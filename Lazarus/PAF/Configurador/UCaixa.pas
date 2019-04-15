{ *******************************************************************************
Title: T2Ti ERP
Description: Tela principal do PAF-ECF - Caixa.

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
t2ti.com@gmail.com</p>

@author Albert Eije (T2Ti.COM)
@version 2.0
******************************************************************************* }

unit UCaixa;

{$MODE Delphi}

interface

uses
  Windows, Dialogs, ExtCtrls, Classes, Messages, SysUtils, Variants,
  Graphics, Controls, Forms, StdCtrls, Buttons, Biblioteca,
  Menus, UConfiguracao;

type
  TMoveControl = class(TControl);
    TFCaixa = class(TForm)panelPrincipal: TPanel;
    imagePrincipal: TImage;
    Bobina: TListBox;
    panelMenuPrincipal: TPanel;
    imagePanelMenuPrincipal: TImage;
    labelMenuPrincipal: TLabel;
    listaMenuPrincipal: TListBox;
    panelMenuOperacoes: TPanel;
    imagePanelMenuOperacoes: TImage;
    labelMenuOperacoes: TLabel;
    listaMenuOperacoes: TListBox;
    panelSubMenu: TPanel;
    imagePanelSubMenu: TImage;
    listaGerente: TListBox;
    panelTitulo: TPanel;
    panelBotoes: TPanel;
    panelF1: TPanel;
    labelF1: TLabel;
    imageF1: TImage;
    panelF7: TPanel;
    labelF7: TLabel;
    imageF7: TImage;
    panelF2: TPanel;
    labelF2: TLabel;
    imageF2: TImage;
    panelF3: TPanel;
    labelF3: TLabel;
    imageF3: TImage;
    panelF4: TPanel;
    labelF4: TLabel;
    imageF4: TImage;
    panelF5: TPanel;
    labelF5: TLabel;
    imageF5: TImage;
    panelF6: TPanel;
    labelF6: TLabel;
    imageF6: TImage;
    panelF8: TPanel;
    labelF8: TLabel;
    imageF8: TImage;
    panelF9: TPanel;
    labelF9: TLabel;
    imageF9: TImage;
    panelF10: TPanel;
    labelF10: TLabel;
    imageF10: TImage;
    panelF11: TPanel;
    labelF11: TLabel;
    imageF11: TImage;
    panelF12: TPanel;
    labelF12: TLabel;
    imageF12: TImage;
    editCodigo: TEdit;
    editQuantidade: TEdit;
    imageProduto: TImage;
    editUnitario: TEdit;
    editTotalItem: TEdit;
    editSubTotal: TEdit;
    Relogio: TStaticText;
    labelOperador: TStaticText;
    labelCaixa: TStaticText;
    labelDescricaoProduto: TStaticText;
    LabelDescontoAcrescimo: TStaticText;
    edtCOO: TStaticText;
    edtNVenda: TStaticText;
    labelTotalGeral: TStaticText;
    labelMensagens: TStaticText;
    PopupMenu1: TPopupMenu;
    CarregarImagemdeFundo1: TMenuItem;
    EditarPropriedades1: TMenuItem;
    procedure ControlMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ControlMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ControlMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ConfiguraResolucao;
    procedure GravarAlteracoes;
    procedure ScreenActiveControlChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CarregarImagemdeFundo1Click(Sender: TObject);
    procedure EditarPropriedades1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCaixa: TFCaixa;
  RetanguloFoco: TShape;
  MoveX, MoveY: Integer;
  Mover: Boolean;

implementation

uses UDataModule, EcfPosicaoComponentesVO, ConfiguracaoController (*, UPropriedades*);
{$R *.lfm}

{ TODO -oExercício -cPAF-ECF : Verifique se todos os controles da janela estão sendo tratados. Faça as devidas correções. }

{$Region 'Infra'}
procedure TFCaixa.FormCreate(Sender: TObject);
begin
  Screen.OnActiveControlChange := ScreenActiveControlChange;
  //
  RetanguloFoco := TShape.Create(self);
  RetanguloFoco.Shape := stRectangle;
  RetanguloFoco.Visible := False;
  RetanguloFoco.Brush.Style := bsClear;
  RetanguloFoco.Pen.Style := psDot;
  RetanguloFoco.Pen.Color := clRed;
  RetanguloFoco.Pen.Width := 1;
  //
  ConfiguraResolucao;
