unit CostesDeEnvasadoMensualReport;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQRCostesDeEnvasadoMensual = class(TQuickRep)
    DetailBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    PsQRSysData1: TQRSysData;
    PsQRLabel1: TQRLabel;
    codigo: TQRExpr;
    QRGroup1: TQRGroup;
    descripcion: TQRExpr;
    coste: TQRExpr;
    PsQRExpr1: TQRExpr;
    QRBand1: TQRBand;
    PsQRExpr4: TQRExpr;
    QRGroup2: TQRGroup;
    PsQRExpr2: TQRExpr;
    PsQRLabel5: TQRLabel;
    PsQRLabel6: TQRLabel;
    PsQRLabel7: TQRLabel;
    PsQRLabel8: TQRLabel;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    PsQRLabel9: TQRLabel;
    PsQRLabel10: TQRLabel;
    PsQRLabel11: TQRLabel;
    lblPeriodo: TQRLabel;
    lblCentro: TQRLabel;
    PsQRExpr6: TQRExpr;
    PsQRExpr7: TQRExpr;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    QRExpr9: TQRExpr;
    QRExpr10: TQRExpr;
    QRExpr11: TQRExpr;
    QRExpr12: TQRExpr;
    QRExpr13: TQRExpr;
    QRExpr14: TQRExpr;
    QRExpr15: TQRExpr;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    qrxpr3: TQRExpr;
    qrxpr4: TQRExpr;
    qrxpr5: TQRExpr;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    qrshpQRMarca: TQRShape;
    procedure PsQRExpr5Print(sender: TObject; var Value: string);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure costePrint(sender: TObject; var Value: string);
    procedure PsQRExpr7Print(sender: TObject; var Value: string);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PsQRExpr2Print(sender: TObject; var Value: string);
    procedure PsQRLabel10Print(sender: TObject; var Value: string);
    procedure PsQRLabel9Print(sender: TObject; var Value: string);
    procedure costeTotalPrint(sender: TObject; var Value: string);
    procedure PsQRLabel12Print(sender: TObject; var Value: string);
    procedure PsQRLabel13Print(sender: TObject; var Value: string);
    procedure PsQRLabel14Print(sender: TObject; var Value: string);
    procedure descripcionPrint(sender: TObject; var Value: string);
  private
    meses: integer;
  public
    Empresa, Producto, Mes: string;
    CosteEnvasado, totalProducto, totalMes, totalInforme: Real;
  end;

procedure QRCostesDeEnvasadoMensualPrint(const AEmpresa, ACentro, AProducto: string;
  const AFechaIni, AFechaFin: TDate; const APromedios: Boolean );
implementation

{$R *.DFM}

uses CReportes, DPreview, UDMbaseDatos, bSQLUtils, UDMAuxDB, Dialogs,
  bTimeUtils, Variants, DB, bMath;


function PreparaQuery(const AEmpresa, ACentro, AProducto: string;
  const AFechaIni, AFechaFin: TDate; const APromedios: Boolean ): Boolean;
