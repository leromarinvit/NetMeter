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

unit NetMeterTrafficLog;

interface

uses
  Classes, SysUtils, DateUtils, Types, Dialogs, SimpleTimer;

const
  TLG_HeaderSignature : integer = $4C544D4E;

  TLG_LoadOK        = 0;
  TLG_SaveOK        = 1;
  TLG_CreatedNewOne = 2;
  TLG_ReadError     = -1;
  TLG_WriteError    = -2;
  TLG_HeaderInvalid = -3;

  TLG_LoadSaveErrMsg : array[-3..-1] of string = (
    'Header of logfile "%s" is invalid!',
    'Error writing logfile "%s"!',
    'Error reading logfile "%s"!' );

  TLG_CSVSeparator = ',';
  TLG_CSVHeader    = 'Date'     + TLG_CSVSeparator +
                     'Download' + TLG_CSVSeparator +
                     'Upload';

  TLG_CSVLoadOK        = 0;
  TLG_CSVSaveOK        = 1;
  TLG_CSVReadError     = -1;
  TLG_CSVWriteError    = -2;
  TLG_CSVHeaderInvalid = -3;
  TLG_CSVLineInvalid   = -4;

  TLG_CSVLoadSaveErrMsg : array[-4..-1] of string = (
    'Error reading line from "%s"!',
    'Header of "%s" is invalid!',
    'Error writing to "%s"!',
    'Error reading from "%s"!' );

  TL_Megabytes = 0;
  TL_Mebibytes = 1;
  TL_Gigabytes = 2;
  TL_Gibibytes = 3;

  TL_UpAndDown    = 0;
  TL_UploadOnly   = 1;
  TL_DownloadOnly = 2;

  TL_Day   = 0;
  TL_Week  = 1;
  TL_Month = 2;

  TL_Nothing = 0;
  TL_Warning = 1;
  TL_Reached = 2;

  TL_Msg : array[1..2] of string = (
    'If the current trend continues, you will exceed your traffic limit!',
    'Your traffic limit has been reached!' );

