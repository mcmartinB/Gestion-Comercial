unit FacturacionCB;

interface

type
  RClienteQL = record
    sEmpresa: String;
    sCliente: String;
    sPais: String;
    sTipoCliente: string;
    bExcluirTipoCliente: Boolean;
    iProcedencia: integer;
    sCentroOrigen: String;
    sCentroSalida: String;
    sCategoria: String;
    dFechaDesde: TDateTime;
    dFechaHasta: TDateTime;
    sNacional: String;
  end;

implementation

end.
