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
	YesBtn: TButton;
	AddWordLabel: TLabel;
	NoBtn: TButton;
	FiftyBtn: TButton;
	HelpBtn: TButton;
	FiftyEdit: TEdit;
	FiftyConfirmBtn: TButton;
	FiftyLabel: TLabel;
	HelpLabel: TLabel;
	HelpEdit: TEdit;
	HelpConfirmBtn: TButton;
	PlayersComboBox: TComboBox;
	WonPlayerLabel: TLabel;
	procedure IntEditChange(Sender: TObject);
	procedure ContinueButtonClick(Sender: TObject);
	procedure NextNameEnterBtnClick(Sender: TObject);
	procedure StartGameBtnClick(Sender: TObject);
	procedure NameEditChange(Sender: TObject);
	procedure WordEditChange(Sender: TObject);
	procedure GameMoveBtnClick(Sender: TObject);
	procedure YesBtnClick(Sender: TObject);
	procedure NoBtnClick(Sender: TObject);
	procedure FiftyBtnClick(Sender: TObject);
	procedure FiftyEditChange(Sender: TObject);
	procedure FiftyConfirmBtnClick(Sender: TObject);
	procedure HelpBtnClick(Sender: TObject);
	procedure HelpConfirmBtnClick(Sender: TObject);
	procedure HelpEditChange(Sender: TObject);
	procedure PlayersComboBoxChange(Sender: TObject);
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
	IsUsed50: Boolean;
	IsUsedHelp: Boolean;
  end;

  TPlayersArr = array of TPlayer;

var
  Form1: TForm1;
  PlayersArr: TPlayersArr;
  NumberOfPlayers, PlayerToSwap: integer;
  IName, Turn, SkipedPlayers, AskedPlayer: integer;
  AllLetters, LastWord, CurWord, CurPlayerLetters, FirstSwappedLetter: string;
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
  AllLetters := '';
  for Letter := 'a' to 'z' do
	if CharInSet(Letter, Vowel) then
	  for I := 1 to 8 do
		AllLetters := AllLetters + Letter
	else
	  for I := 1 to 4 do
		AllLetters := AllLetters + Letter;
end;

procedure SetPlayerLetters(Id: integer);
var
  I, M: integer;
begin
  for I := length(PlayersArr[Id].Letters) to 9 do
  begin
	if length(AllLetters) > 0 then
	begin
	  M := random(length(AllLetters)) + 1;
	  PlayersArr[Id].Letters := PlayersArr[Id].Letters + AllLetters[M];
	  delete(AllLetters, M, 1);
	end;
  end;
end;

procedure UpdateVocabulary(Word: string);
var
  F: TextFile;
  I: integer;
begin
  Vocabulary[length(Vocabulary) - 1] := Word;
  setLength(Vocabulary, length(Vocabulary) + 1);
  AssignFile(F, '..\..\vocabulary.txt');
  rewrite(F);
  for I := 0 to length(Vocabulary) - 2 do
	writeln(F, Vocabulary[I]);
  CloseFile(F);
end;

function SpaceBetween(S: string): string;
var
  I: integer;
begin
  result := '';
  for I := 1 to 10 do
	result := result + S[I] + ' ';
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
  PlayerPanelsArr[I].Letters.Caption := 'Letters: ' +
	SpaceBetween(PlayersArr[Turn].Letters);
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
      i:=0;
      while (i<NumberOfPlayers) do
      begin
        if PlayerPanelsArr[0].IntScore = PlayerPanelsArr[i].IntScore then
        PlayerPanelsArr[i].Panel.Color := $005EF7EB else PlayerPanelsArr[i].Panel.Color := clBtnFace;
        inc(i);
      end;

end;

procedure endGame(form: TForm1);
var
  I: integer;
  playersWon: string;
begin
  form.EnterLabel.Visible := False;
  form.StartGameBtn.Visible := True;
  form.FiftyBtn.Visible := False;
  form.FiftyConfirmBtn.Visible := False;
  form.GameMoveBtn.Visible := False;
  form.WordEdit.Visible := False;
  form.HelpBtn.Visible := False;
  form.WonPlayerLabel.Visible := True;
  playersWon := PlayerPanelsArr[0].Name.Caption;

  for I := 1 to NumberOfPlayers - 1 do
	if PlayerPanelsArr[I].Score.Caption = PlayerPanelsArr[0].Score.Caption then
	begin
	  playersWon := playersWon + ', ' + PlayerPanelsArr[I].Name.Caption;
	end;
	form.WonPlayerLabel.Caption :=playersWon + ' won!!!';
  SetLetters(AllLetters);

  for I := 0 to NumberOfPlayers - 1 do
  begin
	with PlayerPanelsArr[I] do
	begin
	  Name.Free;
	  Score.Free;
	  Letters.Free;
	  Panel.Free;
	end;
  end;
  PlayerPanelsArr := nil;
  PlayersArr := nil;
