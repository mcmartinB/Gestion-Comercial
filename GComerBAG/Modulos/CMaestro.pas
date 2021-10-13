unit CMaestro;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, Dialogs,
  ExtCtrls, db, dbtables, CVariables, BGrid, BCalendario;

var
  MultiplesAltas: boolean;

type
  // Evento
  TSimpleEvent = procedure of object;

type
  TMaestro = class(TForm)
  protected
    { Protected declarations }
    FEstado: TEstado;
    FFiltrar: Boolean;
    FOnChangeState: TSimpleEvent;
    FOnValidateMasterConstrains: TSimpleEvent;
    FOnAfterInsertMaster: TSimpleEvent;
    FOnChangeMasterRecord: TSimpleEvent;
    FOnInsert: TSimpleEvent;
    FOnErrorInsert: TSimpleEvent;
    FOnEdit: TSimpleEvent;
    FOnBrowse: TSimpleEvent;
    FOnView: TSimpleEvent;
    FOnBeforeMasterDelete: TSimpleEvent;
    FOnAfterMasterDeleted: TSimpleEvent;

    DataSetGuia: TQuery;
    DataSetMaestro: TQuery;
    //enclave: TBookMark;

    (*
    bAltas, bBajas, bModificaciones, bBusquedas: Boolean;
    *)

    procedure ChangeMasterRecord; virtual;
    procedure Filtro; virtual;
    function  GetFiltro( var AFiltro: string ): Boolean; virtual;
    procedure AnyadirRegistro; virtual;
    procedure WriteEstado(const value: TEstado);

    procedure SincronizarWeb; virtual;

  public
    { Public declarations }
    PCMaestro: TPosicionCursor; //posicon dentro del dataset
    Registro, Registros, RegistrosInsertados: Integer;

    PanelMaestro: TPanel;

//** Foco inicial para cada estado
    FocoAltas: TWinControl;
    FocoModificar: TWinControl;
    FocoLocalizar: TWinControl;

    //Para rellenar las consultas
    Select: string;
    From: string;
    Where: string;
    Order: string;


    constructor Create( AOwner: TComponent ); override;

    //aceptar/cancelar acciones maestro
    procedure Aceptar; virtual;
    procedure Cancelar; virtual;

    //desplazamiento maestro
    procedure Primero; virtual;
    procedure Anterior; virtual;
    procedure Siguiente; virtual;
    procedure Ultimo; virtual;

    //acciones maestro
    procedure Localizar; virtual;
    procedure Filtrar; virtual;
    procedure Modificar; virtual;
    procedure Borrar; virtual;
    procedure Altas; virtual;

    //salir del formulario
    procedure Salir;

    //Otros
    //Visualizar conjunto resultado (o poner en espera)
    procedure Visualizar; virtual;

    //Aceptar
    procedure AceptarAlta; virtual;
    procedure AceptarModificar;
    procedure AceptarLocalizar; virtual;

    //Cancelar
    procedure CancelarAlta; virtual;
    procedure CancelarModificar;
    procedure CancelarLocalizar; virtual;

    //Borrar
//    procedure BorrarSeleccion;
    procedure BorrarActivo;

    //Listado
    procedure Previsualizar; virtual;

  published
    property Estado: TEstado read FEstado write WriteEstado;
    property Filtrado: Boolean read FFiltrar write FFiltrar;

    (*
    property CanInsert: boolean read bAltas write bAltas default true;
    property CanEdit: boolean read bModificaciones write bModificaciones default true;
    property CanBrowse: boolean read bBusquedas write bBusquedas default true;
    property CanDelte: boolean read bBajas write bBajas default true;
    *)

    property OnInsert: TSimpleEvent read FOnInsert write FOnInsert;
    property OnErrorInsert: TSimpleEvent read FOnErrorInsert write FOnErrorInsert;
    property OnEdit: TSimpleEvent read FOnEdit write FOnEdit;
    property OnBrowse: TSimpleEvent read FOnBrowse write FOnBrowse;
    property OnView: TSimpleEvent read FOnView write FOnView;
    property OnBeforeMasterDelete: TSimpleEvent read FOnBeforeMasterDelete write FOnBeforeMasterDelete;
    property OnAfterMasterDeleted: TSimpleEvent read FOnAfterMasterDeleted write FOnAfterMasterDeleted;
    property OnValidateMasterConstrains: TSimpleEvent read FOnValidateMasterConstrains write FOnValidateMasterConstrains;
    property OnAfterInsertMaster: TSimpleEvent read FOnAfterInsertMaster write FOnAfterInsertMaster;
    property OnChangeMasterRecord: TSimpleEvent read FOnChangeMasterRecord write FOnChangeMasterRecord;
    property OnChangeState: TSimpleEvent read FOnChangeState write FOnChangeState;

  protected
    function CantidadRegistros: Integer;
  end;

