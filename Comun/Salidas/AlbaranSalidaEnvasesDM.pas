unit AlbaranSalidaEnvasesDM;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMAlbaranSalidaEnvases = class(TDataModule)
    QAlbaranC: TQuery;
  private
    { Private declarations }
    sEmpresa, sCentro, sCliente: String;
    iALbaran: integer;
    dFecha: TDateTime;

    function  GetFirmaFileName: string;
    procedure PutObservaciones( var ATexto: TStringList );
    procedure PutPalets(var APalets: TStrings);
    procedure PutLogifruit(var ALogifruit: TStrings);
    function  DNITransporte(const AEmpresa, ATransporte: string): string;
    function  Dir2Transporte(const AEmpresa, ATransporte: string): string;
    function  Dir1Transporte(const AEmpresa, ATransporte: string): string;
  public
    { Public declarations }
    function PreAlbaran( const AEmpresa, ACentro: String;
                         const AALbaran: integer;
                         const AFecha: TDateTime;
                         const APedirFirma, AOriginal: boolean ): boolean;
  end;

function PreAlbaran( const AOwner: TComponent;
                     const AEmpresa, ACentro: String;
                     const AALbaran: integer;
                     const AFecha: TDateTime;
                     const APedirFirma, AOriginal: boolean ): boolean;

implementation

{$R *.dfm}

uses
  AlbaranSalidaEnvasesQR, UDMBaseDatos, CVAriables, Dialogs, UDMAuxDB, bTextUtils,
  UDMConfig, DPreview, SignatureForm, UCAlbaran;

var
  DMAlbaranSalidaEnvases: TDMAlbaranSalidaEnvases;
  QRAlbaranSalidaEnvases: TQRAlbaranSalidaEnvases;

function PreAlbaran( const AOwner: TComponent;
                     const AEmpresa, ACentro: String;
                     const AALbaran: integer;
                     const AFecha: TDateTime;
                     const APedirFirma, AOriginal: boolean ): boolean;
begin
  DMAlbaranSalidaEnvases:= TDMAlbaranSalidaEnvases.Create( AOwner );
  try
    result:= DMAlbaranSalidaEnvases.PreAlbaran( AEmpresa, ACentro, AALbaran, AFecha, APedirFirma, AOriginal );
  finally
    FreeAndNil( DMAlbaranSalidaEnvases );
  end;
end;

function TDMAlbaranSalidaEnvases.PreAlbaran(
                     const AEmpresa, ACentro: String;
                     const AALbaran: integer;
                     const AFecha: TDateTime;
                     const APedirFirma, AOriginal: boolean ): boolean;
