unit CartaPorteQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, CartaPorteDL;

type
  TQMCartaPorte = class(TQuickRep)
    DetailBand1: TQRBand;
    ChildBand1: TQRChildBand;
    ChildBand2: TQRChildBand;
    ChildBand3: TQRChildBand;
    ChildBand4: TQRChildBand;
    ChildBand5: TQRChildBand;
    ChildBand6: TQRChildBand;
    ChildBand7: TQRChildBand;
    ChildBand8: TQRChildBand;
    ChildBand9: TQRChildBand;
    ChildBand10: TQRChildBand;
    ChildBand11: TQRChildBand;
    ChildBand12: TQRChildBand;
    ChildBand13: TQRChildBand;
    ChildBand14: TQRChildBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    lblEmpresaCargadora: TQRLabel;
    lblEmpresaExpedidora: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    ChildBand15: TQRChildBand;
    ChildBand16: TQRChildBand;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRShape21: TQRShape;
    QRLabel12: TQRLabel;
    ChildBand18: TQRChildBand;
    ChildBand19: TQRChildBand;
    ChildBand20: TQRChildBand;
    QRLabel14: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel28: TQRLabel;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel32: TQRLabel;
    QRLabel33: TQRLabel;
    QRLabel34: TQRLabel;
    QRLabel35: TQRLabel;
    QRLabel13: TQRLabel;
    QRShape11: TQRShape;
    QRShape20: TQRShape;
    QRLabel36: TQRLabel;
    QRLabel37: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    empresa_e: TQRDBText;
    nif_e: TQRDBText;
    tipo_via_e: TQRDBText;
    poblacion_e: TQRDBText;
    cod_postal_e: TQRDBText;
    QRLabel38: TQRLabel;
    QRLabel39: TQRLabel;
    QRLabel40: TQRLabel;
    QRLabel41: TQRLabel;
    QRLabel42: TQRLabel;
    QRLabel43: TQRLabel;
    pais_e: TQRLabel;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    qrmProductos: TQRMemo;
    qrmEnvases: TQRMemo;
    qrmPesos: TQRMemo;
    qrmBultos: TQRMemo;
    qrmObservaciones: TQRMemo;
    QRImgFirma: TQRImage;
    QRDBText13: TQRDBText;
    QRDBText14: TQRDBText;
    QRDBText15: TQRDBText;
    empresa_e2: TQRDBText;
    nif_c: TQRDBText;
    direccion_c: TQRDBText;
    poblacion_c: TQRDBText;
    cod_postal_c: TQRDBText;
    pais_c: TQRLabel;
    qrecif_operador: TQRDBText;
    qrecif_transportista: TQRDBText;
    qrlbl1: TQRLabel;
    qrmPacto: TQRMemo;
    QRLabel5: TQRLabel;
    QRLabel15: TQRLabel;
    procedure QRDBText1Print(sender: TObject; var Value: String);
    procedure QRDBText2Print(sender: TObject; var Value: String);
    procedure tipo_via_ePrint(sender: TObject; var Value: String);
    procedure cod_postal_ePrint(sender: TObject; var Value: String);
    procedure QRLabel39Print(sender: TObject; var Value: String);
    procedure QRLabel40Print(sender: TObject; var Value: String);
    procedure QRLabel38Print(sender: TObject; var Value: String);
    procedure nif_ePrint(sender: TObject; var Value: String);
    procedure QRLabel41Print(sender: TObject; var Value: String);
    procedure QRLabel42Print(sender: TObject; var Value: String);
    procedure QRLabel43Print(sender: TObject; var Value: String);
    procedure ChildBand18BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand10BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure empresa_ePrint(sender: TObject; var Value: String);
    procedure direccion_cPrint(sender: TObject; var Value: String);
    procedure poblacion_cPrint(sender: TObject; var Value: String);
    procedure cod_postal_cPrint(sender: TObject; var Value: String);
    procedure qrecif_operadorPrint(sender: TObject; var Value: String);
    procedure poblacion_ePrint(sender: TObject; var Value: String);
    procedure pais_ePrint(sender: TObject; var Value: String);
    procedure ChildBand20BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand19BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    dmDatos: TDLCartaPorte;
  public
    sFirma: string;
    procedure CargaProductos;
  end;

  procedure Previsualizar( const AOwner: TComponent; const ADatos: TDLCartaPorte; const AFirma: String );

implementation

{$R *.DFM}

uses DPreview, UDMAuxDB;

