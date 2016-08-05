unit SocketsD7;
 
interface  
 
uses  
  SysUtils, Classes, Controls, ExtCtrls, Scktcomp;  
 
procedure Register;
 
implementation  
 
procedure Register;  
begin  
  RegisterComponents('Internet', [TServerSocket]);  
  RegisterComponents('Internet', [TClientSocket]);  
end;  
 
end. 
