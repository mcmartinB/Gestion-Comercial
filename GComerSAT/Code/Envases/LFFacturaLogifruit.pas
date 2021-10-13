unit LFFacturaLogifruit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, DbTables, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, kbmMemTable;

type
  TFLFacturaLogifruit = class(TForm)
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
    btnEmpresa: TBGridButton;
    txtEmpresa: TStaticText;
    lblDesde: TLabel;
    edtFechaDesde: TBEdit;
    btnFechaDesde: TBCalendarButton;
    lbl1: TLabel;
    edtFechaHasta: TBEdit;
    btnFechaHasta: TBCalendarButton;
    Label2: TLabel;
    edtEnvComer: TBEdit;
    lblCentro: TLabel;
    edtCentro: TBEdit;
    btnCentro: TBGridButton;
    txtCentro: TStaticText;
    btnEnvComer: TBGridButton;
    txtEnvComer: TStaticText;
    lblOperador: TLabel;
    edtOperador: TBEdit;
    btnOperador: TBGridButton;
    txtOperador: TStaticText;
    chkEntradas: TCheckBox;
    chkSalidas: TCheckBox;
    lblVer: TLabel;
    qryMovimientos: TQuery;
    kmtListado: TkbmMemTable;
    lblCliente: TLabel;
    edtCliente: TBEdit;
    btnCliente: TBGridButton;
    txtCliente: TStaticText;
    chkExcluir: TCheckBox;
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
     dIni, dFin: TDateTime;
     bEntradas,bSalidas: Boolean;

    function  CamposVacios: boolean;
    procedure Imprimir;
    procedure PutSQL( const ACliente, ACentro, AEnvaseComer, AEntradas, ASalidas, AExcluir: Boolean );
    function  CargarDatosListado: boolean;
    procedure AnyadirLineaDatos;
    procedure IncrementarLinea;

  public
    { Public declarations }

  end;

var
  //FLSalidasEnvases: TFLSalidasEnvases;
  Autorizado: boolean;

implementation

uses UDMAuxDB, CVariables, DPreview, CReportes, CAuxiliarDB, Principal,
  LFacturaLogifruit, UDMBaseDatos, bSQLUtils, UDMConfig, bTimeUtils, Variants;

{$R *.DFM}

procedure TFLFacturaLogifruit.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Tag := kEmpresa;
  edtCentro.Tag := kCentro;
  edtCliente.Tag := kCliente;
  edtOperador.Tag := kEnvComerOperador;
  edtEnvComer.Tag := kEnvComerProducto;
  edtFechaDesde.Tag := kCalendar;
  edtFechaHasta.Tag := kCalendar;

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  bPrimeraVez:= true;

  kmtListado.FieldDefs.Clear;

  kmtListado.FieldDefs.Add('empresa', ftString, 3, False);
  kmtListado.FieldDefs.Add('operador', ftString, 3, False);
  kmtListado.FieldDefs.Add('centro', ftString, 1, False);
  kmtListado.FieldDefs.Add('tipo', ftString, 1, False);

  kmtListado.FieldDefs.Add('cliente', ftString, 3, False);
  kmtListado.FieldDefs.Add('almacen', ftString, 3, False);
  kmtListado.FieldDefs.Add('fecha', ftDate, 0, False);
  kmtListado.FieldDefs.Add('referencia', ftString, 10, False);

  kmtListado.FieldDefs.Add('env_0081', ftInteger, 0, False);
  kmtListado.FieldDefs.Add('env_0316', ftInteger, 0, False);
  kmtListado.FieldDefs.Add('env_0618', ftInteger, 0, False);
  kmtListado.FieldDefs.Add('env_3416', ftInteger, 0, False);
  kmtListado.FieldDefs.Add('env_6412', ftInteger, 0, False);
  kmtListado.FieldDefs.Add('env_restos', ftInteger, 0, False);
  kmtListado.IndexFieldNames:= 'empresa;operador;centro;tipo;almacen;cliente;fecha;referencia';
  kmtListado.CreateTable;

  (*
  kmtResumen.FieldDefs.Clear;
  kmtResumen.FieldDefs.Add('empresa', ftString, 3, False);
  kmtResumen.FieldDefs.Add('centro', ftString, 1, False);
  kmtResumen.FieldDefs.Add('operador', ftString, 3, False);
  kmtResumen.FieldDefs.Add('envase', ftString, 9, False);
  kmtResumen.FieldDefs.Add('cantidad', ftInteger, 0, False);
  kmtResumen.IndexFieldNames:= 'empresa;centro;operador;envase';
  kmtResumen.CreateTable;
  *)
