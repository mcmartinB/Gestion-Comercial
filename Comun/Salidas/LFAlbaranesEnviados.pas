unit LFAlbaranesEnviados;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, DbTables, ActnList,
  CGestionPrincipal, BEdit, Grids, DBGrids,
  BGrid, BSpeedButton, BGridButton, BCalendarButton, BCalendario, DError,
  QuickRpt, ComCtrls;

type
  TFLAlbaranesEnviados = class(TForm)
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    BGBEmpresa: TBGridButton;
    LEmpresa: TLabel;
    LCliente: TLabel;
    BGBCliente: TBGridButton;
    STCliente: TStaticText;
    STEmpresa: TStaticText;
    GBPeriodo: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    ADesplegarRejilla: TAction;
    EEmpresa: TBEdit;
    ECliente: TBEdit;
    MEDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    BCBHasta: TBCalendarButton;
    MEHasta: TBEdit;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    GBDatos: TGroupBox;
    QAlbaranesEnviados: TQuery;
    RGEnviados: TRadioGroup;
    Label3: TLabel;
    ECentro: TBEdit;
    btnCentro: TBGridButton;
    stCentro: TStaticText;
    procedure BBCancelarClick(Sender: TObject);
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
  private
      {private declarations}
    titulo, cliente, albaran, fecha, hora, fecha_env: string;
    function CamposVacios: boolean;
    function AbrirConsulta: boolean;

  public
    { Public declarations }

  end;

//var
  //FLAlbaranesEnviados: TFLAlbaranesEnviados;

implementation

uses UDMAuxDB, CVariables, Principal, CAuxiliarDB, LAlbaranesEnviados, DPreview,
  UDMBaseDatos, CReportes;

{$R *.DFM}

procedure TFLAlbaranesEnviados.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

procedure TFLAlbaranesEnviados.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then Exit;

  if CamposVacios then Exit;

  if not AbrirConsulta then Exit;

     //Crear report
  QRLAlbaranesEnviados := TQRLAlbaranesEnviados.Create(Application);
  QRLAlbaranesEnviados.sEmpresa := EEmpresa.Text;
  QRLAlbaranesEnviados.lblRango.Caption := 'Del ' + MEDesde.Text + ' al ' + MEHasta.Text;
  QRLAlbaranesEnviados.Titulo.Caption := titulo;
     //cambiar la tabla de la que se sacan los campos
  QRLAlbaranesEnviados.DBCliente.DataField := cliente;
  QRLAlbaranesEnviados.DBDesCliente.DataField := cliente;
  QRLAlbaranesEnviados.DBAlbaran.DataField := albaran;
  QRLAlbaranesEnviados.DBFecha.DataField := fecha;
  QRLAlbaranesEnviados.DBHora.DataField := hora;
  QRLAlbaranesEnviados.DBFechaEnv.DataField := fecha_env;

  PonLogoGrupoBonnysa( QRLAlbaranesEnviados, eEmpresa.Text );

  Preview(QRLAlbaranesEnviados, 1);

end;

procedure TFLAlbaranesEnviados.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BEMensajes('');
  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;
end;

procedure TFLAlbaranesEnviados.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  MEDesde.Text := DateToStr(Date);
  MEHasta.Text := DateTostr(Date);
  CalendarioFlotante.Date := Date;

  EEmpresa.Tag := kEmpresa;
  ECliente.Tag := kCliente;
  ECentro.Tag := kCentro;
  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;

  EEmpresa.Text := gsDefEmpresa;
  ECliente.Text := '';

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

end;

procedure TFLAlbaranesEnviados.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLAlbaranesEnviados.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCliente: DespliegaRejilla(BGBCliente, [EEmpresa.Text]);
    kCentro: DespliegaRejilla(btnCentro, [EEmpresa.Text]);
    kCalendar:
      begin
        if MEDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TFLAlbaranesEnviados.PonNombre(Sender: TObject);
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
      STEmpresa.Caption := desEmpresa(Eempresa.Text);
      PonNombre( ECentro );
      PonNombre( ECliente );
    end;
    kCentro:
    begin
      if Trim( ECentro.Text ) = '' then
        stCentro.Caption := 'TODOS LOS CENTROS'
      else
        stCentro.Caption := desCentro(Eempresa.Text, ECentro.Text);
    end;
    kCliente:
    begin
      if Trim( ECliente.Text ) = '' then
        STCliente.Caption := 'TODOS LOS CLIENTES'
      else
        STCliente.Caption := desCliente(ECliente.Text);
    end;
  end;
