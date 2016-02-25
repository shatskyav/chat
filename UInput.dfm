object FmInput: TFmInput
  Left = 0
  Top = 0
  Caption = #1042#1093#1086#1076
  ClientHeight = 221
  ClientWidth = 249
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 79
    Width = 76
    Height = 13
    Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100':'
  end
  object Label2: TLabel
    Left = 32
    Top = 125
    Width = 41
    Height = 13
    Caption = #1055#1072#1088#1086#1083#1100':'
  end
  object Label3: TLabel
    Left = 32
    Top = 40
    Width = 31
    Height = 13
    Caption = #1040#1076#1088#1077#1089
  end
  object cbTip: TComboBox
    Left = 32
    Top = 8
    Width = 185
    Height = 21
    ItemIndex = 0
    TabOrder = 0
    Text = #1057#1077#1088#1074#1077#1088
    OnChange = cbTipChange
    Items.Strings = (
      #1057#1077#1088#1074#1077#1088
      #1050#1083#1080#1077#1085#1090)
  end
  object edUser: TEdit
    Left = 32
    Top = 98
    Width = 185
    Height = 21
    TabOrder = 2
  end
  object edPass: TEdit
    Left = 32
    Top = 144
    Width = 185
    Height = 21
    PasswordChar = '#'
    TabOrder = 3
  end
  object edAdress: TEdit
    Left = 32
    Top = 56
    Width = 185
    Height = 21
    TabOrder = 1
    Text = 'localhost'
  end
  object btn1: TBitBtn
    Left = 32
    Top = 176
    Width = 185
    Height = 37
    Caption = #1042#1093#1086#1076
    Default = True
    TabOrder = 4
    OnClick = btn1Click
  end
end
