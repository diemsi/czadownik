unit RxDBGridSorter;

//-------------------------Component TRxDBGridSorter----------------------------
//VERSION 1.00
//Tested under Delphi 3.0,4.0,5.0
//November 26, 1999
//(c) Alexander V. Zhikharev (Alex Z)
//You can find the LATEST version of this(and some other) component(s) on:
//http://www.uic.nnov.ru/~zhav3
//e-mail: zhav3@uic.nnov.ru
//If you have any questions or if you find some BUG(s), please contact me.
//Thank you for good choose!
//------------------------------------------------------------------------------

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, db, dbtables,dialogs,
  RxDBCtrl;

type
  TRxDBGridSorter = class(TComponent)
  private
    { Private declarations }
    FRxDBGrid:TRxDBGrid;
    FMarkers:Boolean;
    sm:TSortMarker;
    OldFName,FName:string;
    FORDERstring:string;

    procedure TBC(Sender: TObject; ACol:Integer; Field: TField);//TitleButtonClick
    procedure GBP(Sender: TObject; Field: TField;
     AFont: TFont; var Background: TColor; var SortMarker: TSortMarker;
     IsDown: Boolean);
    procedure DoGridSorted(G:TRxDBGrid);
    procedure MakeGridSorted(G:TRxDBGrid);
    procedure SortIt;
  protected
    { Protected declarations }
  public
    { Public declarations }
    procedure Loaded;override;
    constructor Create(AOwner:TComponent);override;
  published
    { Published declarations }
    property RxDBGrid:TRxDBGrid read FRxDBGrid write FRxDBGrid;
    property Markers:Boolean read FMarkers write FMarkers;
    property ORDERstring:string read FORDERstring write FORDERstring;
  end;

procedure Register;

implementation

{.$R *.dcr}

function GoodField(F:TField):Boolean;//Checking if it is a GOOD field
begin
  GoodField:=(F.FieldKind=fkData) and
    ((F is TStringField) or (F is TFloatField) or (F is TIntegerField)
    or (F is TBooleanField) or (F is TDateField) or (F is TDateTimeField));
end;

constructor TRxDBGridSorter.Create(AOwner:TComponent);
begin
  Inherited;
  if csDesigning in ComponentState then //we drop component onto form
  begin
    //Start initialization
    Markers:=True;
  end;
end;

procedure TRxDBGridSorter.DoGridSorted(G:TRxDBGrid);
var
  Q:TQuery;
  A:Boolean;
begin
  //Initialization of variables
  FName:='';
  OldFName:='';
  G.TitleButtons:=True;
  Q:=TQuery(G.DataSource.DataSet);
  A:=Q.Active;//Remember if Query was ACTIVE
  //Adding MACRO(TParam) by which we will sort
  Q.SQL.Add(' '+ORDERstring);
  G.OnTitleBtnClick:=TBC;//Title Button Click Event
  G.OnGetBtnParams:=GBP;//Get Button params Event
  if A then Q.Open;//if Query was opened
end;

procedure TRxDBGridSorter.MakeGridSorted(G:TRxDBGrid);
begin
//Check possible access violation errors
  if Assigned(G) then
    if Assigned(G.DataSource) then
      if Assigned(G.DataSource.DataSet) then
        if (G.DataSource.DataSet is TQuery) then //DataSet !MUST! be TQuery
          DoGridSorted(G);
end;

procedure TRxDBGridSorter.SortIt;
var
  s,FN:string;
  Q:TQuery;
  V:Variant;
  i:Integer;
  Good:Boolean;//If there is any GOOD field then TRUE
begin
  Good:=False;
  Q:=TQuery(RxDBGrid.DataSource.DataSet);
  for i:=0 to Q.FieldCount-1 do
    if GoodField(Q.Fields[i]) then//remember where is the active record
    begin
      Good:=True;
      FN:=Q.Fields[i].FieldName;
      V:=Q.Fields[i].AsVariant;
      Break;
    end;
  Q.DisableControls;//if we don't do it grid will flash
  s:=' ORDER BY '+FName;//We sorting be FName field
  if sm=smUp then
    s:=s+' DESC';
  Q.SQL.Delete(Q.SQL.Count-1);//Replace ORDER BY Statement
  Q.SQL.Add(s);
  Q.Open;
  if Good then
    Q.Locate(FN,V,[]);//Going to record that we remember
  Q.EnableControls;
end;

procedure TRxDBGridSorter.GBP(Sender: TObject; Field: TField;
  AFont: TFont; var Background: TColor; var SortMarker: TSortMarker;
  IsDown: Boolean);
begin
  if Markers then //if "Markers" property set to TRUE we draw sort markers
    if Assigned(Field) then
      if Field.FieldName=FName then
        SortMarker:=sm;
end;

procedure TRxDBGridSorter.TBC(Sender: TObject; ACol: Integer; Field: TField);
begin
  if GoodField(Field) then//Field must be GOOD
  begin
    OldFName:=FName;
    FName:=Field.FieldName; //Field by which we will sort
    if (sm=smDown) and (FName=OldFName) then
      sm:=smUp
    else
      sm:=smDown;
    SortIt;//Perform sorting in the Query
  end;
end;

procedure TRxDBGridSorter.Loaded;
begin
  Inherited;
  if not (csDesigning in ComponentState) then
    MakeGridSorted(RxDBGrid);
end;

procedure Register;
begin
  RegisterComponents('RX DBAware', [TRxDBGridSorter]);
end;

end.
