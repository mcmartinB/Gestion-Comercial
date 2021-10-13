unit AprovechaEntradasQR;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, DBTables;

type
  TQRAprovechaEntradas = class(TQuickRep)
    BndTitulo: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    DetailBand1: TQRBand;
    kilos: TQRExpr;
    BndCabecera: TQRBand;
    PsQRLabel10: TQRLabel;
    PsQRLabel5: TQRLabel;
    PsQRLabel6: TQRLabel;
    PsQRLabel8: TQRLabel;
    PsQRLblDestrio: TQRLabel;
    PsQRLblMerma: TQRLabel;
    cajas: TQRExpr;
    rango: TQRLabel;
    qrxprcentro: TQRExpr;
    kilos_primera: TQRExpr;
    kilos_destrio: TQRExpr;
    kilos_segunda: TQRExpr;
    kilos_tercera: TQRExpr;
    qrchldbndKilosAprovecha: TQRChildBand;
    aprovecha_primera: TQRExpr;
    aprovecha_segunda: TQRExpr;
    aprovecha_tercera: TQRExpr;
    aprovecha_destrio: TQRExpr;
    aprovecha_merma: TQRExpr;
    qrxprempresa: TQRExpr;
    qrxprgrupo: TQRExpr;
    qrxprplantacion: TQRExpr;
    qrxprcosechero: TQRExpr;
    pkilos_primera: TQRExpr;
    pkilos_segunda: TQRExpr;
    pkilos_tercera: TQRExpr;
    pkilos_destrio: TQRExpr;
    paprovecha_primera: TQRExpr;
    paprovecha_segunda: TQRExpr;
    paprovecha_tercera: TQRExpr;
    paprovecha_destrio: TQRExpr;
    paprovecha_merma: TQRExpr;
    aprovecha_merma_: TQRExpr;
    paprovecha_merma_: TQRExpr;
    qrgrpGrupo: TQRGroup;
    qrgrpProducto: TQRGroup;
    qrxprProducto: TQRExpr;
    qrgrpCosechero: TQRGroup;
    qrgrpPlantacion: TQRGroup;
    qrxprfecha: TQRExpr;
    qrxprnumero: TQRExpr;
    qrxpr5: TQRExpr;
    qrxpr9: TQRExpr;
    qrlblDesFecha: TQRLabel;
    qrlblDesNumero: TQRLabel;
    qrgrpCentro: TQRGroup;
    qrxpr3: TQRExpr;
    qrxpr8: TQRExpr;
    qrxpr6: TQRExpr;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    qrbndPieProducto: TQRBand;
    kilos_primerap: TQRExpr;
    pkilos_primerap: TQRExpr;
    kilos_segundap: TQRExpr;
    pkilos_segundap: TQRExpr;
    kilos_tercerap: TQRExpr;
    pkilos_tercerap: TQRExpr;
    kilos_destriop: TQRExpr;
    pkilos_destriop: TQRExpr;
    aprovecha_merma_p: TQRExpr;
    paprovecha_merma_p: TQRExpr;
    qrbndPieProductoAux: TQRChildBand;
    aprovecha_primerap: TQRExpr;
    aprovecha_segundap: TQRExpr;
    aprovecha_tercerap: TQRExpr;
    aprovecha_destriop: TQRExpr;
    aprovecha_mermap: TQRExpr;
    paprovecha_primerap: TQRExpr;
    paprovecha_segundap: TQRExpr;
    paprovecha_tercerap: TQRExpr;
    paprovecha_destriop: TQRExpr;
    paprovecha_mermap: TQRExpr;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    qrxpr4: TQRExpr;
    sinasignar_: TQRExpr;
    psinasignar_: TQRExpr;
    qrlbl7: TQRLabel;
    sinasignar: TQRExpr;
    psinasignar: TQRExpr;
    sinasignar_p: TQRExpr;
    psinasignar_p: TQRExpr;
    sinasignarp: TQRExpr;
    psinasignarp: TQRExpr;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure qrxpr3Print(sender: TObject; var Value: String);
    procedure qrxpr5Print(sender: TObject; var Value: String);
    procedure qrxpr9Print(sender: TObject; var Value: String);
    procedure qrxprfechaPrint(sender: TObject; var Value: String);
    procedure qrxpr6Print(sender: TObject; var Value: String);
    procedure qrxpr8Print(sender: TObject; var Value: String);
    procedure qrxprempresaPrint(sender: TObject; var Value: String);
    procedure qrxprcentroPrint(sender: TObject; var Value: String);
    procedure qrxprProductoPrint(sender: TObject; var Value: String);
    procedure qrxprgrupoPrint(sender: TObject; var Value: String);
    procedure qrxprcosecheroPrint(sender: TObject; var Value: String);
    procedure qrxprplantacionPrint(sender: TObject; var Value: String);
    procedure qrgrpPlantacionBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrxpr1Print(sender: TObject; var Value: String);
  private
    bExporting: boolean;
  public
     iTipoEntrada, iVerDatos, iVerDetalle, iPeriodo: integer;

  end;

