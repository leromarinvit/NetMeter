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

unit NetMeterGlobal;

interface

uses
  Graphics, SysUtils, Windows, Classes, Controls, TypInfo, Registry, Forms,
  NetMeterTrafficLog, NetMeterGraph, IPHLPAPI;

type
  NotifyRecord =
    record
      NotifyName: string;
      NotifyType: integer;
      Cmd : string;
      NotifyMonitoringProblems : boolean;
      // Traffic alert options
      TVAlertEnabled : boolean;
      TrafficLimit,
      TrafficLimitUnit,
      TrafficLimitULorDL,
      TrafficLimitPeriod : integer;
    end;

  NMOptionsRecord =
    record
      // Window properties
      AlwaysOnTop,
      ShowCaption,
      StartMinimized,
      MinimizeWhenIdle,
      DisplayAverageValues,
      CloseToTray,
      SnapToScreenEdges,
      ClickThrough,
      FadingEnabled,
      MouseFadingEnabled,
      MouseFadingIn,
      TransparencyEnabled : boolean;
      TransparencyValue : integer;
      RunOnStartup,
      UseOldDUDescription,
      UseOldTrayIcons : boolean;
      // Totals and Report options
      WeekStartsOn,
      MonthStartsOn,
      TotalsDisplayUnit : integer;
      LogfileAutosaveEnabled : boolean;
      LogfileAutosaveMinutes : integer;
      // Interface to monitor
      IFToMonitor : integer;
      IFDescription : IF_DESCRIPTION;
      IFMAC : MAC;
      // Visual options
      Bandwidth : integer;
      Autoscale,
      ShowHorGrid,
      ShowPanel,
      ShowPanelTotals,
      ShowMaxValue,
      Gradient : boolean;
      VertGrid,
      UDDisplayUnit,
      TUDDisplayUnit,
      MVDisplayUnit : integer;
      FontUD,
      FontMV : GR_FontType;
      FontAutosize : boolean;
      Color : GR_ColorsType;
      // Notifications
      Notify: array of NotifyRecord;
    end;


  DU_DisplaySymbol =
    record
      Name,
      Shortcut,
      Alt_Shortcut,
      Equals : string;
      Digits : integer;
      Value : Int64;
    end;

  DU_DisplayUnit =
    record
      Name : string;
      Bitmultiplier : cardinal;
      Symbol : array[0..3] of DU_DisplaySymbol;
    end;

