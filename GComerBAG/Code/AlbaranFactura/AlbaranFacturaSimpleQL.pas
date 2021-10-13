unit AlbaranFacturaSimpleQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls,
  AlbaranFacturaSimpleCB, ListaCodigoValorCB;

type
  TQLAlbaranFacturaSimple = class(TQuickRep)
    PageHeaderBand1: TQRBand;
    bndDetalle: TQRBand;
    kilos_sl: TQRDBText;
    producto_sl: TQRDBText;
    etqTitulo: TQRSysData;
    etqImpresoTitulo: TQRSysData;
    PageFooterBand1: TQRBand;
    QRSysData3: TQRSysData;
    etqRangoFechasTitulos: TQRLabel;
    bndCabGrupo: TQRGroup;
    etqClienteTitulo: TQRLabel;
    bndSumario: TQRBand;
    QRMemo: TQRMemo;
    lineaVertical: TQRShape;
    lineaHorizontal: TQRShape;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRLabel1: TQRLabel;
    QRLabel9: TQRLabel;
    QRGroup1: TQRGroup;
    n_albaran_sc: TQRDBText;
    fecha_sc: TQRDBText;
    n_factura_sc: TQRDBText;
    fecha_factura_sc: TQRDBText;
    importe_euros_f: TQRDBText;
    QRLabel10: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRDBText1: TQRDBText;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    procedure producto_slPrint(sender: TObject; var Value: String);
    procedure importe_euros_fPrint(sender: TObject; var Value: String);
    procedure bndDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndSumarioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndDetalleAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure bndCabGrupoAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRDBText1Print(sender: TObject; var Value: String);
  private
    sEmpresa: String;
    listaProductosKilos: TListaCodigoValor;
  public
    constructor Create( AOwner: TComponent ); Override;
    destructor Destroy; Override;
  end;

procedure LoadReport( APadre: TComponent );
procedure UnloadReport;
procedure ExecuteReport( APadre: TComponent; AParametros: RAlbaranFacturaSimpleQL );

implementation

{$R *.DFM}

uses Dialogs, AlbaranFacturaSimpleDL, UDMAuxDB, DPreview, CReportes;

var
  QLAlbaranFacturaSimple: TQLAlbaranFacturaSimple;
  iContadorUso: integer = 0;

procedure LoadReport( APadre: TComponent );
begin
  Inc( iContadorUso );
  if iContadorUso = 1 then
  begin
    try
      QLAlbaranFacturaSimple:= TQLAlbaranFacturaSimple.Create( APadre );
    except
      iContadorUso:= 0;
      raise;
    end;
  end;
  AlbaranFacturaSimpleDL.LoadModule( APadre );
end;

procedure UnloadReport;
begin
  if iContadorUso > 0  then
  begin
    Dec( iContadorUso );
    if iContadorUso = 0 then
    begin
      if QLAlbaranFacturaSimple <> nil then
        FreeAndNil( QLAlbaranFacturaSimple );
    end;
  end;
  AlbaranFacturaSimpleDL.UnloadModule;
end;

