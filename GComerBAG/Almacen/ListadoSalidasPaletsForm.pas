unit ListadoSalidasPaletsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, nbLabels, nbCombos, nbEdits, BSpeedButton,
  BGridButton, BEdit, Grids, DBGrids, BGrid;

type
  TFListadoSalidasPaletsForm = class(TForm)
    btnCerrar: TBitBtn;
    btnImprimir: TBitBtn;
    lblEmpresa: TnbLabel;
    nbLabel2: TnbLabel;
    nbLabel1: TnbLabel;
    empresa: TnbDBSQLCombo;
    centro: TnbDBSQLCombo;
    fechaDesde: TnbDBCalendarCombo;
    fechaHasta: TnbDBCalendarCombo;
    nbLabel4: TnbLabel;
    nbLabel3: TnbLabel;
    producto: TnbDBSQLCombo;
    nbLabel6: TnbLabel;
    cliente: TnbDBSQLCombo;
    stCliente: TLabel;
    stProducto: TLabel;
    nbLabel7: TnbLabel;
    tipoPalet: TnbDBSQLCombo;
    stTipoPalet: TLabel;
    stEmpresa: TLabel;
    stCentro: TLabel;
    RejillaFlotante: TBGrid;
    lblTransportista: TnbLabel;
    edtTransportista: TnbDBSQLCombo;
    txtTransportista: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCerrarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    function productoGetSQL: String;
    function centroGetSQL: String;
    function clienteGetSQL: String;
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    function tipoPaletGetSQL: String;
    procedure empresaChange(Sender: TObject);
    procedure centroChange(Sender: TObject);
    procedure productoChange(Sender: TObject);
    procedure tipoPaletChange(Sender: TObject);
    procedure clienteChange(Sender: TObject);
    procedure edtTransportistaChange(Sender: TObject);
    function edtTransportistaGetSQL: string;
  private
    { Private declarations }

    procedure ValidarCampos;

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CVariables, Principal, CGestionPrincipal, UDMAuxDB,
     DPreview, UDMBaseDatos, CReportes, ListadoSalidasPaletsReport,
  UDMConfig, CAuxiliarDB;

procedure TFListadoSalidasPaletsForm.FormCreate(Sender: TObject);
begin
  FormType:=tfOther;
  BHFormulario;

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;

 empresa.Text:= gsDefEmpresa;
  //centro.Text:= gsDefCentro;
  fechaDesde.AsDate:= date - 7;
  fechaHasta.AsDate:= date - 1;
  //producto.Text:= gsProducto;

end;

procedure TFListadoSalidasPaletsForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  gRF := nil;
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType:=tfDirector;
    BHFormulario;
  end;
  Action:=caFree;
end;

procedure TFListadoSalidasPaletsForm.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFListadoSalidasPaletsForm.ValidarCampos;
var
  dIni, dFin: TDateTime;
begin
  if Trim(empresa.Text) = '' then
  begin
    empresa.SetFocus;
    raise Exception.Create('Falta el codigo de la empresa que es de obligada inserción.');
  end;

  if stCentro.Caption = '' then
  begin
    centro.SetFocus;
    raise Exception.Create('El codigo del centro es icorrecto.');
  end;

  if not TryStrToDate( fechaDesde.Text, dIni ) then
  begin
    fechaDesde.SetFocus;
    raise Exception.Create('Fecha de inicio incorrecta.');
  end;

  if not TryStrToDate( fechaHasta.Text, dFin ) then
  begin
    fechaHasta.SetFocus;
    raise Exception.Create('Fecha de fin incorrecta.');
  end;
  if dIni > dFin then
  begin
    fechaDesde.SetFocus;
    raise Exception.Create('Rango de fechas incorrectas.');
  end;

end;

function Resumen( const AEmpresa, ACentro, AProducto, ACliente, ATransporte, ATipoPalet: string;
                  const AFechaDesde, AFechaHasta: TDateTime;
                  var ACodigo, ADescripcion, APalets: TStringList ):integer;
var
  sCodigo: string;
  iPalets: integer;
