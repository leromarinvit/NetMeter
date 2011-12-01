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

unit NetMeterGraph;

interface

uses
  Windows, Classes, ExtCtrls, Graphics, SysUtils,
  NetMeterTrafficBuffer;

const
  GR_GradientDivisions = 200;
  GR_GridDivisions = 10;

  LB_UL          = 'UL: ';
  LB_DL          = 'DL: ';
  LB_TUL         = 'TUL: ';
  LB_TDL         = 'TDL: ';
  LB_MAX         = 'MAX: ';
  LB_MAXSpace    = ' ';
  LB_HorSpace    = 8;
  LB_VertSpace   = 0;
  LB_Empty       = '---';
  LB_Separator   = ' | ';
  LB_HeightDummy = 'X';
  LB_PerSec      = '/s';

  PN_BorderWidth = 2;
  MV_BorderWidth = 1;
  GR_BorderWidth = 1;

  DefFontUDName : string  = ('Arial');
  DefFontUDSize : integer = (8);
  DefFontMVName : string  = ('Arial');
  DefFontMVSize : integer = (8);

  FNT_Sizes : array[1..16] of integer =
    ( 8, 9, 10, 11, 12, 14, 16, 18, 20, 22, 24, 26, 28, 36, 48, 72);

type
  GR_ColorsType =
    record
      MV_Border,
      MV_BkGr,
      MV_Font,
      PN_Border,
      PN_BkGr,
      PN_UL,
      PN_DL,
      GR_Border,
      GR_BkGr1,
      GR_BkGr2,
      GR_Grid,
      GR_Upload,
      GR_Download,
      GR_UpDn : integer;
    end;

  GR_FontType =
    record
      Name : string;
      Size : integer;
      Bold,
      Italic : boolean;
    end;

  GR_OptionsType =
    record
      FontUD,
      FontMV : GR_FontType;
      FontAutosize,
      Autoscale,
      ShowHorGrid,
      ShowPanel,
      ShowPanelTotals,
      ShowMaxValue,
      UseGradient : boolean;
      GraphVertGrid : integer;
    end;

  TTrafficGraph = class(TPanel)
  private
    FOptions : GR_OptionsType;
    FColors : GR_ColorsType;
    GradientColorTable : array[1..GR_GradientDivisions] of longint;
    FTrafficBuffer : TTrafficBuffer;
    FULabel,
    FDLabel,
    FTULLabel,
    FTDLLabel,
    FMVLabel : string;
    FMaxValue : Longword;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadGradientColors(StartColor, EndColor : TColor);
    procedure Paint; override;
    property TrafficBuffer : TTrafficBuffer read FTrafficBuffer write FTrafficBuffer;
    property Options : GR_OptionsType read FOptions;
    property Colors : GR_ColorsType read FColors write FColors;
    property ULabel : string read FULabel write FULabel;
    property DLabel : string read FDLabel write FDLabel;
    property TULabel : string read FTULLabel write FTULLabel;
    property TDLabel : string read FTDLLabel write FTDLLabel;
    property MVLabel : string read FMVLabel write FMVLabel;
    property MaxValue : Longword read FMaxValue write FMaxValue;
  protected
  end;

const
  GR_DefColor : GR_ColorsType = (
    MV_Border   : clGray;
    MV_BkGr     : clGray;
    MV_Font     : clWhite;
    PN_Border   : clBlack;
    PN_BkGr     : clBlack;
    PN_UL       : clLime;
    PN_DL       : clRed;
    GR_Border   : clGray;
    GR_BkGr1    : $00C0C0A7;
    GR_BkGr2    : clBlack;
    GR_Grid     : clGray;
    GR_Upload   : clLime;
    GR_Download : clRed;
    GR_UpDn     : clYellow
    );

implementation

var
  old_fnth : THandle;

constructor TTrafficGraph.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  old_fnth := Canvas.Font.Handle;

  FColors := GR_DefColor;

  FULabel   := LB_Empty;
  FDLabel   := LB_Empty;
  FTULLabel := LB_Empty;
  FTDLLabel := LB_Empty;
  FMVLabel  := LB_Empty;

  FMaxValue := 0;

  with FOptions do
    begin
      with FontUD do
        begin
          Name := DefFontUDName;
          Size := DefFontUDSize;
          Bold := FALSE;
          Italic := FALSE;
        end;
      with FontMV do
        begin
          Name := DefFontMVName;
          Size := DefFontMVSize;
          Bold := FALSE;
          Italic := FALSE;
        end;
      FontAutosize := FALSE;
      Autoscale := TRUE;
      ShowHorGrid := TRUE;
      ShowPanel := TRUE;
      ShowPanelTotals := FALSE;
      ShowMaxValue := TRUE;
      UseGradient := TRUE;
      GraphVertGrid := 30;
    end;
