program Lic;

uses
  Forms,
  wnd_LIC in 'wnd_LIC.pas' {Form1},
  mycrc in '..\kci\mycrc.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
