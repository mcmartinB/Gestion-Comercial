unit SeleccionarClonarProveedorFD;

interface

uses
  Forms, SysUtils, Classes, ActnList, ComCtrls, BCalendario, Grids,
  DBGrids, BGrid, StdCtrls, BEdit, BCalendarButton, BSpeedButton, Dialogs,
  BGridButton, Controls, Buttons, ExtCtrls, Windows, Messages, DBTables;

type
  TFDSeleccionarClonarProveedor = class(TForm)
    Panel1: TPanel;
    GBEmpresa: TGroupBox;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    txtProveedor: TStaticText;
    RejillaDespegable: TAction;
    RejillaFlotante: TBGrid;
    edtProveedor: TBEdit;
    CalendarioFlotante: TBCalendario;
    rbNueva: TRadioButton;
    rbClonar: TRadioButton;
    lblNueva: TLabel;
    edtProveedorNew: TBEdit;
    procedure BAceptarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PonNombre(Sender: TObject);
    procedure rbClonarClick(Sender: TObject);

    function ObtenerCodigoProveedor: string;


  public
    bClonar: Boolean;

  end;

  function SeleccionarClonarProveedor( var VOldProveedor, VNewProveedor: string ): Boolean;
  function ClonarProveedor( const VOldProveedor, VNewProveedor: string; var sMsg: string ): Boolean;

implementation

uses UDMAuxDB, UDMBaseDatos, CVariables, Principal, CAuxiliarDB, CReportes,
  CGestionPrincipal, DError, UDMConfig, USincronizarTablas;

{$R *.DFM}

var
  FDSeleccionarClonarProveedor: TFDSeleccionarClonarProveedor;

function SeleccionarClonarProveedor( var VOldProveedor, VNewProveedor: string ): Boolean;
begin
  Application.CreateForm(TFDSeleccionarClonarProveedor, FDSeleccionarClonarProveedor);
  try
    FDSeleccionarClonarProveedor.bClonar:= False;
    FDSeleccionarClonarProveedor.edtProveedor.Text := VOldProveedor;
    FDSeleccionarClonarProveedor.edtProveedorNew.Text := '';
    FDSeleccionarClonarProveedor.ShowModal;
    Result:= FDSeleccionarClonarProveedor.bClonar;
    if Result then
    begin
      VOldProveedor:= FDSeleccionarClonarProveedor.edtProveedor.Text;
      VNewProveedor:= FDSeleccionarClonarProveedor.edtProveedorNew.Text;
    end
    else
    begin
      VOldProveedor:= '';
      VNewProveedor:= '';
    end;
  finally
    FreeAndNil( FDSeleccionarClonarProveedor );
  end;
end;

procedure TFDSeleccionarClonarProveedor.BAceptarExecute(Sender: TObject);
begin
  bClonar:= rbClonar.Checked;
  if not CerrarForm(true) then Exit;
  if  bClonar then
  begin
      //Comprobar que todos los campos tienen valor
      if (trim(edtProveedor.Text) = '') or
         (trim(edtProveedorNew.Text) = '')  then
      begin
         ShowError('Es necesario que rellene todos los campos de edición.');
         edtProveedor.SetFocus;
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

procedure TFDSeleccionarClonarProveedor.FormCreate(Sender: TObject);
begin
  Top := 1;
  //FormType := tfOther;
  //BHFormulario;
  CalendarioFlotante.Date := Date;

  edtProveedor.Tag := kProveedor;

  gRF := rejillaFlotante;
  gCF := calendarioFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
end;

