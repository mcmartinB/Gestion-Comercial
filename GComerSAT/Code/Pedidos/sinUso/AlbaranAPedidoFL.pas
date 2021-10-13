unit AlbaranAPedidoFL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, ActnList,
  ComCtrls, Db, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror, DBTables;

type
  TFLAlbaranAPedido = class(TForm)
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    lblEmpresa: TLabel;
    btnEmpresa: TBGridButton;
    lblCentro: TLabel;
    btnCentro: TBGridButton;
    edtEmpresa: TBEdit;
    stEmpresa: TStaticText;
    edtCentro: TBEdit;
    stCentro: TStaticText;
    lblFechaIni: TLabel;
    edtFechaIni: TBEdit;
    btnFechaIni: TBCalendarButton;
    lblAlbaran: TLabel;
    edtAlbaran: TBEdit;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    lblCliente: TLabel;
    edtCliente: TBEdit;
    btnCliente: TBGridButton;
    stCliente: TStaticText;
    lblFechaFin: TLabel;
    edtFechaFin: TBEdit;
    btnFechaFin: TBCalendarButton;
    lblPedido: TLabel;
    edtPedido: TBEdit;
    QAlbaranes: TQuery;
    cbbUnidadPedido: TComboBox;
    lblUnidadPedido: TLabel;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    function CamposVacios: boolean;

  private
    bPrimeraVez: boolean;
    sEmpresa, sCentro, sCliente, sPedido: string;
    iAlbaran: Integer;
    dIni, dFin: TDateTime;
    slAux: TstringList;

    sEmpresaAlb, sCentroAlb: string;
    iNumeroAlb: Integer;
    dFechaAlb: TDateTime;

    function  HayAlbarenes: Boolean;
    procedure CerrarAlbaranes;
    procedure CargaParametros;

    procedure TituloInforme;
    function LineaInforme: String;
  public
    { Public declarations }
  end;

var
  FLAlbaranAPedido: TFLAlbaranAPedido;
  Autorizado: boolean;

implementation

uses UDMAuxDB, Principal, CVariables, CAuxiliarDB, UDMBaseDatos,
     AlbaranAPedidoDL, AlbaranAPedidoQL, DPreview, bTextUtils;

{$R *.DFM}

function TFLAlbaranAPedido.HayAlbarenes: Boolean;
begin
  with QAlbaranes do
  begin
    Sql.Clear;
    SQL.Add(' select empresa_sc, centro_salida_sc, fecha_sc, n_albaran_sc, cliente_sal_sc, n_pedido_sc ');
    SQL.Add(' from frf_salidas_c ');
    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add(' and cliente_sal_sc = :cliente ');
    SQL.Add(' and fecha_sc between :fechaini and :fechafin ');
    if sCentro <> '' then
      SQL.Add(' and centro_salida_sc = :centro ');
    if iAlbaran  <> -1 then
      SQL.Add(' and n_albaran_sc = :albaran ');
    if sPedido <> '' then
      SQL.Add(' and n_pedido_sc = :pedido ');
    SQL.Add(' order by empresa_sc, centro_salida_sc, fecha_sc, n_albaran_sc ');

    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('cliente').AsString:= sCliente;
    ParamByName('fechaini').AsDateTime:= dIni;
    ParamByName('fechafin').AsDateTime:= dFin;
    if sCentro <> '' then
      ParamByName('centro').AsString:= sCentro;
    if iAlbaran  <> -1 then
      ParamByName('albaran').AsInteger:= iAlbaran;
    if sPedido <> '' then
      ParamByName('pedido').AsString:= sPedido;

    Open;
    Result:= not IsEmpty;
  end;
end;

procedure TFLAlbaranAPedido.CerrarAlbaranes;
begin
  QAlbaranes.Close;
end;

procedure TFLAlbaranAPedido.CargaParametros;
begin
  with QAlbaranes do
  begin
    sEmpresaAlb:= FieldbyName('empresa_sc').AsString;
    sCentroAlb:= FieldbyName('centro_salida_sc').AsString;
    iNumeroAlb:= FieldbyName('n_albaran_sc').AsInteger;
    dFechaAlb:= FieldbyName('fecha_sc').AsDateTime;
  end;
end;

function TFLAlbaranAPedido.LineaInforme: String;
begin
  Result:= RellenaIzq( QAlbaranes.FieldByname('empresa_sc').AsString, 7 ) + ' ' +
           RellenaIzq( QAlbaranes.FieldByname('centro_salida_sc').AsString, 6 ) + ' ' +
           RellenaIzq( QAlbaranes.FieldByname('n_albaran_sc').AsString, 8 ) + ' ' +
           RellenaIzq( QAlbaranes.FieldByname('fecha_sc').AsString, 12 ) + ' ' +
           RellenaIzq( QAlbaranes.FieldByname('cliente_sal_sc').AsString, 7 ) + ' ' +
           RellenaIzq( QAlbaranes.FieldByname('n_pedido_sc').AsString, 22 );
end;

procedure TFLAlbaranAPedido.TituloInforme;
begin
  slAux.Add( '    ' + RellenaIzq( 'EMPRESA', 7 ) + ' ' +
             RellenaIzq( 'CENTRO', 6 ) + ' ' +
             RellenaIzq( 'ALBARAN', 8 ) + ' ' +
             RellenaIzq( 'FECHA', 12 ) + ' ' +
             RellenaIzq( 'CLIENTE', 7 ) + ' ' +
             RellenaIzq( 'PEDIDO', 22 ) );
  slAux.Add( '************************************************************************' );
