unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Unit3;

type
  TForm2 = class(TForm)
	NumberLabel: TLabel;
	NumberOfPlayersEdit: TEdit;
	SubmitButton: TButton;
	procedure NumberOfPlayersEditChange(Sender: TObject);
	procedure SubmitButtonClick(Sender: TObject);
  private
	{ Private declarations }
  public
	{ Public declarations }
  end;

var
  Form2: TForm2;
  NumberOfPlayers, i: integer;

implementation

{$R *.dfm}

procedure TForm2.NumberOfPlayersEditChange(Sender: TObject);
begin
  if (length(NumberOfPlayersEdit.Text) <> 1) or
	(NumberOfPlayersEdit.Text[1] = '0') or
	(NumberOfPlayersEdit.Text[1] = '9') then
	SubmitButton.Enabled := False
  else
	SubmitButton.Enabled := True;
end;

procedure TForm2.SubmitButtonClick(Sender: TObject);
begin
  i := 0;
  NumberOfPlayers := strToInt(NumberOfPlayersEdit.Text);
  Form2.Hide;
  Form3.Show;

end;

end.
