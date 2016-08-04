unit mycrc;
interface
uses windows;
procedure makecrc32table;
function updatecrc32(c : byte; crc : dword) : dword;
function calccrc(pass1: string) : dword;
Type
    TCRC32Table = array[0..255] of dword;

implementation
var Crc32Table:TCRC32Table;
procedure MakeCRC32Table;
var crc:dword;
    i,n:byte;
begin
     for i := 0 to 255 do
     begin
          crc := i;
          for n := 1 to 8 do
              if odd(crc)
                 then crc := (crc shr 1) xor $EDB88320
                 else crc := crc shr 1;
         crc32table[i] := crc;
     end;
end;

function updateCRC32(c : byte; crc : dword) : dword;
begin
     updateCRC32 := crc32table[lo(crc) xor c] xor (crc shr 8);
end;

function calccrc(pass1 : string) : dword;
var crcval:dword;
    j:dword;
begin
     makecrc32table;
     crcval := $FFFFFFFF;
     for j := 1 to length(pass1) do
     begin
          crcval := updateCRC32(ord(pass1[j]),crcval);
     end;
     calccrc := crcval;
end;

end.


