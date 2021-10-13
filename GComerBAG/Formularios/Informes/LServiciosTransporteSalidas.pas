unit LServiciosTransporteSalidas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, Db, ActnList,
  ComCtrls, CGestionPrincipal, BCalendario, Grids,
  DBGrids, BGrid, BCalendarButton, BEdit, BSpeedButton, BGridButton,
  DBTables, CheckLst;

type
  TFLServiciosTransporteSalidas = class(TForm)
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    BCancelar: TAction;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    LEmpresa: TLabel;
    eEmpresa: TBEdit;
    BGBEmpresa: TBGridButton;
    STEmpresa: TStaticText;
    lblDesde: TLabel;
    eDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    Label2: TLabel;
    Label1: TLabel;
    eProducto: TBEdit;
    btnProducto: TBGridButton;
    stProducto: TStaticText;
    Label3: TLabel;
    eCentro: TBEdit;
    btnCentro: TBGridButton;
    stCentro: TStaticText;
    eHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    clbPaises: TCheckListBox;
    cbxPortes: TComboBox;
    cbxDestino: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    lblGrupoPaises: TLabel;
    Label6: TLabel;
    cbxAgrupacion: TComboBox;
    chkDifVehiculo: TCheckBox;
    Label8: TLabel;
    lblTransportista: TLabel;
    eTransportista: TBEdit;
    btnTransportista: TBGridButton;
    stTransportista: TStaticText;
    lblCliente: TLabel;
    eCliente: TBEdit;
    btnCliente: TBGridButton;
    stCliente: TStaticText;
    lblDiferenciar: TLabel;
    chkDifDestino: TCheckBox;
    chkDifCliente: TCheckBox;
    lbl1: TLabel;
    procedure BBCancelarClick(Sender: TObject);
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure eEmpresaChange(Sender: TObject);
    procedure eProductoChange(Sender: TObject);
    procedure eCentroChange(Sender: TObject);
    procedure cbxDestinoChange(Sender: TObject);
    procedure eTransportistaChange(Sender: TObject);
    procedure eClienteChange(Sender: TObject);

  private
    { Private declarations }
    sEmpresa, sCentro, sCliente, sTransportista, sProducto, sPaises: string;
    dFechaIni, dFechaFin: TDateTime;
    slPaises: TStringList;
    iTipoImporte: integer;

    function  ValidarParametros: boolean;
    procedure VerListado;
    procedure DesProductoOptativo;
    procedure DesCentroOptativo;
    procedure DesTransportistaOptativo;
    procedure DesClienteOptativo;
  public
    { Public declarations }
    procedure TipoImporte( const ATipo: integer );
  end;

implementation

uses UDMAuxDB, CVariables, Principal, CReportes, DLServiciosTransporteSalidas,
  CAuxiliarDB, QLServiciosTransporteSalidas, DPreview, bTimeUtils, DateUtils,
  UDMBaseDatos, UFTransportistas;


{$R *.DFM}

procedure TFLServiciosTransporteSalidas.BBCancelarClick(Sender: TObject);
begin
  if CerrarForm(false) then
    Close;
end;


function TFLServiciosTransporteSalidas.ValidarParametros: boolean;
var
  i: integer;
