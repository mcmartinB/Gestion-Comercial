unit MClientesAlm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs
  , Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestroDetalle, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid,  BDEdit,
  ComCtrls, BEdit,CVariables, derror, DBTables;

type
  TFMClientesAlm = class(TMaestroDetalle)
    PMaestroGlobal: TPanel;
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    DSDetalle: TDataSource;
    RejillaFlotante: TBGrid;
    PDetalle: TPanel;
    LDireccionD: TLabel;
    dir_sum_ds: TBDEdit;
    telefono_ds: TBDEdit;
    PRejilla: TPanel;
    RVisualizacion: TDBGrid;
    BtnUniFac: TBitBtn;
    Label22: TLabel;
    PMaestro: TPanel;
    LEmpresa_p: TLabel;
    cliente_c: TBDEdit;
    nombre_c: TBDEdit;
    QDirClientes: TQuery;
    QClientes: TQuery;
    TSuministros: TTable;
    TSuministroscliente_ds: TStringField;
    TSuministrosdir_sum_ds: TStringField;
    TSuministrosnombre_ds: TStringField;
    TSuministrostipo_via_ds: TStringField;
    TSuministrosdomicilio_ds: TStringField;
    TSuministroscod_postal_ds: TStringField;
    TSuministrospoblacion_ds: TStringField;
    TSuministrostelefono_ds: TStringField;
    TSuministrosprovincia_ds: TStringField;
    TSuministrosprovincia_esp_ds: TStringField;
    TSuministrospais_ds: TStringField;
    DSSuministros: TDataSource;
    Label2: TLabel;
    BGBtipo_via_c: TBGridButton;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    BGBpais_c: TBGridButton;
    Label10: TLabel;
    Label8: TLabel;
    Label5: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    tipo_via_c: TBDEdit;
    domicilio_c: TBDEdit;
    poblacion_c: TBDEdit;
    pais_c: TBDEdit;
    cod_postal_c: TBDEdit;
    STProvincia: TStaticText;
    STPais_c: TStaticText;
    telefono_c: TBDEdit;
    nif_c: TBDEdit;
    resp_compras_c: TBDEdit;
    es_comunitario_c: TDBCheckBox;
    n_copias_alb_c: TBDEdit;
    email_alb_c: TBDEdit;
    Label9: TLabel;
    moneda_c: TBDEdit;
    BGBmoneda_c: TBGridButton;
    STMoneda_c: TStaticText;
    telefono2_c: TBDEdit;
    Label28: TLabel;
    fax_c: TBDEdit;
    lbl1: TLabel;
    incoterm_c: TBDEdit;
    BGBincoterm_c: TBGridButton;
    stIncoterm: TStaticText;
    plaza_incoterm_c: TBDEdit;
    lbl2: TLabel;
    lbl6: TLabel;
    tipo_cliente_c: TBDEdit;
    btnTipoCliente: TBGridButton;
    txtTipoCliente: TStaticText;
    btnRecargo: TBitBtn;
    pnlPasarSGP: TPanel;
    grabrar_transporte_c: TDBCheckBox;
    des_tipo_albaran_c: TStaticText;
    tipo_albaran_c: TDBComboBox;
    strngfldTSuministrosnif_ds: TStringField;
    strngfldTSuministrosemail_ds: TStringField;
    lblNif: TLabel;
    nif_ds: TBDEdit;
    lblemail_ds: TLabel;
    email_ds: TBDEdit;
    strngfldTSuministrosdes_pais_ds: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure BtnUniFacClick(Sender: TObject);
    procedure DSMaestroDataChange(Sender: TObject; Field: TField);
    procedure DSDetalleDataChange(Sender: TObject; Field: TField);
    procedure TSuministrosCalcFields(DataSet: TDataSet);
    procedure incoterm_cChange(Sender: TObject);
    procedure btnRecargoClick(Sender: TObject);
    procedure pnlPasarSGPClick(Sender: TObject);
    procedure tipo_albaran_cChange(Sender: TObject);
    procedure QClientesAfterScroll(DataSet: TDataSet);
    procedure expediciones_cChange(Sender: TObject);
  private
    { Private declarations }
    ListaComponentes:TList;
    ListaDetalle:TList;
    Objeto:TObject;

    procedure VerDetalle;
    procedure EditarDetalle;
    procedure ValidarEntradaDetalle;
    procedure RellenaClaveDetalle;
    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;
    procedure PonPanelDetalle;
    procedure PonPanelMaestro;
    procedure CambioRegistro;

    procedure GetClienteBDRemota( const ABDRemota: string; const AAlta: Boolean );
    procedure BuscarCliente( const AEmpresa, ACliente: string );
    procedure RefrescarCliente;

  public
    { Public declarations }

    //SOBREESCRIBIR METODO
    procedure Altas; override;
    procedure Modificar; override;
    procedure Filtro;Override;
    procedure AnyadirRegistro;Override;

    procedure DetalleModificar; override;
    procedure DetalleAltas; override;

    procedure AntesDeInsertar;
    procedure AntesDeLocalizar;
    procedure AntesDeModificar;
    procedure AntesDeVisualizar;

    procedure TSuministrosBeforePost(DataSet: TDataSet);

    //Listado
    procedure Previsualizar;Override;

    procedure Restaurar;
  private

  end;

