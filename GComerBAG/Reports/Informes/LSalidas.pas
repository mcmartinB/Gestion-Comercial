unit LSalidas;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Dialogs, Db,
  DBTables;

type
  TQRLSalidas = class(TQuickRep)
    TitleBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRSysData1: TQRSysData;
    PsQRSysData2: TQRSysData;
    CentroAbajo: TQRLabel;
    qrgProducto: TQRGroup;
    PSQRDBTCat: TQRDBText;
    PsQRDBTCajas: TQRDBText;
    PsQRDBTKilos: TQRDBText;
    qrgCliente: TQRGroup;
    bndPieCliente: TQRBand;
    PsQRLabel7: TQRLabel;
    SummaryBand1: TQRBand;
    PsQRLabel6: TQRLabel;
    PsQRDBText2: TQRDBText;
    periodo: TQRLabel;
    PsQRDBText3: TQRDBText;
    LEnvase: TQRLabel;
    bndPieAlbaran: TQRBand;
    PsQRExpr1: TQRExpr;
    PsQRExpr2: TQRExpr;
    PsQRShape1: TQRShape;
    PsQRShape2: TQRShape;
    PsQRDBText4: TQRDBText;
    PsQRDBText1: TQRDBText;
    LSeparador: TQRLabel;
    CentroArriba: TQRLabel;
    lblNacional: TQRLabel;
    qrgSuministro: TQRGroup;
    bndTitulocab: TQRBand;
    qrlPsQRLabel2: TQRLabel;
    qrlPsQRLabel3: TQRLabel;
    qrlPsQRLabel8: TQRLabel;
    qrlPsQRLabel4: TQRLabel;
    qrlPsQRLabel5: TQRLabel;
    qrlPSLKilos: TQRLabel;
    bndPieProducto: TQRBand;
    qrl1: TQRLabel;
    qrx1: TQRExpr;
    qrx2: TQRExpr;
    qrx3: TQRExpr;
    qrx4: TQRExpr;
    qrx5: TQRExpr;
    qrx6: TQRExpr;
    BDesglose: TQRChildBand;
    qrs1: TQRShape;
    qreCodCliente: TQRDBText;
    qrlCliente: TQRLabel;
    qrgAlbaran: TQRGroup;
    bndPieSuministro: TQRBand;
    qrlSuministro: TQRLabel;
    qrxSuministro: TQRExpr;
    qrxKilosSuministros: TQRExpr;
    LDesglose: TQRLabel;
    MDesglose1: TQRMemo;
    MDesglose2: TQRMemo;
    bndcProducto: TQRChildBand;
    qreCodProducto: TQRDBText;
    qrlProducto: TQRLabel;
    qreUnidades: TQRDBText;
    qrlUnidades: TQRLabel;
    QRShape1: TQRShape;
    QRExpr1: TQRExpr;
    qrx7: TQRExpr;
    qrx8: TQRExpr;
    qrx9: TQRExpr;
    qrx10: TQRExpr;
    qrlNeto: TQRLabel;
    qreNeto1: TQRDBText;
    qrsNeto1: TQRShape;
    qrxNeto2: TQRExpr;
    qrxNeto3: TQRExpr;
    qrxNeto4: TQRExpr;
    qrxNeto5: TQRExpr;
    qrxNeto6: TQRExpr;

    //TITULO
    procedure TitleBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure periodoPrint(sender: TObject; var Value: string);
    //CABECERA GRUPO
    procedure qrlclientePrint(sender: TObject; var Value: string);
    //DETALLE
    procedure PsQRDBTKilosPrint(sender: TObject; var Value: string);
    //SUMARIO
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    //DESGLOSE
    procedure BDesgloseBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure LEnvasePrint(sender: TObject; var Value: string);
    procedure PsQRLabel7Print(sender: TObject; var Value: string);
    procedure PsQRLabel6Print(sender: TObject; var Value: string);
    procedure qrlProductoPrint(sender: TObject; var Value: String);
    procedure qrgSuministroBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrl1Print(sender: TObject; var Value: String);
    procedure qrgAlbaranBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrlSuministroPrint(sender: TObject; var Value: String);
    procedure bndPieSuministroBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrgProductoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndPieAlbaranBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);

  private
    categorias: TStringList;
    faltaCat: boolean;

  public
    bImprimido, bTotalesAlbaran: boolean;
    sCentroSalida, sCentroOrigen, sFechaIni, sFechaFin: string;

    constructor Create( AOwner: TComponent ); Override;
    destructor  Destroy; Override;

  end;

var
  QRLSalidas: TQRLSalidas;

implementation

uses UDMAuxDB, LFSalidas;

{$R *.DFM}
//                                REPORT


constructor TQRLSalidas.Create( AOwner: TComponent );
begin
  inherited;
  faltaCat := true;
  Categorias := TStringList.Create;
end;

destructor  TQRLSalidas.Destroy;
begin
  freeAndNil( Categorias );
  inherited;
end;


//                                TITULO

