unit wnd_LIC;
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, mycrc;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    edtNick: TEdit;
    Label2: TLabel;
    edtPlik: TEdit;
    btnBlokuj: TButton;
    procedure btnBlokujClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

Type TLockData = record
      nick:array[1..255] of Char;
      Suma:Dword;
     end;

procedure TForm1.btnBlokujClick(Sender: TObject);
var LockData:TLockData;
    s:string;
    i:integer;
    f:file;
begin
     makecrc32table;
     RandSeed := $1024;
     FillChar(LockData, SizeOf(TLockData), 0);
     s := edtNick.text;
     Move(Pointer(s)^, LockData.Nick, length(s));
     LockData.Suma := calccrc(s);
     for i := 1 to sizeof(LockData.Nick) do
     begin
          LockData.Nick[i] := Chr(Ord(LockData.Nick[i]) xor Byte(Random($123456)));
     end;
     AssignFile(f, edtPlik.text);
     Reset(f, 1);
     Seek(f, filesize(f));
     blockwrite(f, LockData, SizeOf(TLockData));
     CloseFile(f);
     Close;
end;

end.
