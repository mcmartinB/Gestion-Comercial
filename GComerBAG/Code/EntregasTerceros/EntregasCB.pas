unit EntregasCB;

interface

type
  REntregasQL = record
    sEmpresa: String;
    sCentro: String;
    sProveedor: String;
    sAlmacen: String;
    sProducto: String;
    sEntrega: String;
    sAlbaran: String;
    sAdjudicacion: String;
    dFechaDesde: TDateTime;
    dFechaHasta: TDateTime;
    bPrintDetalle: Boolean;
    bPrintObservacion: Boolean;
    bPrintPacking: Boolean;
    iStatus: Integer;
    iMercado: Integer;
    bAgrupar: Boolean;
  end;

  function GetCodigoEntrega( const AEmpresa, ACentro, AFecha: string ): string;

implementation

uses Classes, SysUtils, UDMConfig, UDMAuxDB, bTextUtils;

function GetCodigoEntrega( const AEmpresa, ACentro, AFecha: string ): string;
var
  iDia, iMes, iAnyo, iCont: word;
  dFecha: TDateTime;
begin
  //Codigo entrada --> EEECAA-contador
  //EEE -> Empresa
  //C -> Codigo centro llegada
  //AA -> Año

  result:= AEmpresa;
  //result:= result + IntToStr(DMConfig.CodigoBD);
  result:= result + ACentro;
  dFecha:= StrToDateDef( AFecha, Date );
  DecodeDate( dFecha, iAnyo, iMes, iDia );

  if dFecha >= EncodeDate(iAnyo, 7, 1 ) then
  begin
    iAnyo:= iAnyo + 1;
  end;
  result:= result + Copy( IntToStr( iAnyo ), 3, 2 );
  result:= result + '-';


  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('select * ');
    SQL.Add('from frf_empresas ');
    SQL.Add('where empresa_e = :empresa ');
    ParamByName('empresa').AsString:= AEmpresa;
    try
      Open;
      iCont:= FieldByName('cont_entregas_e').AsInteger + 1;
    finally
      Close;
    end;
  end;

  result:= result + Rellena( IntToStr( iCont ), 5, '0', taLeftJustify );
end;

end.
