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
    bPrintEntrada: Boolean;
    bPrintObservacion: Boolean;
    bPrintPacking: Boolean;
    iStatus: Integer;
    iMercado: Integer;
  end;

  function GetCodigoEntrega( const AEmpresa, AFecha: string ): string;

implementation

uses Classes, SysUtils, UDMConfig, UDMAuxDB, bTextUtils;

function GetCodigoEntrega( const AEmpresa, AFecha: string ): string;
var
  iDia, iMes, iAnyo, iCont: word;
  dFecha: TDateTime;
begin
  //Codigo entrada --> EEECAA-contador
  //EEE -> Empresa
  //C -> Codigo centro instalacion programa, tabla "frf_configuracion"
  //AA -> Año

  result:= AEmpresa;
  result:= result + IntToStr(DMConfig.CodigoBD);
  DecodeDate( StrToDateDef( AFecha, Date ), iAnyo, iMes, iDia );

  if AEmpresa = '078' then
  begin
    //Inicio de campaña el 1/7/xxxx, incremento el año del segundo trimestre
    //Ejemplo del 1/7/2008 al 30/6/2009 las entregas pertenecen a la campaña del 09
    dFecha:= EncodeDate( iAnyo, 6, 30 );
    if StrToDate( AFecha ) > dFecha then
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
