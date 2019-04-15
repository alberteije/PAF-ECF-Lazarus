{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela de filtro que ser� utilizada por toda a aplica��o

  The MIT License

  Copyright: Copyright (C) 2010 T2Ti.COM

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
  t2ti.com@gmail.com</p>

  @author Albert Eije (T2Ti.COM)
  @version 1.1
  ******************************************************************************* }
unit UFiltro;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, VO,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls, Menus, UBase, FileUtil, DB, BufDataset, LabeledCtrls;

type

  TItemListBox = class
  private
    FCampo: string;
  public
    property Campo: string read FCampo write FCampo;
  end;

  { TFFiltro }

  TFFiltro = class(TFBase)
    BotaoResult: TBitBtn;
    GroupBox1: TGroupBox;
    ListaCampos: TListBox;
    ListaOperadores: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    GrupoEOU: TRadioGroup;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    MemoSQL: TMemo;
    ListaCriterios: TListBox;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    ListaSalvos: TListBox;
    Label4: TLabel;
    BotaoAdicionaCriterio: TSpeedButton;
    BotaoRemoveCriterio: TSpeedButton;
    BotaoSalvarFiltro: TSpeedButton;
    BotaoAplicarFiltro: TSpeedButton;
    BotaoLimparCriterios: TSpeedButton;
    BotalESC: TBitBtn;
    PopupMenu: TPopupMenu;
    CarregarFiltro1: TMenuItem;
    ExcluirFiltro1: TMenuItem;
    EditExpressao: TLabeledMaskEdit;
    function defineEOU: String;
    function defineOperador: String;
    procedure CarregaFiltros;
    procedure BotaoAplicarFiltroClick(Sender: TObject);
    procedure BotaoAdicionaCriterioClick(Sender: TObject);
    procedure BotaoRemoveCriterioClick(Sender: TObject);
    procedure BotaoLimparCriteriosClick(Sender: TObject);
    procedure BotaoSalvarFiltroClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CarregarFiltro1Click(Sender: TObject);
    procedure ExcluirFiltro1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditExpressaoEnter(Sender: TObject);
    procedure ListaCamposClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    QuemChamou: String;
    CDSUtilizado: TBufDataSet;
    DataSetField: TField;
    DataSet: TBufDataSet;
    VO: TVO;
    procedure FormataCampoData;
    procedure PopulaListaCamposComVO(pListBox: TCustomListBox; pVO: TVO);

  end;

var
  FFiltro: TFFiltro;

implementation

uses UDataModule;
{$R *.lfm}

procedure TFFiltro.PopulaListaCamposComVO(pListBox: TCustomListBox; pVO: TVO);
begin
  (*
  Exerc�cio:

  Popule a lista de campos com seus conhecimentos em RTTI.
  *)
end;

procedure TFFiltro.CarregaFiltros;
var
  F: TSearchRec;
  Ret: Integer;
begin
  ListaSalvos.Clear;
  Ret := FindFirst(ExtractFilePath(Application.ExeName) + 'Filtros\*.*',faAnyFile,F);
  try
    while Ret = 0 do
    begin
      if Copy(F.Name, 1, Length(QuemChamou) + 1) = QuemChamou + 'L' then
        ListaSalvos.Items.Add(Copy(F.Name, Length(QuemChamou) + 2, Length(F.Name)));
      Ret := FindNext(F);
    end;
  finally

    FindClose(F);
  end;
end;

procedure TFFiltro.CarregarFiltro1Click(Sender: TObject);
begin
  if ListaSalvos.ItemIndex = -1 then
  begin
    Application.MessageBox('Selecione um filtro para carregar.', 'Erro', MB_OK + MB_ICONERROR);
  end
  else
  begin
    MemoSQL.Lines.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Filtros\' + QuemChamou + 'M' + ListaSalvos.Items.Strings[ListaSalvos.ItemIndex]);
    ListaCriterios.Items.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Filtros\' + QuemChamou + 'L' + ListaSalvos.Items.Strings[ListaSalvos.ItemIndex]);
  end;
end;

function TFFiltro.defineEOU: String;
begin
  if GrupoEOU.ItemIndex = 0 then
    result := ' AND'
  else
    result := ' OR';
end;

function TFFiltro.defineOperador: String;
var
  idx: Integer;
