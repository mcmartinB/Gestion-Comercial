(* CAMBIAR
   PedidosFL, FLPedidos
   PedidosDL
   RParametrosPedidos
*)
unit PedidosFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit;

type
  TFLPedidos = class(TForm)
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
    nbLabel4: TnbLabel;
    edtProducto: TBEdit;
    etqProducto: TnbStaticText;
    cbxNotas: TCheckBox;
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
    procedure edtProductoChange(Sender: TObject);
  private
    { Private declarations }
    function ValidarEntrada: Boolean;

    procedure ListadoPedidoEnvase;
    procedure ListadoPedidoFormato;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses UDMAuxDB, Principal, CGestionPrincipal, CVariables, bTimeUtils,
     DB, PedidosQM, PedidosDM, CReportes, Dpreview, UDMConfig,
     DMPedidosFormato, QMPedidosFormato;

procedure TFLPedidos.FormCreate(Sender: TObject);
var
  fecha: TDateTime;
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Text := gsDefEmpresa;
  edtCentro.Text := gsDefCentro;
  fecha:= LunesAnterior( Date );
  edtFechaDesde.Text := DateToStr(fecha - 7);
  edtFechaHasta.Text := DateToStr(fecha - 1);

  edtProductoChange( edtProducto );
  edtClienteChange( edtCliente );
  edtDirSumChange( edtDirSum );

  PedidosDM.CrearModuloDeDatos;
end;

procedure TFLPedidos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  BEMensajes('');
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;

  PedidosDM.DestruirModuloDeDatos;
end;

procedure TFLPedidos.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFLPedidos.FormKeyDown(Sender: TObject; var Key: Word;
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

function TFLPedidos.ValidarEntrada: Boolean;
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

  //El codigo de empresa es obligatorio
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

procedure TFLPedidos.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLPedidos.btnAceptarClick(Sender: TObject);
begin
  if ValidarEntrada then
  begin
    begin
      ListadoPedidoEnvase;
    end;
  end;
end;

procedure TFLPedidos.ListadoPedidoFormato;
var
  qrpMPedidosFormato: TqrpMPedidosFormato;
begin
  DMPedidosFormato.CrearModuloDeDatos;

  try
    dtmMPedidosFormato.QueryListado( edtEmpresa.Text, edtCentro.Text, edtCliente.Text, edtProducto.Text, '',
                            StrToDate( edtFechaDesde.Text), StrToDate( edtFechaHasta.Text) );
    dtmMPedidosFormato.QListado.Open;

    if not dtmMPedidosFormato.QListado.IsEmpty then
    begin
      if cbxNotas.Checked then
        dtmMPedidosFormato.QNotas.Open;
      qrpMPedidosFormato := TqrpMPedidosFormato.Create(Application);
      try
        PonLogoGrupoBonnysa(qrpMPedidosFormato, edtEmpresa.Text);
        qrpMPedidosFormato.lblPeriodo.Caption:= 'Del ' + edtFechaDesde.Text + ' al ' + edtFechaHasta.Text;
        if edtProducto.Text <> '' then
          qrpMPedidosFormato.lblProducto.Caption:= edtProducto.Text + desProducto( edtEmpresa.Text, edtProducto.Text )
        else
          qrpMPedidosFormato.lblProducto.Caption:= 'TODOS LOS PRODUCTOS';
        qrpMPedidosFormato.ReportTitle:= 'LISTADO DE PEDIDOS';
        qrpMPedidosFormato.bNotas:= cbxNotas.Checked;

        Preview(qrpMPedidosFormato);
      except
        qrpMPedidosFormato.Free;
      end;
    end
    else
    begin
      ShowMessage('No hay Pedidos que cumplan los requisitos especificados.');
    end;
    dtmMPedidosFormato.QNotas.Close;
    dtmMPedidosFormato.QListado.Close;
  finally
    DMPedidosFormato.DestruirModuloDeDatos;
  end;
end;

procedure TFLPedidos.ListadoPedidoEnvase;
var
  QMPedidos: TQMPedidos;
begin
  DMPedidos.QueryListado( edtEmpresa.Text, edtCentro.Text, edtCliente.Text, edtProducto.Text, '',
                          StrToDate( edtFechaDesde.Text), StrToDate( edtFechaHasta.Text) );
  DMPedidos.QListado.Open;
  if not DMPedidos.QListado.IsEmpty then
  begin
    if cbxNotas.Checked then
      DMPedidos.QNotas.Open;
    QMPedidos := TQMPedidos.Create(Application);
    try
      PonLogoGrupoBonnysa(QMPedidos, edtEmpresa.Text);
      QMPedidos.lblPeriodo.Caption:= 'Del ' + edtFechaDesde.Text + ' al ' + edtFechaHasta.Text;
      if edtProducto.Text <> '' then
        QMPedidos.lblProducto.Caption:= edtProducto.Text + desProducto( edtEmpresa.Text, edtProducto.Text )
      else
        QMPedidos.lblProducto.Caption:= 'TODOS LOS PRODUCTOS';
      QMPedidos.ReportTitle:= 'LISTADO DE PEDIDOS';
      QMPedidos.bNotas:= cbxNotas.Checked;
      Preview(QMPedidos);
    except
      QMPedidos.Free;
    end;
  end
  else
  begin
    ShowMessage('No hay Pedidos que cumplan los requisitos especificados.');
  end;
  DMPedidos.QNotas.Close;
  DMPedidos.QListado.Close;
end;



procedure TFLPedidos.edtEmpresaChange(Sender: TObject);
begin
  etqEmpresa.Caption:= desEmpresa( edtEmpresa.Text );
end;

procedure TFLPedidos.edtCentroChange(Sender: TObject);
begin
  etqCentro.Caption:= desCentro( edtEmpresa.Text, edtCentro.Text);
end;

procedure TFLPedidos.edtClienteChange(Sender: TObject);
begin
  etqCliente.Caption:= desCliente( edtEmpresa.Text, edtCliente.Text);
  if etqCliente.Caption = '' then
    etqCliente.Caption:= 'TODOS LOS CLIENTES';
end;

procedure TFLPedidos.edtDirSumChange(Sender: TObject);
begin
  etqDirSum.Caption:= desSuministro( edtEmpresa.Text, edtCliente.Text, edtDirSum.Text );
  if etqDirSum.Caption = '' then
    etqDirSum.Caption:= 'TODOS LOS SUMINISTROS';
end;

procedure TFLPedidos.edtProductoChange(Sender: TObject);
begin
  etqProducto.Caption:= desProducto( edtEmpresa.Text, edtProducto.Text );
    if etqProducto.Caption = '' then
      etqProducto.Caption:= 'TODOS LOS PRODUCTOS';
end;

end.
