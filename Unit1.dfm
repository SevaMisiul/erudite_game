object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Form1'
  ClientHeight = 610
  ClientWidth = 994
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object NumberOfPlayersLabel: TLabel
    Left = 416
    Top = 208
    Width = 124
    Height = 13
    Caption = 'Enter nummber of players'
    Visible = False
  end
  object EnterNameLabel: TLabel
    Left = 421
    Top = 208
    Width = 97
    Height = 13
    Caption = 'Player 1 enter name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object StartGameBtn: TButton
    Left = 416
    Top = 516
    Width = 121
    Height = 49
    Caption = 'Start game'
    TabOrder = 0
    OnClick = StartGameBtnClick
  end
  object ContinueButton: TButton
    Left = 440
    Top = 296
    Width = 75
    Height = 25
    Caption = 'Continue'
    TabOrder = 1
    Visible = False
    OnClick = ContinueButtonClick
  end
  object NumberOfPlayersEdit: TEdit
    Left = 416
    Top = 248
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 2
    Visible = False
    OnChange = NumberOfPlayersEditChange
  end
  object NextNameEnterBtn: TButton
    Left = 441
    Top = 296
    Width = 77
    Height = 25
    Caption = 'Next player'
    TabOrder = 3
    Visible = False
    OnClick = NextNameEnterBtnClick
  end
  object PlayerNameEdit: TEdit
    Left = 416
    Top = 248
    Width = 121
    Height = 21
    TabOrder = 4
    Visible = False
    OnChange = PlayerNameEditChange
  end
end
