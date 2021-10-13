unit LResumenRemesasReport;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQRResumenRemesas = class(TQuickRep)
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    PsQRSysData1: TQRSysData;
    PsQRLabel1: TQRLabel;
    QRGroup1: TQRGroup;
    PsQRExpr1: TQRExpr;
    PsQRExpr2: TQRExpr;
    PsQRLabel2: TQRLabel;
    PsQRExpr3: TQRExpr;
    PsQRExpr4: TQRExpr;
    PsQRExpr5: TQRExpr;
    PsQRExpr8: TQRExpr;
    PsQRExpr11: TQRExpr;
    PsQRLabel9: TQRLabel;
    PsQRExpr12: TQRExpr;
    QRBand1: TQRBand;
    PsQRLabel10: TQRLabel;
    PsQRLabel11: TQRLabel;
    lblPeriodo: TQRLabel;
    lblCliente: TQRLabel;
    qrxnotas_r: TQRExpr;
    qrlnotas_r: TQRLabel;
    qrxpr1: TQRExpr;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrlbl3: TQRLabel;
    qrCliente: TQRExpr;
    QRLabel1: TQRLabel;
    procedure PsQRExpr3Print(sender: TObject; var Value: string);
    procedure PsQRExpr4Print(sender: TObject; var Value: String);
    procedure qrClientePrint(sender: TObject; var Value: string);
  private

  public
    Empresa: string;
  end;

procedure QRResumenRemesasPrint(const AEmpresa, ABanco, ACliente, AFechaDesde, AFechaHasta: string);

implementation

{$R *.DFM}

uses CReportes, DPreview, UDMbaseDatos, bSQLUtils, UDMAuxDB, Dialogs,
  bTimeUtils, Variants;

function PreparaQuery(const AEmpresa, ABanco, ACliente, AFechaDesde, AFechaHasta: string): Boolean;
begin
  with DMBaseDatos.QListado do
  begin
    SQL.Clear;
    SQL.Add('  select empresa_remesa_rc empresa, cod_banco_rc banco, n_remesa_rc remesa, cod_cliente_rc cliente, ');
    SQL.Add('      notas_rc notas, fecha_vencimiento_rc fecha, moneda_cobro_rc moneda, ');
    SQL.Add('      nvl(importe_cobro_rc,0) importe_cobro, ');
    SQL.Add('      sum(importe_cobrado_rf) total_factura ');

    SQL.Add('    from tremesas_cab ');
    SQL.Add('         join tremesas_fac on  empresa_remesa_rc  = empresa_remesa_rf and n_remesa_rc = n_remesa_rf ');
    SQL.Add('         left join tfacturas_cab on cod_factura_rf = cod_factura_fc ');



    if AEmpresa = 'BAG' then
      SQL.Add('   where ( substr(empresa_remesa_rc,1,1) = ''F''  or empresa_remesa_rc = ''BAG'' ) ')
    else
    if AEmpresa = 'SAT' then
      SQL.Add('   where ( empresa_remesa_rc = ''050''  or empresa_remesa_rc = ''080''  or empresa_remesa_rc = ''SAT'' ) ')
    else
      SQL.Add('  where empresa_remesa_rc ' + SQLEqualS(AEmpresa) + ' ');
    SQL.Add('    and fecha_vencimiento_rc ' + SQLRangeD(AFechaDesde, AFechaHasta));
    if ACliente <> '' then
      SQL.Add('    and cod_cliente_fc ' + SQLEqualS(ACliente));
    if trim(ABanco) <> '' then
      SQL.Add('   and cod_banco_rc ' + SQLEqualS(ABanco));

    SQL.Add('    group by 1,2,3,4,5,6,7,8 ');
    SQL.Add('    order by 1,2,3  ');

    Open;
    result := not IsEmpty;
    if not Result then Close
  end;
end;

procedure QRResumenRemesasPrint(const AEmpresa, ABanco, ACliente, AFechaDesde, AFechaHasta: string);
var
  QRResumenRemesas: TQRResumenRemesas;
begin
  if PreparaQuery(AEmpresa, ABanco, ACliente, AFechaDesde, AFechaHasta) then
  begin
    QRResumenRemesas := TQRResumenRemesas.Create(nil);
    PonLogoGrupoBonnysa(QRResumenRemesas, AEmpresa);
    QRResumenRemesas.lblPeriodo.Caption := 'Desde ' + AFechaDesde + ' al ' + AFechaHasta;
    if ACliente <> '' then
    begin
      QRResumenRemesas.lblCliente.Caption:= desCliente( ACliente );
    end
    else
    begin
      QRResumenRemesas.lblCliente.Caption:= 'TODOS LOS CLIENTES';
    end;
    QRResumenRemesas.Empresa := AEmpresa;
    Preview(QRResumenRemesas);
    DMBaseDatos.QListado.Close;
  end
  else
  begin
    ShowMessage('Listado sin datos.');
  end;
end;

procedure TQRResumenRemesas.PsQRExpr3Print(sender: TObject;
  var Value: string);
begin
  Value := desBanco( Value);
end;

procedure TQRResumenRemesas.PsQRExpr4Print(sender: TObject;
  var Value: String);
begin
  Value := FormatDateTime('dd/mm/yy', DataSet.FieldByName('fecha').AsDateTime );
end;

procedure TQRResumenRemesas.qrClientePrint(sender: TObject; var Value: string);
begin
  value := value + ' - ' + descliente(value);
end;

end.