end;

procedure TFLAlbaranAPedido.BBAceptarClick(Sender: TObject);
var
  sAux: string;
  QLAlbaranAPedido: TQLAlbaranAPedido;
begin
  slAux.Clear;
  if not CerrarForm(true) then
    Exit;
  if not CamposVacios then
  begin
    if HayAlbarenes then
    begin
      TituloInforme;

      while not QAlbaranes.Eof do
      begin
        CargaParametros;
        sAux:= LineaInforme;
        case AlbaranAPedidoDL.AlbaranAPedidoExecute( Self, sEmpresaAlb, sCentroAlb, dFechaAlb, iNumeroAlb, cbbUnidadPedido.ItemIndex ) of
          -1:sAux:= 'ERR ' + sAux + ' ' + 'Ya existe el pedido';
           0:sAux:= 'ERR ' + sAux + ' ' + 'No existe el albaran';
           1:sAux:= 'OK  ' + sAux;// + ' ' + 'Pedido creado';
        end;
        slAux.Add( sAux );
        QAlbaranes.Next;
      end;

      QLAlbaranAPedido:= TQLAlbaranAPedido.Create( self );
      QLAlbaranAPedido.qrmInforme.Lines.Clear;
      QLAlbaranAPedido.qrmInforme.Lines.AddStrings( slAux );
      try
        Previsualiza( QLAlbaranAPedido );
      finally
        FreeAndNil( QLAlbaranAPedido );
      end;
    end
    else
    begin
      ShowMessage('Sin albaranes de salida para los parámetros introducidos.');
    end;
    CerrarAlbaranes;
  end;
end;

procedure TFLAlbaranAPedido.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  BEMensajes('');
  FreeAndNil( slAux );
  Action := caFree;
end;

procedure TFLAlbaranAPedido.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then
    Close;
end;

procedure TFLAlbaranAPedido.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Tag := kEmpresa;
  edtCentro.Tag := kCentro;
  edtCliente.Tag := kCliente;
  edtFechaIni.Tag := kCalendar;
  edtFechaFin.Tag := kCalendar;

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;
  CalendarioFlotante.Date := Date;

  edtEmpresa.Text:= gsDefEmpresa;
  //edtCliente.Text:= gsDefCliente;
  edtFechaIni.Text := DateTostr(Date-1);
  edtFechaFin.Text := DateTostr(Date-1);

  bPrimeraVez:= True;

  slAux:= TstringList.Create;
end;

procedure TFLAlbaranAPedido.FormActivate(Sender: TObject);
begin
  if bPrimeraVez then
  begin
    Top := 1;
    bPrimeraVez:= False;
  end;
end;

procedure TFLAlbaranAPedido.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLAlbaranAPedido.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kCentro: DespliegaRejilla(btnCentro, [edtEmpresa.Text]);
    kCliente: DespliegaRejilla(btnCliente, [edtEmpresa.Text]);
    kCalendar:
      if edtFechaIni.Focused then
        DespliegaCalendario(btnFechaIni)
      else
        DespliegaCalendario(btnFechaFin);
  end;
end;

procedure TFLAlbaranAPedido.PonNombre(Sender: TObject);
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
        PonNombre( edtCentro );
        PonNombre( edtCliente );
      end;
    kCliente:
      begin
        stCliente.Caption := desCliente(edtEmpresa.Text, edtCliente.Text );
      end;
    kCentro:
    begin
      if edtCentro.Text = '' then
      begin
        stCentro.Caption := 'VACIO TODOS LOS CENTROS.';
      end
      else
      begin
        STCentro.Caption := desCentro(edtEmpresa.Text, edtCentro.Text);
      end;
    end;
  end;
end;

function TFLAlbaranAPedido.CamposVacios: boolean;
begin
  Result := True;

  //Comprobamos que los campos esten todos con datos
  if STEmpresa.Caption = '' then
  begin
    ShowError('Falta o código de empresa incorrecto.');
    edtEmpresa.SetFocus;
    Exit;
  end;
  sEmpresa:= edtEmpresa.Text;

  if edtCliente.Text = '' then
  begin
    ShowError('Falta o código de cliente incorrecto.');
    edtCliente.SetFocus;
    Exit;
  end;
  sCliente:= edtCliente.Text;

  if not TryStrToDate( edtFechaIni.Text, dIni ) then
  begin
    ShowError('Fecha de inicio incorrecta.');
    edtFechaIni.SetFocus;
    Exit;
  end;
  if not TryStrToDate( edtFechaFin.Text, dFin ) then
  begin
    ShowError('Fecha de fin incorrecta.');
    edtFechaFin.SetFocus;
    Exit;
  end;
  if dFin < dIni then
  begin
    ShowError('Rango de fechas incorrecto.');
    edtFechaIni.SetFocus;
    Exit;
  end;

  if stCentro.Caption = '' then
  begin
    ShowError('El código del centro es incorrecto.');
    edtCentro.SetFocus;
    Exit;
  end;
  sCentro:= edtCentro.Text;

  iAlbaran:= StrToIntDef( edtAlbaran.Text, -1 );
  sPedido:= edtPedido.Text;

  Result := False;
end;

end.