end;

destructor TTrafficGraph.Destroy;
begin
  inherited Destroy;
end;

procedure TTrafficGraph.LoadGradientColors(StartColor, EndColor : TColor);
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
  for x := 1 to GR_GradientDivisions do
    begin
      GradientColorTable[ x ] := RGB( YR, YG, YB );
      YR := SR + Round( DR / GR_GradientDivisions * x );
      YG := SG + Round( DG / GR_GradientDivisions * x );
      YB := SB + Round( DB / GR_GradientDivisions * x );
    end;
end;

procedure TTrafficGraph.Paint;
var
//  debug_text : string;

  im : TBitmap;

  showpanel,
  showpaneltotals,
  showmaxval : boolean;

  diff, least_diff, nearest_size : integer;

  test_limitreached : boolean;
  test_fs,
  fntsize : array[1..2] of integer;

  pn_height,
  mv_width,
  gr_height,
  gr_height_ws,
  gr_width,
  gr_width_ws : integer;
  pn_rect,
  mv_rect,
  gr_rect : TRect;
  ud_lb_left_d,
  ud_lb_left_u,
  tud_lb_left_d,
  tud_lb_left_u,
  ud_lb_top_d,
  ud_lb_top_u,
  tud_lb_top_d,
  tud_lb_top_u : integer;

  i, ii, x, iofs : integer;
  g : double;
  ll_d,
  ll_u : integer;

procedure GraphAutoscale;
var
  i, iofs : integer;
  ulm, dlm : LongWord;
begin
  if gr_width_ws < FTrafficBuffer.BufferLen then
    iofs := FTrafficBuffer.BufferLen - gr_width_ws
  else
    iofs := 0;

  ulm := 0;
  for i := iofs to FTrafficBuffer.BufferLen - 1 do
    if FTrafficBuffer.UploadBuffer[ i ] > ulm then
      ulm := FTrafficBuffer.UploadBuffer[ i ];

  dlm := 0;
  for i := iofs to FTrafficBuffer.BufferLen - 1 do
    if FTrafficBuffer.DownloadBuffer[ i ] > dlm then
      dlm := FTrafficBuffer.DownloadBuffer[ i ];

  if ulm > dlm then
    FMaxValue := ulm * 8
  else
    FMaxValue := dlm * 8
end;

procedure SetFontUD( fsize : integer );
begin
  im.Canvas.Font.Handle := old_fnth;
  with im.Canvas.Font do
    begin
      Name := FOptions.FontUD.Name;
      Size := fsize;

      if FOptions.FontUD.Bold   then Style := Style + [fsBold]   else Style := Style - [fsBold];
      if FOptions.FontUD.Italic then Style := Style + [fsItalic] else Style := Style - [fsItalic];
    end;
end;

procedure SetFontMV( fsize : integer );
var
  fnt : TLogFont;
begin
  im.Canvas.Font.Handle := old_fnth;
  with im.Canvas.Font do
    begin
      Name := FOptions.FontMV.Name;
      Size := fsize;

      if FOptions.FontMV.Bold   then Style := Style + [fsBold]   else Style := Style - [fsBold];
      if FOptions.FontMV.Italic then Style := Style + [fsItalic] else Style := Style - [fsItalic];

      //Rotate font 90 degrees
      GetObject(Handle, SizeOf(TLogFont), @fnt);
      fnt.lfEscapement  := 10 * 90;
      fnt.lfOrientation := fnt.lfEscapement; //for Win9x
      Handle := CreateFontIndirect(fnt);
    end;
end;