const
  Version_Int    = 114;
  BetaVersion    = TRUE;
  Build_Date     = '08-09-2009';

  Win2k_or_newer    = 5;
  WinVista_or_newer = 6;

  Autorun_Regkey = 'Software\Microsoft\Windows\CurrentVersion\Run';

  FNT_Default_9x : string = ('MS Sans Serif');
  FNT_Default_2k : string = ('Microsoft Sans Serif');

  FRM_InitPos         = Low(integer);
  FRM_BorderThreshold = 10;
  FRM_MinWidth        = 0;
  FRM_MinHeight       = 0;
  FRM_DefWidth        = 200;
  FRM_DefHeight       = 150;

  BW_Autodetect = 0;
  BW_Custom     = -1;

  DU_Kilobit  = 0;
  DU_Kibibit  = 1;
  DU_Kilobyte = 2;
  DU_Kibibyte = 3;

  DU_k = 0;
  DU_m = 1;
  DU_g = 2;
  DU_t = 3;

  DU_Unit : array[0..3] of DU_DisplayUnit =
  (
    ( Name : 'Kilobit'; Bitmultiplier : 8; Symbol :
      (
        ( Name : 'Kilobit'; Shortcut : 'kb'; Alt_Shortcut : 'Kb'; Equals : '= 1000 Bit';     Digits : 1; Value : 1000 ),
        ( Name : 'Megabit'; Shortcut : 'Mb'; Alt_Shortcut : 'Mb'; Equals : '= 1000 Kilobit'; Digits : 2; Value : 1000000 ),
        ( Name : 'Gigabit'; Shortcut : 'Gb'; Alt_Shortcut : 'Gb'; Equals : '= 1000 Megabit'; Digits : 3; Value : 1000000000 ),
        ( Name : 'Terabit'; Shortcut : 'Tb'; Alt_Shortcut : 'Tb'; Equals : '= 1000 Gigabit'; Digits : 4; Value : 1000000000000 )
      )
    ),
    ( Name : 'Kibibit'; Bitmultiplier : 8; Symbol :
      (
        ( Name : 'Kibibit'; Shortcut : 'Kibit'; Alt_Shortcut : 'Kb'; Equals : '= 1024 Bit';     Digits : 1; Value : 1024 ),
        ( Name : 'Mebibit'; Shortcut : 'Mibit'; Alt_Shortcut : 'Mb'; Equals : '= 1024 Kibibit'; Digits : 2; Value : 1048576 ),
        ( Name : 'Gibibit'; Shortcut : 'Gibit'; Alt_Shortcut : 'Gb'; Equals : '= 1024 Mebibit'; Digits : 3; Value : 1073741824 ),
        ( Name : 'Tebibit'; Shortcut : 'Tibit'; Alt_Shortcut : 'Tb'; Equals : '= 1024 Gibibit'; Digits : 4; Value : 1099511627776 )
      )
    ),
    ( Name : 'Kilobyte'; Bitmultiplier : 1; Symbol :
      (
        ( Name : 'Kilobyte'; Shortcut : 'kB'; Alt_Shortcut : 'KB'; Equals : '= 1000 Byte';     Digits : 1; Value : 1000 ),
        ( Name : 'Megabyte'; Shortcut : 'MB'; Alt_Shortcut : 'MB'; Equals : '= 1000 Kilobyte'; Digits : 2; Value : 1000000 ),
        ( Name : 'Gigabyte'; Shortcut : 'GB'; Alt_Shortcut : 'GB'; Equals : '= 1000 Megabyte'; Digits : 3; Value : 1000000000 ),
        ( Name : 'Terabyte'; Shortcut : 'TB'; Alt_Shortcut : 'TB'; Equals : '= 1000 Gigabyte'; Digits : 4; Value : 1000000000000 )
      )
    ),
    ( Name : 'Kibibyte';  Bitmultiplier : 1; Symbol :
      (
        ( Name : 'Kibibyte'; Shortcut : 'KiB'; Alt_Shortcut : 'KB'; Equals : '= 1024 Byte';     Digits : 1; Value : 1024 ),
        ( Name : 'Mebibyte'; Shortcut : 'MiB'; Alt_Shortcut : 'MB'; Equals : '= 1024 Kibibyte'; Digits : 2; Value : 1048576 ),
        ( Name : 'Gibibyte'; Shortcut : 'GiB'; Alt_Shortcut : 'GB'; Equals : '= 1024 Mebibyte'; Digits : 3; Value : 1073741824 ),
        ( Name : 'Gibibyte'; Shortcut : 'TiB'; Alt_Shortcut : 'TB'; Equals : '= 1024 Gibibyte'; Digits : 4; Value : 1099511627776 )
      )
    )
  );

  TLG_FileName = 'NetMeter.tlg';

  //Fading stuff
  FG_FadeOut          = 0;
  FG_FadeIn           = 1;
  FG_FadeLow          = 2;
  FG_FadeUpToNormal   = 3;
  FG_FadeFull         = 4;
  FG_FadeDownToNormal = 5;

  FG_StepDef     = 8;
  FG_IntervalDef = 25;

  //Minimize when idle stuff
  MWI_MinTimeToWait = 30; {seconds to wait until graph is minimized}
  MWI_ResTimeToWait = 5; {seconds to wait until graph is restored}

  //Mouse sensitive fading stuff
  MA_FadeLow          = 0;
  MA_FadeUpToNormal   = 1;
  MA_FadeFull         = 2;
  MA_FadeDownToNormal = 3;

  MF_FadeFullTimeToWait         = 0;
  MF_FadeDownToNormalTimeToWait = 0;
  MF_FadeLowTimeToWait          = 0;
  MF_FadeUpToNormalTimeToWait   = 2 {seconds} * 40 {1 second / MF_Timer.Interval};

  PBT_APMQUERYSUSPEND       = $0;
  PBT_APMQUERYSTANDBY       = $1;
  PBT_APMQUERYSUSPENDFAILED = $2;
  PBT_APMQUERYSTANDBYFAILED = $3;
  PBT_APMSUSPEND            = $4;
  PBT_APMSTANDBY            = $5;
  PBT_APMRESUMECRITICAL     = $6;
  PBT_APMRESUMESUSPEND      = $7;
  PBT_APMRESUMESTANDBY      = $8;

  NT_Balloon = 0;
  NT_Popup   = 1;
  NT_Cmd     = 2;

  //Digit imput stuff
  Zero = '';
  Digits : set of char = ['0','1','2','3','4','5','6','7','8','9'];
  Backspace = #8;

  //Presets
  BW_Values : array[0..15] of integer = (
    BW_Autodetect,
    56000,
    64000,
    128000,
    384000,
    768000,
    1536000,
    1544000,
    10000000,
    11000000,
    22000000,
    44736000,
    54000000,
    100000000,
    1000000000,
    BW_Custom);

  VertGrid_Values : array[0..4] of integer = (
    -1,
    10,
    20,
    30,
    60);

  DisplayUnit_Values : array[0..3] of integer = (
    DU_Kilobit,
    DU_Kibibit,
    DU_Kilobyte,
    DU_Kibibyte);

  TrafficLimitUnit_Values : array[0..3] of integer = (
    TL_Megabytes,
    TL_Mebibytes,
    TL_Gigabytes,
    TL_Gibibytes);

  TrafficLimitULorDL_Values : array[0..2] of integer = (
    TL_UpAndDown,
    TL_UploadOnly,
    TL_DownloadOnly);

  TrafficLimitPeriod_Values : array[0..2] of integer = (
    TL_Day,
    TL_Week,
    TL_Month);

  NotifyType_Values : array[0..2] of integer = (
    NT_Balloon,
    NT_Popup,
    NT_Cmd);

  // INI-file stuff
  INI_ReadOK        = 0;
  INI_WriteOK       = 1;
  INI_ReadError     = -1;
  INI_WriteError    = -2;

  INI_LoadSaveErrMsg : array[-2..-1] of string = (
    'Error saving "%s"!',
    'Error reading "%s"!' );

  Ini_FileName    = 'NetMeter.ini';

  Ini_VerSection  = 'Version'; //Version
  Ini_Version     = 'ProgramVersion';

  Ini_PosSection  = 'Position'; //Position
  Ini_PosLeft     = 'Left';
  Ini_PosTop      = 'Top';
  Ini_PosWidth    = 'Width';
  Ini_PosHeight   = 'Height';

  Ini_OptSection  = 'Options'; //Options
  Ini_OptAOT      = 'AlwaysOnTop';
  Ini_OptSC       = 'ShowCaption';
  Ini_OptSM       = 'StartMinimized';
  Ini_OptMWI      = 'MinimizeWhenIdle';
  Ini_OptDAV      = 'DisplayAverageValues';
  Ini_OptCTT      = 'CloseToTray';
  Ini_OptSSE      = 'SnapToScreenEdges';
  Ini_OptTE       = 'TransparencyEnabled';
  Ini_OptTV       = 'TransparencyValue';
  Ini_OptCT       = 'ClickThrough';
  Ini_OptFE       = 'FadingEnabled';
  Ini_OptMFE      = 'MouseFadingEnabled';
  Ini_OptMFI      = 'MouseFadingIn';
  Ini_OptTIBH     = 'TrayIconBalloonHints';
  Ini_OptCMD      = 'NotifyCmd';
  Ini_OptNT       = 'NotifyType';
  Ini_OptNMP      = 'NotifyMonitoringProblems';
  Ini_OptUOD      = 'UseOldDUDescription';
  Ini_OptUOTI     = 'UseOldTrayIcons';
  Ini_OptWSO      = 'WeekStartsOn';
  Ini_OptMSO      = 'MonthStartsOn';
  Ini_OptTDU      = 'TotalsDisplayUnit';
  Ini_OptTVAE     = 'TrafficVolumeAlertEnabled';
  Ini_OptTL       = 'TrafficLimit';
  Ini_OptTLU      = 'TrafficLimitUnit';
  Ini_OptTLULDL   = 'TrafficLimitULorDL';
  Ini_OptTLP      = 'TrafficLimitPeriod';
  Ini_OptLFAS     = 'LogfileAutosave';
  Ini_OptLFASM    = 'LogfileAutosaveMinutes';

  Ini_OptIFTM     = 'NetworkInterfaceToMonitor';
  Ini_OptIFD      = 'NetworkInterfaceDescription';
  Ini_OptIFM      = 'NetworkInterfaceMAC';

  Ini_OptBW       = 'Bandwidth';
  Ini_OptGRAS     = 'GraphAutoScale';
  Ini_OptGRSHG    = 'GraphShowHorizontalGrid';
  Ini_OptGRVG     = 'GraphVertGrid';
  Ini_OptGRSP     = 'GraphShowPanel';
  Ini_OptGRSPT    = 'GraphShowPanelTotals';
  Ini_OptGRSMV    = 'GraphShowMaxValue';
  Ini_OptUDDU     = 'UDDisplayUnit';
  Ini_OptTUDDU    = 'TUDDisplayUnit';
  Ini_OptMVDU     = 'MVDisplayUnit';
  Ini_OptGRGB     = 'GraphGradientBackground';
  Ini_OptFNT_UD_N = 'UDPanelFontName';
  Ini_OptFNT_UD_S = 'UDPanelFontSize';
  Ini_OptFNT_UD_B = 'UDPanelFontBold';
  Ini_OptFNT_UD_I = 'UDPanelFontItalic';
  Ini_OptFNT_MV_N = 'MVPanelFontName';
  Ini_OptFNT_MV_S = 'MVPanelFontSize';
  Ini_OptFNT_MV_B = 'MVPanelFontBold';
  Ini_OptFNT_MV_I = 'MVPanelFontItalic';
  Ini_OptFAS      = 'FontAutosize';
  Ini_Opt_MV_BC   = 'MaxValueBorderColor';
  Ini_Opt_MV_BGC  = 'MaxValueBackgroundColor';
  Ini_Opt_MV_FC   = 'MaxValueFontColor';
  Ini_Opt_PN_BRC  = 'PanelBorderColor';
  Ini_Opt_PN_BGC  = 'PanelBackgroundColor';
  Ini_Opt_PN_ULC  = 'PanelULColor';
  Ini_Opt_PN_DLC  = 'PanelDLColor';
  Ini_Opt_GR_BRC  = 'GraphBorderColor';
  Ini_Opt_GR_BGC1 = 'GraphBackgroundColor1';
  Ini_Opt_GR_BGC2 = 'GraphBackgroundColor2';
  Ini_Opt_GR_GC   = 'GraphGridColor';
  Ini_Opt_GR_ULC  = 'UploadColor';
  Ini_Opt_GR_DLC  = 'DownloadColor';
  Ini_Opt_GR_UDC  = 'UpDnColor';

  function MinWinVersion(min_MajorVersion: Cardinal) : boolean;
  function GetRunOnStartup : boolean;
  procedure SetRunOnStartup;
  procedure DeleteRunOnStartup;
  function UDValueToStr(displayvalue : Int64; displayunit : integer; old_shortcut : boolean): string;
  procedure ModifyFontsFor(ctrl: TWinControl; fontname : string);

