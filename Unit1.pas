﻿unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Unit2;

type
  TForm1 = class(TForm)
	StartGameBtn: TButton;
    procedure StartGameBtnClick(Sender: TObject);
  private
	{ Private declarations }
  public
	{ Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.StartGameBtnClick(Sender: TObject);
begin
  Form1.Hide;
  Form2.Show;
end;

end.
