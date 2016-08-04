program czat;

{$MODE Delphi}

Uses Interfaces, Windows, SysUtils, Dialogs, shellapi;
{$R *.res}
var plik:string;
    f:textfile;
    we,wy:file;
    NumRead, NumWritten:Integer;
    Buf:array[1..2048] of Char;
    x:boolean;

//procedure StartCzata; external 'MAIN.DLL';
begin
     {$I-}
     MkDir('nowa_wersja');
     if (IOResult <> 0) and FileExists('lista.txt') then
     begin
          ShowMessage('Teraz nastąpi dokończenie aktualizacji programu...');
          assignfile(f, 'lista.txt');
          reset(f);
          while not eof(f) do
          begin
               ReadLn(f, Plik);

               if Copy(Plik, Length(Plik), 1) = '\' then
               begin
                    Delete(plik, Length(Plik), 1);
                    MkDir(plik);
                    Continue;
               end;

               if not FileExists('nowa_wersja\'+plik) then
               begin
                    ShowMessage('Plik '+'nowa_wersja\'+plik+' nie istnieje');
                    Continue;
               end;
               assign(we, 'nowa_wersja\'+plik); reset(we, 1);
               assign(wy, plik); rewrite(wy, 1);
               repeat
                     BlockRead(we, Buf, SizeOf(Buf), NumRead);
                     BlockWrite(wy, Buf, NumRead, NumWritten);
               until (NumRead = 0) or (NumWritten <> NumRead);
               CloseFile(wy);
               CloseFile(we);
               DeleteFile('nowa_wersja\'+plik);
          end;
          closefile(f);
          DeleteFile('lista.txt');
          DeleteFile('numer.dat');
     end;
     RmDir('nowa_wersja');
     ShellExecute(0, 'open', 'bzium.exe', '-bziumbzium', '', SW_SHOW);
//     StartCzata;

end.
