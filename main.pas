unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  FileUtil,
  Forms,
  Controls,
  Graphics,
  Dialogs,
  StdCtrls,
  ComCtrls,
  HlpHashFactory,
  HlpIHash,
  HlpIHashResult;

type

  { TMainForm }

  TMainForm = class(TForm)
    Memo1: TMemo;
    StatusBarMain: TStatusBar;
    procedure FormActivate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.FormActivate(Sender: TObject);
var
  Mode: string;
  Fnamesrc: string;
  FSHA2_512: IHash;
  Result: IHashResult;
  ResultStr: string;
  Fnamesig: string;
  Sigtext: string;
begin
  MainForm.Caption := 'Filish v1.0.0';
  Mode := ParamStr(1);
  Fnamesrc := ParamStr(2);
  Fnamesig := Concat(Fnamesrc, '.sha512.sig.txt');
  FSHA2_512 := THashFactory.TCrypto.CreateSHA2_512();
  Result := FSHA2_512.ComputeFile(Fnamesrc);
  ResultStr := Result.ToString();

  if Mode = 'generate' then
  begin

    MainForm.Memo1.Text := ResultStr;

    with TStringList.Create do
      try
        Add(ResultStr);
        SaveToFile(Fnamesig);
      finally
        Free;
      end;

    MainForm.StatusBarMain.Panels[0].Text :=
      Concat('OK, sig written to: ', Fnamesig);
  end
  else if Mode = 'check' then
  begin
    with TStringList.Create do
      try
        LoadFromFile(Fnamesig);

        // purge line endings from the text
        Sigtext := StringReplace(GetText, LineEnding, '', [rfReplaceAll]);

        Add(ResultStr);

        MainForm.Memo1.Text:=GetText;

        if CompareText(ResultStr, Sigtext) = 0 then
        begin
          MainForm.StatusBarMain.Panels[0].Text:='OK: Match';
          //MainForm.Memo1.Text:='OK, hash of file matched contents of sig file';
        end
        else
        begin
          MainForm.StatusBarMain.Panels[0].Text:='NOT OK: Does not match';
          //MainForm.Memo1.Text:='Warning! Hash of file does not match contents of sig file';
        end;
      finally
        Free;
      end;
  end;
end;

end.