begin
  with DMBaseDatos.QListado do
  begin
    SQL.Clear;
    SQL.Add(' select YEAR( fecha_sl ) anyo, MONTH ( fecha_sl ) mes, ');
    SQL.Add('        producto_sl cod_producto, envase_sl cod_envase, ');

    if APromedios then
      SQL.Add(' ( select pmaterial_ec coste_ec from frf_env_costes ')
    else
      SQL.Add(' ( select material_ec coste_ec from frf_env_costes ');
    SQL.Add('  where empresa_ec = empresa_sl ');
    SQL.Add('  and centro_ec = centro_salida_sl ');
    SQL.Add('  and anyo_ec = YEAR( fecha_sl ) ');
    SQL.Add('  and mes_ec = MONTH ( fecha_sl )');
    SQL.Add('  and envase_ec = envase_sl ');
    SQL.Add('  and producto_ec = producto_sl ');
    SQL.Add(' ) coste_material, ');


    if APromedios then
      SQL.Add(' ( select pcoste_ec coste_ec from frf_env_costes ')
    else
      SQL.Add(' ( select coste_ec coste_ec from frf_env_costes ');
    SQL.Add('  where empresa_ec = empresa_sl ');
    SQL.Add('  and centro_ec = centro_salida_sl ');
    SQL.Add('  and anyo_ec = YEAR( fecha_sl ) ');
    SQL.Add('  and mes_ec = MONTH ( fecha_sl )');
    SQL.Add('  and envase_ec = envase_sl ');
    SQL.Add('  and producto_ec = producto_sl ');
    SQL.Add(' ) coste_envasado, ');

    if APromedios then
      SQL.Add(' ( select psecciones_ec from frf_env_costes ')
    else
      SQL.Add(' ( select secciones_ec from frf_env_costes ');
    SQL.Add('  where empresa_ec = empresa_sl ');
    SQL.Add('  and centro_ec = centro_salida_sl ');
    SQL.Add('  and anyo_ec = YEAR( fecha_sl ) ');
    SQL.Add('  and mes_ec = MONTH ( fecha_sl )');
    SQL.Add('  and envase_ec = envase_sl ');
    SQL.Add('  and producto_ec = producto_sl ');
    SQL.Add(' ) secciones, ');

    SQL.Add(' ( select count(*) from frf_env_costes ');
    SQL.Add('  where empresa_ec = empresa_sl ');
    SQL.Add('  and centro_ec = centro_salida_sl ');
    SQL.Add('  and anyo_ec = YEAR( fecha_sl ) ');
    SQL.Add('  and mes_ec = MONTH ( fecha_sl )');
    SQL.Add('  and envase_ec = envase_sl ');
    SQL.Add('  and producto_ec = producto_sl ');
    SQL.Add(' ) registros, sum(kilos_sl) kilos');

    SQL.Add(' from frf_salidas_l, frf_salidas_c ');
    SQL.Add(' where empresa_sl = :empresa ');
    SQL.Add('   and centro_salida_sl = :centro ');
    SQL.Add('   and fecha_sl between :fechaini and :fechafin ');
    if Trim(AProducto) <> '' then
      SQL.Add('  and producto_sl = :producto ');
    SQL.Add('    and empresa_sc = empresa_sl ');
    SQL.Add('    and centro_salida_sc = centro_salida_sl ');
    SQL.Add('    and n_albaran_sc = n_albaran_sl ');
    SQL.Add('    and fecha_sc = fecha_sl ');
    SQL.Add('    and es_transito_sc <> 2 ');		                    //Tipo Salida: Devolucion

    SQL.Add(' group by 1,2,3,4,5,6,7,8 ');
    SQL.Add(' order by 1,2,3,4,5,6,7 ');
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('fechaini').AsDate := AFechaIni;
    ParamByName('fechafin').AsDate := AFechaFin;
    if Trim(AProducto) <> '' then
      ParamByName('producto').AsString := AProducto;

    Open;
    result := not IsEmpty;
    if not Result then
      Close
  end;
end;

procedure QRCostesDeEnvasadoMensualPrint(const AEmpresa, ACentro, AProducto: string;
  const AFechaIni, AFechaFin: TDate; const APromedios: Boolean );
var
  QRCostesDeEnvasadoMensual: TQRCostesDeEnvasadoMensual;
