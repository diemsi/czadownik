program projtest;

uses
  Forms,
  unittest in 'unittest.pas' {Form1},
  Pak in 'pak.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