var
  NMO,
  NMO_TMP : NMOptionsRecord;
  NM_AppDataDir : string;

implementation

function MinWinVersion(min_MajorVersion: Cardinal) : boolean;
var
  OS_VersionInfo : TOSVersionInfo;
begin
  OS_VersionInfo.dwOSVersionInfoSize := SizeOf(OS_VersionInfo);
  if GetVersionEx(OS_VersionInfo) then
    result := (OS_VersionInfo.dwPlatformId = VER_PLATFORM_WIN32_NT) and (OS_VersionInfo.dwMajorVersion >= min_MajorVersion)
  else
    result := FALSE;
end;

function GetRunOnStartup : boolean;
var
  reg: TRegistry;
begin
  Result := FALSE;

  reg := TRegistry.Create;

  try
    reg.RootKey := HKEY_CURRENT_USER;
    reg.OpenKey ( Autorun_Regkey, FALSE );

    Result := reg.ValueExists( Application.Title );
  finally
    reg.Free;
  end;
end;

procedure SetRunOnStartup;
var
  reg: TRegistry;
begin
  reg := TRegistry.Create;

  try
    reg.RootKey := HKEY_CURRENT_USER;
    reg.OpenKey ( Autorun_Regkey, FALSE );

    reg.WriteString ( Application.Title, Application.ExeName )
  finally
    reg.Free;
  end;
