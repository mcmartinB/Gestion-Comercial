unit ConfirmaRecepcionQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQLConfirmaRecepcion = class(TQuickRep)
    TitleBand1: TQRBand;
    lblTitulo: TQRLabel;
    PsQRSysData1: TQRSysData;
    lblCliente: TQRLabel;
    PageFooterBand1: TQRBand;
    bndDetalle: TQRBand;
    codigo: TQRDBText;
    descripcion: TQRDBText;
    unidad_factura: TQRDBText;
    cantidad: TQRDBText;
    QRSysData1: TQRSysData;
    lblRangoFechas: TQRLabel;
    bndTituloPedido: TQRGroup;
    QRLabel3: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel9: TQRLabel;
    bndPedido: TQRChildBand;
    bndTituloDetalle: TQRChildBand;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    albaran: TQRDBText;
    pedido: TQRDBText;
    fecha: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    cajas: TQRDBText;
    unidades: TQRDBText;
    kilos: TQRDBText;
    QRLabel5: TQRLabel;
    bndPieGrupo: TQRBand;
    dir_sum_sc: TQRDBText;
    QRLabel6: TQRLabel;
    procedure cantidadPrint(sender: TObject; var Value: String);
    procedure dir_sum_scPrint(sender: TObject; var Value: String);
  private
    sEmpresa, sCliente: string;

  public
    procedure PreparaListado( const AEmpresa, ACliente, APedido: string;
                              const AAlbaran: Integer;
                              const AFechaIni, AFechaFin: TDateTime );
  end;

  function VerListadoConfirmaRecepcion( const AOwner: TComponent;
                            const AEmpresa, ACliente, APedido: string;
                            const AAlbaran: Integer;
                            const AFechaIni, AFechaFin: TDateTime ): Boolean;

implementation

{$R *.DFM}

uses
  CReportes, ConfirmaRecepcionDL, DPreview, UDMAuxDB;

var
  QLConfirmaRecepcion: TQLConfirmaRecepcion;
  DLConfirmaRecepcion: TDLConfirmaRecepcion;

procedure VerListadoConfirmaRecepcionEx( const AOwner: TComponent;
                            const AEmpresa, ACliente, APedido: string;
                            const AAlbaran: Integer;
                            const AFechaIni, AFechaFin: TDateTime );
begin
  QLConfirmaRecepcion:= TQLConfirmaRecepcion.Create( AOwner );
  try
    QLConfirmaRecepcion.PreparaListado( AEmpresa, ACliente, APedido, AAlbaran, AFechaIni, AFechaFin );
    Previsualiza( QLConfirmaRecepcion );
  finally
    FreeAndNil( QLConfirmaRecepcion );
  end;
end;

function VerListadoConfirmaRecepcion( const AOwner: TComponent;
                            const AEmpresa, ACliente, APedido: string;
                            const AAlbaran: Integer;
                            const AFechaIni, AFechaFin: TDateTime ): Boolean;
begin
  DLConfirmaRecepcion:= TDLConfirmaRecepcion.Create( AOwner );
  try
    result:= DLConfirmaRecepcion.DatosQueryServido( AEmpresa, ACliente, APedido, AAlbaran, AFechaIni, AFechaFin );
    if result then
    begin
      VerListadoConfirmaRecepcionEx( AOwner, AEmpresa, ACliente, APedido, AAlbaran, AFechaIni, AFechaFin );
    end;
  finally
    FreeAndNil( DLConfirmaRecepcion );
  end;
end;

procedure TQLConfirmaRecepcion.PreparaListado( const AEmpresa, ACliente, APedido: string;
                              const AAlbaran: Integer;
                              const AFechaIni, AFechaFin: TDateTime );
begin
  sEmpresa:= AEmpresa;
  sCliente:= ACliente;

  PonLogoGrupoBonnysa( self, AEmpresa );
  lblCliente.Caption:= ACliente + ' ' + DesCliente( ACliente );
  if AFechaIni = AFechaFin then
  begin
    lblRangoFechas.Caption:= 'Fecha ' + DateToStr(AFechaIni);
  end
  else
  begin
    lblRangoFechas.Caption:= 'Fecha del ' + DateToStr(AFechaIni) +
                             ' al ' + DateToStr(AFechaFin);
  end;
end;

procedure TQLConfirmaRecepcion.cantidadPrint(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('unidad_factura').AsString = 'U' then
  begin
    Value:= FormatFloat( '#,##0', DataSet.FieldByName('unidades').AsInteger );
  end
  else
  if DataSet.FieldByName('unidad_factura').AsString = 'C' then
  begin
    Value:= FormatFloat( '#,##0', DataSet.FieldByName('cajas').AsInteger );
  end
  else
  begin
    Value:= FormatFloat( '#,##0.##', DataSet.FieldByName('kilos').AsFloat );
  end;
end;

procedure TQLConfirmaRecepcion.dir_sum_scPrint(sender: TObject;
  var Value: String);
begin
  Value:= DataSet.FieldByName('dir_sum_sc').AsString + ' ' +
          desSuministro( sEmpresa, sCliente, DataSet.FieldByName('dir_sum_sc').AsString );
end;

end.
