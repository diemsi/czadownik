unit unittest;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Pak, StdCtrls, ExtCtrls{, RxGif};

type
  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

procedure TForm1.Button1Click(Sender: TObject);
var Pak:TcymPAK;
    ms:TMemoryStream;
    x:TGifImage;
    sr:tsearchrec;
    n:string;
begin
     DeleteFile('..\gfx.dat');
     pak := TcymPAK.Create(self, '..\gfx.dat');
     pak.Header.AuthorID := 'dmc            ';
     pak.Header.VersionMajor := 1;
     pak.Header.VersionMinor := 14;
//     ShowMessage(pak.Directory.Items[2].Itemname);


     FindFirst('czatowisko\*.gif', faArchive, sr);
     repeat
           n := StringReplace(sr.name, '.gif','',[rfIgnoreCase]);
           pak.AddItem('czatowisko\'+sr.name, n, 0);
     until FindNext(sr) <> 0;
     FindClose(sr);

     MS := TMemoryStream.Create;

     Pak.ItemToStream(19, MS);
     MS.Position := 0;
     x := tgifimage.Create;
     x.LoadFromStream(MS);
     //TODO: Wlasnosc Frames nalezala do TGIFImage; Poprawic ze wzgledu na Lazarusa
     //TODO: http://lazarus-ccr.sourceforge.net/docs/lcl/graphics/tfpimagebitmap.html

     //x.Frames[0].Draw(canvas, rect(1,1,x.Width, x.Height),true);
     x.Free;
     MS.Free;

     pak.Free;
end;

end.
