unit wnd_Splash;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type
  TwndSplash = class(TForm)
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Start:Longint;
  end;

var
  wndSplash: TwndSplash;

implementation

{$R *.DFM}

procedure TwndSplash.Timer1Timer(Sender: TObject);
begin
     Close;
end;
                                                                                
procedure TwndSplash.FormCreate(Sender: TObject);
begin
     Timer1.Enabled := True;
end;

end.