end;

function IsEnableHelpBtn(Id: integer): Boolean;
var
  I: integer;
begin
  result := False;
  if PlayersArr[Id].IsUsedHelp then
	result := False
  else
  begin
	if length(PlayersArr[Id].Letters) >= 1 then
	  for I := 0 to NumberOfPlayers - 1 do
	  begin
		if (I <> Id) and (length(PlayersArr[I].Letters) >= 1) then
		  result := True;
	  end
	else
	  result := False;
  end;
end;

procedure TForm1.StartGameBtnClick(Sender: TObject);
var
  S: string;
begin
  randomize;
  ContinueButton.Visible := True;
  WonPlayerLabel.Visible := False;
  IntEdit.Visible := True;
  IntEdit.SetFocus;
  EnterLabel.Visible := True;
  EnterLabel.Caption := 'Enter number of players';
  IntEdit.Text := '';
  StartGameBtn.Visible := False;
  NameEdit.Text := '';
  AssignFile(F, '..\..\vocabulary.txt');
  Reset(F);
  ContinueButton.Enabled := False;
  setLength(Vocabulary, 1);
  while not Eof(F) do
  begin
	readln(F, S);
	Vocabulary[length(Vocabulary) - 1] := S;
	setLength(Vocabulary, length(Vocabulary) + 1);
  end;
  CloseFile(F);
end;

procedure TForm1.IntEditChange(Sender: TObject);
begin
  if (length(IntEdit.Text) <> 1) or (IntEdit.Text[1] = '0') or
	(IntEdit.Text[1] = '9') then
	ContinueButton.Enabled := False
  else
	ContinueButton.Enabled := True;
end;

procedure TForm1.ContinueButtonClick(Sender: TObject);
begin

  NumberOfPlayers := StrToInt(IntEdit.Text);
  setLength(PlayersArr, NumberOfPlayers);
  ContinueButton.Visible := False;
  IntEdit.Visible := False;
  EnterLabel.Caption := 'Player 1 enter name';
  IName := 0;
  NameEdit.Visible := True;
  NameEdit.setFocus;
  NextNameEnterBtn.Visible := True;
  NextNameEnterBtn.Enabled := False;
end;

procedure TForm1.NameEditChange(Sender: TObject);
var
  J,i: integer;
  IsUsedName: Bool;
  name:string;
begin
name := trim(NameEdit.Text) ;
    i:=2;
    while i<=Length(name) do
       begin
         if (name[i]=' ') and (name[i-1]=' ') then
         	delete(name,i,1) else inc(i);
       end;
  IsUsedName := True;
  if (length(name) = 0) then
	NextNameEnterBtn.Enabled := False
  else
  begin
	for J := 0 to IName - 1 do
	  if name = PlayersArr[J].Name then
		IsUsedName := False;
	NextNameEnterBtn.Enabled := IsUsedName;
  end;
end;

procedure TForm1.NextNameEnterBtnClick(Sender: TObject);
var
  I: integer;
  name: string;