procedure InformeAprovechamiento(const AEmpresa, ACentro, AProducto, ACosechero, APlantacion: string;
                                 const AFechaDesde, AFechaHasta: TDateTime; const ATipoEntrada, AVerDatos, AVerDetalles, APeriodo: integer  );

(*
  APlantacionHasta: Integer; const AVerPlantaciones: boolean;
  const ATipoEntrada: integer; const ADesTipo: string; const ASepRama: boolean );
*)


implementation

{$R *.DFM}

uses CReportes, AprovechaEntradasDM, Dpreview, UDMAuxDB, Dialogs;

procedure InformeAprovechamiento(const AEmpresa, ACentro, AProducto, ACosechero, APlantacion: string;
                                 const AFechaDesde, AFechaHasta: TDateTime; const ATipoEntrada, AVerDatos, AVerDetalles, APeriodo: integer  );
var
  QRAprovechaEntradas: TQRAprovechaEntradas;

begin
  QRAprovechaEntradas := TQRAprovechaEntradas.Create(nil);
  PonLogoGrupoBonnysa(QRAprovechaEntradas, AEmpresa);
  QRAprovechaEntradas.lblTitulo.Caption := 'RESUMEN DE APROVECHAMIENTO';
  QRAprovechaEntradas.iVerDatos:= AVerDatos;
  QRAprovechaEntradas.iVerDetalle:= AVerDetalles;
  QRAprovechaEntradas.iPeriodo:= APeriodo;
  QRAprovechaEntradas.iTipoEntrada:= ATipoEntrada;
  QRAprovechaEntradas.rango.Caption := 'Desde ' + DateToStr( AFechaDesde ) + ' hasta ' + DateToStr( AFechaHasta );

  try
    Preview(QRAprovechaEntradas);
  except
    FreeAndNil(QRAprovechaEntradas);
  end;
end;

