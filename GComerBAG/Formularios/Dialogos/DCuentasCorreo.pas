unit DCuentasCorreo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs
  , Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  BCalendarButton, ComCtrls, BCalendario, BEdit, DError, DBTables;

type
  TFDCuentasCorreo = class(TForm)
    PMaestro: TPanel;
    lblCuentas: TLabel;
    lblCuentaActiva: TLabel;
    desCuentaActiva: TLabel;
    cbxCuentas: TComboBox;
    btnCerrar: TBitBtn;
    btnAplicar: TBitBtn;
    btnEditar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCerrarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnAplicarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cbxCuentasChange(Sender: TObject);

  private
    { Private declarations }
    function  CuentaActiva: Integer;
    procedure CargarDatosCuentas( const ACuentaVisible: integer );
    function  GetIndiceCuenta( const ADesCuenta: string ): integer;

  public
    { Public declarations }
    iCuentaVisible: integer;
  end;

implementation

uses CVariables, CGestionPrincipal, UDMBaseDatos, CReportes, MCuentasCorreo,
  CAuxiliarDB, Principal, DPreview, bSQLUtils, Variants;

{$R *.DFM}

//************************** CREAMOS EL FORMULARIO ************************

procedure TFDCuentasCorreo.FormCreate(Sender: TObject);
begin
  M := nil;
  MD := nil;

  FormType := tfOther;
  BHFormulario;

  iCuentaVisible:= CuentaActiva;

end;

procedure TFDCuentasCorreo.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFDCuentasCorreo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    //               y entre los Campos de Búsqueda en la localización
  case key of
    vk_Return, vk_down:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
      end;
    vk_up:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
      end;
  end;
end;

function TFDCuentasCorreo.CuentaActiva: Integer;
begin
  result:= -1;
  desCuentaActiva.Caption:= 'Sin cuenta de correo activa.';
  with DMBaseDatos.QAux do
  begin
    //SACAMOS CUENTA ACTIVA PARA EL USUARIO
    SQL.Clear;
    SQL.Add('select cuenta_correo_cu from cnf_usuarios where usuario_cu = :usuario ');
    ParamByName('usuario').AsString:= gsCodigo;
    Open;
    if FieldByName('cuenta_correo_cu').Value <> NULL then
    begin
      result:= FieldByName('cuenta_correo_cu').AsInteger;
      //SACAMOS LA DESCRIPCION DE LA CUENTA
      Close;
      SQL.Clear;
      SQL.Add('select descripcion_ccc from cnf_cuentas_correo where codigo_ccc = :cuenta ');
      ParamByName('cuenta').AsInteger:= result;
      Open;
      if not IsEmpty then
      begin
        desCuentaActiva.Caption:= IntToStr( result ) + '- ' + FieldByName('descripcion_ccc').AsString;
      end;
    end;
    Close;
  end;
end;

procedure TFDCuentasCorreo.CargarDatosCuentas( const ACuentaVisible: integer );
var
  iAux: integer;
  bFlag: boolean;
begin
  cbxCuentas.Clear;
  with DMBaseDatos.QAux do
  begin
    //RELLENAMOS COMBO
    SQL.Clear;
    SQL.Add('select codigo_ccc, descripcion_ccc from cnf_cuentas_correo order by codigo_ccc ');
    Open;
    while not EOF do
    begin
      cbxCuentas.Items.Add( FieldByName('codigo_ccc').AsString + '- ' + FieldByName('descripcion_ccc').AsString );
      Next;
    end;
    Close;

    iAux:= 0;
    bFlag:= false;
    while ( iAux < cbxCuentas.Items.Count ) and not bFlag do
    begin
       if GetIndiceCuenta( cbxCuentas.Items[iAux] ) = ACuentaVisible then
       begin
         bFlag:= True;
       end
       else
       begin
         iAux:= iAux + 1;
       end;
    end;
    cbxCuentas.ItemIndex:= iAux;
  end;
end;

procedure TFDCuentasCorreo.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFDCuentasCorreo.btnEditarClick(Sender: TObject);
begin
  TFMCuentasCorreo.Create(Self).ActivarCuenta( iCuentaVisible );
  self.Enabled := false;
end;

function TFDCuentasCorreo.GetIndiceCuenta( const ADesCuenta: string ): integer;
var
  iPos: integer;
  sAux: string;
begin
  iPos:= Pos( '-', ADesCuenta );
  sAux:= Copy( ADesCuenta, 1, iPos - 1 );
  result:= StrToIntDEf( sAux, 1 );
end;

procedure TFDCuentasCorreo.btnAplicarClick(Sender: TObject);
var
  iCuenta: integer;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add('update cnf_usuarios set cuenta_correo_cu = :cuenta where usuario_cu = :usuario ');
    ParamByName('usuario').AsString:= gsCodigo;
    iCuenta:= GetIndiceCuenta( cbxCuentas.Items[cbxCuentas.itemIndex] );
    ParamByName('cuenta').AsInteger:= iCuenta;
    ExecSQL;
    desCuentaActiva.Caption:= cbxCuentas.Text;

    SQL.Clear;
    SQL.Add( ' select * from cnf_cuentas_correo where codigo_ccc = :cuenta' );
    ParamByName('cuenta').AsInteger:= iCuenta;
    try
      Open;
      gsHostCorreo:= FieldByName('smtp_ccc').AsString;
      gsUsarioCorreo:= FieldByName('identificador_ccc').AsString;
      gsClaveCorreo:= FieldByName('clave_ccc').AsString;
    finally
      Close;
    end;
  end;
end;

procedure TFDCuentasCorreo.FormActivate(Sender: TObject);
begin
  CuentaActiva;
  CargarDatosCuentas( iCuentaVisible );
end;

procedure TFDCuentasCorreo.cbxCuentasChange(Sender: TObject);
begin
  iCuentaVisible:= GetIndiceCuenta( cbxCuentas.Items[cbxCuentas.itemIndex] );
end;

end.
