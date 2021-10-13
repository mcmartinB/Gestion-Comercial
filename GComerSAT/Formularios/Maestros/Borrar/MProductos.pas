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
    estomate_p: TDBRadioGroup;
    DSSize: TDataSource;
    DSCategory: TDataSource;
    DSColor: TDataSource;
    DSEjercicios: TDataSource;
    BtnCal: TBitBtn;
    BtnCat: TBitBtn;
    btnCol: TBitBtn;
    BtnEje: TBitBtn;
    GEje: TDBGrid;
    GCat: TDBGrid;
    GCal: TDBGrid;
    CBCal: TCheckBox;
    CBCat: TCheckBox;
    CBCol: TCheckBox;
    CBEje: TCheckBox;
    descripcion2_p: TBDEdit;
    QEjercicios: TQuery;
    QProductos: TQuery;
    QColor: TQuery;
    QCategorias: TQuery;
    QCalibres: TQuery;
    STProductoBase: TStaticText;
    es_propio_p: TDBCheckBox;
    tipo_liquida_p: TDBRadioGroup;
    btnVariedad: TBitBtn;
    gridVariedad: TDBGrid;
    chkVariedad: TCheckBox;
    GCol: TDBGrid;
    qryVariedad: TQuery;
    dsVariedad: TDataSource;
    producto_base_p: TBDEdit;
    lblBase: TLabel;
    btnBase: TBGridButton;
    pnlPasarSGP: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    edtdescripcion2_p: TBDEdit;
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
    procedure BtnEjeClick(Sender: TObject);
    procedure CBCalClick(Sender: TObject);
    procedure CBCatClick(Sender: TObject);
    procedure CBColClick(Sender: TObject);
    procedure CBEjeClick(Sender: TObject);
    procedure btnVariedadClick(Sender: TObject);
    procedure chkVariedadClick(Sender: TObject);
    procedure pnlPasarSGPClick(Sender: TObject);
    procedure DSMaestroDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;

    procedure ValidarEntradaMaestro;
    procedure AntesDeBorrarMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;

  public
    { Public declarations }
    procedure Borrar; override;
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

uses UDMAuxDB, CGestionPrincipal, UDMBaseDatos,
  Principal, LProducto, DPreview, CAuxiliarDB, CReportes,
  MCalibres, MCategoria, MColor, MEjercicios, bSQLUtils, UDMConfig,
  MProductosVariedad,UComerToSgpDM;

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
  bnCloseQuerys([QEjercicios, QColor, qryVariedad, QCategorias, QCalibres, DataSetMaestro]);
end;

