unit MProductos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs
  , Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  BCalendarButton, ComCtrls, BCalendario, BEdit, CVariables
  , DError, DBTables;

type
  TFMProductos = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    AProductos: TActionList;
    ARejillaFlotante: TAction;
    RejillaFlotante: TBGrid;
    LEmpresa_p: TLabel;
    empresa_p: TBDEdit;
    BGBEmpresa_p: TBGridButton;
    STEmpresa_p: TStaticText;
    Label13: TLabel;
    Lproducto_p: TLabel;
    producto_p: TBDEdit;
    Ldescripcion_p: TLabel;
    descripcion_p: TBDEdit;
    DSSize: TDataSource;
    DSCategory: TDataSource;
    DSColor: TDataSource;
    BtnCal: TBitBtn;
    BtnCat: TBitBtn;
    btnCol: TBitBtn;
    GCol: TDBGrid;
    GCat: TDBGrid;
    GCal: TDBGrid;
    CBCal: TCheckBox;
    CBCat: TCheckBox;
    chkPais: TCheckBox;
    descripcion2_p: TBDEdit;
    QProductos: TQuery;
    QColores: TQuery;
    QCategorias: TQuery;
    QCalibres: TQuery;
    QCalibresAux: TQuery;
    QCategoriasAux: TQuery;
    QColoresAux: TQuery;
    dsPaises: TDataSource;
    qryPaises: TQuery;
    qryPaisesAux: TQuery;
    btnPaises: TBitBtn;
    dbgrdPaises: TDBGrid;
    CBCol: TCheckBox;
    strngfldPaisesempresa_psp: TStringField;
    strngfldPaisesproducto_psp: TStringField;
    strngfldPaisespais_psp: TStringField;
    strngfldPaisesdes_pais: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure RequiredTime(Sender: TObject;
      var isTime: Boolean);
    procedure BtnCalClick(Sender: TObject);
    procedure btn_CategoryokClick(Sender: TObject);
    procedure btnColClick(Sender: TObject);
    procedure CBCalClick(Sender: TObject);
    procedure CBCatClick(Sender: TObject);
    procedure CBColClick(Sender: TObject);
    procedure QProductosBeforePost(DataSet: TDataSet);
    procedure producto_pExit(Sender: TObject);
    procedure QProductosAfterPost(DataSet: TDataSet);
    procedure QCalibresAfterPost(DataSet: TDataSet);
    procedure QCategoriasAfterPost(DataSet: TDataSet);
    procedure QColoresAfterPost(DataSet: TDataSet);
    procedure QCalibresBeforePost(DataSet: TDataSet);
    procedure btnPaisesClick(Sender: TObject);
    procedure qryPaisesAfterPost(DataSet: TDataSet);
    procedure chkPaisClick(Sender: TObject);
    procedure qryPaisesCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;
    bInsertar: boolean;

    procedure ValidarEntradaMaestro;
    procedure AntesDeBorrarMaestro;
    procedure SQLTablas;
    procedure AbrirTablas;
    procedure CerrarTablas;

  public
    { Public declarations }
    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    procedure AntesDeInsertar;
    procedure AntesDeModificar;
    procedure AntesDeVisualizar;
    procedure RestituirEstados();

    //Listado
    procedure Previsualizar; override;
  end;

//var
  //FMProductos: TFMProductos;

implementation

uses UDMAuxDB, CGestionPrincipal, UDMBaseDatos, Principal,
     LProducto, DPreview, CAuxiliarDB, CReportes, MPais,
     MCalibres, MCategoria, MColor, bSQLUtils, UDMConfig;

{$R *.DFM}

