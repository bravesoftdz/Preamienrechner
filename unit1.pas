unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, fphttpclient, Unit2, process;

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
    procedure FormCreate(Sender: TObject);
    procedure rmClick(Sender: TObject);
    procedure sendmailClick(Sender: TObject);
    procedure Update_ButtonClick(Sender: TObject);
    function is_Portable_APP(App: String):Boolean;
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
  //ShowMessage(FloatToStr(bz));
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
  //Form2.search_for_Updates(Update_Label,version,Progame_Name);
end;

procedure TForm1.Exit_ButtonClick(Sender: TObject);
begin
  Form1.Close();
end;


procedure TForm1.FormCreate(Sender: TObject); //will be extracted to SASetup Programm
var
  inifile :TextFile;
  inicode :string;
  exe     :string;
  uiwdiimw:Boolean;
begin
  setup:=False;
  //exe:=ExtractFileName(Application.ExeName);

  //if NOT(is_Portable_APP(exe))then
  //begin
    //AssignFile(inifile,Progame_Name+'.ini');
    //if FileExists(Progame_Name+'.ini') then
    //begin
         //Reset(inifile);
         //ReadLn(inifile,inicode);
         //if(inicode = '5C6AA54174C00EF5')then
         //begin
              //CloseFile(inifile);
              //setup:=False;
         //end
    //end
    //else
    //begin
         //Rewrite(inifile);
         //Write(inifile,'5C6AA54174C00EF5');
         //CloseFile(inifile);
         //setup:=True;
    //end;
  //end;

end;

procedure TForm1.rmClick(Sender: TObject);
begin
  Edit1.Clear();
  preamie_in_euro.Clear();
  RadioButton1.Checked:=True;
  //Form2.search_for_Updates(Update_Label,version,Progame_Name);
end;

procedure TForm1.sendmailClick(Sender: TObject);
var
  thunderbird : TProcess;
begin
  //Form2.search_for_Updates(Update_Label,version,Progame_Name);
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
  Form2.search_for_Updates();
  Form2.Show;
end;

function TForm1.is_Portable_APP(App:String):Boolean;
begin
  if(0 <pos('portable.exe',App))then
     begin
       Result:=True
     end
     else
     begin
       Result:=False;
     end;
end;

end.

