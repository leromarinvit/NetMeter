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

unit NetMeterTotals;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, DateUtils, SimpleTimer,
  NetMeterGlobal, NetMeterGraph;

type
  TNMTotals = class(TForm)
    PageControl1: TPageControl;
    TotalsTab: TTabSheet;
    DailyTab: TTabSheet;
    WeeklyTab: TTabSheet;
    MonthlyTab: TTabSheet;
    ListViewDaily: TListView;
    ListViewWeekly: TListView;
    ListViewMonthly: TListView;
    GroupBox1: TGroupBox;
    ULValue_Label: TLabel;
    ULPeekValue_Label: TLabel;
    ULPeek_Label: TLabel;
    UL_Label: TLabel;
    UDValue_Label: TLabel;
    UD_Label: TLabel;
    DLValue_Label: TLabel;
    DLPeekValue_Label: TLabel;
    DLPeek_Label: TLabel;
    DL_Label: TLabel;
    Bevel3: TBevel;
    ULAvgValue_Label: TLabel;
    ULAvg_Label: TLabel;
    DLAvgValue_Label: TLabel;
    DLAvg_Label: TLabel;
    Bevel9: TBevel;
    UDAvg_Label: TLabel;
    UDAvgValue_Label: TLabel;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ULToday_Label: TLabel;
    DLToday_Label: TLabel;
    UDToday_Label: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ExportButton: TBitBtn;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ULThisWeek_Label: TLabel;
    DLThisWeek_Label: TLabel;
    UDThisWeek_Label: TLabel;
    GroupBox4: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    ULThisMonth_Label: TLabel;
    DLThisMonth_Label: TLabel;
    UDThisMonth_Label: TLabel;
    GroupBox5: TGroupBox;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    ULTotal_Label: TLabel;
    DLTotal_Label: TLabel;
    UDTotal_Label: TLabel;
    SaveDialog1: TSaveDialog;
    ProjectedTab: TTabSheet;
    GroupBox6: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Bevel1: TBevel;
    ULThisWeek2_Label: TLabel;
    DLThisWeek2_Label: TLabel;
    UDThisWeek2_Label: TLabel;
    ULThisWeekProj_Label: TLabel;
    DLThisWeekProj_Label: TLabel;
    UDThisWeekProj_Label: TLabel;
    GroupBox7: TGroupBox;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Bevel2: TBevel;
    ULThisMonth2_Label: TLabel;
    DLThisMonth2_Label: TLabel;
    UDThisMonth2_Label: TLabel;
    ULThisMonthProj_Label: TLabel;
    DLThisMonthProj_Label: TLabel;
    UDThisMonthProj_Label: TLabel;
    GroupBox8: TGroupBox;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Bevel4: TBevel;
    ULToday2_Label: TLabel;
    DLToday2_Label: TLabel;
    UDToday2_Label: TLabel;
    ULTodayProj_Label: TLabel;
    DLTodayProj_Label: TLabel;
    UDTodayProj_Label: TLabel;
    gb_TrafficVolumeLimit: TGroupBox;
    TVL_Used: TLabel;
    TVL_Left: TLabel;
    TVL_AvgLPD: TLabel;
    TVL_UsedValue: TLabel;
    TVL_LeftValue: TLabel;
    TVL_AvgLPDValue: TLabel;
    TVL_Limit: TLabel;
    TVL_LimitValue: TLabel;
    TVL_Projected: TLabel;
    TVL_ProjectedValue: TLabel;
    ImportButton: TBitBtn;
    OpenDialog1: TOpenDialog;
    ResetAllLogsBtn: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure ListViewCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ExportButtonClick(Sender: TObject);
    procedure ImportButtonClick(Sender: TObject);
    procedure ResetAllLogsBtnClick(Sender: TObject);
  private
    { Private declarations }
    RefreshTimer : TSimpleTimer;
    procedure ActivateEventHandlers;
    procedure DeactivateEventHandlers;
    procedure RefreshStats(Sender: TObject);
    procedure DailyRefresh;
    procedure WeeklyRefresh;
    procedure MonthlyRefresh;
    procedure TotalsRefresh;
    procedure TempLogRefresh(Sender: TObject);
    procedure TrafficLimitRefresh;
    procedure ProjectedRefresh;
    procedure DailyListInit(Sender: TObject);
    procedure DailyListUpdate(Sender: TObject);
    procedure WeeklyListInit(Sender: TObject);
    procedure WeeklyListUpdate(Sender: TObject);
    procedure MonthlyListInit(Sender: TObject);
    procedure MonthlyListUpdate(Sender: TObject);
  public
    { Public declarations }
  end;