begin
  //RESUMEN PALETS
  with DMBaseDatos.QListado.SQL do
  begin
    Clear;

    Add('select tipo_palets_sl palet, sum(nvl(n_palets_sl,0)) palets');
    Add('from frf_salidas_c, frf_salidas_l');

    if AEmpresa = 'BAG' then
      Add(' where empresa_sc[1] = ''F'' ')
    else
      Add('where empresa_sc = :empresa');

    if ACentro <> '' then
      Add('and centro_salida_sc = :centro');
    Add('and fecha_sc between :fechaDesde and :fechaHasta');

    Add('and empresa_sl = empresa_sc');
    Add('and centro_salida_sl = centro_salida_sc');
    Add('and n_albaran_sl = n_albaran_sc');
    Add('and fecha_sl = fecha_sc');
    Add('and es_transito_sc <> 2 ');        //Tipo Salida: Devolucion

    Add('and tipo_palets_sl is not null');

    if Trim( AProducto) <> '' then
      Add('and producto_sl = :producto ');
    if Trim(ACliente) <> '' then
      Add('and cliente_sl = :cliente ');
    if Trim(ATransporte) <> '' then
      Add('and transporte_sc = :transporte ');
    if Trim(ATipoPalet) <> '' then
      Add('and tipo_palets_sl = :tipoPalet ');

    Add('group by tipo_palets_sl');
    Add('having sum(nvl(n_palets_sl,0)) > 0');

    Add('order by palet');
  end;

    if AEmpresa <> 'BAG' then
    DMBaseDatos.QListado.ParamByName('empresa').AsString:= AEmpresa;
    if ACentro <> '' then
      DMBaseDatos.QListado.ParamByName('centro').AsString:= ACentro;
    DMBaseDatos.QListado.ParamByName('fechaDesde').AsDateTime:= AFechaDesde;
    DMBaseDatos.QListado.ParamByName('fechaHasta').AsDateTime:= AFechaHasta;

    if Trim(AProducto) <> '' then
      DMBaseDatos.QListado.ParamByName('producto').AsString:= AProducto;
    if Trim(ACliente) <> '' then
      DMBaseDatos.QListado.ParamByName('cliente').AsString:= ACliente;
    if trim( ATransporte ) <> '' then
      DMBaseDatos.QListado.ParamByName('transporte').AsString:= ATransporte;
    if Trim(ATipoPalet) <> '' then
      DMBaseDatos.QListado.ParamByName('tipoPalet').AsString:= ATipoPalet;
    DMBaseDatos.QListado.Open;

    result:= 0;
    ACodigo.Clear;
    ADescripcion.Clear;
    APalets.Clear;
    sCodigo:= '';
    iPalets:= 0;
    while not DMBaseDatos.QListado.Eof do
    begin
      if sCodigo <> DMBaseDatos.QListado.FieldByName('palet').AsString then
      begin
        if sCodigo <> '' then
        begin
          ACodigo.Add( sCodigo );
          APalets.Add( IntToStr( iPalets ) );
          ADescripcion.Add( desTipoPalet( sCodigo ) );
          result:= result + 1;
        end;
        sCodigo:= DMBaseDatos.QListado.FieldByName('palet').AsString;
        iPalets:= DMBaseDatos.QListado.FieldByName('palets').AsInteger;
      end
      else
      begin
        iPalets:= iPalets + DMBaseDatos.QListado.FieldByName('palets').AsInteger;
      end;

      DMBaseDatos.QListado.Next;
    end;
    if sCodigo <> '' then
    begin
      ACodigo.Add( sCodigo );
      APalets.Add( IntToStr( iPalets ) );
      ADescripcion.Add( desTipoPalet( sCodigo ) );
      result:= result + 1;
    end;
    DMBaseDatos.QListado.Close;
end;

procedure Detalle( const AEmpresa, ACentro,AProducto, ACliente, ATransporte, ATipoPalet: string;
                   const AFechaDesde, AFechaHasta: TDateTime  );