//************************** CREAMOS EL FORMULARIO ************************

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
  producto_base_p.Tag := kProductoBase;

     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_productos ';
 {+}where := ' WHERE empresa_p=' + QuotedStr('###');
 {+}Order := ' ORDER BY empresa_p, producto_base_p, producto_p ';

 with QCalibres do
 begin
   SQL.Clear;
   SQL.Add(' SELECT empresa_c,producto_c,calibre_c ');
   SQL.Add(' FROM   frf_calibres Frf_calibres ');
   SQL.Add(' WHERE  (empresa_c=:empresa_p) ');
   SQL.Add(' AND    (producto_c=:producto_p) ');
   SQL.Add(' ORDER BY calibre_c ');
 end;
 with QCategorias do
 begin
   SQL.Clear;
   SQL.Add(' SELECT * ');
   SQL.Add(' FROM frf_categorias Frf_categorias ');
   SQL.Add(' WHERE (empresa_c=:empresa_p) ');
   SQL.Add(' AND   (producto_c=:producto_p) ');
   SQL.Add(' ORDER BY categoria_c ');
 end;
 with QColor do
 begin
   SQL.Clear;
   SQL.Add(' SELECT empresa_c,producto_c,color_c,descripcion_c ');
   SQL.Add(' FROM   frf_colores Frf_color ');
   SQL.Add(' WHERE  (empresa_c=:empresa_p) ');
   SQL.Add(' AND    (producto_c=:producto_p) ');
   SQL.Add(' ORDER BY color_c ');
 end;
 with qryVariedad do
 begin
   SQL.Clear;
   SQL.Add(' SELECT empresa_pv,producto_pv,codigo_pv,descripcion_pv ');
   SQL.Add(' FROM   frf_productos_variedad ');
   SQL.Add(' WHERE  (empresa_pv=:empresa_p) ');
   SQL.Add(' AND    (producto_pv=:producto_p) ');
   SQL.Add(' ORDER BY codigo_pv ');
 end;
 with QEjercicios do
 begin
   SQL.Clear;
   SQL.Add(' SELECT empresa_e, producto_e, centro_e, ejercicio_e ');
   SQL.Add(' FROM frf_ejercicios Frf_ejercicios ');
   SQL.Add(' WHERE   (empresa_e =:empresa_p)    ');
   SQL.Add('    AND  (producto_e =:producto_p) ');
   SQL.Add(' ORDER BY empresa_e, producto_e, centro_e, ejercicio_e ');
 end;


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
    AbrirTablas;
    Visualizar;
  except
    Close;
    Exit;
  end;

  QCalibres.Open;
  QCategorias.Open;
  QColor.Open;
  qryVariedad.Open;
  QEjercicios.Open;
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

  pnlPasarSGP.Visible:= DMConfig.EsLosLLanos or DMConfig.EsLaFontEx;
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

procedure TFMProductos.Borrar;
var emp, prod: string;
  botonPulsado: Word;
begin
  if not AbrirTransaccion(DMBaseDatos.DBBaseDatos) then
    Exit;

  Estado := teBorrar;
  BEEstado;
  BHEstado;
  botonPulsado := MessageDlg('¿Desea borrar la ficha seleccionada?',
    mtConfirmation, [mbYes, mbNo], 0);
  if botonPulsado = mrYes then
    emp := QuotedStr(empresa_p.Text);
  prod := QuotedStr(producto_p.Text);
  try
    QCalibres.Close;
    QCategorias.Close;
    QColor.Close;
    qryVariedad.Close;
    QEjercicios.Close;
    DMBaseDatos.QGeneral.SQL.Clear;
    DMBaseDatos.QGeneral.SQL.Add('DELETE FROM frf_calibres ');
    DMBaseDatos.QGeneral.SQL.Add('WHERE  empresa_c  =' + emp);
    DMBaseDatos.QGeneral.SQL.Add('And    producto_c =' + prod);
    DMBaseDatos.QGeneral.ExecSQL;
    DMBaseDatos.QGeneral.SQL.Clear;
    DMBaseDatos.QGeneral.SQL.Add('DELETE FROM frf_categorias ');
    DMBaseDatos.QGeneral.SQL.Add('WHERE  empresa_c  =' + emp);
    DMBaseDatos.QGeneral.SQL.Add('And    producto_c =' + prod);
    DMBaseDatos.QGeneral.ExecSQL;
    DMBaseDatos.QGeneral.SQL.Clear;
    DMBaseDatos.QGeneral.SQL.Add('DELETE FROM frf_colores ');
    DMBaseDatos.QGeneral.SQL.Add('WHERE  empresa_c  =' + emp);
    DMBaseDatos.QGeneral.SQL.Add('And    producto_c =' + prod);
    DMBaseDatos.QGeneral.ExecSQL;
    DMBaseDatos.QGeneral.SQL.Clear;
    DMBaseDatos.QGeneral.SQL.Add('DELETE FROM frf_productos_variedad ');
    DMBaseDatos.QGeneral.SQL.Add('WHERE  empresa_pv  =' + emp);
    DMBaseDatos.QGeneral.SQL.Add('And    producto_pv =' + prod);
    DMBaseDatos.QGeneral.ExecSQL;
    DMBaseDatos.QGeneral.SQL.Clear;
    DMBaseDatos.QGeneral.SQL.Add('DELETE FROM frf_ejercicios ');
    DMBaseDatos.QGeneral.SQL.Add('WHERE  empresa_e  =' + emp);
    DMBaseDatos.QGeneral.SQL.Add('And    producto_e =' + prod);
    DMBaseDatos.QGeneral.ExecSQL;
    DataSeTMaestro.Delete;
    if Registro = Registros then Registro := Registro - 1;
    Registros := Registros - 1;
    AceptarTransaccion(DMBaseDatos.DBBaseDatos);
  except
    on E: EDBEngineerror do
    begin
      QCalibres.Open;
      QCategorias.Open;
      QColor.Open;
      qryVariedad.Open;
      QEjercicios.Open;
      CancelarTransaccion(DMBaseDatos.DBBaseDatos);
      Visualizar;
      ShowError(e);
    end;
  end;
  QCalibres.Open;
  QCategorias.Open;
  QColor.Open;
  qryVariedad.Open;
  QEjercicios.Open;
  Visualizar;