var
  aux: TStringList;
  sAux, sDir, sMsg: string;
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

  try
    QRAlbaranSalidaEnvases:= TQRAlbaranSalidaEnvases.Create( self );
    QRAlbaranSalidaEnvases.sFirma:= sFilename;
    QRAlbaranSalidaEnvases.empresa := sEmpresa;
    QRAlbaranSalidaEnvases.cliente := sCliente;

    QRAlbaranSalidaEnvases.GetCodigoProveedor(sEmpresa, sCliente);

    aux := TStringList.Create;
    PutObservaciones( aux );
    QRAlbaranSalidaEnvases.mmoObservaciones.Lines.Clear;
    if Trim(aux.text) <> '' then
      QRAlbaranSalidaEnvases.mmoObservaciones.Lines.AddStrings(aux);

    aux.Clear;
    PutPalets(TStrings(aux));
    QRAlbaranSalidaEnvases.MemoPalets.Lines.Clear;
    QRAlbaranSalidaEnvases.MemoPalets.Lines.Add('RESUMEN PALETS:');
    QRAlbaranSalidaEnvases.MemoPalets.Lines.AddStrings(aux);

    aux.Clear;
    PutLogifruit(TStrings(aux));
    QRAlbaranSalidaEnvases.MemoCajas.Lines.Clear;
    QRAlbaranSalidaEnvases.MemoCajas.Lines.Add('RESUMEN CAJAS LOGIGRUT:');
    QRAlbaranSalidaEnvases.MemoCajas.Lines.AddStrings(aux);

    aux.Free;

        //Seleccion datos suministro/cliente
    if (Trim(QAlbaranC.FieldByname('dir_sum_sc').AsString) = Trim(sCliente)) or
      (Trim(QAlbaranC.FieldByname('dir_sum_sc').AsString) = '') then
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
          Add('     pais_c, descripcion_p, moneda_c, nif_c');
          Add(' FROM frf_salidas_c , frf_clientes , frf_paises');
          Add(' WHERE  (empresa_sc = :empresa) ');
          Add(' AND  (cliente_sal_sc = :cliente) ');
          Add(' AND  (cliente_c = :cliente) '); //Cliente
          Add(' AND  (pais_p = pais_c) '); //pais

        end;
        ParamByName('empresa').AsString := sEmpresa;
        ParamByName('cliente').AsString := sCliente;

        try
          Open;
        except
          MessageDlg('Error : No se puede recuperar los datos del cliente.', mtWarning, [mbOK], 0);
          raise;
        end;

                  //Rellenamos datos
        with QRAlbaranSalidaEnvases do
        begin

          QRAlbaranSalidaEnvases.qrmDireccion.Lines.Clear;
          QRAlbaranSalidaEnvases.qrmDireccion.Lines.Add( desCliente( sCliente ) );

          sAux:= Trim(FieldByName('nif_c').AsString);
          if sAux <> '' then
          begin
            QRAlbaranSalidaEnvases.qrmDireccion.Lines.Add( 'CIF: ' + sAux )
          end;
          sAux:= Trim( FieldByName('tipo_via_c').AsString  + ' ' +  FieldByName('domicilio_c').AsString );
          if sAux <> '' then
            QRAlbaranSalidaEnvases.qrmDireccion.Lines.Add( sAux );
          sAux:= Trim( FieldByName('poblacion_c').AsString );
          if sAux <> '' then
            QRAlbaranSalidaEnvases.qrmDireccion.Lines.Add( sAux );

          sAux:= Trim( FieldByName('cod_postal_c').AsString + ' ' + desProvincia(FieldByName('cod_postal_c').AsString) );
          if sAux <> '' then
            QRAlbaranSalidaEnvases.qrmDireccion.Lines.Add( sAux );
        end;
      end;
    end
    else
    begin
      //Hay direccion de suministro
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
          Add('     provincia_ds,pais_ds, descripcion_p,  moneda_c, nif_c ');
          Add(' FROM frf_salidas_c , frf_dir_sum  ,frf_clientes , frf_paises');
          Add(' WHERE  (empresa_sc = :empresa) ');
          Add(' AND  (cliente_sal_sc = :cliente) ');
          Add(' AND  (dir_sum_sc = :suministro)  ');
          Add(' AND  (cliente_c = :cliente) '); //Cliente
          Add(' AND  (cliente_ds = :cliente) ');
          Add(' AND  (dir_sum_ds = :suministro) ');
          Add(' AND  (pais_p = pais_ds) '); //Pais
        end;
        ParamByName('empresa').AsString := sEmpresa;
        ParamByName('cliente').AsString := sCliente;
        ParamByName('suministro').AsString := QAlbaranC.FieldByname('dir_sum_sc').AsString;

        try
          Open;
        except
          MessageDlg('Error : No se puede recuperar los datos del cliente.', mtWarning, [mbOK], 0);
          raise;
        end;

                  //Rellenamos datos
        with QRAlbaranSalidaEnvases do
        begin

          QRAlbaranSalidaEnvases.qrmDireccion.Lines.Clear;
          QRAlbaranSalidaEnvases.qrmDireccion.Lines.Add( desCliente( sCliente ) );

          sAux:= Trim(FieldByName('nif_c').AsString);
          if sAux <> '' then
          begin
            QRAlbaranSalidaEnvases.qrmDireccion.Lines.Add( 'CIF: ' + sAux )
          end;

          QRAlbaranSalidaEnvases.qrmDireccion.Lines.Add( desSuministro( sEmpresa, sCliente, QAlbaranC.FieldByname('dir_sum_sc').AsString )  );

          sAux:= Trim( FieldByName('tipo_via_ds').AsString  + ' ' +  FieldByName('domicilio_ds').AsString );
          if sAux <> '' then
            QRAlbaranSalidaEnvases.qrmDireccion.Lines.Add( sAux );
          sAux:= Trim( FieldByName('poblacion_ds').AsString );
          if sAux <> '' then
            QRAlbaranSalidaEnvases.qrmDireccion.Lines.Add( sAux );

          sAux:= desProvincia(FieldByName('cod_postal_ds').AsString);
          if sAux <> '' then
          begin
            sAux:= Trim( FieldByName('cod_postal_ds').AsString + ' ' + sAux );
            QRAlbaranSalidaEnvases.qrmDireccion.Lines.Add( sAux );
          end
          else
          begin
            sAux:= Trim( FieldByName('cod_postal_ds').AsString + ' ' + FieldByName('provincia_ds').AsString );
            if sAux <> '' then
              QRAlbaranSalidaEnvases.qrmDireccion.Lines.Add( sAux );
          end;
        end;
      end;
    end;



    //Datos almacen
    (*ALBARAN*)

    if ( Copy( sEmpresa, 1, 1) = 'F' ) and ( sCliente <> 'ECI' ) then
    //if ( Copy( sEmpresa, 1, 1) = 'F' ) then
    begin
      QRAlbaranSalidaEnvases.qrlNAlbaran.Caption := sEmpresa + sCentro + Rellena( IntToStr( iAlbaran ), 5, '0', taLeftJustify );
      QRAlbaranSalidaEnvases.qrlNAlbaran.Alignment := taRightJustify;
      QRAlbaranSalidaEnvases.qrlNAlbaran.Width:= 73;
      QRAlbaranSalidaEnvases.qrlNAlbaran.Left:= 41;
      QRAlbaranSalidaEnvases.qrlNAlbaran2.Caption := Coletilla( sEmpresa );
      QRAlbaranSalidaEnvases.qrlNAlbaran2.Enabled := True;
    end
    else
    //Bargosa
    if Trim( sEmpresa ) = '505' then
    begin
      QRAlbaranSalidaEnvases.qrlNAlbaran.Caption := 'BON.' + Rellena( IntToStr( iAlbaran ), 5, '0', taLeftJustify );
      QRAlbaranSalidaEnvases.qrlNAlbaran.Alignment := taRightJustify;
      QRAlbaranSalidaEnvases.qrlNAlbaran.Width:= 73;
      QRAlbaranSalidaEnvases.qrlNAlbaran.Left:= 41;
      QRAlbaranSalidaEnvases.qrlNAlbaran2.Caption := '';
      QRAlbaranSalidaEnvases.qrlNAlbaran2.Caption := 'e';
      QRAlbaranSalidaEnvases.qrlNAlbaran2.Enabled := True;
    end
    else
    begin
      QRAlbaranSalidaEnvases.qrlNAlbaran.Caption := IntToStr( iAlbaran );
      QRAlbaranSalidaEnvases.qrlNAlbaran.Alignment := taCenter;
      QRAlbaranSalidaEnvases.qrlNAlbaran.Width:= 87;
      QRAlbaranSalidaEnvases.qrlNAlbaran.Left:= 41;
      QRAlbaranSalidaEnvases.qrlNAlbaran2.Caption := '';
      QRAlbaranSalidaEnvases.qrlNAlbaran2.Enabled := False;
    end;

    QRAlbaranSalidaEnvases.LFecha.Caption := DateTimeToStr( dFecha );
    QRAlbaranSalidaEnvases.LHora.Caption := QAlbaranC.FieldByname('hora_sc').AsString;
    QRAlbaranSalidaEnvases.LPedido.Caption := QAlbaranC.FieldByname('n_pedido_sc').AsString;
    QRAlbaranSalidaEnvases.LVehiculo.Caption := QAlbaranC.FieldByname('vehiculo_sc').AsString;

    QRAlbaranSalidaEnvases.LCentro.Caption := desCentro( sEmpresa, sCentro );
    if sCliente = 'MER' then
      QRAlbaranSalidaEnvases.LTransporte.Caption := desTransporte( sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString) + DNITransporte(sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString)
    else
      QRAlbaranSalidaEnvases.LTransporte.Caption := desTransporte( sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString);
    sDir := Dir2Transporte(sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString);
    if Trim( sDir ) <> '' then
      QRAlbaranSalidaEnvases.LTransporteDir1.Caption := Dir1Transporte(sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString) + ', ' + sDir
    else
      QRAlbaranSalidaEnvases.LTransporteDir1.Caption := Dir1Transporte(sEmpresa, QAlbaranC.FieldByname('transporte_sc').AsString);

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
        Add(' select ');
        Add('        ( select descripcion_p from frf_productos where producto_p = producto_sl ) producto, ');
        Add('        ( select descripcion_tp from frf_tipo_palets where codigo_tp = tipo_palets_sl ) palet, ');
        Add('               ( select descripcion_e from frf_envases where producto_e = producto_sl ');
        Add('          and envase_e = envase_sl ) envase, ');
        Add('        sum(n_palets_sl) palets, sum(cajas_sl) cajas ');
        Add(' from frf_salidas_l ');
        Add(' where empresa_sl = :empresa ');
        Add(' and centro_salida_sl = :centro ');
        Add(' and n_albaran_sl = :albaran ');
        Add(' and fecha_sl = :fecha ');
        Add(' group by 1,2,3 ');
        Add(' order by 1,2,3 ');
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

    QRAlbaranSalidaEnvases.Configurar(sEmpresa);

    DPreview.bCanSend := DMConfig.EsLaFont;

    QRAlbaranSalidaEnvases.bOriginal:= AOriginal;
    iCopias:= NumeroCopias( sEmpresa, sCliente);
    if not AOriginal then

      iCopias:= iCopias - 1;
    QRAlbaranSalidaEnvases.ReportTitle:= sCliente + 'A' + IntToStr( iALbaran );
    result:= DPreview.Preview(QRAlbaranSalidaEnvases, iCopias, False, True);

    DMBaseDatos.QListado.Cancel;
    DMBaseDatos.QListado.Close;

  except
    DMBaseDatos.QListado.Cancel;
    DMBaseDatos.QListado.Close;
    QRAlbaranSalidaEnvases.Free;
  end;