var
  estadoOld:TEstado;

implementation

uses CGestionPrincipal, UDMBaseDatos, DPreview, CAuxiliarDB, Principal,
     (*MClienteFact,*) LClientesAlm, UDMAuxDB, bSQLUtils, CReportes, Variants,
  CMaestro, CliEnvases, UDMConfig, SeleccionarTipoAltaFD, AdvertenciaFD,
  ImportarClientesFD, UDMMaster, RecargoClientesFD, CGlobal, UComerToSgpDM;

{$R *.DFM}

procedure TFMClientesAlm.AbrirTablas;
begin
     // Abrir tablas/Querys
     if not DataSetMaestro.Active then
     begin
         DataSetMaestro.SQL.Clear;
         DataSetMaestro.SQL.Add(Select);
         DataSetMaestro.SQL.Add(Where);
         DataSetMaestro.SQL.Add(Order);
         DataSetMaestro.Open;
     end;

     if not DataSourceDetalle.DataSet.Active then
         DataSourceDetalle.DataSet.Open;

     //Estado inicial
     Registros:=DataSetMaestro.RecordCount;
     if Registros>0 then
       Registro:=1
     else
       Registros:=0;
     RegistrosInsertados:=0;
end;

procedure TFMClientesAlm.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuery( QDirClientes);
  bnCloseQuerys( [DataSourceDetalle.DataSet, DataSetMaestro]);
end;

//************************** CREAMOS EL FORMULARIO ************************
procedure TFMClientesAlm.FormCreate(Sender: TObject);
var i:Integer;
begin
     LineasObligadas:=false;
     ListadoObligado:=false;
     //Titulo
     Self.Caption:='CLIENTES';

     //Variables globales
     M:=Self;
     MD:=Self;
     //Panel sobre el que iran los controles
     PanelMaestro:=PMaestro;
     PanelDetalle:=PDetalle;
     RejillaVisualizacion:=RVisualizacion;

     //Fuente de datos
{+}  DataSetMaestro:=QClientes;
     DataSourceDetalle:=DSDetalle;
     RVisualizacion.DataSource :=DSDetalle;
     //Intrucciones para sacar los datos (inicialmente consulta vacia)
{+}  Select := ' SELECT * FROM frf_clientes ';
{+}  where  := ' WHERE cliente_c=' + QuotedStr('###');
{+}  Order  := ' ORDER BY cliente_c ';
     //Abrir tablas/Querys
     try
        AbrirTablas;
     except
        on e:EDBEngineError do
        begin
             showError(e);
             Close;
             Exit;
        end;
     end;
     //Lista de componentes
     ListaComponentes:=TList.Create;
     ListaDetalle:=TList.Create;
     PMaestro.GetTabOrderList(ListaDetalle);
     for i:=0 to ListaDetalle.Count-1 do
     begin
          ListaComponentes.Add(ListaDetalle.Items[i]);
     end;
     PDetalle.GetTabOrderList(ListaDetalle);

     //Muestra la barra de herramientas de Maestro/Detalle
     if FormType <> CVariables.tfMaestroDetalle then
     begin
          FormType := CVariables.tfMaestroDetalle;
          BHFormulario;
     end;
     //Inicialmente grupo de desplazamiento deshabilitado
     BtnUniFac.Enabled:=false;
     btnRecargo.Enabled:=false;
     Visualizar;

     //Para intentar reducir el numero de veces que abrimos la consulta
     DMBaseDatos.QDespegables.Tag:=0;
     //Asignamos constantes a los componentes que los tienen
     //para facilitar distingirlos

     cod_postal_c.Tag:=kProvincia;
     //cod_postal_ds.Tag:=kProvincia;
     pais_c.Tag:=kPais;
     tipo_via_c.Tag:=kTipoVia;
     //tipo_via_ds.Tag:=kTipoVia;
     pais_c.Tag:=kPais;
     moneda_c.Tag:=kMoneda;
     incoterm_c.Tag := kIncoterm;
     tipo_cliente_c.Tag := kTipoCliente;

     //Validar entrada
     OnValidateMasterConstrains:=ValidarEntradaMaestro;
     OnValidateDetailConstrains:=ValidarEntradaDetalle;
     OnInsert:=AntesDeInsertar;
     OnEdit:=AntesDeModificar;
     OnBrowse:=AntesDeLocalizar;
     OnView:=AntesDeVisualizar;
     OnViewDetail:=VerDetalle;
     OnEditDetail:=EditarDetalle;
     OnChangeMasterRecord:=CambioRegistro;

     DSDetalle.DataSet.BeforePost:=TSuministrosBeforePost;

     //Focos
{+}   FocoAltas:=cliente_c;
{+}   FocoModificar:=cliente_c;
{+}   FocoLocalizar:=cliente_c;

     pnlPasarSGP.Visible:= DMConfig.EsLosLLanos or DMConfig.EsLaFontEx;
end;

procedure TFMClientesAlm.FormActivate(Sender: TObject);
begin
     //Si ho hemos conseguido abrir las tablas salimos
   Top:= 1;
   if not DataSourceDetalle.DataSet.Active then
      Exit
   else
   begin
     Restaurar;
   end;

end;

