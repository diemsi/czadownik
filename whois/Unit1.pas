unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, WSocket;

type
  TForm1 = class(TForm)
    WSocket1: TWSocket;
    Edit1: TEdit;
    Button1: TButton;
    Memo1: TMemo;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure WSocket1DataAvailable(Sender: TObject; Error: Word);
    procedure WSocket1SessionConnected(Sender: TObject; Error: Word);
    procedure WSocket1SessionClosed(Sender: TObject; Error: Word);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
     Memo1.Lines.Clear;
     WSocket1.Close;
     while WSocket1.State <> wsClosed do
           Application.Processmessages;
     WSocket1.Addr := '193.0.0.135';
     WSocket1.Port := '43';
     Memo1.Lines.Add('£¹czenie z serwerem whois.ripe.net (193.0.0.135)...');
     WSocket1.Connect;
end;

procedure TForm1.WSocket1DataAvailable(Sender: TObject; Error: Word);
var s:string;
    linia:string;
    poz:integer;
begin
     s := WSocket1.Text;
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
          Memo1.Lines.Add(Linia);
     end;
end;

procedure TForm1.WSocket1SessionConnected(Sender: TObject; Error: Word);
begin
     Memo1.Lines.Add('Nawi¹za³em po³¹czenie. Oczekuje na dane...');
     Memo1.Lines.Add('');
     WSocket1.SendStr(edit1.text+#13#10);
end;

procedure TForm1.WSocket1SessionClosed(Sender: TObject; Error: Word);
begin
     if Error = 0
        then Memo1.Lines.Add('Po³¹czenie zakoñczone')
        else Memo1.Lines.Add('Po³¹czenie zakoñczone (kod b³êdu #'+IntToStr(Error)+')');
end;

end.
