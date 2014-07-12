unit LzmaEnc;

interface

uses System.SysUtils, Winapi.Windows, LzmaTypes, LzFind, LzFindMt;

{$Z4}
type
  TCLzmaEncHandle = Pointer;

  TCLzmaEncProps = record
    level: Integer;         (*  0 <= level <= 9 *)
    dictSize: UInt32;       (* (1 << 12) <= dictSize <= (1 << 27) for 32-bit version
                              (1 << 12) <= dictSize <= (1 << 30) for 64-bit version
                              default = (1 << 24) *)
    lc: Integer;            (* 0 <= lc <= 8, default = 3 *)
    lp: Integer;            (* 0 <= lp <= 4, default = 0 *)
    pb: Integer;            (* 0 <= pb <= 4, default = 2 *)
    algo: Integer;          (* 0 - fast, 1 - normal, default = 1 *)
    fb: Integer;            (* 5 <= fb <= 273, default = 32 *)
    btMode: Integer;        (* 0 - hashChain Mode, 1 - binTree mode - normal, default = 1 *)
    numHashBytes: Integer;  (* 2, 3 or 4, default = 4 *)
    mc: UInt32;             (* 1 <= mc <= (1 << 30), default = 32 *)
    writeEndMark: Cardinal; (* 0 - do not write EOPM, 1 - write EOPM, default = 0 *)
    numThreads: Integer;    (* 1 or 2, default = 2 *)
  end;

function _LzmaEnc_Create(var alloc: TISzAlloc): TCLzmaEncHandle; cdecl; external;

procedure _LzmaEnc_Destroy(p: TCLzmaEncHandle; var alloc: TISzAlloc; var allocBig: TISzAlloc); cdecl; external;

procedure _LzmaEncProps_Init(var p: TCLzmaEncProps); cdecl; external;

function _LzmaEnc_SetProps(p: TCLzmaEncHandle; var props: TCLzmaEncProps): TSRes; cdecl; external;

function _LzmaEnc_WriteProperties(p: TCLzmaEncHandle; properties: TBytes; var size: SIZE_T): TSRes; cdecl; external;

function _LzmaEnc_Encode(p: TCLzmaEncHandle; outStream: PISeqOutStream; inStream: PISeqInStream;
    progress: PICompressProgress; var alloc: TISzAlloc; var allocBig: TISzAlloc): TSRes; cdecl; external;

implementation

uses System.Win.Crtl;

{$L Win32\LzmaEnc.obj}

end.