unit PrecioVentaAsignacion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus,
  dxSkinsCore, dxSkinBlue, dxSkinBlueprint, dxSkinFoggy, dxSkinMoneyTwins,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, StdCtrls, cxButtons,
  SimpleSearch, BEdit, BDEdit, nbLabels, ExtCtrls, DBTables, ComCtrls, dxCore,
  cxDateUtils, cxMaskEdit, cxDropDownEdit, cxCalendar, cxCurrencyEdit, cxLabel,
  cxGroupBox, ActnList;

type
  TFPrecioVentaAsignacion = class(TForm)
    PMaestro: TcxGroupBox;
    stCliente: TnbStaticText;
    stenvase: TnbStaticText;
    stMoneda: TnbStaticText;
    ssEnvase: TSimpleSearch;
    btAceptar: TcxButton;
    btCancelar: TcxButton;
    ssCliente: TSimpleSearch;
    ssMoneda: TSimpleSearch;
    eCliente: TcxTextEdit;
    eEnvase: TcxTextEdit;
    eMoneda: TcxTextEdit;
    eFechaInicio: TcxDateEdit;
    ePrecio: TcxCurrencyEdit;
    eFechaFin: TcxDateEdit;
    lbFechaIni: TcxLabel;
    lbFechaFin: TcxLabel;
    lbCliente: TcxLabel;
    lbEnvase: TcxLabel;
    lbPrecio: TcxLabel;
    lbMoneda: TcxLabel;
    eUnidadPrecio: TcxComboBox;
    lbUnidadFacturacion: TcxLabel;
    ActionList: TActionList;
    ACancelar: TAction;
    AAceptar: TAction;
    procedure btCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure eClientePropertiesChange(Sender: TObject);
    procedure eEnvaseExit(Sender: TObject);
    procedure eEnvasePropertiesChange(Sender: TObject);
    procedure eMonedaPropertiesChange(Sender: TObject);
    procedure btAceptarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ACancelarExecute(Sender: TObject);
    procedure AAceptarExecute(Sender: TObject);
    procedure ssEnvaseAntesEjecutar(Sender: TObject);
  private
    { Private declarations }

    sCliente, sEnvase, sMoneda, sFechaIni, sFechaFin: string;

    function Parametros(var ponerFoco: TcxCustomTextEdit): boolean;
    function InsertarPrecioVenta: boolean;
    function ComprobarPrecios: boolean;
    function AbrirTransaccion(DB: TDataBase): boolean;
    procedure AceptarTransaccion(DB: TDataBase);
    procedure CancelarTransaccion(DB: TDataBase);


  public
    { Public declarations }
    dFechaIni, dFechaFin: TDateTime;

    function AsignarPrecios ( const AOwner:TComponent; var AFechaini, AFechaFin: String ):integer;
  end;

var
  FPrecioVentaAsignacion: TFPrecioVentaAsignacion;

implementation

{$R *.dfm}

uses UDMAuxDB, bTextUtils, DError, UDMBaseDatos, PrecioVenta;

{ TFPrecioVentaAsignacion }

function TFPrecioVentaAsignacion.AsignarPrecios (const AOwner: TComponent; var AFechaIni, AFechaFin: string ): integer ;
begin
  FPrecioVentaAsignacion:= TFPrecioVentaAsignacion.Create( AOwner );
  try
    Result:= FPrecioVentaAsignacion.ShowModal;
    AFechaIni := '';
    AFechaFin := '';
    if FPrecioVentaAsignacion.dFechaIni <> 0 then
      AFechaIni := DateToStr(FPrecioVentaAsignacion.dFechaIni);
    if FPrecioVentaAsignacion.dFechaFin <> 0 then
      AFechaFin := DateToStr(FPrecioVentaAsignacion.dFechaFin);

  finally
    FreeAndNil( FPrecioVentaAsignacion );
  end;
end;

