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

unit NetMeterOptions;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, ExtCtrls, CheckLst,
  NetMeterGlobal, NetMeterIPHLP, NetMeterGraph;

type
  TNMOptions = class(TForm)
    ColorDialog1: TColorDialog;
    ChkRunOnStartup: TCheckBox;
    FontDialog1: TFontDialog;
    OKBtn: TBitBtn;
    ApplyBtn: TBitBtn;
    CancelBtn: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    NetIfGrp: TGroupBox;
    NetIfCombo: TComboBox;
    WindowPropGrp: TGroupBox;
    TV_PercentDisplay: TLabel;
    Bevel4: TBevel;
    ChkFadingEnabled: TCheckBox;
    ChkAlwaysOnTop: TCheckBox;
    ChkShowCaption: TCheckBox;
    ChkStartMinimized: TCheckBox;
    ChkMinimizeWhenIdle: TCheckBox;
    ChkTransparency: TCheckBox;
    TV_TrackBar: TTrackBar;
    ChkMouseFadingEnabled: TCheckBox;
    ChkDisplayAverage: TCheckBox;
    ChkCloseToTray: TCheckBox;
    RadioFadeout: TRadioButton;
    RadioFadein: TRadioButton;
    ChkClickThroughEnabled: TCheckBox;
    ChkScreenSnap: TCheckBox;
    GraphTabSheet: TTabSheet;
    ScalingPropGrp: TGroupBox;
    BWLabel: TLabel;
    BWCustomLabel1: TLabel;
    BWCustomLabel2: TLabel;
    ChkAutoscale: TCheckBox;
    BWCombo: TComboBox;
    BWCustom: TEdit;
    NumericalDisplayGrp: TGroupBox;
    Label1: TLabel;
    ChkUDDShow: TCheckBox;
    ChkTUDDShow: TCheckBox;
    ChkUDDShowMaxVal: TCheckBox;
    UDDUnitCombo: TComboBox;
    TUDDUnitCombo: TComboBox;
    MVDUnitCombo: TComboBox;
    GraphicalDisplayGrp: TGroupBox;
    VertGridLabel: TLabel;
    ChkGradientBkGr: TCheckBox;
    ChkShowHorGrid: TCheckBox;
    VertGridCombo: TComboBox;
    FontTabSheet: TTabSheet;
    FontPropGrp: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    UDFontPreview: TEdit;
    MVFontPreview: TEdit;
    UDFontSizePreview: TEdit;
    MVFontSizePreview: TEdit;
    ChkFontAutosize: TCheckBox;
    BitBtn1: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    ColorPropGrp: TGroupBox;
    Bevel2: TBevel;
    ColorPreview: TPaintBox;
    BitBtn2: TBitBtn;
    Button3: TButton;
    ColorCombo: TComboBox;
    TabSheet2: TTabSheet;
    PeriodsGroup: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MPCombo: TComboBox;
    WPCombo: TComboBox;
    TabSheet3: TTabSheet;
    NotificationGroup: TGroupBox;
    RadioBalloonHint: TRadioButton;
    RadioPopup: TRadioButton;
    TVAGroup: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    TLVEdit: TEdit;
    TLUCombo: TComboBox;
    TLUDCombo: TComboBox;
    TLPCombo: TComboBox;
    TVAEChk: TCheckBox;
    ChkMonProbNotify: TCheckBox;
    ChkUseOldDUDescriptions: TCheckBox;
    TotalsDisplayUnitGroup: TGroupBox;
    TDUCombo: TComboBox;
    TabSheet4: TTabSheet;
    RadioGroup1: TRadioGroup;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    LogautosaveGroup: TGroupBox;
    LogautosaveChk: TCheckBox;
    LogautosaveMinutes: TEdit;
    LogautosaveLabel1: TLabel;
    LogautosaveLabel2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ChkTransparencyClick(Sender: TObject);
    procedure ChkAlwaysOnTopClick(Sender: TObject);
    procedure ChkCloseToTrayClick(Sender: TObject);
    procedure ChkMinimizeWhenIdleClick(Sender: TObject);
    procedure ChkShowCaptionClick(Sender: TObject);
    procedure ChkStartMinimizedClick(Sender: TObject);
    procedure NetIfSelect(Sender: TObject);
    procedure ChkAutoscaleClick(Sender: TObject);
    procedure ChkShowHorGridClick(Sender: TObject);
    procedure BWComboSelect(Sender: TObject);
    procedure ApplyBtnClick(Sender: TObject);
    procedure ColorComboSelect(Sender: TObject);
    procedure ColorChangeBtnClick(Sender: TObject);
    procedure TV_TrackBarChange(Sender: TObject);
    procedure EditInvalidKeyPress(Sender: TObject; var Key: Char);
    procedure ChkUDDShowClick(Sender: TObject);
    procedure ChkUDDShowMaxValClick(Sender: TObject);
    procedure ChkFadingEnabledClick(Sender: TObject);
    procedure VertGridComboChange(Sender: TObject);
    procedure ChkMouseFadingEnabledClick(Sender: TObject);
    procedure ChkRunOnStartupClick(Sender: TObject);
    procedure BWCustomChange(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure ChkTUDDShowClick(Sender: TObject);
    procedure ColorResetClick(Sender: TObject);
    procedure ChangeUDLabelFontClick(Sender: TObject);
    procedure ChangeMVLabelFontClick(Sender: TObject);
    procedure FontResetClick(Sender: TObject);
    procedure ChkFontAutosizeClick(Sender: TObject);
    procedure ChkDisplayAverageClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure ChkGradientBkGrClick(Sender: TObject);
    procedure UDDUnitComboSelect(Sender: TObject);
    procedure TUDDUnitComboSelect(Sender: TObject);
    procedure MVDUnitComboSelect(Sender: TObject);
    procedure RadioFadeoutClick(Sender: TObject);
    procedure RadioFadeinClick(Sender: TObject);
    procedure ChkClickThroughEnabledClick(Sender: TObject);
    procedure ChkScreenSnapClick(Sender: TObject);
    procedure ColorPreviewPaint(Sender: TObject);
    procedure MPComboSelect(Sender: TObject);
    procedure WPComboSelect(Sender: TObject);
    procedure TLUDComboSelect(Sender: TObject);
    procedure TLUComboSelect(Sender: TObject);
    procedure TLPComboSelect(Sender: TObject);
    procedure TLVEditChange(Sender: TObject);
    procedure TVAEChkClick(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure RadioBalloonHintClick(Sender: TObject);
    procedure ChkMonProbNotifyClick(Sender: TObject);
    procedure ChkUseOldDUDescriptionsClick(Sender: TObject);
    procedure TDUComboSelect(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure LogautosaveMinutesChange(Sender: TObject);
    procedure LogautosaveChkClick(Sender: TObject);
  private
    { Private declarations }
    procedure OptionsChanged(b : boolean);
    procedure SetColorFromIdx(var ct : GR_ColorsType; idx, c : integer);
    function  GetColorFromIdx(var ct : GR_ColorsType; idx : integer) : integer;
    procedure ColorPreviewUpdate;
    procedure FontPreviewUpdate;
    procedure GraphOptionsRefresh;
  public
    { Public declarations }
  end;

var
  NMOptions: TNMOptions;

implementation

uses NetMeterMain;

{$R *.dfm}

var
  opts_changed : boolean;

procedure TNMOptions.OptionsChanged(b : boolean);
begin
  opts_changed := b;
  ApplyBtn.Enabled := opts_changed;
end;

procedure TNMOptions.SetColorFromIdx(var ct : GR_ColorsType; idx, c : integer);
begin
  with ct do
  case idx of
    0 : MV_Border := c;
    1 : MV_BkGr := c;
    2 : MV_Font := c;
    3 : PN_Border := c;
    4 : PN_BkGr := c;
    5 : PN_UL := c;
    6 : PN_DL := c;
    7 : GR_Border := c;
    8 : GR_BkGr1 := c;
    9 : GR_BkGr2 := c;
    10 : GR_Grid := c;
    11 : GR_Upload := c;
    12 : GR_Download := c;
    13 : GR_UpDn := c;
  end;
end;

function TNMOptions.GetColorFromIdx(var ct : GR_ColorsType; idx : integer) : integer;
var i : integer;
begin
  i := 0;
  with ct do
  case idx of
    0 : i := MV_Border;
    1 : i := MV_BkGr;
    2 : i := MV_Font;
    3 : i := PN_Border;
    4 : i := PN_BkGr;
    5 : i := PN_UL;
    6 : i := PN_DL;
    7 : i := GR_Border;
    8 : i := GR_BkGr1;
    9 : i := GR_BkGr2;
    10 : i := GR_Grid;
    11 : i := GR_Upload;
    12 : i := GR_Download;
    13 : i := GR_UpDn;
  end;
  result := i;
end;

procedure TNMOptions.GraphOptionsRefresh;
var i : integer;
begin
  with BWCombo do
    begin
      for i := 0 to High(BW_Values) do
        if BW_Values[i] = NMO_TMP.Bandwidth then ItemIndex := i;
      if ItemIndex = -1 then ItemIndex := High(BW_Values);
    end;

  with VertGridCombo do
    for i := 0 to High(VertGrid_Values) do
      if VertGrid_Values[i] = NMO_TMP.VertGrid then ItemIndex := i;

  for i := 0 to 3 do
    begin
      if DisplayUnit_Values[i] = NMO_TMP.UDDisplayUnit     then UDDUnitCombo.ItemIndex  := i;
      if DisplayUnit_Values[i] = NMO_TMP.TUDDisplayUnit    then TUDDUnitCombo.ItemIndex := i;
      if DisplayUnit_Values[i] = NMO_TMP.MVDisplayUnit     then MVDUnitCombo.ItemIndex  := i;
      if DisplayUnit_Values[i] = NMO_TMP.TotalsDisplayUnit then TDUCombo.ItemIndex      := i;
    end;

  ChkAutoScale.Checked := NMO_TMP.AutoScale;
  BWCombo.Enabled := not(ChkAutoScale.Checked);
  BWLabel.Enabled := BWCombo.Enabled;
  BWCustom.Enabled := BWCombo.Enabled and ( BW_Values[ BWCombo.ItemIndex ] = BW_Custom );
  if BWCustom.Enabled then
    BWCustom.Text := IntToStr(NMO_TMP.Bandwidth)
  else
    BWCustom.Text := Zero;
  BWCustomLabel1.Enabled := BWCustom.Enabled;
  BWCustomLabel2.Enabled := BWCustom.Enabled;

  ChkShowHorGrid.Checked := NMO_TMP.ShowHorGrid;
  ChkUDDShow.Checked := NMO_TMP.ShowPanel;
  ChkTUDDShow.Checked := NMO_TMP.ShowPanelTotals;
  ChkUDDShowMaxVal.Checked := NMO_TMP.ShowMaxValue;

  ChkGradientBkGr.Checked := NMO_TMP.Gradient;

  ColorPreview.Color := GetColorFromIdx(NMO_TMP.Color, ColorCombo.ItemIndex);

  FontPreviewUpdate;
  ChkFontAutosize.Checked := NMO_TMP.FontAutosize;
end;

procedure TNMOptions.LogautosaveChkClick(Sender: TObject);
begin
  NMO_TMP.LogfileAutosaveEnabled := LogautoSaveChk.Checked;
  LogautoSaveMinutes.Enabled := LogautoSaveChk.Checked;
  LogautosaveLabel1.Enabled := LogautoSaveChk.Checked;
  LogautosaveLabel2.Enabled := LogautoSaveChk.Checked;
end;

procedure TNMOptions.LogautosaveMinutesChange(Sender: TObject);
var
  i,e : integer;
begin
  if LogAutosaveMinutes.Modified then
    begin
      Val(LogAutosaveMinutes.Text,i,e);
      if e = 0 then
        begin
          if i = 0 then
            NMO_TMP.LogfileAutosaveMinutes := 1
          else
            NMO_TMP.LogfileAutosaveMinutes := i;
        end
      else
        NMO_TMP.LogfileAutosaveMinutes := 5;

      if NMO_TMP.LogfileAutosaveMinutes <> i then
        LogAutosaveMinutes.Text := IntToStr( NMO_TMP.LogfileAutosaveMinutes );

      OptionsChanged(TRUE);
    end
end;

procedure TNMOptions.FormCreate(Sender: TObject);
var i : integer;
begin
  ModifyFontsFor(self, NMMain.Font.Name);

  NMO_TMP := NMO;

  with NMO_TMP do
    begin

      with NetIfCombo do
        begin
          Items.Add(IF_All_noLB_noDP_Str);
          Items.Add(IF_PPP_noDP_Str);

          with NMMain.NMIC do
            if NumInterfaces > 0 then
              for i := 0 to NumInterfaces - 1 do
                Items.Add( GetFormattedIFDescription( i, 77, TRUE ) );

          case IFToMonitor of
            IF_All_noLB_noDP : ItemIndex := 0;
            IF_PPP_noDP      : ItemIndex := 1;
            IF_Manual        :
              with NMMain.NMIC do
                if NumInterfaces > 0 then
                  begin
                    ItemIndex := LastMonitoredIFIndex;
                    if ItemIndex <> -1 then ItemIndex := 2 + ItemIndex;
                  end;
          end;
        end;

      with UDDUnitCombo do
        for i := 0 to 3 do
          Items.Add( DU_Unit[i].Name + ' (1 ' + DU_Unit[i].Symbol[DU_k].Shortcut + ' ' + DU_Unit[i].Symbol[DU_k].Equals + ')' );
      TUDDUnitCombo.Items := UDDUnitCombo.Items;
      MVDUnitCombo.Items  := UDDUnitCombo.Items;
      TDUCombo.Items      := UDDUnitCombo.Items;

      with MPCombo do
        for i := 1 to 31 do
          if i = MonthStartsOn then ItemIndex := i - 1;

      with WPCombo do
        for i := 1 to 7 do
          if i = WeekStartsOn then ItemIndex := i - 1;

      with TLUCombo do
        for i := 0 to 3 do
          if TrafficLimitUnit_Values[i] = TrafficLimitUnit then ItemIndex := i;

      with TLUDCombo do
        for i := 0 to High(TrafficLimitULorDL_Values) do
          if TrafficLimitULorDL_Values[i] = TrafficLimitULorDL then ItemIndex:=i;

      with TLPCombo do
        for i := 0 to High(TrafficLimitPeriod_Values) do
          if TrafficLimitPeriod_Values[i] = TrafficLimitPeriod then ItemIndex:=i;

      ChkAlwaysOnTop.Checked      := AlwaysOnTop;
      ChkShowCaption.Checked      := ShowCaption;
      ChkStartMinimized.Checked   := StartMinimized;
      ChkMinimizeWhenIdle.Checked := MinimizeWhenIdle;
      ChkDisplayAverage.Checked   := DisplayAverageValues;
      ChkCloseToTray.Checked      := CloseToTray;
      ChkScreenSnap.Checked       := SnapToScreenEdges;

      ChkUseOldDUDescriptions.Checked := UseOldDUDescription;

      RadioButton1.Checked := not UseOldTrayIcons;
      RadioButton2.Checked := not RadioButton1.Checked;

      if not(MinWinVersion(Win2k_or_newer)) then
        begin
          ChkTransparency.Enabled := FALSE;
          RadioBalloonHint.Enabled := FALSE;
        end;

      ChkTransparency.Checked        := TransparencyEnabled;
      TV_PercentDisplay.Caption      := IntToStr( Round( TransparencyValue / 2.55 ) ) + ' % visible';
      TV_TrackBar.Position           := TransparencyValue;
      ChkClickThroughEnabled.Checked := ClickThrough;
      ChkFadingEnabled.Checked       := FadingEnabled;
      ChkMouseFadingEnabled.Checked  := MouseFadingEnabled;
      RadioFadein.Checked            := MouseFadingIn;
      RadioFadeout.Checked           := not(MouseFadingIn);

      TV_PercentDisplay.Enabled      := ChkTransparency.Checked;
      TV_TrackBar.Enabled            := ChkTransparency.Checked;
      ChkClickThroughEnabled.Enabled := ChkTransparency.Checked;
      ChkFadingEnabled.Enabled       := ChkTransparency.Checked;
      ChkMouseFadingEnabled.Enabled  := ChkTransparency.Checked and ChkFadingEnabled.Checked;
      RadioFadein.Enabled            := ChkTransparency.Checked and ChkFadingEnabled.Checked and ChkMouseFadingEnabled.Checked;
      RadioFadeout.Enabled           := ChkTransparency.Checked and ChkFadingEnabled.Checked and ChkMouseFadingEnabled.Checked;

      ChkRunOnStartup.Checked := RunOnStartup;

      RadioBalloonHint.Checked := TrayIcon_BalloonHints;
      RadioPopup.Checked := not(TrayIcon_BalloonHints);
      ChkMonProbNotify.Checked := NotifyMonitoringProblems;

      TVAEChk.Checked := TVAlertEnabled;
      Label10.Enabled := TVAEChk.Checked;
      Label11.Enabled := TVAEChk.Checked;
      Label12.Enabled := TVAEChk.Checked;
      TLUDCombo.Enabled := TVAEChk.Checked;
      TLVEdit.Enabled := TVAEChk.Checked;
      TLUCombo.Enabled := TVAEChk.Checked;
      TLPCombo.Enabled := TVAEChk.Checked;
      TLVEdit.Text := IntToStr(TrafficLimit);

      LogautoSaveChk.Checked := LogfileAutosaveEnabled;
      LogautoSaveMinutes.Enabled := LogautoSaveChk.Checked;
      LogautoSaveMinutes.Text := IntToStr(LogfileAutosaveMinutes);
      LogautosaveLabel1.Enabled := LogautoSaveChk.Checked;
      LogautosaveLabel2.Enabled := LogautoSaveChk.Checked;
    end;

  GraphOptionsRefresh;

  OptionsChanged(FALSE);
end;

procedure TNMOptions.ChkTransparencyClick(Sender: TObject);
begin
  NMO_TMP.TransparencyEnabled := ChkTransparency.Checked;

  TV_PercentDisplay.Enabled      := ChkTransparency.Checked;
  TV_TrackBar.Enabled            := ChkTransparency.Checked;
  ChkClickThroughEnabled.Enabled := ChkTransparency.Checked;
  ChkFadingEnabled.Enabled       := ChkTransparency.Checked;
  ChkMouseFadingEnabled.Enabled  := ChkTransparency.Checked and ChkFadingEnabled.Checked;
  RadioFadein.Enabled            := ChkTransparency.Checked and ChkFadingEnabled.Checked and ChkMouseFadingEnabled.Checked;
  RadioFadeout.Enabled           := ChkTransparency.Checked and ChkFadingEnabled.Checked and ChkMouseFadingEnabled.Checked;

  OptionsChanged(TRUE);
end;

procedure TNMOptions.ChkAlwaysOnTopClick(Sender: TObject);
begin
  NMO_TMP.AlwaysOnTop := ChkAlwaysOnTop.Checked;
  OptionsChanged(TRUE);
end;

procedure TNMOptions.ChkCloseToTrayClick(Sender: TObject);
begin
  NMO_TMP.CloseToTray := ChkCloseToTray.Checked;
  OptionsChanged(TRUE);
end;

procedure TNMOptions.ChkMinimizeWhenIdleClick(Sender: TObject);
begin
  NMO_TMP.MinimizeWhenIdle := ChkMinimizeWhenIdle.Checked;
  OptionsChanged(TRUE);
end;

procedure TNMOptions.ChkShowCaptionClick(Sender: TObject);
begin
  NMO_TMP.ShowCaption := ChkShowCaption.Checked;
  OptionsChanged(TRUE);
end;

procedure TNMOptions.ChkStartMinimizedClick(Sender: TObject);
begin
  NMO_TMP.StartMinimized := ChkStartMinimized.Checked;
  OptionsChanged(TRUE);
end;

procedure TNMOptions.NetIfSelect(Sender: TObject);
begin
with NMMain do
begin
  with NetIfCombo do
    case ItemIndex of
      0 :
        begin
          NMO_TMP.IFToMonitor := IF_All_noLB_noDP;
          FillChar(NMO_TMP.IFDescription, SizeOf(NMO.IFDescription), #0);
          FillChar(NMO_TMP.IFMAC, SizeOf(NMO.IFMAC), 0);
        end;
      1 :
        begin
          NMO_TMP.IFToMonitor := IF_PPP_noDP;
          FillChar(NMO_TMP.IFDescription, SizeOf(NMO.IFDescription), #0);
          FillChar(NMO_TMP.IFMAC, SizeOf(NMO.IFMAC), 0);
        end;
    else
      begin
        NMO_TMP.IFToMonitor := IF_Manual;
        NMO_TMP.IFDescription := NMIC.GetIFDescription( ItemIndex - 2 );
        NMO_TMP.IFMAC := NMIC.GetIFMAC( ItemIndex - 2 )
      end;
    end;
  OptionsChanged(TRUE);
end;
end;

procedure TNMOptions.ChkAutoscaleClick(Sender: TObject);
begin
with NMMain do
begin
  NMO_TMP.Autoscale := ChkAutoScale.Checked;

  BWCombo.Enabled := not(ChkAutoScale.Checked);
  BWLabel.Enabled := BWCombo.Enabled;
  BWCustom.Enabled := BWCombo.Enabled and (BW_Values[BWCombo.ItemIndex] = BW_Custom);
  if not(BWCustom.Enabled) then BWCustom.Text := Zero;
  BWCustomLabel1.Enabled := BWCustom.Enabled;
  BWCustomLabel2.Enabled := BWCustom.Enabled;

  OptionsChanged(TRUE);
end;
end;

procedure TNMOptions.ChkShowHorGridClick(Sender: TObject);
begin
  NMO_TMP.ShowHorGrid := ChkShowHorGrid.Checked;
  OptionsChanged(TRUE);
end;

procedure TNMOptions.BWComboSelect(Sender: TObject);
var i,e : integer;
begin
  NMO_TMP.Bandwidth := BW_Values[BWCombo.ItemIndex];
  if NMO_TMP.Bandwidth = BW_Custom then
    begin
      Val(BWCustom.Text,i,e);
      if e = 0 then
        NMO_TMP.Bandwidth := i
      else
        begin
          NMO_TMP.Bandwidth := 0;
          BWCustom.Text := IntToStr(NMO_TMP.Bandwidth);
        end;
      BWCustom.Enabled := TRUE;
      BWCustomLabel1.Enabled := TRUE;
      BWCustomLabel2.Enabled := TRUE;
    end
  else
    begin
      BWCustom.Text := Zero;
      BWCustom.Enabled := FALSE;
      BWCustomLabel1.Enabled := FALSE;
      BWCustomLabel2.Enabled := FALSE;
    end;
  OptionsChanged(TRUE);
end;

procedure TNMOptions.ApplyBtnClick(Sender: TObject);
begin
  NMMain.ApplyOptions.Execute;
  OptionsChanged(FALSE);
end;

procedure TNMOptions.ColorPreviewUpdate;
begin
  ColorPreview.Color := GetColorFromIdx(NMO_TMP.Color, ColorCombo.ItemIndex);
end;

procedure TNMOptions.ColorComboSelect(Sender: TObject);
begin
  ColorPreviewUpdate;
end;

procedure TNMOptions.ColorChangeBtnClick(Sender: TObject);
begin
  ColorDialog1.Color := GetColorFromIdx(NMO_TMP.Color, ColorCombo.ItemIndex);
  ColorDialog1.Execute;
  SetColorFromIdx(NMO_TMP.Color, ColorCombo.ItemIndex, ColorDialog1.Color);
  ColorPreviewUpdate;
  OptionsChanged(TRUE);
end;

procedure TNMOptions.ColorResetClick(Sender: TObject);
begin
  NMO_TMP.Color := GR_DefColor;
  ColorPreviewUpdate;
  OptionsChanged(TRUE);
end;

procedure TNMOptions.TV_TrackBarChange(Sender: TObject);
begin
  NMO_TMP.TransparencyValue := TV_TrackBar.Position;
  TV_PercentDisplay.Caption := IntToStr(Round(NMO_TMP.TransparencyValue / 2.55)) + ' % visible';
  OptionsChanged(TRUE);
end;

procedure TNMOptions.EditInvalidKeyPress(Sender: TObject; var Key: Char);
begin
  if not( (Key in Digits) or (Key = Backspace) ) then key := #0;
end;

procedure TNMOptions.ChkUDDShowClick(Sender: TObject);
begin
  NMO_TMP.ShowPanel := ChkUDDShow.Checked;
  OptionsChanged(TRUE);
end;

procedure TNMOptions.ChkTUDDShowClick(Sender: TObject);
begin
  NMO_TMP.ShowPanelTotals := ChkTUDDShow.Checked;
  OptionsChanged(TRUE);
end;

procedure TNMOptions.ChkUDDShowMaxValClick(Sender: TObject);
begin
  NMO_TMP.ShowMaxValue := ChkUDDShowMaxVal.Checked;
  OptionsChanged(TRUE);
end;

procedure TNMOptions.ChkUseOldDUDescriptionsClick(Sender: TObject);
begin
  NMO_TMP.UseOldDUDescription := ChkUseOldDUDescriptions.Checked;
  OptionsChanged(TRUE);
end;

procedure TNMOptions.ChkFadingEnabledClick(Sender: TObject);
begin
  NMO_TMP.FadingEnabled := ChkFadingEnabled.Checked;

  ChkMouseFadingEnabled.Enabled  := ChkTransparency.Checked and ChkFadingEnabled.Checked;
  RadioFadein.Enabled            := ChkTransparency.Checked and ChkFadingEnabled.Checked and ChkMouseFadingEnabled.Checked;
  RadioFadeout.Enabled           := ChkTransparency.Checked and ChkFadingEnabled.Checked and ChkMouseFadingEnabled.Checked;

  OptionsChanged(TRUE);
end;

procedure TNMOptions.ChkMouseFadingEnabledClick(Sender: TObject);
begin
  NMO_TMP.MouseFadingEnabled := ChkMouseFadingEnabled.Checked;

  RadioFadein.Enabled  := ChkTransparency.Checked and ChkFadingEnabled.Checked and ChkMouseFadingEnabled.Checked;
  RadioFadeout.Enabled := ChkTransparency.Checked and ChkFadingEnabled.Checked and ChkMouseFadingEnabled.Checked;

  OptionsChanged(TRUE);
end;

procedure TNMOptions.VertGridComboChange(Sender: TObject);
begin
  NMO_TMP.VertGrid := VertGrid_Values[VertGridCombo.ItemIndex];
  OptionsChanged(TRUE);
end;

procedure TNMOptions.ChkRunOnStartupClick(Sender: TObject);
begin
  NMO_TMP.RunOnStartup := ChkRunOnStartup.Checked;
  OptionsChanged(TRUE);
end;

procedure TNMOptions.OKBtnClick(Sender: TObject);
begin
  if opts_changed then
    ModalResult := mrOK
  else
    ModalResult := mrCancel;
end;

procedure TNMOptions.FontPreviewUpdate;
begin
  with UDFontPreview do
    begin
      Font.Name := NMO_TMP.FontUD.Name;

      if NMO_TMP.FontUD.Bold   then Font.Style := Font.Style + [fsBold]   else Font.Style := Font.Style - [fsBold];
      if NMO_TMP.FontUD.Italic then Font.Style := Font.Style + [fsItalic] else Font.Style := Font.Style - [fsItalic];

      Text := Font.Name;
    end;

  with UDFontSizePreview do
    begin
      Text := IntToStr( NMO_TMP.FontUD.Size );
    end;

  with MVFontPreview do
    begin
      Font.Name := NMO_TMP.FontMV.Name;

      if NMO_TMP.FontMV.Bold   then Font.Style := Font.Style + [fsBold]   else Font.Style := Font.Style - [fsBold];
      if NMO_TMP.FontMV.Italic then Font.Style := Font.Style + [fsItalic] else Font.Style := Font.Style - [fsItalic];

      Text := Font.Name;
    end;

  with MVFontSizePreview do
    begin
      Text := IntToStr( NMO_TMP.FontMV.Size );
    end;
end;

procedure TNMOptions.ChangeUDLabelFontClick(Sender: TObject);
begin
  with NMO_TMP.FontUD do
    begin
      FontDialog1.Options := FontDialog1.Options - [fdTrueTypeOnly];

      FontDialog1.Font.Name := Name;
      FontDialog1.Font.Size := Size;

      if Bold   then FontDialog1.Font.Style := FontDialog1.Font.Style + [fsBold]   else FontDialog1.Font.Style := FontDialog1.Font.Style - [fsBold];
      if Italic then FontDialog1.Font.Style := FontDialog1.Font.Style + [fsItalic] else FontDialog1.Font.Style := FontDialog1.Font.Style - [fsItalic];

      FontDialog1.Execute;

      Name := FontDialog1.Font.Name;
      Size := FontDialog1.Font.Size;
      NMO_TMP.FontUD.Bold   := fsBold   in FontDialog1.Font.Style;
      NMO_TMP.FontUD.Italic := fsItalic in FontDialog1.Font.Style;

    end;
  FontPreviewUpdate;

  OptionsChanged(TRUE);
end;

procedure TNMOptions.ChangeMVLabelFontClick(Sender: TObject);
begin
  with NMO_TMP.FontMV do
    begin
      FontDialog1.Options := FontDialog1.Options + [fdTrueTypeOnly];

      FontDialog1.Font.Name := Name;
      FontDialog1.Font.Size := Size;

      if Bold   then FontDialog1.Font.Style := FontDialog1.Font.Style + [fsBold]   else FontDialog1.Font.Style := FontDialog1.Font.Style - [fsBold];
      if Italic then FontDialog1.Font.Style := FontDialog1.Font.Style + [fsItalic] else FontDialog1.Font.Style := FontDialog1.Font.Style - [fsItalic];

      FontDialog1.Execute;

      Name := FontDialog1.Font.Name;
      Size := FontDialog1.Font.Size;
      NMO_TMP.FontMV.Bold   := fsBold   in FontDialog1.Font.Style;
      NMO_TMP.FontMV.Italic := fsItalic in FontDialog1.Font.Style;

    end;
  FontPreviewUpdate;

  OptionsChanged(TRUE);
end;

procedure TNMOptions.FontResetClick(Sender: TObject);
begin
  with NMO_TMP do
    begin
      FontUD.Name   := DefFontUDName;
      FontUD.Size   := DefFontUDSize;
      FontUD.Bold   := FALSE;
      FontUD.Italic := FALSE;
      FontMV.Name   := DefFontMVName;
      FontMV.Size   := DefFontMVSize;
      FontMV.Bold   := FALSE;
      FontMV.Italic := FALSE;
    end;
  FontPreviewUpdate;
  OptionsChanged(TRUE);
end;

procedure TNMOptions.ChkFontAutosizeClick(Sender: TObject);
begin
  NMO_TMP.FontAutosize := ChkFontAutosize.Checked;
  OptionsChanged(TRUE);
end;

procedure TNMOptions.ChkDisplayAverageClick(Sender: TObject);
begin
  NMO_TMP.DisplayAverageValues := ChkDisplayAverage.Checked;
  OptionsChanged(TRUE);
end;

procedure TNMOptions.CancelBtnClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TNMOptions.ChkGradientBkGrClick(Sender: TObject);
begin
  NMO_TMP.Gradient := ChkGradientBkGr.Checked;
  OptionsChanged(TRUE);
end;

procedure TNMOptions.UDDUnitComboSelect(Sender: TObject);
begin
  NMO_TMP.UDDisplayUnit := DisplayUnit_Values[UDDUnitCombo.ItemIndex];
  OptionsChanged(TRUE);
end;

procedure TNMOptions.TUDDUnitComboSelect(Sender: TObject);
begin
  NMO_TMP.TUDDisplayUnit := DisplayUnit_Values[TUDDUnitCombo.ItemIndex];
  OptionsChanged(TRUE);
end;

procedure TNMOptions.MVDUnitComboSelect(Sender: TObject);
begin
  NMO_TMP.MVDisplayUnit := DisplayUnit_Values[MVDUnitCombo.ItemIndex];
  OptionsChanged(TRUE);
end;

procedure TNMOptions.RadioFadeoutClick(Sender: TObject);
begin
  NMO_TMP.MouseFadingIn := not(RadioFadeout.Checked);
  OptionsChanged(TRUE);
end;

procedure TNMOptions.RadioFadeinClick(Sender: TObject);
begin
  NMO_TMP.MouseFadingIn := RadioFadein.Checked;
  OptionsChanged(TRUE);
end;

procedure TNMOptions.ChkClickThroughEnabledClick(Sender: TObject);
begin
  NMO_TMP.ClickThrough := ChkClickThroughEnabled.Checked;
  OptionsChanged(TRUE);
end;

procedure TNMOptions.ChkScreenSnapClick(Sender: TObject);
begin
  NMO_TMP.SnapToScreenEdges := ChkScreenSnap.Checked;
  OptionsChanged(TRUE);
end;

procedure TNMOptions.ColorPreviewPaint(Sender: TObject);
begin
  with ColorPreview do
    begin
      Canvas.Brush.Color := Color;
      Canvas.FillRect(ClientRect);
    end;
end;

procedure TNMOptions.MPComboSelect(Sender: TObject);
begin
  NMO_TMP.MonthStartsOn := MPCombo.ItemIndex + 1;
  OptionsChanged(TRUE);
end;

procedure TNMOptions.WPComboSelect(Sender: TObject);
begin
  NMO_TMP.WeekStartsOn := WPCombo.ItemIndex + 1;
  OptionsChanged(TRUE);
end;

procedure TNMOptions.TLUDComboSelect(Sender: TObject);
begin
  NMO_TMP.TrafficLimitULorDL := TrafficLimitULorDL_Values[TLUDCombo.ItemIndex];
  OptionsChanged(TRUE);
end;

procedure TNMOptions.TLUComboSelect(Sender: TObject);
begin
  NMO_TMP.TrafficLimitUnit := TrafficLimitUnit_Values[TLUCombo.ItemIndex];
  OptionsChanged(TRUE);
end;

procedure TNMOptions.TLPComboSelect(Sender: TObject);
begin
  NMO_TMP.TrafficLimitPeriod := TrafficLimitPeriod_Values[TLPCombo.ItemIndex];
  OptionsChanged(TRUE);
end;

procedure TNMOptions.BWCustomChange(Sender: TObject);
var
  i,e : integer;
begin
  if BWCustom.Modified then
    begin
      Val(BWCustom.Text,i,e);
      if e = 0 then
        NMO_TMP.Bandwidth := i
      else
        begin
          NMO_TMP.Bandwidth := 0;
          BWCustom.Text := Zero;
        end;
      OptionsChanged(TRUE);
    end
end;

procedure TNMOptions.TLVEditChange(Sender: TObject);
var
  i,e : integer;
begin
  if TLVEdit.Modified then
    begin
      Val(TLVEdit.Text,i,e);
      if e = 0 then
        NMO_TMP.TrafficLimit := i
      else
        begin
          NMO_TMP.TrafficLimit := 0;
          TLVEdit.Text := Zero;
        end;
      OptionsChanged(TRUE);
    end
end;

procedure TNMOptions.TVAEChkClick(Sender: TObject);
begin
  NMO_TMP.TVAlertEnabled := TVAEChk.Checked;
  Label10.Enabled := TVAEChk.Checked;
  Label11.Enabled := TVAEChk.Checked;
  Label12.Enabled := TVAEChk.Checked;
  TLUDCombo.Enabled := TVAEChk.Checked;
  TLVEdit.Enabled := TVAEChk.Checked;
  TLUCombo.Enabled := TVAEChk.Checked;
  TLPCombo.Enabled := TVAEChk.Checked;

  OptionsChanged(TRUE);
end;

procedure TNMOptions.TabControl1Change(Sender: TObject);
begin
  GraphOptionsRefresh;
end;

procedure TNMOptions.TDUComboSelect(Sender: TObject);
begin
  NMO_TMP.TotalsDisplayUnit := DisplayUnit_Values[TDUCombo.ItemIndex];
  OptionsChanged(TRUE);
end;

procedure TNMOptions.RadioBalloonHintClick(Sender: TObject);
begin
  NMO_TMP.TrayIcon_BalloonHints := RadioBalloonHint.Checked;
  OptionsChanged(TRUE);
end;

procedure TNMOptions.ChkMonProbNotifyClick(Sender: TObject);
begin
  NMO_TMP.NotifyMonitoringProblems := ChkMonProbNotify.Checked;
  OptionsChanged(TRUE);
end;

procedure TNMOptions.RadioButton1Click(Sender: TObject);
begin
  NMO_TMP.UseOldTrayIcons := FALSE;
  OptionsChanged(TRUE);
end;

procedure TNMOptions.RadioButton2Click(Sender: TObject);
begin
  NMO_TMP.UseOldTrayIcons := TRUE;
  OptionsChanged(TRUE);
end;

end.
