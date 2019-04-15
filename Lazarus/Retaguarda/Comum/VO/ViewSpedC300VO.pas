{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado � tabela [VIEW_SPED_C300] 
                                                                                
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
unit ViewSpedC300VO;

{$mode objfpc}{$H+}

interface

uses
  VO, Classes, SysUtils, FGL;

type
  TViewSpedC300VO = class(TVO)
  private
    FID: Integer;
    FSERIE: String;
    FSUBSERIE: String;
    FDATA_EMISSAO: TDateTime;
    FSOMA_TOTAL_NF: Extended;
    FSOMA_PIS: Extended;
    FSOMA_COFINS: Extended;

  published 
    property Id: Integer  read FID write FID;
    property Serie: String  read FSERIE write FSERIE;
    property Subserie: String  read FSUBSERIE write FSUBSERIE;
    property DataEmissao: TDateTime  read FDATA_EMISSAO write FDATA_EMISSAO;
    property SomaTotalNf: Extended  read FSOMA_TOTAL_NF write FSOMA_TOTAL_NF;
    property SomaPis: Extended  read FSOMA_PIS write FSOMA_PIS;
    property SomaCofins: Extended  read FSOMA_COFINS write FSOMA_COFINS;

  end;

  TListaViewSpedC300VO = specialize TFPGObjectList<TViewSpedC300VO>;

implementation


initialization
  Classes.RegisterClass(TViewSpedC300VO);

finalization
  Classes.UnRegisterClass(TViewSpedC300VO);

end.
