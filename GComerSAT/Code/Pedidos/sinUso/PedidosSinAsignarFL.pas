(* CAMBIAR
   PedidosFL, FLPedidos
   PedidosDL
   RParametrosPedidos
*)
unit PedidosSinAsignarFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit;

type
  TFLPedidosSinAsignar = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    edtEmpresa: TBEdit;
    lblEmpresa: TnbLabel;
    etqEmpresa: TnbStaticText;
    lblFechaDesde: TnbLabel;
    edtFechaDesde: TBEdit;
    lblFechaHasta: TnbLabel;
    edtFechaHasta: TBEdit;
    nbLabel1: TnbLabel;
    edtCentro: TBEdit;
    etqCentro: TnbStaticText;
    nbLabel2: TnbLabel;
    etqCliente: TnbStaticText;
    edtCliente: TBEdit;
    nbLabel3: TnbLabel;
    edtDirSum: TBEdit;
    etqDirSum: TnbStaticText;
    lblTipo: TnbLabel;
    cbxTipo: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAceptarClick(Sender: TObject);
    procedure edtEmpresaChange(Sender: TObject);
    procedure edtCentroChange(Sender: TObject);
    procedure edtClienteChange(Sender: TObject);
    procedure edtDirSumChange(Sender: TObject);
    procedure cbxTipoChange(Sender: TObject);
  private
    { Private declarations }
    function ValidarEntrada: Boolean;
  public
    { Public declarations }
  end;

var
  iTipo: Integer;

implementation

{$R *.dfm}

uses UDMAuxDB, Principal, CGestionPrincipal, CVariables, bTimeUtils,
     DB, PedidosSinAsignarQL, PedidosSinAsignarDL, CReportes,
     Dpreview;

procedure TFLPedidosSinAsignar.FormCreate(Sender: TObject);
var
  fecha: TDateTime;
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Text := '050';
  edtCentro.Text := '1';
  fecha:= LunesAnterior( Date );
  edtFechaDesde.Text := DateToStr(fecha - 7);
  edtFechaHasta.Text := DateToStr(fecha - 1);

  edtClienteChange( edtCliente );
  edtDirSumChange( edtDirSum );

  PedidosSinAsignarDL.CrearModuloDeDatos;

  if iTipo = 0 then
  begin
    //Pedidos sin servir
    cbxTipo.ItemIndex:= 0;
    Caption:= '    PEDIDOS SIN NINGUNA SALIDA ASIGNADA';
  end
  else
  begin
    //Salidas sin pedido
    cbxTipo.ItemIndex:= 1;
    Caption:= '    SALIDAS SIN PEDIDO ASIGNADO';
  end;
end;

procedure TFLPedidosSinAsignar.cbxTipoChange(Sender: TObject);
begin
  if cbxTipo.ItemIndex = 0 then
  begin
    //Pedidos sin servir
    Caption:= '    PEDIDOS SIN NINGUNA SALIDA ASIGNADA';
  end
  else
  begin
    //Salidas sin pedido
    Caption:= '    SALIDAS SIN PEDIDO ASIGNADO';
  end;
end;

procedure TFLPedidosSinAsignar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  BEMensajes('');
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;

  PedidosSinAsignarDL.DestruirModuloDeDatos;
end;

procedure TFLPedidosSinAsignar.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFLPedidosSinAsignar.FormKeyDown(Sender: TObject; var Key: Word;
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

function TFLPedidosSinAsignar.ValidarEntrada: Boolean;
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

  //El codigo del centro es obligatorio
  if Trim( edtCentro.Text ) = '' then
  begin
    edtCentro.SetFocus;
    ShowMessage('El código del centro es obligatorio.');
    Exit;
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

procedure TFLPedidosSinAsignar.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLPedidosSinAsignar.btnAceptarClick(Sender: TObject);
var
  QLPedidosSinAsignar: TQLPedidosSinAsignar;
  bPedidos: boolean;
begin
  if ValidarEntrada then
  begin
    bPedidos:= ( cbxTipo.ItemIndex = 0 );
    DLPedidosSinAsignar.CargaQuery( edtEmpresa.Text, edtCentro.Text, edtCliente.Text,
       edtDirSum.Text, StrToDate(edtFechaDesde.Text), StrToDate(edtFechaHasta.Text), bPedidos );
    DLPedidosSinAsignar.QPedidosSinAsignar.Open;
    if not DLPedidosSinAsignar.QPedidosSinAsignar.IsEmpty then
    begin

      QLPedidosSinAsignar := TQLPedidosSinAsignar.Create(Application);
      try
        PonLogoGrupoBonnysa( QLPedidosSinAsignar, edtEmpresa.Text );
        QLPedidosSinAsignar.lblRango.Caption:= 'Del ' + edtFechaDesde.Text + ' al ' + edtFechaHasta.Text; 
        QLPedidosSinAsignar.Configurar( bPedidos );
        Preview(QLPedidosSinAsignar);
      except
        QLPedidosSinAsignar.Free;
      end;
    end
    else
    begin
      if bPedidos then
        ShowMessage('No hay Pedidos que cumplan los requisitos especificados.')
      else
        ShowMessage('No hay Salidas que cumplan los requisitos especificados.')
    end;
    DLPedidosSinAsignar.QPedidosSinAsignar.Close;
 end;
end;

procedure TFLPedidosSinAsignar.edtEmpresaChange(Sender: TObject);
begin
  etqEmpresa.Caption:= desEmpresa( edtEmpresa.Text );
end;

procedure TFLPedidosSinAsignar.edtCentroChange(Sender: TObject);
begin
  etqCentro.Caption:= desCentro( edtEmpresa.Text, edtCentro.Text);
end;

procedure TFLPedidosSinAsignar.edtClienteChange(Sender: TObject);
begin
  etqCliente.Caption:= desCliente( edtEmpresa.Text, edtCliente.Text);
  if etqCliente.Caption = '' then
    etqCliente.Caption:= 'TODOS LOS CLIENTES';
end;

procedure TFLPedidosSinAsignar.edtDirSumChange(Sender: TObject);
begin
  etqDirSum.Caption:= desSuministro( edtEmpresa.Text, edtCliente.Text, edtDirSum.Text );
  if etqDirSum.Caption = '' then
    etqDirSum.Caption:= 'TODOS LOS SUMINISTROS';
end;

initialization
  iTipo:= 0;
end.
