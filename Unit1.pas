unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

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
  I: Integer;

implementation

{$R *.dfm}

procedure TForm1.ContinueButtonClick(Sender: TObject);
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
begin
  if I < NumberOfPlayers - 1 then
  begin
    PlayersArr[I].Name := PlayerNameEdit.Text;
    PlayerNameEdit.Text := '';
    inc(I);
    EnterNameLabel.Caption := 'Player ' + IntToStr(I + 1) + ' enter name';
  end
  else
  begin
    PlayersArr[I].Name := PlayerNameEdit.Text;
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

procedure TForm1.StartGameBtnClick(Sender: TObject);
begin
  ContinueButton.Visible := True;

  NumberOfPlayersEdit.Visible := True;
  NumberOfPlayersLabel.Visible := True;
  StartGameBtn.Visible := False;
end;

end.