procedure TFMClientesAlm.Restaurar;
begin
     //Variables globales
     M:=Self;
     MD:=Self;
     gRF :=RejillaFlotante;
     RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
     gCF:=nil;


     PanelMaestro:=PMaestro;
     PanelDetalle:=PDetalle;
     RejillaVisualizacion:=RVisualizacion;
     {+}   FocoAltas:=cliente_c;
     {+}   FocoModificar:=nombre_c;
     {+}   FocoLocalizar:=cliente_c;

     //Muestra la barra de herramientas de Maestro/Detalle
     if FormType <> CVariables.tfMaestroDetalle then
     begin
          FormType := CVariables.tfMaestroDetalle;
          BHFormulario;
     end;
     //Inicialmente grupo de desplazamiento deshabilitado
     BHGrupoDesplazamientoMaestro(PCMaestro);
     BHGrupoDesplazamientoDetalle(PCDetalle);

     //Estado botones de desplamiento
     BHGrupoDesplazamientoMaestro(PCMaestro);
     //Barra de estado y barra de herramientas
     BEEstado;
     BHEstado;
end;


procedure TFMClientesAlm.FormDeactivate(Sender: TObject);
begin
     gRF:=nil;
     gCF:=nil;
end;

procedure TFMClientesAlm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ListaComponentes.Free;
  ListaDetalle.Free;
     //Variables globales
     gRF:=nil;
     gCF:=nil;

     //Codigo de desactivacion
     CerrarTablas;

     //Restauramos barra de herramientas si es necesario
     if FPrincipal.MDIChildCount = 1 then
     begin
        FormType:=tfDirector;
        BHFormulario;
     end;
     
     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
     Action := caFree;
end;

procedure TFMClientesAlm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{*} //Si la rejilla esta desplegada no hacemos nada
    if (RejillaFlotante<>nil) then
        if (RejillaFlotante.Visible) then
           //No hacemos nada
           Exit;

    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    //               y entre los Campos de Búsqueda en la localización
    case key of
         vk_Return,vk_down:
         begin
              Key := 0;
              PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
         end;
         vk_up:
         begin
              Key := 0;
              PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
         end;
    end;
end;

//*****************************************************************************
//*****************************************************************************
//En todos los formularios
//*****************************************************************************
//*****************************************************************************

//...................... FILTRO LOCALIZACION .........................
//function generica, tiene mucha importancia que los datos esten en campos
//que hereden de TBEdit y que se llamen igual que el campo al que representan
//en la base de datos
//....................................................................
procedure TFMClientesAlm.Filtro;
var Flag:Boolean;
    i:Integer;
begin
    where:='';Flag:=false;
    for i:=0 to ListaComponentes.Count-1 do
    begin
         Objeto:=ListaComponentes.Items[i];
         if (Objeto is TBEdit) then
         begin
              with Objeto as TBEdit do
              begin
                   if Trim(Text)<>'' then
                   begin
                        if flag then where:=where+' and ';
                        if InputType=itChar then
                           where:=where+' '+name+' LIKE '+SQLFilter(Text)
                        else
                        if InputType=itDate then
                           where:=where+' '+name+' ='+SQLDate(Text)
                        else
                           where:=where+' '+name+' ='+Text;
                        flag:=True;
                   end;
              end;
         end;
    end;

    if grabrar_transporte_c.State <> cbGrayed then
  begin
    if grabrar_transporte_c.State = cbUnchecked then
    begin
      if flag then
        where := where + ' and  grabrar_transporte_c = 0 '
      else
        where := ' grabrar_transporte_c = 0 ';
      flag:= True;
    end
    else
    begin
      if flag then
        where := where + ' and grabrar_transporte_c = 1 '
      else
        where := ' grabrar_transporte_c = 1 ';
      flag:= True;
    end;
  end;

  if tipo_albaran_c.Text <> '' then
  begin
      if flag then
        where := where + ' and  tipo_albaran_c = ' + tipo_albaran_c.Text
      else
        where := ' tipo_albaran_c = ' + tipo_albaran_c.Text;
      flag:= True;
  end;  

    if flag then where:=' WHERE '+where;
end;

//...................... REGISTROS INSERTADOS .........................
//function generica, tiene mucha importancia que los datos esten en campos
//que hereden de TBDEdit y que se llamen igual que el campo al que representan
//en la base de datos. Si quieres que salgan aqui pon a True la propiedad
// PrimaryKey del componente.
//....................................................................
procedure TFMClientesAlm.AnyadirRegistro;
var Flag:Boolean;
    i:Integer;
begin
    Flag:=false;
    if  where<>'' then where:=where+' OR ('
    else where:=' WHERE (';

    for i:=0 to ListaComponentes.Count-1 do
    begin
         objeto:=ListaComponentes.Items[i];
         if (objeto is TBDEdit) then
         begin
              with objeto as TBDEdit do
              begin
                   if PrimaryKey and (Trim(Text)<>'') then
                   begin
                        if flag then where:=where+' and ';
                        if InputType=itChar then
                           where:=where+' '+name+' ='+SQLFilter(Text)
                        else
                        if InputType=itDate then
                           where:=where+' '+name+' ='+SQLDate(Text)
                        else
                           where:=where+' '+name+' ='+Text;
                        flag:=True;
                   end;
              end;
         end;
    end;
    where:=where+') ';
end;