var
  NMTotals: TNMTotals;

implementation

uses
  NetMeterMain, NetMeterTrafficLog;

{$R *.dfm}

procedure TNMTotals.ActivateEventHandlers;
begin
  with NMMain.NMTL do
    begin
      TempLog.OnChanged := TempLogRefresh;
      with Log[ lgDaily ] do
        begin
          OnEntryAdded          := DailyListInit;
          OnCurrentEntryChanged := DailyListUpdate;
        end;
      with Log[ lgWeekly ] do
        begin
          OnEntryAdded          := WeeklyListInit;
          OnCurrentEntryChanged := WeeklyListUpdate;
        end;
      with Log[ lgMonthly ] do
        begin
          OnEntryAdded          := MonthlyListInit;
          OnCurrentEntryChanged := MonthlyListUpdate;
        end;
    end;
end;

procedure TNMTotals.DeactivateEventHandlers;
begin
  with NMMain.NMTL do
    begin
      TempLog.OnChanged := nil;
      with Log[ lgDaily ] do
        begin
          OnEntryAdded          := nil;
          OnCurrentEntryChanged := nil;
        end;
      with Log[ lgWeekly ] do
        begin
          OnEntryAdded          := nil;
          OnCurrentEntryChanged := nil;
        end;
      with Log[ lgMonthly ] do
        begin
          OnEntryAdded          := nil;
          OnCurrentEntryChanged := nil;
        end;
    end;
end;

procedure TNMTotals.FormCreate(Sender: TObject);
begin
  ModifyFontsFor(self, NMMain.Font.Name);

  ListViewDaily.DoubleBuffered   := TRUE;
  ListViewWeekly.DoubleBuffered  := TRUE;
  ListViewMonthly.DoubleBuffered := TRUE;

  TempLogRefresh(self);
  DailyListInit(self);
  WeeklyListInit(self);
  MonthlyListInit(self);

  ActivateEventHandlers;

  RefreshTimer := TSimpleTimer.CreateEx( 1000, RefreshStats );
  RefreshTimer.Enabled := TRUE;
  RefreshStats(self);
end;

procedure TNMTotals.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  RefreshTimer.Free;

  DeactivateEventHandlers;
end;

procedure TNMTotals.RefreshStats(Sender: TObject);
begin
  TrafficLimitRefresh;
  ProjectedRefresh;
end;

procedure TNMTotals.DailyRefresh;
begin
  with NMMain.NMTL.Log[ lgDaily ].GetCurrentEntry do
    begin
      ULToday_Label.Caption := UDValueToStr(Upload,    NMO.TotalsDisplayUnit, NMO.UseOldDUDescription);
      DLToday_Label.Caption := UDValueToStr(Download,  NMO.TotalsDisplayUnit, NMO.UseOldDUDescription);
      UDToday_Label.Caption := UDValueToStr(UpAndDown, NMO.TotalsDisplayUnit, NMO.UseOldDUDescription);

      ULToday2_Label.Caption := ULToday_Label.Caption;
      DLToday2_Label.Caption := DLToday_Label.Caption;
      UDToday2_Label.Caption := UDToday_Label.Caption;
    end;
end;

