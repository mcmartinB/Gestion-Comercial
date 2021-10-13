unit MEAN13_old;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs, Db,
  ExtCtrls, StdCtrls, DBCtrls, CMaestro, Buttons, BSpeedButton,
  DBGrids, BGridButton, BGrid, BDEdit, ComCtrls, Graphics,
  BEdit, DError, ActnList, Grids, DBTables;

type
  TFMEAN13_old = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    RejillaFlotante: TBGrid;
    LCodigo_e: TLabel;
    codigo_e: TBDEdit;
    LEnvase_e: TLabel;
    envase_e: TBDEdit;
    LProducto_e: TLabel;
    productop_e: TBDEdit;
    BGBProductop_e: TBGridButton;
    Label13: TLabel;
    ACampos: TAction;
    BGBEnvase_e: TBGridButton;
    LMarca_e: TLabel;
    LCalibre_e: TLabel;
    BGBMarca_e: TBGridButton;
    BGbCalibre_e: TBGridButton;
    marca_e: TBDEdit;
    calibre_e: TBDEdit;
    STEnvase_e: TStaticText;
    STMarca_e: TStaticText;
    LEmpresa_e: TLabel;
    empresa_e: TBDEdit;
    BGBEmpresa_e: TBGridButton;
    STEmpresa_e: TStaticText;
    Label1: TLabel;
    descripcion_e: TBDEdit;
    Label2: TLabel;
    descripcion2_e: TBDEdit;
    DBRGAgrupacion: TDBRadioGroup;
    QEan13: TQuery;
    DBMemo1: TDBMemo;
    descripcion_pb: TBDEdit;
    Label4: TLabel;
    Label5: TLabel;
    fecha_baja_e: TBDEdit;
    cbxVer: TComboBox;
    cbxAgrupacion: TComboBox;
    lbl1: TLabel;
    ean14_e: TBDEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject;
      var isTime: Boolean);
    procedure PonNombre(Sender: TObject);
    procedure codigo_eKeyPress(Sender: TObject; var Key: Char);
    procedure DBRGAgrupacionChange(Sender: TObject);
    procedure DBMemo1Enter(Sender: TObject);
    procedure DBMemo1Exit(Sender: TObject);
    procedure productop_eChange(Sender: TObject);
    procedure DSMaestroStateChange(Sender: TObject);
//    procedure ACamposExecute(Sender: TObject);
  private
    { Private declarations }
    ListaComponentes: TList;
    Objeto: TObject;

    oldEnvase: string; //Para controlar la insercion de envases dados de baja

    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;
    procedure Clonar;

    procedure GetEan13BDRemota( const ABDRemota: string; const AAlta: Boolean );
    procedure BuscarEnvase( const AEmpresa, AEan13: string );

  public
    { Public declarations }
    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    procedure AntesDeInsertar;
    procedure AntesDeModificar;
    procedure AntesDeVisualizar;
    procedure AntesDeLocalizar;

    //Listado
    procedure Previsualizar; override;

    procedure MiAlta;
    procedure Altas; override;
    procedure Modificar; override;

  end;

implementation

uses UDMAuxDB, CVariables, CGestionPrincipal, UDMBaseDatos, bCodeUtils,
  CAuxiliarDB, Principal, LEAN13_old, DPreview, bSQLUtils, CReportes,
  SeleccionarAltaClonarFD, UDMConfig, ImportarEan13FD, AdvertenciaFD;

{$R *.DFM}

procedure TFMEAN13_old.AbrirTablas;
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
     //Estado inicial
  Registros := DataSetMaestro.RecordCount;
  if Registros > 0 then
    Registro := 1
  else
    Registro := 0;
  RegistrosInsertados := 0;
end;

