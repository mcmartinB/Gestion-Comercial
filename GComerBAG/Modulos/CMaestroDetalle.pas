unit CMaestroDetalle;

interface

uses
  forms, Windows, SysUtils, Classes, Controls, Dialogs,
  ExtCtrls, db, dbtables, dbgrids, CVariables, CMaestro, DError;

var
  LineasObligadas: boolean;
  ListadoObligado: boolean;
  MultipleAltas: boolean;

type
  TMaestroDetalle = class(TMaestro)

  private
    { Private declarations }
    FOnValidateDetailConstrains: TSimpleEvent;
    FOnChangeDetailRecord: TSimpleEvent;
    FOnBeforeDetailDelete: TSimpleEvent;
    FOnViewDetail: TSimpleEvent;
    FOnEditDetail: TSimpleEvent;
    FOnAfterDetailDeleted: TSimpleEvent;
  protected
    { Protected declarations }
    PanelDetalle: TPanel;
    RejillaVisualizacion: TDBGrid;

    procedure ChangeMasterRecord; override;
    procedure ChangeDetailRecord; virtual;
    procedure ReintentarAlta; virtual;
    procedure RestaurarCabecera; virtual;

    procedure SincronizarDetalleWeb; virtual;

  public
    { Public declarations }
    FocoDetalle: TWinControl;
    Detalle, Detalles, DetallesInsertados: Integer;
    PCDetalle: TPosicionCursor;
    EstadoDetalle: TEstadoDetalle;
    DataSourceDetalle: TDataSource;

    //aceptar/cancelar acciones maestro
    procedure Aceptar; override;
    procedure Cancelar; override;


    //acciones maestro
    procedure Localizar; override;
    procedure Modificar; override;
    procedure Borrar; override;
    procedure Altas; override;


    //Otros
    //Visualizar conjunto resultado (o poner en espera)
    procedure Visualizar; override;

    //Aceptar
    procedure AceptarAlta; override;
    procedure AceptarModificar;
    procedure AceptarLocalizar; override;

    //Cancelar
    procedure CancelarAlta; override;
    procedure CancelarModificar;
    procedure CancelarLocalizar; override;

    //Borrar
{    procedure BorrarSeleccion;}
    procedure BorrarActivo;

    //Detalle
    //aceptar/cancelar acciones detalle
    procedure DetalleAceptar; virtual;
    procedure DetalleCancelar; virtual;
    //desplazamiento detalle
    procedure DetalleAnterior; virtual;
    procedure DetalleSiguiente; virtual;

    //acciones detalle
    procedure DetalleModificar; virtual;
    procedure DetalleBorrar; virtual;
    procedure DetalleAltas; virtual;

    //otros
    procedure CancelarAltaDetalle; virtual;
    procedure CancelarModificarDetalle; virtual;
    procedure AceptarAltaDetalle; virtual;
    procedure AceptarModificarDetalle; virtual;

  published
    property OnValidateDetailConstrains: TSimpleEvent read FOnValidateDetailConstrains write FOnValidateDetailConstrains;
    property OnChangeDetailRecord: TSimpleEvent read FOnChangeDetailRecord write FOnChangeDetailRecord;
    property OnBeforeDetailDelete: TSimpleEvent read FOnBeforeDetailDelete write FOnBeforeDetailDelete;
    property OnAfterDetailDeleted: TSimpleEvent read FOnAfterDetailDeleted write FOnAfterDetailDeleted;
    property OnViewDetail: TSimpleEvent read FOnViewDetail write FOnViewDetail;
    property OnEditDetail: TSimpleEvent read FOnEditDetail write FOnEditDetail;

  end;

implementation

uses CGestionPrincipal, CAuxiliarDB, UDMBaseDatos, AdvertenciaFD;

//===================  CODIGO GENERICO  ========================

//**************************  DESPLAZAMIENTO DETALLE  **************************

procedure TMaestroDetalle.DetalleAnterior;
begin
     //Poner en la posicion anterior
  if DataSourceDetalle.DataSet.BOF then
  begin
    beep;
    Detalle := 1;
    BHGrupoDesplazamientoDetalle(pcInicio);
    BERegistros;
    BEMensajes('Ya se esta situado en el primer registro');
  end
  else
  begin
    DataSourceDetalle.DataSet.Prior;
    Detalle := Detalle - 1;
    ChangeDetailRecord;
    BEMensajes('');
  end;
