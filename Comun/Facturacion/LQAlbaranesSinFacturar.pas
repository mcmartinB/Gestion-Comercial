unit LQAlbaranesSinFacturar;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQLAlbaranesSinFacturar = class(TQuickRep)
    bndCabeceraListado: TQRBand;
    lblTitulo: TQRLabel;
    QRSysData1: TQRSysData;
    bndPieListado: TQRBand;
    QRSysData2: TQRSysData;
    QRGroupCentro: TQRGroup;
    QRGroupCliente: TQRGroup;
    QRPieGroupCentro: TQRBand;
    QRPieGroupCliente: TQRBand;
    DetailBand1: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    ChildBand1: TQRChildBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRExpr1: TQRExpr;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    lblRangoFechas: TQRLabel;
    QRDBText13: TQRDBText;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    unidad_precio: TQRDBText;
    lblPrecio: TQRLabel;
    lblCalibre: TQRLabel;
    calibre: TQRDBText;
    qrealbaran: TQRDBText;
    qrl1: TQRLabel;
    qrlPais: TQRLabel;
    QRLabel4: TQRLabel;
    categoria: TQRDBText;
    QRDBText14: TQRDBText;
    QRDBText15: TQRDBText;
    procedure QRDBText1Print(sender: TObject; var Value: String);
    procedure QRDBText2Print(sender: TObject; var Value: String);
    procedure QRDBText11Print(sender: TObject; var Value: String);
    procedure QRDBText6Print(sender: TObject; var Value: String);
    procedure QRDBText5Print(sender: TObject; var Value: String);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ImprimirAlbaran(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRGroupClienteBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRPieGroupClienteBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRPieGroupCentroBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndPieListadoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrealbaranPrint(sender: TObject; var Value: String);
    procedure QRDBText3Print(sender: TObject; var Value: String);
    procedure QRDBText14Print(sender: TObject; var Value: string);
    procedure QRDBText12Print(sender: TObject; var Value: string);
  private
    sAlbaran: string;
    bImprimirAlbaran: boolean;
    
  public
    sEmpresa: string;

  end;

  procedure InicializarReport;
  procedure FinalizarReport;
  function  Imprimir( const AEmpresa, ACentro, ACliente, APais: String; const APaises: Integer;
                      const ATipoAlbaran: integer;
                      const AClienteFacturable, AExcluirMercadona, AMostrarCalibre: Boolean;
                      const AProducto: string;
                      const AFechaIni, AFechaFin: TDateTime;
                      const AUnidadPrecio: Integer ): boolean;

implementation

{$R *.DFM}

uses
  LDAlbaranesSinFacturar, DPreview, UDMAuxDB, CReportes;

var
  QLAlbaranesSinFacturar: TQLAlbaranesSinFacturar;
  DLAlbaranesSinFacturar: TDLAlbaranesSinFacturar;
  i: integer = 0;

procedure InicializarReport;
begin
  Inc( i );
  if i = 1 then
  begin
    DLAlbaranesSinFacturar:= LDAlbaranesSinFacturar.InicializarModulo;
  end;
end;

procedure FinalizarReport;
begin
  Dec( i );
  if i = 0 then
  begin
    LDAlbaranesSinFacturar.FinalizarModulo;
  end;
end;

function Imprimir( const AEmpresa, ACentro, ACliente, APais: String; const APaises: Integer;
                   const ATipoAlbaran: integer;
                   const AClienteFacturable, AExcluirMercadona, AMostrarCalibre: Boolean;
                   const AProducto: string;
                   const AFechaIni, AFechaFin: TDateTime;
                   const AUnidadPrecio: Integer ): boolean;
begin
  try
    result:= DLAlbaranesSinFacturar.ObtenerDatos(AEmpresa, ACentro, ACliente, APais, APaises,
                                                 ATipoAlbaran, AClienteFacturable, AExcluirMercadona, AMostrarCalibre,
                                                 AProducto, AFechaIni, AFechaFin );
    if result then
    begin
      QLAlbaranesSinFacturar:= TQLAlbaranesSinFacturar.Create( Application );
      QLAlbaranesSinFacturar.sEmpresa:= AEmpresa;
      if APais <> '' then
      begin
        QLAlbaranesSinFacturar.qrlPais.Caption:= desPais( APais );
      end
      else
      begin
        QLAlbaranesSinFacturar.qrlPais.Caption:= '';
      end;
      if AUnidadPrecio = 0 then
      begin
        QLAlbaranesSinFacturar.lblPrecio.Caption:= 'Precio Kilo';
        QLAlbaranesSinFacturar.unidad_precio.DataField:= 'precio_kilo';
      end
      else
      begin
        QLAlbaranesSinFacturar.lblPrecio.Caption:= 'Precio Caja';
        QLAlbaranesSinFacturar.unidad_precio.DataField:= 'precio_caja';
      end;
      PonLogoGrupoBonnysa( QLAlbaranesSinFacturar, AEmpresa );
      QLAlbaranesSinFacturar.lblRangoFechas.Caption:= DateToStr( AFechaIni ) + ' a ' +
                                                      DateToStr( AFechaFin );
      QLAlbaranesSinFacturar.lblCalibre.Enabled:= AMostrarCalibre;
      QLAlbaranesSinFacturar.calibre.Enabled:= AMostrarCalibre;
      if ATipoAlbaran = 1 then
        QLAlbaranesSinFacturar.lblTitulo.Caption := 'ALBARANES PENDIENTES DE FACTURAR CON IVA'
      else if ATipoAlbaran = 2 then
        QLAlbaranesSinFacturar.lblTitulo.Caption := 'ALBARANES PENDIENTES DE FACTURAR SIN IVA'
      else
        QLAlbaranesSinFacturar.lblTitulo.Caption := 'ALBARANES PENDIENTES DE FACTURAR';

      try
        Preview( QLAlbaranesSinFacturar );
      except
        FreeAndNil(QLAlbaranesSinFacturar);
        raise;
      end;
    end;
  finally
    DLAlbaranesSinFacturar.CerrarQuery;
  end;
end;

procedure TQLAlbaranesSinFacturar.QRDBText1Print(sender: TObject;
  var Value: String);
begin
  Value:= 'CENTRO SALIDA: ' + Value + ' - ' + DesCentro( DataSet.FieldByName('empresa').AsString, Value );
end;

procedure TQLAlbaranesSinFacturar.QRDBText2Print(sender: TObject;
  var Value: String);
begin
  Value:= 'CLIENTE: [' + Value + '] ' + DesCliente( Value ) + '   CODIGO X3: [' + DataSet.FieldByName('codigoX3').AsString + ']';
end;

procedure TQLAlbaranesSinFacturar.QRDBText11Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL CLIENTE: [' + Value + ' ]';
end;

procedure TQLAlbaranesSinFacturar.QRDBText12Print(sender: TObject;
  var Value: string);
begin
  Value:= 'CENTRO SALIDA: ' + Value;
end;

procedure TQLAlbaranesSinFacturar.QRDBText14Print(sender: TObject;
  var Value: string);
begin
  Value:= 'EMPRESA: ' + Value + ' - ' + DesEmpresa( DataSet.FieldByName('empresa').AsString );
end;

procedure TQLAlbaranesSinFacturar.QRDBText6Print(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desProducto( sEmpresa, Value );
end;

procedure TQLAlbaranesSinFacturar.QRDBText5Print(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' ' + desEnvaseProducto( sEmpresa, Value, DataSet.FieldByName('producto').AsString );
end;

procedure TQLAlbaranesSinFacturar.DetailBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
  sAux: string;
begin
  sAux:= DataSet.FieldByName('albaran').AsString + DataSet.FieldByName('fecha').AsString;
  bImprimirAlbaran:= sAux <> sAlbaran;
  if bImprimirAlbaran then
    sAlbaran:= sAux;
end;

procedure TQLAlbaranesSinFacturar.ImprimirAlbaran(sender: TObject;
  var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    FormatDateTime('dd/mm/aa', DLAlbaranesSinFacturar.QListado.FieldByName('fecha').AsDateTime );
  end
  else
  begin
    if not bImprimirAlbaran then
    begin
      Value:= ''
    end
    else
    begin
      FormatDateTime('dd/mm/aa', DLAlbaranesSinFacturar.QListado.FieldByName('fecha').AsDateTime );
    end
  end;
end;

procedure TQLAlbaranesSinFacturar.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  sAlbaran:= '';
end;

procedure TQLAlbaranesSinFacturar.QRGroupClienteBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLAlbaranesSinFacturar.QRPieGroupClienteBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLAlbaranesSinFacturar.QRPieGroupCentroBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLAlbaranesSinFacturar.bndPieListadoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQLAlbaranesSinFacturar.qrealbaranPrint(sender: TObject;
  var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    qrealbaran.Width:= 200;
    Value:= DesCliente( DataSet.fieldByName('cliente').AsString );
  end
  else
  begin
    if not bImprimirAlbaran then
    begin
      Value:= ''
    end;
  end;
end;

procedure TQLAlbaranesSinFacturar.QRDBText3Print(sender: TObject;
  var Value: String);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    if not bImprimirAlbaran then
    begin
      Value:= ''
    end;
  end;
end;

end.
