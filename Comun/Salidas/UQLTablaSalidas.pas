unit UQLTablaSalidas;

interface      

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQLTablaSalidas = class(TQuickRep)
    bndDetalle: TQRBand;
    bndCab: TQRBand;
    qrdbtxtempresa: TQRDBText;
    qrdbanyo: TQRDBText;
    qrdbtxtfecha_salida: TQRDBText;
    qrdbtxtn_salida: TQRDBText;
    qrdbtxtcentro_salida: TQRDBText;
    qrdbtxtpais_cliente: TQRDBText;
    qrdbtxtcliente: TQRDBText;
    qrdbtxtreclamacion: TQRDBText;
    qrdbtxtsuministro: TQRDBText;
    qrdbtxtfacturado: TQRDBText;
    qrdbtxtpagamos_porte: TQRDBText;
    qrdbtxtoperador: TQRDBText;
    qrdbtxttransporista: TQRDBText;
    qrlMatricula: TQRDBText;
    qrdbtxtorigen: TQRDBText;
    qrdbtxtenvase: TQRDBText;
    qrdbtxtproducto: TQRDBText;
    qrdbtxtpalet: TQRDBText;
    qrdbtxtcategoria: TQRDBText;
    qrdbtxtpalets: TQRDBText;
    qrdbtxtcalibre: TQRDBText;
    qrdbtxtcajas: TQRDBText;
    qrdbtxtunidades: TQRDBText;
    qrdbtxtimporte: TQRDBText;
    qrdbtxtkilos: TQRDBText;
    qrlEnvase: TQRDBText;
    qrlTransportista: TQRDBText;
    qrlSuministros: TQRDBText;
    qrbndTitleBand1: TQRBand;
    qrlblParametros: TQRLabel;
    qrlbl1: TQRLabel;
    qrlblEmpresa: TQRLabel;
    qrlblanyo: TQRLabel;
    qrlblFecha: TQRLabel;
    qrlblAlbaran: TQRLabel;
    qrlblcentrosalida: TQRLabel;
    qrlblpais: TQRLabel;
    qrlblcliente: TQRLabel;
    qrlblsuministro: TQRLabel;
    qrlbldessuministro: TQRLabel;
    qrlblreclamacion: TQRLabel;
    qrlblportes: TQRLabel;
    qrlbloperador: TQRLabel;
    qrlbltransporista: TQRLabel;
    qrlbldesqrlbltransporista: TQRLabel;
    qrlblMatricula: TQRLabel;
    qrlblcentroorigen: TQRLabel;
    qrlbldesenvase: TQRLabel;
    qrlblpalet: TQRLabel;
    qrlblcategoria: TQRLabel;
    qrlblcalibre: TQRLabel;
    qrlblfacturado: TQRLabel;
    qrlblproducto: TQRLabel;
    qrlblenvase: TQRLabel;
    qrlblpalets: TQRLabel;
    qrlblcajas: TQRLabel;
    qrlblunidades: TQRLabel;
    qrlblkilos: TQRLabel;
    qrlblimporte: TQRLabel;
    qrlComercial: TQRLabel;
    qrlblComecial: TQRDBText;
    qrdbtxtComercial: TQRDBText;
    qrlProductoDes: TQRDBText;
    qrlbldesProducto: TQRLabel;
    qrlblMes: TQRLabel;
    qrlblSem: TQRLabel;
    qrdbmes: TQRDBText;
    qrdbsem: TQRDBText;
    qrlClientes: TQRLabel;
    qrlDesCliente: TQRDBText;
    qrblFechaDescarga: TQRLabel;
    qrdbtxtfecha_descarga: TQRDBText;
    procedure qrdbtxtfecha_salidaPrint(sender: TObject; var Value: String);
    procedure qrlEnvasePrint(sender: TObject; var Value: String);
    procedure qrlTransportistaPrint(sender: TObject;
      var Value: String);
    procedure qrlSuministrosPrint(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure qrlbl1Print(sender: TObject; var Value: String);
    procedure qrdbtxtproducto1Print(sender: TObject; var Value: String);
    procedure qrdbtxtComercialPrint(sender: TObject; var Value: String);
    procedure qrlProductoDesPrint(sender: TObject; var Value: string);
    procedure qrlDesClientePrint(sender: TObject; var Value: string);
    procedure AjustarGrupo2;
    procedure qrdbtxtfecha_descargaPrint(sender: TObject; var Value: string);
  private
    procedure Ajustar( ACampo: TQRLabel; const AVisible: Boolean; const ALeft: Integer = -1 );
  public

  end;

  procedure VerListado( const AOwner: TComponent );

var
  bCentroSalida:boolean;
  bCentroOrigen:boolean;
  bPais:boolean;
  bCliente:boolean;
  bSuministro:boolean;
  bTransportista:boolean;
  bOperador:boolean;
  bMatricula:boolean;
  bProducto:boolean;
  bEnvase:boolean;
  bComercial:boolean;
  bPalet:boolean;
  bCategoria:boolean;
  bCalibre:boolean;
  bpalets:boolean;
  bCajas:boolean;
  bUnidades:boolean;
  bKilos:boolean;
  bImporte:boolean;
  bComunitario:boolean;
  bPortesPagados:boolean;
  bFacturado:boolean;
  bReclamacion:boolean;
  iGrupo: integer;
  iGrupo2: integer;
  sParametros: string;

implementation

{$R *.DFM}

uses
  UFLTablaSalidas,CReportes,DPreview, UDMAuxDB, UDMMaster;

procedure VerListado( const AOwner: TComponent  );
var
  QLTablaSalidas: TQLTablaSalidas;
begin
  QLTablaSalidas:= TQLTablaSalidas.create( AOwner );
  try
    case iGrupo of
      4: begin
//        QLTablaSalidas.qrlblGrupo.Caption:= 'Año';
//        QLTablaSalidas.qrdbtxtanyo_semana.DataField:= 'anyo';
          QLTablaSalidas.qrlblAnyo.Enabled := true;
          QLTablaSalidas.qrlblMes.Enabled := false;
          QLTablaSalidas.qrlblSem.Enabled := false;
          QLTablaSalidas.qrdbanyo.Enabled := True;
          QLTablaSalidas.qrdbmes.Enabled := false;
          QLTablaSalidas.qrdbsem.Enabled := false;

      end;
      3: begin
//        QLTablaSalidas.qrlblGrupo.Caption:= 'Año/Mes';
//        QLTablaSalidas.qrdbtxtanyo_semana.DataField:= 'anyo_mes';
          QLTablaSalidas.qrlblAnyo.Enabled := true;
          QLTablaSalidas.qrlblMes.Enabled := true;
          QLTablaSalidas.qrlblSem.Enabled := false;
          QLTablaSalidas.qrdbanyo.Enabled := True;
          QLTablaSalidas.qrdbmes.Enabled := true;
          QLTablaSalidas.qrdbsem.Enabled := false;
      end;
      2,1,0: begin
//        QLTablaSalidas.qrlblGrupo.Caption:= 'Año/Semana';
//        QLTablaSalidas.qrdbtxtanyo_semana.DataField:= 'anyo_semana';
          QLTablaSalidas.qrlblAnyo.Enabled := true;
          QLTablaSalidas.qrlblMes.Enabled := false;
          QLTablaSalidas.qrlblSem.Enabled := true;
          QLTablaSalidas.qrdbanyo.Enabled := True;
          QLTablaSalidas.qrdbmes.Enabled := false;
          QLTablaSalidas.qrdbsem.Enabled := true;
      end;
      else
      begin
//        QLTablaSalidas.qrlblGrupo.Caption:= '';
//        QLTablaSalidas.qrdbtxtanyo_semana.DataField:= '';
          QLTablaSalidas.qrlblAnyo.Enabled := false;
          QLTablaSalidas.qrlblMes.Enabled := false;
          QLTablaSalidas.qrlblSem.Enabled := false;
          QLTablaSalidas.qrdbanyo.Enabled := false;
          QLTablaSalidas.qrdbmes.Enabled := false;
          QLTablaSalidas.qrdbsem.Enabled := false;
      end;
    end;
    Preview( QLTablaSalidas );
  except
    FreeAndNil( QLTablaSalidas );
    raise;
  end;
end;

procedure TQLTablaSalidas.qrdbtxtfecha_descargaPrint(sender: TObject;
  var Value: string);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    if Value<> '' then
      Value:= FormatDateTime('dd/mm/yyyy', DataSet.fieldByName('fecha_descarga').AsDateTime);
  end
  else
  begin
    if Value<> '' then
      Value:= FormatDateTime('dd/mm/yy', DataSet.fieldByName('fecha_descarga').AsDateTime);
  end;
end;

procedure TQLTablaSalidas.qrdbtxtfecha_salidaPrint(sender: TObject;
  var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    if Value<> '' then
      Value:= FormatDateTime('dd/mm/yyyy', DataSet.fieldByName('fecha_salida').AsDateTime);
  end
  else
  begin
    if Value<> '' then
      Value:= FormatDateTime('dd/mm/yy', DataSet.fieldByName('fecha_salida').AsDateTime);
  end;
end;

procedure TQLTablaSalidas.qrlEnvasePrint(sender: TObject;
  var Value: String);
begin
  Value:= desEnvaseCli( DataSet.fieldByName('empresa').AsString, DataSet.fieldByName('envase').AsString, DataSet.fieldByName('cliente').AsString);
end;

procedure TQLTablaSalidas.qrlProductoDesPrint(sender: TObject;
  var Value: string);
begin
  if iGrupo2 = 0 then                 //Producto
    Value := desProducto( DataSet.FieldByname('empresa').AsString, DataSet.FieldByname('producto').AsString )
  else if iGrupo2 = 1 then            //Linea Producto
    Value := desLineaProducto( DataSet.FieldByname('producto').AsString );
end;

procedure TQLTablaSalidas.qrlTransportistaPrint(sender: TObject;
  var Value: String);
begin
  Value:= desTransporte( DataSet.fieldByName('empresa').AsString,DataSet.fieldByName('transporista').AsString);
end;

procedure TQLTablaSalidas.qrlSuministrosPrint(sender: TObject;
  var Value: String);
begin
  if bCliente and not bSuministro then
  begin
    Value:= desCliente( Value);
  end
  else
  begin
    if DataSet.fieldByName('cliente').AsString = DataSet.fieldByName('suministro').AsString then
      Value:= desCliente( DataSet.fieldByName('cliente').AsString)
    else
      Value:= desSuministro( DataSet.fieldByName('empresa').AsString,DataSet.fieldByName('cliente').AsString,Value);
  end;
end;

procedure TQLTablaSalidas.Ajustar( ACampo: TQRLabel; const AVisible: Boolean; const ALeft: Integer = -1 );
begin
  ACampo.Enabled:= AVisible;
  if AVisible then
  begin
    ACampo.AutoSize:= ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
    if not ACampo.AutoSize then
    begin
      if ALeft <> -1 then
        ACampo.Left:= ALeft;
      ACampo.Width:= ACampo.Tag;
    end;
  end;
end;

procedure TQLTablaSalidas.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin

  AjustarGrupo2;

  Ajustar( TQRLabel( qrdbtxtempresa ), true );
  Ajustar( TQRLabel( qrlblEmpresa ), true );

  Ajustar( TQRLabel( qrdbtxtpalets ), bPalets, 862 );
  Ajustar( TQRLabel( qrlblpalets ), bPalets, 862 );
  Ajustar( TQRLabel( qrdbtxtcajas ), bCajas, 889 );
  Ajustar( TQRLabel( qrlblcajas ), bCajas, 889 );
  Ajustar( TQRLabel( qrdbtxtunidades ), bUnidades, 921 );
  Ajustar( TQRLabel( qrlblunidades ), bUnidades, 921 );
  Ajustar( TQRLabel( qrdbtxtkilos ), bKilos, 954 );
  Ajustar( TQRLabel( qrlblkilos ), bKilos, 954 );
  Ajustar( TQRLabel( qrdbtxtimporte ), bImporte, 1000 );
  Ajustar( TQRLabel( qrlblimporte ), bImporte, 1000 );

//  Ajustar( TQRLabel( qrdbtxtanyo_semana ), iGrupo<5 );
//  Ajustar( TQRLabel( qrlblGrupo ), iGrupo<5 );
  //Año
  Ajustar( TQRLabel( qrlblanyo ), iGrupo<5 );
  Ajustar( TQRLabel( qrdbanyo ), iGrupo<5 );
  //MES
  Ajustar( TQRLabel( qrlblMes ), iGrupo=3);
  Ajustar( TQRLabel( qrdbmes ), iGrupo=3);
  //SEMANA
  Ajustar( TQRLabel( qrlblSem ), iGrupo<3 );
  Ajustar( TQRLabel( qrdbsem ), iGrupo<3 );

  Ajustar( TQRLabel( qrdbtxtfecha_salida ), iGrupo<2 );
  Ajustar( TQRLabel( qrlblFecha ), iGrupo<2 );
  Ajustar( TQRLabel( qrdbtxtn_salida ), iGrupo<1 );
  Ajustar( TQRLabel( qrlblAlbaran ), iGrupo<1 );

  Ajustar( TQRLabel( qrblFechaDescarga ), iGrupo=0 );
  Ajustar( TQRLabel( qrdbtxtfecha_descarga ), iGrupo=0 );

  Ajustar( TQRLabel( qrdbtxtcentro_salida ), bCentroSalida );
  Ajustar( TQRLabel( qrlblcentrosalida ), bCentroSalida );
  Ajustar( TQRLabel( qrdbtxtorigen ), bCentroOrigen );
  Ajustar( TQRLabel( qrlblcentroorigen ), bCentroOrigen );
  Ajustar( TQRLabel( qrdbtxtpais_cliente ), bPais );
  Ajustar( TQRLabel( qrlblpais ), bPais );
  Ajustar( TQRLabel( qrdbtxtcliente ), bCliente );
  Ajustar( TQRLabel( qrlblcliente ), bCliente );
  Ajustar( TQRLabel( qrlClientes ), bCliente );
  Ajustar( TQRLabel( qrlDesCliente ), bCliente );
  Ajustar( TQRLabel( qrdbtxtsuministro ), bSuministro );
  Ajustar( TQRLabel( qrlblsuministro ), bSuministro );
  Ajustar( TQRLabel( qrlbldessuministro ), bSuministro or bCliente );
  Ajustar( TQRLabel( qrlSuministros ), bSuministro or bCliente );
  Ajustar( TQRLabel( qrdbtxttransporista ), bTransportista );
  Ajustar( TQRLabel( qrlbltransporista ), bTransportista );
  Ajustar( TQRLabel( qrlbldesqrlbltransporista ), bTransportista );
  Ajustar( TQRLabel( qrlTransportista ), bTransportista );
  Ajustar( TQRLabel( qrdbtxtoperador ), bOperador );
  Ajustar( TQRLabel( qrlbloperador ), bOperador );
  Ajustar( TQRLabel( qrlblMatricula ), bMatricula );
  Ajustar( TQRLabel( qrlMatricula ), bMatricula );
  Ajustar( TQRLabel( qrlComercial ), bComercial );
  Ajustar( TQRLabel( qrlblComecial ), bComercial );
  Ajustar( TQRLabel( qrdbtxtComercial ), bComercial );
  Ajustar( TQRLabel( qrdbtxtproducto ), bProducto );
  Ajustar( TQRLabel( qrlblproducto ), bProducto );
  Ajustar( TQRLabel( qrlProductoDes ), (bProducto) and (iGrupo2<>2));
  Ajustar( TQRLabel( qrlbldesproducto ), (bProducto) and (iGrupo2<>2));
  Ajustar( TQRLabel( qrdbtxtenvase ), bEnvase );
  Ajustar( TQRLabel( qrlblenvase ), bEnvase );
  Ajustar( TQRLabel( qrlEnvase ), bEnvase );
  Ajustar( TQRLabel( qrlbldesenvase ), bEnvase );

  Ajustar( TQRLabel( qrdbtxtpalet ), bPalet );
  Ajustar( TQRLabel( qrlblpalet ), bPalet );
  Ajustar( TQRLabel( qrdbtxtcategoria ), bCategoria );
  Ajustar( TQRLabel( qrlblcategoria ), bCategoria );
  Ajustar( TQRLabel( qrdbtxtcalibre ), bCalibre );
  Ajustar( TQRLabel( qrlblcalibre ), bCalibre );
  Ajustar( TQRLabel( qrdbtxtpagamos_porte ), bPortesPagados );
  Ajustar( TQRLabel( qrlblportes ), bPortesPagados );
  Ajustar( TQRLabel( qrdbtxtfacturado ), bFacturado );
  Ajustar( TQRLabel( qrlblfacturado ), bFacturado );
  Ajustar( TQRLabel( qrdbtxtreclamacion ), bReclamacion );
  Ajustar( TQRLabel( qrlblreclamacion ), bReclamacion );

  qrlblParametros.Caption:= sParametros;

  if bCliente and not bSuministro then
  begin
    qrlbldessuministro.Caption:= 'Des.Cliente';
    qrlSuministros.DataField:= 'cliente';
  end;
end;

procedure TQLTablaSalidas.qrlbl1Print(sender: TObject; var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= '';
end;

procedure TQLTablaSalidas.qrlDesClientePrint(sender: TObject;
  var Value: string);
begin
  Value:= desCliente( Value);
end;

procedure TQLTablaSalidas.qrdbtxtproducto1Print(sender: TObject;
  var Value: String);
begin
  //Descripcion producto
//  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
//    Value:= desProducto( DataSet.FieldByname('empresa').AsString, DataSet.FieldByname('producto').AsString )
//  else
//    Value:= '';
end;

procedure TQLTablaSalidas.AjustarGrupo2;
begin
  if iGrupo2 = 0 then
  begin
    qrlblproducto.Caption := 'Producto';
    qrlblDesproducto.Caption := 'Des Producto';
  end
  else if iGrupo2 = 1 then
  begin
    qrlblproducto.Caption := 'Linea Producto';
    qrlblDesproducto.Caption := 'Des Linea Producto';
  end
  else if iGrupo2 = 2 then
  begin
    qrlblproducto.Caption := 'Agru. Comercial';
  end;


  if iGrupo2 = 2 then     //Agrupacion Comercial
  begin
    qrlbldesProducto.Enabled := false;
    qrlProductoDes.Enabled := false;
    qrlblProducto.Tag := 74;
    qrdbtxtProducto.Tag := 74;
  end
  else
  begin
    qrlbldesProducto.Enabled := true;
    qrlProductoDes.Enabled := true;
    qrlblProducto.Tag := 25;
    qrdbtxtProducto.Tag := 25;
  end;
end;

procedure TQLTablaSalidas.qrdbtxtComercialPrint(sender: TObject;
  var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
    Value:= desComercial( DataSet.FieldByname('vendedor').AsString )
  else
    Value:= '';
end;

end.