procedure TNMTotals.WeeklyRefresh;
begin
  with NMMain.NMTL.Log[ lgWeekly ].GetCurrentEntry do
    begin
      ULThisWeek_Label.Caption := UDValueToStr(Upload,    NMO.TotalsDisplayUnit, NMO.UseOldDUDescription);
      DLThisWeek_Label.Caption := UDValueToStr(Download,  NMO.TotalsDisplayUnit, NMO.UseOldDUDescription);
      UDThisWeek_Label.Caption := UDValueToStr(UpAndDown, NMO.TotalsDisplayUnit, NMO.UseOldDUDescription);

      ULThisWeek2_Label.Caption := ULThisWeek_Label.Caption;
      DLThisWeek2_Label.Caption := DLThisWeek_Label.Caption;
      UDThisWeek2_Label.Caption := UDThisWeek_Label.Caption;
    end;
end;

procedure TNMTotals.MonthlyRefresh;
begin
  with NMMain.NMTL.Log[ lgMonthly ].GetCurrentEntry do
    begin
      ULThisMonth_Label.Caption := UDValueToStr(Upload,    NMO.TotalsDisplayUnit, NMO.UseOldDUDescription);
      DLThisMonth_Label.Caption := UDValueToStr(Download,  NMO.TotalsDisplayUnit, NMO.UseOldDUDescription);
      UDThisMonth_Label.Caption := UDValueToStr(UpAndDown, NMO.TotalsDisplayUnit, NMO.UseOldDUDescription);

      ULThisMonth2_Label.Caption := ULThisMonth_Label.Caption;
      DLThisMonth2_Label.Caption := DLThisMonth_Label.Caption;
      UDThisMonth2_Label.Caption := UDThisMonth_Label.Caption;
    end;
end;

procedure TNMTotals.TotalsRefresh;
var
  WholeUL,
  WholeDL,
  WholeUD : Int64;
  i : integer;
begin
  WholeUL := 0;
  WholeDL := 0;
  WholeUD := 0;
  with NMMain.NMTL do
    for i := Low( Log[ lgDaily ].Data ) to High( Log[ lgDaily ].Data ) do
      with Log[ lgDaily ].Data[ i ] do
        begin
          WholeUL := WholeUL + Upload;
          WholeDL := WholeDL + Download;
          WholeUD := WholeUD + UpAndDown;
        end;
  ULTotal_Label.Caption := UDValueToStr(WholeUL, NMO.TotalsDisplayUnit, NMO.UseOldDUDescription);
  DLTotal_Label.Caption := UDValueToStr(WholeDL, NMO.TotalsDisplayUnit, NMO.UseOldDUDescription);
  UDTotal_Label.Caption := UDValueToStr(WholeUD, NMO.TotalsDisplayUnit, NMO.UseOldDUDescription);
end;

procedure TNMTotals.TempLogRefresh(Sender: TObject);
var
  SecondsPassed,
  AvgUL,
  AvgDL,
  AvgUD : Int64;
begin
  with NMMain.NMTL.TempLog.Data do
    begin
      GroupBox1.Caption         := 'Data transferred since ' + DateTimeToStr(LastReset);
      ULValue_Label.Caption     := UDValueToStr(TotalUL, NMO.TotalsDisplayUnit, NMO.UseOldDUDescription);
      DLValue_Label.Caption     := UDValueToStr(TotalDL, NMO.TotalsDisplayUnit, NMO.UseOldDUDescription);
      UDValue_Label.Caption     := UDValueToStr(TotalUD, NMO.TotalsDisplayUnit, NMO.UseOldDUDescription);
      ULPeekValue_Label.Caption := UDValueToStr(MaxUL,   NMO.TotalsDisplayUnit, NMO.UseOldDUDescription) + LB_PerSec;
      DLPeekValue_Label.Caption := UDValueToStr(MaxDL,   NMO.TotalsDisplayUnit, NMO.UseOldDUDescription) + LB_PerSec;

      SecondsPassed := SecondsBetween(LastReset, Date);
      if SecondsPassed <= 0 then SecondsPassed := 1;
      AvgUL := Round( TotalUL / SecondsPassed );
      AvgDL := Round( TotalDL / SecondsPassed );
      AvgUD := Round( TotalUD / SecondsPassed );
      ULAvgValue_Label.Caption  := UDValueToStr(AvgUL, NMO.TotalsDisplayUnit, NMO.UseOldDUDescription) + LB_PerSec;
      DLAvgValue_Label.Caption  := UDValueToStr(AvgDL, NMO.TotalsDisplayUnit, NMO.UseOldDUDescription) + LB_PerSec;
      UDAvgValue_Label.Caption  := UDValueToStr(AvgUD, NMO.TotalsDisplayUnit, NMO.UseOldDUDescription) + LB_PerSec;
    end;