end;

procedure TFLFacturaLogifruit.FormActivate(Sender: TObject);
begin
  ActiveControl := edtEmpresa;
  Top := 10;
  if bPrimeraVez then
  begin
    edtEmpresa.Text:= gsDefEmpresa;
    edtCentro.Text:= '';
    edtOperador.Text:= '002';      //LOGIFRUIT
    edtCliente.Text:= 'MER';
    dIni:= lunesAnterior( Date ) - 7;
    dFin:= dIni + 6;
    edtFechaDesde.Text := DateTostr( dIni );
    edtFechaHasta.Text := DateTostr( dFin );
    CalendarioFlotante.Date := Date;
    bPrimeraVez:= false;
  end;
end;

procedure TFLFacturaLogifruit.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLFacturaLogifruit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  kmtListado.Close;
  //kmtResumen.Close;

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

procedure TFLFacturaLogifruit.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kCalendar:
      begin
        if edtFechaDesde.Focused then
          DespliegaCalendario(btnFechaDesde)
        else
          DespliegaCalendario(btnFechaHasta);
      end;
    kCentro: DespliegaRejilla(btnCentro, [edtEmpresa.Text]);
    kCliente: DespliegaRejilla(btnCliente, [edtEmpresa.Text]);
    kEnvComerProducto: DespliegaRejilla(btnEnvComer);
  end;
end;

procedure TFLFacturaLogifruit.PonNombre(Sender: TObject);
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
      txtEmpresa.Caption := desEmpresa(edtEmpresa.Text);
      PonNombre( edtCentro );
    end;
    kCentro:
    begin
      if edtCentro.Text = '' then
        txtCentro.Caption := 'TODOS LOS CENTROS'
      else
        txtCentro.Caption := desCentro(edtEmpresa.Text, edtCentro.Text );
    end;
    kCliente:
    begin
      if edtCliente.Text = '' then
        txtCliente.Caption := 'TODOS LOS CLIENTES'
      else
        txtCliente.Caption := desCliente( edtCliente.Text );
    end;
    kEnvComerOperador:
    begin
      txtOperador.Caption := desEnvComerOperador(edtOperador.Text  );
      PonNombre( edtEnvComer );
    end;
    kEnvComerProducto:
    begin
      if edtEnvComer.Text = '' then
        txtEnvComer.Caption := 'TODOS LOS ENVASES COMERCIALES'
      else
        txtEnvComer.Caption := desEnvComerProducto(edtOperador.Text, edtEnvComer.Text  );
    end;
  end;
end;

procedure TFLFacturaLogifruit.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then
    Exit;

  if CamposVacios then Exit;

     //Llamamos al QReport
  Imprimir;
end;

procedure TFLFacturaLogifruit.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

function TFLFacturaLogifruit.CamposVacios: boolean;
begin

        //Comprobamos que los campos esten todos con datos
  if txtEmpresa.Caption = '' then
  begin
    ShowError('Falta el código de la empresa o es incorrecto.');
    edtEmpresa.SetFocus;
    Result := True;
    Exit;
  end;

  if txtOperador.Caption = '' then
  begin
    ShowError('Falta el código del operador comercial o es incorrecto.');
    edtOperador.SetFocus;
    Result := True;
    Exit;
  end;

  if not TryStrToDateTime( edtFechaDesde.Text, dIni ) then
  begin
    ShowError('La fecha de inicio es incorrecta.');
    edtFechaDesde.SetFocus;
    Result := True;
    Exit;
  end;

  if not TryStrToDateTime( edtFechaHasta.Text, dFin ) then
  begin
    ShowError('La fecha de fin es incorrecta.');
    edtFechaHasta.SetFocus;
    Result := True;
    Exit;
  end;

  if dIni > dFin  then
  begin
    ShowError('El rango de fechas es incorrecto.');
    edtFechaDesde.SetFocus;
    Result := True;
    Exit;
  end;

  if txtCliente.Caption = '' then
  begin
    ShowError('El código del cliente es incorrecto.');
    edtCliente.SetFocus;
    Result := True;
    Exit;
  end;

  if txtCentro.Caption = '' then
  begin
    ShowError('El código del centro es incorrecto.');
    edtCentro.SetFocus;
    Result := True;
    Exit;
  end;

  if txtEnvComer.Caption = '' then
  begin
    ShowError('El código del envase comercial es incorrecto.');
    edtEnvComer.SetFocus;
    Result := True;
    Exit;
  end;


  bEntradas:= chkEntradas.Checked;
  bSalidas:= chkSalidas.Checked;
  if not( bEntradas or bSalidas ) then
  begin
    bEntradas:= True;
    bSalidas:= True;
  end;

  Result := False;