procedure TFMProductos.AbrirTablas;
begin
     // Abrir tablas/Querys
     // if not DataSetMaestro.Active then
  try
    DataSetMaestro.SQL.Clear;
    DataSetMaestro.SQL.Add(Select);
    DataSetMaestro.SQL.Add(Where);
    DataSetMaestro.SQL.Add(Order);
    DataSetMaestro.Open;
  except
         //Mensaje de error
    on E: EDBEngineError do
    begin
      ShowError(e);
      raise Exception.Create('No puedo abrir la tabla maestro.');
    end;
  end;

     //Estado inicial
  Registro := 1;
  Registros := DataSetMaestro.RecordCount;
  RegistrosInsertados := 0;
     {+}FocoAltas := empresa_p;
     {+}FocoModificar := descripcion_p;
     {+}FocoLocalizar := empresa_p;
end;

procedure TFMProductos.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([QColores, QCategorias, QCalibres, qryPaises,DataSetMaestro]);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMProductos.SQLTablas;
begin
  with QCalibres do
  begin
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM   frf_calibres Frf_calibres ');
    SQL.Add('WHERE  (empresa_c=:empresa_p) ');
    SQL.Add('AND    (producto_c=:producto_p) ');
    SQL.Add('ORDER BY calibre_c ');
  end;

  with QCategorias do
  begin
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM frf_categorias Frf_categorias ');
    SQL.Add('WHERE (empresa_c=:empresa_p) ');
    SQL.Add('AND   (producto_c=:producto_p) ');
    SQL.Add('ORDER BY categoria_c');
  end;

  with QColores do
  begin
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM   frf_colores Frf_color ');
    SQL.Add('WHERE  (empresa_c=:empresa_p) ');
    SQL.Add('AND    (producto_c=:producto_p) ');
    SQL.Add('ORDER BY color_c');
  end;

  with qryPaises do
  begin
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM   frf_paises_producto ');
    SQL.Add('WHERE  (empresa_psp=:empresa_p) ');
    SQL.Add('AND    (producto_psp=:producto_p) ');
    SQL.Add('ORDER BY pais_psp');
  end;

  (*BAG*)
  with QCalibresAux do
  begin
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM   frf_calibres  ');
  end;

  with QCategoriasAux do
  begin
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM frf_categorias  ');
  end;

  with QColoresAux do
  begin
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM   frf_colores  ');
  end;

  with qryPaisesAux do
  begin
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM   frf_paises_producto  ');
  end;
end;

procedure TFMProductos.FormCreate(Sender: TObject);
begin
  // INICIO
  //Variables globales
  M := Self;
  MD := nil;
     //Lista de componentes
  Lista := TList.Create;
  PMaestro.GetTabOrderList(Lista);

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
          //Fuente de datos maestro
 {+}DataSetMaestro := QProductos;

     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;
  PanelMaestro.Visible := false; {Hasta que no tengamos los datos}
     //Para intentar reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := 0;
     //Asignamos constantes a los componentes que los tienen
     //para facilitar distingirlos
  empresa_p.Tag := kEmpresa;

     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_productos ';
 {+}where := ' WHERE empresa_p=' + QuotedStr('###');
 {+}Order := ' ORDER BY empresa_p, producto_base_p, producto_p ';

     //Inicialmente grupo de desplazamiento deshabilitado
  BHGrupoDesplazamientoMaestro(pcNulo);

     //Aqui indicamos si va a existir la rejilla y/o el calendario flotante
  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := nil;
     //Desplegar(Self,439);
  if PanelMaestro.Visible = false then
    PanelMaestro.Visible := true;

  //Abrir tablas/Querys
  try
    SQLTablas;
    AbrirTablas;
    Visualizar;
  except
    Close;
    Exit;
  end;

  QCalibres.Open;
  QCategorias.Open;
  QColores.Open;
  qryPaises.Open;
     //Validar entrada
{+   Eliminar linea y funcion si no se va a usar }

  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnBrowse := AntesDeInsertar;
  OnView := AntesDeVisualizar;
  OnValidateMasterConstrains := ValidarEntradaMaestro;
  OnBeforeMasterDelete := AntesDeBorrarMaestro;

    // Focos
 {+}// FocoAltas:=ano_semana_p;
 {+}// FocoLocalizar:=ano_semana_p;
end;

{+ CUIDADIN }