end;

procedure TNMTotals.TrafficLimitRefresh;
begin
  if NMO.TVAlertEnabled then
    begin
      gb_TrafficVolumeLimit.Enabled := TRUE;
      TVL_Limit.Enabled             := TRUE;
      TVL_Used.Enabled              := TRUE;
      TVL_Left.Enabled              := TRUE;
      TVL_Projected.Enabled         := TRUE;
      TVL_AvgLPD.Enabled            := TRUE;

      with NMMain.NMTL.TrafficLimitData do
        begin
          TVL_LimitValue.Font.Color := clTeal;

          if TrafficUsed >= TrafficLimit      then TVL_UsedValue.Font.Color      := clRed
                                              else TVL_UsedValue.Font.Color      := clTeal;

          if TrafficLeft <= 0                 then TVL_LeftValue.Font.Color      := clRed
                                              else TVL_LeftValue.Font.Color      := clTeal;

          if TrafficProjected >= TrafficLimit then TVL_ProjectedValue.Font.Color := clRed
                                              else TVL_ProjectedValue.Font.Color := clTeal;

          if AvgLeftPerDay <= 0               then TVL_AvgLPDValue.Font.Color    := clRed
                                              else TVL_AvgLPDValue.Font.Color    := clTeal;

          TVL_LimitValue.Caption     := UDValueToStr(TrafficLimit,     NMO.TotalsDisplayUnit, NMO.UseOldDUDescription);
          TVL_UsedValue.Caption      := UDValueToStr(TrafficUsed,      NMO.TotalsDisplayUnit, NMO.UseOldDUDescription);
          TVL_LeftValue.Caption      := UDValueToStr(TrafficLeft,      NMO.TotalsDisplayUnit, NMO.UseOldDUDescription);
          TVL_ProjectedValue.Caption := UDValueToStr(TrafficProjected, NMO.TotalsDisplayUnit, NMO.UseOldDUDescription);
          TVL_AvgLPDValue.Caption    := UDValueToStr(AvgLeftPerDay,    NMO.TotalsDisplayUnit, NMO.UseOldDUDescription);
        end;
    end
  else
    begin
      gb_TrafficVolumeLimit.Enabled  := FALSE;
      TVL_Limit.Enabled              := FALSE;
      TVL_Used.Enabled               := FALSE;
      TVL_Left.Enabled               := FALSE;
      TVL_Projected.Enabled          := FALSE;
      TVL_AvgLPD.Enabled             := FALSE;
      TVL_LimitValue.Font.Color      := clLtGray;
      TVL_UsedValue.Font.Color       := clLtGray;
      TVL_LeftValue.Font.Color       := clLtGray;
      TVL_ProjectedValue.Font.Color  := clLtGray;
      TVL_AvgLPDValue.Font.Color     := clLtGray;
      TVL_LimitValue.Caption         := LB_Empty;
      TVL_UsedValue.Caption          := LB_Empty;
      TVL_LeftValue.Caption          := LB_Empty;
      TVL_ProjectedValue.Caption     := LB_Empty;
      TVL_AvgLPDValue.Caption        := LB_Empty;
    end;
end;

procedure TNMTotals.ProjectedRefresh;
var
  cd, sd, ed : TDateTime;