begin
    //DETALLES
  with DMBaseDatos.QListado.SQL do
  begin
    Clear;
      Add('select empresa_sc empresa, ''A'' tipo, n_albaran_sc referencia, fecha_sc fecha, cliente_sal_sc destino, ');
      Add('       dir_sum_sc suministro, tipo_palets_sl palet, sum(n_palets_sl) n_palets ');

      Add('from frf_salidas_c, frf_salidas_l ');
      if AEmpresa = 'BAG' then
        Add(' where empresa_sc[1] = ''F'' ')
      else
        Add('where empresa_sc = :empresa ');

      if ACentro <> '' then
        Add('and centro_salida_sc = :centro ');
      Add('and fecha_sc between :fechaDesde and :fechaHasta ');
      Add('and empresa_sl = empresa_sc ');
      Add('and centro_salida_sl = centro_salida_sc ');
      Add('and n_albaran_sl = n_albaran_sc ');
      Add('and fecha_sl = fecha_sc ');
      Add(' and es_transito_sc <> 2 ');           //Tipo Salida: Devolucion

      if Trim(AProducto) <> '' then
        Add('and producto_sl = :producto ');
      if Trim(ACliente) <> '' then
        Add('and cliente_sl = :cliente ');
      if Trim(ATransporte) <> '' then
        Add('and transporte_sc = :transporte ');
      if Trim(ATipoPalet) <> '' then
        Add('and tipo_palets_sl = :tipoPalet ');

      Add('and tipo_palets_sl is not null ');

      Add('group by empresa_sc, cliente_sal_sc, dir_sum_sc, n_albaran_sc, fecha_sc, tipo_palets_sl ');
      Add('having sum(n_palets_sl) > 0 ');
    Add('order by empresa, tipo, destino, suministro, referencia, fecha, palet ');

    if AEmpresa <> 'BAG' then
      DMBaseDatos.QListado.ParamByName('empresa').AsString:= AEmpresa;
    if ACentro <> '' then
      DMBaseDatos.QListado.ParamByName('centro').AsString:= ACentro;
    DMBaseDatos.QListado.ParamByName('fechaDesde').AsDateTime:= AFechaDesde;
    DMBaseDatos.QListado.ParamByName('fechaHasta').AsDateTime:= AFechaHasta;

    if Trim(AProducto) <> '' then
      DMBaseDatos.QListado.ParamByName('producto').AsString:= AProducto;
    if Trim(ACliente) <> '' then
      DMBaseDatos.QListado.ParamByName('cliente').AsString:= ACliente;
    if trim( ATransporte ) <> '' then
      DMBaseDatos.QListado.ParamByName('transporte').AsString:= ATransporte;
    if Trim(ATipoPalet) <> '' then
      DMBaseDatos.QListado.ParamByName('tipoPalet').AsString:= ATipoPalet;

    DMBaseDatos.QListado.Open;
  end;
end;

procedure Listado( const AEmpresa, ACentro, AProducto, ACliente, ATransporte, ATipoPalet: string;
                   const AFechaDesde, AFechaHasta: TDateTime );
var
  QRListadoSalidasPaletsReport: TQRListadoSalidasPaletsReport;
  iTiposPalets: integer;
  slCodigo, slDescripcion, slPalets: TStringList;
begin
  try
    QRListadoSalidasPaletsReport:= TQRListadoSalidasPaletsReport.Create( Application );

    slDescripcion:= TStringList.Create;
    slCodigo:= TStringList.Create;
    slPalets:= TStringList.Create;

    iTiposPalets:= Resumen( AEmpresa, ACentro, AProducto, ACliente, ATransporte, ATipoPalet,
                            AFechaDesde, AFechaHasta, slCodigo, slDescripcion, slPalets );
    QRListadoSalidasPaletsReport.PutResumen( iTiposPalets, slCodigo, slDescripcion, slPalets );
    Detalle( AEmpresa, ACentro, AProducto, ACliente, ATransporte, ATipoPalet, AFechaDesde, AFechaHasta );

    PonLogoGrupoBonnysa( QRListadoSalidasPaletsReport, AEmpresa );
//    if ACentro <> '' then
      QRListadoSalidasPaletsReport.LCentro.Caption:= AEmpresa + ' ' + desEmpresa( AEmpresa );
//    else
//      QRListadoSalidasPaletsReport.LCentro.Caption:= 'TODOS LOS CENTROS';
    QRListadoSalidasPaletsReport.LProducto.Caption:= AProducto + ' ' + desProducto( AEmpresa, AProducto );
    QRListadoSalidasPaletsReport.LPeriodo.Caption:= 'Desde el ' + DateToStr(AFechaDesde) + ' al ' + DateToStr(AFechaHasta);

    if ATransporte <> '' then
      QRListadoSalidasPaletsReport.qrlblTransporte.Caption:= 'Transportista: ' + ATransporte + ' - ' + desTransporte( AEmpresa, ATransporte )
    else
      QRListadoSalidasPaletsReport.qrlblTransporte.Caption:= '';

    Preview( QRListadoSalidasPaletsReport );
  finally
    DMBaseDatos.QListado.Close;
    FreeAndNil( slCodigo );
    FreeAndNil( slDescripcion );
    FreeAndNil( slPalets );
  end;