procedure TFMProductos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Lista.Free;
     //Restauramos barra de herramientas
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

  //Codigo de desactivacion
  CerrarTablas;
 {*}//Por si acaso el nuevo form no necesita rejilla
  gRF := nil;
  gCF := nil;

     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
     //Desahabilitamos controles de Base de datos
     //mientras estamos desactivados
  DataSetMaestro.DisableControls;
  CerrarTablas;
end;

procedure TFMProductos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{*}//Si la rejilla esta desplegada no hacemos nada
  if (RejillaFlotante <> nil) then
    if (RejillaFlotante.Visible) then
           //No hacemos nada
      Exit;

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


{+}//Sustituir por funcion generica

procedure TFMProductos.Filtro;
var Flag: Boolean;
  i: Integer;
begin
  where := ''; Flag := false;
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBEdit) then
    begin
      with Objeto as TBEdit do
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
  if flag then where := ' WHERE ' + where;
end;

{+}//sustituir por funcion generica

procedure TFMProductos.AnyadirRegistro;
var Flag: Boolean;
  i: Integer;
begin
  Flag := false;
  if where <> '' then where := where + ' OR ('
  else where := ' WHERE (';

  for i := 0 to Lista.Count - 1 do
  begin
    objeto := Lista.Items[i];
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

{+}//Sustituir por funcion generica

procedure TFMProductos.AntesDeBorrarMaestro;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select * from frf_salidas_l ');
    SQL.Add(' where empresa_sl = :empresa ');
    SQL.Add(' and producto_sl = :producto ');
    ParamByName('empresa').AsString:= empresa_p.Text;
    ParamByName('producto').AsString:= producto_p.Text;
    Open;
    if not IsEmpty then
    begin
      Close;
      raise Exception.Create('No se puede borrar el producto, ya se han realizado ventas.');
    end;
    Close;
  end;

  if ( not QColores.IsEmpty ) or ( not QCategorias.IsEmpty ) or ( not QCalibres.IsEmpty ) or ( not qryPaises.IsEmpty ) then
  begin
    raise Exception.Create('No se puede borrar el producto, primero borre el detalle.');
  end;
end;

procedure TFMProductos.ValidarEntradaMaestro;
var
  i: Integer;
  sAux: string;
begin
 //Que no hayan campos vacios
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBEdit) then
    begin
      with Objeto as TBEdit do
      begin
        if Required and (Trim(Text) = '') then
        begin
          if Trim(RequiredMsg) <> '' then
            raise Exception.Create(RequiredMsg)
          else
            raise Exception.Create('Faltan datos de obligada inserción.');
        end;

      end;
    end;
  end;

  (*BAG*)
  //Buscar si esta grabado
  if Estado = teAlta then
  begin
    with DMAuxDB.QAux do
    begin
      SQL.Clear;
      SQL.Add(' select first 1 * ');
      SQL.Add(' from frf_productos ');
      SQL.Add(' where empresa_p = ' + QuotedStr( Trim( empresa_p.Text ) ) );
      SQL.Add(' and producto_p = ' + QuotedStr( Trim( producto_p.Text ) ) );
      Open;
      if not IsEmpty then
      begin
        sAux:= 'Producto duplicado. (' + Trim( empresa_p.Text ) + '-' + Trim( producto_p.Text ) + '-' + Trim( descripcion_p.Text )  + ').';
        Close;
        raise Exception.Create( sAux );
      end;
      Close;

      SQL.Clear;
      SQL.Add(' select first 1 * ');
      SQL.Add(' from frf_productos ');
      SQL.Add(' where empresa_p matches ''F*'' ');
      SQL.Add(' and producto_p = ' + QuotedStr( Trim( producto_p.Text ) ) );
      Open;
      if   not IsEmpty then
      begin
        if FieldByName('descripcion_p').AsString <> descripcion_p.Text then
        begin
          sAux:= 'Ya hay un producto con el mismo código y diferente descripción (' + FieldByName('descripcion_p').AsString + ').';
          Close;
          raise Exception.Create( sAux );
        end;
      end;
      Close;

      SQL.Clear;
      SQL.Add(' select first 1 * ');
      SQL.Add(' from frf_productos ');
      SQL.Add(' where empresa_p matches ''F*'' ');
      SQL.Add(' and descripcion_p = ' + QuotedStr( Trim( descripcion_p.Text ) ) );
      Open;
      if not IsEmpty then
      begin
        if FieldByName('producto_p').AsString <> producto_p.Text then
        begin
          sAux:= 'Ya hay un producto con la misma descripción y diferente código (' + FieldByName('producto_p').AsString + ').';
          Close;
          raise Exception.Create( sAux );
        end;
      end;
      Close;
    end;
  end;
