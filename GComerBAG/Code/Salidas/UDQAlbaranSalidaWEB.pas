unit UDQAlbaranSalidaWEB;

interface

uses
  SysUtils, Classes, DB, DBTables, uSalidaUtils;

type
  TDQAlbaranSalidaWEB = class(TDataModule)
    QAlbaranC: TQuery;
    QDirAlbaran: TQuery;
    QTransporte: TQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sCentro, sCliente: String;
    iALbaran: integer;
    dFecha: TDateTime;

    function  GetFirmaFileName: string;
    function  DNITransporte(const AEmpresa, ATransporte: string): string;
  public
    { Public declarations }
    function PreAlbaran( const AEmpresa, ACentro: String;
                         const AALbaran: integer;
                         const AFecha: TDateTime;
                         const APedirFirma, AOriginal: boolean; GGN : TGGN;  const APrevisualizar: boolean = True  ) : boolean;
  end;

function PreAlbaran( const AOwner: TComponent;
                     const AEmpresa, ACentro: String;
                     const AALbaran: integer;
                     const AFecha: TDateTime;
                     const APedirFirma, AOriginal: boolean;   GGN : TGGN; const APrevisualizar: boolean = True ) : boolean;

implementation

{$R *.dfm}

uses
  UQRAlbaranSalidaWEB, UDMBaseDatos, CVAriables, Dialogs, UDMAuxDB, bTextUtils, UDMConfig,
  DPreview, bMath, SignatureForm, UCAlbaran;

var
  DQAlbaranSalidaWEB: TDQAlbaranSalidaWEB;
  QRAlbaranSalidaWEB: TQRAlbaranSalidaWEB;

{
function PreAlbaran( const AOwner: TComponent;
                     const AEmpresa, ACentro: String;
                     const AALbaran: integer;
                     const AFecha: TDateTime;
                     const APedirFirma, AOriginal: boolean; PlatanoGGC : TPlatanoGGC; const APrevisualizar: boolean = True  ): boolean;
}

function PreAlbaran( const AOwner: TComponent;
                     const AEmpresa, ACentro: String;
                     const AALbaran: integer;
                     const AFecha: TDateTime;
                     const APedirFirma, AOriginal: boolean;   GGN : TGGN; const APrevisualizar: boolean = True ) : boolean;
begin
  Result:= True;
  DQAlbaranSalidaWEB:= TDQAlbaranSalidaWEB.Create( AOwner );
  try
    DQAlbaranSalidaWEB.PreAlbaran( AEmpresa, ACentro, AALbaran, AFecha, APedirFirma, AOriginal, GGN , APrevisualizar );
  finally
    FreeAndNil( DQAlbaranSalidaWEB );
  end;
end;

procedure TDQAlbaranSalidaWEB.DataModuleCreate(Sender: TObject);
begin
  with QAlbaranC do
  begin
    SQL.Clear;
    SQL.Add('select * from frf_salidas_c');
    SQL.Add('where empresa_sc = :empresa');
    SQL.Add('and centro_salida_sc = :centro');
    SQL.Add('and fecha_sc = :fecha');
    SQL.Add('and n_albaran_sc = :albaran');
  end;

  with QTransporte do
  begin
    SQL.Clear;
    SQL.Add('select importe_g, tipo_iva_tg, general_il iva2, reducido_il iva1, super_il iva0');
    SQL.Add('from frf_gastos, frf_tipo_gastos, frf_impuestos, frf_impuestos_l');
    SQL.Add('where empresa_g = :empresa');
    SQL.Add('and centro_salida_g = :centro');
    SQL.Add('and fecha_g = :fecha');
    SQL.Add('and n_albaran_g = :albaran');
    SQL.Add('and tipo_tg = tipo_g');
    SQL.Add('and facturable_tg = ''S'' ');
    SQL.Add('and codigo_i = :tipoiva ');
    SQL.Add('and codigo_il = :tipoiva ');
    SQL.add('and fecha_g  between fecha_ini_il and case when fecha_fin_il is null then fecha_g else fecha_fin_il end ');
  end;
end;

function TDQAlbaranSalidaWEB.PreAlbaran(
                     const AEmpresa, ACentro: String;
                     const AALbaran: integer;
                     const AFecha: TDateTime;
                     const APedirFirma, AOriginal: boolean; GGN : TGGN;   const APrevisualizar: boolean = True  ): boolean;
