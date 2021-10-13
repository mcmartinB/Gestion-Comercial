unit DAsigDua;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, BGrid, Db, DBTables, Grids, DBGrids, StdCtrls, BSpeedButton,
  BGridButton, BEdit, Buttons, CVariables, ActnList, Menus;

type
  TFDAsigDua = class(TForm)
    PBotones: TPanel;
    PMaestro: TPanel;
    PRejilla: TPanel;
    SBLocalizar: TSpeedButton;
    SBModificar: TSpeedButton;
    SBAceptar: TSpeedButton;
    SBCancelar: TSpeedButton;
    SBPrimero: TSpeedButton;
    SBAnterior: TSpeedButton;
    SBSiguiente: TSpeedButton;
    SBUltimo: TSpeedButton;
    SBSalir: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Empresa: TBEdit;
    cliente: TBEdit;
    BGEmpresa: TBGridButton;
    BGCliente: TBGridButton;
    STEmpresa: TStaticText;
    STCliente: TStaticText;
    Rejilla: TDBGrid;
    QMaestro: TQuery;
    DSMaestro: TDataSource;
    ActionList1: TActionList;
    ALocalizar: TAction;
    AModificar: TAction;
    AAceptar: TAction;
    ACancelar: TAction;
    ASiguiente: TAction;
    AAnterior: TAction;
    AUltimo: TAction;
    ASalir: TAction;
    APrimero: TAction;
    ARejillaFlotante: TAction;
    PDua: TPanel;
    EDua: TBEdit;
    fecha_dua: TBEdit;
    Label3: TLabel;
    Label4: TLabel;
    RejillaFlotante: TBGrid;
    Panel1: TPanel;
    RGOpciones: TRadioGroup;
    ppmMenu: TPopupMenu;
    ppmAlbaran: TMenuItem;
    ppmFecha: TMenuItem;
    ppmVehiculo: TMenuItem;
    ppmDUA: TMenuItem;
    ppmFechaDUA: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure ALocalizarExecute(Sender: TObject);
    procedure AModificarExecute(Sender: TObject);
    procedure AAceptarExecute(Sender: TObject);
    procedure ACancelarExecute(Sender: TObject);
    procedure ASiguienteExecute(Sender: TObject);
    procedure AAnteriorExecute(Sender: TObject);
    procedure AUltimoExecute(Sender: TObject);
    procedure ASalirExecute(Sender: TObject);
    procedure APrimeroExecute(Sender: TObject);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PonNombre(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RGOpcionesClick(Sender: TObject);
    procedure RejillaTitleClick(Column: TColumn);
    procedure popupMenuClick(Sender: TObject);
    procedure RejillaDblClick(Sender: TObject);
  private
    { Private declarations }
    Lista: TList;
    FocoLocalizar, FocoModificar: TWinCOntrol;
    Estado: TEstado;
    Registro, registros: integer;
    emp, clien: string;
    opcc: integer;
    localizado: boolean;
    ordenarPor: Integer;
    ordenAscendente: Boolean;

    procedure AbrirTablas;
    procedure Visualizar;

    procedure Botones;

    procedure BorrarTextoEdits;

    procedure Localizar;
    procedure Modificar;
    procedure AceptarLocalizar;
    procedure AceptarModificar;
    procedure CancelarLocalizar;
    procedure CancelarModificar;

    procedure ReponerDatos;
    procedure ActualizarDatos;

    procedure CerrarTablas;
  public
    { Public declarations }
  end;

implementation

uses UDMAuxDB, DError, CGestionPrincipal, CAuxiliarDB,
  Principal, UDMBaseDatos, bSQLUtils;

{$R *.DFM}

procedure TFDAsigDua.AbrirTablas;
begin
        //Le paso los parametros
  with QMaestro do
  begin
    if not Active then
    begin
      ParamByName('empresa').AsString := '#';
      ParamByName('cliente').AsString := '#';
      Open;
    end;
  end;

end;

procedure TFDAsigDua.FormCreate(Sender: TObject);
begin
  ordenarPor := -1;
  ordenAscendente := True;

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
    FormType := tfOther;
    BHFormulario;
  end;
  Visualizar;

     //Para intentar reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := kNull;
     //Asignamos constantes a los componentes que los tienen
     //para facilitar distingirlos
  Empresa.Tag := kEmpresa;
  Cliente.Tag := kCliente;

     //Focos
 {+}FocoModificar := Empresa;
 {+}FocoLocalizar := Empresa;
end;

procedure TFDAsigDua.Localizar;
begin
     //Cerrar consulta
  QMaestro.Close;

     //Estado
  Estado := teLocalizar;

  PMaestro.Enabled := True;

     //Hay que borrar las descripciones
  BorrarTextoEdits;

  Botones;

  RGopciones.ItemIndex := 0;

     //BETexto('','','','');

     //Poner foco
  Self.ActiveControl := FocoLocalizar;
end;

procedure TFDAsigDua.Visualizar;
begin
  if Registros = 0 then
  begin
    Estado := teEspera;
    Botones;
    BorrarTextoEdits;
    Self.ActiveControl := nil;
  end
  else
  begin
    Estado := teConjuntoResultado;
    Botones;
  end;
  PMaestro.Enabled := False;
  PRejilla.Enabled := True;
end;

procedure TFDAsigDua.Botones;
begin
        //Configurar los botones de herramientas
  if Estado = teLocalizar then
  begin
    ALocalizar.Enabled := False;
    AModificar.Enabled := False;
    APrimero.Enabled := False;
    AAnterior.Enabled := False;
    ASiguiente.Enabled := False;
    AUltimo.Enabled := False;
    AAceptar.Enabled := True;
    ACancelar.Enabled := True;
    ASalir.Enabled := False;
    ACancelar.ShortCut := vk_Escape;
    ASalir.ShortCut := 0;
  end;

  if Estado = teConjuntoResultado then
  begin
    ALocalizar.Enabled := True;
    AModificar.Enabled := True;
    APrimero.Enabled := True;
    AAnterior.Enabled := True;
    ASiguiente.Enabled := True;
    AUltimo.Enabled := True;
    AAceptar.Enabled := False;
    ACancelar.Enabled := False;
    ASalir.Enabled := True;
    ACancelar.ShortCut := 0;
    ASalir.ShortCut := vk_Escape;
  end;

  if Estado = teEspera then
  begin
    ALocalizar.Enabled := True;
    AModificar.Enabled := False;
    APrimero.Enabled := False;
    AAnterior.Enabled := False;
    ASiguiente.Enabled := False;
    AUltimo.Enabled := False;
    AAceptar.Enabled := False;
    ACancelar.Enabled := False;
    ASalir.Enabled := True;
    ACancelar.ShortCut := 0;
    ASalir.ShortCut := vk_Escape;
  end;

  if Estado = teModificar then
  begin
    ALocalizar.Enabled := False;
    AModificar.Enabled := False;
    APrimero.Enabled := False;
    AAnterior.Enabled := False;
    ASiguiente.Enabled := False;
    AUltimo.Enabled := False;
    AAceptar.Enabled := True;
    ACancelar.Enabled := True;
    ASalir.Enabled := False;
    ACancelar.ShortCut := vk_Escape;
    ASalir.ShortCut := 0;
  end;
end;

procedure TFDAsigDua.BorrarTextoEdits;
begin
  empresa.Text := '';
  cliente.Text := '';
end;

procedure TFDAsigDua.ALocalizarExecute(Sender: TObject);
begin
  Localizar;
  RGopciones.ItemIndex := 2;
  Botones;
end;

procedure TFDAsigDua.AModificarExecute(Sender: TObject);
begin
  Modificar;
  Botones;
end;

procedure TFDAsigDua.AAceptarExecute(Sender: TObject);
begin
  emp := Empresa.Text;
  clien := cliente.Text;
  if Estado = teLocalizar then
    AceptarLocalizar;
  if Estado = teModificar then
    AceptarModificar;
end;

procedure TFDAsigDua.ACancelarExecute(Sender: TObject);
begin
  if RejillaFlotante.Visible then
  begin
    RejillaFlotante.Hide;
    Exit;
  end;
  if Estado = teLocalizar then
  begin
    CancelarLocalizar;
  end;
  if Estado = teModificar then
    CancelarModificar;
end;

procedure TFDAsigDua.APrimeroExecute(Sender: TObject);
begin
        //ir a la primera posicion
  if Registro = Registros then
  begin
    AUltimo.Enabled := True;
    ASiguiente.Enabled := True;
  end;

  if Registro > 1 then
  begin
    QMaestro.First;
    Registro := 1;
    APrimero.Enabled := False;
    AAnterior.Enabled := False;
          //BETexto('Nil',IntToStr(registro)+':'+IntToStr(Registros),'Nil','Nil');
  end;
end;

procedure TFDAsigDua.AAnteriorExecute(Sender: TObject);
begin
                    //
        //ir a la posicion anterior
  if Registro = Registros then
  begin
    AUltimo.Enabled := True;
    ASiguiente.Enabled := True;
  end;
  if Registro > 1 then
  begin
    QMaestro.Prior;
    Registro := Registro - 1;
    if Registro = 1 then
    begin
      APrimero.Enabled := False;
      AAnterior.Enabled := False;
    end;
          //BETexto('Nil',IntToStr(registro)+':'+IntToStr(Registros),'Nil','Nil');
  end;
end;

procedure TFDAsigDua.ASiguienteExecute(Sender: TObject);
begin
        //ir a la posicion siguiente
  if Registro = 1 then
  begin
    APrimero.Enabled := True;
    AAnterior.Enabled := True;
  end;
  if Registro < Registros then
  begin
    QMaestro.Next;
    Registro := Registro + 1;
    if Registro = Registros then
    begin
      ASiguiente.Enabled := False;
      AUltimo.Enabled := False;
    end;
          //BETexto('Nil',IntToStr(registro)+':'+IntToStr(Registros),'Nil','Nil');
  end;
end;

procedure TFDAsigDua.AUltimoExecute(Sender: TObject);
begin
        //ir a la ultima posicion
  if Registro = 1 then
  begin
    APrimero.Enabled := True;
    AAnterior.Enabled := True;
  end;
  if Registro < Registros then
  begin
    QMaestro.Last;
    Registro := Registros;
    ASiguiente.Enabled := False;
    AUltimo.Enabled := False;
          //BETexto('Nil',IntToStr(registro)+':'+IntToStr(Registros),'Nil','Nil');
  end;
end;

procedure TFDAsigDua.ASalirExecute(Sender: TObject);
begin
        //Salir del formulario
  Close;
end;

procedure TFDAsigDua.Modificar;
begin
        //Nos colocamos sobre el registro a modificar en la tabla de salidas cabeceras
        //Mostramos el valor que queremos modificar si existe y si no un espacio a rellenar
  Estado := teModificar;
  Botones;

  PDua.Show;
        //Pasarle los datos si los tiene
  if QMaestro.FieldByName('dua_sc').AsString <> '' then begin
    EDua.Text := QMaestro.FieldByName('dua_sc').AsString;
    Fecha_dua.Text := QMaestro.FieldByName('fecha_dua_sc').AsString;
  end else begin
    EDua.Text := '';
    Fecha_dua.Text := '';
  end;

  EDua.SetFocus;
  PMaestro.Enabled := False;
  PRejilla.Enabled := False;
end;

procedure TFDAsigDua.AceptarLocalizar;
begin
  with QMaestro do
  begin
    Cancel;
    Close;
    try
      ParamByName('empresa').AsString := empresa.Text;
      ParamByName('cliente').AsString := cliente.Text;
      Open;
    except
      on E: EDBEngineError do
      begin
        ShowError(e);
        Registro := 0;
        Registros := 0;
        Visualizar;
        Exit;
      end;
    end;

    Registros := RecordCount;
  end;

  if Registros = 0 then
  begin
    BEMensajes('No se han encontrado datos para los valores introducidos');
    Visualizar;
    Exit;
  end;

        //Guardo los datos de la localizacion por si se cancela una futura
  Localizado := True;
  emp := Empresa.Text;
  clien := Cliente.Text;
  opcc := RGOpciones.ItemIndex;

  Registro := 1;

        //BETexto('Nil',IntToStr(registro)+':'+IntToStr(Registros),'Nil','Nil');

  Visualizar;

        //Ponemos las descripciones por si acaso;
  STEmpresa.Caption := desEmpresa(empresa.Text);
  STCliente.Caption := desCliente(Cliente.Text);

end;

procedure TFDAsigDua.AceptarModificar;
begin
  with DMBaseDatos.QGeneral do
  begin
    if Active then Close;
    SQL.Clear;
    if Trim(EDua.Text) = '' then begin
      SQL.Add(' UPDATE frf_salidas_c SET ' +
        ' dua_sc = NULL , fecha_dua_sc = NULL ' +
        ' WHERE empresa_sc ' + SQLEqualS(Empresa.Text) +
        ' AND n_albaran_sc ' + SQLEqualN(QMaestro.FieldByName('n_albaran_sc').AsString) +
        ' AND fecha_sc ' + SQLEqualD(QMaestro.FieldByName('fecha_sc').AsString));
    end else begin
      try
        StrToDate(fecha_dua.Text);
      except
        fecha_dua.SetFocus;
        MessageDlg('' + #13 + #10 + 'Fecha incorrecta.    ', mtWarning, [mbOK], 0);
        Exit;
      end;
      SQL.Add(' UPDATE frf_salidas_c SET ' +
        ' dua_sc ' + SQLEqualS(EDua.Text) + ',' +
        ' fecha_dua_sc ' + SQLEqualD(fecha_dua.Text) +
        ' WHERE empresa_sc ' + SQLEqualS(Empresa.Text) +
        ' AND n_albaran_sc ' + SQLEqualN(QMaestro.FieldByName('n_albaran_sc').AsString) +
        ' AND fecha_sc ' + SQLEqualD(QMaestro.FieldByName('fecha_sc').AsString));
    end;
    ExecSQL;
    PDua.Visible := False;

    ActualizarDatos;
  end;
end;

procedure TFDAsigDua.CancelarLocalizar;
begin
        //Cancelar la localizacion
        //Comprobar si hay ya una localizacion

  if Localizado then
  begin
    ReponerDatos;
    Exit;
  end;

  empresa.Text := '';
  cliente.Text := '';
  RGopciones.ItemIndex := -1;
  Visualizar;

end;

procedure TFDAsigDua.CancelarModificar;
begin
        //Cancelar la operacion
        //Ocultar el edit en el que se introducirá la operacion
  PDUA.Visible := False;
  Visualizar;
end;

procedure TFDAsigDua.ARejillaFlotanteExecute(Sender: TObject);
begin
     //Muestra la rejilla que contiene datos dependiendo del control que haga la llamada
  if estado = telocalizar then
    case ActiveControl.Tag of
      kEmpresa: DespliegaRejilla(BGEmpresa);
      kCliente: DespliegaRejilla(BGCliente, [empresa.Text])
    end;
end;

procedure TFDAsigDua.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Lista.Free;

     //Restauramos barra de herramientas
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

  Cerrartablas;
  Action := caFree;
end;

procedure TFDAsigDua.ReponerDatos;
begin
        //Poner los datos en los edits
  Empresa.Text := emp;
  cliente.Text := clien;
  RGOpciones.ItemIndex := opcc;
        //Abrir la consulta de nuevo
  with QMaestro do
  begin
    if Active then Close;
            //Parametros
    try
      Open;
    except
      on E: EDBEngineError do
      begin
             //Mensaje y cerramos el formulario
        ShowError(e);
        Self.Close;
      end;
    end;
          //BETexto('Nil',IntToStr(Registro)+':'+IntToStr(Registros),'Nil','Nil');
    Visualizar;
  end;
end;

procedure TFDAsigDua.PonNombre(Sender: TObject);
begin
  case TComponent(Sender).Tag of
    kEmpresa: STEmpresa.Caption := desEmpresa(empresa.Text);
    kCliente: STCliente.Caption := desCliente(cliente.Text);
  end;
end;

procedure TFDAsigDua.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if PDua.Visible then
    case key of
      vk_Escape: CancelarModificar;
      vk_F1: AceptarModificar;
    end;

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

procedure TFDAsigDUA.CerrarTablas;
begin
  CloseAuxQuerys;
  bnCloseQuerys([QMaestro]);
end;

procedure TFDAsigDua.RGOpcionesClick(Sender: TObject);
begin
  case RGOpciones.ItemIndex of
    0: QMaestro.Filter := '';
    1: QMaestro.Filter := 'dua_sc IS NOT NULL';
    2: QMaestro.Filter := 'dua_sc IS NULL';
  end;
end;

procedure TFDAsigDua.RejillaTitleClick(Column: TColumn);
begin
  if ordenarPor <> Column.Index then begin
    ordenarPor := Column.Index;
    ordenAscendente := True;
  end else begin
    ordenAscendente := not ordenAscendente;
  end;

  QMaestro.DisableControls;
  if QMaestro.Active then QMaestro.Close;
  if ordenAscendente then
    QMaestro.SQL[11] := ' ORDER BY ' + Column.FieldName
  else
    QMaestro.SQL[11] := ' ORDER BY ' + Column.FieldName + ' DESC';
  QMaestro.Open;
  QMaestro.EnableControls;
end;

procedure TFDAsigDua.popupMenuClick(Sender: TObject);
var
  titulo: string;
  valor: string;
begin
  case TComponent(Sender).Tag of
    0: titulo := 'Inserta el número de un albarán';
    1: titulo := 'Inserta la fecha de un albarán';
    2: titulo := 'Inserta el identificador de un vehículo';
    3: titulo := 'Inserta el número de un DUA';
    4: titulo := 'Inserta la fecha de un DUA';
  end;

  valor := '';
  if TComponent(Sender).Tag <> 10 then InputQuery(' BUSQUEDA DE REGISTROS.', titulo, valor);

  case TComponent(Sender).Tag of
    0: try
        StrToInt(valor);
      except
        MessageDlg('' + #13 + #10 + 'Número incorrecto.     ', mtWarning, [mbOK], 0);
        Exit;
      end;
    1, 4: try
        StrToDate(valor);
      except
        MessageDlg('' + #13 + #10 + 'Fecha incorrecto.     ', mtWarning, [mbOK], 0);
        Exit;
      end;
  end;

  //Localizar
  case TComponent(Sender).Tag of
    0: QMaestro.Locate('n_albaran_sc', valor, [loCaseInsensitive, loPartialKey]);
    1: QMaestro.Locate('fecha_sc', valor, [loCaseInsensitive, loPartialKey]);
    2: QMaestro.Locate('vehiculo_sc', valor, [loCaseInsensitive, loPartialKey]);
    3: QMaestro.Locate('dua_sc', valor, [loCaseInsensitive, loPartialKey]);
    4: QMaestro.Locate('fecha_dua_sc', valor, [loCaseInsensitive, loPartialKey]);
  end;
end;

procedure TFDAsigDua.RejillaDblClick(Sender: TObject);
begin
  if AModificar.Enabled then AModificar.Execute;
end;

procedure TFDAsigDua.ActualizarDatos;
var
  ancla: TBookmark;
begin
  QMaestro.DisableControls;

  //Echar el ancla si lo creemos necesario
  ancla := nil;
  if (not QMaestro.BOF) and (RGOpciones.ItemIndex <> 0) then
  begin
    QMaestro.Prior;
    ancla := QMaestro.GetBookmark;
  end;

  //Refrescar datos de la query
  QMaestro.Close;
  QMaestro.Open;

  //Levantar el ancla si la echamos
  if ancla <> nil then begin
    try
      if not QMaestro.IsEmpty then
        QMaestro.GotoBookmark(ancla);
    finally
      QMaestro.FreeBookmark(ancla);
    end;
  end;

  QMaestro.EnableControls;
  Visualizar;
end;


end.
