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

unit NetMeterMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, Menus, ActnList, IniFiles, DateUtils, Types, ShlObj, ActiveX,
  SimpleTimer, CoolTrayIcon,
  NetMeterGlobal, NetMeterIPHLP, NetMeterTrafficLog, NetMeterTrafficBuffer, NetMeterGraph,
  NetMeterTrayIcon, ShellApi;

type
  TNMMain = class(TForm)
    NMTrayIcons: TImageList;
    NMPopupMenu: TPopupMenu;
    Exit1: TMenuItem;
    NMActions: TActionList;
    ExitProgram: TAction;
    NMActionIcons: TImageList;
    HideMeterAction: TAction;
    HideMeter1: TMenuItem;
    Options: TAction;
    N3: TMenuItem;
    N1: TMenuItem;
    Options1: TMenuItem;
    ApplyOptions: TAction;
    About: TAction;
    Options2: TMenuItem;
    ShowMeterAction: TAction;
    ShowMeter1: TMenuItem;
    Totals: TAction;
    ShowTotals1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure OptionsExecute(Sender: TObject);
    procedure ApplyOptionsExecute(Sender: TObject);
    procedure AboutExecute(Sender: TObject);
    procedure ExitProgramExecute(Sender: TObject);
    procedure HideMeterActionExecute(Sender: TObject);
    procedure ShowMeterActionExecute(Sender: TObject);
    procedure LeftClickMoveWindow(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TotalsExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure NMTrayClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SaveAllData;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    NMTray : TCoolTrayIcon;

    //general timer stuff
    TimersSuspended : boolean;
    //main timer stuff
    PD_Timer          : TSimpleTimer;
    PD_Timer_OldState : boolean;
    PD_isbusy         : boolean;
    //fade graph timer stuff
    FG_Timer          : TSimpleTimer;
    FG_Timer_OldState : boolean;
    FG_Type, FG_Step  : integer;
    //mousefade timer stuff
    MF_Timer          : TSimpleTimer;
    MF_Timer_OldState : boolean;
    MF_WaitCounter    : integer;
    MF_CursorIsOnForm : boolean;
    //minimize when idle stuff
    MWI_IsIdle      : boolean;
    MWI_WaitCounter : integer;

    procedure SetConstraints;
    procedure ApplyOpts(init : boolean = FALSE);
    //timer procedures
    procedure PD_TimerProc(Sender: TObject);
    procedure FG_TimerProc(Sender: TObject);
    procedure MF_TimerProc(Sender: TObject);
    procedure MF_Timer_RefreshState;
    //windows messages processing stuff
    procedure wmSysCommand(var msg : TMessage); message WM_SYSCOMMAND;
    procedure wmPowerBroadcast(var msg : TMessage); message WM_POWERBROADCAST;
    procedure wmEndSession(var msg : TMessage); message WM_ENDSESSION;
    procedure wmEraseBkgnd(var msg : TMessage); message WM_ERASEBKGND;
    //message window stuff
    procedure MessageForm(s : string);
    //INI-file stuff
    procedure ReadIniFile;
    procedure WriteIniFile;
    //main window hide/show stuff
    procedure DoHideMeter;
    procedure DoShowMeter(BringToFront : boolean);
    procedure HideMeter;
    procedure ShowMeter(BringToFront : boolean);
    procedure HideShowBlock;
    procedure HideShowRestore;
    procedure FadeGraph( FGT : integer; BringToFront : boolean );
    //mousefade stuff
    function  MouseWithinGraphWindow : boolean;
    //check if graph window is within visible desktop area
    procedure CheckMainFormPosition;
    //event handling procs
    procedure INI_LoadSaveErrorProc(const msg : integer; var retry : boolean );
    procedure TLG_LoadSaveErrorProc(Sender: TObject; const msg : integer; var retry : boolean );
    procedure TLG_CSVLoadSaveErrorProc(Sender: TObject; const msg : integer; var retry : boolean );
    procedure TL_WarningProc(Sender: TObject; const msg : integer; const n : Pointer);
    procedure IF_ErrorProc(Sender: TObject; const msg : integer);
  public
    { Public declarations }
    NMIC : TIPHLPCollector;
    NMTB : TTrafficBuffer;
    NMGR : TTrafficGraph;
    NMTL : TTrafficLogs;
    NMTIG : TTrayIconGauge;
    procedure SuspendTimers;
    procedure ResumeTimers;
  end;

var
  NMMain : TNMMain;

implementation

uses NetMeterAbout, NetMeterOptions, NetMeterTotals, NetMeterMessageForm;

{$R *.dfm}

procedure TNMMain.MessageForm(s : string);
var
  m : TNMMessageForm;
begin
  MessageBeep( MB_OK );

  m := TNMMessageForm.Create( Application );
  m.MessageToShow.Caption := s;
  m.Show;
end;

procedure TNMMain.CheckMainFormPosition;
var
  pmon,
  lp, tp : integer;
begin
  lp := NMMain.Left;
  tp := NMMain.Top;

  if ( ( lp = FRM_InitPos ) or (tp = FRM_InitPos ) ) or
     ( ( lp < Screen.DesktopLeft - NMMain.Width  + 1 + FRM_BorderThreshold ) or
       ( tp < Screen.DesktopTop  - NMMain.Height + 1 + FRM_BorderThreshold ) or
       ( lp > Screen.DesktopLeft + Screen.DesktopWidth  - 1 - FRM_BorderThreshold ) or
       ( tp > Screen.DesktopTop  + Screen.DesktopHeight - 1 - FRM_BorderThreshold ) ) then
    begin
      pmon := 0;
      while Screen.Monitors[pmon].Primary = FALSE do inc(pmon);

      NMMain.Left := Screen.Monitors[pmon].WorkareaRect.Right  - NMMain.Width  - 32;
      NMMain.Top  := Screen.Monitors[pmon].WorkareaRect.Bottom - NMMain.Height - 32;
    end;
end;

procedure TNMMain.ReadIniFile;
var
  IniFile : TIniFile;
  Status : integer;
  iswin9x,
  ShouldRetry : boolean;

function DoRead : integer;

procedure ResetIni;
var
  i : integer;
  sl : TStringList;
begin
  sl := TStringList.Create;
  IniFile.ReadSections(sl);
  for i := 0 to sl.Count - 1 do
    IniFile.EraseSection( sl[i] );
  sl.Free;
end;

var
  ts : TMemoryStream;
  s : string;
  n : NotifyRecord;
  i, default : integer;
  sections : TStringList;
begin
  Result := INI_ReadOK;

  iswin9x := not(MinWinVersion(Win2k_or_newer));

  IniFile := TIniFile.Create(NM_AppDataDir + Ini_FileName);
  try
    with IniFile do
    begin
      //Version
      if ReadInteger(Ini_VerSection, Ini_Version, 0) = 0 then ResetIni;

      //Form position
      NMMain.Width  := ReadInteger(Ini_PosSection, Ini_PosWidth,  FRM_DefWidth);
      NMMain.Height := ReadInteger(Ini_PosSection, Ini_PosHeight, FRM_DefHeight);
      NMMain.Left   := ReadInteger(Ini_PosSection, Ini_PosLeft,   FRM_InitPos);
      NMMain.Top    := ReadInteger(Ini_PosSection, Ini_PosTop,    FRM_InitPos);

      CheckMainFormPosition;

      //Options
      NMO.AlwaysOnTop             := ReadBool   (Ini_OptSection, Ini_OptAOT,    TRUE);
      NMO.ShowCaption             := ReadBool   (Ini_OptSection, Ini_OptSC,     TRUE);
      NMO.StartMinimized          := ReadBool   (Ini_OptSection, Ini_OptSM,     FALSE);
      NMO.MinimizeWhenIdle        := ReadBool   (Ini_OptSection, Ini_OptMWI,    FALSE);
      NMO.DisplayAverageValues    := ReadBool   (Ini_OptSection, Ini_OptDAV,    FALSE);
      NMO.CloseToTray             := ReadBool   (Ini_OptSection, Ini_OptCTT,    TRUE);
      NMO.SnapToScreenEdges       := ReadBool   (Ini_OptSection, Ini_OptSSE,    TRUE);
      NMO.TransparencyEnabled     := ReadBool   (Ini_OptSection, Ini_OptTE,     FALSE);
      NMO.TransparencyValue       := ReadInteger(Ini_OptSection, Ini_OptTV,     204);
      NMO.ClickThrough            := ReadBool   (Ini_OptSection, Ini_OptCT,     FALSE);
      NMO.FadingEnabled           := ReadBool   (Ini_OptSection, Ini_OptFE,     FALSE);
      NMO.MouseFadingEnabled      := ReadBool   (Ini_OptSection, Ini_OptMFE,    FALSE);
      NMO.MouseFadingIn           := ReadBool   (Ini_OptSection, Ini_OptMFI,    FALSE);
      NMO.WeekStartsOn            := ReadInteger(Ini_OptSection, Ini_OptWSO,    1);
      NMO.MonthStartsOn           := ReadInteger(Ini_OptSection, Ini_OptMSO,    1);
      NMO.TotalsDisplayUnit       := ReadInteger(Ini_OptSection, Ini_OptTDU,    DU_Kibibyte);

      NMO.LogfileAutosaveEnabled  := ReadBool   (Ini_OptSection, Ini_OptLFAS,   TRUE);
      NMO.LogfileAutosaveMinutes  := ReadInteger(Ini_OptSection, Ini_OptLFASM,  5);

      //NMO.TVAlertEnabled          := ReadBool   (Ini_OptSection, Ini_OptTVAE,   FALSE);
      //NMO.TrafficLimit            := ReadInteger(Ini_OptSection, Ini_OptTL,     0);
      //NMO.TrafficLimitUnit        := ReadInteger(Ini_OptSection, Ini_OptTLU,    TL_Gibibytes);
      //NMO.TrafficLimitULorDL      := ReadInteger(Ini_OptSection, Ini_OptTLULDL, TL_UpAndDown);
      //NMO.TrafficLimitPeriod      := ReadInteger(Ini_OptSection, Ini_OptTLP,    TL_Month);
      //NMO.TrayIcon_BalloonHints   := ReadBool   (Ini_OptSection, Ini_OptTIBH,   not iswin9x);
      //NMO.NotifyRunCmd            := ReadBool   (Ini_OptSection, Ini_OptNRC,    FALSE);
      //NMO.NotifyCmd               := ReadString (Ini_OptSection, Ini_OptNC,     '') ;
      //NMO.NotifyMonitoringProblems:= ReadBool   (Ini_OptSection, Ini_OptNMP,    TRUE);

      sections := TStringList.Create;
      ReadSections(sections);
      for i := 0 to sections.Count - 1 do
        begin
          s := sections[i];
          OutputDebugString(PChar('read section ' + s));
          if (s = Ini_OptSection) or (s = Ini_VerSection) or (s = Ini_PosSection) then
            Continue;
          n.NotifyName := s;
          if iswin9x then
            default := NT_POPUP
          else
            default := NT_BALLOON;

          n.NotifyType                  := ReadInteger(s, Ini_OptNT,     default);
          n.Cmd                         := ReadString (s, Ini_OptCMD,    '');
          n.NotifyMonitoringProblems    := ReadBool   (s, Ini_OptNMP,    TRUE);
          n.TVAlertEnabled              := ReadBool   (s, Ini_OptTVAE,   FALSE);
          n.TrafficLimit                := ReadInteger(s, Ini_OptTL,     0);
          n.TrafficLimitUnit            := ReadInteger(s, Ini_OptTLU,    TL_Gibibytes);
          n.TrafficLimitULorDL          := ReadInteger(s, Ini_OptTLULDL, TL_UpAndDown);
          n.TrafficLimitPeriod          := ReadInteger(s, Ini_OptTLP,    TL_Month);
          
          SetLength(NMO.Notify, Length(NMO.Notify) + 1);
          NMO.Notify[High(NMO.Notify)] := n;
        end;

      NMO.UseOldDUDescription     := ReadBool   (Ini_OptSection, Ini_OptUOD,    FALSE);
      NMO.UseOldTrayIcons         := ReadBool   (Ini_OptSection, Ini_OptUOTI,   iswin9x);

      NMO.IFToMonitor             := ReadInteger(Ini_OptSection, Ini_OptIFTM,   IF_All_noLB_noDP);

      FillChar(NMO.IFDescription, SizeOf(NMO.IFDescription), #0);
      ts := TMemoryStream.Create;
      ReadBinaryStream(Ini_OptSection, Ini_OptIFD, ts);
      ts.Position := 0;
      if ts.Size <= SizeOf(NMO.IFDescription) then
        ts.Read(NMO.IFDescription, ts.Size);
      ts.Free;

      FillChar(NMO.IFMAC, SizeOf(NMO.IFMAC), 0);
      ts := TMemoryStream.Create;
      ReadBinaryStream(Ini_OptSection, Ini_OptIFM, ts);
      ts.Position := 0;
      if ts.Size <= SizeOf(NMO.IFMAC) then
        ts.Read(NMO.IFMAC, ts.Size);
      ts.Free;

      NMO.Bandwidth             := ReadInteger(Ini_OptSection, Ini_OptBW,       BW_Autodetect);
      NMO.Autoscale             := ReadBool   (Ini_OptSection, Ini_OptGRAS,     TRUE);
      NMO.ShowHorGrid           := ReadBool   (Ini_OptSection, Ini_OptGRSHG,    TRUE);
      NMO.ShowPanel             := ReadBool   (Ini_OptSection, Ini_OptGRSP,     TRUE);
      NMO.ShowPanelTotals       := ReadBool   (Ini_OptSection, Ini_OptGRSPT,    FALSE);
      NMO.ShowMaxValue          := ReadBool   (Ini_OptSection, Ini_OptGRSMV,    TRUE);
      NMO.UDDisplayUnit         := ReadInteger(Ini_OptSection, Ini_OptUDDU,     DU_Kibibyte);
      NMO.TUDDisplayUnit        := ReadInteger(Ini_OptSection, Ini_OptTUDDU,    DU_Kibibyte);
      NMO.MVDisplayUnit         := ReadInteger(Ini_OptSection, Ini_OptMVDU,     DU_Kibibyte);
      NMO.Gradient              := ReadBool   (Ini_OptSection, Ini_OptGRGB,     TRUE);
      NMO.VertGrid              := ReadInteger(Ini_OptSection, Ini_OptGRVG,     -1);
      NMO.Color.MV_Border       := ReadInteger(Ini_OptSection, Ini_Opt_MV_BC,   GR_DefColor.MV_Border);
      NMO.Color.MV_BkGr         := ReadInteger(Ini_OptSection, Ini_Opt_MV_BGC,  GR_DefColor.MV_BkGr);
      NMO.Color.MV_Font         := ReadInteger(Ini_OptSection, Ini_Opt_MV_FC,   GR_DefColor.MV_Font);
      NMO.Color.PN_Border       := ReadInteger(Ini_OptSection, Ini_Opt_PN_BRC,  GR_DefColor.PN_Border);
      NMO.Color.PN_BkGr         := ReadInteger(Ini_OptSection, Ini_Opt_PN_BGC,  GR_DefColor.PN_BkGr);
      NMO.Color.PN_UL           := ReadInteger(Ini_OptSection, Ini_Opt_PN_ULC,  GR_DefColor.PN_UL);
      NMO.Color.PN_DL           := ReadInteger(Ini_OptSection, Ini_Opt_PN_DLC,  GR_DefColor.PN_DL);
      NMO.Color.GR_Border       := ReadInteger(Ini_OptSection, Ini_Opt_GR_BRC,  GR_DefColor.GR_Border);
      NMO.Color.GR_BkGr1        := ReadInteger(Ini_OptSection, Ini_Opt_GR_BGC1, GR_DefColor.GR_BkGr1);
      NMO.Color.GR_BkGr2        := ReadInteger(Ini_OptSection, Ini_Opt_GR_BGC2, GR_DefColor.GR_BkGr2);
      NMO.Color.GR_Grid         := ReadInteger(Ini_OptSection, Ini_Opt_GR_GC,   GR_DefColor.GR_Grid);
      NMO.Color.GR_Upload       := ReadInteger(Ini_OptSection, Ini_Opt_GR_ULC,  GR_DefColor.GR_Upload);
      NMO.Color.GR_Download     := ReadInteger(Ini_OptSection, Ini_Opt_GR_DLC,  GR_DefColor.GR_Download);
      NMO.Color.GR_UpDn         := ReadInteger(Ini_OptSection, Ini_Opt_GR_UDC,  GR_DefColor.GR_UpDn);
      NMO.FontUD.Name           := ReadString (Ini_OptSection, Ini_OptFNT_UD_N, DefFontUDName);
      NMO.FontUD.Size           := ReadInteger(Ini_OptSection, Ini_OptFNT_UD_S, DefFontUDSize);
      NMO.FontUD.Bold           := ReadBool   (Ini_OptSection, Ini_OptFNT_UD_B, FALSE);
      NMO.FontUD.Italic         := ReadBool   (Ini_OptSection, Ini_OptFNT_UD_I, FALSE);
      NMO.FontMV.Name           := ReadString (Ini_OptSection, Ini_OptFNT_MV_N, DefFontMVName);
      NMO.FontMV.Size           := ReadInteger(Ini_OptSection, Ini_OptFNT_MV_S, DefFontMVSize);
      NMO.FontMV.Bold           := ReadBool   (Ini_OptSection, Ini_OptFNT_MV_B, FALSE);
      NMO.FontMV.Italic         := ReadBool   (Ini_OptSection, Ini_OptFNT_MV_I, FALSE);
      NMO.FontAutosize          := ReadBool   (Ini_OptSection, Ini_OptFAS,      FALSE);
    end;
  except
    Result := INI_ReadError;
    IniFile.Free;
  end;
end;

begin
  repeat
    ShouldRetry := FALSE;
    Status := DoRead;
    if Status <> INI_ReadOK then
      INI_LoadSaveErrorProc( Status, ShouldRetry );
  until ShouldRetry = FALSE;
end;

procedure TNMMain.WriteIniFile;
var
  IniFile : TIniFile;
  Status : integer;
  ShouldRetry : boolean;

function DoWrite : integer;
var
  ts : TMemoryStream;
  i : integer;
  sections : TStringList;
  s : string;
begin
  Result := INI_WriteOK;

  IniFile := TIniFile.Create(NM_AppDataDir + Ini_FileName);
  try
    with IniFile do
    begin
      //Version
      WriteInteger(Ini_VerSection, Ini_Version,     Version_Int);

      //Position
      WriteInteger(Ini_PosSection, Ini_PosWidth,    NMMain.Width);
      WriteInteger(Ini_PosSection, Ini_PosHeight,   NMMain.Height);
      WriteInteger(Ini_PosSection, Ini_PosLeft,     NMMain.Left);
      WriteInteger(Ini_PosSection, Ini_PosTop,      NMMain.Top);

      //Options
      WriteBool   (Ini_OptSection, Ini_OptAOT,      NMO.AlwaysOnTop);
      WriteBool   (Ini_OptSection, Ini_OptSC,       NMO.ShowCaption);
      WriteBool   (Ini_OptSection, Ini_OptSM,       NMO.StartMinimized);
      WriteBool   (Ini_OptSection, Ini_OptMWI,      NMO.MinimizeWhenIdle);
      WriteBool   (Ini_OptSection, Ini_OptDAV,      NMO.DisplayAverageValues);
      WriteBool   (Ini_OptSection, Ini_OptCTT,      NMO.CloseToTray);
      WriteBool   (Ini_OptSection, Ini_OptSSE,      NMO.SnapToScreenEdges);
      WriteBool   (Ini_OptSection, Ini_OptTE,       NMO.TransparencyEnabled);
      WriteInteger(Ini_OptSection, Ini_OptTV,       NMO.TransparencyValue);
      WriteBool   (Ini_OptSection, Ini_OptCT,       NMO.ClickThrough);
      WriteBool   (Ini_OptSection, Ini_OptFE,       NMO.FadingEnabled);
      WriteBool   (Ini_OptSection, Ini_OptMFE,      NMO.MouseFadingEnabled);
      WriteBool   (Ini_OptSection, Ini_OptMFI,      NMO.MouseFadingIn);
      WriteInteger(Ini_OptSection, Ini_OptWSO,      NMO.WeekStartsOn);
      WriteInteger(Ini_OptSection, Ini_OptMSO,      NMO.MonthStartsOn);
      WriteInteger(Ini_OptSection, Ini_OptTDU,      NMO.TotalsDisplayUnit);

      WriteBool   (Ini_OptSection, Ini_OptLFAS,     NMO.LogfileAutosaveEnabled);
      WriteInteger(Ini_OptSection, Ini_OptLFASM,    NMO.LogfileAutosaveMinutes);

      {WriteBool   (Ini_OptSection, Ini_OptTVAE,     NMO.TVAlertEnabled);
      WriteInteger(Ini_OptSection, Ini_OptTL,       NMO.TrafficLimit);
      WriteInteger(Ini_OptSection, Ini_OptTLU,      NMO.TrafficLimitUnit);
      WriteInteger(Ini_OptSection, Ini_OptTLULDL,   NMO.TrafficLimitULorDL);
      WriteInteger(Ini_OptSection, Ini_OptTLP,      NMO.TrafficLimitPeriod);
      WriteBool   (Ini_OptSection, Ini_OptTIBH,     NMO.TrayIcon_BalloonHints);
      WriteBool   (Ini_OptSection, Ini_OptNRC,      NMO.NotifyRunCmd);
      WriteString (Ini_OptSection, Ini_OptNC,       NMO.NotifyCmd);
      WriteBool   (Ini_OptSection, Ini_OptNMP,      NMO.NotifyMonitoringProblems);}

      WriteBool   (Ini_OptSection, Ini_OptUOD,      NMO.UseOldDUDescription);
      WriteBool   (Ini_OptSection, Ini_OptUOTI,     NMO.UseOldTrayIcons);

      WriteInteger(Ini_OptSection, Ini_OptIFTM,     NMO.IFToMonitor);

      ts := TMemoryStream.Create;
      ts.Write(NMO.IFDescription, SizeOf(NMO.IFDescription));
      ts.Position := 0;
      WriteBinaryStream(Ini_OptSection, Ini_OptIFD, ts);
      ts.Free;

      ts := TMemoryStream.Create;
      ts.Write(NMO.IFMAC, SizeOf(NMO.IFMAC));
      ts.Position := 0;
      WriteBinaryStream(Ini_OptSection, Ini_OptIFM, ts);
      ts.Free;

      WriteInteger(Ini_OptSection, Ini_OptBW,       NMO.Bandwidth);
      WriteBool   (Ini_OptSection, Ini_OptGRAS,     NMO.Autoscale);
      WriteBool   (Ini_OptSection, Ini_OptGRSHG,    NMO.ShowHorGrid);
      WriteBool   (Ini_OptSection, Ini_OptGRSP,     NMO.ShowPanel);
      WriteBool   (Ini_OptSection, Ini_OptGRSPT,    NMO.ShowPanelTotals);
      WriteBool   (Ini_OptSection, Ini_OptGRSMV,    NMO.ShowMaxValue);
      WriteInteger(Ini_OptSection, Ini_OptUDDU,     NMO.UDDisplayUnit);
      WriteInteger(Ini_OptSection, Ini_OptTUDDU,    NMO.TUDDisplayUnit);
      WriteInteger(Ini_OptSection, Ini_OptMVDU,     NMO.MVDisplayUnit);
      WriteBool   (Ini_OptSection, Ini_OptGRGB,     NMO.Gradient);
      WriteInteger(Ini_OptSection, Ini_OptGRVG,     NMO.VertGrid);
      WriteInteger(Ini_OptSection, Ini_Opt_MV_BC,   NMO.Color.MV_Border);
      WriteInteger(Ini_OptSection, Ini_Opt_MV_BGC,  NMO.Color.MV_BkGr);
      WriteInteger(Ini_OptSection, Ini_Opt_MV_FC,   NMO.Color.MV_Font);
      WriteInteger(Ini_OptSection, Ini_Opt_PN_BRC,  NMO.Color.PN_Border);
      WriteInteger(Ini_OptSection, Ini_Opt_PN_BGC,  NMO.Color.PN_BkGr);
      WriteInteger(Ini_OptSection, Ini_Opt_PN_ULC,  NMO.Color.PN_UL);
      WriteInteger(Ini_OptSection, Ini_Opt_PN_DLC,  NMO.Color.PN_DL);
      WriteInteger(Ini_OptSection, Ini_Opt_GR_BRC,  NMO.Color.GR_Border);
      WriteInteger(Ini_OptSection, Ini_Opt_GR_BGC1, NMO.Color.GR_BkGr1);
      WriteInteger(Ini_OptSection, Ini_Opt_GR_BGC2, NMO.Color.GR_BkGr2);
      WriteInteger(Ini_OptSection, Ini_Opt_GR_GC,   NMO.Color.GR_Grid);
      WriteInteger(Ini_OptSection, Ini_Opt_GR_ULC,  NMO.Color.GR_Upload);
      WriteInteger(Ini_OptSection, Ini_Opt_GR_DLC,  NMO.Color.GR_Download);
      WriteInteger(Ini_OptSection, Ini_Opt_GR_UDC,  NMO.Color.GR_UpDn);
      WriteString (Ini_OptSection, Ini_OptFNT_UD_N, NMO.FontUD.Name);
      WriteInteger(Ini_OptSection, Ini_OptFNT_UD_S, NMO.FontUD.Size);
      WriteBool   (Ini_OptSection, Ini_OptFNT_UD_B, NMO.FontUD.Bold);
      WriteBool   (Ini_OptSection, Ini_OptFNT_UD_I, NMO.FontUD.Italic);
      WriteString (Ini_OptSection, Ini_OptFNT_MV_N, NMO.FontMV.Name);
      WriteInteger(Ini_OptSection, Ini_OptFNT_MV_S, NMO.FontMV.Size);
      WriteBool   (Ini_OptSection, Ini_OptFNT_MV_B, NMO.FontMV.Bold);
      WriteBool   (Ini_OptSection, Ini_OptFNT_MV_I, NMO.FontMV.Italic);
      WriteBool   (Ini_OptSection, Ini_OptFAS,      NMO.FontAutosize);

      sections := TStringList.Create;
      ReadSections(sections);
      for i := 0 to sections.Count - 1 do
        begin
          s := sections[i];
          if (s = Ini_OptSection) or (s = Ini_VerSection) or (s = Ini_PosSection) then
            Continue
          else
            EraseSection(s);
          OutputDebugString(PChar('erase section ' + s));
        end;

      for i := Low(NMO.Notify) to High(NMO.Notify) do
        with NMO.Notify[i] do
          begin
            OutputDebugString(PChar('write section ' + NotifyName));
            WriteBool   (NotifyName, Ini_OptTVAE,     TVAlertEnabled);
            WriteInteger(NotifyName, Ini_OptTL,       TrafficLimit);
            WriteInteger(NotifyName, Ini_OptTLU,      TrafficLimitUnit);
            WriteInteger(NotifyName, Ini_OptTLULDL,   TrafficLimitULorDL);
            WriteInteger(NotifyName, Ini_OptTLP,      TrafficLimitPeriod);
            WriteString (NotifyName, Ini_OptCMD,      Cmd);
            WriteInteger(NotifyName, Ini_OptNT,       NotifyType);
            WriteBool   (NotifyName, Ini_OptNMP,      NotifyMonitoringProblems);
          end;

      UpdateFile;
    end;
  except
    Result := INI_WriteError;
    IniFile.Free;
  end;
end;

begin
  repeat
    ShouldRetry := FALSE;
    Status := DoWrite;
    if Status <> INI_WriteOK then
      INI_LoadSaveErrorProc( Status, ShouldRetry );
  until ShouldRetry = FALSE;
end;

procedure TNMMain.INI_LoadSaveErrorProc(const msg : integer; var retry : boolean );
var
  s : string;
begin
  MessageBeep( MB_ICONHAND );

  s := Format( INI_LoadSaveErrMsg[ msg ], [ ExtractFileName( NM_AppDataDir + Ini_FileName ) ] );
  retry := ( MessageDlg( s, mtError, [mbRetry, mbAbort], 0 ) = mrRetry );
end;

procedure TNMMain.TLG_LoadSaveErrorProc(Sender: TObject; const msg : integer; var retry : boolean );
var
  s : string;
  AutosaveWasEnabled : boolean;
begin
  AutosaveWasEnabled := NMTL.AutosaveEnabled;
  NMTL.AutosaveEnabled := FALSE;

  MessageBeep( MB_ICONHAND );

  s := Format( TLG_LoadSaveErrMsg[ msg ], [ ExtractFileName( NMTL.FileName ) ] );
  retry := ( MessageDlg( s, mtError, [mbRetry, mbAbort], 0 ) = mrRetry );

  NMTL.AutosaveEnabled := AutosaveWasEnabled;
end;

procedure TNMMain.TLG_CSVLoadSaveErrorProc(Sender: TObject; const msg : integer; var retry : boolean );
var
  s : string;
begin
  MessageBeep( MB_ICONHAND );

  s := Format( TLG_CSVLoadSaveErrMsg[ msg ], [ ExtractFileName( NMTL.CSVFileName ) ] );
  retry := ( MessageDlg( s, mtError, [mbRetry, mbAbort], 0 ) = mrRetry );
end;

procedure TNMMain.TL_WarningProc(Sender: TObject; const msg : integer; const n : Pointer);
var
  np : ^NotifyRecord;
begin
  np := n;
  case np.NotifyType of
    NT_Balloon:
      NMTray.ShowBalloonHint( Application.Title, TL_Msg[ msg ], BitInfo, 10);
    NT_Popup:
      MessageForm( TL_Msg[ msg ] );
    NT_Cmd:
      ShellExecute(Handle, 'open', PChar(np.Cmd), PChar(IntToStr(msg)), nil, SW_SHOWNORMAL);
  end;
end;

procedure TNMMain.IF_ErrorProc(Sender: TObject; const msg : integer);
var
  i : integer;
begin
for i := Low(NMO.Notify) to High(NMO.Notify) do
with NMO.Notify[i] do
if NotifyMonitoringProblems then
begin
  case NotifyType of
    NT_Balloon:
      NMTray.ShowBalloonHint( Application.Title, IFS_Msg[ msg ], BitInfo, 10);
    NT_Popup:
      MessageForm( IFS_Msg[ msg ] );
    NT_Cmd:
      ShellExecute(Handle, 'open', PChar(Cmd), nil, nil, SW_SHOWNORMAL);
  end;
  Exit;
end;
end;

procedure TNMMain.FormCreate(Sender: TObject);

function GetSpecialFolder(aFolder: integer): string;
var
  pIdL: PItemIDList;
  path: Array [0..Max_Path] Of char;
  allocator: IMalloc;
begin
  SHGetSpecialFolderLocation(0, aFolder, pIdL);
  SHGetPathFromIDList(pIDL, path);
  if succeeded(SHGetMalloc(Allocator)) then allocator.Free(pIdL);
  Result := path;
end;

begin
  // Init CoolTrayIcon Component
  NMTray := TCoolTrayIcon.Create(self);
  with NMTray do
    begin
      IconList := NMTrayIcons;
      PopupMenu := NMPopupMenu;
      OnClick := NMTrayClick;
    end;

  // Set form font depending on windows version
  if MinWinVersion(Win2k_or_newer) then
    NMMain.Font.Name := FNT_Default_2k
  else
    NMMain.Font.Name := FNT_Default_9x;

  //Determine where to load/save INI and TLG
  if MinWinVersion(WinVista_or_newer) then
    begin
      NM_AppDataDir := GetSpecialFolder(CSIDL_APPDATA) + '\' + Application.Title + '\';
      if not DirectoryExists(NM_AppDataDir) then CreateDir(NM_AppDataDir);
    end
  else
    NM_AppDataDir := ExtractFilePath(Application.ExeName);

  //Initialize options
  ReadIniFile;
  NMO.RunOnStartup := GetRunOnStartup;
  NMO_TMP := NMO;

  //Initialize traffic log module
  NMTL := TTrafficLogs.Create;
  with NMTL do
    begin
      FileName := NM_AppDataDir + TLG_FileName;
      OnLoadSaveError := TLG_LoadSaveErrorProc;
      LoadFromFile;
      OnTrafficLimitWarning := TL_WarningProc;
      OnCSVLoadSaveError := TLG_CSVLoadSaveErrorProc;
    end;

  //Initialize IP-helper module
  NMIC := TIPHLPCollector.Create;
  NMIC.OnMonitoringError := IF_ErrorProc;

  NMTB := TTrafficBuffer.Create;

  NMGR := TTrafficGraph.Create(self);
  with NMGR do
    begin
      DoubleBuffered := TRUE;
      Parent := NMMain;
      Align := alClient;
      OnMouseDown := LeftClickMoveWindow;
      TrafficBuffer := NMTB;
      Paint;
    end;

  NMTIG := TTrayIconGauge.Create(self);
  with NMTIG do
    begin
      TrafficBuffer := NMTB;
    end;

  //Enable tray icon and set visibility of main window
  with NMTray do
    begin
      Enabled := TRUE;
      IconVisible := TRUE;
    end;
  NMMain.Visible := not(NMO.StartMinimized);
  HideShowRestore;

  //Initialize timers
  PD_Timer := TSimpleTimer.CreateEx( 1000, PD_TimerProc );
  FG_Timer := TSimpleTimer.CreateEx( 1000, FG_TimerProc );
  MF_Timer := TSimpleTimer.CreateEx( 25,   MF_TimerProc );
  TimersSuspended := FALSE;

  //Apply options with init-flag
  ApplyOpts(TRUE);

  //Start main timer
  PD_isbusy := FALSE;
  PD_Timer.Enabled := TRUE;
  PD_TimerProc(self);
end;

procedure TNMMain.FormDestroy(Sender: TObject);
begin
  MF_Timer.Free;
  FG_Timer.Free;
  PD_Timer.Free;

  NMTIG.Free;
  NMGR.Free;
  NMTB.Free;
  NMIC.Free;
  NMTL.Free;

  NMTray.Free;
end;

procedure TNMMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveAllData;
end;

procedure TNMMain.SaveAllData;
begin
  WriteIniFile;

  NMTL.AutosaveEnabled := FALSE;
  NMTL.SaveToFile;
end;

function TNMMain.MouseWithinGraphWindow : boolean;
var
  mcp : TPoint;
begin
  if NMMain.Visible then
    begin
       try
         GetCursorPos( mcp );
         result := ( mcp.X >= NMMain.Left ) and
                   ( mcp.Y >= NMMain.Top  ) and
                   ( mcp.X <= NMMain.Left + NMMain.Width  ) and
                   ( mcp.Y <= NMMain.Top  + NMMain.Height )
       except
         result := FALSE;
       end;
    end
  else
    result := FALSE;
end;

procedure TNMMain.MF_Timer_RefreshState;
begin
  with NMO do
    MF_Timer.Enabled := NMMain.Visible and TransparencyEnabled and FadingEnabled and MouseFadingEnabled;
end;

procedure TNMMain.PD_TimerProc(Sender: TObject);
var
  MWI_Traffic : boolean;

begin
  if PD_isbusy then exit;
  PD_isbusy := TRUE;

  NMIC.Update;

  //Autoscale stuff
  if not NMO.Autoscale then
    begin
      if NMO.Bandwidth = BW_Autodetect then
        begin
          NMGR.MaxValue := NMIC.BandwidthTotal;
          NMTIG.MaxValue := NMIC.BandwidthTotal;
        end
      else
        begin
          NMGR.MaxValue := NMO.Bandwidth;
          NMTIG.MaxValue := NMO.Bandwidth;
        end;
    end;

  //Add to traffic buffer
  with NMIC do NMTB.Add( Upload, Download );

  //Display average stuff
  if NMO.DisplayAverageValues then
    begin
      NMGR.ULabel := LB_UL + UDValueToStr( NMTB.UploadAV,   NMO.UDDisplayUnit, NMO.UseOldDUDescription ) + LB_PerSec;
      NMGR.DLabel := LB_DL + UDValueToStr( NMTB.DownloadAV, NMO.UDDisplayUnit, NMO.UseOldDUDescription ) + LB_PerSec;
    end
  else
    begin
      NMGR.ULabel := LB_UL + UDValueToStr( NMIC.Upload,   NMO.UDDisplayUnit, NMO.UseOldDUDescription ) + LB_PerSec;
      NMGR.DLabel := LB_DL + UDValueToStr( NMIC.Download, NMO.UDDisplayUnit, NMO.UseOldDUDescription ) + LB_PerSec;
    end;

  //Total UD stuff
  with NMTL.TempLog.Data do
    begin
      NMGR.TULabel := LB_TUL + UDValueToStr( TotalUL, NMO.TUDDisplayUnit, NMO.UseOldDUDescription );
      NMGR.TDLabel := LB_TDL + UDValueToStr( TotalDL, NMO.TUDDisplayUnit, NMO.UseOldDUDescription );
      NMGR.MVLabel := LB_MAX + UDValueToStr( Round( NMGR.MaxValue / 8 ), NMO.MVDisplayUnit, NMO.UseOldDUDescription ) + LB_PerSec;
    end;

  //Tray icon stuff
  with NMTray do
    begin
      if NMO.UseOldTrayIcons then
        begin
          if (NMIC.Upload = 0) and (NMIC.Download = 0) then NMTrayIcons.GetIcon(0, Icon); //Idle
          if (NMIC.Upload > 0) and (NMIC.Download = 0) then NMTrayIcons.GetIcon(1, Icon); //Upload only
          if (NMIC.Upload = 0) and (NMIC.Download > 0) then NMTrayIcons.GetIcon(2, Icon); //Download only
          if (NMIC.Upload > 0) and (NMIC.Download > 0) then NMTrayIcons.GetIcon(3, Icon); //Upload and Download
        end
      else
        Icon.Assign(NMTIG.Icon);

      Hint := NMGR.DLabel + LB_Separator + NMGR.ULabel + #13 + NMIC.LastMonitoredIFDescription;
    end;

  //Repaint graph
  if NMMain.Visible then
    begin
      NMGR.Paint;
      SetConstraints;
    end;

  //Add to traffic log
  with NMIC do NMTL.Add( Date, Upload, Download );

  //Minimize when idle stuff
  if NMO.MinimizeWhenIdle then
    begin
      MWI_Traffic := (NMIC.Upload <> 0) or (NMIC.Download <> 0);

      if not MWI_IsIdle then
        begin
          if not(MWI_Traffic) then
            begin
              if (MWI_WaitCounter + 1) <= MWI_MinTimeToWait then
                inc(MWI_WaitCounter)
              else
                if not(NMO.MouseFadingEnabled and
                       NMO.MouseFadingIn and
                       MF_CursorIsOnForm) then
                  HideMeter;
            end
          else
            begin
              MWI_IsIdle := not(NMMain.Visible);
              MWI_WaitCounter := 0;
            end;
        end
      else
        begin
          if MWI_Traffic then
            begin
              if (MWI_WaitCounter + 1) <= MWI_ResTimeToWait then
                inc(MWI_WaitCounter)
              else
                ShowMeter(FALSE);
            end
          else
            begin
              MWI_IsIdle := not(NMMain.Visible);
              MWI_WaitCounter := 0;
            end;
        end;
    end;

  PD_isbusy := FALSE;
end;

procedure TNMMain.wmSysCommand(var msg:TMessage);
begin
  if msg.wparam = SC_CLOSE then
    if NMO.CloseToTray then
      begin
        msg.wparam := 0;
        HideMeter;
      end;
  inherited;
end;

procedure TNMMain.SuspendTimers;
begin if not TimersSuspended then
begin
  TimersSuspended := TRUE;

  PD_Timer_OldState := PD_Timer.Enabled;
  FG_Timer_OldState := FG_Timer.Enabled;
  MF_Timer_OldState := MF_Timer.Enabled;

  PD_Timer.Enabled := FALSE;
  FG_Timer.Enabled := FALSE;
  MF_Timer.Enabled := FALSE;
end;
end;

procedure TNMMain.ResumeTimers;
begin if TimersSuspended then
begin
  PD_Timer.Enabled := PD_Timer_OldState;
  FG_Timer.Enabled := FG_Timer_OldState;
  MF_Timer.Enabled := MF_Timer_OldState;

  TimersSuspended := FALSE;
end;
end;

procedure TNMMain.wmPowerBroadcast(var msg:TMessage);
begin
  case msg.wparam of
    PBT_APMSUSPEND,
    PBT_APMSTANDBY       : SuspendTimers;
    PBT_APMRESUMESUSPEND,
    PBT_APMRESUMESTANDBY : ResumeTimers;
  end;
  inherited;
end;

procedure TNMMain.wmEndSession(var msg : TMessage);
begin
  SaveAllData;
  inherited;
end;

procedure TNMMain.wmEraseBkgnd(var msg : TMessage);
begin
  //Suppress execution of WM_ERASEBKGND to avoid flickering
end;

procedure TNMMain.OptionsExecute(Sender: TObject);
begin
  Options.Enabled := FALSE;
  NMOptions := TNMOptions.Create(Self);
  Application.NormalizeAllTopMosts;
  try
    if NMOptions.ShowModal = mrOK then ApplyOptions.Execute;
  finally
    NMOptions.Free;
  end;
  Application.RestoreTopMosts;
  Options.Enabled := TRUE;
end;

procedure TNMMain.TotalsExecute(Sender: TObject);
begin
  Totals.Enabled := FALSE;
  NMTotals := TNMTotals.Create(Self);
  Application.NormalizeAllTopMosts;
  try
    NMTotals.ShowModal;
  finally
    NMTotals.Free;
  end;
  Application.RestoreTopMosts;
  Totals.Enabled := TRUE;
end;

procedure TNMMain.AboutExecute(Sender: TObject);
begin
  About.Enabled := FALSE;
  NMAbout := TNMAbout.Create(Self);
  Application.NormalizeAllTopMosts;
  try
    NMAbout.ShowModal;
  finally
    NMAbout.Free;
  end;
  Application.RestoreTopMosts;
  About.Enabled := TRUE;
end;

procedure TNMMain.FormActivate(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TNMMain.NMTrayClick(Sender: TObject);

function IsObscured(wnd : HWND) : boolean;
var
  r_mywin, r_other, r_temp : TRect;
  w : HWND;
begin
  result := FALSE;
  GetWindowRect(wnd, r_mywin);
  w := wnd;
  repeat
    begin
      w := GetNextWindow(w, GW_HWNDPREV);
      if IsWindowVisible(w) then
        begin
          GetWindowRect(w, r_other);
          if IntersectRect(r_temp, r_mywin, r_other) then
            result := TRUE;
        end;
    end
  until w = 0;
end;

begin
  if not(NMMain.Visible) then
    begin
      ShowMeter(TRUE);
      NMMain.Invalidate;
    end
  else
    begin
      if IsObscured(NMMain.Handle) then
        SetForegroundWindow(NMMain.Handle)
      else
        HideMeter;
    end;
end;

procedure TNMMain.SetConstraints;
begin
  NMMain.Constraints.MinWidth  := FRM_MinWidth;
  NMMain.Constraints.MinHeight := FRM_MinHeight;
  NMMain.Constraints.MaxWidth  := NMGR.Constraints.MaxWidth + ( NMMain.Width - NMMain.ClientWidth );
end;

procedure TNMMain.ApplyOpts(init : boolean = FALSE);
var
  tdwo : TDayAndWeekOffset;
  tc : TTrafficLimitRec;
  fstyle : longint;
  i : integer;
begin
  with NMO_TMP do
    begin

      if AlwaysOnTop then
        begin
          if NMMain.FormStyle <> fsStayOnTop then NMMain.FormStyle := fsStayOnTop;
        end
      else
        begin
          if NMMain.FormStyle <> fsNormal then NMMain.FormStyle := fsNormal;
        end;

      if ShowCaption then
        begin
          NMMain.BorderStyle := bsToolWindow;
          NMMain.BorderStyle := bsSizeToolWin;
        end
      else
        begin
          NMMain.BorderStyle := bsToolWindow;
          NMMain.BorderStyle := bsSizeToolWin;

          fstyle := GetWindowLong( NMMain.Handle, GWL_STYLE );
          SetWindowLong( NMMain.Handle, GWL_STYLE, fstyle and ( not( WS_CAPTION ) ) or WS_BORDER );
          NMMain.Height := NMMain.Height + getSystemMetrics( SM_CYCAPTION );
          NMMain.Height := NMMain.Height - getSystemMetrics( SM_CYCAPTION );
        end;

      SetConstraints;

      //Minimize when idle stuff
      MWI_IsIdle := not(NMMain.Visible);
      MWI_WaitCounter := 0;

      //Snap to screen edges stuff
      //NMMain.ScreenSnap := SnapToScreenEdges;

      //Transparency stuff
      NMMain.AlphaBlendValue := TransparencyValue;
      NMMain.AlphaBlend      := TransparencyEnabled;

      //Click through stuff
      fstyle := GetWindowLong( NMMain.Handle, GWL_EXSTYLE );
      if TransparencyEnabled and ClickThrough then
        SetWindowLong( NMMain.Handle, GWL_EXSTYLE, fstyle or WS_EX_TRANSPARENT )
      else
        if ( fstyle or WS_EX_TRANSPARENT ) <> 0 then
          SetWindowLong( NMMain.Handle, GWL_EXSTYLE, fstyle and not WS_EX_TRANSPARENT );

      //Mouse sensitive fading stuff
      MF_CursorIsOnForm := MouseWithinGraphWindow;
      MF_WaitCounter := 0;

      //Autorunner stuff
      if RunOnStartup <> GetRunOnStartup then
        begin
          case GetRunOnStartup of
            FALSE : SetRunOnStartup;
            TRUE : DeleteRunOnStartup;
          end;
        end;
    end;

  //Init IF stats when IF has changed or program is being started
  if ( NMO_TMP.IFToMonitor <> NMO.IFToMonitor )
  or ( NMO_TMP.IFDescription <> NMO.IFDescription )
  or init then
    with NMIC do
      begin
        InterfaceToMonitor := NMO_TMP.IFToMonitor;
        InterfaceDescription := NMO_TMP.IFDescription;
        InterfaceMAC := NMO_TMP.IFMAC;
        Init;
      end;

  NMO := NMO_TMP;

  NMGR.Colors := NMO_TMP.Color;

  with NMGR.Options do
    begin
      with FontUD do
        begin
          Name := NMO_TMP.FontUD.Name;
          Size := NMO_TMP.FontUD.Size;
          Bold := NMO_TMP.FontUD.Bold;
          Italic := NMO_TMP.FontUD.Italic;
        end;
      with FontMV do
        begin
          Name := NMO_TMP.FontMV.Name;
          Size := NMO_TMP.FontMV.Size;
          Bold := NMO_TMP.FontMV.Bold;
          Italic := NMO_TMP.FontMV.Italic;
        end;
      FontAutosize := NMO_TMP.FontAutosize;
      Autoscale := NMO_TMP.Autoscale;
      ShowHorGrid := NMO_TMP.ShowHorGrid;
      ShowPanel := NMO_TMP.ShowPanel;
      ShowPanelTotals := NMO_TMP.ShowPanelTotals;
      ShowMaxValue := NMO_TMP.ShowMaxValue;
      UseGradient := NMO_TMP.Gradient;
      GraphVertGrid := NMO_TMP.VertGrid;
    end;

  NMTIG.AutoScale := NMO_TMP.Autoscale;
  NMTIG.UseAverageValues := NMO_TMP.DisplayAverageValues;

  with NMTL do
    begin
      with tdwo do
        begin
          WeekStartsOn  := NMO.WeekStartsOn;
          MonthStartsOn := NMO.MonthStartsOn;
        end;
      DayAndWeekOffset := tdwo;
      ClearTrafficLimits;
      for i := Low(NMO.Notify) to High(NMO.Notify) do
      begin
        with tc do
          begin
            Value   := NMO.Notify[i].TrafficLimit;
            TLUnit  := NMO.Notify[i].TrafficLimitUnit;
            ULorDL  := NMO.Notify[i].TrafficLimitULorDL;
            Period  := NMO.Notify[i].TrafficLimitPeriod;
            Enabled := NMO.Notify[i].TVAlertEnabled;
            Notify  := @NMO.Notify[i];
            FWarningLevelReached := FALSE;
            FTrafficLimitReached := FALSE;
          end;
        TrafficLimitAdd(tc);
      end;

      AutosaveEnabled  := NMO.LogfileAutosaveEnabled;
      AutosaveInterval := NMO.LogfileAutosaveMinutes;
    end;

  if not init then NMMain.Invalidate;

  MF_Timer_RefreshState;

  WriteIniFile;
end;

procedure TNMMain.ApplyOptionsExecute(Sender: TObject);
begin
  ApplyOpts;
end;

procedure TNMMain.ExitProgramExecute(Sender: TObject);
begin
  Close;
end;

procedure TNMMain.LeftClickMoveWindow(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    begin
      ReleaseCapture;
      NMMain.Perform(WM_SYSCOMMAND,$F012,0);
    end;
end;

procedure TNMMain.FG_TimerProc(Sender: TObject);
begin
  case FG_Type of

    FG_FadeOut :
      begin
        if (NMMain.AlphaBlendValue - FG_Step) >= 0 then
          NMMain.AlphaBlendValue := NMMain.AlphaBlendValue - FG_Step
        else
          begin
            NMMain.AlphaBlendValue := 0;
            FG_Timer.Enabled := FALSE;

            DoHideMeter;
            HideShowRestore;
          end;
      end;

    FG_FadeIn :
      begin
        if (NMMain.AlphaBlendValue + FG_Step) <= NMO.TransparencyValue then
          NMMain.AlphaBlendValue := NMMain.AlphaBlendValue + FG_Step
        else
          begin
            NMMain.AlphaBlendValue := NMO.TransparencyValue;
            FG_Timer.Enabled := FALSE;

            HideShowRestore;
          end;
      end;

    FG_FadeFull :
      begin
        if (NMMain.AlphaBlendValue + FG_Step) <= 255 then
          NMMain.AlphaBlendValue := NMMain.AlphaBlendValue + FG_Step
        else
          begin
            NMMain.AlphaBlendValue := 255;
            FG_Timer.Enabled := FALSE;
          end;
      end;

    FG_FadeDownToNormal :
      begin
        if (NMMain.AlphaBlendValue - FG_Step) >= NMO.TransparencyValue then
          NMMain.AlphaBlendValue := NMMain.AlphaBlendValue - FG_Step
        else
          begin
            NMMain.AlphaBlendValue := NMO.TransparencyValue;
            FG_Timer.Enabled := FALSE;
          end;
      end;

    FG_FadeLow :
      begin
        if (NMMain.AlphaBlendValue - FG_Step) >= (NMO.TransparencyValue div 3) then
          NMMain.AlphaBlendValue := NMMain.AlphaBlendValue - FG_Step
        else
          begin
            NMMain.AlphaBlendValue := (NMO.TransparencyValue div 3);
            FG_Timer.Enabled := FALSE;
          end;
      end;

    FG_FadeUpToNormal :
      begin
        if (NMMain.AlphaBlendValue + FG_Step) <= NMO.TransparencyValue then
          NMMain.AlphaBlendValue := NMMain.AlphaBlendValue + FG_Step
        else
          begin
            NMMain.AlphaBlendValue := NMO.TransparencyValue;
            FG_Timer.Enabled := FALSE;
          end;
      end;

  end;
end;

procedure TNMMain.HideShowBlock;
begin
  ShowMeterAction.Enabled := FALSE;
  HideMeterAction.Enabled := FALSE;
end;

procedure TNMMain.HideShowRestore;
begin
  ShowMeterAction.Enabled := not(NMMain.Visible);
  HideMeterAction.Enabled := NMMain.Visible;
end;

procedure TNMMain.DoShowMeter;
var
  h : hWnd;
begin
  CheckMainFormPosition;

  h := GetForeGroundWindow;
  NMMain.Visible := TRUE;

  ShowWindow(Application.Handle, SW_HIDE);

  if BringToFront then
    SetForegroundWindow( NMMain.Handle )
  else
    SetForegroundWindow( h );

  MWI_IsIdle := FALSE;
  MWI_WaitCounter := 0;

  MF_Timer_RefreshState;
end;

procedure TNMMain.DoHideMeter;
begin
  NMMain.Visible := FALSE;
  ShowWindow(Application.Handle, SW_HIDE);

  MWI_IsIdle := TRUE;
  MWI_WaitCounter := 0;

  MF_Timer_RefreshState;
end;

procedure TNMMain.ShowMeter;
begin
  if not(NMMain.Visible) then
    begin
      if NMMain.AlphaBlend and NMO.FadingEnabled then
        FadeGraph(FG_FadeIn, BringToFront)
      else
        begin
          DoShowMeter(BringToFront);
          HideShowRestore;
        end;
    end;
end;

procedure TNMMain.HideMeter;
begin
  if NMMain.Visible then
    begin
      if NMMain.AlphaBlend and NMO.FadingEnabled then
        FadeGraph(FG_FadeOut, FALSE)
      else
        begin
          DoHideMeter;
          HideShowRestore;
        end;
    end;
end;

procedure TNMMain.ShowMeterActionExecute(Sender: TObject);
begin
  ShowMeter(TRUE);
end;

procedure TNMMain.HideMeterActionExecute(Sender: TObject);
begin
  HideMeter;
end;

procedure TNMMain.FadeGraph( FGT : integer; BringToFront : boolean );
begin
  FG_Timer.Enabled := FALSE;

  FG_Timer.Interval := FG_IntervalDef;
  FG_Step := FG_StepDef;
  FG_Type := FGT;

  case FG_Type of
    FG_FadeIn :
      begin
        HideShowBlock;
        AlphaBlendValue := 0;
        DoShowMeter(BringToFront);
      end;
    FG_FadeOut :
      begin
        HideShowBlock;
      end;
  end;

  FG_Timer.Enabled := TRUE;
end;

procedure TNMMain.MF_TimerProc(Sender: TObject);
var
  MF_WaitCounterMax,
  MF_ActionRunning : integer;

begin
  if (MF_CursorIsOnForm = MouseWithinGraphWindow) then
    begin

      if NMO.MouseFadingIn then
        begin
          if MF_CursorIsOnForm then
            begin
              MF_ActionRunning  := MA_FadeFull;
              MF_WaitCounterMax := MF_FadeFullTimeToWait;
            end
          else
            begin
              MF_ActionRunning  := MA_FadeDownToNormal;
              MF_WaitCounterMax := MF_FadeDownToNormalTimeToWait;
            end
        end
      else
        begin
          if MF_CursorIsOnForm then
            begin
              MF_ActionRunning  := MA_FadeLow;
              MF_WaitCounterMax := MF_FadeLowTimeToWait;
            end
          else
            begin
              MF_ActionRunning  := MA_FadeUpToNormal;
              MF_WaitCounterMax := MF_FadeUpToNormalTimeToWait;
            end
        end;

      if (MF_WaitCounter + 1) <= MF_WaitCounterMax then
        inc(MF_WaitCounter)
      else
        if not(FG_Timer.Enabled) then
          begin

            case MF_ActionRunning of

              MA_FadeLow :
                if NMMain.AlphaBlendValue > (NMO.TransparencyValue div 3) then
                  begin
                    FadeGraph( FG_FadeLow, FALSE );
                    MF_WaitCounter := 0;
                  end;

              MA_FadeUpToNormal :
                if NMMain.AlphaBlendValue < NMO.TransparencyValue then
                  begin
                    FadeGraph( FG_FadeUpToNormal, FALSE );
                    MF_WaitCounter := 0;
                  end;

              MA_FadeFull :
                if NMMain.AlphaBlendValue < 255 then
                  begin
                    FadeGraph( FG_FadeFull, FALSE );
                    MF_WaitCounter := 0;
                  end;

              MA_FadeDownToNormal :
                if NMMain.AlphaBlendValue > NMO.TransparencyValue then
                  begin
                    FadeGraph( FG_FadeDownToNormal, FALSE);
                    MF_WaitCounter := 0;
                  end;

            end;

          end;
    end
  else
     begin
      MF_WaitCounter := 0;
      MF_CursorIsOnForm := not(MF_CursorIsOnForm);
    end;

end;

end.

