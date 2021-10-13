unit ServiciosEntregaGastosFM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  BCalendarButton, ComCtrls, BCalendario, BEdit, dbTables,
  DError, CVariables, StrUtils, DBActns, StdActns{, ServiciosEntregaFM};

type
  TFMServiciosEntregaGastos = class(TForm)
    AGastos: TActionList;
    ARejillaFlotante: TAction;
    Label13: TLabel;
    PRejilla: TPanel;
    PBotones: TPanel;
    SBAceptar: TSpeedButton;
    SBCancelar: TSpeedButton;
    SBAnterior: TSpeedButton;
    SBPrimero: TSpeedButton;
    SBSiguiente: TSpeedButton;
    SBUltimo: TSpeedButton;
    SBSalir: TSpeedButton;
    SBModificar: TSpeedButton;
    ALocalizar: TAction;
    AModificar: TAction;
    ASalir: TAction;
    AAceptar: TAction;
    ACancelar: TAction;
    SBAltas: TSpeedButton;
    SBBorrar: TSpeedButton;
    ABorrar: TAction;
    STTipoGastos: TStaticText;
    LTipoGastos: TLabel;
    LImporte: TLabel;
    BGBTipoGastos: TBGridButton;
    AAlta: TAction;
    Label1: TLabel;
    STTotalGastos: TStaticText;
    rejilla: TDBGrid;
    tipo_seg: TBDEdit;
    importe_seg: TBDEdit;
    RejillaFlotante: TBGrid;
    APrimero: TAction;
    AAnterior: TAction;
    ASiguiente: TAction;
    AUltimo: TAction;
    ref_fac_seg: TBDEdit;
    LApunte: TLabel;
    DSGastosCompras: TDataSource;
    Label2: TLabel;
    fecha_fac_seg: TBDEdit;
    btnFecha_fac: TBCalendarButton;
    Calendario: TBCalendario;
    Label3: TLabel;
    nota_seg: TBDEdit;
    QGastos: TQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure ARejillaFlotanteExecute(Sender: TObject);
    procedure AAceptarExecute(Sender: TObject);
    procedure ACancelarExecute(Sender: TObject);
    procedure ASalirExecute(Sender: TObject);
    procedure ABorrarExecute(Sender: TObject);
    procedure AAltaExecute(Sender: TObject);
    procedure AModificarExecute(Sender: TObject);
    procedure tipo_segRequiredTime(Sender: TObject; var isTime: Boolean);
    procedure APrimeroExecute(Sender: TObject);
    procedure AAnteriorExecute(Sender: TObject);
    procedure ASiguienteExecute(Sender: TObject);
    procedure AUltimoExecute(Sender: TObject);
    procedure rejillaDblClick(Sender: TObject);
    procedure tipo_segChange(Sender: TObject);
    procedure BGBTipoGastosClick(Sender: TObject);
    procedure rejillaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnFecha_facClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure QGastosAfterPost(DataSet: TDataSet);
    procedure QGastosAfterDelete(DataSet: TDataSet);


  private
    lRF: TBGrid;
    lCF: TBCalendario;
    { Private declarations }
    estado: TEstado;
    salir: boolean;

    iServicio: integer;
    dFechaServicio: TDateTime;
    bGastoModificado: boolean;

    procedure botoneraDespl;

    // procedure Modificar;
    function  ValidarDatos: boolean;
    procedure AceptarAltas;
    procedure AceptarModificar;
    procedure CancelarAltas;
    procedure CancelarModificar;
    procedure CambiarEstado(estad: TEstado);
    procedure CalculoGastos;

    procedure EuroConversorExecute( const AFecha: TDateTime );
  public
    { Public declarations }

    procedure Botones;
    procedure CargaParametros( const AServicio: integer; const AFechaServicio: TDateTime );
    function  GastosModificados: boolean;

  end;

var
  FMServiciosEntregaGastos: TFMServiciosEntregaGastos;
  opcc: Integer;

