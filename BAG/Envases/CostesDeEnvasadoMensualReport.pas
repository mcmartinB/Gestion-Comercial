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
    PsQRExpr1: TQRExpr;
    QRBand1: TQRBand;
    PsQRExpr4: TQRExpr;
    QRGroup2: TQRGroup;
    PsQRExpr2: TQRExpr;
    PsQRLabel5: TQRLabel;
    PsQRLabel6: TQRLabel;
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
    QRLabel2: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    qrxGeneral: TQRExpr;
    qrx1: TQRExpr;
    qrl3: TQRLabel;
    qrl4: TQRLabel;
    qrx2: TQRExpr;
    qrx3: TQRExpr;
    qrx4: TQRExpr;
    qrl1: TQRLabel;
    procedure PsQRExpr5Print(sender: TObject; var Value: string);
    procedure costePrint(sender: TObject; var Value: string);
    procedure PsQRExpr7Print(sender: TObject; var Value: string);
    procedure PsQRExpr2Print(sender: TObject; var Value: string);
    procedure PsQRLabel10Print(sender: TObject; var Value: string);
    procedure PsQRLabel9Print(sender: TObject; var Value: string);
    procedure descripcionPrint(sender: TObject; var Value: string);
  private

  public
    Empresa, Producto, Mes: string;
  end;

procedure QRCostesDeEnvasadoMensualPrint(const AEmpresa, ACentro, AProducto: string;
  const AFechaIni, AFechaFin: TDate);
implementation

{$R *.DFM}

uses CReportes, DPreview, UDMbaseDatos, bSQLUtils, UDMAuxDB, Dialogs,
  bTimeUtils, Variants, DB, bMath;


function PreparaQuery(const AEmpresa, ACentro, AProducto: string;
  const AFechaIni, AFechaFin: TDate): Boolean;
begin
  with DMBaseDatos.QListado do
  begin
    SQL.Clear;
    SQL.Add(' select YEAR( fecha_sl ) anyo, MONTH ( fecha_sl ) mes, ');
    SQL.Add('        producto_sl cod_producto, envase_sl cod_envase, ');

    SQL.Add(' ( select material_ec  from frf_env_costes ');
    SQL.Add('  where empresa_ec = empresa_sl ');
    SQL.Add('  and centro_ec = centro_salida_sl ');
    SQL.Add('  and ( anyo_ec * 100 ) + mes_ec = ( select max( ( anyo_ec * 100 ) + mes_ec ) from frf_env_costes');
    SQL.Add('                                     where empresa_ec = empresa_sl');
    SQL.Add('                                     and centro_ec = centro_salida_sl');
    SQL.Add('                                     and ( ( anyo_ec = YEAR( fecha_sl )  and mes_ec <= MONTH ( fecha_sl ) ) or');
    SQL.Add('                                           ( anyo_ec < YEAR( fecha_sl ) ) )');
    SQL.Add('                                     and envase_ec = envase_sl');
    SQL.Add('                                     and producto_ec =producto_sl ');
    SQL.Add('                                    )');
    SQL.Add('  and envase_ec = envase_sl ');
    SQL.Add('  and producto_ec = producto_sl ');
    SQL.Add(' ) material, ');
    SQL.Add(' ( select personal_ec  from frf_env_costes ');
    SQL.Add('  where empresa_ec = empresa_sl ');
    SQL.Add('  and centro_ec = centro_salida_sl ');
    SQL.Add('  and ( anyo_ec * 100 ) + mes_ec = ( select max( ( anyo_ec * 100 ) + mes_ec ) from frf_env_costes');
    SQL.Add('                                     where empresa_ec = empresa_sl');
    SQL.Add('                                     and centro_ec = centro_salida_sl');
    SQL.Add('                                     and ( ( anyo_ec = YEAR( fecha_sl )  and mes_ec <= MONTH ( fecha_sl ) ) or');
    SQL.Add('                                           ( anyo_ec < YEAR( fecha_sl ) ) )');
    SQL.Add('                                     and envase_ec = envase_sl');
    SQL.Add('                                     and producto_ec = producto_sl ');
    SQL.Add('                                    )');
    SQL.Add('  and envase_ec = envase_sl ');
    SQL.Add('  and producto_ec = producto_sl');
    SQL.Add(' ) personal, ');
    SQL.Add(' ( select general_ec from frf_env_costes ');
    SQL.Add('  where empresa_ec = empresa_sl ');
    SQL.Add('  and centro_ec = centro_salida_sl ');
    SQL.Add('  and ( anyo_ec * 100 ) + mes_ec = ( select max( ( anyo_ec * 100 ) + mes_ec ) from frf_env_costes');
    SQL.Add('                                     where empresa_ec = empresa_sl');
    SQL.Add('                                     and centro_ec = centro_salida_sl');
    SQL.Add('                                     and ( ( anyo_ec = YEAR( fecha_sl )  and mes_ec <= MONTH ( fecha_sl ) ) or');
    SQL.Add('                                           ( anyo_ec < YEAR( fecha_sl ) ) )');
    SQL.Add('                                     and envase_ec = envase_sl');
    SQL.Add('                                     and producto_ec = producto_sl');
    SQL.Add('                                    )');
    SQL.Add('  and envase_ec = envase_sl ');
    SQL.Add('  and producto_ec = producto_sl');
    SQL.Add(' ) general, sum(kilos_sl) kilos');
    SQL.Add(' from frf_salidas_l ');
    SQL.Add(' where empresa_sl = :empresa ');
    SQL.Add('   and centro_salida_sl = :centro ');
    SQL.Add('   and fecha_sl between :fechaini and :fechafin ');
    if Trim(AProducto) <> '' then
      SQL.Add('   and producto_sl = :producto ');
    SQL.Add(' group by 1,2,3,4,5,6,7 ');
    SQL.Add(' order by 1,2,3,4,5,6,7 ');
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('fechaini').AsDate := AFechaIni;
    ParamByName('fechafin').AsDate := AFechaFin;
    if Trim(AProducto) <> '' then
      ParamByName('producto').AsString := AProducto;
    Open;
    result := not IsEmpty;
    if not Result then Close
  end;
end;

procedure QRCostesDeEnvasadoMensualPrint(const AEmpresa, ACentro, AProducto: string;
  const AFechaIni, AFechaFin: TDate);
var
  QRCostesDeEnvasadoMensual: TQRCostesDeEnvasadoMensual;
begin
  if PreparaQuery(AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin) then
  begin
    QRCostesDeEnvasadoMensual := TQRCostesDeEnvasadoMensual.Create(nil);
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
  Value := desProductoBase(Empresa, Value);
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

procedure TQRCostesDeEnvasadoMensual.descripcionPrint(sender: TObject;
  var Value: string);
begin
  Value := desEnvaseP(Empresa, value, DataSet.FieldByName('cod_producto').AsString );
end;

end.
