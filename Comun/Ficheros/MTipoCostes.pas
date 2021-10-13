unit MTipoCostes;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs, ExtCtrls,
  Db, StdCtrls, DBCtrls, CMaestro, Buttons, ActnList, BSpeedButton, Grids,
  BGridButton, BGrid, BDEdit, BCalendarButton, ComCtrls, BCalendario,
  DBGrids, BEdit, DError, DBTables;

type
  TFMTipoCostes = class(TMaestro)
    PMaestro: TPanel;
    DSMaestro: TDataSource;
    LCodigo_tp: TLabel;
    codigo_tc: TBDEdit;
    LDescripcion_tp: TLabel;
    descripcion_tc: TBDEdit;
    Label13: TLabel;
    QTipoCostes: TQuery;
    lblNombre12: TLabel;
    lblEsPlastico: TLabel;
    es_ayuda_tc: TDBCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure RequiredTime(Sender: TObject;
      var isTime: Boolean);
    procedure env_comer_operador_tpChange(Sender: TObject);
    procedure QTipoCostesAfterScroll(DataSet: TDataSet);
    procedure QTipoCostesAfterOpen(DataSet: TDataSet);
    procedure es_ayuda_tcClick(Sender: TObject);
  private
    { Private declarations }
    Lista: TList;
    Objeto: TObject;

    procedure ValidarEntradaMaestro;
    procedure AbrirTablas;
    procedure CerrarTablas;
    //procedure Clonar;

    procedure PonSiEsAyuda;

  public
    { Public declarations }
    procedure Filtro; override;
    procedure AnyadirRegistro; override;


    procedure AntesDeinsertar;
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

uses CVariables, CGestionPrincipal, UDMBaseDatos, CReportes,
  CAuxiliarDB, Principal, LTipoPalets, DPreview, bSQLUtils,
  UDMAuxDB, Variants, UDMConfig,  AdvertenciaFD, ImportarPaletFD, LTipoCostes;

{$R *.DFM}

procedure TFMTipoCostes.AbrirTablas;
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

procedure TFMTipoCostes.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([DataSetMaestro]);
end;

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMTipoCostes.FormCreate(Sender: TObject);
begin
     //Variables globales
  M := Self;
  MD := nil;
     //Panel sobre el que iran los controles
  PanelMaestro := PMaestro;

     //***************************************************************
     //Fuente de datos maestro
     //CAMBIAR POR LA QUERY QUE LE TOQUE
 {+}DataSetMaestro := QTipoCostes;
     //***************************************************************

     //Intrucciones para sacar los datos (inicialmente consulta vacia)
 {+}Select := ' SELECT * FROM frf_tipo_costes ';
 {+}where := ' WHERE codigo_tc=' + QuotedStr('###');
 {+}Order := ' ORDER BY codigo_tc ';
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
     //Visualizar estado inicial
  Visualizar;


     //Validar entrada
  OnValidateMasterConstrains := ValidarEntradaMaestro;
//DEJAR LAS QUE SEAN NECESARIAS
  OnEdit := AntesDeModificar;
  OnInsert := AntesDeInsertar;
  OnView := AntesDeVisualizar;
  OnBrowse:= AntesDeLocalizar;



     //Focos
  FocoAltas := codigo_tc;
  FocoModificar := descripcion_tc;
  FocoLocalizar := codigo_tc;

end;

procedure TFMTipoCostes.FormActivate(Sender: TObject);
begin
     //Si la tabla no esta abierta salimos
  if not DataSetMaestro.Active then Exit;
     //Variables globales
  M := Self;
  MD := nil;
//  gRF := RejillaFlotante;
//  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
{*DEJAR LAS NECESARIAS

     gCF:=CalendarioFlotante;
}

     //Muestra la barra de herramientas de Maestro/Detalle
  if FormType <> tfMaestro then
  begin
    FormType := tfMaestro;
    BHFormulario;
  end;
     //Estado botones de desplamiento
  BHGrupoDesplazamientoMaestro(PCMaestro);
end;


procedure TFMTipoCostes.FormDeactivate(Sender: TObject);
begin
{*DEJAR LAS QUE TENIAN VALOR
   //Por si acaso el nuevo form no necesita rejilla
   gRF:=nil;
   gCF:=nil;
}
end;

procedure TFMTipoCostes.FormClose(Sender: TObject; var Action: TCloseAction);
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

{*DEJAR LAS QUE TENIAN VALOR
     //Por si acaso el nuevo form no necesita rejilla
     gRF:=nil;
     gCF:=nil;
}
     // Cambia acción por defecto para Form hijas en una aplicación MDI
     // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

procedure TFMTipoCostes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{
    //Si la rejilla esta desplegada no hacemos nada
    if (RejillaFlotante<>nil) then
        if (RejillaFlotante.Visible) then
           //No hacemos nada
           Exit;
 }
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

procedure TFMTipoCostes.Filtro;
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
  if es_ayuda_tc.State <> cbGrayed then
  begin
    if flag then where := where + ' and ';
    if es_ayuda_tc.State = cbChecked then
      where := where + ' es_ayuda_tc = 1 '
    else
      where := where + ' es_ayuda_tc = 0 ';
    flag := True;
  end;
  if flag then where := ' WHERE ' + where;

end;

//function generica, no tocar si no es estrictamente necesario
//Construye el select que extrae los registros que son insertados
//para, else fin usa los campos que marcamos como PrimaryKey

procedure TFMTipoCostes.AnyadirRegistro;
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


//function semi-generica, introducir restricciones particulares donde se indica
//Conprueba que tengan valor todos los campos marcados como required

