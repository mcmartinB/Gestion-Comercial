unit PrecioLiquidacion;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs, Db, ExtCtrls,
  StdCtrls, Mask, DBCtrls, CMaestro, Buttons, ActnList, BSpeedButton, Grids,
  DBGrids, BGridButton, BGrid, BDEdit, ComCtrls, BEdit, dbTables, nbLabels;

type
  TFPrecioLiquidacion = class(TMaestro)
    DSMaestro: TDataSource;
    QPrecioLiquidacion: TQuery;
    PMaestro: TPanel;
    lblEmpresa: TLabel;
    lblEnvse: TLabel;
    lbAnyo: TLabel;
    empresa_pl: TBDEdit;
    producto_pl: TBDEdit;
    anyo_semana_pl: TBDEdit;
    des_empresa: TnbStaticText;
    des_producto: TnbStaticText;
    dgbCostes: TDBGrid;
    qGuia: TQuery;
    dsGuia: TDataSource;
    lblGeneral: TLabel;
    precio_kg_pl: TBDEdit;
    lbl2: TLabel;
    lblProducto: TLabel;
    proveedor_pl: TBDEdit;
    des_proveedor: TnbStaticText;
    lbl3: TLabel;
    categoria_pl: TBDEdit;
    des_categoria: TnbStaticText;
    lbl1: TLabel;
    des_variedad: TnbStaticText;
    QPrecioLiquidacionempresa_pl: TStringField;
    QPrecioLiquidacionproveedor_pl: TStringField;
    iQPrecioLiquidacionanyo_semana_pl: TIntegerField;
    QPrecioLiquidacionproducto_pl: TStringField;
    QPrecioLiquidacioncategoria_pl: TStringField;
    iQPrecioLiquidacionvariedad_pl: TIntegerField;
    QPrecioLiquidacionprecio_kg_pl: TFloatField;
    QPrecioLiquidaciondes_producto: TStringField;
    QPrecioLiquidaciondes_categoria: TStringField;
    QPrecioLiquidaciondes_variedad: TStringField;
    variedad_pl: TBDEdit;
    sqluGuia: TUpdateSQL;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject; var isTime: Boolean);
    procedure empresa_plChange(Sender: TObject);
    procedure proveedor_plChange(Sender: TObject);
    procedure QPrecioLiquidacionCalcFields(DataSet: TDataSet);
    procedure qGuiaAfterOpen(DataSet: TDataSet);
    procedure qGuiaBeforeClose(DataSet: TDataSet);
    procedure producto_plChange(Sender: TObject);
    procedure categoria_plChange(Sender: TObject);
    procedure variedad_plChange(Sender: TObject);
    procedure QPrecioLiquidacionAfterPost(DataSet: TDataSet);

  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;

    sEmpresa, sProveedor, sAnyoSemana: string;

    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;

    procedure AnyadirRegistroTotal;

  public
    { Public declarations }
    bPrimerAlta: boolean;
    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    procedure AntesDeLocalizar;
    procedure AntesDeModificar;
    procedure AntesDeVisualizar;
    procedure AntesDeInsertar;

    //Listado
    procedure Previsualizar; override;
  end;

implementation

uses CVariables, CGestionPrincipal, UDMBaseDatos, UDMAuxDB, CReportes,
  CAuxiliarDB, Principal, DError, bSQLUtils, bTimeUtils,
  bDialogs;

{$R *.DFM}

procedure TFPrecioLiquidacion.AbrirTablas;
begin
     // Abrir tablas/Querys
  if not DataSetMaestro.Active then
  begin
    DataSetGuia.SQL.Clear;
    DataSetGuia.SQL.Add(Select);
    DataSetGuia.SQL.Add(Where);
    DataSetGuia.SQL.Add(Order);
    DataSetGuia.Open;
  end;
     //Estado inicial
  Registros := DataSetGuia.RecordCount;
  if registros > 0 then
    Registro := 1
  else
    Registro := 0;
  RegistrosInsertados := 0;
end;

procedure TFPrecioLiquidacion.CerrarTablas;
begin
     // Cerrar tabla
  if DataSetGuia.Active then DataSetGuia.Close;
end;



//************************** CREAMOS EL FORMULARIO ************************

