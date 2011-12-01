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

unit IPHLPAPI;

interface

uses Windows;

const
  MAX_INTERFACE_NAME_LEN             = $100;
  ERROR_SUCCESS                      = 0;
  MAXLEN_IFDESCR                     = $100;
  MAXLEN_PHYSADDR                    = 8;

  MIB_IF_OPER_STATUS_NON_OPERATIONAL = 0;
  MIB_IF_OPER_STATUS_UNREACHABLE     = 1;
  MIB_IF_OPER_STATUS_DISCONNECTED    = 2;
  MIB_IF_OPER_STATUS_CONNECTING      = 3;
  MIB_IF_OPER_STATUS_CONNECTED       = 4;
  MIB_IF_OPER_STATUS_OPERATIONAL     = 5;

  MIB_IF_TYPE_OTHER                  = 1;
  MIB_IF_TYPE_ETHERNET               = 6;
  MIB_IF_TYPE_TOKENRING              = 9;
  MIB_IF_TYPE_FDDI                   = 15;
  MIB_IF_TYPE_PPP                    = 23;
  MIB_IF_TYPE_LOOPBACK               = 24;
  MIB_IF_TYPE_SLIP                   = 28;

  MIB_IF_ADMIN_STATUS_UP             = 1;
  MIB_IF_ADMIN_STATUS_DOWN           = 2;
  MIB_IF_ADMIN_STATUS_TESTING        = 3;

  MAX_INTERFACES                     = 32;


type
  IF_DESCRIPTION = array[0..MAXLEN_IFDESCR-1] of AnsiChar;

  MAC_ADDRESS    = array[0..MAXLEN_PHYSADDR-1] of byte;

  MAC =
    record
      Address : MAC_ADDRESS;
      Length  : DWORD;
    end;

  MIB_IFROW =
    packed record
      wszName              : array[0..MAX_INTERFACE_NAME_LEN-1] of WCHAR;
      dwIndex              : DWORD;
      dwType               : DWORD;
      dwMtu                : DWORD;
      dwSpeed              : DWORD;
      dwPhysAddrLen        : DWORD;
      bPhysAddr            : MAC_ADDRESS;
      dwAdminStatus        : DWORD;
      dwOperStatus         : DWORD;
      dwLastChange         : DWORD;
      dwInOctets           : DWORD;
      dwInUcastPkts        : DWORD;
      dwInNUcastPkts       : DWORD;
      dwInDiscards         : DWORD;
      dwInErrors           : DWORD;
      dwInUnknownProtos    : DWORD;
      dwOutOctets          : DWORD;
      dwOutUcastPkts       : DWORD;
      dwOutNUcastPkts      : DWORD;
      dwOutDiscards        : DWORD;
      dwOutErrors          : DWORD;
      dwOutQLen            : DWORD;
      dwDescrLen           : DWORD;
      bDescr               : IF_DESCRIPTION;
    end;

  PMIB_IFTABLE = ^MIB_IFTABLE;
  MIB_IFTABLE =
    record
      dwNumEntries : DWORD;
      Table : array[0..MAX_INTERFACES-1] of MIB_IFROW;
    end;

function GetIfTable( IFT : PMIB_IFTABLE; var BufLen : DWORD; bOrder : boolean ) : DWORD; stdcall;

implementation

function GetIfTable; stdcall; external 'IPHLPAPI.DLL';

end.