begin
name := trim(NameEdit.Text) ;
    i:=2;
    while i<=Length(name) do
       begin
         if (name[i]=' ') and (name[i-1]=' ') then
         	delete(name,i,1) else inc(i);
       end;
  if IName < NumberOfPlayers - 1 then
  begin
	NameEdit.setFocus;
	PlayersArr[IName].Name := name;
	NameEdit.Text := '';
	inc(IName);
	EnterLabel.Caption := 'Player ' + IntToStr(IName + 1) + ' enter name';
	NextNameEnterBtn.Enabled := False;
  end
  else
  begin
	PlayersArr[IName].Name := name;
	NameEdit.Text := '';
	Turn := 0;
	FiftyBtn.Enabled := True;
	SkipedPlayers := 0;
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
        ParentColor:=False;
      	ParentBackground:=False;
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

	  PlayerPanelsArr[I].Name := TLabel.Create(PlayerPanelsArr[I].Panel);
	  with PlayerPanelsArr[I].Name do
	  begin
		Font.Style := Font.Style + [fsBold];
		Parent := PlayerPanelsArr[I].Panel;
		Width := 200;
		Height := 20;
		Font.Size := 10;
		Left := 10;
		Top := 5;

		Caption := PlayersArr[I].Name;
	  end;

	  PlayerPanelsArr[I].Score := TLabel.Create(PlayerPanelsArr[I].Panel);
	  with PlayerPanelsArr[I].Score do
	  begin
		Parent := PlayerPanelsArr[I].Panel;
		Width := 200;
		Height := 20;
		Font.Size := 10;
		Left := 10;
		Top := 25;

		Caption := 'Score: ' + IntToStr(PlayersArr[I].Score);
	  end;

	  SetPlayerLetters(I);

	  PlayerPanelsArr[I].Letters := TLabel.Create(PlayerPanelsArr[I].Panel);
	  with PlayerPanelsArr[I].Letters do
	  begin
		Parent := PlayerPanelsArr[I].Panel;
		Width := 200;
		Height := 20;
		Font.Size := 10;
		Left := 10;
		Top := 45;

		Caption := 'Letters: ' + SpaceBetween(PlayersArr[I].Letters);
	  end;
	  PlayersArr[I].IsUsed50 := False;
	  PlayersArr[I].IsUsedHelp := False;
	end;
	FiftyBtn.Visible := True;
	HelpBtn.Visible := True;
	NameEdit.Visible := False;
	WordEdit.Visible := True;
	GameMoveBtn.Visible := True;
	if NumberOfPlayers = 1 then
	  PlayersArr[0].IsUsedHelp := True;
	HelpBtn.Enabled := not PlayersArr[0].IsUsedHelp;
	EnterLabel.Caption := PlayersArr[Turn].Name + ' enter word';
	LastWord := '';
  end;
end;

procedure TForm1.WordEditChange(Sender: TObject);
begin
  WordEdit.Text := trim(WordEdit.Text);
  if length(WordEdit.Text) = 0 then
	GameMoveBtn.Caption := 'Skip'
  else
	GameMoveBtn.Caption := 'Next';
end;

procedure TForm1.GameMoveBtnClick(Sender: TObject);
var
  Letter: char;
  IsCorrect: Boolean;
  IsAdding: Boolean;
begin
  IsAdding := False;
  if length(WordEdit.Text) <> 0 then
  begin
	IsCorrect := True;
	CurPlayerLetters := PlayersArr[Turn].Letters;

	for Letter in WordEdit.Text do
	  if CurPlayerLetters.Contains(Letter) then
		delete(CurPlayerLetters, pos(Letter, CurPlayerLetters), 1)
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
		PlayersArr[Turn].Letters := CurPlayerLetters;
		SetPlayerLetters(Turn);
		LastWord := WordEdit.Text;
	  end
	  else
	  begin
		YesBtn.Visible := True;
		NoBtn.Visible := True;
        FiftyBtn.Enabled := False;
        HelpBtn.Enabled := False;
		AddWordLabel.Visible := True;
		AddWordLabel.Caption := PlayersArr[Turn].Name +
		  ', do you want to add word ' + WordEdit.Text + ' to vocabulary?';
		IsAdding := True;
		AskedPlayer := 0;
		WordEdit.Enabled := False;
		GameMoveBtn.Enabled := False;
	  end;
	end
	else
	  PlayersArr[Turn].Score := PlayersArr[Turn].Score - length(WordEdit.Text);
	if not IsAdding then
	begin
	  WordEdit.Text := '';
	  Sort;
	  SkipedPlayers := 0;
	end;
  end
  else
	inc(SkipedPlayers);
  if SkipedPlayers = NumberOfPlayers then
	endGame(Form1)
  else
  begin
	if not IsAdding then
	begin
	  inc(Turn);
	  Turn := Turn mod NumberOfPlayers;
	  if (length(AllLetters) >= 5) and (length(PlayersArr[Turn].Letters) >= 5)
	  then
		FiftyBtn.Enabled := not PlayersArr[Turn].IsUsed50
	  else
		FiftyBtn.Enabled := False;
	  HelpBtn.Enabled := IsEnableHelpBtn(Turn);
	  EnterLabel.Caption := PlayersArr[Turn].Name + ' enter word';
	end;
  end;
end;

