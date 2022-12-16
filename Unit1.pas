unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    StartGameBtn: TButton;
    NumberOfPlayersLabel: TLabel;
    ContinueButton: TButton;
    NumberOfPlayersEdit: TEdit;
    EnterNameLabel: TLabel;
    NextNameEnterBtn: TButton;
    PlayerNameEdit: TEdit;
    procedure NumberOfPlayersEditChange(Sender: TObject);
    procedure ContinueButtonClick(Sender: TObject);
    procedure NextNameEnterBtnClick(Sender: TObject);
    procedure StartGameBtnClick(Sender: TObject);
    procedure PlayerNameEditChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TPlayerPanel = record
    PlayerName: TLabel;
    PlayerPanel: TPanel;
    PlayerScore: TLabel;
    PlayerLetters: TLabel;
  end;

  TPlayerPanels = array of TPlayerPanel;

  TLettersArr = array [1 .. 10] of char;

  TPlayer = record
    Name: string;
    Letters: TLettersArr;
    Score: integer;
  end;

  TPlayersArr = array of TPlayer;

var
  Form1: TForm1;
  PlayersArr: TPlayersArr;
  NumberOfPlayers: integer;
  IName: integer;
  PlayerPanelsArr: TPlayerPanels;

implementation

{$R *.dfm}

procedure TForm1.ContinueButtonClick(Sender: TObject);
var
  I: integer;
begin
  NumberOfPlayers := strtoint(NumberOfPlayersEdit.Text);
  setLength(PlayersArr, NumberOfPlayers);

  ContinueButton.Visible := False;
  NumberOfPlayersEdit.Visible := False;
  NumberOfPlayersLabel.Visible := False;

  EnterNameLabel.Visible := True;
  PlayerNameEdit.Visible := True;
  NextNameEnterBtn.Visible := True;

end;

procedure TForm1.NextNameEnterBtnClick(Sender: TObject);
var
  I, J: integer;
begin
  if IName < NumberOfPlayers - 1 then
  begin
    PlayersArr[IName].Name := PlayerNameEdit.Text;
    PlayerNameEdit.Text := '';
    inc(IName);
    EnterNameLabel.Caption := 'Player ' + IntToStr(IName + 1) + ' enter name';
  end
  else
  begin
    PlayersArr[IName].Name := PlayerNameEdit.Text;
    PlayerNameEdit.Text := '';
    PlayerNameEdit.Visible := False;
    EnterNameLabel.Visible := False;
    NextNameEnterBtn.Visible := False;

    setLength(PlayerPanelsArr, NumberOfPlayers);
    for I := 0 to NumberOfPlayers - 1 do
    begin
      PlayerPanelsArr[I].PlayerPanel := TPanel.Create(Form1);
      with PlayerPanelsArr[I].PlayerPanel do
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

      PlayerPanelsArr[I].PlayerName := TLabel.Create(Form1);
      with PlayerPanelsArr[I].PlayerName do
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

      PlayerPanelsArr[I].PlayerScore := TLabel.Create(Form1);
      with PlayerPanelsArr[I].PlayerScore do
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

        Caption := 'Score: ' + inttostr(PlayersArr[I].Score);
      end;

      PlayerPanelsArr[I].PlayerLetters := TLabel.Create(Form1);
      with PlayerPanelsArr[I].PlayerLetters do
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

        Caption := 'Letters: qwertyuiop';
      end;

    end;
  end;
end;

procedure TForm1.NumberOfPlayersEditChange(Sender: TObject);
begin
  if (length(NumberOfPlayersEdit.Text) <> 1) or
    (NumberOfPlayersEdit.Text[1] = '0') or (NumberOfPlayersEdit.Text[1] = '9')
  then
    ContinueButton.Enabled := False
  else
    ContinueButton.Enabled := True;
end;

procedure TForm1.PlayerNameEditChange(Sender: TObject);
var
  J: integer;
  IsUsedName: Bool;
begin
  IsUsedName := True;
  for J := 0 to IName - 1 do
    if PlayerNameEdit.Text = PlayersArr[J].Name then
      IsUsedName := False;
  NextNameEnterBtn.Enabled := IsUsedName;

end;

procedure TForm1.StartGameBtnClick(Sender: TObject);
begin
  ContinueButton.Visible := True;

  NumberOfPlayersEdit.Visible := True;
  NumberOfPlayersLabel.Visible := True;
  StartGameBtn.Visible := False;

end;

end.