procedure CalculateUDPanel(fsize : integer);
begin
  SetFontUD(fsize);

  // Calculate UL/DL label positions
  ud_lb_left_d := (im.Width div 2) - im.Canvas.TextWidth(FDLabel) - (LB_HorSpace div 2);
  ud_lb_left_u := (im.Width div 2) + (LB_HorSpace div 2);

  // Calculate TUL/TDL label positions
  tud_lb_left_d := (im.Width div 2) - im.Canvas.TextWidth(FTDLLabel) - (LB_HorSpace div 2);
  tud_lb_left_u := (im.Width div 2) + (LB_HorSpace div 2);

  // Determine if there is enough space for panel
  if ( ud_lb_left_d <= PN_BorderWidth ) or
     ( ud_lb_left_u + im.Canvas.TextWidth(FULabel) + PN_BorderWidth > im.Width) then
    begin
      showpanel := FALSE;
      showpaneltotals := FALSE; // Deactivate the other panel, too
    end;

  // Determine if there is enough space for totals panel
  if showpaneltotals then
    if ( tud_lb_left_d <= PN_BorderWidth ) or
       ( tud_lb_left_u + im.Canvas.TextWidth(FTULLabel) + PN_BorderWidth > im.Width) then
      begin
        showpaneltotals := FALSE;
        showpanel := FALSE;  // Deactivate the other panel, too
      end;

  // Calculate correct panel height
  if showpanel and showpaneltotals then
    pn_height := (PN_BorderWidth * 2) + (im.Canvas.TextHeight(LB_HeightDummy) * 2) + LB_VertSpace
  else
    if showpanel or showpaneltotals then
      pn_height := (PN_BorderWidth * 2) + im.Canvas.TextHeight(LB_HeightDummy)
    else
      pn_height := 0;

  // Determine if there is enough vertical space for both panels
  if pn_height > im.Height then
    begin
      pn_height := 0;
      showpanel := FALSE;
      showpaneltotals := FALSE;
    end;
end;

procedure CalculateMVPanel(fsize : integer);
begin
  SetFontMV(fsize);

  // Determine if there is enough space for maxval display
  if (MV_BorderWidth * 2) + im.Canvas.TextWidth(LB_MAXSpace + FMVLabel + LB_MAXSpace) + pn_height > im.Height then
    showmaxval := FALSE;

  if showmaxval then
    mv_width := (MV_BorderWidth * 2) + im.Canvas.TextHeight(LB_HeightDummy)
  else
    mv_width := 0;

  // Determine if there is enough horizontal space for maxval display
  if mv_width > im.Width then
    begin
      mv_width := 0;
      showmaxval := FALSE;
    end;
end;

begin
  with FColors do
    LoadGradientColors( GR_BkGr1, GR_BkGr2 );

  im := TBitmap.Create;
  im.Height := Height;
  im.Width  := Width;

  fntsize[1] := FOptions.FontUD.Size;
  fntsize[2] := FOptions.FontMV.Size;

  if not FOptions.FontAutosize then
    begin
      showpanel       := FOptions.ShowPanel;
      showpaneltotals := FOptions.ShowPanelTotals;
      showmaxval      := FOptions.ShowMaxValue;
      CalculateUDPanel( fntsize[1] );
      CalculateMVPanel( fntsize[2] );
    end
  else
    begin

      // Determine the nearest font size
      for i := 1 to 2 do
        begin
          least_diff := High(integer);
          nearest_size := 1;
          for ii := 1 to High(FNT_Sizes) do
            begin
              if FNT_Sizes[ii] - fntsize[i] < 0 then
                diff := fntsize[i] - FNT_Sizes[ii]
              else
                diff := FNT_Sizes[ii] - fntsize[i];
              if diff < least_diff then
                begin
                  least_diff := diff;
                  nearest_size := ii;
                end;
            end;
          test_fs[i] := nearest_size;
        end;

      test_limitreached := FALSE;
      repeat
        begin
          showpanel       := FOptions.ShowPanel;
          showpaneltotals := FOptions.ShowPanelTotals;
          CalculateUDPanel( FNT_Sizes[test_fs[1]] );
          if FOptions.ShowPanel = TRUE then
