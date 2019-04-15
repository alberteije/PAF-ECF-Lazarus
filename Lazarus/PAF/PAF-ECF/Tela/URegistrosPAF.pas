{ *******************************************************************************
Title: T2TiPDV
Description: Gera o arquivo Registros do PAF.

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
t2ti.com@gmail.com

@author Albert Eije
@version 2.0
******************************************************************************* }
unit URegistrosPAF;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, UBase,
  Dialogs, StdCtrls, Buttons,  ExtCtrls, MaskEdit, ACBrEnterTab,LabeledCtrls;

type

  { TFRegistrosPAF }

  TFRegistrosPAF = class(TFBase)
    Image1: TImage;
    panPeriodo: TPanel;
    ACBrEnterTab1: TACBrEnterTab;
    EditDataInicial: TLabeledDateEdit;
    EditDataFinal: TLabeledDateEdit;
    RadioGroupSubCategoria: TRadioGroup;
    PanelParcial: TPanel;
    RadioGroupFiltro: TRadioGroup;
    panNome: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    EditNomeInicial: TEdit;
    EditNomeFinal: TEdit;
    panCodigo: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    EditInicio: TEdit;
    EditFim: TEdit;
    Label5: TLabel;
    Bevel1: TBevel;
    Label6: TLabel;
    Panel1: TPanel;
    botaoConfirma: TBitBtn;
    botaoCancela: TBitBtn;
    LabelAguarde: TLabel;
    procedure Confirma;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure botaoConfirmaClick(Sender: TObject);
    procedure RadioGroupSubCategoriaClick(Sender: TObject);
    procedure RadioGroupFiltroClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRegistrosPAF: TFRegistrosPAF;

implementation

uses
  PAFUtil;

{$R *.lfm}

procedure TFRegistrosPAF.FormActivate(Sender: TObject);
begin
  Color := StringToColor(Sessao.Configuracao.CorJanelasInternas);
  EditDataInicial.Date := Now;
  EditDataFinal.Date := Now;
  EditDataInicial.SetFocus;
end;

procedure TFRegistrosPAF.RadioGroupFiltroClick(Sender: TObject);
begin
  if RadioGroupFiltro.ItemIndex = 0 then
  begin;
    panCodigo.Enabled := True;
    panCodigo.BevelOuter := bvRaised;
    panNome.Enabled := False;
    panNome.BevelOuter := bvLowered;
  end
  else
  begin
    panCodigo.Enabled := False;
    panCodigo.BevelOuter := bvLowered;
    panNome.Enabled := True;
    panNome.BevelOuter := bvRaised;
  end;
end;

procedure TFRegistrosPAF.RadioGroupSubCategoriaClick(Sender: TObject);
begin
  if RadioGroupSubCategoria.ItemIndex = 0 then
  begin
    PanelParcial.Visible := False;
    Self.ClientHeight := 250;
  end
  else
  begin
    PanelParcial.Visible := True;
    Self.ClientHeight := 400;
  end;
end;

procedure TFRegistrosPAF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFRegistrosPAF.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F12 then
    Confirma;
end;

procedure TFRegistrosPAF.botaoConfirmaClick(Sender: TObject);
begin
  Confirma;
end;

procedure TFRegistrosPAF.Confirma;
begin
  LabelAguarde.Caption := 'Aguarde...';
  Self.Repaint;
  // Estoque Total
  if RadioGroupSubCategoria.ItemIndex = 0 then
  begin
    TPAFUtil.GerarRegistrosPAF(EditDataInicial.Date, EditDataFinal.Date, 'T');
  end

  // Estoque Parcial
  else
  begin
    // por codigo
    if RadioGroupFiltro.ItemIndex = 0 then
      TPAFUtil.GerarRegistrosPAF(EditDataInicial.Date, EditDataFinal.Date, 'P', 'C', EditInicio.Text, EditFim.Text)
    // por nome
    else if RadioGroupFiltro.ItemIndex = 1 then
      TPAFUtil.GerarRegistrosPAF(EditDataInicial.Date, EditDataFinal.Date, 'P', 'N', EditNomeInicial.Text, EditNomeFinal.Text);
  end;
  LabelAguarde.Caption := '';
end;

end.
