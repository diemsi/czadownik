unit nl_elem;
interface
uses windows;
// z apleta
	const BIT_SELF      = 4;
	const BIT_IGNORE    = 2;
	const BIT_BUDDY     = 1;
	const BIT_BUSY      = 1;
	const BIT_OP        = 2;
	const BIT_GUEST_NUM = 4;

Type PCzatowicz = ^TCzatowicz;
     TCzatowicz = object
private
       istat:Word;
       gstat:word;
public
       ip:string;

       Function guestNum:Integer;
       Function isBuddy:Boolean;
       Function isBusy:Boolean;
       Function isGuest:Boolean;
       Function isIgnored:Boolean;
       Function isOp:Boolean;
       Function isSelf:Boolean;
       Procedure SetStatus(gst, ist:word);
     end;

implementation

Function TCzatowicz.guestNum:Integer;
begin
     Result := gstat shr BIT_GUEST_NUM;
end;

Function TCzatowicz.isBuddy:Boolean;
begin
     Result := (iStat and BIT_BUDDY) <> 0;
end;

Function TCzatowicz.isBusy:Boolean;
begin
     Result := (gStat and BIT_BUSY) <> 0;
end;

Function TCzatowicz.isGuest:Boolean;
begin
     Result := (gStat and BIT_GUEST_NUM) <> 0;
end;

Function TCzatowicz.isIgnored:Boolean;
begin
     Result := (iStat and BIT_IGNORE) <> 0;
end;

Function TCzatowicz.isOp:Boolean;
begin
     Result := (gStat and BIT_OP) <> 0;
end;

Function TCzatowicz.isSelf:Boolean;
begin
     Result := (iStat and BIT_SELF) <> 0;
end;

Procedure TCzatowicz.SetStatus(gst, ist:word);
begin
     if gst <> word(-1) then gstat := gst;
     if ist <> word(-1) then istat := ist;
end;

end.
