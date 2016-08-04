object Form1: TForm1
  Left = 222
  Top = 103
  BorderStyle = bsDialog
  Caption = 'Form1'
  ClientHeight = 116
  ClientWidth = 393
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
    Left = 12
    Top = 14
    Width = 25
    Height = 13
    Caption = 'Nick:'
  end
  object Label2: TLabel
    Left = 12
    Top = 40
    Width = 20
    Height = 13
    Caption = 'Plik:'
  end
  object edtNick: TEdit
    Left = 40
    Top = 10
    Width = 339
    Height = 21
    TabOrder = 0
  end
  object edtPlik: TEdit
    Left = 40
    Top = 36
    Width = 339
    Height = 21
    TabOrder = 1
    Text = 'bzium.exe'
  end
  object btnBlokuj: TButton
    Left = 302
    Top = 70
    Width = 75
    Height = 25
    Caption = 'Blokuj'
    Default = True
    TabOrder = 2
    OnClick = btnBlokujClick
  end
end
