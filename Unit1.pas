unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.UITypes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

const
  Vowel = ['a', 'e', 'i', 'o', 'u', 'y'];

type
  TForm1 = class(TForm)
    StartGameBtn: TButton;
    EnterLabel: TLabel;
    ContinueButton: TButton;
    IntEdit: TEdit;
    NextNameEnterBtn: TButton;
    NameEdit: TEdit;
    GameMoveBtn: TButton;
    WordEdit: TEdit;
    procedure IntEditChange(Sender: TObject);
    procedure ContinueButtonClick(Sender: TObject);
    procedure NextNameEnterBtnClick(Sender: TObject);
    procedure StartGameBtnClick(Sender: TObject);
    procedure NameEditChange(Sender: TObject);
    procedure WordEditChange(Sender: TObject);
    procedure GameMoveBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TPlayerPanel = record
    Name: TLabel;
    Score: TLabel;
    Letters: TLabel;
    Panel: TPanel;
    IntScore: integer;

  end;

  TPlayerPanels = array of TPlayerPanel;

  TPlayer = record
    Name: string;
    Letters: string;
    Score: integer;
  end;

  TPlayersArr = array of TPlayer;

var
  Form1: TForm1;
  PlayersArr: TPlayersArr;
  NumberOfPlayers: integer;
  IName, Turn: integer;
  AllLetters, LastWord: string;
  PlayerPanelsArr: TPlayerPanels;
  F: TextFile;
  Vocabulary: array of string;

implementation

{$R *.dfm}

procedure SetLetters(var AllLetters: string);
var
  I: integer;
  Letter: char;
begin
  for Letter := 'a' to 'z' do
    if CharInSet(Letter, Vowel) then
      for I := 1 to 8 do
        AllLetters := AllLetters + Letter
    else
      for I := 1 to 4 do
        AllLetters := AllLetters + Letter;
end;

procedure TForm1.ContinueButtonClick(Sender: TObject);
begin
  NumberOfPlayers := StrToInt(IntEdit.Text);
  setLength(PlayersArr, NumberOfPlayers);

  ContinueButton.Visible := False;
  IntEdit.Visible := False;
  EnterLabel.Caption := 'Player 1 enter name';

  NameEdit.Visible := True;
  NextNameEnterBtn.Visible := True;

end;

procedure SetPlayerLetters(Id: integer);
var
  I, M: integer;
begin
  for I := length(PlayersArr[Id].Letters) to 9 do
  begin
    M := random(length(AllLetters) - 1) + 1;
    PlayersArr[Id].Letters := PlayersArr[Id].Letters + AllLetters[M];
    delete(AllLetters, M, 1);
  end;
end;

procedure TForm1.NextNameEnterBtnClick(Sender: TObject);
var
  I, J: integer;
begin
  if IName < NumberOfPlayers - 1 then
  begin
    PlayersArr[IName].Name := NameEdit.Text;
    NameEdit.Text := '';
    inc(IName);
    EnterLabel.Caption := 'Player ' + IntToStr(IName + 1) + ' enter name';
  end
  else
  begin
    PlayersArr[IName].Name := NameEdit.Text;
    NameEdit.Text := '';
    NextNameEnterBtn.Visible := False;
    SetLetters(AllLetters);
    setLength(PlayerPanelsArr, NumberOfPlayers);
    for I := 0 to NumberOfPlayers - 1 do
    begin
      PlayerPanelsArr[I].IntScore := PlayersArr[I].Score;
      PlayerPanelsArr[I].Panel := TPanel.Create(Form1);
      with PlayerPanelsArr[I].Panel do
      begin
        Parent := Form1;
        Width := 200;
        Height := 70;
        if I < 4 then
        begin
          Left := 250 * I + 25;
          Top := 10;
        end
        else
        begin
          Left := 250 * (I - 4) + 25;
          Top := 90;
        end;
      end;

      PlayerPanelsArr[I].Name := TLabel.Create(Form1);
      with PlayerPanelsArr[I].Name do
      begin
        Font.Style := Font.Style + [fsBold];
        Parent := Form1;
        Width := 200;
        Height := 20;
        if I < 4 then
        begin
          Left := 250 * I + 40;
          Top := 15;
        end
        else
        begin
          Left := 250 * (I - 4) + 40;
          Top := 95;
        end;

        Caption := PlayersArr[I].Name;
      end;

      PlayerPanelsArr[I].Score := TLabel.Create(Form1);
      with PlayerPanelsArr[I].Score do
      begin
        Parent := Form1;
        Width := 200;
        Height := 20;
        if I < 4 then
        begin
          Left := 250 * I + 40;
          Top := 35;
        end
        else
        begin
          Left := 250 * (I - 4) + 40;
          Top := 115;
        end;

        Caption := 'Score: ' + IntToStr(PlayersArr[I].Score);
      end;

      SetPlayerLetters(I);

      PlayerPanelsArr[I].Letters := TLabel.Create(Form1);
      with PlayerPanelsArr[I].Letters do
      begin
        Parent := Form1;
        Width := 200;
        Height := 20;
        if I < 4 then
        begin
          Left := 250 * I + 40;
          Top := 55;
        end
        else
        begin
          Left := 250 * (I - 4) + 40;
          Top := 135;
        end;

        Caption := 'Letters: ' + PlayersArr[I].Letters;
      end;
      NameEdit.Visible := False;
      WordEdit.Visible := True;
      GameMoveBtn.Visible := True;
      EnterLabel.Caption := PlayersArr[Turn].Name + ' enter word';
      LastWord := '';
    end;
  end;