end;

procedure TFMProductos.Previsualizar;
var
  marcador: TBookmark;
begin
  marcador := DSMaestro.DataSet.GetBookmark;
  //Crear el listado
  QRLProducto := TQRLProducto.Create(Application);
  PonLogoGrupoBonnysa(QRLProducto);

  QRLProducto.DataSet := QProductos;
  QRLProducto.ColorDataSet := QColores;
  QRLProducto.CalibreDataSet := QCalibres;
  QRLProducto.CategoriaDataSet := QCategorias;
  QRLProducto.PaisDataSet := qryPaises;

  Preview(QRLProducto);
  DSMaestro.DataSet.GotoBookmark(marcador);
  DSMaestro.DataSet.FreeBookmark(marcador);
end;

//*****************************************************************************
//*****************************************************************************
//Funciones asociadas a la rejilla flotante
//Si no existe la rejilla flotante
//   - Borrar Lista de acciones
//   - Borrar las funciones de esta seccion
//*****************************************************************************
//*****************************************************************************

procedure TFMProductos.ARejillaFlotanteExecute(Sender: TObject);
begin
  if empresa_p.Focused then
    DespliegaRejilla(BGBEmpresa_p);
end;

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************
//Evento que se produce cuando pulsamos altas
//Aprobrechar para modificar estado controles

procedure TFMProductos.AntesDeInsertar;
begin
  CBCal.Enabled := false;
  CBCat.Enabled := false;
  CBCol.Enabled := false;
  BtnCal.Enabled := false;
  BtnCat.Enabled := false;
  BtnCol.Enabled := false;
  GCal.Enabled := false;
  GCat.Enabled := false;
  GCol.Enabled := false;
end;

//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMProductos.AntesDeModificar;
var
  i: Integer;
begin
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := false;
  end;

  CBCal.Enabled := false;
  CBCat.Enabled := false;
  CBCol.Enabled := false;
  BtnCal.Enabled := false;
  BtnCat.Enabled := false;
  BtnCol.Enabled := false;
  GCal.Enabled := false;
  GCat.Enabled := false;
  GCol.Enabled := false;
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMProductos.AntesDeVisualizar;
var i: Integer;
begin
    //Resaturamos estado controles
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          if Enabled = false then Enabled := true;
  end;

  CBCal.Enabled := true;
  CBCat.Enabled := true;
  CBCol.Enabled := true;
  BtnCal.Enabled := true;
  BtnCat.Enabled := true;
  BtnCol.Enabled := true;
  GCal.Enabled := true;
  GCat.Enabled := true;
  GCol.Enabled := true;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TFMProductos.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  if TBEdit(Sender).Name = 'empresa_p' then
  begin
    STEmpresa_p.Caption := desEmpresa(empresa_p.text);
  end;
end;