procedure TFMEAN13_old.CerrarTablas;
begin
  if DMBaseDatos.QDespegables.Active then
    DMBaseDatos.QDespegables.Tag := 0;
      //Cerramos todos los dataSet abiertos
  DMBaseDatos.DBBaseDatos.CloseDataSets;
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMEAN13_old.FormCreate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

     //***************************************************************
     //Fuente de datos maestro
     //CAMBIAR POR LA QUERY QUE LE TOQUE
 {+}DataSetMaestro := QEan13;
     //***************************************************************

     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_ean13 ';
 {+}where := ' WHERE codigo_e=' + QuotedStr('###');
 {+}Order := ' ORDER BY codigo_e ';
     //Abrir tablas/Querys
  try
    AbrirTablas;
  except
    on e: EDBEngineError do
    begin
      ShowError(e);
      Close;
      Exit;
    end;
  end;

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
     //Visualizar estado inicial
  Visualizar;

//DESCOMENTAR SI USAMOS REJILLA FLOTANTE
     //Para intentar reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := kNull;

//RELLENAR, CONSTANTES EN CVariables
     //Asignamos constantes a los componentes que los tienen
     //para facilitar distingirlos
  empresa_e.Tag := kEmpresa;
  productop_e.Tag := kProducto;
  descripcion_pb.Tag := kProducto;
  envase_e.Tag := kEnvaseProducto;
  marca_e.Tag := kMarca;
  calibre_e.Tag := kCalibre;

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
//DEJAR LAS QUE SEAN NECESARIAS
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnView := AntesDeVisualizar;
  OnBrowse := AntesDeLocalizar;

     //Focos
  FocoAltas := codigo_e;
  FocoModificar := empresa_e;
  FocoLocalizar := codigo_e;

{*     //Inicializar variables
     CalendarioFlotante.Date:=Date;
}

  ListaComponentes := TList.Create;
  PMaestro.GetTabOrderList(ListaComponentes);
end;

procedure TFMEAN13_old.FormActivate(Sender: TObject);
begin
     //Si la tabla no esta abierta salimos
  if not DataSetMaestro.Active then Exit;
     //Variables globales
  M := Self;
  MD := nil;
//DEJAR LAS NECESARIAS
  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
//     gCF:=CalendarioFlotante;


     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
     //Estado botones de desplamiento
  BHGrupoDesplazamientoMaestro(PCMaestro);
end;


procedure TFMEAN13_old.FormDeactivate(Sender: TObject);
begin
{*DEJAR LAS QUE TENIAN VALOR
   //Por si acaso el nuevo form no necesita rejilla
   gRF:=nil;
   gCF:=nil;
}
end;

procedure TFMEAN13_old.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ListaComponentes.Free;

     //Restauramos barra de herramientas
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
     //Codigo de desactivacion
  CerrarTablas;

{*DEJAR LAS QUE TENIAN VALOR
     //Por si acaso el nuevo form no necesita rejilla
     gRF:=nil;
     gCF:=nil;
}
     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMEAN13_old.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//DEJAR SI EXISTE REJILLA
    //Si la rejilla esta desplegada no hacemos nada
  if (RejillaFlotante <> nil) then
    if (RejillaFlotante.Visible) then
           //No hacemos nada
      Exit;


{*DEJAR SI EXISTE CALENDARIO
    //Si  el calendario esta desplegado no hacemos nada
    if (CalendarioFlotante<>nil) then
         if (CalendarioFlotante.Visible) then
            //No hacemos nada
            Exit;
}

    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    //               y entre los Campos de Búsqueda en la localización
  case key of
    vk_Return, vk_down:
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
//function generica, no tocar si no es estrictamente necesario
//Construye el select que extrae los registros que concuerdan
//con los capos que hemos rellenado

procedure TFMEAN13_old.Filtro;
var Flag: Boolean;
  i: Integer;
