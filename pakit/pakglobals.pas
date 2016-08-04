(*******************************************************************************

Author:    Sean Mathews

Date:      28/02/1999

Version:   0.1

********************************************************************************)
unit PakGlobals;

{$MODE Delphi}

interface

uses
  SysUtils;

const
  VER_MAJOR_CURRENT = 0;
  VER_MINOR_CURRENT = 1;

type
  EcymPakException = class(Exception);

procedure StrToArr(var Arr: array of Char; const Str: string);

implementation

procedure StrToArr(var Arr: array of Char; const Str: string);
var
  loop, last: Integer;
begin
  fillchar(Arr, High(Arr), #0);
  if length(Str) > High(Arr) then last := High(Arr)
  else Last := Length(Str);
  for loop := 0 to last do
  begin
    Arr[loop] := Str[loop + 1];
  end;
end;

end.

