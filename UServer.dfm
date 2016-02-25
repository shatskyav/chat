object FmChat: TFmChat
  Left = 0
  Top = 0
  Caption = #1063#1072#1090' '#1057#1077#1088#1074#1077#1088
  ClientHeight = 593
  ClientWidth = 847
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnmenu: TPanel
    Left = 0
    Top = 0
    Width = 847
    Height = 41
    Align = alTop
    TabOrder = 0
  end
  object pnSend: TPanel
    Left = 0
    Top = 533
    Width = 847
    Height = 60
    Align = alBottom
    TabOrder = 1
    object tmSend: TMemo
      Left = 1
      Top = 1
      Width = 695
      Height = 58
      Align = alClient
      TabOrder = 0
    end
    object btnSend: TButton
      Left = 696
      Top = 1
      Width = 150
      Height = 58
      Align = alRight
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100
      TabOrder = 1
      OnClick = btnSendClick
    end
  end
  object pnChat: TPanel
    Left = 0
    Top = 41
    Width = 847
    Height = 492
    Align = alClient
    TabOrder = 2
    object pnUsers: TPanel
      Left = 696
      Top = 1
      Width = 150
      Height = 490
      Align = alRight
      TabOrder = 0
      object lstUser: TListBox
        Left = 1
        Top = 1
        Width = 148
        Height = 488
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
      end
    end
    object tmChat: TMemo
      Left = 1
      Top = 1
      Width = 695
      Height = 490
      Align = alClient
      TabOrder = 1
      OnChange = tmChatChange
    end
  end
  object tsrv1: TTcpServer
    LocalHost = 'localhost'
    LocalPort = '3308'
    OnAccept = tsrv1Accept
    OnGetThread = tsrv1GetThread
    Left = 760
  end
  object tcl1: TTcpClient
    RemoteHost = 'localhost'
    RemotePort = '3308'
    Left = 800
  end
  object tmr1: TTimer
    OnTimer = tmr1Timer
    Left = 640
    Top = 8
  end
  object IdSMTP1: TIdSMTP
    AuthType = satNone
    SASLMechanisms = <>
    Left = 744
    Top = 64
  end
  object idmsg1: TIdMessage
    AttachmentEncoding = 'MIME'
    BccList = <>
    CCList = <>
    Encoding = meDefault
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 792
    Top = 64
  end
end
