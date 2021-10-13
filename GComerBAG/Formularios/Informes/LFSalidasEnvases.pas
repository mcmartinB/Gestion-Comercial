unit LFSalidasEnvases;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, DbTables, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror;

type
  TFLSalidasEnvases = class(TForm)
    Panel1: TPanel;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    Label1: TLabel;
    edtEmpresa: TBEdit;
    BGBEmpresa: TBGridButton;
    STEmpresa: TStaticText;
    Desde: TLabel;
    edtFechaDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    Label14: TLabel;
    edtFechaHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    Label5: TLabel;
    edtCliente: TBEdit;
    Label2: TLabel;
    edtEnvase: TBEdit;
    lblOperador: TLabel;
    edtOperador: TBEdit;
    btnOperador: TBGridButton;
    txtOperador: TStaticText;
    btnCliente: TBGridButton;
    txtCliente: TStaticText;
    btnEnvComer: TBGridButton;
    txtEnvComer: TStaticText;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure FormActivate(Sender: TObject);


  private
     { Private declarations}
     bPrimeraVez: boolean;

    function CamposVacios: boolean;
    procedure Imprimir;

  public
    { Public declarations }
    empresa, centro: string;
    fechaInicio, inicioCampana: TDate;
    imprimido: boolean;
    //contabiliza las direcciones de suminitros que existen en la consulta
    direcciones: integer;
  end;

var
  //FLSalidasEnvases: TFLSalidasEnvases;
  Autorizado: boolean;

implementation

uses UDMAuxDB, CVariables, DPreview, CReportes,
  CAuxiliarDB, Principal, LSalidasEnvases,
  UDMBaseDatos, bSQLUtils, UDMConfig;

{$R *.DFM}

procedure TFLSalidasEnvases.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Tag := kEmpresa;
  edtFechaDesde.Tag := kCalendar;
  edtFechaHasta.Tag := kCalendar;
  edtCliente.Tag := kCliente;
  edtOperador.Tag  := kEnvComerOperador;
  edtEnvase.Tag := kEnvComerProducto;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  direcciones := 0;

  bPrimeraVez:= true;
end;

procedure TFLSalidasEnvases.FormActivate(Sender: TObject);
begin
  ActiveControl := edtEmpresa;
  Top := 10;

  if bPrimeraVez then
  begin
    edtEmpresa.Text:= gsDefEmpresa;
    edtOperador.Text:= '002';//logifruit

    edtFechaDesde.Text := DateTostr(Date-6);
    edtFechaHasta.Text := DateTostr(Date);
    CalendarioFlotante.Date := Date;

    edtCliente.Text := '';
    edtEnvase.Text := '';

    bPrimeraVez:= false;
  end;
end;

procedure TFLSalidasEnvases.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    $0D, $28: //vk_return,vk_down
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
        Exit;
      end;
    $26: //vk_up
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
        Exit;
      end;
  end;
end;

procedure TFLSalidasEnvases.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  CloseAuxQuerys;
  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  BEMensajes('');
  Action := caFree;
end;

procedure TFLSalidasEnvases.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCliente: DespliegaRejilla(btnCliente,[edtEmpresa.text]);
    kCalendar:
      begin
        if edtFechaDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
    kEnvComerOperador: DespliegaRejilla(btnOperador);
    kEnvComerProducto: DespliegaRejilla(btnEnvComer,[edtOperador.Text]);
  end;
end;

procedure TFLSalidasEnvases.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa:
    begin
      STEmpresa.Caption := desEmpresa(edtEmpresa.Text);
      PonNombre( edtCliente );
    end;
    kCliente: 
    begin
      if edtCliente.Text = '' then
      begin
        txtCliente.Caption := 'TODOS LOS CLIENTES';
      end
      else
      begin
        txtCliente.Caption := desCliente(edtCliente.Text);
      end;
    end;
    kEnvComerOperador:
    begin
      txtOperador.Caption := desEnvComerOperador( edtOperador.Text );
      PonNombre( edtEnvase );
    end;
    kEnvComerProducto:
    begin
      if edtEnvase.Text = '' then
      begin
        txtEnvComer.Caption := 'TODOS LOS ENVASES RETORNABLES';
      end
      else
      begin
        txtEnvComer.Caption := desEnvComerProducto( edtOperador.Text, edtEnvase.Text );
      end;
    end;
  end;
end;

procedure TFLSalidasEnvases.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true)then
    Exit;

  if CamposVacios then
    Exit;

     //Llamamos al QReport
  Imprimir;
end;

procedure TFLSalidasEnvases.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

function TFLSalidasEnvases.CamposVacios: boolean;
var
  dIni, dFin: TDateTime;
