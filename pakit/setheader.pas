unit SetHeader;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Buttons;

type
  TfrmPakheader = class(TForm)
    edtAuthor: TEdit;
    btnOK: TBitBtn;
    btnAbort: TBitBtn;
    spinVerMajor: TSpinEdit;
    spinVerMinor: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPakheader: TfrmPakheader;

implementation

{$R *.lfm}

end.
