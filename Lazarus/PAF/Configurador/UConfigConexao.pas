{*******************************************************************************
Title: T2TiPDV
Description: Configuração de acesso aos Bancos de Dados.

The MIT License

Copyright: Copyright (C) 2014 T2Ti.COM

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

       The author may be contacted at:
           alberteije@gmail.com

@author T2Ti.COM
@version 1.0
*******************************************************************************}
unit UConfigConexao;

{$mode objfpc}{$H+}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, IniFiles, ComCtrls, EditBtn, ACBrBase,
  ACBrEnterTab;

type

  { TFConfigConexao }

  TFConfigConexao = class(TForm)
    ACBrEnterTab1: TACBrEnterTab;
    edtCaminhoLocal: TFileNameEdit;
    Image1: TImage;
    botaoConfirma: TBitBtn;
    botaoCancela: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    botaoTestaLocal: TSpeedButton;
    Label2: TLabel;
    imgFirebird: TImage;
    Label3: TLabel;
    Label1: TLabel;
    imgMySQL: TImage;
    rdgTpConexaoLocal: TRadioGroup;
    edtServidorLocal: TEdit;
    cbxBanco: TComboBox;
    GroupBox2: TGroupBox;
    botaoTestarBalcao: TSpeedButton;
    Label4: TLabel;
    imgFireBirdBalcao: TImage;
    Label5: TLabel;
    Label6: TLabel;
    imgMySQLBalcao: TImage;
    rdgTpConexaoBalcao: TRadioGroup;
    edtServidorBalcao: TEdit;
    edtCaminhoBalcao: TFilenameEdit;
    cbxBancoBalcao: TComboBox;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure rdgTpConexaoLocalClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure botaoTestaLocalClick(Sender: TObject);
    procedure botaoConfirmaClick(Sender: TObject);
    procedure botaoCancelaClick(Sender: TObject);
    procedure cbxBancoSelect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FConfigConexao: TFConfigConexao;
  Banco: string;
  BancoBalcao: string;

implementation

uses UDataModule;

{$R *.lfm}

procedure TFConfigConexao.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
  FConfigConexao := Nil;
end;

procedure TFConfigConexao.FormCreate(Sender: TObject);
var
  Arquivo, sAux, BaseDados, Caminho, Servidor: String;
  i: Integer;
  Parametros: TStrings;
  ArquivoIni: TIniFile;
begin
  PageControl1.TabIndex := 0;

  try
    ArquivoIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Conexao.ini');
    Banco := UpperCase(ArquivoIni.ReadString('SGBD', 'BD', ''));
  finally
    ArquivoIni.Free;
  end;

  if Banco = 'FIREBIRD' then
  begin
    Arquivo := ExtractFilePath(Application.ExeName) + 'Firebird_DBExpress_conn.txt';
    imgFirebird.Visible := True;
    imgFirebird.BringToFront;
  end
  else if Banco = 'MYSQL' then
  begin
    Arquivo := ExtractFilePath(Application.ExeName) + 'MySQL_DBExpress_conn.txt';
    imgMySQL.Visible := True;
    imgMySQL.BringToFront;
  end;

  Parametros := TStringList.Create;

  try
    Parametros.LoadFromFile(Arquivo);
    for i := 0 to Pred(Parametros.Count) do
    begin
      sAux := Parametros[i];
      if Banco = 'FIREBIRD' then
      begin
        if Pos('Database=', sAux) = 1 then
          BaseDados := sAux;
      end
      else if Banco = 'MYSQL' then
      begin
        if Pos('HostName=', sAux) = 1 then
          Servidor := sAux;

        if Pos('Database=', sAux) = 1 then
          BaseDados := sAux;
      end;
    end;
  finally
    FreeAndNil(Parametros);
  end;

  /// Configura edits para Conexao Local
  if Banco = 'FIREBIRD' then
  begin
    i := 0;
    sAux := BaseDados;
    while Pos(':', sAux) <> 0 do
    begin
      delete(sAux, Pos(':', sAux), 1);
      Inc(i);
    end;

    if i > 1 then
    begin
      Servidor := copy(BaseDados, Pos('=', BaseDados) + 1, Pos(':', BaseDados) - Pos('=', BaseDados) - 1);
      Caminho := copy(BaseDados, Pos(':', BaseDados) + 1, length(trim(BaseDados)));
    end
    else
    begin
      Servidor := 'localhost';
      Caminho := copy(BaseDados, Pos('=', BaseDados) + 1, length(trim(BaseDados)));
    end;
  end;

  if Banco = 'MYSQL' then
  begin
    delete(Servidor, 1, Pos('=', Servidor));
    delete(BaseDados, 1, Pos('=', BaseDados));
    Caminho := BaseDados;
  end;

  for i := 0 to cbxBanco.Items.Count - 1 do
  begin
    if cbxBanco.Items[i] = Banco then
    begin
      cbxBanco.ItemIndex := i;
      break;
    end;
  end;

  edtServidorLocal.Text := Servidor;
  edtCaminhoLocal.Text := Caminho;