var
  sAux, sMsg: string;
  SFileName: string;
  iCopias: integer;
begin
  Result:= False;

  sEmpresa:= AEmpresa;
  sCentro:= ACentro;
  iALbaran:= AALbaran;
  dFecha:= AFecha;

  with QAlbaranC do
  begin
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('albaran').AsInteger:= iALbaran;
    ParamByName('fecha').AsDateTime:= dFecha;
    Open;
  end;
  sCliente:= QAlbaranC.FieldByname('cliente_sal_sc').AsString;

  SFileName:= GetFirmaFileName;
  if APedirFirma then
  begin
    if sFileName = '' then
    begin
      ShowMessage('Falta inicializar la ruta para guardar las firmas.');
    end
    else
    begin
      if not SignatureForm.SignSave( self, sFilename, sMsg ) then
      begin
        ShowMessage( sMsg );
      end;
      //GetFirma( self, sFilename );
    end;
  end;

  try
    QRAlbaranSalidaWEB:= TQRAlbaranSalidaWEB.Create( self );
    QRAlbaranSalidaWEB.rGGN := GGN;
    QRAlbaranSalidaWEB.mmoObservaciones.Lines.Clear;
    QRAlbaranSalidaWEB.mmoObservaciones.Lines.Add(Trim(QAlbaranC.FieldByname('nota_sc').AsString));

    //Seleccion datos suministro/cliente
    with QDirAlbaran do
    begin
      begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT nombre_ds nombre, nif_ds nif , tipo_via_ds tipo_via, domicilio_ds domicilio, ');
        SQL.Add('        cod_postal_ds cod_postal, poblacion_ds poblacion, provincia_ds provincia, ');
        SQL.Add('        descripcion_p pais, moneda_c moneda');
        SQL.Add(' FROM frf_salidas_c , frf_clientes, frf_dir_sum, frf_paises ');
        SQL.Add(' WHERE   empresa_sc = :empresa ');
        SQL.Add(' and centro_salida_sc = :centro ');
        SQL.Add(' and n_albaran_sc = :albaran ');
        SQL.Add(' and fecha_sc = :fecha ');

        SQL.Add(' AND  cliente_c = :cliente ');

        SQL.Add(' AND  cliente_ds = :cliente ');
        SQL.Add(' AND  dir_sum_ds = :suministro ');

        SQL.Add(' AND  pais_p = pais_ds ');
        ParamByName('empresa').AsString := sEmpresa;
        ParamByName('centro').AsString:= sCentro;
        ParamByName('albaran').AsInteger:= iALbaran;
        ParamByName('fecha').AsDateTime:= dFecha;
        ParamByName('cliente').AsString := sCliente;
        ParamByName('suministro').AsString := QAlbaranC.FieldByname('dir_sum_sc').AsString;

        Open;
      end;

                  //Rellenamos datos
      with QRAlbaranSalidaWEB do
      begin

        qrmDireccion.Lines.Clear;
        qrmDireccion.Lines.Add( FieldByName('nombre').AsString );

        sAux:= Trim(FieldByName('nif').AsString);
        if sAux <> '' then
        begin
          qrmDireccion.Lines.Add( 'CIF: ' + sAux )
        end;

        sAux:= Trim( FieldByName('tipo_via').AsString  + ' ' +  FieldByName('domicilio').AsString );
        if sAux <> '' then
          qrmDireccion.Lines.Add( sAux );
        sAux:= Trim( FieldByName('poblacion').AsString );
        if sAux <> '' then
          qrmDireccion.Lines.Add( sAux );

        if FieldByName('provincia').AsString <> '' then
          sAux:= Trim( FieldByName('cod_postal').AsString + ' ' + FieldByName('provincia').AsString )
        else
          sAux:= Trim( FieldByName('cod_postal').AsString + ' ' + desProvincia(FieldByName('cod_postal').AsString) );
        if sAux <> '' then
          qrmDireccion.Lines.Add( sAux );

        sAux:= Trim( FieldByName('pais').AsString );
        if sAux <> '' then
          qrmDireccion.Lines.Add( sAux );
      end;
      Close;
    end;


    //Datos almacen
    (*ALBARAN*)
    if ( Copy( sEmpresa, 1, 1) = 'F' )  and ( sCliente <> 'ECI' ) then
    //if ( Copy( sEmpresa, 1, 1) = 'F' )  then
    begin
      QRAlbaranSalidaWEB.qrlNAlbaran.Caption := sEmpresa + sCentro + Rellena( IntToStr( iAlbaran ), 5, '0', taLeftJustify );
      QRAlbaranSalidaWEB.qrlNAlbaran.Alignment := taRightJustify;
      QRAlbaranSalidaWEB.qrlNAlbaran.Width:= 73;
      QRAlbaranSalidaWEB.qrlNAlbaran.Left:= 41;
      QRAlbaranSalidaWEB.qrlNAlbaran2.Caption := Coletilla( sEmpresa );
      QRAlbaranSalidaWEB.qrlNAlbaran2.Enabled := True;
    end
    else
    begin
      QRAlbaranSalidaWEB.qrlNAlbaran.Caption := IntToStr( iAlbaran );
      QRAlbaranSalidaWEB.qrlNAlbaran.Alignment := taCenter;
      QRAlbaranSalidaWEB.qrlNAlbaran.Width:= 87;
      QRAlbaranSalidaWEB.qrlNAlbaran.Left:= 41;
      QRAlbaranSalidaWEB.qrlNAlbaran2.Caption := '';
      QRAlbaranSalidaWEB.qrlNAlbaran2.Enabled := False;
    end;

    QRAlbaranSalidaWEB.LFecha.Caption := DateTimeToStr( dFecha );
    QRAlbaranSalidaWEB.LHora.Caption := QAlbaranC.FieldByname('hora_sc').AsString;
    QRAlbaranSalidaWEB.LPedido.Caption := QAlbaranC.FieldByname('n_pedido_sc').AsString;

    QRAlbaranSalidaWEB.LCentro.Caption := desCentro( sEmpresa, sCentro );
    if sCliente = 'MER' then
      QRAlbaranSalidaWEB.LTransporte.Caption := desTransporte( sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString) + DNITransporte(sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString)
    else
      QRAlbaranSalidaWEB.LTransporte.Caption := desTransporte( sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString);

        //Buscar cuerpo del formulario
    with DMBaseDatos.QListado do
    begin
      if Active then
      begin
        Cancel;
        Close;
      end;
      with SQL do
      begin
        Clear;
        Add(' SELECT estomate_p,producto_p,descripcion_p,descripcion2_p, envase_sl,');
        Add('     envase_e, descripcion_m, color_sl, calibre_sl,  ');
        Add('    unidad_precio_sl,precio_sl,porc_iva_sl, tipo_iva_sl, ');

        Add('    SUM(kilos_sl) as kilos_sl, ');
        Add('    SUM(cajas_sl) as cajas_sl, ');
        Add('    SUM((cajas_sl*unidades_caja_sl)) as unidades, ');
        Add('    SUM(importe_neto_sl) as importe_neto_sl, ');
        Add('    SUM(iva_sl) as iva_sl, ');
        Add('    SUM(importe_total_sl) as importe_total_sl ');

                  //INICIO
                  //Si la empresa es Maset desglosar tambien por categoria
        if (Trim(sEmpresa) = '037') or
          (Trim(sEmpresa) = '062') then
        begin
          Add(',categoria_sl ');
        end;
                  //Si la empresa es Maset desglosar tambien por categoria
                  //FIN
        Add(' FROM frf_salidas_l , frf_productos , frf_envases , frf_marcas  ');
        Add(' WHERE   (empresa_sl = :empresa) ');
        Add('    AND  (centro_salida_sl = :centro) ');
        Add('    AND  (n_albaran_sl = :albaran) ');
        Add('    AND  (fecha_sl = :fecha) ');
        Add('    AND  (producto_p = producto_sl) ');
        Add('    AND  (envase_e = envase_sl  and producto_e = producto_p ) '); //ENVASE
        Add('    AND  (codigo_m = marca_sl) '); //MARCA
        Add(' GROUP BY estomate_p, producto_p, descripcion_p, descripcion2_p, ' +
          '          envase_sl, envase_e, descripcion_m, ' +
          '          color_sl, calibre_sl, unidad_precio_sl, precio_sl, porc_iva_sl, tipo_iva_sl ');
                  //INICIO
                  //Si la empresa es Maset desglosar tambien por categoria
        if (Trim(sEmpresa) = '037') or
          (Trim(sEmpresa) = '062') then
        begin
          Add(',categoria_sl ');
        end;
                  //Si la empresa es Maset desglosar tambien por categoria
                  //FIN
        Add(' ORDER BY estomate_p,producto_p, envase_e, color_sl, ');
        Add(' calibre_sl, precio_sl, unidad_precio_sl ');
      end;
      ParamByName('empresa').AsString := sEmpresa;
      ParamByName('centro').AsString := sCentro;
      ParamByName('albaran').AsInteger := iAlbaran;
      ParamByName('fecha').AsDateTime := dFecha;
      try
        Open;
      except
        DMBaseDatos.QListado.Cancel;
        DMBaseDatos.QListado.Close;
        MessageDlg('Error : No se puede recuperar los datos del cliente.', mtWarning, [mbOK], 0);
        raise;
      end;
    end;

    with QTransporte do
    begin
      ParamByName('empresa').AsString:= sEmpresa;
      ParamByName('centro').AsString:= sCentro;
      ParamByName('albaran').AsInteger:= iALbaran;
      ParamByName('fecha').AsDateTime:= dFecha;
      ParamByName('tipoiva').AsString:= DMBaseDatos.QListado.FieldByName('tipo_iva_sl').AsString;
      Open;
      QRAlbaranSalidaWEB.rBaseTransporte:= FieldByName('importe_g').AsFloat;

      case FieldByName('tipo_iva_tg').AsInteger of
        0: QRAlbaranSalidaWEB.rTipoIvaTransporte:= FieldByName('iva0').AsFloat;
        1: QRAlbaranSalidaWEB.rTipoIvaTransporte:= FieldByName('iva1').AsFloat;
        2: QRAlbaranSalidaWEB.rTipoIvaTransporte:= FieldByName('iva2').AsFloat;
        else QRAlbaranSalidaWEB.rTipoIvaTransporte:= 0;
      end;
      QRAlbaranSalidaWEB.rIvaTransporte:= bRoundTo( ( QRAlbaranSalidaWEB.rBaseTransporte * QRAlbaranSalidaWEB.rTipoIvaTransporte )  / 100, 2 );
      Close;
    end;

    QRAlbaranSalidaWEB.Configurar(dFecha);
    QRAlbaranSalidaWEB.sCodCliente:= sCliente;
    QRAlbaranSalidaWEB.sCodEmpresa:= AEmpresa;
    iCopias:= NumeroCopias( sEmpresa, sCliente);
    if not AOriginal then
      iCopias:= iCopias - 1;

    QRAlbaranSalidaWEB.ReportTitle:= sCliente + 'A' + IntToStr( iALbaran );
    if APrevisualizar then
    begin
      result:= DPreview.Preview(QRAlbaranSalidaWEB, iCopias, False, True, ForzarEnvioAlbaran( sEmpresa, sCliente, iALbaran, dFecha ) );
    end
    else
    begin
      try
        QRAlbaranSalidaWEB.Print;
        result:= True;
      finally
        FreeAndNil( QRAlbaranSalidaWEB );
      end;
    end;

    DMBaseDatos.QListado.Cancel;
    DMBaseDatos.QListado.Close;

  except
    DMBaseDatos.QListado.Cancel;
    DMBaseDatos.QListado.Close;
    QRAlbaranSalidaWEB.Free;
  end;
