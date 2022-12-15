﻿unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Unit4;

type
  TForm3 = class(TForm)
	PlayerNameLabel: TLabel;
	Player: TEdit;
	NextPlayerBtn: TButton;
	procedure NextPlayerBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
	{ Private declarations }
  public
	{ Public declarations }
  end;
  TLetters = array[1..10] of char;
  TPlayer = record
    id:integer;
    name:string;
    letters:TLetters;
    points:integer;
  end;
  TPlayers = array of TPlayer;
var
  Form3: TForm3;
  Players: TPlayers;


{$R *.dfm}

implementation

uses Unit2;

procedure TForm3.FormShow(Sender: TObject);
begin
Player.Text:=IntToStr(NumberOfPlayers);
setLength(Players, NumberOfPlayers);
end;

procedure TForm3.NextPlayerBtnClick(Sender: TObject);

begin
       inc(i);
  if i < NumberOfPlayers then
  begin
    Players[i-1].name:=Player.Text;
	Player.Text := '';
    PlayerNameLabel.Caption := 'Enter player ' + IntToStr(i+1) + ' name' +IntToStr(NumberOfPlayers);
  end else
  begin
  Players[i].name:=Player.Text;
    Form3.Hide;
    Form4.Show;
  end;


end;
end.
