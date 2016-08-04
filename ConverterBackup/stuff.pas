unit stuff;
interface
uses windows, sysutils, forms, graphics, pak, ShellApi, classes, winsock;


Type PTablicaHTML = ^TTablicaHTML;
     TTablicaHTML = Array[1..1024] of String;
Type TLongInt = array[1..4] of byte;
     PLongint = ^TLongInt;

Type TZnakCzata = record
       Java:String[2];
       Windows:Char;
     end;

type PFoncik = ^TFoncik;
     TFoncik = record
       Kolor:TColor;
       Styl:TFontStyles;
     end;

Const MaxLiniiHTML = 400;
      IleSiedziSt = 'dni:%d, godzin:%d, minut:%d';

Type PLiniaHTML = ^TLiniaHTML;
     TLiniaHTML = record
          Elementy:TTablicaHTML;
          IloscElementow:Word;
          WysokoscCalkowita:Byte;
          Wysokosc:array[1..32] of Byte;
          CiagOrginalny:String;
     end;


Type TObrazki = array[0..370] of
        record
           bitmap:TBitMap;
           nazwa:string[15];
        end;
     POknoCzata = ^TOknoCzata;
     TOknoCzata = record
           Linie:array[1..MaxLiniiHTML] of TLiniaHTML;
           OstatniaWidzialna:Integer;
           IloscLinii:Integer;
     end;

Type PMyLogFont = ^TMyLogFont;
     TMyLogFont = record
        LF:TLogFont;
        Kolor:TColor;
     end;



Function DajWersjeProgramu:String;
procedure RozwijanieSkrotowHTML(var s:string);
procedure JavaCodesToWindows(var s:string);
Procedure WstepnaAnalizaHTML(Linia:String; Tablica:PTablicaHTML; var Numer:Word);
Function HTMLColorToDelphi(tekst:string):TColor;
Procedure ZamienKolory(var Ciag:String);
function JavaWordToWord(x:word):word;
function JavaLongToLong(x:Longint):longint;
procedure OdsyfiaczHTML(var zrodlo:string);
Function DelphiColorToHTML(Kolor:TColor):String;
Procedure OdpalLinka(link:string);
procedure GetIPList(const List: TStrings);
Function Wild(input_word,wilds:String;upcase_wish:boolean):Boolean;
function IleSiedzi(m:integer):string;
procedure WindowsCodesTojava(var s:string);


const TabelaKonwersji : array [1..18] of TZnakCzata = (
        (Java: 'Ä˜'; Windows: 'Ê'),
        (Java: 'Ä™'; Windows: 'ê'),
        (Java: 'Ã“'; Windows: 'Ó'),
        (Java: 'Ã³'; Windows: 'ó'),
        (Java: 'Ä„'; Windows: '¥'),
        (Java: 'Ä…'; Windows: '¹'),
        (Java: 'Åš'; Windows: 'Œ'),
        (Java: 'Å›'; Windows: 'œ'),
        (Java: 'Å'; Windows: '£'),
        (Java: 'Å‚'; Windows: '³'),
        (Java: 'Å»'; Windows: '¯'),
        (Java: 'Å¼'; Windows: '¿'),
        (Java: 'Å¹'; Windows: ''),
        (Java: 'Åº'; Windows: 'Ÿ'),
        (Java: 'Ä†'; Windows: 'Æ'),
        (Java: 'Ä‡'; Windows: 'æ'),
        (Java: 'Åƒ'; Windows: 'Ñ'),
        (Java: 'Å„'; Windows: 'ñ'));


var AktywneOkno:THandle;
    MigajTymOknem:THandle;
    WlasnyKolor:String;
    KolorCzasu:String;
    KolorCzata:String;
    LocalIP:String;
    IleObrazkow:Integer;
    TablicaObrazkow:TObrazki;
    OldPrvCount:Integer;
    IloscKOlumnObrazkow:Longint;
    KoloryCzatowiczow:array[1..32] of String;
    IleKolorow:Integer;
    PlikZPokojami:String;

implementation
uses wndmain;

procedure JavaCodesToWindows(var s:string);
var i:word;
begin
     for i := 1 to 18 do
     begin
          s := StringReplace(s,
                      TabelaKonwersji[i].Java,
                      TabelaKonwersji[i].Windows,
                      [rfReplaceAll]);
     end;
