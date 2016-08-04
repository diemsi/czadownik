object Form1: TForm1
  Left = 343
  Top = 173
  BorderStyle = bsDialog
  Caption = 'KCI WhoIs v0.1 by DMC (www.kutno.vel.pl, dmc@op.pl)'
  ClientHeight = 285
  ClientWidth = 557
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 10
    Width = 57
    Height = 13
    Caption = '&Numer IP:'
    FocusControl = Edit1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 66
    Top = 6
    Width = 301
    Height = 21
    TabOrder = 0
    Text = '213.77.11.29'
  end
  object Button1: TButton
    Left = 422
    Top = 2
    Width = 75
    Height = 25
    Caption = '&SprawdŸ info'
    Default = True
    TabOrder = 1
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 4
    Top = 30
    Width = 551
    Height = 253
    Color = clBlack
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clLime
    Font.Height = -11
    Font.Name = 'Fixedsys'
    Font.Style = []
    Lines.Strings = (
      'KCI WhoIs v0.1 by DMC.'
      '---------------------'
      'Wszelkie uwagi prosze kierowaæ pod: dmc@op.pl'
      'NASZ ADRES: http://www.kutno.vel.pl/'
      '---------------------'
      ''
      'Krótki opis dzia³ania programu:'
      'W polu '#39'Numer IP'#39' nale¿y podaæ identyfikowany numer IP,'
      'a potem klikn¹æ na przycisk [SprawdŸ info].'
      'Program po³¹czy siê z baz¹  WhoIs i œci¹gnie  wymagane'
      'informacje.')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object WSocket1: TWSocket
    LineMode = True
    LineEnd = #13#10
    LineEcho = False
    LineEdit = False
    Addr = '193.0.0.135'
    Port = '43'
    Proto = 'tcp'
    LocalAddr = '0.0.0.0'
    LocalPort = '0'
    MultiThreaded = False
    ComponentOptions = []
    OnDataAvailable = WSocket1DataAvailable
    OnSessionClosed = WSocket1SessionClosed
    OnSessionConnected = WSocket1SessionConnected
    FlushTimeout = 60
    SendFlags = wsSendNormal
    LingerOnOff = wsLingerOn
    LingerTimeout = 0
    SocksLevel = '5'
    SocksAuthentication = socksNoAuthentication
    Left = 240
    Top = 38
  end
end