procedure TForm1.YesBtnClick(Sender: TObject);
begin
  if (AskedPlayer >= NumberOfPlayers) or
	((AskedPlayer + 1 = NumberOfPlayers) and (AskedPlayer = Turn)) then
  begin
	PlayersArr[Turn].Letters := CurPlayerLetters;
	SetPlayerLetters(Turn);
	if (length(LastWord) > 0) and (LastWord[length(LastWord)] = WordEdit.Text[1])
	then
	  PlayersArr[Turn].Score := PlayersArr[Turn].Score +
		length(WordEdit.Text) * 2
	else
	  PlayersArr[Turn].Score := PlayersArr[Turn].Score + length(WordEdit.Text);
	LastWord := WordEdit.Text;
	WordEdit.Enabled := True;
	GameMoveBtn.Enabled := True;
	UpdateVocabulary(WordEdit.Text);
	WordEdit.Text := '';
	Sort;
	SkipedPlayers := 0;
	inc(Turn);
	Turn := Turn mod NumberOfPlayers;
	if (length(AllLetters) >= 5) and (length(PlayersArr[Turn].Letters) >= 5)
	then
	  FiftyBtn.Enabled := not PlayersArr[Turn].IsUsed50
	else
	  FiftyBtn.Enabled := False;
	HelpBtn.Enabled := IsEnableHelpBtn(Turn);
	EnterLabel.Caption := PlayersArr[Turn].Name + ' enter word';
	YesBtn.Visible := False;
	NoBtn.Visible := False;
    FiftyBtn.Enabled := True;
    HelpBtn.Enabled := True;
	AddWordLabel.Visible := False;
  end
  else
  begin
	if (AskedPlayer + 1 < NumberOfPlayers) and (AskedPlayer = Turn) then
	begin
	  AddWordLabel.Caption := PlayersArr[AskedPlayer + 1].Name +
		', do you want to add word ' + WordEdit.Text + ' to vocabulary?';
	  AskedPlayer := AskedPlayer + 1;
	end
	else
	  AddWordLabel.Caption := PlayersArr[AskedPlayer].Name +
		', do you want to add word ' + WordEdit.Text + ' to vocabulary?';
	AskedPlayer := AskedPlayer + 1;
  end;
end;

procedure TForm1.NoBtnClick(Sender: TObject);
begin
  WordEdit.Enabled := True;
  GameMoveBtn.Enabled := True;
  PlayersArr[Turn].Score := PlayersArr[Turn].Score - length(WordEdit.Text);
  WordEdit.Text := '';
  Sort;
  SkipedPlayers := 0;
  inc(Turn);
  Turn := Turn mod NumberOfPlayers;
  if (length(AllLetters) >= 5) and (length(PlayersArr[Turn].Letters) >= 5) then
	FiftyBtn.Enabled := not PlayersArr[Turn].IsUsed50
  else
	FiftyBtn.Enabled := False;
  HelpBtn.Enabled := IsEnableHelpBtn(Turn);
  EnterLabel.Caption := PlayersArr[Turn].Name + ' enter word';
  YesBtn.Visible := False;
  NoBtn.Visible := False;
  FiftyBtn.Enabled := True;
  HelpBtn.Enabled := True;
  AddWordLabel.Visible := False;
end;

procedure TForm1.FiftyBtnClick(Sender: TObject);
begin
  WordEdit.Enabled := False;
  GameMoveBtn.Enabled := False;
  HelpBtn.Enabled := False;
  FiftyBtn.Enabled := False;
  FiftyLabel.Visible := True;
  FiftyEdit.Visible := True;
  FiftyConfirmBtn.Visible := True;
  FiftyConfirmBtn.Enabled := False;
end;

procedure TForm1.FiftyEditChange(Sender: TObject);
var
  Tmp: string;
  Letter: char;
  IsCorrect: Boolean;
begin
  IsCorrect := True;
  if length(FiftyEdit.Text) = 5 then
  begin
	Tmp := PlayersArr[Turn].Letters;
	for Letter in FiftyEdit.Text do
	begin
	  if Tmp.Contains(Letter) then
		delete(Tmp, pos(Letter, Tmp), 1)
	  else
		IsCorrect := False;
	end;
  end
  else
	IsCorrect := False;
  FiftyConfirmBtn.Enabled := IsCorrect;
end;



procedure TForm1.FiftyConfirmBtnClick(Sender: TObject);
var
  Letter: char;
begin
  for Letter in FiftyEdit.Text do
	delete(PlayersArr[Turn].Letters, pos(Letter, PlayersArr[Turn].Letters), 1);
  SetPlayerLetters(Turn);
  PlayersArr[Turn].IsUsed50 := True;

  WordEdit.Enabled := True;
  GameMoveBtn.Enabled := True;
  HelpBtn.Enabled := not PlayersArr[Turn].IsUsedHelp;
  FiftyBtn.Enabled := False;
  FiftyLabel.Visible := False;
  FiftyEdit.Visible := False;
  FiftyEdit.Text := '';
  FiftyConfirmBtn.Visible := False;
  PlayersArr[Turn].Score := PlayersArr[Turn].Score - 2;
  Sort;