end;


Procedure WstepnaAnalizaHTML(Linia:String; Tablica:PTablicaHTML; var Numer:Word);
var poz:integer;
begin
     Numer := 1;
     Tablica^[Numer]:= '';
     while Length(Linia) > 0 do
     begin
          if Numer = 1024 then
          begin
               Dec(Numer);
               exit;
          end;
          if Linia[1] = '<' then
          begin
               // TAG
               Delete(Linia, 1, 1);
               Poz := Pos('>', Linia);
               Tablica^[Numer] := '<'+Copy(Linia, 1, Poz-1)+'>';
               if pos('HREF=', UpperCase(Tablica^[Numer])) = 0
                  then Tablica^[Numer] := UpperCase(Tablica^[Numer]);
               if {(Tablica^[Numer] <> '</FONT>') and
               } (Tablica^[Numer] <> '<BR>')
                 then inc(Numer);
               Tablica^[Numer]:= '';
               Delete(Linia, 1, Poz);
          end else
          begin
               // TEKST
               Poz := Pos('<', Linia);
               if poz = 0 then
               begin
                    Tablica^[Numer] := Linia;
                    Linia := '';
               end else
               begin
                    Tablica^[Numer] := Copy(Linia, 1, Poz-1);
                    Delete(Linia, 1, Poz-1);
               end;
               inc(Numer);
               Tablica^[Numer]:= '';
          end;
     end;
end;

Function DajWersjeProgramu:String;
Type TTranslation = array [1..2] of Word;
var Dlugosc:Longint;
    Dummy:Dword;
    klucz ,A: array[0..200] of Char;
    Bufor:Pointer;
    Bw:pointer;
    dlg2:dword;
