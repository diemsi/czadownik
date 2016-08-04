(*******************************************************************************

Author:    Sean Mathews

Date:      28/02/1999

Version:   0.1

********************************************************************************)
unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Pak, ExtCtrls;

type
  TfrmPakMaster = class(TForm)
    btnCreate: TButton;
    btnClose: TButton;
    btnAdd: TButton;
    lblItemName: TLabel;
    lblItemType: TLabel;
    btnFile: TButton;
    SaveDialog: TSaveDialog;
    btnDelete: TButton;
    btnPak: TButton;
    btnPakHeader: TButton;
    Label1: TLabel;
    Label2: TLabel;
    btnToStream: TButton;
    procedure btnCreateClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAddClick(Sender: TObject);
    procedure listPakClick(Sender: TObject);
    procedure btnFileClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnPakClick(Sender: TObject);
    procedure btnPakHeaderClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label1DblClick(Sender: TObject);
    procedure Label2DblClick(Sender: TObject);
    procedure btnToStreamClick(Sender: TObject);
  private
    { Private declarations }
    PAK: TcymPak;

    procedure RenderList;
    procedure AddITems (Names : TStringList; IDX : Integer);
    procedure AddItemTooTree(ItemIndex : Integer);
    procedure ReplaceChar(CH, CHR: char; var Str: string);
  public
    { Public declarations }
  end;

var
  frmPakMaster: TfrmPakMaster;

implementation

uses SetHeader;

{$R *.DFM}

procedure TfrmPakMaster.btnCreateClick(Sender: TObject);
var
   OpenDialog : TOpenDialog;
begin
  OpenDialog := TOpenDialog.Create(Self);
  OpenDialog.Filter := 'PAK FILES|*.pak';
  if OpenDialog.Execute then
  begin
    PAK := TcymPak.Create(Self, OpenDialog.Filename);
    renderlist;
  end;
  OpenDialog.Free;
end;

procedure TfrmPakMaster.btnCloseClick(Sender: TObject);
begin
  if Assigned(Pak) then
  begin
    lblItemName.Caption := '';
    lblItemType.Caption := '';
//    TreePak.Items.Clear;
    PAK.Free;
    PAK := nil;
  end;
end;

procedure TfrmPakMaster.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(Pak) then
  begin
    PAK.Free;
    PAK := nil;
  end;
end;

procedure TfrmPakMaster.btnAddClick(Sender: TObject);
var
  OpenDialog : TOpenDialog;
  description: string;
  filetype: Word;