begin
  Result := True;

  //Comprobamos que los campos esten todos con datos
  if STEmpresa.Caption = '' then
  begin
    ShowError('Falta el código de la empresa o es incorrecto.');
    edtEmpresa.SetFocus;
    Exit;
  end;
  if txtOperador.Caption = '' then
  begin
    ShowError('Falta el código del operador o es incorrecto.');
    edtOperador.SetFocus;
    Exit;
  end;
  if not TryStrToDate( edtFechaDesde.Text, dIni ) then
  begin
    ShowError('Falta la fecha de inicio o es incorrecta.');
    edtFechaDesde.SetFocus;
    Exit;
  end;
  if not TryStrToDate( edtFechaHasta.Text, dFin ) then
  begin
    ShowError('Falta la fecha de fin o es incorrecta.');
    edtFechaHasta.SetFocus;
    Exit;
  end;
  if dIni > dFin then
  begin
    ShowError('Rango de fechas incorrecto.');
    edtFechaDesde.SetFocus;
    Exit;
  end;
  if txtCliente.Caption = '' then
  begin
    ShowError('El codigo del cliente es incorrecto.');
    edtCliente.SetFocus;
    Exit;
  end;
  if txtEnvComer.Caption = '' then
  begin
    ShowError('El codigo del envase retornable es incorrecto.');
    edtEnvase.SetFocus;
    Exit;
  end;

  Result := False;
end;

procedure TFLSalidasEnvases.Imprimir;
var
  i: Integer;
  aux: string;
begin
   // Hacer la llamada al informe
  QRLSalidasEnvases := TQRLSalidasEnvases.Create(Application);
  PonLogoGrupoBonnysa(QRLSalidasEnvases, edtEmpresa.Text);

  with QRLSalidasEnvases do
  begin
     //Sacar datos
     //Le pasamos los parametros y abrimos la consulta principal
    with QSalidasEnvases do
    begin
      try
        Close;
        SQL.Add(' SELECT cliente_sal_sc,dir_sum_sc,n_albaran_sc,fecha_sc, n_pedido_sc, fecha_pedido_sc, ' +
          '        envase_sl, descripcion_e, env_comer_producto_e codigo_caja_e,  ' +
          //'        SUM(cajas_sl * nvl(cantidad_cajas_e,1) ) cajas ');
          '        SUM(cajas_sl ) cajas ');
        SQL.Add(' FROM frf_salidas_c, frf_salidas_l, frf_envases ');

        SQL.Add(' WHERE empresa_sc ' + SQLEqualS(edtEmpresa.Text));
        SQL.Add(' AND   fecha_sc ' + SQLRangeD(edtFechaDesde.Text, edtFechaHasta.Text));
        if edtCliente.Text <> '' then
        SQL.Add(' AND   cliente_sal_sc ' + SQLEqualS(edtCliente.Text));

        SQL.Add(' AND   empresa_sl ' + SQLEqualS(edtEmpresa.Text));
        SQL.Add(' AND   centro_salida_sl = centro_salida_sc ');
        SQL.Add(' AND   n_albaran_sl = n_albaran_sc ');
        SQL.Add(' AND   fecha_sl = fecha_sc ');

        SQL.Add(' AND   envase_sl = envase_e ');
        SQL.Add(' and   producto_e = producto_sl');

        if edtEnvase.Text <> '' then
          SQL.Add(' AND   env_comer_producto_e ' + SQLEqualS(edtEnvase.Text))
        else
          SQL.Add(' AND   env_comer_producto_e is not null ');

        if edtOperador.Text <> '' then
          SQL.Add(' AND   env_comer_operador_e ' + SQLEqualS(edtOperador.Text))
        else
          SQL.Add(' AND   env_comer_operador_e is not null ');

        SQL.Add(' GROUP BY cliente_sal_sc, dir_sum_sc,n_albaran_sc,fecha_sc, n_pedido_sc,fecha_pedido_sc, ' +
          '          env_comer_producto_e, envase_sl, descripcion_e ');
        SQL.Add(' ORDER BY cliente_sal_sc, dir_sum_sc,n_albaran_sc,fecha_sc, n_pedido_sc,fecha_pedido_sc, ' +
          '          env_comer_producto_e, envase_sl, descripcion_e ');
        Open;
      except
        on E: EDBEngineError do
        begin
          ShowError(e);
          Exit; //Raise;
        end;
      end;
      //Recorrer la query para saber cuantas direcciones de suministro diferentes hay
      aux := '';
      for i := 0 to RecordCount - 1 do
        if not IsEmpty then
          while not Eof do
          begin
            if aux <> FieldByName('dir_sum_sc').AsString then
            begin
              inc(direcciones);
              aux := FieldByName('dir_sum_sc').AsString;
            end;
            Next;
          end;
    end;

    iDirecciones := Direcciones;
    lblPeriodo.Caption := edtFechaDesde.Text + ' a ' + edtFechaHasta.Text;
    lblClientes.Caption := txtCliente.Caption;
    qrlblOperador.Caption := txtOperador.Caption;
    sEmpresa := edtEmpresa.Text;
  end;
  if not QRLSalidasEnvases.QSalidasEnvases.isEmpty then
  begin
    Preview(QRLSalidasEnvases);
  end
  else
  begin
    QRLSalidasEnvases.free;
    Application.ProcessMessages;
    Application.MessageBox('Listado sin datos ..', Pchar(Application.title), MB_OK + MB_ICONINFORMATION);
  end;
end;

end.
