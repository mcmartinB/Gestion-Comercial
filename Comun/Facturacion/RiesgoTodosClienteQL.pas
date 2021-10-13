unit RiesgoTodosClienteQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls,
  FacturacionCB;

type
  TQLRiesgoTodosCliente = class(TQuickRep)
    PageHeaderBand1: TQRBand;
    bndDetalle: TQRBand;
    etqImpresoTitulo: TQRSysData;
    PageFooterBand1: TQRBand;
    QRSysData3: TQRSysData;
    ColumnHeaderBand1: TQRBand;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    cliente: TQRDBText;
    qtxtdescripcion: TQRDBText;
    QRLabel1: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRLabel2: TQRLabel;
    SummaryBand1: TQRBand;
    qrxTotalFacturado: TQRExpr;
    QRLabel3: TQRLabel;
    etqPaisTitulo: TQRLabel;
    qrlTitulo: TQRLabel;
    qrlDesde: TQRLabel;
    qrx1: TQRExpr;
    qrx2: TQRExpr;
    qrxPais: TQRExpr;
    qrxSeguro: TQRExpr;
    qrlSeguro: TQRLabel;
    qrlPais: TQRLabel;
    qrxTotalPendiente: TQRExpr;
    qrlbl1: TQRLabel;
    procedure QRExpr2Print(sender: TObject; var Value: String);
    procedure QRExpr1Print(sender: TObject; var Value: String);
    procedure qrlbl1Print(sender: TObject; var Value: String);
  private
    sEmpresa: String;
    //rExceso: Real;
    //bExceso: Boolean;
  public
    constructor Create( AOwner: TComponent ); Override;
    destructor Destroy; Override;
  end;

procedure LoadReport( APadre: TComponent );
procedure UnloadReport;
procedure ExecuteReport( APadre: TComponent; AParametros: RClienteQL; const AVer: boolean );

implementation

{$R *.DFM}

uses Dialogs, RiesgoClienteDL, UDMAuxDB, DPreview, CReportes;

var
  QLRiesgoTodosCliente: TQLRiesgoTodosCliente;
  iContadorUso: integer = 0;

procedure LoadReport( APadre: TComponent );
begin
  Inc( iContadorUso );
  if iContadorUso = 1 then
  begin
    try
      QLRiesgoTodosCliente:= TQLRiesgoTodosCliente.Create( APadre );
    except
      iContadorUso:= 0;
      raise;
    end;
  end;
  RiesgoClienteDL.LoadModule( APadre );
end;

procedure UnloadReport;
begin
  if iContadorUso > 0  then
  begin
    Dec( iContadorUso );
    if iContadorUso = 0 then
    begin
      if QLRiesgoTodosCliente <> nil then
        FreeAndNil( QLRiesgoTodosCliente );
    end;
  end;
  RiesgoClienteDL.UnloadModule;
end;

procedure ExecuteReport( APadre: TComponent; AParametros: RClienteQL; const  AVer: boolean );
begin
  LoadReport( APadre );
  if RiesgoClienteDL.OpenData( APadre, AParametros, AVer) <> 0 then
  begin
     QLRiesgoTodosCliente.sEmpresa:= AParametros.sEmpresa;
     QLRiesgoTodosCliente.qrlTitulo.Caption:= 'RIESGO CLIENTE (' + DateToStr( Now ) + ')';
     QLRiesgoTodosCliente.ReportTitle:= 'RIESGO CLIENTE ' + FormatDateTime( 'yyyymmdd', Now );
     if AParametros.sPais <> '' then
       QLRiesgoTodosCliente.etqPaisTitulo.Caption:= AParametros.sPais + ' ' + DesPais( AParametros.sPais )
     else
       QLRiesgoTodosCliente.etqPaisTitulo.Caption:= '';
     QLRiesgoTodosCliente.qrlDesde.Caption:= 'Desde el ' + DateToStr( AParametros.dFechaDesde );
     PonLogoGrupoBonnysa( QLRiesgoTodosCliente, AParametros.sEmpresa );
     Previsualiza( QLRiesgoTodosCliente );
  end
  else
  begin
    ShowMessage('Sin datos para mostrar para los parametros de selección introducidos.');
  end;
  UnloadReport;
end;

constructor TQLRiesgoTodosCliente.Create( AOwner: TComponent );
begin
  inherited;
  //BEGIN CODE

  //END CODE
end;

destructor TQLRiesgoTodosCliente.Destroy;
begin
  //BEGIN CODE

  //END CODE
  inherited;
end;

procedure TQLRiesgoTodosCliente.QRExpr2Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('max_riesgo').AsString = '-1' then
    Value:= '-';
end;

procedure TQLRiesgoTodosCliente.QRExpr1Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('max_riesgo').AsString = '-1' then
    Value:= '-';
end;

procedure TQLRiesgoTodosCliente.qrlbl1Print(sender: TObject;
  var Value: String);
begin
  if not ( Exporting and ( Pos( 'EXCEL', UpperCase( ExportFilter.Name ) ) > 0 ) ) then
    Value:= '';
end;

end.
