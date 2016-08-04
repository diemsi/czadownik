(*******************************************************************************

Author:    Sean Mathews

Date:      28/02/1999

Version:   0.1

********************************************************************************)
unit PakDirectoryItem;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Classes, PakGlobals;

type
  TcymPakDirectoryItem = class(TPersistent)
  private
    FSize: LongWord;
    FOffSet: LongWord;
    FItemType: Word;
    fItemName: array[0..255] of Char;
    procedure SetItemType(const Value: Word);
    procedure SetOffSet(const Value: LongWord);
    procedure SetSize(const Value: LongWord);
    function GetItemName: String;
    procedure SetItemname(const Value: String);

  protected

  public

    constructor Create;
    destructor Destroy; override;

    procedure LoadFromStream(Strm: TStream);
    procedure WriteToStream(Strm: TStream);

    property ItemType: Word read FItemType write SetItemType;
    property OffSet: LongWord read FOffSet write SetOffSet;
    property Size: LongWord read FSize write SetSize;
    property Itemname : String read GetItemName write SetItemname;

  published

  end;

implementation


{ TcymPakDirectoryItem }

constructor TcymPakDirectoryItem.Create;
begin
  inherited Create;
  FillChar(fItemName, High(fItemName)+1, #0);
  FItemType := 0;
  FOffSet := 0;
  FSize := 0;
end;

destructor TcymPakDirectoryItem.Destroy;
begin

  inherited Destroy;
end;

function TcymPakDirectoryItem.GetItemName: String;
begin
RESULT := fItemName;
end;

procedure TcymPakDirectoryItem.LoadFromStream(Strm: TStream);
begin
  Strm.Read(fItemName, High(fItemName)+1);
  Strm.Read(fItemType, SizeOf(fItemType));
  Strm.Read(fOffset, SizeOf(fOffset));
  Strm.Read(fSize, SizeOf(fSize));
end;

procedure TcymPakDirectoryItem.SetItemname(const Value: String);
begin
StrToArr(fItemName, Value);
end;

procedure TcymPakDirectoryItem.SetItemType(const Value: Word);
begin
  FItemType := Value;
end;

procedure TcymPakDirectoryItem.SetOffSet(const Value: LongWord);
begin
  FOffSet := Value;
end;

procedure TcymPakDirectoryItem.SetSize(const Value: LongWord);
begin
  FSize := Value;
end;

procedure TcymPakDirectoryItem.WriteToStream(Strm: TStream);
begin
  Strm.Write(fItemName, High(fItemName)+1);
  Strm.Write(fItemType, SizeOf(fItemType));
  Strm.Write(fOffset, SizeOf(fOffset));
  Strm.Write(fSize, SizeOf(fSize));
end;

end.