end;

procedure TFCaixa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Screen.OnActiveControlChange := nil;
end;

procedure TFCaixa.FormDestroy(Sender: TObject);
begin
  Screen.OnActiveControlChange := nil;
end;

procedure TFCaixa.ScreenActiveControlChange(Sender: TObject);
begin
  with RetanguloFoco do
  begin
    Parent := Screen.ActiveControl.Parent;

    Top := Screen.ActiveControl.Top - 2;
    Height := Screen.ActiveControl.Height + 4;
    Left := Screen.ActiveControl.Left - 2;
    Width := Screen.ActiveControl.Width + 4;

    Visible := True;
  end;
  //
  ActiveControl.BringToFront;
  ActiveControl.Repaint;
end;
{$EndRegion}

{$Region 'Controle do Mouse'}
procedure TFCaixa.ControlMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  (Sender as TWinControl).SetFocus;
  MoveX := X;
  MoveY := Y;
  Mover := True;
  TMoveControl(Sender).MouseCapture := True;
  ScreenActiveControlChange(Sender);
end;

procedure TFCaixa.ControlMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if Mover then begin
    with Sender As TControl Do
    Begin
      Left := X - MoveX + Left;
      Top := Y - MoveY + Top;
    End;
  end;
  ScreenActiveControlChange(Sender);
end;

procedure TFCaixa.ControlMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Mover then begin
    Mover := False;
    TMoveControl(Sender).MouseCapture := False;
  end;
  ScreenActiveControlChange(Sender);
  if (Sender is TControl) then
    (Sender as TControl).Repaint;
end;
{$EndRegion}