type
  TLogEntryRec = record
    ReferenceDate : TDateTime;
    Upload,
    Download,
    UpAndDown : Int64;
  end;
  TLogEntries = array of TLogEntryRec;

  TTrafficLog = class(TObject)
  private
    FCurrentDateIndex : integer;
    FData : TLogEntries;
    FOnEntryAdded : TNotifyEvent;
    FOnCurrentEntryChanged : TNotifyEvent;
    FOnChanged : TNotifyEvent;
    procedure Reset;
  public
    constructor Create;
    function SetDateIndex( AValue : TDateTime ) : boolean;
    procedure Add( NewEntryDate : TDateTime; NewEntryUpload, NewEntryDownload : Int64 );
    function GetCurrentEntry : TLogEntryRec;
    property CurrentDateIndex : integer read FCurrentDateIndex;
    property Data : TLogEntries read FData;
    property OnEntryAdded : TNotifyEvent read FOnEntryAdded write FOnEntryAdded;
    property OnCurrentEntryChanged : TNotifyEvent read FOnCurrentEntryChanged write FOnCurrentEntryChanged;
  protected
    procedure EntryAdded; virtual;
    procedure CurrentEntryChanged; virtual;
    procedure Changed; virtual;
  end;

  TLogType = (lgDaily, lgWeekly, lgMonthly);
  TAllTrafficLogs = array[ TLogType ] of TTrafficLog;

  TTempLogRec = record
    LastReset : TDateTime;
    TotalUL,
    TotalDL,
    TotalUD,
    MaxUL,
    MaxDL : Int64;
  end;

  TTempTrafficLog = class(TObject)
  private
    FData : TTempLogRec;
    FOnChanged : TNotifyEvent;
  public
    constructor Create;
    procedure Add( NewEntryDate : TDateTime; NewEntryUpload, NewEntryDownload : Int64 );
    procedure Reset;
    property Data : TTempLogRec read FData;
    property OnChanged : TNotifyEvent read FOnChanged write FOnChanged;
  protected
    procedure Changed; virtual;
  end;

  TLoadSaveErrorProc =
    procedure( Sender: TObject; const msg : integer; var retry : boolean ) of object;

  TTrafficLimitRec = record
    Value,
    TLUnit,
    ULorDL,
    Period : Integer;
    Enabled : boolean;
    Notify : Pointer;
    FWarningLevelReached,
    FTrafficLimitReached : boolean;
  end;

  TTrafficCounterRec = record
    TrafficLimit,
    TrafficUsed,
    TrafficLeft,
    TrafficProjected,
    AvgLeftPerDay : Int64;
  end;

  TTrafficLimitWarningProc = procedure(Sender: TObject; const msg : integer; const n : Pointer) of object;

  TDayAndWeekOffset = record
    WeekStartsOn,
    MonthStartsOn : integer;
  end;

  TCSVLoadSaveErrorProc =
    procedure( Sender: TObject; const msg : integer; var retry : boolean ) of object;

  TTrafficLogs = class(TObject)
  private
    FDayAndWeekOffset : TDayAndWeekOffset;
    FLog : TAllTrafficLogs;
    FTempLog : TTempTrafficLog;
    FFileName : string;
    FOnLoadSaveError : TLoadSaveErrorProc;
    FSavingInProgress : boolean;
    FAutosaveTimer : TSimpleTimer;
    FAutosaveEnabled : boolean;
    FAutosaveInterval : cardinal;
    FOnTrafficLimitWarning : TTrafficLimitWarningProc;
    FTrafficLimitEnabled : boolean;
    FTrafficLimit : array of TTrafficLimitRec;
    FTrafficLimitData : TTrafficCounterRec;
    //CSV import/export
    FCSVFileName : string;
    FOnCSVLoadSaveError : TCSVLoadSaveErrorProc;
    //end CSV
    procedure SetAutosaveEnabled( NewStatus : boolean );
    procedure SetAutosaveInterval( NewInterval : cardinal );
    procedure AutosaveTimerProc( Sender : TObject );
    procedure SetTrafficLimitEnabled( NewStatus : boolean );
    procedure TrafficLimitReset;
    procedure SetTrafficLimit( NewLimit : TTrafficLimitRec );
    procedure CheckTrafficLimit( Sender : TObject );
    function GetTrafficLimit ( Index : integer ) : TTrafficLimitRec;
  public
    constructor Create;
    destructor Destroy; override;
    procedure ResetAllLogs;
    procedure Add( NewEntryDate : TDateTime; NewEntryUpload, NewEntryDownload : Int64 );
    procedure SyncLogs;
    procedure SetDayAndWeekOffset( NewOffset : TDayAndWeekOffset );
    procedure LoadFromFile;
    procedure SaveToFile;
    procedure TrafficLimitAdd( tl : TTrafficLimitRec );
    procedure ClearTrafficLimits;
    //CSV stuff
    function CSVLoadFromFile : boolean;
    procedure CSVSaveToFile;
    //end CSV
    function StartOfWeek ( AValue : TDateTime ) : TDateTime;
    function EndOfWeek   ( AValue : TDateTime ) : TDateTime;
    function StartOfMonth( AValue : TDateTime ) : TDateTime;
    function EndOfMonth  ( AValue : TDateTime ) : TDateTime;
    function ProjectedValue( CurrentDate, StartDate, EndDate : TDateTime; AValue : Int64 ) : Int64;
    function AverageLeftPerDay( CurrentDate, EndDate : TDateTime; TrafficLeft : Int64 ) : Int64;
    property DayAndWeekOffset : TDayAndWeekOffset read FDayAndWeekOffset write SetDayAndWeekOffset;
    property Log : TAllTrafficLogs read FLog;
    property TempLog : TTempTrafficLog read FTempLog;
    property FileName : string read FFileName write FFileName;
    property AutosaveEnabled : boolean read FAutosaveEnabled write SetAutosaveEnabled;
    property AutosaveInterval : cardinal read FAutosaveInterval write SetAutosaveInterval;
    property TrafficLimitEnabled : boolean read FTrafficLimitEnabled write SetTrafficLimitEnabled;
    property TrafficLimit[Index : integer] : TTrafficLimitRec read GetTrafficLimit;// write SetTrafficLimit;
    property TrafficLimitData : TTrafficCounterRec read FTrafficLimitData;
    property OnLoadSaveError : TLoadSaveErrorProc read FOnLoadSaveError write FOnLoadSaveError;
    property OnTrafficLimitWarning : TTrafficLimitWarningProc read FOnTrafficLimitWarning write FOnTrafficLimitWarning;
    //CSV stuff
    property CSVFileName : string read FCSVFileName write FCSVFileName;
    property OnCSVLoadSaveError : TCSVLoadSaveErrorProc read FOnCSVLoadSaveError write FOnCSVLoadSaveError;
    //end CSV
  protected
    procedure LoadSaveError( const msg : integer; var retry : boolean ); virtual;
    procedure TrafficLimitWarning( const msg : integer; const n : Pointer ); virtual;
    //CSV stuff
    procedure CSVLoadSaveError( const msg : integer; var retry : boolean ); virtual;
    //end CSV
  end;

