unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, OleCtrls, SHDocVw;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    ListBox1: TListBox;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

Function PoliczZnaki(znak:char; st:string):Integer;
var i:integer;
begin
     Result := 0;
     for i := 1 to length(st) do
         if copy(st, i, 1) = znak then inc(result);
end;

function IsValidIP(ip:string):Boolean;
var poz:integer;
    czlon:string;
    iczlon, kod:integer;
begin
     Result := False;
     // ip musi miec 3 znaki
     if PoliczZnaki('.', ip) <> 3
        then exit;

     // teraz rozwalamy na slowa i rozpoznajemy numery ip
     while not (ip = '') do
     begin
          poz := pos('.', ip);
          if poz = 0 then
          begin
               czlon := ip;
               ip := '';
          end else
          begin
               czlon := copy(ip, 1, poz-1);
               Delete(ip, 1, poz);
               ip := trim(ip);
          end;
          val(czlon, iczlon, kod);
          if kod <> 0 then exit; // blad konwersji
          if iczlon < 0 then exit; // za ma³y ??
          if iczlon > 255 then exit; //zycie to nie film 'SYSTEM' :)
     end;
     Result := True;
end;

procedure TForm1.Button1Click(Sender: TObject);
var s:string;
    poz:integer;
    slowo:string;
begin
     listbox1.items.clear;
     s := edit1.text;
     poz := 1;
     // teraz mamy tylko numery ip (chyba);
     while not (poz > length(s)) do
     begin
          if s[poz] in ['0'..'9', '.', ' '] then
          begin
               inc(poz);
               continue;
          end else Delete(s, poz, 1);
     end;
     s := trim(s);
     // teraz rozwalamy na slowa i rozpoznajemy numery ip
     while not (s = '') do
     begin
          poz := pos(' ', s);
          if poz = 0 then
          begin
               slowo := s;
               s := '';
          end else
          begin
               slowo := copy(s, 1, poz-1);
               Delete(s, 1, poz);
               s := trim(s);
          end;
          // slowo to nasz domniemany numer ip
          if isValidIP(slowo)
             then ListBox1.Items.Add(slowo);

     end;




end;

end.