begin
  result:= False;
  //Comprobar parametros de entrada
  if STEmpresa.Caption = '' then
  begin
    MessageDlg('Falta o código de empresa incorrecto', mtError, [mbOk], 0);
    EEmpresa.SetFocus;
    Exit;
  end;

  if not TryStrToDate( eDesde.Text, dFechaIni ) then
  begin
    MessageDlg('Fecha de inicio incorrecta ...', mtError, [mbOk], 0);
    eDesde.SetFocus;
    Exit;
  end;
  if not TryStrToDate( eHasta.Text, dFechaFin ) then
  begin
    MessageDlg('Fecha de fin incorrecta ...', mtError, [mbOk], 0);
    eHasta.SetFocus;
    Exit;
  end;
  if dFechaIni > dFechaFin then
  begin
    MessageDlg('Rango de fechas incorrecto ...', mtError, [mbOk], 0);
    eDesde.SetFocus;
    Exit;
  end;

  if STCentro.Caption = '' then
  begin
    MessageDlg('Código de centro incorrecto', mtError, [mbOk], 0);
    ECentro.SetFocus;
    Exit;
  end;

  if stTransportista.Caption = '' then
  begin
    MessageDlg('Código de transportista incorrecto', mtError, [mbOk], 0);
    eTransportista.SetFocus;
    Exit;
  end;

  if stCliente.Caption = '' then
  begin
    MessageDlg('Código de cliente incorrecto', mtError, [mbOk], 0);
    eCliente.SetFocus;
    Exit;
  end;


  if STProducto.Caption = '' then
  begin
    MessageDlg('Código de producto incorrecto', mtError, [mbOk], 0);
    EProducto.SetFocus;
    Exit;
  end;

  sPaises:= '';
  if cbxDestino.ItemIndex = 6 then
  begin
    for i:= 0 to clbPaises.Items.Count -1 do
    begin
      if clbPaises.Checked[i] then
      begin
        if sPaises = '' then
          sPaises:= '''' + slPaises[i] + ''''
        else
          sPaises:= sPaises + ',''' + slPaises[i] + '''';
      end;
    end;
    if sPaises = '' then
    begin
      MessageDlg('Falta seleccionar los paises.', mtError, [mbOk], 0);
      clbPaises.SetFocus;
      Exit;
    end;
  end;

  sEmpresa:= eEmpresa.Text;
  sCentro:= eCentro.Text;
  sCliente:= eCliente.Text;
  sTransportista:= eTransportista.Text;
  sProducto:= eProducto.Text;
  result:= True;
end;

procedure TFLServiciosTransporteSalidas.VerListado;
begin
  QRLServiciosTransporteSalidas := TQRLServiciosTransporteSalidas.Create(Application);

  PonLogoGrupoBonnysa(QRLServiciosTransporteSalidas, EEmpresa.Text);
  QRLServiciosTransporteSalidas.lblFecha.Caption:= 'DEL ' + DateToStr( dFechaIni ) + ' AL ' + DateToStr( dFechaFin );
  if eCentro.Text = '' then
    QRLServiciosTransporteSalidas.lblCentro.Caption:=  'TODOS LOS CENTROS'
  else
    QRLServiciosTransporteSalidas.lblCentro.Caption:=  'CENTRO SALIDA: ' + eCentro.Text + ' ' + stCentro.Caption;
  if eProducto.Text = '' then
    QRLServiciosTransporteSalidas.lblProducto.Caption:=  'TODOS LOS PRODUCTOS'
  else
    QRLServiciosTransporteSalidas.lblProducto.Caption:=  'PRODUCTO: ' + eProducto.Text + ' ' + stProducto.Caption;

  QRLServiciosTransporteSalidas.lblMatricula.Enabled:= chkDifVehiculo.Checked;
  QRLServiciosTransporteSalidas.qrlCliente.Enabled:= chkDifCliente.Checked;
  QRLServiciosTransporteSalidas.qrlCodPostal.Enabled:= chkDifDestino.Checked;

  if cbxAgrupacion.ItemIndex = 0 then
  begin
    QRLServiciosTransporteSalidas.qrlservicios.Caption:= 'Albarán';
    QRLServiciosTransporteSalidas.qrxservicios.Expression:= 'albaran';
    QRLServiciosTransporteSalidas.qrxservicios1.Expression:= '';
  end
  else
  begin
    if chkDifDestino.Checked or chkDifCliente.Checked then
    begin
      //QRLServiciosTransporteSalidas.qrlservicios.Enabled:= False;
      //QRLServiciosTransporteSalidas.qrxservicios.Enabled:= False;
      QRLServiciosTransporteSalidas.qrxservicios1.Enabled:= False;
    end;
  end;

  case cbxAgrupacion.ItemIndex of
    0: begin
         QRLServiciosTransporteSalidas.lblAgrupa.Caption:= 'Fecha';
       end;
    1: begin
         QRLServiciosTransporteSalidas.lblAgrupa.Caption:= 'Año/Sem.';
       end;
    2: begin
         QRLServiciosTransporteSalidas.lblAgrupa.Caption:= 'Año/mes';
       end;
    3: begin
         QRLServiciosTransporteSalidas.lblAgrupa.Caption:= '';
       end;
  end;
  QRLServiciosTransporteSalidas.lblPortes.Caption:= 'PORTES: ' + UpperCase(cbxPortes.Items[cbxPortes.ItemIndex]);
  if sCliente = '' then
  begin
    QRLServiciosTransporteSalidas.lblDestino.Caption:= 'DESTINO: ' + UpperCase(cbxDestino.Items[cbxDestino.ItemIndex]);
  end
  else
  begin
    QRLServiciosTransporteSalidas.lblDestino.Caption:= 'CLIENTE: ' + sCliente + ' ' + DesCliente( sCliente );
  end;
  if cbxDestino.ItemIndex = 6 then
    QRLServiciosTransporteSalidas.lblDestino.Caption:= QRLServiciosTransporteSalidas.lblDestino.Caption +
                                                      ' [' + sPaises + ']';

  try
    Preview(QRLServiciosTransporteSalidas);
  except
    FreeAndNil( QRLServiciosTransporteSalidas );
    raise;
  end;
end;

procedure TFLServiciosTransporteSalidas.BBAceptarClick(Sender: TObject);
begin
  if not CerrarForm(true) then
    Exit;

  if ValidarParametros then
  begin
    try
      if DMLServiciosTransporteSalidas.ObtenerDatos( sEmpresa, sCentro,
                                                     sTransportista, sCliente, sProducto,
                                                     dFechaIni, dFechaFin,
                                                     chkDifVehiculo.Checked, chkDifDestino.Checked, chkDifCliente.Checked,
                                                     cbxPortes.ItemIndex, cbxDestino.ItemIndex, sPaises,
                                                     cbxAgrupacion.ItemIndex ) then
        VerListado
      else
        ShowMessage('No hay datos para los parametros introducidos.');
    finally
      DMLServiciosTransporteSalidas.LimpiarDatos;
    end;
  end;
end;

procedure TFLServiciosTransporteSalidas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  gRF := nil;
  gCF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  FreeAndNIl( DMLServiciosTransporteSalidas );
  FreeAndNil( slPaises );
  Action := caFree;
end;

procedure TFLServiciosTransporteSalidas.FormCreate(Sender: TObject);
var
  i: integer;
begin
  FormType := tfOther;
  BHFormulario;

  eEmpresa.Tag := kEmpresa;
  eCentro.Tag := kCentro;
  eCliente.Tag := kCliente;
  eTransportista.Tag:= kTransportista;
  eProducto.Tag := kProducto;
  eDesde.Tag := kCalendar;
  eHasta.Tag := kCalendar;

  gRF := RejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := CalendarioFlotante;

  eEmpresa.Text := gsDefEmpresa;

  dFechaIni:= LunesAnterior( Date ) - 6;
  CalendarioFlotante.Date := dFechaIni;
  eDesde.Text:= DateToStr( dFechaIni );
  dFechaFin:= Date;
  eHasta.Text:= DateToStr( dFechaFin );

  DMLServiciosTransporteSalidas:= TDMLServiciosTransporteSalidas.Create( self );



  slPaises:= TStringList.Create;
  i:= 0;
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select descripcion_p, pais_c ');
    SQL.Add(' from frf_clientes, frf_paises ');
    SQL.Add(' where pais_c = pais_p ');
    SQL.Add(' group by descripcion_p, pais_c ');
    SQL.Add(' order by descripcion_p, pais_c ');
    Open;
    while not EOF do
    begin
      slPaises.Add( FieldByName('pais_c').AsString );
      clbPaises.Items.Add( FieldByName('descripcion_p').AsString + ' [' +FieldByName('pais_c').AsString + ']');
      clbPaises.Checked[i]:= False;
      //clbPaises.Checked[i]:= ( FieldByName('pais_c').AsString = 'GB' ) or
      //   ( FieldByName('pais_c').AsString = 'DE' );
      Next;
      Inc(i);
    end;
    Close;
  end;
end;

(*
    if ATipoImporte = 0 then
    begin
      SQL.Add('        0 coste_producto,  ');
      SQL.Add('        0 coste_todos, ');
      SQL.Add('        0 kilos_albaran, ');
      SQL.Add('        '''' factura, ');
    end
    else
    begin
      if sProductoAux <> '' then
      begin
        SQL.Add('        ( select sum(importe_g) from frf_gastos ');
        SQL.Add('           where empresa_g = empresa_sc and centro_salida_g = centro_salida_sc ');
        SQL.Add('           and n_albaran_g = n_albaran_sl and fecha_g = fecha_sl ');
        //SQL.Add('           and ( producto_g in ( ' + sProductoAux + ' ) ) ');
        SQL.Add('           and ( producto_g = producto_sl ) ');
        if ATipoImporte = 1 then
          SQL.Add('           and ( tipo_g = ''009'' or tipo_g = ''056'' ) ) coste_producto, ')
        else
        if ATipoImporte = 2 then
          SQL.Add('           and ( tipo_g = ''009'' or tipo_g = ''011'' or tipo_g = ''012'' or tipo_g = ''037'' or tipo_g = ''038'' ) ) coste_producto, ')
        else
        if ATipoImporte = 3 then
          SQL.Add('           and ( tipo_g = ''011'' or tipo_g = ''012'' or tipo_g = ''037'' or tipo_g = ''038'' ) ) coste_producto, ')
        else
        if ATipoImporte = 4 then
          SQL.Add('           and tipo_g = ''009'' ) coste_producto, ')
        else
        if ATipoImporte = 5 then
          SQL.Add('           and tipo_g = ''056'' ) coste_producto, ');

        SQL.Add('        ( select sum(importe_g) from frf_gastos ');
        SQL.Add('           where empresa_g = empresa_sc and centro_salida_g = centro_salida_sc ');
        SQL.Add('           and n_albaran_g = n_albaran_sl and fecha_g = fecha_sl ');
        SQL.Add('           and ( producto_g is null ) ');
        if ATipoImporte = 1 then
          SQL.Add('           and ( tipo_g = ''009'' or tipo_g = ''056'' ) ) coste_todos, ')
        else
        if ATipoImporte = 2 then
          SQL.Add('           and ( tipo_g = ''009'' or tipo_g = ''011'' or tipo_g = ''012'' or tipo_g = ''037'' or tipo_g = ''038'' ) ) coste_producto, ')
        else
        if ATipoImporte = 3 then
          SQL.Add('           and ( tipo_g = ''011'' or tipo_g = ''012'' or tipo_g = ''037'' or tipo_g = ''038'' ) ) coste_producto, ')
        else
        if ATipoImporte = 4 then
          SQL.Add('           and tipo_g = ''009'' ) coste_todos, ')
        else
        if ATipoImporte = 5 then
          SQL.Add('           and tipo_g = ''056'' ) coste_todos, ');

        SQL.Add('        ( select sum(slaux.kilos_sl) from frf_salidas_l slaux ');
        SQL.Add('           where slaux.empresa_sl = empresa_sc and slaux.centro_salida_sl = centro_salida_sc ');
        SQL.Add('           and slaux.n_albaran_sl = n_albaran_sc and slaux.fecha_sl = fecha_sc ) kilos_albaran,');
      end
      else
      begin
        SQL.Add('        ( select sum(importe_g) from frf_gastos ');
        SQL.Add('           where empresa_g = empresa_sc and centro_salida_g = centro_salida_sc ');
        SQL.Add('           and n_albaran_g = n_albaran_sl and fecha_g = fecha_sl ');
        if ATipoImporte = 1 then
          SQL.Add('           and ( tipo_g = ''009'' or tipo_g = ''056'' ) ) coste_producto, ')
        else
        if ATipoImporte = 2 then
          SQL.Add('           and ( tipo_g = ''009'' or tipo_g = ''011'' or tipo_g = ''012'' or tipo_g = ''037'' or tipo_g = ''038'' ) ) coste_producto, ')
        else
        if ATipoImporte = 3 then
          SQL.Add('           and ( tipo_g = ''011'' or tipo_g = ''012'' or tipo_g = ''037'' or tipo_g = ''038'' ) ) coste_producto, ')
        else
        if ATipoImporte = 4 then
          SQL.Add('           and tipo_g = ''009'' ) coste_producto, ')
        else
        if ATipoImporte = 5 then
          SQL.Add('           and tipo_g = ''056'' ) coste_producto, ');

        SQL.Add('           0 coste_todos, ');
        SQL.Add('           0 kilos_albaran, ');
      end;