begin
  where := ''; Flag := false;
  for i := 0 to ListaComponentes.Count - 1 do
  begin
    Objeto := ListaComponentes.Items[i];
    if (Objeto is TBEdit) then
    begin
      with Objeto as TBEdit do
      begin
        if Name <> 'descripcion_pb' then
        begin
          if Trim(Text) <> '' then
          begin
            if flag then where := where + ' and ';
            if InputType = itChar then
              where := where + ' ' + name + ' LIKE ' + SQLFilter(Text)
            else
              if InputType = itDate then
                where := where + ' ' + name + ' =' + SQLDate(Text)
              else
                where := where + ' ' + name + ' =' + SQLNumeric(Text);
            flag := True;
          end;
        end;
      end;
    end;
  end;

  if cbxVer.ItemIndex <> 0 then
  begin
    if flag then
      where := where + ' and ';
    flag := true;

    if cbxVer.ItemIndex = 1 then
      where := where + ' fecha_baja_e is null'
    else
      where := where + ' fecha_baja_e is not null';
  end;

  if cbxAgrupacion.ItemIndex <> 0 then
  begin
    if flag then
      where := where + ' and ';
    flag := true;

    case cbxAgrupacion.ItemIndex of
      1: where := where + ' agrupacion_e = 1';
      2: where := where + ' agrupacion_e = 2';
      3: where := where + ' agrupacion_e = 3';
    end;
  end;

  if flag then where := ' WHERE ' + where;
end;

//function generica, no tocar si no es estrictamente necesario
//Construye el select que extrae los registros que son insertados
//para, else fin usa los campos que marcamos como PrimaryKey

procedure TFMEAN13_old.AnyadirRegistro;
var Flag: Boolean;
  i: Integer;
begin
  Flag := false;
  if where <> '' then where := where + ' OR ('
  else where := ' WHERE (';

  for i := 0 to ListaComponentes.Count - 1 do
  begin
    objeto := ListaComponentes.Items[i];
    if (objeto is TBDEdit) then
    begin
      with objeto as TBDEdit do
      begin
        if PrimaryKey and (Trim(Text) <> '') then
        begin
          if flag then where := where + ' and ';
          if InputType = itChar then
            where := where + ' ' + name + ' =' + SQLFilter(Text)
          else
            if InputType = itDate then
              where := where + ' ' + name + ' =' + SQLDate(Text)
            else
              where := where + ' ' + name + ' =' + Text;
          flag := True;
        end;
      end;
    end;
  end;
  where := where + ') ';
end;


//function semi-generica, introducir restricciones particulares donde se indica
//Conprueba que tengan valor todos los campos marcados como required

procedure TFMEAN13_old.ValidarEntradaMaestro;
var i: Integer; //,aux
begin
    //Que no hayan campos vacios
  for i := 0 to ListaComponentes.Count - 1 do
  begin
    Objeto := ListaComponentes.Items[i];
    if (Objeto is TBEdit) then
    begin
      with Objeto as TBEdit do
      begin
        if Required and (Trim(Text) = '') then
        begin
          if Trim(RequiredMsg) <> '' then
            raise Exception.Create(RequiredMsg)
          else
            raise Exception.Create('Dato necesario.');
        end;

      end;
    end;
  end;

    //**************************************************************
    //REstricciones Particulares
    //**************************************************************
    //Codigo ean 13 valido
  if DigitoControlEAN13(codigo_e.Text) = False then
  begin
    raise Exception.Create('Código EAN13 no válido.');
  end;

    //el envase no debe estar de baja
  if  ( Envase_e.Tag = kEnvaseProducto ) and ( oldEnvase <> envase_e.Text ) then
    with DMBaseDatos.QAux do
    begin
      Close;
      SQL.Clear;
      SQl.Add(' Select * from frf_envases ');
      SQl.Add(' where envase_e = ' + QuotedStr( envase_e.Text ) );
      SQl.Add('   and producto_e = ' + QuotedStr( productop_e.Text ) );
      SQl.Add('   and fecha_baja_e is  null ');
      Open;
      if IsEmpty then
      begin
        Close;
        raise Exception.Create('Envase inexistente o de baja.');
      end;
      Close;
    end;