end;

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

procedure TFMProductos.ValidarEntradaMaestro;
var i: Integer;
begin
    //Que no hayan campos vacios
  if estomate_p.value = '' then
  begin
    estomate_p.SetFocus;
    raise Exception.Create('Faltan datos de obligada inserción.');
  end;
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
  QRLProducto.EjercicioDataSet := QEjercicios;
  QRLProducto.ColorDataSet := QColor;
  QRLProducto.VariedadDataSet := qryVariedad;
  QRLProducto.CalibreDataSet := QCalibres;
  QRLProducto.CategoriaDataSet := QCategorias;

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
    DespliegaRejilla(BGBEmpresa_p)
  else
  if producto_base_p.Focused then
    DespliegaRejilla(btnBase, [empresa_p.Text])
end;

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************
//Evento que se produce cuando pulsamos altas
//Aprobrechar para modificar estado controles

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

  if ( not qryVariedad.IsEmpty ) or ( not QColor.IsEmpty ) or ( not QCategorias.IsEmpty ) or ( not QCalibres.IsEmpty ) or ( not QEjercicios.IsEmpty ) then
  begin
    raise Exception.Create('No se puede borrar el producto, primero borre el detalle.');
  end;
end;

procedure TFMProductos.AntesDeInsertar;
begin
  if Estado = teLocalizar then
  begin
    estomate_p.Enabled := false;
    tipo_liquida_p.Enabled := false;
  end
  else
  begin
    estomate_p.ItemIndex := 1;
    estomate_p.Field.AsString := 'N';
    tipo_liquida_p.ItemIndex:= 1;
    tipo_liquida_p.Field.AsString := 'E';
    es_propio_p.Checked:= False;
    es_propio_p.Field.AsString := '0';
  end;

  CBCal.Enabled := false;
  CBCat.Enabled := false;
  CBCol.Enabled := false;
  chkVariedad.Enabled := false;
  CBEje.Enabled := false;
  BtnCal.Enabled := false;
  BtnCat.Enabled := false;
  BtnCol.Enabled := false;
  btnVariedad.Enabled := false;
  BtnEje.Enabled := false;
  GCal.Enabled := false;
  GCat.Enabled := false;
  GCol.Enabled := false;
  gridVariedad.Enabled := false;
  GEje.Enabled := false;

end;

//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMProductos.AntesDeModificar;
var
  i: Integer;
  position: integer;
