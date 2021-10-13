unit LFMoviEnvasesProveedor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, ActnList,
  ComCtrls, Db, DbTables, CGestionPrincipal, BEdit,
  BCalendarButton, BSpeedButton, BGridButton, BCalendario, Grids, DBGrids,
  BGrid, Derror;

type
  TFMoviEnvasesProveedor = class(TForm)
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
    lblProveedor: TLabel;
    edtProveedor: TBEdit;
    btnProveedor: TBGridButton;
    txtProveedor: TStaticText;
    lblEntregas: TLabel;
    edtEntregas: TBEdit;
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

    function CamposVacios: boolean;
    procedure Imprimir;
    procedure PutSalidas( const AOperador, AEnvase, AProveedor, AEntrega: string );

  public
    { Public declarations }

  end;

var
  //FLSalidasEnvases: TFLSalidasEnvases;
  Autorizado: boolean;

implementation

uses UDMAuxDB, CVariables, DPreview, CReportes,
  CAuxiliarDB, Principal, LQMoviEnvasesProveedor,
  UDMBaseDatos, bSQLUtils, UDMConfig, bTimeUtils, UFProveedores;

{$R *.DFM}

procedure TFMoviEnvasesProveedor.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Tag := kEmpresa;
  edtCentro.Tag := kCentro;
  edtProveedor.Tag := kProveedor;
  edtOperador.Tag := kEnvComerOperador;
  edtEnvComer.Tag := kEnvComerProducto;
  edtFechaDesde.Tag := kCalendar;
  edtFechaHasta.Tag := kCalendar;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  bPrimeraVez:= true;
end;

procedure TFMoviEnvasesProveedor.FormActivate(Sender: TObject);
begin
  ActiveControl := edtEmpresa;
  Top := 10;
  if bPrimeraVez then
  begin
    edtEmpresa.Text:= gsDefEmpresa;
    edtCentro.Text:= gsDefCentro;
    edtOperador.Text:= '100';      //LOGIFRUIT
    dIni:= lunesAnterior( Date ) - 7;
    dFin:= dIni + 6;
    edtFechaDesde.Text := DateTostr( dIni );
    edtFechaHasta.Text := DateTostr( dFin );
    CalendarioFlotante.Date := Date;
    bPrimeraVez:= false;
  end;
end;