implementation

uses NetMeterGlobal;

procedure TTrafficLog.Reset;
begin
  SetLength( FData, 1 );
  with FData[ 0 ] do
    begin
      ReferenceDate := 2.75; { = EncodeDate( 1900, 1, 1 ) }
      Upload        := 0;
      Download      := 0;
      UpAndDown     := 0;
    end;
  FCurrentDateIndex := 0;
end;

constructor TTrafficLog.Create;
begin
  inherited Create;
  Reset;
end;

function TTrafficLog.SetDateIndex( AValue : TDateTime ) : boolean;
var
  i : integer;
  match : boolean;
begin
  i := High( FData );

  match := FALSE;
  repeat
    if SameDate( AValue, FData[ i ].ReferenceDate ) then
      match := TRUE
    else
      dec( i );
  until match or ( i < 0 );

  if match then
    FCurrentDateIndex := i
  else
    FCurrentDateIndex := -1;

  result := match;
end;

procedure TTrafficLog.Add( NewEntryDate : TDateTime; NewEntryUpload, NewEntryDownload : Int64 );
var
  i : integer;
  match, ne, ce : boolean;
begin
  if not SetDateIndex( NewEntryDate ) then
    begin
      ne := TRUE;

      i := High( FData ) + 1;

      match := FALSE;
      repeat
        if CompareDate( NewEntryDate, FData[ i - 1 ].ReferenceDate ) = LessThanValue then
          dec( i )
        else
          match := TRUE;
      until match or ( i = 0 );

      if FData[ 0 ].ReferenceDate <> 2.75 { = EncodeDate( 1900, 1, 1 ) } then
        begin
          FCurrentDateIndex := i;
          SetLength( FData, Length( FData ) + 1 );
          for i := High( FData ) downto ( FCurrentDateIndex + 1 ) do
            FData[ i ] := FData[ i - 1 ];
        end
      else
        FCurrentDateIndex := 0;

      FData[ FCurrentDateIndex ].ReferenceDate := NewEntryDate;
    end
  else
    ne := FALSE;

  with FData[ FCurrentDateIndex ] do
    if ( NewEntryUpload    > 0 ) or
       ( NewEntryDownload  > 0 ) then
      begin
        ce := TRUE;
        Inc( Upload,    NewEntryUpload    );
        Inc( Download,  NewEntryDownload  );
        Inc( UpAndDown, NewEntryUpload + NewEntryDownload);
      end
    else
      ce := FALSE;

  if ne then EntryAdded
  else
    if ce then CurrentEntryChanged;

  if ne or ce then Changed;
end;

function TTrafficLog.GetCurrentEntry : TLogEntryRec;
begin
  Result := FData[ FCurrentDateIndex ]
end;

procedure TTrafficLog.EntryAdded;
begin
  if Assigned(FOnEntryAdded) then
    FOnEntryAdded(self);
end;

procedure TTrafficLog.CurrentEntryChanged;
begin
  if Assigned(FOnCurrentEntryChanged) then
    FOnCurrentEntryChanged(self);
end;

procedure TTrafficLog.Changed;
begin
  if Assigned(FOnChanged) then
    FOnChanged(self);
end;

constructor TTempTrafficLog.Create;
begin
  inherited Create;
end;

