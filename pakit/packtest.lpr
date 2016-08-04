program PackTest;

{$MODE Delphi}

uses
  Forms, Interfaces,
  main in 'main.pas' {frmPakMaster},
  PakHeader in 'PakHeader.pas',
  PakGlobals in 'PakGlobals.pas',
  PakDirectoryItem in 'PakDirectoryItem.pas',
  PakDirectory in 'PakDirectory.pas',
  Pak in 'Pak.pas',
  SetHeader in 'SetHeader.pas' {frmPakheader};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPakMaster, frmPakMaster);
  Application.Run;
end.

