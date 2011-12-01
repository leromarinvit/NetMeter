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

unit NetMeterAbout;

interface

uses
  Windows, Forms, Classes, Controls, StdCtrls, ExtCtrls, Buttons, Graphics,
  SysUtils,
  NetMeterGlobal, NetMeterMain;

type
  TNMAbout = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    BitBtn1: TBitBtn;
    Panel1: TPanel;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    Beta_Tag : TLabel;
  public
    { Public declarations }
  end;

var
  NMAbout: TNMAbout;

implementation

uses ShellAPI;

{$R *.dfm}

procedure TNMAbout.FormCreate(Sender: TObject);
var Version_String : string;
begin
  ModifyFontsFor(self, NMMain.Font.Name);

  Version_String := IntToStr(Version_Int);
  Insert('.', Version_String, 2);
  Insert('.', Version_String, 4);

  Label3.Caption := Label3.Caption + #32 + Version_String;
  Label7.Caption := Build_Date;

  if BetaVersion then
    begin
      Beta_Tag := TLabel.Create(self);
      with Beta_Tag do
        begin
          Parent := Panel1;
          Caption := 'BETA';
          Font.Color := clRed;
          Left := 130;
          Top := 16;
        end;
    end;
end;

procedure TNMAbout.FormDestroy(Sender: TObject);
begin
  if BetaVersion then Beta_Tag.Free;
end;

procedure TNMAbout.Image1Click(Sender: TObject);
begin
  ShellExecute(0, 'open', pChar('https://www.paypal.com/cgi-bin/webscr?cmd=_xclick&business=NetMeter%40gmx%2ede&item_name=NetMeter&no_shipping=0&no_note=1&tax=0&currency_code=USD&lc=US&bn=PP%2dDonationsBF&charset=UTF%2d8'), nil, nil, SW_SHOWNORMAL);
end;

procedure TNMAbout.Label1Click(Sender: TObject);
begin
  Label1.Font.Color := clNavy;
  ShellExecute(0, 'open', pChar(Label1.Caption), nil, nil, SW_SHOWNORMAL);
end;

procedure TNMAbout.Label2Click(Sender: TObject);
begin
  Label2.Font.Color := clNavy;
  ShellExecute(0, 'open', pChar(Label2.Caption), nil, nil, SW_SHOWNORMAL);
end;

end.
