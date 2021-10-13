unit ListadoRemesaCobroFL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, ComCtrls, DBCtrls, ActnList,
  BDEdit, BSpeedButton, BGridButton, Db,
  CGestionPrincipal, BEdit, Grids, DBGrids, BGrid,
  BCalendarButton, BCalendario, DError, DPreview, DBTables;

type
  TFLListadoRemesaCobro = class(TForm)
    panel1: TPanel;
    SBAceptar: TSpeedButton;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    RejillaDespegable: TAction;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    Label1: TLabel;
    eEmpresa: TBEdit;
    BGBEmpresa: TBGridButton;
    STEmpresa: TStaticText;
    stCliente: TStaticText;
    btnCliente: TBGridButton;
    eCliente: TBEdit;
    Label4: TLabel;
    Label5: TLabel;
    eFechaDesde: TBEdit;
    BCBFechaDesde: TBCalendarButton;
    stHastaFecha: TStaticText;
    eFechaHasta: TBEdit;
    BCBFechaHasta: TBCalendarButton;
    eFacturaHasta: TBEdit;
    stHastaFactura: TStaticText;
    eFacturaDesde: TBEdit;
    Label2: TLabel;
    lblBanco: TLabel;
    edtBanco: TBEdit;
    btnBanco: TBGridButton;
    txtBanco: TStaticText;
    lbl1: TLabel;
    lbl3: TLabel;
    btnCuentaBanco: TBGridButton;
    lblIban: TLabel;
    edtIban: TBDEdit;
    txtstcuenta: TStaticText;

    procedure BCancelarExecute(Sender: TObject);
    procedure BAceptarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RejillaDespegableExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure PonNombre(Sender: TObject);

  private
    sEmpresa, sCliente, sBanco, sCCC: string;
    iFactIni, iFactFin: Integer;
    dFechaIni, dFechaFin: TDateTime;
    bFactura, bFecha: Boolean;



    function  ValidarParametros: boolean;

  public

  end;

var
  FLListadoRemesaCobro: TFLListadoRemesaCobro;
implementation

uses UDMBaseDatos, CVariables, bDialogs, Principal, CAuxiliarDB,
  UDMAuxDB, bSQLUtils, bNumericUtils, UDMConfig, DConfigMail,
  GenerarRemesaCobroDL;


{$R *.DFM}

procedure TFLListadoRemesaCobro.BCancelarExecute(Sender: TObject);
begin
  if CerrarForm(false) then Close;
end;

procedure TFLListadoRemesaCobro.BAceptarExecute(Sender: TObject);
begin
  if ValidarParametros then
  begin
    GenerarRemesaCobroDL.GenerarRemesa( sEmpresa, sCliente, sBanco, sCCC,
                                        bFactura,iFactIni, iFactFin,
                                        bFecha,dFechaIni, dFechaFin );
  end;
end;

function IbanToCcc( const AIban: string ): string;
begin
  result:= Copy( AIban, 5, 20 );
end;

function TFLListadoRemesaCobro.ValidarParametros: boolean;
begin
  Result:= False;
  if STEmpresa.Caption = '' then
  begin
    eEmpresa.SetFocus;
    ShowMessage('Falta el codigó de la empresa o es incorrecto.');
  end
  else
  if txtBanco.Caption = '' then
  begin
    edtBanco.SetFocus;
    ShowMessage('Falta el codigó del banco o es incorrecto.');
  end
  else
  if txtstcuenta.Caption = '' then
  begin
    edtIban.SetFocus;
    ShowMessage('El IBAN de la cuenta de empresa es incorrecto.');
  end
  else
  if stCliente.Caption = '' then
  begin
    eCliente.SetFocus;
    ShowMessage('El codigó del cliente es incorrecto.');
  end
  else
  begin
    sEmpresa:= eEmpresa.Text;
    sBanco:= edtBanco.Text;
    sCCC:= IbanToCcc( txtstcuenta.Caption );
    sCliente:= Trim( eCliente.Text );

    if TryStrToDate( eFechaDesde.Text, dFechaIni ) then
    begin
      bFecha:= True;
      dFechaFin:= StrToDateDef( eFechaHasta.Text, dFechaIni );
    end
    else
    begin
      dFechaIni:= Date;
      dFechaFin:= dFechaIni;
      bFecha:= False;
    end;

    if TryStrToInt( eFacturaDesde.Text, iFactIni ) then
    begin
      bFactura:= True;
      iFactFin:= StrToIntDef( eFacturaHasta.Text, iFactIni );
    end
    else
    begin
      iFactIni:= 0;
      iFactFin:= 0;
      bFactura:= False;
    end;

    Result:= True;
  end;
end;

procedure TFLListadoRemesaCobro.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;
  CalendarioFlotante.Date := Date;
  eEmpresa.Tag := kEmpresa;
  eCliente.Tag := kCliente;
  edtBanco.Tag := kBancoEx;
  edtIban.Tag := kCuentaBanco;
  eFechaDesde.Tag := kCalendar;
  eFechaHasta.Tag := kCalendar;

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  eEmpresa.Text := '';
  edtBanco.Text := '';
  edtIban.Text := '';

  eCliente.Text:= '';
  eFacturadesde.Text := '';
  eFacturahasta.Text := '';
  eFechaDesde.Text := '';
  eFechaHasta.Text := '';
end;

procedure TFLListadoRemesaCobro.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
     //Limpiar;
  CanClose := true;
end;

procedure TFLListadoRemesaCobro.FormClose(Sender: TObject;
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
  Action := caFree;
end;

procedure TFLListadoRemesaCobro.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;

  case TEdit( Sender ).Tag of
    kEmpresa:
    begin
      stEmpresa.Caption:= desEmpresa( eEmpresa.Text );
      PonNombre( edtBanco );
      PonNombre( eCliente );
    end;
    kBancoEx:
    begin
      txtBanco.Caption:= desBancoEx( eEmpresa.Text, edtBanco.Text );
      txtstcuenta.Caption:= desCuentaBanco( eEmpresa.Text, edtBanco.Text, edtIban.Text );
    end;
    kCuentaBanco:
      txtstcuenta.Caption:= desCuentaBanco( eEmpresa.Text, edtBanco.Text, edtIban.Text );
    kCliente:
      if eCliente.Text = '' then
      begin
        stCliente.Caption:= 'Todos los clientes'
      end
      else
      begin
        if eEmpresa.Text = 'BAG' then
          stCliente.Caption:= desClienteBAG( eCliente.Text )
        else
          stCliente.Caption:= desCliente( eEmpresa.Text, eCliente.Text );
      end;
  end;
end;

procedure TFLListadoRemesaCobro.FormKeyDown(Sender: TObject;
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

procedure TFLListadoRemesaCobro.RejillaDespegableExecute(
  Sender: TObject);
begin

  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kBancoEx: DespliegaRejilla(btnBanco,[eEmpresa.Text]);
    kCuentaBanco: DespliegaRejilla(btnCuentaBanco,[eEmpresa.Text,edtBanco.Text]);
    kCliente: DespliegaRejilla(btnCliente,[eEmpresa.Text]);
    kCalendar:
      begin
        if eFechaDesde.Focused then
          DespliegaCalendario(BCBFechaDesde)
        else
          DespliegaCalendario(BCBFechaHasta);
      end;
  end;
end;


end.