procedure TTempTrafficLog.Add( NewEntryDate : TDateTime; NewEntryUpload, NewEntryDownload : Int64 );
begin
  if ( NewEntryUpload   <> 0 ) or
     ( NewEntryDownload <> 0 ) then
    with FData do
      begin
        Inc( TotalUL, NewEntryUpload    );
        Inc( TotalDL, NewEntryDownload  );
        Inc( TotalUD, NewEntryUpload + NewEntryDownload );
        if NewEntryUpload   > MaxUL then MaxUL := NewEntryUpload;
        if NewEntryDownload > MaxDL then MaxDL := NewEntryDownload;
        Changed;
      end;
end;

procedure TTempTrafficLog.Reset;
begin
  with FData do
    begin
      LastReset := Now;
      TotalUL   := 0;
      TotalDL   := 0;
      TotalUD   := 0;
      MaxUL     := 0;
      MaxDL     := 0;
    end;
  Changed;
end;

procedure TTempTrafficLog.Changed;
begin
  if Assigned(FOnChanged) then
    FOnChanged(self);
end;

procedure TTrafficLogs.SetAutosaveEnabled( NewStatus : boolean );
begin
  if NewStatus <> FAutosaveEnabled then
    begin
      FAutosaveEnabled       := NewStatus;
      FAutosaveTimer.Enabled := FAutosaveEnabled;
    end;
end;

procedure TTrafficLogs.SetAutosaveInterval( NewInterval : cardinal );
begin
  if NewInterval <> FAutosaveInterval then
    begin
      FAutosaveInterval       := NewInterval;
      FAutosaveTimer.Interval := FAutosaveInterval * 60000 {1 Minute};
    end;
end;

procedure TTrafficLogs.AutosaveTimerProc( Sender : TObject );
begin
  SaveToFile;
end;

procedure TTrafficLogs.SetTrafficLimitEnabled( NewStatus : boolean );
begin
  if NewStatus <> FTrafficLimitEnabled then
    begin
      FTrafficLimitEnabled := NewStatus;
      if FTrafficLimitEnabled then
        begin
          Log[ lgDaily ].FOnChanged := CheckTrafficLimit;
          TrafficLimitReset;
        end
      else
        Log[ lgDaily ].FOnChanged := nil;
    end;
end;

procedure TTrafficLogs.TrafficLimitReset;
var
  i : integer;
begin
  with FTrafficLimitData do
    begin
      TrafficLimit     := 0;
      TrafficUsed      := 0;
      TrafficLeft      := 0;
      TrafficProjected := 0;
      AvgLeftPerDay    := 0;
    end;
  for i := Low(FTrafficLimit) to High(FTrafficLimit) do
    with FTrafficLimit[i] do
      begin
        FWarningLevelReached := FALSE;
        FTrafficLimitReached := FALSE;
        if Enabled then CheckTrafficLimit(self);
      end;
end;

procedure TTrafficLogs.SetTrafficLimit( NewLimit : TTrafficLimitRec );
var
  i : integer;
begin
  for i := Low(FTrafficLimit) to High(FTrafficLimit) do
  with FTrafficLimit[i] do
    if ( NewLimit.Value  <> Value  ) or
       ( NewLimit.TLUnit <> TLUnit ) or
       ( NewLimit.ULorDL <> ULorDL ) or
       ( NewLimit.Period <> Period ) then
      begin
        FTrafficLimit[i] := NewLimit;
        TrafficLimitReset;
      end;
end;

procedure TTrafficLogs.LoadSaveError( const msg : integer; var retry : boolean );
begin
  if Assigned(FOnLoadSaveError) then
    FOnLoadSaveError(self, msg, retry);
end;

procedure TTrafficLogs.TrafficLimitWarning( const msg : integer; const n : Pointer );
begin
  if Assigned(FOnTrafficLimitWarning) then
    FOnTrafficLimitWarning(self, msg, n);
end;

procedure TTrafficLogs.CSVLoadSaveError( const msg : integer; var retry : boolean );
begin
  if Assigned(FOnCSVLoadSaveError) then
    FOnCSVLoadSaveError(self, msg, retry);
end;