//...................... VALIDAR CAMPOS .........................
//function generica, tiene mucha importancia que los datos esten en campos
//que hereden de TBDEdit y que se llamen igual que el campo al que representan
//en la base de datos. Si quieres que salgan aqui pon a True la propiedad
// Required del componente y en RequiredMsg el mensaje que quieres mostrar
//....................................................................
// La funcion generica que realiza es comprobar que los campos que tienen
// datos por obligacion los tengan, en caso de querer hacer algo mas hay
// que implenentarlo, como comprobar la existencia de un valor en la base
// de datos
//....................................................................
procedure TFMClientesAlm.ValidarEntradaMaestro;
var i:Integer;
begin
    for i:=0 to ListaComponentes.Count-1 do
    begin
         Objeto:=ListaComponentes.Items[i];
         if (Objeto is TBEdit) then
         begin
               with Objeto as TBEdit do
               begin
                    if Required and (Trim(Text)='') then
                     begin
                          if Trim(RequiredMsg)<>'' then
                             raise Exception.Create(RequiredMsg)
                          else
                             raise Exception.Create('Faltan datos de obligada inserción.');
                          TBEdit(Objeto).setfocus;
                     end;

                end;
         end;
    end;
    if DataSeTMaestro.FieldByName('es_comunitario_c').AsString = '' then
    begin
      raise Exception.Create('Falta marcar si el cliente es o no comunitario.');
    end
    else
    begin
      if pais_c.Text <> '' then
      with DMAuxDB.QAux do
      begin
        SQL.Clear;
        SQL.Add( ' select case when comunitario_p = 1 then ''S'' else ''N'' end comu_p ');
        SQL.Add( ' from frf_paises ');
        SQL.Add( ' where pais_p = :pais ');
        ParamByName('pais').ASString:= pais_c.Text;
        Open;
        if FieldByName('comu_p').AsString <> DataSeTMaestro.FieldByName('es_comunitario_c').AsString then
        begin
          Close;
          if DataSeTMaestro.FieldByName('es_comunitario_c').AsString = 'S' then
          begin
            if MessageDlg( 'Ha indicado que el cliente es comunitario cuando ' +
                           pais_c.Text + ' - ' + STPais_c.Caption + 'es extracomunitario.' + #13 + #10 +
                           '¿Seguro que desea continuar?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then

             Abort;
          end
          else
          begin
            if MessageDlg( 'Ha indicado que el cliente es extracomunitario cuando ' +
                           pais_c.Text + ' - ' + STPais_c.Caption + 'es comunitario.' + #13 + #10 +
                           '¿Seguro que desea continuar?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
             Abort;
          end;
        end
        else
        begin
          Close;
        end;
      end;
    end;

  if ( grabrar_transporte_c.State = cbGrayed ) then
  begin
    grabrar_transporte_c.SetFocus;
    raise Exception.Create('Falta seleccionar si hay que grabar las facturas de portes del cliente (si el porte lo paga Bonnysa).');
  end;

  if Trim(incoterm_c.text) = '' then
  begin
    QClientes.FieldByname('incoterm_c').Value := NULL;
    QClientes.FieldByname('plaza_incoterm_c').Value := NULL;
  end;    
  if Trim( txtTipoCliente.caption ) = '' then
  begin
    tipo_cliente_c.SetFocus;
    raise Exception.Create('Falta el tipo de cliente o es incorrecto.');
  end;
//Restricciones
end;

procedure TFMClientesAlm.Previsualizar;
begin
     if DMBaseDatos.QGeneral.Active Then DMBaseDatos.QGeneral.Close;
     DMBaseDatos.QGeneral.SQL.Clear;
     DMBaseDatos.QGeneral.SQL.Add('SELECT *');
     DMBaseDatos.QGeneral.SQL.Add(' FROM frf_clientes ');
     DMBaseDatos.QGeneral.SQL.Add(Where);//Recojo las condiciones que se han introducido en la busqueda
     DMBaseDatos.QGeneral.SQL.Add(' ORDER BY cliente_c');
     try
       ConsultaOpen(DMBaseDatos.QGeneral,False,false);
       ConsultaOpen(QDirClientes,False,false);
     except
       Exit;
     end;
     try
        QRLClientesAlm:=TQRLClientesAlm.Create(Application);

        QRLClientesAlm.DataSet := DMBaseDatos.QGeneral;
        QRLClientesAlm.nombre_c.DataSet := DMBaseDatos.QGeneral;
        QRLClientesAlm.cliente_c.DataSet := DMBaseDatos.QGeneral;
        QRLClientesAlm.tipo_via_c.DataSet := DMBaseDatos.QGeneral;
        QRLClientesAlm.domicilio_c.DataSet := DMBaseDatos.QGeneral;
        QRLClientesAlm.nif_c.DataSet := DMBaseDatos.QGeneral;
        QRLClientesAlm.cod_postal_c.DataSet := DMBaseDatos.QGeneral;
        QRLClientesAlm.telefono_c.DataSet := DMBaseDatos.QGeneral;
        QRLClientesAlm.telefono2_c.DataSet := DMBaseDatos.QGeneral;
        QRLClientesAlm.fax_c.DataSet := DMBaseDatos.QGeneral;
        QRLClientesAlm.poblacion_c.DataSet := DMBaseDatos.QGeneral;
        QRLClientesAlm.es_comunitario_c.DataSet := DMBaseDatos.QGeneral;

        QRLClientesAlm.DSDescripciones.DataSet := DMBaseDatos.QGeneral;
        DSSuministros.DataSet:= DMBaseDatos.QGeneral;

        QRLClientesAlm.QRSubDetail.DataSet := QDirClientes;
        QRLClientesAlm.dir_sum_ds.DataSet := QDirClientes;
        QRLClientesAlm.nombre_ds.DataSet := QDirClientes;
        //QRLClientesAlm.cod_postal_ds.DataSet := QDirClientes;
        QRLClientesAlm.poblacion_ds.DataSet := QDirClientes;
        //QRLClientesAlm.tipo_via_ds.DataSet := QDirClientes;
        //QRLClientesAlm.domicilio_ds.DataSet := QDirClientes;
        QRLClientesAlm.telefono_ds.DataSet := QDirClientes;
        //QRLClientesAlm.provincia_ds.DataSet := QDirClientes;
        //QRLClientesAlm.pais_ds.DataSet := QDirClientes;

        ConsultaOpen(QRLClientesAlm.QDescripciones,false,false);
        PonLogoGrupoBonnysa(QRLClientesAlm);
        Preview(QRLClientesAlm);
     Finally
        DMBaseDatos.QGeneral.Close;
        QDirClientes.Close;
     End;
End;

//*****************************************************************************
//*****************************************************************************
//Funciones asociadas a la rejilla flotante
//Si no existe la rejilla flotante
//   - Borrar Lista de acciones
//   - Borrar las funciones de esta seccion
//*****************************************************************************
//*****************************************************************************

procedure TFMClientesAlm.ARejillaFlotanteExecute(Sender: TObject);
begin
     case ActiveControl.Tag of
          kTipoVia:
          begin
            DespliegaRejilla(BGBtipo_via_c);
            (*
               if ActiveControl=tipo_via_c then
                  DespliegaRejilla(BGBtipo_via_c)
               else
               if ActiveControl=tipo_via_ds then
                  DespliegaRejilla(BGBtipo_via_ds);
            *)
          end;
          kPais:
          begin
            DespliegaRejilla(BGBPais_c);
          end;
          kMoneda:DespliegaRejilla(BGBmoneda_c);
          kIncoterm: DespliegaRejilla(BGBincoterm_c);
    kTipoCliente:
    begin
      DespliegaRejilla(btnTipoCliente);
    end;
     end;
end;

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************
//Evento que se produce cuando pulsamos altas
//Aprobrechar para modificar estado controles
procedure TFMClientesAlm.AntesDeInsertar;
begin
     BtnUniFac.Enabled:=false;
     btnRecargo.Enabled:=false;
     //Rejilla en visualizacion
     VerDetalle;
     //Por defecto no hay descuento
     DataSeTMaestro.FieldByName('porc_dto_c').Value:= 0;
     DataSeTMaestro.FieldByName('edi_c').Value:= 'N';
     //DataSeTMaestro.FieldByName('es_comunitario_c').Value:= 'S';
     DataSeTMaestro.FieldByName('moneda_c').Value:= 'EUR';
     DataSeTMaestro.FieldByName('n_copias_alb_c').Value:= 3;

     grabrar_transporte_c.AllowGrayed:= False;
end;

procedure TFMClientesAlm.AntesDeLocalizar;
begin
     BtnUniFac.Enabled:=false;
     btnRecargo.Enabled:=false;
     //Rejilla en visualizacion
     VerDetalle;
     //Deshabilitar es comunitario
     es_comunitario_c.Enabled:=false;
  grabrar_transporte_c.AllowGrayed:= True;
end;

//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles
procedure TFMClientesAlm.AntesDeModificar;
var i:Integer;
begin
     BtnUniFac.Enabled:=false;
     btnRecargo.Enabled:=false;
    for i:=0 to ListaComponentes.Count-1 do
    begin
         Objeto:=ListaComponentes.Items[i];
         if (Objeto is TBDEdit) then
            with Objeto as TBDEdit do
                 if not Modificable then
                    Enabled:=false;
    end;
    //Guardar valores para ver si han sido modificados
    grabrar_transporte_c.AllowGrayed:= False;
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores
procedure TFMClientesAlm.AntesDeVisualizar;
var i:Integer;
begin
     if registros>0 then
     begin
        BtnUniFac.Enabled:=true;
        btnRecargo.Enabled:=True;
     end
     else
     begin
        BtnUniFac.Enabled:=false;
        btnRecargo.Enabled:=false;
     end;

   for i:=0 to ListaComponentes.Count-1 do
    begin
         Objeto:=ListaComponentes.Items[i];
         if (Objeto is TBDEdit) then
            with Objeto as TBDEdit do
                 if not Modificable then
                    Enabled:=true;
    end;
     //Habilitar es comunitario
     es_comunitario_c.Enabled:=True;
     STPais_c.Caption:=desPais(pais_c.Text);
end;

procedure TFMClientesAlm.VerDetalle;
var i:integer;
begin
//    if PageControl.ActivePage=TSDEtalle then
    for i:=0 to ListaDetalle.Count-1 do
    begin
         Objeto:=ListaDetalle.Items[i];
         if (Objeto is TBDEdit) then
         begin
            with Objeto as TBDEdit do
            begin
                 if Modificable=false then
                    Enabled:=true;
            end;
         end;
    end;

     //Vidualizar maestro
     PonPanelMaestro;
end;

procedure TFMClientesAlm.EditarDetalle;
var i:integer;
begin
     //Deshabilitamos boton de unidades de facturacion
     BtnUniFac.Enabled:=false;
     btnRecargo.Enabled:=false;
    if EstadoDetalle=tedModificar then
    for i:=0 to ListaDetalle.Count-1 do
    begin
         Objeto:=ListaDetalle.Items[i];
         if (Objeto is TBDEdit) then
         begin
            with Objeto as TBDEdit do
            begin
                 if Modificable=false then
                    Enabled:=false;
            end;
         end;
         FocoDetalle:=nif_ds;
    end
    else
       FocoDetalle:=dir_sum_ds;

     //Visdualizar detalle
     PonPanelDetalle;
end;


procedure TFMClientesAlm.expediciones_cChange(Sender: TObject);
begin

end;

//...................... VALIDAR CAMPOS .........................
//function generica, tiene mucha importancia que los datos esten en campos
//que hereden de TBDEdit y que se llamen igual que el campo al que representan
//en la base de datos. Si quieres que salgan aqui pon a True la propiedad
// Required del componente y en RequiredMsg el mensaje que quieres mostrar
//....................................................................
// La funcion generica que realiza es comprobar que los campos que tienen
// datos por obligacion los tengan, en caso de querer hacer algo mas hay
// que implenentarlo, como comprobar la existencia de un valor en la base
// de datos
//....................................................................
procedure TFMClientesAlm.ValidarEntradaDetalle;
var i:Integer;
begin
     //controlar que no hayan campos vacios y que se cumplan las restricciones que no
     //hemos implementado en la base de datos
    for i:=0 to ListaDetalle.Count-1 do
    begin
         Objeto:=ListaDetalle.Items[i];
         if (Objeto is TBDEdit) then
         begin
            with Objeto as TBDEdit do
            begin
                 if Required and (Trim(Text)='') then
                 begin
                      if Trim(RequiredMsg)<>'' then
                         raise Exception.Create(RequiredMsg)
                      else
                          raise Exception.Create('Faltan datos de obligada inserción.');
                      TBEdit(Objeto).setfocus;
                 end;
            end;
         end;
    end;

    //Completamos la clave primaria
    RellenaClaveDetalle;
end;

procedure TFMClientesAlm.RellenaClaveDetalle;
begin
     //cliente
     if Trim(cliente_c.Text)='' then
        raise Exception.Create('Faltan datos de la cabecera.');
     DataSourceDetalle.DataSet.FieldByName('cliente_ds').AsString:=
              cliente_c.Text;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TFMClientesAlm.RequiredTime(Sender: TObject;
  var isTime: Boolean);
begin
     isTime:=false;
     if TBEdit(Sender).CanFocus then
     begin
          if (Estado=teLocalizar) then
             Exit;
          if (gRF<>nil) and (gRf.Visible=true) then
               Exit;
{          if (gCF<>nil) and (gCf.Visible=true) then
               Exit;
}
          isTime:=true;
     end;
end;

procedure TFMClientesAlm.PonPanelDetalle;
begin
  (*
    //Valores de la cabecera
    STEmpresa.Caption:=empresa_c.Text+'-'+STEmpresa_c.Caption;
    if Trim(nombre_c.Text)<>'' then
    begin
         LCliente.Caption:=' Nombre Cliente';
         STCliente.Caption:=cliente_c.Text+'-'+nombre_c.Text;
    end
    else
    begin
         LCliente.Caption:=' Código Cliente';
         STCliente.Caption:=cliente_c.Text;
    end;

    if pais_c.Text='ES' then
    begin
      STProvinciaD.Enabled:=true;
      STProvinciaD.Visible:=true;
      provincia_ds.Enabled:=false;
      provincia_ds.Visible:=false;
      //cod_postal_ds.MaxLength:=5;
    end
    else
    begin
      STProvinciaD.Enabled:=False;
      STProvinciaD.Visible:=False;
      provincia_ds.Enabled:=true;
      provincia_ds.Visible:=true;
      //cod_postal_ds.MaxLength:=8;
    end;

    //Tamaños paneles
    PMaestroGlobal.Visible:=false;
    {PMaestro.Visible:=False;
    PageControl.Visible:=False;}

    //PDetalle.Visible:=true;
    //PDetalle.Height:=287;

    //Titulo
    Self.Caption:='DIRECCIONES DE SUMINISTRO';
  *)
end;

procedure TFMClientesAlm.PonPanelMaestro;
begin
    //Tamaños paneles
    //PDetalle.Visible:=false;
    //PDetalle.Height:=0;
    //PMaestroGlobal.Visible:=True;

    //Titulo
    Self.Caption:='CLIENTES';
    //Activar boton (si se puede) de unidades de facturacion
    if registros>0 then
    begin
      BtnUniFac.Enabled:=True;
      btnRecargo.Enabled:=True;
    end;
end;

Procedure TFMClientesAlm.BtnUniFacClick(Sender: TObject);
Begin
(*  if Estado = teConjuntoResultado Then
  begin
    Self.Enabled := False;
    TFMClienteFacturacion.Create(Self);
    //ShowWindow(Self.Handle,SW_HIDE);
  End;
*)
  if not QClientes.IsEmpty and (QClientes.State = dsBrowse) then
  begin
    EnvaseClientePorCliente (gsDefEmpresa, cliente_c.Text );
  end;
End;


//Evento que se produce cuando cambia el registro activo
//Tambien se genera cuando se muestra el primero
Procedure TFMClientesAlm.CambioRegistro;
Begin
     STPais_c.Caption:=desPais(pais_c.Text);
     If ((pais_c.Text<>'ES')) then
          STprovincia.Caption:=''
     Else STprovincia.Caption:=desProvincia(cod_postal_c.Text);
End;

procedure TFMClientesAlm.TSuministrosBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('pais_ds').AsString='' then
  begin
    DataSet.FieldByName('pais_ds').AsString:=pais_c.Text;
  end;
end;

procedure TFMClientesAlm.DSMaestroDataChange(Sender: TObject; Field: TField);
begin
  STPais_c.Caption:=desPais(pais_c.Text);
  STMoneda_c.Caption:=desMoneda(moneda_c.Text);
  txtTipoCliente.Caption:=desTipoCliente(tipo_cliente_c.Text );
  If (pais_c.Text='ES') then STprovincia.Caption:=desProvincia(cod_postal_c.Text)
  Else STprovincia.Caption:='';
  
  if not QClientes.IsEmpty and (QClientes.State = dsBrowse) then
  begin
    pnlPasarSGP.Font.Color := clBlue;
  end
  else
  begin
    pnlPasarSGP.Font.Color := clGray;
  end;
end;

procedure TFMClientesAlm.DSDetalleDataChange(Sender: TObject; Field: TField);
begin
  if TDataSource(Sender).DataSet.State in [dsEdit, dsInsert] then
  begin
    //STPaisD.Caption:= desPais(pais_ds.Text);
    //if pais_c.Text='ES' then
    //  STProvinciaD.Caption:= desProvincia(cod_postal_ds.Text);
  end;
end;

procedure TFMClientesAlm.TSuministrosCalcFields(DataSet: TDataSet);
begin
  if (DSMaestro.DataSet['pais_c']<>NULL) and
     (DSMaestro.DataSet['pais_c']='ES') and
     (DataSet['cod_postal_ds']<>NULL) then
  begin
     DataSet['provincia_esp_ds']:=NomProvincia(copy(DataSet['cod_postal_ds'],1,2),
                                             DSMaestro.DataSet['pais_c']);
  end
  else
  begin
    DataSet['provincia_esp_ds']:=DataSet['provincia_ds'];
  end;
  DataSet['des_pais_ds']:=DesPais( DataSet['pais_ds'] );
end;

procedure TFMClientesAlm.incoterm_cChange(Sender: TObject);
begin
  stIncoterm.Caption:= desIncoterm( incoterm_c.Text );
end;


procedure TFMClientesAlm.Altas;
var
  iTipo: Integer;
  sBD: string;
begin
  if DMConfig.EsLaFontEx then
  begin
    if DMBaseDatos.GetPermiso( gsCodigo, 'imp_cli_almacen' ) = 1 then
    begin
      if SeleccionarTipoAltaFD.SeleccionarTipoAlta( Self, iTipo, sBD ) = mrOk then
      begin
        case iTipo of
          0: inherited Altas;
          1: GetClienteBDRemota( sBD, True );
        end;
      end
    end
    else
    begin
      inherited Altas;
    end;
  end
  else
  begin
    begin
      if DMBaseDatos.AbrirConexionCentral then
      begin
        GetClienteBDRemota( 'BDCentral', True );
      end
      else
      begin
        if AdvertenciaFD.VerAdvertencia(Self, 'ATENCION: No se ha podido conectar con la central.' + #13 + #10 +
                                       'Recuerde que cualquier cambio que se realize debera realizarse tambien en la central.',
                                       'PERMITIR MODIFICACIONES EN BASE DE DATOS LOCAL',
                                       'Confirmo que quiero hacer altas locales', 'Nuevo Envase') = mrIgnore then
          inherited Altas;
      end;
    end;
  end;
end;


procedure TFMClientesAlm.Modificar;
var
  iTipo: Integer;
  sBD: string;
begin
  if DMConfig.EsLaFontEx then
  begin
    if DMBaseDatos.GetPermiso( gsCodigo, 'imp_cli_almacen' ) = 1 then
    begin
      if SeleccionarTipoAltaFD.SeleccionarTipoAlta( Self, iTipo, sBD,
                               '     SELECCIONAR TIPO ACTUALIZACIÓN', 'Editar Registro Local' ) = mrOk then
      begin
        case iTipo of
          0: inherited Modificar;
          1: GetClienteBDRemota( sBD, False );
        end;
      end
    end
    else
    begin
      inherited Modificar;
    end;
  end
  else
  begin
    begin
      if DMBaseDatos.AbrirConexionCentral then
      begin
        GetClienteBDRemota( 'BDCentral', False );
      end
      else
      begin
        if AdvertenciaFD.VerAdvertencia(Self, 'ATENCION: No se ha podido conectar con la central.' + #13 + #10 +
                                       'Cualquier cambio que realize debera realizarse tambien en la central.',
                                       'PERMITIR MODIFICACIONES EN BASE DE DATOS LOCAL',
                                       'Confirmo que quiero hacer modificaciones locales', 'Modificar Envase') = mrIgnore then
          inherited Modificar;
      end;
    end;
  end;
end;

procedure TFMClientesAlm.GetClienteBDRemota( const ABDRemota: string; const AAlta: Boolean );
var
  sEmpresa, sCliente: string;
  iValue: Integer;
  bAlta: Boolean;
begin
  sEmpresa:= gsDefEmpresa;
  if AAlta then
    sCliente:= ''
  else
    sCliente:= cliente_c.Text;
  bAlta:= AAlta;

  iValue:= ImportarCliente( Self, ABDRemota, sCliente, bAlta );
  case iValue of
      -1: //Operacion cancelada
          begin end;
       1: begin
            if bAlta then
            begin
              BuscarCliente( sEmpresa, sCliente );
              //ShowMessage('Alta de envase correcta.');
            end
            else
            begin
              RefrescarCliente;
              //ShowMessage('Modificación de envase correcta.');
            end;
          end;
       else ShowMessage('Error ' + IntToStr( iValue ) + ' al importar el artículo.');
  end;
end;

procedure TFMClientesAlm.BuscarCliente( const AEmpresa, ACliente: string );
begin
 {+}Select := ' SELECT * FROM frf_clientes ';
 {+}where := ' WHERE cliente_c=' + QuotedStr(ACliente);
 {+}Order := ' ORDER BY cliente_c ';

 QClientes.Close;
 AbrirTablas;
 Visualizar;
end;

procedure TFMClientesAlm.RefrescarCliente;
var
  myBookMark: TBookmark;
begin
  myBookMark:= QClientes.GetBookmark;
  QClientes.Close;
  QClientes.Open;
  QClientes.GotoBookmark(myBookMark);
  QClientes.FreeBookmark(myBookMark);
end;


procedure TFMClientesAlm.DetalleModificar;
begin
  if DMConfig.EsLaFontEx then
  begin
    inherited DetalleModificar;
  end
  else
  begin
    //inherited Altas;
    if DMBaseDatos.AbrirConexionCentral then
    begin
      GetClienteBDRemota( 'BDCentral', False );
    end
    else
    begin
      if AdvertenciaFD.VerAdvertencia(Self, 'ATENCION: No se ha podido conectar con la central.' + #13 + #10 +
                                       'Recuerde que cualquier cambio que se realize debera realizarse tambien en la central.',
                                       'PERMITIR MODIFICACIONES EN BASE DE DATOS LOCAL',
                                       'Confirmo que quiero hacer altas locales', 'Nuevo Envase') = mrIgnore then
        inherited DetalleModificar;
    end;
  end;
end;

procedure TFMClientesAlm.DetalleAltas;
begin
  if DMConfig.EsLaFontEx then
  begin
    inherited DetalleAltas;
  end
  else
  begin
    //inherited Altas;
    if DMBaseDatos.AbrirConexionCentral then
    begin
      GetClienteBDRemota( 'BDCentral', False );
    end
    else
    begin
      if AdvertenciaFD.VerAdvertencia(Self, 'ATENCION: No se ha podido conectar con la central.' + #13 + #10 +
                                       'Recuerde que cualquier cambio que se realize debera realizarse tambien en la central.',
                                       'PERMITIR MODIFICACIONES EN BASE DE DATOS LOCAL',
                                       'Confirmo que quiero hacer altas locales', 'Nuevo Envase') = mrIgnore then
        inherited DetalleAltas;
    end;
  end;
end;

procedure TFMClientesAlm.btnRecargoClick(Sender: TObject);
begin
  if not QClientes.IsEmpty and (QClientes.State = dsBrowse) then
  begin
    RecargoClientesFD.ExecuteRecargoClientes( self, gsDefEmpresa, cliente_c.Text );
  end;
end;

procedure TFMClientesAlm.pnlPasarSGPClick(Sender: TObject);
begin
  if not QClientes.IsEmpty and (QClientes.State = dsBrowse) then
  begin
    //Copiar envase en el SGP
    if UComerToSgpDM.PasarCliente( gsDefEmpresa, cliente_c.Text ) then
    begin
      ShowMessage('Programa finalizado con éxito.');
    end
    else
    begin
      ShowMessage('Error al pasar al SGP el cliente seleccionado.');
    end;
  end;
end;

procedure TFMClientesAlm.tipo_albaran_cChange(Sender: TObject);
begin
  //Descripcion tipo de albaran
  if tipo_albaran_c.Text = '0' then
    des_tipo_albaran_c.Caption:= 'SIN VALORAR'
  else
  if tipo_albaran_c.Text = '1' then
    des_tipo_albaran_c.Caption:= 'VALORADO'
  else
  if tipo_albaran_c.Text = '2' then
    des_tipo_albaran_c.Caption:= 'ALEMAN'
  else
  if tipo_albaran_c.Text = '3' then
    des_tipo_albaran_c.Caption:= 'INGLES'
  else
    des_tipo_albaran_c.Caption:= '';
end;

procedure TFMClientesAlm.QClientesAfterScroll(DataSet: TDataSet);
begin
  tipo_albaran_cChange(tipo_albaran_c);
end;

END.


