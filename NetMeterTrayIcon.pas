// ************************************************************************** //
//                           NetMeter 1.1.4 BETA                              //
//                    Copyright (C) 2009 Oliver Winterholler                  //
// ************************************************************************** //
// This file is part of NetMeter.                                             //
//                                                                            //
// NetMeter is free software: you can redistribute it and/or modify           //
// it under the terms of the GNU General Public License as published by       //
// the Free Software Foundation, either version 3 of the License, or          //
// (at your option) any later version.                                        //
//                                                                            //
// NetMeter is distributed in the hope that it will be useful,                //
// but WITHOUT ANY WARRANTY; without even the implied warranty of             //
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the              //
// GNU General Public License for more details.                               //
//                                                                            //
// You should have received a copy of the GNU General Public License          //
// along with NetMeter.  If not, see <http://www.gnu.org/licenses/>.          //
// ************************************************************************** //

unit NetMeterTrayIcon;

interface

uses
  Windows, Classes, ExtCtrls, Graphics, Controls, NetMeterTrafficBuffer;

const
  TI_MaxGradientDivisions = 16;

type
  TTrayIconGauge = class(TComponent)
  private
    FTrafficBuffer : TTrafficBuffer;
    FAutoScale : boolean;
    FMaxValue : Longword;
    FIcon : TIcon;
    GradientColorTable : array[1..TI_MaxGradientDivisions] of longint;
    FUseAverageValues : boolean;
    procedure LoadGradientColors(StartColor, EndColor : TColor; Divisions : byte);
    procedure BitmapToIcon(const Bitmap: TBitmap; const Icon: TIcon; MaskColor: TColor);
    function IconCreate : TIcon;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property TrafficBuffer : TTrafficBuffer read FTrafficBuffer write FTrafficBuffer;
    property AutoScale : boolean read FAutoScale write FAutoScale default TRUE;
    property MaxValue : Longword read FMaxValue write FMaxValue default 0;
    property Icon : TIcon read IconCreate;
    property UseAverageValues : boolean read FUseAverageValues write FUseAverageValues default FALSE;
  protected
  end;

const
  TI_BorderLoColor    = TColor($000000);
  TI_BorderHiColor    = TColor($FFFFFF);
  TI_NoTrafficLoColor = TColor($000000);
  TI_NoTrafficHiColor = TColor($000080);
  TI_TrafficLoColor   = TColor($004000);
  TI_TrafficHiColor   = TColor($00FF00);

implementation

constructor TTrayIconGauge.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FIcon := TIcon.Create;
end;

destructor TTrayIconGauge.Destroy;
begin
  FIcon.Free;
  inherited Destroy;
end;

procedure TTrayIconGauge.LoadGradientColors(StartColor, EndColor : TColor; Divisions : byte);
var
  x,
  YR, YG, YB,
  SR, SG, SB,
  DR, DG, DB : integer;
begin
  YR := GetRValue( StartColor );
  YG := GetGValue( StartColor );
  YB := GetBValue( StartColor );
  SR := YR;
  SG := YG;
  SB := YB;
  DR := GetRValue( EndColor ) - SR;
  DG := GetGValue( EndColor ) - SG;
  DB := GetBValue( EndColor ) - SB;

  for x := 1 to Divisions do
    begin
      GradientColorTable[ x ] := RGB( YR, YG, YB );
      YR := SR + Round( DR / Divisions * x );
      YG := SG + Round( DG / Divisions * x );
      YB := SB + Round( DB / Divisions * x );
    end;
end;

procedure TTrayIconGauge.BitmapToIcon(const Bitmap: TBitmap; const Icon: TIcon; MaskColor: TColor);
var
  bil: TImageList;
begin
  bil := TImageList.CreateSize(16, 16);
  bil.AddMasked(Bitmap, MaskColor);
  bil.GetIcon(0, Icon);
  bil.Free;
end;

function TTrayIconGauge.IconCreate : TIcon;
var
  b : TBitmap;
  i : integer;
  ll_u,
  ll_d : integer;

procedure GraphAutoscale;
var
  i : integer;
  ulm, dlm : LongWord;
begin with FTrafficBuffer do
begin
  ulm := 0;
  for i := 0 to BufferLen - 1 do
    if UploadBuffer[ i ] > ulm then ulm := UploadBuffer[ i ];

  dlm := 0;
  for i := 0 to BufferLen - 1 do
    if FTrafficBuffer.DownloadBuffer[ i ] > dlm then dlm := FTrafficBuffer.DownloadBuffer[ i ];

  if ulm > dlm then
    FMaxValue := ulm * 8
  else
    FMaxValue := dlm * 8
end;
end;

begin
  b := TBitmap.Create;
  b.Height := 16;
  b.Width  := 16;

  // Determine maximum graph value
  if FAutoscale then GraphAutoscale;

  with b do
    begin
      // Draw graph border
      LoadGradientColors( TI_BorderLoColor, TI_BorderHiColor, 8 );
      for i := 1 to 8 do
        begin
          Canvas.Brush.Color := GradientColorTable[i];
          Canvas.FillRect( Rect( 0, i - 1, 16, i ) );
          Canvas.FillRect( Rect( 0, 17 - i, 16, i ) );
        end;

      // Draw graph background
      LoadGradientColors( TI_NoTrafficLoColor, TI_NoTrafficHiColor, 16 );
      for i := 1 to 16 do
        begin
          Canvas.Brush.Color := GradientColorTable[i];
          Canvas.FillRect( Rect( 1, i  - 1 , 7 , i ) );
          Canvas.FillRect( Rect( 9, 16 - i, 15 , 17 - i ) );
        end;

      // Draw graph gauges
      if FMaxValue > 0 then
        begin
          if FUseAverageValues then
            begin
              ll_d := Round( 16 / 100 * ( FTrafficBuffer.DownloadAV * 8 / FMaxValue * 100 ) );
              ll_u := Round( 16 / 100 * ( FTrafficBuffer.UploadAV   * 8 / FMaxValue * 100 ) );
            end
          else
            begin
              ll_d := Round( 16 / 100 * ( FTrafficBuffer.DownloadBuffer[ FTrafficBuffer.BufferLen - 1 ] * 8 / FMaxValue * 100 ) );
              ll_u := Round( 16 / 100 * ( FTrafficBuffer.UploadBuffer  [ FTrafficBuffer.BufferLen - 1 ] * 8 / FMaxValue * 100 ) );
            end;

          if ll_d > 16 then ll_d := 16;
          if ll_u > 16 then ll_u := 16;

          LoadGradientColors( TI_TrafficLoColor, TI_TrafficHiColor, ll_d );
          for i := 1 to ll_d do
            begin
              Canvas.Brush.Color := GradientColorTable[i];
              Canvas.FillRect( Rect( 1, i  - 1 , 7 , i ) );
            end;

          LoadGradientColors( TI_TrafficLoColor, TI_TrafficHiColor, ll_u );
          for i := 1 to ll_u do
            begin
              Canvas.Brush.Color := GradientColorTable[i];
              Canvas.FillRect( Rect( 9, 16 - i, 15 , 17 - i ) );
            end;
        end;
    end;

  BitmapToIcon(b, FIcon, clNone);
  Result := FIcon;
  b.Free;
end;

end.
