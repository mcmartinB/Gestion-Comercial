unit SeleccionarClonarClienteFD;

interface

uses
  Forms, SysUtils, Classes, ActnList, ComCtrls, BCalendario, Grids,
  DBGrids, BGrid, StdCtrls, BEdit, BCalendarButton, BSpeedButton, Dialogs,
  BGridButton, Controls, Buttons, ExtCtrls, Windows, Messages, DBTables;

type
  TFDSeleccionarClonarCliente = class(TForm)
    Panel1: TPanel;
    GBEmpresa: TGroupBox;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    txtCliente: TStaticText;
    RejillaDespegable: TAction;
    RejillaFlotante: TBGrid;
    edtCliente: TBEdit;
    CalendarioFlotante: TBCalendario;
    rbNueva: TRadioButton;
    rbClonar: TRadioButton;
    lblNueva: TLabel;
    edtClienteNew: TBEdit;
    procedure BAceptarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PonNombre(Sender: TObject);
    procedure rbClonarClick(Sender: TObject);

  public
    bClonar: Boolean;

  end;

  function SeleccionarClonarCliente( var VOldCliente, VNewCliente: string ): Boolean;
  function ClonarCliente( const VOldCliente, VNewCliente: string; var sMsg: string ): Boolean;

implementation

uses UDMAuxDB, UDMBaseDatos, CVariables, Principal, CAuxiliarDB, CReportes,
  CGestionPrincipal, DError, UDMConfig, USincronizarTablas,
  SincronizacionBonny;

{$R *.DFM}

var
  FDSeleccionarClonarCliente: TFDSeleccionarClonarCliente;

function SeleccionarClonarCliente( var VOldCliente, VNewCliente: string ): Boolean;
begin
  Application.CreateForm(TFDSeleccionarClonarCliente, FDSeleccionarClonarCliente);
  try
    FDSeleccionarClonarCliente.bClonar:= False;
    FDSeleccionarClonarCliente.edtCliente.Text := VOldCliente;
    FDSeleccionarClonarCliente.edtClienteNew.Text := '';
    FDSeleccionarClonarCliente.ShowModal;
    Result:= FDSeleccionarClonarCliente.bClonar;
    if Result then
    begin
      VOldCliente:= FDSeleccionarClonarCliente.edtCliente.Text;
      VNewCliente:= FDSeleccionarClonarCliente.edtClienteNew.Text;
    end
    else
    begin
      VOldCliente:= '';
      VNewCliente:= '';
    end;
  finally
    FreeAndNil( FDSeleccionarClonarCliente );
  end;
end;

procedure TFDSeleccionarClonarCliente.BAceptarExecute(Sender: TObject);
begin
  bClonar:= rbClonar.Checked;
  if not CerrarForm(true) then Exit;
  if  bClonar then
  begin
      //Comprobar que todos los campos tienen valor
    if (trim(txtCliente.Caption) = '') or
       (trim(edtClienteNew.Text) = '')  then
    begin
       ShowError('Es necesario que rellene todos los campos de edición.');
       edtCliente.SetFocus;
    end
    else
    begin
      Close;
    end;
  end
  else
  begin
    Close;
  end;
end;

procedure TFDSeleccionarClonarCliente.FormCreate(Sender: TObject);
begin
  Top := 1;
  //FormType := tfOther;
  //BHFormulario;
  CalendarioFlotante.Date := Date;

  edtCliente.Tag := kCliente;

  gRF := rejillaFlotante;
  gCF := calendarioFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
end;

