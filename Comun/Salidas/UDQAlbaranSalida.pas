unit UDQAlbaranSalida;

interface

uses
  SysUtils, Classes, DB, DBTables, uSalidaUtils;

type
  TDQAlbaranSalida = class(TDataModule)
    QAlbaranC: TQuery;
    qryDatosCliente: TQuery;
    qryAux: TQuery;
    qryAlbaranLin: TQuery;
  private
    { Private declarations }
    sEmpresa, sCentro, sCliente, sSuministro, sMoneda, sDireccionCompleta: String;
    sRazon, sNif, sReceptor, sDireccion, sPoblacion, sCodPais, sPais: String;
    bValorarAlbaran: Boolean;
    iALbaran: integer;
    dFecha: TDateTime;
    SFileName: string;
    rGGN : TGGN;


    function  GetFirmaFileName: string;
    procedure PutObservaciones( var ATexto: TStringList );
    procedure PutPaletsMercadona(var APaletsMercadona: TStrings);
    procedure PutPalets(var APalets: TStrings);
    procedure PutLogifruit(var ALogifruit: TStrings);
    function  DNITransporte(const AEmpresa, ATransporte: string): string;
    function  Dir2Transporte(const AEmpresa, ATransporte: string): string;
    function  Dir1Transporte(const AEmpresa, ATransporte: string): string;

    procedure DatosCliente;
    procedure LineasAlbaran;

    function SinValorar( const AOriginal: Boolean; GGN : TGGN; const APrevisualizar: boolean = True ): Boolean;
    function Valorado( const AOriginal: Boolean; GGN : TGGN; const APrevisualizar: boolean = True ): Boolean;
    function Generico( const AOriginal: Boolean; GGN : TGGN; const APrevisualizar: boolean = True ): Boolean;
    function Exportacion( const AOriginal: Boolean; GGN : TGGN; const APrevisualizar: boolean = True ): Boolean;
    function ExportacionIngles( const AOriginal: Boolean; GGN : TGGN; const APrevisualizar: boolean = True ): Boolean;
    function EstaValorado: boolean;
    function SinValorarDPS( const AOriginal: Boolean; GGN : TGGN; const APrevisualizar: boolean = True ): Boolean;

    function GetCodigoProveedor(const AEmpresa, ACliente: string): string;
    function GetResumen(const AEmpresa, ACentro: string; const AAlbaran: integer; const Afecha: TDateTime ): string;

    function HayTomate(const AEmpresa, ACentro: string; const AAlbaran: integer; const Afecha: TDateTime ): Boolean;
    function  EsIndustria(const AEmpresa, ACentro: string; const AAlbaran: integer; const Afecha: TDateTime ): Boolean;

  public
    { Public declarations }
    function  PreAlbaran( const AEmpresa, ACentro: String;
                         const AALbaran: integer;
                         const AFecha: TDateTime;
                         const APedirFirma, AOriginal: boolean;  GGN : TGGN; const APrevisualizar: boolean = True ): boolean;
    function  PreAlbaranSAT( const AEmpresa, ACentro: String;
                         const AALbaran: integer;
                         const AFecha: TDateTime;
                         const APedirFirma, AOriginal: boolean;  GGN : TGGN; const APrevisualizar: boolean = True ): boolean;
    function  PreAlbaranIngles( const AEmpresa, ACentro: String;
                                const AALbaran: integer;
                                const AFecha: TDateTime;
                                const APedirFirma, AOriginal: boolean; GGN : TGGN; const APrevisualizar: boolean = True ): boolean;

  end;

function PreAlbaran( const AOwner: TComponent;
                     const AEmpresa, ACentro: String;
                     const AALbaran: integer;
                     const AFecha: TDateTime;
                     const APedirFirma, AOriginal: boolean; GGN : TGGN; const APrevisualizar: boolean = True ): boolean;
function PreAlbaranSAT( const AOwner: TComponent;
                     const AEmpresa, ACentro: String;
                     const AALbaran: integer;
                     const AFecha: TDateTime;
                     const APedirFirma, AOriginal: boolean; GGN : TGGN; const APrevisualizar: boolean = True ): boolean;
function PreAlbaranIngles( const AOwner: TComponent;
                           const AEmpresa, ACentro: String;
                           const AALbaran: integer;
                           const AFecha: TDateTime;
                           const APedirFirma, AOriginal: boolean; GGN: TGGN; const APrevisualizar: boolean = True ): boolean;

implementation

{$R *.dfm}

uses
  UQRAlbaranValorado, UQRAlbaranSinValorar, UDMBaseDatos, CVAriables, Dialogs,
  UDMAuxDB, bTextUtils, UDMConfig, DPreview, SignatureForm, UQRAlbaranGenerico,
  UQRAlbaranExportacion,  UQRAlbaranExportacionIngles, bMath, UQRAlbaranSat, bSQLUtils, UCAlbaran,
  UQRAlbaranSinValorarDPS;

var
  DQAlbaranSalida: TDQAlbaranSalida;
  QRAlbaranGenerico: TQRAlbaranGenerico;
  QRAlbaranExportacion: TQRAlbaranExportacion;
  QRAlbaranExportacionIngles: TQRAlbaranExportacionIngles;
  QRAlbaranValorado: TQRAlbaranValorado;
  QRAlbaranSinValorar: TQRAlbaransinValorar;
  QRAlbaranSinValorarDPS: TQRAlbaransinValorarDPS;



function PreAlbaran( const AOwner: TComponent;
                     const AEmpresa, ACentro: String;
                     const AALbaran: integer;
                     const AFecha: TDateTime;
                     const APedirFirma, AOriginal: boolean; GGN: TGGN; const APrevisualizar: boolean = True ): boolean;
begin
  DQAlbaranSalida:= TDQAlbaranSalida.Create( AOwner );
  try
    result:= DQAlbaranSalida.PreAlbaran( AEmpresa, ACentro, AALbaran, AFecha, APedirFirma, AOriginal, GGN, APrevisualizar );
  finally
    FreeAndNil( DQAlbaranSalida );
  end;
end;

function PreAlbaranSAT( const AOwner: TComponent;
                     const AEmpresa, ACentro: String;
                     const AALbaran: integer;
                     const AFecha: TDateTime;
                     const APedirFirma, AOriginal: boolean; GGN : TGGN; const APrevisualizar: boolean = True ): boolean;
begin
  DQAlbaranSalida:= TDQAlbaranSalida.Create( AOwner );
  try
    result:= DQAlbaranSalida.PreAlbaranSAT( AEmpresa, ACentro, AALbaran, AFecha, APedirFirma, AOriginal, GGN, APrevisualizar );
  finally
    FreeAndNil( DQAlbaranSalida );
  end;
end;

function PreAlbaranIngles( const AOwner: TComponent;
                           const AEmpresa, ACentro: String;
                           const AALbaran: integer;
                           const AFecha: TDateTime;
                           const APedirFirma, AOriginal: boolean; GGN : TGGN; const APrevisualizar: boolean = True ): boolean;
begin
  DQAlbaranSalida:= TDQAlbaranSalida.Create( AOwner );
  try
    result:= DQAlbaranSalida.PreAlbaranIngles( AEmpresa, ACentro, AALbaran, AFecha, APedirFirma, AOriginal, GGN, APrevisualizar );
  finally
    FreeAndNil( DQAlbaranSalida );
  end;
end;