begin with NMMain.NMTL do
begin
  cd := Now;

  with Log[ lgDaily ].GetCurrentEntry do
    begin
      sd := StartOfTheDay( cd );
      ed := EndOfTheDay  ( cd );

      ULTodayProj_Label.Caption := UDValueToStr( ProjectedValue(cd, sd, ed, Upload),    NMO.TotalsDisplayUnit, NMO.UseOldDUDescription);
      DLTodayProj_Label.Caption := UDValueToStr( ProjectedValue(cd, sd, ed, Download),  NMO.TotalsDisplayUnit, NMO.UseOldDUDescription);
      UDTodayProj_Label.Caption := UDValueToStr( ProjectedValue(cd, sd, ed, UpAndDown), NMO.TotalsDisplayUnit, NMO.UseOldDUDescription);
    end;

  with Log[ lgWeekly ].GetCurrentEntry do
    begin
      sd := StartOfWeek( cd );
      ed := EndOfWeek  ( cd );

      ULThisWeekProj_Label.Caption := UDValueToStr( ProjectedValue(cd, sd, ed, Upload),    NMO.TotalsDisplayUnit, NMO.UseOldDUDescription);
      DLThisWeekProj_Label.Caption := UDValueToStr( ProjectedValue(cd, sd, ed, Download),  NMO.TotalsDisplayUnit, NMO.UseOldDUDescription);
      UDThisWeekProj_Label.Caption := UDValueToStr( ProjectedValue(cd, sd, ed, UpAndDown), NMO.TotalsDisplayUnit, NMO.UseOldDUDescription);
    end;

  with Log[ lgMonthly ].GetCurrentEntry do
    begin
      sd := StartOfMonth( cd );
      ed := EndOfMonth  ( cd );

      ULThisMonthProj_Label.Caption := UDValueToStr( ProjectedValue(cd, sd, ed, Upload),    NMO.TotalsDisplayUnit, NMO.UseOldDUDescription);
      DLThisMonthProj_Label.Caption := UDValueToStr( ProjectedValue(cd, sd, ed, Download),  NMO.TotalsDisplayUnit, NMO.UseOldDUDescription);
      UDThisMonthProj_Label.Caption := UDValueToStr( ProjectedValue(cd, sd, ed, UpAndDown), NMO.TotalsDisplayUnit, NMO.UseOldDUDescription);
    end;
end;
end;

procedure TNMTotals.DailyListInit;
var
  i : integer;
  li : TListItem;
begin
  DailyRefresh;

  ListViewDaily.Items.BeginUpdate;
  ListViewDaily.Items.Clear;

  with NMMain.NMTL do
    begin
      ListViewDaily.AllocBy := High( Log[ lgDaily ].Data ) + 1;
      for i := High( Log[ lgDaily ].Data ) downto 0 do
        with Log[ lgDaily ].Data[i] do
          begin
            li := ListViewDaily.Items.Add;

            li.Caption := DateToStr( ReferenceDate );

            li.SubItems.Add( UDValueToStr( Upload,    NMO.TotalsDisplayUnit, NMO.UseOldDUDescription ) );
            li.SubItems.Add( UDValueToStr( Download,  NMO.TotalsDisplayUnit, NMO.UseOldDUDescription ) );
            li.SubItems.Add( UDValueToStr( UpAndDown, NMO.TotalsDisplayUnit, NMO.UseOldDUDescription ) );
          end;
    end;

  ListViewDaily.Items.EndUpdate;
end;

procedure TNMTotals.DailyListUpdate;
var
  i : integer;
  te : TLogEntryRec;
begin
  DailyRefresh;

  ListViewDaily.Items.BeginUpdate;

  with NMMain.NMTL do
    begin

      with Log[ lgDaily ] do
        begin
          i := ( ListViewDaily.Items.Count - 1 ) - CurrentDateIndex;
          te := GetCurrentEntry;
        end;

      ListViewDaily.Items[i].Caption     := DateToStr(te.ReferenceDate);

      ListViewDaily.Items[i].SubItems[0] := UDValueToStr(te.Upload,    NMO.TotalsDisplayUnit, NMO.UseOldDUDescription);
      ListViewDaily.Items[i].SubItems[1] := UDValueToStr(te.Download,  NMO.TotalsDisplayUnit, NMO.UseOldDUDescription);
      ListViewDaily.Items[i].SubItems[2] := UDValueToStr(te.UpAndDown, NMO.TotalsDisplayUnit, NMO.UseOldDUDescription);
    end;

  ListViewDaily.Items.EndUpdate;