procedure Previsualizar( const AOwner: TComponent; const ADatos: TDLCartaPorte; const AFirma: String );
var
  QMCartaPorte: TQMCartaPorte;
begin
  QMCartaPorte:= TQMCartaPorte.Create( AOwner );
  try
    QMCartaPorte.sFirma:= AFirma;
    QMCartaPorte.dmDatos:= ADatos;
    QMCartaPorte.CargaProductos;
    Previsualiza( QMCartaPorte );
  finally
    FreeAndNil( QMCartaPorte );
  end;
end;

procedure TQMCartaPorte.QRDBText1Print(sender: TObject; var Value: String);
begin
  (*
  If bDirFija then
  begin
    Value:= 'RIBADUMIA - PONTEVEDRA'
  end
  else
  *)
  begin
    Value:= desCentro( dmDatos.QAlbaranCab.FieldByName('empresa_sc').AsString, Value );
  end;
end;

procedure TQMCartaPorte.QRDBText2Print(sender: TObject; var Value: String);
begin
  Value:= desSuministro( dmDatos.QAlbaranCab.FieldByName('empresa_sc').AsString, DataSet.FieldByName('cliente_sal_sc').AsString, Value );
  if Value = '' then
    Value:= desCliente( DataSet.FieldByName('cliente_sal_sc').AsString )
end;

procedure TQMCartaPorte.nif_ePrint(sender: TObject; var Value: String);
begin
  if ( DataSet.FieldByName('empresa_sc').AsString = 'F21' ) and ( DataSet.FieldByName('centro_salida_sc').AsString = '4' ) then
  begin
    Value:= 'CIF PT507444612';
  end
  else
  begin
    Value := 'Nif: ' + Value;
  end;
end;

procedure TQMCartaPorte.tipo_via_ePrint(sender: TObject; var Value: String);
begin
  if ( DataSet.FieldByName('empresa_sc').AsString = 'F21' ) and ( DataSet.FieldByName('centro_salida_sc').AsString = '4' ) then
  begin
    Value:= 'QUINTA DAS PICAS - RUA DA AGRELA';
  end
  else
  begin
    if Value <> '' then
      Value:= Value + ' ' + dmDatos.QEmpresa.FieldByName('domicilio_e').AsString
    else
      Value:= dmDatos.QEmpresa.FieldByName('domicilio_e').AsString;
  end;
end;

procedure TQMCartaPorte.cod_postal_ePrint(sender: TObject; var Value: String);
begin
  if ( DataSet.FieldByName('empresa_sc').AsString = 'F21' ) and ( DataSet.FieldByName('centro_salida_sc').AsString = '4' ) then
  begin
    Value:= 'GUIMARAES';
  end
  else
  begin
    Value:= Value +  ' ' + desProvincia( Value );
  end;
end;

procedure TQMCartaPorte.QRLabel39Print(sender: TObject; var Value: String);
begin
  Value:= dmDatos.QCliente.FieldByName('nombre_c').AsString;
end;

procedure TQMCartaPorte.QRLabel38Print(sender: TObject; var Value: String);
begin
  Value:= 'Nif: ' + dmDatos.QCliente.FieldByName('nif_c').AsString;
end;

procedure TQMCartaPorte.QRLabel40Print(sender: TObject; var Value: String);
begin
  if dmDatos.QDirSum.IsEmpty then
    Value:= ''
  else
    Value:= dmDatos.QDirSum.FieldByName('nombre_ds').AsString;
end;

procedure TQMCartaPorte.QRLabel41Print(sender: TObject; var Value: String);
begin
  if dmDatos.QDirSum.IsEmpty then
  begin
    if dmDatos.QCliente.FieldByName('tipo_via_c').AsString <> '' then
    begin
      Value:= dmDatos.QCliente.FieldByName('tipo_via_c').AsString + ' ' +
              dmDatos.QCliente.FieldByName('domicilio_c').AsString;
    end
    else
    begin
      Value:= dmDatos.QCliente.FieldByName('domicilio_c').AsString;
    end;
  end
  else
  begin
    if dmDatos.QDirSum.FieldByName('tipo_via_ds').AsString <> '' then
    begin
      Value:= dmDatos.QDirSum.FieldByName('tipo_via_ds').AsString + ' ' +
              dmDatos.QDirSum.FieldByName('domicilio_ds').AsString;
    end
    else
    begin
      Value:= dmDatos.QDirSum.FieldByName('domicilio_ds').AsString;
    end;
  end;
end;