procedure TTrafficLogs.ResetAllLogs;
begin
  Log[ lgDaily ].Reset;
  SyncLogs;
  TrafficLimitReset;
end;

constructor TTrafficLogs.Create;
var
  i : integer;
begin
  inherited Create;

  with FDayAndWeekOffset do
    begin
      WeekStartsOn  := 1;
      MonthStartsOn := 1;
    end;

  FLog[ lgDaily   ] := TTrafficLog.Create;
  FLog[ lgWeekly  ] := TTrafficLog.Create;
  FLog[ lgMonthly ] := TTrafficLog.Create;

  FTempLog := TTempTrafficLog.Create;

  for i := Low(FTrafficLimit) to High(FTrafficLimit) do
  with FTrafficLimit[i] do
    begin
      Value  := 0;
      TLUnit := TL_Gibibytes;
      ULorDL := TL_UpAndDown;
      Period := TL_Month;
    end;
  TrafficLimitReset;

  FSavingInProgress  := FALSE;
  FAutosaveInterval := 5;
  FAutosaveTimer    := TSimpleTimer.CreateEx( FAutosaveInterval * 60000, AutosaveTimerProc );
  FAutosaveEnabled  := FAutosaveTimer.Enabled;
end;

destructor TTrafficLogs.Destroy;
begin
  FAutosaveTimer.Free;

  FTempLog.Free;

  FLog[ lgDaily   ].Free;
  FLog[ lgWeekly  ].Free;
  FLog[ lgMonthly ].Free;

  inherited Destroy;
end;

procedure TTrafficLogs.Add( NewEntryDate : TDateTime; NewEntryUpload, NewEntryDownload : Int64 );
begin
  FLog[ lgDaily   ].Add( NewEntryDate, NewEntryUpload, NewEntryDownload );
  FLog[ lgWeekly  ].Add( StartOfWeek( NewEntryDate ), NewEntryUpload, NewEntryDownload );
  FLog[ lgMonthly ].Add( StartOfMonth( NewEntryDate ), NewEntryUpload, NewEntryDownload );
  FTempLog.Add( NewEntryDate, NewEntryUpload, NewEntryDownload );
end;

procedure TTrafficLogs.SyncLogs;
var
  i : integer;
begin
  FLog[ lgWeekly  ].Reset;
  FLog[ lgMonthly ].Reset;
  for i := Low( FLog[ lgDaily ].FData ) to High( FLog[ lgDaily ].FData ) do
    with FLog[ lgDaily ].FData[ i ] do
      begin
        FLog[ lgWeekly  ].Add( StartOfWeek( ReferenceDate ), Upload, Download );
        FLog[ lgMonthly ].Add( StartOfMonth( ReferenceDate ), Upload, Download );
      end;
end;

procedure TTrafficLogs.SetDayAndWeekOffset( NewOffset : TDayAndWeekOffset );
begin
  with FDayAndWeekOffset do
    if ( NewOffset.WeekStartsOn  <> WeekStartsOn  ) or
       ( NewOffset.MonthStartsOn <> MonthStartsOn ) then
      begin
        FDayAndWeekOffset := NewOffset;
        SyncLogs;
      end;
end;

function TTrafficLogs.StartOfWeek( AValue : TDateTime ) : TDateTime;
begin
  with FDayAndWeekOffset do
    if DayOfTheWeek( AValue ) < WeekStartsOn then
      Result := IncDay( StartOfTheWeek( IncWeek( AValue, -1 ) ), WeekStartsOn - 1 )
    else
      Result := IncDay( StartOfTheWeek( AValue ), WeekStartsOn - 1 );
end;

function TTrafficLogs.EndOfWeek( AValue : TDateTime ) : TDateTime;
begin
  with FDayAndWeekOffset do
    if DayOfTheWeek( AValue ) < WeekStartsOn then
      Result := IncDay( EndOfTheWeek( IncWeek( AValue, -1 ) ), WeekStartsOn - 1 )
    else
      Result := IncDay( EndOfTheWeek( AValue ), WeekStartsOn - 1 );
end;

