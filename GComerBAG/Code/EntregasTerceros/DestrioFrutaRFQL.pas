unit DestrioFrutaRFQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLDestrioFrutaRF = class(TQuickRep)
    TitleBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    ColumnHeaderBand1: TQRBand;
    QRLabel1: TQRLabel;
    bndEntrega: TQRBand;
    qreproducto: TQRDBText;
    QRBand1: TQRBand;
    QRSysData1: TQRSysData;
    qrepais_p: TQRDBText;
    qreproducto_el: TQRDBText;
    QRLabel3: TQRLabel;
    lblRango: TQRLabel;
    QRLabel8: TQRLabel;
    qreproveedor_ec: TQRDBText;
    qrlCentro: TQRLabel;
    lblProducto: TQRLabel;
    qrevariedad_el: TQRDBText;
    qrlTipo: TQRLabel;
    qretipo: TQRDBText;
    qreproducto_el1: TQRDBText;
    qrl1: TQRLabel;
    qrl2: TQRLabel;
    qrg1: TQRGroup;
    qrg2: TQRGroup;
    bnd1: TQRBand;
    bnd2: TQRBand;
    qrxCajas2: TQRExpr;
    qrxNeto2: TQRExpr;
    bndSumario: TQRBand;
    qrxCajasS: TQRExpr;
    qrxNetoS: TQRExpr;
    qrxCajas1: TQRExpr;
    qrxNeto1: TQRExpr;
    qrlTotal: TQRLabel;
    qreTotalproducto: TQRDBText;
    qreTotalProveedor: TQRDBText;
    procedure qretipoPrint(sender: TObject; var Value: String);
    procedure qreproductoPrint(sender: TObject; var Value: String);
    procedure qreproveedor_ecPrint(sender: TObject; var Value: String);
    procedure qrg1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrg2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qreTotalproductoPrint(sender: TObject; var Value: String);
    procedure qreTotalProveedorPrint(sender: TObject; var Value: String);
  private

  public

    procedure PreparaListado( const AEmpresa, AProducto: string;
                              const AFechaIni, AFechaFin: TDateTime );
  end;

function VerDestrioFrutaRF( const AOwner: TComponent;
                            const AEmpresa, AProveedor, AProducto, AVariedad, ACalibre, AEntrega: string;
                            const AFechaIni, AFechaFin: TDateTime  ): boolean;

implementation

{$R *.DFM}

uses
  CReportes, DestrioFrutaRFDL, DPreview, UDMAuxDB, bMath;

var
  QLDestrioFrutaRF: TQLDestrioFrutaRF;


function VerDestrioFrutaRF( const AOwner: TComponent;
                            const AEmpresa, AProveedor, AProducto, AVariedad, ACalibre, AEntrega: string;
                            const AFechaIni, AFechaFin: TDateTime  ): boolean;
begin
  try
    result:= DestrioFrutaRFDL.ObtenerDatos( AOwner,  AEmpresa, AProveedor, AProducto, AVariedad, ACalibre, AEntrega, AFechaIni, AFechaFin );
    if result then
    begin
      QLDestrioFrutaRF:= TQLDestrioFrutaRF.Create( AOwner );
      try
        QLDestrioFrutaRF.PreparaListado( AEmpresa, AProducto, AFechaIni, AFechaFin );
        Previsualiza( QLDestrioFrutaRF );
      finally
        FreeAndNil( QLDestrioFrutaRF );
      end;
    end;
  finally
    DestrioFrutaRFDL.CerrarTablas;
  end;
end;

procedure TQLDestrioFrutaRF.PreparaListado( const AEmpresa, AProducto: string;
                                               const AFechaIni, AFechaFin: TDateTime );
begin
  PonLogoGrupoBonnysa( self, AEmpresa );

  if AProducto <> '' then
    lblProducto.Caption:= AProducto + ' ' + desProducto( AEmpresa, AProducto )
  else
    lblProducto.Caption:= 'TODOS LOS PRODUCTOS';

  lblRango.Caption:= 'Del ' + DateToStr( AFechaIni ) + ' al ' + DateToStr( AFechaFin );

end;

procedure TQLDestrioFrutaRF.qretipoPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + '  ' + DataSet.fieldByName('des_proveedor').AsString;
  //desProveedor( DataSet.fieldByName('empresa').AsString, Value );
end;

procedure TQLDestrioFrutaRF.qreproductoPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + '  ' +  DataSet.fieldByName('des_producto').AsString;
  //desProducto( DataSet.fieldByName('empresa').AsString, Value );
end;

procedure TQLDestrioFrutaRF.qreproveedor_ecPrint(sender: TObject;
  var Value: String);
begin
  Value:= Value + '  ' + DataSet.fieldByName('des_variedad').AsString;
  (*
  desVariedad( DataSet.fieldByName('empresa').AsString,
                                     DataSet.fieldByName('proveedor').AsString,
                                     DataSet.fieldByName('producto').AsString, Value );
  *)
end;

procedure TQLDestrioFrutaRF.qrg1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qrg1.Height:= 0;
end;

procedure TQLDestrioFrutaRF.qrg2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qrg2.Height:= 0;
end;

procedure TQLDestrioFrutaRF.qreTotalproductoPrint(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL ' + desProducto( DataSet.fieldByName('empresa').AsString, Value );
end;

procedure TQLDestrioFrutaRF.qreTotalProveedorPrint(sender: TObject;
  var Value: String);
begin
 Value:= 'TOTAL ' + desProveedor( DataSet.fieldByName('empresa').AsString, Value );
end;

end.