*)

procedure TFLServiciosTransporteSalidas.TipoImporte( const ATipo: integer );
begin
  if ATipo = 0 then
  begin
    iTipoImporte:= 0;
    Caption:='   RESUMEN SERVICIOS POR TRANSPORTISTA - SALIDAS, IMPORTE FRUTA.';
  end
  else
  begin
    iTipoImporte:= 1;
    Caption:='   RESUMEN SERVICIOS POR TRANSPORTISTA - SALIDAS, COSTE TRANSPORTE.';
  end;
end;

procedure TFLServiciosTransporteSalidas.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFLServiciosTransporteSalidas.ADesplegarRejillaExecute(Sender: TObject);
var
  sAux: string;
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCentro: DespliegaRejilla(btnCentro);
    kTransportista: //DespliegaRejilla(btnTransportista);
    begin
      sAux:= eTransportista.Text;
      if SeleccionaTransportista( self, eTransportista, eEmpresa.Text, sAux ) then
      begin
        eTransportista.Text:= sAux;
      end;
    end;
    kCliente: DespliegaRejilla(btnCliente);
    kProducto: DespliegaRejilla(btnProducto,[eEmpresa.Text]);
    kCalendar:
    begin
      if eDesde.Focused then
        DespliegaCalendario(BCBDesde)
      else
        DespliegaCalendario(BCBHasta);
    end;
  end;