begin
  if PreparaQuery(AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin, APromedios) then
  begin
    QRCostesDeEnvasadoMensual := TQRCostesDeEnvasadoMensual.Create(nil);

    if not APromedios then
      QRCostesDeEnvasadoMensual.PsQRLabel1.Caption:= 'COSTES DE ENVASADO'
    else
      QRCostesDeEnvasadoMensual.PsQRLabel1.Caption:= 'COSTES DE ENVASADO PROMEDIO';

    PonLogoGrupoBonnysa(QRCostesDeEnvasadoMensual, AEmpresa);
    QRCostesDeEnvasadoMensual.Empresa := AEmpresa;
    QRCostesDeEnvasadoMensual.lblPeriodo.Caption :=
      'Desde ' + DateToStr(AFechaIni) + ' hasta ' + DateToStr(AFechaFin);
    QRCostesDeEnvasadoMensual.lblCentro.Caption := desCentro(AEmpresa, ACentro);
    Preview(QRCostesDeEnvasadoMensual);
    DMBaseDatos.QListado.Close;
  end
  else
  begin
    ShowMessage('Listado sin datos.');
  end;
end;

procedure TQRCostesDeEnvasadoMensual.PsQRExpr5Print(sender: TObject;
  var Value: string);
begin
  Value := desProducto(Empresa, Value);
end;

procedure TQRCostesDeEnvasadoMensual.DetailBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if DMBaseDatos.QListado.FieldByName('coste_envasado').Value = NULL then
  begin
    codigo.Font.Style := codigo.Font.Style + [fsItalic];
    descripcion.Font.Style := codigo.Font.Style + [fsItalic];
  end
  else
  begin
    codigo.Font.Style := codigo.Font.Style - [fsItalic];
    descripcion.Font.Style := codigo.Font.Style - [fsItalic];
  end;
  CosteEnvasado := bRoundTo(DataSet.fieldbyName('coste_envasado').AsFloat *
    DataSet.fieldbyName('kilos').AsFloat, -2);
  totalProducto := totalProducto + CosteEnvasado;
end;

procedure TQRCostesDeEnvasadoMensual.costePrint(sender: TObject;
  var Value: string);
begin
  if Value = '0' then Value := '';
end;

procedure TQRCostesDeEnvasadoMensual.PsQRExpr7Print(sender: TObject;
  var Value: string);
begin
  Value := desMes(Value);
  Mes := Value;
end;

procedure TQRCostesDeEnvasadoMensual.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  meses := 0;
  totalProducto := 0;
  totalMes := 0;
  totalInforme := 0;
end;

procedure TQRCostesDeEnvasadoMensual.QRGroup1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  Inc(meses);
end;

procedure TQRCostesDeEnvasadoMensual.QRBand3BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand := meses > 1;
end;

procedure TQRCostesDeEnvasadoMensual.PsQRExpr2Print(sender: TObject;
  var Value: string);
begin
  Producto := Value;
  Value := Value + ' ' + desProducto(Empresa, Value);
end;

procedure TQRCostesDeEnvasadoMensual.PsQRLabel10Print(sender: TObject;
  var Value: string);
begin
  Value := 'TOTAL MES ' + Mes;
end;

procedure TQRCostesDeEnvasadoMensual.PsQRLabel9Print(sender: TObject;
  var Value: string);
begin
  Value := 'TOTAL PRODUCTO [' + Producto + ']';
end;

procedure TQRCostesDeEnvasadoMensual.costeTotalPrint(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', CosteEnvasado);
end;

procedure TQRCostesDeEnvasadoMensual.PsQRLabel12Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', totalProducto);
  totalMes := totalMes + totalProducto;
  totalProducto := 0;
end;

procedure TQRCostesDeEnvasadoMensual.PsQRLabel13Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', totalMes);
  totalInforme := totalInforme + totalMes;
  totalMes := 0;
end;

procedure TQRCostesDeEnvasadoMensual.PsQRLabel14Print(sender: TObject;
  var Value: string);
begin
  Value := FormatFloat('#,##0.00', totalInforme);
end;

procedure TQRCostesDeEnvasadoMensual.descripcionPrint(sender: TObject;
  var Value: string);
begin
  Value := desEnvase(Empresa, value);
  if DataSet.FieldByName('registros').AsInteger <> 1 then
  begin
    qrshpQRMarca.Enabled:= True;
  end
  else
  begin
    qrshpQRMarca.Enabled:= False;
  end;
end;

end.