procedure TFMoviEnvasesProveedor.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMoviEnvasesProveedor.FormClose(Sender: TObject;
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

procedure TFMoviEnvasesProveedor.ADesplegarRejillaExecute(Sender: TObject);
var
  sResult: string;
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
    kProveedor:
    begin
      if SeleccionaProveedor( self, edtProveedor, edtEmpresa.Text, sResult ) then
      begin
        edtProveedor.Text:= sResult;
      end;
    end;
    kEnvComerOperador: DespliegaRejilla(btnOperador);
    kEnvComerProducto: DespliegaRejilla(btnEnvComer);
  end;
end;

procedure TFMoviEnvasesProveedor.PonNombre(Sender: TObject);
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
      PonNombre( edtProveedor );
    end;
    kCentro:
    begin
      txtCentro.Caption := desCentro(edtEmpresa.Text, edtCentro.Text );
    end;
    kProveedor:
    begin
      if edtProveedor.Text = '' then
        txtProveedor.Caption := 'TODOS LOS PROVEEDORES'
      else
        txtProveedor.Caption := desProveedor(edtEmpresa.Text, edtProveedor.Text );
    end;
    kEnvComerOperador:
    begin
      if edtOperador.Text = '' then
        txtOperador.Caption := 'TODOS LOS OPERADORES COMERCIALES'
      else
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

procedure TFMoviEnvasesProveedor.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then Exit;

  if CamposVacios then Exit;

     //Llamamos al QReport
  Imprimir;
end;

procedure TFMoviEnvasesProveedor.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

function TFMoviEnvasesProveedor.CamposVacios: boolean;
begin

        //Comprobamos que los campos esten todos con datos
  if txtEmpresa.Caption = '' then
  begin
    ShowError('Falta el código de la empresa o es incorrecto');
    edtEmpresa.SetFocus;
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

  if txtCentro.Caption = '' then
  begin
    ShowError('Falta el código del centro salida o es incorrecto.');
    edtCentro.SetFocus;
    Result := True;
    Exit;
  end;

  if txtProveedor.Caption = '' then
  begin
    ShowError('El código del proveedor es incorrecto.');
    edtProveedor.SetFocus;
    Result := True;
    Exit;
  end;

  if txtOperador.Caption = '' then
  begin
    ShowError('El código del operador comercial es incorrecto.');
    edtOperador.SetFocus;
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

  Result := False;
end;


procedure TFMoviEnvasesProveedor.PutSalidas( const AOperador, AEnvase, AProveedor, AEntrega: string );
begin
  with DMBaseDatos.QListado do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_em empresa, centro_em centro, ');
    SQL.Add('        cod_operador_em operador, cod_producto_em envase, ');
    SQL.Add('        cod_proveedor_em proveedor, codigo_em referencia, ');
    SQL.Add('        fecha_em fecha, notas_em nota, ');
    SQL.Add('        entrada_em entrada, salida_em salida, 0 stock ');
    SQL.Add(' from frf_entregas_mat ');
    SQL.Add(' where codigo_em = codigo_em ');
    SQL.Add(' and empresa_em = :empresa ');
    SQL.Add(' and centro_em = :centro ');
    SQL.Add(' and fecha_em between :fechaini and :fechafin ');
    if AOperador <> '' then
      SQL.Add(' and cod_operador_em = :operador ');
    if AEnvase <> '' then
      SQL.Add(' and cod_producto_em = :envase ');
    if AProveedor <> '' then
      SQL.Add(' and cod_proveedor_em = :proveedor ');

    if AEntrega <> '' then
    begin
      SQL.Add(' and codigo_em = :entrega ');
    end
    else
    begin
      SQL.Add(' union ');

      SQL.Add(' select empresa_esm empresa, centro_esm centro, ');
      SQL.Add('        cod_operador_esm operador, cod_producto_esm envase, ');
      SQL.Add('        cod_proveedor_esm proveedor, ''INVENTARIO'' referencia, ');
      SQL.Add('        fecha_esm fecha, nota_esm nota, ');
      SQL.Add('        0 entrada, 0 salida, stock_esm stock ');
      SQL.Add(' from frf_entregas_stock_mat ');
      SQL.Add(' where empresa_esm = :empresa ');
      SQL.Add(' and centro_esm = :centro ');
      SQL.Add(' and fecha_esm between :fechaini and :fechafin ');
      if AOperador <> '' then
        SQL.Add(' and cod_operador_esm = :operador ');
      if AEnvase <> '' then
        SQL.Add(' and cod_producto_esm = :envase ');
      if AProveedor <> '' then
        SQL.Add(' and cod_proveedor_esm = :proveedor ');
    end;

    SQL.Add(' order by empresa, centro, operador, envase, proveedor, fecha ');
  end;
end;

procedure TFMoviEnvasesProveedor.Imprimir;
begin
   // Hacer la llamada al informe
  QMoviEnvasesProveedor := TQMoviEnvasesProveedor.Create(Application);
  PonLogoGrupoBonnysa(QMoviEnvasesProveedor, edtEmpresa.Text);

  with DMBaseDatos.QListado do
  begin
    try
      Close;
      PutSalidas( Trim(edtOperador.Text), Trim(edtEnvComer.Text),
                  Trim(edtProveedor.Text), Trim(edtEntregas.Text) );

      ParamByName('empresa').AsString:= edtEmpresa.Text;
      ParamByName('centro').AsString:= edtCentro.Text;
      ParamByName('fechaini').AsDateTime:= dIni;
      ParamByName('fechafin').AsDateTime:= dFin;
      if Trim(edtProveedor.Text) <> '' then
        ParamByName('proveedor').AsString:= Trim(edtProveedor.Text);
      if Trim(edtOperador.Text) <> '' then
        ParamByName('operador').AsString:= Trim(edtOperador.Text);
      if Trim(edtEnvComer.Text) <> '' then
        ParamByName('envase').AsString:= Trim(edtEnvComer.Text);
      if Trim(edtEntregas.Text) <> '' then
        ParamByName('entrega').AsString:= Trim(edtEntregas.Text);
      Open;

    except
      FreeAndNil( QMoviEnvasesProveedor );
      raise;
    end;
  end;

  QMoviEnvasesProveedor.sEmpresa := edtEmpresa.Text;
  if not DMBaseDatos.QListado.isEmpty then
  begin
    Preview(QMoviEnvasesProveedor);
  end
  else
  begin
    FreeAndNil( QMoviEnvasesProveedor );
    Application.ProcessMessages;
    Application.MessageBox('Listado sin datos ..', Pchar(Application.title), MB_OK + MB_ICONINFORMATION);
  end;
end;

end.