procedure TQRAprovechaEntradas.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  if iVerDatos = 1 then
  begin
    //Ver escandallos
    qrchldbndKilosAprovecha.Enabled:= False;
    aprovecha_merma_.Enabled:= False;
    paprovecha_merma_.Enabled:= False;
    PsQRLblMerma.Enabled:= False;

    qrbndPieProductoAux.Enabled:= False;
    qrbndPieProducto.Frame.DrawBottom:= True;
    aprovecha_merma_p.Enabled:= False;
    paprovecha_merma_p.Enabled:= False;

    sinasignar_.Enabled:= False;
    psinasignar_.Enabled:= False;
    sinasignar_p.Enabled:= False;
    psinasignar_p.Enabled:= False;
  end
  else
  if iVerDatos = 2 then
  begin
    //Ver aprovechamientos
    qrchldbndKilosAprovecha.Enabled:= False;
    kilos_primera.Expression:= aprovecha_primera.Expression;
    kilos_segunda.Expression:= aprovecha_segunda.Expression;
    kilos_tercera.Expression:= aprovecha_tercera.Expression;
    kilos_destrio.Expression:= aprovecha_destrio.Expression;
    pkilos_primera.Expression:= paprovecha_primera.Expression;
    pkilos_segunda.Expression:= paprovecha_segunda.Expression;
    pkilos_tercera.Expression:= paprovecha_tercera.Expression;
    pkilos_destrio.Expression:= paprovecha_destrio.Expression;

    aprovecha_merma_.Enabled:= True;
    paprovecha_merma_.Enabled:= True;

    qrbndPieProductoAux.Enabled:= False;
    qrbndPieProducto.Frame.DrawBottom:= True;
    kilos_primerap.Expression:= aprovecha_primerap.Expression;
    kilos_segundap.Expression:= aprovecha_segundap.Expression;
    kilos_tercerap.Expression:= aprovecha_tercerap.Expression;
    kilos_destriop.Expression:= aprovecha_destriop.Expression;
    pkilos_primerap.Expression:= paprovecha_primerap.Expression;
    pkilos_segundap.Expression:= paprovecha_segundap.Expression;
    pkilos_tercerap.Expression:= paprovecha_tercerap.Expression;
    pkilos_destriop.Expression:= paprovecha_destriop.Expression;

    aprovecha_merma_p.Enabled:= True;
    paprovecha_merma_p.Enabled:= True;

    sinasignar_.Enabled:= True;
    psinasignar_.Enabled:= True;
    sinasignar_p.Enabled:= True;
    psinasignar_p.Enabled:= True;
  end
  else
  begin
    qrbndPieProductoAux.Enabled:= not bExporting and ( iVerDetalle >= 0 );
    qrbndPieProducto.Frame.DrawBottom:= False;

    aprovecha_merma_.Enabled:= False;
    paprovecha_merma_.Enabled:= False;

    aprovecha_merma_p.Enabled:= False;
    paprovecha_merma_p.Enabled:= False;

    sinasignar_.Enabled:= False;
    psinasignar_.Enabled:= False;
    sinasignar_p.Enabled:= False;
    psinasignar_p.Enabled:= False;
  end;

  bExporting:= ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
  qrxprempresa.Enabled:= bExporting;
  qrxprcentro.Enabled:= bExporting;
  qrxprgrupo.Enabled:= bExporting;
  qrxprproducto.Enabled:= bExporting;
  qrxprcosechero.Enabled:= bExporting;
  qrxprplantacion.Enabled:= bExporting;

  qrgrpCentro.Enabled:= not bExporting;
  qrgrpProducto.Enabled:= not bExporting and ( iVerDetalle >= 0 );
  qrgrpGrupo.Enabled:= not bExporting and ( iVerDetalle >= 0 );
  qrgrpCosechero.Enabled:= not bExporting and ( iVerDetalle >= 1 );
  qrgrpPlantacion.Enabled:= not bExporting and ( iVerDetalle >= 2 );

  qrbndPieProducto.Enabled:= not bExporting and ( iVerDetalle >= 0 );



  if iPeriodo = 1 then
  begin
    qrlblDesFecha.Caption:= 'Año';
    qrlblDesFecha.Enabled:= True;
    qrxprfecha.Enabled:= True;
    qrxprfecha.Left:= qrxprnumero.left;
    qrlblDesFecha.Left:=qrxprfecha.Left;

    qrxprnumero.Enabled:= False;
    qrlblDesNumero.Enabled:= False
  end
  else
  if iPeriodo = 2 then
  begin
    qrlblDesFecha.Caption:= 'Mes';
    qrlblDesFecha.Enabled:= True;
    qrxprfecha.Enabled:= True;
    qrxprfecha.Left:= qrxprnumero.left;
    qrlblDesFecha.Left:=qrxprfecha.Left;

    qrxprnumero.Enabled:= False;
    qrlblDesNumero.Enabled:= False
  end
  else
  if iPeriodo = 3 then
  begin
    qrlblDesFecha.Caption:= 'Semana';
    qrlblDesFecha.Enabled:= True;
    qrxprfecha.Enabled:= True;
    qrxprfecha.Left:= qrxprnumero.left;
    qrlblDesFecha.Left:=qrxprfecha.Left;

    qrxprnumero.Enabled:= False;
    qrlblDesNumero.Enabled:= False
  end
  else
  if iPeriodo = 4 then
  begin
    qrlblDesFecha.Caption:= 'Fecha';
    qrlblDesFecha.Enabled:= True;
    qrxprfecha.Enabled:= True;
    qrxprfecha.Left:= qrxprnumero.left;
    qrlblDesFecha.Left:=qrxprfecha.Left;

    qrxprnumero.Enabled:= False;
    qrlblDesNumero.Enabled:= False
  end
  else
  if iPeriodo = 5 then
  begin
    qrlblDesFecha.Caption:= 'Fecha';
    qrlblDesFecha.Enabled:= True;
    qrxprfecha.Enabled:= True;

    qrlblDesNumero.Caption:= 'Albarán';
    qrlblDesNumero.Enabled:= True;
    qrxprnumero.Enabled:= True;
  end
  else
  begin
    qrxprfecha.Enabled:= False;
    qrlblDesFecha.Enabled:= False;
    qrxprnumero.Enabled:= False;
    qrlblDesNumero.Enabled:= False;
  end
end;

procedure TQRAprovechaEntradas.qrxprfechaPrint(sender: TObject;
  var Value: String);