end;

//**************************************************************
//IMPRESION: Introducir QuickReport
//**************************************************************

procedure TFMEAN13_old.Previsualizar;
var
  sAux: string;
begin
     //Crear el listado
  try
    with DMBaseDatos.QListado do
    begin
      if Active then
      begin
        Cancel;
        Close;
      end;
      SQL.Clear;
      SQL.Add('SELECT e13.codigo_e, e13.descripcion_e, e13.empresa_e, emp.nombre_e,' +
        ' e13.productop_e, descripcion_p, e13.calibre_e, e13.marca_e ,' +
        ' descripcion_m, e13.agrupacion_e, e13.envase_e ' +
        ' FROM   frf_ean13 e13, frf_empresas emp, frf_productos, frf_marcas ');

      if where <> '' then
      begin
        sAux := StringReplace(where, 'empresa_e', 'e13.empresa_e', [rfReplaceAll, rfIgnoreCase]);
        SQL.Add(sAux + ' and ');
      end
      else
        SQL.Add(' where ');
      SQL.Add(' emp.empresa_e = e13.empresa_e ' +
        ' AND    producto_p = productop_e ' +
        ' AND    codigo_m = e13.marca_e ' +
        ' ORDER BY e13.empresa_e, e13.productop_e, e13.codigo_e ');
      try
        Open;
        RecordCount;
      except
        MessageDlg('Error al crear el listado.', mtError, [mbOK], 0);
        Exit;
      end;
    end;
    QRLEan13_old := TQRLEan13_old.Create(Application);
    PonLogoGrupoBonnysa(QRLEan13_old);
    Preview(QRLEan13_old);
  finally
    DMBaseDatos.QListado.Cancel;
    DMBaseDatos.QListado.Close;                                                  
  end;
end;

//*****************************************************************************
//*****************************************************************************
//Funciones asociadas a la rejilla flotante
//Si no existe la rejilla flotante
//   - Borrar rejilla flotante (Formulario)
//   - Borrar Lista de acciones(Formulario)
//   - Borrar las funciones de esta seccion(Codigo)
//*****************************************************************************
//*****************************************************************************

procedure TFMEAN13_old.ARejillaFlotanteExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa_e);
    kProducto: DespliegaRejilla(BGBproductop_e, [empresa_e.Text]);
          //**************************************************
          //ahora va a depender de la agrupacion que este seleccionada
          //habra que buscar en la tabla de envases, unidades de consumo o tipo palets
    kEnvaseProducto: DespliegaRejilla(BGBEnvase_e, [empresa_e.Text,   productop_e.Text]);
    kTipoPalet: DespliegaRejilla(BGBEnvase_e);
    kTipoUnidad: DespliegaRejilla(BGBEnvase_e);
          //**************************************************
    kMarca: DespliegaRejilla(BGBMarca_e, [marca_e.Text]);
    kCalibre: DespliegaRejilla(BGBCalibre_e, [empresa_e.Text, productop_e.Text]);
  end;
end;

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************
//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMEAN13_old.AntesDeInsertar;
begin
  DBRGAgrupacion.ItemIndex:= 1;
  QEan13.FieldByName('agrupacion_e').AsInteger:= 2;
end;

procedure TFMEAN13_old.AntesDeModificar;
var i: Integer;
begin
    //Deshabilitamos todos los componentes Modificable=False
  for i := 0 to ListaComponentes.Count - 1 do
  begin
    Objeto := ListaComponentes.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := false;
  end;
end;