procedure ExecuteReport( APadre: TComponent; AParametros: RAlbaranFacturaSimpleQL );
begin
  LoadReport( APadre );
  if AlbaranFacturaSimpleDL.OpenData( APadre, AParametros) <> 0 then
  begin
     QLAlbaranFacturaSimple.listaProductosKilos:= LimpiarLista( QLAlbaranFacturaSimple.listaProductosKilos );
     QLAlbaranFacturaSimple.sEmpresa:= AParametros.sEmpresa;
     QLAlbaranFacturaSimple.ReportTitle:= 'LISTADO FACTURAS ALBARÁN';
     QLAlbaranFacturaSimple.etqRangoFechasTitulos.Caption:= 'Del ' +
       DateToStr( AParametros.dFechaDesde ) +
       ' al ' + DateToStr( AParametros.dFechaHasta );
     //QLAlbaranFacturaSimple.etqRangoFechasCabPagina.Caption:=
     //  QLAlbaranFacturaSimple.etqRangoFechasTitulos.Caption;
     //QLAlbaranFacturaSimple.etqEmpresaCapPagina.Caption:= AParametros.sEmpresa +
     //  '/' + desEmpresa( AParametros.sEmpresa );
     QLAlbaranFacturaSimple.etqClienteTitulo.Caption:= AParametros.sCliente +
       '/' + desCliente( AParametros.sCliente );
     //QLAlbaranFacturaSimple.etqClienteCabPagina.Caption:=
     //  QLAlbaranFacturaSimple.etqClienteTitulo.Caption;
     PonLogoGrupoBonnysa( QLAlbaranFacturaSimple, AParametros.sEmpresa );
     Previsualiza( QLAlbaranFacturaSimple );
  end
  else
  begin
    ShowMessage('Sin datos para mostrar para los parametros de selección introducidos.');
  end;
  UnloadReport;
end;

constructor TQLAlbaranFacturaSimple.Create( AOwner: TComponent );
begin
  inherited;
  //BEGIN CODE

  //END CODE
end;

destructor TQLAlbaranFacturaSimple.Destroy;
begin
  //BEGIN CODE

  //END CODE
  inherited;
end;

procedure TQLAlbaranFacturaSimple.producto_slPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desProducto( sEmpresa, Value );
end;

procedure TQLAlbaranFacturaSimple.importe_euros_fPrint(sender: TObject;
  var Value: String);
begin
  if Value = '0,00' then
  begin
    Value:= 'ALBARÁN SIN FACTURAR';
    importe_euros_f.Font.Style:= importe_euros_f.Font.Style + [fsItalic] + [fsBold];
  end
  else
  begin
    importe_euros_f.Font.Style:= importe_euros_f.Font.Style - [fsItalic, fsBold];
  end;
end;

procedure TQLAlbaranFacturaSimple.bndDetalleBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  nodo: RNodoLista;
begin
  if not DataSet.IsEmpty then
  begin
    nodo.sCodigo:= DataSet.FieldByName('producto_sl').AsString;
    nodo.rValor:= DataSet.FieldByName('kilos_sl').AsFloat;
    listaProductosKilos:= AnyadirNodo( listaProductosKilos, nodo );
  end;
end;

procedure TQLAlbaranFacturaSimple.bndSumarioBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  i, cont, aux: integer;
  listaOrdenada: TStringList;
begin
  listaOrdenada:= TStringList.Create;
  QRMemo.Lines.Clear;
  cont:= 0;
  for i:= 0  to Length( listaProductosKilos ) - 1 do
  begin
    listaOrdenada.Add( ' ' + listaProductosKilos[i].sCodigo + '-' +
                      Format('%-20s', [Copy(desProducto( sEmpresa, listaProductosKilos[i].sCodigo),1,20)] ) +
                      Format('%12s', [FormatFloat( '#,##0.00', listaProductosKilos[i].rValor )] ) );
    inc( cont );
  end;
  listaOrdenada.Sort;
  QRMemo.Lines.AddStrings( listaOrdenada );
  aux:= 21 + ( ( cont - 1 ) * 16 );
  if aux > 35 then
  begin
    QRMemo.Height:= aux;
  end
  else
  begin
    QRMemo.Height:= 35;
  end;
  bndSumario.Height:= QRMemo.Height + 15;
  FreeAndNil(listaOrdenada);
end;

procedure TQLAlbaranFacturaSimple.bndDetalleAfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  lineaHorizontal.Enabled:= False;
end;

procedure TQLAlbaranFacturaSimple.bndCabGrupoAfterPrint(
  Sender: TQRCustomBand; BandPrinted: Boolean);
begin
  lineaHorizontal.Enabled:= True;
end;

procedure TQLAlbaranFacturaSimple.QRDBText1Print(sender: TObject;
  var Value: String);
begin
  Value:= 'Importe ' + Value;
end;

end.
