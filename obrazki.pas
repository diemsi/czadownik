unit obrazki;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Grids, math, Placemnt, RxGIF;

type
  TwndObrazki = class(TForm)
    Panel1: TPanel;
    lblIloscObrazkow: TLabel;
    Label2: TLabel;
    btnZamknij: TButton;
    Obrazki: TStringGrid;
    NazwaObrazka: TLabel;
    Pozycja: TFormPlacement;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnZamknijClick(Sender: TObject);
    procedure ObrazkiDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure ObrazkiClick(Sender: TObject);
    procedure ObrazkiDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  wndObrazki: TwndObrazki;

implementation

uses Stuff, wndmain, pak;

{$R *.DFM}

procedure TwndObrazki.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     Action := caHide;
end;

procedure TwndObrazki.FormCreate(Sender: TObject);
var wart:integer;
    MaxWysokosc, MaxSzerokosc:Integer;
    i:integer;
//    MS:TMemoryStream;
//    X:TGIFImage;
begin
     Pozycja.IniFileName := ExtractFilePath(Application.exename)+'\czat.ini';
     MaxWysokosc := 0;
     MaxSzerokosc := 0;
     For i := 0 to IleObrazkow-1 do
     begin
          MaxWysokosc := Max(MaxWysokosc, TablicaObrazkow[i].bitmap.Height);
          MaxSzerokosc := Max(MaxSzerokosc, TablicaObrazkow[i].bitmap.Width);
     end;

     lblIloscObrazkow.caption := IntToStr(IleObrazkow);

     wart := IleObrazkow div IloscKolumnObrazkow;
     if IleObrazkow mod IloscKolumnObrazkow > 0 then inc(wart);

     Obrazki.RowCount := wart;
     Obrazki.ColCount := IloscKolumnObrazkow;
     Obrazki.DefaultColWidth := MaxSzerokosc;
     Obrazki.DefaultRowHeight := MaxWysokosc;

     ObrazkiClick(nil);
end;

procedure TwndObrazki.btnZamknijClick(Sender: TObject);
begin
     Close;
end;

procedure TwndObrazki.ObrazkiDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var Numer:Integer;
begin
     obrazki.Canvas.FillRect(Rect);
     Numer := ACol+ARow*Obrazki.ColCount;
     if Numer >= IleObrazkow-1 then exit;

     Inc(Rect.Left, obrazki.DefaultColWidth div 2 - TablicaObrazkow[Numer].bitmap.Width div 2);
     Inc(rect.top, obrazki.DefaultRowHeight div 2 - TablicaObrazkow[Numer].bitmap.height div 2);
     BitBlt(Obrazki.canvas.handle, Rect.Left, Rect.Top,
                     TablicaObrazkow[Numer].bitmap.width, TablicaObrazkow[Numer].bitmap.height,
                     TablicaObrazkow[Numer].bitmap.Canvas.Handle,
                     0, 0, SRCCOPY);
end;

procedure TwndObrazki.ObrazkiClick(Sender: TObject);
var numer:integer;
begin
     Numer := Obrazki.Col+Obrazki.Row*Obrazki.ColCount;
     NazwaObrazka.Caption := '';
     if Numer >= IleObrazkow-1 then exit;
     NazwaObrazka.Caption := '<'+LowerCase(TablicaObrazkow[Numer].nazwa)+'>';
end;

procedure TwndObrazki.ObrazkiDblClick(Sender: TObject);
var nazwa,s:string;
    i,sel:integer;
{    priv:TwndPriv;}
    numer:integer;
begin
     if not wndCzat.chkDwuKliknaObrazek.Checked then exit;

     Numer := Obrazki.Col+Obrazki.Row*Obrazki.ColCount;
     if Numer >= IleObrazkow-1 then exit;
     nazwa := '<'+LowerCase(TablicaObrazkow[Numer].nazwa)+'>';

     if AktywneOkno = wndczat.Handle then
     begin
          sel := wndczat.edtTekst.selstart;
          s := wndCzat.edtTekst.text;
          Insert(nazwa, s, sel+1);
          wndCzat.edtTekst.text := s;
          inc(sel, length(nazwa));
          wndCzat.edtTekst.selstart := sel;
          wndczat.edttekst.SetFocus;
     end else
     begin
{          for i := 1 to MaxPriv do
          begin
               priv := Privy[i];
               if not assigned(priv) then continue;
               if priv.Handle <> AktywneOkno then Continue;

               sel := priv.edtTekst.selstart;
               s := priv.edtTekst.text;
               Insert(nazwa, s, sel+1);
               priv.edtTekst.text := s;
               inc(sel, length(nazwa));
               priv.edtTekst.selstart := sel;
               priv.edttekst.SetFocus;
               exit;
          end;
          //pewnie okno priv zostalo zamkniete
}          
     end;
     if wndCzat.chkChowajObrazki.Checked then Hide;
end;

end.