//             Options.GraphShowPanelTotals
            if showpanel = FALSE then
              if test_fs[1] > 1 then dec(test_fs[1])
              else test_limitreached := TRUE
            else test_limitreached := TRUE
          else test_limitreached := TRUE;
        end
      until test_limitreached;

      test_limitreached := FALSE;
      repeat
        begin
          showmaxval := FOptions.ShowMaxValue;
          CalculateMVPanel( FNT_Sizes[test_fs[2]] );
          if FOptions.ShowMaxValue = TRUE then
            if showmaxval = FALSE then
              if test_fs[2] > 1 then dec(test_fs[2])
              else test_limitreached := TRUE
            else test_limitreached := TRUE
          else test_limitreached := TRUE;
        end
      until test_limitreached;

      fntsize[1] := FNT_Sizes[test_fs[1]];
      fntsize[2] := FNT_Sizes[test_fs[2]];
    end;

  // Calculate maxvalue display rectangle
  mv_rect := Rect( 0,
                   0,
                   mv_width,
                   im.Height - pn_height );

  // Calculate UL/DL panel display rectangle
  pn_rect := Rect( 0,
                   im.Height - pn_height,
                   im.Width,
                   im.Height );

  // Calculate graph rectangle
  gr_rect := Rect( mv_rect.Right,
                   0,
                   im.Width,
                   pn_rect.Top );

  gr_height    := gr_rect.Bottom - gr_rect.Top;
  gr_width     := gr_rect.Right  - gr_rect.Left;
  gr_height_ws := gr_height - (GR_BorderWidth * 2);
  gr_width_ws  := gr_width  - (GR_BorderWidth * 2);

  // Set constraints of graph window
  Constraints.MaxWidth := FTrafficBuffer.BufferLen + ( GR_BorderWidth * 2 ) + mv_width;

  // Determine maximum graph value
  if FOptions.Autoscale then GraphAutoscale;

  try
    with im do
    begin

      if showpanel or showpaneltotals then
        begin
          SetFontUD(fntsize[1]);

          if PN_BorderWidth > 0 then
            begin
              Canvas.Brush.Color := FColors.PN_Border;
              Canvas.FrameRect(pn_rect);
            end;

          Canvas.Brush.Color := FColors.PN_BkGr;
          with pn_rect do
            Canvas.FillRect( Rect( Left + 1,
                                   Top + 1,
                                   Right - 1,
                                   Bottom - 1 ) );

          ud_lb_top_u := pn_rect.Top + PN_Borderwidth;
          ud_lb_top_d := pn_rect.Top + PN_Borderwidth;
          tud_lb_top_u := pn_rect.Top + PN_Borderwidth;
          tud_lb_top_d := pn_rect.Top + PN_Borderwidth;

          if showpaneltotals and showpanel then
            begin
              inc( tud_lb_top_u, + im.Canvas.TextHeight(LB_HeightDummy) + LB_VertSpace );
              inc( tud_lb_top_d, + im.Canvas.TextHeight(LB_HeightDummy) + LB_VertSpace );
            end;

          Canvas.Font.Color := FColors.PN_UL;
          if showpanel       then Canvas.TextOut(ud_lb_left_u,  ud_lb_top_u,  FULabel);
          if showpaneltotals then Canvas.TextOut(tud_lb_left_u, tud_lb_top_u, FTULLabel);

          Canvas.Font.Color := FColors.PN_DL;
          if showpanel       then Canvas.TextOut(ud_lb_left_d,  ud_lb_top_d,  FDLabel);
          if showpaneltotals then Canvas.TextOut(tud_lb_left_d, tud_lb_top_d, FTDLLabel);
        end;

      if showmaxval then
        begin
          Canvas.Brush.Color := FColors.MV_Border;
          Canvas.FrameRect(mv_rect);

          Canvas.Brush.Color := FColors.MV_BkGr;
          with mv_rect do
            Canvas.FillRect( Rect( Left + 1,
                                   Top + 1,
                                   Right - 1,
                                   Bottom - 1 ) );

          // Set the "MAX"-Label font
          SetFontMV(fntsize[2]);

          Canvas.Font.Color := FColors.MV_Font;
          Canvas.TextOut( mv_rect.Left + MV_Borderwidth,
                          mv_rect.Top + Canvas.TextWidth(LB_MAXSpace + FMVLabel) + MV_Borderwidth,
                          FMVLabel);
        end;

      if GR_BorderWidth > 0 then
        begin
          Canvas.Brush.Color := FColors.GR_Border;
          Canvas.FrameRect(gr_rect);
        end;

      if ( gr_height_ws > 0 ) and ( gr_width_ws > 0 ) then begin // Don't draw graph if it has no size

      // Draw graph background
      if FOptions.UseGradient then
        begin
          g := gr_height_ws / GR_GradientDivisions;
          for i := 1 to GR_GradientDivisions do
            begin
              Canvas.Brush.Color := GradientColorTable[i];
              with gr_rect do
                Canvas.FillRect( Rect( Left  + GR_BorderWidth,
                                       Top   + GR_BorderWidth + Round( g * (i - 1) ),
                                       Right - GR_BorderWidth,
                                       Top   + GR_BorderWidth + Round( g * i ) ) );
            end;
        end
      else
        begin
          Canvas.Brush.Color := FColors.GR_BkGr1;
          with gr_rect do
            Canvas.FillRect( Rect( Left   + GR_BorderWidth,
                                   Top    + GR_BorderWidth,
                                   Right  - GR_BorderWidth,
                                   Bottom - GR_BorderWidth ) );
        end;

      if FOptions.ShowHorGrid then
        begin
          Canvas.Pen.Color := FColors.GR_Grid;
          g := gr_height_ws / GR_GridDivisions;
          for i := 1 to GR_GridDivisions - 1 do
            with gr_rect do
              begin
                Canvas.MoveTo( Left  + GR_BorderWidth,
                               Top   + GR_BorderWidth + Round( g * i ) );
                Canvas.LineTo( Right - GR_BorderWidth,
                               Top   + GR_BorderWidth + Round( g * i ) );
              end;
        end;

      if gr_width_ws < FTrafficBuffer.BufferLen then
        iofs := FTrafficBuffer.BufferLen - gr_width_ws
      else
        iofs := 0;

      if FMaxValue > 0 then
      for i := iofs to FTrafficBuffer.BufferLen - 1 do
        begin
          x := ( gr_rect.right - GR_BorderWidth ) - FTrafficBuffer.BufferLen + i;

          ll_u := Round( gr_height_ws / 100 * ( FTrafficBuffer.UploadBuffer  [ i ] * 8 / FMaxValue * 100 ) );
          ll_d := Round( gr_height_ws / 100 * ( FTrafficBuffer.DownloadBuffer[ i ] * 8 / FMaxValue * 100 ) );

          if (ll_u > 0) or (ll_d > 0) then
            begin with Canvas do
            begin
              if ll_u = ll_d then
                begin
                  Pen.Color := FColors.GR_UpDn;
                  MoveTo( x, gr_rect.Bottom - GR_BorderWidth - 1 );
                  LineTo( x, gr_rect.Bottom - GR_BorderWidth - ll_u - 1 );
                end;
              if ll_u > ll_d then
                begin
                  Pen.Color := FColors.GR_UpDn;
                  MoveTo( x, gr_rect.Bottom - GR_BorderWidth - 1 );
                  LineTo( x, gr_rect.Bottom - GR_BorderWidth - ll_d - 1 );

                  Pen.Color := FColors.GR_Upload;
                  MoveTo( x, gr_rect.Bottom - GR_BorderWidth - ll_d - 1 );
                  LineTo( x, gr_rect.Bottom - GR_BorderWidth - ll_u - 1 );
                end;
              if ll_u < ll_d then
                begin
                  Pen.Color := FColors.GR_UpDn;
                  MoveTo( x, gr_rect.Bottom - GR_BorderWidth - 1 );
                  LineTo( x, gr_rect.Bottom - GR_BorderWidth - ll_u - 1 );

                  Pen.Color := FColors.GR_Download;
                  MoveTo( x, gr_rect.Bottom - GR_BorderWidth - ll_u - 1 );
                  LineTo( x, gr_rect.Bottom - GR_BorderWidth - ll_d - 1 );
                end;
            end;
            end;
        end;

      if FOptions.GraphVertGrid > 0 then
        begin
          Canvas.Brush.Style := bsClear;
          Canvas.Pen.Style := psDot;
          Canvas.Pen.Color := FColors.GR_Grid;
          i := gr_rect.Right - GR_BorderWidth;
          if i - FOptions.GraphVertGrid >= gr_rect.Left + GR_BorderWidth then
            repeat
              begin
                dec( i, FOptions.GraphVertGrid );
                x := i;
                Canvas.MoveTo( x, gr_rect.Top + GR_BorderWidth );
                Canvas.LineTo( x, gr_rect.Bottom - GR_BorderWidth );
              end
            until i - FOptions.GraphVertGrid < gr_rect.Left + GR_BorderWidth;
        end;

      //Debug stuff
{      SetFontUD(fntsize[1]);
      Canvas.Font.Color := clBlack;
      debug_text := IntToStr(Constraints.MaxWidth);
      Canvas.TextRect(gr_rect,gr_rect.Left + 5,gr_rect.Top + 5,debug_text);}

      end;
    end;

    Canvas.Draw(0,0,im);
  finally
    im.Destroy;
  end;
end;

end.
