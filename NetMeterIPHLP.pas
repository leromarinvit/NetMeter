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

unit NetMeterIPHLP;

interface

uses
  Windows, SysUtils, Classes,
  IPHLPAPI;

const
  IF_All_noLB_noDP = 0;
  IF_PPP_noDP      = 1;
  IF_Manual        = 2;

  IF_All_noLB_noDP_Str = 'All Interfaces (No Loopback, No Duplicates)';
  IF_PPP_noDP_Str      = 'Dial-Up Interfaces Only (No Duplicates)';

  IFS_FetchError       = 1;
  IFS_NothingToMonitor = 2;

  IFS_Msg : array[1..2] of string = (
    'Error monitoring currently selected interface(s)',
    'Nothing to monitor!' );

  IFD_FullLength = -1;

type
  TMonitoringErrorMessageProc = procedure(Sender: TObject; const msg : integer) of object;

  TIFStats =
    record
      do_monitor : boolean;
      PrevCountIn,          // previous byte count in
      PrevCountOut,         // previous byte count out
      InPerSec,             // byte count in of last sample period
      OutPerSec : LongWord; // byte count out of last sample period
    end;
  TIFStatArray = array[0..MAX_INTERFACES-1] of TIFStats;

  TIPHLPCollector = class(TObject)
  private
    FMIB_IFTable : MIB_IFTABLE;
    FIFStatArray : TIFStatArray;
    FNumInterfaces : integer;
    FLastMonitoringSuccessful : boolean;
    FInterfaceToMonitor : integer;
    FInterfaceDescription : IF_DESCRIPTION;
    FInterfaceMAC : MAC;
    FLastMonitoredIFIndex : integer;
    FLastMonitoredIFDescription : string;
    FUpload,
    FDownload : LongWord;
    FBandwidthTotal : Int64;
    FFetchErrorNotified,
    FNothingToMonitorErrorNotified : boolean;
    FOnMonitoringError : TMonitoringErrorMessageProc;
    function GetMIBIFTable(init : boolean) : boolean;
    function CalculateUDB : boolean;
    function IFD_matches(i1,i2 : IF_DESCRIPTION) : boolean;
    function MAC_matches(m1,m2 : MAC) : boolean;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Init;
    procedure Update;
    function GetIFDescription( idx : integer ) : IF_DESCRIPTION;
    function GetIFMAC( idx : integer ) : MAC;
    function GetFormattedIFDescription( idx : integer; maxlen : integer = IFD_FullLength; withmac : boolean = TRUE ) : string;
    function MacStrOf( idx : integer ) : string;
    property NumInterfaces : integer read FNumInterfaces;
    property InterfaceToMonitor : integer read FInterfaceToMonitor write FInterfaceToMonitor default IF_All_noLB_noDP;
    property InterfaceDescription : IF_DESCRIPTION read FInterfaceDescription write FInterfaceDescription;
    property InterfaceMAC : MAC read FInterfaceMAC write FInterfaceMAC;
    property LastMonitoredIFIndex : integer read FLastMonitoredIFIndex;
    property LastMonitoredIFDescription : string read FLastMonitoredIFDescription;
    property Upload         : LongWord read FUpload;
    property Download       : LongWord read FDownload;
    property BandwidthTotal : Int64 read FBandwidthTotal;
    property LastMonitoringSuccessful : boolean read FLastMonitoringSuccessful default FALSE;
    property OnMonitoringError : TMonitoringErrorMessageProc read FOnMonitoringError write FOnMonitoringError;
  protected
    procedure MonitoringError( const msg : integer ); virtual;
  end;

implementation

