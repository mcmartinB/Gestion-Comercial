unit LFEnvasesCliente;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, DbTables, ActnList,
  ComCtrls, CGestionPrincipal, BEdit, Grids, DBGrids,
  BGrid, BSpeedButton, BGridButton, BCalendarButton, BCalendario, DError,
  QuickRpt, BDEdit, QRCtrls;

type
  TFLEnvasesCliente = class(TForm)
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    ADesplegarRejilla: TAction;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    qryEnvases: TQuery;
    STEmpresa: TStaticText;
    STCliente: TStaticText;
    edtCliente: TBEdit;
    edtEmpresa: TBEdit;
    BGBEmpresa: TBGridButton;
    BGBCliente: TBGridButton;
    LCliente: TLabel;
    LEmpresa: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    lblDesde: TLabel;
    edtDesde: TBEdit;
    btnDesde: TBCalendarButton;
    lblHasta: TLabel;
    edtHasta: TBEdit;
    btnHasta: TBCalendarButton;
    txtProducto: TStaticText;
    txtEnvase: TStaticText;
    edtEnvase: TBEdit;
    edtProducto: TBEdit;
    btnProducto: TBGridButton;
    btnEnvase: TBGridButton;
    lbl1: TLabel;
    lbl2: TLabel;
    procedure BBCancelarClick(Sender: TObject);
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonEmpresa(Sender: TObject);
    procedure edtClienteChange(Sender: TObject);
  private
    {private declarations}
    sEmpresa, sCliente, sProducto, sEnvase: string;
    dDesde, dHasta: TDateTime;

    function CamposVacios: boolean;
    function ExistenDatos: boolean;
    procedure Imprimir;


  public
    { Public declarations }

  end;


implementation


uses CVariables, UDMAuxDB, Principal, CAuxiliarDB, DPreview, UDMBaseDatos,
  LEnvasesCliente, bSQLUtils, CReportes;

{$R *.DFM}

procedure TFLEnvasesCliente.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Tag := kEmpresa;
  edtCliente.Tag := kCliente;
  edtProducto.Tag := kProducto;
  edtEnvase.Tag := kEnvase;

  edtDesde.Tag := kCalendar;
  edtHasta.Tag := kCalendar;

  edtEmpresa.Text := gsDefEmpresa;
  edtCliente.Text := '';
  edtProducto.Text := '';
  edtEnvase.Text := '';
  edtDesde.Text := DateToStr(Date);
  edtHasta.Text := DateToStr(Date);
  CalendarioFlotante.Date := Date;


  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;
end;

procedure TFLEnvasesCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BorrarTemporal('tmp_gastos_cli');

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

procedure TFLEnvasesCliente.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLEnvasesCliente.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

procedure TFLEnvasesCliente.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then
    Exit;

  if CamposVacios then
    Exit;

  try
    if ExistenDatos then
    begin
      Imprimir;
    end
    else
    begin
      ShowMessage('Sin datos');
    end;
  finally
    DMAuxDB.QAux.Close;
  end;
end;

procedure TFLEnvasesCliente.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCliente: DespliegaRejilla(BGBCliente, [edtEmpresa.Text]);
    kProducto: DespliegaRejilla(btnProducto, [edtEmpresa.Text]);
    kEnvase: DespliegaRejilla(btnEnvase, [edtEnvase.Text]);
    kCalendar: if ActiveControl = edtDesde then
                 DespliegaCalendario(btnDesde)
               else
                 DespliegaCalendario(btnHasta);

  end;
end;

