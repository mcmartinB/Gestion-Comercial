unit SeleccionarClonarSuministroFD;

interface

uses
  Forms, SysUtils, Classes, ActnList, ComCtrls, BCalendario, Grids,
  DBGrids, BGrid, StdCtrls, BEdit, BCalendarButton, BSpeedButton, Dialogs,
  BGridButton, Controls, Buttons, ExtCtrls, Windows, Messages, DBTables;

type
  TFDSeleccionarClonarSuministro = class(TForm)
    Panel1: TPanel;
    GBEmpresa: TGroupBox;
    Label3: TLabel;
    SpeedButton1: TSpeedButton;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    txtCliente: TStaticText;
    btnCliente: TBGridButton;
    RejillaDespegable: TAction;
    RejillaFlotante: TBGrid;
    edtCliente: TBEdit;
    CalendarioFlotante: TBCalendario;
    rbNueva: TRadioButton;
    rbClonar: TRadioButton;
    lblSuministro: TLabel;
    edtSuministro: TBEdit;
    btnSuministro: TBGridButton;
    txtSuministro: TStaticText;
    lblNueva: TLabel;
    edtCodigo: TBEdit;
    edtClienteOld: TBEdit;
    procedure BAceptarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RejillaDespegableExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PonNombre(Sender: TObject);
    procedure rbClonarClick(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);

  public
    bClonar: Boolean;

  end;

  function SeleccionarClonarSuministro( var VEmpresa, VCliente, VSuministro, VCodigo: string ): Boolean;
  function ClonarSuministro( const VOldEmpresa, VOldCliente, VOldSuministro, VNewEmpresa, VNewCliente, VNewSuministro: string; var sMsg: string ): Boolean;

implementation

uses UDMAuxDB, UDMBaseDatos, CVariables, Principal, CAuxiliarDB, CReportes,
  CGestionPrincipal, DError, UDMConfig, USincronizarTablas, UDMMaster, CGlobal,
  SincronizacionBonny;

{$R *.DFM}

var
  FDSeleccionarClonarSuministro: TFDSeleccionarClonarSuministro;

function SeleccionarClonarSuministro( var VEmpresa, VCliente, VSuministro, VCodigo: string ): Boolean;
begin
  Application.CreateForm(TFDSeleccionarClonarSuministro, FDSeleccionarClonarSuministro);
  try
    FDSeleccionarClonarSuministro.bClonar:= False;
    FDSeleccionarClonarSuministro.edtCliente.Text := VCliente;
    FDSeleccionarClonarSuministro.edtClienteOld.Text := VCliente;
    FDSeleccionarClonarSuministro.edtSuministro.Text := VSuministro;
    FDSeleccionarClonarSuministro.edtCodigo.Text:= VCodigo;
    FDSeleccionarClonarSuministro.ShowModal;
    Result:= FDSeleccionarClonarSuministro.bClonar;
    if Result then
    begin
      VEmpresa:= gsDefEmpresa;
      VCliente:= FDSeleccionarClonarSuministro.edtCliente.Text;
      VSuministro:= FDSeleccionarClonarSuministro.edtSuministro.Text;
      VCodigo:= FDSeleccionarClonarSuministro.edtCodigo.Text;
    end
    else
    begin
      VEmpresa:= '';
      VCliente:= '';
      VSuministro:= '';
    end;
  finally
    FreeAndNil( FDSeleccionarClonarSuministro );
  end;
end;

procedure TFDSeleccionarClonarSuministro.BAceptarExecute(Sender: TObject);
begin
  bClonar:= rbClonar.Checked;
  if not CerrarForm(true) then Exit;
  if  bClonar then
  begin
      //Comprobar que todos los campos tienen valor
    if (trim(txtCliente.Caption) = '') or
       (trim(txtSuministro.Caption) = '') or
       (trim(edtCodigo.Text) = '')  then
    begin
       ShowError('Es necesario que rellene todos los campos de edición.');
       edtCliente.SetFocus;
    end
    else
    begin
      if Length(edtCodigo.Text) <> 3 then
      begin
        ShowError('El código de sumnistro debe de ser de tres caracteres.');
        edtCodigo.SetFocus;
      end
      else
      begin
        Close;
      end;
    end;
  end
  else
  begin
    Close;
  end;