end;

function TFLAlbaranesEnviados.CamposVacios: boolean;
var
  dIni, dFin: TDateTime;
begin
  //Comprobar si los campos se han rellenado correctamente
  if EEmpresa.Text = '' then
  begin
    ShowError('Falta o es incorrecto el código de la empresa.');
    EEmpresa.SetFocus;
    Result := True;
    Exit;
  end;

  if stCentro.Caption = '' then
  begin
    ShowError('El código del centro es incorrecto.');
    ECentro.SetFocus;
    Result := True;
    Exit;
  end;

  if stCliente.Caption = '' then
  begin
    ShowError('El código del cliente es incorrecto.');
    ECliente.SetFocus;
    Result := True;
    Exit;
  end;

  if not TryStrToDateTime( MEDesde.Text, dIni ) then
  begin
    ShowError('La fecha de inicio es incorrecta.');
    MEDesde.SetFocus;
    Result := True;
    Exit;
  end;
  if not TryStrToDateTime( MEHasta.Text, dFin ) then
  begin
    ShowError('La fecha de fin es incorrecta.');
    MEHasta.SetFocus;
    Result := True;
    Exit;
  end;
  if dIni > dFin then
  begin
    ShowError('Rango de fechas incorrecto.');
    MEDesde.SetFocus;
    Result := True;
    Exit;
  end;
  Result := False;
end;

function TFLAlbaranesEnviados.AbrirConsulta: boolean;
begin
     //Generar y abrir la consulta
  with QAlbaranesEnviados do
  begin
    Close;
    SQL.Clear;
    case RGenviados.ItemIndex of
      0: begin
          titulo := 'ALBARANES ENVIADOS';
          cliente := 'cliente_sal_ae';
          albaran := 'n_albaran_ae';
          fecha := 'fecha_ae';
          hora := 'hora_env_ae';
          fecha_env := 'fecha_env_ae';
          SQl.Add('Select distinct * from frf_alb_enviados join frf_salidas_c on empresa_sc = empresa_ae and n_albaran_sc = n_albaran_ae and fecha_sc = fecha_ae ' +
            'where empresa_ae = ' + QuotedStr(EEmpresa.Text) );
          SQl.Add('and cliente_sal_sc = cliente_sal_ae ');
          if Trim( ECentro.Text ) <> '' then
            SQl.Add(' and centro_salida_sc = ' + QuotedStr(ECentro.Text) );

          if Trim( ECliente.Text ) <> '' then
            SQl.Add(' and cliente_sal_ae = ' + QuotedStr(ECliente.Text) );

                    //11-06-02 Cambio de fecha de envio a fecha de albaran
          SQl.Add(' and fecha_ae BETWEEN ' + QuotedStr(MEDesde.Text) + ' AND ' + QuotedStr(MEHasta.Text) +
            ' Order by cliente_sal_ae, fecha_ae, n_albaran_ae ');

        end;
      1: begin
          titulo := 'ALBARANES NO ENVIADOS';
          cliente := 'cliente_sal_sc';
          albaran := 'n_albaran_sc';
          fecha := 'fecha_sc';
          hora := '';
          fecha_env := '';
          SQl.Add('select cliente_sal_sc, n_albaran_sc, fecha_sc ' +
            ' from frf_salidas_c' +
            ' where empresa_sc = ' + QuotedStr(EEmpresa.Text) );
          if Trim( ECentro.Text ) <> '' then
            SQl.Add(' and centro_salida_sc = ' + QuotedStr(ECentro.Text) );

          if Trim( ECliente.Text ) <> '' then
            SQl.Add(' and   cliente_sal_sc = ' + QuotedStr(ECliente.Text) );
          SQl.Add(' and   fecha_sc between ' + QuotedStr(MEDesde.Text) + ' and ' + QuotedStr(MEHasta.Text) +
            ' and   n_albaran_sc not in (select n_albaran_ae from frf_alb_enviados' +
            ' where n_albaran_ae = n_albaran_sc' +
            ' and  empresa_ae = empresa_sc ' +
            ' and  cliente_sal_ae = cliente_sal_sc)' +
            ' order by cliente_sal_sc, n_albaran_sc');
        end;
    end;

    try
      Open;
    except
      Result := False;
      ShowError('No se puede mostrar el resultado de la consulta');
      Exit;
    end;
    if bof and eof then
    begin
      Result := false;
      ShowError('No existen datos para los parámetros introducidos');
    end
    else
    begin
      Result := true;
    end;
  end;
end;

end.