implementation

uses bDialogs, UDMBaseDatos, CAuxiliarDB, Principal, bSQLUtils,
     DConversor, uDMAuxDB, variants;

{$R *.DFM}

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMServiciosEntregaGastos.CargaParametros( const AServicio: integer; const AFechaServicio: TDateTime );
begin
  iServicio:= AServicio;
  dFechaServicio:= AFechaServicio;
  with QGastos do
  begin
    ParamByName('servicio_sec').AsInteger:= AServicio;
  end;
end;

procedure TFMServiciosEntregaGastos.FormShow(Sender: TObject);
begin
  QGastos.Open;
  cambiarEstado(teLocalizar);
  CalculoGastos;
end;

procedure TFMServiciosEntregaGastos.FormCreate(Sender: TObject);
begin
  Salir := false;

   //Teclas para las altas y bajas
  AAlta.ShortCut := vk_add; //mas numerico
  ABorrar.ShortCut := VK_SUBTRACT; //menos numerico
  ASalir.ShortCut := VK_ESCAPE;

  //cambiarEstado(teLocalizar);
  lRF := gRF;
  lCF := gCF;
  gRF := RejillaFlotante;
  gCF := nil;
  Botones;

  Calendario.Date:= Date;
  bGastoModificado:= False;

  with QGastos do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_servicios_entrega_g ');
    SQL.Add(' where servicio_seg = :servicio_sec ');
    SQL.Add(' order by tipo_seg ');
    Prepare;
  end;
end;


procedure TFMServiciosEntregaGastos.FormActivate(Sender: TObject);
begin
  gRF := RejillaFlotante;
  gCF := nil;
end;


procedure TFMServiciosEntregaGastos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if salir then
  begin
    QGastos.Close;
    gRF := lRF;
    gCF := lCF;
    Action := caFree;
  end
  else
  begin
    Action := caNone;
  end;
end;

