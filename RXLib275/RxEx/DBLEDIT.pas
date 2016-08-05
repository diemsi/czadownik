unit DBLEdit;

{   ������������� � RxLib 2.60. 
    ��������� - ������������ DBEdit � DBLookup. ���� ��� �����, ��� ��� 
  ������� �����, �������� ��� �� vs@balance.dp.ua. 
    � �������,  ��� ��� ������������� ������� - ������������� ���� � �� �� 
  ������ � ���� ������ ������, �� ������ ����.
    ����� ��������������, ������������ ��� ������ � ��������������. ���� ��
  �������� ���� ��������� (��������, �������� ������� "���� ������� ��������, 
  �������� ��� � Lookup-�������, � Post")- ����������, �������� ��� ����� 
  ������.
    ������� ������� ��������� ������������� ��������� ��� � ����� - ���� �����
  ������ ������ �����. ����������� �� ��������, ���������, �������� - 
  ���������... 
    ��� ��� �����, �� ����� ����. �� ��� ���-�� �����.}

{   ����� � ������� DEFINE RIGHT_SPACE_ALIGN ����� �������� ��������
  "������������ ������ ��������� �� ������������ ������". ���������
  ��� ����� ������ �� ������.
    �������� RightSpaceAlign: ���� False, �� ������������ �� ������������,
  ����� ����� �������� �������� ���������� ����� ��������� ��
  ������ Field.Size }

{$DEFINE RIGHT_SPACE_ALIGN}

interface

uses
  Windows, SysUtils, Messages, Classes, Controls, Forms,
  StdCtrls, ExtCtrls, Mask, Buttons, ComCtrls, Db, dbctrls,
  RxLookup;

type
  TDBLookupEdit = class(TRxLookupEdit)
  private
    FDataLink: TFieldDataLink;
    FAlignment: TAlignment;
    FFocused: Boolean;
{$IFDEF RIGHT_SPACE_ALIGN}
    FRightSpaceAlign: boolean;
{$ENDIF}

    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    // ��� warning - ��� � ���� - VS.
    function GetReadOnly: Boolean; override; // �� ���� override - VS.
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetFocused(Value: Boolean);
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    // ��� �������. ������ Change ��������� ������ �� ������� CloseUp,
    // ��������� State � FDataLink ������� ������ ��� (�� Editing).
    // ������ ��������� CloseUp ����������� ���� ���� � �� �����. ���������� Change
    // _��� ������_ *Post* � ����.
    ChangeInvoked: boolean;
    procedure Change; override;
    function EditCanModify: Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure Reset; override;
    procedure DropDown;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function AcceptPopup(var Value: Variant): Boolean; override;

    property Field: TField read GetField;
  published

    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
{$IFDEF RIGHT_SPACE_ALIGN}
    property RightSpaceAlign: boolean read FRightSpaceAlign write FRightSpaceAlign;
{$ENDIF}
  end;

procedure Register;

implementation

uses DBTables{$IFDEF DEBUG}, Dialogs{$ENDIF}, StrUtils;

constructor TDBLookupEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
//  inherited ReadOnly := True;
  ControlStyle := ControlStyle + [csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
  //DSS
  PopupOnlyLocate := False;
{$IFDEF RIGHT_SPACE_ALIGN}
  FRightSpaceAlign := False;
{$ENDIF}
end;

destructor TDBLookupEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TDBLookupEdit.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TDBLookupEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TDBLookupEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_DELETE) or ((Key = VK_INSERT) and (ssShift in Shift)) then
    FDataLink.Edit;
  inherited;
end;

procedure TDBLookupEdit.KeyUp(var Key: Word; Shift: TShiftState);
var
  SStart, SLength: integer;
begin
  inherited;
  SLength := SelLength;
  SStart := SelStart + FDataLink.Field.Size - Length(Text);
  if Trim(Text) <> '' then
    Text := RightStr(Trim(Text), FDataLink.Field.Size)
  else
    Text := '';
  SelStart := SStart; // ����� ������������ Text ���������������.
  SelLength := SLength;
  FDataLink.Edit;
//  SelStart := Length(Text);
end;

procedure TDBLookupEdit.KeyPress(var Key: Char);
var
  NewText: string;
//  SStart, SLength: integer;
begin
{$IFDEF RIGHT_SPACE_ALIGN}
  if FRightSpaceAlign and (Key in [#32..#255])
    and (FDataLink.Field <> nil) and FDataLink.Field.IsValidChar(Key)
    and (SelStart <= MaxLength)
  then begin
    NewText := Copy(Text, 1, SelStart) + Key +
               Copy(Text, SelStart+SelLength, Length(Text) - SelStart - SelLength);
    if Trim(NewText) <> '' then
      Text := RightStr(Trim(NewText), FDataLink.Field.Size)
    else
      Text := '';
    SelStart := Length(Text);
  end;  
{$ENDIF}

  inherited KeyPress(Key);

  if (Key in [#32..#255]) and (FDataLink.Field <> nil) and
    not FDataLink.Field.IsValidChar(Key) then
  begin
    MessageBeep(0);
    Key := #0;
  end;
  case Key of
    ^H, ^V, ^X, #32..#255:
      FDataLink.Edit;
    #27:
      begin
        FDataLink.Reset;
        SelectAll;
        Key := #0;
      end;
  end;
end;

function TDBLookupEdit.EditCanModify: Boolean;
begin
  Result := FDataLink.Edit;
end;

procedure TDBLookupEdit.Reset;
begin
  FDataLink.Reset;
  SelectAll;
end;

procedure TDBLookupEdit.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
  begin
    FFocused := Value;
    if (FAlignment <> taLeftJustify) and not IsMasked then Invalidate;
    FDataLink.Reset;
  end;
end;

procedure TDBLookupEdit.Change;
begin
//  if ChangeInvoked then
//    exit; // ���� ���� ������� - ���� ��������.
  Application.ProcessMessages;
  ChangeInvoked := True;
  // ���������, ������ ��� ��� ��������� ���������� ������, ��� FormCreate, ����-����.
  if not Showing then exit;

  FDataLink.Modified;
  if Assigned(FDataLink.Dataset)
     and FDataLink.Dataset.Active
                                              //    and Assigned(LookupSource.Dataset) and LookupSource.Dataset.Active
  then begin                                  // inherited Change; - �������� ����� ���������� ��������� ���������.
    if PopupOnlyLocate then begin             //DSS - PopupOnlyLocate �� ��������� VS - ������ ����� ���������.
      if PopupVisible then PopupChange;
    end else begin
      PopupChange;
      DoChange;
    end;
  end;
  ChangeInvoked := False;
end;

function TDBLookupEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TDBLookupEdit.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TDBLookupEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TDBLookupEdit.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TDBLookupEdit.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TDBLookupEdit.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TDBLookupEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TDBLookupEdit.DataChange(Sender: TObject);
begin
  Enabled := (FDataLink.Field <> nil)
             and Assigned(LookupSource)
             and LookupSource.Dataset.Active
             and FDataLink.Field.Dataset.Active;

  if Enabled then
  begin
    if (FAlignment <> FDataLink.Field.Alignment) then
    begin
      EditText := '';  //  forces update
      FAlignment := FDataLink.Field.Alignment;
    end;
    EditMask := FDataLink.Field.EditMask;

    // ��� ����� ���� - VS
    if (FDataLink.Field is TStringField) and
       (MaxLength <> FDataLink.Field.Size)
      then MaxLength := FDataLink.Field.Size;

    if FFocused and FDataLink.CanModify then
      Text := FDataLink.Field.Text
    else
    begin
      EditText := FDataLink.Field.DisplayText;
      if FDataLink.Editing and
        ((FDataLink.Dataset is TBDEDataSet)
          and (FDataLink.Dataset as TBDEDataSet).CachedUpdates
          and (FDataLink.Field.OldValue <> FDataLink.Field.NewValue)
          or not (FDataLink.Dataset is TBDEDataSet)
        )
//      FDataLink.FModified
      then
        Modified := True;
    end;
  end else begin
    FAlignment := taLeftJustify;
    EditMask := '';
    if csDesigning in ComponentState then
      EditText := Name else
      EditText := '';
  end;
end;

procedure TDBLookupEdit.EditingChange(Sender: TObject);
begin
//  inherited ReadOnly := not FDataLink.Editing;
end;

procedure TDBLookupEdit.UpdateData(Sender: TObject);
begin
  ValidateEdit;
  FDataLink.Field.Text := Text;
end;

procedure TDBLookupEdit.WMPaste(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TDBLookupEdit.WMCut(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TDBLookupEdit.CMEnter(var Message: TCMEnter);
begin
  SetFocused(True);
  inherited;
  if SysLocale.FarEast and FDataLink.CanModify then begin
    inherited ReadOnly := False;
    ReadOnly := False;
  end;
end;

procedure TDBLookupEdit.CMExit(var Message: TCMExit);
begin
  try
    if FDataLink.Field.Dataset.State in [dsEdit, dsInsert] then
      FDataLink.UpdateRecord;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
//  SetFocused(False);
//  CheckCursor;
  DoExit;
end;

procedure TDBLookupEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

function TDBLookupEdit.AcceptPopup(var Value: Variant): Boolean;
begin
  FDataLink.Edit;
  result := inherited AcceptPopup(Value);
  if result then begin
    FDataLink.UpdateRecord;
    FDataLink.Reset;
  end {$IFDEF DEBUG} else MessageDlg('DFFF', mtError, [mbOk], 0){$ENDIF};
end;

procedure TDBLookupEdit.DropDown;
begin
  // !!! �� ����, ��� RecordCount ������ �������� ������.
  // ��������, ��� �������� ������ � ������� �������.
  if DropDownCount > LookupSource.Dataset.RecordCount then
    DropDownCount := LookupSource.Dataset.RecordCount;
  inherited;
end;

procedure Register;
begin
  RegisterComponents('Samples', [TDBLookupEdit]);
end;

end.