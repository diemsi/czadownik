unit pokoje;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, OleCtrls, SHDocVw, ExtCtrls, Stuff;

type
  TwndPokoje = class(TForm)
    StatusBar1: TStatusBar;
    edtPokoj: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Panel1: TPanel;
    web: TWebBrowser;
    PanelWczytywania: TPanel;
    Timer1: TTimer;
    Label2: TLabel;
    Label3: TLabel;
    Panel2: TPanel;
    Label4: TLabel;
    cbKat: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure webBeforeNavigate2(Sender: TObject; const pDisp: IDispatch;
      var URL, Flags, TargetFrameName, PostData, Headers: OleVariant;
      var Cancel: WordBool);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//  Procedure Wczytajkategorie(s:string);
var
  wndPokoje: TwndPokoje;
  ListaKategorii:String;

Procedure Wczytajkategorie(s:string);
  
implementation

uses wndmain, stale;
{$R *.DFM}

Procedure Wczytajkategorie(s:string);
var slowo:string;
    p:integer;
begin
     s := trim(s);
     JavaCodesToWindows(s);
     if assigned(wndPokoje)
        then if assigned(wndPokoje.cbKat)
                then wndPokoje.cbKat.Items.Clear;
     while not (s = '') do
     begin
          p := pos(' ', s);
          if p = 0 then
          begin
               slowo := s;
               s := '';
          end else
          begin
               slowo := copy(s, 1, p-1);
               delete(s, 1, p);
          end;
          if assigned(wndPokoje)
             then if assigned(wndPokoje.cbKat)
                     then wndPokoje.cbKat.Items.Add(slowo);
     end;
     if assigned(wndPokoje)
        then if assigned(wndPokoje.cbKat)
                then wndPokoje.cbKat.ItemIndex := 0;
end;

procedure TwndPokoje.FormShow(Sender: TObject);
var Ciagi:TStringArray;
    Polecenia:TWordArray;
begin
     if cbKat.Items.Count = 0 then Wczytajkategorie(Listakategorii);
     DeleteFile(plikZPokojami);
     web.Navigate('');
     if wndczat = nil then exit;
     Polecenia[1] := P__2S_ROOM_LIST;
     Polecenia[2] := 7;
     Ciagi[1] := cbkat.Text;
     WindowsCodesTojava(Ciagi[1]);
     wndczat.Wyslij(Polecenia, 2, Ciagi, 1);
     PanelWczytywania.Visible := True;
     Timer1.Enabled := True;
     PanelWczytywania.visible := True;
end;

procedure TwndPokoje.webBeforeNavigate2(Sender: TObject;
  const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);

var polecenie:string;
    p,i:integer;
begin
     Polecenie := Trim(UpperCase(url));
     if Uppercase(PlikZPokojami) = Polecenie then exit;
     p := pos('JOIN ', Polecenie);
     if (p = 0)  then
     begin
          Cancel := True;
          exit;
     end;
     Polecenie := LowerCase('/'+Copy(Polecenie, p, Length(polecenie)));
     if wndczat = nil then exit;
     for i := 1 to Length(Polecenie) do
          if Ord(Polecenie[i]) > $07e then Polecenie[i] := ' ';
     wndczat.PowiedzNaPolczat(polecenie);
     Close;
end;

procedure TwndPokoje.Timer1Timer(Sender: TObject);
begin
     if not FileExists(PlikZPokojami) then exit;
     Timer1.Enabled := False;
     PanelWczytywania.visible := false;
     web.Navigate(plikZPokojami);
end;

procedure TwndPokoje.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     Action := caHide;
     DeleteFile(PlikZPokojami);
end;

procedure TwndPokoje.Button1Click(Sender: TObject);
begin
     if wndczat = nil then exit;
     wndczat.PowiedzNaPolczat('/join '+edtPOkoj.text);
     Close;
end;

procedure TwndPokoje.FormCreate(Sender: TObject);
begin
     WczytajKategorie(ListaKategorii);
end;

end.
