unit LSalidasEnvases;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQRLSalidasEnvases = class(TQuickRep)
    TitleBand1: TQRBand;
    DetailBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    qrdbtxtenvase: TQRDBText;
    qrdbtxtdescripcion: TQRDBText;
    PsQRDBText3: TQRDBText;
    PsQRSysData1: TQRSysData;
    QRBCabeceraGrupo1: TQRGroup;
    QRBCabeceraGrupo2: TQRGroup;
    qrbndCliente: TQRBand;
    qrbndSuministro: TQRBand;
    SummaryBand1: TQRBand;
    PsQRExpr1: TQRExpr;
    PsQRExpr2: TQRExpr;
    PsQRExpr3: TQRExpr;
    PsQRLabel13: TQRLabel;
    PsQRLabel14: TQRLabel;
    lblPeriodo: TQRLabel;
    qrdbtxtalbaran: TQRDBText;
    qrdbtxtfecha: TQRDBText;
    QSalidasEnvases: TQuery;
    qrdbtxtenv_comer_producto_e: TQRDBText;
    qrdbtxtdescripcion_e: TQRDBText;
    bndcChildBand4: TQRChildBand;
    qrgrp1: TQRGroup;
    qrdbtxtdir_sum_sc: TQRDBText;
    qrdbtxtcliente_sal_sc: TQRDBText;
    bndcChildBand1: TQRChildBand;
    qrlblPsQRLabel6: TQRLabel;
    qrlblPsQRLabel3: TQRLabel;
    qrlblPsQRLabel2: TQRLabel;
    qrlblPsQRLabel5: TQRLabel;
    qrlblPsQRLabel4: TQRLabel;
    qrdbtxtcliente: TQRDBText;
    qrbndPieOperador: TQRBand;
    qrlbl1: TQRLabel;
    qrxpr1: TQRExpr;
    qrlbl2: TQRLabel;
    qrdbtxtoperador: TQRDBText;
    qrdbtxtcliente1: TQRDBText;
    qrdbtxtsuministro: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    procedure qrdbtxtdescripcion_ePrint(sender: TObject;
      var Value: String);
    procedure qrdbtxtcliente_sal_scPrint(sender: TObject; var Value: String);
    procedure qrdbtxtdir_sum_scPrint(sender: TObject; var Value: String);
    procedure qrlblPsQRLabel2Print(sender: TObject; var Value: String);
    procedure qrlblPsQRLabel6Print(sender: TObject; var Value: String);
    procedure qrdbtxtclientePrint(sender: TObject; var Value: String);
    procedure qrlbl2Print(sender: TObject; var Value: String);
    procedure PsQRLabel13Print(sender: TObject; var Value: String);
    procedure qrlbl1Print(sender: TObject; var Value: String);
    procedure qrdbtxtenv_comer_producto_ePrint(sender: TObject;
      var Value: String);
    procedure qrbndSuministroBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrdbtxtoperadorPrint(sender: TObject; var Value: String);
    procedure qrdbtxtcliente1Print(sender: TObject; var Value: String);
    procedure qrdbtxtsuministroPrint(sender: TObject; var Value: String);
    procedure qrdbtxtdescripcionPrint(sender: TObject; var Value: string);
  private


  public
    sEmpresa: string;
    bAlbaran, bEnvase: Boolean;

    destructor Destroy; override;
  end;

var
  QRLSalidasEnvases: TQRLSalidasEnvases;

implementation



uses LFSalidasEnvases, UDMAuxDB, bTextUtils;

{$R *.DFM}

destructor TQRLSalidasEnvases.Destroy;
begin
  QSalidasEnvases.Close;
  inherited;
end;

procedure TQRLSalidasEnvases.qrdbtxtdescripcionPrint(sender: TObject;
  var Value: string);
begin
  if  not bEnvase then
   Value:= ''
  else if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value:= '';
  end

end;

procedure TQRLSalidasEnvases.qrdbtxtdescripcion_ePrint(sender: TObject;
  var Value: String);
begin
  if ( Value <> '-1' ) and ( Value <> '-2' )then
    Value:= desEnvComerProducto( DataSet.fieldByName('operador').AsString, Value )
  else
    Value:= 'ENVASE COMERCIAL SIN ASIGNAR';
end;