procedure TFMServiciosEntregaGastos.FormKeyDown(Sender: TObject; var Key: Word;
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
    vk_f8:
      begin
        Key := 0;
        EuroConversorExecute( dFechaServicio );
      end;
  end;
end;

//*****************************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************


//***************************************************************
//Procedimientos de los botones, acciones, desplazamientos, etc..
//***************************************************************

procedure TFMServiciosEntregaGastos.AAceptarExecute(Sender: TObject);
begin
  if RejillaFlotante.Visible then
  begin
    RejillaFlotante.DblClick;
    Exit;
  end;
  if Calendario.Visible then
  begin
    Calendario.DblClick;
    Calendario.BControl.SetFocus;
    Exit;
  end;

  if Estado = teAlta then
    AceptarAltas;
  if Estado = teModificar then
    AceptarModificar;
  CalculoGastos;
end;

procedure TFMServiciosEntregaGastos.ACancelarExecute(Sender: TObject);
var
  sAux: string;
begin
  if RejillaFlotante.Visible then
  begin
    RejillaFlotante.Hide;
    Exit;
  end;
  if Calendario.Visible then
  begin
    sAux:= Calendario.BControl.Text;
    Calendario.DblClick;
    Calendario.BControl.Text:= sAux;
    Calendario.BControl.SetFocus;
    Exit;
  end;

  CalculoGastos;
  if estado = teModificar then
  begin
    CancelarModificar;
    Exit;
  end;
  if estado = teAlta then
  begin
    CancelarAltas;
    Exit;
  end;
end;

procedure TFMServiciosEntregaGastos.ASalirExecute(Sender: TObject);
begin
  if Salir then
    Close;
end;

function  TFMServiciosEntregaGastos.ValidarDatos: boolean;
begin
  result:= false;
  if STTipoGastos.Caption = '' then
  begin
    MessageDlg('Debe introducir un tipo de gasto valido ...', mtError, [mbOK], 0);
    tipo_seg.SetFocus;
  end
  else
  if importe_seg.Text = '' then
  begin
    MessageDlg('Debe introducir el importe del Gasto...', mtError, [mbOK], 0);
    importe_seg.SetFocus;
  end
  else
  begin
    //El gasto debe ser de entregas
    with DMAuxDB.QAux do
    begin
      if Active then Close;
      SQL.Clear;
      SQL.Add('SELECT count(*) As cuenta FROM frf_tipo_gastos ');
      SQL.Add('WHERE tipo_tg = ' + QuotedStr(tipo_seg.Text));
      SQL.Add('AND gasto_transito_tg = 2');
      Open;
      if (FieldByName('cuenta').AsInteger = 0) then
      begin
        MessageDlg('El Tipo de Gastos introducido no es de compras o no existe ...', mtError, [mbOK], 0);
        tipo_seg.SetFocus;
      end
      else
      begin
        result:= True;
      end;
     Close;
    end;
  end;
end;

procedure TFMServiciosEntregaGastos.AceptarAltas;
var
  stipo: string;
begin
  if ValidarDatos then
  begin
    QGastos.Post;
    QGastos.DisableControls;
    try
      sTipo:= QGastos.FieldByname('tipo_seg').AsString;
      QGastos.Close;
      QGastos.Open;
      While ( QGastos.FieldByname('tipo_seg').AsString <> sTipo ) AND
        not QGastos.Eof do
        QGastos.Next;
    finally
      QGastos.EnableControls;
    end;

    cambiarEstado(teLocalizar);
  end;
end;

procedure TFMServiciosEntregaGastos.CancelarAltas;
begin
  QGastos.Cancel;
  cambiarEstado(teLocalizar);
end;

procedure TFMServiciosEntregaGastos.AceptarModificar;
begin
  if ValidarDatos then
  begin
    QGastos.Post;
    cambiarEstado(teLocalizar);
  end;
end;

procedure TFMServiciosEntregaGastos.CancelarModificar;
begin
  QGastos.Cancel;
  cambiarEstado(teLocalizar);
end;

// ******************************************************************
// **                  OBTENCIÓN DE DATOS                          **
// ******************************************************************

procedure TFMServiciosEntregaGastos.ABorrarExecute(Sender: TObject);
begin
  QGastos.Delete;
  cambiarEstado(teConjuntoResultado);
end;

procedure TFMServiciosEntregaGastos.cambiarEstado(estad: TEstado);
var
  vis: Boolean;
begin
  estado := estad;
  vis := ( estad = teAlta ) or ( estad = teModificar );

  LTipoGastos.Visible := vis;
  tipo_seg.Visible := vis;
  BGBTipoGastos.Visible := vis;
  STTipoGastos.Visible := vis;
  LImporte.Visible := vis;
  importe_seg.Visible := vis;
  ref_fac_seg.Visible := vis;
  nota_seg.Visible := vis;
  LApunte.Visible := vis;

  if vis then
  begin
    rejilla.Top := 136;
    rejilla.Height := 122;
    rejilla.Enabled:= False;
  end
  else
  begin
    rejilla.Top := 48;
    rejilla.Height := 210;
    rejilla.Enabled:= True;
  end;


  case estad of
    teAlta:
      begin
        APrimero.Enabled := False;
        ASiguiente.Enabled := False;
        AAnterior.Enabled := False;
        AUltimo.Enabled := False;
      end;
    teModificar:
      begin
        APrimero.Enabled := False;
        ASiguiente.Enabled := False;
        AAnterior.Enabled := False;
        AUltimo.Enabled := false;
      end;
    teLocalizar:
      begin
        botoneraDespl;
      end;
  end;
  Botones;
end;

procedure TFMServiciosEntregaGastos.Botones;
begin
  case estado of
    teAlta:
      begin
        Salir := false;
        ASalir.ShortCut := 0;
        ACancelar.ShortCut := VK_ESCAPE;

        AModificar.Enabled := False;
        AAlta.Enabled := False;
        ABorrar.Enabled := FAlse;

        AAceptar.Enabled := True;
        ACancelar.Enabled := True;

        ASalir.Enabled := false;

        ARejillaFlotante.Enabled := true;
      end;
    teModificar:
      begin
        Salir := false;
        ASalir.ShortCut := 0;
        ACancelar.ShortCut := VK_ESCAPE;

        AModificar.Enabled := False;
        AAlta.Enabled := False;
        ABorrar.Enabled := False;

        AAceptar.Enabled := True;
        ACancelar.Enabled := True;

        ASalir.Enabled := false;

        ARejillaFlotante.Enabled := true;
      end;
    teLocalizar:
      begin
        Salir := true;
        ASalir.ShortCut := VK_ESCAPE;
        ACancelar.ShortCut := 0;

        if not QGastos.IsEmpty then
        begin
          AModificar.Enabled := true;
          ABorrar.Enabled := true;
        end
        else
        begin
          AModificar.Enabled := false;
          ABorrar.Enabled := false;
        end;
        AAlta.Enabled := true;

        AAceptar.Enabled := false;
        ACancelar.Enabled := false;


        ASalir.Enabled := true;

        ARejillaFlotante.Enabled := true;

      end;
  end;
end;

procedure TFMServiciosEntregaGastos.AAltaExecute(Sender: TObject);
begin
  cambiarEstado(teAlta);
  QGastos.Insert;
  QGastos.FieldByname('servicio_seg').AsInteger := iServicio;
  QGastos.FieldByname('solo_lectura_seg').AsInteger := 0;
  tipo_seg.Change;
end;

procedure TFMServiciosEntregaGastos.AModificarExecute(Sender: TObject);
begin
  cambiarEstado(teModificar);
  QGastos.Edit;
  importe_seg.SetFocus;
  tipo_seg.Change;
end;

procedure TFMServiciosEntregaGastos.CalculoGastos;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select sum(importe_seg) importe ');
    SQL.Add(' from frf_servicios_entrega_g ');
    SQL.Add(' where servicio_seg = :servicio ');
    ParamByName('servicio').AsInteger:= iServicio;
    try
      Open;
      STTotalGastos.Caption := FieldByName('importe').AsString;
    finally
      Close;
    end;
  end;
end;

procedure TFMServiciosEntregaGastos.tipo_segRequiredTime(Sender: TObject;
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

procedure TFMServiciosEntregaGastos.APrimeroExecute(Sender: TObject);
begin
  rejilla.DataSource.DataSet.First;
  botoneraDespl;
end;

procedure TFMServiciosEntregaGastos.AAnteriorExecute(Sender: TObject);
begin
  rejilla.DataSource.DataSet.Prior;
  botoneraDespl;
end;

procedure TFMServiciosEntregaGastos.ASiguienteExecute(Sender: TObject);
begin
  rejilla.DataSource.DataSet.Next;
  botoneraDespl;
end;

procedure TFMServiciosEntregaGastos.AUltimoExecute(Sender: TObject);
begin
  rejilla.DataSource.DataSet.Last;
  botoneraDespl;
end;

procedure TFMServiciosEntregaGastos.botoneraDespl;
begin
  if ((not rejilla.DataSource.DataSet.Active) or
    (rejilla.DataSource.DataSet.RecordCount <= 0)) then
  begin
    APrimero.Enabled := False;
    AAnterior.Enabled := False;
    ASiguiente.Enabled := False;
    AUltimo.Enabled := False;
    Exit;
  end;


  if rejilla.DataSource.DataSet.Bof then
  begin
    APrimero.Enabled := False;
    AAnterior.Enabled := False;
  end
  else
  begin
    APrimero.Enabled := True;
    AAnterior.Enabled := True;
  end;

  if rejilla.DataSource.DataSet.Eof then
  begin
    ASiguiente.Enabled := False;
    AUltimo.Enabled := False;
  end
  else
  begin
    ASiguiente.Enabled := True;
    AUltimo.Enabled := True;
  end;
end;

procedure TFMServiciosEntregaGastos.EuroConversorExecute( const AFecha: TDateTime );
var
  aux: string;
begin
  aux := DConversor.Execute(self, AFecha, 'EUR', 'GBP');
  if ActiveControl is TBEdit then
  begin
    if Trim(aux) <> '' then
      TBEdit(ActiveControl).Text := aux;
  end;
end;

procedure TFMServiciosEntregaGastos.rejillaDblClick(Sender: TObject);
begin
  SBModificar.Click;
end;

procedure TFMServiciosEntregaGastos.tipo_segChange(Sender: TObject);
begin
  STTipoGastos.Caption:= desTipoGastos(tipo_seg.Text );
end;

procedure TFMServiciosEntregaGastos.ARejillaFlotanteExecute(Sender: TObject);
begin
  if tipo_seg.Focused then
    BGBTipoGastos.Click
  else
  if fecha_fac_seg.Focused then
    btnFecha_fac.Click;
end;

procedure TFMServiciosEntregaGastos.BGBTipoGastosClick(Sender: TObject);
begin
  if DMBaseDatos.QDespegables.Active then
    DMBaseDatos.QDespegables.Close;
  DMBaseDatos.QDespegables.SQL.Clear;

  RejillaFlotante.BControl := tipo_seg;
  DMBaseDatos.QDespegables.SQL.Add(' select tipo_tg, descripcion_tg ');
  DMBaseDatos.QDespegables.SQL.Add(' from frf_tipo_gastos ');
  DMBaseDatos.QDespegables.SQL.Add(' where gasto_transito_tg = 2 ');
  DMBaseDatos.QDespegables.SQL.Add(' and not exists ');
  DMBaseDatos.QDespegables.SQL.Add(' ( ');
  DMBaseDatos.QDespegables.SQL.Add('   select * ');
  DMBaseDatos.QDespegables.SQL.Add('   from frf_servicios_entrega_g ');
  DMBaseDatos.QDespegables.SQL.Add('   where servicio_seg = :servicio ');
  DMBaseDatos.QDespegables.SQL.Add('   and tipo_seg = tipo_tg ');
  DMBaseDatos.QDespegables.SQL.Add(' ) ');
  DMBaseDatos.QDespegables.SQL.Add(' order by tipo_tg, descripcion_tg ');

  DMBaseDatos.QDespegables.ParamByName('servicio').AsInteger:= iServicio;

  DMBaseDatos.QDespegables.Open;
  BGBTipoGastos.GridShow;
end;

procedure TFMServiciosEntregaGastos.rejillaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  sAux: string;
begin
  if DataCol = 1 then
  begin
    sAux:= desTipoGastos( Column.Field.AsString );

    if gdSelected in State then
      rejilla.Canvas.Brush.Color := clMenuHighlight;
    if gdFocused in State then
      rejilla.Canvas.Font.Color := clMenuHighlight;

    rejilla.Canvas.TextRect(Rect,Rect.Left, Rect.Top,sAux);

  end
  else
    rejilla.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;


procedure TFMServiciosEntregaGastos.btnFecha_facClick(Sender: TObject);
var
  dFecha: TDate;
begin
  dFecha:= StrToDateDef( fecha_fac_seg.Text, Date );
  Calendario.BControl:= fecha_fac_seg;
  Calendario.Date:= dFecha;
  btnFecha_fac.CalendarShow;
end;

procedure TFMServiciosEntregaGastos.QGastosAfterPost(DataSet: TDataSet);
begin
  //Poner status_gastos_c de la compra a 0 para indicar que tenemos que volver a
  //asignar gastos
  bGastoModificado:= True;
end;

procedure TFMServiciosEntregaGastos.QGastosAfterDelete(DataSet: TDataSet);
begin
  bGastoModificado:= True;
end;

function TFMServiciosEntregaGastos.GastosModificados: boolean;
begin
  result:= bGastoModificado;
end;

end.


