unit ResumenConsumosFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, ExtCtrls, nbButtons,
  nbEdits, nbCombos, BSpeedButton, BCalendarButton, ComCtrls, BCalendario,
  Grids, DBGrids, DB, DBTables, kbmMemTable, BGridButton, BGrid;

type
  TFLResumenConsumos = class(TForm)
    lblCodigo1: TnbLabel;
    edtEmpresa: TBEdit;
    btnResumen: TButton;
    lblDesEmpresa: TLabel;
    RejillaFlotante: TBGrid;
    btnEmpresa: TBGridButton;
    edtDesde: TnbDBCalendarCombo;
    lblCodigo5: TnbLabel;
    edtHasta: TnbDBCalendarCombo;
    lblCodigo6: TnbLabel;
    edtProducto: TBEdit;
    btnProducto: TBGridButton;
    lblCodigo7: TnbLabel;
    lblDesProducto: TLabel;
    btnCancelar: TButton;
    lblCodigo3: TnbLabel;
    edtAnyoSemana: TBEdit;
    lblEntrega: TnbLabel;
    edtEntrega: TBEdit;
    lbl2: TLabel;
    lbl3: TLabel;
    rbEntrega: TRadioButton;
    rbCliente: TRadioButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnResumenClick(Sender: TObject);
    procedure btnEmpresaClick(Sender: TObject);
    procedure edtEmpresaChange(Sender: TObject);
    procedure edtProductoChange(Sender: TObject);

  private
    sEmpresa, sProducto, sSemana, sEntrega: string;
    dFechaIni, dFechaFin: TDateTime;

    function ValidarParametros: Boolean;

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses UDMAuxDB, UDMBaseDatos, Principal, CGestionPrincipal, CVariables, bTimeUtils,
     CAuxiliarDB, bMath, ResumenConsumosDL;

var
  DLResumenConsumos: TDLResumenConsumos;

procedure TFLResumenConsumos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  BEMensajes('');
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

  FreeAndNil(DLResumenConsumos);
  Action := caFree;
end;

procedure TFLResumenConsumos.FormCreate(Sender: TObject);
var
  dFecha: TDateTime;
begin
  FormType := tfOther;
  BHFormulario;


  DLResumenConsumos := TDLResumenConsumos.Create(self);


  edtEmpresa.Tag:= kEmpresa;
  edtEmpresa.Text:= 'F17';
  edtProducto.Tag:= kProducto;
  edtProducto.Text:= '';
  dFecha:= LunesAnterior( Now );
  edtHasta.AsDate:= dFecha - 1;
  edtDesde.AsDate:= dFecha - 7;
  //edtHasta.Text:= '';
  //edtDesde.Text:= '';

  edtEntrega.Text:= '';
end;

procedure TFLResumenConsumos.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFLResumenConsumos.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLResumenConsumos.FormKeyDown(Sender: TObject; var Key: Word;
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
    vk_escape:
      begin
        btnCancelar.Click;
      end;
    vk_f1:
      begin
        btnResumen.Click;
      end;
  end;
end;

function TFLResumenConsumos.ValidarParametros: Boolean;
begin
  if ( edtEmpresa.Text = '' ) or ( edtEmpresa.Text = 'BAG' )  then
  begin
    raise Exception.Create('Falta el código de la planta.');
  end;
  if lblDesEmpresa.Caption = '' then
  begin
    raise Exception.Create('El código de la empresa es incorrrecto.');
  end;
  if lblDesProducto.Caption = '' then
  begin
    raise Exception.Create('El código del producto es incorrrecto.');
  end;


  if ( edtAnyoSemana.Text <> '' ) and ( Length( edtAnyoSemana.Text ) <> 6 ) then
  begin
    raise Exception.Create('El año/semana debe de tener 6 digitos.');
  end
  else
  begin
    sSemana:= edtAnyoSemana.Text;
  end;
  if ( edtEntrega.Text <> '' ) and ( Length( edtEntrega.Text ) <> 12 ) then
  begin
    raise Exception.Create('El año/semana debe de tener 12 digitos.');
  end
  else
  begin
    sEntrega:= edtEntrega.Text;
  end;

  if not TryStrToDate( edtDesde.Text, dFechaIni ) then
  begin
    raise Exception.Create('Falta la fecha de inicio o es incorrrecta.')
  end;
  if not TryStrToDate( edtHasta.Text, dFechaFin ) then
  begin
    raise Exception.Create('Falta la fecha de fin o es incorrrecta.')
  end;
  if dFechaIni > dFechaFin then
  begin
      raise Exception.Create('Rango de fechas incorrecto ');
  end;

  if edtEmpresa.Text = '' then
    sEmpresa:= 'BAG'
  else
    sEmpresa:= edtEmpresa.Text;

  sProducto:= edtProducto.Text;

  Result:= True;
end;

procedure TFLResumenConsumos.btnResumenClick(Sender: TObject);
begin
  if ValidarParametros then
  begin
    if rbEntrega.Checked then
      DLResumenConsumos.ResumenConsumosRFEntrega( sEmpresa, sProducto, sSemana, sEntrega, dFechaIni, dFechaFin  )
    else
      DLResumenConsumos.ResumenConsumosRFCliente( sEmpresa, sProducto, sSemana, sEntrega, dFechaIni, dFechaFin  );
  end;
end;

procedure TFLResumenConsumos.btnEmpresaClick(Sender: TObject);
begin
  if ActiveControl <> nil then
  case ActiveControl.Tag of
    kEmpresa:
      begin
        DespliegaRejilla(btnEmpresa);
      end;
    kProducto:
      begin
        DespliegaRejilla(btnProducto, [edtEmpresa.Text])
      end;
  end;
end;

procedure TFLResumenConsumos.edtEmpresaChange(Sender: TObject);
begin
  if ( edtEmpresa.Text = '' ) or  ( edtEmpresa.Text = 'BAG' ) then
  begin
    lblDesEmpresa.Caption:= 'Por favor selecione una planta.';
  end
  else
  begin
    lblDesEmpresa.Caption:= desEmpresa( edtEmpresa.Text );
  end;
  edtProductoChange( edtProducto );
end;

procedure TFLResumenConsumos.edtProductoChange(Sender: TObject);
begin
  if ( edtProducto.Text = '' )  then
  begin
    lblDesProducto.Caption:= 'Todos los productos.';
  end
  else
  begin
    lblDesProducto.Caption:= desProducto( edtEmpresa.Text, edtProducto.Text );
  end;
end;

end.