begin
  OpenDialog := TOpenDialog.Create(Self);
  if OpenDialog.Execute then
  begin
    Description := Copy(OpenDialog.FileName, 4, Length(OpenDialog.FileName) - 3);
    ReplaceChar('\', '/', Description);
    fileType := 0;
    PAK.AddItem(OpenDialog.Filename, Description, filetype);
    RenderList;
  end;
  OpenDialog.Free;
end;

procedure TfrmPakMaster.RenderList;
var
  loop: Integer;
begin
  if Pak.Directory.Count > 0 then
  begin
    lblItemName.Caption := '';
    lblItemType.Caption := '';
//    treePak.Items.Clear;
//    treePak.Items.Add(nil, 'PAK ITEMS');
    for loop := 0 to Pak.Directory.Count - 1 do
    begin
      AddItemtooTree(loop);
    end;
  end;
end;

procedure TfrmPakMaster.listPakClick(Sender: TObject);
begin
  if (treePak.Selected <> nil) and (treePak.Selected.HasChildren = false) then
  begin
    lblItemName.Caption := PAK.Directory.Items[
      Integer(treePak.Selected.Data)].ItemName;
    lblItemType.Caption := InttoStr(PAK.Directory.Items[
      Integer(treePak.Selected.Data)].ItemType);
  end;
  if (treePak.Selected <> nil) and (treePak.Selected.HasChildren = true) then
  begin
    lblItemName.Caption := '';
    lblItemType.Caption := '';
  end;

end;

procedure TfrmPakMaster.btnFileClick(Sender: TObject);
begin
if (treePak.Selected <> nil) and (treePak.Selected.HasChildren = false) then
  begin
    SaveDialog.FileName := TreePak.Selected.Text;
    if SaveDialog.Execute then
      begin
        Pak.ItemToFile(Integer(TreePak.Selected.Data), SaveDialog.Filename);
      end;
  end;
end;

procedure TfrmPakMaster.btnDeleteClick(Sender: TObject);
begin
if treePak.Selected <> nil then
  begin
    Pak.DeleteItem(Integer(treePak.Selected.Data));
    RenderList;
  end;
if Pak.Directory.Count = 0 then
  begin
    treePak.Items.Clear;
  end;
end;

procedure TfrmPakMaster.btnPakClick(Sender: TObject);
begin
Pak.PakPak;
end;

Function FindCreateChild(List : TTreeView; RootNode : TTreeNode;
         Text : string; IDX : Integer): TTreeNode;
Var
  Search                : TTreeNode;
Begin
  Result := Nil;
  Search := RootNode.GetFirstChild;
  While Assigned(Search) Do
  Begin
    If (Search.Text=Text) Then
    Begin
      Result := Search;
      Break;
    End;
    Search := Search.GetNextSibling;
  End;
  If Not Assigned(Result) Then
  begin
    Result := List.Items.AddChild(RootNode,Text);
    Result.Data := Pointer(IDX);
  End;
End;

procedure TfrmPakMaster.AddITems (Names : TStringList; IDX : Integer);
Var
  Root : TTreeNode;
  Loop : Integer;
Begin
  Root := TreePAK.Items[0];      //  I usually define this with an AddFirst call.
  For Loop := 0 To Names.Count-1 Do
  Begin
    Root := FindCreateChild(treePak,Root,Names[Loop], IDX);
  End;
end;

procedure TfrmPakMaster.AddItemTooTree(ItemIndex: Integer);
var
   SL : TStringList;
   TMP : string;
begin
SL := TStringList.Create;
TMP := PAK.Directory.Items[ItemIndex].ItemName;
while TMP[1] = '/' do TMP := Copy(TMP, 2, Length(TMP));
while pos('/', TMP) > 0 do
  begin
    SL.Add(copy(TMP, 1, pos('/', TMP)-1));
    Delete(TMP, 1, pos('/', TMP));
  end;
if TMP <> '' then SL.Add(TMP);
AddItems(SL, ItemIndex);
SL.Free;
end;

procedure TfrmPakMaster.ReplaceChar(CH, CHR: char; var Str: string);
begin
while pos(CH, Str) > 0 do
  begin
    Str[pos(CH, Str)] := CHR;
  end;
end;

procedure TfrmPakMaster.btnPakHeaderClick(Sender: TObject);
var
   frm : TfrmPakHeader;
begin
frm := TfrmPakHeader.Create(Self);
  try
    frm.edtAuthor.Text := PAK.Header.AuthorID;
    frm.spinVerMajor.Value := PAK.Header.VersionMajor;
    frm.spinVerMinor.Value := PAK.Header.VersionMinor;
    Hide;
    frm.ShowModal;
  finally
    if frm.ModalResult = mrOK then
      begin
        PAK.Header.AuthorID := frm.edtAuthor.Text;
        PAK.Header.VersionMajor := frm.spinVerMajor.Value;
        PAK.Header.VersionMinor := frm.spinVerMinor.Value;
        Pak.UpdatePak;
      end;
    frm.Free;
    Show;
  end;
end;

procedure TfrmPakMaster.FormCreate(Sender: TObject);
begin
//lblItemName.Caption := '';
//lblItemType.Caption := '';
end;

procedure TfrmPakMaster.Label1DblClick(Sender: TObject);
var
   TMP : String;
   IName : String;
begin
if (treePak.Selected <> nil) and (treePak.Selected.HasChildren = false) then
  begin
    IName := PAK.Directory.Items[Integer(treePak.Selected.Data)].ItemName;
    TMP := InputBox('Item Name','Type A New Name',IName);
    treePak.Selected.Text := TMP;
    PAK.Directory.Items[Integer(treePak.Selected.Data)].ItemName := TMP;
    RenderList;
    Pak.UpdatePak;
  end;
end;

procedure TfrmPakMaster.Label2DblClick(Sender: TObject);
var
   TMP : String;
   WRD : Word;
begin
if (treePak.Selected <> nil) and (treePak.Selected.HasChildren = false) then
  begin
    WRD := PAK.Directory.Items[Integer(treePak.Selected.Data)].ItemType;
    TMP := InputBox('Item Type','Type A New Value',InttoStr(Wrd));
    treePak.Selected.Text := TMP;
    PAK.Directory.Items[Integer(treePak.Selected.Data)].ItemType :=
      StrtoIntDef(TMP, 0);
    RenderList;
    Pak.UpdatePak;
  end;
end;

procedure TfrmPakMaster.btnToStreamClick(Sender: TObject);
var
   MS : TMemoryStream;
begin
if (treePak.Selected <> nil) and (treePak.Selected.HasChildren = false) then
  begin
    if Pak.Directory.Items[Integer(TreePak.Selected.Data)].ItemType = 42 then
    begin
      MS := TMemoryStream.Create;
      Pak.ItemToStream(Integer(TreePak.Selected.Data), MS);
      MS.Position := 0;
      Image1.Picture.Bitmap.LoadFromStream(MS);
      MS.Free;
    end
    else ShowMessage('Only use this feature on a .bmp type file' + #13#10 +
                     'with the itemtype set to 42');
  end;
end;

end.

