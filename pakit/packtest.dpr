program PackTest;

uses
  Forms,
  main in 'main.pas' {frmPakMaster},
  PakHeader in 'PakHeader.pas',
  PakGlobals in 'PakGlobals.pas',
  PakDirectoryItem in 'PakDirectoryItem.pas',
  PakDirectory in 'PakDirectory.pas',
  Pak in 'Pak.pas',
  SetHeader in 'SetHeader.pas' {frmPakheader};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPakMaster, frmPakMaster);
  Application.Run;
end.

