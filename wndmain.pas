unit wndmain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Contnrs, ExtCtrls, Math, Buttons, ScktComp,
  ComCtrls, Stale, stuff, inifiles, mmsystem, ImgList,
  CoolTrayIcon, Menus, FtpCli, Gauges, clipbrd, RXCtrls, pak,
  TopMostCtl, WSocket, Tabs, Grids, Mask, ToolEdit, CurrEdit,
  RXSpin, RxGIF, nl_elem, ip_parser;

type TWordArray = array[1..1024] of Word;
     TStringArray = array [1..1024] of String;
Type TCoTeraz = (ctLogin, ctNic, ctSttings);

const lblWpisrevDNS = 'Wpis revDNS dla: %s';
      lblWhoIs      = 'WhoIs dla: %s';
      MaxOkienekCzata = 32;

type
  TwndCzat = class(TForm)
    Zakladki: TPageControl;
    zCzat: TTabSheet;
    OdczytZaleglegoBufora: TTimer;
    AntyIdleTimer: TTimer;
    czat: TClientSocket;
    OproznianieBuforaAntyFloodowego: TTimer;
    btnKoloOki1: TImage;
    btnKoloIgnore1: TImage;
    btnPriv1: TImage;
    btnInfo1: TImage;
    btnKoloOki0: TImage;
    btnKoloIgnore0: TImage;
    btnPriv0: TImage;
    btnInfo0: TImage;
    TimerPrzyciskuPolacz: TTimer;
    zKonfiguracja: TTabSheet;
    Drzewo: TTreeView;
    Panel1: TPanel;
    lblnazwaZakladki: TLabel;
    Notebook1: TNotebook;
    lblOProgramie: TLabel;
    edtNick: TEdit;
    Label2: TLabel;
    edtPassword: TEdit;
    Label3: TLabel;
    edtRoom: TEdit;
    Label4: TLabel;
    edtMasterPanelSettings: TComboBox;
    Label9: TLabel;
    edtCodeBase: TComboBox;
    Label8: TLabel;
    edtDocumentBase: TComboBox;
    Label7: TLabel;
    edtPort: TComboBox;
    Label6: TLabel;
    edtServer: TComboBox;
    Label5: TLabel;
    Label10: TLabel;
    edtTekstIDLE: TEdit;
    Label11: TLabel;
    edtCzestotliwoscAntyIDLE: TRxSpinEdit;
    Label12: TLabel;
    chkAntyIDLE: TCheckBox;
    Label1: TLabel;
    Label15: TLabel;
    Polacz: TButton;
    Ustawienia: TMemo;
    Label13: TLabel;
    Log: TMemo;
    Label16: TLabel;
    btnCzyscLogowanieLaczenia: TButton;
    Label14: TLabel;
    BuforAntyFlood: TListBox;
    chkAntyFloodAktywny: TCheckBox;
    chkUsuwajDuble: TCheckBox;
    Label17: TLabel;
    chkDwuklikNaObrazek: TCheckBox;
    lbZnajomi: TListBox;
    Label19: TLabel;
    btnDodajZnajomka: TBitBtn;
    btnUsunZnajomka: TBitBtn;
    btnZmienZnajomka: TBitBtn;
    Label20: TLabel;
    edtXywaZnajomka: TEdit;
    OtworzWAV: TOpenDialog;
    TimerMigania: TTimer;
    dlgKolor: TColorDialog;
    Migacz: TImageList;
    Tray: TCoolTrayIcon;
    TrayPopupMenu: TPopupMenu;
    Pokaokno1: TMenuItem;
    N1: TMenuItem;
    Zamknij1: TMenuItem;
    OczkaSpiace: TImageList;
    TimerTrayBara: TTimer;
    Ukryjokno1: TMenuItem;
    chkIkonkaWpaskuZegara: TCheckBox;
    chkMinimalizacja: TCheckBox;
    chkChowajObrazki: TCheckBox;
    GroupBox5: TGroupBox;
    Label28: TLabel;
    edtIloscKolumn: TRxSpinEdit;
    ListaUserowPopupMenu: TPopupMenu;
    Dodajdoznajomych1: TMenuItem;
    CzatPopupMenu: TPopupMenu;
    Doschowka1: TMenuItem;
    chkCzasWypowiedzi: TCheckBox;
    lblPrzykladCzasu: TLabel;
    btnUstawKolorCzasu: TSpeedButton;
    Label29: TLabel;
    chkDodawajLinkiZPriva: TCheckBox;
    chkDodawajLinkiZGlownego: TCheckBox;
    Panel3: TPanel;
    btnBold: TSpeedButton;
    btnItalic: TSpeedButton;
    btnUnderline: TSpeedButton;
    lbKolory: TComboBox;
    btnUstawKolor: TSpeedButton;
    btnObrazki: TSpeedButton;
    SpeedButton1: TSpeedButton;
    edtPrzedrostek: TEdit;
    Panel4: TPanel;
    btnGuest: TButton;
    ListaUserow: TListBox;
    btnBan: TButton;
    btnKick: TButton;
    btnUsunWszystkieLinki: TSpeedButton;
    btnUsunLink: TSpeedButton;
    btnSortujLinki: TSpeedButton;
    KolorowyNapis1: TPanel;
    Label30: TLabel;
    KolorowyNapis2: TPanel;
    Label31: TLabel;
    Label32: TLabel;
    KolorowyNapis3: TPanel;
    NaGorze: TTopMost;
    chkOnTop: TCheckBox;
    Czybufor1: TMenuItem;
    menuWpisrevDNS: TMenuItem;
    revDNS: TWSocket;
    lbLinki: TListView;
    chkPolaczPrzyUruchomieniu: TCheckBox;
    chkAutoDNS: TCheckBox;
    StatusBar1: TStatusBar;
    StatusBarUpdate: TTimer;
    GroupBox2: TGroupBox;
    btnPrivOtworzWav: TSpeedButton;
    chkPrivMigaj: TCheckBox;
    chkPrivGraj: TCheckBox;
    edtPrivWav: TEdit;
    GroupBox1: TGroupBox;
    btnWejscieOtworzWav: TSpeedButton;
    chkWejscieMigaj: TCheckBox;
    chkWejscieGraj: TCheckBox;
    edtWejscieWav: TEdit;
    GroupBox3: TGroupBox;
    btnGlownyOdtowrzWav: TSpeedButton;
    chkGlownyMigaj: TCheckBox;
    chkGlownyGraj: TCheckBox;
    edtGlownyWAV: TEdit;
    GroupBox6: TGroupBox;
    btnKtosGlownyOtworzWAV: TSpeedButton;
    chkKtosGlownyMigaj: TCheckBox;
    chkKtosGlownyGraj: TCheckBox;
    edtKtosGlownyWAV: TEdit;
    GroupBox7: TGroupBox;
    btnPrivKtosOtworzWAV: TSpeedButton;
    chkKtosPrivMigaj: TCheckBox;
    chkKtosPrivGraj: TCheckBox;
    edtKtosPrivWaV: TEdit;
    GroupBox8: TGroupBox;
    btnKtosWejscieOtworzWAV: TSpeedButton;
    chkKtosWejscieMigaj: TCheckBox;
    chkKtosWejscieGraj: TCheckBox;
    edtKtosWejscieWav: TEdit;
    lbIgnorowane: TListBox;
    Label35: TLabel;
    lbSlowa: TListBox;
    Label36: TLabel;
    edtSlowo: TEdit;
    btnUsunSlowo: TBitBtn;
    btnZmienSlowo: TBitBtn;
    btnDodajSlowo: TBitBtn;
    GroupBox9: TGroupBox;
    btnSlowoOtworzWava: TSpeedButton;
    chkSlowoMigajPaskiem: TCheckBox;
    chkSlowoGrajWava: TCheckBox;
    edtSlowoWAV: TEdit;
    Label18: TLabel;
    lblWersjaCzata: TLabel;
    Label21: TLabel;
    lblNajnowszaWersja: TLabel;
    Label25: TLabel;
    btnSprawdzWersje: TButton;
    btnAktualizuj: TButton;
    Panel2: TPanel;
    Label26: TLabel;
    lblIloscPlikowDoSciagniecia: TLabel;
    lblPlik: TLabel;
    Label27: TLabel;
    Postep: TGauge;
    lbListaPlikow: TListBox;
    GroupBox4: TGroupBox;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    edtFTPHost: TEdit;
    edtFTPUser: TEdit;
    edtFTPPassword: TEdit;
    LogiFTP: TMemo;
    ftp: TFtpClient;
    Label37: TLabel;
    lbPozegnania: TListBox;
    Label38: TLabel;
    edtPozegnanie: TEdit;
    btnDodajPozegnanie: TBitBtn;
    btnusunPozegnanie: TBitBtn;
    btnZmienPozegnanie: TBitBtn;
    chkPozegnaniaAktywne: TCheckBox;
    chkSprawdzanieWersji: TCheckBox;
    OczkaOtwarte: TImageList;
    edtTekst: TEdit;
    Panel5: TPanel;
    sb: TScrollBar;
    PanelDoRysowania: TPaintBox;
    btnPriv: TPaintBox;
    btnKoloOki: TPaintBox;
    btnKoloIgnore: TPaintBox;
    btnInfo: TPaintBox;
    ZakladkaOkienek: TTabSet;
    ZakladkaPopUp: TPopupMenu;
    Zamknij2: TMenuItem;
    chkObrazki: TCheckBox;
    btnPOkoje: TSpeedButton;
    lblIloscUserow: TLabel;
    TimerListyUserow: TTimer;
    Label33: TLabel;
    zBany: TTabSheet;
    sgBany: TStringGrid;
    Label34: TLabel;
    btnWczytajBany: TButton;
    Label39: TLabel;
    Label40: TLabel;
    edtBanMinuty: TRxCalcEdit;
    lblRozwiniecieCzasu: TLabel;
    btnAktualizujBana: TButton;
    edtIP1: TEdit;
    edtIP2: TEdit;
    edtIP3: TEdit;
    edtIP4: TEdit;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    btnUsunBana: TButton;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    edtF1: TEdit;
    edtF2: TEdit;
    edtF3: TEdit;
    edtF4: TEdit;
    edtF8: TEdit;
    edtF7: TEdit;
    edtF6: TEdit;
    edtF5: TEdit;
    edtF12: TEdit;
    edtF11: TEdit;
    edtF10: TEdit;
    edtF9: TEdit;
    Label57: TLabel;
    lbListaFunkcji: TListBox;
    edtFunkcja: TEdit;
    btnDodajFunkcje: TBitBtn;
    btnUsunFunkcjeZListy: TBitBtn;
    btnZmienFunkcjeWLiscie: TBitBtn;
    Label59: TLabel;
    lbFunkcjeIP: TListBox;
    edtFunkcjaIP: TEdit;
    btnDodajFunkcjeIP: TBitBtn;
    btnUsunFukcjeIP: TBitBtn;
    btnZmienFunkcjeIP: TBitBtn;
    ListaZaleglychNumerowIP: TListBox;
    Helpik: TMemo;
    lblTransfer: TLabel;
    TimerTransferu: TTimer;
    TabSheet1: TTabSheet;
    WhoIsSocket: TWSocket;
    edtWhoIsIP: TEdit;
    btnSprawdzInfo: TButton;
    WhoIsMemo: TMemo;
    Label56: TLabel;
    menuWhoIs: TMenuItem;
{    procedure lbDrawItem(Control: TWinControl; Index: Integer; Rect: TRect;
      State: TOwnerDrawState);}
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
{    procedure lbMeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);}
    procedure lbKoloryDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure btnBoldClick(Sender: TObject);
    procedure lbKoloryChange(Sender: TObject);
    procedure btnKoloOkiMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnKoloOkiMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnKoloIgnoreMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnKoloIgnoreMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnPrivMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnPrivMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnInfoMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnInfoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormPaint(Sender: TObject);
    procedure ZakladkiDrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure czatConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure czatConnecting(Sender: TObject; Socket: TCustomWinSocket);
    procedure czatDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure czatError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure czatLookup(Sender: TObject; Socket: TCustomWinSocket);
    procedure czatRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure czatWrite(Sender: TObject; Socket: TCustomWinSocket);
    procedure AntyIdleTimerTimer(Sender: TObject);
    procedure OdczytZaleglegoBuforaTimer(Sender: TObject);
    procedure PolaczClick(Sender: TObject);
    procedure edtTekstKeyPress(Sender: TObject; var Key: Char);
    procedure edtCzestotliwoscAntyIDLEChange(Sender: TObject);
    procedure ListaUserowDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure btnInfoClick(Sender: TObject);
    procedure zCzatShow(Sender: TObject);
    procedure btnGuestClick(Sender: TObject);
    procedure btnBanClick(Sender: TObject);
    procedure btnKickClick(Sender: TObject);
    procedure btnKoloIgnoreClick(Sender: TObject);
    procedure btnPobierzPlikiClick(Sender: TObject);
    procedure btnKoloOkiClick(Sender: TObject);
    procedure btnObrazkiClick(Sender: TObject);
    procedure btnPrivClick(Sender: TObject);
    procedure OproznianieBuforaAntyFloodowegoTimer(Sender: TObject);
    procedure chkAntyFloodAktywnyClick(Sender: TObject);
    procedure TimerPrzyciskuPolaczTimer(Sender: TObject);
    procedure DrzewoChange(Sender: TObject; Node: TTreeNode);
    procedure DrzewoEditing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure btnCzyscLogowanieLaczeniaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnDodajZnajomkaClick(Sender: TObject);
    procedure btnUsunZnajomkaClick(Sender: TObject);
    procedure btnZmienZnajomkaClick(Sender: TObject);
    procedure lbZnajomiClick(Sender: TObject);
    procedure btnWejscieOtworzWavClick(Sender: TObject);
    procedure btnPrivOtworzWavClick(Sender: TObject);
    procedure TimerMiganiaTimer(Sender: TObject);
    procedure btnUstawKolorClick(Sender: TObject);
    procedure btnGlownyOdtowrzWavClick(Sender: TObject);
    procedure Pokaokno1Click(Sender: TObject);
    procedure Zamknij1Click(Sender: TObject);
    procedure TimerTrayBaraTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Ukryjokno1Click(Sender: TObject);
    procedure chkIkonkaWpaskuZegaraClick(Sender: TObject);
    procedure TrayDblClick(Sender: TObject);
    procedure chkMinimalizacjaClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ListaUserowDblClick(Sender: TObject);
    procedure Dodajdoznajomych1Click(Sender: TObject);
    procedure Doschowka1Click(Sender: TObject);
    procedure CzatPopupMenuPopup(Sender: TObject);
    procedure ZakladkiChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnKoloOkiPaint(Sender: TObject);
    procedure btnPrivPaint(Sender: TObject);
    procedure btnKoloIgnorePaint(Sender: TObject);
    procedure btnInfoPaint(Sender: TObject);
    procedure btnUsunWszystkieLinkiClick(Sender: TObject);
    procedure btnUsunLinkClick(Sender: TObject);
    procedure lbLinkiKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSortujLinkiClick(Sender: TObject);
    procedure lbLinkiDblClick(Sender: TObject);
    procedure KolorowyNapis1Click(Sender: TObject);
    procedure KolorowyNapis2Click(Sender: TObject);
    procedure KolorowyNapis3Click(Sender: TObject);
    procedure chkOnTopClick(Sender: TObject);
    procedure Czybufor1Click(Sender: TObject);
    procedure menuWpisrevDNSClick(Sender: TObject);
    procedure revDNSDnsLookupDone(Sender: TObject; Error: Word);
    procedure btnUstawKolorCzasuClick(Sender: TObject);
    procedure StatusBarUpdateTimer(Sender: TObject);
    procedure btnKtosWejscieOtworzWAVClick(Sender: TObject);
    procedure btnPrivKtosOtworzWAVClick(Sender: TObject);
    procedure btnKtosGlownyOtworzWAVClick(Sender: TObject);
    procedure btnDodajSlowoClick(Sender: TObject);
    procedure btnUsunSlowoClick(Sender: TObject);
    procedure btnZmienSlowoClick(Sender: TObject);
    procedure btnSlowoOtworzWavaClick(Sender: TObject);
    procedure lbSlowaClick(Sender: TObject);
    procedure btnSprawdzWersjeClick(Sender: TObject);
    procedure btnAktualizujClick(Sender: TObject);
    procedure ftpProgress(Sender: TObject; Count: Integer;
      var Abort: Boolean);
    procedure ftpSessionClosed(Sender: TObject; Error: Word);
    procedure ftpSessionConnected(Sender: TObject; Error: Word);
    procedure ftpDisplayFile(Sender: TObject; var Msg: String);
    procedure ftpRequestDone(Sender: TObject; RqType: TFtpRequest;
      Error: Word);
    procedure lbPozegnaniaClick(Sender: TObject);
    procedure btnDodajPozegnanieClick(Sender: TObject);
    procedure btnusunPozegnanieClick(Sender: TObject);
    procedure btnZmienPozegnanieClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sbChange(Sender: TObject);
    procedure PanelDoRysowaniaPaint(Sender: TObject);
    procedure PanelDoRysowaniaMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ZakladkaOkienekChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure Zamknij2Click(Sender: TObject);
    procedure edtTekstKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StatusBar1DrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure ZakladkaOkienekMeasureTab(Sender: TObject; Index: Integer;
      var TabWidth: Integer);
    procedure ZakladkaOkienekDrawTab(Sender: TObject; TabCanvas: TCanvas;
      R: TRect; Index: Integer; Selected: Boolean);
    procedure btnPOkojeClick(Sender: TObject);
    procedure TimerListyUserowTimer(Sender: TObject);
    procedure btnPolchatClick(Sender: TObject);
    procedure sgBanySetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure btnWczytajBanyClick(Sender: TObject);
    procedure edtBanMinutyChange(Sender: TObject);
    procedure sgBanyClick(Sender: TObject);
    procedure btnAktualizujBanaClick(Sender: TObject);
    procedure btnUsunBanaClick(Sender: TObject);
    procedure btnDodajFunkcjeClick(Sender: TObject);
    procedure btnUsunFunkcjeZListyClick(Sender: TObject);
    procedure btnZmienFunkcjeWLiscieClick(Sender: TObject);
    procedure lbListaFunkcjiClick(Sender: TObject);
    procedure ListaUserowPopupMenuPopup(Sender: TObject);
    procedure lbFunkcjeIPClick(Sender: TObject);
    procedure btnDodajFunkcjeIPClick(Sender: TObject);
    procedure btnUsunFukcjeIPClick(Sender: TObject);
    procedure btnZmienFunkcjeIPClick(Sender: TObject);
    procedure TimerTransferuTimer(Sender: TObject);
    procedure TrayMinimizeToTray(Sender: TObject);
    procedure btnSprawdzInfoClick(Sender: TObject);
    procedure WhoIsSocketDataAvailable(Sender: TObject; Error: Word);
    procedure WhoIsSocketSessionClosed(Sender: TObject; Error: Word);
    procedure WhoIsSocketSessionConnected(Sender: TObject; Error: Word);
    procedure menuWhoIsClick(Sender: TObject);
  private
    { Private declarations }
    OknaCzata:Array[0..MaxOkienekCzata] of record
        Zawartosc:POknoCzata;
        Nick:String;
        Tekst:String;
        SelStart:Integer;
        Bold, Italic, Underline:Boolean;
        Kolor:Integer;
    end;
    NumerOknaCzata:Integer;
    BufferBitmap, OldBitmap:hbitmap;
    PanelDCReal, PanelDC:HDC;
    PanelDoRysowaniaY:integer;
  public