end;

function TDQAlbaranSalidaWEB.GetFirmaFileName: string;
var
  sFilename: string;
  iAnyo, iMes, iDia: word;
begin

  result:= '';
  if gsDirFirmasGlobal <> '' then
  begin
    if DirectoryExists( gsDirFirmasGlobal ) then
      result:=  gsDirFirmasGlobal;
  end;
  if result = '' then
  begin
    if gsDirFirmasLocal <> '' then
    begin
      if DirectoryExists( gsDirFirmasLocal ) then
        result:=  gsDirFirmasLocal;
    end;
  end;

  if result <> '' then
  begin
    DecodeDate( dFecha, iAnyo, iMes, iDia );
    sFilename:= intToStr( iAnyo ) + sEmpresa + sCentro + sCliente + '-' + IntToStr( iAlbaran );
    result:= result + '\' + sFileName + '.jpg';
  end;
end;

function TDQAlbaranSalidaWEB.DNITransporte(const AEmpresa, ATransporte: string): string;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select cif_t from frf_transportistas ');
    SQL.Add(' where transporte_t = ' + QuotedStr(ATransporte));
    Open;
    if not IsEmpty then
    begin
      result := ' C.I.F.: ' + Fields[0].AsString;
    end
    else
    begin
      result := '';
    end;
    Close;
  end;
end;



end.
