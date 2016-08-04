program projtest;

{$MODE Delphi}

uses
  Interfaces, Forms,
  unittest in 'unittest.pas' {Form1},
  Pak in 'pak.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
