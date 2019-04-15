{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado � tabela [ECF_SINTEGRA_60A] 
                                                                                
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
unit EcfSintegra60aVO;

{$mode objfpc}{$H+}

interface

uses
  VO, Classes, SysUtils, FGL;

type
  TEcfSintegra60aVO = class(TVO)
  private
    FID: Integer;
    FNOME_CAIXA: String;
    FID_GERADO_CAIXA: Integer;
    FID_EMPRESA: Integer;
    FID_SINTEGRA_60M: Integer;
    FSITUACAO_TRIBUTARIA: String;
    FVALOR: Extended;
    FDATA_SINCRONIZACAO: TDateTime;
    FHORA_SINCRONIZACAO: String;

  published 
    property Id: Integer  read FID write FID;
    property NomeCaixa: String  read FNOME_CAIXA write FNOME_CAIXA;
    property IdGeradoCaixa: Integer  read FID_GERADO_CAIXA write FID_GERADO_CAIXA;
    property IdEmpresa: Integer  read FID_EMPRESA write FID_EMPRESA;
    property IdSintegra60m: Integer  read FID_SINTEGRA_60M write FID_SINTEGRA_60M;
    property SituacaoTributaria: String  read FSITUACAO_TRIBUTARIA write FSITUACAO_TRIBUTARIA;
    property Valor: Extended  read FVALOR write FVALOR;
    property DataSincronizacao: TDateTime  read FDATA_SINCRONIZACAO write FDATA_SINCRONIZACAO;
    property HoraSincronizacao: String  read FHORA_SINCRONIZACAO write FHORA_SINCRONIZACAO;

  end;

  TListaEcfSintegra60aVO = specialize TFPGObjectList<TEcfSintegra60aVO>;

implementation


initialization
  Classes.RegisterClass(TEcfSintegra60aVO);

finalization
  Classes.UnRegisterClass(TEcfSintegra60aVO);

end.
