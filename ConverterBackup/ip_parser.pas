unit ip_parser;
interface
uses windows, sysutils, classes;

function IsValidIP(ip:string):Boolean;
Function PoliczZnaki(znak:char; st:string):Integer;
procedure GetIPsFromText(s:String; var lista:TStringList);

implementation

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

procedure GetIPsFromText(s:String; var lista:TStringList);
var poz:integer;
    slowo:string;
begin
     lista := TStringList.Create;
     lista.clear;
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
             then lista.Add(slowo);
     end; //while
end;

end.
