unit UFMEntregasGastos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  BCalendarButton, ComCtrls, BCalendario, BEdit, dbTables,
  DError, CVariables, StrUtils, DBActns, StdActns;

type
  TFMEntregasGastos = class(TForm)
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
    tipo_ge: TBDEdit;
    importe_ge: TBDEdit;
    RejillaFlotante: TBGrid;
    APrimero: TAction;
    AAnterior: TAction;
    ASiguiente: TAction;
    AUltimo: TAction;
    ref_fac_ge: TBDEdit;
    LApunte: TLabel;
    DSGastosEntregas: TDataSource;
    Label2: TLabel;
    fecha_fac_ge: TBDEdit;
    btnFecha_fac_ge: TBCalendarButton;
    Calendario: TBCalendario;
    Label3: TLabel;
    nota_ge: TBDEdit;
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
    procedure tipo_geRequiredTime(Sender: TObject; var isTime: Boolean);
    procedure APrimeroExecute(Sender: TObject);
    procedure AAnteriorExecute(Sender: TObject);
    procedure ASiguienteExecute(Sender: TObject);
    procedure AUltimoExecute(Sender: TObject);
    procedure rejillaDblClick(Sender: TObject);
    procedure tipo_geChange(Sender: TObject);
    procedure BGBTipoGastosClick(Sender: TObject);
    procedure rejillaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnFecha_fac_geClick(Sender: TObject);
    procedure rejillaCellClick(Column: TColumn);


  private
    lRF: TBGrid;
    lCF: TBCalendario;
    { Private declarations }
    estado: TEstado;
    salir: boolean;

    procedure botoneraDespl;

    // procedure Modificar;
    function  ValidarDatos: boolean;
    procedure AceptarAltas;
    procedure AceptarModificar;
    procedure CancelarAltas;
    procedure CancelarModificar;
    procedure CambiarEstado(estad: TEstado);
    procedure CalculoGastos;

    procedure EuroConversorExecute;
    function  NuevaLinea( Const ACodigo: string ): integer;
  public
    { Public declarations }

    procedure Botones;

  end;

var
  FMEntregasGastos: TFMEntregasGastos;
  opcc: Integer;

implementation

uses bDialogs, UDMBaseDatos, CAuxiliarDB, Principal, bSQLUtils,
     DConversor, UMDEntregas, uDMAuxDB;

{$R *.DFM}

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMEntregasGastos.FormCreate(Sender: TObject);
begin
  Salir := false;

   //Teclas para las altas y bajas
  AAlta.ShortCut := vk_add; //mas numerico
  ABorrar.ShortCut := VK_SUBTRACT; //menos numerico
  ASalir.ShortCut := VK_ESCAPE;

  //Tamaño y posicion del formulario
  //MDEntregas.QGastosEntregas.Open;
  cambiarEstado(teLocalizar);
  lRF := gRF;
  lCF := gCF;
  gRF := RejillaFlotante;
  gCF := nil;
  Botones;

  Calendario.Date:= Date;
  CalculoGastos;
  botoneraDespl;
end;


procedure TFMEntregasGastos.FormActivate(Sender: TObject);
begin
  gRF := RejillaFlotante;
  gCF := nil;
end;


procedure TFMEntregasGastos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if salir then
  begin
    //MDEntregas.QGastosEntregas.Close;
    gRF := lRF;
    gCF := lCF;
    Action := caFree;
  end
  else
  begin
    Action := caNone;
  end;
end;

