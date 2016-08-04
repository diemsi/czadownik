(*******************************************************************************

Author:    Sean Mathews

Date:      28/02/1999

Version:   0.1

********************************************************************************)
unit Pak;

interface

uses
  Windows, Messages, SysUtils, Classes, PakGlobals, PakDirectory,
  PakHeader, PakDirectoryItem;

type
  TcymPak = class(TComponent)
  private
    fFileName: string;
    fStream: TFileStream;
    fHeader: TcymPakHeader;
    fDirectory: TcymPakDirectory;

    procedure SetDirectory(const Value: TcymPakDirectory);
    procedure SetHeader(const Value: TcymPakHeader);

  protected

  public
    constructor Create(AOwner: TComponent; fName: string); reintroduce;
    destructor Destroy; override;

    procedure AddItem(fName, Desc: string; fType: Word);
    procedure DeleteItem(Index: Integer);
    procedure ItemToFile(Index: Integer; fName: string);
    procedure ItemToStream(Index: Integer; Strm: TStream);
    procedure UpdatePak;
    procedure PakPak;

    property Directory: TcymPakDirectory read FDirectory write SetDirectory;
    property Header: TcymPakHeader read FHeader write SetHeader;
  published

  end;

implementation

{ TcymPak }

procedure TcymPak.AddItem(fName, Desc: string; fType: Word);
var
  FS: TFileStream;
  DirItem: TcymPakDirectoryItem;
begin
  if FileExists(fName) then  //Make sure file exists
  begin
    //Open file for reading then write it to the end of the file.
    //(Overwrite the directory, which is updated from memory later)
    FS := TFileStream.Create(fName, fmOpenRead);
    DirItem := TcymPakDirectoryItem.Create;
    fStream.Position := fHeader.DirOffSet;
    DirItem.OffSet := fStream.Position;
    DirItem.Size := FS.Size;
    DirItem.ItemType := fType;
    DirItem.Itemname := Desc;
    FS.Position := 0;
    fStream.CopyFrom(FS, FS.Size);

    //Add the item to the pak directory
    fDirectory.AddItem(DirItem);
    fHeader.DirOffSet := fStream.Position;

    //Close the file to be added
    FS.Free;
  end;
end;

constructor TcymPak.Create(AOwner: TComponent; fName: string);
var
  fMode: Word;
begin
  inherited Create(AOwner);

  //If the file exists we are going to read it, else we will assume we are
  //going to create a new one
  if FileExists(fName) = false then fMode := (fmCreate or fmOpenReadWrite)
  else fMode := fmOpenReadWrite;
  fFileName := fName;
  fStream := TFileStream.Create(fName, fMode);
  fHeader := TcymPakHeader.Create(Self);
  fDirectory := TcymPakDirectory.Create(Self);
  if (fmCreate xor fMode = 0) then
  begin
    //fmCreate IS in fMode, so create new
    fHeader.WriteToStream(fStream);
    fHeader.DirOffset := fStream.Position;
  end
  else
  begin
    //fmCreate is NOT in fMode, so Loadfrom file
    fStream.Position := 0;
    fHeader.LoadFromStream(fStream);
    //Make sure we compensate for a 0 size directory
    if fHeader.DirSize > 0 then
    begin
    fStream.Position := fHeader.DirOffset;
    fDirectory.LoadFromStream(fStream, fHeader.DirSize);
    end
    else
    begin
    fHeader.DirOffset := fStream.Position;
    end;
  end;
end;

procedure TcymPak.DeleteItem(Index: Integer);
begin
  //simply delete the item from the directory, we can free the space in the
  //file by calling Pak.PakPak (Silly procname = yes).  I did this so it
  //only has to make disk writes occasionally when removing lots of items.
  fDirectory.DeleteItem(Index);
end;

destructor TcymPak.Destroy;
begin
  //Make sure the directory and header are up to date and written to the pak
  //then frre all the sub-objects.
  UpdatePak;
  fHeader.Free;
  fDirectory.Free;
  fStream.Free;
  inherited Destroy;
end;

procedure TcymPak.ItemToFile(Index: Integer; fName: string);
var
  FS: TFileStream;
begin
  FS := TFileStream.Create(fName, fmCreate);
  try
    fStream.Position := fDirectory.Items[Index].OffSet;
    FS.CopyFrom(fStream, fDirectory.Items[Index].Size);
  finally
    FS.Free;
  end;
end;

procedure TcymPak.ItemToStream(Index: Integer; Strm: TStream);
begin
fStream.Position := fDirectory.Items[Index].OffSet;
Strm.CopyFrom(fStream, fDirectory.Items[Index].Size);
end;

procedure TcymPak.PakPak;
(***************************************************************************
This may be a very inneficient way of updating the file and recovering space,
I havent tested it too much.
***************************************************************************)
var
  loop: Integer;
  WriteS, ReadS: TFileStream;
begin
//Write all directory and header changes
  UpdatePak;
//Close the pak so we can open it once for writing and once for reading
  fStream.Free;
//Create Read and write stream
  WriteS := TFileStream.Create(fFileName, fmOpenWrite or fmShareDenyNone);
  ReadS := TFileStream.Create(fFileName, fmOpenRead or fmShareDenyNone);
  WriteS.Position := 0;
  ReadS.Position := 0;
  fHeader.WriteToStream(WriteS);
  for loop := 0 to fDirectory.Count - 1 do
  begin
    ReadS.Position := fDirectory.Items[loop].OffSet;
    fDirectory.Items[loop].Offset := WriteS.Position;
    WriteS.CopyFrom(ReadS, fDirectory.Items[loop].Size);
  end;
  WriteS.Size := WriteS.Position;
  fHeader.DirOffset := WriteS.Position;
  ReadS.Free;
  WriteS.Free;
  fStream := TFileStream.Create(fFileName, fmOpenReadWrite);
  UpdatePak;
end;

procedure TcymPak.SetDirectory(const Value: TcymPakDirectory);
begin
  fDirectory.Assign(Value);
end;

procedure TcymPak.SetHeader(const Value: TcymPakHeader);
begin
  fHeader.Assign(Value);
end;

procedure TcymPak.UpdatePak;
begin
  //Make the changes to the pak file Header and Directory current.
  fStream.Position := 0;
  fHeader.DirSize := fDirectory.Count;
  fHeader.WriteToStream(fStream);
  fStream.Position := fHeader.DirOffset;
  fDirectory.WriteToStream(fStream);
end;

end.