procedure TFMProductos.RequiredTime(Sender: TObject;
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

procedure TFMProductos.BtnCalClick(Sender: TObject);
begin
  if Estado = teConjuntoResultado then
  begin
    TFMCalibre.Create(Self);
    self.Enabled := False;
  end;
end;

procedure TFMProductos.btn_CategoryokClick(Sender: TObject);
begin
  if Estado = teConjuntoResultado then
  begin
    TFMCategoria.Create(Self);
    self.Enabled := False;
  end;
end;

procedure TFMProductos.btnColClick(Sender: TObject);
begin
  if Estado = teConjuntoResultado then
  begin
    TFMColor.Create(Self);
    self.Enabled := False;
  end;
end;

procedure TFMProductos.btnPaisesClick(Sender: TObject);
begin
  if Estado = teConjuntoResultado then
  begin
    TFMPais.Create(Self);
    self.Enabled := False;
  end;
end;

procedure TFMProductos.RestituirEstados();
begin
  M := Self;
  MD := nil;
  gRF := RejillaFlotante;
  gCF := nil;
  BHEstado;
  BHGrupoDesplazamientoMaestro(PCMaestro);
end;

procedure TFMProductos.CBCalClick(Sender: TObject);
begin
  if CBCal.Checked then
  begin
    QCalibres.Open;
    BtnCal.Enabled := True;
    GCal.Color := clWhite;
    GCal.Enabled := true;
  end
  else
  begin
    QCalibres.Close;
    BtnCal.Enabled := False;
    GCal.Color := clSilver;
    GCal.Enabled := false;
  end;
end;

procedure TFMProductos.CBCatClick(Sender: TObject);
begin
  if CBCat.Checked then
  begin
    QCategorias.Open;
    BtnCat.Enabled := True;
    GCat.Color := clWhite;
    GCat.Enabled := true;
  end
  else
  begin
    QCategorias.Close;
    BtnCat.Enabled := False;
    GCat.Color := clSilver;
    GCat.Enabled := false;
  end;
end;

procedure TFMProductos.CBColClick(Sender: TObject);
begin
  if CBCol.Checked then
  begin
    QColores.Open;
    btnCol.Enabled := true;
    GCol.Color := clWhite;
    GCol.Enabled := true;
  end
  else
  begin
    QColores.Close;
    btnCol.Enabled := false;
    GCol.Color := clSilver;
    GCol.Enabled := false;
  end;
end;

procedure TFMProductos.chkPaisClick(Sender: TObject);
begin
  if chkPais.Checked then
  begin
    qryPaises.Open;
    btnPaises.Enabled := true;
    dbgrdPaises.Color := clWhite;
    dbgrdPaises.Enabled := true;
  end
  else
  begin
    qryPaises.Close;
    btnPaises.Enabled := false;
    dbgrdPaises.Color := clSilver;
    dbgrdPaises.Enabled := false;
  end;
end;

procedure TFMProductos.QProductosBeforePost(DataSet: TDataSet);
var
  iProducto: integer;
begin
  if Estado = teAlta then
  begin
    QProductos.FieldByName('estomate_p').AsString:= 'N';
    QProductos.FieldByName('tipo_liquida_p').AsString:= 'S';
    QProductos.FieldByName('socio_p').AsInteger:= 1;
    QProductos.FieldByName('tipo_iva_p').AsInteger:= 0;
    QProductos.FieldByName('valorar_entrega_por_kilos_p').AsInteger:= 1;
    //Insertar producto base

    with DMAuxDB.QAux do
    begin
      SQL.Clear;
      SQL.Add('select nvl( max( producto_base_pb ), 0 ) + 1 producto_base from frf_productos_base where empresa_pb = :empresa ' );
      ParamByName('empresa').AsString:= empresa_p.Text;
      Open;
      iProducto:= FieldByName('producto_base').AsInteger;
      QProductos.FieldByName('producto_base_p').AsInteger:= iProducto;
      Close;

      SQL.Clear;
      SQL.Add('insert into frf_productos_base ( empresa_pb, producto_base_pb, producto_pb, descripcion_pb, estomate_pb ) ');
      SQL.Add('                        values ( :empresa, :producto_base, :producto, :descripcion, :estomate )' );
      ParamByName('empresa').AsString:= empresa_p.Text;
      ParamByName('producto_base').AsInteger:= iProducto;
      ParamByName('producto').AsString:= producto_p.Text;
      ParamByName('descripcion').AsString:= descripcion_p.Text;
      ParamByName('estomate').AsString:= 'N';
      ExecSql;
    end;
  end;
end;

procedure TFMProductos.producto_pExit(Sender: TObject);
begin
  (*BAG*)
  //Buscar si esta grabado y rellenar datos
  if ( Trim( empresa_p.Text ) <> '' ) and ( Trim( producto_p.Text ) <> '' ) and ( Estado = teAlta ) then
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select first 1 * ');
    SQL.Add(' from frf_productos ');
    SQL.Add(' where empresa_p matches ''F*'' ');
    SQL.Add(' and producto_p = ' + QuotedStr( Trim( producto_p.Text )  ));

    Open;
    if not IsEmpty then
    begin
      if MessageDlg( 'Ya hay un producto con este código, ¿desea rellenar los campos de la ficha actual con sus datos?.' , mtWarning, [mbYes, mbNo], 0 ) = mrYes then
       begin
         descripcion_p.Text:= FieldByName('descripcion_p').AsString;
         descripcion2_p.Text:= FieldByName('descripcion2_p').AsString;
       end;
    end;
    Close;
  end;
end;

procedure TFMProductos.QProductosAfterPost(DataSet: TDataSet);
var
  sEmpresa: string;
begin
  (*BAG*)
  if Estado = teAlta then
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select first 1 * ');
    SQL.Add(' from frf_productos ');
    SQL.Add(' where empresa_p <> ' + QuotedStr( DataSet.FieldByName('empresa_p').AsString ) );
    SQL.Add(' and empresa_p matches ''F*'' ');
    SQL.Add(' and producto_p = ' + QuotedStr( DataSet.FieldByName('producto_p').AsString ) );
    Open;

    if not IsEmpty then
    begin
      sEmpresa:= FieldByName('empresa_p').AsString;
      Close;
      SQL.Clear;
      SQL.Add(' select * ');
      SQL.Add(' from frf_categorias ');
      SQL.Add(' where empresa_c = ' + QuotedStr( sEmpresa ) );
      SQL.Add(' and producto_c = ' + QuotedStr( DataSet.FieldByName('producto_p').AsString ) );
      Open;
      while not Eof do
      begin
        QCategorias.Insert;
        QCategorias.FieldByName('empresa_c').AsString:= DataSet.FieldByName('empresa_p').AsString;
        QCategorias.FieldByName('producto_c').AsString:= FieldByName('producto_c').AsString;
        QCategorias.FieldByName('categoria_c').AsString:= FieldByName('categoria_c').AsString;
        QCategorias.FieldByName('descripcion_c').AsString:= FieldByName('descripcion_c').AsString;
        QCategorias.Post;
        Next;
      end;
      Close;

      SQL.Clear;
      SQL.Add(' select * ');
      SQL.Add(' from frf_colores ');
      SQL.Add(' where empresa_c = ' + QuotedStr( sEmpresa ) );
      SQL.Add(' and producto_c = ' + QuotedStr( DataSet.FieldByName('producto_p').AsString ) );
      Open;
      while not Eof do
      begin
        QColores.Insert;
        QColores.FieldByName('empresa_c').AsString:= DataSet.FieldByName('empresa_p').AsString;
        QColores.FieldByName('producto_c').AsString:= FieldByName('producto_c').AsString;
        QColores.FieldByName('color_c').AsString:= FieldByName('color_c').AsString;
        QColores.FieldByName('descripcion_c').AsString:= FieldByName('descripcion_c').AsString;
        QColores.Post;
        Next;
      end;
      Close;

      SQL.Clear;
      SQL.Add(' select * ');
      SQL.Add(' from frf_paises_producto ');
      SQL.Add(' where empresa_psp = ' + QuotedStr( sEmpresa ) );
      SQL.Add(' and producto_psp = ' + QuotedStr( DataSet.FieldByName('producto_p').AsString ) );
      Open;
      while not Eof do
      begin
        qryPaises.Insert;
        qryPaises.FieldByName('empresa_psp').AsString:= DataSet.FieldByName('empresa_p').AsString;
        qryPaises.FieldByName('producto_psp').AsString:= FieldByName('producto_psp').AsString;
        qryPaises.FieldByName('pais_psp').AsString:= FieldByName('pais_psp').AsString;
        qryPaises.Post;
        Next;
      end;
      Close;


      SQL.Clear;
      SQL.Add(' select * ');
      SQL.Add(' from frf_calibres ');
      SQL.Add(' where empresa_c = ' + QuotedStr( sEmpresa ) );
      SQL.Add(' and producto_c = ' + QuotedStr( DataSet.FieldByName('producto_p').AsString ) );
      Open;
      while not Eof do
      begin
        QCalibres.Insert;
        QCalibres.FieldByName('empresa_c').AsString:= DataSet.FieldByName('empresa_p').AsString;
        QCalibres.FieldByName('producto_c').AsString:= FieldByName('producto_c').AsString;
        QCalibres.FieldByName('calibre_c').AsString:= FieldByName('calibre_c').AsString;
        QCalibres.FieldByName('medida_c').AsInteger:= FieldByName('medida_c').AsInteger;
        QCalibres.Post;
        Next;
      end;
      Close;
    end;
  end;
end;

procedure TFMProductos.QCalibresAfterPost(DataSet: TDataSet);
begin
  (*BAG*)
  if bInsertar  and ( Estado = teConjuntoResultado ) then
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_productos ');
    SQL.Add(' where empresa_p like ''F%'' ');
    SQL.Add(' and producto_p = ' + QuotedStr( DataSet.FieldByName('producto_c').AsString ) );
    SQL.Add(' and not exists ');
    SQL.Add(' ( ');
    SQL.Add('   select * ');
    SQL.Add('   from frf_calibres ');
    SQL.Add('   where empresa_c = empresa_p ');
    SQL.Add('   and producto_c = ' + QuotedStr( DataSet.FieldByName('producto_c').AsString ) );
    SQL.Add('   and calibre_c = ' + QuotedStr( DataSet.FieldByName('calibre_c').AsString ) );
    SQL.Add(' ) ');
    Open;

    if not IsEmpty then
    begin
      QCalibresAux.Open;
      while not Eof do
      begin
        QCalibresAux.Insert;
        QCalibresAux.FieldByName('empresa_c').AsString:= FieldByName('empresa_p').AsString;
        QCalibresAux.FieldByName('producto_c').AsString:= DataSet.FieldByName('producto_c').AsString;
        QCalibresAux.FieldByName('calibre_c').AsString:= DataSet.FieldByName('calibre_c').AsString;
        QCalibresAux.FieldByName('medida_c').AsString:= DataSet.FieldByName('medida_c').AsString;
        QCalibresAux.Post;
        Next;
      end;
      QCalibresAux.Close;
      Close;
    end;
  end;
end;

procedure TFMProductos.QCategoriasAfterPost(DataSet: TDataSet);
begin
  (*BAG*)
  if bInsertar and ( Estado = teConjuntoResultado ) then
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_productos ');
    SQL.Add(' where empresa_p like ''F%'' ');
    SQL.Add(' and producto_p = ' + QuotedStr( DataSet.FieldByName('producto_c').AsString ) );
    SQL.Add(' and not exists ');
    SQL.Add(' ( ');
    SQL.Add('   select * ');
    SQL.Add('   from frf_categorias ');
    SQL.Add('   where empresa_c = empresa_p ');
    SQL.Add('   and producto_c = ' + QuotedStr( DataSet.FieldByName('producto_c').AsString ) );
    SQL.Add('   and categoria_c = ' + QuotedStr( DataSet.FieldByName('categoria_c').AsString ) );
    SQL.Add(' ) ');
    Open;

    if not IsEmpty then
    begin
      QCategoriasAux.Open;
      while not Eof do
      begin
        QCategoriasAux.Insert;
        QCategoriasAux.FieldByName('empresa_c').AsString:= FieldByName('empresa_p').AsString;
        QCategoriasAux.FieldByName('producto_c').AsString:= DataSet.FieldByName('producto_c').AsString;
        QCategoriasAux.FieldByName('categoria_c').AsString:= DataSet.FieldByName('categoria_c').AsString;
        QCategoriasAux.FieldByName('descripcion_c').AsString:= DataSet.FieldByName('descripcion_c').AsString;
        QCategoriasAux.Post;
        Next;
      end;
      QCategoriasAux.Close;
      Close;
    end;
  end;
end;

procedure TFMProductos.QColoresAfterPost(DataSet: TDataSet);
begin
  (*BAG*)
  if bInsertar and ( Estado = teConjuntoResultado ) then
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_productos ');
    SQL.Add(' where empresa_p like ''F%'' ');
    SQL.Add(' and producto_p = ' + QuotedStr( DataSet.FieldByName('producto_c').AsString ) );
    SQL.Add(' and not exists ');
    SQL.Add(' ( ');
    SQL.Add('   select * ');
    SQL.Add('   from frf_colores ');
    SQL.Add('   where empresa_c = empresa_p ');
    SQL.Add('   and producto_c = ' + QuotedStr( DataSet.FieldByName('producto_c').AsString ) );
    SQL.Add('   and color_c = ' + QuotedStr( DataSet.FieldByName('color_c').AsString ) );
    SQL.Add(' ) ');
    Open;

    if not IsEmpty then
    begin
      QColoresAux.Open;
      while not Eof do
      begin
        QColoresAux.Insert;
        QColoresAux.FieldByName('empresa_c').AsString:= FieldByName('empresa_p').AsString;
        QColoresAux.FieldByName('producto_c').AsString:= DataSet.FieldByName('producto_c').AsString;
        QColoresAux.FieldByName('color_c').AsString:= DataSet.FieldByName('color_c').AsString;
        QColoresAux.FieldByName('descripcion_c').AsString:= DataSet.FieldByName('descripcion_c').AsString;
        QColoresAux.Post;
        Next;
      end;
      QColoresAux.Close;
      Close;
    end;
  end;
end;

procedure TFMProductos.qryPaisesAfterPost(DataSet: TDataSet);
begin
  (*BAG*)
  if bInsertar and ( Estado = teConjuntoResultado ) then
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_productos ');
    SQL.Add(' where empresa_p like ''F%'' ');
    SQL.Add(' and producto_p = ' + QuotedStr( DataSet.FieldByName('producto_psp').AsString ) );
    SQL.Add(' and not exists ');
    SQL.Add(' ( ');
    SQL.Add('   select * ');
    SQL.Add('   from frf_paises_producto ');
    SQL.Add('   where empresa_psp = empresa_p ');
    SQL.Add('   and producto_psp = ' + QuotedStr( DataSet.FieldByName('producto_psp').AsString ) );
    SQL.Add('   and pais_psp = ' + QuotedStr( DataSet.FieldByName('pais_psp').AsString ) );
    SQL.Add(' ) ');
    Open;

    if not IsEmpty then
    begin
      qryPaisesAux.Open;
      while not Eof do
      begin
        qryPaisesAux.Insert;
        qryPaisesAux.FieldByName('empresa_psp').AsString:= FieldByName('empresa_p').AsString;
        qryPaisesAux.FieldByName('producto_psp').AsString:= DataSet.FieldByName('producto_psp').AsString;
        qryPaisesAux.FieldByName('pais_psp').AsString:= DataSet.FieldByName('pais_psp').AsString;
        qryPaisesAux.Post;
        Next;
      end;
      qryPaisesAux.Close;
      Close;
    end;
  end;
end;

procedure TFMProductos.QCalibresBeforePost(DataSet: TDataSet);
begin
  bInsertar:=  ( DataSet.State = dsInsert );
end;

procedure TFMProductos.qryPaisesCalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('des_pais').AsString:= desPais( DataSet.FieldByName('pais_psp').AsString );
end;

end.