procedure TFMEAN13_old.AntesDeLocalizar;
begin
  cbxVer.ItemIndex := 0;
  cbxVer.Enabled := True;

  cbxAgrupacion.ItemIndex:= 0;
  cbxAgrupacion.Visible:= True;
  DBRGAgrupacion.Enabled:= False;
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMEAN13_old.AntesDeVisualizar;
var i: Integer;
begin
    //Resaturamos estado controles
  for i := 0 to ListaComponentes.Count - 1 do
  begin
    Objeto := ListaComponentes.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          if Enabled = false then Enabled := true;
  end;
  STMarca_e.Caption := desMarca(marca_e.Text);

  cbxAgrupacion.Visible:= False;
  DBRGAgrupacion.Enabled:= True;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TFMEAN13_old.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa:
      begin
        STEmpresa_e.Caption := desEmpresa(empresa_e.Text);
        descripcion_pb.text := desProducto(empresa_e.Text, productop_e.Text);
        PonNombre( envase_e );
      end;
          //**************************************************
          //ahora va a depender de la agrupacion que este seleccionada
          //habra que buscar en la tabla de envases, unidades de consumo o tipo palets
    kTipoPalet: STEnvase_e.Caption := desTipoPalet( envase_e.text );
    kEnvaseProducto: STEnvase_e.Caption := desEnvase(empresa_e.Text, envase_e.Text);
    kTipoUnidad: STEnvase_e.Caption := desTipoUnidad(empresa_e.text, envase_e.text,productop_e.Text);
          //**************************************************
    kMarca: STMarca_e.Caption := desMarca(marca_e.text);
  end;
end;

//Para saber cuando tenemos que obligar a que un campo sea requerido

procedure TFMEAN13_old.RequiredTime(Sender: TObject;
  var isTime: Boolean);
begin
  isTime := false;
  if TBEdit(Sender).CanFocus then
  begin
    if (Estado = teLocalizar) then
      Exit;
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
    isTime := true;
  end;
end;

procedure TFMEAN13_old.codigo_eKeyPress(Sender: TObject; var Key: Char);
begin
  if ((key < '0') or (key > '9')) and (key <> char(vk_back)) then
  begin
    Key := char(0);
  end;
end;

procedure TFMEAN13_old.DBRGAgrupacionChange(Sender: TObject);
begin
  //cambiar caption etiqueta de envase
  case DBRGAgrupacion.ItemIndex of
    -1: begin
        LEnvase_e.Caption := ' Artículo ';
        Envase_e.Tag := kEnvaseProducto;
        envase_e.MaxLength:= 9;
      end;
    0: begin
        LEnvase_e.Caption := ' Unidad Consumo ';
        Envase_e.Tag := kTipoUnidad;
        envase_e.MaxLength:= 3;
      end;
    1: begin
        LEnvase_e.Caption := ' Artículo ';
        Envase_e.Tag := kEnvaseProducto;
        envase_e.MaxLength:= 9;
      end;
    2: begin
        LEnvase_e.Caption := ' Tipo Palet ';
        Envase_e.Tag := kTipoPalet;
        envase_e.MaxLength:= 2;
        if ( QEan13.State in [dsInsert, dsEdit] ) and ( Length(envase_e.text) > 2 ) then
        begin
          envase_e.text:= copy( envase_e.text, 2 , 3 );
        end;
      end;
  end;
end;

procedure TFMEAN13_old.DBMemo1Enter(Sender: TObject);
begin
  keypreview := false;
end;

procedure TFMEAN13_old.DBMemo1Exit(Sender: TObject);
begin
  keypreview := true;
end;

procedure TFMEAN13_old.productop_eChange(Sender: TObject);
begin
  //buscar descripcion
  descripcion_pb.text := desProducto(empresa_e.Text, productop_e.Text);
end;

procedure TFMEAN13_old.DSMaestroStateChange(Sender: TObject);
begin
  if DSMaestro.State = dsEdit then
    oldEnvase := envase_e.Text
  else
    oldEnvase := '';
end;

procedure TFMEAN13_old.MiAlta;
var
  iTipo: Integer;
begin
  if QEan13.IsEmpty then
  begin
    inherited Altas;
  end
  else
  begin
    if Estado <> teAlta then
    begin
      if SeleccionarAltaClonarFD.SeleccionarTipoAlta( Self, iTipo ) = mrOk then
      begin
        if iTipo = 0 then
        begin
          inherited Altas;
        end
        else
        begin
          Clonar;
        end;
      end;
    end
    else
    begin
      Clonar;
    end;
  end;