procedure TFPrecioVentaAsignacion.btAceptarClick(Sender: TObject);
var temp: TcxCustomTextEdit;
begin
  //Datos del formulario correctos
  if not Parametros(temp) then
  begin
    temp.SetFocus;
    Exit;
  end;

  if not ComprobarPrecios then
    ShowMessage(' ATENCION! Existen precios grabados entre las fechas especificadas, para el Cliente ' + eCliente.Text + ' y el Artículo ' + eEnvase.Text  )
  else
  begin
    if InsertarPrecioVenta then
      ShowMessage('Precios insertados correctamente para el periodo de fechas: ' + eFechaInicio.Text + ' - ' + eFechaFin.Text)
    else
      ShowMessage('Se ha producido un error al intentar grabar los precios por cliente y Articulo.');
  end;
  dFechaIni :=  StrToDateTime( eFechaInicio.Text );
  dFechaFin :=  StrToDateTime( eFechaFin.Text );
  Close;
end;

procedure TFPrecioVentaAsignacion.btCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFPrecioVentaAsignacion.eClientePropertiesChange(Sender: TObject);
begin
  stCliente.Caption := desCliente(eCliente.Text);
end;

procedure TFPrecioVentaAsignacion.eEnvaseExit(Sender: TObject);
begin
  if EsNumerico(eEnvase.Text) and (Length(eEnvase.Text) <= 5) then
    if (eEnvase.Text <> '' ) and (Length(eEnvase.Text) < 9) then
      eEnvase.Text := 'COM-' + Rellena( eEnvase.Text, 5, '0');
end;

procedure TFPrecioVentaAsignacion.eEnvasePropertiesChange(Sender: TObject);
begin
  stEnvase.Caption := desEnvase( '', eEnvase.Text)
end;

procedure TFPrecioVentaAsignacion.eMonedaPropertiesChange(Sender: TObject);
begin
  stMoneda.Caption := desMoneda(eMoneda.Text);
end;

procedure TFPrecioVentaAsignacion.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
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

procedure TFPrecioVentaAsignacion.FormShow(Sender: TObject);
begin
  eMoneda.Text := 'EUR';
  eFechaInicio.SetFocus;
end;

function TFPrecioVentaAsignacion.ComprobarPrecios: boolean;
var QComprobarPrecios: TQuery;
begin

  QComprobarPrecios := TQuery.Create(Self);
  with QComprobarPrecios do
  begin
    DatabaseName:= 'BDProyecto';

    SQL.Clear;
    SQL.Add(' select * from frf_precio_venta ');
    SQL.Add('  where fecha_pv between :fecha_ini and :fecha_fin ');
    SQL.Add('    and cliente_pv = :cliente ');
    SQL.Add('    and envase_pv = :envase ');

    ParamByName('fecha_ini').AsString := eFechaInicio.Text;
    ParamByName('fecha_fin').AsString := eFechaFin.Text;
    ParamByName('cliente').AsString := eCliente.Text;
    ParamByName('envase').AsString := eEnvase.Text;

    Open;
    result := IsEmpty;
  end;

end;

function TFPrecioVentaAsignacion.InsertarPrecioVenta: boolean;
var QInsertarPrecio: TQuery;
begin

  QInsertarPrecio := TQuery.Create(Self);
  with QInsertarPrecio do
  begin
    DatabaseName:= 'BDProyecto';

    SQL.Clear;
    SQL.Add(' insert into frf_precio_venta values (:cliente, :envase, :fecha, :precio, :unidad_precio, :moneda, :fecha_ult_mod) ');

    Prepare;
  end;

  with QInsertarPrecio do
  try
    if not AbrirTransaccion(DMBaseDatos.DBBaseDatos) then
      raise Exception.Create('Error al abrir transaccion en BD.');

    while dFechaIni <= dFechaFin do
    begin
      if QInsertarPrecio.Active then
        QInsertarPrecio.Close;

      ParamByName('cliente').AsString := eCliente.Text;
      ParamByName('envase').AsString := eEnvase.Text;
      ParamByName('fecha').AsString := DateToStr(dFechaIni);
      ParamByName('precio').AsString := ePrecio.Text;
      ParamByName('unidad_precio').AsString := eUnidadPrecio.Text;
      ParamByName('moneda').AsString := eMoneda.Text;
      ParamByName('fecha_ult_mod').AsDatetime := now;

      ExecSQL;

      dFechaIni := dFechaIni + 1;
    end;

    AceptarTransaccion(DMBaseDatos.DBBaseDatos);
    result := true;

  except
    if DMBaseDatos.DBBaseDatos.InTransaction then
      CancelarTransaccion(DMBaseDatos.DBBaseDatos);
    QInsertarPrecio.Close;
    result := false;
  end;