end;

procedure TFDSeleccionarClonarSuministro.FormCreate(Sender: TObject);
begin
  Top := 1;
  //FormType := tfOther;
  //BHFormulario;
  CalendarioFlotante.Date := Date;

  edtCliente.Tag := kCliente;
  edtSuministro.Tag := kSuministro;

  gRF := rejillaFlotante;
  gCF := calendarioFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
end;

procedure TFDSeleccionarClonarSuministro.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //if FPrincipal.MDIChildCount = 1 then
  //begin
    //FormType := tfDirector;
    //BHFormulario;
  //end/;
  gRF := nil;
  gCF := nil;
  Action := caFree;
end;

procedure TFDSeleccionarClonarSuministro.RejillaDespegableExecute(
  Sender: TObject);
begin
  case ActiveControl.Tag of
    kCliente: DespliegaRejilla(btnCliente);
    kSuministro: DespliegaRejilla(btnSuministro, [edtcliente.Text]);
  end;
end;

procedure TFDSeleccionarClonarSuministro.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kCliente:
      begin
        txtCliente.Caption := desCliente(edtCliente.Text);
        PonNombre( edtSuministro );
      end;
    kSuministro:
      begin
        txtSuministro.Caption := desSuministro(gsDefEmpresa, edtCliente.Text, edtSuministro.Text);
      end;
  end;
end;