constructor TIPHLPCollector.Create;
begin
  inherited Create;

  FillChar(FInterfaceDescription, SizeOf(IF_DESCRIPTION), #0);
  FillChar(FInterfaceMAC, SizeOf(MAC), 0);

  FLastMonitoredIFIndex := -1;
  FLastMonitoredIFDescription := '';

  FFetchErrorNotified            := FALSE;
  FNothingToMonitorErrorNotified := FALSE;

  GetMIBIFTable(TRUE);
end;

destructor TIPHLPCollector.Destroy;
begin
  inherited Destroy;
end;

procedure TIPHLPCollector.MonitoringError;
var
  do_notify : boolean;
begin
  do_notify := FALSE;
  case msg of
    IFS_FetchError :
      begin
        do_notify := not FFetchErrorNotified;
        FFetchErrorNotified := TRUE;
      end;
    IFS_NothingToMonitor :
      begin
        do_notify := not FNothingToMonitorErrorNotified;
        FNothingToMonitorErrorNotified := TRUE;
      end;
  end;

  if Assigned(FOnMonitoringError) and do_notify then
    FOnMonitoringError(self, msg);
end;

procedure TIPHLPCollector.Init;
begin
  GetMIBIFTable(TRUE);
  FLastMonitoringSuccessful := CalculateUDB;
end;

procedure TIPHLPCollector.Update;
begin
  GetMIBIFTable(FALSE);
  FLastMonitoringSuccessful := CalculateUDB;
end;

function TIPHLPCollector.CalculateUDB;
var
  i,c : integer;
begin
  FUpload   := 0;
  FDownload := 0;
  FBandwidthTotal := 0;

  Result := TRUE;
  c := 0;

  if FNumInterfaces > 0 then
    for i := 0 to FNumInterfaces - 1 do
      if FIFStatArray[i].do_monitor then
        begin
          inc( c );
          inc( FUpload,   FIFStatArray[i].OutPerSec );
          inc( FDownload, FIFStatArray[i].InPerSec  );
          inc( FBandwidthTotal, FMIB_IFTable.Table[i].dwSpeed );
        end;

  if c = 0 then
    begin
      Result := FALSE;
      MonitoringError(IFS_NothingToMonitor);
    end
  else
    FNothingToMonitorErrorNotified := FALSE;
end;

function TIPHLPCollector.GetMIBIFTable;
var
  i : integer;
  bufsize : LongWord;
  pbuf : PMIB_IFTABLE;

procedure SelectIFsToMonitor;
var
  i : integer;
  m : MAC;
begin
  FLastMonitoredIFIndex := -1;
  case FInterfaceToMonitor of
    IF_All_noLB_noDP : FLastMonitoredIFDescription := IF_All_noLB_noDP_Str;
    IF_PPP_noDP      : FLastMonitoredIFDescription := IF_PPP_noDP_Str;
  else
    FLastMonitoredIFDescription := '';
  end;

  if FNumInterfaces > 0 then
    for i := 0 to FNumInterfaces - 1 do
      with FMIB_IFTable.Table[i] do begin
      with FIFStatArray[i] do
        begin
          do_monitor := FALSE;

          case FInterfaceToMonitor of
            IF_All_noLB_noDP : do_monitor := ( dwType <> MIB_IF_TYPE_LOOPBACK );
            IF_PPP_noDP      : do_monitor := ( dwType = MIB_IF_TYPE_PPP );
            IF_Manual        :
              begin
                m.Address := bPhysAddr;
                m.Length  := dwPhysAddrLen;
                if IFD_matches( bDescr, FInterfaceDescription ) and MAC_matches( m, FInterfaceMAC ) then
                  begin
                    do_monitor := TRUE;
                    FLastMonitoredIFIndex := i;
                    FLastMonitoredIFDescription := GetFormattedIFDescription( i , IFD_FullLength, TRUE );
                  end;
              end;
          end;

// The following lines have been disabled because some interfaces work although the status says otherwise...

//          if ( dwAdminStatus = MIB_IF_ADMIN_STATUS_DOWN ) or
//             ( dwOperStatus = MIB_IF_OPER_STATUS_NON_OPERATIONAL ) then
//            do_monitor := FALSE;

        end;
      end;
end;

procedure DuplicateCheck;
var
  first : boolean;
  i,x : integer;
  m : array of MAC;
  cm : MAC;

begin
  first := TRUE;

  if FNumInterfaces > 0 then
    for i := 0 to FNumInterfaces - 1 do
      with FMIB_IFTable.Table[i] do begin
      with FIFStatArray[i] do
        begin
          cm.Length := dwPhysAddrLen;
          cm.Address := bPhysAddr;
          if cm.Length > 0 then
            begin
              if first then
                begin
                  SetLength( m, 1 );
                  m[0] := cm;
                  first := FALSE;
                end
              else
                for x := 0 to Length(m) - 1 do
                  begin
                    if MAC_matches( cm , m[x] ) then do_monitor := FALSE
                    else
                      begin
                        SetLength( m, Length(m) + 1 );
                        m[ Length(m) - 1 ] := cm;
                      end;
                  end;
            end;
          end;
      end;
end;

procedure InitIFStatArray;
var
  i : integer;
begin
  if FNumInterfaces > 0 then
    for i := 0 to FNumInterfaces - 1 do
      with FMIB_IFTable.Table[i] do begin
      with FIFStatArray[i] do
        begin
          PrevCountIn  := dwInOctets;
          PrevCountOut := dwOutOctets;
          InPerSec     := 0;
          OutPerSec    := 0;
        end;
      end;
end;

procedure UpdateIFStatArray;
var
  i : integer;
begin
  if FNumInterfaces > 0 then
    for i := 0 to FNumInterfaces - 1 do
      with FMIB_IFTable.Table[i] do begin
      with FIFStatArray[i] do
        begin
          if dwInOctets > PrevCountIn then InPerSec := dwInOctets - PrevCountIn else InPerSec := 0;
          PrevCountIn := dwInOctets;
          if dwOutOctets > PrevCountOut then OutPerSec := dwOutOctets - PrevCountOut else OutPerSec := 0;
          PrevCountOut := dwOutOctets;
        end;
      end;
end;

begin
  Result := FALSE;

  FNumInterfaces := 0;

  pbuf := nil;
  bufsize := 0;
  if GetIfTable( pbuf, bufsize, TRUE ) = ERROR_INSUFFICIENT_BUFFER then
    begin
      GetMem( pbuf, bufsize );
      FillChar ( pbuf^, bufsize, #0);
      try
        if GetIfTable( pbuf, bufsize, TRUE ) = NO_ERROR then
          begin
            FNumInterfaces := pbuf^.dwNumEntries;
            if FNumInterfaces > 0 then
              for i := 0 to FNumInterfaces - 1 do
                FMIB_IFTable.Table[i] := pbuf^.Table[i];
            Result := TRUE;
          end;
      finally
        FreeMem( pbuf );
      end;
    end;

  if Result = FALSE then
    MonitoringError(IFS_FetchError)
  else
    FFetchErrorNotified := FALSE;

  SelectIFsToMonitor;
  if ( FInterfaceToMonitor = IF_All_noLB_noDP ) or
     ( FInterfaceToMonitor = IF_PPP_noDP ) then
    DuplicateCheck;

  if init then
    InitIFStatArray
  else
    UpdateIFStatArray;
end;

function TIPHLPCollector.GetIFDescription;
begin
  if ( idx > -1 ) and ( idx < FNumInterfaces ) then
    Result := FMIB_IFTable.Table[ idx ].bDescr
  else
    FillChar(Result, SizeOf( IF_DESCRIPTION ), #0);
end;

function TIPHLPCollector.GetIFMAC;
begin
  if ( idx > -1 ) and ( idx < FNumInterfaces ) then
    begin
      Result.Length  := FMIB_IFTable.Table[ idx ].dwPhysAddrLen;
      Result.Address := FMIB_IFTable.Table[ idx ].bPhysAddr;
    end
  else
    begin
      Result.Length := 0;
      FillChar(Result.Address, SizeOf( MAC ), 0);
    end;
end;

function TIPHLPCollector.GetFormattedIFDescription;
var
  s1, s2, s3 : string;
begin
  if ( idx > -1 ) and ( idx < FNumInterfaces ) then
    begin
      s2 := FMIB_IFTable.Table[ idx ].bDescr;
      s2 := Trim( s2 );

      if withmac then
        begin
          s1 := MacStrOf( idx );
          if s1 = '' then
            s3 := ''
          else
            s3 := ' [' + s1 + ']';
        end
      else
        s3 := '';

      if ( maxlen <> IFD_FullLength ) and ( Length( s2 + s3 ) > maxlen ) then
        begin
          SetLength( s2, maxlen - Length( s3 ) - 3 );
          s2 := s2 + '...';
        end;

      result := s2 + s3;

      //Mark all monitored interfaces
      if FIFStatArray[idx].do_monitor then result := '* ' + result;

    end
  else
    result := '';
end;

function TIPHLPCollector.IFD_matches;
var
  c : integer;
begin
  Result := TRUE;
  c := 0;
  repeat
    begin
      if i1[c] <> i2[c] then Result := FALSE;
      inc( c );
    end
  until ( c > High(IF_DESCRIPTION) ) or ( Result = FALSE );
end;

function TIPHLPCollector.MAC_matches;
var
  c : integer;
begin
  Result := TRUE;

  if m1.Length <> m2.Length then Result := FALSE
  else
    if m1.Length > 0 then
      begin
        c := 0;
        repeat
          begin
            if m1.Address[c] <> m2.Address[c] then Result := FALSE;
            inc( c );
          end
        until ( c > m1.Length - 1 ) or ( Result = FALSE );
      end;
end;

function TIPHLPCollector.MacStrOf;
var
  i : integer;
  s : string;
begin
  s := '';
  if ( idx > -1 ) and ( idx < FNumInterfaces ) then
    with FMIB_IFTable.Table[ idx ] do
      if dwPhysAddrLen > 0 then
        begin
          for i := 0 to dwPhysAddrLen - 1 do
            s := s + IntToHex( bPhysAddr[i] , 2 ) + '-';
          SetLength( s, Length( s ) - 1 );
        end;
  result := s;
end;

end.