implementation

uses CGestionPrincipal, CAuxiliarDB, UDMBaseDatos, DError;

//===================  CODIGO GENERICO  ========================




constructor TMaestro.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  DataSetGuia:= nil;
  FFiltrar:= False;
end;


procedure TMaestro.Salir;
begin
     //Borramos contenio barra de estado
  BETexto('', '');
     //Cerramos formulario
  Close;
end;

//**************************  DESPLAZAMIENTO MAESTRO  **************************

procedure TMaestro.Primero;
begin
     //Poner en la primera posicion
  if DataSetGuia <> nil then
  begin
    if DataSetGuia.BOF then
    begin
      beep;
      Registro := 1;
      BHGrupoDesplazamientoMaestro(pcInicio);
      BERegistros;
      BEMensajes('Ya se esta situado en el primer registro');
    end
    else
    begin
      DataSetGuia.First;
      Registro := 1;
      ChangeMasterRecord;
      BEMensajes('');
    end;
  end
  else
  begin
    if DataSeTMaestro.BOF then
    begin
      beep;
      Registro := 1;
      BHGrupoDesplazamientoMaestro(pcInicio);
      BERegistros;
      BEMensajes('Ya se esta situado en el primer registro');
    end
    else
    begin
      DataSeTMaestro.First;
      Registro := 1;
      ChangeMasterRecord;
      BEMensajes('');
    end;
  end;
end;

procedure TMaestro.Anterior;
begin
     //Poner en la posicion anterior
    if DataSetGuia <> nil then
  begin
    if DataSetGuia.BOF then
    begin
      beep;
      Registro := 1;
      BHGrupoDesplazamientoMaestro(pcInicio);
      BERegistros;
      BEMensajes('Ya se esta situado en el primer registro');
    end
    else
    begin
      DataSetGuia.Prior;
      Registro := Registro - 1;
      ChangeMasterRecord;
      BEMensajes('');
    end;
  end
  else
  begin
    if DataSeTMaestro.BOF then
    begin
      beep;
      Registro := 1;
      BHGrupoDesplazamientoMaestro(pcInicio);
      BERegistros;
      BEMensajes('Ya se esta situado en el primer registro');
    end
    else
    begin
      DataSeTMaestro.Prior;
      Registro := Registro - 1;
      ChangeMasterRecord;
      BEMensajes('');
    end;
  end;
end;

procedure TMaestro.Siguiente;
begin
  //Poner en la posicion siguiente
  if DataSetGuia <> nil then
  begin
    if DataSetGuia.EOF then
    begin
      beep;
      Registro := Registros;
      BHGrupoDesplazamientoMaestro(pcFin);
      BERegistros;
      BEMensajes('Ya se esta situado en el ultimo registro');
    end
    else
    begin
      DataSetGuia.Next;
      Registro := Registro + 1;
      ChangeMasterRecord;
      BEMensajes('');
    end;
  end
  else
  begin
    if DataSeTMaestro.EOF then
    begin
      beep;
      Registro := Registros;
      BHGrupoDesplazamientoMaestro(pcFin);
      BERegistros;
      BEMensajes('Ya se esta situado en el ultimo registro');
    end
    else
    begin
      DataSeTMaestro.Next;
      Registro := Registro + 1;
      ChangeMasterRecord;
      BEMensajes('');
    end;
  end;
end;

procedure TMaestro.SincronizarWeb;
begin

end;

procedure TMaestro.Ultimo;
begin
     //Poner en la ultima posicion
  if DataSetGuia <> nil then
  begin
    if DataSetGuia.EOF then
    begin
      beep;
      Registro := Registros;
      BHGrupoDesplazamientoMaestro(pcFin);
      BERegistros;
      BEMensajes('Ya se esta situado en el ultimo registro');
    end
    else
    begin
      DataSetGuia.Last;
      Registro := Registros;
      ChangeMasterRecord;
      BEMensajes('');
    end;
  end
  else
  begin
    if DataSeTMaestro.EOF then
    begin
      beep;
      Registro := Registros;
      BHGrupoDesplazamientoMaestro(pcFin);
      BERegistros;
      BEMensajes('Ya se esta situado en el ultimo registro');
    end
    else
    begin
      DataSeTMaestro.Last;
      Registro := Registros;
      ChangeMasterRecord;
      BEMensajes('');
    end;
  end;
end;

//*******************************  ACCIONES MAESTRO  ***************************

