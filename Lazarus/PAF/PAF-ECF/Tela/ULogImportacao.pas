{*******************************************************************************
Title: T2TiPDV
Description: Visualiza e Exclui Registros de Log de Importação de Dados.

The MIT License

Copyright: Copyright (C) 2012 T2Ti.COM

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
unit ULogImportacao;

{$mode objfpc}{$H+}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, DB, FMTBcd, ZDataset,
  ACBrBase, ACBrEnterTab, UBase;

type
  TFLogImportacao = class(TFBase)
    Image1: TImage;
    botaoCancela: TSpeedButton;
    GroupBox1: TGroupBox;
    GridLog: TDBGrid;
    DtsLog: TDataSource;
    btnRemoveAtual: TBitBtn;
    btnRemoveTodos: TBitBtn;
    QLog: TZQuery;
    QLogDATA_IMPORTACAO: TDateField;
    QLogID: TIntegerField;
    QLogLOG_ERRO: TStringField;
    botaoConfirma: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnRemoveTodosClick(Sender: TObject);
    procedure btnRemoveAtualClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure botaoConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FLogImportacao: TFLogImportacao;

implementation

uses UDataModule, UCaixa;

{$R *.lfm}

procedure TFLogImportacao.botaoConfirmaClick(Sender: TObject);
begin
  Close;
end;

procedure TFLogImportacao.btnRemoveAtualClick(Sender: TObject);
begin
  (*
  if not QLog.IsEmpty then
  begin
    if TLogImportacaoController.ExcluirLog(QLogID.AsInteger) then
      QLog.Refresh;
    GridLog.SetFocus;
  end;
  *)
end;

procedure TFLogImportacao.btnRemoveTodosClick(Sender: TObject);
begin
  (*
  if Application.MessageBox('Tem Certeza Que Deseja Excluir Todos os Registros de Log?', 'Exclusão de Registros', Mb_YesNo + Mb_IconQuestion) = IdYes then
  begin
    if TLogImportacaoController.ExcluirTodos then
    begin
      Application.MessageBox('Dados Excluídos com Sucesso!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
      QLog.Refresh;
      botaoConfirma.SetFocus;
    end;
  end;
  *)
end;

procedure TFLogImportacao.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if QLog.IsEmpty then
  begin
    FCaixa.GifAnimadoLogErro.Active := false;
    FCaixa.GifAnimadoLogErro.Visible := false;
  end;
  CloseAction := caFree;
end;

procedure TFLogImportacao.FormCreate(Sender: TObject);
begin
  QLog.Active := True;
end;

procedure TFLogImportacao.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = 27 then
    botaoCancela.Click;
end;

end.