procedure TFDSeleccionarClonarCliente.FormClose(Sender: TObject;
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

procedure TFDSeleccionarClonarCliente.PonNombre(Sender: TObject);
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
      end;
  end;
end;

procedure TFDSeleccionarClonarCliente.FormKeyDown(Sender: TObject;
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

procedure TFDSeleccionarClonarCliente.rbClonarClick(Sender: TObject);
begin
  edtCliente.Enabled:= rbClonar.Checked;
  edtClienteNew.Enabled:= rbClonar.Checked;
  if rbClonar.Checked then
  begin
    edtCliente.SetFocus;
  end;
end;

function GrupoCliente( const AOldCliente, ANewCliente: string; var AGrupo: string ): boolean;
begin
//  DMBaseDatos.qryCabecera.DatabaseName:= DMBaseDatos.dbMaster.DatabaseName;
  DMBaseDatos.qryCabecera.SQL.Clear;
  DMBaseDatos.qryCabecera.SQL.Add(' select cliente_c from frf_clientes where cliente_c = :cliente ');


  DMBaseDatos.qryCabecera.ParamByName('cliente').AsString:= ANewCliente;
  DMBaseDatos.qryCabecera.Open;
  if not DMBaseDatos.qryCabecera.IsEmpty then
  begin
    Result:= false;
    AGrupo:= 'El cliente destino a clonar ya existe.';
    DMBaseDatos.qryCabecera.Close;
  end
  else
  begin
    DMBaseDatos.qryCabecera.Close;
    DMBaseDatos.qryCabecera.ParamByName('cliente').AsString:= AOldCliente;
    DMBaseDatos.qryCabecera.Open;
    if DMBaseDatos.qryCabecera.IsEmpty then
    begin
      Result:= False;
      AGrupo:= 'No encontrado cliente origen a clonar.';
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
        DMBaseDatos.qryDetalle.DatabaseName:= DMBaseDatos.dbBAG.DatabaseName;
      end
      else
      begin
        DMBaseDatos.qryCabecera.DatabaseName:= DMBaseDatos.dbSAT.DatabaseName;
        DMBaseDatos.qryDetalle.DatabaseName:= DMBaseDatos.dbSAT.DatabaseName;
}
      end;
    end;
end;

function LocalizaCliente( const AOldCliente: string ): boolean;
begin
  DMBaseDatos.qryCabecera.SQL.Clear;
  DMBaseDatos.qryCabecera.SQL.Add(' select * from frf_clientes where cliente_c = :cliente ');
  DMBaseDatos.qryCabecera.ParamByName('cliente').AsString:= AOldCliente;
  DMBaseDatos.qryCabecera.Open;

  if DMBaseDatos.qryCabecera.IsEmpty then
  begin
    Result:= False;
    DMBaseDatos.qryCabecera.Close;
  end
  else
  begin
    Result:= True;
  end;
end;

procedure PutRepresentante;
begin
  DMBaseDatos.QAux.SQL.Clear;
  DMBaseDatos.QAux.SQL.Add(' select * from frf_representantes where representante_r = :representante ');
  DMBaseDatos.QAux.ParamByName('representante').AsString:= DMBaseDatos.qryCabecera.FieldByName('representante_c').AsString;
  DMBaseDatos.QAux.Open;
  if DMBaseDatos.QAux.IsEmpty then
  begin
    DMBaseDatos.qryDetalle.SQL.Clear;
    DMBaseDatos.qryDetalle.SQL.Add(' select * from frf_representantes where representante_r = :representante ');
    DMBaseDatos.qryDetalle.ParamByName('representante').AsString:= DMBaseDatos.qryCabecera.FieldByName('representante_c').AsString;
    DMBaseDatos.qryDetalle.Open;
    while not DMBaseDatos.qryDetalle.Eof do
    begin
      ClonarRegistro( DMBaseDatos.qryDetalle, DMBaseDatos.QAux );
//      DMBaseDatos.QAux.FieldByName('empresa_r').AsString:= AEmpresa;
      DMBaseDatos.QAux.Post;

      DMBaseDatos.qryDetalle.Next;
    end;
    DMBaseDatos.qryDetalle.Close;
  end;
  DMBaseDatos.QAux.Close;
  (*TODO COMPROBAR QUE el representante es correcto *)
end;

procedure  PutSuministros( const ACliente: string );
var
  cliente_ds,
  dir_sum_ds: String;
begin
  DMBaseDatos.QAux.SQL.Clear;
  DMBaseDatos.QAux.SQL.Add(' select * from frf_dir_sum where cliente_ds = :cliente ');
  DMBaseDatos.QAux.ParamByName('cliente').AsString:= ACliente;
  DMBaseDatos.QAux.Open;
  if DMBaseDatos.QAux.IsEmpty then
  begin
    DMBaseDatos.qryDetalle.SQL.Clear;
    DMBaseDatos.qryDetalle.SQL.Add(' select * from frf_dir_sum where cliente_ds = :cliente ');
    DMBaseDatos.qryDetalle.ParamByName('cliente').AsString:= DMBaseDatos.qryCabecera.FieldByName('cliente_c').AsString;
    DMBaseDatos.qryDetalle.Open;
    while not DMBaseDatos.qryDetalle.Eof do
    begin
      ClonarRegistro( DMBaseDatos.qryDetalle, DMBaseDatos.QAux );
      DMBaseDatos.QAux.FieldByName('cliente_ds').AsString:= ACliente;
      DMBaseDatos.QAux.Post;

      cliente_ds := DMBaseDatos.QAux.FieldByName('cliente_ds').AsString;
      dir_sum_ds := DMBaseDatos.QAux.FieldByName('dir_sum_ds').AsString;
      SincroBonnyAurora.SincronizarDirSuministro(cliente_ds, dir_sum_ds);

      DMBaseDatos.qryDetalle.Next;
    end;
    DMBaseDatos.qryDetalle.Close;
  end;
  DMBaseDatos.QAux.Close;
end;

procedure  PutDescuentos( const ACliente: string );
var
  empresa_dc: String;
  cliente_dc: String;
  fecha_ini_dc: TDate;
begin
  DMBaseDatos.QAux.SQL.Clear;
  DMBaseDatos.QAux.SQL.Add(' select * from frf_descuentos_cliente where cliente_dc = :cliente ');
  DMBaseDatos.QAux.ParamByName('cliente').AsString:= ACliente;
  DMBaseDatos.QAux.Open;
  if DMBaseDatos.QAux.IsEmpty then
  begin
    DMBaseDatos.qryDetalle.SQL.Clear;
    DMBaseDatos.qryDetalle.SQL.Add(' select * from frf_descuentos_cliente where cliente_dc = :cliente ');
    DMBaseDatos.qryDetalle.ParamByName('cliente').AsString:= DMBaseDatos.qryCabecera.FieldByName('cliente_c').AsString;
    DMBaseDatos.qryDetalle.Open;
    while not DMBaseDatos.qryDetalle.Eof do
    begin
      ClonarRegistro( DMBaseDatos.qryDetalle, DMBaseDatos.QAux );
      DMBaseDatos.QAux.FieldByName('cliente_dc').AsString:= ACliente;
      DMBaseDatos.QAux.Post;

      empresa_dc := DMBaseDatos.QAux.FieldByName('empresa_dc').AsString;
      cliente_dc := DMBaseDatos.QAux.FieldByName('cliente_dc').AsString;
      fecha_ini_dc := DMBaseDatos.QAux.FieldByName('fecha_ini_dc').AsDateTime;
      SincroBonnyAurora.SincronizarDescuentoCliente(empresa_dc, cliente_dc, fecha_ini_dc);


      DMBaseDatos.qryDetalle.Next;
    end;
    DMBaseDatos.qryDetalle.Close;
  end;
  DMBaseDatos.QAux.Close;
end;


procedure  PutEnvases( const ACliente: string );
var
  empresa_ce,
  producto_ce,
  envase_ce,
  cliente_ce: String;
begin
  //Solamente BAG
//  if ( AEmpresa = DMBaseDatos.qryCabecera.FieldByName('empresa_c').AsString ) or
//     ( ( Copy( AEmpresa, 1, 1 ) = 'F' ) and ( Copy( DMBaseDatos.qryCabecera.FieldByName('empresa_c').AsString, 1, 1 ) = 'F' ) ) then
//  begin
    DMBaseDatos.QAux.SQL.Clear;
    DMBaseDatos.QAux.SQL.Add('  select * from frf_clientes_env where cliente_ce = :cliente ');
    DMBaseDatos.QAux.ParamByName('cliente').AsString:= ACliente;
    DMBaseDatos.QAux.Open;
    if DMBaseDatos.QAux.IsEmpty then
    begin
      DMBaseDatos.qryDetalle.SQL.Clear;
      DMBaseDatos.qryDetalle.SQL.Add(' select * from frf_clientes_env where cliente_ce = :cliente ');
      DMBaseDatos.qryDetalle.ParamByName('cliente').AsString:= DMBaseDatos.qryCabecera.FieldByName('cliente_c').AsString;
      DMBaseDatos.qryDetalle.Open;
      while not DMBaseDatos.qryDetalle.Eof do
      begin
        ClonarRegistro( DMBaseDatos.qryDetalle, DMBaseDatos.QAux );
        DMBaseDatos.QAux.FieldByName('cliente_ce').AsString:= ACliente;
        try
          //Puede ser que el envase no exista en la empresa destino, ignoramos
          DMBaseDatos.QAux.Post;

          empresa_ce := DMBaseDatos.QAux.FieldByName('empresa_ce').AsString;
          producto_ce := DMBaseDatos.QAux.FieldByName('producto_ce').AsString;
          envase_ce := DMBaseDatos.QAux.FieldByName('envase_ce').AsString;
          cliente_ce := DMBaseDatos.QAux.FieldByName('cliente_ce').AsString;
          SincroBonnyAurora.SincronizarUnidadFacturacion(empresa_ce, producto_ce, envase_ce, cliente_ce);


        except
          DMBaseDatos.QAux.Cancel;
        end;
        DMBaseDatos.qryDetalle.Next;
      end;
      DMBaseDatos.qryDetalle.Close;
    end;
    DMBaseDatos.QAux.Close;
//  end;
end;

procedure PutFormaPago( const ACliente: string);
begin
  DMBaseDatos.QAux.SQL.Clear;
  DMBaseDatos.QAux.SQL.Add('  select * from frf_clientes_tes where cliente_ct = :cliente ');
  DMBaseDatos.QAux.ParamByName('cliente').AsString:= ACliente;
  DMBaseDatos.QAux.Open;
  if DMBaseDatos.QAux.IsEmpty then
  begin
    DMBaseDatos.qryDetalle.SQL.Clear;
    DMBaseDatos.qryDetalle.SQL.Add(' select * from frf_clientes_tes where cliente_ct = :cliente ');
    DMBaseDatos.qryDetalle.ParamByName('cliente').AsString:= DMBaseDatos.qryCabecera.FieldByName('cliente_c').AsString;
    DMBaseDatos.qryDetalle.Open;
    while not DMBaseDatos.qryDetalle.Eof do
    begin
      ClonarRegistro( DMBaseDatos.qryDetalle, DMBaseDatos.QAux );
      DMBaseDatos.QAux.FieldByName('cliente_ct').AsString:= ACliente;
      try
        //Puede ser que el envase no exista en la empresa destino, ignoramos
        DMBaseDatos.QAux.Post;
      except
        DMBaseDatos.QAux.Cancel;
      end;
      DMBaseDatos.qryDetalle.Next;
    end;
    DMBaseDatos.qryDetalle.Close;
  end;
  DMBaseDatos.QAux.Close;
end;

procedure PutRiesgo( const ACliente: string);
begin
  DMBaseDatos.QAux.SQL.Clear;
  DMBaseDatos.QAux.SQL.Add('  select * from frf_clientes_rie where cliente_cr = :cliente ');
  DMBaseDatos.QAux.ParamByName('cliente').AsString:= ACliente;
  DMBaseDatos.QAux.Open;
  if DMBaseDatos.QAux.IsEmpty then
  begin
    DMBaseDatos.qryDetalle.SQL.Clear;
    DMBaseDatos.qryDetalle.SQL.Add(' select * from frf_clientes_rie where cliente_cr = :cliente ');
    DMBaseDatos.qryDetalle.ParamByName('cliente').AsString:= DMBaseDatos.qryCabecera.FieldByName('cliente_c').AsString;
    DMBaseDatos.qryDetalle.Open;
    while not DMBaseDatos.qryDetalle.Eof do
    begin
      ClonarRegistro( DMBaseDatos.qryDetalle, DMBaseDatos.QAux );
      DMBaseDatos.QAux.FieldByName('cliente_cr').AsString:= ACliente;
      try
        //Puede ser que el envase no exista en la empresa destino, ignoramos
        DMBaseDatos.QAux.Post;
      except
        DMBaseDatos.QAux.Cancel;
      end;
      DMBaseDatos.qryDetalle.Next;
    end;
    DMBaseDatos.qryDetalle.Close;
  end;
  DMBaseDatos.QAux.Close;
end;

procedure  PutCliente( const ACliente: string );
begin
    DMBaseDatos.QAux.SQL.Clear;
    DMBaseDatos.QAux.SQL.Add('  select * from frf_clientes where cliente_c = :cliente ');
    DMBaseDatos.QAux.ParamByName('cliente').AsString:= ACliente;
    DMBaseDatos.QAux.Open;
    if DMBaseDatos.QAux.IsEmpty then
    begin
      DMBaseDatos.qryDetalle.SQL.Clear;
      DMBaseDatos.qryDetalle.SQL.Add(' select * from frf_clientes where cliente_c = :cliente ');
      DMBaseDatos.qryDetalle.ParamByName('cliente').AsString:= DMBaseDatos.qryCabecera.FieldByName('cliente_c').AsString;
      DMBaseDatos.qryDetalle.Open;
      while not DMBaseDatos.qryDetalle.Eof do
      begin
        ClonarRegistro( DMBaseDatos.qryDetalle, DMBaseDatos.QAux );
        DMBaseDatos.QAux.FieldByName('cliente_c').AsString:= ACliente;
        DMBaseDatos.QAux.Post;
        SincroBonnyAurora.SincronizarCliente(ACliente);
        DMBaseDatos.qryDetalle.Next;
      end;
      DMBaseDatos.qryDetalle.Close;
    end;
    DMBaseDatos.QAux.Close;
end;


procedure CerrarTablas;
begin
  DMBaseDatos.qryCabecera.Close;
  DMBaseDatos.qryDetalle.Close;
  DMBaseDatos.qAux.Close;
end;

function ClonarCliente( const VOldCliente, VNewCliente: string; var sMsg: string ): Boolean;
var
  sGrupo: string;
begin
  CerrarTablas;

  with DMBaseDatos do
  begin
    if GrupoCliente( VOldCliente, VNewCliente, sGrupo ) then
    begin
      if LocalizaCliente( VOldCliente ) then
      begin
        DMBaseDatos.QAux.RequestLive:= True;
        try
          PutRepresentante;
          PutCliente( VNewCliente );
          PutSuministros( VNewCliente );
          PutDescuentos( VNewCliente );
          PutEnvases( VNewCliente );
          PutFormaPago( VNewCliente );
          PutRiesgo( VNewCliente );
          SincroBonnyAurora.Sincronizar;
        finally
          DMBaseDatos.QAux.RequestLive:= False;
        end;
        result:= True;
      end
      else
      begin
        sMsg:= 'No encontrado cliente origen a clonar';
        Result:= False;
      end;
    end
    else
    begin
      sMsg:= sGrupo;
      Result:= False;
    end;
  end;

  CerrarTablas;
end;

end.
