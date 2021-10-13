unit ListProductoSinFacturarQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables, ListProductoSinFacturarDL;

type
  TQLListProductoSinFacturar = class(TQuickRep)
    bndTitulo: TQRBand;
    bndDetalle: TQRBand;
    bndCabeceraColumna: TQRBand;
    bndPiePagina: TQRBand;
    lblImpresoEl: TQRSysData;
    lblTitulo: TQRSysData;
    lblPaginaNum: TQRSysData;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRBandPieGrupo: TQRBand;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRGroup2: TQRGroup;
    QRDBText9: TQRDBText;
    QRDBText1: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRShape1: TQRShape;
    lblFecha: TQRLabel;
    QRLabel9: TQRLabel;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    procedure QRDBText1Print(sender: TObject; var Value: String);
    procedure QRDBText11Print(sender: TObject; var Value: String);

  private

  public

  end;

procedure LoadReport( APadre: TComponent );
procedure UnloadReport;
procedure ExecuteReport( APadre: TComponent; AParametros: RParametrosListProductoSinFacturar );

implementation

{$R *.DFM}

uses UDMAuxDB, CReportes, Dpreview, Dialogs;

var
  QLListProductoSinFacturar: TQLListProductoSinFacturar;
  iContadorUso: integer = 0;

procedure LoadReport( APadre: TComponent );
begin
  Inc( iContadorUso );
  if iContadorUso = 1 then
  begin
    try
      QLListProductoSinFacturar:= TQLListProductoSinFacturar.Create( APadre );
    except
      iContadorUso:= 0;
      raise;
    end;
  end;
  ListProductoSinFacturarDL.LoadModule( APadre );
end;

procedure UnloadReport;
begin
  if iContadorUso > 0  then
  begin
    Dec( iContadorUso );
    if iContadorUso = 0 then
    begin
      if QLListProductoSinFacturar <> nil then
        FreeAndNil( QLListProductoSinFacturar );
    end;
  end;
  ListProductoSinFacturarDL.UnloadModule;
end;

procedure ExecuteReport( APadre: TComponent; AParametros: RParametrosListProductoSinFacturar );
begin
  LoadReport( APadre );
  if ListProductoSinFacturarDL.OpenData( APadre, AParametros) <> 0 then
  begin
    QLListProductoSinFacturar.ReportTitle:= 'PRODUCTO SIN FACTURAR';
    QLListProductoSinFacturar.lblFecha.Caption:= 'Pendiente de facturar hasta el ' + DateToStr( AParametros.dFechaHasta );
    PonLogoGrupoBonnysa( QLListProductoSinFacturar, AParametros.sEmpresa );
    Previsualiza( QLListProductoSinFacturar );
  end
  else
  begin
    ShowMessage('Sin datos para mostrar para los parametros de selección introducidos.');
  end;
  UnloadReport;
end;


procedure TQLListProductoSinFacturar.QRDBText1Print(sender: TObject;
  var Value: String);
begin
  Value:= DesProducto( DataSet.FieldByName('empresa_sc').AsString, Value );
end;

procedure TQLListProductoSinFacturar.QRDBText11Print(sender: TObject;
  var Value: String);
begin
  Value:= 'TOTAL "' + Value + '"';
end;

end.