procedure TQRLSalidasEnvases.qrdbtxtenv_comer_producto_ePrint(
  sender: TObject; var Value: String);
begin
  if ( Value = '-1' ) then
    Value:= 'CAJAS'
  else
  if ( Value = '-2' ) then
    Value:= 'PALETS'
  else
    Value:= Value;
end;

procedure TQRLSalidasEnvases.qrdbtxtcliente_sal_scPrint(sender: TObject;
  var Value: String);
begin
  if DataSet.fieldByName('tipo').AsString = 'S' then
    Value:= Value + ' ' + desCliente( Value )
  else
    Value:= Value + ' ' + desCentro( sEmpresa, Value );
end;

procedure TQRLSalidasEnvases.qrdbtxtdir_sum_scPrint(sender: TObject;
  var Value: String);
var
  sAux: string;
begin
  if DataSet.fieldByName('tipo').AsString = 'S' then
  begin
    sAux:= desSuministro( sEmpresa, DataSet.fieldByName('cliente').AsString, Value );
    if sAux = '' then
      sAux:= desCliente( Value );
    Value:= Value + ' ' + sAux;
  end
  else
    Value:= Value + ' ' + desCentro( sEmpresa, Value );
end;

procedure TQRLSalidasEnvases.qrlblPsQRLabel2Print(sender: TObject;
  var Value: String);
begin
  if not bEnvase then
   Value:= '';
end;

procedure TQRLSalidasEnvases.qrlblPsQRLabel6Print(sender: TObject;
  var Value: String);
begin
  if not bAlbaran then
   Value:= '';
end;

procedure TQRLSalidasEnvases.qrdbtxtclientePrint(sender: TObject;
  var Value: String);
begin
  if Value <> '-1'then
    Value:= Value + ' ' + desEnvComerOperador( Value )
  else
    Value:= 'OPERADOR SIN ASIGNAR';
end;

procedure TQRLSalidasEnvases.qrlbl2Print(sender: TObject;
  var Value: String);
begin
  if DataSet.fieldByName('tipo').AsString = 'S' then
    Value:= 'Total suministro ' +  DataSet.fieldByName('cliente').AsString + '/' + DataSet.fieldByName('suministro').AsString + ':'
  else
    Value:= 'Total centro destino ' +  DataSet.fieldByName('cliente').AsString + '/' + DataSet.fieldByName('suministro').AsString + ':';
end;

procedure TQRLSalidasEnvases.PsQRLabel13Print(sender: TObject;
  var Value: String);
begin
  if DataSet.fieldByName('tipo').AsString = 'S' then
    Value:= 'Total cliente ' +  DataSet.fieldByName('cliente').AsString + ':'
  else
    Value:= 'Total centro destino ' +  DataSet.fieldByName('cliente').AsString + ':'
end;

procedure TQRLSalidasEnvases.qrlbl1Print(sender: TObject;
  var Value: String);
begin
  Value:= 'Total operador ' +  DataSet.fieldByName('operador').AsString + ':';
end;

procedure TQRLSalidasEnvases.qrbndSuministroBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    PrintBand:= False;
  end;
end;

procedure TQRLSalidasEnvases.qrdbtxtoperadorPrint(sender: TObject;
  var Value: String);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value:= '';
  end
  else
  if Value <> '-1'then
    Value:= Value + ' ' + desEnvComerOperador( Value )
  else
    Value:= 'OPERADOR SIN ASIGNAR';
end;

procedure TQRLSalidasEnvases.qrdbtxtcliente1Print(sender: TObject;
  var Value: String);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value:= '';
  end
  else
  if DataSet.fieldByName('tipo').AsString = 'S' then
    Value:= Value + ' ' + desCliente( Value )
  else
    Value:= Value + ' ' + desCentro( sEmpresa, Value );  
end;

procedure TQRLSalidasEnvases.qrdbtxtsuministroPrint(sender: TObject;
  var Value: String);
var
  sAux: string;
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value:= '';
  end
  else
  if DataSet.fieldByName('tipo').AsString = 'S' then
  begin
    sAux:= desSuministro( sEmpresa, DataSet.fieldByName('cliente').AsString, Value );
    if sAux = '' then
      sAux:= desCliente( Value );
    Value:= Value + ' ' + sAux;
  end
  else
    Value:= Value + ' ' + desCentro( sEmpresa, Value );  
end;

end.