end;


procedure TFLFacturaLogifruit.PutSQL( const ACliente, ACentro, AEnvaseComer, AEntradas, ASalidas, AExcluir: Boolean );
var
  bFlag: Boolean;
begin
  bFlag:= false;
  with qryMovimientos do
  begin
    SQL.Clear;

    if AEntradas then
    begin
      SQL.Add('select empresa_ece empresa, cod_operador_ece operador, centro_ece centro, 1 tipo, ');
      SQL.Add('       cod_operador_ece cliente, cod_almacen_ece almacen, fecha_ece fecha, ');
      SQL.Add('       nota_ece referencia, cod_producto_ece envase, cantidad_ece cantidad ');
      SQL.Add('from frf_env_comer_entradas ');
      SQL.Add('where empresa_ece = :empresa ');
      if ACentro  then
       SQL.Add(' and centro_ece = :centro ');
      SQL.Add('and fecha_ece between :fechaini and :fechafin ');
      SQL.Add('and cod_operador_ece = :operador ');
      if AEnvaseComer then
        SQL.Add('and cod_producto_ece = :envcomer ');
      bFlag:= True;
    end;

    //solo salidas y tzansitos que tienen operador
    if ASalidas then
    begin
      if bFlag then
       SQL.Add('union ');

      SQL.Add('select empresa_sl empresa, env_comer_operador_e operador, centro_salida_sl centro, 2 tipo, ');
      SQL.Add('       cliente_sal_sc cliente, dir_sum_sc almacen, fecha_sl fecha, ');
      SQL.Add('       cast( n_albaran_sl as char(10) ) referencia, env_comer_producto_e envase, cajas_sl cantidad   ');

      SQL.Add('from frf_salidas_l, frf_envases, frf_salidas_c ');
      SQL.Add('where empresa_sl = :empresa ');
      if ACentro  then
       SQL.Add(' and centro_salida_sl = :centro ');
      SQL.Add('and fecha_sl between :fechaini and :fechafin ');
      SQL.Add('and envase_sl = envase_e ');
      SQL.Add('and env_comer_operador_e = :operador ');
      if AEnvaseComer then
        SQL.Add('and env_comer_producto_e = :envcomer ');
      SQL.Add('and empresa_sc = :empresa ');
      if ACentro then
       SQL.Add(' and centro_salida_sc = :centro ')
      else
       SQL.Add(' and centro_salida_sc = centro_salida_sl ');
      if ACliente then
      begin
        if AExcluir then
          SQL.Add(' and cliente_sal_sc <> :cliente ')
        else
          SQL.Add(' and cliente_sal_sc = :cliente ');
      end;
      SQL.Add('and fecha_sc = fecha_sl ');
      SQL.Add('and n_albaran_sc = n_albaran_sl ');

      SQL.Add('union ');

      SQL.Add('select empresa_sl empresa, env_comer_operador_tp operador, centro_salida_sl centro, 2 tipo, ');
      SQL.Add('       cliente_sal_sc cliente, dir_sum_sc almacen,  fecha_sl fecha, ');
      SQL.Add('       cast( n_albaran_sl as char(10) ) referencia, env_comer_producto_tp envase, n_palets_sl cantidad   ');

      SQL.Add('from frf_salidas_l, frf_tipo_palets, frf_salidas_c ');
      SQL.Add('where empresa_sl = :empresa ');
      if ACentro  then
       SQL.Add(' and centro_salida_sl = :centro ');
      SQL.Add('and fecha_sl between :fechaini and :fechafin ');
      SQL.Add('and tipo_palets_sl = codigo_tp ');
      SQL.Add('and env_comer_operador_tp = :operador ');
      if AEnvaseComer then
        SQL.Add('and env_comer_producto_tp = :envcomer ');
      SQL.Add('and empresa_sc = :empresa ');
      if ACentro  then
       SQL.Add(' and centro_salida_sc = :centro ')
      else
       SQL.Add(' and centro_salida_sc = centro_salida_sl ');
      if ACliente then
      begin
        if AExcluir then
          SQL.Add(' and cliente_sal_sc <> :cliente ')
        else
          SQL.Add(' and cliente_sal_sc = :cliente ');
      end;
      SQL.Add('and fecha_sc = fecha_sl ');
      SQL.Add('and n_albaran_sc = n_albaran_sl ');
    end;

    SQL.Add('order by  empresa, operador, centro, tipo, cliente, almacen, fecha, referencia, envase ');

  end;
