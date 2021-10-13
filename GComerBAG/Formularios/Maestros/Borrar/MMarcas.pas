unit MMarcas;

interface

uses
  Windows, Messages, SysUtils, Classes, Forms, Dialogs, Db, ExtCtrls, BDEdit,
  StdCtrls, CMaestro, ComCtrls, BEdit, DError, Controls, DBTables;

type
  TFMMarcas = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    LPlantacion_p: TLabel;
    codigo_m: TBDEdit;
    LEmpresa_p: TLabel;
    descripcion_m: TBDEdit;
    Label13: TLabel;
    QMarcas: TQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject;
      var isTime: Boolean);
  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;

    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;

    function ObtenerCodigoMarca: string;

    procedure GetMarcaBDRemota( const ABDRemota: string; const AAlta: Boolean );
    procedure BuscarMarca( const AMarca: string );
    procedure RefrescarMarca;


  public
    { Public declarations }
    procedure Filtro; override;
    procedure AnyadirRegistro; override;

    procedure AntesDeInsertar;
    procedure AntesDeModificar;
    procedure AntesDeVisualizar;

    //Listado
    procedure Previsualizar; override;

    procedure MiAlta;
    procedure Altas; override;
    procedure Modificar; override;
    procedure Clonar;
  end;

implementation

uses CVariables, UDMBaseDatos, Principal, LMarcas, CReportes,
  CGestionPrincipal, DPreview, bSQLUtils, ImportarMarcaFD, SeleccionarAltaClonarFD,
  UDMConfig, AdvertenciaFD, UDMAuxDB;

{$R *.DFM}

procedure TFMMarcas.AbrirTablas;
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
  Registro := 1;
  Registros := DataSetMaestro.RecordCount;
  RegistrosInsertados := 0;
end;

procedure TFMMarcas.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetMaestro]);
end;

procedure TFMMarcas.Clonar;
var sMarca, sDescripcion, stara, notas: string;
begin
  sMarca:= ObtenerCodigoMarca;
  sDescripcion:= descripcion_m.Text;

  inherited Altas;

  codigo_m.Text := sMarca;
  descripcion_m.Text := sDescripcion;
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMMarcas.FormCreate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

     //Fuente de datos maestro
 {+}DataSetMaestro := QMarcas;
     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_marcas ';
 {+}where := ' WHERE codigo_m= ' + QuotedStr('##');
 {+}Order := ' ORDER BY codigo_m ';
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

     //Lista de componentes
  Lista := TList.Create;
  PMaestro.GetTabOrderList(Lista);

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
     //Estado inicial
  Visualizar;
     //Inicialmente grupo de desplazamiento deshabilitado
  BHGrupoDesplazamientoMaestro(pcNulo);


     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
  OnInsert := AntesDeInsertar;
  OnEdit := AntesDeModificar;
  OnView := AntesDeVisualizar;
     //Focos
  FocoAltas := descripcion_m;
  FocoModificar := descripcion_m;
  FocoLocalizar := codigo_m;

end;

procedure TFMMarcas.FormActivate(Sender: TObject);
begin
  if not DataSetMaestro.Active then Exit;
     //Variables globales
  M := Self;
  MD := nil;

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
     //Estado botones de desplamiento
  BHGrupoDesplazamientoMaestro(PCMaestro);
end;


procedure TFMMarcas.FormClose(Sender: TObject; var Action: TCloseAction);
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

     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMMarcas.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMMarcas.GetMarcaBDRemota(const ABDRemota: string;
  const AAlta: Boolean);
var
  sMarca: string;
  iValue: Integer;
  bAlta: Boolean;
begin
  if AAlta then
    sMarca:= ''
  else
    sMarca:= codigo_m.Text;
  bAlta:= AAlta;

  iValue:= ImportarMarca( Self, ABDRemota, sMarca );
  case iValue of
      -1: //Operacion cancelada
          begin end;
       1: begin
            if bAlta then
            begin
              BuscarMarca( sMarca );
            end
            else
            begin
              RefrescarMarca;
            end;
          end;
       else ShowMessage('Error ' + IntToStr( iValue ) + ' al importar la marca.');
  end;
end;