begin
  idx := ListaCampos.ItemIndex;

  DataSetField := TField.Create(Nil); //DataSet.FindField(DataSet.FieldList.Fields[idx].FieldName);

  if (DataSetField.DataType = ftDateTime) then
  begin
    result := ' IN ' + '(' + Quotedstr(FormatDateTime('yyyy-mm-dd', StrToDate(EditExpressao.Text))) + ')';
  end
  else
  begin
    case ListaOperadores.ItemIndex of
      0:
        begin
          result := '=' + Quotedstr(EditExpressao.Text);
        end;
      1:
        begin
          result := '<>' + Quotedstr(EditExpressao.Text);
        end;
      2:
        begin
          result := '<' + Quotedstr(EditExpressao.Text);
        end;
      3:
        begin
          result := '>' + Quotedstr(EditExpressao.Text);
        end;
      4:
        begin
          result := '<=' + Quotedstr(EditExpressao.Text);
        end;
      5:
        begin
          result := '>=' + Quotedstr(EditExpressao.Text);
        end;
      6:
        begin
          result := ' IS NULL ';
        end;
      7:
        begin
          result := ' IS NOT NULL ';
        end;
      8:
        begin
          result := ' LIKE ' + Quotedstr(EditExpressao.Text + '*');
        end;
      9:
        begin
          result := ' LIKE ' + Quotedstr('*' + EditExpressao.Text);
        end;
      10:
        begin
          result := ' LIKE ' + Quotedstr('*' + EditExpressao.Text + '*');
        end;
    end;
  end;
end;

procedure TFFiltro.EditExpressaoEnter(Sender: TObject);
begin
  CustomKeyPreview := False;
  FormataCampoData;
  EditExpressao.SelectAll;
end;