end;

procedure TFLFacturaLogifruit.IncrementarLinea;
begin
  if qryMovimientos.FieldByName('envase').AsString = '81' then
    kmtListado.FieldByName('env_0081').AsInteger:= kmtListado.FieldByName('env_0081').AsInteger +
                                                   qryMovimientos.FieldByName('cantidad').AsInteger
  else
  if qryMovimientos.FieldByName('envase').AsString = '316' then
    kmtListado.FieldByName('env_0316').AsInteger:= kmtListado.FieldByName('env_0316').AsInteger +
                                                   qryMovimientos.FieldByName('cantidad').AsInteger
  else
  if qryMovimientos.FieldByName('envase').AsString = '618' then
    kmtListado.FieldByName('env_0618').AsInteger:= kmtListado.FieldByName('env_0618').AsInteger +
                                                   qryMovimientos.FieldByName('cantidad').AsInteger
  else
  if qryMovimientos.FieldByName('envase').AsString = '3416' then
    kmtListado.FieldByName('env_3416').AsInteger:= kmtListado.FieldByName('env_3416').AsInteger +
                                                   qryMovimientos.FieldByName('cantidad').AsInteger
  else
  if qryMovimientos.FieldByName('envase').AsString = '6412' then
    kmtListado.FieldByName('env_6412').AsInteger:= kmtListado.FieldByName('env_6412').AsInteger +
                                                   qryMovimientos.FieldByName('cantidad').AsInteger
  else
    kmtListado.FieldByName('env_restos').AsInteger:= kmtListado.FieldByName('env_restos').AsInteger +
                                                   qryMovimientos.FieldByName('cantidad').AsInteger;
end;

