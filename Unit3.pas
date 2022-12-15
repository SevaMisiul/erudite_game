﻿unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm3 = class(TForm)
	PlayerNameLabel: TLabel;
	Player: TEdit;
	NextPlayerBtn: TButton;
	procedure NextPlayerBtnClick(Sender: TObject);
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

procedure TForm3.NextPlayerBtnClick(Sender: TObject);

begin
inc(i);


  if i <= NumberOfPlayers then
  begin

	Player.Text := '';
  end else
  begin
    Form3.Hide;

  end;
  PlayerNameLabel.Caption := 'Enter player ' + IntToStr(i) + ' name' +IntToStr(NumberOfPlayers);

end;
end.