end;

function TFPrecioVentaAsignacion.Parametros(var ponerFoco: TcxCustomTextEdit): boolean;
begin
  if (stCliente.Caption = '') then
  begin
    ShowError('Falta el código de cliente o es incorrecto.');
    ponerFoco := eCliente;
    Parametros := false;
    Exit;
  end;
  sCliente:= eCliente.Text;

  if (stEnvase.Caption = '') then
  begin
    ShowError('Falta el código de artículo o es incorrecto.');
    ponerFoco := eEnvase;
    Parametros := false;
    Exit;
  end;
  sEnvase:= eEnvase.Text;

  if (eMoneda.Text = '') then
  begin
    ShowError('Falta el código de moneda o es incorrecto.');
    ponerFoco := eMoneda;
    Parametros := false;
    Exit;
  end;
  sMoneda:= eMoneda.Text;

  if not TryStrToDate( eFechaInicio.Text, dFechaIni ) then
  begin
    ShowError('La fecha Inicio es incorrecta.');
    ponerFoco := eFechaInicio;
    Parametros := false;
    Exit;
  end;
  sFechaIni:= eFechaInicio.Text;

  if not TryStrToDate( eFechaFin.Text, dFechaFin ) then
  begin
    ShowError('La fecha Fin es incorrecta.');
    ponerFoco := eFechaFin;
    Parametros := false;
    Exit;
  end;
  sFechaFin:= eFechaFin.Text;

  if dFechaIni > dFechaFin then
  begin
    ShowError('La fecha Fin no puede se menor que la fecha Inicio.');
    ponerFoco := eFechaFin;
    Parametros := false;
    Exit;
  end;

  ponerFoco := nil;
  Parametros := true;

end;

procedure TFPrecioVentaAsignacion.ssEnvaseAntesEjecutar(Sender: TObject);
begin
  ssEnvase.SQLAdi := '';
  if eCliente.Text <> '' then
    ssEnvase.SQLAdi := ' cliente_e = ' +  QuotedStr(Ecliente.Text);
end;

procedure TFPrecioVentaAsignacion.AAceptarExecute(Sender: TObject);
begin
  btAceptar.Click;
end;

function TFPrecioVentaAsignacion.AbrirTransaccion(DB: TDataBase): Boolean;
var
  T, Tiempo: Cardinal;
  cont: integer;
  flag: boolean;
begin
  cont := 0;
  flag := true;
  while flag do
  begin
        //Abrimos transaccion si podemos
    if DB.InTransaction then
    begin
           //Ya hay una transaccion abierta
      inc(cont);
      if cont = 3 then
      begin
        AbrirTransaccion := false;
        Exit;
      end;
           //Esperar entre 1 y (1+cont) segundos
      T := GetTickCount;
      Tiempo := cont * 1000 + Random(1000);
      while GetTickCount - T < Tiempo do Application.ProcessMessages;
    end
    else
    begin
      DB.StartTransaction;
      flag := false;
    end;
  end;
  AbrirTransaccion := true;
end;

procedure TFPrecioVentaAsignacion.ACancelarExecute(Sender: TObject);
begin
  btCancelar.Click;
end;

procedure TFPrecioVentaAsignacion.AceptarTransaccion(DB: TDataBase);
begin
  if DB.InTransaction then
  begin
    DB.Commit;
  end;
end;

procedure TFPrecioVentaAsignacion.CancelarTransaccion(DB: TDataBase);
begin
  if DB.InTransaction then
  begin
    DB.Rollback;
  end;
end;

end.