procedure TFLFacturaLogifruit.AnyadirLineaDatos;
begin
  (*
  if qryMovimientos.FieldByName('empresa').AsString = '1' then
  begin
    if kmtResumen.Locate('empresa;centro;operador;envase',
                        VarArrayOf([qryMovimientos.FieldByName('empresa').AsString,
                                    qryMovimientos.FieldByName('centro').AsString,
                                    qryMovimientos.FieldByName('operador').AsString,
                                    qryMovimientos.FieldByName('envase').AsString]), []) then
    begin
      kmtResumen.Edit;
      kmtResumen.FieldByName('cantidad').AsInteger:= kmtResumen.FieldByName('cantidad').AsInteger +
                                                   qryMovimientos.FieldByName('cantidad').AsInteger;
      kmtResumen.Post;
    end
    else
    begin
      kmtResumen.Insert;
      kmtResumen.FieldByName('empresa').AsString:= qryMovimientos.FieldByName('empresa').AsString;
      kmtResumen.FieldByName('centro').AsString:= qryMovimientos.FieldByName('centro').AsString;
      kmtResumen.FieldByName('operador').AsString:= qryMovimientos.FieldByName('operador').AsString;
      kmtResumen.FieldByName('envase').AsString:= qryMovimientos.FieldByName('envase').AsString;
      kmtResumen.FieldByName('cantidad').AsInteger:= qryMovimientos.FieldByName('cantidad').AsInteger;
      kmtResumen.Post;
    end;
  end;
  *)
  if kmtListado.Locate('tipo;empresa;centro;operador;cliente;almacen;fecha;referencia',
                        VarArrayOf([qryMovimientos.FieldByName('tipo').AsString,
                                    qryMovimientos.FieldByName('empresa').AsString,
                                    qryMovimientos.FieldByName('centro').AsString,
                                    qryMovimientos.FieldByName('operador').AsString,
                                    qryMovimientos.FieldByName('cliente').AsString,
                                    qryMovimientos.FieldByName('almacen').AsString,
                                    qryMovimientos.FieldByName('fecha').AsDateTime,
                                    qryMovimientos.FieldByName('referencia').AsString]), []) then
  begin
    kmtListado.Edit;
    IncrementarLinea;
    kmtListado.Post;
  end
  else
  begin
    kmtListado.Insert;
    kmtListado.FieldByName('tipo').AsString:= qryMovimientos.FieldByName('tipo').AsString;
    kmtListado.FieldByName('empresa').AsString:= qryMovimientos.FieldByName('empresa').AsString;
    kmtListado.FieldByName('centro').AsString:= qryMovimientos.FieldByName('centro').AsString;
    kmtListado.FieldByName('operador').AsString:= qryMovimientos.FieldByName('operador').AsString;
    kmtListado.FieldByName('cliente').AsString:= qryMovimientos.FieldByName('cliente').AsString;
    kmtListado.FieldByName('almacen').AsString:= qryMovimientos.FieldByName('almacen').AsString;
    kmtListado.FieldByName('fecha').AsDateTime:= qryMovimientos.FieldByName('fecha').AsDateTime;
    kmtListado.FieldByName('referencia').AsString:= qryMovimientos.FieldByName('referencia').AsString;
    kmtListado.FieldByName('env_0081').AsInteger:= 0;
    kmtListado.FieldByName('env_0316').AsInteger:= 0;
    kmtListado.FieldByName('env_0618').AsInteger:= 0;
    kmtListado.FieldByName('env_3416').AsInteger:= 0;
    kmtListado.FieldByName('env_6412').AsInteger:= 0;
    kmtListado.FieldByName('env_restos').AsInteger:= 0;
    IncrementarLinea;
    kmtListado.Post;
  end;
end;

function TFLFacturaLogifruit.CargarDatosListado: boolean;
begin
  kmtListado.Close;
  kmtListado.Open;
  (*
  kmtResumen.Close;
  kmtResumen.Open;
  *)

  with qryMovimientos do
  begin
    Close;
    PutSQL( Trim(edtCliente.Text) <> '', Trim(edtCentro.Text) <> '', Trim(edtEnvComer.Text) <> '', bEntradas, bSalidas, chkExcluir.Checked );
    ParamByName('empresa').AsString:= edtEmpresa.Text;
    ParamByName('operador').AsString:= edtOperador.Text;
    ParamByName('fechaini').AsDateTime:= dIni;
    ParamByName('fechafin').AsDateTime:= dFin;
    if Trim(edtCliente.Text) <> '' then
      ParamByName('cliente').AsString:= edtCliente.Text;
    if Trim(edtCentro.Text) <> '' then
      ParamByName('centro').AsString:= edtCentro.Text;
    if Trim(edtEnvComer.Text) <> '' then
      ParamByName('envcomer').AsString:= edtEnvComer.Text;
    Open;
    result:= not qryMovimientos.isEmpty;
    while not Eof do
    begin
      AnyadirLineaDatos;
      Next;
    end;
    Close;
  end;
  kmtListado.SortFields:= 'empresa;operador;centro;tipo;cliente;almacen;fecha;referencia';
  kmtListado.Sort([]);
end;

procedure TFLFacturaLogifruit.Imprimir;
begin
   // Hacer la llamada al informe
  if CargarDatosListado then
  begin
    QRLFacturaLogifruit := TQRLFacturaLogifruit.Create(Application);
    PonLogoGrupoBonnysa(QRLFacturaLogifruit, edtEmpresa.Text);
    QRLFacturaLogifruit.lblPeriodo.Caption := edtFechaDesde.Text + ' a ' + edtFechaHasta.Text;
    QRLFacturaLogifruit.sEmpresa := edtEmpresa.Text;
    try
      Preview(QRLFacturaLogifruit);
    except
      FreeAndNil( QRLFacturaLogifruit );
      raise;
    end
  end
  else
  begin
    Application.MessageBox('Listado sin datos ..', Pchar(Application.title), MB_OK + MB_ICONINFORMATION);
  end;
end;

end.