procedure TFMEntregasGastos.FormKeyDown(Sender: TObject; var Key: Word;
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
        EuroConversorExecute;
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

procedure TFMEntregasGastos.AAceptarExecute(Sender: TObject);
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
  botoneraDespl;
end;

procedure TFMEntregasGastos.ACancelarExecute(Sender: TObject);
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
    botoneraDespl;
    Exit;
  end;
  if estado = teAlta then
  begin
    CancelarAltas;
    botoneraDespl;
    Exit;
  end;
end;

procedure TFMEntregasGastos.ASalirExecute(Sender: TObject);
begin
  if Salir then
    Close;
end;

function  TFMEntregasGastos.ValidarDatos: boolean;
begin
  result:= false;
  if STTipoGastos.Caption = '' then
  begin
    MessageDlg('Debe introducir un tipo de gasto valido ...', mtError, [mbOK], 0);
    tipo_ge.SetFocus;
  end
  else
  if importe_ge.Text = '' then
  begin
    MessageDlg('Debe introducir el importe del Gasto...', mtError, [mbOK], 0);
    importe_ge.SetFocus;
  end
  else
  begin
    //El gasto debe ser de entregas
    with DMAuxDB.QAux do
    begin
      if Active then Close;
      SQL.Clear;
      SQL.Add('SELECT count(*) As cuenta FROM frf_tipo_gastos ');
      SQL.Add('WHERE tipo_tg = ' + QuotedStr(tipo_ge.Text));
      SQL.Add('AND gasto_transito_tg = 2');
      Open;
      if (FieldByName('cuenta').AsInteger = 0) then
      begin
        MessageDlg('El Tipo de Gastos introducido no es de entregas o no existe ...', mtError, [mbOK], 0);
        tipo_ge.SetFocus;
      end
      else
      begin
        result:= True;
      end;
     Close;
    end;
  end;
end;

procedure TFMEntregasGastos.AceptarAltas;
var
  i: integer;
begin
  if ValidarDatos then
  begin
    MDEntregas.QGastosEntregas.Post;
    MDEntregas.QGastosEntregas.DisableControls;
    try
      i:= MDEntregas.QGastosEntregas.FieldByname('linea_ge').AsInteger;
      MDEntregas.QGastosEntregas.Close;
      MDEntregas.QGastosEntregas.Open;
      While ( MDEntregas.QGastosEntregas.FieldByname('linea_ge').AsInteger <> i ) or
        not MDEntregas.QGastosEntregas.Eof do
        MDEntregas.QGastosEntregas.Next;
    finally
      MDEntregas.QGastosEntregas.EnableControls;
    end;

    cambiarEstado(teLocalizar);
  end;
end;

procedure TFMEntregasGastos.CancelarAltas;
begin
  MDEntregas.QGastosEntregas.Cancel;
  cambiarEstado(teLocalizar);
end;

procedure TFMEntregasGastos.AceptarModificar;
begin
  if ValidarDatos then
  begin
    MDEntregas.QGastosEntregas.Post;
    cambiarEstado(teLocalizar);
  end;
end;

procedure TFMEntregasGastos.CancelarModificar;
begin
  MDEntregas.QGastosEntregas.Cancel;
  cambiarEstado(teLocalizar);
end;

// ******************************************************************
// **                  OBTENCIÓN DE DATOS                          **
// ******************************************************************

procedure TFMEntregasGastos.ABorrarExecute(Sender: TObject);
begin
  MDEntregas.QGastosEntregas.Delete;
  cambiarEstado(teConjuntoResultado);
end;

procedure TFMEntregasGastos.cambiarEstado(estad: TEstado);
var
  vis: Boolean;
begin
  estado := estad;
  vis := ( estad = teAlta ) or ( estad = teModificar );

  LTipoGastos.Visible := vis;
  tipo_ge.Visible := vis;
  BGBTipoGastos.Visible := vis;
  STTipoGastos.Visible := vis;
  LImporte.Visible := vis;
  importe_ge.Visible := vis;
  ref_fac_ge.Visible := vis;
  nota_ge.Visible := vis;
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
        if tipo_ge.Focused then
          tipo_ge.SetFocus;
      end;
    teModificar:
      begin
        APrimero.Enabled := False;
        ASiguiente.Enabled := False;
        AAnterior.Enabled := False;
        AUltimo.Enabled := false;
        if importe_ge.Focused then
          importe_ge.SetFocus;
      end;
    teLocalizar:
      begin
        botoneraDespl;
      end;
  end;
  Botones;
end;

procedure TFMEntregasGastos.Botones;
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

        if not MDEntregas.QGastosEntregas.IsEmpty then
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


function TFMEntregasGastos.NuevaLinea( Const ACodigo: string ): integer;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.clear;
    SQL.Add('select max(linea_ge) from frf_gastos_entregas');
    SQL.Add('where codigo_ge = :codigo ');
    ParamByName('codigo').AsString:= ACodigo;
    Open;
    result:= Fields[0].AsInteger + 1;
    Close;
  end;
end;

procedure TFMEntregasGastos.AAltaExecute(Sender: TObject);
begin
  cambiarEstado(teAlta);
  MDEntregas.QGastosEntregas.Insert;
  MDEntregas.QGastosEntregas.FieldByname('codigo_ge').AsString :=
   MDEntregas.QEntregasC.FieldByname('codigo_ec').AsString;
  MDEntregas.QGastosEntregas.FieldByname('linea_ge').AsInteger :=
   NuevaLinea( MDEntregas.QEntregasC.FieldByname('codigo_ec').AsString );
  MDEntregas.QGastosEntregas.FieldByname('producto_ge').AsString :=
   MDEntregas.QEntregasC.FieldByname('producto_ec').AsString;
  tipo_ge.Change;
end;

procedure TFMEntregasGastos.AModificarExecute(Sender: TObject);
begin
  cambiarEstado(teModificar);
  MDEntregas.QGastosEntregas.Edit;
  importe_ge.SetFocus;
  tipo_ge.Change;
end;

procedure TFMEntregasGastos.CalculoGastos;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select sum(importe_ge) importe ');
    SQL.Add(' from frf_gastos_entregas ');
    SQL.Add(' where codigo_ge = :codigo ');
    ParamByName('codigo').AsString:= MDEntregas.QGastosEntregas.FieldByName('codigo_ge').AsString;
    try
      Open;
      STTotalGastos.Caption := FieldByName('importe').AsString;
    finally
      Close;
    end;
  end;
end;

procedure TFMEntregasGastos.tipo_geRequiredTime(Sender: TObject;
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

procedure TFMEntregasGastos.APrimeroExecute(Sender: TObject);
begin
  rejilla.DataSource.DataSet.First;
  botoneraDespl;
end;

procedure TFMEntregasGastos.AAnteriorExecute(Sender: TObject);
begin
  rejilla.DataSource.DataSet.Prior;
  botoneraDespl;
end;

procedure TFMEntregasGastos.ASiguienteExecute(Sender: TObject);
begin
  rejilla.DataSource.DataSet.Next;
  botoneraDespl;
end;

procedure TFMEntregasGastos.AUltimoExecute(Sender: TObject);
begin
  rejilla.DataSource.DataSet.Last;
  botoneraDespl;
end;

procedure TFMEntregasGastos.botoneraDespl;
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

  AModificar.Enabled:= DSGastosEntregas.DataSet.FieldByName('solo_lectura_ge').AsInteger <> 1;
  ABorrar.Enabled:= AModificar.Enabled;
end;

procedure TFMEntregasGastos.EuroConversorExecute;
var
  aux: string;
begin
  aux := DConversor.Execute(self, Date, 'EUR', 'GBP');
  if ActiveControl is TBEdit then
  begin
    if Trim(aux) <> '' then
      TBEdit(ActiveControl).Text := aux;
  end;
end;

procedure TFMEntregasGastos.rejillaDblClick(Sender: TObject);
begin
  SBModificar.Click;
end;

procedure TFMEntregasGastos.tipo_geChange(Sender: TObject);
begin
  STTipoGastos.Caption:= desTipoGastos(tipo_ge.Text );
end;

procedure TFMEntregasGastos.ARejillaFlotanteExecute(Sender: TObject);
begin
  if Tipo_ge.Focused then
    BGBTipoGastos.Click
  else
  if Fecha_fac_ge.Focused then
    btnFecha_fac_ge.Click;
end;


procedure TFMEntregasGastos.BGBTipoGastosClick(Sender: TObject);
begin
  if DMBaseDatos.QDespegables.Active then
    DMBaseDatos.QDespegables.Close;
  DMBaseDatos.QDespegables.SQL.Clear;

  RejillaFlotante.BControl := tipo_ge;
  DMBaseDatos.QDespegables.SQL.Add(' select tipo_tg, descripcion_tg ');
  DMBaseDatos.QDespegables.SQL.Add(' from frf_tipo_gastos ');
  DMBaseDatos.QDespegables.SQL.Add(' where gasto_transito_tg = 2 ');
  DMBaseDatos.QDespegables.SQL.Add(' and not exists ');
  DMBaseDatos.QDespegables.SQL.Add(' ( ');
  DMBaseDatos.QDespegables.SQL.Add('   select * ');
  DMBaseDatos.QDespegables.SQL.Add('   from frf_gastos_entregas ');
  DMBaseDatos.QDespegables.SQL.Add('   where codigo_ge = :codigo ');
  DMBaseDatos.QDespegables.SQL.Add('   and tipo_ge = tipo_tg ');
  DMBaseDatos.QDespegables.SQL.Add(' ) ');
  DMBaseDatos.QDespegables.SQL.Add(' order by tipo_tg, descripcion_tg ');

  DMBaseDatos.QDespegables.ParamByName('codigo').AsString:=
    MDEntregas.QGastosEntregas.FieldByname('codigo_ge').AsString;

  DMBaseDatos.QDespegables.Open;
  BGBTipoGastos.GridShow;
end;

procedure TFMEntregasGastos.rejillaDrawColumnCell(Sender: TObject;
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

procedure TFMEntregasGastos.btnFecha_fac_geClick(Sender: TObject);
var
  dFecha: TDate;
begin
  dFecha:= StrToDateDef( fecha_fac_ge.Text, Date );
  Calendario.BControl:= fecha_fac_ge;
  Calendario.Date:= dFecha;
  btnFecha_fac_ge.CalendarShow;
end;

procedure TFMEntregasGastos.rejillaCellClick(Column: TColumn);
begin
  botoneraDespl;
end;

end.