procedure TMaestro.Localizar;
begin
  if FFiltrar then
  begin
    Filtrar;
  end
  else
  begin
    DataSeTMaestro.Cancel;
    if DataSeTMaestro.Active then
    begin
      //Estado
      Estado := teLocalizar;
      BEEstado;
      BHEstado;
      PanelMaestro.Enabled := True;

      DataSeTMaestro.Insert;

      if Assigned(FOnBrowse) then
        FOnBrowse;

      //Poner foco
      Self.ActiveControl := FocoLocalizar;
    end;
  end;
end;

procedure TMaestro.Filtrar;
var
  sFiltro: string;
begin
     //Construir filtro con datos pasados
  if GetFiltro( sFiltro ) then
  begin
    Where:= sFiltro;
    //Aplicar Query
    if DataSetGuia <> nil then
    begin
      DataSetGuia.SQL.Clear;
      DataSetGuia.SQL.Add(Select);
      DataSetGuia.SQL.Add(Where);
      DataSetGuia.SQL.Add(Order);
    end
    else
    begin
      DataSeTMaestro.SQL.Clear;
      DataSeTMaestro.SQL.Add(Select);
      DataSeTMaestro.SQL.Add(Where);
      DataSeTMaestro.SQL.Add(Order);
    end;


    //activar Query
    try
      if DataSetGuia <> nil then
      begin
        AbrirConsulta(DataSetGuia);
      end
      else
      begin
        AbrirConsulta(DataSeTMaestro);
      end;

    except
      try
      except
        //Seguramente no existe el directorio
      end;
      Exit;
    end;

    //Numero de registros
    Registros := CantidadRegistros;
    Registro := 1;

    //Poner estado segun el resultado de la busqueda
    Visualizar;

    //Mensaje si no encontramos ningun registro
    if Registros = 0 then
      BEMensajes('No se encontro ningun registro')
    else
      BERegistros;
  end;
end;

procedure TMaestro.Modificar;
begin
  if not DataSeTMaestro.CanModify
    then Exit;

     //Estado
  Estado := teModificar;
  BEEstado;
  BHEstado;
  PanelMaestro.Enabled := True;

     //ponemos en edicion
  DataSeTMaestro.Edit;

  try
    if Assigned(FOnEdit)
      then FOnEdit;
  except
    Cancelar;
    Exit;
  end;

  //Poner foco
  if FocoModificar.CanFocus then
    Self.ActiveControl := FocoModificar;
end;

procedure TMaestro.Borrar;
var botonPulsado: Word;
begin
  if Assigned(FOnBeforeMasterDelete) then
  begin
    try
      FOnBeforeMasterDelete;
    except
      on E: Exception do
      begin
        ShowError(e);
        Exit;
      end;
    end;
  end;

     //Barra estado
  Estado := teBorrar;
  BEEstado;
  BHEstado;

     //preguntar si realmente queremos borrar
{     botonPulsado:=MessageDlg('Realmente quiere borrar el registro activo',
                    mtConfirmation,[mbYes,mbNo,mbAll],0);
}
  botonPulsado := MessageDlg('¿Desea borrar la ficha seleccionada?',
    mtConfirmation, [mbYes, mbNo], 0);
  if botonPulsado = mrYes then
  try
    BorrarActivo;
    if Assigned(FOnAfterMasterDeleted) then
      FOnAfterMasterDeleted;

  except
    on E: EDBEngineError do
    begin
      ShowError(e);
    end;
  end;

{     else
     if botonPulsado=mrAll then
        try
           BorrarSeleccion;
        except
           on E:Exception do
           begin
                Error(E.Message);
           end;
        end;
}

     //Por ultimo visualizamos resultado
  Visualizar;
end;

{procedure TMaestro.BorrarSeleccion;
begin
     //Abrir transaccion
     if AbrirTransaccion(DMBaseDatos.DBBaseDatos) then
        Exit;

     DataSeTMaestro.DisableControls;

     try
        DataSeTMaestro.First;
        while not DataSeTMaestro.Eof do
        begin
             DataSeTMaestro.Delete;
        end;
     except
        CancelarTransaccion(DMBaseDatos.DBBaseDatos);
        raise Exception.Create('No puedo borrar el conjunto de registros seleccionado.');
     end;

     //Todo correcto
     AceptarTransaccion(DMBaseDatos.DBBaseDatos);
     Registro:=0;
     Registros:=0;

     ReEnableControls(DataSeTMaestro);
end;
}