end;

procedure TFMEAN13_old.BuscarEnvase( const AEmpresa, AEan13: string );
begin
 {+}Select := ' SELECT * FROM frf_ean13 ';
 {+}where := ' WHERE empresa_e=' + QuotedStr(AEmpresa) +
             ' and codigo_e=' + QuotedStr(AEan13);
 {+}Order := ' ORDER BY empresa_e, codigo_e, envase_e ';

 QEan13.Close;
 AbrirTablas;
 Visualizar;
end;

procedure TFMEAN13_old.GetEan13BDRemota( const ABDRemota: string; const AAlta: Boolean );
var
  sEmpresa, sEan13: string;
  iValue: Integer;
begin
  sEmpresa:= empresa_e.Text;
  if AAlta then
    sEan13:= ''
  else
    sEan13:= codigo_e.Text;

  iValue:= ImportarEan13( Self, ABDRemota, sEmpresa, sEan13 );
  case iValue of
      -1: //Operacion cancelada
          begin end;
       1: begin
            BuscarEnvase( sEmpresa, sEan13 );
          end;
       else ShowMessage('Error ' + IntToStr( iValue ) + ' al importar el artículo.');
  end;
end;

procedure TFMEAN13_old.Modificar;
begin
  if DMConfig.EsLaFontEx then
  begin
    inherited Modificar;
  end
  else
  begin
    //inherited Modificar;
    if DMBaseDatos.AbrirConexionCentral then
    begin
      GetEan13BDRemota( 'BDCentral', False );
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

procedure TFMEAN13_old.Altas;
begin
  if DMConfig.EsLaFontEx then
  begin
    MiAlta;
  end
  else
  begin
    //inherited Altas;
    if DMBaseDatos.AbrirConexionCentral then
    begin
      GetEan13BDRemota( 'BDCentral', True );
    end
    else
    begin
      if AdvertenciaFD.VerAdvertencia(Self, 'ATENCION: No se ha podido conectar con la central.' + #13 + #10 +
                                       'Recuerde que cualquier cambio que se realize debera realizarse tambien en la central.',
                                       'PERMITIR MODIFICACIONES EN BASE DE DATOS LOCAL',
                                       'Confirmo que quiero hacer altas locales', 'Nuevo Envase') = mrIgnore then
        MiAlta;
    end;
  end;
end;

procedure TFMEAN13_old.Clonar;
var
  sCodigo, sEmpresa, sProducto, sMarca, sDescripcion, sNotas, sEnvase, sFecha: string;
  iAgrupa: Integer;
begin
  sCodigo:= codigo_e.Text;
  sEmpresa:= empresa_e.Text;
  sProducto:= productop_e.Text;
  sMarca:= marca_e.Text;
  //sCalibre:= calibre_e.Text;
  sDescripcion:= descripcion_e.Text;
  sNotas:= QEan13.FieldByName('descripcion2_e').AsString;
  sEnvase:= envase_e.Text;
  sFecha:= fecha_baja_e.Text;
  iAgrupa:= DBRGAgrupacion.itemIndex;

  inherited Altas;

  codigo_e.Text:= sCodigo;
  empresa_e.Text:= sEmpresa;
  productop_e.Text:= sProducto;
  marca_e.Text:= sMarca;
  //calibre_e.Text:= sCalibre;
  descripcion_e.Text:= sDescripcion;

  QEan13.FieldByName('descripcion2_e').AsString:= sNotas;
  descripcion2_e.Text:= sNotas;
  DBMemo1.Text:= sNotas;

  envase_e.Text:= sEnvase;
  fecha_baja_e.Text:= sFecha;
  DBRGAgrupacion.itemIndex:= iAgrupa;
end;


end.