procedure TDQAlbaranSalida.DatosCliente;
begin
  with qryDatosCliente do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    with SQL do
    begin
      Clear;
      Add(' SELECT DISTINCT tipo_via_ds, domicilio_ds, cod_postal_ds, poblacion_ds,');
      Add('     provincia_ds,pais_ds, ');
      Add('     CASE when tipo_albaran_c > 1 THEN (case when original_name_p <> '''' then original_name_p else descripcion_p end ) ELSE descripcion_p END descripcion_p, ');
      Add('     tipo_albaran_c, nif_c ');
      Add(' FROM frf_salidas_c , frf_dir_sum  ,frf_clientes , frf_paises');
      Add(' WHERE  (empresa_sc = :empresa) ');
      Add(' AND  (cliente_sal_sc = :cliente) ');
      Add(' AND  (dir_sum_sc = :suministro)  ');
      Add(' AND  (cliente_c = :cliente) ');
      Add(' AND  (cliente_ds = :cliente) ');
      Add(' AND  (dir_sum_ds = :suministro) ');
      Add(' AND  (pais_p = pais_ds) '); //Pais
    end;
    ParamByName('empresa').AsString := QAlbaranC.FieldByname('empresa_sc').AsString;
    ParamByName('cliente').AsString := QAlbaranC.FieldByname('cliente_sal_sc').AsString;
    ParamByName('suministro').AsString := QAlbaranC.FieldByname('dir_sum_sc').AsString;

    try
      Open;
      bValorarAlbaran:= FieldByName('tipo_albaran_c').AsInteger = 1;
      if bValorarAlbaran then
        bValorarAlbaran:= EstaValorado;
      sCodPais:= Trim(FieldByName('pais_ds').AsString);
      sRazon:= desCliente( sCliente );
      if Trim(FieldByName('nif_c').AsString) <> '' then
      begin
        if sCodPais = 'ES' then
        begin
          sNif:= 'CIF: ' + Trim(FieldByName('nif_c').AsString);
        end
        else
        begin
          sNif:= 'VAT: ' + Trim(FieldByName('nif_c').AsString);
        end;
      end
      else
      begin
        sNif:= '';
      end;
      sReceptor:= desSuministro( sEmpresa, sCliente, QAlbaranC.FieldByname('dir_sum_sc').AsString );
      sDireccion:= Trim( FieldByName('tipo_via_ds').AsString  + ' ' +  FieldByName('domicilio_ds').AsString );

      sPoblacion:= '';
      //Provincia
      if sCodPais = 'ES' then
      begin
        sPoblacion:= desProvincia(FieldByName('cod_postal_ds').AsString);
      end;
      if sPoblacion = '' then
      begin
        sPoblacion:= Trim(FieldByName('provincia_ds').AsString);
      end;
      //A?ado cod postal
      if sPoblacion <> '' then
        sPoblacion:=  Trim( FieldByName('cod_postal_ds').AsString ) + ' (' + sPoblacion  + ')'
      else
        sPoblacion:=  Trim( FieldByName('cod_postal_ds').AsString );
      //A?ado poblacion
      if sPoblacion <> '' then
        sPoblacion:=  Trim( FieldByName('poblacion_ds').AsString ) + ', ' + sPoblacion
      else
        sPoblacion:=  Trim( FieldByName('poblacion_ds').AsString );

      sPais:= Trim(FieldByName('descripcion_p').AsString);

      sDireccionCompleta:= sRazon;
      if sNif <> '' then
        sDireccionCompleta:= sDireccionCompleta + #13 + #10 + sNif;
      if ( sReceptor <> '' ) and ( sReceptor <> sRazon ) then
        sDireccionCompleta:= sDireccionCompleta + #13 + #10 + sReceptor;
      if sDireccion <> '' then
        sDireccionCompleta:= sDireccionCompleta + #13 + #10 + sDireccion;
      if ( sPoblacion <> '' ) and ( sPoblacion <> sDireccion )  then
        sDireccionCompleta:= sDireccionCompleta + #13 + #10 + sPoblacion;
      if sPais <> '' then
        sDireccionCompleta:= sDireccionCompleta + #13 + #10 + sPais;

    finally
      Close;
    end;
  end;
end;

function TDQAlbaranSalida.EstaValorado: boolean;
begin
  qryAux.SQL.Clear;
  qryAux.SQL.Add(' SELECT sum(nvl(importe_neto_sl,0)) importe ');
  qryAux.SQL.Add(' FROM frf_salidas_l  ');
  qryAux.SQL.Add(' WHERE   (empresa_sl = :empresa) ');
  qryAux.SQL.Add('    AND  (centro_salida_sl = :centro) ');
  qryAux.SQL.Add('    AND  (n_albaran_sl = :albaran) ');
  qryAux.SQL.Add('    AND  (fecha_sl = :fecha) ');
  qryAux.ParamByName('empresa').AsString := sEmpresa;
  qryAux.ParamByName('centro').AsString := sCentro;
  qryAux.ParamByName('albaran').AsInteger := iAlbaran;
  qryAux.ParamByName('fecha').AsDateTime := dFecha;
  try
    qryAux.Open;
    result:= qryAux.FieldByname('importe').AsFloat <> 0;
  finally
    qryAux.CLose;
  end;
end;


procedure TDQAlbaranSalida.LineasAlbaran;
begin
  //Buscar cuerpo del formulario
  with qryAlbaranLin do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    with SQL do
    begin
      //frf_envases Tipo_e -> 0: normal -> 1: Multienvase  -> 2: Parte del multienvase (no se vende por separado del multienvase, que es que tiene precio)

      Clear;
      (*
      Add(' SELECT estomate_p,producto_sl, producto_p,descripcion_p,descripcion2_p, envase_sl,');
      Add('     tipo_e, descripcion_m, categoria_sl, calibre_sl, color_sl, ');
      Add('    unidad_precio_sl, ');
      Add('    case when tipo_e = 2 then 0 else precio_sl end  as precio_sl, ');
      Add('    porc_iva_sl, unidades_caja_sl, ');

      Add('    SUM(kilos_sl) as kilos_sl, ');
      Add('    SUM(cajas_sl) as cajas_sl, ');
      Add('    SUM((cajas_sl*unidades_caja_sl)) as unidades_sl, ');

      Add('    SUM( case when tipo_e = 2 then 0 else importe_neto_sl end ) as importe_neto_sl, ');
      Add('    SUM( case when tipo_e = 2 then 0 else iva_sl end ) as iva_sl, ');
      Add('    SUM( case when tipo_e = 2 then 0 else importe_total_sl end ) as importe_total_sl ');

      Add(' FROM frf_salidas_l , frf_productos , frf_envases , frf_marcas  ');
      Add(' WHERE   (empresa_sl = :empresa) ');
      Add('    AND  (centro_salida_sl = :centro) ');
      Add('    AND  (n_albaran_sl = :albaran) ');
      Add('    AND  (fecha_sl = :fecha) ');
      Add('    AND  (empresa_p = :empresa) '); //PRODUCTO
      Add('    AND  (producto_p = producto_sl) ');
      Add('    AND  (envase_e = envase_sl  and empresa_e = :empresa and producto_base_e = producto_base_p ) '); //ENVASE
      Add('    AND  (codigo_m = marca_sl) '); //MARCA
      Add(' GROUP BY estomate_p, producto_sl, producto_p, descripcion_p, descripcion2_p, ' +
          '          envase_sl,  tipo_e, descripcion_m, categoria_sl, calibre_sl, color_sl, ' +
          '          unidad_precio_sl, precio_sl, porc_iva_sl, unidades_caja_sl ');
      Add(' ORDER BY estomate_p, envase_sl, producto_sl, producto_p, categoria_sl, ');
      Add(' calibre_sl, precio_sl, unidad_precio_sl ');
      *)

      Add(' SELECT ');
      Add('     estomate_p,producto_sl, producto_p,descripcion_p,descripcion2_p, envase_sl, ');
      Add('     tipo_e, descripcion_m, categoria_sl, calibre_sl, color_sl, ');
      Add('     unidad_precio_sl, ');
      Add('     case when tipo_e = 2 then 0 else precio_sl end  as precio_sl, ');
      Add('     porc_iva_sl, ');

      Add('     tipo_palets_sl, descripcion_tp, notas_sl,');
      Add('     SUM(n_palets_sl) as palets_sl, ');
      Add('     SUM(n_palets_sl * kilos_tp) peso_palets, ');

      Add('     SUM(cajas_sl) as cajas_sl, ');
      Add('     SUM(cajas_sl*peso_envase_e) as peso_cajas, ');
      Add('     SUM(kilos_sl) as kilos_sl, ');

      Add('     unidades_caja_sl, ');
      Add('     SUM((cajas_sl*unidades_caja_sl)) as unidades_sl, ');

      Add('     SUM( case when tipo_e = 2 then 0 else importe_neto_sl end ) as importe_neto_sl, ');
      Add('     SUM( case when tipo_e = 2 then 0 else iva_sl end ) as iva_sl, ');
      Add('     SUM( case when tipo_e = 2 then 0 else importe_total_sl end ) as importe_total_sl ');

      Add('  FROM frf_salidas_l ');
      Add('       join frf_productos on (producto_p = producto_sl) ');
      Add('       join frf_envases  on envase_e = envase_sl -- and producto_e = producto_p ');
      Add('       join frf_marcas on  codigo_m = marca_sl ');
      Add('       left join frf_tipo_palets on codigo_tp = tipo_palets_sl ');
      Add(' WHERE   (empresa_sl = :empresa) ');
      Add('    AND  (centro_salida_sl = :centro) ');
      Add('    AND  (n_albaran_sl = :albaran) ');
      Add('    AND  (fecha_sl = :fecha) ');
      Add('  GROUP BY estomate_p, producto_sl, producto_p, descripcion_p, descripcion2_p, tipo_palets_sl, descripcion_tp, ');
      Add('           envase_sl, tipo_e, descripcion_m, categoria_sl, calibre_sl, color_sl, ');
      Add('           unidad_precio_sl, precio_sl, porc_iva_sl, unidades_caja_sl, kilos_tp, notas_sl ');
      Add('  ORDER BY estomate_p, producto_sl, envase_sl, categoria_sl, ');
      Add('  calibre_sl, unidades_caja_sl, precio_sl, unidad_precio_sl ');

    end;
    ParamByName('empresa').AsString := sEmpresa;
    ParamByName('centro').AsString := sCentro;
    ParamByName('albaran').AsInteger := iAlbaran;
    ParamByName('fecha').AsDateTime := dFecha;
    try
      Open;
    except
      qryAlbaranLin.Cancel;
      qryAlbaranLin.Close;
      MessageDlg('Error : No se puede recuperar los datos del cliente.', mtWarning, [mbOK], 0);
      raise;
    end;
  end;
end;

function TDQAlbaranSalida.PreAlbaranSAT(
                     const AEmpresa, ACentro: String;
                     const AALbaran: integer;
                     const AFecha: TDateTime;
                     const APedirFirma, AOriginal: boolean; GGN : TGGN; const APrevisualizar: boolean = True  ): boolean;
var
  aux: TStringList;
  sAux, sDir: string;
  bEsEspanya: boolean;
  sFilename, SFilePath: string;
  iAnyo, iMes, iDia: word;
  iCopias: integer;
  sHora, sDEscarga, sPedido, sTransporte: string;
begin
  result:= false;

  sEmpresa:= AEmpresa;
  sCentro:= ACentro;
  iALbaran:= AALbaran;
  DFecha:= AFecha;

  SFilePath:= '';
  if gsDirFirmasGlobal <> '' then
  begin
    if DirectoryExists( gsDirFirmasGlobal ) then
      SFilePath:=  gsDirFirmasGlobal;
  end;
  if SFilePath = '' then
  begin
    if gsDirFirmasLocal <> '' then
    begin
      if DirectoryExists( gsDirFirmasLocal ) then
        SFilePath:=  gsDirFirmasLocal;
    end;
  end;

  if SFilePath <> '' then
  begin
    DecodeDate( AFecha, iAnyo, iMes, iDia );
    sFilename:= intToStr( iAnyo ) + AEmpresa + ACentro + sCliente + '-' + IntToStr( AALbaran );
    sFileName:= SFilePath + '\' + sFileName + '.jpg';
  end;

  {
  if APedirFirma then
  begin
    if sFileName = '' then
    begin
      ShowMessage('Falta inicializar la ruta para guardar las firmas.');
    end
    else
    begin
      GetFirma( self, sFilename );
    end;
  end;
  }

  try

    with QAlbaranC do
    begin
      if Active then
      begin
        Cancel;
        Close;
      end;
      with SQL do
      begin
          Clear;
          Add(' select * ');
          Add(' from frf_salidas_c');
          Add(' where empresa_sc = :empresa');
          Add(' and centro_salida_sc = :centro');
          Add(' and n_albaran_sc = :albaran');
          Add(' and fecha_sc = :fecha');
          ParamByName('empresa').AsString := AEmpresa;
          ParamByName('centro').AsString := ACentro;
          ParamByName('albaran').AsInteger := AALbaran;
          ParamByName('fecha').AsDateTime := AFecha;
          Open;
          sCliente:= FieldByName('cliente_sal_sc').AsString;
          sSuministro:= FieldByName('dir_sum_sc').AsString;
          sHora:= FieldByName('hora_sc').AsString;
          sPedido:= FieldByName('n_pedido_sc').AsString;
          sTransporte:= FieldByName('transporte_sc').AsString;
          sDEscarga:= FieldByName('fecha_descarga_sc').AsString;
      end;
    end;
    QRAlbaranSat := TQRAlbaranSat.Create( self );
    QRAlbaranSat.rGGN := GGN;
    QRAlbaranSat.sFirma:= sFilename;
    QRAlbaranSat.empresa := AEmpresa;
    QRAlbaranSat.cliente := sCliente;

    QRAlbaranSat.ReportTitle := 'Albaran ' + IntToStr( AALbaran );
    QRAlbaranSat.Hint := sCliente + ' ' +
      StringReplace(DateToStr(AFecha), '/', '-', [rfReplaceAll, rfIgnoreCase])
      + ' ' + IntToStr( AALbaran );


    QRAlbaranSat.GetCodigoProveedor(AEmpresa, sCliente);
    QRAlbaranSat.GetResumen(AEmpresa, ACentro,
      intToStr( AALbaran ), DateToStr( AFecha) );
    aux := TStringList.Create;
    PutObservaciones( aux );
    QRAlbaranSat.mmoObservaciones.Lines.Clear;
    if Trim(aux.text) <> '' then QRAlbaranSat.mmoObservaciones.Lines.AddStrings(aux);

    aux.Clear;
    PutPalets(TStrings(aux));
    QRAlbaranSat.MemoPalets.Lines.Clear;
    QRAlbaranSat.MemoPalets.Lines.AddStrings(aux);

    aux.Clear;
    QRAlbaranSat.mmoPaletsMercadona.Lines.Clear;
    QRAlbaranSat.mmoPaletsMercadona.Lines.AddStrings(aux);

    aux.Clear;
    PutLogifruit(TStrings(aux));
    QRAlbaranSat.MemoCajas.Lines.Clear;
    QRAlbaranSat.MemoCajas.Lines.AddStrings(aux);

    QRAlbaranSat.LAlbaran.Caption := InTToStr( AALbaran );
    QRAlbaranSat.LFecha.Caption := DateToStr( AFecha );
    QRAlbaranSat.LHoraCarga.Caption := sHora;
    QRAlbaranSat.LDescarga.Caption := sDEscarga;
    QRAlbaranSat.LPedido.Caption := sPedido;

    aux.Free;

    if HayTomate( AEmpresa, ACentro, AALbaran, AFecha ) then
    begin
      QRAlbaranSat.bAquiHayTomate := (not EsIndustria( AEmpresa, ACentro, AALbaran, AFecha )  )and
        (AEmpresa = '050');
    end
    else
    begin
      QRAlbaranSat.bAquiHayTomate := False;
    end;

    (*

        //Seleccion datos suministro/cliente
    if (Trim(sSuministro) = Trim(sCliente)) or
      (Trim(sSuministro) = '') then
    begin
             //No hay direccion de suministro
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
          Add(' SELECT DISTINCT tipo_via_c, domicilio_c, poblacion_c, cod_postal_c, telefono_c,');
          Add('     pais_c, descripcion_p, tipo_albaran_c, moneda_c, nif_c');
          Add(' FROM frf_salidas_c , frf_clientes , frf_paises');
          Add(' WHERE  (empresa_sc = :empresa) ');
          Add(' AND  (cliente_sal_sc = :cliente) ');
          Add(' AND  (empresa_c = :empresa) '); //cliente
          Add(' AND  (cliente_c = :cliente) ');
          Add(' AND  (pais_p = pais_c) '); //pais

        end;
        ParamByName('empresa').AsString := AEmpresa;
        ParamByName('cliente').AsString := sCliente;

        try
          Open;
        except
          MessageDlg('Error : No se puede recuperar los datos del cliente.', mtWarning, [mbOK], 0);
          raise;
        end;

        //Rellenamos datos
        with QRAlbaranSat do
        begin
          bValorar := FieldByName('tipo_albaran_c').AsInteger = 1;
        end;

          QRAlbaranSat.qrlMonedaIva.Caption:= FieldByName('moneda_c').AsString;
          QRAlbaranSat.qrlMonedaTotal.Caption:= FieldByName('moneda_c').AsString;
          QRAlbaranSat.moneda3.Caption:= FieldByName('moneda_c').AsString;
          QRAlbaranSat.qrmDireccion.Lines.Clear;
          QRAlbaranSat.qrmDireccion.Lines.Add( desCliente( AEmpresa, sCliente ) );
          bEsEspanya:= Trim(FieldByName('pais_c').AsString) = 'ES';

          sAux:= Trim(FieldByName('nif_c').AsString);
          if sAux <> '' then
          begin
            if bEsEspanya then
              QRAlbaranSat.qrmDireccion.Lines.Add( 'CIF: ' + sAux )
            else
              QRAlbaranSat.qrmDireccion.Lines.Add( 'VAT: ' + sAux )
          end;
          sAux:= Trim( FieldByName('tipo_via_c').AsString  + ' ' +  FieldByName('domicilio_c').AsString );
          if sAux <> '' then
            QRAlbaranSat.qrmDireccion.Lines.Add( sAux );
          sAux:= Trim( FieldByName('poblacion_c').AsString );
          if sAux <> '' then
            QRAlbaranSat.qrmDireccion.Lines.Add( sAux );

          if bEsEspanya then
          begin
            sAux:= Trim( FieldByName('cod_postal_c').AsString + ' ' + desProvincia(FieldByName('cod_postal_c').AsString) );
            if sAux <> '' then
              QRAlbaranSat.qrmDireccion.Lines.Add( sAux );
          end
          else
          begin
            sAux:= Trim( FieldByName('cod_postal_c').AsString + ' ' + FieldByName('descripcion_p').AsString );
            if sAux <> '' then
              QRAlbaranSat.qrmDireccion.Lines.Add( sAux );
          end;
      end;
    end
    else
    *)
    begin
      //Siempre Hay direccion de suministro
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
          Add(' SELECT DISTINCT tipo_via_ds, domicilio_ds, cod_postal_ds, poblacion_ds, telefono_ds,');
          Add('     provincia_ds,pais_ds, descripcion_p, tipo_albaran_c, moneda_c, nif_c ');
          Add(' FROM frf_salidas_c , frf_dir_sum  ,frf_clientes , frf_paises');
          Add(' WHERE  (empresa_sc = :empresa) ');
          Add(' AND  (cliente_sal_sc = :cliente) ');
          Add(' AND  (dir_sum_sc = :suministro)  ');
          Add(' AND  (cliente_c = :cliente) ');
          Add(' AND  (cliente_ds = :cliente) ');
          Add(' AND  (dir_sum_ds = :suministro) ');
          Add(' AND  (pais_p = pais_ds) '); //Pais
        end;
        ParamByName('empresa').AsString := AEmpresa;
        ParamByName('cliente').AsString := sCliente;
        ParamByName('suministro').AsString := sSuministro;

        try
          Open;
        except
          MessageDlg('Error : No se puede recuperar los datos del cliente.', mtWarning, [mbOK], 0);
          raise;
        end;

                  //Rellenamos datos
        with QRAlbaranSat do
        begin
          bValorar := FieldByName('tipo_albaran_c').AsInteger = 1;
        end;
          QRAlbaranSat.qrmDireccion.Lines.Clear;
          QRAlbaranSat.qrmDireccion.Lines.Add( desCliente( sCliente ) );

          bEsEspanya:= Trim(FieldByName('pais_ds').AsString) = 'ES';
          sAux:= Trim(FieldByName('nif_c').AsString);
          if sAux <> '' then
          begin
            if bEsEspanya then
              QRAlbaranSat.qrmDireccion.Lines.Add( 'CIF: ' + sAux )
            else
              QRAlbaranSat.qrmDireccion.Lines.Add( 'VAT: ' + sAux )
          end;

          QRAlbaranSat.qrmDireccion.Lines.Add( desSuministro( AEmpresa, sCliente, sSuministro ) );

          sAux:= Trim( FieldByName('tipo_via_ds').AsString  + ' ' +  FieldByName('domicilio_ds').AsString );
          if sAux <> '' then
            QRAlbaranSat.qrmDireccion.Lines.Add( sAux );
          sAux:= Trim( FieldByName('poblacion_ds').AsString );
          if sAux <> '' then
            QRAlbaranSat.qrmDireccion.Lines.Add( sAux );

          if bEsEspanya then
          begin
            sAux:= desProvincia(FieldByName('cod_postal_ds').AsString);
            if sAux <> '' then
            begin
              sAux:= Trim( FieldByName('cod_postal_ds').AsString + ' ' + sAux );
              QRAlbaranSat.qrmDireccion.Lines.Add( sAux );
            end
            else
            begin
              sAux:= Trim( FieldByName('cod_postal_ds').AsString + ' ' + FieldByName('provincia_ds').AsString );
              if sAux <> '' then
                QRAlbaranSat.qrmDireccion.Lines.Add( sAux );
            end;
          end
          else
          begin
            sAux:= Trim( FieldByName('provincia_ds').AsString );
            if sAux <> '' then
            begin
              QRAlbaranSat.qrmDireccion.Lines.Add( Trim( FieldByName('cod_postal_ds').AsString + ' ' + sAux ) );
              sAux:= Trim( FieldByName('descripcion_p').AsString );
              if sAux <> '' then
                QRAlbaranSat.qrmDireccion.Lines.Add( sAux );
            end
            else
            begin
              sAux:= Trim( FieldByName('cod_postal_ds').AsString + ' ' + FieldByName('descripcion_p').AsString );
              if sAux <> '' then
                QRAlbaranSat.qrmDireccion.Lines.Add( sAux );
            end;
          end;

      end;
    end;
        //Datos almacen
    QRAlbaranSat.LCentro.Caption := desCentro( AEmpresa, ACentro );
    QRAlbaranSat.LVehiculo.Caption := QAlbaranC.FieldByname('vehiculo_sc').AsString;
    if sCliente = 'MER' then
      QRAlbaranSat.LTransporte.Caption := desTransporte( AEmpresa, sTransporte ) + DNITransporte(AEmpresa, sTransporte)
    else
      QRAlbaranSat.LTransporte.Caption := desTransporte( AEmpresa, sTransporte );
    sDir := Dir2Transporte(AEmpresa, sTransporte);
    if Trim( sDir ) <> '' then
      QRAlbaranSat.LTransporteDir1.Caption := Dir1Transporte(AEmpresa, sTransporte) + ', ' + sDir
    else
      QRAlbaranSat.LTransporteDir1.Caption := Dir1Transporte(AEmpresa, sTransporte);

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
        Add('    unidades_caja_sl, unidad_precio_sl,precio_sl,porc_iva_sl, producto_sl, ');

        Add('    SUM(kilos_sl) as kilos_sl, ');
        Add('    SUM(cajas_sl) as cajas_sl, ');
        Add('    SUM(cajas_sl*unidades_caja_sl) as unidades, ');
        Add('    SUM(importe_neto_sl) as importe_neto_sl, ');
        Add('    SUM(iva_sl) as iva_sl, ');
        Add('    SUM(importe_total_sl) as importe_total_sl ');

        if (Trim(AEmpresa) = '001') then
        begin
          Add(',categoria_sl ');
        end;

        Add(' FROM frf_salidas_l , frf_productos , frf_envases , frf_marcas  ');
        Add(' WHERE   (empresa_sl = :empresa) ');
        Add('    AND  (centro_salida_sl = :centro) ');
        Add('    AND  (n_albaran_sl = :albaran) ');
        Add('    AND  (fecha_sl = :fecha) ');
        Add('    AND  (producto_p = producto_sl) ');
        Add('    AND  (envase_e = envase_sl ) '); //ENVASE
        Add('    AND  (codigo_m = marca_sl) '); //MARCA

        Add(' GROUP BY estomate_p, producto_p, descripcion_p, descripcion2_p, ' +
          '          envase_sl, envase_e, descripcion_m, color_sl, calibre_sl, ' +
          '          unidades_caja_sl, unidad_precio_sl, precio_sl, porc_iva_sl, producto_sl ');

        if (Trim(AEmpresa) = '001') then
        begin
          Add(',categoria_sl ');
        end;

        Add(' ORDER BY estomate_p,producto_p, envase_e, color_sl, descripcion_m,');
        Add(' calibre_sl, precio_sl, unidad_precio_sl ');
      end;
      ParamByName('empresa').AsString := AEmpresa;
      ParamByName('centro').AsString := ACentro;
      ParamByName('albaran').AsString := IntToStr( AALbaran );
      ParamByName('fecha').AsDateTime := AFecha;
      try
        Open;
      except
        DMBaseDatos.QListado.Cancel;
        DMBaseDatos.QListado.Close;
        MessageDlg('Error : No se puede recuperar los datos del cliente.', mtWarning, [mbOK], 0);
        raise;
      end;
    end;
        //Aprovechando que las siguientes querys no se usas
    with QRAlbaranSat.QEmpresas do
    begin
      with SQL do
      begin
        Clear;
        Add(' SELECT estomate_p,producto_p,envase_e, descripcion_m, color_sl, calibre_sl, cajas_sl, kilos_sl, ');
        Add('    unidad_precio_sl, importe_neto_sl, precio_sl, (cajas_sl*unidades_caja_sl) as unidades,  ');
        Add('    ref_transitos_sl, notas_sl ');
        Add(' FROM frf_salidas_l , frf_productos , frf_envases , frf_marcas  ');
        Add(' WHERE   (empresa_sl = :empresa) ');
        Add('    AND  (centro_salida_sl = :centro) ');
        Add('    AND  (n_albaran_sl = :albaran) ');
        Add('    AND  (fecha_sl = :fecha) ');
        Add('    AND  (producto_p = producto_sl) ');
        Add('    AND  (envase_e = envase_sl ) '); //ENVASE
        Add('    AND  (codigo_m = marca_sl) '); //MARCA
        Add(' ORDER BY estomate_p,producto_p, envase_e, descripcion_m, color_sl, ');
        Add(' calibre_sl, precio_sl, unidad_precio_sl ');
      end;
      ParamByName('empresa').AsString := AEmpresa;
      ParamByName('centro').AsString := ACentro;
      ParamByName('albaran').AsString := IntToStr( AALbaran );
      ParamByName('fecha').AsDateTime := AFecha;
      try
        Open;
      except
        MessageDlg('Error : No se puede recuperar los datos del cliente.', mtWarning, [mbOK], 0);
        raise;
      end;
    end;


    QRAlbaranSat.Configurar(AEmpresa);
    DPreview.bCanSend := (DMConfig.EsLaFont);
    QRAlbaranSat.bEnEspanyol:= bEsEspanya;
    QRAlbaranSat.qrlMonedaIva.Caption:= sMoneda;
    QRAlbaranSat.qrlMonedaTotal.Caption:= sMoneda;
    QRAlbaranSat.moneda3.Caption:= sMoneda;

    QRAlbaranSat.bOriginal:= AOriginal;
    iCopias:= NumeroCopias( sEmpresa, sCliente);
    if not AOriginal then
      iCopias:= iCopias - 1;
    QRAlbaranSat.ReportTitle:= sCliente + 'A' + IntToStr( AALbaran );

    if APrevisualizar then
    begin
      result:= DPreview.Preview(QRAlbaranSat, iCopias, False, True, ForzarEnvioAlbaran( AEmpresa, sCliente, AALbaran, AFecha ) );
    end
    else
    begin
      try
        QRAlbaranSat.Print;
      finally
        FreeAndNil( QRAlbaranSat );
      end;
    end;

    DMBaseDatos.QListado.Cancel;
    DMBaseDatos.QListado.Close;

    QAlbaranC.Close;

  except
    QAlbaranC.Close;
    DMBaseDatos.QListado.Cancel;
    DMBaseDatos.QListado.Close;
    QRAlbaranSat.QEmpresas.Cancel;
    QRAlbaranSat.QEmpresas.Close;
    QRAlbaranSat.QEmpresas.RequestLive := true;
    QRAlbaranSat.Free;
  end;
end;

function TDQAlbaranSalida.HayTomate(const AEmpresa, ACentro: string; const AAlbaran: integer; const Afecha: TDateTime ): Boolean;
begin
  with DMBaseDatos.QTemp do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    with SQL do
    begin
      Clear;
      Add(' SELECT distinct estomate_p ');
      Add(' FROM frf_salidas_l , frf_productos ');
      Add(' WHERE  (empresa_sl = :empresa) ');
      Add('   AND  (centro_salida_sl = :centro) ');
      Add('   AND  (n_albaran_sl = :albaran) ');
      Add('   AND  (fecha_sl = :fecha)  ');
      Add('   AND  (producto_p = producto_sl) ');
      Add('   AND  (estomate_p ' + SQLEqualS('S') + ') ');
    end;
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('albaran').AsInteger := AAlbaran;
    ParamByName('fecha').AsDateTime := Afecha;
    try
      Open;
      Result := Fields[0].AsString = 'S';
    finally
      Close;
    end;
  end;
end;

function TDQAlbaranSalida.EsIndustria(const AEmpresa, ACentro: string; const AAlbaran: integer; const Afecha: TDateTime ): Boolean;
begin
  with DMBaseDatos.QTemp do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    with SQL do
    begin
      Clear;
      Add(' SELECT distinct categoria_sl ');
      Add(' FROM frf_salidas_l ');
      Add(' WHERE  empresa_sl = :empresa ');
      Add('   AND  centro_salida_sl = :centro ');
      Add('   AND  n_albaran_sl = :albaran ');
      Add('   AND  fecha_sl = :fecha  ');
      Add('   AND  categoria_sl ' + SQLEqualS('3B'));
    end;
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('albaran').AsInteger := AAlbaran;
    ParamByName('fecha').AsDateTime := Afecha;
    try
      Open;
      Result := Fields[0].AsString = '3B';
    finally
      Close;
    end;
  end;
end;


function TDQAlbaranSalida.PreAlbaran(
                     const AEmpresa, ACentro: String;
                     const AALbaran: integer;
                     const AFecha: TDateTime;
                     const APedirFirma, AOriginal: boolean; GGN : TGGN; const APrevisualizar: boolean = True  ): boolean;
var
  sMsg: string;
begin
  sEmpresa:= AEmpresa;
  sCentro:= ACentro;
  iALbaran:= AALbaran;
  dFecha:= AFecha;

  with QAlbaranC do
  begin
    SQL.Clear;
    SQL.Add('select * from frf_salidas_c');
    SQL.Add('where empresa_sc = :empresa');
    SQL.Add('and centro_salida_sc = :centro');
    SQL.Add('and fecha_sc = :fecha');
    SQL.Add('and n_albaran_sc = :albaran');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('albaran').AsInteger:= iALbaran;
    ParamByName('fecha').AsDateTime:= dFecha;
    Open;
  end;
  sCliente:= QAlbaranC.FieldByname('cliente_sal_sc').AsString;
  sSuministro:= QAlbaranC.FieldByname('dir_sum_sc').AsString;
  sMoneda:= QAlbaranC.FieldByname('moneda_sc').AsString;

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
      //GetFirma( self, sFilename );//OLDTablet
    end;
  end;

  DatosCliente;
  if sCliente = 'ERO' then
  begin
    result:= Generico( AOriginal, GGN,  APrevisualizar )
  end
  else
  if ( sCliente = 'GOM' ) or ( sCliente = 'THA' ) or ( sCliente = 'M&W' ) or ( sCliente = 'APS' ) or ( sCliente = 'EEN' ) or ( sCliente = 'P' ) or
     (sCliente = 'LBE') or (sCliente = 'LDE') or (sCliente = 'LRO') or (sCliente = 'LPL') or (sCliente = 'LDK') or (sCliente = 'LCZ') then
  begin
    result:= Exportacion( AOriginal, GGN, APrevisualizar )
  end
  else
  begin
    if bValorarAlbaran then
      result:= Valorado( AOriginal, GGN, APrevisualizar )
    else
    begin
      if sCliente = 'DPS' then
        result := SinValorarDPS(  AOriginal, GGN, APrevisualizar )
      else
        result:= SinValorar( AOriginal, GGN, APrevisualizar );
    end;
  end;
end;

function TDQAlbaranSalida.PreAlbaranIngles(
                     const AEmpresa, ACentro: String;
                     const AALbaran: integer;
                     const AFecha: TDateTime;
                     const APedirFirma, AOriginal: boolean; GGN : TGGN; const APrevisualizar: boolean = True  ): boolean;
var
  sMsg: string;
begin
  sEmpresa:= AEmpresa;
  sCentro:= ACentro;
  iALbaran:= AALbaran;
  dFecha:= AFecha;

  with QAlbaranC do
  begin
    SQL.Clear;
    SQL.Add('select * from frf_salidas_c');
    SQL.Add('where empresa_sc = :empresa');
    SQL.Add('and centro_salida_sc = :centro');
    SQL.Add('and fecha_sc = :fecha');
    SQL.Add('and n_albaran_sc = :albaran');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('albaran').AsInteger:= iALbaran;
    ParamByName('fecha').AsDateTime:= dFecha;
    Open;
  end;
  sCliente:= QAlbaranC.FieldByname('cliente_sal_sc').AsString;
  sSuministro:= QAlbaranC.FieldByname('dir_sum_sc').AsString;
  sMoneda:= QAlbaranC.FieldByname('moneda_sc').AsString;

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
      //GetFirma( self, sFilename );//OLDTablet
    end;
  end;

  DatosCliente;
  result:= ExportacionIngles( AOriginal, GGN, APrevisualizar )

end;


function TDQAlbaranSalida.Generico( const AOriginal: Boolean; GGN : TGGN; const APrevisualizar: boolean = True ): Boolean;
var
  aux: TStringList;
  sDir: string;
  iCopias: integer;
begin
  result:= False;
  LineasAlbaran;

  QRAlbaranGenerico:= TQRAlbaranGenerico.Create( self );
  try
    QRAlbaranGenerico.rGGN := GGN;
    QRAlbaranGenerico.sFirma:= sFilename;
    QRAlbaranGenerico.sempresa := sEmpresa;
    QRAlbaranGenerico.cliente := sCliente;

    QRAlbaranGenerico.qrmDireccion.Lines.Add( sDireccionCompleta );

    QRAlbaranGenerico.codProveedor:= GetCodigoProveedor(sEmpresa, sCliente);
    QRAlbaranGenerico.resumenList.Add( GetResumen(sEmpresa, sCentro, iAlbaran, dFecha) );

    aux := TStringList.Create;
    PutObservaciones( aux );
    QRAlbaranGenerico.mmoObservaciones.Lines.Clear;
    if Trim(aux.text) <> '' then
      QRAlbaranGenerico.mmoObservaciones.Lines.AddStrings(aux);

    aux.Clear;
    PutPalets(TStrings(aux));
    QRAlbaranGenerico.MemoPalets.Lines.Clear;
    QRAlbaranGenerico.MemoPalets.Lines.AddStrings(aux);

    aux.Clear;
    if ( sCliente = 'MER' ) then
      PutPaletsMercadona(TStrings(aux));
    QRAlbaranGenerico.mmoPaletsMercadona.Lines.Clear;
    QRAlbaranGenerico.mmoPaletsMercadona.Lines.AddStrings(aux);

    aux.Clear;
    PutLogifruit(TStrings(aux));
    QRAlbaranGenerico.MemoCajas.Lines.Clear;
    QRAlbaranGenerico.MemoCajas.Lines.AddStrings(aux);

    aux.Free;

    //Datos almacen
    if ( Copy( sEmpresa, 1, 1) = 'F' ) and ( sCliente <> 'ECI' )then
    //if ( Copy( sEmpresa, 1, 1) = 'F' ) then
    begin
      QRAlbaranGenerico.qrlNAlbaran.Caption := sEmpresa + sCentro + Rellena( IntToStr( iAlbaran ), 5, '0', taLeftJustify );
      QRAlbaranGenerico.qrlNAlbaran.Alignment := taRightJustify;
      QRAlbaranGenerico.qrlNAlbaran.Width:= 73;
      QRAlbaranGenerico.qrlNAlbaran.Left:= 7;
      QRAlbaranGenerico.qrlNAlbaran2.Caption := Coletilla( sEmpresa );
      QRAlbaranGenerico.qrlNAlbaran2.Enabled := True;
    end
    else
    //Bargosa
    if Trim( sEmpresa ) = '505' then
    begin
      QRAlbaranGenerico.qrlNAlbaran.Caption := 'BON.' + Rellena( IntToStr( iAlbaran ), 5, '0', taLeftJustify );
      QRAlbaranGenerico.qrlNAlbaran.Alignment := taRightJustify;
      QRAlbaranGenerico.qrlNAlbaran.Width:= 73;
      QRAlbaranGenerico.qrlNAlbaran.Left:= 7;
      QRAlbaranGenerico.qrlNAlbaran2.Caption := '';
      QRAlbaranGenerico.qrlNAlbaran2.Enabled := False;
    end
    else
    begin
      QRAlbaranGenerico.qrlNAlbaran.Caption := IntToStr( iAlbaran );
      QRAlbaranGenerico.qrlNAlbaran.Alignment := taCenter;
      QRAlbaranGenerico.qrlNAlbaran.Width:= 87;
      QRAlbaranGenerico.qrlNAlbaran.Left:= 7;
      QRAlbaranGenerico.qrlNAlbaran2.Caption := '';
      QRAlbaranGenerico.qrlNAlbaran2.Enabled := False;
    end;

    QRAlbaranGenerico.LFecha.Caption := DateTimeToStr( dFecha );
    QRAlbaranGenerico.LHoraCarga.Caption := QAlbaranC.FieldByname('hora_sc').AsString;
    QRAlbaranGenerico.LDescarga.Caption := QAlbaranC.FieldByname('fecha_descarga_sc').AsString;
    QRAlbaranGenerico.LPedido.Caption := QAlbaranC.FieldByname('n_pedido_sc').AsString;
    QRAlbaranGenerico.LVehiculo.Caption := QAlbaranC.FieldByname('vehiculo_sc').AsString;

    QRAlbaranGenerico.LCentro.Caption := desCentro( sEmpresa, sCentro );

    if sCliente = 'MER' then
      QRAlbaranGenerico.LTransporte.Caption := desTransporte( sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString) + DNITransporte(sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString)
    else
      QRAlbaranGenerico.LTransporte.Caption := desTransporte( sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString);
    sDir := Dir2Transporte(sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString);
    if Trim( sDir ) <> '' then
      QRAlbaranGenerico.LTransporteDir1.Caption := Dir1Transporte(sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString) + ', ' + sDir
    else
      QRAlbaranGenerico.LTransporteDir1.Caption := Dir1Transporte(sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString);


    QRAlbaranGenerico.Configurar(sEmpresa);

    DPreview.bCanSend := DMConfig.EsLaFont;

    QRAlbaranGenerico.bOriginal:= AOriginal;
    iCopias:= NumeroCopias( sEmpresa, sCliente);

    if not AOriginal then
      iCopias:= iCopias - 1;


    QRAlbaranGenerico.ReportTitle:= sCliente + 'A' + IntToStr( iALbaran );
    if APrevisualizar then
    begin
      result:= DPreview.Preview(QRAlbaranGenerico, iCopias, False, True, ForzarEnvioAlbaran( sEmpresa, sCliente, iALbaran, dFecha ) );
    end
    else
    begin
      try
        QRAlbaranGenerico.Print;
        result:= True;
      finally
        FreeAndNil( QRAlbaranGenerico );
      end;
    end;    

    qryAlbaranLin.Cancel;
    qryAlbaranLin.Close;

  except
    qryAlbaranLin.Cancel;
    qryAlbaranLin.Close;
    QRAlbaranGenerico.Free;
  end;
end;


function TDQAlbaranSalida.Exportacion( const AOriginal: Boolean; GGN : TGGN; const APrevisualizar: boolean = True ): Boolean;
var
  aux: TStringList;
  sDir: string;
  iCopias: integer;
begin
  result:= False;
  LineasAlbaran;

  QRAlbaranExportacion:= TQRAlbaranExportacion.Create( self );
  try
    QRAlbaranExportacion.rGGN := GGN;
    QRAlbaranExportacion.sFirma:= sFilename;
    QRAlbaranExportacion.sempresa := sEmpresa;
    QRAlbaranExportacion.cliente := sCliente;

    QRAlbaranExportacion.qrmDireccion.Lines.Add( sDireccionCompleta );

    QRAlbaranExportacion.codProveedor:= GetCodigoProveedor(sEmpresa, sCliente);
    QRAlbaranExportacion.resumenList.Add( GetResumen(sEmpresa, sCentro, iAlbaran, dFecha) );

    aux := TStringList.Create;


    PutPalets( TStrings(aux) );
    QRAlbaranExportacion.MemoPalets.Lines.Clear;
    QRAlbaranExportacion.MemoPalets.Lines.AddStrings(aux);
    QRAlbaranExportacion.LPalets.enabled:= aux.count <> 0;

    aux.Clear;
    PutLogifruit( TStrings(aux) );
    QRAlbaranExportacion.MemoCajas.Lines.Clear;
    QRAlbaranExportacion.MemoCajas.Lines.AddStrings(aux);
    QRAlbaranExportacion.LCajas.enabled:= aux.count <> 0;

    PutObservaciones( aux );
    QRAlbaranExportacion.mmoObservaciones.Lines.Clear;
    if Trim(aux.text) <> '' then
      QRAlbaranExportacion.mmoObservaciones.Lines.AddStrings(aux);

    aux.Free;

    //Datos almacen
    if ( Copy( sEmpresa, 1, 1) = 'F' ) and ( sCliente <> 'ECI' )then
    //if ( Copy( sEmpresa, 1, 1) = 'F' ) then
    begin
      QRAlbaranExportacion.qrlNAlbaran.Caption := sEmpresa + sCentro + Rellena( IntToStr( iAlbaran ), 5, '0', taLeftJustify );
      QRAlbaranExportacion.qrlNAlbaran.Alignment := taRightJustify;
      QRAlbaranExportacion.qrlNAlbaran.Width:= 73;
      QRAlbaranExportacion.qrlNAlbaran.Left:= 5;
      QRAlbaranExportacion.qrlNAlbaran2.Caption := Coletilla( sEmpresa );
      QRAlbaranExportacion.qrlNAlbaran2.Enabled := True;
    end
    else
    //Bargosa
    if Trim( sEmpresa ) = '505' then
    begin
      QRAlbaranExportacion.qrlNAlbaran.Caption := 'BON.' + Rellena( IntToStr( iAlbaran ), 5, '0', taLeftJustify );
      QRAlbaranExportacion.qrlNAlbaran.Alignment := taRightJustify;
      QRAlbaranExportacion.qrlNAlbaran.Width:= 73;
      QRAlbaranExportacion.qrlNAlbaran.Left:= 5;
      QRAlbaranExportacion.qrlNAlbaran2.Caption := '';
      QRAlbaranExportacion.qrlNAlbaran2.Enabled := False;
    end
    else
    begin
      QRAlbaranExportacion.qrlNAlbaran.Caption := IntToStr( iAlbaran );
      QRAlbaranExportacion.qrlNAlbaran.Alignment := taCenter;
      QRAlbaranExportacion.qrlNAlbaran.Width:= 87;
      QRAlbaranExportacion.qrlNAlbaran.Left:= 5;
      QRAlbaranExportacion.qrlNAlbaran2.Caption := '';
      QRAlbaranExportacion.qrlNAlbaran2.Enabled := False;
    end;

    QRAlbaranExportacion.LFecha.Caption := DateTimeToStr( dFecha ) + ' ' + QAlbaranC.FieldByname('hora_sc').AsString;
    QRAlbaranExportacion.LDescarga.Caption := QAlbaranC.FieldByname('fecha_descarga_sc').AsString;
    QRAlbaranExportacion.LPedido.Caption := QAlbaranC.FieldByname('n_pedido_sc').AsString;
    QRAlbaranExportacion.LVehiculo.Caption := QAlbaranC.FieldByname('vehiculo_sc').AsString;

    QRAlbaranExportacion.LCentro.Caption := desCentro( sEmpresa, sCentro );

    if sCliente = 'MER' then
      QRAlbaranExportacion.LTransporte.Caption := desTransporte( sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString) + DNITransporte(sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString)
    else
      QRAlbaranExportacion.LTransporte.Caption := desTransporte( sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString);
    sDir := Dir2Transporte(sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString);
    if Trim( sDir ) <> '' then
      QRAlbaranExportacion.LTransporteDir1.Caption := Dir1Transporte(sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString) + ', ' + sDir
    else
      QRAlbaranExportacion.LTransporteDir1.Caption := Dir1Transporte(sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString);


    QRAlbaranExportacion.Configurar(sEmpresa);

    DPreview.bCanSend := DMConfig.EsLaFont;

    QRAlbaranExportacion.bOriginal:= AOriginal;
    iCopias:= NumeroCopias( sEmpresa, sCliente);
    if not AOriginal then
      iCopias:= iCopias - 1;


    QRAlbaranExportacion.ReportTitle:= sCliente + 'A' + IntToStr( iALbaran );
    if APrevisualizar then
    begin
      result:= DPreview.Preview(QRAlbaranExportacion, iCopias, False, True, ForzarEnvioAlbaran( sEmpresa, sCliente, iALbaran, dFecha ) );
    end
    else
    begin
      try
        QRAlbaranExportacion.Print;
        result:= True;
      finally
        FreeAndNil( QRAlbaranExportacion );
      end;
    end;

    qryAlbaranLin.Cancel;
    qryAlbaranLin.Close;

  except
    qryAlbaranLin.Cancel;
    qryAlbaranLin.Close;
    QRAlbaranExportacion.Free;
  end;
end;


function TDQAlbaranSalida.ExportacionIngles( const AOriginal: Boolean; GGN : TGGN; const APrevisualizar: boolean = True ): Boolean;
var
  aux: TStringList;
  sDir: string;
  iCopias: integer;
begin
  result:= False;
  LineasAlbaran;

  QRAlbaranExportacionIngles:= TQRAlbaranExportacionIngles.Create( self );
  try
    QRAlbaranExportacionIngles.rGGN := GGN;
    QRAlbaranExportacionIngles.sFirma:= sFilename;
    QRAlbaranExportacionIngles.sempresa := sEmpresa;
    QRAlbaranExportacionIngles.cliente := sCliente;

    QRAlbaranExportacionIngles.qrmDireccion.Lines.Add( sDireccionCompleta );

    QRAlbaranExportacionIngles.codProveedor:= GetCodigoProveedor(sEmpresa, sCliente);
    QRAlbaranExportacionIngles.resumenList.Add( GetResumen(sEmpresa, sCentro, iAlbaran, dFecha) );

    aux := TStringList.Create;


    PutPalets( TStrings(aux) );
    QRAlbaranExportacionIngles.MemoPalets.Lines.Clear;
    QRAlbaranExportacionIngles.MemoPalets.Lines.AddStrings(aux);
    QRAlbaranExportacionIngles.LPalets.enabled:= aux.count <> 0;

    aux.Clear;
    PutLogifruit( TStrings(aux) );
    QRAlbaranExportacionIngles.MemoCajas.Lines.Clear;
    QRAlbaranExportacionIngles.MemoCajas.Lines.AddStrings(aux);
    QRAlbaranExportacionIngles.LCajas.enabled:= aux.count <> 0;

    PutObservaciones( aux );
    QRAlbaranExportacionIngles.mmoObservaciones.Lines.Clear;
    if Trim(aux.text) <> '' then
      QRAlbaranExportacionIngles.mmoObservaciones.Lines.AddStrings(aux);

    aux.Free;

    //Datos almacen
    if ( Copy( sEmpresa, 1, 1) = 'F' ) and ( sCliente <> 'ECI' )then
    //if ( Copy( sEmpresa, 1, 1) = 'F' ) then
    begin
      QRAlbaranExportacionIngles.qrlNAlbaran.Caption := sEmpresa + sCentro + Rellena( IntToStr( iAlbaran ), 5, '0', taLeftJustify );
      QRAlbaranExportacionIngles.qrlNAlbaran.Alignment := taRightJustify;
      QRAlbaranExportacionIngles.qrlNAlbaran.Width:= 73;
      QRAlbaranExportacionIngles.qrlNAlbaran.Left:= 5;
      QRAlbaranExportacionIngles.qrlNAlbaran2.Caption := Coletilla( sEmpresa );
      QRAlbaranExportacionIngles.qrlNAlbaran2.Enabled := True;
    end
    else
    //Bargosa
    if Trim( sEmpresa ) = '505' then
    begin
      QRAlbaranExportacionIngles.qrlNAlbaran.Caption := 'BON.' + Rellena( IntToStr( iAlbaran ), 5, '0', taLeftJustify );
      QRAlbaranExportacionIngles.qrlNAlbaran.Alignment := taRightJustify;
      QRAlbaranExportacionIngles.qrlNAlbaran.Width:= 73;
      QRAlbaranExportacionIngles.qrlNAlbaran.Left:= 5;
      QRAlbaranExportacionIngles.qrlNAlbaran2.Caption := '';
      QRAlbaranExportacionIngles.qrlNAlbaran2.Enabled := False;
    end
    else
    begin
      QRAlbaranExportacionIngles.qrlNAlbaran.Caption := IntToStr( iAlbaran );
      QRAlbaranExportacionIngles.qrlNAlbaran.Alignment := taCenter;
      QRAlbaranExportacionIngles.qrlNAlbaran.Width:= 87;
      QRAlbaranExportacionIngles.qrlNAlbaran.Left:= 5;
      QRAlbaranExportacionIngles.qrlNAlbaran2.Caption := '';
      QRAlbaranExportacionIngles.qrlNAlbaran2.Enabled := False;
    end;

    QRAlbaranExportacionIngles.LFecha.Caption := DateTimeToStr( dFecha ) + ' ' + QAlbaranC.FieldByname('hora_sc').AsString;
    QRAlbaranExportacionIngles.LDescarga.Caption := QAlbaranC.FieldByname('fecha_descarga_sc').AsString;
    QRAlbaranExportacionIngles.LPedido.Caption := QAlbaranC.FieldByname('n_pedido_sc').AsString;
    QRAlbaranExportacionIngles.LVehiculo.Caption := QAlbaranC.FieldByname('vehiculo_sc').AsString;

    QRAlbaranExportacionIngles.LCentro.Caption := desCentro( sEmpresa, sCentro );

    if sCliente = 'MER' then
      QRAlbaranExportacionIngles.LTransporte.Caption := desTransporte( sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString) + DNITransporte(sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString)
    else
      QRAlbaranExportacionIngles.LTransporte.Caption := desTransporte( sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString);
    sDir := Dir2Transporte(sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString);
    if Trim( sDir ) <> '' then
      QRAlbaranExportacionIngles.LTransporteDir1.Caption := Dir1Transporte(sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString) + ', ' + sDir
    else
      QRAlbaranExportacionIngles.LTransporteDir1.Caption := Dir1Transporte(sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString);



    QRAlbaranExportacionIngles.Configurar(sEmpresa);

    DPreview.bCanSend := DMConfig.EsLaFont;

    QRAlbaranExportacionIngles.bOriginal:= AOriginal;
    iCopias:= NumeroCopias( sEmpresa, sCliente);
    if not AOriginal then
      iCopias:= iCopias - 1;


    QRAlbaranExportacionIngles.ReportTitle:= sCliente + 'A' + IntToStr( iALbaran );
    if APrevisualizar then
    begin
      result:= DPreview.Preview(QRAlbaranExportacionIngles, iCopias, False, True, ForzarEnvioAlbaran( sEmpresa, sCliente, iALbaran, dFecha ) );
    end
    else
    begin
      try
        QRAlbaranExportacionIngles.Print;
        result:= True;
      finally
        FreeAndNil( QRAlbaranExportacionIngles );
      end;
    end;

    qryAlbaranLin.Cancel;
    qryAlbaranLin.Close;

  except
    qryAlbaranLin.Cancel;
    qryAlbaranLin.Close;
    QRAlbaranExportacionIngles.Free;
  end;
end;

function TDQAlbaranSalida.Valorado( const AOriginal: Boolean; GGN : TGGN; const APrevisualizar: boolean = True ): Boolean;
var
  aux: TStringList;
  sDir: string;
  iCopias: integer;
begin
  result:= False;
  LineasAlbaran;

  QRAlbaranValorado:= TQRAlbaranValorado.Create( self );
  try
    QRAlbaranValorado.rGGN := GGN;
    QRAlbaranValorado.sFirma:= sFilename;
    QRAlbaranValorado.empresa := sEmpresa;
    QRAlbaranValorado.cliente := sCliente;

    QRAlbaranValorado.qrmDireccion.Lines.Add( sDireccionCompleta );

    QRAlbaranValorado.codProveedor:= GetCodigoProveedor(sEmpresa, sCliente);
    QRAlbaranValorado.resumenList.Add( GetResumen(sEmpresa, sCentro, iAlbaran, dFecha) );

    aux := TStringList.Create;
    PutObservaciones( aux );
    QRAlbaranValorado.mmoObservaciones.Lines.Clear;
    if Trim(aux.text) <> '' then
      QRAlbaranValorado.mmoObservaciones.Lines.AddStrings(aux);

    aux.Clear;
    PutPalets(TStrings(aux));
    QRAlbaranValorado.MemoPalets.Lines.Clear;
    QRAlbaranValorado.MemoPalets.Lines.AddStrings(aux);

    aux.Clear;
    if ( sCliente = 'MER' ) then
      PutPaletsMercadona(TStrings(aux));
    QRAlbaranValorado.mmoPaletsMercadona.Lines.Clear;
    QRAlbaranValorado.mmoPaletsMercadona.Lines.AddStrings(aux);

    aux.Clear;
    PutLogifruit(TStrings(aux));
    QRAlbaranValorado.MemoCajas.Lines.Clear;
    QRAlbaranValorado.MemoCajas.Lines.AddStrings(aux);

    aux.Free;

    //Datos almacen
    if ( Copy( sEmpresa, 1, 1) = 'F' ) and ( sCliente <> 'ECI' )then
    //if ( Copy( sEmpresa, 1, 1) = 'F' ) then
    begin
      QRAlbaranValorado.qrlNAlbaran.Caption := sEmpresa + sCentro + Rellena( IntToStr( iAlbaran ), 5, '0', taLeftJustify );
      QRAlbaranValorado.qrlNAlbaran.Alignment := taRightJustify;
      QRAlbaranValorado.qrlNAlbaran.Width:= 73;
      QRAlbaranValorado.qrlNAlbaran.Left:= 7;
      QRAlbaranValorado.qrlNAlbaran2.Caption := Coletilla( sEmpresa );
      QRAlbaranValorado.qrlNAlbaran2.Enabled := True;
    end
    else
    //Bargosa
    if Trim( sEmpresa ) = '505' then
    begin
      QRAlbaranValorado.qrlNAlbaran.Caption := 'BON.' + Rellena( IntToStr( iAlbaran ), 5, '0', taLeftJustify );
      QRAlbaranValorado.qrlNAlbaran.Alignment := taRightJustify;
      QRAlbaranValorado.qrlNAlbaran.Width:= 73;
      QRAlbaranValorado.qrlNAlbaran.Left:= 7;
      QRAlbaranValorado.qrlNAlbaran2.Caption := '';
      QRAlbaranValorado.qrlNAlbaran2.Enabled := False;
    end
    else
    begin
      QRAlbaranValorado.qrlNAlbaran.Caption := IntToStr( iAlbaran );
      QRAlbaranValorado.qrlNAlbaran.Alignment := taCenter;
      QRAlbaranValorado.qrlNAlbaran.Width:= 87;
      QRAlbaranValorado.qrlNAlbaran.Left:= 7;
      QRAlbaranValorado.qrlNAlbaran2.Caption := '';
      QRAlbaranValorado.qrlNAlbaran2.Enabled := False;
    end;

    QRAlbaranValorado.LFecha.Caption := DateTimeToStr( dFecha );
    QRAlbaranValorado.LHoraDescarga.Caption := QAlbaranC.FieldByname('hora_sc').AsString;
    QRAlbaranValorado.LDescarga.Caption := QAlbaranC.FieldByname('fecha_descarga_sc').AsString;
    QRAlbaranValorado.LPedido.Caption := QAlbaranC.FieldByname('n_pedido_sc').AsString;
    QRAlbaranValorado.LVehiculo.Caption := QAlbaranC.FieldByname('vehiculo_sc').AsString;

    QRAlbaranValorado.LCentro.Caption := desCentro( sEmpresa, sCentro );

    if sCliente = 'MER' then
      QRAlbaranValorado.LTransporte.Caption := desTransporte( sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString) + DNITransporte(sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString)
    else
      QRAlbaranValorado.LTransporte.Caption := desTransporte( sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString);
    sDir := Dir2Transporte(sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString);
    if Trim( sDir ) <> '' then
      QRAlbaranValorado.LTransporteDir1.Caption := Dir1Transporte(sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString) + ', ' + sDir
    else
      QRAlbaranValorado.LTransporteDir1.Caption := Dir1Transporte(sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString);

    QRAlbaranValorado.qrlMonedaIva.Caption:= sMoneda;
    QRAlbaranValorado.qrlMonedaTotal.Caption:= sMoneda;
    QRAlbaranValorado.moneda3.Caption:= sMoneda;


    QRAlbaranValorado.Configurar(sEmpresa);

    DPreview.bCanSend := DMConfig.EsLaFont;

    QRAlbaranValorado.bOriginal:= AOriginal;
    iCopias:= NumeroCopias( sEmpresa, sCliente);
    if not AOriginal then
      iCopias:= iCopias - 1;

    QRAlbaranValorado.ReportTitle:= sCliente + 'A' + IntToStr( iALbaran );
    if APrevisualizar then
    begin
      result:= DPreview.Preview(QRAlbaranValorado, iCopias, False, True, ForzarEnvioAlbaran( sEmpresa, sCliente, iALbaran, dFecha ) );
    end
    else
    begin
      try
        QRAlbaranValorado.Print;
        result:= True;
      finally
        FreeAndNil( QRAlbaranValorado );
      end;
    end;    

    qryAlbaranLin.Cancel;
    qryAlbaranLin.Close;

  except
    qryAlbaranLin.Cancel;
    qryAlbaranLin.Close;
    QRAlbaranValorado.Free;
  end;
end;

function TDQAlbaranSalida.SinValorar( const AOriginal: Boolean; GGN : TGGN; const APrevisualizar: boolean = True ): Boolean;
var
  aux: TStringList;
  sDir: string;
  iCopias: integer;
begin
  result:= False;
  LineasAlbaran;

  QRAlbaranSinValorar:= TQRAlbaranSinValorar.Create( self );
  try
    QRAlbaranSinValorar.rGGN := GGN;
    QRAlbaranSinValorar.sFirma:= sFilename;
    QRAlbaranSinValorar.empresa := sEmpresa;
    QRAlbaranSinValorar.cliente := sCliente;

    QRAlbaranSinValorar.qrmDireccion.Lines.Add( sDireccionCompleta );

    QRAlbaranSinValorar.codProveedor:= GetCodigoProveedor(sEmpresa, sCliente);
    QRAlbaranSinValorar.resumenList.Add( GetResumen(sEmpresa, sCentro, iAlbaran, dFecha) );

    aux := TStringList.Create;
    PutObservaciones( aux );
    QRAlbaranSinValorar.mmoObservaciones.Lines.Clear;
    if Trim(aux.text) <> '' then
      QRAlbaranSinValorar.mmoObservaciones.Lines.AddStrings(aux);

    aux.Clear;
    PutPalets(TStrings(aux));
    QRAlbaranSinValorar.MemoPalets.Lines.Clear;
    QRAlbaranSinValorar.MemoPalets.Lines.AddStrings(aux);

    aux.Clear;
    if ( sCliente = 'MER' ) then
      PutPaletsMercadona(TStrings(aux));
    QRAlbaranSinValorar.mmoPaletsMercadona.Lines.Clear;
    QRAlbaranSinValorar.mmoPaletsMercadona.Lines.AddStrings(aux);

    aux.Clear;
    PutLogifruit(TStrings(aux));
    QRAlbaranSinValorar.MemoCajas.Lines.Clear;
    QRAlbaranSinValorar.MemoCajas.Lines.AddStrings(aux);

    aux.Free;

    //Datos almacen
    if ( Copy( sEmpresa, 1, 1) = 'F' ) and ( sCliente <> 'ECI' )then
    //if ( Copy( sEmpresa, 1, 1) = 'F' ) then
    begin
      QRAlbaranSinValorar.qrlNAlbaran.Caption := sEmpresa + sCentro + Rellena( IntToStr( iAlbaran ), 5, '0', taLeftJustify );
      QRAlbaranSinValorar.qrlNAlbaran.Alignment := taRightJustify;
      QRAlbaranSinValorar.qrlNAlbaran.Width:= 73;
      QRAlbaranSinValorar.qrlNAlbaran.Left:= 7;
      QRAlbaranSinValorar.qrlNAlbaran2.Caption := Coletilla( sEmpresa );
      QRAlbaranSinValorar.qrlNAlbaran2.Enabled := True;
    end
    else
    //Bargosa
    if Trim( sEmpresa ) = '505' then
    begin
      QRAlbaranSinValorar.qrlNAlbaran.Caption := 'BON.' + Rellena( IntToStr( iAlbaran ), 5, '0', taLeftJustify );
      QRAlbaranSinValorar.qrlNAlbaran.Alignment := taRightJustify;
      QRAlbaranSinValorar.qrlNAlbaran.Width:= 73;
      QRAlbaranSinValorar.qrlNAlbaran.Left:= 7;
      QRAlbaranSinValorar.qrlNAlbaran2.Caption := '';
      QRAlbaranSinValorar.qrlNAlbaran2.Enabled := False;
    end
    else
    begin
      QRAlbaranSinValorar.qrlNAlbaran.Caption := IntToStr( iAlbaran );
      QRAlbaranSinValorar.qrlNAlbaran.Alignment := taCenter;
      QRAlbaranSinValorar.qrlNAlbaran.Width:= 87;
      QRAlbaranSinValorar.qrlNAlbaran.Left:= 7;
      QRAlbaranSinValorar.qrlNAlbaran2.Caption := '';
      QRAlbaranSinValorar.qrlNAlbaran2.Enabled := False;
    end;

    QRAlbaranSinValorar.LFecha.Caption := DateTimeToStr( dFecha );
    QRAlbaranSinValorar.LHoraDescarga.Caption := QAlbaranC.FieldByname('hora_sc').AsString;
    QRAlbaranSinValorar.LDescarga.Caption := QAlbaranC.FieldByname('fecha_descarga_sc').AsString;
    QRAlbaranSinValorar.LPedido.Caption := QAlbaranC.FieldByname('n_pedido_sc').AsString;
    QRAlbaranSinValorar.LVehiculo.Caption := QAlbaranC.FieldByname('vehiculo_sc').AsString;

    QRAlbaranSinValorar.LCentro.Caption := desCentro( sEmpresa, sCentro );

    if sCliente = 'MER' then
      QRAlbaranSinValorar.LTransporte.Caption := desTransporte( sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString) + DNITransporte(sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString)
    else
      QRAlbaranSinValorar.LTransporte.Caption := desTransporte( sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString);
    sDir := Dir2Transporte(sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString);
    if Trim( sDir ) <> '' then
      QRAlbaranSinValorar.LTransporteDir1.Caption := Dir1Transporte(sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString) + ', ' + sDir
    else
      QRAlbaranSinValorar.LTransporteDir1.Caption := Dir1Transporte(sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString);


    QRAlbaranSinValorar.Configurar(sEmpresa);

    DPreview.bCanSend := DMConfig.EsLaFont;

    QRAlbaranSinValorar.bOriginal:= AOriginal;
    iCopias:= NumeroCopias( sEmpresa, sCliente);
    if not AOriginal then
      iCopias:= iCopias - 1;

    QRAlbaranSinValorar.ReportTitle:= sCliente + 'A' + IntToStr( iALbaran );
    if APrevisualizar then
    begin
      result:= DPreview.Preview(QRAlbaranSinValorar, iCopias, False, True, ForzarEnvioAlbaran( sEmpresa, sCliente, iALbaran, dFecha ) );
    end
    else
    begin
      try
        QRAlbaranSinValorar.Print;
        result:= True;
      finally
        FreeAndNil( QRAlbaranSinValorar );
      end;
    end;

    qryAlbaranLin.Cancel;
    qryAlbaranLin.Close;

  except
    qryAlbaranLin.Cancel;
    qryAlbaranLin.Close;
    QRAlbaranSinValorar.Free;
  end;
end;

function TDQAlbaranSalida.SinValorarDPS( const AOriginal: Boolean; GGN : TGGN; const APrevisualizar: boolean = True ): Boolean;
var
  aux: TStringList;
  iCopias: integer;
  bEsEspanya: boolean;
  sAux, sDir, sFilename, SFilePath: string;
  iAnyo, iMes, iDia: word;
  sHora, sDEscarga, sPedido, sTransporte: string;
begin
  result:= false;

  SFilePath:= '';
  if gsDirFirmasGlobal <> '' then
  begin
    if DirectoryExists( gsDirFirmasGlobal ) then
      SFilePath:=  gsDirFirmasGlobal;
  end;
  if SFilePath = '' then
  begin
    if gsDirFirmasLocal <> '' then
    begin
      if DirectoryExists( gsDirFirmasLocal ) then
        SFilePath:=  gsDirFirmasLocal;
    end;
  end;

  if SFilePath <> '' then
  begin
    DecodeDate( dFecha, iAnyo, iMes, iDia );
    sFilename:= intToStr( iAnyo ) + sEmpresa + sCentro + sCliente + '-' + IntToStr( iALbaran );
    sFileName:= SFilePath + '\' + sFileName + '.jpg';
  end;

  try

    with QAlbaranC do
    begin
      if Active then
      begin
        Cancel;
        Close;
      end;
      with SQL do
      begin
          Clear;
          Add(' select * ');
          Add(' from frf_salidas_c');
          Add(' where empresa_sc = :empresa');
          Add(' and centro_salida_sc = :centro');
          Add(' and n_albaran_sc = :albaran');
          Add(' and fecha_sc = :fecha');
          ParamByName('empresa').AsString := sEmpresa;
          ParamByName('centro').AsString := sCentro;
          ParamByName('albaran').AsInteger := iALbaran;
          ParamByName('fecha').AsDateTime := dFecha;
          Open;
          sCliente:= FieldByName('cliente_sal_sc').AsString;
          sSuministro:= FieldByName('dir_sum_sc').AsString;
          sHora:= FieldByName('hora_sc').AsString;
          sPedido:= FieldByName('n_pedido_sc').AsString;
          sTransporte:= FieldByName('transporte_sc').AsString;
          sDEscarga:= FieldByName('fecha_descarga_sc').AsString;
      end;
    end;
    QRAlbaranSinValorarDPS := TQRAlbaranSinValorarDPS.Create( self );
    QRAlbaranSinValorarDPS.rGGN := GGN;
    QRAlbaranSinValorarDPS.sFirma:= sFilename;
    QRAlbaranSinValorarDPS.empresa := sEmpresa;
    QRAlbaranSinValorarDPS.cliente := sCliente;

    QRAlbaranSinValorarDPS.ReportTitle := 'Albaran ' + IntToStr( iALbaran );
    QRAlbaranSinValorarDPS.Hint := sCliente + ' ' +
      StringReplace(DateToStr(dFecha), '/', '-', [rfReplaceAll, rfIgnoreCase])
      + ' ' + IntToStr( iALbaran );


    QRAlbaranSinValorarDPS.GetCodigoProveedor(sEmpresa, sCliente);
    QRAlbaranSinValorarDPS.GetResumen(sEmpresa, sCentro,
      intToStr( iALbaran ), DateToStr( dFecha) );
    aux := TStringList.Create;
    PutObservaciones( aux );
    QRAlbaranSinValorarDPS.mmoObservaciones.Lines.Clear;
    if Trim(aux.text) <> '' then QRAlbaranSinValorarDPS.mmoObservaciones.Lines.AddStrings(aux);

    aux.Clear;
    PutPalets(TStrings(aux));
    QRAlbaranSinValorarDPS.MemoPalets.Lines.Clear;
    QRAlbaranSinValorarDPS.MemoPalets.Lines.AddStrings(aux);

    aux.Clear;
    QRAlbaranSinValorarDPS.mmoPaletsMercadona.Lines.Clear;
    QRAlbaranSinValorarDPS.mmoPaletsMercadona.Lines.AddStrings(aux);

    aux.Clear;
    PutLogifruit(TStrings(aux));
    QRAlbaranSinValorarDPS.MemoCajas.Lines.Clear;
    QRAlbaranSinValorarDPS.MemoCajas.Lines.AddStrings(aux);

    QRAlbaranSinValorarDPS.LAlbaran.Caption := InTToStr( iALbaran );
    QRAlbaranSinValorarDPS.LFecha.Caption := DateToStr( dFecha );
    QRAlbaranSinValorarDPS.LHoraCarga.Caption := sHora;
    QRAlbaranSinValorarDPS.LDescarga.Caption := sDEscarga;
    QRAlbaranSinValorarDPS.LPedido.Caption := sPedido;

    aux.Free;

    if HayTomate( sEmpresa, sCentro, iALbaran, dFecha ) then
    begin
      QRAlbaranSinValorarDPS.bAquiHayTomate := (not EsIndustria( sEmpresa, sCentro, iALbaran, dFecha )  )and
        (sEmpresa = '050');
    end
    else
    begin
      QRAlbaranSinValorarDPS.bAquiHayTomate := False;
    end;

    begin
      //Siempre Hay direccion de suministro
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
          Add(' SELECT DISTINCT tipo_via_ds, domicilio_ds, cod_postal_ds, poblacion_ds, telefono_ds,');
          Add('     provincia_ds,pais_ds, descripcion_p, tipo_albaran_c, moneda_c, nif_c ');
          Add(' FROM frf_salidas_c , frf_dir_sum  ,frf_clientes , frf_paises');
          Add(' WHERE  (empresa_sc = :empresa) ');
          Add(' AND  (cliente_sal_sc = :cliente) ');
          Add(' AND  (dir_sum_sc = :suministro)  ');
          Add(' AND  (cliente_c = :cliente) ');
          Add(' AND  (cliente_ds = :cliente) ');
          Add(' AND  (dir_sum_ds = :suministro) ');
          Add(' AND  (pais_p = pais_ds) '); //Pais
        end;
        ParamByName('empresa').AsString := sEmpresa;
        ParamByName('cliente').AsString := sCliente;
        ParamByName('suministro').AsString := sSuministro;

        try
          Open;
        except
          MessageDlg('Error : No se puede recuperar los datos del cliente.', mtWarning, [mbOK], 0);
          raise;
        end;

                  //Rellenamos datos
        with QRAlbaranSinValorarDPS do
        begin
          bValorar := FieldByName('tipo_albaran_c').AsInteger = 1;
        end;
          QRAlbaranSinValorarDPS.qrmDireccion.Lines.Clear;
          QRAlbaranSinValorarDPS.qrmDireccion.Lines.Add( desCliente( sCliente ) );

          bEsEspanya:= Trim(FieldByName('pais_ds').AsString) = 'ES';
          sAux:= Trim(FieldByName('nif_c').AsString);
          if sAux <> '' then
          begin
            if bEsEspanya then
              QRAlbaranSinValorarDPS.qrmDireccion.Lines.Add( 'CIF: ' + sAux )
            else
              QRAlbaranSinValorarDPS.qrmDireccion.Lines.Add( 'VAT: ' + sAux )
          end;

          QRAlbaranSinValorarDPS.qrmDireccion.Lines.Add( desSuministro( sEmpresa, sCliente, sSuministro ) );

          sAux:= Trim( FieldByName('tipo_via_ds').AsString  + ' ' +  FieldByName('domicilio_ds').AsString );
          if sAux <> '' then
            QRAlbaranSinValorarDPS.qrmDireccion.Lines.Add( sAux );
          sAux:= Trim( FieldByName('poblacion_ds').AsString );
          if sAux <> '' then
            QRAlbaranSinValorarDPS.qrmDireccion.Lines.Add( sAux );

          if bEsEspanya then
          begin
            sAux:= desProvincia(FieldByName('cod_postal_ds').AsString);
            if sAux <> '' then
            begin
              sAux:= Trim( FieldByName('cod_postal_ds').AsString + ' ' + sAux );
              QRAlbaranSinValorarDPS.qrmDireccion.Lines.Add( sAux );
            end
            else
            begin
              sAux:= Trim( FieldByName('cod_postal_ds').AsString + ' ' + FieldByName('provincia_ds').AsString );
              if sAux <> '' then
                QRAlbaranSinValorarDPS.qrmDireccion.Lines.Add( sAux );
            end;
          end
          else
          begin
            sAux:= Trim( FieldByName('provincia_ds').AsString );
            if sAux <> '' then
            begin
              QRAlbaranSinValorarDPS.qrmDireccion.Lines.Add( Trim( FieldByName('cod_postal_ds').AsString + ' ' + sAux ) );
              sAux:= Trim( FieldByName('descripcion_p').AsString );
              if sAux <> '' then
                QRAlbaranSinValorarDPS.qrmDireccion.Lines.Add( sAux );
            end
            else
            begin
              sAux:= Trim( FieldByName('cod_postal_ds').AsString + ' ' + FieldByName('descripcion_p').AsString );
              if sAux <> '' then
                QRAlbaranSinValorarDPS.qrmDireccion.Lines.Add( sAux );
            end;
          end;

      end;
    end;
        //Datos almacen
    QRAlbaranSinValorarDPS.LCentro.Caption := desCentro( sEmpresa, sCentro );
    QRAlbaranSinValorarDPS.LVehiculo.Caption := QAlbaranC.FieldByname('vehiculo_sc').AsString;
    if sCliente = 'MER' then
      QRAlbaranSinValorarDPS.LTransporte.Caption := desTransporte( sEmpresa, sTransporte ) + DNITransporte(sEmpresa, sTransporte)
    else
      QRAlbaranSinValorarDPS.LTransporte.Caption := desTransporte( sEmpresa, sTransporte );
    sDir := Dir2Transporte(sEmpresa, sTransporte);
    if Trim( sDir ) <> '' then
      QRAlbaranSinValorarDPS.LTransporteDir1.Caption := Dir1Transporte(sEmpresa, sTransporte) + ', ' + sDir
    else
      QRAlbaranSinValorarDPS.LTransporteDir1.Caption := Dir1Transporte(sEmpresa, sTransporte);

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
        Add('    unidades_caja_sl, unidad_precio_sl,precio_sl,porc_iva_sl, ');

        Add('    SUM(kilos_sl) as kilos_sl, ');
        Add('    SUM(cajas_sl) as cajas_sl, ');
        Add('    SUM(cajas_sl*unidades_caja_sl) as unidades, ');
        Add('    SUM(importe_neto_sl) as importe_neto_sl, ');
        Add('    SUM(iva_sl) as iva_sl, ');
        Add('    SUM(importe_total_sl) as importe_total_sl ');

        if (Trim(sEmpresa) = '001') then
        begin
          Add(',categoria_sl ');
        end;

        Add(' FROM frf_salidas_l , frf_productos , frf_envases , frf_marcas  ');
        Add(' WHERE   (empresa_sl = :empresa) ');
        Add('    AND  (centro_salida_sl = :centro) ');
        Add('    AND  (n_albaran_sl = :albaran) ');
        Add('    AND  (fecha_sl = :fecha) ');
        Add('    AND  (producto_p = producto_sl) ');
        Add('    AND  (envase_e = envase_sl ) '); //ENVASE
        Add('    AND  (codigo_m = marca_sl) '); //MARCA

        Add(' GROUP BY estomate_p, producto_p, descripcion_p, descripcion2_p, ' +
          '          envase_sl, envase_e, descripcion_m, color_sl, calibre_sl, ' +
          '          unidades_caja_sl, unidad_precio_sl, precio_sl, porc_iva_sl ');

        if (Trim(sEmpresa) = '001') then
        begin
          Add(',categoria_sl ');
        end;

        Add(' ORDER BY estomate_p,producto_p, envase_e, color_sl, descripcion_m,');
        Add(' calibre_sl, precio_sl, unidad_precio_sl ');
      end;
      ParamByName('empresa').AsString := sEmpresa;
      ParamByName('centro').AsString := sCentro;
      ParamByName('albaran').AsString := IntToStr( iALbaran );
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
        //Aprovechando que las siguientes querys no se usas
    with QRAlbaranSinValorarDPS.QEmpresas do
    begin
      with SQL do
      begin
        Clear;
        Add(' SELECT estomate_p,producto_p,envase_e, descripcion_m, color_sl, calibre_sl, cajas_sl, kilos_sl, ');
        Add('    unidad_precio_sl, importe_neto_sl, precio_sl, (cajas_sl*unidades_caja_sl) as unidades,  ');
        Add('    ref_transitos_sl, notas_sl ');
        Add(' FROM frf_salidas_l , frf_productos , frf_envases , frf_marcas  ');
        Add(' WHERE   (empresa_sl = :empresa) ');
        Add('    AND  (centro_salida_sl = :centro) ');
        Add('    AND  (n_albaran_sl = :albaran) ');
        Add('    AND  (fecha_sl = :fecha) ');
        Add('    AND  (producto_p = producto_sl) ');
        Add('    AND  (envase_e = envase_sl ) '); //ENVASE
        Add('    AND  (codigo_m = marca_sl) '); //MARCA
        Add(' ORDER BY estomate_p,producto_p, envase_e, descripcion_m, color_sl, ');
        Add(' calibre_sl, precio_sl, unidad_precio_sl ');
      end;
      ParamByName('empresa').AsString := sEmpresa;
      ParamByName('centro').AsString := sCentro;
      ParamByName('albaran').AsString := IntToStr( iALbaran );
      ParamByName('fecha').AsDateTime := dFecha;
      try
        Open;
      except
        MessageDlg('Error : No se puede recuperar los datos del cliente.', mtWarning, [mbOK], 0);
        raise;
      end;
    end;

    if dfecha >= EncodeDate(2021,8,23) then QRAlbaranSinValorarDPS.GGN_Code := '8430543000007' else QRAlbaranSinValorarDPS.GGN_Code := '4049928415684';


    QRAlbaranSinValorarDPS.Configurar(sEmpresa);
    DPreview.bCanSend := (DMConfig.EsLaFont);
    QRAlbaranSinValorarDPS.bEnEspanyol:= bEsEspanya;
//    QRAlbaranSinValorarDPS.qrlMonedaIva.Caption:= sMoneda;
//    QRAlbaranSinValorarDPS.qrlMonedaTotal.Caption:= sMoneda;
//    QRAlbaranSinValorarDPS.moneda3.Caption:= sMoneda;

    QRAlbaranSinValorarDPS.bOriginal:= AOriginal;
    iCopias:= NumeroCopias( sEmpresa, sCliente);
    if not AOriginal then
      iCopias:= iCopias - 1;
    QRAlbaranSinValorarDPS.ReportTitle:= sCliente + 'A' + IntToStr( iALbaran );

    if APrevisualizar then
    begin
      result:= DPreview.Preview(QRAlbaranSinValorarDPS, iCopias, False, True, ForzarEnvioAlbaran( sEmpresa, sCliente, iALbaran, dFecha ) );
    end
    else
    begin
      try
        QRAlbaranSinValorarDPS.Print;
      finally
        FreeAndNil( QRAlbaranSinValorarDPS );
      end;
    end;

    DMBaseDatos.QListado.Cancel;
    DMBaseDatos.QListado.Close;

    QAlbaranC.Close;

  except
    QAlbaranC.Close;
    DMBaseDatos.QListado.Cancel;
    DMBaseDatos.QListado.Close;
    QRAlbaranSinValorarDPS.QEmpresas.Cancel;
    QRAlbaranSinValorarDPS.QEmpresas.Close;
    QRAlbaranSinValorarDPS.QEmpresas.RequestLive := true;
    QRAlbaranSinValorarDPS.Free;
  end;
end;

function TDQAlbaranSalida.GetFirmaFileName: string;
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

procedure TDQAlbaranSalida.PutObservaciones( var ATexto: TStringList );
begin
  if QAlbaranC.FieldByname('n_cmr_sc').AsString <> '' then
  begin
    ATexto.Add('N? CMR:' + QAlbaranC.FieldByname('n_cmr_sc').AsString);
  end;
  if QAlbaranC.FieldByname('n_orden_sc').AsString <> '' then
  begin
    ATexto.Add('N? ORDEN CARGA:' + QAlbaranC.FieldByname('n_orden_sc').AsString);
  end;
  if QAlbaranC.FieldByname('higiene_sc').AsInteger = 1  then
  begin
    ATexto.Add('CONDICIONES HIGIENICAS: OK');
  end
  else
  begin
    ATexto.Add('CONDICIONES HIGIENICAS: INCORRECTAS');
  end;

  if Trim( QAlbaranC.FieldByname('nota_sc').AsString ) <> '' then
    ATexto.Add( Trim(QAlbaranC.FieldByname('nota_sc').AsString) );
end;

procedure TDQAlbaranSalida.PutPaletsMercadona(var APaletsMercadona: TStrings);
var
  iPalets, iCajas: Integer;
  rKilos: Real;
begin
  with qryAux do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    with SQL do
    begin
      Clear;
      Add(' select tipo_palets_sl, ');
      Add('        ( select descripcion_tp from frf_tipo_palets where codigo_tp = tipo_palets_sl ) des_tipo_palets_sl, ');
      Add('        producto_sl, ');
      Add('        ( select descripcion_p from frf_productos where producto_p = producto_sl ) des_producto_sl, ');
      Add('        envase_sl, ');
      Add('        ( select descripcion_e from frf_envases where producto_e = producto_sl ');
      Add('          and envase_e = envase_sl ) des_envase_sl, ');
      Add('        sum(n_palets_sl) palets, sum(cajas_sl) cajas_sl, sum(kilos_sl) kilos_sl ');
      Add(' from frf_salidas_l ');
      Add(' where empresa_sl = :empresa ');
      Add(' and centro_salida_sl = :centro ');
      Add(' and n_albaran_sl = :albaran ');
      Add(' and fecha_sl = :fecha ');
      Add(' group by 1,2,3,4,5,6 ');
      Add(' order by tipo_palets_sl, producto_sl, envase_sl ');

    end;
    ParamByName('empresa').AsString := sEmpresa;
    ParamByName('centro').AsString := sCentro;
    ParamByName('albaran').AsInteger := iALbaran;
    ParamByName('fecha').AsDateTime := dFecha;
    try
      iPalets := 0;
      iCajas := 0;
      rKilos := 0;

      Open;
      First;
      APaletsMercadona.Clear;
      APaletsMercadona.Add('TIPO PALETA                         ENVASE                         PALETS   CAJAS      KILOS');
      APaletsMercadona.Add('----------------------------------- ------------------------------ ------ ------- ----------');
      while not Eof do
      begin
        //'35 30 6 7 9'
        APaletsMercadona.Add(
          RellenaDer(FieldByName('des_tipo_palets_sl').AsString, 35) + ' ' +
          RellenaDer(FieldByName('des_envase_sl').AsString, 30) + ' ' +
          Rellena(FieldByName('palets').AsString, 6) + ' ' +
          Rellena(FieldByName('cajas_sl').AsString, 7) + ' ' +
          Rellena(FormatFloat('#0.00', FieldByName('kilos_sl').AsFloat ), 10) );
        iPalets := iPalets + FieldByName('palets').AsInteger;
        iCajas := iCajas + FieldByName('cajas_sl').AsInteger;
        rKilos := rKilos + FieldByName('kilos_sl').AsFloat;
        Next;
      end;
      APaletsMercadona.Add('----------------------------------- ------------------------------ ------ ------- ----------');
      APaletsMercadona.Add(
        Rellena(' ', 66) + ' ' +
        Rellena(IntToStr(iPalets), 6) + ' ' +
        Rellena(IntToStr(iCajas), 7) + ' ' +
        Rellena(FormatFloat('#0.00', rKilos), 10));

    finally
      Close;
    end;
  end;
end;

procedure TDQAlbaranSalida.PutPalets(var APalets: TStrings);
begin
  with qryAux do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    with SQL do
    begin
      Clear;
      Add(' SELECT descripcion_tp, SUM(n_palets_sl) as n_palets_sl ');
      Add(' FROM frf_salidas_l , frf_tipo_palets ');
      Add(' WHERE   (tipo_palets_sl = codigo_tp) ');
      Add('    AND  (empresa_sl = :empresa) ');
      Add('    AND  (centro_salida_sl = :centro) ');
      Add('    AND  (n_albaran_sl = :albaran) ');
      Add('    AND  (fecha_sl = :fecha) ');
      Add(' GROUP BY descripcion_tp  ');
      Add(' ORDER BY descripcion_tp ');
    end;
    ParamByName('empresa').AsString := sEmpresa;
    ParamByName('centro').AsString := sCentro;
    ParamByName('albaran').AsInteger := ialbaran;
    ParamByName('fecha').AsDateTime := dFecha;
    try
      Open;
      First;
      while not Eof do
      begin
        APalets.add(FieldByName('descripcion_tp').AsString + ' : ' +
          FieldByName('n_palets_sl').AsString);
        Next;
      end;
    finally
      Close;
    end;
  end;
end;

procedure TDQAlbaranSalida.PutLogifruit(var ALogifruit: TStrings);
begin
  with qryAux do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    with SQL do
    begin
      Clear;
      Add(' select cod_producto_ecp codigo_caja_e, des_producto_ecp texto_caja_e, sum(cajas_sl) cajas_sl ');
      Add(' FROM frf_salidas_l, frf_envases, frf_env_comer_productos ');
      Add(' WHERE empresa_sl = :empresa ');
      Add('   AND centro_salida_sl = :centro ');
      Add('   AND n_albaran_sl = :albaran ');
      Add('   AND fecha_sl = :fecha ');
      Add('   and envase_e = envase_sl ');
      Add('   and producto_e = producto_sl ');
      Add(' and env_comer_operador_e = cod_operador_ecp ');
      Add(' and env_comer_producto_e = cod_producto_ecp ');
      Add(' group by cod_producto_ecp, des_producto_ecp ');
      Add(' order by cod_producto_ecp ');

    end;
    ParamByName('empresa').AsString := sEmpresa;
    ParamByName('centro').AsString := sCentro;
    ParamByName('albaran').AsInteger := iAlbaran;
    ParamByName('fecha').AsDateTime := dFecha;
    try
      Open;
      First;
      while not Eof do
      begin
          ALogifruit.add(FieldByName('texto_caja_e').AsString + ' : ' + FieldByName('cajas_sl').AsString );
        Next;
      end;
    finally
      Close;
    end;
  end;
end;

function TDQAlbaranSalida.DNITransporte(const AEmpresa, ATransporte: string): string;
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

function TDQAlbaranSalida.Dir2Transporte(const AEmpresa, ATransporte: string): string;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select direccion2_t from frf_transportistas ');
    SQL.Add(' where transporte_t = ' + QuotedStr(ATransporte));
    Open;
    if not IsEmpty then
    begin
      result := Fields[0].AsString;
    end
    else
    begin
      result := '';
    end;
    Close;
  end;
end;

function TDQAlbaranSalida.Dir1Transporte(const AEmpresa, ATransporte: string): string;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select direccion1_t from frf_transportistas ');
    SQL.Add(' where transporte_t = ' + QuotedStr(ATransporte));
    Open;
    if not IsEmpty then
    begin
      result := Fields[0].AsString;
    end
    else
    begin
      result := '';
    end;
    Close;
  end;
end;


function TDQAlbaranSalida.GetCodigoProveedor(const AEmpresa, ACliente: string): string;
begin
  if ACliente = 'MER' then
  begin
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT codigo_ean_e  ' +
      ' FROM    frf_empresas ' +
      ' WHERE empresa_e = :empresa ');
    qryAux.ParamByName('empresa').AsString := AEmpresa;
    qryAux.open;
    Result := qryAux.FieldByName('codigo_ean_e').AsString;
    qryAux.Close;
  end
  else
  begin
    Result := '';
  end;
end;

function TDQAlbaranSalida.GetResumen(const AEmpresa, ACentro: string; const AAlbaran: integer; const Afecha: TDateTime ): string;
var
  cajas, unidades, kilos, bruto, undsCaja: Real;
  sAux: string;
  resumenList: TStringList;
begin
  with qryAux do
  begin
    resumenList:= TStringList.Create;
    with SQL do
    begin
      Clear;
      Add(' SELECT centro_origen_sl  as centro, producto_p, ');
      Add('        descripcion_p as nomProducto,');
      Add('        sum(cajas_sl) as cajasResumen, ');
      Add('        sum(cajas_sl*unidades_caja_sl) as unidadesResumen, ');
      Add('        sum(kilos_sl) as kilosResumen, ');
      Add('        sum(  round( ( cajas_sl * nvl(peso_envase_e,0) ), 2 ) + kilos_sl + (nvl(kilos_tp,0) * nvl(n_palets_sl, 0))) as brutoResumen, ');
      Add('        unidad_precio_sl unidadPrecio ');

      Add(' FROM frf_salidas_l , frf_productos , frf_envases, frf_tipo_palets ');

      Add(' WHERE (empresa_sl = :empresa) ');
      Add(' AND   (centro_salida_sl = :centro) ');
      Add(' AND   (n_albaran_sl = :albaran) ');
      Add(' AND   (fecha_sl = :fecha) ');

      Add(' AND   (producto_p = producto_sl) ');

      Add(' AND   (envase_sl = envase_e and producto_e = producto_p ) '); // envase

      Add(' AND   (codigo_tp = tipo_palets_sl) ');

      Add(' GROUP BY  centro_origen_sl, producto_p, descripcion_p, unidad_precio_sl ');
      Add(' ORDER BY  1, 2 ');

    end;

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('albaran').AsInteger := AAlbaran;
    ParamByName('fecha').AsDateTime := AFecha;
    try
      Open;
      resumenList.Clear;
      resumenList.Add('   Cajas   Unid.       Kilos  Unds/Caj       Bruto(Sin Palets)');
      cajas := 0;
      unidades := 0;
      kilos := 0;
      bruto := 0;
      First;
      undsCaja:= 0;
      while not Eof do
      begin
        //'1 5XXXX 5XXXX 8XXXXXX 9XXXXXXX RESTO'
        if Fields[7].AsString = 'UND' then
        begin
          if Fields[3].AsInteger <> 0 then
            undsCaja:= bRoundTo( ( Fields[4].AsInteger / Fields[3].AsInteger ), -2 );
          sAux:= 'U';
        end
        else
        begin
          if Fields[3].AsInteger <> 0 then
            undsCaja:= bRoundTo( ( Fields[5].AsFloat / Fields[3].AsInteger ), -2 );
          sAux:= 'K';
        end;
        resumenList.Add(Fields[0].AsString + ' ' +
          Rellena(FormatFloat('#0', Fields[3].AsInteger ), 6) + ' ' +
          Rellena(FormatFloat('#0', Fields[4].AsInteger ), 7) + ' ' +
          Rellena(FormatFloat('#0.00', Fields[5].AsFloat ), 11) + ' ' +

          Rellena(FormatFloat('#0.00', undsCaja ), 7) + ' ' + sAux + ' ' +

          Rellena(Fields[6].AsString, 11) + ' ' +
          Fields[1].AsString + ' ' +
          Fields[2].AsString);
        cajas := cajas + Fields[3].AsFloat;
        unidades := unidades + Fields[4].AsFloat;
        kilos := kilos + Fields[5].AsFloat;
        bruto := bruto + Fields[6].AsFloat;
        Next;
      end;
      resumenList.Add('  ------ ------- ----------- --------- -----------');
      resumenList.Add(Rellena(FormatFloat('#0', cajas), 8) + ' ' +
        Rellena(FormatFloat('#0', unidades), 7) + ' ' +
        Rellena(FormatFloat('#0.00', kilos), 11) + ' ' +
        Rellena(FormatFloat('#0.00', bruto), 21));
    finally
      Close;
    end;
    result:= resumenList.text;
    FreeAndNil( resumenList );
  end;
end;



end.