procedure TFDSeleccionarClonarProveedor.FormClose(Sender: TObject;
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

procedure TFDSeleccionarClonarProveedor.PonNombre(Sender: TObject);
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
        PonNombre( edtProveedor );
      end;
    kProveedor:
      begin
        txtProveedor.Caption := desProveedor('', edtProveedor.Text);
      end;
  end;
end;

procedure TFDSeleccionarClonarProveedor.FormKeyDown(Sender: TObject;
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

function TFDSeleccionarClonarProveedor.ObtenerCodigoProveedor: string;
var iProveedor: Integer;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select max(proveedor_p) proveedor from frf_proveedores ');

    Open;
    if IsEmpty then
      iProveedor := 1
    else
    begin
      iProveedor := fieldbyname('proveedor').AsInteger + 1;
    end;

    Result := IntToStr(iProveedor);

    Close;
  end;
end;

procedure TFDSeleccionarClonarProveedor.rbClonarClick(Sender: TObject);
begin
  edtProveedor.Enabled:= rbClonar.Checked;
  edtProveedorNew.Text := ObtenerCodigoProveedor;
  if rbClonar.Checked then
  begin
    edtProveedor.SetFocus;
  end;
end;


function LocalizaProveedor( const AOldProveedor: string ): boolean;
begin
  DMBaseDatos.qryCabecera.SQL.Clear;
  DMBaseDatos.qryCabecera.SQL.Add(' select * from frf_Proveedores where Proveedor_p = :Proveedor ');
  DMBaseDatos.qryCabecera.ParamByName('Proveedor').AsString:= AOldProveedor;
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


procedure  PutAlmacenes( const AProveedor: string );
begin
  DMBaseDatos.QAux.SQL.Clear;
  DMBaseDatos.QAux.SQL.Add(' select * from frf_proveedores_almacen where Proveedor_pa = :Proveedor ');
  DMBaseDatos.QAux.ParamByName('Proveedor').AsString:= AProveedor;
  DMBaseDatos.QAux.Open;
  if DMBaseDatos.QAux.IsEmpty then
  begin
    DMBaseDatos.qryDetalle.SQL.Clear;
    DMBaseDatos.qryDetalle.SQL.Add(' select * from frf_proveedores_almacen where Proveedor_pa = :Proveedor ');
    DMBaseDatos.qryDetalle.ParamByName('Proveedor').AsString:= DMBaseDatos.qryCabecera.FieldByName('Proveedor_p').AsString;
    DMBaseDatos.qryDetalle.Open;
    while not DMBaseDatos.qryDetalle.Eof do
    begin
      ClonarRegistro( DMBaseDatos.qryDetalle, DMBaseDatos.QAux );
      DMBaseDatos.QAux.FieldByName('Proveedor_pa').AsString:= AProveedor;
      DMBaseDatos.QAux.Post;

      DMBaseDatos.qryDetalle.Next;
    end;
    DMBaseDatos.qryDetalle.Close;
  end;
  DMBaseDatos.QAux.Close;
end;

procedure  PutEnvases( const AProveedor: string );
begin
  //Solamente BAG
//  if ( AEmpresa = DMBaseDatos.qryCabecera.FieldByName('empresa_p').AsString ) or
//     ( ( Copy( AEmpresa, 1, 1 ) = 'F' ) and ( Copy( DMBaseDatos.qryCabecera.FieldByName('empresa_p').AsString, 1, 1 ) = 'F' ) ) then
//  begin
    DMBaseDatos.QAux.SQL.Clear;
    DMBaseDatos.QAux.SQL.Add('  select * from frf_productos_proveedor where Proveedor_pp = :Proveedor ');
    DMBaseDatos.QAux.ParamByName('Proveedor').AsString:= AProveedor;
    DMBaseDatos.QAux.Open;
    if DMBaseDatos.QAux.IsEmpty then
    begin
      DMBaseDatos.qryDetalle.SQL.Clear;
      DMBaseDatos.qryDetalle.SQL.Add(' select * from frf_productos_proveedor where Proveedor_pp = :Proveedor ');
      DMBaseDatos.qryDetalle.ParamByName('Proveedor').AsString:= DMBaseDatos.qryCabecera.FieldByName('Proveedor_p').AsString;
      DMBaseDatos.qryDetalle.Open;
      while not DMBaseDatos.qryDetalle.Eof do
      begin
        ClonarRegistro( DMBaseDatos.qryDetalle, DMBaseDatos.QAux );
        DMBaseDatos.QAux.FieldByName('Proveedor_pp').AsString:= AProveedor;
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
//  end;
end;

procedure  PutProveedor( const AProveedor: string );
begin
    DMBaseDatos.QAux.SQL.Clear;
    DMBaseDatos.QAux.SQL.Add('  select * from frf_Proveedores where Proveedor_p = :Proveedor ');
    DMBaseDatos.QAux.ParamByName('Proveedor').AsString:= AProveedor;
    DMBaseDatos.QAux.Open;
    if DMBaseDatos.QAux.IsEmpty then
    begin
      DMBaseDatos.qryDetalle.SQL.Clear;
      DMBaseDatos.qryDetalle.SQL.Add(' select * from frf_Proveedores where Proveedor_p = :Proveedor ');
      DMBaseDatos.qryDetalle.ParamByName('Proveedor').AsString:= DMBaseDatos.qryCabecera.FieldByName('Proveedor_p').AsString;
      DMBaseDatos.qryDetalle.Open;
      while not DMBaseDatos.qryDetalle.Eof do
      begin
        ClonarRegistro( DMBaseDatos.qryDetalle, DMBaseDatos.QAux );
        DMBaseDatos.QAux.FieldByName('Proveedor_p').AsString:= AProveedor;
        DMBaseDatos.QAux.Post;
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

function ClonarProveedor( const VOldProveedor, VNewProveedor: string; var sMsg: string ): Boolean;
var
  sGrupo: string;
begin
  CerrarTablas;

  with DMBaseDatos do
  begin
      if LocalizaProveedor( VOldProveedor ) then
      begin
        DMBaseDatos.QAux.RequestLive:= True;

        try
          PutProveedor( VNewProveedor );
          PutAlmacenes( VNewProveedor );
          PutEnvases( VNewProveedor );
        finally
          DMBaseDatos.QAux.RequestLive:= False;
        end;
        result:= True;
      end
      else
      begin
        sMsg:= 'No encontrado Proveedor origen a clonar';
        Result:= False;
      end;
  end;

  CerrarTablas;
end;

end.