procedure TFMMarcas.MiAlta;
var
  iTipo: Integer;
begin
  if QMarcas.IsEmpty then
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

procedure TFMMarcas.Modificar;
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
      GetMarcaBDRemota( 'BDCentral', False );
    end
    else
    begin
      if AdvertenciaFD.VerAdvertencia(Self, 'ATENCION: No se ha podido conectar con la central.' + #13 + #10 +
                                       'Cualquier cambio que realize debera realizarse tambien en la central.',
                                       'PERMITIR MODIFICACIONES EN BASE DE DATOS LOCAL',
                                       'Confirmo que quiero hacer modificaciones locales', 'Modificar Camión') = mrIgnore then
        inherited Modificar;
    end;
  end;
end;

function TFMMarcas.ObtenerCodigoMarca: string;
var iMarca: Integer;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select max(codigo_m) marca from frf_marcas ');
    SQL.Add('  where codigo_m <> 99 ');

    Open;
    if IsEmpty then
      iMarca := 1
    else
    begin
      iMarca := fieldbyname('marca').AsInteger + 1;
    end;

    Result := IntToStr(iMarca);

    Close;
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

procedure TFMMarcas.Filtro;
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

//function generica, no tocar si no es estrictamente necesario
//Construye el select que extrae los registros que son insertados
//para, else fin usa los campos que marcamos como PrimaryKey

procedure TFMMarcas.AnyadirRegistro;
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


procedure TFMMarcas.BuscarMarca(const AMarca: string);
begin
 {+}Select := ' SELECT * FROM frf_marcas ';
 {+}where := ' WHERE codigo_m =' + QuotedStr(AMarca);
 {+}Order := ' ORDER BY codigo_m ';

 QMarcas.Close;
 AbrirTablas;
 Visualizar;
end;

//function semi-generica, introducir restricciones particulares donde se indica
//Conprueba que tengan valor todos los campos marcados como required

procedure TFMMarcas.ValidarEntradaMaestro;
var i: Integer;
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

    //**************************************************************
    //REstricciones Particulares
    //**************************************************************
    //Ninguna
end;

//**************************************************************
//IMPRESION: Introducir QuickReport
//**************************************************************

procedure TFMMarcas.Previsualizar;
var enclave: TBookMark;
begin
     //Crear el listado
  enclave := DataSetMaestro.GetBookmark;
  QRLMarcas := TQRLMarcas.Create(Application);
  PonLogoGrupoBonnysa(QRLMarcas);
  QRLMarcas.DataSet := QMarcas;
  Preview(QRLMarcas);
  DataSetMaestro.GotoBookmark(enclave);
  DataSetMaestro.FreeBookmark(enclave);
end;

//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************
//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMMarcas.Altas;
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
      GetMarcaBDRemota( 'BDCentral', True );
    end
    else
    begin
      if AdvertenciaFD.VerAdvertencia(Self, 'ATENCION: No se ha podido conectar con la central.' + #13 + #10 +
                                       'Recuerde que cualquier cambio que se realize debera realizarse tambien en la central.',
                                       'PERMITIR MODIFICACIONES EN BASE DE DATOS LOCAL',
                                       'Confirmo que quiero hacer altas locales', 'Nueva Marca') = mrIgnore then
        MiAlta;
    end;
  end;

end;

procedure TFMMarcas.AntesDeInsertar;
begin
  //Deshabilitamos el campo codigo_m, se genera codigo automatico
  codigo_m.Enabled := False;
  codigo_m.Text := ObtenerCodigoMarca;
end;

procedure TFMMarcas.AntesDeModificar;
var i: Integer;
begin
    //Deshabilitamos todos los componentes Modificable=False
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

procedure TFMMarcas.AntesDeVisualizar;
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
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************
//Para saber cuando tenemos que obligar a que un campo sea requerido

procedure TFMMarcas.RefrescarMarca;
var
  myBookMark: TBookmark;
begin
  myBookMark:= QMarcas.GetBookmark;
  QMarcas.Close;
  QMarcas.Open;
  QMarcas.GotoBookmark(myBookMark);
  QMarcas.FreeBookmark(myBookMark);
end;

procedure TFMMarcas.RequiredTime(Sender: TObject;
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

end.
