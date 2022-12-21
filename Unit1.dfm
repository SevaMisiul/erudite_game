object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Erudite'
  ClientHeight = 600
  ClientWidth = 1000
  Color = clCream
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object EnterLabel: TLabel
    Left = 416
    Top = 317
    Width = 116
    Height = 13
    Caption = 'Enter number of players'
    Visible = False
  end
  object AddWordLabel: TLabel
    Left = 648
    Top = 296
    Width = 3
    Height = 13
    Visible = False
  end
  object FiftyLabel: TLabel
    Left = 8
    Top = 296
    Width = 168
    Height = 13
    Caption = 'Enter 5 letters you want to replace'
    Visible = False
  end
  object HelpLabel: TLabel
    Left = 224
    Top = 296
    Width = 3
    Height = 13
    Visible = False
  end
  object WonPlayerLabel: TLabel
    AlignWithMargins = True
    Left = 0
    Top = 112
    Width = 992
    Height = 21
    Alignment = taCenter
    AutoSize = False
    Caption = 'WonPlayerLabel'
    Color = 6223851
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
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
    Top = 386
    Width = 75
    Height = 25
    Caption = 'Continue'
    TabOrder = 1
    Visible = False
    OnClick = ContinueButtonClick
  end
  object IntEdit: TEdit
    Left = 411
    Top = 336
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 2
    Visible = False
    OnChange = IntEditChange
  end
  object NextNameEnterBtn: TButton
    Left = 440
    Top = 384
    Width = 77
    Height = 25
    Caption = 'Next player'
    TabOrder = 3
    Visible = False
    OnClick = NextNameEnterBtnClick
  end
  object NameEdit: TEdit
    Left = 411
    Top = 336
    Width = 121
    Height = 21
    TabOrder = 4
    Visible = False
    OnChange = NameEditChange
  end
  object GameMoveBtn: TButton
    Left = 440
    Top = 384
    Width = 77
    Height = 25
    Caption = 'Skip'
    TabOrder = 5
    Visible = False
    OnClick = GameMoveBtnClick
  end
  object WordEdit: TEdit
    Left = 411
    Top = 336
    Width = 121
    Height = 21
    CharCase = ecLowerCase
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
  object FiftyBtn: TButton
    Left = 32
    Top = 384
    Width = 57
    Height = 25
    Caption = '50-50'
    TabOrder = 9
    Visible = False
    OnClick = FiftyBtnClick
  end
  object HelpBtn: TButton
    Left = 224
    Top = 384
    Width = 73
    Height = 25
    Caption = 'Help a friend'
    TabOrder = 10
    Visible = False
    OnClick = HelpBtnClick
  end
  object FiftyEdit: TEdit
    Left = 32
    Top = 336
    Width = 137
    Height = 21
    CharCase = ecLowerCase
    MaxLength = 5
    TabOrder = 11
    Visible = False
    OnChange = FiftyEditChange
  end
  object FiftyConfirmBtn: TButton
    Left = 112
    Top = 384
    Width = 57
    Height = 25
    Caption = 'Confirm'
    TabOrder = 12
    Visible = False
    OnClick = FiftyConfirmBtnClick
  end
  object HelpEdit: TEdit
    Left = 224
    Top = 336
    Width = 153
    Height = 21
    CharCase = ecLowerCase
    MaxLength = 1
    TabOrder = 13
    Visible = False
    OnChange = HelpEditChange
  end
  object HelpConfirmBtn: TButton
    Left = 312
    Top = 384
    Width = 65
    Height = 25
    Caption = 'Confirm'
    TabOrder = 14
    Visible = False
    OnClick = HelpConfirmBtnClick
  end
  object PlayersComboBox: TComboBox
    Left = 224
    Top = 336
    Width = 153
    Height = 21
    Style = csDropDownList
    TabOrder = 15
    Visible = False
    OnChange = PlayersComboBoxChange
  end
end