end;

procedure DeleteRunOnStartup;
var
  reg: TRegistry;
begin
  reg := TRegistry.Create;

  try
    reg.RootKey := HKEY_CURRENT_USER;
    reg.OpenKey ( Autorun_Regkey, FALSE );

    if reg.ValueExists( Application.Title ) then
      reg.DeleteValue ( Application.Title );
  finally
    reg.Free;
  end;
end;

function UDValueToStr(displayvalue : Int64; displayunit : integer; old_shortcut : boolean): string;
var
  divider : Int64;
  s : string;
  d, sc : integer;
  found : boolean;
begin
  with DU_Unit[displayunit] do
    begin
      with Symbol[DU_k] do
        begin
          divider := Value;
          if old_shortcut then s := Alt_Shortcut else s := Shortcut;
          d := Digits;
        end;

      sc := DU_t;
      found := FALSE;

      repeat
        begin
          if Abs( displayvalue * Bitmultiplier ) >= Symbol[sc].Value then
            with Symbol[sc] do
              begin
                divider := Value;
                if old_shortcut then s := Alt_Shortcut else s := Shortcut;
                d := Digits;
                found := TRUE;
              end;
          dec(sc);
        end
      until ( sc = 0 ) or found;

      result := FloatToStrF( displayvalue * Bitmultiplier / divider, ffNumber, 15, d ) + #32 + s;
    end;
  end;

procedure ModifyFontsFor(ctrl: TWinControl; fontname : string);
var
  i: integer;

procedure ModifyFont(ctrl: TControl);
var
  f: TFont;
begin
  if IsPublishedProp( ctrl, 'Parentfont' ) and
     ( GetOrdProp( ctrl, 'Parentfont' ) = Ord(false) ) and
     IsPublishedProp(ctrl, 'font') then
    begin
      f := TFont(GetObjectProp(ctrl, 'font', TFont));
      f.Name := fontname;
    end;
end;

begin
  ModifyFont(ctrl);
  for i := 0 to ctrl.controlcount - 1 do
    if ctrl.controls[i] is Twincontrol then
      ModifyFontsfor( TWincontrol( ctrl.controls[i] ), fontname )
    else
      Modifyfont( ctrl.controls[i] );
end;

end.