function TTrafficLogs.StartOfMonth( AValue : TDateTime ) : TDateTime;
begin
  with FDayAndWeekOffset do
    begin
      if DayOfTheMonth( AValue ) < MonthStartsOn then
        Result := IncDay( StartOfTheMonth( IncMonth( AValue, -1 ) ), MonthStartsOn - 1 )
      else
        Result := IncDay( StartOfTheMonth( AValue ), MonthStartsOn - 1 );
    end;
end;

function TTrafficLogs.EndOfMonth( AValue : TDateTime ) : TDateTime;
begin
  with FDayAndWeekOffset do
    begin
      if DayOfTheMonth( AValue ) < MonthStartsOn then
        Result := IncDay( EndOfTheMonth( IncMonth( AValue, -1 ) ), MonthStartsOn - 1 )
      else
        Result := IncDay( EndOfTheMonth( AValue ), MonthStartsOn - 1 );
    end;
end;

function TTrafficLogs.ProjectedValue( CurrentDate, StartDate, EndDate : TDateTime; AValue : Int64 ) : Int64;
var
  SecondsTotal,
  SecondsPassed : Int64;
begin
  SecondsTotal  := SecondsBetween( StartDate, EndDate );
  SecondsPassed := SecondsBetween( StartDate, CurrentDate );
  if SecondsPassed = 0 then
    Result := AValue
  else
    Result := Round( ( AValue / SecondsPassed ) * SecondsTotal );
end;

function TTrafficLogs.AverageLeftPerDay( CurrentDate, EndDate : TDateTime; TrafficLeft : Int64 ) : Int64;
var
  DaysLeft : Int64;
begin
  DaysLeft := DaysBetween( CurrentDate, EndDate ) + 1;
  if DaysLeft = 0 then
    Result := TrafficLeft
  else
    Result := Round( TrafficLeft / DaysLeft );
end;

procedure TTrafficLogs.CheckTrafficLimit;
var
  cd, sd, ed : TDateTime;
  tmp_e : TLogEntryRec;
  tmp_l,
  tmp_u : Int64;
  j : integer;
begin
for j := Low(FTrafficLimit) to High(FTrafficLimit) do
with FTrafficLimitData do
begin
  cd := Now;

  case FTrafficLimit[j].Period of
    TL_Day :
      begin
        sd    := StartOfTheDay( cd );
        ed    := EndOfTheDay  ( cd );
        tmp_e := FLog[ lgDaily ].GetCurrentEntry;
      end;
    TL_Week :
      begin
        sd    := StartOfWeek( cd );
        ed    := EndOfWeek  ( cd );
        tmp_e := FLog[ lgWeekly ].GetCurrentEntry;
      end;
    else
    //TL_Month
      begin
        sd    := StartOfMonth( cd );
        ed    := EndOfMonth  ( cd );
        tmp_e := FLog[ lgMonthly ].GetCurrentEntry;
      end;
  end;

  tmp_l := 0;
  case FTrafficLimit[j].TLUnit of
    TL_Megabytes : tmp_l := FTrafficLimit[j].Value * DU_Unit[DU_Kilobyte].Symbol[DU_m].Value;
    TL_Mebibytes : tmp_l := FTrafficLimit[j].Value * DU_Unit[DU_Kibibyte].Symbol[DU_m].Value;
    TL_Gigabytes : tmp_l := FTrafficLimit[j].Value * DU_Unit[DU_Kilobyte].Symbol[DU_g].Value;
    TL_Gibibytes : tmp_l := FTrafficLimit[j].Value * DU_Unit[DU_Kibibyte].Symbol[DU_g].Value;
  end;

  case FTrafficLimit[j].ULorDL of
    TL_UploadOnly   :
      tmp_u := tmp_e.Upload;
    TL_DownloadOnly :
      tmp_u := tmp_e.Download;
  else
  //TL_UpAndDown
    tmp_u := tmp_e.UpAndDown;
  end;

  TrafficLimit     := tmp_l;
  TrafficUsed      := tmp_u;
  TrafficLeft      := TrafficLimit - TrafficUsed;
  TrafficProjected := ProjectedValue( cd, sd, ed, TrafficUsed );
  AvgLeftPerDay    := AverageLeftPerDay( cd, ed, TrafficLeft );

  if TrafficUsed >= TrafficLimit then
    begin
      if not FTrafficLimit[j].FTrafficLimitReached then
        begin
          FTrafficLimit[j].FTrafficLimitReached := TRUE;
          TrafficLimitWarning(TL_Reached, FTrafficLimit[j].Notify);
        end;
    end
  else
    begin
      if TrafficProjected >= TrafficLimit then
        begin
          if not FTrafficLimit[j].FWarningLevelReached then
            begin
              FTrafficLimit[j].FWarningLevelReached := TRUE;
              TrafficLimitWarning(TL_Warning, FTrafficLimit[j].Notify);
            end;
        end
      else
        FTrafficLimit[j].FWarningLevelReached := FALSE;
    end;
