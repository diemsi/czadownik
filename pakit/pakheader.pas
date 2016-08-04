(*******************************************************************************

Author:    Sean Mathews

Date:      28/02/1999

Version:   0.1

********************************************************************************)
unit PakHeader;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Classes, PakGlobals;

type
  TcymPakHeader = class(TPersistent)
  private
    fAuthorID: array[0..49] of Char;
    fReserved: array[0..23] of Char;
    FDirSize: LongWord;
    FDirOffset: LongWord;
    FVersionMinor: Word;
    FVersionMajor: Word;
    procedure SetDirOffset(const Value: LongWord);
    procedure SetDirSize(const Value: LongWord);
    procedure SetVersionMajor(const Value: Word);
    procedure SetVersionMinor(const Value: Word);
    function GetID: String;
    procedure SetID(const Value: String);

  protected

  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;

    procedure LoadFromStream(Strm: TStream);
    procedure WriteToStream(Strm: TStream);

    property VersionMajor: Word read FVersionMajor write SetVersionMajor;
    property VersionMinor: Word read FVersionMinor write SetVersionMinor;
    property DirOffset: LongWord read FDirOffset write SetDirOffset;
    property DirSize: LongWord read FDirSize write SetDirSize;
    property AuthorID : String read GetID write SetID;
  published

  end;

implementation

{ TcymPakHeader }

constructor TcymPakHeader.Create(AOwner: TComponent);
begin
  inherited Create;
  FillChar(fAuthorID, High(fAuthorID)+1, #0);
  FillChar(fReserved, High(fReserved)+1, 'X');
  fVersionMajor := VER_MAJOR_CURRENT;
  fVersionMinor := VER_MINOR_CURRENT;
  fDirOffset := 0;
  fDirSize := 0;
end;

destructor TcymPakHeader.Destroy;
begin

  inherited Destroy;
end;

function TcymPakHeader.GetID: String;
begin
RESULT := fAuthorID;
end;

procedure TcymPakHeader.LoadFromStream(Strm: TStream);
begin
  Strm.Read(fVersionMajor, SizeOf(fVersionMajor));
  Strm.Read(fVersionMinor, SizeOf(fVersionMinor));
  Strm.Read(fDirOffset, SizeOf(fDirOffset));
  Strm.Read(fDirSize, SizeOf(fDirSize));
  Strm.Read(fAuthorID, High(fAuthorID)+1);
  Strm.Read(fReserved, High(fReserved)+1);
end;

procedure TcymPakHeader.SetDirOffset(const Value: LongWord);
begin
  FDirOffset := Value;
end;

procedure TcymPakHeader.SetDirSize(const Value: LongWord);
begin
  FDirSize := Value;
end;

procedure TcymPakHeader.SetID(const Value: String);
begin
StrToArr(fAuthorID, Value);
end;

procedure TcymPakHeader.SetVersionMajor(const Value: Word);
begin
  FVersionMajor := Value;
end;

procedure TcymPakHeader.SetVersionMinor(const Value: Word);
begin
  FVersionMinor := Value;
end;

procedure TcymPakHeader.WriteToStream(Strm: TStream);
begin
  Strm.Write(fVersionMajor, SizeOf(fVersionMajor));
  Strm.Write(fVersionMinor, SizeOf(fVersionMinor));
  Strm.Write(fDirOffset, SizeOf(fDirOffset));
  Strm.Write(fDirSize, SizeOf(fDirSize));
  Strm.Write(fAuthorID, High(fAuthorID)+1);
  Strm.Write(fReserved, High(fReserved)+1);
end;

end.

