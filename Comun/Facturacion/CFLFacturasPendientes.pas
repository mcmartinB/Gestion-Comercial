unit CFLFacturasPendientes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, ComCtrls, DBCtrls, ActnList,
  BDEdit, BSpeedButton, BGridButton, Db,
  CGestionPrincipal, BEdit, Grids, DBGrids, BGrid,
  BCalendarButton, BCalendario, DError, DBTables, DPreview;

type
  TDFLFacturasPendientes = class(TForm)
    Panel1: TPanel;
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    RejillaDespegable: TAction;
    RejillaFlotante: TBGrid;
    eEmpresa: TBEdit;
    btnEmpresa: TBGridButton;
    stEmpresa: TStaticText;
    Label1: TLabel;
    Label3: TLabel;
    eCliente: TBEdit;
    btnCliente: TBGridButton;
    Label10: TLabel;
    ePais: TBEdit;
    btnPais: TBGridButton;
    Label11: TLabel;
    stCliente: TStaticText;
    stPais: TStaticText;
    Label2: TLabel;
    lblNombre1: TLabel;
    eFechaCobroIni: TBEdit;
    btnFechaCobroIni: TBCalendarButton;
    CalendarioFlotante: TBCalendario;
    eFechaCobroFin: TBEdit;
    btnFechaCobroFin: TBCalendarButton;
    lblNombre3: TLabel;
    chkExcluir: TCheckBox;
    btnEnviar: TButton;
    rgTesoreria: TRadioGroup;
    lblAnyadir: TLabel;
    txtListaCliente: TStaticText;
    btn1: TButton;
    btnLimpiar: TButton;
    lblTipoCliente: TLabel;
    edtTipoCliente: TBEdit;
    btnTipoCliente: TBGridButton;
    txtTipoCliente: TStaticText;
    chkTipoCliente: TCheckBox;
    lbl3: TLabel;
    cbbMercado: TComboBox;
    lbl6: TLabel;
    cbbFacAbonos: TComboBox;
    lblMoneda: TLabel;
    cbbMoneda: TComboBox;
    Label4: TLabel;
    eFechaFacturaIni: TBEdit;
    BCalendarButton1: TBCalendarButton;
    Label5: TLabel;
    eFechaFacturaFin: TBEdit;
    BCalendarButton2: TBCalendarButton;
    lbl1: TLabel;
    grpTipoListado: TGroupBox;
    rbLstSimple: TRadioButton;
    rbLstPedido: TRadioButton;
    rbLstBanco: TRadioButton;
    btnSII: TButton;
    procedure BCancelarExecute(Sender: TObject);
    procedure BAceptarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RejillaDespegableExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    function  EsParametrosOk: boolean;
    procedure eClienteChange(Sender: TObject);
    procedure ePaisChange(Sender: TObject);
    procedure eEmpresaChange(Sender: TObject);
    procedure chkSocomoClick(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure edtTipoClienteChange(Sender: TObject);

  private
    sEmpresa, sFechaFacturaIni, sFechaFacturaFin,  sFechaCobroIni, sFechaCobroFin, sCliente, sPais, sTipoCliente: String;
    dFechaFacturaIni, dFechaFacturaFin, dFechaCobroIni, dFechaCobroFin: TDateTime;
    bExcluirCliente, bExcluirTipoCliente, bMultiplesClientes: boolean;
    iTipo: Integer;

  public

  end;

var
  DFLFacturasPendientes: TDFLFacturasPendientes;

implementation

uses bDialogs, UDMBaseDatos, CVariables, Principal, CAuxiliarDB,
  UDMAuxDB, CMLFacturasPendientes, UDMConfig, CGlobal, DateUtils,
  UDMMaster, UFClientes;

{$R *.DFM}

procedure TDFLFacturasPendientes.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;
  eEmpresa.Tag := kEmpresa;
  eCliente.Tag := kCliente;
  edtTipoCliente.Tag := kTipoCliente;
  ePais.Tag := kPais;
  eFechaCobroIni.Tag:= kCalendar;
  eFechaCobroFin.Tag:= kCalendar;


  if gProgramVersion  = pvBAG then
    eEmpresa.Text := 'BAG'
  else
    eEmpresa.Text := 'SAT';

  STEmpresa.Caption := desEmpresa(eEmpresa.Text);
  eCliente.Text := '';
  STCliente.Caption := '';
  ePais.Text:= '';
  STPais.Caption := '';
  cbbMercado.ItemIndex:= 0;
  eFechaFacturaIni.Text:= FormatDateTime('dd/mm/yyyy', IncYear( Now, -2 ) );
  eFechaFacturaFin.Text:= FormatDateTime('dd/mm/yyyy', Now );
  eFechaCobroIni.Text:= FormatDateTime('dd/mm/yyyy', IncYear( Now, -2 ) );
  eFechaCobroFin.Text:= FormatDateTime('dd/mm/yyyy', Now );

  edtTipoCliente.Text:= 'IP';

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := nil;

  CalendarioFlotante.Date:= Date;

  CMLFacturasPendientes.UsarModuloDeDatos( self, DMBaseDatos.DBBaseDatos.DatabaseName );
end;

procedure TDFLFacturasPendientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  gRF := nil;
  gCF := nil;

  BEMensajes('');
  CMLFacturasPendientes.LiberarModuloDeDatos;
  Action := caFree;
end;

procedure TDFLFacturasPendientes.BCancelarExecute(Sender: TObject);
begin
  Close;
end;

procedure TDFLFacturasPendientes.BAceptarExecute(Sender: TObject);
begin
  //Datos del formulario correctos
  if EsParametrosOk then
  begin
    with CMLFacturasPendientes.DMLFacturasPendientes do
      if not Ejecutar( sEmpresa, sFechaFacturaIni, sFechaFacturaFin, sFechaCobroIni, sFechaCobroFin, cbbFacAbonos.ItemIndex,
                cbbMercado.ItemIndex, sCliente, sTipoCliente, sPais,
                rgTesoreria.ItemIndex = 1, bExcluirCliente, bExcluirTipoCliente, bMultiplesClientes, True, cbbMoneda.ItemIndex = 0, iTipo ) then
      begin
        ShowMessage('No hay facturas pendientes de cobro para los parametros pasados.');
      end;
  end;
end;

procedure TDFLFacturasPendientes.RejillaDespegableExecute(Sender: TObject);
var
  sAux: string;
begin
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kCliente:
    begin
      //DespliegaRejilla(btnCliente, [eEmpresa.Text]);
      sAux:= eCliente.Text;
      if SeleccionaClientes( self, eCliente, eEmpresa.Text, sAux ) then
      begin
        eCliente.Text:= sAux;
      end;
    end;
    kPais: DespliegaRejilla(btnPais);
    kCalendar: if eFechaCobroIni.Focused then
                 DespliegaCalendario(btnFechaCobroIni)
               else
                 DespliegaCalendario(btnFechaCobroFin);
    kTipoCliente:
    begin
      DespliegaRejilla(btnTipoCliente);
    end;
  end;
end;

procedure TDFLFacturasPendientes.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
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

function TDFLFacturasPendientes.EsParametrosOk: boolean;
begin
  Result := false;

  //Comprobar que el campo empresa tiene valor
  if (trim(eEmpresa.Text) = '') then
  begin
    ShowError('Es necesario que rellene el código de la empresa.');
    eEmpresa.Focused;
    Exit;
  end
  else
  begin
    //Comprobar que sea valido
    if stEmpresa.Caption = '' then
    begin
      ShowError('El código de la empresa no es correcto.');
      eEmpresa.Focused;
      Exit;
    end;
  end;
  sEmpresa:= eEmpresa.text;

  sFechaFacturaIni:= eFechaFacturaIni.Text;
  if sFechaFacturaIni <> '' then
  begin
    if not TryStrToDate( eFechaFacturaIni.Text, dFechaFacturaIni ) then
    begin
      ShowError('La fecha de factura inicial es incorrecta.');
      eFechaFacturaIni.Focused;
      Exit;
    end;
  end
  else
  begin
    ShowError('Falta la fecha de factura inicial.');
    eFechaFacturaIni.Focused;
    Exit;
  end;
  sFechaFacturafin:= eFechaFacturaFin.Text;
  if sFechaFacturafin <> '' then
  begin
    if not TryStrToDate( eFechaFacturaFin.Text, dFechaFacturaFin ) then
    begin
      ShowError('La fecha de factura final es incorrecta.');
      eFechaFacturaFin.Focused;
      Exit;
    end;
  end
  else
  begin
    ShowError('Falta la fecha de factura final.');
    eFechaFacturaIni.Focused;
    Exit;
  end;

  if dFechaFacturaIni > dFechaFacturaFin then
  begin
      ShowError('La fecha de factura inicial debe de ser inferior a la de factura final.');
      eFechaFacturaIni.Focused;
      Exit;
  end;


  sFechaCobroIni:= eFechaCobroIni.Text;
  if sFechaCobroIni <> '' then
  begin
    if not TryStrToDate( eFechaCobroIni.Text, dFechaCobroIni ) then
    begin
      ShowError('La fecha de cobro inicial es incorrecta.');
      eFechaCobroIni.Focused;
      Exit;
    end;
  end
  else
  begin
    ShowError('Falta la fecha de cobro inicial.');
    eFechaCobroIni.Focused;
    Exit;
  end;
  sFechaCobrofin:= eFechaCobroFin.Text;
  if sFechaCobrofin <> '' then
  begin
    if not TryStrToDate( eFechaCobroFin.Text, dFechaCobroFin ) then
    begin
      ShowError('La fecha de cobro final es incorrecta.');
      eFechaCobroFin.Focused;
      Exit;
    end;
  end
  else
  begin
    ShowError('Falta la fecha de cobro final.');
    eFechaCobroIni.Focused;
    Exit;
  end;

  if dFechaCobroIni > dFechaCobroFin then
  begin
      ShowError('La fecha de cobro inicial debe de ser inferior a la de cobro final.');
      eFechaCobroIni.Focused;
      Exit;
  end;

  //Comprobar que el cliente si tiene valor sea valido
  if (trim(eCliente.Text) <> '') then
  begin
    if stCliente.Caption = '' then
    begin
      ShowError('El código del cliente no es correcto.');
      eCliente.Focused;
      Exit;
    end;
  end;

  if txtListaCliente.Caption = '' then
  begin
    bMultiplesClientes:= False;
    if (trim(eCliente.Text) <> '') then
      sCliente:= eCliente.Text
    else
      sCliente:= '';
  end
  else
  begin
    bMultiplesClientes:= True;
    if (trim(eCliente.Text) = '') then
      sCliente:= txtListaCliente.Caption
    else
      sCliente:= txtListaCliente.Caption + ',' + QuotedStr( eCliente.Text );
  end;
  bExcluirCliente:= chkExcluir.Checked;

  //Comprobar que el tipo cliente si tiene valor sea valido
  if (trim(edtTipoCliente.Text) <> '') then
  begin
    if txtTipoCliente.Caption = '' then
    begin
      ShowError('El código del tipo cliente no es correcto.');
      edtTipoCliente.Focused;
      Exit;
    end;
  end;
  sTipoCliente:= edtTipoCliente.Text;
  bExcluirTipoCliente:= chkTipoCliente.Checked;

  //Comprobar que el pais si tiene valor sea valido
  if (trim(ePais.Text) <> '') then
  begin
    if stPais.Caption = '' then
    begin
      ShowError('El código del país no es correcto.');
      ePais.Focused;
      Exit;
    end;
    sPais:= ePais.Text;
  end
  else
  begin
    sPais:= '';
  end;

  if rbLstPedido.Checked then
    iTipo:= 1
  else
  if rbLstBanco.Checked then
    iTipo:= 2
  else
    iTipo:= 0;

  Result := true;
end;

procedure TDFLFacturasPendientes.eEmpresaChange(Sender: TObject);
begin
  IF eEmpresa.Text = 'SAT' then
  begin
    STEmpresa.Caption := 'SAT BONNYSA';
  end
  else
  begin
    STEmpresa.Caption := desEmpresa(eEmpresa.Text);
  end;
  eClienteChange(eCliente);
end;

procedure TDFLFacturasPendientes.eClienteChange(Sender: TObject);
begin
  if Trim( eCliente.Text ) <> '' then
    ePais.Text:= '';
  STCliente.Caption := desCliente(eCliente.Text);
end;

procedure TDFLFacturasPendientes.ePaisChange(Sender: TObject);
begin
  if Trim( ePais.Text ) <> '' then
    eCliente.Text:= '';
  STPais.Caption := desPais(ePais.Text);
end;

procedure TDFLFacturasPendientes.chkSocomoClick(Sender: TObject);
begin
(*
  if chkSocomo.Checked then
  begin
    eFechaCobroFin.Text:= FormatDateTime('dd/mm/yyyy', Now );
    eCliente.Text:= 'SOC';
  end;
*)
end;

procedure TDFLFacturasPendientes.btnEnviarClick(Sender: TObject);
begin
  //Datos del formulario correctos
  if EsParametrosOk then
  begin
    with CMLFacturasPendientes.DMLFacturasPendientes do
      if not Enviar( sEmpresa, sFechaFacturaIni, sFechaFacturaFin, sFechaCobroIni, sFechaCobroFin, cbbFacAbonos.ItemIndex,
                cbbMercado.ItemIndex, sCliente, sTipoCliente, sPais, bExcluirCliente, bExcluirTipoCliente,
                bMultiplesClientes, True, rgTesoreria.ItemIndex = 1, iTipo ) then
      begin
        ShowMessage('No hay facturas pendientes de cobro para los parametros pasados.');
      end;
  end;
end;

procedure TDFLFacturasPendientes.btn1Click(Sender: TObject);
begin
  if ( stCliente.Caption <> '' )  and ( eCliente.Text <> ''  ) then
  begin
    if Pos( eCliente.Text, txtListaCliente.Caption ) = 0 then
    begin
      if txtListaCliente.Caption = '' then
        txtListaCliente.Caption:= QuotedStr(eCliente.Text)
      else
        txtListaCliente.Caption:= txtListaCliente.Caption + ',' +QuotedStr(eCliente.Text);
    end;
  end;
end;

procedure TDFLFacturasPendientes.btnLimpiarClick(Sender: TObject);
begin
  txtListaCliente.Caption:= '';
end;

procedure TDFLFacturasPendientes.edtTipoClienteChange(Sender: TObject);
begin
  IF edtTipoCliente.Text = '' then
  begin
    txtTipoCliente.Caption := 'TODOS LOS TIPOS';
  end
  else
  begin
//    txtTipoCliente.Caption := UDMMaster.DMMaster.desTipoCliente(edtTipoCliente.Text );
    txtTipoCliente.Caption := desTipoCliente(edtTipoCliente.Text );
  end;
end;

end.
