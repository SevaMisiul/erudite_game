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
  PixelsPerInch = 96
  TextHeight = 13
  object PlayerNameLabel: TLabel
    Left = 256
    Top = 120
    Width = 88
    Height = 13
    Caption = 'Enter player name'
  end
  object Player: TEdit
    Left = 304
    Top = 176
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object NextPlayerBtn: TButton
    Left = 288
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Next player'
    TabOrder = 1
  end
end