unit ResumenSalidasProductoQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Dialogs, Db,
  DBTables;

type
  TQRLResumenSalidasProducto = class(TQuickRep)
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
    qrecliente_sal_sc: TQRDBText;
    qrl2: TQRLabel;
    qrl3: TQRLabel;
    qrl4: TQRLabel;
    qrl5: TQRLabel;
    qrl6: TQRLabel;
    qredir_sum_sc: TQRDBText;
    qrl7: TQRLabel;
    qrlPais: TQRLabel;

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
    procedure bndPieClienteBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndPieProductoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrgClienteBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndcProductoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrl5Print(sender: TObject; var Value: String);
    procedure qrecliente_sal_scPrint(sender: TObject; var Value: String);
    procedure qreproducto_slPrint(sender: TObject; var Value: String);
    procedure qrlPsQRLabel2Print(sender: TObject; var Value: String);
    procedure qrlPsQRLabel8Print(sender: TObject; var Value: String);
    procedure qrl4Print(sender: TObject; var Value: String);
    procedure PageFooterBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrl6Print(sender: TObject; var Value: String);
    procedure qrlPsQRLabel4Print(sender: TObject; var Value: String);
    procedure qredir_sum_scPrint(sender: TObject; var Value: String);
    procedure qrl7Print(sender: TObject; var Value: String);
    procedure qrlPaisPrint(sender: TObject; var Value: String);

  private
    categorias: TStringList;
    faltaCat: boolean;

  public
    bProducto, bAlbaran, bEnvase, bSuministro, bCategoria: boolean;
    bImprimido, bTotalesAlbaran: boolean;
    sCentroSalida, sCentroOrigen, sFechaIni, sFechaFin: string;

    constructor Create( AOwner: TComponent ); Override;
    destructor  Destroy; Override;

  end;

var
  QRLSalidas: TQRLResumenSalidasProducto;

implementation

uses UDMAuxDB, ResumenSalidasProductoFL;

{$R *.DFM}
//                                REPORT


constructor TQRLResumenSalidasProducto.Create( AOwner: TComponent );
begin
  inherited;
  faltaCat := true;
  Categorias := TStringList.Create;
  bAlbaran:= True;
  bEnvase:= True;
  bSuministro:= True;
end;

destructor  TQRLResumenSalidasProducto.Destroy;
begin
  freeAndNil( Categorias );
  inherited;
end;


//                                TITULO

procedure TQRLResumenSalidasProducto.TitleBand1BeforePrint(Sender: TQRCustomBand;
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

procedure TQRLResumenSalidasProducto.periodoPrint(sender: TObject; var Value: string);
begin
        //Le paso el rango de fechas sobre las que va el informe
  Value := 'DEL ' + sFechaIni + ' AL ' + sFechaFin;
end;

//                           CABECERA DE GRUPO

procedure TQRLResumenSalidasProducto.qrlclientePrint(sender: TObject; var Value: string);
begin
  Value := DataSet.FieldByName('des_cliente').AsString;
  //Value := desCliente(DataSet.FieldByName('empresa_sl').AsString,
    //DataSet.FieldByName('cliente_sal_sc').AsString);
end;

procedure TQRLResumenSalidasProducto.qrlProductoPrint(sender: TObject; var Value: String);
begin
  if DataSet.FieldByName('producto_sl').AsString = '' then
    Value := 'TODOS LOS PRODUCTOS'
  else
    Value := DataSet.FieldByName('des_producto').AsString;
end;


procedure TQRLResumenSalidasProducto.LEnvasePrint(sender: TObject; var Value: string);
begin
  Value := DataSet.FieldByName('des_envase').AsString;
  //Value := desEnvase(DataSet.FieldByName('empresa_sl').AsString,
    //DataSet.FieldByName('envase_sl').AsString);
end;



//KILOS

procedure TQRLResumenSalidasProducto.PsQRDBTKilosPrint(sender: TObject; var Value: string);
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
      if not encontradoCat then categorias.Values[DataSet.FieldByName('categoria_sl').AsString] := Value;
    end;
  end;

  value := formatFloat('#,##0.00', StrToFloat(value));
end;

//                                PIE DE GRUPO

procedure TQRLResumenSalidasProducto.PsQRLabel7Print(sender: TObject; var Value: string);
begin
  Value := ' TOTAL CLIENTE  ' + DataSet.FieldByName('cliente_sal_sc').AsString + ': ';
end;

procedure TQRLResumenSalidasProducto.qrl1Print(sender: TObject; var Value: String);
begin
  Value := ' TOTAL PRODUCTO  ' + DataSet.FieldByName('producto_sl').AsString + ': ';
end;

//                                SUMARIO

procedure TQRLResumenSalidasProducto.SummaryBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    PrintBand:= False;
  end;
  faltaCat := false;
end;

//                                DESGLOSE

procedure TQRLResumenSalidasProducto.BDesgloseBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  i: integer;
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) and bCategoria then
  begin
    if bImprimido then exit
    else bImprimido := true;

    for i := 0 to categorias.Count - 1 do
    begin
      //Habilito los memos que luego deshabilitare para que no haya problemas de impresion
      LDesglose.Enabled := true;
      MDesglose1.Enabled := True;
      MDesglose2.Enabled := true;

      MDesglose1.Lines.Add('Cat. ' + categorias.Names[i] + ':  ');
      MDesglose2.Lines.Add(FormatFloat('#,##0.00', StrToFloat(categorias.Values[categorias.Names[i]])) + ' kgs.');
      MDesglose1.Height := 1 + ((i + 1) * 16);
    end;
    MDesglose2.Height := MDesglose1.Height;
    BDesglose.Height := MDesglose1.Height + LDesglose.Height + 9;
  end
  else
  begin
    PrintBand:= False;
  end;
