unit UTransitosListDesglose_QR;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TTransitosListDesglose_QR = class(TQuickRep)
    CabPagina: TQRBand;
    PiePagina: TQRBand;
    Detalle: TQRBand;
    etqReferencia: TQRDBText;
    etqFecha: TQRDBText;
    etqKilos: TQRDBText;
    lblRango: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRSysData3: TQRSysData;
    CabGrupo: TQRGroup;
    PieGrupo: TQRBand;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    lblProducto: TQRLabel;
    lblCentro: TQRLabel;
    QRSubDetail1: TQRSubDetail;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    bndPieGrupo: TQRBand;
    QRDBText1: TQRDBText;
    QRLabel13: TQRLabel;
    QRSubDetail2: TQRSubDetail;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    QRDBText14: TQRDBText;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRShape1: TQRShape;
    QRLabel15: TQRLabel;
    QRLabel2: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRSubDetail3: TQRSubDetail;
    QRDBText15: TQRDBText;
    QRDBText16: TQRDBText;
    QRDBText17: TQRDBText;
    QRDBText18: TQRDBText;
    QRDBText19: TQRDBText;
    QRLabel3: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel14: TQRLabel;
    QRDBText20: TQRDBText;
    QRDBText21: TQRDBText;
    QRDBText22: TQRDBText;
    QRDBText23: TQRDBText;
    QRDBText24: TQRDBText;
    QRDBText25: TQRDBText;
    QRLabel19: TQRLabel;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRDBText1Print(sender: TObject; var Value: String);
    procedure QRDBText7Print(sender: TObject; var Value: String);
    procedure QRDBText13Print(sender: TObject; var Value: String);
    procedure DetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRLabel17Print(sender: TObject; var Value: String);
    procedure QRLabel18Print(sender: TObject; var Value: String);
    procedure QRSubDetail2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRSubDetail1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRSubDetail3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRDBText21Print(sender: TObject; var Value: String);
    procedure QRDBText19Print(sender: TObject; var Value: String);
  private
    rKilosGrupo, rKilosTotales: Real;
    iTipoDesglose: integer;

    procedure ConfigurarDataSets(const ATipo, ACategorias: integer);
  public

  end;

procedure Previsualizar(const AEmpresa, ACEntro, AProducto: String; const AInicio, AFin: TDateTime;
  const ATipoListado, ACategorias, ADesglose: Integer; const ATitulo: string);

implementation

uses UTransitosList_MD, CReportes, DPreview, UDMAuxDB, Dialogs;

{$R *.DFM}

procedure Previsualizar(const AEmpresa, ACEntro, AProducto: String; const AInicio, AFin: TDateTime;
  const ATipoListado, ACategorias, ADesglose: Integer; const ATitulo: string);
var
  TransitosListDesglose_QR: TTransitosListDesglose_QR;
begin
  TransitosListDesglose_QR := TTransitosListDesglose_QR.Create(nil);
  try
    TransitosListDesglose_QR.lblProducto.Caption := AProducto + ' ' + desProducto(AEmpresa, AProducto);
    TransitosListDesglose_QR.lblCentro.Caption := ACentro + ' ' + desCentro(AEmpresa, ACentro);
    TransitosListDesglose_QR.lblRango.Caption := 'Del ' + DateToStr( AInicio ) + ' al ' + DateToStr( AFin );
    TransitosListDesglose_QR.ReportTitle := ATitulo;
    TransitosListDesglose_QR.iTipoDesglose:= ADesglose;
    PonLogoGrupoBonnysa(TransitosListDesglose_QR, AEmpresa);

    TransitosListDesglose_QR.ConfigurarDataSets(ATipoListado, ACategorias);
    if TransitosListDesglose_QR.DataSet.IsEmpty then
    begin
      ShowMessage('Listado sin datos para los parametros de busqueda introducidos.');
      FreeANdNil(TransitosListDesglose_QR);
      Exit;
    end;
    Preview(TransitosListDesglose_QR);
  except
    FreeANdNil(TransitosListDesglose_QR);
    raise;
  end;
end;