procedure TMaestro.BorrarActivo;
begin
  DataSeTMaestro.Delete;
  IF DataSetGuia <> nil then
  begin
    if DataSeTMaestro.IsEmpty then
    begin
      //Va a dar error
      DataSetGuia.Delete;
      if Registro = Registros then
        Registro := Registro - 1;
      Registros := Registros - 1;
    end;
  end
  else
  begin
    if Registro = Registros then
      Registro := Registro - 1;
    Registros := Registros - 1;
  end;
end;

procedure TMaestro.Altas;
begin
     //La primera insercion de la tanda
  if Estado <> teAlta then
  begin
          //Todavia no hemos insertado ningun registro
    RegistrosInsertados := 0;
          //gConjuntoInsertado:='';
    where := '';

          //Guardamos posicion de vuelta por si no hacemos ninguna insercion
          //enclave:=DataSeTMaestro.GetBookmark;

          //Quitamos filtro para evitar problemas en la insercion
          //DataSeTMaestro.Filtered:=False;

          //Ponemos estado
    Estado := teAlta;
    BEEstado;
    BHEstado;
    PanelMaestro.Enabled := true;
  end;

     //Sacamos el foco de cualquier sitio
  ActiveControl := nil;

     //Insertamos un nuevo registro
  DataSeTMaestro.Insert;

     // Antes de la inserccion
  if Assigned(FOnInsert) then FOnInsert;

     //Poner foco
  Self.ActiveControl := FocoAltas;
end;

//*******************  ACEPTAR/CANCELAR ACCIONES MAESTRO  **********************

procedure TMaestro.Aceptar;
begin
  case Estado of
    teAlta: AceptarAlta;
    teLocalizar: AceptarLocalizar;
    teModificar: AceptarModificar;
  end;
end;

procedure TMaestro.Cancelar;
begin
  case Estado of
    teAlta: CancelarAlta;
    teLocalizar: CancelarLocalizar;
    teModificar: CancelarModificar;
  end;
end;

procedure TMaestro.Visualizar;
begin
  if Registros = 0 then
  begin
    Estado := teEspera;
    BHGrupoDesplazamientoMaestro(pcNulo);
  end
  else
  begin
    Estado := teConjuntoResultado;
    ChangeMasterRecord;
  end;
  BEEstado;
  BHEstado;
  PanelMaestro.Enabled := False;

  if Assigned(FOnView) then FOnView;
end;

//Aceptar

procedure TMaestro.AceptarAlta;
begin
     //Evento antes de insertar
  try
    if Assigned(FOnValidateMasterConstrains) then FOnValidateMasterConstrains;
  except
    on E: Exception do
    begin
      ShowError(E);
      Exit;
    end;
  end;

  try
    GrabarDatos(DataSeTMaestro);
    SincronizarWeb;
  except
    Exit;
  end;

  try
    if Assigned(FOnAfterInsertMaster) then FOnAfterInsertMaster;
  except
    on E: Exception do
    begin
      ShowError(E);
    end;
  end;

  RegistrosInsertados := RegistrosInsertados + 1;
  AnyadirRegistro;

     //Hasta que no cancelemos daremos altas
  if MultiplesAltas then
    Altas
  else
    CancelarAlta;
end;

procedure TMaestro.AceptarModificar;
begin
     //Evento antes de modificar
  try
    if Assigned(FOnValidateMasterConstrains) then FOnValidateMasterConstrains;
  except
    on E: Exception do
    begin
      ShowError(E);
           {Cancelar;}
      Exit;
    end;
  end;

  try
    GrabarDatos(DataSeTMaestro);
        //Refrescar para que no de el error de que otro usuario ha
        //modificado el registro
        {enclave:=DataSeTMaestro.GetBookmark;
        DataSeTMaestro.Cancel;
        DataSeTMaestro.Close;
        DataSeTMaestro.Open;
        DataSeTMaestro.GotoBookmark(enclave);
        DataSeTMaestro.FreeBookmark(enclave);}
    SincronizarWeb;
  except
    Exit;
  end;

     //Visualizamos resultado
  Visualizar;
end;