{$Region 'Controle do Teclado'}
procedure TFCaixa.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (ssAlt in Shift) and (Key = VK_DOWN) then // Ctrl+abaixo
    ActiveControl.Top := ActiveControl.Top + 1;
  if (ssAlt in Shift) and (Key = VK_UP) then // Ctrl+acima
    ActiveControl.Top := ActiveControl.Top - 1;
  if (ssAlt in Shift) and (Key = VK_LEFT) then // Ctrl+esquerda
    ActiveControl.Left := ActiveControl.Left - 1;
  if (ssAlt in Shift) and (Key = VK_RIGHT) then // Ctrl+direita
    ActiveControl.Left := ActiveControl.Left + 1;
  //
  ScreenActiveControlChange(Sender);
  //
  if Key = VK_F12 then
  begin
    if Application.MessageBox('Deseja salvar as alterações antes de fechar a janela?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
    begin
      GravarAlteracoes;
    end;
    Close;
  end;
  //
  if Key = VK_F2 then
  begin
    panelMenuPrincipal.Visible := True;
    panelMenuPrincipal.BringToFront;
    panelSubMenu.Visible := True;
    panelMenuPrincipal.SetFocus;
  end;
  //
  if Key = VK_F3 then
  begin
    panelMenuOperacoes.Visible := True;
    panelMenuOperacoes.BringToFront;
    panelSubMenu.Visible := True;
    panelMenuOperacoes.SetFocus;
  end;
  //
  if Key = VK_ESCAPE then
  begin
    editCodigo.SetFocus;
    panelMenuPrincipal.Visible := False;
    panelMenuOperacoes.Visible := False;
    panelSubMenu.Visible := False;
  end;
end;
{$EndRegion}

{$Region 'Configuração dos Componentes'}
procedure TFCaixa.CarregarImagemdeFundo1Click(Sender: TObject);
var
  i: Integer;
begin
  if FDataModule.OpenDialog.Execute then
  begin
    imagePrincipal.Picture.LoadFromFile(FDataModule.OpenDialog.FileName);
    for i := 0 to componentcount - 1 do
    begin
      if (components[i] is TControl) then
        (components[i] as TControl).Repaint;
    end;
  end;
end;

procedure TFCaixa.EditarPropriedades1Click(Sender: TObject);
begin
  (*
  FPropriedades.JvInspector.Clear;
  FPropriedades.JvInspector.AddComponent(ActiveControl, ActiveControl.Name, True);
  FPropriedades.ShowModal;
  *)
end;

procedure TFCaixa.GravarAlteracoes;
var
  i: Integer;
  ListaPosicoes: TListaEcfPosicaoComponentesVO;
  PosicaoComponente: TEcfPosicaoComponentesVO;
begin
  try
    ListaPosicoes := TListaEcfPosicaoComponentesVO.Create;

    for i := 0 to componentcount - 1 do
    begin
      if (components[i] is TControl) then
      begin
        PosicaoComponente := TEcfPosicaoComponentesVO.Create;

        PosicaoComponente.IdEcfResolucao := UConfiguracao.ConfiguracaoVO.EcfResolucaoVO.Id;
        PosicaoComponente.Nome := components[i].Name;
        PosicaoComponente.Altura := (components[i] as TControl).Height;
        PosicaoComponente.Esquerda := (components[i] as TControl).Left;
        PosicaoComponente.Topo := (components[i] as TControl).Top;
        PosicaoComponente.Largura := (components[i] as TControl).Width;

        if (components[i] is TEdit) then
          PosicaoComponente.TamanhoFonte := (components[i] as TEdit).Font.Size;
        if (components[i] is TListBox) then
          PosicaoComponente.TamanhoFonte := (components[i] as TListBox).Font.Size;
        if (components[i] is TPanel) then
          PosicaoComponente.TamanhoFonte := (components[i] as TPanel).Font.Size;
        if (components[i] is TEdit) then
          PosicaoComponente.TamanhoFonte := (components[i] as TEdit).Font.Size;
        if (components[i] is TStaticText) then
          PosicaoComponente.TamanhoFonte := (components[i] as TStaticText).Font.Size;

        if (components[i] is TLabel) then
        begin
          PosicaoComponente.TamanhoFonte := (components[i] as TLabel).Font.Size;
          PosicaoComponente.Texto := (components[i] as TLabel).Caption;
        end;

        if (components[i] is TLabel) then
        begin
          PosicaoComponente.TamanhoFonte := (components[i] as TLabel).Font.Size;
          PosicaoComponente.Texto := (components[i] as TLabel).Caption;
        end;

        ListaPosicoes.Add(PosicaoComponente);
      end;
    end;
    TEcfConfiguracaoController.GravarPosicaoComponentes(ListaPosicoes);

  finally
    FreeAndNil(ListaPosicoes);
  end;
end;

procedure TFCaixa.ConfiguraResolucao;
var
  i, j: Integer;
  ListaPosicoes: TListaEcfPosicaoComponentesVO;
  PosicaoComponente: TEcfPosicaoComponentesVO;
  NomeComponente: String;
begin
  ListaPosicoes := UConfiguracao.ConfiguracaoVO.EcfResolucaoVO.ListaEcfPosicaoComponentesVO;

  for j := 0 to componentcount - 1 do
  begin
    NomeComponente := components[j].Name;
    for i := 0 to ListaPosicoes.Count - 1 do
    begin
      PosicaoComponente := ListaPosicoes.Items[i];
      if PosicaoComponente.Nome = NomeComponente then
      begin
        (components[j] as TControl).Height := PosicaoComponente.Altura;
        (components[j] as TControl).Left := PosicaoComponente.Esquerda;
        (components[j] as TControl).Top := PosicaoComponente.Topo;
        (components[j] as TControl).Width := PosicaoComponente.Largura;
        if PosicaoComponente.TamanhoFonte <> 0 then
        begin
          if (components[j] is TEdit) then
            (components[j] as TEdit).Font.Size := PosicaoComponente.TamanhoFonte;
          if (components[j] is TListBox) then
            (components[j] as TListBox).Font.Size := PosicaoComponente.TamanhoFonte;
          if (components[j] is TLabel) then
            (components[j] as TLabel).Font.Size := PosicaoComponente.TamanhoFonte;
          if (components[j] is TPanel) then
            (components[j] as TPanel).Font.Size := PosicaoComponente.TamanhoFonte;
          if (components[j] is TEdit) then
            (components[j] as TEdit).Font.Size := PosicaoComponente.TamanhoFonte;
        end;
        if (components[j] is TLabel) then
          (components[j] as TLabel).Caption := PosicaoComponente.Texto;
        break;
      end;
    end;
  end;
  FCaixa.Left := 0;
  FCaixa.Top := 0;
  FCaixa.Width := UConfiguracao.ConfiguracaoVO.EcfResolucaoVO.Largura;
  FCaixa.Height := UConfiguracao.ConfiguracaoVO.EcfResolucaoVO.Altura;

  FCaixa.AutoSize := true;
end;
{$EndRegion}

end.
