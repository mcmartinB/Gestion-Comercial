unit MProductores;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestro, Buttons, BGrid,  BDEdit,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, ComCtrls, BCalendario,
  BCalendarButton, BEdit,DError, DBTables;

type
  TFMProductores = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    Bevel1: TBevel;
    ACosecheros: TActionList;
    ARejillaFlotante: TAction;
    RejillaFlotante: TBGrid;
    LPlantacion_p: TLabel;
    plantacion_p: TBDEdit;
    descripcion_p: TBDEdit;
    LDescripcion_p: TLabel;
    LEmpresa_p: TLabel;
    empresa_p: TBDEdit;
    BGBEmpresa_p: TBGridButton;
    BGBProducto_p: TBGridButton;
    producto_p: TBDEdit;
    LProducto_p: TLabel;
    LCosechero_p: TLabel;
    cosechero_p: TBDEdit;
    BGBCosechero_p: TBGridButton;
    STEmpresa_p: TStaticText;
    STProducto_p: TStaticText;
    STCosechero_p: TStaticText;
    Label13: TLabel;
    ano_semana_p: TBDEdit;
    LAno_semana_p: TLabel;
    ACampos: TAction;
    QPlantaciones: TQuery;
    fecha_inicio_p: TBDEdit;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject;
      var isTime: Boolean);
    procedure SalirEdit(Sender: TObject);
    procedure EntrarEdit(Sender: TObject);
  private
    { Private declarations }
    Lista:TList;
    Objeto:TObject;

    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;

  public
    { Public declarations }
    procedure Borrar; Override;
    procedure BorrarPlantacion;
    procedure Filtro; Override;
    procedure AnyadirRegistro; Override;

    procedure AntesDeModificar;
    procedure AntesDeVisualizar;

    //Listado
    procedure Previsualizar;Override;
  end;

implementation

uses CVariables, CGestionPrincipal, UDMBaseDatos, CReportes,
     LProductores, CAuxiliarDB, Principal,
     DPreview, UDMAuxDB, bSQLUtils;

{$R *.DFM}

procedure TFMProductores.AbrirTablas;
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
     Registros:=DataSetMaestro.RecordCount;
     if registros>0 then
        Registro:=1
     else
        Registro:=0;
     RegistrosInsertados:=0;
end;

procedure TFMProductores.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys( [DataSetMaestro]);
end;

//************************** CREAMOS EL FORMULARIO ************************
procedure TFMProductores.FormCreate(Sender: TObject);
begin
     //Variables globales
     M:=Self;
     MD:=nil;
     //Panel sobre el que iran los controles
     PanelMaestro:=PMaestro;

     //Fuente de datos maestro
{+}  DataSetMaestro:=QPlantaciones;
     //Intrucciones para sacar los datos (inicialmente consulta vacia)
{+}  Select := ' SELECT * FROM frf_plantaciones ';
{+}  where  := ' WHERE empresa_p='+QuotedStr('###');
{+}  Order  := ' ORDER BY ano_semana_p, empresa_p, producto_p, cosechero_p, plantacion_p ';
      //Abrir tablas/Querys
      try
         AbrirTablas;
      except
         on e:EDBEngineError do
         begin
              ShowError(e);
              Close;
              Exit;
         end;
      end;

     //Lista de componentes
     Lista:=TList.Create;
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
     DMBaseDatos.QDespegables.Tag:=kNull;
     //Asignamos constantes a los componentes que los tienen
     //para facilitar distingirlos
     empresa_p.Tag:=kEmpresa;
     producto_p.Tag:=kProducto;
     cosechero_p.Tag:=kCosechero;
     //Validar entrada
     OnValidateMasterConstrains:=ValidarEntradaMaestro;
{+   Eliminar linea y funcion si no se va a usar }
     OnEdit:=AntesDeModificar;
     OnView:=AntesDeVisualizar;
     //Focos
{+}  FocoAltas:=ano_semana_p ;
{+}  FocoModificar:=descripcion_p;
{+}  FocoLocalizar:=ano_semana_p;
     //Inicializar variables
end;