end;

function TDMAlbaranSalidaEnvases.GetFirmaFileName: string;
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

procedure TDMAlbaranSalidaEnvases.PutObservaciones( var ATexto: TStringList );
begin
  if QAlbaranC.FieldByname('n_cmr_sc').AsString <> '' then
  begin
    ATexto.Add('Nº CMR:' + QAlbaranC.FieldByname('n_cmr_sc').AsString);
  end;
  if QAlbaranC.FieldByname('n_orden_sc').AsString <> '' then
  begin
    ATexto.Add('Nº ORDEN CARGA:' + QAlbaranC.FieldByname('n_orden_sc').AsString);
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

procedure TDMAlbaranSalidaEnvases.PutPalets(var APalets: TStrings);
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

procedure TDMAlbaranSalidaEnvases.PutLogifruit(var ALogifruit: TStrings);
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
      Add(' select cod_producto_ecp codigo_caja_e, des_producto_ecp texto_caja_e, sum(cajas_sl) cajas_sl ');
      Add(' FROM frf_salidas_l, frf_envases, frf_env_comer_productos ');
      Add(' WHERE empresa_sl = :empresa ');
      Add('   AND centro_salida_sl = :centro ');
      Add('   AND n_albaran_sl = :albaran ');
      Add('   AND fecha_sl = :fecha ');
      Add('   and envase_e = envase_sl ');
      Add('   and producto_e = producto_sl');
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

function TDMAlbaranSalidaEnvases.DNITransporte(const AEmpresa, ATransporte: string): string;
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

function TDMAlbaranSalidaEnvases.Dir2Transporte(const AEmpresa, ATransporte: string): string;
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

function TDMAlbaranSalidaEnvases.Dir1Transporte(const AEmpresa, ATransporte: string): string;
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


end.
