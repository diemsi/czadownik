object wndSplash: TwndSplash
  Left = 169
  Top = 169
  BorderStyle = bsNone
  ClientHeight = 256
  ClientWidth = 333
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object CoolForm1: TCoolForm
    left = 0
    top = 0
    width = 333
    height = 256
    Align = alClient
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = Timer1Timer
    Left = 264
    Top = 14
  end
end
