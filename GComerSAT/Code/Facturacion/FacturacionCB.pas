unit FacturacionCB;

interface

type
  RClienteQL = record
    sEmpresa: String;
    sSerie: string;
    sCliente: String;
    bAgruparCliente: Boolean;
    bVerDetalle: Boolean;
    sPais: String;
    sTipoCliente: String;
    bExcluirTipoCliente: Boolean;    
    iProcedencia: integer;
    iTipo: integer;
    iAbonos: integer;
    sCentroOrigen: String;
    sCentroSalida: String;
    sProducto: String;
    sCategoria: String;
    bFechaFactura: Boolean;
    dFechaDesde: TDateTime;
    dFechaHasta: TDateTime;
    sAgrupacion: String;
    sNacional: String;
  end;

implementation

end.