procedure TFPrecioLiquidacion.FormCreate(Sender: TObject);
begin
  des_empresa.Caption := '';
  des_proveedor.Caption := '';
  des_producto.Caption := '';
  des_categoria.Caption := '';
  des_variedad.Caption := '';

  bPrimerAlta := true;

     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;
  PMaestro.Height:= 150;

     //Fuente de datos maestro
    DataSetGuia := qGuia;
 {+}DataSetMaestro := QPrecioLiquidacion;
     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT empresa_pl, proveedor_pl, anyo_semana_pl FROM frf_precio_liquidacion ';
 {+}where := ' WHERE empresa_pl=' + QuotedStr('###');
 {+}Order := ' GROUP BY empresa_pl, proveedor_pl, anyo_semana_pl ' +
             ' ORDER BY empresa_pl, proveedor_pl, anyo_semana_pl ';
     //Abrir tablas/Querys
  try
    AbrirTablas;
        //Habilitamos controles de Base de datos
  except
    on e: Exception do
    begin
      ShowError(e);
      Close;
      Exit;
    end;
  end;

     //Lista de componentes
  Lista := TList.Create;
  PMaestro.GetTabOrderList(Lista);

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
  Visualizar;
     //Inicialmente grupo de desplazamiento deshabilitado
  BHGrupoDesplazamientoMaestro(pcNulo);

     //Para intentar reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := kNull;
     //Asignamos constantes a los componentes que los tienen
     //para facilitar distingirlos
//     empresa_t.Tag:=kEmpresa;

     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
  OnEdit := AntesDeModificar;
  OnBrowse:=AntesDeLocalizar;
  OnView := AntesDeVisualizar;
  OnInsert := AntesDeInsertar;
     //Focos
  {+}FocoAltas := empresa_pl;
  {+}FocoModificar := precio_kg_pl;
  {+}FocoLocalizar := empresa_pl;

end;

{+ CUIDADIN }

procedure TFPrecioLiquidacion.FormActivate(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_SHOWNORMAL);
  if not DataSetMaestro.Active then Exit;
     //Formulario activo
  M := self;
  MD := nil;

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
     //Estado botones de desplamiento
  BHGrupoDesplazamientoMaestro(PCMaestro);
  Top:= 1;
end;


procedure TFPrecioLiquidacion.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //Liberamos recursos
  Lista.Free;

     //Restauramos barra de herramientas
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
     //Codigo de desactivacion
  CerrarTablas;

     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFPrecioLiquidacion.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
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

procedure TFPrecioLiquidacion.Filtro;
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
          if flag then where := where + ' AND ';
          if InputType = itChar then
            where := where + ' ' + Name + ' LIKE ' + SQLFilter(Text)
          else
            where := where + ' ' + Name + ' =' + QUOTEDSTR(Text);
          flag := True;
        end;
      end;
    end;
  end;
  if flag then where := ' WHERE ' + where;
end;

{+}//sustituir por funcion generica

procedure TFPrecioLiquidacion.AnyadirRegistro;
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
          if flag then where := where + ' AND ';
          where := where + ' ' + Name + ' =' + QUOTEDSTR(Text);
          flag := True;
        end;
      end;
    end;
  end;
  where := where + ') ';
end;

procedure TFPrecioLiquidacion.AnyadirRegistroTotal;
var flag: boolean;
begin
  flag := false;
  with DMBaseDatos.QAux do
  begin
    SQl.Clear;
    SQL.Add(' select * from frf_precio_liquidacion ');
    SQL.Add('  where empresa_pl = :empresa_pl ');
    SQL.Add('    and proveedor_pl = :proveedor_pl ');
    SQL.Add('    and anyo_semana_pl = :anyo_semana_pl');
    ParamByName('empresa_pl').AsString:= QGuia.Fieldbyname('empresa_pl').AsString;
    ParamByName('proveedor_pl').AsString:= QGuia.Fieldbyname('proveedor_pl').AsString;
    ParamByName('anyo_semana_pl').AsString:= QGuia.Fieldbyname('anyo_semana_pl').AsString;
    Open;
    First;
    where := ' WHERE ';
    while not eof do
    begin
     if flag then where := where + ' OR ';
     where := where + '( ' + 'empresa_pl = '   + QUOTEDSTR(DMBaseDatos.QAux.fieldbyname('empresa_pl').AsString);
     where := where + ' AND proveedor_pl = '   + QUOTEDSTR(DMBaseDatos.QAux.fieldbyname('proveedor_pl').AsString);
     where := where + ' AND anyo_semana_pl = ' + QUOTEDSTR(DMBaseDatos.QAux.fieldbyname('anyo_semana_pl').AsString);
     where := where + ' AND producto_pl = '    + QUOTEDSTR(DMBaseDatos.QAux.fieldbyname('producto_pl').AsString);
     where := where + ' AND categoria_pl = '   + QUOTEDSTR(DMBaseDatos.QAux.fieldbyname('categoria_pl').AsString);
     where := where + ' AND variedad_pl = '    + QUOTEDSTR(DMBaseDatos.QAux.fieldbyname('variedad_pl').AsString) + ' )';
     flag := true;
     Next;
    end;
    Close;
  end;
