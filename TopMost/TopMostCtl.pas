unit TopMostCtl;
{
by Michel BRAIZAZ - KK Wett Productions - 1997
e-mail : braizaz@mygale.org
web : http://www.mygale.org/07/braizaz/delphi/delphi.htm
}

{**** THE "TTOPMOST" COMPONENT IS FREEWARE ***}

{
Version 1.0

Placed on a form, this component keep it in front of all other
 windows, even when losing focus.
The only property is "OnTop" which may be True for keeping
 the form on the front.
}


interface

{$IFDEF WIN32}
uses
  Windows, Messages, SysUtils, Classes, Forms;
{$ELSE}
uses
  Winprocs, Wintypes, Messages, SysUtils, Classes, Forms;
{$ENDIF}

type
  TTopMost = class(TComponent)
  private
    FOnTop:Boolean;
    Procedure SetOnTop(Value:Boolean);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property OnTop: Boolean read FOnTop write SetOnTop default True;
                         {I've got a problem with the default value}
  end;

procedure Register;

implementation

{$IFDEF WIN32}
     {$R TopMos32.dcr}
{$ELSE}
     {$R TopMos16.dcr}
{$ENDIF}

constructor TTopMost.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   SetOnTop(True);
end;

destructor TTopMost.Destroy;
begin
   SetOnTop(False);
   inherited Destroy;
end;

Procedure TTopMost.SetOnTop(Value:Boolean);
begin
     FOnTop := Value;
     if (Owner is TForm) then
        begin
        if Value then
           SetWindowPos((Owner as TForm).Handle, HWND_TOPMOST, 0,0,0,0, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE)
        else
            SetWindowPos((Owner as TForm).Handle, HWND_NOTOPMOST,0,0,0,0, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);


            {other ideas which doesn't work...}

{        SetWindowLong((Owner as TForm).Handle,GWL_EXSTYLE,
               GetWindowLong((Owner as TForm).Handle, GWL_EXSTYLE) or WS_EX_TOPMOST);}

{        (Owner as TForm).ExStyle := (Owner as TForm).ExStyle or WS_EX_TOPMOST;}
        end;
end;

procedure Register;
begin
  RegisterComponents('Kompo', [TTopMost]);
end;

end.
