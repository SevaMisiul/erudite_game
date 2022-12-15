unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm4 = class(TForm)

    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;
   Labels:array of TLabel;
implementation
uses Unit3,Unit2;


{$R *.dfm}




procedure TForm4.FormShow(Sender: TObject);
var i,h: integer;
begin
setLength(Labels,NumberOfPlayers);
h:=20;
for i:=0 to NumberOfPlayers do
 begin
  labels[i]:=TLabel.Create(Form4);
  with labels[i] do
   begin
    Parent:=Form4;
    Left:=100*i;
    Height:=h;
    Top:=h;
    Caption:=Players[i].name;
   end;
 end;
end;

end.
