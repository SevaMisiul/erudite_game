object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 311
  ClientWidth = 590
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PlayerNameLabel: TLabel
    Left = 248
    Top = 120
    Width = 97
    Height = 13
    Caption = 'Enter player 1 name'
  end
  object Player: TEdit
    Left = 232
    Top = 168
    Width = 131
    Height = 21
    TabOrder = 0
  end
  object NextPlayerBtn: TButton
    Left = 248
    Top = 232
    Width = 96
    Height = 25
    Caption = 'Next player'
    TabOrder = 1
    OnClick = NextPlayerBtnClick
  end
end
