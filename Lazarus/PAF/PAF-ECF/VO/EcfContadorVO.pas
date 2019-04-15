{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado � tabela [ECF_CONTADOR] 
                                                                                
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
unit EcfContadorVO;

{$mode objfpc}{$H+}

interface

uses
  VO, Classes, SysUtils, FGL;

type
  TEcfContadorVO = class(TVO)
  private
    FID: Integer;
    FID_ECF_EMPRESA: Integer;
    FCPF: String;
    FCNPJ: String;
    FNOME: String;
    FINSCRICAO_CRC: String;
    FFONE: String;
    FFAX: String;
    FLOGRADOURO: String;
    FNUMERO: Integer;
    FCOMPLEMENTO: String;
    FBAIRRO: String;
    FCEP: String;
    FCODIGO_MUNICIPIO: Integer;
    FUF: String;
    FEMAIL: String;

  published 
    property Id: Integer  read FID write FID;
    property IdEcfEmpresa: Integer  read FID_ECF_EMPRESA write FID_ECF_EMPRESA;
    property Cpf: String  read FCPF write FCPF;
    property Cnpj: String  read FCNPJ write FCNPJ;
    property Nome: String  read FNOME write FNOME;
    property InscricaoCrc: String  read FINSCRICAO_CRC write FINSCRICAO_CRC;
    property Fone: String  read FFONE write FFONE;
    property Fax: String  read FFAX write FFAX;
    property Logradouro: String  read FLOGRADOURO write FLOGRADOURO;
    property Numero: Integer  read FNUMERO write FNUMERO;
    property Complemento: String  read FCOMPLEMENTO write FCOMPLEMENTO;
    property Bairro: String  read FBAIRRO write FBAIRRO;
    property Cep: String  read FCEP write FCEP;
    property CodigoMunicipio: Integer  read FCODIGO_MUNICIPIO write FCODIGO_MUNICIPIO;
    property Uf: String  read FUF write FUF;
    property Email: String  read FEMAIL write FEMAIL;

  end;

  TListaEcfContadorVO = specialize TFPGObjectList<TEcfContadorVO>;

implementation


initialization
  Classes.RegisterClass(TEcfContadorVO);

finalization
  Classes.UnRegisterClass(TEcfContadorVO);

end.