end;

procedure TFListadoSalidasPaletsForm.btnImprimirClick(Sender: TObject);
begin
  ValidarCampos;
  Listado(empresa.Text, centro.Text, producto.Text, cliente.Text, edtTransportista.Text,
          tipoPalet.Text, StrToDate( fechaDesde.Text ), StrToDate( fechaHasta.Text ) );
end;

function TFListadoSalidasPaletsForm.productoGetSQL: String;
begin
    result:= 'select producto_p, descripcion_p from frf_productos order by producto_p';
end;



function TFListadoSalidasPaletsForm.centroGetSQL: String;
begin
  if Empresa.Text <> '' then
    result:= 'select centro_c, descripcion_c from frf_centros where empresa_c = ' +
             Empresa.GetSQLText + ' order by centro_c'
  else
    result:= 'select centro_c, descripcion_c from frf_centros order by centro_c';
end;

function TFListadoSalidasPaletsForm.clienteGetSQL: String;
begin
  result:= 'select cliente_c, nombre_c from frf_clientes order by cliente_c';
end;

function TFListadoSalidasPaletsForm.tipoPaletGetSQL: String;
begin
  if Empresa.Text <> '' then
    result:= 'select codigo_tp, descripcion_tp from frf_tipo_palets ';
end;

procedure TFListadoSalidasPaletsForm.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    Vk_escape: btnCerrar.Click;
    vk_f1: btnImprimir.Click;
  end;
end;

procedure TFListadoSalidasPaletsForm.edtTransportistaChange(Sender: TObject);
var
  sAux: string;
begin
  sAux:= desTransporte( empresa.Text, edtTransportista.Text );
  if sAux <> '' then
  begin
    txtTransportista.Caption:= sAux;
  end
  else
  begin
    txtTransportista.Caption:= '(Opcional, vacio muestra todos)';
  end;
end;

function TFListadoSalidasPaletsForm.edtTransportistaGetSQL: string;
begin
  result:= ' select transporte_t, descripcion_t ' +
           ' from frf_transportistas ' +
           ' order by 1';
end;

procedure TFListadoSalidasPaletsForm.empresaChange(Sender: TObject);
var
  sAux: string;
begin
  sAux:= desEmpresa( empresa.Text );
  if sAux <> '' then
  begin
    stEmpresa.Caption:= sAux;
  end
  else
  begin
    stEmpresa.Caption:= '(Falta código de la empresa)';
  end;
end;

procedure TFListadoSalidasPaletsForm.centroChange(Sender: TObject);
var
  sAux: string;
begin
  sAux:= desCentro( empresa.Text, centro.Text );
  if sAux <> '' then
  begin
    stCentro.Caption:= sAux;
  end
  else
  begin
    stCentro.Caption:= '(Opcional, vacio muestra todos)';
  end;
end;

procedure TFListadoSalidasPaletsForm.productoChange(Sender: TObject);
var
  sAux: string;
begin
  sAux:= desProducto( empresa.Text, producto.Text );
  if sAux <> '' then
  begin
    stProducto.Caption:= sAux;
  end
  else
  begin
    stProducto.Caption:= '(Opcional, vacio muestra todos)';
  end;
end;

procedure TFListadoSalidasPaletsForm.tipoPaletChange(Sender: TObject);
var
  sAux: string;
begin
  sAux:= desTipoPalet( tipoPalet.Text );
  if sAux <> '' then
  begin
    stTipoPalet.Caption:= sAux;
  end
  else
  begin
    stTipoPalet.Caption:= '(Opcional, vacio muestra todos)';
  end;
end;

procedure TFListadoSalidasPaletsForm.clienteChange(Sender: TObject);
var
  sAux: string;
begin
  sAux:= desCliente( cliente.Text );
  if sAux <> '' then
  begin
    stCliente.Caption:= sAux;
  end
  else
  begin
    stCliente.Caption:= '(Opcional, vacio muestra todos)';
  end;
end;

end.