end;

procedure TQRLResumenSalidasProducto.PsQRLabel6Print(sender: TObject; var Value: string);
begin
  Value := ' TOTAL LISTADO :';
end;

procedure TQRLResumenSalidasProducto.qrgSuministroBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    PrintBand:= False;
  end
  else
  begin
    qrgSuministro.Height:= 1;
  end;
end;

procedure TQRLResumenSalidasProducto.qrgAlbaranBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    PrintBand:= False;
  end
  else
  begin
     qrgAlbaran.Height:= 1;
  end;
end;

procedure TQRLResumenSalidasProducto.qrlSuministroPrint(sender: TObject;
  var Value: String);
begin
  Value := 'SUMINISTRO  ' + DataSet.FieldByName('dir_sum_sc').AsString + ': ';
end;

procedure TQRLResumenSalidasProducto.bndPieSuministroBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if ( not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) ) and ( bSuministro ) then
  begin
    if DataSet.FieldByName('cliente_sal_sc').AsString <> 'MER' then
    begin
      bndPieSuministro.Height:= 0;
      qrxSuministro.Reset;
      qrxKilosSuministros.Reset;
    end
    else
    begin
      bndPieSuministro.Height:= 21;
    end;
  end
  else
  begin
    PrintBand:= False;
  end;

end;

procedure TQRLResumenSalidasProducto.qrgProductoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    PrintBand:= False;
  end
  else
  begin
    qrgProducto.Height:= 0;
  end;
end;

procedure TQRLResumenSalidasProducto.bndPieAlbaranBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    if not bTotalesAlbaran then
     bndPieAlbaran.Height:= 0;
  end
  else
  begin
    PrintBand:= False;
  end;
end;

procedure TQRLResumenSalidasProducto.bndPieClienteBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    PrintBand:= False;
  end;
end;

procedure TQRLResumenSalidasProducto.bndPieProductoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    PrintBand:= False;
  end;
end;

procedure TQRLResumenSalidasProducto.qrgClienteBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    PrintBand:= False;
  end;
end;

procedure TQRLResumenSalidasProducto.bndcProductoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    PrintBand:= False;
  end;
end;

procedure TQRLResumenSalidasProducto.qrl7Print(sender: TObject; var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value := DataSet.FieldByName('producto_sl').AsString;
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TQRLResumenSalidasProducto.qrl5Print(sender: TObject; var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    if DataSet.FieldByName('producto_sl').AsString = '' then
      Value := 'TODOS LOS PRODUCTOS'
    else
      Value := DataSet.FieldByName('des_producto').AsString;
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TQRLResumenSalidasProducto.qrecliente_sal_scPrint(sender: TObject;
  var Value: String);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value:= '';
  end;
end;

procedure TQRLResumenSalidasProducto.qreproducto_slPrint(sender: TObject;
  var Value: String);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value:= '';
  end;
end;

procedure TQRLResumenSalidasProducto.qrlPsQRLabel2Print(sender: TObject;
  var Value: String);
begin
  if not bAlbaran then
  begin
    Value:= '';
  end;
end;

procedure TQRLResumenSalidasProducto.qrlPsQRLabel8Print(sender: TObject;
  var Value: String);
begin
  if not bEnvase then
  begin
    Value:= '';
  end;
end;

procedure TQRLResumenSalidasProducto.qrl4Print(sender: TObject; var Value: String);
begin
  if not bSuministro then
  begin
    Value:= '';
  end;
end;

procedure TQRLResumenSalidasProducto.PageFooterBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    PrintBand:= False;
  end;
end;

procedure TQRLResumenSalidasProducto.qrl6Print(sender: TObject; var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value := DataSet.FieldByName('des_cliente').AsString;
    //Value := desCliente(DataSet.FieldByName('empresa_sl').AsString,
      //DataSet.FieldByName('cliente_sal_sc').AsString);
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TQRLResumenSalidasProducto.qrlPsQRLabel4Print(sender: TObject;
  var Value: String);
begin
  if not bCategoria then
  begin
    Value:= '';
  end;
end;

procedure TQRLResumenSalidasProducto.qredir_sum_scPrint(sender: TObject;
  var Value: String);
var
  sAux: string;
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) or not bAlbaran then
  begin
    sAux:= DataSet.FieldByName('des_suministro').AsString;
    //sAux := desSuministro( DataSet.FieldByName('empresa_sl').AsString,
      //                      DataSet.FieldByName('cliente_sal_sc').AsString, Value );
    if sAux = '' then
    begin
      sAux := DataSet.FieldByName('des_cliente').AsString;
      //sAux := desCliente( DataSet.FieldByName('empresa_sl').AsString,
        //                   Value );
    end;
    Value:= sAux;
  end
  else
  begin
    Value:= '';
  end;
end;

procedure TQRLResumenSalidasProducto.qrlPaisPrint(sender: TObject; var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value := DataSet.FieldByName('pais_sc').AsString;
  end
  else
  begin
    Value:= '';
  end;
end;

end.