procedure TFFiltro.ExcluirFiltro1Click(Sender: TObject);
begin
  if ListaSalvos.ItemIndex = -1 then
  begin
    Application.MessageBox('Selecione um filtro para excluir.', 'Erro', MB_OK + MB_ICONERROR);
  end
  else
  begin
    DeleteFile(ExtractFilePath(Application.ExeName) + 'Filtros\' + QuemChamou + 'M' + ListaSalvos.Items.Strings[ListaSalvos.ItemIndex]);
    DeleteFile(ExtractFilePath(Application.ExeName) + 'Filtros\' + QuemChamou + 'L' + ListaSalvos.Items.Strings[ListaSalvos.ItemIndex]);
    CarregaFiltros;
    BotaoLimparCriterios.Click;
  end;
end;

procedure TFFiltro.FormActivate(Sender: TObject);
begin
  PopulaListaCamposComVO(ListaCampos, VO);
  CarregaFiltros;
  ListaCampos.ItemIndex := 0;
  ListaOperadores.ItemIndex := 0;
  ListaSalvos.SetFocus;
end;

procedure TFFiltro.BotaoAdicionaCriterioClick(Sender: TObject);
var
  Criterio: String;
  ConsultaSQL: String;
  idx: Integer;
begin
  if ListaCampos.ItemIndex = -1 then
  begin
    Application.MessageBox('� necess�rio selecionar um campo.', 'Erro', MB_OK + MB_ICONERROR);
  end
  else
  begin

    Criterio := '';
    ConsultaSQL := '';
    idx := ListaCampos.ItemIndex;

    if ListaCriterios.Count > 0 then
    begin
      Criterio := '[' + GrupoEOU.Items.Strings[GrupoEOU.ItemIndex] + ']';
      ConsultaSQL := defineEOU;
    end;

    if (ListaOperadores.ItemIndex = 6) or (ListaOperadores.ItemIndex = 7) then
    begin
      // Crit�rio
      Criterio := Criterio + ' ' + '[' + DataSet.Fields[idx].FieldName + ']' + ' [' + ListaOperadores.Items.Strings[ListaOperadores.ItemIndex] + '] ';
      ListaCriterios.Items.Add(Criterio);

      // Consulta SQL
      ConsultaSQL := ConsultaSQL + ' ' + '[' + DataSet.Fields[idx].FieldName + ']' + defineOperador;
      MemoSQL.Lines.Add(ConsultaSQL);
    end
    else
    begin
      if EditExpressao.Text <> '' then
      begin
        // Crit�rio
        Criterio := Criterio + ' ' + '[' + DataSet.Fields[idx].FieldName + ']' + ' [' + ListaOperadores.Items.Strings[ListaOperadores.ItemIndex] + '] ' + '"' + EditExpressao.Text + '"';
        ListaCriterios.Items.Add(Criterio);

        // Consulta SQL
        ConsultaSQL := ConsultaSQL + ' ' + '[' + DataSet.Fields[idx].FieldName + ']' + defineOperador;
        MemoSQL.Lines.Add(ConsultaSQL);
      end
      else
      begin
        Application.MessageBox('N�o existe express�o para filtro.', 'Erro', MB_OK + MB_ICONERROR);
        EditExpressao.SetFocus;
      end;
    end;
  end;
end;

procedure TFFiltro.BotaoRemoveCriterioClick(Sender: TObject);
begin
  if ListaCriterios.ItemIndex = -1 then
  begin
    Application.MessageBox('Selecione um crit�rio para remover.', 'Erro', MB_OK + MB_ICONERROR);
  end
  else
  begin
    if (ListaCriterios.ItemIndex = 0) and (ListaCriterios.Items.Count > 1) then
    begin
      if Application.MessageBox('Primeiro crit�rio selecionado. Existem outros crit�rios. Todos os crit�rios ser�o exclu�dos. Continua?', 'Pergunta do sistema', MB_YesNo + MB_IconQuestion) = IdYes then
      begin
        ListaCriterios.Clear;
        MemoSQL.Clear;
      end;
    end
    else
    begin
      MemoSQL.Lines.Delete(ListaCriterios.ItemIndex);
      ListaCriterios.Items.Delete(ListaCriterios.ItemIndex);
    end;
  end;
end;

procedure TFFiltro.BotaoSalvarFiltroClick(Sender: TObject);
var
  NomeFiltro: String;
begin
  if ListaCriterios.ItemIndex = -1 then
  begin
    Application.MessageBox('N�o existem crit�rios para salvar um filtro.', 'Erro', MB_OK + MB_ICONERROR);
  end
  else
  begin
    NomeFiltro := InputBox('Nome do filtro', 'Informe o nome do filtro para armazenamento:', '');
    if Trim(NomeFiltro) <> '' then
    begin
      if not DirectoryExists(ExtractFilePath(Application.ExeName) + 'Filtros\') then
        CreateDir(ExtractFilePath(Application.ExeName) + 'Filtros\');
      ListaCriterios.Items.SaveToFile(ExtractFilePath(Application.ExeName) + 'Filtros\' + QuemChamou + 'L' + NomeFiltro);
      MemoSQL.Lines.SaveToFile(ExtractFilePath(Application.ExeName) + 'Filtros\' + QuemChamou + 'M' + NomeFiltro);
      CarregaFiltros;
    end;
  end;
end;

procedure TFFiltro.BotaoAplicarFiltroClick(Sender: TObject);
begin
  BotaoResult.Click;
end;

procedure TFFiltro.BotaoLimparCriteriosClick(Sender: TObject);
begin
  ListaCriterios.Clear;
  MemoSQL.Clear;
end;

procedure TFFiltro.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F2 then
    BotaoAdicionaCriterio.Click;
  if Key = VK_F4 then
    BotaoRemoveCriterio.Click;
  if Key = VK_F5 then
    BotaoAplicarFiltro.Click;
  if Key = VK_F11 then
    BotaoLimparCriterios.Click;
  if Key = VK_F12 then
    BotaoSalvarFiltro.Click;
end;

procedure TFFiltro.ListaCamposClick(Sender: TObject);
begin
  inherited;
  FormataCampoData;
end;

procedure TFFiltro.FormataCampoData;
var
  Item: String;
  idx: Integer;
begin
  DataSet := CDSUtilizado;
  idx := ListaCampos.ItemIndex;
  Item := DataSet.Fields[idx].FieldName;
  DataSetField := DataSet.FindField(Item);
  if DataSetField.DataType = ftDateTime then
  begin
    EditExpressao.EditMask := '99/99/9999;1;_';
    EditExpressao.Clear;
  end
  else
    EditExpressao.EditMask := '';
  EditExpressao.Clear;
end;

end.
