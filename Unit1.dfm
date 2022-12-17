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
  object EnterLabel: TLabel
    Left = 416
    Top = 296
    Width = 116
    Height = 13
    Caption = 'Enter number of players'
    Visible = False
  end
  object AddWordLabel: TLabel
    Left = 648
    Top = 296
    Width = 217
    Height = 21
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
    Top = 384
    Width = 75
    Height = 25
    Caption = 'Continue'
    TabOrder = 1
    Visible = False
    OnClick = ContinueButtonClick
  end
  object IntEdit: TEdit
    Left = 416
    Top = 336
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 2
    Visible = False
    OnChange = IntEditChange
  end
  object NextNameEnterBtn: TButton
    Left = 441
    Top = 384
    Width = 77
    Height = 25
    Caption = 'Next player'
    TabOrder = 3
    Visible = False
    OnClick = NextNameEnterBtnClick
  end
  object NameEdit: TEdit
    Left = 416
    Top = 336
    Width = 121
    Height = 21
    TabOrder = 4
    Visible = False
    OnChange = NameEditChange
  end
  object GameMoveBtn: TButton
    Left = 441
    Top = 384
    Width = 77
    Height = 25
    Caption = 'Skip'
    TabOrder = 5
    Visible = False
    OnClick = GameMoveBtnClick
  end
  object WordEdit: TEdit
    Left = 416
    Top = 336
    Width = 121
    Height = 21
    TabOrder = 6
    Visible = False
    OnChange = WordEditChange
  end
  object YesBtn: TButton
    Left = 648
    Top = 364
    Width = 65
    Height = 33
    Caption = 'Yes'
    TabOrder = 7
    Visible = False
    OnClick = YesBtnClick
  end
  object NoBtn: TButton
    Left = 806
    Top = 364
    Width = 59
    Height = 33
    Caption = 'No'
    TabOrder = 8
    Visible = False
    OnClick = NoBtnClick
  end
end
