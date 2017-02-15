unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, CheckLst, ExtCtrls, fphttpclient,
  strutils, convutils, varutils, XMLRead, DOM;

type

  { TForm2 }
  TSarray = array of string;
  TForm2 = class(TForm)

    Exit_Button: TButton;
    Update_Button: TButton;
    Install: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckGroup1: TCheckGroup;
    CheckListBox1: TCheckListBox;
    procedure CheckBox3Change(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure InstallClick(Sender: TObject);
    procedure search_for_Updates();
    //function ProInstall(Programname :String):Boolean;
    function search_for_Updates(Updatelabe : TLabel; version: Extended;Programname :String):Boolean;
  private
    { private declarations }
  public
    { public declarations }

    var
       Programs      : string;
       newUpdate     : Boolean;


  end;

var
  Form2         : TForm2;
  Doc           : TXMLDocument;
  node          : TDOMNode;
  Stringarray : array of string;
  gaeste: array[1..10] of string;
  Programms: array [1..20] of TDOMNode;
  nodes      :TDOMNodeList;
  S: TStringStream;
implementation

{$R *.lfm}

{ TForm2 }


procedure TForm2.CheckBox3Click(Sender: TObject);
begin
  CheckBox3.Checked:=False;
  ShowMessage('Beta Only');
end;

procedure TForm2.CheckBox3Change(Sender: TObject);
begin

end;




procedure TForm2.FormCreate(Sender: TObject);
var
  inifile :TextFile;
begin
  //Programs:= TFPCustomHTTPClient.SimpleGet('http://darkpinguin.net/DV/Programms.xml.update');
  //AssignFile(inifile,'.aini');
  //Rewrite(inifile);
  //Write(inifile,Programs);
  //CloseFile(inifile);
  //ShowMessage(Application.ExeName);
  //Doc := load
  //ReadXMLFile(Doc,'http://darkpinguin.net/DV/Programs.xml.update');
  //nodes:=Doc.DocumentElement.FindNode('programms').GetChildNodes;
  //ShowMessage(Programms[0].Attributes.Item[0].ToString);
  //Stringarray:= TForm2.Split(Programs,'|');
  //ShowMessage();                                                    ><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  ////CheckListBox1.Items.AddStrings();
  //CheckListBox1.Items.Add('Preamienrechner');
  //CheckListBox1.Items.Add('SETUP');
  //CheckListBox1.Items.Add('Taschenrehner(keine Updates mehr)');
end;

procedure TForm2.InstallClick(Sender: TObject);
var
  Http : TFPCustomHTTPClient;
  Installo: Array of String;
  Box    : TCheckBox;
begin
  //ProInstall('Preamienrechner');
  ShowMessage(inttostr(CheckListBox1.Count));
  //for Box in CheckListBox1.;
  ShowMessage('sc1'+inttostr(CheckListBox1.SelCount));
  ShowMessage('c2'+BoolToStr(CheckListBox1.Checked[0]));
  ShowMessage('3'+BoolToStr(CheckListBox1.Checked[1]));
  ShowMessage('4'+BoolToStr(CheckListBox1.Checked[2]));
  ShowMessage('s5'+BoolToStr(CheckListBox1.Selected[0]));
  ShowMessage('6'+BoolToStr(CheckListBox1.Selected[1]));
  ShowMessage('7'+BoolToStr(CheckListBox1.Selected[2]));
  Http := TFPCustomHTTPClient.Create(nil);
  Http.Get('http://darkpinguin.net/DV/releases/Delphi-Calculator/Delphi-Calculator.exe','Delphi-Calculator.exe');
  ///DV/releases/Delphi-Calculator/Delphi-Calculator.exe


end;

procedure TForm2.search_for_Updates();
var
  i : Integer;
  len : String;
  proname : String;
begin
  ShowMessage(TFPCustomHTTPClient.SimpleGet('http://darkpinguin.net/DV/len.data'));
  len := TFPCustomHTTPClient.SimpleGet('http://darkpinguin.net/DV/len.data');
  for i:= 0 to StrtoInt(len[1]) do begin
    proname := TFPCustomHTTPClient.SimpleGet('http://darkpinguin.net/DV/'+InttoStr(i)+'/name.dat');
    CheckListBox1.Items.Add(copy(proname,0,length(proname)-1));
  end;
end;
function TForm2.search_for_Updates(Updatelabe : TLabel; version: Extended;Programname :String) : Boolean;
var
  netversion:Extended;
  tmp       :string;
begin
  Result:=False;
  tmp:= TFPCustomHTTPClient.SimpleGet('http://darkpinguin.net/DV/releases/'+Programname+'/version.dat');
  netversion:=StrToFloat(copy(tmp,1,length(tmp)-1));
  if netversion > version then
  begin
    Updatelabe.Visible:=True;
    Result:=True
  end;
end;

//function TForm2.ProInstall(Programname :string) :Boolean;
//begin
  //TFPCustomHTTPClient.Get('http://darkpinguin.net/DV/releases/'+Programname+'/'+Programname+'.exe',Programname+'new.exe');

//end;


end.