end;

procedure TForm1.HelpBtnClick(Sender: TObject);
var
  I: integer;
begin
  PlayersComboBox.Items.Clear;
  for I := 0 to NumberOfPlayers - 1 do
	if I <> Turn then
	  PlayersComboBox.Items.Add(PlayersArr[I].Name);
  WordEdit.Enabled := False;
  GameMoveBtn.Enabled := False;
  FiftyBtn.Enabled := False;

  HelpBtn.Enabled := False;
  HelpLabel.Visible := True;
  HelpLabel.Caption := 'Enter your letter you want to swap';
  HelpEdit.Visible := True;
  HelpConfirmBtn.Visible := True;
  HelpConfirmBtn.Enabled := False;
  HelpEdit.MaxLength := 1;
end;

procedure TForm1.HelpEditChange(Sender: TObject);
var
  IsCorrect: Boolean;
begin
  if HelpLabel.Caption = 'Enter your letter you want to swap' then
	if PlayersArr[Turn].Letters.Contains(HelpEdit.Text) then
	  IsCorrect := True
	else
	  IsCorrect := False
  else if HelpLabel.Caption = 'Enter ' + PlayersArr[PlayerToSwap].Name + '`s letter you want to swap'
  then
  begin
	if PlayersArr[PlayerToSwap].Letters.Contains(HelpEdit.Text) then
	  IsCorrect := True
	else
	  IsCorrect := False
  end;
  HelpConfirmBtn.Enabled := IsCorrect;
end;

procedure TForm1.PlayersComboBoxChange(Sender: TObject);
begin
  if PlayersComboBox.Visible and (PlayersComboBox.Text <> ' ') then
	HelpConfirmBtn.Enabled := True;
end;

procedure TForm1.HelpConfirmBtnClick(Sender: TObject);
var
  I: integer;
  Tmp: string;
begin
  if HelpLabel.Caption = 'Enter your letter you want to swap' then
  begin
	FirstSwappedLetter := HelpEdit.Text;
	HelpEdit.Text := '';
	HelpConfirmBtn.Enabled := False;
	HelpEdit.Visible := False;
	PlayersComboBox.Visible := True;
	HelpLabel.Caption := 'Choose the name of the player you want to swap with';
  end
  else if HelpLabel.Caption = 'Choose the name of the player you want to swap with'
  then
  begin
	I := 0;
	while PlayersArr[I].Name <> PlayersComboBox.Text do
	  inc(I);
	PlayerToSwap := I;
	HelpConfirmBtn.Enabled := False;
	PlayersComboBox.Text := '';
	PlayersComboBox.Visible := False;
	HelpEdit.Visible := True;
	HelpLabel.Caption := 'Enter ' + PlayersArr[PlayerToSwap].Name +
	  '`s letter you want to swap';
  end
  else if HelpLabel.Caption = 'Enter ' + PlayersArr[PlayerToSwap].Name + '`s letter you want to swap'
  then
  begin
	Tmp := FirstSwappedLetter;
	PlayersArr[Turn].Letters[pos(Tmp, PlayersArr[Turn].Letters)] :=
	  HelpEdit.Text[1];
	PlayersArr[PlayerToSwap].Letters
	  [pos(HelpEdit.Text, PlayersArr[PlayerToSwap].Letters)] := Tmp[1];
	PlayersArr[Turn].IsUsedHelp := True;
	HelpLabel.Visible := False;
	FirstSwappedLetter := '';
	HelpEdit.Text := '';
	HelpEdit.Visible := False;
	HelpConfirmBtn.Visible := False;

	I := 0;
	while PlayerPanelsArr[I].Name.Caption <> PlayersArr[Turn].Name do
	  inc(I);
	PlayerPanelsArr[I].Letters.Caption := 'Letters: ' +
	  SpaceBetween(PlayersArr[Turn].Letters);
	I := 0;
	while PlayerPanelsArr[I].Name.Caption <> PlayersArr[PlayerToSwap].Name do
	  inc(I);
	PlayerPanelsArr[I].Letters.Caption := 'Letters: ' +
	  SpaceBetween(PlayersArr[PlayerToSwap].Letters);

	WordEdit.Enabled := True;
	GameMoveBtn.Enabled := True;
	if (length(AllLetters) >= 5) and (length(PlayersArr[Turn].Letters) >= 5)
	then
	  FiftyBtn.Enabled := not PlayersArr[Turn].IsUsed50
	else
	  FiftyBtn.Enabled := False;
  end;

end;

end.
