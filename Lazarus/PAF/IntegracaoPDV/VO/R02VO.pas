{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado � tabela [R02] 
                                                                                
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
                                                                                
@author Albert Eije (t2ti.com@gmail.com)                    
@version 2.0                                                                    
*******************************************************************************}
unit R02VO;

{$mode objfpc}{$H+}

interface

uses
  VO, Classes, SysUtils, FGL, R03VO;

type
  TR02VO = class(TVO)
  private
    FID: Integer;
    FID_OPERADOR: Integer;
    FID_IMPRESSORA: Integer;
    FID_ECF_CAIXA: Integer;
    FSERIE_ECF: String;
    FCRZ: Integer;
    FCOO: Integer;
    FCRO: Integer;
    FDATA_MOVIMENTO: TDateTime;
    FDATA_EMISSAO: TDateTime;
    FHORA_EMISSAO: String;
    FVENDA_BRUTA: Extended;
    FGRANDE_TOTAL: Extended;
    FLOGSS: String;

    FNOME_CAIXA: String;
    FID_GERADO_CAIXA: Integer;
    FDATA_SINCRONIZACAO: TDateTime;
    FHORA_SINCRONIZACAO: String;

    FListaR03VO: TListaR03VO;

  published
    constructor Create; override;
    destructor Destroy; override;

    property Id: Integer  read FID write FID;
    property IdOperador: Integer  read FID_OPERADOR write FID_OPERADOR;
    property IdImpressora: Integer  read FID_IMPRESSORA write FID_IMPRESSORA;
    property IdEcfCaixa: Integer  read FID_ECF_CAIXA write FID_ECF_CAIXA;
    property SerieEcf: String  read FSERIE_ECF write FSERIE_ECF;
    property Crz: Integer  read FCRZ write FCRZ;
    property Coo: Integer  read FCOO write FCOO;
    property Cro: Integer  read FCRO write FCRO;
    property DataMovimento: TDateTime  read FDATA_MOVIMENTO write FDATA_MOVIMENTO;
    property DataEmissao: TDateTime  read FDATA_EMISSAO write FDATA_EMISSAO;
    property HoraEmissao: String  read FHORA_EMISSAO write FHORA_EMISSAO;
    property VendaBruta: Extended  read FVENDA_BRUTA write FVENDA_BRUTA;
    property GrandeTotal: Extended  read FGRANDE_TOTAL write FGRANDE_TOTAL;
    property HashRegistro: String  read FLOGSS write FLOGSS;

    property NomeCaixa: String  read FNOME_CAIXA write FNOME_CAIXA;
    property IdGeradoCaixa: Integer  read FID_GERADO_CAIXA write FID_GERADO_CAIXA;
    property DataSincronizacao: TDateTime  read FDATA_SINCRONIZACAO write FDATA_SINCRONIZACAO;
    property HoraSincronizacao: String  read FHORA_SINCRONIZACAO write FHORA_SINCRONIZACAO;

    property ListaR03VO: TListaR03VO read FListaR03VO write FListaR03VO;
  end;

  TListaR02VO = specialize TFPGObjectList<TR02VO>;

implementation

constructor TR02VO.Create;
begin
  inherited;

  FListaR03VO := TListaR03VO.Create;
end;

destructor TR02VO.Destroy;
begin
  FreeAndNil(FListaR03VO);

  inherited;
end;

initialization
  Classes.RegisterClass(TR02VO);

finalization
  Classes.UnRegisterClass(TR02VO);

end.