end;

function IsInVocabulary(Word: string): Boolean;
var
  I: integer;
begin
  result := False;
  I := 0;
  while not result and (I < length(Vocabulary)) do
  begin
    if Vocabulary[I] = Word then
      result := True;
    inc(I);
  end;
end;

procedure Sort;
var
  I, J, TmpIntScore: integer;
  TmpName, TmpScore, TmpLetters: string;
begin
  I := 0;
  while PlayerPanelsArr[I].Name.Caption <> PlayersArr[Turn].Name do
    inc(I);
  PlayerPanelsArr[I].Score.Caption := 'Score: ' +
    IntToStr(PlayersArr[Turn].Score);
  PlayerPanelsArr[I].Letters.Caption := 'Letters: ' + PlayersArr[Turn].Letters;
  PlayerPanelsArr[I].IntScore := PlayersArr[Turn].Score;
  for I := 0 to NumberOfPlayers - 1 do
    for J := I + 1 to NumberOfPlayers - 1 do
      if PlayerPanelsArr[I].IntScore < PlayerPanelsArr[J].IntScore then
      begin
        TmpName := PlayerPanelsArr[I].Name.Caption;
        TmpScore := PlayerPanelsArr[I].Score.Caption;
        TmpLetters := PlayerPanelsArr[I].Letters.Caption;
        TmpIntScore := PlayerPanelsArr[I].IntScore;

        PlayerPanelsArr[I].Name.Caption := PlayerPanelsArr[J].Name.Caption;
        PlayerPanelsArr[I].Score.Caption := PlayerPanelsArr[J].Score.Caption;
        PlayerPanelsArr[I].Letters.Caption := PlayerPanelsArr[J]
          .Letters.Caption;
        PlayerPanelsArr[I].IntScore := PlayerPanelsArr[J].IntScore;

        PlayerPanelsArr[J].Name.Caption := TmpName;
        PlayerPanelsArr[J].Score.Caption := TmpScore;
        PlayerPanelsArr[J].Letters.Caption := TmpLetters;
        PlayerPanelsArr[J].IntScore := TmpIntScore;
      end;
end;

procedure TForm1.GameMoveBtnClick(Sender: TObject);
var
  Letter: char;
  tmp: string;
  IsCorrect: Boolean;
begin
  if length(WordEdit.Text) <> 0 then
  begin
    IsCorrect := True;
    tmp := PlayersArr[Turn].Letters;

    for Letter in WordEdit.Text do
      if tmp.Contains(Letter) then
        delete(tmp, pos(Letter, tmp), 1)
      else
        IsCorrect := False;

    if IsCorrect then
    begin
      if IsInVocabulary(WordEdit.Text) then
      begin
        if (length(LastWord) > 0) and
          (LastWord[length(LastWord)] = WordEdit.Text[1]) then
          PlayersArr[Turn].Score := PlayersArr[Turn].Score +
            length(WordEdit.Text) * 2
        else
          PlayersArr[Turn].Score := PlayersArr[Turn].Score +
            length(WordEdit.Text);
        PlayersArr[Turn].Letters := tmp;
        SetPlayerLetters(Turn);
        LastWord := WordEdit.Text;
      end
      else
      begin
        // add to vocabulary button
        PlayersArr[Turn].Score := PlayersArr[Turn].Score -
          length(WordEdit.Text);
      end;
    end
    else
      PlayersArr[Turn].Score := PlayersArr[Turn].Score - length(WordEdit.Text);
    WordEdit.Text := '';
    Sort;
  end;
  inc(Turn);
  Turn := Turn mod NumberOfPlayers;
  EnterLabel.Caption := PlayersArr[Turn].Name + ' enter word';
end;

procedure TForm1.IntEditChange(Sender: TObject);
begin
  if (length(IntEdit.Text) <> 1) or (IntEdit.Text[1] = '0') or
    (IntEdit.Text[1] = '9') then
    ContinueButton.Enabled := False
  else
    ContinueButton.Enabled := True;
end;

procedure TForm1.NameEditChange(Sender: TObject);
var
  J: integer;
  IsUsedName: Bool;
begin
  IsUsedName := True;
  for J := 0 to IName - 1 do
    if NameEdit.Text = PlayersArr[J].Name then
      IsUsedName := False;
  NextNameEnterBtn.Enabled := IsUsedName;

end;

procedure TForm1.StartGameBtnClick(Sender: TObject);
var
  s: string;
begin
  randomize;
  ContinueButton.Visible := True;

  IntEdit.Visible := True;
  EnterLabel.Visible := True;
  StartGameBtn.Visible := False;

  AssignFile(F, '..\..\vocabulary.txt');
  Reset(F);
  setLength(Vocabulary, 1);
  while not Eof(F) do
  begin
    readln(F, s);
    Vocabulary[length(Vocabulary) - 1] := s;
    setLength(Vocabulary, length(Vocabulary) + 1);
  end;
  closeFile(F);
end;

procedure TForm1.WordEditChange(Sender: TObject);
begin
  if length(WordEdit.Text) = 0 then
    GameMoveBtn.Caption := 'Skip'
  else
    GameMoveBtn.Caption := 'Next';
end;

end.