procedure TFMProductores.FormActivate(Sender: TObject);
begin
     Top:=1;
     if not DataSetMaestro.Active then Exit;
     //Variables globales
     M:=Self;
     MD:=nil;
     gRF :=RejillaFlotante;
     RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
     gCF:=nil;

     //Muestra la barra de herramientas de Maestro/Detalle
     if FormType <> tfMaestro then
     begin
          FormType := tfMaestro;
          BHFormulario;
     end;

     //Estado botones de desplamiento
     BHGrupoDesplazamientoMaestro(PCMaestro);
     //Barra de estado y barra de herramientas
     BEEstado;
     BHEstado;
     Enabled:=True;
end;


procedure TFMProductores.FormDeactivate(Sender: TObject);
begin
{*}  //Por si acaso el nuevo form no necesita rejilla
     gRF:=nil;
     gCF:=nil;
end;

procedure TFMProductores.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Lista.Free;
     //Restauramos barra de herramientas
     if FPrincipal.MDIChildCount = 1 then
     begin
        FormType:=tfDirector;
        BHFormulario;
     end;

     //Codigo de desactivacion
     CerrarTablas;
{*}  //Por si acaso el nuevo form no necesita rejilla
     gRF:=nil;
     gCF:=nil;

     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
     Action := caFree;
end;

