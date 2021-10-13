unit ListEntregasSinAsociarQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables, ListEntregasSinAsociarDL;

type
  TQLListEntregasSinAsociar = class(TQuickRep)
    bndTitulo: TQRBand;
    bndPiePagina: TQRBand;
    lblImpresoEl: TQRSysData;
    lblTitulo: TQRSysData;
    lblPaginaNum: TQRSysData;
    bndCabeceraColumna: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRGroup1: TQRGroup;
    QRDBText4: TQRDBText;
    QRDBText6: TQRDBText;
    bndDetalle: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText5: TQRDBText;
    etqProducto: TQRLabel;
    etqRangoFechas: TQRLabel;
    codigo_ec: TQRDBText;
    QRLabel6: TQRLabel;
    almacen_ec: TQRDBText;
    procedure QRDBText6Print(sender: TObject; var Value: String);

  private
     sEmpresa: string;
  public

  end;

procedure LoadReport( APadre: TComponent );
procedure UnloadReport;
procedure ExecuteReport( APadre: TComponent; AParametros: RListEntregasSinAsociar );

implementation

{$R *.DFM}

uses UDMAuxDB, CReportes, Dpreview, Dialogs;

var
  QLListEntregasSinAsociar: TQLListEntregasSinAsociar;
  iContadorUso: integer = 0;

procedure LoadReport( APadre: TComponent );
begin
  Inc( iContadorUso );
  if iContadorUso = 1 then
  begin
    try
      QLListEntregasSinAsociar:= TQLListEntregasSinAsociar.Create( APadre );
    except
      iContadorUso:= 0;
      raise;
    end;
  end;
  ListEntregasSinAsociarDL.LoadModule( APadre );
end;

procedure UnloadReport;
begin
  if iContadorUso > 0  then
  begin
    Dec( iContadorUso );
    if iContadorUso = 0 then
    begin
      if QLListEntregasSinAsociar <> nil then
        FreeAndNil( QLListEntregasSinAsociar );
    end;
  end;
  ListEntregasSinAsociarDL.UnloadModule;
end;

procedure ExecuteReport( APadre: TComponent; AParametros: RListEntregasSinAsociar );
begin
  LoadReport( APadre );
  if ListEntregasSinAsociarDL.OpenData( APadre, AParametros) <> 0 then
  begin
    QLListEntregasSinAsociar.ReportTitle:= 'ENTREGAS SIN ASOCIAR';
    QLListEntregasSinAsociar.etqRangoFechas.Caption:= 'Del ' + DateToStr( AParametros.dFechaDesde ) +
      ' al ' + DateToStr( AParametros.dFechaHasta );
    if Trim( AParametros.sProducto ) <> '' then
    begin
      QLListEntregasSinAsociar.etqProducto.Caption:= AParametros.sProducto + ' - ' +
        desProducto( AParametros.sEmpresa, AParametros.sProducto );
    end
    else
    begin
      QLListEntregasSinAsociar.etqProducto.Caption:= '';
    end;
    QLListEntregasSinAsociar.sEmpresa := AParametros.sEmpresa;
    PonLogoGrupoBonnysa( QLListEntregasSinAsociar, AParametros.sEmpresa );
    Previsualiza( QLListEntregasSinAsociar );
  end
  else
  begin
    ShowMessage('Sin datos para mostrar para los parametros de selección introducidos.');
  end;
  UnloadReport;
end;


procedure TQLListEntregasSinAsociar.QRDBText6Print(sender: TObject;
  var Value: String);
begin
  Value:= desProveedorAlmacen( DataSet.FieldByName('empresa_ec').AsString,
                               DataSet.FieldByName('proveedor_ec').AsString, Value );
end;

end.
