object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 370
  ClientWidth = 644
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object NumberLabel: TLabel
    Left = 264
    Top = 96
    Width = 124
    Height = 13
    Caption = 'Enter nummber of players'
  end
  object NumberOfPlayersEdit: TEdit
    Left = 264
    Top = 144
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 0
    OnChange = NumberOfPlayersEditChange
  end
  object SubmitButton: TButton
    Left = 288
    Top = 192
    Width = 75
    Height = 25
    Caption = 'Submit'
    TabOrder = 1
    OnClick = SubmitButtonClick
  end
end