procedure TFMProductores.FormKeyDown(Sender: TObject; var Key: Word;
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

//function generica, no tocar si no es estrictamente necesario
//Construye el select que extrae los registros que concuerdan
//con los capos que hemos rellenado
procedure TFMProductores.Filtro;
var Flag:Boolean;
    i:Integer;
begin
    where:='';Flag:=false;
    for i:=0 to Lista.Count-1 do
    begin
         Objeto:=Lista.Items[i];
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
    if flag then where:=' WHERE '+where;
end;

//function generica, no tocar si no es estrictamente necesario
//Construye el select que extrae los registros que son insertados
//para, else fin usa los campos que marcamos como PrimaryKey
procedure TFMProductores.AnyadirRegistro;
var Flag:Boolean;
    i:Integer;
begin
    Flag:=false;
    if  where<>'' then where:=where+' OR ('
    else where:=' WHERE (';

    for i:=0 to Lista.Count-1 do
    begin
         objeto:=Lista.Items[i];
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


//function semi-generica, introducir restricciones particulares donde se indica
//Conprueba que tengan valor todos los campos marcados como required
procedure TFMProductores.ValidarEntradaMaestro;
var i,aux:Integer;
begin
    //Que no hayan campos vacios
    for i:=0 to Lista.Count-1 do
    begin
         Objeto:=Lista.Items[i];
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
                     end;

                end;
         end;
    end;

    //**************************************************************
    //REstricciones Particulares
    //**************************************************************
    //Comprobar que el año_semana tenga obligatoriamente 6 cifras
    if (length(ano_semana_p.Text)<6)  then
    begin
         ano_semana_p.SetFocus;
         raise Exception.Create('El año y la semana de la plantacion debe ser de 6 dígitos.');
    end;
    //Comprobar que las dos ultimas cifras del año_semana esten entre 00-53
    aux:=StrToInt(Copy(ano_semana_p.Text,5,2));
    if (aux<0) and (aux>53)  then
    begin
         ano_semana_p.SetFocus;
         raise Exception.Create('Las dos últimas cifras del año y la semana de la plantacion deben estar entre 00 y 53 ambos incluidos.');
    end;
end;

//**************************************************************
//IMPRESION: Introducir QuickReport
//**************************************************************
procedure TFMProductores.Previsualizar;
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
             SQL.Add(' SELECT p.*, nombre_c '+
                     ' FROM frf_plantaciones p,frf_cosecheros c');
             if where<>'' then
                SQL.Add(where +' and (p.empresa_p = c.empresa_c) '+
                        ' AND  (p.cosechero_p = c.cosechero_c)')
             else
                SQL.Add(' where (p.empresa_p = c.empresa_c) '+
                        ' AND  (p.cosechero_p = c.cosechero_c)');
             SQL.Add(order);
             try
                Open;
                RecordCount;
             except
                 MessageDlg('Error al crear el listado.', mtError, [mbOK], 0);
                 Exit;
             end;
        end;
        QRLProductores:=TQRLProductores.Create(Application);
        PonLogoGrupoBonnysa(QRLProductores);
        QRLProductores.DataSet:= DMBaseDatos.QListado;
        Preview(QRLProductores);
     finally
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
procedure TFMProductores.ARejillaFlotanteExecute(Sender: TObject);
begin
     case ActiveControl.Tag of
          kEmpresa:DespliegaRejilla(BGBEmpresa_p);
          kProducto:DespliegaRejilla(BGBProducto_p,[empresa_p.Text]);
          kCosechero:DespliegaRejilla(BGBCosechero_p,[empresa_p.Text]);
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
procedure TFMProductores.AntesDeModificar;
var i:Integer;
begin
    //Deshabilitamos boton
    for i:=0 to Lista.Count-1 do
    begin
         Objeto:=Lista.Items[i];
         if (Objeto is TBDEdit) then
            with Objeto as TBDEdit do
                 if not Modificable then
                    Enabled:=false;
    end;
end;
//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores
procedure TFMProductores.AntesDeVisualizar;
var i:Integer;
begin
    //Resaturamos estado controles
    for i:=0 to Lista.Count-1 do
    begin
         Objeto:=Lista.Items[i];
         if (Objeto is TBDEdit) then
            with Objeto as TBDEdit do
                 if not Modificable then
                    if Enabled=false then Enabled:=true;
    end;
    STCosechero_p.Caption:=desCosechero(empresa_p.Text,cosechero_p.Text);
    STProducto_p.Caption:=desProducto(empresa_p.Text,producto_p.Text);
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

procedure TFMProductores.PonNombre(Sender:TObject);
begin
     if ((gRF<>nil) and gRF.Visible) or
        ((gCF<>nil) and gCF.Visible) then
        Exit;
     case TComponent(Sender).Tag of
          kEmpresa:STEmpresa_p.Caption:=desEmpresa(empresa_p.Text);
          kCosechero:STCosechero_p.Caption:=desCosechero(empresa_p.Text,cosechero_p.Text);
          kProducto: STProducto_p.Caption:=
            desProducto(QPlantaciones.FieldByName('empresa_p').AsString,producto_p.Text);
     end;
end;

//Para saber cuando tenemos que obligar a que un campo sea requerido
procedure TFMProductores.RequiredTime(Sender: TObject;
  var isTime: Boolean);
begin
     isTime:=false;
     if TBEdit(Sender).CanFocus then
     begin
          if (Estado=teLocalizar) then
             Exit;
          if (gRF<>nil) and (gRf.Visible=true) then
               Exit;
          if (gCF<>nil) and (gCf.Visible=true) then
               Exit;
          isTime:=true;
     end;
end;

//*****************************************************************
//MANTENIMIENTO DE CAMPOS
//*****************************************************************
procedure TFMProductores.SalirEdit(Sender: TObject);
begin
     BEMensajes('');
end;

procedure TFMProductores.EntrarEdit(Sender: TObject);
begin
     BEMensajes(TEdit(Sender).Hint);
end;


procedure TFMProductores.BorrarPlantacion;
begin
  //Comprobar que no tenga datos
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add( ' select count(*) from frf_entradas2_l ');
    SQL.Add( ' where empresa_e2l ' + SQLEqualS( empresa_p.Text));
    SQL.Add( '   and producto_e2l ' + SQLEqualS( producto_p.Text));
    SQL.Add( '   and cosechero_e2l ' + SQLEqualN( cosechero_p.Text));
    SQL.Add( '   and plantacion_e2l ' + SQLEqualS( plantacion_p.Text));
    SQL.Add( '   and ano_sem_planta_e2l ' + SQLEqualS( ano_semana_p.Text));

    try
      Open;
    except
      raise Exception.Create(' Error al comprobar la existencia de entradas.');
    end;
    if Fields[0].AsInteger <> 0 then
    begin
      raise Exception.Create(' No se puede borrar una plantación con entradas asociadas.');
    end;
    Close;
  end;

  QPlantaciones.Delete;
  if Registro=Registros then Registro:=Registro-1;
    Registros:=Registros-1;
end;

procedure TFMProductores.Borrar;
var botonPulsado:Word;
begin
  //Barra estado
  botonPulsado:=MessageDlg('¿Desea borrar la plantación seleccionada?',
                    mtConfirmation,[mbYes,mbNo],0);
  if botonPulsado=mrYes then
  try
    BorrarPlantacion;
  except
    on E:EDBEngineError do
    begin
      ShowError(e);
    end;
  end;

  //Por ultimo visualizamos resultado
  Visualizar;
end;

end.

