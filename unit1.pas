unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Unit2, process;

type

  { TForm1 }

  TForm1 = class(TForm)
    Update_Label: TLabel;
    Preamie: TButton;
    sendmail: TButton;
    rm: TButton;
    Exit_Button: TButton;
    Update_Button: TButton;
    Edit1: TEdit;
    preamie_in_euro: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioGroup1: TRadioGroup;
    wq: TGroupBox;
    Jahre: TLabel;
    procedure Exit_ButtonClick(Sender: TObject);
    procedure PreamieClick(Sender: TObject);
    procedure rmClick(Sender: TObject);
    procedure sendmailClick(Sender: TObject);
    procedure Update_ButtonClick(Sender: TObject);

  private
    { private declarations }
    const
    Progame_Name = 'Preamienrechner';
    version      = 0.0;
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  setup   :Boolean;
  p       :Extended;
  bz      :Extended;

implementation

{$R *.lfm}

{ TForm1 }


procedure TForm1.PreamieClick(Sender: TObject);
begin

  p:=0;
  bz:= StrToFloat(Edit1.Text);

  if NOT(bz < 1)then
  begin

    p:=200;

    if (bz >= 6)then
    begin

      p:= p + 80 +bz * 20;

      if (RadioButton2.Checked)then
      begin

        p:= p + 50;

      end;

    end;

  end;

  preamie_in_euro.Text:= FloatToStr(p);
  Form2.search_for_Updates(Update_Label,version,Progame_Name);

end;


procedure TForm1.Exit_ButtonClick(Sender: TObject);
begin

  Form1.Close();

end;

// Clear all

procedure TForm1.rmClick(Sender: TObject);
begin

  Edit1.Clear();
  preamie_in_euro.Clear();
  RadioButton1.Checked:=True;
  Form2.search_for_Updates(Update_Label,version,Progame_Name);

end;

//run Thunderbird

procedure TForm1.sendmailClick(Sender: TObject);
var

  thunderbird : TProcess;

begin

  Form2.search_for_Updates(Update_Label,version,Progame_Name);
  thunderbird := TProcess.Create(Nil);

  if FileExistsUTF8('c:\\Program Files\Mozilla Thunderbird\thunderbird.exe') then
  begin

    thunderbird.CommandLine:='c:\\Program Files\Mozilla Thunderbird\thunderbird.exe -compose "to=name@exsample.com,subject=Preamie,body=Hallo Frau/Herr NAME Sie Erhalten eine Preamie von '+FloatToStr(p)+' Euro. Mit freundlichen Gruessen"';

  end else if FileExistsUTF8('c:\\Program Files (x86)\Mozilla Thunderbird\thunderbird.exe')then
  begin

    thunderbird.CommandLine:='c:\\Program Files (x86)\Mozilla Thunderbird\thunderbird.exe -compose "to=name@exsample.com,subject=Preamie,body=Hallo Frau/Herr NAME Sie Erhalten eine Preamie von '+FloatToStr(p)+' Euro. Mit freundlichen Gruessen"';

  end else if FileExistsUTF8('c:\\ProgramData\Microsoft\Windows\Start Menu\Programs\Mozilla Thunderbird\thunderbird.exe ')then
  begin

    thunderbird.CommandLine:='c:\\ProgramData\Microsoft\Windows\Start Menu\Programs\Mozilla Thunderbird\thunderbird.exe -compose "to=name@exsample.com,subject=Preamie,body=Hallo Frau/Herr NAME Sie Erhalten eine Preamie von '+FloatToStr(p)+' Euro. Mit freundlichen Gruessen"';

  end else begin

    ShowMessage('Mozilla Thunderbird only');

    if FileExistsUTF8('c:\\Program Files\Internet Explorer\iexplore.exe') then
  begin

    thunderbird.CommandLine:='c:\\Program Files\Internet Explorer\iexplore.exe';

  end else begin

      ShowMessage('Your are broken because NO INTERNET EXPLORER / Edge (iexplore.exe) was found\n');

  end;

    Form1.Close;
  end;

  thunderbird.Execute;

end;

procedure TForm1.Update_ButtonClick(Sender: TObject);
begin
  Form2.ShowInTaskBar:=TShowInTaskbar.stDefault;
  Form2.Show;
end;

end.

