(*******************************************************************************

Author:    Sean Mathews

Date:      28/02/1999

Version:   0.1

********************************************************************************)
unit PakDirectory;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Classes, PakGlobals, PakDirectoryItem;

type
  TcymPakDirectory = class(TPersistent)
  private
    fItems: TList;
    function GetItems(Index: Integer): TcymPakDirectoryItem;
    function GetCount: Integer;

  protected

  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;

    procedure ClearItems;
    procedure WriteToStream(Strm: TStream);
    procedure LoadFromStream(Strm: TStream; NumItems: Word);
    procedure AddItem(Item: TcymPakDirectoryItem);
    procedure DeleteItem(Index : Integer);

    property Items[Index: Integer]: TcymPakDirectoryItem read GetItems;
    property Count: Integer read GetCount;

  published

  end;

implementation

{ TcymPakDirectory }

procedure TcymPakDirectory.AddItem(Item: TcymPakDirectoryItem);
begin
  fItems.Add(Item);
end;

procedure TcymPakDirectory.ClearItems;
var
  loop: Integer;
begin
  if fItems.Count > 0 then
    for loop := fItems.Count - 1 downto 0 do
    begin
      TcymPakDirectoryItem(fItems[loop]).Free;
      fItems.Delete(loop);
    end;
end;

constructor TcymPakDirectory.Create(AOwner: TComponent);
begin
  inherited Create;
  fItems := TList.Create;
end;

procedure TcymPakDirectory.DeleteItem(Index: Integer);
begin
TcymPakDirectoryItem(fItems[Index]).Free;
fItems.Delete(Index);
end;

destructor TcymPakDirectory.Destroy;
begin
//Clear and free item list
  ClearItems;
  fItems.Free;
  fItems := nil;

  inherited Destroy;
end;

function TcymPakDirectory.GetCount: Integer;
begin
  RESULT := fItems.Count;
end;

function TcymPakDirectory.GetItems(Index: Integer): TcymPakDirectoryItem;
begin
  RESULT := TcymPakDirectoryItem(fItems[Index]);
end;

procedure TcymPakDirectory.LoadFromStream(Strm: TStream;
  NumItems: Word);
var
  loop: word;
  DirItem: TcymPakDirectoryItem;
begin
  for loop := 0 to NumItems - 1 do
  begin
    DirItem := TcymPakDirectoryItem.Create;
    DirItem.LoadFromStream(Strm);
    fItems.Add(DirItem);
  end;
end;

procedure TcymPakDirectory.WriteToStream(Strm: TStream);
var
  loop: word;
begin
  if fItems.Count > 0 then
  begin
    for loop := 0 to fItems.Count - 1 do
    begin
      TcymPakDirectoryItem(fItems[loop]).WriteToStream(Strm);
    end;
  end;
end;

end.