procedure TFMTipoCostes.ValidarEntradaMaestro;
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
            raise Exception.Create('Dato necesario.');
        end;

      end;
    end;
  end;


    //**************************************************************
    //REstricciones Particulares
    //**************************************************************
{*INSERTAR LAS NECESARIAS
    //Comprobar que el año_semana tenga obligatoriamente 6 cifras
    if (length(ano_semana_p.Text)<6)  then
    begin
         ano_semana_p.SetFocus;
         raise Exception.Create('El año y la semana de la plantacion debe set de 6 dígitos.');
    end;
    //Comprobar que las dos ultimas cifras del año_semana esten entre 00-53
    aux:=StrToInt(Copy(ano_semana_p.Text,5,2));
    if (aux<0) and (aux>53)  then
    begin
         ano_semana_p.SetFocus;
         raise Exception.Create('Las dos últimas cifras del año y la semana de la plantacion deben estar entre 00 y 53 ambos incluidos.');
    end;
}
end;

//**************************************************************
//IMPRESION: Introducir QuickReport
//**************************************************************

procedure TFMTipoCostes.Previsualizar;
var enclave: TBookMarK;
begin
     //Crear el listado
  enclave := DatasetMaestro.GetBookmark;
  QRLTipoCostes := TQRLTipoCostes.Create(Application);
  PonLogoGrupoBonnysa(QRLTipoCostes);
  QRLTipoCostes.DataSet := QTipoCostes;
  Preview(QRLTipoCostes);
  DatasetMaestro.GotoBookmark(enclave);
  DatasetMaestro.FreeBookmark(enclave);
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
//*****************************************************************************
//*****************************************************************************
//EVENTOS
//Borrar si no es necesario
//*****************************************************************************
//*****************************************************************************
//Evento que se produce cuando pulsamos modificar
//Aprobrechar para modificar estado controles

procedure TFMTipoCostes.AntesDeInsertar;
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
  es_ayuda_tc.AllowGrayed:= False;
end;

procedure TFMTipoCostes.AntesDeModificar;
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
  es_ayuda_tc.AllowGrayed:= False;
end;
//Evento que se produce cuando vamos a visualizar el resultado de las operaciones
//Aprobrechar para restaurar los cambios realizados por los eventos anteriores

procedure TFMTipoCostes.AntesDeVisualizar;
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
  es_ayuda_tc.AllowGrayed:= False;
end;

procedure TFMTipoCostes.AntesDeLocalizar;
begin
   es_ayuda_tc.AllowGrayed:= True;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************

//Para saber cuando tenemos que obligar a que un campo sea requerido

procedure TFMTipoCostes.RequiredTime(Sender: TObject;
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

procedure TFMTipoCostes.env_comer_operador_tpChange(Sender: TObject);
begin
  if (gRF <> nil) then
    if esVisible( gRF ) then
      Exit;
  if (gCF <> nil) then
    if esVisible( gCF ) then
      Exit;
end;

procedure TFMTipoCostes.MiAlta;
(*
var
  iTipo: Integer;
*)
begin
  inherited Altas;
  (*
  if QTipoPalets.IsEmpty then
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
  *)
end;


procedure TFMTipoCostes.Modificar;
begin
  inherited Modificar;
{
  if DMConfig.EsLaFontEx then
  begin
    inherited Modificar;
  end
  else
  begin
    //inherited Modificar;
    if DMBaseDatos.AbrirConexionCentral then
    begin
      GetPaletBDRemota( 'BDCentral', False );
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
}
end;

procedure TFMTipoCostes.Altas;
begin
  MiAlta;
 {
  if DMConfig.EsLaFontEx then
  begin
    MiAlta;
  end
  else
  begin
    //inherited Altas;
    if DMBaseDatos.AbrirConexionCentral then
    begin
      GetPaletBDRemota( 'BDCentral', True );
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
}
end;

(*
procedure TFMTipoPalets.Clonar;
var
  sCodigo, sDescripcion, sOperador, sProducto: string;
  rKilos: Real;
begin
  sCodigo:= codigo_tp.Text;
  sDescripcion:= descripcion_tp.Text;
  sOperador:= env_comer_operador_tp.Text;
  sProducto:= env_comer_producto_tp.Text;
  rKilos:= StrToFloatDef( kilos_tp.Text, 0 );

  inherited Altas;

  //codigo_tp.Text:= sCodigo;
  descripcion_tp.Text:= sDescripcion;
  env_comer_operador_tp.Text:= sOperador;
  env_comer_producto_tp.Text:= sProducto;
  kilos_tp.Text:= FloatToStr( rKilos );
end;
*)

procedure TFMTipoCostes.PonSiEsAyuda;
begin
  if DSMaestro.DataSet.active then
  begin
    es_ayuda_tc.Caption:= '';
    if DSMaestro.DataSet.IsEmpty then
    begin
      es_ayuda_tc.Caption:= '';
    end
    else
    begin

      //if DSMaestro.DataSet.FieldByName('palet_plastico_tp').Asinteger = 1 then
      if es_ayuda_tc.State = cbGrayed then
        es_ayuda_tc.Caption:= 'SIN DEFINIR'
      else
      if es_ayuda_tc.State = cbChecked then
        es_ayuda_tc.Caption:= 'SI'
      else
        es_ayuda_tc.Caption:= 'NO';
    end;
  end;
end;

procedure TFMTipoCostes.QTipoCostesAfterScroll(DataSet: TDataSet);
begin
  PonSiEsAyuda;
end;

procedure TFMTipoCostes.QTipoCostesAfterOpen(DataSet: TDataSet);
begin
  PonSiEsAyuda;
end;

procedure TFMTipoCostes.es_ayuda_tcClick(Sender: TObject);
begin
  PonSiEsAyuda;
end;

end.