begin
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := false;
  end;

  estomate_p.Enabled := true;
  tipo_liquida_p.Enabled := true;  

  CBCal.Enabled := false;
  CBCat.Enabled := false;
  CBCol.Enabled := false;
  chkVariedad.Enabled := false;
  CBEje.Enabled := false;
  BtnCal.Enabled := false;
  BtnCat.Enabled := false;
  BtnCol.Enabled := false;
  btnVariedad.Enabled := false;
  BtnEje.Enabled := false;
  GCal.Enabled := false;
  GCat.Enabled := false;
  GCol.Enabled := false;
  gridVariedad.Enabled := false;
  GEje.Enabled := false;

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

  estomate_p.Enabled := true;
  tipo_liquida_p.Enabled := true;

  CBCal.Enabled := true;
  CBCat.Enabled := true;
  CBCol.Enabled := true;
  chkVariedad.Enabled := true;
  CBEje.Enabled := true;
  BtnCal.Enabled := true;
  BtnCat.Enabled := true;
  BtnCol.Enabled := true;
  btnVariedad.Enabled := true;
  BtnEje.Enabled := true;
  GCal.Enabled := true;
  GCat.Enabled := true;
  GCol.Enabled := true;
  gridVariedad.Enabled := true;
  GEje.Enabled := true;

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
    producto_base_p.Change;
  end
  else
  if TBEdit(Sender).Name = 'producto_base_p' then
  begin
    STProductoBase.Caption := desProductoBase(empresa_p.text, producto_base_p.Text );
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

procedure TFMProductos.RestituirEstados();
begin
  M := Self;
  MD := nil;
  gRF := RejillaFlotante;
  gCF := nil;
  BHEstado;
  BHGrupoDesplazamientoMaestro(PCMaestro);
end;

procedure TFMProductos.BtnEjeClick(Sender: TObject);
begin
  if Estado = teConjuntoResultado then
  begin
    TFMEjercicios.Create(Self);
    self.Enabled := False;
  end;
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
    QColor.Open;
    btnCol.Enabled := true;
    GCol.Color := clWhite;
    GCol.Enabled := true;
  end
  else
  begin
    QColor.Close;
    btnCol.Enabled := false;
    GCol.Color := clSilver;
    GCol.Enabled := false;
  end;
end;

procedure TFMProductos.CBEjeClick(Sender: TObject);
begin
  if CBEje.Checked then
  begin
    QEjercicios.Open;
    BtnEje.Enabled := true;
    GEje.Color := clWhite;
    GEje.Enabled := true;
  end
  else
  begin
    QEjercicios.Close;
    BtnEje.Enabled := false;
    GEje.Color := clSilver;
    GEje.Enabled := false;
  end;
end;

procedure TFMProductos.btnVariedadClick(Sender: TObject);
begin
  if Estado = teConjuntoResultado then
  begin
    TFMProductosVariedad.Create(Self);
    self.Enabled := False;
  end;
end;

procedure TFMProductos.chkVariedadClick(Sender: TObject);
begin
  if chkVariedad.Checked then
  begin
    qryVariedad.Open;
    btnVariedad.Enabled := true;
    gridVariedad.Color := clWhite;
    gridVariedad.Enabled := true;
  end
  else
  begin
    qryVariedad.Close;
    btnVariedad.Enabled := false;
    gridVariedad.Color := clSilver;
    gridVariedad.Enabled := false;
  end;
end;

procedure TFMProductos.pnlPasarSGPClick(Sender: TObject);
begin
  if not QProductos.IsEmpty and (QProductos.State = dsBrowse) then
  begin
    //Copiar envase en el SGP
    if UComerToSgpDM.PasarProducto( empresa_p.Text, producto_p.Text ) then
    begin
      ShowMessage('Programa finalizado con éxito.');
    end
    else
    begin
      ShowMessage('Error al pasar al SGP el producto seleccionado.');
    end;
  end;
end;

procedure TFMProductos.DSMaestroDataChange(Sender: TObject; Field: TField);
begin
  if not QProductos.IsEmpty and (QProductos.State = dsBrowse) then
  begin
    pnlPasarSGP.Font.Color := clBlue;
  end
  else
  begin
    pnlPasarSGP.Font.Color := clGray;
  end;
end;

end.