procedure TFLEnvasesCliente.PonEmpresa(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  STEmpresa.Caption := desEmpresa(edtEmpresa.Text);
  edtClienteChange( edtCliente );
end;

function TFLEnvasesCliente.CamposVacios: boolean;
begin
  result := True;
  if STEmpresa.Caption = '' then
  begin
    ShowMessage('Falta el código de la empresa o es incorrecto.');
  end
  else
  if STCliente.Caption = '' then
  begin
    ShowMessage('Código de cliente incorrecto.');
  end
  else
  if txtProducto.Caption = '' then
  begin
    ShowMessage('Código de producto incorrecto.');
  end
  else
  if txtEnvase.Caption = '' then
  begin
    ShowMessage('Código de envase incorrecto.');
  end
  else
  if not TryStrToDate( edtDesde.Text, dDesde ) then
  begin
    ShowMessage('Fecha desde incorrecta.');
  end
  else
  if not TryStrToDate( edtHasta.Text, dHasta ) then
  begin
    ShowMessage('Fecha hasta incorrecta.');
  end
  else
  if dHasta < dDesde then
  begin
    ShowMessage('Rango de fechas incorrecto.');
  end
  else
  begin
    sEmpresa:= Trim( edtEmpresa.Text );
    sCliente:= Trim( edtCliente.Text );
    sProducto:= Trim( edtProducto.Text );
    sEnvase:= Trim( edtEnvase.Text );
    Result:= False;
  end;
end;

procedure TFLEnvasesCliente.Imprimir;
begin

  QRLEnvasesCliente := TQRLEnvasesCliente.Create(Application);
  QRLEnvasesCliente.qlTitulo.Caption:= QRLEnvasesCliente.qlTitulo.Caption + ' ' + DateToStr( dDesde );
  QRLEnvasesCliente.lblCliente.Caption := edtCliente.Text + ' ' + STCliente.caption;

  PonLogoGrupoBonnysa(QRLEnvasesCliente, edtEmpresa.text);

  try
    Preview(QRLEnvasesCliente);
  except
    FreeAndNil(QRLEnvasesCliente);
    raise;
  end;
end;

//Comprueba si en el periodo seleccionado el cliente ha trabajado con 2 monedas

function TFLEnvasesCliente.ExistenDatos: boolean;
begin
  with DMBaseDatos.QListado do
  begin
    //Comprobar que existan gastos
    SQl.Clear;
    SQl.Add(' select cliente_c cod_cliente, nombre_c cliente, ');

    SQl.Add('        ( select facturable_dc from frf_Envases_cliente ');
    SQl.Add('           where empresa_dc = :empresa ');
    SQl.Add('             and cliente_dc = cliente_c ');
    SQl.Add('             and :fecha between  fecha_ini_dc and nvl(fecha_fin_dc,Today) ');
    SQl.Add('        ) facturable, ');
    SQl.Add('        ( select no_fact_bruto_dc from frf_Envases_cliente ');
    SQl.Add('           where empresa_dc = :empresa ');
    SQl.Add('             and cliente_dc = cliente_c ');
    SQl.Add('             and :fecha between  fecha_ini_dc and nvl(fecha_fin_dc,Today) ');
    SQl.Add('        ) descuento, ');
    SQl.Add('        ( select comision_rc from frf_representantes_comision ');
    SQl.Add('          where representante_c = representante_rc ');
    SQl.Add('            and :fecha between  fecha_ini_rc and nvl(fecha_fin_rc,Today) ');
    SQl.Add('        ) comision, ');
    SQl.Add('        representante_c cod_representante, ');
    SQl.Add('        ( select descripcion_r from frf_representantes ');
    SQl.Add('          where representante_c = representante_r ');
    SQl.Add('        ) representante ');

    SQl.Add(' from frf_clientes ');
    SQl.Add(' where 1=1');

    if sCliente <> '' then
      SQl.Add(' and cliente_c = :cliente ');



    SQl.Add(' order by 1,2  ');

    if dHasta > Date then
      dHasta:= Date;
    ParamByName('empresa').AsString := gsDefEmpresa;
    ParamByName('fecha').AsDate:= dHasta;
    if sCliente <> '' then
      ParamByName('cliente').AsString:= sCliente;

    Open;
    Result:= not IsEmpty;
  end;
end;

procedure TFLEnvasesCliente.edtClienteChange(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  if edtCliente.Text = '' then
    STCliente.Caption:= 'TODOS LOS CLIENTES'
  else
    STCliente.Caption := desCliente(edtCliente.Text);
end;

end.