end;

procedure TMaestroDetalle.DetalleSiguiente;
begin
       //Poner en la posicion siguiente
  if DataSourceDetalle.DataSet.EOF then
  begin
    beep;
    Detalle := Detalles;
    BHGrupoDesplazamientoDetalle(pcFin);
    BERegistros;
    BEMensajes('Ya se esta situado en el ultimo registro');
  end
  else
  begin
    DataSourceDetalle.DataSet.Next;
    Detalle := Detalle + 1;
    ChangeDetailRecord;
    BEMensajes('');
  end;
end;

//*******************************  ACCIONES MAESTRO  ***************************

procedure TMaestroDetalle.Localizar;
begin
  EstadoDetalle := tedOperacionMaestro;
  inherited Localizar;
     //Deshabilitamos el DBGrid
  RejillaVisualizacion.Enabled := False;
     //Deshabilitamos mensajes del DataSet a sus DataSource
  DataSeTMaestro.DisableControls;
end;

procedure TMaestroDetalle.Modificar;
begin
  EstadoDetalle := tedOperacionMaestro;
  inherited Modificar;
     //Deshabilitamos el DBGrid
  RejillaVisualizacion.Enabled := False;
end;

procedure TMaestroDetalle.Borrar;
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
  EstadoDetalle := tedOperacionMaestro;
  BEEstado;
  BHEstado;

     //preguntar si realmente queremos borrar
  botonPulsado := mrNo;
  //if application.MessageBox('Esta usted seguro de querer borrar la cabecera con todas sus lineas?',
  //  '  ATENCIÓN !', MB_OKCANCEL + MB_ICONWARNING + MB_DEFBUTTON2) = IDOK then
  if VerAdvertencia( Self, #13 + #10 + ' ¿Esta usted seguro de querer borrar el ficha completa con su detalle asociado?', '    BORRAR FICHA',
                     'Quiero borrar el ficha completa', 'Borrar Ficha'  ) = mrIgnore then
    botonPulsado := mrYes;

     {
     botonPulsado:=MessageDlg('',
                    mtConfirmation,[mbYes,mbNo,mbAll],0);
      }
  if botonPulsado = mrYes then
    BorrarActivo;
{
     else
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

{
procedure TMaestroDetalle.BorrarSeleccion;
begin
     //Abrir trnsaccion
     if AbrirTransaccion(DMBaseDatos.DBBaseDatos) then
        Exit;

     DataSetMaestro.DisableControls;
     DataSourceDetalle.DataSet.DisableControls;

     try
        DataSetMaestro.First;
        while not DataSetMaestro.Eof do
        begin
             //Borrar detalle
             DataSourceDetalle.DataSet.First;
             while not DataSourceDetalle.DataSet.Eof do
             begin
                  DataSourceDetalle.DataSet.Delete;
             end;
             //Borrar maestro
             DataSetMaestro.Delete;
        end;
     except
        CancelarTransaccion(DMBaseDatos.DBBaseDatos);
        raise Exception.Create('No puedo borrar el conjunto de registros seleccionado.');
     end;

     //Todo correcto
     AceptarTransaccion(DMBaseDatos.DBBaseDatos);
     Registro:=0;
     Registros:=0;

     DataSetMaestro.EnableControls;
     DataSourceDetalle.DataSet.EnableControls;
end;
}

procedure TMaestroDetalle.BorrarActivo;
var enclave: TBookMark;
begin
     //Abrir trnsaccion
  if not AbrirTransaccion(DMBaseDatos.DBBaseDatos) then
    Exit;

  DataSetMaestro.DisableControls;

     //Borramos detalle
  try
    DataSourceDetalle.DataSet.First;
    while not DataSourceDetalle.DataSet.Eof do
      DataSourceDetalle.DataSet.Delete;
  except
    on e: EDBEngineError do
    begin
      ShowError(e);
      CancelarTransaccion(DMBaseDatos.DBBaseDatos);
      DataSetMaestro.EnableControls;
      Exit;
    end;
  end;

     //Borramos maestro
  try
    DataSetMaestro.Delete;
    if Assigned(FOnAfterMasterDeleted) then
      FOnAfterMasterDeleted;

  except
    on e: EDBEngineError do
    begin
      ShowError(e);
      CancelarTransaccion(DMBaseDatos.DBBaseDatos);
      DataSetMaestro.EnableControls;
      if DataSourceDetalle.DataSet.IsEmpty then
      begin
        DataSourceDetalle.DataSet.Close;
        DataSourceDetalle.DataSet.Open;
      end
      else
      begin
        enclave := DataSourceDetalle.DataSet.GetBookmark;
        DataSourceDetalle.DataSet.Close;
        DataSourceDetalle.DataSet.Open;
        try
          DataSourceDetalle.DataSet.GotoBookmark(enclave);
        except
          DataSourceDetalle.DataSet.FreeBookmark(enclave);
        end;
      end;
      Exit;
    end;
  end;

  DataSetMaestro.EnableControls;
  AceptarTransaccion(DMBaseDatos.DBBaseDatos);
  if Registro = Registros then Registro := Registro - 1;
  Registros := Registros - 1;
end;


procedure TMaestroDetalle.Altas;
begin
  //La primera insercion de la tanda
  if Estado <> teOperacionDetalle then
  begin
          //De momento ningun registro insertado
    RegistrosInsertados := 0;
    where := '';

    //punto de retorno por si no insertamos ningun registro
    //enclave := DataSetMaestro.GetBookmark;

          //Deshabilitamos el DBGrid
    RejillaVisualizacion.Enabled := false;

    Detalles := 0;
  end
  else
  begin
       //Solicitamos impresion
    if ListadoObligado then
    begin
      if not ((DetallesInsertados = 0) and (Detalles = 0)) then
        Previsualizar;
    end;
  end;
  DetallesInsertados := 0;

     //Ponemos estado
  Estado := teAlta;
  EstadoDetalle := tedOperacionMaestro;
  BEEstado;
  BHEstado;
  PanelMaestro.Enabled := True;
  PanelDetalle.Enabled := false;

     //Insertamos un nuevo registro
  DataSetMaestro.Insert;

     // Antes de la inserccion
  if Assigned(FOnInsert) then FOnInsert;

     //Poner foco
  Self.ActiveControl := FocoAltas;
end;

//*******************************  ACCIONES DETALLE  ***************************

procedure TMaestroDetalle.DetalleBorrar;
begin
  if Assigned(FOnBeforeDetailDelete) then
  begin
    try
      FOnBeforeDetailDelete;
    except
      on E: Exception do
      begin
        ShowError(e);
        Exit;
      end;
    end;
  end;

  Estado := teOperacionDetalle;
  EstadoDetalle := tedBorrar;
  BEEstado;
  BHEstado;



  if (DataSourceDetalle.DataSet.RecordCount > 1) or
    not LineasObligadas then
  begin
    if MessageDlg('¿Desea borrar la linea seleccionada?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
        //Borramos detalle activo
      try
        DataSourceDetalle.DataSet.Delete;
        if Assigned(FOnAfterDetailDeleted) then
          FOnAfterDetailDeleted;

        if Detalle = Detalles then
          Detalle := Detalle - 1;
        Detalles := Detalles - 1;
      except
        on E: EDBEngineError do
        begin
          ShowError(e);
        end;
      end;
    end;
  end
  else
  begin
    if application.MessageBox('Esta es la ultima linea, si la borra tambien' + #13 + #10 + 'se borrara la cabecera asociada.' + #13 + #10 + '¿Esta uste seguro de querer continuar?',
      '  ATENCIÓN !', MB_OKCANCEL + MB_ICONWARNING + MB_DEFBUTTON2) = IDOK then
    begin
        {
        if not AbrirTransaccion(DMBaseDatos.DBBaseDatos) then
        begin
             Visualizar;
             Exit;
        end;

        try
        }
      Borrar;
        {
           DataSourceDetalle.DataSet.Delete;
           if Detalle=Detalles then
              Detalle:=Detalle-1;
           Detalles:=Detalles-1;

           DataSetMaestro.Delete;
           if Registro=Registros then
              Registro:=Registro-1;
           Registros:=Registros-1;

           AceptarTransaccion(DMBaseDatos.DBBaseDatos);
        except
           On E:EDBEngineError do
           begin
                CancelarTransaccion(DMBaseDatos.DBBaseDatos);
                ShowError(e);
           end;
        end;
        }
    end;
  end;

     //Por ultimo visualizamos resultado
  Visualizar;
end;

procedure TMaestroDetalle.DetalleModificar;
var aux: TEstadoDetalle;
begin
     //Evento antes de permitir la entrada de datos
  aux := EstadoDetalle;
  EstadoDetalle := tedModificar;
  if Assigned(FOnEditDetail) then
  try
    FOnEditDetail;
  except
    on E: Exception do
    begin
             //Cancelamos
      EstadoDetalle := Aux;
      ShowError(e);
      Exit;
    end;
  end;

     //Guardar posicion
  Estado := teOperacionDetalle;
  BEEstado;
  BHEstado;
  if DataSourceDetalle.DataSet.canModify then
    if DataSourceDetalle.DataSet <> nil then
      DataSourceDetalle.DataSet.Edit;
  PanelDetalle.Enabled := true;
     //Deshabilitamos el DBGrid
  RejillaVisualizacion.Enabled := false;
     //Poner foco
  if FocoDetalle <> nil then
  begin
    if FocoDetalle.Enabled and FocoDetalle.Visible and FocoDetalle.CanFocus then
    begin
      Self.ActiveControl := FocoDetalle;
    end;
  end;
end;

procedure TMaestroDetalle.DetalleAltas;
begin
     //Evento antes de permitir la entrada de datos
  if Assigned(FOnEditDetail) then
  try
    FOnEditDetail;
  except
    on E: Exception do
    begin
             //Cancelamos
      ShowError(e);
      Exit;
    end;
  end;

     //La primera insercion de la tanda
  if Estado <> teOperacionDetalle then
  begin
          //estado detalle
    if Estado = teAlta then
      EstadoDetalle := tedAltaRegresoMaestro
    else
      EstadoDetalle := tedAlta;
          //estado maestro
    Estado := teOperacionDetalle;

    DetallesInsertados := 0;
    BEEstado;
    BHEstado;

    PanelMaestro.Enabled := false;
    PanelDetalle.Enabled := true;
          //Deshabilitamos el DBGrid
    RejillaVisualizacion.Enabled := false;
  end;
     //Poner foco
  Self.ActiveControl := FocoDetalle;
     //Todas la inserciones
  if DataSourceDetalle.Dataset.CanModify then
    DataSourceDetalle.DataSet.Insert;
end;


//*******************  ACEPTAR/CANCELAR ACCIONES MAESTRO  **********************

procedure TMaestroDetalle.Aceptar;
begin
  self.ActiveControl := nil;
  case Estado of
    teAlta: AceptarAlta;
    teLocalizar: AceptarLocalizar;
    teModificar: AceptarModificar;
    teOperacionDetalle: DetalleAceptar;
  end;
end;

procedure TMaestroDetalle.Cancelar;
begin
  case Estado of
    teAlta: CancelarAlta;
    teLocalizar: CancelarLocalizar;
    teModificar: CancelarModificar;
    teOperacionDetalle: DetalleCancelar;
  end;
end;

procedure TMaestroDetalle.Visualizar;
begin
  if Estado = teOperacionDetalle then
  begin
    if Assigned(FOnViewDetail) then FOnViewDetail
  end
  else
  begin
    if Assigned(FOnView) then FOnView;
  end;

  if Registros = 0 then
  begin
    Estado := teEspera;
    BHGrupoDesplazamientoMaestro(pcNulo);
    BHGrupoDesplazamientoDetalle(pcNulo);
  end
  else
  begin
    Estado := teConjuntoResultado;
    ChangeMasterRecord;
  end;

  BEEstado;
  BHEstado;
  BERegistros;

  PanelMaestro.Enabled := False;
  PanelDetalle.Enabled := False;
     //Habilitamos el DBGrid

  RejillaVisualizacion.Enabled := true;
  RejillaVisualizacion.BringToFront;
end;

//Aceptar

procedure TMaestroDetalle.AceptarAlta;
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

  if not LineasObligadas then
  try
    DataSetMaestro.Post;
    RegistrosInsertados := RegistrosInsertados + 1;
    SincronizarWeb;    
    AnyadirRegistro;
  except
    on e: EDBengineError do
    begin
      ShowError(e);
      if Assigned(FOnErrorInsert) then FOnErrorInsert;
      Self.ActiveControl := FocoAltas;
      Exit;
    end;
  end;

  try
    if Assigned(FOnAfterInsertMaster) then FOnAfterInsertMaster;
  except
    on E: Exception do
    begin
      ShowError(E);
    end;
  end;

  //Hasta que no cancelemos daremos altas
  DetalleAltas;
end;

procedure TMaestroDetalle.AceptarModificar;
begin
     //Evento antes de modificar
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
    DataSetMaestro.Post;
    SincronizarWeb;    
  except
    on e: EDBengineError do
    begin
      ShowError(e);
           //Cancelar;
      Exit;
    end;
  end;

     //Visualizamos resultado
  Visualizar;
end;

procedure TMaestroDetalle.AceptarLocalizar;
begin
     //Construir filtro con datos pasados
  Filtro;
     //Cerramos detalle
  DataSourceDetalle.DataSet.Cancel;
  DataSourceDetalle.DataSet.Close;
     //Cerramos maestro
  DataSeTMaestro.Cancel;
  DataSeTMaestro.Close;

     //Aplicar Query
  DataSeTMaestro.SQL.Clear;
  DataSeTMaestro.SQL.Add(Select);
  DataSeTMaestro.SQL.Add(Where);
  DataSeTMaestro.SQL.Add(Order);
  DataSeTMaestro.EnableControls;

     //activar Query
  try
    DataSeTMaestro.Open;
    DataSourceDetalle.DataSet.Open;
  except
    on e: EDBengineError do
    begin
      ShowError(e);
      Registros := 0;
      Registro := 0;
      Visualizar;
      Exit;
    end;
  end;

     //Numero de registros
  Registros := CantidadRegistros;
  Registro := 1;

     //Poner estado segun el resultado de la busqueda
  Visualizar;

     //Mensaje si no encontramos ningun registro
  if Registros = 0 then
    BEMensajes('No se han encontrado datos para los valores introducidos.');
end;

//Cancelar

procedure TMaestroDetalle.CancelarAlta;
begin
     //Cancelamos
  DataSetMaestro.Cancel;

  if RegistrosInsertados <> 0 then
  begin
          //Realizar consulta con datos pasados
    DataSourceDetalle.DataSet.Cancel;
    DataSourceDetalle.DataSet.Close;
    DataSeTMaestro.Close;
    DataSeTMaestro.SQL.Clear;
    DataSeTMaestro.SQL.Add(Select);
    if Trim(where) <> '' then
      DataSeTMaestro.SQL.Add(where);
    DataSeTMaestro.SQL.Add(Order);

    try
      DataSeTMaestro.Open;
      DataSourceDetalle.DataSet.Open;
    except
      on e: EDBengineError do
      begin
        ShowError(e);
        Registros := 0;
        Registro := 0;
        Visualizar;
        Exit;
      end;
    end;

          //Cuantos datos estamos visualizando actualmente
    Registros := CantidadRegistros;
    Registro := 1;

    if (not MultipleAltas) and ListadoObligado then
    begin
      Previsualizar;
    end;

  end;
  Visualizar;
end;

procedure TMaestroDetalle.CancelarModificar;
begin
     //Cancelamos
  DataSetMaestro.Cancel;
     //Poner estado
  Visualizar;
end;

procedure TMaestroDetalle.CancelarLocalizar;
begin
     //Cancelamos
  DataSetMaestro.Cancel;

     //Habilitar mensajes de dataset
  DataSeTMaestro.EnableControls;

     //Poner estado
  Visualizar;
end;

//*******************  ACEPTAR/CANCELAR ACCIONES DETALLE  **********************

procedure TMaestroDetalle.DetalleAceptar;
begin
  case EstadoDetalle of
    tedAlta, tedAltaRegresoMaestro: AceptarAltaDetalle;
    tedModificar: AceptarModificarDetalle;
  end;
end;

procedure TMaestroDetalle.DetalleCancelar;
begin
  case EstadoDetalle of
    tedAlta, tedAltaRegresoMaestro: CancelarAltaDetalle;
    tedModificar: CancelarModificarDetalle;
  end;
end;

procedure TMaestroDetalle.AceptarAltaDetalle;
begin
  if LineasObligadas then
  begin
    if (DetallesInsertados = 0) and (Detalles = 0) then
    begin
      if not AbrirTransaccion(DMBaseDatos.DBBaseDatos) then
        Exit;
      try
          //Evento antes de insertar detalle
        if Assigned(FOnValidateDetailConstrains) then FOnValidateDetailConstrains;

          //Insertar cabecera
        try
          DataSetMaestro.DisableControls;
          if ( DataSetMaestro.State = dsInsert ) or
             ( DataSetMaestro.State = dsEdit )  then
             begin
              DataSetMaestro.Post;
              SincronizarWeb;
             end;
        except
          on e: EDBengineError do
          begin
            CancelarTransaccion(DMBaseDatos.DBBaseDatos);
            if DataSourceDetalle.Dataset.CanModify then
            begin
              if DataSourceDetalle.State = dsInsert then
                DataSourceDetalle.DataSet.Cancel
              else
                DataSourceDetalle.DataSet.Delete;
            end;
            DataSetMaestro.EnableControls;
            ShowError(e);
            ReintentarAlta;
            Exit;
          end;
        end;

          //Insertar detalle
        try
          if DataSourceDetalle.Dataset.CanModify then
          begin
            DataSourceDetalle.DataSet.Post;
            DataSetMaestro.EnableControls;
            AceptarTransaccion(DMBaseDatos.DBBaseDatos);
            SincronizarDetalleWeb;
          end
          else
          begin
            DataSourceDetalle.DataSet.Close;
            DataSourceDetalle.DataSet.Open;
            DataSetMaestro.EnableControls;
            AceptarTransaccion(DMBaseDatos.DBBaseDatos);
          end;
        except
          on e: EDBengineError do
          begin
            CancelarTransaccion(DMBaseDatos.DBBaseDatos);
            RestaurarCabecera;
            self.ActiveControl := FocoDetalle;
            ShowError(e);
            Exit;
          end;
        end;
      except
        on E: Exception do
        begin
          CancelarTransaccion(DMBaseDatos.DBBaseDatos);
          if DataSeTMaestro.State = dsBrowse then
            DataSeTMaestro.Edit;
          ShowError(E);
          self.ActiveControl := FocoDetalle;
          Exit;
        end;
      end;
      RegistrosInsertados := RegistrosInsertados + 1;
      AnyadirRegistro;
    end
    else
    begin
      try
        try
          if Assigned(FOnValidateDetailConstrains) then FOnValidateDetailConstrains;
        except
          on E: Exception do
          begin
            ShowError(E);
            self.ActiveControl := FocoDetalle;
            Exit;
          end;
        end;
        if DataSourceDetalle.Dataset.CanModify then
        begin
          DataSourceDetalle.DataSet.Post;
          SincronizarDetalleWeb;
        end;
      except
        on e: EDBengineError do
        begin
          ShowError(e);
          self.ActiveControl := FocoDetalle;
          Exit;
        end;
      end;
    end;
  end
  else
  begin
    try
      try
        if Assigned(FOnValidateDetailConstrains) then FOnValidateDetailConstrains;
      except
        on E: Exception do
        begin
          ShowError(E);
          self.ActiveControl := FocoDetalle;
          Exit;
        end;
      end;
      if DataSourceDetalle.Dataset.CanModify then
      begin
        DataSourceDetalle.DataSet.Post;
        SincronizarDetalleWeb;
      end;
    except
      on e: EDBengineError do
      begin
        ShowError(e);
        self.ActiveControl := FocoDetalle;
        Exit;
      end;
    end;
  end;

  DetallesInsertados := DetallesInsertados + 1;
     //Hasta que no cancelemos daremos altas
  DetalleAltas;
end;

procedure TMaestroDetalle.AceptarModificarDetalle;
var enclave: TBookMark;
begin
     //Evento antes de modificar
  try
    if Assigned(FOnValidateDetailConstrains) then FOnValidateDetailConstrains;
  except
    on E: Exception do
    begin
      ShowError(E);
      Exit;
    end;
  end;

  try
    if DataSourceDetalle.Dataset.CanModify then
    begin
      DataSourceDetalle.DataSet.Post;
      SincronizarDetalleWeb;
    end;

    enclave := DataSourceDetalle.DataSet.GetBookmark;
    DataSourceDetalle.DataSet.Close;
    DataSourceDetalle.DataSet.Open;
    try
      DataSourceDetalle.DataSet.GotoBookmark(enclave);
    except
    end;
    DataSourceDetalle.DataSet.FreeBookmark(enclave);
  except
    on e: EDBengineError do
    begin
      ShowError(e);
      Cancelar;
      Exit;
    end;
    on e: Exception do
    begin
      ShowError(e);
      Cancelar;
      Exit;
    end;
  end;
  Visualizar;
end;

procedure TMaestroDetalle.CancelarAltaDetalle;
begin
     //No se permiten las cabeceras sin detalles
  if LineasObligadas then
  begin
    if (DetallesInsertados = 0) and (Detalles = 0) then
    begin
      if MessageDlg('No ha insertado ninguna linea en el detalle,' + #13 + #10 + ' si continua se borrara la cabecera. ' + #13 + #10 + '¿Esta seguro que desea continuar? ', mtWarning, [mbOK, mbCancel], 0)
        = mrCancel then
      begin
        Exit;
      end
      else
      begin
               //Cancelamos
        if DataSourceDetalle.Dataset.CanModify then
          DataSourceDetalle.DataSet.Cancel;
        DataSetMaestro.EnableControls;
        if DataSeTMaestro.state = dsBrowse then
          DataSeTMaestro.Delete
        else
          DataSeTMaestro.Cancel;
      end;
    end
    else
    begin
         //Cancelamos
      if DataSourceDetalle.Dataset.CanModify then
        DataSourceDetalle.DataSet.Cancel;
      DataSetMaestro.EnableControls;
    end;
  end
  else
  begin
       //Cancelamos
    if DataSourceDetalle.Dataset.CanModify then
      DataSourceDetalle.DataSet.Cancel;
  end;

     //Poner estado de vuelta
  if (EstadoDetalle = tedAlta) then
    Visualizar
  else
    if (not MultipleAltas) then
    begin
      CancelarAlta;
      Visualizar;
    end
    else
      Altas;
end;

procedure TMaestroDetalle.CancelarModificarDetalle;
begin
     //Cancelamos
  if DataSourceDetalle.Dataset.CanModify then
    DataSourceDetalle.DataSet.Cancel;
     //Poner estado
  Visualizar;
end;



//*******************************  EVENTOS  **********************************

procedure TMaestroDetalle.ChangeMasterRecord;
begin
  if ( M.Estado = teEspera ) or ( M.Estado = teConjuntoResultado ) then
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

     //Evento cambio de registro
    if Assigned(FOnChangeMasterRecord) then FOnChangeMasterRecord;

    Detalle := 1;
    Detalles := DataSourceDetalle.DataSet.RecordCount;

    if Detalles = 0 then
      EstadoDetalle := tedNoConjuntoResultado
    else
      EstadoDetalle := tedConjuntoResultado;
    BHGrupoAccionDetalle(Estado, EstadoDetalle);
    ChangeDetailRecord;
  end;
end;

procedure TMaestroDetalle.ChangeDetailRecord;
begin
  if Detalles = 0 then BHGrupoDesplazamientoDetalle(pcNulo)
  else
    if Detalle = Detalles then
    begin
      if Detalle = 1 then BHGrupoDesplazamientoDetalle(pcNulo)
      else BHGrupoDesplazamientoDetalle(pcFin);
    end
    else
      if Detalle = 1 then BHGrupoDesplazamientoDetalle(pcInicio)
      else BHGrupoDesplazamientoDetalle(pcMedio);

  BERegistros;

     //Evento cambio de registro
  if Assigned(FOnChangeDetailRecord) then FOnChangeDetailRecord;
end;

procedure TMaestroDetalle.ReintentarAlta;
begin
     //Implementar en el formulario
  Exit;
end;

procedure TMaestroDetalle.RestaurarCabecera;
begin
     //Implementar en el formulario
  Exit;
end;

procedure TMaestroDetalle.SincronizarDetalleWeb;
begin

end;

initialization
  ListadoObligado := false;
  LineasObligadas := true;
  MultipleAltas := true;
end.