end;
end;

procedure TTrafficLogs.LoadFromFile;
var
  ShouldRetry : boolean;
  Status : integer;

function DoLoad : integer;
var
  fs : TFileStream;
  Header, NumEntries, i : integer;
begin
  Result := TLG_LoadOK;

  FLog[ lgDaily ].Reset;
  FTempLog.Reset;

  try
    fs := TFileStream.Create( FFileName, fmOpenRead );
    try
      // read header signature
      fs.Read( Header, SizeOf( integer ) );
      if Header <> TLG_HeaderSignature then
        Result := TLG_HeaderInvalid
      else
        begin
          // read number of log entries
          fs.Read( NumEntries, SizeOf( integer ) );
          SetLength( FLog[ lgDaily ].FData, NumEntries );

          // read all log entries
          for i := 0 to NumEntries - 1 do
            with FLog[ lgDaily ] do
              begin
                fs.Read( FData[ i ], SizeOf( TLogEntryRec ) );
                with FData[ i ] do
                  UpAndDown := Upload + Download;
              end;

          // read temporary log data
          fs.Read( FTempLog.FData , SizeOf( TTempLogRec ) );
        end;
      fs.Free;
    except
      Result := TLG_ReadError;
      fs.Free;
    end;
  except
    Result := TLG_CreatedNewOne;
  end;

  FLog[ lgDaily ].Add( Date, 0, 0 );
  SyncLogs;
end;

begin
  repeat
    ShouldRetry := FALSE;
    Status := DoLoad;
    if Status < 0 then
      LoadSaveError( Status, ShouldRetry );
  until ShouldRetry = FALSE;
end;

procedure TTrafficLogs.SaveToFile;
var
  ShouldRetry : boolean;
  Status : integer;

function DoSave : integer;
var
  fs : TFileStream;
  NumEntries, i : integer;
begin
  Result := TLG_SaveOK;

  try
    fs := TFileStream.Create( FFileName, fmCreate );
    try
      // write header signature
      fs.Write( TLG_HeaderSignature, SizeOf( integer ) );

      // write number of log entries
      NumEntries := Length( FLog[ lgDaily ].FData );
      fs.Write( NumEntries, SizeOf( integer ) );

      // write all log entries
      for i := 0 to NumEntries - 1 do
        fs.Write( FLog[ lgDaily ].FData[ i ], SizeOf( TLogEntryRec ) );

      // write temporary log data
      fs.Write( FTempLog.FData, SizeOf( TTempLogRec ) );
      fs.Free;
    except
      Result := TLG_WriteError;
      fs.Free;
    end;
  except
    Result := TLG_WriteError;
  end;
end;

begin
  if FSavingInProgress then exit;
  FSavingInProgress := TRUE;

  repeat
    ShouldRetry := FALSE;
    Status := DoSave;
    if Status <> TLG_SaveOK then
      LoadSaveError( Status, ShouldRetry );
  until ShouldRetry = FALSE;

  FSavingInProgress := FALSE;
end;

function TTrafficLogs.CSVLoadFromFile : boolean;
var
  ShouldRetry : boolean;
  Status : integer;

function DoCSVLoad : integer;
var
  f : TextFile;
  tmp_importlog : TTrafficLogs;
  readbuffer : string;
  readstrings : TStringList;
  convbuffer : TLogEntryRec;
  abort : boolean;

  procedure Split(const Delimiter: Char; Input: string; const Strings: TStrings);