end;

procedure TNMTotals.WeeklyListInit;
var
  i : integer;
  li : TListItem;
begin
  WeeklyRefresh;

  ListViewWeekly.Items.BeginUpdate;
  ListViewWeekly.Items.Clear;

  with NMMain.NMTL do
    begin
      ListViewWeekly.AllocBy := High( Log[ lgWeekly ].Data ) + 1;

      for i := High( Log[ lgWeekly ].Data ) downto 0 do
        with Log[ lgWeekly ].Data[ i ] do
          begin
            li := ListViewWeekly.Items.Add;
            li.Caption := DateToStr( StartOfWeek( ReferenceDate ) ) + ' - ' +
                          DateToStr( EndOfWeek  ( ReferenceDate ) );
            li.SubItems.Add( UDValueToStr( Upload,    NMO.TotalsDisplayUnit, NMO.UseOldDUDescription ) );
            li.SubItems.Add( UDValueToStr( Download,  NMO.TotalsDisplayUnit, NMO.UseOldDUDescription ) );
            li.SubItems.Add( UDValueToStr( UpAndDown, NMO.TotalsDisplayUnit, NMO.UseOldDUDescription ) );
          end;
    end;

  ListViewWeekly.Items.EndUpdate;
end;

procedure TNMTotals.WeeklyListUpdate;
var
  i : integer;
  te : TLogEntryRec;
begin
  WeeklyRefresh;

  ListViewWeekly.Items.BeginUpdate;

  with NMMain.NMTL do
    begin

      with Log[ lgWeekly ] do
        begin
          i := ( ListViewWeekly.Items.Count - 1 ) - CurrentDateIndex;
          te := GetCurrentEntry;
        end;

      ListViewWeekly.Items[ i ].Caption
        := DateToStr( StartOfWeek( te.ReferenceDate ) ) + ' - '
         + DateToStr( EndOfWeek  ( te.ReferenceDate ) );

      ListViewWeekly.Items[ i ].SubItems[0] := UDValueToStr( te.Upload,    NMO.TotalsDisplayUnit, NMO.UseOldDUDescription );
      ListViewWeekly.Items[ i ].SubItems[1] := UDValueToStr( te.Download,  NMO.TotalsDisplayUnit, NMO.UseOldDUDescription );
      ListViewWeekly.Items[ i ].SubItems[2] := UDValueToStr( te.UpAndDown, NMO.TotalsDisplayUnit, NMO.UseOldDUDescription );
    end;

  ListViewWeekly.Items.EndUpdate;
end;

procedure TNMTotals.MonthlyListInit;
var
  i : integer;
  li : TListItem;
  bd : TDateTime;
begin
  MonthlyRefresh;
  TotalsRefresh;

  ListViewMonthly.Items.BeginUpdate;
  ListViewMonthly.Items.Clear;

  with NMMain.NMTL do
    begin
      ListViewMonthly.AllocBy := High( Log[ lgMonthly ].Data ) + 1;
      for i := High( Log[ lgMonthly ].Data ) downto 0 do
        with Log[ lgMonthly ].Data[ i ] do
          begin
            li := ListViewMonthly.Items.Add;
            bd := StartOfMonth( ReferenceDate );

            li.Caption := LongMonthNames[ MonthOf( ReferenceDate ) ] + ' ' + IntToStr( YearOf( ReferenceDate ) );

            li.SubItems.Add(
              DateToStr( bd ) + ' - ' +
              DateToStr( EndOfMonth( ReferenceDate ) ) );

            li.SubItems.Add( UDValueToStr(Upload,    NMO.TotalsDisplayUnit, NMO.UseOldDUDescription ) );
            li.SubItems.Add( UDValueToStr(Download,  NMO.TotalsDisplayUnit, NMO.UseOldDUDescription ) );
            li.SubItems.Add( UDValueToStr(UpAndDown, NMO.TotalsDisplayUnit, NMO.UseOldDUDescription ) );
          end;
    end;

  ListViewMonthly.Items.EndUpdate;
