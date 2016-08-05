program bzium;

uses
  Forms,
  windows,
  SysUtils,
  Dialogs,
  wndmain in 'wndmain.pas' {wndCzat},
  obrazki in 'obrazki.pas' {wndObrazki},
  stale in 'stale.pas',
  stuff in 'stuff.pas',
  Pak in 'pakit\pak.pas',
  wnd_Splash in 'wnd_Splash.pas' {wndSplash},
  pokoje in 'pokoje.pas' {wndPokoje},
  nl_elem in 'nl_elem.pas',
  ip_parser in 'ip_parser.pas',
  mycrc in 'mycrc.pas';

Type TLockData = record
      nick:array[1..255] of Char;
      Suma:Dword;
     end;

{$R *.RES}
{$R BZIKONY.RES}

var LockData:TlockData;
    f:file;
    i:integer;
begin
     if ParamStr(1) <> '-bziumbzium' then exit;
     if not FileExists('gfx.dat') then
     begin
          MessageDlg('Do poprawnej pracy programu wymagany jest plik gfx.dat', mtError, [mbOk], 0);
          exit;
     end;

     makecrc32table;
     FileMode := 0;
     AssignFile(f, paramstr(0));
     Reset(f, 1);
     Seek(f, FileSize(f)-SizeOf(TLockData));
     BlockRead(f, LockData, SizeOf(TLockData), i);
     RandSeed := $1024;
     for i := 1 to sizeof(LockData.Nick) do
     begin
          LockData.Nick[i] := Chr(Ord(LockData.Nick[i]) xor Byte(Random($123456)));
     end;
     WymuszonyNick := StrPas(@LockData.Nick);
     WymuszanieNicka := True;

     CloseFile(f);

     if (Dword(calccrc(WymuszonyNick)) <> dword(LockData.Suma)) and (not (LockData.Suma = 0)) then
     begin
          exit;
     end;
     if LockData.Suma = 0 then
     begin
          WymuszonyNick := '';
          WymuszanieNicka := False;
     end;


     FileMode := 2;

     Randomize;
     Application.Initialize;
     Application.Title := 'KCI Czadownik';
     Application.Icon.Handle := LoadIcon(MainInstance, 'Z_IKONKA');
     Application.CreateForm(TwndCzat, wndCzat);
  Application.CreateForm(TwndPokoje, wndPokoje);
  Application.CreateForm(TwndObrazki, wndObrazki);
  wndSplash := TwndSplash.Create(Application);
     wndSplash.Show;
     wndSplash.Refresh;
     Application.Run;


end.