procedure TQRLSalidas.TitleBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  //le paso las descripciones  de los campos del titulo
  if ( sCentroOrigen <> '' ) and ( sCentroSalida <> '' ) then
  begin
    CentroArriba.Caption := 'ORIGEN: ' +sCentroOrigen;
    CentroAbajo.Caption := 'SALIDA: ' +sCentroSalida;
  end
  else
  begin
    CentroArriba.Caption := '';
    if ( scentroOrigen = '' ) and ( scentroSalida = '' ) then
    begin
      CentroAbajo.Caption := 'TODOS LOS CENTROS';
    end
    else
    begin
      if ( scentroOrigen = '' )  then
      begin
        CentroAbajo.Caption := 'SALIDA: ' +scentroSalida;
      end
      else
      begin
        CentroAbajo.Caption := 'ORIGEN: ' +scentroOrigen;
      end;
    end;
  end;
end;

procedure TQRLSalidas.periodoPrint(sender: TObject; var Value: string);
begin
        //Le paso el rango de fechas sobre las que va el informe
  Value := 'DEL ' + sFechaIni + ' AL ' + sFechaFin;
end;

//                           CABECERA DE GRUPO

procedure TQRLSalidas.qrlclientePrint(sender: TObject; var Value: string);
begin
  Value := desCliente(DataSet.FieldByName('cliente_sal_sc').AsString);
end;

procedure TQRLSalidas.qrlProductoPrint(sender: TObject; var Value: String);
begin
  if DataSet.FieldByName('producto_sl').AsString = '' then
    Value := 'TODOS LOS PRODUCTOS'
  else
    Value := desProducto( DataSet.FieldByName('empresa_sl').AsString,
                          DataSet.FieldByName('producto_sl').AsString);
end;

//                                 DETALLE

//ENVASES

procedure TQRLSalidas.LEnvasePrint(sender: TObject; var Value: string);
begin
  Value := desEnvaseP(DataSet.FieldByName('empresa_sl').AsString,
    DataSet.FieldByName('envase_sl').AsString, DataSet.FieldByName('producto_sl').AsString);
end;



//KILOS

procedure TQRLSalidas.PsQRDBTKilosPrint(sender: TObject; var Value: string);
var
  i: Integer;
  encontradoCat: boolean;
begin
  if faltaCat then
  begin
    if categorias.Count = 0 then
      categorias.Values[DataSet.FieldByName('categoria_sl').AsString] := Value
    else
    begin
      encontradoCat := false;
      for i := 0 to categorias.Count - 1 do
      begin
        if DataSet.FieldByName('categoria_sl').AsString = categorias.Names[i] then
        begin
          categorias.Values[DataSet.FieldByName('categoria_sl').AsString] :=
            FloatToStr(StrToFloat(Value) +
            StrTOFloat(categorias.Values[DataSet.FieldByName('categoria_sl').AsString]));
          encontradoCat := true;
          Break;
        end;
      end;
      if not encontradoCat then
        categorias.Values[DataSet.FieldByName('categoria_sl').AsString] := Value;
    end;
  end;

  value := formatFloat('#,##0.00', StrToFloat(value));
end;

//                                PIE DE GRUPO

procedure TQRLSalidas.PsQRLabel7Print(sender: TObject; var Value: string);
begin
  Value := ' TOTAL CLIENTE  ' + DataSet.FieldByName('cliente_sal_sc').AsString + ': ';
end;

procedure TQRLSalidas.qrl1Print(sender: TObject; var Value: String);
begin
  Value := ' TOTAL PRODUCTO  ' + DataSet.FieldByName('producto_sl').AsString + ': ';
end;

//                                SUMARIO

procedure TQRLSalidas.SummaryBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  faltaCat := false;
end;

//                                DESGLOSE

procedure TQRLSalidas.BDesgloseBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  i: integer;
begin
  if bImprimido then exit
  else bImprimido := true;

  for i := 0 to categorias.Count - 1 do
  begin
    //Habilito los memos que luego deshabilitare para que no haya problemas de impresion
    LDesglose.Enabled := true;
    MDesglose1.Enabled := True;
    MDesglose2.Enabled := true;

    MDesglose1.Lines.Add('Categoría ' + categorias.Names[i] + ':  ');
    MDesglose2.Lines.Add(FormatFloat('#,##0.00', StrToFloat(categorias.Values[categorias.Names[i]])) + ' kgs.');
    MDesglose1.Height := 1 + ((i + 1) * 16);
  end;
  MDesglose2.Height := MDesglose1.Height;
  BDesglose.Height := MDesglose1.Height + LDesglose.Height + 9;
end;

procedure TQRLSalidas.PsQRLabel6Print(sender: TObject; var Value: string);
begin
  Value := ' TOTAL LISTADO :';
end;

procedure TQRLSalidas.qrgSuministroBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qrgSuministro.Height:= 1;
end;

procedure TQRLSalidas.qrgAlbaranBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
   qrgAlbaran.Height:= 1;
end;

procedure TQRLSalidas.qrlSuministroPrint(sender: TObject;
  var Value: String);
begin
  Value := 'SUMINISTRO  ' + DataSet.FieldByName('dir_sum_sc').AsString + ': ';
end;

procedure TQRLSalidas.bndPieSuministroBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if DataSet.FieldByName('cliente_sal_sc').AsString <> 'MER' then
  begin
    bndPieSuministro.Height:= 0;
  end
  else
  begin
    bndPieSuministro.Height:= 21;
  end;
end;

procedure TQRLSalidas.qrgProductoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qrgProducto.Height:= 0;
end;

procedure TQRLSalidas.bndPieAlbaranBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if not bTotalesAlbaran then
    bndPieAlbaran.Height:= 0;
end;

end.