begin
  Assert( Assigned( Strings ) ) ;
  Strings.Clear;
  Strings.Delimiter := Delimiter;
  Strings.DelimitedText := Input;
end;

begin
  Result := TLG_CSVLoadOK;

  tmp_importlog := TTrafficLogs.Create;

  readstrings := TStringList.Create;

  try
    AssignFile( f, FCSVFileName );
    Reset( f );
    try
      ReadLn( f, readbuffer );
      if readbuffer <> TLG_CSVHeader then
        Result := TLG_CSVHeaderInvalid
      else
        begin
          abort := FALSE;
          repeat
            begin
              ReadLn( f, readbuffer );
              Split( TLG_CSVSeparator, readbuffer, readstrings );
              if readstrings.Count <> 3 then
                begin
                  abort := TRUE;
                  Result := TLG_CSVLineInvalid
                end
              else
                with convbuffer do
                  begin
                    try
                      ReferenceDate := StrToDate ( readstrings[0] );
                      Download      := StrToInt64( readstrings[1] );
                      Upload        := StrToInt64( readstrings[2] );
                    except
                      on EConvertError do
                        begin
                          abort := TRUE;
                          Result := TLG_CSVLineInvalid;
                        end;
                    end;
                    if not abort then tmp_importlog.Add( ReferenceDate, Upload, Download );
                  end;
            end;
          until EoF( f ) or abort;
        end;
      CloseFile( f );
    except
      Result := TLG_CSVReadError;
      CloseFile( f );
    end;
  except
    Result := TLG_CSVReadError;
  end;

  if Result = TLG_CSVLoadOK then
    begin
      ResetAllLogs;
      FLog[ lgDaily ].FData := tmp_importlog.Log[ lgDaily ].Data;
      FLog[ lgDaily ].Add( Date, 0, 0 );
      SyncLogs;
      TrafficLimitReset
    end;

  readstrings.Free;
  tmp_importlog.Free;
end;

begin
  repeat
    ShouldRetry := FALSE;
    Status := DoCSVLoad;
    if Status < 0 then
      CSVLoadSaveError( Status, ShouldRetry );
  until ShouldRetry = FALSE;
  Result := ( Status = 0 );
end;

procedure TTrafficLogs.CSVSaveToFile;
var
  ShouldRetry : boolean;
  Status : integer;

function DoCSVSave : integer;
var
  f : TextFile;
  NumEntries, i : integer;
begin
  Result := TLG_CSVSaveOK;

  try
    AssignFile( f, FCSVFileName );
    ReWrite( f );
    try
      // write header
      WriteLn( f, TLG_CSVHeader );

      // write all log entries
      NumEntries := Length( FLog[ lgDaily ].FData );
      for i := 0 to NumEntries - 1 do
        WriteLn( f, DateToStr( FLog[ lgDaily ].FData[ i ].ReferenceDate ) + TLG_CSVSeparator +
                     IntToStr( FLog[ lgDaily ].FData[ i ].Download )      + TLG_CSVSeparator +
                     IntToStr( FLog[ lgDaily ].FData[ i ].Upload ) );
      CloseFile( f );
    except
      Result := TLG_CSVWriteError;
      CloseFile( f );
    end;
  except
    Result := TLG_CSVWriteError;
  end;
end;

begin
  repeat
    ShouldRetry := FALSE;
    Status := DoCSVSave;
    if Status <> TLG_CSVSaveOK then
      CSVLoadSaveError( Status, ShouldRetry );
  until ShouldRetry = FALSE;
end;

function TTrafficLogs.GetTrafficLimit(Index : integer) : TTrafficLimitRec;
begin
  Result := FTrafficLimit[Index];
end;

procedure TTrafficLogs.TrafficLimitAdd( tl : TTrafficLimitRec );
begin
  SetLength(FTrafficLimit, Length(FTrafficLimit) + 1);
  FTrafficLimit[High(FTrafficLimit)] := tl;
  if tl.Enabled then
    TrafficLimitEnabled := TRUE;
end;

procedure TTrafficLogs.ClearTrafficLimits;
begin
  SetLength(FTrafficLimit, 0);
  TrafficLimitEnabled := FALSE;
end;

end.

