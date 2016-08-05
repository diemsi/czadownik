object wndPokoje: TwndPokoje
  Left = 243
  Top = 229
  Width = 362
  Height = 381
  Caption = 'Lista pokoi...'
  Color = clBtnFace
  Constraints.MinHeight = 275
  Constraints.MinWidth = 344
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    346
    342)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 14
    Top = 307
    Width = 157
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Wejd'#378' do pokoju io nazwie:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 322
    Width = 346
    Height = 20
    Panels = <>
  end
  object edtPokoj: TEdit
    Left = 176
    Top = 305
    Width = 83
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 1
    Text = 'kci'
  end
  object Button1: TButton
    Left = 266
    Top = 303
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Wejd'#378'!'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = Button1Click
  end
  object Panel1: TPanel
    Left = 8
    Top = 40
    Width = 337
    Height = 256
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvLowered
    TabOrder = 3
    DesignSize = (
      337
      256)
    object web: TWebBrowser
      Left = 2
      Top = 2
      Width = 333
      Height = 252
      Align = alClient
      TabOrder = 0
      OnBeforeNavigate2 = webBeforeNavigate2
      ControlData = {
        4C0000006B2200000C1A00000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126200000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
    object PanelWczytywania: TPanel
      Left = 67
      Top = 21
      Width = 203
      Height = 58
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clTeal
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      DesignSize = (
        203
        58)
      object Label2: TLabel
        Left = 27
        Top = 13
        Width = 148
        Height = 13
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Wczytywanie listy pokoi...'
      end
      object Label3: TLabel
        Left = 19
        Top = 31
        Width = 166
        Height = 13
        Anchors = [akLeft, akTop, akRight]
        Caption = 'To mo'#380'e troszke potrwa'#263'! :->'
      end
    end
  end
  object Panel2: TPanel
    Left = 46
    Top = 6
    Width = 263
    Height = 31
    BevelOuter = bvNone
    TabOrder = 4
    object Label4: TLabel
      Left = 4
      Top = 10
      Width = 48
      Height = 13
      Caption = 'Kategorie:'
    end
    object cbKat: TComboBox
      Left = 58
      Top = 6
      Width = 199
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = FormShow
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 28
    Top = 38
  end
end