//    konfigheight, konfigwidth:integer;
    czatheight, czatwidth:integer;
    MOgeZmieniacRozmiar:Boolean;
    OrginalneMinHeight, OrginalneMinWidth:Integer;
    OrginalneHeight, OrginalneWidth:Integer;
    OldLbWidth:Integer;
    OknoRevDNS:Integer;
    OstatnieTeksty:Array[1..20] of String;
    NickOstatniejOsoby:String;
    IPOstatniejOsoby:String;
    JoinIP:String;
    TransferStaraWartosc:Longint;
    TransferWartosc:Longint;

    { Public declarations }
    procedure Powiedz(s:String);
    procedure Interpretuj(IloscPolecen:Byte; Polecenia:TWordArray; IloscCiagow:Byte; Ciagi:TStringArray);
    procedure Wyslij(Polecenia:TWordArray; IloscPolecen:Byte; Ciagi:TStringArray; IloscCiagow:Byte);
    procedure WykonajPomiar(var Item:String; var LiniaHTML:TLiniaHTML);
    function DajNickaZListy:string;
    procedure AnalizujUstawieniaSerwera(Ciag:String);
    procedure PowiedzNaPolczat(s:String);
    Function CzyZnajomy(nick:string):Boolean;
    Procedure WlaczMiganie(Uchwyt:THandle);
    Procedure WylaczMiganie(Uchwyt:THandle);
    procedure ustawPrzedrostek;
    procedure LinkInternetowyClick(Sender: TObject);
    procedure DodajLinkiDoListy(Linia:string);
    procedure DodajDoOknaCzata(Numer:Integer; Tekst:String);
    Procedure PozegnajSie;
    Procedure Busy(Busy:Boolean);
    procedure WczytajDoListyBanow(s:string);
    procedure WstawWMiejsceKursora(s:string);
    function FormatujTekstFunkcyjny(s:string):string;
    procedure WykonajFunkcje(Sender: TObject);
    procedure WyczyscListeUserow;
  end;

{const MaxPriv = 256;
Type  TPrivy = array[1..MaxPriv] of TwndPriv;}

var
  wndCzat: TwndCzat;
  Stos:TStack;
  Coteraz:TCoTeraz;
  JestemOpem:Boolean;
  Kolorusera, KolorOpa:String;
  WymuszanieNicka:Boolean;
  WymuszonyNick:String;

implementation

uses obrazki, wnd_Splash, pokoje;

{$R *.DFM}
/////////////////////////////////////////////////////////////////////////////
// Pomiar wysokoœci i rysowanie poszczególnych linii w okienku czata       //
/////////////////////////////////////////////////////////////////////////////
/////////////////{$i rys_pom.pas}
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////

procedure TwndCzat.AnalizujUstawieniaSerwera(Ciag:String);
var Element:String;
    i:integer;
    p:integer;
begin
     Ustawienia.Lines.Clear;
     element := '';
     IleKolorow := 0;
     while not (Ciag = '') do
     begin
          if Ciag[1] = '&' then
          begin
               Element := StringReplace(Element, '  ', ' ', [rfReplaceAll]);
               Ustawienia.Lines.Add(Element);
               if Copy(UpperCase(Element), 1, 9) = 'COLOR_OP=' then
               begin
                    Delete(Element, 1, 9);
                    KolorOpa := Element;
               end;
               if Copy(UpperCase(Element), 1, 11) = 'COLOR_USER=' then
               begin
                    Delete(Element, 1, 11);
                    KolorUsera := Element;
               end;
               if Copy(UpperCase(Element), 1, 12) = 'COLOR_GUEST=' then
               begin
                    Delete(Element, 1, 12);
                    for i := 1 to 16 do
                    begin
                         p := pos(' ', Element);
                         if Element = '' then break;
                         if p = 0 then
                         begin
                              KoloryCzatowiczow[i] := Element;
                              Element := '';
                         end else
                         begin
                              KOloryCzatowiczow[i] := Trim(Copy(Element, 1, p));
                              Delete(Element, 1, p);
                              Element := Trim(Element);
                         end;
                         inc(IleKolorow);
                    end;
               end;
               Element := '';
          end else Element := Element + Ciag[1];
          Delete(Ciag, 1, 1);
     end;
     if Element <> '' then Ustawienia.Lines.Add(Element);
end;



procedure TwndCzat.FormCreate(Sender: TObject);
var wersja:string;
    r:TIniFile;
    i:integer;
    ciag:string;
    Item:TListItem;
    gfx:TcymPAK;
    bmp:TBitmap;
    ms:TMemoryStream;
    gif:tgifimage;
begin
     edtServer.ItemIndex := 0;
     edtPort.ItemIndex := 0;
     edtDocumentBase.ItemIndex := 0;
     edtCodeBase.ItemIndex := 0;
     edtMasterPanelSettings.ItemIndex := 0;


     JestemOpem := False;

     sgBany.Cells[0, 0] := 'IP';
     sgBany.Cells[1, 0] := 'Czas[min]';

     sgBany.ColWidths[0] := 120;
     sgBany.ColWidths[1] := 80;

     lblRozwiniecieCzasu.caption := IleSiedzi(0);
     NickOstatniejOsoby := '';
     IPOstatniejOsoby := '';
     TransferStaraWartosc := 0;
     TransferWartosc := 0;

     if FileExists('helpik.txt') then
     begin
          Helpik.Lines.clear;
          helpik.Lines.LoadFromFile('helpik.txt');
     end;

     for i := 1 to 20 do OstatnieTeksty[i] := '';
     OldPrvCount := 0;
     StatusBarUpdateTimer(nil);
     OldLBWidth := PanelDoRysowania.Width;
     OrginalneHeight := Height;
     OrginalneWidth := Width;
     OrginalneMinHeight := wndczat.Constraints.MinHeight;
     OrginalneMinWidth := wndczat.Constraints.MinWidth;

     MogeZmieniacRozmiar := True;
     Zakladki.ActivePage := zCzat;
     chkAntyFloodAktywnyClick(nil);
     Stos := TStack.Create;
     Zakladki.OwnerDraw := True;
     CoTeraz := ctNic;
     edtCzestotliwoscAntyIDLEChange(nil);

     wersja := DajWersjeProgramu;
     Caption := Format(Caption, [wersja]);
     lblOProgramie.Caption := Format(lblOProgramie.Caption, [wersja]);
     lblWersjaCzata.Caption := Format(lblWersjaCzata.Caption, [wersja]);
{     FillChar(Privy, SizeOf(TPrivy), 0);}


     ZakladkaOkienek.TabIndex := 0;
     NumerOknaCzata := 0;
     New(OknaCzata[NumerOknaCzata].Zawartosc);
     FillChar(OknaCzata[NumerOknaCzata].Zawartosc^, SizeOf(TOknoCzata), 0);

//     PanelDoRysowania.canvas.Brush.Color := clWhite;

     //rejestr odczytujemy na samym koncu
     if FileExists(ExtractFilePath(Application.exename)+'czat.ini') then
     begin
          r := TIniFile.Create(ExtractFilePath(Application.exename)+'czat.ini');
          WlasnyKolor := r.readstring('czat','wlasnykolor', WlasnyKolor);
          btnBold.Down := r.ReadBool('czat','pogrubienie', btnBold.Down);
          btnItalic.Down := r.ReadBool('czat','pochylenie', btnItalic.Down);
          btnUnderline.Down := r.ReadBool('czat','podkreslenie', btnUnderline.Down);
          lbKolory.ItemIndex := r.ReadInteger('czat','kolory', lbKolory.ItemIndex);
          KolorCzata := r.readstring('czat','kolorczata', KolorCzata);
//          edtTekst.Color := HTMLColorToDelphi(KolorCzata);
//          ListaUserow.Color := HTMLColorToDelphi(KolorCzata);
//          PanelDoRysowania.Color := HTMLColorToDelphi(KolorCzata);

          ustawPrzedrostek;
          {}
          edtNick.Text := r.ReadString('uzytkownik','Nick', edtNick.Text);
          edtPassword.text := r.ReadString('uzytkownik','Password', edtPassword.text);
          edtRoom.text := r.ReadString('uzytkownik','Room', edtRoom.text);
          {}
          edtServer.text := r.ReadString('polaczenie','Serwer', edtServer.text);
          edtPort.text := r.ReadString('polaczenie','Port', edtPort.text);
          edtDocumentbase.Text := r.ReadString('polaczenie','DocumentBase', edtDocumentbase.Text);
          edtMasterPanelSettings.text := r.ReadString('polaczenie','MasterPanelSettings', edtMasterPanelSettings.text);
          edtCodeBase.Text := r.ReadString('polaczenie','CodeBase', edtCodeBase.Text);
          {}
          edtTekstIdle.Text := r.ReadString('antyidle','TekstIDLE', edtTekstIdle.Text);
          edtCzestotliwoscAntyIDLE.Value := r.ReadInteger('antyidle','CzestIDLE', Trunc(edtCzestotliwoscAntyIDLE.Value));
          chkAntyIdle.checked := r.ReadBool('antyidle','AntyIDLE', chkAntyIdle.checked);
          {}
          chkUsuwajDuble.Checked := r.ReadBool('antyflood','UsuwajDuble', chkUsuwajDuble.Checked);
          chkAntyFloodAktywny.Checked := r.ReadBool('antyflood','AntyFlood', chkAntyFloodAktywny.Checked);
          {}
          chkDwukliknaObrazek.Checked := r.ReadBool('ustawienia','DwuklikNaObrazek' ,chkDwukliknaObrazek.Checked);
          chkIkonkaWPaskuZegara.Checked := r.ReadBool('ustawienia','TrayIcon' ,chkIkonkaWPaskuZegara.Checked);
          chkMinimalizacja.Checked := r.ReadBool('ustawienia','Minimalizacja' ,chkMinimalizacja.Checked);
          chkChowajObrazki.Checked := r.ReadBool('ustawienia','ChowajObrazki' ,chkChowajObrazki.Checked);
          edtIloscKolumn.Value := r.ReadInteger('ustawienia','IloscKolumn', Trunc(edtIloscKolumn.Value));
          IloscKolumnObrazkow := Trunc(edtIloscKolumn.Value);
          KolorCzasu := r.ReadString('ustawienia','kolorczasu', KolorCzasu);
          lblPrzykladCzasu.Font.Color := HTMLColorToDelphi(KolorCzasu);
          chkCzasWypowiedzi.Checked := r.ReadBool('ustawienia','PokazujCzas' ,chkCzasWypowiedzi.Checked);
          chkDodawajLinkiZGlownego.Checked := r.ReadBool('ustawienia','linkizglownego' ,chkDodawajLinkiZGlownego.Checked);
          chkDodawajLinkiZPriva.Checked := r.ReadBool('ustawienia','linkizpriva' ,chkDodawajLinkiZPriva.Checked);
          chkOnTop.Checked := r.ReadBool('ustawienia','ontop' ,chkOnTop.Checked);
          chkOnTopClick(nil);
          chkPolaczPrzyUruchomieniu.Checked := r.ReadBool('ustawienia','polaczprzuruchomieniu' ,chkPolaczPrzyUruchomieniu.Checked);
          chkAutoDNS.Checked := r.ReadBool('ustawienia','dns' ,chkAutoDNS.Checked);
          chkSprawdzanieWersji.Checked := r.ReadBool('ustawienia','SprWersji' ,chkSprawdzanieWersji.Checked);
          chkObrazki.Checked := r.ReadBool('ustawienia','WyswObrazki' ,chkObrazki.Checked);
          {}
          edtFTPUser.Text := r.ReadString('LiveUpdate', 'Uzytkownik' ,edtFTPUser.Text);
          edtFTPPassword.Text := r.ReadString('LiveUpdate', 'Haseuko' ,edtFTPPassword.Text);
          edtFTPHost.Text := r.ReadString('LiveUpdate', 'Hoscik' ,edtFTPHost.Text);
          {}
          chkPrivMigaj.Checked := r.ReadBool('znajomi','priv.migaj' ,chkPrivMigaj.Checked);
          chkPrivGraj.Checked := r.ReadBool('znajomi','priv.graj' ,chkPrivGraj.Checked);
          edtPrivWav.Text := r.ReadString('znajomi','priv.wav' ,edtPrivWav.Text);
          chkWejscieMigaj.Checked := r.ReadBool('znajomi','wejscie.migaj' ,chkWejscieMigaj.Checked);
          chkWejscieGraj.Checked := r.ReadBool('znajomi','wejscie.graj' ,chkWejscieGraj.Checked);
          edtWejscieWav.Text := r.ReadString('znajomi','wejscie.wav' ,edtWejscieWav.Text);
          chkGlownyMigaj.Checked := r.ReadBool('znajomi','glowny.migaj' ,chkGlownyMigaj.Checked);
          chkGlownyGraj.Checked := r.ReadBool('znajomi','glowny.graj' ,chkGlownyGraj.Checked);
          edtGlownyWav.Text := r.ReadString('znajomi','glowny.wav' ,edtGlownyWav.Text);
          {}
          chkKtosWejscieMigaj.Checked := r.ReadBool('nieznajomi', 'wejscie.migaj', chkKtosWejscieMigaj.Checked);
          chkKtosWejscieGraj.Checked := r.ReadBool('nieznajomi', 'wejscie.Graj', chkKtosWejscieGraj.Checked);
          edtKtosWejscieWav.Text := r.ReadString('nieznajomi', 'wejscie.wav', edtKtosWejscieWav.Text);
          chkKtosPrivMigaj.Checked := r.ReadBool('nieznajomi', 'Priv.migaj', chkKtosPrivMigaj.Checked);
          chkKtosPrivGraj.Checked := r.ReadBool('nieznajomi', 'Priv.Graj', chkKtosPrivGraj.Checked);
          edtKtosPrivWaV.Text := r.ReadString('nieznajomi', 'Priv.wav', edtKtosPrivWaV.Text);
          chkKtosGlownyMigaj.Checked := r.ReadBool('nieznajomi', 'glowny.migaj', chkKtosGlownyMigaj.Checked);
          chkKtosGlownyGraj.Checked := r.ReadBool('nieznajomi', 'glowny.Graj', chkKtosGlownyGraj.Checked);
          edtKtosGlownyWAV.Text := r.ReadString('nieznajomi', 'glowny.wav', edtKtosGlownyWAV.Text);
          {}
          chkSlowoMigajPaskiem.Checked := r.ReadBool('Slowo', 'migaj', chkSlowoMigajPaskiem.Checked);
          chkSlowoGrajWava.Checked := r.ReadBool('Slowo', 'Graj', chkSlowoGrajWava.Checked);
          edtSlowoWAV.Text := r.ReadString('Slowo', 'wav' ,edtSlowoWAV.Text);
          {}
          edtF1.Text := r.ReadString('funkcyjne', 'F1' ,edtF1.Text);
          edtF2.Text := r.ReadString('funkcyjne', 'F2' ,edtF2.Text);
          edtF3.Text := r.ReadString('funkcyjne', 'F3' ,edtF3.Text);
          edtF4.Text := r.ReadString('funkcyjne', 'F4' ,edtF4.Text);
          edtF5.Text := r.ReadString('funkcyjne', 'F5' ,edtF5.Text);
          edtF6.Text := r.ReadString('funkcyjne', 'F6' ,edtF6.Text);
          edtF7.Text := r.ReadString('funkcyjne', 'F7' ,edtF7.Text);
          edtF8.Text := r.ReadString('funkcyjne', 'F8' ,edtF8.Text);
          edtF9.Text := r.ReadString('funkcyjne', 'F9' ,edtF9.Text);
          edtF10.Text := r.ReadString('funkcyjne', 'F10' ,edtF10.Text);
          edtF11.Text := r.ReadString('funkcyjne', 'F11' ,edtF11.Text);
          edtF12.Text := r.ReadString('funkcyjne', 'F12' ,edtF12.Text);


          Top := r.ReadInteger('okno.czat', 'top', top);
          left := r.ReadInteger('okno.czat', 'left', left);
          height := r.ReadInteger('okno.czat', 'czatheight', height);
          width := r.ReadInteger('okno.czat', 'czatwidth', width);
          czatheight := height;
          czatwidth := width;
          lbZnajomi.Items.Clear;
          for i := 0 to r.ReadInteger('znajomi.lista','count', 0)-1 do
          begin
               lbZnajomi.Items.Add(r.ReadString('znajomi.lista', 'Item'+IntToStr(i) ,''));
          end;

          dlgKolor.CustomColors.Clear;
          for i := 0 to r.ReadInteger('kolory.lista','count', 0)-1 do
          begin
               dlgKolor.CustomColors.Add(r.ReadString('kolory.lista', 'Item'+IntToStr(i) ,''));
          end;

          lbLinki.Items.Clear;
          for i := 0 to r.ReadInteger('linki.lista','count', 0)-1 do
          begin
               ciag := r.ReadString('linki.lista', 'Item'+IntToStr(i) ,'');
               item := lblinki.Items.Add;
               item.Caption := Ciag;
          end;

          lbSlowa.Items.Clear;
          for i := 0 to r.ReadInteger('slowa_efektory','count', 0)-1 do
          begin
               lbSlowa.Items.Add(r.ReadString('slowa_efektory', 'Item'+IntToStr(i) ,''));
          end;

          lbPozegnania.Items.Clear;
          for i := 0 to r.ReadInteger('Pozegnania','count', 0)-1 do
          begin
               lbPozegnania.Items.Add(r.ReadString('Pozegnania', 'Item'+IntToStr(i) ,''));
          end;
          chkPozegnaniaAktywne.Checked := r.ReadBool('Pozegnania','Aktywne', chkPozegnaniaAktywne.Checked);

          if r.ReadInteger('Funkcje','count', 0) <> 0
             then lbListaFunkcji.Items.Clear;
          for i := 0 to r.ReadInteger('Funkcje','count', 0)-1 do
          begin
               lbListaFunkcji.Items.Add(r.ReadString('Funkcje', 'Item'+IntToStr(i) ,''));
          end;

          if r.ReadInteger('FunkcjeIP','count', 0) <> 0
             then lbFunkcjeIP.Items.Clear;
          for i := 0 to r.ReadInteger('FunkcjeIP','count', 0)-1 do
          begin
               lbFunkcjeIP.Items.Add(r.ReadString('FunkcjeIP', 'Item'+IntToStr(i) ,''));
          end;

          r.free;
     end;

     if chkPolaczPrzyUruchomieniu.Checked then PolaczClick(nil);
     if chkSprawdzanieWersji.Checked then btnSprawdzWersjeClick(nil);



     //to gowno na koncu bo cos sie sypie
     IleObrazkow := 0;
     btnObrazki.Visible := chkObrazki.Checked;
     if chkObrazki.Checked then
     begin
          gfx := TcymPAK.Create(self, 'gfx.dat');
          for i := 0 to gfx.Directory.Count-1 do
          begin
               TablicaObrazkow[i].nazwa := UpperCase(gfx.Directory.Items[i].Itemname);
               ms := TMemoryStream.Create;
               gfx.ItemToStream(i, ms);
               gif := tgifimage.Create;
               ms.Position := 0;
               gif.LoadFromStream(ms);
               ms.free;
               bmp := TBitmap.Create;
               bmp.Height := gif.Height;
               bmp.width := gif.Width;
               gif.Frames[0].Draw(bmp.canvas, rect(0, 0, bmp.width, bmp.height), False);
               TablicaObrazkow[i].bitmap := bmp;
               gif.free;
          end;
          IleObrazkow := gfx.Directory.Count;
          gfx.Free;
     end;

