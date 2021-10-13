unit Recadv_DL;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDLRecadv_ = class(TDataModule)
    QCabecera: TQuery;
    DSMaestro: TDataSource;
    QDetalle: TQuery;
    QDetalleidcab_elr: TStringField;
    QDetalleidemb_elr: TStringField;
    QDetalleidlin_elr: TStringField;
    QDetalleean_elr: TStringField;
    QDetallerefprov_elr: TStringField;
    QDetallerefcli_elr: TStringField;
    QDetallecantace_elr: TFloatField;
    QDetallecantue_elr: TFloatField;
    QDetalleunidad_fac: TStringField;
    QDetalleenvase: TStringField;
    QCantidades: TQuery;
    QCantidadescalif_enr: TStringField;
    QCantidadescantidad_enr: TFloatField;
    QCantidadesdiscrep_enr: TStringField;
    QCantidadesrazon_enr: TStringField;
    QCantidadescalificador: TStringField;
    QCantidadesdiscrepancia: TStringField;
    QCantidadesrazon: TStringField;
    QObservaciones: TQuery;
    QObservacionesidobs_eor: TStringField;
    QObservacionestexto1_eor: TStringField;
    QObservacionestexto2_eor: TStringField;
    QObservacionestexto3_eor: TStringField;
    QObservacionestexto4_eor: TStringField;
    QObservacionestexto5_eor: TStringField;
    DSDetalle: TDataSource;
    QCabeceraempresa_ecr: TStringField;
    QCabeceraidcab_ecr: TStringField;
    QCabeceranumcon_ecr: TStringField;
    QCabeceratipo_ecr: TStringField;
    QCabecerafuncion_ecr: TStringField;
    QCabecerafecdoc_ecr: TDateField;
    QCabecerafecrec_ecr: TDateField;
    QCabeceranumalb_ecr: TStringField;
    QCabeceranumped_ecr: TStringField;
    QCabeceraorigen_ecr: TStringField;
    QCabeceramatric_ecr: TStringField;
    QCabeceradestino_ecr: TStringField;
    QCabeceraproveedor_ecr: TStringField;
    QCabecerafcarga_ecr: TDateField;
    QCabeceraaqsfac_ecr: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure QCabeceraAfterOpen(DataSet: TDataSet);
    procedure QCabeceraBeforeClose(DataSet: TDataSet);
    procedure QDetalleCalcFields(DataSet: TDataSet);
    procedure QCantidadesCalcFields(DataSet: TDataSet);

  private
    { Private declarations }

  public
    { Public declarations }
    function ObtenerDatosListado( const ARecadv: string ): boolean;
    procedure CerrarDatosListado;

  end;

var
  DLRecadv_: TDLRecadv_;

implementation

{$R *.dfm}

uses
  RecadvDM;

procedure TDLRecadv_.DataModuleCreate(Sender: TObject);
begin
  with QCabecera do
  begin
    SQL.Clear;
    SQL.Add(' select * from edi_cabcre where idcab_ecr = :idcab_ecr');
  end;
  with QDetalle do
  begin
    SQL.Clear;
    SQL.Add(' select idcab_elr, idemb_elr, idlin_elr, ean_elr, refprov_elr, refcli_elr, cantace_elr, cantue_elr ');
    SQL.Add(' from edi_lincre where idcab_elr = :idcab_ecr ');
    SQL.Add(' order by idcab_elr, idemb_elr, idlin_elr ');
    Prepare;
  end;
  with QCantidades do
  begin
    SQL.Clear;
    SQL.Add(' select calif_enr, cantidad_enr, discrep_enr, razon_enr ');
    SQL.Add(' from edi_cantcre where idcab_enr = :idcab_elr and idemb_enr = :idemb_elr and idlin_enr = :idlin_elr  ');
    SQL.Add(' order by idcab_enr, idemb_enr, idlin_enr, calif_enr ');
    Prepare;
  end;
  with QObservaciones do
  begin
    SQL.Clear;
    SQL.Add(' select idobs_eor, texto1_eor, texto2_eor, texto3_eor, texto4_eor, texto5_eor ');
    SQL.Add(' from edi_obscabre where idcab_eor = :idcab_ecr ');
    SQL.Add(' order by idcab_eor, idobs_eor ');
    Prepare;
  end;
end;

procedure TDLRecadv_.DataModuleDestroy(Sender: TObject);
begin
  CerrarDatosListado;
  with QDetalle do
  begin
    if Prepared then
      UnPrepare;
  end;
  with QCantidades do
  begin
    if Prepared then
      UnPrepare;
  end;
  with QObservaciones do
  begin
    if Prepared then
      UnPrepare;
  end;
end;

procedure TDLRecadv_.QCabeceraAfterOpen(DataSet: TDataSet);
begin
  QDetalle.Open;
  QCantidades.Open;
  QObservaciones.Open;
end;

procedure TDLRecadv_.QCabeceraBeforeClose(DataSet: TDataSet);
begin
  QObservaciones.Close;
  QCantidades.Close;
  QDetalle.Close;
end;

procedure TDLRecadv_.QDetalleCalcFields(DataSet: TDataSet);
var
  sAux: string;
begin
  if DMRecadv <> nil then
  begin
    QDetalleenvase.AsString:= DMRecadv.DesEnvaseCliente( QDetallerefcli_elr.AsString, sAux );
    QDetalleunidad_fac.AsString:= sAux;
  end
  else
  begin
    QDetalleenvase.AsString:= '';
    QDetalleunidad_fac.AsString:= '';
  end;
end;

procedure TDLRecadv_.QCantidadesCalcFields(DataSet: TDataSet);
begin
  QCantidadescalificador.AsString:= GetCalificador( QCantidadescalif_enr.AsString );
  QCantidadesdiscrepancia.AsString:= GetDiscrepancia( QCantidadesdiscrep_enr.AsString );
  QCantidadesrazon.AsString:= GetRazon( QCantidadesrazon_enr.AsString );
end;

function TDLRecadv_.ObtenerDatosListado( const ARecadv: string ): boolean;
begin
  QCabecera.ParamByName('idcab_ecr').AsString:= ARecadv;
  QCabecera.Open;
  Result:= not QCabecera.IsEmpty;
end;

procedure TDLRecadv_.CerrarDatosListado;
begin
  QCabecera.Close;
end;

end.