end;

procedure TFPrecioLiquidacion.categoria_plChange(Sender: TObject);
begin
  if QPrecioLiquidacion.State = dsBrowse then
    des_categoria.Caption := desCategoria(QPrecioLiquidacionempresa_pl.Value,
                                            QPrecioLiquidacionproducto_pl.Value,
                                            QPrecioLiquidacioncategoria_pl.Value)

  else
    des_categoria.Caption := desCategoria(empresa_pl.Text,
                                          producto_pl.Text,
                                          categoria_pl.Text);

end;

{+}//Sustituir por funcion generica

procedure TFPrecioLiquidacion.ValidarEntradaMaestro;
(*
var
  flag: Boolean
*)
var i: Integer;
begin
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

  sEmpresa:= empresa_pl.Text;
  sProveedor:= proveedor_pl.Text;
  sAnyoSemana:= anyo_semana_pl.Text;
  FocoAltas:= producto_pl;
{
  //comprobar si existe la linea
  with DMBaseDatos.QAux do
  begin
    SQl.Clear;
    SQl.Add(' select precio_kg_pl from frf_precio_liquidacion ');
    SQl.Add(' where empresa_pl= :empresa_pl ');
    SQl.Add(' and proveedor_pl= :proveedor_pl ');
    SQl.Add(' and anyo_semana_pl= :anyo_semana_pl ');
    SQl.Add(' and producto_pl= :producto_pl ');
    SQl.Add(' and categoria_pl= :categoria_pl ');
    SQl.Add(' and variedad_pl= :variedad_pl ');
    ParamByName('empresa_pl').AsString:= empresa_pl.Text;
    ParamByName('proveedor_pl').AsString:= proveedor_pl.Text;
    ParamByName('anyo_semana_pl').AsString:= anyo_semana_pl.Text;
    ParamByName('producto_pl').AsString:= producto_pl.Text;
    ParamByName('categoria_pl').AsString:= categoria_pl.Text;
    ParamByName('variedad_pl').AsString:= variedad_pl.Text;

    Open;
    if not IsEmpty then
    begin
      Close;
      raise Exception.Create('Linea ya introducida [' + empresa_pl.Text + '-' +
                                                    proveedor_pl.Text + '-' +
                                                    anyo_semana_pl.Text + '-' +
                                                    producto_pl.Text + '-' +
                                                    categoria_pl.Text + '-' +
                                                    variedad_pl.Text + '].');
    end;
    Close;
  end;
}
end;

procedure TFPrecioLiquidacion.variedad_plChange(Sender: TObject);
begin
  if QPrecioLiquidacion.State = dsBrowse then
       des_variedad.Caption := desVariedad (QPrecioLiquidacionempresa_pl.Value,
                                            QPrecioLiquidacionproveedor_pl.Value,
                                            QPrecioLiquidacionproducto_pl.Value,
                                            IntToStr(iQPrecioLiquidacionvariedad_pl.Value) )
   else
     des_variedad.Caption := desVariedad (empresa_pl.Text,
                                          proveedor_pl.Text,
                                          producto_pl.Text,
                                          variedad_pl.Text);

end;

procedure TFPrecioLiquidacion.Previsualizar;
begin
  //
  Informar('Sin listado.');
end;

//*****************************************************************************
//*****************************************************************************
//Funciones asociadas a la rejilla flotante
//Si no existe la rejilla flotante
//   - Borrar Lista de acciones
//   - Borrar las funciones de esta seccion
//*****************************************************************************
//****************************************************************************

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//*****************************************************************************
//*****************************************************************************
//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles
procedure TFPrecioLiquidacion.AntesDeLocalizar;
begin
  PMaestro.Height:= 250;
end;

procedure TFPrecioLiquidacion.AntesDeModificar;
var i: Integer;
begin
  PMaestro.Height:= 250;
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := false;
  end;
end;

//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores

procedure TFPrecioLiquidacion.AntesDeVisualizar;
var i: Integer;
begin
  PMaestro.Height:= 150;
    //Resaturar estado
  for i := 0 to Lista.Count - 1 do
  begin
    Objeto := Lista.Items[i];
    if (Objeto is TBDEdit) then
      with Objeto as TBDEdit do
        if not Modificable then
          Enabled := True;
  end;

  sEmpresa:= '';
  sProveedor:= '';
  sAnyosemana:= '';

  FocoAltas := empresa_pl;
end;

