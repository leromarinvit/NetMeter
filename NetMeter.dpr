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

program NetMeter;

uses
  Forms,
  Windows,
  NetMeterMain in 'NetMeterMain.pas' {NMMain},
  NetMeterOptions in 'NetMeterOptions.pas' {NMOptions},
  NetMeterAbout in 'NetMeterAbout.pas' {NMAbout},
  NetMeterTotals in 'NetMeterTotals.pas' {NMTotals},
  NetMeterGlobal in 'NetMeterGlobal.pas',
  NetMeterMessageForm in 'NetMeterMessageForm.pas' {NMMessageForm},
  NetMeterTrafficLog in 'NetMeterTrafficLog.pas',
  NetMeterIPHLP in 'NetMeterIPHLP.pas',
  NetMeterTrafficBuffer in 'NetMeterTrafficBuffer.pas',
  NetMeterGraph in 'NetMeterGraph.pas',
  NetMeterTrayIcon in 'NetMeterTrayIcon.pas',
  IPHLPAPI in 'IPHLPAPI.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'NetMeter';
  Application.ShowMainForm := FALSE;
  Application.CreateForm(TNMMain, NMMain);
  Application.Run;
end.