end;

procedure TFLServiciosTransporteSalidas.DesProductoOptativo;
begin
  if eProducto.Text = '' then
  begin
    stProducto.Caption := 'VACIO = TODOS LOS PRODUCTOS';
  end
  else
  begin
    stProducto.Caption := desProducto(Eempresa.Text, eProducto.Text);
  end;
end;

procedure TFLServiciosTransporteSalidas.DesCentroOptativo;
begin
  if eCentro.Text = '' then
  begin
    stCentro.Caption := 'VACIO = TODOS LOS CENTROS';
  end
  else
  begin
    stCentro.Caption := desCentro(Eempresa.Text, eCentro.Text);
  end;
end;

procedure TFLServiciosTransporteSalidas.DesClienteOptativo;
begin
  if eCliente.Text = '' then
  begin
    stCliente.Caption := 'VACIO = TODOS LOS CLIENTES';
  end
  else
  begin
    stCliente.Caption := desCliente(eCliente.Text);
  end;
end;

procedure TFLServiciosTransporteSalidas.DesTransportistaOptativo;
begin
  if eTransportista.Text = '' then
  begin
    stTransportista.Caption := 'VACIO = TODOS LOS TRANSPORTISTAS';
  end
  else
  begin
    stTransportista.Caption := desTransporte(Eempresa.Text, eTransportista.Text);
  end;
end;

procedure TFLServiciosTransporteSalidas.eEmpresaChange(Sender: TObject);
begin
  STEmpresa.Caption := desEmpresa(Eempresa.Text);
  DesCentroOptativo;
  DesProductoOptativo;
  DesClienteOptativo;
  DesTransportistaOptativo;
end;

procedure TFLServiciosTransporteSalidas.eCentroChange(Sender: TObject);
begin
  DesCentroOptativo;
end;

procedure TFLServiciosTransporteSalidas.eProductoChange(Sender: TObject);
begin
  DesProductoOptativo;
end;

procedure TFLServiciosTransporteSalidas.cbxDestinoChange(Sender: TObject);
begin
  lblGrupoPaises.Visible:= ( cbxDestino.ItemIndex = 6 );
  clbPaises.Enabled:= lblGrupoPaises.Visible;
end;

procedure TFLServiciosTransporteSalidas.eTransportistaChange(
  Sender: TObject);
begin
  DesTransportistaOptativo;
end;

procedure TFLServiciosTransporteSalidas.eClienteChange(Sender: TObject);
begin
  DesClienteOptativo;
end;

end.