begin
  if iPeriodo >= 4 then
  begin
    if Value <> '' then
      Value:= FormatDateTime( 'dd/mm/yy', StrToFloat( Value ) );
  end;
end;

procedure TQRAprovechaEntradas.qrxpr3Print(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desProducto( DataSet.FieldByName('empresa').AsString, Value );
  if DataSet.FieldByName('rama_suelta').AsInteger = 1 then
    Value:= value + ' (RAMA SUELTA)';
end;

procedure TQRAprovechaEntradas.qrxpr5Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('grupo').AsString = 'T' then
  begin
    Value:= Value + ' ' + desCentro( DataSet.FieldByName('empresa').AsString, Value );
  end
  else
  begin
    Value:= Value + ' ' + desCosechero( DataSet.FieldByName('empresa').AsString, Value );
  end;
end;

procedure TQRAprovechaEntradas.qrxpr9Print(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' +
          DataSet.FieldByName('anyo_semana').AsString + ' ' +
          desPlantacion( DataSet.FieldByName('empresa').AsString,
                         DataSet.FieldByName('producto').AsString,
                         DataSet.FieldByName('cosechero').AsString,
                         Value, DataSet.FieldByName('anyo_semana').AsString );
end;


procedure TQRAprovechaEntradas.qrxpr6Print(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desCentro( DataSet.FieldByName('empresa').AsString, Value );
end;

procedure TQRAprovechaEntradas.qrxpr8Print(sender: TObject;
  var Value: String);
begin
  if Value = 'C' then
  begin
    Value:= 'COMPRAS SAT BONNYSA'; //TOTAL
  end
  else
  if Value = 'S' then
  begin
    Value:= 'ENTRADAS DEL GRUPO';
  end
  else
  if Value = 'N' then
  begin
    Value:= 'ENTRADAS DE TERCEROS';
  end
  else
  if Value = 'T' then
  begin
    Value:= 'TRANSITOS DE ENTRADAS';
  end;
end;

procedure TQRAprovechaEntradas.qrxprempresaPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + DesEmpresa( Value );
end;

procedure TQRAprovechaEntradas.qrxprcentroPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desCentro( DataSet.FieldByName('empresa').AsString, Value );
end;

procedure TQRAprovechaEntradas.qrxprProductoPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desProducto( DataSet.FieldByName('empresa').AsString, Value );
  if DataSet.FieldByName('rama_suelta').AsInteger = 1 then
    Value:= value + ' (RAMA SUELTA)';
end;

procedure TQRAprovechaEntradas.qrxprgrupoPrint(sender: TObject;
  var Value: String);
begin
  if Value = 'C' then
  begin
    Value:= 'COMPRAS SAT BONNYSA'; //TOTAL
  end
  else
  if Value = 'S' then
  begin
    Value:= 'ENTRADAS DEL GRUPO';
  end
  else
  if Value = 'N' then
  begin
    Value:= 'ENTRADAS DE TERCEROS';
  end
  else
  if Value = 'T' then
  begin
    Value:= 'TRANSITOS DE ENTRADAS';
  end;
end;

procedure TQRAprovechaEntradas.qrxprcosecheroPrint(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('grupo').AsString = 'T' then
  begin
    Value:= Value + ' ' + desCentro( DataSet.FieldByName('empresa').AsString, Value );
  end
  else
  begin
    Value:= Value + ' ' + desCosechero( DataSet.FieldByName('empresa').AsString, Value );
  end;
end;

procedure TQRAprovechaEntradas.qrxprplantacionPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' +
          DataSet.FieldByName('anyo_semana').AsString + ' ' +
          desPlantacion( DataSet.FieldByName('empresa').AsString,
                         DataSet.FieldByName('producto').AsString,
                         DataSet.FieldByName('cosechero').AsString,
                         Value, DataSet.FieldByName('anyo_semana').AsString );
end;

procedure TQRAprovechaEntradas.qrgrpPlantacionBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if DataSet.FieldByName('grupo').AsString = 'T' then
  begin
    qrgrpPlantacion.Height:= 0;
  end
  else
  begin
    qrgrpPlantacion.Height:= 17;
  end;
end;

procedure TQRAprovechaEntradas.qrxpr1Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTALES ' + Value + ' ' + desProducto( DataSet.FieldByName('empresa').AsString, Value );
  if DataSet.FieldByName('rama_suelta').AsInteger = 1 then
    Value:= value + ' (RAMA SUELTA)';
end;

end.