procedure TTransitosListDesglose_QR.ConfigurarDataSets(const ATipo, ACategorias: integer);
begin
  case ATipo of
    0: begin
        DataSet.Filter := '';
        DataSet.Filtered := False;
      end;
    1: begin
        DataSet.Filter := 'kilos = vendidos';
        DataSet.Filtered := True;
      end;
    2: begin
        DataSet.Filter := 'kilos <> vendidos';
        DataSet.Filtered := True;
      end;
  end;
  case ACategorias of
    0: begin
         QRSubDetail1.DataSet.Filter := '( ( categoria_sl = ''1'' ) or ( categoria_sl = ''2'' ) or ( categoria_sl = ''3'' ) ) ';
         QRSubDetail1.DataSet.Filtered:= True;
         QRSubDetail2.DataSet.Filter := '( ( categoria = ''1'' ) or ( categoria = ''2'' ) or ( categoria = ''3'' ) ) ';
         QRSubDetail2.DataSet.Filtered:= True;
         QRSubDetail3.DataSet.Filter := '( ( categoria = ''1'' ) or ( categoria = ''2'' ) or ( categoria = ''3'' ) ) ';
         QRSubDetail3.DataSet.Filtered:= True;
      end;
    1: begin
         QRSubDetail1.DataSet.Filter := '';
         QRSubDetail1.DataSet.Filtered:= False;
         QRSubDetail2.DataSet.Filter := '';
         QRSubDetail2.DataSet.Filtered:= False;
         QRSubDetail3.DataSet.Filter := '';
         QRSubDetail3.DataSet.Filtered:= False;
      end;
  end;
end;

procedure TTransitosListDesglose_QR.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  CabGrupo.Height := 0;
  rKilosTotales:= 0;
end;

procedure TTransitosListDesglose_QR.QRDBText1Print(sender: TObject;
  var Value: String);
begin
  Value:= DesCliente( Value );
end;

procedure TTransitosListDesglose_QR.DetalleBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  rKilosGrupo:= 0;
end;

procedure TTransitosListDesglose_QR.QRDBText7Print(sender: TObject;
  var Value: String);
begin
  rKilosGrupo:= rKilosGrupo + QRSubDetail1.DataSet.fieldByName('kilos_sl').AsFloat;
  rKilosTotales:= rKilosTotales + QRSubDetail1.DataSet.fieldByName('kilos_sl').AsFloat;
end;

procedure TTransitosListDesglose_QR.QRDBText13Print(sender: TObject;
  var Value: String);
begin
  rKilosGrupo:= rKilosGrupo + QRSubDetail2.DataSet.fieldByName('kilos').AsFloat;
  rKilosTotales:= rKilosTotales + QRSubDetail2.DataSet.fieldByName('kilos').AsFloat;
end;

procedure TTransitosListDesglose_QR.QRLabel17Print(sender: TObject;
  var Value: String);
begin
  Value:= FormatFloat( '#,##0.00', rKilosGrupo );
end;

procedure TTransitosListDesglose_QR.QRLabel18Print(sender: TObject;
  var Value: String);
begin
  Value:= FormatFloat( '#,##0.00', rKilosTotales );
end;

procedure TTransitosListDesglose_QR.QRSubDetail1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if QRSubDetail1.DataSet.IsEmpty then
    QRSubDetail1.Height:= 0
  else
    QRSubDetail1.Height:= 15;
end;

procedure TTransitosListDesglose_QR.QRSubDetail2BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if QRSubDetail2.DataSet.IsEmpty  or ( iTipoDesglose = 1 ) then
    QRSubDetail2.Height:= 0
  else
    QRSubDetail2.Height:= 15;
end;

procedure TTransitosListDesglose_QR.QRSubDetail3BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if QRSubDetail3.DataSet.IsEmpty or ( iTipoDesglose = 2 ) then
    QRSubDetail3.Height:= 0
  else
    QRSubDetail3.Height:= 15;
end;

procedure TTransitosListDesglose_QR.QRDBText21Print(sender: TObject;
  var Value: String);
begin
  Value:= DesCentro( DataSet.FieldByName('empresa').AsString, Value );
end;

procedure TTransitosListDesglose_QR.QRDBText19Print(sender: TObject;
  var Value: String);
begin
  rKilosGrupo:= rKilosGrupo + QRSubDetail3.DataSet.fieldByName('kilos').AsFloat;
  rKilosTotales:= rKilosTotales + QRSubDetail3.DataSet.fieldByName('kilos').AsFloat;
end;

end.