end;

procedure TwndCzat.FormDestroy(Sender: TObject);
var f:PFoncik;
    r:TIniFile;
    i:integer;
begin
     r := TIniFile.Create(ExtractFilePath(Application.exename)+'czat.ini');
     r.WriteString('czat', 'wlasnykolor', WlasnyKolor);
     r.WriteBool('czat', 'pogrubienie', btnBold.Down);
     r.WriteBool('czat', 'pochylenie', btnItalic.Down);
     r.WriteBool('czat', 'podkreslenie', btnUnderline.Down);
     r.WriteInteger('czat', 'kolory', lbKolory.ItemIndex);
     r.Writestring('czat','kolorczata', KolorCzata);
     {}
     r.WriteString('uzytkownik', 'Nick', edtNick.Text);
     r.WriteString('uzytkownik', 'Password', edtPassword.text);
     r.WriteString('uzytkownik', 'Room', edtRoom.text);
     {}
     r.WriteString('polaczenie', 'Serwer', edtServer.text);
     r.WriteString('polaczenie', 'Port', edtPort.text);
     r.WriteString('polaczenie', 'DocumentBase',edtDocumentbase.Text);
     r.WriteString('polaczenie', 'MasterPanelSettings', edtMasterPanelSettings.text);
     r.WriteString('polaczenie', 'CodeBase', edtCodeBase.Text);
     {}
     r.WriteString('antyidle', 'TekstIDLE', edtTekstIdle.Text);
     r.WriteInteger('antyidle', 'CzestIDLE', Trunc(edtCzestotliwoscAntyIDLE.Value));
     r.WriteBool('antyidle', 'AntyIDLE', chkAntyIdle.checked);
     {}
     r.WriteBool('antyflood', 'UsuwajDuble', chkUsuwajDuble.Checked);
     r.WriteBool('antyflood', 'AntyFlood', chkAntyFloodAktywny.Checked);
     {}
     r.WriteBool('ustawienia', 'DwuklikNaObrazek', chkDwukliknaObrazek.Checked);
     r.WriteBool('ustawienia','TrayIcon', chkIkonkaWPaskuZegara.Checked);
     r.WriteBool('ustawienia','Minimalizacja' ,chkMinimalizacja.Checked);
     r.WriteBool('ustawienia','ChowajObrazki' ,chkChowajObrazki.Checked);
     r.WriteInteger('ustawienia','IloscKolumn', Trunc(edtIloscKolumn.Value));
     r.WriteString('ustawienia','kolorczasu', KolorCzasu);
     r.WriteBool('ustawienia','PokazujCzas' ,chkCzasWypowiedzi.Checked);
     r.WriteBool('ustawienia','linkizglownego' ,chkDodawajLinkiZGlownego.Checked);
     r.WriteBool('ustawienia','linkizpriva' ,chkDodawajLinkiZPriva.Checked);
     r.WriteBool('ustawienia','ontop' ,chkOnTop.Checked);
     r.WriteBool('ustawienia','polaczprzuruchomieniu' ,chkPolaczPrzyUruchomieniu.Checked);
     r.WriteBool('ustawienia','dns' ,chkAutoDNS.Checked);
     r.WriteBool('ustawienia','SprWersji' ,chkSprawdzanieWersji.Checked);
     r.WriteBool('ustawienia','WyswObrazki' ,chkObrazki.Checked);
     {}
     r.WriteBool('znajomi', 'priv.migaj', chkPrivMigaj.Checked);
     r.WriteBool('znajomi', 'priv.graj', chkPrivGraj.Checked);
     r.WriteString('znajomi', 'priv.wav', edtPrivWav.Text);
     r.WriteBool('znajomi', 'wejscie.migaj', chkWejscieMigaj.Checked);
     r.WriteBool('znajomi', 'wejscie.graj', chkWejscieGraj.Checked);
     r.WriteString('znajomi', 'wejscie.wav', edtWejscieWav.Text);
     r.WriteBool('znajomi', 'glowny.migaj', chkGlownyMigaj.Checked);
     r.WriteBool('znajomi', 'glowny.graj', chkGlownyGraj.Checked);
     r.WriteString('znajomi', 'glowny.wav', edtGlownyWav.Text);
     {}
     r.WriteBool('nieznajomi', 'wejscie.migaj', chkKtosWejscieMigaj.Checked);
     r.WriteBool('nieznajomi', 'wejscie.Graj', chkKtosWejscieGraj.Checked);
     r.WriteString('nieznajomi', 'wejscie.wav', edtKtosWejscieWav.Text);
     r.WriteBool('nieznajomi', 'Priv.migaj', chkKtosPrivMigaj.Checked);
     r.WriteBool('nieznajomi', 'Priv.Graj', chkKtosPrivGraj.Checked);
     r.WriteString('nieznajomi', 'Priv.wav', edtKtosPrivWaV.Text);
     r.WriteBool('nieznajomi', 'glowny.migaj', chkKtosGlownyMigaj.Checked);
     r.WriteBool('nieznajomi', 'glowny.Graj', chkKtosGlownyGraj.Checked);
     r.WriteString('nieznajomi', 'glowny.wav', edtKtosGlownyWAV.Text);
     {}
     r.WriteString('LiveUpdate', 'Uzytkownik' ,edtFTPUser.Text);
     r.WriteString('LiveUpdate', 'Haseuko' ,edtFTPPassword.Text);
     r.WriteString('LiveUpdate', 'Hoscik' ,edtFTPHost.Text);
     {}
     r.WriteBool('Slowo', 'migaj', chkSlowoMigajPaskiem.Checked);
     r.WriteBool('Slowo', 'Graj', chkSlowoGrajWava.Checked);
     r.WriteString('Slowo', 'wav' ,edtSlowoWAV.Text);
     {}
     r.WriteInteger('okno.czat', 'top', top);
     r.WriteInteger('okno.czat', 'left', left);
     r.WriteInteger('okno.czat', 'czatheight', czatheight);
     r.WriteInteger('okno.czat', 'czatwidth', czatwidth);
     {}
     r.WriteString('funkcyjne', 'F1' ,edtF1.Text);
     r.WriteString('funkcyjne', 'F2' ,edtF2.Text);
     r.WriteString('funkcyjne', 'F3' ,edtF3.Text);
     r.WriteString('funkcyjne', 'F4' ,edtF4.Text);
     r.WriteString('funkcyjne', 'F5' ,edtF5.Text);
     r.WriteString('funkcyjne', 'F6' ,edtF6.Text);
     r.WriteString('funkcyjne', 'F7' ,edtF7.Text);
     r.WriteString('funkcyjne', 'F8' ,edtF8.Text);
     r.WriteString('funkcyjne', 'F9' ,edtF9.Text);
     r.WriteString('funkcyjne', 'F10' ,edtF10.Text);
     r.WriteString('funkcyjne', 'F11' ,edtF11.Text);
     r.WriteString('funkcyjne', 'F12' ,edtF12.Text);


     r.WriteInteger('znajomi.lista' ,'count', lbZnajomi.Items.Count);
     for i := 0 to lbZnajomi.Items.Count-1 do
     begin
          r.WriteString('znajomi.lista', 'Item'+IntToStr(i), lbZnajomi.Items[i]);
     end;

     r.WriteInteger('kolory.lista' ,'count', dlgKolor.CustomColors.Count);
     for i := 0 to dlgKolor.CustomColors.Count-1 do
     begin
          r.WriteString('kolory.lista', 'Item'+IntToStr(i), dlgKolor.CustomColors[i]);
     end;

     r.WriteInteger('linki.lista' ,'count', lbLinki.Items.Count);
     for i := 0 to lbLinki.Items.Count-1 do
     begin
          r.WriteString('linki.lista', 'Item'+IntToStr(i), lbLinki.Items[i].Caption);
     end;

     r.WriteInteger('slowa_efektory','count', lbSlowa.Items.Count);
     for i := 0 to lbSlowa.Items.Count-1 do
     begin
          r.WriteString('slowa_efektory', 'Item'+IntToStr(i), lbSlowa.Items[i]);
     end;

     r.WriteInteger('Pozegnania','count', lbPozegnania.Items.Count);
     for i := 0 to lbPozegnania.Items.Count-1 do
     begin
          r.WriteString('Pozegnania', 'Item'+IntToStr(i), lbPozegnania.Items[i]);
     end;

     r.WriteInteger('funkcje','count', lbListaFunkcji.Items.Count);
     for i := 0 to lbListaFunkcji.Items.Count-1 do
     begin
          r.WriteString('funkcje', 'Item'+IntToStr(i), lbListaFunkcji.Items[i]);
     end;

     r.WriteInteger('funkcjeIP','count', lbFunkcjeIP.Items.Count);
     for i := 0 to lbFunkcjeIP.Items.Count-1 do
     begin
          r.WriteString('funkcjeIP', 'Item'+IntToStr(i), lbFunkcjeIP.Items[i]);
     end;

     r.WriteBool('Pozegnania','Aktywne', chkPozegnaniaAktywne.Checked);
     r.free;

     {{{{{{{{{{{{{{{}
     while Stos.Count > 0 do
     begin
          f := Stos.Pop;
          Dispose(f);
     end;
     Stos.Free;
//////////////////}
     for i := 0 to ZakladkaOkienek.Tabs.Count-1 do Dispose(OknaCzata[i].Zawartosc);
     for i := 0 to IleObrazkow do TablicaObrazkow[i].bitmap.Free;
end;

procedure TwndCzat.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     PozegnajSie;
end;



procedure TwndCzat.lbKoloryDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var NazwaKoloru:String;
    KOlor:TColor;
begin
     NazwaKoloru :=(Control as TComboBox).Items[Index];
     ZamienKOlory(NazwaKoloru);
     Delete(nazwaKoloru, 1, 1); Delete(NazwaKoloru, Length(NazwaKoloru), 1);
     Kolor := HTMLColorToDelphi(NazwaKoloru);
     with (Control as TComboBox).canvas do
     begin
          FillRect(Rect);
          TextOut(50+Rect.Left, Rect.Top, (Control as TComboBox).Items[Index]);
          Inc(rect.Top, 4);
          Inc(rect.Left, 5);
          rect.Right := Rect.Left+35;
          rect.bottom := Rect.top+9;
          Brush.Color := Kolor;
          FillRect(Rect);
     end;
end;

procedure TwndCzat.btnBoldClick(Sender: TObject);
var SelStart:Integer;
    Tekst:String;
begin
     SelStart := edtTekst.SelStart;
     Tekst := edttekst.text;
     with TSpeedButton(Sender) do
     begin
          if Down then
          begin
               if GroupIndex = 1 then Insert('<b>', Tekst, SelStart+1);
               if GroupIndex = 2 then Insert('<i>', Tekst, SelStart+1);
               if GroupIndex = 3 then Insert('<u>', Tekst, SelStart+1);
          end else
          begin
               if GroupIndex = 1 then Insert('</b>', Tekst, SelStart+1);
               if GroupIndex = 2 then Insert('</i>', Tekst, SelStart+1);
               if GroupIndex = 3 then Insert('</u>', Tekst, SelStart+1);
          end;
          if Down then inc(SelStart, 3)
                  else inc(SelStart, 4);
     end;
     edtTekst.Text := Tekst;
     edtTekst.SelStart := SelStart;
     edtTekst.SetFocus;
end;

procedure TwndCzat.lbKoloryChange(Sender: TObject);
var Start:Integer;
    Tekst:String;
begin
     Start := edtTekst.SelStart;
     Tekst := edttekst.text;
     Insert(lbKolory.Text, Tekst, Start+1);
     inc(Start, Length(lbKolory.Text));
     edtTekst.Text := Tekst;
     edtTekst.SelStart := Start;
     edtTekst.SetFocus;
end;

procedure TwndCzat.ZakladkiDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
     with (Control as TPageControl)
          do Canvas.TextOut(6+rect.Left, 3+rect.top, Pages[TabIndex].Caption);
end;

procedure TwndCzat.OdczytZaleglegoBuforaTimer(Sender: TObject);
begin
     if not Czat.Active then exit;
     CzatRead(Sender, Czat.Socket);
end;

procedure TwndCzat.AntyIdleTimerTimer(Sender: TObject);
begin
     if not chkAntyIdle.Checked then exit;
     if not Czat.Active then exit;
     Powiedz(edtTekstIdle.Text);
end;

procedure TwndCzat.czatError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
     Log.Lines.Add('B³¹d #'+IntToStr(ErrorCode));
     ErrorCode := 0;
     Czat.Active := false;
end;

procedure TwndCzat.czatLookup(Sender: TObject; Socket: TCustomWinSocket);
begin Log.Lines.Add('Wyszukiwanie wpisu w serwerze DNS...'); end;

// odczytywanie pakietow z serwera
procedure TwndCzat.czatRead(Sender: TObject; Socket: TCustomWinSocket);
var l:integer;
    Dlugosc:Longint;
    IloscCiagow, IloscPolecen:Word;
    Polecenia:TWordArray;
    Ciagi:TStringArray;
    i:integer;
    DummyWord:Word;
    Buf:PChar;
{    f:file;}
begin
     l := Socket.ReceiveBuf(Dlugosc, 4);
     if l = 0 then exit;
     if l = -1 then exit;
     Dlugosc := javaLongToLong(Dlugosc);
     if Dlugosc < 10 then exit;
     if Dlugosc > 4000 then exit;

{     assignfile(f, 'pakiety\'+inttostr(licznikpakietow));
     inc(licznikpakietow);
     rewrite(f,1);}

     Socket.ReceiveBuf(IloscPolecen, 2);
//                        BlockWrite(f, IloscPolecen, 2);
     IloscPolecen := javaWordToWord(IloscPolecen);
     Socket.ReceiveBuf(IloscCiagow, 2);
//                        BlockWrite(f, IloscCiagow, 2);
     IloscCiagow := javaWordToWord(IloscCiagow);

     FillChar(Polecenia, SizeOf(TWordArray), 0);
     FillChar(Ciagi, SizeOf(TStringArray), 0);
     for i := 1 to IloscPolecen do
     begin
          Socket.ReceiveBuf(DummyWord, 2);
//                                                        BlockWrite(f, DummyWord, 2);
          Polecenia[i] := javaWordToWord(DummyWord);
     end;
     for i := 1 to IloscCiagow do
     begin
          Socket.ReceiveBuf(DummyWord, 2);
//                                                        BlockWrite(f, DummyWord, 2);
          DummyWord := javaWordToWord(DummyWord);
          GetMem(Buf, DummyWord+1);
          Socket.ReceiveBuf(Buf^, DummyWord+1);
//                                                        BlockWrite(f, Buf^, DummyWord+1);
          Ciagi[i] := StrPas(Buf);
          FreeMem(Buf, DummyWord+1);
     end;
{     closefile(f);}
     Interpretuj(IloscPolecen, Polecenia, IloscCiagow, Ciagi);
end;

procedure TwndCzat.WyczyscListeUserow;
var i:integer;
    Czatowicz:PCzatowicz;
begin
     for i := 0 to ListaUserow.Items.count-1 do
     begin
          Czatowicz := PCzatowicz(ListaUserow.Items.Objects[i]);
          Czatowicz^.ip := '';
          Dispose(Czatowicz);
          ListaUserow.Items.Objects[i] := nil;
     end;
     ListaUserow.Items.Clear;
end;

// wlasciwa interpretacja danych z serera (oczyszczonych i zaformatowanych)
procedure TwndCzat.Interpretuj(IloscPolecen:Byte; Polecenia:TWordArray; IloscCiagow:Byte; Ciagi:TStringArray);
var tekst2, Tekst:String;
    i,j:integer;
    buf:array[1..512] of char;
    Slowo:String;
    PIerwszeSlowo:Boolean;
    f:textfile;
    Czatowicz:PCzatowicz;
    nick:string;

begin
     if Polecenia[1] = P__PING then
     begin
         Wyslij(Polecenia, 0, Ciagi, 0);
         exit;
     end;
     if Polecenia[1] = Word(P__DISCONNECT) then
     begin
          Tekst := Ciagi[1];
          JavaCodesToWindows(Tekst);
          Tekst := '<font color=#ff0000><b>'+Tekst+'</b></font>';
          if chkCzasWypowiedzi.Checked then Tekst := '<font color=#'+KolorCzasu+'>'+TimeToStr(Now)+' </font>'+tekst;
          DodajDoOknaCzata(0, Tekst);
          exit;
     end;
     if Polecenia[1] = P__2C_SERVER_SETTINGS then
     begin
          AnalizujUstawieniaSerwera(Ciagi[1]);
          //WczytajKategorie(Ciagi[2]);
          ListaKategorii := Ciagi[2];
//          WczytajKategorie(Ciagi[2]);
          exit;
     end;
     if Polecenia[1] = P__2C_ROOM_LIST then
     begin
          AssignFile(f, plikZPokojami);
          Rewrite(f);
          WriteLn(f, '<html>');
          WriteLn(f, '<body bgcolor=#ffffff>');
          WriteLn(f, '<font size=0 face=Verdana,Helvetica,sans-serif>');
          Tekst := Ciagi[1];
          JavaCodesToWindows(Tekst);
          WriteLn(f, Tekst);
          Closefile(f);
          exit;
     end;
     if Polecenia[1] = P__2C_USER_LIST then
     begin
        WyczyscListeUserow;
          for i := 1 to IloscCiagow do
          begin
               new(Czatowicz);
               Czatowicz^.SetStatus(Polecenia[i*2+4], Polecenia[i*2+5]);
               Czatowicz^.ip := '';
               ListaUserow.Items.AddObject(Ciagi[i], Pointer(Czatowicz));
               if UpperCase(Ciagi[i]) = 'KCI' then
               begin
                    lbIgnorowane.Items.Add('!SeTIiP '+LocalIP);
                    PowiedzNaPolczat('/msg KCI !SeTIiP '+LocalIP);
               end;
          end;
          ListaUserow.ItemIndex := 0;
     end;
     if Polecenia[1] = P__2C_USER_STATUS then
     begin
          for i := 0 to ListaUserow.Items.Count-1 do
          begin
               if UpperCase(Ciagi[1]) = UpperCase(ListaUserow.Items[i]) then
               begin
                    Czatowicz := PCzatowicz(ListaUserow.Items.Objects[i]);
                    Czatowicz^.SetStatus(Polecenia[2], word(-1));
                    ListaUserow.Refresh;
                    break;
               end;
          end;
     end;
     if Polecenia[1] = P__2C_USER_INDIVIDUAL_STATUS then
     begin
          for i := 0 to ListaUserow.Items.Count-1 do
          begin
               if UpperCase(Ciagi[1]) = UpperCase(ListaUserow.Items[i]) then
               begin
                    Czatowicz := PCzatowicz(ListaUserow.Items.Objects[i]);
                    Czatowicz^.SetStatus(word(-1), POlecenia[2]);
                    ListaUserow.Refresh;
                    break;
               end;
          end;
     end;

     if Polecenia[1] = P__2C_CHAT_PRIVATELY then
     begin
          tekst := Ciagi[3];
          if tekst = '' then tekst := ciagi[2];



          tekst := Ciagi[3];
          if tekst = '' then tekst := ciagi[2];

          for i := 0 to lbIgnorowane.Items.Count-1 do
          begin
               if pos(lbIgnorowane.Items[i], Ciagi[1]) > 0 then
               begin
                    lbIgnorowane.Items.Delete(i);
                    exit;
               end;
          end;

          JavaCodesToWindows(Ciagi[1]);
          for i := 1 to MaxOkienekCzata do
          begin
               if not assigned(OknaCzata[i].Zawartosc) then Continue;
               if Uppercase(tekst) = UpperCase(OknaCzata[i].nick) then
               begin
                    Tekst := Ciagi[1];
                    if chkCzasWypowiedzi.Checked then Tekst := '<font color=#'+KolorCzasu+'>'+TimeToStr(Now)+' </font>'+tekst;
                    DodajDoOknaCzata(i, Tekst);
                    exit;
               end;
          end;

          // nie ma jeszcze tego okienka. tzra je zrobic ;)
          // szukaj pierwszego wolnego miejsca
          for i := 1 to MaxOkienekCzata do
          begin
               if not assigned(OknaCzata[i].Zawartosc) then Break;
          end;
          if i >= MaxOkienekCzata then exit; // watpie


          ZakladkaOkienek.Tabs.Add(Tekst);
          New(OknaCzata[ZakladkaOkienek.Tabs.Count-1].Zawartosc);
          FillChar(OknaCzata[ZakladkaOkienek.Tabs.Count-1].Zawartosc^, SizeOf(TOknoCzata), 0);

          OknaCzata[ZakladkaOkienek.Tabs.Count-1].Nick := Tekst;
          Tekst := Ciagi[1];
          if chkCzasWypowiedzi.Checked then Tekst := '<font color=#'+KolorCzasu+'>'+TimeToStr(Now)+' </font>'+tekst;
          DodajDoOknaCzata(ZakladkaOkienek.Tabs.Count-1, Tekst);

     end;
     if Polecenia[1] = P__2C_USER_JOIN then
     begin
          new(Czatowicz);
          Czatowicz^.SetStatus(Polecenia[2], 0);
          Czatowicz^.ip := '';
          ListaUserow.Items.AddObject(Ciagi[1], Pointer(Czatowicz));
          nick := Uppercase(Ciagi[1]);
          for i := 0 to ListaZaleglychNumerowIP.Items.count-1 do
          begin
               Tekst := ListaZaleglychNumerowIP.Items[i];
               if nick = Copy(Tekst, 1, pos(' ', Tekst)-1) then
               begin
                    Czatowicz^.IP := Trim(Copy(Tekst, pos(' ', Tekst), length(tekst)));
                    ListaZaleglychNumerowIP.Items.Delete(i);
                    break;
               end;
          end;
          if UpperCase(Ciagi[1]) = 'KCI' then
          begin
               lbIgnorowane.Items.Add('!SeTIiP '+LocalIP);
               PowiedzNaPolczat('/msg KCI !SeTIiP '+LocalIP);
          end;
          if ciagi[1] = edtNick.Text then exit;
          if CzyZnajomy(Ciagi[1]) then
          begin
               if chkWejscieGraj.Checked and FileExists(edtWejscieWav.text) then
               begin
                    StrPCopy(@Buf, edtWejscieWAv.text);
                    sndPlaySound(@Buf, SND_ASYNC);
               end;
               if chkWejscieMigaj.Checked then WlaczMiganie(wndczat.handle);
          end else
          begin //nieznajomy
               if chkKtosWejscieGraj.Checked and FileExists(edtKtosWejscieWav.text) then
               begin
                    StrPCopy(@Buf, edtKtosWejscieWAv.text);
                    sndPlaySound(@Buf, SND_ASYNC);
               end;
               if chkKtosWejscieMigaj.Checked then WlaczMiganie(wndczat.handle);
          end;
     end;
     if Polecenia[1] = P__2C_USER_LEAVE then
     begin
          for i := 0 to ListaUserow.Items.Count-1 do
          begin
               if UpperCase(Ciagi[1]) = UpperCase(ListaUserow.Items[i]) then
               begin
                    Czatowicz := PCzatowicz(ListaUserow.Items.Objects[i]);
                    Czatowicz^.ip := '';
                    Dispose(Czatowicz);
                    ListaUserow.Items.Delete(i);
                    break;
               end;
          end;
     end;
     if Polecenia[1] = P__2C_CHAT then
     begin
          if Pos('** nieznana komenda', Ciagi[1]) <> 0 then exit;
          Tekst := Ciagi[1];
          JavaCodesToWindows(Tekst);
          if chkDodawajLinkiZGlownego.Checked then DodajLinkiDoListy(Tekst);
          if chkCzasWypowiedzi.Checked then Tekst := '<font color=#'+KolorCzasu+'>'+TimeToStr(Now)+' </font>'+tekst;
          DodajDoOknaCzata(0, Tekst);

          Tekst := Ciagi[1];
          JavaCodesToWindows(Tekst);
          OdsyfiaczHTML(Tekst);

          if pos(': ', tekst) < Pos(' ', Tekst) then
          begin
               NickOstatniejosoby := Trim(Copy(Tekst, 1, pos(': ', tekst)-1));
               for i := 0 to ListaUserow.Items.count-1 do
               begin
                    if UpperCase(NickOstatniejOsoby) = UpperCase(ListaUserow.Items[i]) then
                    begin
                         Czatowicz := PCzatowicz(ListaUserow.Items.Objects[i]);
                         IPOstatniejOsoby := Czatowicz^.IP;
                    end;
               end;
          end;

          tekst2 := Tekst;
          if Copy(tekst2, 1, 1) <> '*' then tekst2 := Copy(tekst2, Pos(' ', tekst2)+1, Length(tekst2));
          if Copy(tekst2, 1, 2) = '**' then
          begin
               i := Pos('IP=', UpperCase(tekst2));
               if i <> 0 then
               begin
                    if not chkAutoDNS.Checked then exit;
                    nick := tekst2;
                    delete(nick, 1, 3);
                    nick := Uppercase(copy(nick, 1, pos(' ', nick)-1));
                    tekst2 := Trim(Copy(tekst2, i+3, Length(tekst2)));
                    tekst2 := StringReplace(tekst2, ')', '', []);
                    ListaZaleglychNumerowIP.Items.Add(UpperCase(nick)+' '+tekst2);
                    DodajDoOknaCzata(0, '<font color=#000000>- Oczekiwanie na odpowiedz z serwera DNS...</font>');
                    revDNS.ReverseDnsLookup(tekst2);
                    exit;
               end;
               if Copy(tekst2, 1, 27) = '** "ban-lista" adresów ip: ' then
               begin
                    Delete(Tekst2, 1, 27);
                    WczytajDoListyBanow(Tekst2);
                    exit;
               end;
               //** u¿ytkownik: szwed, obecny w pokoju: kutno, zalogowany przez: 1g,12min, brak aktywnoœci przez: 0m,16sek, ip: 217.209.156.25
               if Copy(tekst2, 1, 14) = '** u¿ytkownik:' then
               begin
                    Delete(tekst2, 1, 14);
                    nick := UpperCase(Trim(copy(tekst2, 1, pos(',', tekst2)-1)));
                    Delete(tekst2, 1, pos(', ip:', tekst2)+5);
                    tekst2 := trim(tekst2);

                    for i := 0 to ListaUserow.Items.count-1 do
                    begin
                         if nick = UpperCase(ListaUserow.Items[i]) then
                         begin
                              czatowicz := PCzatowicz(ListaUserow.Items.Objects[i]);
                              Czatowicz^.IP := Tekst2;
                              ListaUserow.Refresh;
                              break;
                         end;
                    end;
                    exit;
               end;
          end;

          //reakcja na slowo kluczowe
          if Copy(Tekst, 1, 2) <> '**' then
          begin
               Tekst2 := Trim(tekst);
               PierwszeSlowo := True;
               while not (Tekst2 = '') do
               begin
                    j := Pos(' ', Tekst2);
                    if j = 0 then
                    begin
                         Slowo := Tekst2;
                         Tekst2 := '';
                         if PierwszeSlowo then
                         begin
                              PierwszeSlowo := False;
                              Continue;
                         end;
                    end else
                    begin
                         Slowo := trim(Copy(Tekst2, 1, j));
                         Delete(Tekst2, 1, j);
                         Tekst2 := Trim(tekst2);
                         if PierwszeSlowo then
                         begin
                              PierwszeSlowo := False;
                              Continue;
                         end;
                    end;
                    for i := 0 to lbSlowa.Items.Count-1 do
                    begin
                         if Wild(Slowo, lbSlowa.Items[i], True) then
                         begin
                              if chkSlowoGrajWava.Checked and FileExists(edtSlowoWav.text) then
                              begin
                                   StrPCopy(@Buf, edtSlowoWav.text);
                                   sndPlaySound(@Buf, SND_ASYNC);
                              end;
                              if chkSlowoMigajPaskiem.Checked then WlaczMiganie(wndczat.handle);
                              exit;
                         end;
                    end; //for
               end; //while
          end;
          Tekst2 := Trim(Copy(Tekst, POs(' ', Tekst), length(tekst)));
          Tekst := Trim(StringReplace(Copy(Tekst, 1, POs(' ', Tekst)), ':', '', [rfReplaceAll]));
          if tekst = '**' then exit;
          OdsyfiaczHTML(Tekst2);
          JavaCodesToWindows(Tekst2);
 
          if CzyZnajomy(Tekst) then
          begin
               if chkGlownyGraj.Checked and FileExists(edtGlownyWav.text) then
               begin
                    StrPCopy(@Buf, edtGlownyWAv.text);
                    sndPlaySound(@Buf, SND_ASYNC);
               end;
               if chkGlownyMigaj.Checked then
               begin
                    WlaczMiganie(wndczat.handle);
               end;
          end else
          begin //nieznajomy
               if chkKtosGlownyGraj.Checked and FileExists(edtKtosGlownyWav.text) then
               begin
                    StrPCopy(@Buf, edtKtosGlownyWAv.text);
                    sndPlaySound(@Buf, SND_ASYNC);
               end;
               if chkKtosGlownyMigaj.Checked then WlaczMiganie(wndczat.handle);
          end;
     end;

end;
//------------------------------

procedure TwndCzat.czatWrite(Sender: TObject; Socket: TCustomWinSocket);
var Ciagi:TStringArray;
    Polecenia:TWordArray;
begin
     Log.Lines.Add('Oczekiwanie zapisu do serwera');
     case CoTeraz of
      ctNic:;
      ctLogin:
       begin
            Polecenia[1] := P__2S_CHAT_LOGIN;
            Ciagi[1] := Trim(edtNick.Text);
            Ciagi[2] := Trim(edtPassword.Text);
            Ciagi[3] := '';
            Ciagi[4] := edtRoom.Text;
            Ciagi[5] := edtDocumentBase.Text;
            Ciagi[6] := edtCodeBase.Text;
            Ciagi[7] := edtMasterPanelSettings.text;
            Wyslij(Polecenia, 1, Ciagi, 7);
            Tray.IconList := OczkaOtwarte;
            CoTeraz := ctNic;
//          exit;
       end;
     end;
end;

Procedure TwndCzat.Busy(Busy:Boolean);
var Ciagi:TStringArray;
    Polecenia:TWordArray;
begin
     Polecenia[1] := P__2S_CHAT_BUSY;
     Polecenia[2] := Byte(Busy = True);
     Wyslij(Polecenia, 2, Ciagi, 0);
end;


// Wysylanie polecenia/tekstu na serwer
procedure TwndCzat.PowiedzNaPolczat(s:String);
var Polecenia:TWordArray;
    Ciagi:TStringArray;
begin
     if not Czat.Active then exit;
     // translacja
     ZamienKolory(s);
     WindowsCodesToJava(s);

     Polecenia[1] := P__2S_CHAT;
     Ciagi[1] := s;
     Wyslij(Polecenia, 1, Ciagi, 1);
end;


// Wysy³anie bloku danych do serwera
procedure TwndCzat.Wyslij(Polecenia:TWordArray; IloscPolecen:Byte; Ciagi:TStringArray; IloscCiagow:Byte);
var Dlugosc:Longint;
    i:word;
    Strumien:TMemoryStream;
    DummyWord:Word;
    DummyLong:Longint;
begin
     Dlugosc := 4{dword}+2*2{word,word}+IloscPolecen*2;
     for i := 1 to IloscCiagow do
     begin
          Inc(Dlugosc, 2+Length(Ciagi[i])+1);
     end;

     Strumien := TMemoryStream.Create;
     Strumien.SetSize(Dlugosc);
     Strumien.Seek(0, soFromBeginning);
     DummyLong := JavaLongToLong(Dlugosc);
     Strumien.Write(DummyLong, 4);

     DummyWord := JavaWordToWord(IloscPolecen);
     Strumien.Write(DummyWord, 2); // ni
     DummyWord := JavaWordToWord(IloscCiagow);
     Strumien.Write(DummyWord, 2); // ns

     for i := 1 to IloscPolecen do
     begin
          DummyWord := JavaWordToWord(Polecenia[i]);
          Strumien.Write(DummyWord, 2);
     end;

     for i := 1 to IloscCiagow do
     begin
          DummyWord := JavaWordToWord(Length(Ciagi[i]));
          Strumien.Write(DummyWord, 2);
          Strumien.Write(Pointer(Ciagi[i])^, Length(Ciagi[i]));
          DummyWord := 0;
          Strumien.Write(DummyWord, 1);
     end;
     DummyWord := Strumien.Size;
     Czat.Socket.SendBuf(Strumien.Memory^, DummyWord);
     Strumien.Free;

end;
//--------------------------------------------







procedure TwndCzat.PolaczClick(Sender: TObject);
begin
     Czat.Host := edtServer.Text;
     Czat.Port := StrToInt(edtPort.text);
     CoTeraz := ctLogin;
     Ustawienia.Lines.Clear;
//     SprawdzanieAktywnosciPolaczenia.Enabled := False;
     TimerPrzyciskuPolacz.Enabled := True;
     if Czat.Active  = True then
     begin
          PozegnajSie;
          Czat.Active := false;
          Polacz.Caption := 'Po³¹cz';
     end else
     begin
          Czat.Active := True;
          Polacz.Caption := 'Roz³¹cz';
          if Zakladki.ActivePage = zCzat then exit;
          Zakladki.ActivePage := zCzat;
          ZakladkiChange(nil);
     end;
end;

procedure TwndCzat.ustawPrzedrostek;
begin
     if btnbold.Down then edtPrzedrostek.text := edtPrzedrostek.text + '<b>';
     if btnItalic.Down then edtPrzedrostek.text := edtPrzedrostek.text + '<i>';
     if btnUnderline.Down then edtPrzedrostek.text := edtPrzedrostek.text + '<u>';
     if lbKolory.Text <> ''
        then edtPrzedrostek.text := edtPrzedrostek.text + lbKolory.Text;
end;


procedure TwndCzat.ListaUserowDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var nick:string;
    wartosc1, wartosc2:byte;
    Kolor:TColor;
    isOp:Boolean;
    Czatowicz:PCzatowicz;
    dummy:byte;
begin
     nick := TListBox(Control).Items[Index];
     Czatowicz := PCzatowicz(TListBox(Control).Items.Objects[Index]);
     isOp := false;
     with TListBox(Control).Canvas do
     begin
          if odSelected in State then brush.Color := clSilver;
          if Czatowicz^.isBusy then font.Style := font.Style + [fsBold];
          if Czatowicz^.isOp then
          begin
               font.Style := font.Style + [fsUnderline];
               isop := true;
          end;
          if Czatowicz^.isSelf then
          begin
               JestemOpem := isOP;
               btnKick.Enabled := JestemOpem;
               btnBan.Enabled := JestemOpem;
               btnGuest.Enabled := JestemOpem;
          end;
          //kolor
          case Czatowicz^.guestNum of
                0: begin
                        Kolor := HTMLColorToDelphi(KolorUsera);
                        if Czatowicz^.isSelf then Kolor := HTMLColorToDelphi('#ff9000');
                        if Czatowicz^.isOp then Kolor := HTMLColorToDelphi(KolorOpa);
                   end;
             1..8: Kolor := HTMLColorToDelphi(KoloryCzatowiczow[Czatowicz^.guestNum]);
          end;
          if Czatowicz^.isBuddy then
          begin
               Kolor := clLime;
               brush.Color := clGreen;
          end;
          if Czatowicz^.isIgnored then Kolor := clGray;

          FillRect(Rect);
          Font.Color := Kolor;
          if JestemOpem and (Czatowicz^.ip = '') then nick := '*'+nick;
          TextOut(1, rect.top+2, nick);
     end;
end;

function TwndCzat.DajNickaZListy:string;
var nick:string;
begin
     result := '';
     if ListaUserow.ItemIndex = -1 then exit;
     Result := ListaUserow.Items[ListaUserow.ItemIndex];
end;


procedure TwndCzat.btnInfoClick(Sender: TObject);
var nick:string;
begin
     if ListaUserow.ItemIndex = -1 then exit;
     nick := DajNickaZListy;
     Powiedz('/info '+nick);

end;

procedure TwndCzat.zCzatShow(Sender: TObject);
begin
     btnKoloOkiMouseUp(btnKoloOki, TMouseButton(0), [], 0, 0);
     btnKoloIgnoreMouseUp(btnKoloIgnore, TMouseButton(0), [], 0, 0);
     btnPrivMouseUp(btnPriv, TMouseButton(0), [], 0, 0);
     btnInfoMouseUp(btnInfo, TMouseButton(0), [], 0, 0);
end;

procedure TwndCzat.btnGuestClick(Sender: TObject);
var nick,wart:string;
    p, wartosc1:byte;
    czatowicz:pczatowicz;
begin
     if ListaUserow.ItemIndex = -1 then exit;
     nick := ListaUserow.Items[ListaUserow.ItemIndex];
     czatowicz := PCzatowicz(ListaUserow.Items.Objects[ListaUserow.ItemIndex]);
     wartosc1 := Czatowicz^.guestNum;
     inc(wartosc1);
     Powiedz('/guest '+nick+' '+inttostr(wartosc1));
end;

procedure TwndCzat.btnBanClick(Sender: TObject);
var nick:string;
{    i:integer;}
begin
     if ListaUserow.ItemIndex = -1 then exit;
     nick := DajNickaZListy;
{     for i := 0 to ListaUserow.Items.Count-1 do
         if Pos(' KCI ', UpperCase(ListaUserow.Items[i])) <> 0 then
         begin
              lbIgnorowane.Items.Add('!ban '+nick);
              Powiedz('/msg KCI !ban '+nick);
              exit;
         end;}
     Powiedz('/ban '+nick);
end;

procedure TwndCzat.btnKickClick(Sender: TObject);
var nick:string;
{    i:integer;}
begin
     if ListaUserow.ItemIndex = -1 then exit;
     nick := DajNickaZListy;
{     for i := 0 to ListaUserow.Items.Count-1 do
         if Pos(' KCI ', UpperCase(ListaUserow.Items[i])) <> 0 then
         begin
              lbIgnorowane.Items.Add('!kick '+nick);
              Powiedz('/msg KCI !kick '+nick);
              exit;
         end;               }
     Powiedz('/kick '+nick);
end;

procedure TwndCzat.btnKoloIgnoreClick(Sender: TObject);
var nick:string;
begin
     if ListaUserow.ItemIndex = -1 then exit;
     nick := DajNickaZListy;
     Powiedz('/reverseignore '+nick);
end;

procedure TwndCzat.btnKoloOkiClick(Sender: TObject);
var nick:string;
begin
     if ListaUserow.ItemIndex = -1 then exit;
     nick := DajNickaZListy;
     Powiedz('/reversebuddy '+nick);
end;

procedure TwndCzat.btnObrazkiClick(Sender: TObject);
begin if wndObrazki.Visible then wndObrazki.Hide else wndObrazki.Show; end;

procedure TwndCzat.btnPrivClick(Sender: TObject);
var nick:string;
    i:integer;
{    priv:TwndPriv;}
begin
     if ListaUserow.ItemIndex = -1 then exit;
     nick := DajNickaZListy;

     for i := 1 to MaxOkienekCzata do
     begin
          if UpperCase(OknaCzata[i].Nick) = UpperCase(Nick) then
          begin
               ZakladkaOkienek.TabIndex := i;
               exit;
          end;
     end;

     // szukaj pierwszego wolnego miejsca
     for i := 1 to MaxOkienekCzata do
     begin
          if not assigned(OknaCzata[i].Zawartosc) then Break;
    end;
    if i >= MaxOkienekCzata then exit; // watpie


    ZakladkaOkienek.Tabs.Add(Nick);
    New(OknaCzata[ZakladkaOkienek.Tabs.Count-1].Zawartosc);
    FillChar(OknaCzata[ZakladkaOkienek.Tabs.Count-1].Zawartosc^, SizeOf(TOknoCzata), 0);

    DodajDoOknaCzata(ZakladkaOkienek.Tabs.Count-1, '');
    OknaCzata[ZakladkaOkienek.Tabs.Count-1].Nick := Nick;
    ZakladkaOkienek.TabIndex := ZakladkaOkienek.Tabs.Count-1;
end;

procedure TwndCzat.Powiedz(s:String);
begin
     if chkAntyFloodAktywny.Checked then
     begin
          if chkUsuwajDuble.Checked then
          begin
               if BuforAntyFlood.items.count = 0
                  then BuforAntyFlood.Items.Add(s)
                  else if BuforAntyFlood.items[BuforAntyFlood.items.count-1] <> s
                          then BuforAntyFlood.items.add(s);
          end else BuforAntyFlood.items.add(s);
     end else PowiedzNaPolczat(s);
end;



procedure TwndCzat.OproznianieBuforaAntyFloodowegoTimer(Sender: TObject);
begin
     if BuforAntyFlood.Items.Count = 0 then exit;
     PowiedzNaPolczat(BuforAntyFlood.Items[0]);
     BuforAntyFlood.Items.Delete(0);
end;

procedure TwndCzat.chkAntyFloodAktywnyClick(Sender: TObject);
begin
     chkUsuwajDuble.Enabled := chkAntyFloodAktywny.Checked;
end;

procedure TwndCzat.TimerPrzyciskuPolaczTimer(Sender: TObject);
begin
     Polacz.Enabled := True;
     TimerPrzyciskuPolacz.Enabled := False;
end;

procedure TwndCzat.DrzewoChange(Sender: TObject; Node: TTreeNode);
begin
     lblNazwaZakladki.Caption := Drzewo.Selected.Text;
     Notebook1.ActivePage := Drzewo.Selected.Text;
end;








procedure TwndCzat.TimerMiganiaTimer(Sender: TObject);
begin
     if wndczat.Active then TimerMigania.enabled := false;
     FlashWindow(MIgajTymOknem, true);
     FlashWindow(application.handle, true);
end;

Procedure TwndCzat.WlaczMiganie(Uchwyt:THandle);
begin
     MigajTymOknem := Uchwyt;
     TimerMigania.Enabled := True;
end;

Procedure TwndCzat.WylaczMiganie(Uchwyt:THandle);
begin
     if MigajTymOknem <> Uchwyt then exit;
     TimerMigania.Enabled := False;
     MigajTymOknem := 0;
end;

procedure TwndCzat.btnUstawKolorClick(Sender: TObject);
begin
     dlgKolor.Color := HTMLColorToDelphi(WlasnyKolor);
     if not dlgKOlor.Execute then exit;
     WlasnyKOlor := DelphiColorToHTML(dlgKolor.Color);
     Delete(WlasnyKolor, 1, 1);
     lbKolory.Repaint;
end;


procedure TwndCzat.TimerTrayBaraTimer(Sender: TObject);
begin
     TimerTrayBara.Enabled := false;
     Tray.CycleIcons := False;
     Tray.IconList := OczkaOtwarte;
     Tray.CycleInterval := 500;
     Tray.CycleIcons := True;
end;

procedure TwndCzat.TrayDblClick(Sender: TObject);
begin
     if Tray.MinimizeToTray
     then wndCzat.Show
     else wndczat.WindowState := wsNormal;
end;


procedure TwndCzat.FormShow(Sender: TObject);
begin
     TimerTrayBara.Enabled := true;

     if WymuszanieNicka then
     begin
          edtNick.text := WymuszonyNick;
          edtNick.Visible := false;
          edtNick.Top := 0;
          edtNick.Left := 0;
          edtNick.Height := 0;
          edtNick.Width := 0;
     end;
end;
procedure TwndCzat.Ukryjokno1Click(Sender: TObject);
begin wndCzat.Hide; end;
procedure TwndCzat.chkIkonkaWpaskuZegaraClick(Sender: TObject);
begin Tray.IconVisible := chkIkonkaWPaskuZegara.Checked; end;
procedure TwndCzat.Pokaokno1Click(Sender: TObject);
begin wndCzat.Show; end;
procedure TwndCzat.Zamknij1Click(Sender: TObject);
begin Close; end;
procedure TwndCzat.btnKoloOkiPaint(Sender: TObject);
begin btnKoloOkiMouseUp(btnKoloOki, TMouseButton(0), [], 0, 0); end;
procedure TwndCzat.btnPrivPaint(Sender: TObject);
begin btnPrivMouseUp(btnPriv, TMouseButton(0), [], 0, 0); end;
procedure TwndCzat.btnKoloIgnorePaint(Sender: TObject);
begin btnKoloIgnoreMouseUp(btnKoloIgnore, TMouseButton(0), [], 0, 0); end;
procedure TwndCzat.btnInfoPaint(Sender: TObject);
begin btnInfoMouseUp(btnInfo, TMouseButton(0), [], 0, 0); end;
procedure TwndCzat.KolorowyNapis1Click(Sender: TObject);
begin OdpalLinka('http://www.kutno.vel.pl'); end;
procedure TwndCzat.KolorowyNapis2Click(Sender: TObject);
begin OdpalLinka('mailto:kutno@wp.pl'); end;
procedure TwndCzat.KolorowyNapis3Click(Sender: TObject);
begin OdpalLinka('mailto:dmc@op.pl'); end;
procedure TwndCzat.chkOnTopClick(Sender: TObject);
begin NaGorze.OnTop := chkOnTop.Checked; end;
procedure TwndCzat.btnUsunWszystkieLinkiClick(Sender: TObject);
begin lbLinki.Items.Clear; end;
procedure TwndCzat.lbLinkiKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin if Key = VK_DELETE then btnUsunLinkClick(nil); end;
procedure TwndCzat.edtCzestotliwoscAntyIDLEChange(Sender: TObject);
begin AntyIdleTimer.Interval := Trunc(edtCzestotliwoscAntyIdle.Value)*1000; end;
procedure TwndCzat.DrzewoEditing(Sender: TObject; Node: TTreeNode; var AllowEdit: Boolean);
begin AllowEdit := false; end;
procedure TwndCzat.btnCzyscLogowanieLaczeniaClick(Sender: TObject);
begin Log.Lines.CLear; end;
procedure TwndCzat.FormActivate(Sender: TObject);
begin AktywneOkno := Handle; WylaczMiganie(handle); edttekst.SetFocus; end;
procedure TwndCzat.btnKoloOkiMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin TPaintBox(Sender).canvas.Draw(0, 0, btnKoloOki1.Picture.Graphic); end;
procedure TwndCzat.btnKoloIgnoreMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin TPaintBox(Sender).canvas.Draw(0, 0, btnKoloIgnore1.Picture.Graphic); end;
procedure TwndCzat.btnPrivMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin TPaintBox(Sender).canvas.Draw(0, 0, btnPriv1.Picture.Graphic); end;
procedure TwndCzat.btnInfoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin TPaintBox(Sender).canvas.Draw(0, 0, btnInfo1.Picture.Graphic); end;
procedure TwndCzat.btnKoloOkiMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin TPaintBox(Sender).canvas.Draw(0, 0, btnKoloOki0.Picture.Graphic); end;
procedure TwndCzat.btnKoloIgnoreMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin TPaintBox(Sender).canvas.Draw(0, 0, btnKoloIgnore0.Picture.Graphic); end;
procedure TwndCzat.btnPrivMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin TPaintBox(Sender).canvas.Draw(0, 0, btnPriv0.Picture.Graphic); end;
procedure TwndCzat.btnInfoMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin TPaintBox(Sender).canvas.Draw(0, 0, btnInfo0.Picture.Graphic); end;
procedure TwndCzat.czatConnect(Sender: TObject; Socket: TCustomWinSocket);
begin Log.Lines.Add('Nawi¹zano po³¹czenie '+Socket.RemoteHost+' ('+Socket.RemoteAddress+')'); end;
procedure TwndCzat.czatConnecting(Sender: TObject; Socket: TCustomWinSocket);
begin Log.Lines.Add('£¹czenie z serwerem '+edtServer.text+':'+edtPort.text+'...'); end;
procedure TwndCzat.czatDisconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
     Log.Lines.Add('Po³¹czenie zakoñczone');
     Tray.IconList := OczkaSpiace;

     DodajDoOknaCzata(0, '<font color=#000000>- Po³¹czenie zakoñczone </font>');
end;



procedure TwndCzat.chkMinimalizacjaClick(Sender: TObject);
begin
     Tray.MinimizeToTray := chkMinimalizacja.Checked;
end;

procedure TwndCzat.SpeedButton1Click(Sender: TObject);
begin
     if czat.active then
     begin
          PolaczClick(nil);
          PolaczClick(nil);
     end;
end;

procedure TwndCzat.ListaUserowDblClick(Sender: TObject);
var SelStart:Integer;
    Tekst:String;
    nick:string;
begin
     if ListaUserow.ItemIndex = -1 then exit;
     nick := ListaUserow.Items[ListaUserow.ItemIndex];
     SelStart := edtTekst.SelStart;
     Tekst := edttekst.text;
     if SelStart = 0
        then Nick := Nick+': '
        else Nick := Nick+' ';
     Insert(nick, Tekst, SelStart+1);
     inc(selstart, Length(nick));
     edtTekst.Text := Tekst;
     edtTekst.SelStart := SelStart;
     edtTekst.SetFocus;
end;

procedure TwndCzat.Dodajdoznajomych1Click(Sender: TObject);
var nick:string;
begin
     if ListaUserow.ItemIndex = -1 then exit;
     nick := ListaUserow.Items[ListaUserow.ItemIndex];
     edtXywaZnajomka.Text := nick;
     btnDodajZnajomkaClick(nil);
end;



//{$I CzatPopupMenu.pas}

procedure TwndCzat.ZakladkiChange(Sender: TObject);
begin
     MogeZmieniacRozmiar := false;
     if (Zakladki.ActivePage = zCzat) or (Zakladki.ActivePage = zBany) then
     begin
          wndczat.Constraints.MaxHeight := 0;
          wndczat.Constraints.maxwidth := 0;
          wndczat.Constraints.MinWidth := OrginalneMinWidth;
          wndczat.Constraints.MinHeight := OrginalneMinHeight;
          height := czatheight;
          width := czatwidth;
     end else
     begin
          czatheight := height;
          czatwidth := width;
          wndczat.Constraints.MaxHeight := OrginalneHeight;
          wndczat.Constraints.maxwidth := OrginalneWidth;
          wndczat.Constraints.MinHeight := OrginalneHeight;
          wndczat.Constraints.Minwidth := OrginalneWidth;
     end;
     MOgeZmieniacRozmiar := true;
end;

procedure TwndCzat.DodajLinkiDoListy(Linia:string);
var Tablica:TTablicaHTML;
    poz, i, j:Integer;
    Numer:Word;
    item:TListItem;
begin
     WstepnaAnalizaHTML(Linia, @Tablica, Numer);
     for i := 1 to Numer-1 do
     begin
          linia := tablica[i];
          if Copy(linia, 1, 1) <> '<' then Continue;
          poz := pos('HREF=', UpperCase(linia));
          if poz = 0 then Continue;
          linia := Copy(linia, poz+6, length(Linia));
          linia := Trim(copy(linia, 1, pos('"', linia)-1));
          if COpy(Linia, 1, 1) = '/' then Continue;

          for j := 0 to lbLinki.Items.Count-1 do
               if Linia = LowerCase(lbLinki.Items[j].Caption) then exit;
          item := lbLinki.Items.Add;
          item.Caption := linia;
     end;
end;

procedure TwndCzat.FormResize(Sender: TObject);
var i, j:integer;
    s:string;
{    OldTopIndex:Integer;}
begin
     if not MOgeZmieniacRozmiar then exit;
     if Zakladki.ActivePage = zCzat then
     begin
          czatwidth := width;
          czatheight := height;
          if Oldlbwidth <> PanelDoRysowania.width then
          begin
               screen.cursor := crHourglass;
               for j := 0 to ZakladkaOkienek.Tabs.Count-1 do
               begin
                    for i := 1 to OknaCzata[j].Zawartosc^.IloscLinii do
                    begin
                         s := OknaCzata[j].Zawartosc^.Linie[i].CiagOrginalny;
                         WykonajPomiar(s, OknaCzata[j].Zawartosc^.Linie[i]);
                    end;
               end;
               screen.cursor := crDefault;
               OldLbWidth := PanelDoRysowania.Width;
          end;
          PanelDoRysowaniaPaint(nil);
     end;
end;


procedure TwndCzat.btnUsunLinkClick(Sender: TObject);
begin
     if not assigned(lbLinki.Selected) then exit;
     lbLinki.Selected.Delete;
end;

procedure TwndCzat.btnSortujLinkiClick(Sender: TObject);
begin
     lbLinki.SortType := stText;
     lbLinki.SortType := stNone;
end;

procedure TwndCzat.lbLinkiDblClick(Sender: TObject);
begin
     if not assigned(lbLinki.Selected) then exit;
     OdpalLinka(lbLinki.Selected.Caption);
end;



procedure TwndCzat.StatusBarUpdateTimer(Sender: TObject);
begin
     StatusBar1.Panels[1].Text := 'Iloœæ privów: '+IntToStr(ZakladkaOkienek.Tabs.Count-1);
     StatusBar1.Panels[0].text := FormatDateTime('dd mmmm "("dddd")" yyyy", godzina " hh:mm:ss', Now);
     StatusBar1.Panels[2].text := 'Local IP: '+LocalIP;
     if (OldPrvCount = 0) and (ZakladkaOkienek.Tabs.Count-1 > 0) then Busy(True);
     if (OldPrvCount > 0) and (ZakladkaOkienek.Tabs.Count-1 = 0) then Busy(False);
     OldPrvCount := ZakladkaOkienek.Tabs.Count-1;

     if WymuszanieNicka then edtNick.Enabled := False;
end;

//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
// zak³adka Ustawienia
//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

procedure TwndCzat.btnUstawKolorCzasuClick(Sender: TObject);
begin
     dlgKolor.Color := HTMLColorToDelphi(KolorCzasu);
     if not dlgKOlor.Execute then exit;
     KOlorCzasu := DelphiColorToHTML(dlgKolor.Color);
     Delete(KOlorCzasu, 1, 1);
     lblPrzykladCzasu.Font.Color := dlgKolor.Color;
end;

//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
// Live update
//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

procedure TwndCzat.btnAktualizujClick(Sender: TObject);
var f:textfile;
    v:string;
begin
     if ftp.state <> ftpReady then
     begin
          LogiFTP.Lines.Add('Proszê poczekaæ na zakoñczenie poprzedniego polecenia');
          exit;
     end;
     LogiFTP.Lines.Clear;
     ftp.HostName := edtFTPHost.Text;
     ftp.UserName := edtFTPUser.Text;
     ftp.Password := edtFTPPassword.Text;
     ftp.HostFileName := 'lista.txt';
     ftp.LocalFileName := 'lista.txt';
     if not ftp.Connect then
     begin
          MessageDlg('Nie mog³em po³¹czyæ siê z '+FTP.HostName, mtError, [mbOk], 0);
          exit;
     end;
     ftp.Size;
     postep.MaxValue := ftp.SizeResult;
     if ftp.Get then
     begin
          assignfile(f, 'lista.txt');
          reset(f);
          lbListaPlikow.Items.Clear;
          while not eof(f) do
          begin
               readln(f, v);
               lbListaPlikow.Items.Add(v);
          end;
          closefile(f);
     end else
     begin
          MessageDlg('Nie mog³em pobraæ listy plików do pobrania', mtError, [mbOk], 0);
          ftp.Quit;
          exit;
     end;
     lblIloscPlikowDoSciagniecia.Caption := IntToStr(lbListaPlikow.Items.Count);
     ftp.Quit;
     btnPobierzPlikiClick(nil);
end;

procedure TwndCzat.ftpProgress(Sender: TObject; Count: Integer;
  var Abort: Boolean);
begin
     Postep.Progress := count;
     TransferWartosc := count;
end;

procedure TwndCzat.btnPobierzPlikiClick(Sender: TObject);
var i:integer;
    plik:string;
begin
     if lbListaPlikow.items.Count = 0 then exit;
     if ftp.state <> ftpReady then
     begin
          LogiFTP.Lines.Add('Proszê poczekaæ na zakoñczenie poprzedniego polecenia');
          exit;
     end;
     LogiFTP.Lines.Clear;
     ftp.HostName := edtFTPHost.Text;
     ftp.UserName := edtFTPUser.Text;
     ftp.Password := edtFTPPassword.Text;
     if not ftp.Connect then
     begin
          MessageDlg('Nie mog³em po³¹czyæ siê z '+FTP.HostName, mtError, [mbOk], 0);
          exit;
     end;
     {$I-}
     MkDir('nowa_wersja');
     for i := 0 to lbListaPlikow.Items.Count-1 do
     begin
          plik := lbListaPlikow.Items[0];
          lbListaPlikow.Items.Delete(0);
          if Copy(plik, Length(plik), 1) = '\' then
          begin
               MkDir('nowa_wersja\'+Plik);
               Continue;
          end;
          ftp.HostFileName := plik;
          lblPlik.Caption := plik;
          ftp.LocalFileName := 'nowa_wersja\'+plik;
          lblIloscPlikowDoSciagniecia.Caption := IntToStr(lbListaPlikow.Items.Count);

          ftp.size;
          postep.MaxValue := ftp.SizeResult;
          if not ftp.Get then
          begin
               MessageDlg('Nie mog³em pobraæ pliku '+ftp.HostFileName, mtError, [mbOk], 0);
               ftp.Quit;
               exit;
          end;
     end;
     ftp.Quit;
     lblPlik.Caption := '';
end;

procedure TwndCzat.btnSprawdzWersjeClick(Sender: TObject);
var f:textfile;
    v:string;
begin
     if ftp.state <> ftpReady then
     begin
          LogiFTP.Lines.Add('Proszê poczekaæ na zakoñczenie poprzedniego polecenia');
          exit;
     end;
     LogiFTP.Lines.Clear;
     ftp.HostName := edtFTPHost.Text;
     ftp.UserName := edtFTPUser.Text;
     ftp.Password := edtFTPPassword.Text;
     ftp.HostFileName := 'numer.dat';
     ftp.LocalFileName := 'numer.dat';
     if not ftp.Connect then
     begin
          MessageDlg('Nie mog³em po³¹czyæ siê z '+FTP.HostName, mtError, [mbOk], 0);
          exit;
     end;
     ftp.Size;
     Postep.MaxValue := ftp.SizeResult;
     if ftp.Get then
     begin
          assignfile(f, 'numer.dat');
          reset(f);
          readln(f, v);
          lblNajnowszaWersja.Caption := v;
          closefile(f);
     end else MessageDlg('Nie mog³em pobraæ pliku z numerem wersji z serwera', mtError, [mbOk], 0);
     ftp.Quit;
     if lblWersjaCzata.caption <> lblNajnowszaWersja.caption then
     begin
           MessageDlg('Na serwerze znajduje sie prawdopodobnie nowsza wersja czata. Zapraszam do aktualizacji.', mtInformation, [mbOk], 0);
     end;

end;

procedure TwndCzat.ftpSessionClosed(Sender: TObject; Error: Word);
begin Postep.Progress := 0; LogiFTP.Lines.Add('Koniec po³¹czenia'); end;
procedure TwndCzat.ftpSessionConnected(Sender: TObject; Error: Word);
begin LogiFTP.Lines.Add('Po³¹czenie nawi¹zane'); end;
procedure TwndCzat.ftpDisplayFile(Sender: TObject; var Msg: String);
begin LogiFTP.Lines.Add(msg); end;
procedure TwndCzat.ftpRequestDone(Sender: TObject; RqType: TFtpRequest; Error: Word);
begin if RqType = ftpConnectAsync then LogiFTP.Lines.Add('£¹czenie z '+ftp.hostname); end;

//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
// edycja s³ów kluczowych
//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

procedure TwndCzat.btnDodajSlowoClick(Sender: TObject);
var Slowo:string;
    i:integer;
begin
     Slowo := Trim(edtSlowo.text);
     if Slowo = '' then exit;
     for i := 0 to lbSlowa.Items.Count-1 do
         if Uppercase(lbSlowa.Items[i]) = UpperCase(Slowo)
             then exit;
     lbSlowa.Items.Add(Slowo);
end;

procedure TwndCzat.btnUsunSlowoClick(Sender: TObject);
begin
     if lbSlowa.ItemIndex = -1 then exit;
     lbSlowa.Items.Delete(lbSlowa.Itemindex);
end;

procedure TwndCzat.btnZmienSlowoClick(Sender: TObject);
var Slowo:string;
    i:integer;
begin
     if lbSlowa.ItemIndex = -1 then exit;
     Slowo := Trim(edtSlowo.text);
     if Slowo = '' then exit;
     for i := 0 to lbSlowa.Items.Count-1 do
         if (Uppercase(lbSlowa.Items[i]) = UpperCase(Slowo)) and not (i=lbSlowa.ItemIndex)
             then exit;
     lbSlowa.Items[lbSlowa.ItemIndex] := Slowo;
end;

procedure TwndCzat.btnSlowoOtworzWavaClick(Sender: TObject);
begin
     OtworzWAV.FileName := edtSlowoWAV.Text;
     if not OtworzWav.execute then exit;
     edtSlowoWAV.Text := OtworzWAV.FileName;
end;

procedure TwndCzat.lbSlowaClick(Sender: TObject);
begin
     if lbSlowa.ItemIndex = -1 then exit;
     edtSlowo.Text := lbSlowa.items[lbSlowa.ItemIndex];
end;

//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
// edycja pozegnania
//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

procedure TwndCzat.lbPozegnaniaClick(Sender: TObject);
begin
     if lbPozegnania.ItemIndex = -1 then exit;
     edtPozegnanie.Text := lbPozegnania.items[lbPozegnania.ItemIndex];
end;

procedure TwndCzat.btnDodajPozegnanieClick(Sender: TObject);
var Pozegnanie:string;
    i:integer;
begin
     Pozegnanie := Trim(edtPozegnanie.text);
     if Pozegnanie = '' then exit;
     for i := 0 to lbPozegnania.Items.Count-1 do
         if Uppercase(lbPozegnania.Items[i]) = UpperCase(Pozegnanie)
             then exit;
     lbPozegnania.Items.Add(Pozegnanie);
end;

procedure TwndCzat.btnUsunPozegnanieClick(Sender: TObject);
begin
     if lbPozegnania.ItemIndex = -1 then exit;
     lbPozegnania.Items.Delete(lbPozegnania.Itemindex);
end;

procedure TwndCzat.btnZmienPozegnanieClick(Sender: TObject);
var Pozegnanie:string;
    i:integer;
begin
     if lbPozegnania.ItemIndex = -1 then exit;
     Pozegnanie := Trim(edtPozegnanie.text);
     if Pozegnanie = '' then exit;
     for i := 0 to lbPozegnania.Items.Count-1 do
         if (Uppercase(lbPozegnania.Items[i]) = UpperCase(Pozegnanie)) and not (i=lbPozegnania.ItemIndex)
             then exit;
     lbPozegnania.Items[lbPozegnania.ItemIndex] := Pozegnanie;
end;

Procedure TwndCzat.PozegnajSie;
var tekst:string;
{    x:integer;}
begin
     tekst := '';
     if lbPozegnania.Items.Count > 0 then if chkPozegnaniaAktywne.checked then Tekst := lbPozegnania.Items[Random(lbPozegnania.Items.Count)];
     PowiedzNaPolczat('/quit '+Tekst);
end;

//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
// Edycja znajomych / detekcja znajomych
//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

procedure TwndCzat.lbZnajomiClick(Sender: TObject);
begin
     if lbZnajomi.ItemIndex = -1 then exit;
     edtXywaZnajomka.Text := lbZnajomi.items[lbZnajomi.ItemIndex];
end;

procedure TwndCzat.btnDodajZnajomkaClick(Sender: TObject);
var xywka:string;
    i:integer;
begin
     xywka := Trim(edtXywaZnajomka.text);
     if xywka = '' then exit;
     for i := 0 to lbZnajomi.Items.Count-1 do
         if Uppercase(lbZnajomi.Items[i]) = UpperCase(xywka)
             then exit;
     lbZnajomi.Items.Add(Xywka);
end;

procedure TwndCzat.btnUsunZnajomkaClick(Sender: TObject);
begin
     if lbZnajomi.ItemIndex = -1 then exit;
     lbZnajomi.Items.Delete(lbZnajomi.Itemindex);
end;

procedure TwndCzat.btnZmienZnajomkaClick(Sender: TObject);
var xywka:string;
    i:integer;
begin
     if lbZnajomi.ItemIndex = -1 then exit;
     xywka := Trim(edtXywaZnajomka.text);
     if xywka = '' then exit;
     for i := 0 to lbZnajomi.Items.Count-1 do
         if (Uppercase(lbZnajomi.Items[i]) = UpperCase(xywka)) and not (i=lbZnajomi.ItemIndex)
             then exit;
     lbZnajomi.Items[lbZnajomi.ItemIndex] := Xywka;

end;

Function TwndCzat.CzyZnajomy(nick:string):Boolean;
var i:integer;
begin
     Result := false;
     nick := Trim(UpperCase(nick));
     for i := 0 to lbZnajomi.Items.Count-1 do
     begin
          if Uppercase(lbZnajomi.Items[i]) = nick then
          begin
               Result := true;
               exit;
          end;
     end;
end;

//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
// Otwieranie plikow WAV do poszczegolnych zdarzeñ
//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
procedure TwndCzat.btnWejscieOtworzWavClick(Sender: TObject);
begin
     OtworzWAV.FileName := edtWejscieWAV.Text;
     if not OtworzWav.execute then exit;
     edtWejscieWAV.Text := OtworzWAV.FileName;
end;

procedure TwndCzat.btnPrivOtworzWavClick(Sender: TObject);
begin
     OtworzWAV.FileName := edtPrivWAV.Text;
     if not OtworzWav.execute then exit;
     edtPrivWAV.Text := OtworzWAV.FileName;
end;

procedure TwndCzat.btnGlownyOdtowrzWavClick(Sender: TObject);
begin
     OtworzWAV.FileName := edtGlownyWAV.Text;
     if not OtworzWav.execute then exit;
     edtGlownyWAV.Text := OtworzWAV.FileName;
end;

procedure TwndCzat.btnKtosWejscieOtworzWAVClick(Sender: TObject);
begin
     OtworzWAV.FileName := edtKtosWejscieWAV.Text;
     if not OtworzWav.execute then exit;
     edtKtosWejscieWAV.Text := OtworzWAV.FileName;
end;

procedure TwndCzat.btnPrivKtosOtworzWAVClick(Sender: TObject);
begin
     OtworzWAV.FileName := edtKtosPrivWAV.Text;
     if not OtworzWav.execute then exit;
     edtKtosPrivWAV.Text := OtworzWAV.FileName;
end;

procedure TwndCzat.btnKtosGlownyOtworzWAVClick(Sender: TObject);
begin
     OtworzWAV.FileName := edtKtosGlownyWAV.Text;
     if not OtworzWav.execute then exit;
     edtKtosGlownyWAV.Text := OtworzWAV.FileName;
end;

//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//  Obs³uga okna czata i bufora czata
//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
procedure TwndCzat.WykonajPomiar(var Item:String; var LiniaHTML:TLiniaHTML);
var i, j:longint;
    pi:^longint;
    Foncik:PFoncik;
    poz:integer;
    tekst:string;
    Kolumna,NumerLinii:Integer;
    Slowo:String;
    KoniecSlow:Boolean;
    DlugoscSlowa:Integer;
    Znalazlem:Boolean;
//    gif:TGIFImage;

    Procedure AplikujDlugoscSlowa(ds:integer; ZwiekszajKolumne:Boolean);
    begin
         if Kolumna+ds > PanelDoRysowania.Width then
         begin
              inc(NumerLinii);
              LiniaHTML.Wysokosc[NumerLinii] := 14;
              KOlumna := 16; //margines z lewej
         end else if ZwiekszajKolumne then inc(Kolumna, DS);
    end;

begin
     Label17.font.Color := clBlack;
     LiniaHTML.CiagOrginalny := Item;
     WstepnaAnalizaHTML(Item, @LiniaHTML.Elementy, LiniaHTML.IloscElementow);
//     FillChar(WysokoscLinii, SizeOf(WysokoscLinii), #0);
     NumerLinii := 1;
     Kolumna := 2;
     LiniaHTML.Wysokosc[NumerLinii] := 14;
     i := 1;
     while i < LiniaHTML.IloscElementow do
     begin
          if LiniaHTML.Elementy[i] = '' then Continue;
          if LiniaHTML.Elementy[i][1] = '<' then
          begin // tag thml
               if LiniaHTML.Elementy[i][2] = '/' then
               begin
                    Foncik := Stos.Pop;
                    Label17.Canvas.Font.Style := Foncik^.Styl;
                    Label17.Canvas.Font.Color := Foncik.Kolor;
                    Dispose(Foncik);
               end else
               begin
                    Foncik := New(PFoncik);
                    Foncik^.Styl := Label17.canvas.Font.Style;
                    Foncik^.Kolor := Label17.canvas.Font.Color;
                    Stos.Push(Foncik);
                    if LiniaHTML.Elementy[i] = '<B>' then Label17.canvas.Font.Style := Label17.canvas.Font.Style + [fsBold];
                    if LiniaHTML.Elementy[i] = '<U>' then Label17.canvas.Font.Style := Label17.canvas.Font.Style + [fsUnderline];
                    if LiniaHTML.Elementy[i] = '<I>' then Label17.canvas.Font.Style := Label17.canvas.Font.Style + [fsItalic];
                    // image
                    poz := Pos('COLOR=', LiniaHTML.Elementy[i]);
                    if poz <> 0 then
                    begin
                         Tekst := LiniaHTML.Elementy[i];
                         Delete(Tekst, 1, poz+5);
                         Delete(Tekst, Length(tekst), 1);
                         if Uppercase(Tekst) = 'RED' then Tekst := '#ff0000';
                         LiniaHTML.Elementy[i] := '<C'+Tekst;

                    end;
                    poz := Pos('SRC=', LiniaHTML.Elementy[i]);
                    if poz <> 0 then
                    begin
                         Tekst := LiniaHTML.Elementy[i];
                         Delete(Tekst, 1, poz+4);
                         Tekst := StringReplace(Tekst, '''', '"', [rfReplaceAll]);
                         Tekst := Copy(tekst, 1, Pos('"', Tekst)-1);
                         Tekst := StringReplace(tekst, '/', '\', [rfReplaceAll]);
                         Tekst := ExtractFileName(Tekst);
                         tekst := UpperCase(Copy(tekst, 1, pos('.', tekst)-1));

                         if IleObrazkow = 0 then
                         begin
//                              LiniaHTML.Elementy[i] :='&lt;'+LowerCase(tekst)+'&gt;';
                              LiniaHTML.Elementy[i] :='[o:'+LowerCase(tekst)+']';
                              Continue;
                         end;

                         Znalazlem := False;
                         for j := 0 to IleObrazkow do
                         begin
                              if TablicaObrazkow[j].nazwa = tekst then
                              begin
                                   AplikujDlugoscSlowa(TablicaObrazkow[j].Bitmap.Width+4, True);
                                   LiniaHTML.Wysokosc[NumerLinii] := Max(TablicaObrazkow[j].Bitmap.Height, LiniaHTML.Wysokosc[NumerLinii]);
                                   LiniaHTML.Elementy[i] := '<I'+inttostr(j);
                                   Znalazlem := true;
                                   Break;
                              end;
                         end;
                         // nie mam takiej grafiki
                         if not Znalazlem then
                         begin
                              LiniaHTML.Elementy[i] :='&lt;BRAK:'+LowerCase(tekst)+'&gt;';
                              Continue;
{                              pi := @i;
                              dec(pi^);}
                         end;
                         //rysowanie grafiki
                    end;
               end; //tag HTML
          end {tagi THML}
          else //tekst zwykly
          begin
               // teraz wywalamy slowo po slowie i robimy pomiar.
               KoniecSlow := False;
               Tekst := LiniaHTML.Elementy[i];
               RozwijanieSkrotowHTML(Tekst);
               while not KoniecSlow do
               begin
                    poz := pos(' ', Tekst);
                    if poz = 0 then
                    begin
                         Slowo := Tekst;
                         KoniecSlow := True;
                    end else
                    begin
                         Slowo := Copy(Tekst, 1, poz);
                         Delete(Tekst, 1, poz);
                    end;
                    DlugoscSlowa := Label17.Canvas.TextWidth(Slowo);
                    AplikujDlugoscSlowa(DlugoscSlowa, False);
                    AplikujDlugoscSlowa(DlugoscSlowa, True);
               end; //while not KoniecSlow}
          end; {if tablica[i][1] = '<'}
          inc(i);
     end; {for i := 1 to Numer-1}
     // oczyszczenie stosu
     while Stos.Count > 0 do
     begin
          Foncik := Stos.Pop;
          Dispose(foncik);
     end;
     LiniaHTML.WysokoscCalkowita := 0;
     for i := 1 to NumerLinii do
         Inc(LiniaHTML.WysokoscCalkowita, LiniaHTML.Wysokosc[i]);
end;

procedure TwndCzat.DodajDoOknaCzata(Numer:Integer; Tekst:String);
var LiniaHTML:TLiniaHTML;
    i:Byte;
    j:integer;
    OldPos:Integer;
    OknoCzata:POknoCzata;
begin
//     JavaCodesToWindows(Tekst);
     WykonajPomiar(Tekst, LiniaHTML);
     OldPos := sb.Position;
     OknoCzata := OknaCzata[Numer].Zawartosc;
     if OknoCzata^.IloscLinii >= MaxLiniiHTML then
     begin
          for i := 1 to OknoCzata^.Linie[1].IloscElementow do
              OknoCzata^.Linie[1].Elementy[i] := '';
          OknoCzata^.Linie[1].CiagOrginalny := '';
          for j := 2 to OknoCzata^.IloscLinii do
              OknoCzata^.Linie[j-1] := OknoCzata^.Linie[j];
          Dec(OknoCzata^.IloscLinii);
          Dec(OknoCzata^.OstatniaWidzialna);
     end;
     OknoCzata^.Linie[OknoCzata^.IloscLinii+1] := LiniaHTML;
     inc(OknoCzata^.IloscLinii);
     inc(OknoCzata^.OstatniaWidzialna);
     if Numer <> NumerOknaCzata then
     begin
          if Tekst = '' then exit;
          if Copy(ZakladkaOkienek.Tabs[Numer], 1, 3) <> '[+]' then
             ZakladkaOkienek.Tabs[Numer] := '[+] '+ZakladkaOkienek.Tabs[Numer];
          exit;
     end;
     if sb.Max = sb.Position then
     begin
          sb.Max := OknoCzata^.IloscLinii;
          sb.Position := OknoCzata^.IloscLinii;
     end else sb.Max := OknoCzata^.IloscLinii;
     if OldPos = sb.Position then PanelDoRysowaniaPaint(nil);
end;

procedure TwndCzat.sbChange(Sender: TObject);
begin
     PanelDoRysowaniaPaint(nil);
end;

procedure TwndCzat.FormPaint(Sender: TObject);
begin
     // przyciski
     btnKoloOkiMouseUp(btnKoloOki, TMouseButton(0), [], 0, 0);
     btnKoloIgnoreMouseUp(btnKoloIgnore, TMouseButton(0), [], 0, 0);
     btnPrivMouseUp(btnPriv, TMouseButton(0), [], 0, 0);
     btnInfoMouseUp(btnInfo, TMouseButton(0), [], 0, 0);
end;

procedure TwndCzat.PanelDoRysowaniaPaint(Sender: TObject);
{GDI}
var dc2:hdc;
    hfoncik, aktualnyfont:HFont;
    Foncik, Foncik2:PMyLogFont;
    staryfont:hfont;
{reszta}
    XOffset,Y, YOffset:Integer;
    Tekst:String;
    Linia:TLiniaHTML;
    BuforPChar:array[1..400] of Char;
    NumerLinii:Byte;
    poz,i:integer;
    Kolor:TColor;
    Slowo:String;
    KoniecSlow:Boolean;
    WymiaryFonta:TSize;
    nItem:Integer;

    procedure AplikujDlugoscSlowa(ds:integer; ZwiekszajKolumne:Boolean);
    begin
         if {X}XOffset+ds > PanelDoRysowania.Width then
         begin
              inc(YOffset, Linia.Wysokosc[NumerLinii]);
              inc(NumerLinii);
              XOffset := 16; //margines z lewej
         end else if ZwiekszajKolumne then inc(XOffset, ds);
    end;

    procedure UstawFonta(f:PMyLogFont);
    begin
         hfoncik := CreateFontIndirect(f^.LF);
         AktualnyFont := hfoncik;
         hfoncik := SelectObject(PanelDC, hfoncik);
         if staryfont = 0 then StaryFont := hFoncik
                          else DeleteObject(hfoncik);
         Dispose(f);
         exit;
    end;
begin
     // okno czata
     PanelDC := PanelDoRysowania.Canvas.Handle;
     BufferBitmap := CreateCompatibleBitmap(PanelDC, PanelDoRysowania.width, PanelDoRysowania.Height);
     dc2 := CreateCompatibleDC(PanelDC);
     PanelDC := dc2;
     OldBitmap := SelectObject(PanelDC, BufferBitmap);
     PanelDCReal := PanelDoRysowania.canvas.Handle;

     StaryFont := 0;
     YOffset := 0;
     Y := PanelDoRysowania.Height;


     Fillrect(PanelDC, rect(0, 0, PanelDoRysowania.width, PanelDoRysowania.Height), PanelDoRysowania.Canvas.Brush.handle);
     for nItem := sb.Position downto 1 do
     begin
          Linia := OknaCzata[NumerOknaCzata].Zawartosc^.Linie[nItem];
          if Linia.WysokoscCalkowita = 0 then Break;

          Dec(Y, Linia.WysokoscCalkowita{Wysokosc[NumerLinii]});
          YOffset := Y;
          XOffset := 2;
          NumerLinii := 1;

          SettextColor(PanelDC, clBlack);
          Foncik := New(PMyLogFont);
          FillChar(Foncik^, SizeOf(TLogFont), 0);
          Foncik^.LF.lfHeight := -12;
          Foncik^.lf.lfWeight := FW_NORMAL;
          Foncik^.Kolor := clBlack;
          Foncik^.LF.lfCharSet := EASTEUROPE_CHARSET;
          StrPCopy(Foncik.lf.lfFaceName, 'Verdana');
          UstawFonta(foncik);

          for i := 1 to Linia.IloscElementow-1 do
          begin
               Tekst := Linia.Elementy[i];
               if Tekst = '' then Continue;
               if Tekst[1] = '<' then
               begin // tag thml
                    if Copy(Tekst, 2, 1) = '/' then
                    begin
                         Foncik := Stos.Pop;
                         if not Assigned(Foncik) then Continue;

                         if Tekst = '</B>' then
                         begin
                              Foncik^.lf.lfWeight := FW_NORMAL;
                              UstawFonta(Foncik);
                              Continue;
                         end;
                         if Tekst = '</U>' then
                         begin
                              Foncik^.lf.lfUnderline := Byte(False);
                              UstawFonta(Foncik);
                              Continue;
                         end;
                         if Tekst = '</I>' then
                         begin
                              Foncik^.lf.lfItalic := Byte(False);
                              UstawFonta(Foncik);
                              Continue;
                         end;

                         SettextColor(PanelDC, Foncik^.kOLOR);
                         UstawFonta(Foncik);
                    end else
                    begin
                         Foncik := New(PMyLogFont);
                         GetObject(AktualnyFont, sizeof(LogFont), @Foncik^.LF);
                         Foncik^.Kolor := GetTextColor(PanelDC);
                         Stos.Push(Foncik);

                         Foncik2 := New(PMyLogFont);
                         Move(Foncik^, Foncik2^,SizeOf(TMyLogFont));
                         Foncik := Foncik2;

                         if Tekst = '<B>' then
                         begin
                              Foncik^.lf.lfWeight := FW_BOLD;
                              UstawFonta(Foncik);
                              Continue;
                         end;
                         if Tekst = '<U>' then
                         begin
                              Foncik^.lf.lfUnderline := Byte(True);
                              UstawFonta(Foncik);
                              Continue;
                         end;
                         if Tekst = '<I>' then
                         begin
                              Foncik^.lf.lfItalic := Byte(True);
                              UstawFonta(Foncik);
                              Continue;
                         end;
                         //font
                         if Copy(Tekst, 1, 2) = '<C' then
                         begin
                              Delete(Tekst, 1, 2);
                              Kolor := HTMLColorToDelphi(Tekst);
                              SetTextColor(PanelDC, ColorToRGB(Kolor));
                              Dispose(Foncik);
                              Continue;
                         end;
                         if Copy(UpperCase(Tekst), 1, 2) = '<A' then
                         begin
                              Foncik^.lf.lfUnderline := Byte(True);
                              SetTextColor(PanelDC, ColorToRGB(clBlue));
                              UstawFonta(Foncik);
                              Continue;
                         end;
                         // image
                         if Copy(Tekst, 1, 2) = '<I' then
                         begin
                              Dispose(Foncik);
                              Delete(Tekst, 1, 2);
                              poz := StrToInt(Tekst);
                              BitBlt(PanelDC, xoffset+2, yoffset+Linia.Wysokosc[NumerLinii] shr 1-TablicaObrazkow[poz].bitmap.Height shr 1,
                                              TablicaObrazkow[poz].bitmap.width, TablicaObrazkow[poz].bitmap.height,
                                              TablicaObrazkow[poz].bitmap.Canvas.Handle,
                                              0, 0, SRCCOPY);
                              AplikujDlugoscSlowa(TablicaObrazkow[poz].bitmap.Width+4, True);
                              Continue
                         end; {SRC=}
                    end; //jakis tag html
               end else
               begin // wyswietlenie tekstu
                    KoniecSlow := False;
                    Tekst := Linia.Elementy[i];
                    RozwijanieSkrotowHTML(Tekst);
                    while not KoniecSlow do
                    begin
                         poz := pos(' ', Tekst);
                         if poz = 0 then
                         begin
                              Slowo := Tekst;
                              KoniecSlow := True;
                         end else
                         begin
                              Slowo := Copy(Tekst, 1, poz);
                              Delete(Tekst, 1, poz);
                         end;

                         WymiaryFonta.cX := 0;
                         WymiaryFonta.cY := 0;
                         StrPCopy(@BuforPChar, Slowo);
                         GetTextExtentPoint32(PanelDC, @BuforPChar, Length(Slowo), WymiaryFonta);
                         if WymiaryFonta.cX = 0 then Continue;

                         AplikujDlugoscSlowa(WymiaryFonta.cx, false);
                         TextOut(PanelDC,
                                 XOffset,
                                 YOffset+Linia.Wysokosc[NumerLinii] shr 1 - WymiaryFonta.cy shr 1,
                                 @BuforPChar,
                                 length(Slowo));
                         AplikujDlugoscSlowa(WymiaryFonta.cx, True);

                    end; //while not KoniecSlow
               end; //koniec wyswietlania tekstow
          end; //for i := 2 to Numer-1 do
          if Y < 0 then break;
     end; {petla wyswietlania linii}


     while Stos.Count > 0 do
     begin
          Foncik := Stos.Pop;
          Dispose(foncik);
     end;
     DeleteObject(SelectObject(PanelDC, staryfont));

     BitBlt(PanelDCReal, 0, 0, PanelDoRysowania.width, PanelDoRysowania.height, PanelDC, 0, 0, SRCCOPY);
//     releasedc(PanelDoRysowania.handle, PanelDCReal);
     SelectObject(PanelDC, OldBitmap);
     deleteObject(BufferBitmap);
     DeleteDC(panelDC);
end;

procedure TwndCzat.PanelDoRysowaniaMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     PanelDoRysowaniaY := y;
end;

//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
// Okno czata - popup menu i revDNS
//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

procedure TwndCzat.LinkInternetowyClick(Sender: TObject);
begin
     OdpalLinka(TMenuitem(Sender).Caption);
end;

procedure TwndCzat.CzatPopupMenuPopup(Sender: TObject);
var item:TMenuItem;
    linia:string;
    i:integer;
    adres:string;
    Tablica:TTablicaHTML;
    poz:Integer;
    Numer:word;
    DodalemLinie:Boolean;
    Linia2:String;

    liniahtml:PLiniaHTML;
    OldY1, OldY2:integer;
    mam:Boolean;

    ipki:TStringList;

procedure SprawdzCzySaLinki;
var i:integer;
begin
     WstepnaAnalizaHTML(Linia, @Tablica, Numer);
     DodalemLinie := False;
     for i := 1 to Numer-1 do
     begin
          linia := tablica[i];
          if Copy(linia, 1, 1) <> '<' then Continue;
          poz := pos('HREF=', UpperCase(linia));
          if poz = 0 then Continue;
          linia := Copy(linia, poz+5, length(Linia));
          adres := copy(linia, 1, pos('>', linia)-1);
          Adres := StringReplace(Adres, '"', '', [rfReplaceAll]);
          if not dodalemLinie then
          begin
               DodalemLinie := True;
               item := TMenuItem.Create(CzatPopupmenu);
               item.Caption := '-';
               item.Name := 'linki';
               CzatPopupmenu.Items.Add(item);
          end;
          item := TMenuItem.Create(CzatPopupmenu);
          item.Caption := Adres;
          item.OnClick := wndCzat.LinkInternetowyClick;
          CzatPopupmenu.Items.Add(item);
     end; //     for i := 1 to Numer-1 do
end;


begin
     OldY1 := 0; OldY2 := 0;
     Mam := False;
     for i := sb.Position downto 1 do
     begin
          liniahtml := @OknaCzata[NumerOknaCzata].Zawartosc^.Linie[i];
          if liniahtml^.IloscElementow = 0 then exit;
          OldY1 := OldY2;
          OldY2 := OldY2 + liniahtml^.WysokoscCalkowita;
          if (PanelDoRysowaniaY <= PanelDoRysowania.Height-OldY1) and (PanelDoRysowaniaY >= PanelDoRysowania.Height-OldY2) then
          begin
               linia := liniahtml.CiagOrginalny;
               linia := copy(linia, pos('<', linia), length(linia));
               Mam := True;
               Break;
          end;
     end;
     if not Mam then exit;


     menuWpisRevDNS.Visible := False;
     for i := 0 to CzatPopupmenu.Items.Count-1 do
     begin
          if CzatPopupmenu.Items[i].Name = 'linki' then
          begin
               while not (CzatPopupMenu.Items.Count = i) do
               begin
                    item := CzatPopupMenu.Items[CzatPopupMenu.Items.Count-1];
                    item.Free;
               end;
               Break;
          end;
     end;
     for i := 0 to CzatPopupMenu.Items.Count-1 do
     begin
          if CzatPopupMenu.Items[i].Name = 'funkcjeip' then
          begin
               while not (CzatPopupMenu.Items.Count = i) do
               begin
                    item := CzatPopupMenu.Items[CzatPopupMenu.Items.Count-1];
                    item.Free;
               end;
               Break;
          end;
     end;


     Linia2 := Linia;
     OdsyfiaczHTML(Linia2);

     GetIPsFromText(linia2, ipki);
     if JestemOpem and (ipki.Count > 0) then
     begin
          SprawdzCzySaLinki;
          poz := Pos('"ban-lista" adresów ip:', linia2);
          if poz > 0 then
          begin
               Ipki.Free;
               exit;
          end;

          JoinIp := Ipki.Strings[0];
          menuWpisRevDNS.Caption := Format(lblWpisRevDNS, [JoinIp]);
          menuWpisRevDNS.Visible := true;

          menuWhoIs.Caption := Format(lblWhoIs, [JoinIp]);
          menuWhoIs.Visible := true;

          dodalemlinie := false;
          for i := 0 to lbFunkcjeIP.Items.Count-1 do
          begin
               if not dodalemLinie then
               begin
                    DodalemLinie := True;
                    item := TMenuItem.Create(CzatPopupMenu);
                    item.Caption := '-';
                    item.Name := 'funkcjeip';
                    CzatPopupMenu.Items.Add(item);
               end;
               item := TMenuItem.Create(CzatPopupMenu);
               item.Caption := FormatujTekstFunkcyjny(lbFunkcjeIP.Items[i]);
               item.OnClick := wndCzat.WykonajFunkcje;
               CzatPopupMenu.Items.Add(item);
          end; //     for i := 1 to Numer-1 do
          JoinIP := '';
          ipki.free;
          exit;
     end else Ipki.Free;
     SprawdzCzySaLinki;
end;

procedure TwndCzat.menuWpisrevDNSClick(Sender: TObject);
var IP:String;
begin
     IP := TMenuItem(Sender).Caption;
     IP := Trim(Copy(IP, Pos(':', IP)+1, Length(IP)));
     OknoRevDNS := NumerOknaCzata;
     DodajDoOknaCzata(OknoRevDNS, '<font color=#000000>- Oczekiwanie na odpowiedz z serwera DNS...</font>');
     revDNS.ReverseDnsLookup(IP);
end;

procedure TwndCzat.revDNSDnsLookupDone(Sender: TObject; Error: Word);
var i:integer;
begin
      if Error = 0 then
      begin
           DodajDoOknaCzata(OknoRevDNS, '<font color=#000000>- Iloœæ hostów: <b>'+IntToStr(revDNS.DnsResultList.Count)+'</b></font>');
           for i := 0 to revDNS.DnsResultList.Count-1 do
           DodajDoOknaCzata(OknoRevDNS, '<font color=#000000>- ['+IntToStr(i+1)+']: <b>'+revDNS.DnsResultList[i]+'</b></font>');
      end
      else
      begin
           if Error <> 11004
              then DodajDoOknaCzata(OknoRevDNS, '<font color=#000000>- B³¹d <b>#'+IntToStr(Error)+'</b></font>')
              else DodajDoOknaCzata(OknoRevDNS, '<font color=#000000>- <b>Nie mog³em znaleŸæ wpisu revDNS</b></font>')
      end;

end;

procedure TwndCzat.Doschowka1Click(Sender: TObject);
var linia:string;
    schowek:TClipboard;
    i:integer;
    liniahtml:PLiniaHTML;
    OldY1, OldY2:integer;
    mam:Boolean;
begin
     OldY1 := 0; OldY2 := 0;
     Mam := False;
     for i := sb.Position downto 1 do
     begin
          liniahtml := @OknaCzata[NumerOknaCzata].Zawartosc^.Linie[i];
          if liniahtml^.IloscElementow = 0 then exit;
          OldY1 := OldY2;
          OldY2 := OldY2 + liniahtml^.WysokoscCalkowita;
          if (PanelDoRysowaniaY <= PanelDoRysowania.Height-OldY1) and (PanelDoRysowaniaY >= PanelDoRysowania.Height-OldY2) then
          begin
               linia := liniahtml.CiagOrginalny;
               linia := copy(linia, pos('<', linia), length(linia));
               Mam := True;
               Break;
          end;
     end;
     if not Mam then exit;
     OdsyfiaczHTML(Linia);
     schowek := clipboard;
     schowek.AsText := Linia;
end;

procedure TwndCzat.Czybufor1Click(Sender: TObject);
var i:integer;
    j:byte;
    OknoCzata:PoknoCzata;
begin
     OknoCzata := OknaCzata[NumerOknaCzata].Zawartosc;
     for i := 1 to OknoCzata^.IloscLinii do
     begin
          for j := 1 to OknoCzata^.Linie[i].IloscElementow
              do OknoCzata^.Linie[i].Elementy[j] := '';
          OknoCzata^.Linie[i].CiagOrginalny := '';
     end;
     FillChar(OknoCzata^, SizeOf(TOknoCzata), 0);
     if sb.Max = 1 then PanelDoRysowaniaPaint(nil);
     sb.Max := 1;
     sb.Position := 1;
end;


//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
// Zak³adka okienek priv i okna czata
//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
procedure TwndCzat.ZakladkaOkienekMeasureTab(Sender: TObject;
  Index: Integer; var TabWidth: Integer);
var t:string;
begin
     t := IntToStr(Index+1)+': ';
     t := t + ZakladkaOkienek.Tabs[Index];
     TabWidth := ZakladkaOkienek.Canvas.TextWidth(t);
end;

procedure TwndCzat.ZakladkaOkienekDrawTab(Sender: TObject;
  TabCanvas: TCanvas; R: TRect; Index: Integer; Selected: Boolean);
var t:string;
begin
     t := IntToStr(Index+1)+': ';
     t := t + ZakladkaOkienek.Tabs[Index];
     TabCanvas.TextOut(R.Left, r.Top+2, t);
end;

procedure TwndCzat.ZakladkaOkienekChange(Sender: TObject;
  NewTab: Integer; var AllowChange: Boolean);
var Caption:String;
begin

     NumerOknaCzata := NewTab;
     Caption := ZakladkaOkienek.Tabs[NumerOknaCzata];
     if Copy(Caption, 1, 3) = '[+]' then Delete(Caption, 1, 4);
     ZakladkaOkienek.Tabs[NumerOknaCzata] := Caption;
     sb.Max := OknaCzata[NumerOknaCzata].Zawartosc^.IloscLinii;
     sb.Position := OknaCzata[NumerOknaCzata].Zawartosc^.IloscLinii;
     PanelDoRysowaniaPaint(nil);
end;

procedure TwndCzat.Zamknij2Click(Sender: TObject);
var i:Integer;
    dummy:Boolean;
begin
     i := ZakladkaOkienek.TabIndex;
     if i = 0 then exit;
     ZakladkaOkienek.Tabs.Delete(i);
     OknaCzata[i].Nick := '';
     Dispose(OknaCzata[i].Zawartosc);
     for i := i+1 to MaxOkienekCzata do
         OknaCzata[i-1] := OknaCzata[i];
     OknaCzata[MaxOkienekCzata].Nick := '';
     OknaCzata[MaxOkienekCzata].Zawartosc := nil;
     ZakladkaOkienekChange(nil, ZakladkaOkienek.TabIndex, dummy);

end;

//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
// Pole edycji tekstow
//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

procedure TwndCzat.WstawWMiejsceKursora(s:string);
var SelStart:Integer;
    Tekst:String;
begin
     SelStart := edtTekst.SelStart;
     Tekst := edttekst.text;
     Insert(s, Tekst, SelStart+1);
     inc(selstart, Length(s));
     edtTekst.Text := Tekst;
     edtTekst.SelStart := SelStart;
     edtTekst.SetFocus;
end;

function TwndCzat.FormatujTekstFunkcyjny(s:string):string;
var ip, nick:string;
    rok, miech, dzien:word;
    srok, smiech, sdzien:string;
    Data:TDateTime;
    Roznica:TDateTime;
begin
     if ListaUserow.ItemIndex = -1 then nick := '' else
     begin
          nick := ListaUserow.Items[ListaUserow.ItemIndex];
          ip := PCzatowicz(ListaUserow.Items.Objects[ListaUserow.ItemIndex])^.IP;
     end;

     Data := Now;

     if not JestemOpem then
     begin
          Joinip := '';
          ip := '';
          ipostatniejosoby := '';
     end;

     s := StringReplace(s, '%nick', nick, [rfReplaceAll, rfIgnoreCase]);
     s := StringReplace(s, '%ver', DajWersjeProgramu, [rfReplaceAll, rfIgnoreCase]);
     s := StringReplace(s, '%me', edtNick.Text, [rfReplaceAll, rfIgnoreCase]);
     s := StringReplace(s, '%joinip', JoinIP, [rfReplaceAll, rfIgnoreCase]);
     s := StringReplace(s, '%ip', ip, [rfReplaceAll, rfIgnoreCase]);
     s := StringReplace(s, '%lastip', IPOstatniejOsoby, [rfReplaceAll, rfIgnoreCase]);

     DecodeDate(Data, Rok, Miech, Dzien);
     sDzien := IntToStr(Dzien); if Length(sDzien) = 1 then sDzien := '0'+sDzien;
     sMiech := IntToStr(Miech); if Length(sMiech) = 1 then sMiech := '0'+sMIech;
     s := StringReplace(s, '%dd', sDzien, [rfReplaceAll, rfIgnoreCase]);
     s := StringReplace(s, '%mm', sMiech, [rfReplaceAll, rfIgnoreCase]);
     s := StringReplace(s, '%yy', IntToStr(Rok), [rfReplaceAll, rfIgnoreCase]);
     s := StringReplace(s, '%now', sDzien+' '+sMiech+' '+IntToStr(Rok), [rfReplaceAll, rfIgnoreCase]);

     Roznica := EncodeTime(12, 0, 0, 0);
     Data := Data-Roznica-Roznica;
     DecodeDate(Data, Rok, Miech, Dzien);
     sDzien := IntToStr(Dzien); if Length(sDzien) = 1 then sDzien := '0'+sDzien;
     sMiech := IntToStr(Miech); if Length(sMiech) = 1 then sMiech := '0'+sMIech;

     s := StringReplace(s, '%lastdd', sDzien, [rfReplaceAll, rfIgnoreCase]);
     s := StringReplace(s, '%lastmm', sMiech, [rfReplaceAll, rfIgnoreCase]);
     s := StringReplace(s, '%lastyy', IntToStr(Rok), [rfReplaceAll, rfIgnoreCase]);
     s := StringReplace(s, '%yesterday', sDzien+' '+sMiech+' '+IntToStr(Rok), [rfReplaceAll, rfIgnoreCase]);

     s := StringReplace(s, '%last', NickOstatniejOsoby, [rfReplaceAll, rfIgnoreCase]);
     Result := s;
end;

procedure TwndCzat.edtTekstKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var i:integer;
begin
     if (ssCtrl in Shift) and (Key = VK_RETURN) then
     begin
          ListaUserowDblClick(nil);
          exit;
     end;
     if (ssAlt in Shift) then
     begin
          if (Key = VK_RIGHT) then
             if ZakladkaOkienek.TabIndex = ZakladkaOkienek.Tabs.Count-1
                then ZakladkaOkienek.TabIndex := 0
                else ZakladkaOkienek.TabIndex := ZakladkaOkienek.TabIndex+1;
          if (Key = VK_LEFT) then
             if ZakladkaOkienek.TabIndex = 0
                then ZakladkaOkienek.TabIndex := ZakladkaOkienek.Tabs.Count-1
                else ZakladkaOkienek.TabIndex := ZakladkaOkienek.TabIndex-1;
          if Key in [$31..$39] then
          begin
               Dec(Key, $31);
               if (Key >= 0) and (Key <= ZakladkaOkienek.Tabs.Count-1)
                  then ZakladkaOkienek.TabIndex := Key;
          end;
          exit;
     end;
     if (ssCtrl in Shift) then
     begin
          if (Key = VK_DOWN) then
             if ListaUserow.ItemIndex = ListaUserow.Items.Count-1
                then ListaUserow.ItemIndex := 0
                else ListaUserow.ItemIndex := ListaUserow.ItemIndex+1;
          if (Key = VK_UP) then
             if ListaUserow.ItemIndex = 0
                then ListaUserow.ItemIndex := ListaUserow.Items.Count-1
                else ListaUserow.ItemIndex := ListaUserow.ItemIndex-1;
          if (Key = VK_UP) or (Key = VK_DOWN)
             then Key := 0;

          exit;
     end;
     if (Key = VK_UP) then
     begin
          For i := 1 to 20 do
          begin
               if (UpperCase(Trim(OstatnieTeksty[i])) = UpperCase(Trim(edtTekst.text)))
                  and (OstatnieTeksty[i] <> '') then
               begin

                    if i = 20 then edtTekst.text := OstatnieTeksty[1]
                              else edtTekst.text := OstatnieTeksty[i+1];
                    exit;
               end;
          end;
          edtTekst.Text := OstatnieTeksty[1];
     end;
     case Key of
        VK_F1: WstawWMiejsceKursora(FormatujTekstFunkcyjny(edtF1.Text));
        VK_F2: WstawWMiejsceKursora(FormatujTekstFunkcyjny(edtF2.Text));
        VK_F3: WstawWMiejsceKursora(FormatujTekstFunkcyjny(edtF3.Text));
        VK_F4: WstawWMiejsceKursora(FormatujTekstFunkcyjny(edtF4.Text));
        VK_F5: WstawWMiejsceKursora(FormatujTekstFunkcyjny(edtF5.Text));
        VK_F6: WstawWMiejsceKursora(FormatujTekstFunkcyjny(edtF6.Text));
        VK_F7: WstawWMiejsceKursora(FormatujTekstFunkcyjny(edtF7.Text));
        VK_F8: WstawWMiejsceKursora(FormatujTekstFunkcyjny(edtF8.Text));
        VK_F9: WstawWMiejsceKursora(FormatujTekstFunkcyjny(edtF9.Text));
        VK_F10: begin
                     WstawWMiejsceKursora(FormatujTekstFunkcyjny(edtF10.Text));
                     key := 0;
                end;
        VK_F11: WstawWMiejsceKursora(FormatujTekstFunkcyjny(edtF11.Text));
        VK_F12: WstawWMiejsceKursora(FormatujTekstFunkcyjny(edtF12.Text));
     end;
end;
procedure TwndCzat.edtTekstKeyPress(Sender: TObject; var Key: Char);
var Przed:String;
    i:integer;
begin
     if Key = #13 then
     begin
          Przed := '';
          if NumerOknaCzata > 0 then
             Przed := '/msg '+OknaCzata[NumerOknaCzata].Nick+' ';
          if Trim(edtTekst.text) = '' then exit;
          edtTekst.Text := Trim(edtTekst.Text);
          if Copy(edtTekst.Text, 1, 1) = '/'
             then Powiedz(Przed+edtTekst.Text)
             else Powiedz(Przed+edtPrzedrostek.Text+edtTekst.Text);
          if OstatnieTeksty[1] <> edtTekst.Text then
          begin
               for i := 19 downto 1 do OstatnieTeksty[i+1] := OstatnieTeksty[i];
               OstatnieTeksty[1] := edtTekst.Text;
          end;
          edtTekst.text := '';
          edtPrzedrostek.Text := '';
          Key := #0;
          UstawPrzedrostek;
     end;
end;


//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//
//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//
//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//
//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//
//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


procedure TwndCzat.StatusBar1DrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
      with StatusBar1.Canvas do
      begin
           Font.Style := [fsBold];
           if ZakladkaOkienek.Tabs.Count-1 > 0 then
           begin
                Brush.Color := clNavy;
                FillRect(Rect);
                Font.Color := clWhite;
           end;
           TextOut(Rect.left + 0, Rect.top + 1, Panel.Text);
      end;
end;

procedure TwndCzat.btnPOkojeClick(Sender: TObject);
begin
     wndPokoje.Show;
end;


procedure TwndCzat.TimerListyUserowTimer(Sender: TObject);
begin lblIloscUserow.Caption := 'Czatowiczów: '+IntToStr(ListaUserow.Items.count); end;

procedure TwndCzat.btnPolchatClick(Sender: TObject);
begin
end;

//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
// Edytor banów
//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

procedure TwndCzat.sgBanySetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: String);
begin
     ShowMessage(Value);
end;


procedure TwndCzat.btnWczytajBanyClick(Sender: TObject);
begin
     if not JestemOpem then
     begin
          MessageDlg('Sorry, ale nie jesteœ opem :(', mtError, [mbOk], 0);
          exit;
     end;
     Powiedz('/bans');
     WczytajDoListyBanow('');
end;

procedure TwndCzat.edtBanMinutyChange(Sender: TObject);
begin
     lblRozwiniecieCzasu.caption := IleSiedzi(trunc(edtBanMinuty.value));
end;

procedure TwndCzat.sgBanyClick(Sender: TObject);
var a:string;
begin
     if not JestemOpem then exit;
     if sgBany.Row = 0 then exit;
     try
        if sgBany.Cells[1, sgBany.Row] = ''
           then edtBanMinuty.value := 0
           else edtBanMinuty.value := StrToInt(sgBany.Cells[1, sgBany.Row]);
     except
        edtBanMinuty.value := 0;
     end;
     a := sgBany.Cells[0, sgBany.Row];
     edtIP1.Text := Copy(a, 1, pos('.', a)-1);
     Delete(a, 1, pos('.', a));
     edtIP2.Text := Copy(a, 1, pos('.', a)-1);
     Delete(a, 1, pos('.', a));
     edtIP3.Text := Copy(a, 1, pos('.', a)-1);
     Delete(a, 1, pos('.', a));
     edtIP4.Text := a;
end;

procedure TwndCzat.btnAktualizujBanaClick(Sender: TObject);
begin
     if (edtIP1.text = '') or (edtIP2.text = '') or (edtIP3.text = '') or (edtIP4.text = '')
        then exit;
     if sgBany.Row = 0 then exit;
     if not JestemOpem then
     begin
          MessageDlg('Sorry, ale nie jesteœ opem :(', mtError, [mbOk], 0);
          exit;
     end;
     Powiedz('/unban '+sgBany.Cells[0, sgBany.Row]);
     sgBany.Cells[0, sgBany.Row] := edtIP1.Text+'.'+edtIP2.Text+'.'+edtIP3.Text+'.'+edtIP4.Text;
     sgBany.Cells[1, sgBany.Row] := IntToStr(Trunc(edtBanMinuty.value));
     Powiedz('/banip '+sgBany.Cells[0, sgBany.Row]+' '+sgBany.Cells[1, sgBany.Row]);
end;

procedure TwndCzat.WczytajDoListyBanow(s:string);
var ip, czas:string;
    godziny, minuty:integer;
    dummys:string;
    kod:integer;
    i:integer;
begin
     //s = '217.98.207.* (148g:43min), 80.49.55.88 (152g:09min), 217.97.25.93 (20560g:31min)'
     sgBany.RowCount := 2;
     sgBany.Cells[0, 1] := '';
     sgBany.Cells[1, 1] := '';
     i := 1;
     while s <> '' do
     begin
          s := trim(s);
          ip := Copy(s, 1, pos(' ', s)-1);
          Delete(s, 1, Length(ip));
          s := Trim(s);
          czas := s;
          Delete(czas, 1, 1);
          czas := Copy(Czas, 1, Pos(')', czas)-1);
          s := Copy(s, Pos(')', s)+2, length(s));
          // ip i czas = '148g:43min';
          czas := StringReplace(czas, 'g', '', [rfReplaceAll, rfIgnoreCase]);
          czas := StringReplace(czas, 'min', '', [rfReplaceAll, rfIgnoreCase]);
          // czas = '148:43';
          dummys := copy(czas, 1, pos(':', czas)-1);
          val(dummys, godziny, kod);
          Delete(Czas, 1, length(dummys)+1);
          val(czas, minuty, kod);

          minuty := minuty+godziny*60;
          //ip i minuty(int)
          sgBany.Cells[0, i] := ip;
          sgBany.Cells[1, i] := inttostr(minuty);
          if i > 1 then sgbany.RowCount := sgBany.RowCount+1;
          inc(i);
     end;
     sgBany.Row := 1;
     sgBanyClick(nil);
end;
procedure TwndCzat.btnUsunBanaClick(Sender: TObject);
begin
     if sgBany.Row = 0 then exit;
     if not JestemOpem then
     begin
          MessageDlg('Sorry, ale nie jesteœ opem :(', mtError, [mbOk], 0);
          exit;
     end;
     Powiedz('/unban '+sgBany.Cells[0, sgBany.Row]);
     Powiedz('/bans');
end;

//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
// edytor funkcji
//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

procedure TwndCzat.btnDodajFunkcjeClick(Sender: TObject);
var funk:string;
begin
     funk := Trim(edtFunkcja.text);
     if funk = '' then exit;
     lbListaFunkcji.Items.Add(funk);

end;

procedure TwndCzat.btnUsunFunkcjeZListyClick(Sender: TObject);
begin
     if lbListaFunkcji.ItemIndex = -1 then exit;
     lbListaFunkcji.Items.Delete(lbListaFunkcji.Itemindex);

end;

procedure TwndCzat.btnZmienFunkcjeWLiscieClick(Sender: TObject);
var funk:string;
begin
     if lbListaFunkcji.ItemIndex = -1 then exit;
     funk := Trim(edtFunkcja.text);
     if funk = '' then exit;
     lbListaFunkcji.Items[lbListaFunkcji.ItemIndex] := funk;


end;

procedure TwndCzat.lbListaFunkcjiClick(Sender: TObject);
begin
     if lbListaFunkcji.ItemIndex = -1 then exit;
     edtFunkcja.Text := lbListaFunkcji.items[lbListaFunkcji.ItemIndex];
end;

procedure TwndCzat.ListaUserowPopupMenuPopup(Sender: TObject);
var item:TMenuItem;
    i:integer;
    dodalemlinie:boolean;
begin
     for i := 0 to ListaUserowPopupMenu.Items.Count-1 do
     begin
          if ListaUserowPopupMenu.Items[i].Name = 'funkcje' then
          begin
               while not (ListaUserowPopupMenu.Items.Count = i) do
               begin
                    item := ListaUserowPopupMenu.Items[ListaUserowPopupMenu.Items.Count-1];
                    item.Free;
               end;
               Break;
          end;
     end;

     dodalemlinie := false;
     for i := 0 to lbListaFunkcji.Items.Count-1 do
     begin
          if not dodalemLinie then
          begin
               DodalemLinie := True;
               item := TMenuItem.Create(ListaUserowPopupMenu);
               item.Caption := '-';
               item.Name := 'funkcje';
               ListaUserowPopupMenu.Items.Add(item);
          end;
          item := TMenuItem.Create(ListaUserowPopupMenu);
          item.Caption := FormatujTekstFunkcyjny(lbListaFunkcji.Items[i]);
          item.OnClick := wndCzat.WykonajFunkcje;
          ListaUserowPopupMenu.Items.Add(item);
     end; //     for i := 1 to Numer-1 do
end;

procedure TwndCzat.WykonajFunkcje(Sender: TObject);
begin
     Powiedz(TMenuitem(Sender).Caption);
end;


//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
// edytor funkcji dla IP
//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

procedure TwndCzat.lbFunkcjeIPClick(Sender: TObject);
begin
     if lbFunkcjeIP.ItemIndex = -1 then exit;
     edtFunkcjaIP.Text := lbFunkcjeIP.items[lbFunkcjeIP.ItemIndex];

end;

procedure TwndCzat.btnDodajFunkcjeIPClick(Sender: TObject);
var funk:string;
begin
     funk := Trim(edtFunkcjaIP.text);
     if funk = '' then exit;
     lbFunkcjeIP.Items.Add(funk);

end;

procedure TwndCzat.btnUsunFukcjeIPClick(Sender: TObject);
begin
     if lbFunkcjeIP.ItemIndex = -1 then exit;
     lbFunkcjeIP.Items.Delete(lbFunkcjeIP.Itemindex);

end;

procedure TwndCzat.btnZmienFunkcjeIPClick(Sender: TObject);
var funk:string;
begin
     if lbFunkcjeIP.ItemIndex = -1 then exit;
     funk := Trim(edtFunkcjaIP.text);
     if funk = '' then exit;
     lbFunkcjeIP.Items[lbFunkcjeIP.ItemIndex] := funk;
end;

procedure TwndCzat.TimerTransferuTimer(Sender: TObject);
var rozn:longint;
begin
     Rozn := Abs(TransferWartosc - TransferStaraWartosc);
     TransferStaraWartosc := TransferWartosc;

     Rozn := Rozn div 1024;
     lblTransfer.Caption := IntToStr(Rozn)+'kB/s';
end;

procedure TwndCzat.TrayMinimizeToTray(Sender: TObject);
begin
     Hide;
end;

procedure TwndCzat.btnSprawdzInfoClick(Sender: TObject);
begin
     WhoIsMemo.Lines.Clear;
     WhoIsSocket.Close;
     while WhoIsSocket.State <> wsClosed do
           Application.Processmessages;
     WhoIsSocket.Addr := '193.0.0.135';
     WhoIsSocket.Port := '43';
     WhoIsMemo.Lines.Add('£¹czenie z serwerem whois.ripe.net (193.0.0.135)...');
     WhoIsSocket.Connect;
end;

procedure TwndCzat.WhoIsSocketDataAvailable(Sender: TObject; Error: Word);
var s:string;
    linia:string;
    poz:integer;
begin
     s := WhoIsSocket.Text;
     while length(s) > 0 do
     begin
          poz := pos(#$0A, s);
          if poz = 0 then
          begin
               linia := s;
               s := '';
          end else
          begin
               linia := copy(s, 1, poz-1);
               Delete(s, 1, poz);
          end;
          WhoIsMemo.Lines.Add(Linia);
     end;
end;

procedure TwndCzat.WhoIsSocketSessionConnected(Sender: TObject; Error: Word);
begin
     WhoIsMemo.Lines.Add('Nawi¹za³em po³¹czenie. Oczekuje na dane...');
     WhoIsMemo.Lines.Add('');
     WhoIsSocket.SendStr(edtWhoIsIP.text+#13#10);
end;

procedure TwndCzat.WhoIsSocketSessionClosed(Sender: TObject; Error: Word);
begin
     if Error = 0
        then WhoIsMemo.Lines.Add('Po³¹czenie zakoñczone')
        else WhoIsMemo.Lines.Add('Po³¹czenie zakoñczone (kod b³êdu #'+IntToStr(Error)+')');
end;



procedure TwndCzat.menuWhoIsClick(Sender: TObject);
var IP:String;
begin
     IP := TMenuItem(Sender).Caption;
     IP := Trim(Copy(IP, Pos(':', IP)+1, Length(IP)));
     edtWhoIsIP.Text := IP;
     btnSprawdzInfoClick(Sender);
end;

end.
