unit ServiciosTransportistasReport;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DBTables, DB;

type
  TQRServiciosTransportistasReport = class(TQuickRep)
    Query: TQuery;
    BandaDetalle: TQRBand;
    BandaCabecera: TQRGroup;
    BandaPie: TQRBand;
    PsQRExpr1: TQRExpr;
    PsQRExpr2: TQRExpr;
    PsQRExpr3: TQRExpr;
    PsQRExpr4: TQRExpr;
    PsQRExpr5: TQRExpr;
    PsQRExpr6: TQRExpr;
    PsQRExpr7: TQRExpr;
    PsQRExpr8: TQRExpr;
    PageFooterBand1: TQRBand;
    PsQRSysData1: TQRSysData;
    TitleBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    producto: TQRLabel;
    periodo: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    PsQRLabel2: TQRLabel;
    PsQRLabel3: TQRLabel;
    PsQRLabel4: TQRLabel;
    PsQRLabel5: TQRLabel;
    PsQRSysData2: TQRSysData;
  private

  public
    class procedure Ejecutar(const AEmpresa, ACentro, AProducto: string;
      const AFechaIni, AFechaFin: TDate);

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{$R *.DFM}
(*
select transportista_ec CodTransporte, descripcion_t NomTransporte,
       cosechero_e2l CodCosechero,
       ( select nombre_c from frf_cosecheros where empresa_c = empresa_ec and cosechero_c = cosechero_e2l ) NomCosechero,
       plantacion_e2l CodPlantacion,
       ( select descripcion_p from frf_plantaciones where ano_semana_p = ano_sem_planta_e2l and empresa_p = empresa_ec and
         producto_p = producto_ec and cosechero_p = cosechero_e2l and plantacion_p = plantacion_e2l ) NomPlantacion,
       sum(total_cajas_e2l) Cajas,
       sum(total_kgs_e2l) Kilos
from frf_entradas_c, frf_transportistas, frf_entradas2_l

where empresa_ec = '050'
and centro_ec = '1'
and fecha_ec between '1/11/2003' and '15/11/2003'
and producto_ec = 'T'

and empresa_t = '050'
and transporte_t = transportista_ec

and empresa_e2l = '050'
and centro_e2l = '1'
and numero_entrada_e2l = numero_entrada_ec
and fecha_e2l = fecha_ec

group by transportista_ec, descripcion_t, cosechero_e2l, 4, plantacion_e2l, 6
order by transportista_ec, descripcion_t, cosechero_e2l, 4, plantacion_e2l, 6
*)

uses bSQLUtils, DPreview, CReportes, UDMAuxDB, bDialogs;

class procedure TQRServiciosTransportistasReport.Ejecutar(const AEmpresa, ACentro, AProducto: string;
  const AFechaIni, AFechaFin: TDate);
var
  Report: TQRServiciosTransportistasReport;
begin
  Report := TQRServiciosTransportistasReport.Create(nil);

  Report.query.SQL.Clear;
  Report.query.SQL.Add(' select transportista_ec CodTransporte, descripcion_t NomTransporte, ');
  Report.query.SQL.Add('        cosechero_e2l CodCosechero, ');
  Report.query.SQL.Add('        ( select nombre_c from frf_cosecheros ');
  Report.query.SQL.Add('          where empresa_c = :empresa ');
  Report.query.SQL.Add('          and cosechero_c = cosechero_e2l ) NomCosechero, ');
  Report.query.SQL.Add('        plantacion_e2l CodPlantacion, ');
  Report.query.SQL.Add('        ( select descripcion_p from frf_plantaciones ');
  Report.query.SQL.Add('          where ano_semana_p = ano_sem_planta_e2l ');
  Report.query.SQL.Add('          and empresa_p = :empresa ');
  Report.query.SQL.Add('          and producto_p = producto_ec ');
  Report.query.SQL.Add('          and cosechero_p = cosechero_e2l ');
  Report.query.SQL.Add('          and plantacion_p = plantacion_e2l ) NomPlantacion, ');
  Report.query.SQL.Add('        sum(total_cajas_e2l) Cajas, ');
  Report.query.SQL.Add('        sum(total_kgs_e2l) Kilos ');
  Report.query.SQL.Add(' from frf_entradas_c, frf_transportistas, frf_entradas2_l ');

  Report.query.SQL.Add(' where empresa_ec = :empresa ');
  Report.query.SQL.Add(' and centro_ec = :centro ');
  Report.query.SQL.Add(' and fecha_ec between :fechaini and :fechafin ');
  if AProducto <> '' then
  begin
    Report.query.SQL.Add(' and producto_ec = :producto ');
  end;

  Report.query.SQL.Add(' and empresa_t = :empresa ');
  Report.query.SQL.Add(' and transporte_t = transportista_ec ');

  Report.query.SQL.Add(' and empresa_e2l = :empresa ');
  Report.query.SQL.Add(' and centro_e2l = :centro ');
  Report.query.SQL.Add(' and numero_entrada_e2l = numero_entrada_ec ');
  Report.query.SQL.Add(' and fecha_e2l = fecha_ec ');

  Report.query.SQL.Add(' group by transportista_ec, descripcion_t, cosechero_e2l, 4, plantacion_e2l, 6 ');
  Report.query.SQL.Add(' order by transportista_ec, descripcion_t, cosechero_e2l, 4, plantacion_e2l, 6 ');

  Report.query.ParamByName('empresa').AsString := AEmpresa;
  Report.query.ParamByName('centro').AsString := ACentro;
  if AProducto <> '' then
  begin
    Report.query.ParamByName('producto').AsString := AProducto;
  end;
  Report.query.ParamByName('fechaini').AsDate := AFechaIni;
  Report.query.ParamByName('fechafin').AsDate := AFechaFin;

  if OpenQuery(Report.query) and not Report.Query.IsEmpty then
  begin
    PonLogoGrupoBonnysa(Report, AEmpresa);
    if AProducto = '' then
    begin
      Report.producto.Caption := 'TODOS LOS PRODUCTOS';
    end
    else
    begin
      Report.producto.Caption := AProducto + ' ' + desProducto(AEmpresa, AProducto);
    end;
    Report.periodo.Caption := 'Desde ' + DateToStr(AFechaIni) +
      ' hasta ' + DateToStr(AFechaFin);
    DPreview.Preview(Report);
  end
  else
  begin
    Informar('Informe sin datos.');
    FreeAndNil(Report)
  end;
end;

constructor TQRServiciosTransportistasReport.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TQRServiciosTransportistasReport.Destroy;
begin
  inherited;
end;

end.
