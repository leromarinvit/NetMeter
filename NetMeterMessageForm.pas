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

unit NetMeterMessageForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, NetMeterMain, NetMeterGlobal;

type
  TNMMessageForm = class(TForm)
    MessageBtn: TBitBtn;
    MessageToShow: TLabel;
    MessageBevel: TBevel;
    Image1: TImage;
    Bevel1: TBevel;
    procedure MessageBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  NMMessageForm: TNMMessageForm;

implementation

{$R *.dfm}

procedure TNMMessageForm.FormCreate(Sender: TObject);
begin
  ModifyFontsFor(self, NMMain.Font.Name);
end;

procedure TNMMessageForm.MessageBtnClick(Sender: TObject);
begin
  Close;
end;

end.