procedure TQMCartaPorte.QRLabel42Print(sender: TObject; var Value: String);
begin
  if dmDatos.QDirSum.IsEmpty then
  begin
    if dmDatos.QCliente.FieldByName('cod_postal_c').AsString <> '' then
    begin
      Value:= dmDatos.QCliente.FieldByName('cod_postal_c').AsString + ' ' +
              dmDatos.QCliente.FieldByName('poblacion_c').AsString;
    end
    else
    begin
      Value:= dmDatos.QCliente.FieldByName('poblacion_c').AsString;
    end;
  end
  else
  begin
    if dmDatos.QDirSum.FieldByName('cod_postal_ds').AsString <> '' then
    begin
      Value:= dmDatos.QDirSum.FieldByName('cod_postal_ds').AsString + ' ' +
              dmDatos.QDirSum.FieldByName('poblacion_ds').AsString;
    end
    else
    begin
      Value:= dmDatos.QDirSum.FieldByName('poblacion_ds').AsString;
    end;
  end;
end;

procedure TQMCartaPorte.QRLabel43Print(sender: TObject; var Value: String);
begin
  if dmDatos.QDirSum.IsEmpty then
    Value:= DesPais( dmDatos.QCliente.FieldByName('pais_c').AsString )
  else
    Value:= DesPais( dmDatos.QDirSum.FieldByName('pais_ds').AsString );
end;


procedure TQMCartaPorte.CargaProductos;
var
  sAux: string;
begin
  with dmDatos.QAlbaranLin do
  begin
    qrmProductos.Lines.Clear;
    qrmEnvases.Lines.Clear;
    qrmPesos.Lines.Clear;
    qrmBultos.Lines.Clear;
    while not EOF do
    begin
      sAux:= dmDatos.QAlbaranLin.FieldByName('producto').AsString;
      saux:= desProducto( dmDatos.QAlbaranCab.FieldByName('empresa_sc').AsString, sAux );
      qrmProductos.Lines.Add( sAux );

      sAux:= dmDatos.QAlbaranLin.FieldByName('envase').AsString;
      saux:= desEnvaseProducto( dmDatos.QAlbaranCab.FieldByName('empresa_sc').AsString, sAux,
                                dmDatos.QAlbaranLin.FieldByName('producto').AsString );
      qrmEnvases.Lines.Add( sAux );

      sAux:= FormatFloat( '#,##0.00', dmDatos.QAlbaranLin.FieldByName('kilos').AsFloat );
      qrmPesos.Lines.Add( sAux );

      sAux:= FormatFloat( '#,##0', dmDatos.QAlbaranLin.FieldByName('bultos').AsInteger );
      qrmBultos.Lines.Add( sAux );
      Next;
    end;
  end;
end;

procedure TQMCartaPorte.ChildBand18BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qrmObservaciones.Lines.Clear;
  qrmObservaciones.Lines.Add( dmDatos.QAlbaranCab.FieldByName('nota_sc').AsString );
end;

procedure TQMCartaPorte.ChildBand19BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QRLabel15.Caption := dmDatos.QAlbaranCab.FieldByName('empresa_sc').AsString + ' / ' +
                       dmDatos.QAlbaranCab.FieldByName('centro_salida_sc').AsString +  ' / ' +
                       dmDatos.QAlbaranCab.FieldByName('n_albaran_sc').AsString + ' / ' +
                       dmDatos.QAlbaranCab.FieldByName('fecha_sc').AsString;
end;

procedure TQMCartaPorte.ChildBand10BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  //Carga firma si la tiene
  If FileExists( sFirma ) then
  begin
    QRImgFirma.Enabled:= True;
    QRImgFirma.Stretch:= True;
    QRImgFirma.Picture.LoadFromFile( sFirma );
  end;
end;

procedure TQMCartaPorte.empresa_ePrint(sender: TObject; var Value: String);
begin
  if Copy( Value, 1, 1) = 'F' then
  begin
    if ( DataSet.FieldByName('empresa_sc').AsString = 'F21' ) and ( DataSet.FieldByName('centro_salida_sc').AsString = '4' ) then
    begin
      Value:= 'LILIANA PERESTRELO, LDA';
    end
    else
    begin
      Value:= 'BONNYSA AGROALIMENTARIA';
    end;
  end
  else
  begin
    Value:= TQRDBText( sender ).DataSet.FieldByName('nombre_e').AsString;
  end;
end;

procedure TQMCartaPorte.direccion_cPrint(sender: TObject;
  var Value: String);