end;

procedure TFConfigConexao.rdgTpConexaoLocalClick(Sender: TObject);
begin
  if rdgTpConexaoLocal.ItemIndex = 0 then
  begin
    edtServidorLocal.Enabled := False;
    edtServidorLocal.Text := 'localhost';
  end
  else
  begin
    edtServidorLocal.Enabled := True;
  end;
end;

procedure TFConfigConexao.botaoCancelaClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFConfigConexao.botaoConfirmaClick(Sender: TObject);
var
  i: Integer;
  Arquivo, sAux: String;
  Parametros: TStrings;
  ArquivoIni: TIniFile;
begin

  if trim(edtServidorLocal.Text) = '' then
  begin
    Application.MessageBox('Informe o Nome ou IP do Servidor!', 'Informação do Sistema', MB_OK + MB_ICONWARNING);
    edtServidorLocal.SetFocus;
    exit;
  end;

  if trim(edtCaminhoLocal.Text) = '' then
  begin
    Application.MessageBox('Informe o caminho do banco de dados!', 'Informação do Sistema', MB_OK + MB_ICONWARNING);
    edtCaminhoLocal.SetFocus;
    exit;
  end;

  if cbxBanco.Text = 'MYSQL' then
    Arquivo := ExtractFilePath(Application.ExeName) + 'MySQL_DBExpress_conn.txt'
  else if cbxBanco.Text = 'FIREBIRD' then
    Arquivo := ExtractFilePath(Application.ExeName) + 'Firebird_DBExpress_conn.txt';

  try
    Parametros := TStringList.Create;
    Parametros.LoadFromFile(Arquivo);

    for i := 0 to Pred(Parametros.Count) do
    begin
      sAux := Parametros[i];
      if cbxBanco.Text = 'FIREBIRD' then
      begin
        if Pos('Database=', sAux) = 1 then
          Parametros[i] := 'Database=' + edtServidorLocal.Text + ':' + edtCaminhoLocal.Text;
      end
      else if cbxBanco.Text = 'MYSQL' then // Considenrando que usaremos sempre o usuario e senha "root" e "root"
      begin
        if Pos('HostName=', sAux) = 1 then
          Parametros[i] := 'HostName=' + edtServidorLocal.Text;

        if Pos('Database=', sAux) = 1 then
          Parametros[i] := 'Database=' + edtCaminhoLocal.Text;
      end;
    end;

    Parametros.SaveToFile(Arquivo);

    ArquivoIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Conexao.ini');
    ArquivoIni.WriteString('SGBD', 'BD', cbxBanco.Text);

  finally
    FreeAndNil(Parametros);
    FreeAndNil(ArquivoIni);
  end;
  ModalResult := mrok;
end;

procedure TFConfigConexao.botaoTestaLocalClick(Sender: TObject);
var
  i: Integer;
  sAux, Arquivo: String;
  Parametros: TStrings;
begin

  FDataModule.Conexao.Connected := False;

  if cbxBanco.Text = 'MYSQL' then
  begin
    Arquivo := ExtractFilePath(Application.ExeName) + 'MySQL_DBExpress_conn.txt';
    FDataModule.Conexao.Protocol       := 'MySQL';
  end
  else if cbxBanco.Text = 'FIREBIRD' then
  begin
    Arquivo := ExtractFilePath(Application.ExeName) + 'Firebird_DBExpress_conn.txt';
    FDataModule.Conexao.Protocol       := 'Firebird';
  end;

  try
    Parametros := TStringList.Create;
    Parametros.LoadFromFile(Arquivo);

    for i := 0 to Pred(Parametros.Count) do
    begin
      sAux := Parametros[i];
      if cbxBanco.Text = 'FIREBIRD' then
      begin
        if Pos('Database=',sAux) = 1  then
          Parametros[i] := 'Database='+edtServidorLocal.Text+':'+edtCaminhoLocal.Text;
      end
      else if cbxBanco.Text = 'MYSQL' then
      begin
        if Pos('HostName=',sAux) = 1  then
          Parametros[i] := 'HostName='+edtServidorLocal.Text;
        if Pos('Database=',sAux) = 1  then
          Parametros[i] := 'Database='+edtCaminhoLocal.Text;
      end;
    end;//for i := 0 to Pred(Parametros.Count) do

//    FDataModule.Conexao.Params := Parametros;
  finally
    FreeAndNil(Parametros);
  end;

  try
    FDataModule.Conexao.Connected := True;
    botaoConfirma.Enabled := True;
  except
    raise exception.Create('Falha na Conexão!');
    botaoConfirma.Enabled := False;
  end;

  Application.MessageBox('Conexão realizada com sucesso!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFConfigConexao.cbxBancoSelect(Sender: TObject);
begin
  if cbxBanco.Text = 'MYSQL' then
  begin
    imgMySQL.Visible := True;
    imgMySQL.BringToFront;
  end
  else if cbxBanco.Text = 'FIREBIRD' then
  begin
    imgFirebird.Visible := True;
    imgFirebird.BringToFront;
  end;
end;

end.
