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

unit NetMeterTrafficBuffer;

interface

uses SysUtils, Classes;

const
  TB_DefaultBufferLen    = 60 * 30; //30 minutes
  TB_DefaultDAVBufferLen = 10;      //10 seconds

type
  TTrafficBufferArray = array of Longword;

  TTrafficBuffer = class(TObject)
  private
    FBufferLen,
    FDAVBufferLen : Cardinal;
    FUploadBuffer,
    FDownloadBuffer : TTrafficBufferArray;
    FUploadAV,
    FDownloadAV : Longword;
    procedure SetBufferLen( NewLen : Cardinal );
    procedure SetDAVBufferLen( NewLen : Cardinal );
    procedure RefreshAV;
  public
    constructor Create;
    procedure Clear;
    procedure Add( NewUpload, NewDownload : Longword );
    property BufferLen      : Cardinal read FBufferLen write SetBufferLen;
    property DAVBufferLen   : Cardinal read FDAVBufferLen write SetDAVBufferLen;
    property UploadBuffer   : TTrafficBufferArray read FUploadBuffer;
    property DownloadBuffer : TTrafficBufferArray read FDownloadBuffer;
    property UploadAV       : Longword read FUploadAV;
    property DownloadAV     : Longword read FDownloadAV;
  protected
  end;

implementation

constructor TTrafficBuffer.Create;
begin
  SetBufferLen   ( TB_DefaultBufferLen    );
  SetDAVBufferLen( TB_DefaultDAVBufferLen );
  Clear;
  RefreshAV;
end;

procedure TTrafficBuffer.Clear;
var i : Cardinal;
begin
  for i := 0 to FBufferLen - 1 do
    begin
      FUploadBuffer  [ i ] := 0;
      FDownloadBuffer[ i ] := 0;
    end;

  //Refresh DAV
  RefreshAV;
end;

procedure TTrafficBuffer.Add( NewUpload, NewDownload : Longword );
var i : Cardinal;
begin
  //add to buffer
  for i := 0 to FBufferLen - 2 do
    begin
      FUploadBuffer  [ i ] := FUploadBuffer  [ i + 1 ];
      FDownloadBuffer[ i ] := FDownloadBuffer[ i + 1 ];
    end;
  FUploadBuffer  [ FBufferLen - 1 ] := NewUpload;
  FDownloadBuffer[ FBufferLen - 1 ] := NewDownload;

  //Refresh DAV
  RefreshAV;
end;

procedure TTrafficBuffer.SetBufferLen( NewLen : Cardinal );
var
  OldLen,
  i : Cardinal;
begin
  OldLen := FBufferLen;
  FBufferLen := NewLen;

  if ( NewLen < OldLen ) and ( NewLen > 0 ) then
    begin
      for i := 0 to NewLen - 1 do
        begin
          FUploadBuffer  [ i ] := FUploadBuffer  [ OldLen - NewLen + i ];
          FDownloadBuffer[ i ] := FDownloadBuffer[ OldLen - NewLen + i ];
        end;
    end;

  SetLength( FUploadBuffer,   NewLen );
  SetLength( FDownloadBuffer, NewLen );

  if ( NewLen > OldLen ) and ( OldLen > 0 ) then
    begin
      for i := 0 to NewLen - OldLen - 1 do
        begin
          FUploadBuffer  [ i ] := 0;
          FDownloadBuffer[ i ] := 0;
        end;
      for i := 0 to OldLen - 1 do
        begin
          FUploadBuffer  [ NewLen - OldLen + i ] := FUploadBuffer  [ i ];
          FDownloadBuffer[ NewLen - OldLen + i ] := FDownloadBuffer[ i ];
        end;
    end;

  if FDAVBufferLen > NewLen then FDAVBufferLen := NewLen;

  //Refresh average calculation
  RefreshAV;
end;

procedure TTrafficBuffer.SetDAVBufferLen( NewLen : Cardinal );
begin
  if NewLen > FBufferLen then
    FDAVBufferLen := FBufferLen
  else
    FDAVBufferLen := NewLen;

  //Refresh average calculation
  RefreshAV;
end;

procedure TTrafficBuffer.RefreshAV;
var
  i : Cardinal;
  tmp_aup,
  tmp_adn : Double;
begin
  tmp_aup := 0;
  tmp_adn := 0;
  for i := 1 to FDAVBufferLen do
    begin
      tmp_aup := tmp_aup + ( FUploadBuffer  [ FBufferLen - i ] / FDAVBufferLen );
      tmp_adn := tmp_adn + ( FDownloadBuffer[ FBufferLen - i ] / FDAVBufferLen );
    end;
  FUploadAV   := Round( tmp_aup );
  FDownloadAV := Round( tmp_adn );
end;

end.
