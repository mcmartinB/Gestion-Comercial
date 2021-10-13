unit IntrastatEntradaQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLIntrastatEntrada = class(TQuickRep)
    TitleBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    ColumnHeaderBand1: TQRBand;
    QRLabel1: TQRLabel;
    bndEntrega: TQRBand;
    codigo_ec: TQRDBText;
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
    qrl1: TQRLabel;
    qrl2: TQRLabel;
    qrl3: TQRLabel;
    qrl4: TQRLabel;
    qrl5: TQRLabel;
    qrl6: TQRLabel;
    qrl7: TQRLabel;
    qrekilos_producto: TQRDBText;
    qrekilos_variedad: TQRDBText;
    qrepais_origen_pp: TQRDBText;
    qrevariedad_el: TQRDBText;
    qrekilos_entrega: TQRDBText;
    qrlTipo: TQRLabel;
    qretipo: TQRDBText;
    qregastos_terrestre: TQRDBText;
    qregastos_transporte: TQRDBText;
    qregastos_factura: TQRDBText;
    procedure qreproveedor_ecPrint(sender: TObject; var Value: String);
    procedure qrevariedad_elPrint(sender: TObject; var Value: String);
  private

  public

    procedure PreparaListado( const AEmpresa, AProducto: string;
                              const AFechaIni, AFechaFin: TDateTime );
  end;

function VerIntrastatEntrada( const AOwner: TComponent; const AEmpresa, AProducto: string;
                              const AFechaIni, AFechaFin: TDateTime): Boolean;

implementation

{$R *.DFM}

uses
  CReportes, IntrastatEntradaDL, DPreview, UDMAuxDB, bMath;

var
  QLIntrastatEntrada: TQLIntrastatEntrada;


function VerIntrastatEntrada( const AOwner: TComponent; const AEmpresa, AProducto: string;
                              const AFechaIni, AFechaFin: TDateTime): Boolean;
begin
  try
    result:= IntrastatEntradaDL.ObtenerDatos( AOwner,  AEmpresa, AProducto, AFechaIni, AFechaFin );
    if result then
    begin
      QLIntrastatEntrada:= TQLIntrastatEntrada.Create( AOwner );
      try
        QLIntrastatEntrada.PreparaListado( AEmpresa, AProducto, AFechaIni, AFechaFin );
        Previsualiza( QLIntrastatEntrada );
      finally
        FreeAndNil( QLIntrastatEntrada );
      end;
    end;
  finally
    IntrastatEntradaDL.CerrarTablas;
  end;
end;

procedure TQLIntrastatEntrada.PreparaListado( const AEmpresa, AProducto: string;
                                               const AFechaIni, AFechaFin: TDateTime );
begin
  PonLogoGrupoBonnysa( self, AEmpresa );

  if AProducto <> '' then
    lblProducto.Caption:= AProducto + ' ' + desProducto( AEmpresa, AProducto )
  else
    lblProducto.Caption:= 'TODOS LOS PRODUCTOS';

  lblRango.Caption:= 'Del ' + DateToStr( AFechaIni ) + ' al ' + DateToStr( AFechaFin );

end;

procedure TQLIntrastatEntrada.qreproveedor_ecPrint(sender: TObject;
  var Value: String);
begin
  value:= value +  ' '  + desProveedor(DataSet.FieldByName('empresa_ec').AsString,Value)
end;

procedure TQLIntrastatEntrada.qrevariedad_elPrint(sender: TObject;
  var Value: String);
begin
  value:= value +  '- '  + desVariedad(DataSet.FieldByName('empresa_ec').AsString,DataSet.FieldByName('proveedor_ec').AsString,
                                      DataSet.FieldByName('producto_el').AsString, Value)
end;

end.