procedure TFDSeleccionarClonarSuministro.FormKeyDown(Sender: TObject;
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

procedure TFDSeleccionarClonarSuministro.rbClonarClick(Sender: TObject);
begin
  edtCliente.Enabled:= rbClonar.Checked;
  edtSuministro.Enabled:= rbClonar.Checked;
  edtCodigo.Enabled:= rbClonar.Checked;
  btnCliente.Enabled:= rbClonar.Checked;
  btnSuministro.Enabled:= rbClonar.Checked;
  if rbClonar.Checked then
  begin
    edtCliente.SetFocus;
  end;
end;

procedure TFDSeleccionarClonarSuministro.edtCodigoEnter(Sender: TObject);
begin
  if edtCodigo.Text = '' then
  begin
    edtCodigo.Text:= edtSuministro.Text;
  end;
end;

function GrupoSuministro( const AOldEmpresa, AOldCliente, AOldSuministro, ANewEmpresa, ANewCliente, ANewSuministro: string; var AGrupo: string ): boolean;
begin
//  DMBaseDatos.qryCabecera.DatabaseName:= DMBaseDatos.dbMaster.DatabaseName;
  DMBaseDatos.qryCabecera.SQL.Clear;
  DMBaseDatos.qryCabecera.SQL.Add('select nombre_ds ');
  DMBaseDatos.qryCabecera.SQL.Add('from frf_dir_sum ');
  DMBaseDatos.qryCabecera.SQL.Add('     join frf_clientes on cliente_ds = cliente_c ');
  DMBaseDatos.qryCabecera.SQL.Add('      where cliente_ds= :cliente and dir_sum_ds= :suministro ');

  DMBaseDatos.qryCabecera.ParamByName('cliente').AsString:= ANewCliente;
  DMBaseDatos.qryCabecera.ParamByName('suministro').AsString:= ANewSuministro;

  DMBaseDatos.qryCabecera.Open;
  if not DMBaseDatos.qryCabecera.IsEmpty then
  begin
    Result:= false;
    AGrupo:= 'El suministro destino a clonar ya existe.';
    DMBaseDatos.qryCabecera.Close;
  end
  else
  begin
    DMBaseDatos.qryCabecera.Close;
    DMBaseDatos.qryCabecera.ParamByName('cliente').AsString:= AOldCliente;
    DMBaseDatos.qryCabecera.ParamByName('suministro').AsString:= AOldSuministro;
    DMBaseDatos.qryCabecera.Open;
    if DMBaseDatos.qryCabecera.IsEmpty then
    begin
      Result:= False;
      AGrupo:= 'No encontrado suministro origen a clonar.';
      DMBaseDatos.qryCabecera.Close;
    end
    else
    begin
      Result:= True;
{
      AGrupo:= DMBaseDatos.qryCabecera.FieldByName('grupo_c').AsString;
      DMBaseDatos.qryCabecera.Close;
      if AGrupo = 'BAG' then
      begin
        DMBaseDatos.qryCabecera.DatabaseName:= DMBaseDatos.dbBAG.DatabaseName;
      end
      else
      begin
        DMBaseDatos.qryCabecera.DatabaseName:= DMBaseDatos.dbSAT.DatabaseName;
      end;
}
    end;
  end;
end;

function LocalizaSuministro( const AOldEmpresa, AOldCliente, AOldSuministro: string ): boolean;
begin
  DMBaseDatos.qryCabecera.SQL.Clear;
  DMBaseDatos.qryCabecera.SQL.Add(' select * from frf_dir_sum where cliente_ds = :cliente and dir_sum_ds = :suministro ');
  DMBaseDatos.qryCabecera.ParamByName('cliente').AsString:= AOldCliente;
  DMBaseDatos.qryCabecera.ParamByName('suministro').AsString:= AOldSuministro;
  DMBaseDatos.qryCabecera.Open;

  if DMBaseDatos.qryCabecera.IsEmpty then
  begin
    Result:= False;
    DMBaseDatos.qryCabecera.Close;
  end
  else
  begin
    Result:= True;
    DMBaseDatos.QGeneral.SQL.Clear;
    DMBaseDatos.QGeneral.SQL.Add(' select * from frf_dir_sum where cliente_ds = :cliente and dir_sum_ds = :suministro ');
    DMBaseDatos.QGeneral.ParamByName('cliente').AsString:= AOldCliente;
    DMBaseDatos.QGeneral.ParamByName('suministro').AsString:= AOldSuministro;
    DMBaseDatos.QGeneral.Open;
  end;
end;


function ClonarSuministro( const VOldEmpresa, VOldCliente, VOldSuministro, VNewEmpresa, VNewCliente, VNewSuministro: string; var sMsg: string ): Boolean;
var
  bAux: Boolean;
  sGrupo: string;
begin
  with DMBaseDatos do
  begin
    if GrupoSuministro( VOldEmpresa, VOldCliente, VOldSuministro, VNewEmpresa, VNewCliente, VNewSuministro, sGrupo ) then
    begin
      bAux:= QGeneral.RequestLive;
      QGeneral.RequestLive:= True;

      if LocalizaSuministro(VOldEmpresa, VOldCliente, VOldSuministro ) then
      begin
        ClonarRegistro( DMBaseDatos.qryCabecera, QGeneral );
        QGeneral.FieldByName('cliente_ds').AsString:= VNewCliente;
        QGeneral.FieldByName('dir_sum_ds').AsString:= VNewSuministro;
        QGeneral.Post;

        SincroBonnyAurora.SincronizarDirSuministro(
          QGeneral.FieldByName('cliente_ds').AsString,
          QGeneral.FieldByName('dir_sum_ds').AsString);
        SincroBonnyAurora.Sincronizar;

        Result:= True;
      end
      else
      begin
        sMsg:= 'La clave del suministro a clonar ya existe.';
        Result:= False;
      end;
      QGeneral.Close;
      QGeneral.RequestLive:= bAux;
    end
    else
    begin
      sMsg:= 'No encontrado suministro a clonar';
      Result:= False;
    end;
    qryCabecera.Close;
  end;
end;

end.
