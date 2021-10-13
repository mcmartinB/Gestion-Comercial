unit ControlIntrastatQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLControlIntrastat = class(TQuickRep)
    TitleBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblRango: TQRLabel;
    lblProducto: TQRLabel;
    bndColumnHeaderBand1: TQRBand;
    qrl9: TQRLabel;
    qrl10: TQRLabel;
    qrl1: TQRLabel;
    qrl2: TQRLabel;
    qrl3: TQRLabel;
    qrl4: TQRLabel;
    qrl5: TQRLabel;
    qrl6: TQRLabel;
    qrl7: TQRLabel;
    bndEntrega: TQRBand;
    qrepais_p: TQRDBText;
    qreproducto_el: TQRDBText;
    qrekilos_producto: TQRDBText;
    qrekilos_variedad: TQRDBText;
    qrepais_origen_pp: TQRDBText;
    qrevariedad_el: TQRDBText;
    qrekilos_entrega: TQRDBText;
    bnd1: TQRBand;
    qrsysdt1: TQRSysData;
    qretipo: TQRDBText;
    qre_ec: TQRDBText;
    qreproveedor_ec: TQRDBText;
    qrlTipo: TQRLabel;
    qrlCentro: TQRLabel;
    qrl11: TQRLabel;
    qregastos_terrestre: TQRDBText;
    qregastos_transporte: TQRDBText;
    qregastos_factura: TQRDBText;
    procedure qreproveedor_ecPrint(sender: TObject; var Value: String);
    procedure qrevariedad_elPrint(sender: TObject; var Value: String);
  private

  public

    procedure PreparaListado( const AEmpresa, AProducto, AProveedor: string;
                              const AFechaIni, AFechaFin: TDateTime );
  end;

function VerControlIntrastat( const AOwner: TComponent; const AEmpresa, AProducto, AProveedor: string;
                              const AFechaIni, AFechaFin: TDateTime;
                              const AAsimilada, AComunitaria, AImportacion, ANacional, AISP, ASinAsignar : Boolean;
                              const AFactura, AFlete, ATerrestre : Boolean): Boolean;

implementation

{$R *.DFM}

uses
  CReportes, ControlIntrastatDL, DPreview, UDMAuxDB, bMath;

var
  QLControlIntrastat: TQLControlIntrastat;


function VerControlIntrastat( const AOwner: TComponent; const AEmpresa, AProducto, AProveedor: string;
                              const AFechaIni, AFechaFin: TDateTime;
                              const AAsimilada, AComunitaria, AImportacion, ANacional, AISP, ASinAsignar : Boolean;
                              const AFactura, AFlete, ATerrestre : Boolean): Boolean;
begin
  try
    result:= ControlIntrastatDL.ObtenerDatos( AOwner,  AEmpresa, AProducto, AProveedor, AFechaIni, AFechaFin,
                                              AAsimilada, AComunitaria, AImportacion, ANacional, AISP, ASinAsignar,
                                              AFactura, AFlete, ATerrestre );

    if result then
    begin
      QLControlIntrastat:= TQLControlIntrastat.Create( AOwner );
      try
        QLControlIntrastat.PreparaListado( AEmpresa, AProducto, AProveedor, AFechaIni, AFechaFin );
        Previsualiza( QLControlIntrastat );
      finally
        FreeAndNil( QLControlIntrastat );
      end;
    end;
  finally
    ControlIntrastatDL.CerrarTablas;
  end;
end;

procedure TQLControlIntrastat.PreparaListado( const AEmpresa, AProducto, AProveedor: string;
                                               const AFechaIni, AFechaFin: TDateTime );
begin
  PonLogoGrupoBonnysa( self, AEmpresa );

  if AProducto <> '' then
    lblProducto.Caption:= AProducto + ' ' + desProducto( AEmpresa, AProducto )
  else
    lblProducto.Caption:= 'TODOS LOS PRODUCTOS';

  lblRango.Caption:= 'Del ' + DateToStr( AFechaIni ) + ' al ' + DateToStr( AFechaFin );

end;

procedure TQLControlIntrastat.qreproveedor_ecPrint(sender: TObject;
  var Value: String);
begin
  value:= value +  ' '  + desProveedor(DataSet.FieldByName('empresa_ec').AsString,Value)
end;

procedure TQLControlIntrastat.qrevariedad_elPrint(sender: TObject;
  var Value: String);
begin
  value:= value +  '- '  + desVariedad(DataSet.FieldByName('empresa_ec').AsString,DataSet.FieldByName('proveedor_ec').AsString,
                                      DataSet.FieldByName('producto_el').AsString, Value)
end;

end.

