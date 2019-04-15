{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado � tabela [VIEW_SINTEGRA_60R] 
                                                                                
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
unit ViewSintegra60rVO;

{$mode objfpc}{$H+}

interface

uses
  VO, Classes, SysUtils, FGL;

type
  TViewSintegra60rVO = class(TVO)
  private
    FID: Integer;
    FGTIN: String;
    FSERIE: String;
    FDATA_EMISSAO: TDateTime;
    FMES_EMISSAO: Integer;
    FANO_EMISSAO: Integer;
    FID_MOVIMENTO: Integer;
    FECF_ICMS_ST: String;
    FSOMA_QUANTIDADE: Extended;
    FSOMA_ITEM: Extended;
    FSOMA_BASE_ICMS: Extended;
    FSOMA_ICMS: Extended;

  published 
    property Id: Integer  read FID write FID;
    property Gtin: String  read FGTIN write FGTIN;
    property Serie: String  read FSERIE write FSERIE;
    property DataEmissao: TDateTime  read FDATA_EMISSAO write FDATA_EMISSAO;
    property MesEmissao: Integer  read FMES_EMISSAO write FMES_EMISSAO;
    property AnoEmissao: Integer  read FANO_EMISSAO write FANO_EMISSAO;
    property IdMovimento: Integer  read FID_MOVIMENTO write FID_MOVIMENTO;
    property EcfIcmsSt: String  read FECF_ICMS_ST write FECF_ICMS_ST;
    property SomaQuantidade: Extended  read FSOMA_QUANTIDADE write FSOMA_QUANTIDADE;
    property SomaItem: Extended  read FSOMA_ITEM write FSOMA_ITEM;
    property SomaBaseIcms: Extended  read FSOMA_BASE_ICMS write FSOMA_BASE_ICMS;
    property SomaIcms: Extended  read FSOMA_ICMS write FSOMA_ICMS;

  end;

  TListaViewSintegra60rVO = specialize TFPGObjectList<TViewSintegra60rVO>;

implementation


initialization
  Classes.RegisterClass(TViewSintegra60rVO);

finalization
  Classes.UnRegisterClass(TViewSintegra60rVO);

end.