procedure TFPrecioLiquidacion.AntesDeInsertar;
begin
  PMaestro.Height:= 250;
  if (qGuia.Recordcount <> 0) and (bPrimerAlta) then
  begin
    sEmpresa := QGuia.Fieldbyname('empresa_pl').AsString;
    sProveedor := QGuia.Fieldbyname('proveedor_pl').AsString;
    sAnyoSemana := QGuia.Fieldbyname('anyo_semana_pl').AsString;

    AnyadirRegistroTotal;
    FocoAltas := producto_pl;
  end;
  empresa_pl.Text:= sEmpresa;
  proveedor_pl.Text:= sProveedor;
  anyo_semana_pl.Text:= sAnyoSemana;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TFPrecioLiquidacion.RequiredTime(Sender: TObject;
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

procedure TFPrecioLiquidacion.empresa_plChange(Sender: TObject);
begin
  if QPrecioLiquidacion.State = dsBrowse then
    des_empresa.Caption := desEmpresa(QPrecioLiquidacionempresa_pl.Value)
  else
    des_empresa.Caption := desEmpresa(empresa_pl.Text);
end;

procedure TFPrecioLiquidacion.producto_plChange(Sender: TObject);
begin
   if QPrecioLiquidacion.State = dsBrowse then
     des_producto.Caption := desProducto(QPrecioLiquidacionempresa_pl.Value,
                                         QPrecioLiquidacionproducto_pl.Value)
  else
    des_producto.Caption := desProducto(empresa_pl.Text,
                                        producto_pl.Text);
end;

procedure TFPrecioLiquidacion.proveedor_plChange(Sender: TObject);
begin
  if QPrecioLiquidacion.State = dsBrowse then
    des_proveedor.Caption := desProveedor(QPrecioLiquidacionempresa_pl.Value,
      QPrecioLiquidacionproveedor_pl.AsString)
  else
    des_proveedor.Caption := desProveedor(empresa_pl.Text,
      proveedor_pl.Text);
end;

procedure TFPrecioLiquidacion.QPrecioLiquidacionAfterPost(DataSet: TDataSet);
begin
  bPrimerAlta := false;
{
  QPrecioLiquidacion.Close;

  QPrecioLiquidacion.ParamByName('empresa_pl').AsString := empresa_pl.Text;
  QPrecioLiquidacion.ParamByName('proveedor_pl').AsString := proveedor_pl.Text;
  QPrecioLiquidacion.ParamByName('anyo_semana_pl').AsString := anyo_semana_pl.Text;
  QPrecioLiquidacion.Open;
}
end;

procedure TFPrecioLiquidacion.QPrecioLiquidacionCalcFields(DataSet: TDataSet);
begin
   QPrecioLiquidacion.FieldByName('des_producto').AsString := desProducto(QPrecioLiquidacion.FieldByName('empresa_pl').AsString,
                                                                          QPrecioLiquidacion.FieldByName('producto_pl').AsString);
   QPrecioLiquidacion.FieldByName('des_categoria').AsString := desCategoria(QPrecioLiquidacion.FieldByName('empresa_pl').AsString,
                                                                            QPrecioLiquidacion.FieldByName('producto_pl').AsString,
                                                                            QPrecioLiquidacion.FieldByName('categoria_pl').AsString);
   QPrecioLiquidacion.FieldByName('des_variedad').AsString := desVariedad (QPrecioLiquidacion.FieldByName('empresa_pl').AsString,
                                                                          QPrecioLiquidacion.FieldByName('proveedor_pl').AsString,
                                                                          QPrecioLiquidacion.FieldByName('producto_pl').AsString,
                                                                          QPrecioLiquidacion.FieldByName('variedad_pl').AsString);
end;

procedure TFPrecioLiquidacion.qGuiaAfterOpen(DataSet: TDataSet);
begin
  //Abrir detalle
  QPrecioLiquidacion.SQL.Clear;
  QPrecioLiquidacion.SQL.Add('SELECT * FROM frf_precio_liquidacion ');
  if Trim(Where) <> '' then
  begin
    QPrecioLiquidacion.SQL.Add( Where );
    QPrecioLiquidacion.SQL.Add( ' and empresa_pl = :empresa_pl ');
  end
  else
  begin
    QPrecioLiquidacion.SQL.Add( ' where empresa_pl = :empresa_pl ');
  end;
  QPrecioLiquidacion.SQL.Add( ' and proveedor_pl = :proveedor_pl ');
  QPrecioLiquidacion.SQL.Add( ' and anyo_semana_pl = :anyo_semana_pl ');
  QPrecioLiquidacion.SQL.Add( ' ORDER BY producto_pl ');
  QPrecioLiquidacion.Open;
end;

procedure TFPrecioLiquidacion.qGuiaBeforeClose(DataSet: TDataSet);
begin
  //cancelar cambios pendientes en la guia
  qGuia.CancelUpdates;
  //Cerrar detalle
  QPrecioLiquidacion.Close;
end;

end.