end;

procedure TNMTotals.MonthlyListUpdate;
var
  i : integer;
  te : TLogEntryRec;
  bd : TDateTime;
begin
  MonthlyRefresh;
  TotalsRefresh;

  ListViewMonthly.Items.BeginUpdate;

  with NMMain.NMTL do
    begin

      with Log[ lgMonthly ] do
        begin
          i := ( ListViewMonthly.Items.Count - 1 ) - CurrentDateIndex;
          te := GetCurrentEntry;
        end;
      bd := StartOfMonth( te.ReferenceDate );

      ListViewMonthly.Items[i].Caption :=
        LongMonthNames[ MonthOf( bd ) ] + ' ' + IntToStr( YearOf( bd ) );

      ListViewMonthly.Items[i].SubItems[0] :=
        DateToStr( StartOfMonth( te.ReferenceDate ) ) + ' - ' +
        DateToStr( EndOfMonth  ( te.ReferenceDate ) );

      ListViewMonthly.Items[i].SubItems[1] := UDValueToStr( te.Upload,    NMO.TotalsDisplayUnit, NMO.UseOldDUDescription );
      ListViewMonthly.Items[i].SubItems[2] := UDValueToStr( te.Download,  NMO.TotalsDisplayUnit, NMO.UseOldDUDescription );
      ListViewMonthly.Items[i].SubItems[3] := UDValueToStr( te.UpAndDown, NMO.TotalsDisplayUnit, NMO.UseOldDUDescription );
    end;

  ListViewMonthly.Items.EndUpdate;
end;

procedure TNMTotals.ListViewCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  Sender.Canvas.Font.Style := [];
  if Item.Index mod 2 = 0 then
    Sender.Canvas.Brush.Color := $00FFF8F8
  else
    Sender.Canvas.Brush.Color := $00F0E0E0 //$00F8FFF8
end;

procedure TNMTotals.BitBtn2Click(Sender: TObject);
begin
  NMMain.NMTL.TempLog.Reset;
end;

procedure TNMTotals.ResetAllLogsBtnClick(Sender: TObject);
begin
  if MessageDlg( 'Are you really sure that you want to reset all logs? This action can''t be undone!', mtWarning, [mbYes, mbNo], 0 ) = mrYes then
    with NMMain do
      begin
        RefreshTimer.Enabled := FALSE;
        SuspendTimers;
        DeactivateEventHandlers;

        NMTL.ResetAllLogs;

        ActivateEventHandlers;
        ResumeTimers;
        RefreshTimer.Enabled := TRUE;

        RefreshStats(self);
        DailyListInit(self);
        WeeklyListInit(self);
        MonthlyListInit(self);
        MessageDlg( 'All traffic logs have been cleared!', mtInformation, [mbOK], 0 );
      end;
end;

procedure TNMTotals.ImportButtonClick(Sender: TObject);
var success : boolean;
begin
  if MessageDlg( 'Are you really sure that you want to import external logdata? This will overwrite all existing logdata!', mtWarning, [mbYes, mbNo], 0 ) = mrYes then
    if OpenDialog1.Execute then
      with NMMain do
        begin
          RefreshTimer.Enabled := FALSE;
          SuspendTimers;
          DeactivateEventHandlers;

          NMTL.CSVFileName := OpenDialog1.FileName;
          success := NMTL.CSVLoadFromFile;

          ActivateEventHandlers;
          ResumeTimers;
          RefreshTimer.Enabled := TRUE;

          if success then
            begin
              RefreshStats(self);
              DailyListInit(self);
              WeeklyListInit(self);
              MonthlyListInit(self);
              MessageDlg( 'Import was successful!', mtInformation, [mbOK], 0 );
            end;
        end;
end;

procedure TNMTotals.ExportButtonClick(Sender: TObject);
begin
  if SaveDialog1.Execute then
    with NMMain.NMTL do
      begin
        CSVFileName := SaveDialog1.FileName;
        CSVSaveToFile;
      end;
end;

end.