begin
  (*
  if bDirFija then
  begin
    //Value:= 'Ctra. del Palmar a Mazarrón km. 10';
    Value:= 'Lois-Portaris s/n';
  end;
  *)
  if ( DataSet.FieldByName('empresa_sc').AsString = 'F21' ) and ( DataSet.FieldByName('centro_salida_sc').AsString = '4' ) then
  begin
    Value:= 'QUINTA DAS PICAS - RUA DA AGRELA';
  end;
end;

procedure TQMCartaPorte.poblacion_cPrint(sender: TObject;
  var Value: String);
begin
  (*
  if bDirFija then
  begin
    //Value:= 'Molino de la Vereda';
    Value:= 'Ribadumia';
  end;
  *)
  if ( DataSet.FieldByName('empresa_sc').AsString = 'F21' ) and ( DataSet.FieldByName('centro_salida_sc').AsString = '4' ) then
  begin
    Value:= '4805-449 SAO SALVADOR DE BRITEIROS';
  end;  
end;

procedure TQMCartaPorte.cod_postal_cPrint(sender: TObject;
  var Value: String);
begin
  (*
  if bDirFija then
  begin
    //Value:= '30833 Sangonera la Verde (Murcia)';
    Value:= '36635 Pontevedra';
  end
  else
  *)
  if ( DataSet.FieldByName('empresa_sc').AsString = 'F21' ) and ( DataSet.FieldByName('centro_salida_sc').AsString = '4' ) then
  begin
    Value:= 'GUIMARAES';
  end
  else
  begin
    Value:= Value +  ' ' + desProvincia( Value );
  end;
end;

procedure TQMCartaPorte.qrecif_operadorPrint(sender: TObject;
  var Value: String);
begin
  if value <> '' then
  begin
    Value:= 'Cif: ' + Value;
  end;
end;

procedure TQMCartaPorte.poblacion_ePrint(sender: TObject;
  var Value: String);
begin
  if ( DataSet.FieldByName('empresa_sc').AsString = 'F21' ) and ( DataSet.FieldByName('centro_salida_sc').AsString = '4' ) then
  begin
    Value:= '4805-449 SAO SALVADOR DE BRITEIROS';
  end;
end;

procedure TQMCartaPorte.pais_ePrint(sender: TObject; var Value: String);
begin
  if ( DataSet.FieldByName('empresa_sc').AsString = 'F21' ) and ( DataSet.FieldByName('centro_salida_sc').AsString = '4' ) then
  begin
    Value:= 'PORTUGAL';
  end
  else
  begin
    Value:= 'ESPAÑA';
  end;
end;

procedure TQMCartaPorte.ChildBand20BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
//var
  //sProvincia: string;
begin
  (*
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('select nombre_p from frf_provincias ');
    SQL.Add('where codigo_p = ');
    SQL.Add('( select cod_postal_c[1,2] ');
    SQL.Add('  from frf_centros ');
    SQL.Add('  where empresa_c = :empresa and centro_c = :centro ) ');
    ParamByName('empresa').AsString:= DataSet.FieldByName('empresa_sc').AsString;
    ParamByName('centro').AsString:= DataSet.FieldByName('centro_salida_sc').AsString;
    Open;
    sProvincia:= FieldByName('nombre_p').AsString;
    Close;
  end;
  if sProvincia <> '' then
   sProvincia:= UpperCase(Copy(sProvincia,1,1)) + LowerCase( Copy( sProvincia,2,Length(sProvincia)-1) )
  else
    sProvincia:= 'Alicante';
  *)
  (*
  //OLD Pacto
  qrmPacto.Lines.Clear;
  qrmPacto.Lines.Add('Este documento completa la información requerida en el DOCUMENTO DE CONTROL, segun la Orden de 2861/2012 de 5 de enero de 2013');
  qrmPacto.Lines.Add('que afecta a todo el transporte público de Mercancias por Carretera. Cada una de las partes intervinientes deben guardar, durante 1 año,');
  qrmPacto.Lines.Add('una copia de toda la documentación concerniente al servicio de transporte.');
  *)
  //NEw pacto

  qrmPacto.Lines.Clear;
  qrmPacto.Lines.Add('Pacto de Sumisión: Para cualquier controversia que pudiera derivarse de la ejecución del presente Contrato las partes, con renuncia a su fuero ');
  qrmPacto.Lines.Add('propio, se somenten de forma expresa a la competencia de a Junta Arbitral de Transportes de Alicante, sea cual sea la cuantía de dicha controversia.');

end;

end.