begin
     StrPCopy(a, Application.ExeName);
     Dlugosc := GetFileVersionInfoSize(a, Dummy);
     if Dlugosc = 0 then
     begin
          Result := 'B£¥D PROGRAMU!(1)';
          exit;
     end;
     GetMem(Bufor, Dlugosc);
     if getFileVersionInfo(a, 0, Dlugosc, Bufor) then
     begin
          if not VerQueryValue(Bufor,'\VarFileInfo\Translation', bw, dlg2) then
          begin
               Result := 'B£¥D PROGRAMU!(3)';
               exit;
          end;
          FillChar(Klucz, SizeOf(Klucz), #0);
          StrCat(klucz, '\StringFileInfo\');
          StrPCopy(a, IntToHex(TTranslation(bw^)[1], 4)); strCat(Klucz, a);
          StrPCopy(a, IntToHex(TTranslation(bw^)[2], 4)); strCat(Klucz, a);
          StrCat(klucz, '\FileVersion');
          if not VerQueryValue(Bufor,Klucz, bw, dlg2) then
          begin
               Result := 'B£¥D PROGRAMU!(4)';
               exit;
          end;
          Result := StrPas(bw);
     end else
     begin
          Result := 'B£¥D PROGRAMU!(2)';
     end;
     FreeMem(Bufor, Dlugosc);
end;

procedure RozwijanieSkrotowHTML(var s:string);
begin
     s := StringReplace(s,'&amp;' ,'&' , [rfReplaceAll, rfIgnoreCase]);
     s := StringReplace(s,'&quot;' ,'"' , [rfReplaceAll, rfIgnoreCase]);
     s := StringReplace(s,'&lt;' ,'<' , [rfReplaceAll, rfIgnoreCase]);
     s := StringReplace(s,'&gt;' ,'>' , [rfReplaceAll, rfIgnoreCase]);
end;

Function HTMLColorToDelphi(tekst:string):TColor;
var r,g,b:Byte;
    i:integer;
begin
     Result := clBlack;
     i := 1;
     while not (length(tekst)+1 <= i) do
     begin
          if tekst[i] in ['0'..'9','A'..'F','a'..'f'] then
          begin
               inc(i);
               Continue;
          end;
          Delete(tekst, i, 1);
     end;
     if length(tekst) <> 6 then exit;
     r := StrToInt('$'+copy(tekst, 1, 2));
     g := StrToInt('$'+copy(tekst, 3, 2));
     b := StrToInt('$'+copy(tekst, 5, 2));
     Result := r or (g shl 8) or (b shl 16);
end;

Function DelphiColorToHTML(Kolor:TColor):String;
begin
     Result := '#'+ IntToHex(Kolor and $000000FF, 2);
     Result := Result + IntToHex((Kolor and $0000FF00) shr 8, 2);
     Result := Result + IntToHex((Kolor and $00FF0000) shr 16, 2);
end;

Procedure ZamienKolory(var Ciag:String);
begin
     if WlasnyKolor = '' then Wlasnykolor := '000000';
     Ciag := StringReplace(Ciag, '<czarny>', '<#000000>', [rfReplaceAll, rfIgnoreCase]);
     Ciag := StringReplace(Ciag, '<zielony>', '<#00bf00>', [rfReplaceAll, rfIgnoreCase]);
     Ciag := StringReplace(Ciag, '<niebieski>', '<#0000ff>', [rfReplaceAll, rfIgnoreCase]);
     Ciag := StringReplace(Ciag, '<czerwony>', '<#ff0000>', [rfReplaceAll, rfIgnoreCase]);
     Ciag := StringReplace(Ciag, '<fioletowy>', '<#b300ff>', [rfReplaceAll, rfIgnoreCase]);
     Ciag := StringReplace(Ciag, '<pomarañczowy>', '<#ff9000>', [rfReplaceAll, rfIgnoreCase]);
     Ciag := StringReplace(Ciag, '<br¹zowy>', '<#a55217>', [rfReplaceAll, rfIgnoreCase]);
     Ciag := StringReplace(Ciag, '<szary>', '<#b3b3b3>', [rfReplaceAll, rfIgnoreCase]);
     Ciag := StringReplace(Ciag, '<ró¿owy>', '<#ff00cc>', [rfReplaceAll, rfIgnoreCase]);
     Ciag := StringReplace(Ciag, '<b³êkitny>', '<#00bfe8>', [rfReplaceAll, rfIgnoreCase]);
     Ciag := StringReplace(Ciag, '<turkusowy>', '<#00ddb6>', [rfReplaceAll, rfIgnoreCase]);
     Ciag := StringReplace(Ciag, '<¿ó³ty>', '<#e5d848>', [rfReplaceAll, rfIgnoreCase]);
     Ciag := StringReplace(Ciag, '<kasztanowy>', '<#800000>', [rfReplaceAll, rfIgnoreCase]);
     Ciag := StringReplace(Ciag, '<granatowy>', '<#000080>', [rfReplaceAll, rfIgnoreCase]);
     Ciag := StringReplace(Ciag, '<purpurowy>', '<#800080>', [rfReplaceAll, rfIgnoreCase]);
     Ciag := StringReplace(Ciag, '<oliwkowy>', '<#808000>', [rfReplaceAll, rfIgnoreCase]);
     Ciag := StringReplace(Ciag, '<zielonomodry>', '<#008080>', [rfReplaceAll, rfIgnoreCase]);
     Ciag := StringReplace(Ciag, '<w³asny>', '<#'+WlasnyKolor+'>', [rfReplaceAll, rfIgnoreCase]);
end;

function JavaWordToWord(x:word):word;
begin
     JavaWordToWord := Swap(x);
end;

function JavaLongToLong(x:Longint):longint;
var wyn:longint;
begin
     PLongint(@wyn)^[1] := PLongint(@X)^[4];
     PLongint(@wyn)^[2] := PLongint(@X)^[3];
     PLongint(@wyn)^[3] := PLongint(@X)^[2];
     PLongint(@wyn)^[4] := PLongint(@X)^[1];
     JavaLongToLong := Wyn;
end;

/// Odsyfiacz do HTML
procedure OdsyfiaczHTML(var zrodlo:string);
var poz:integer;
    UsuwamyZnaki:Boolean;
begin
     // 1) usuwamy tagi
     poz := 1;
     UsuwamyZnaki := False;
     if Length(Zrodlo) = 0 then exit;
     repeat
          if Zrodlo[poz] = '<' then
          begin
               UsuwamyZnaki := True;
          end;
          if UsuwamyZnaki Then
          begin
               if Zrodlo[poz] = '>' then UsuwamyZnaki := false;
               Delete(zrodlo, poz, 1);
          end else Inc(Poz);
     until poz > Length(zrodlo);
     // 2) rozwiazujemy skroty jezyka
     Zrodlo := StringReplace(Zrodlo,'&amp;' ,'&' , [rfReplaceAll, rfIgnoreCase]);
     Zrodlo := StringReplace(Zrodlo,'&quot;' ,'"' , [rfReplaceAll, rfIgnoreCase]);
     Zrodlo := StringReplace(Zrodlo,'&lt;' ,'<' , [rfReplaceAll, rfIgnoreCase]);
     Zrodlo := StringReplace(Zrodlo,'&gt;' ,'>' , [rfReplaceAll, rfIgnoreCase]);
     // 4) no i jeszcze na koniec usuwamy zbedne spacje
     Zrodlo := Trim(Zrodlo);
end;

Procedure OdpalLinka(link:string);
var a:array[1..256] of char;
begin
     if Copy(link, 1, 1) = '/' then
     begin
          if wndCzat <> nil then wndczat.Powiedz(link);
     end;
     StrPCopy(@a, link);
     ShellExecute(0, 'open', @a, '', '', SW_SHOW);
end;

/////////////////////////////////////////////////////////////


procedure GetIPList(const List: TStrings);
var
  WSAData: TWSAData;
  HostName: array[0..255] of Char;
  HostInfo: PHostEnt;
  InAddr: ^PInAddr;
begin
     List.Clear;
     if WSAStartup($0101, WSAData) = 0 then
     try
        if gethostname(HostName, SizeOf(HostName)) = 0 then
        begin
             HostInfo := gethostbyname(HostName);
             if HostInfo <> nil then
             begin
                  InAddr := Pointer(HostInfo^.h_addr_list);
                  if (InAddr <> nil) then
                  while InAddr^ <> nil do
                  begin
                       List.Add(inet_ntoa(InAddr^^));
                       Inc(InAddr);
                  end;
             end;
        end;
     finally
            WSACleanup;
     end;
end;

function GetLocalIP:String;
var
  WSAData: TWSAData;
  HostName: array[0..255] of Char;
  HostInfo: PHostEnt;
  InAddr: ^PInAddr;
begin
     Result := '0.0.0.0';
     if WSAStartup($0101, WSAData) = 0 then
     try
        if gethostname(HostName, SizeOf(HostName)) = 0 then
        begin
             HostInfo := gethostbyname(HostName);
             if HostInfo <> nil then
             begin
                  InAddr := Pointer(HostInfo^.h_addr_list);
                  if (InAddr <> nil) then
                  begin
                       result := inet_ntoa(InAddr^^);
                       exit;
                  end;
             end;
        end;
     finally
            WSACleanup;
     end;
end;

Function Wild(input_word,wilds:String;upcase_wish:boolean):Boolean;
 {looking for next *, returns position and string until position}
 function search_next(var wilds:string):word;
 var position:word;
 begin
  position:=pos('*',wilds); {looks for *}

  if position<>0 then wilds:= copy(wilds,1,position-1);
     {returns the string}

  search_next:= position;
 end;

 {compares a string with '?' and another,
  returns the position of helpwilds in input_word}
 function find_part(helpwilds,input_word:string):word;
 var q,q2:word;
     diff:integer;
 begin
  q:= pos('?',helpwilds);

  if q= 0 then
   begin
    {if no '?' in helpwilds}

    find_part:= pos(helpwilds,input_word);
    exit;
   end;

  {'?' in helpwilds}
  diff:= length(input_word)-length(helpwilds);
  if diff<0 then begin find_part:= 0;exit;end;
{  between:= 0;}

  {now move helpwilds over input_word}
  for q:= 0 to diff do
   begin
    for q2:= 1 to length(helpwilds) do
     begin
      if (Copy(input_word, q+q2, 1)= Copy(helpwilds, q2, 1)) or (Copy(helpwilds, q2, 1) = '?') then
       begin if q2= length(helpwilds) then begin find_part:= q+1;exit;end;end
        else break;
     end;
   end;
  find_part:= 0;
 end;
{************************** MAIN ******************************************}
{                this is the mainpart of wild                              }
var cwild,cinput_word:word;{counter for positions}
    q,lengthhelpwilds:word;
    maxinput_word,maxwilds:word;{length of input_word and wilds}
    helpwilds:string;
begin
     Result:= false;

     {uncomment this for often use with 'wildcardless' wilds}
     {if wilds= input_word then begin wild:= true;exit;end;}

     {delete '**', because '**'= '*'}
     repeat
           q:= pos('**',wilds);
           if q<>0 then wilds:= copy(wilds,1,q-1)+'*'+copy(wilds,q+2,255);
     until q= 0;

     {for fast end, if wilds only '*'}
     if wilds= '*' then
     begin
          Result := true;
          exit;
     end;

     maxinput_word:= length(input_word);
     maxwilds := length(wilds);

     {upcase all letters}
     if upcase_wish then
     begin
          input_word := UpperCase(input_word);
          wilds := UpperCase(wilds);
     end;

     {set initialization}
     cinput_word:= 1;
     cwild:= 1;
     Result:= true;

     repeat
           {equal letters}
           if Copy(input_word, cinput_word, 1) = Copy(wilds, cwild, 1) then
           begin
                {goto next letter}
                inc(cwild);
                inc(cinput_word);
                continue;
           end;

           {equal to '?'}
           if Copy(wilds, cwild, 1)= '?' then
           begin
                {goto next letter}
                inc(cwild);
                inc(cinput_word);
                continue;
           end;

           {handling of '*'}
           if Copy(wilds, cwild, 1)= '*' then
           begin
                helpwilds:= copy(wilds,cwild+1,maxwilds);{takes the rest of wilds}
                q := search_next(helpwilds);{search the next '*'}
                lengthhelpwilds:= length(helpwilds);

                if q= 0 then
                begin
                     {no '*' in the rest}
                     {compare the ends}
                     if helpwilds= '' then exit;{'*' is the last letter}

                     {check the rest for equal length and no '?'}
                     for q:= 0 to lengthhelpwilds-1 do
                     if (Copy(helpwilds, lengthhelpwilds-q, 1)<>Copy(input_word, maxinput_word-q, 1)) and
                        (Copy(helpwilds, lengthhelpwilds-q, 1)<>'?') then
                     begin
                          result:= false;
                          exit;
                     end;
                     exit;
                end;

                {handle all to the next '*'}
                inc(cwild,1+lengthhelpwilds);
                q:= find_part(helpwilds,copy(input_word,cinput_word,255));
                if q= 0 then
                begin
                     result:= false;
                     exit;
                end;
                cinput_word:= q+lengthhelpwilds;
                continue;
           end;

           result:= false;
           exit;
     until (cinput_word>maxinput_word) or (cwild>maxwilds);
     if cinput_word>maxinput_word then
     begin
          if copy(input_word, maxinput_word, length(input_word)) = '*' then
          begin
               result := true;
               exit;
          end;
     end;
     {no completed evaluation}
     if cinput_word<= maxinput_word then result:= false;
     if cwild<= maxwilds then result:= false;
end;

function IleSiedzi(m:integer):string;
var dni, minuty, godziny:integer;
begin
     minuty := m mod 60;
     m := m div 60;
     godziny := m mod 24;
     dni := m div 24;
     Result := Format(IleSiedziSt, [dni, godziny, minuty]);
end;


procedure WindowsCodesTojava(var s:string);
var i,poz:integer;
begin
     poz := 1;
     if Length(s) > 0 then
     begin
          repeat
                for i := 1 to 18 do
                begin
                     if TabelaKonwersji[i].Windows = s[poz] then
                     begin
                          Delete(s, poz, 1);
                          Insert(TabelaKonwersji[i].Java, s, poz);
                          Inc(poz);
                          Break;
                     end;
                end;
                Inc(poz);
          until (poz >= Length(s)+1);
          // zamaian kolorow na kody
     end;
end;

begin
     AktywneOkno := 0;
     MIgajTymOknem := 0;
     WlasnyKolor := '000000';
     KolorCzasu := '000000';
     KolorCzata := 'ffffff';
     IleKolorow := 0;
     LocalIP := GetLocalIP;
     IloscKolumnObrazkow := 10;
     plikZPokojami := ExtractFilePath(Application.exename)+'konsola.rooms.htm';
end.
