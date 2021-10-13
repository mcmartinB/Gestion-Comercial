unit AlbaranFacturaSimpleFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit;

type
  TFLAlbaranFacturaSimple = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    edtEmpresa: TBEdit;
    edtFechaDesde: TBEdit;
    edtFechaHasta: TBEdit;
    lblEmpresa: TnbLabel;
    lblFechaDesde: TnbLabel;
    etqEmpresa: TnbStaticText;
    lblFechaHasta: TnbLabel;
    lblCliente: TnbLabel;
    edtCliente: TBEdit;
    etqCliente: TnbStaticText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAceptarClick(Sender: TObject);
    procedure edtEmpresaChange(Sender: TObject);
    procedure edtClienteChange(Sender: TObject);
  private
    { Private declarations }
    function ValidarEntrada: Boolean;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses UDMAuxDB, Principal, CGestionPrincipal, CVariables, bTimeUtils,
  AlbaranFacturaSimpleQL, AlbaranFacturaSimpleCB, DB;

procedure TFLAlbaranFacturaSimple.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  BEMensajes('');
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;

  AlbaranFacturaSimpleQL.UnloadReport;
end;

procedure TFLAlbaranFacturaSimple.FormCreate(Sender: TObject);
var
  fecha: TDateTime;
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Text := gsDefEmpresa;
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select cliente_c ');
    SQL.Add(' from frf_clientes ');
    SQL.Add(' where albaran_factura_c <> 0 ');
    SQL.Add(' order by cliente_c ');
    Open;
    edtCliente.Text := Fields[0].AsString;
    Close;
  end;
  
  fecha:= LunesAnterior( Date );
  edtFechaDesde.Text := DateToStr(fecha - 7);
  edtFechaHasta.Text := DateToStr(fecha - 1);

  AlbaranFacturaSimpleQL.LoadReport( Self );
end;

procedure TFLAlbaranFacturaSimple.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFLAlbaranFacturaSimple.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLAlbaranFacturaSimple.edtEmpresaChange(Sender: TObject);
begin
  etqEmpresa.Caption:= desEmpresa( edtEmpresa.Text );
end;

procedure TFLAlbaranFacturaSimple.edtClienteChange(Sender: TObject);
begin
  etqCliente.Caption := desCliente( edtCliente.Text );
end;

procedure TFLAlbaranFacturaSimple.FormKeyDown(Sender: TObject; var Key: Word;
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
        btnAceptar.Click;
      end;
  end;
end;

function TFLAlbaranFacturaSimple.ValidarEntrada: Boolean;
var
  desde, hasta: TDate;
begin
  result := false;
  //El codigo de empresa es obligatorio
  if Trim( edtEmpresa.Text ) = '' then
  begin
    edtEmpresa.SetFocus;
    ShowMessage('El código de empresa es obligatorio.');
    Exit;
  end;

  //El codigo del cliente es obligatorio
  if Trim( edtCliente.Text ) = '' then
  begin
    edtCliente.SetFocus;
    ShowMessage('El código del cliente es obligatorio.');
    Exit;
  end;

  //Al cliente sólo se puede facturar un albaran por factura
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_clientes ');
    SQL.Add(' where cliente_c = :cliente ');
    SQL.Add(' and albaran_factura_c <> 0 ');
    ParamByName('cliente').AsString:= edtCliente.Text;
    Open;
    if IsEmpty then
    begin
       edtCliente.SetFocus;
       ShowMessage('Al cliente cliente se le debe de facturar un ''Albarán'' por ''Factura''.');
       Close;
       Exit;
    end;
    Close;
  end;


  //Comprobar que las fechas sean correctas
  try
    desde := StrToDate(edtFechaDesde.Text);
  except
    edtFechaDesde.SetFocus;
    ShowMessage('Fecha incorrecta.');
    Exit;
  end;
  try
    hasta := StrToDate(edtFechaHasta.Text);
  except
    edtFechaHasta.SetFocus;
    ShowMessage('Fecha incorrecta.');
    Exit;
  end;

  //Comprobar que el rango sea correcto
  if desde > hasta then
  begin
    edtFechaDesde.SetFocus;
    ShowMessage('Rango de fechas incorrecto.');
    Exit;
  end;
  result := true;
end;

procedure TFLAlbaranFacturaSimple.btnAceptarClick(Sender: TObject);
var
  Parametros: RAlbaranFacturaSimpleQL;
begin
  if ValidarEntrada then
  begin
    Parametros.sEmpresa:= edtEmpresa.Text;
    Parametros.sCliente:= edtCliente.Text;
    Parametros.dFechaDesde:= StrToDate( edtFechaDesde.Text );
    Parametros.dFechaHasta:= StrToDate( edtFechaHasta.Text );
    AlbaranFacturaSimpleQL.ExecuteReport( Self, Parametros );
  end;
end;

end.
