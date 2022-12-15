object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 573
  ClientWidth = 947
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object NumberOfPlayersLabel: TLabel
    Left = 432
    Top = 216
    Width = 124
    Height = 13
    Caption = 'Enter nummber of players'
    Visible = False
  end
  object EnterNameLabel: TLabel
    Left = 282
    Top = 272
    Width = 97
    Height = 13
    Caption = 'Player 1 enter name'
    Visible = False
  end
  object StartGameBtn: TButton
    Left = 416
    Top = 488
    Width = 121
    Height = 49
    Caption = 'Start game'
    TabOrder = 0
    OnClick = StartGameBtnClick
  end
  object ContinueButton: TButton
    Left = 456
    Top = 304
    Width = 75
    Height = 25
    Caption = 'Continue'
    TabOrder = 1
    Visible = False
    OnClick = ContinueButtonClick
  end
  object NumberOfPlayersEdit: TEdit
    Left = 432
    Top = 256
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 2
    Visible = False
    OnChange = NumberOfPlayersEditChange
  end
  object NextNameEnterBtn: TButton
    Left = 296
    Top = 344
    Width = 75
    Height = 25
    Caption = 'Next player'
    TabOrder = 3
    Visible = False
    OnClick = NextNameEnterBtnClick
  end
  object PlayerNameEdit: TEdit
    Left = 272
    Top = 304
    Width = 121
    Height = 21
    TabOrder = 4
    Visible = False
  end
end