procedure TMaestro.AceptarLocalizar;
begin
     //Construir filtro con datos pasados
  Filtro;
  if DataSetGuia <> nil then
  begin
    DataSetGuia.Cancel;
    DataSetGuia.Close;
    DataSetGuia.SQL.Clear;
    DataSetGuia.SQL.Add(Select);
    DataSetGuia.SQL.Add(Where);
    DataSetGuia.SQL.Add(Order);
  end
  else
  begin
    DataSeTMaestro.Cancel;
    DataSeTMaestro.Close;
    DataSeTMaestro.SQL.Clear;
    DataSeTMaestro.SQL.Add(Select);
    DataSeTMaestro.SQL.Add(Where);
    DataSeTMaestro.SQL.Add(Order);
  end;

  //activar Query
  try
    if DataSetGuia <> nil then
    begin
      AbrirConsulta(DataSetGuia);
    end
    else
    begin
      AbrirConsulta(DataSeTMaestro);
    end;
  except
    try
    except
      //Seguramente no existe el directorio
    end;
    Exit;
  end;

     //Numero de registros
  Registros := CantidadRegistros;
  Registro := 1;

     //Poner estado segun el resultado de la busqueda
  Visualizar;

     //Mensaje si no encontramos ningun registro
  if Registros = 0 then
    BEMensajes('No se encontro ningun registro')
  else
    BERegistros;
end;

//Cancelar

procedure TMaestro.CancelarAlta;
begin
     //Cancelamos
  DataSeTMaestro.Cancel;

  if RegistrosInsertados <> 0 then
  begin
    //Realizar consulta con datos pasados
    if DataSetGuia <> nil then
    begin
      DataSetGuia.Cancel;
      DataSetGuia.Close;
      DataSetGuia.SQL.Clear;
      DataSetGuia.SQL.Add(Select);
      if Trim(where) <> '' then
        DataSetGuia.SQL.Add(where);
      DataSetGuia.SQL.Add(Order);
    end
    else
    begin
      DataSeTMaestro.Cancel;
      DataSeTMaestro.Close;
      DataSeTMaestro.SQL.Clear;
      DataSeTMaestro.SQL.Add(Select);
      if Trim(where) <> '' then
        DataSeTMaestro.SQL.Add(where);
      DataSeTMaestro.SQL.Add(Order);
    end;

    try
      if DataSetGuia <> nil then
      begin
        AbrirConsulta(DataSetGuia);
      end
      else
      begin
        AbrirConsulta(DataSeTMaestro);
      end;
    except
             //Close;
      Registros := 0;
      Registro := 1;
      Visualizar;
      Exit;
    end;
          //Cuantos datos estamos visualizando actualmente
    Registros := CantidadRegistros;
    Registro := 1;
  end;
  Visualizar;
end;

procedure TMaestro.CancelarModificar;
begin
     //Cancelamos
  DataSeTMaestro.Cancel;

     //Poner estado
  Visualizar;
end;

procedure TMaestro.CancelarLocalizar;
begin
     //Cancelamos
  DataSeTMaestro.Cancel;

  Visualizar;
end;

procedure TMaestro.Filtro;
begin
end;

function TMaestro.GetFiltro( var AFiltro: string ): Boolean;
begin
  result:= false;
end;

procedure TMaestro.AnyadirRegistro;
begin
end;

procedure TMaestro.Previsualizar;
begin
end;

procedure TMaestro.ChangeMasterRecord;
begin
  if Registros = 0 then BHGrupoDesplazamientoMaestro(pcNulo)
  else
    if Registro = Registros then
    begin
      if Registro = 1 then BHGrupoDesplazamientoMaestro(pcNulo)
      else BHGrupoDesplazamientoMaestro(pcFin);
    end
    else
      if Registro = 1 then BHGrupoDesplazamientoMaestro(pcInicio)
      else BHGrupoDesplazamientoMaestro(pcMedio);

  BERegistros;

     //Evento cambio de registro
  if Assigned(FOnChangeMasterRecord) then FOnChangeMasterRecord;
end;

procedure TMaestro.WriteEstado(const value: TEstado);
begin
  if Assigned(FOnChangeState) then FOnChangeState;
  FEstado := value;
end;

function TMaestro.CantidadRegistros: Integer;
var
  consulta:TQuery;
  i: integer;
begin
  if DataSetGuia <> nil then
  begin
    result := DataSetGuia.RecordCount;
  end
  else
  begin
    result := DataSeTMaestro.RecordCount;
  end;
  if result < 0 then
  begin
    result:= 0;
    consulta:=TQuery.Create(Nil);
    consulta.DatabaseName:= DataSeTMaestro.DatabaseName;
    i:= pos( 'FROM', UpperCase(select) );
    from:= copy( select, i, ( length( select ) + 1 ) - i );
    consulta.sql.Add('SELECT count(*) ' + from + ' ' + where);
    try
      try
        try
          consulta.Open;
        except
          try
          except
            //Seguramente no existe el directorio
          end;
          raise;
        end;
        result:= consulta.Fields[0].AsInteger;
        consulta.Close;
      finally
        consulta.Free;
      end;
    except
      result:= 0;
    end;
  end;
end;

initialization
  MultiplesAltas := true;

end.

