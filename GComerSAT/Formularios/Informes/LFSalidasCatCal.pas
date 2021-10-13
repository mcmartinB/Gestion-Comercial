unit LFSalidasCatCal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, BEdit, Buttons, BSpeedButton, BGridButton, ExtCtrls,
  BCalendarButton, Grids, DBGrids, BGrid, ComCtrls, BCalendario, ActnList,
  Db, DBTables;

type
  TFLSalidasCatCal = class(TForm)
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ListaAcciones: TActionList;
    BAceptar: TAction;
    ADesplegarRejilla: TAction;
    ACancelar: TAction;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    QDatos: TQuery;
    Label1: TLabel;
    EEmpresa: TBEdit;
    BGBEmpresa: TBGridButton;
    STEmpresa: TStaticText;
    Label5: TLabel;
    edtcentroOrigen: TBEdit;
    Label2: TLabel;
    edtproducto: TBEdit;
    Desde: TLabel;
    MEDesde: TBEdit;
    BCBDesde: TBCalendarButton;
    Label14: TLabel;
    MEHasta: TBEdit;
    BCBHasta: TBCalendarButton;
    Label4: TLabel;
    edtcliente: TBEdit;
    btnCentroOrigen: TBGridButton;
    txtCentroOrigen: TStaticText;
    btnProducto: TBGridButton;
    txtProducto: TStaticText;
    btnCliente: TBGridButton;
    txtCliente: TStaticText;
    lblCentroSalida: TLabel;
    edtCentroSalida: TBEdit;
    btnCentroSalida: TBGridButton;
    txtCentroSalida: TStaticText;
    lblCategoria: TLabel;
    edtCategoria: TBEdit;
    lbl1: TLabel;
    chkComerciales: TCheckBox;
    chkIgnorarRet: TCheckBox;
    rbCatCal: TRadioButton;
    rbCat: TRadioButton;
    rbCal: TRadioButton;
    lbl2: TLabel;
    procedure BAceptarExecute(Sender: TObject);
    procedure ACancelarExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sCentroOrigen, sCentroSalida, sProducto, sCliente, sCategoria: string;
    dfechaIni, dfechaFin: TDateTime;
    bComercial, bIgnorarRet, bCategoria, bCalibre: Boolean;

    function RecogerDatos: Boolean;
    procedure PreparaQuerys;
    function Temporal: boolean;
    function Listado: boolean;
  public
    { Public declarations }
  end;

//var
//  FLSalidasCatCal: TFLSalidasCatCal;

implementation

uses CAuxiliarDB, cVariables, UDMAuxDB, LSalidasCatCal, DPreview,
  UDMBaseDatos, CGestionPrincipal, CReportes, Principal;

{$R *.DFM}

procedure TFLSalidasCatCal.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  EEmpresa.Tag := kEmpresa;
  edtcentroOrigen.Tag := kCentro;
  edtcentroSalida.Tag := kCentro;
  edtproducto.Tag:= kProducto;
  edtcliente.Tag:= kCliente;
  MEDesde.Tag := kCalendar;
  MEHasta.Tag := kCalendar;

  edtcentroOrigen.Text:= '';
  edtCentroSalida.Text:= '';
  edtproducto.Text:= '';
  MEDesde.Text:= DateToStr( Date - 6 );
  MEHasta.Text:= DateToStr( Date );
  edtcliente.Text:= '';
  EEmpresa.Text:= gsDefEmpresa;


  calendarioFlotante.Date:= Date;

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := calendarioFlotante;

  (*
  QDatos.Sql.Clear;
  QDatos.Sql.Add('select empresa_sl, cliente_sl, categoria_sl categoria, calibre_sl calibre, sum(kilos_sl)kilos,');
  QDatos.Sql.Add('year(fecha_sl)anyo, month(fecha_sl)mes, producto_sl producto');
  QDatos.Sql.Add('from frf_salidas_l');
  QDatos.Sql.Add('where (empresa_sl= :emp)');
  QDatos.Sql.Add('and   (centro_origen_sl between :ctr_d and :ctr_h)');
  QDatos.Sql.Add('and   (fecha_sl between :fec_d and :fec_h)');
  QDatos.Sql.Add('and   (producto_sl between :pro_d and :pro_h)');
  QDatos.Sql.Add('and   (cliente_sl between :clt_d and :clt_h)');
  QDatos.Sql.Add('and   (cliente_sl <> ''RET'')');
  QDatos.Sql.Add('group by empresa_sl, cliente_sl, producto_sl, categoria_sl, calibre_sl, fecha_sl');
  QDatos.Sql.Add('order by cliente_sl, categoria_sl, calibre_sl');
  QDatos.Sql.Add('into temp cat_cal');
  QDatos.Prepare;
  *)
end;

procedure TFLSalidasCatCal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     if FPrincipal.MDIChildCount = 1 then
     begin
        FormType:=tfDirector;
        BHFormulario;
     end;
    Action:=caFree;

end;

procedure TFLSalidasCatCal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
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

procedure TFLSalidasCatCal.BAceptarExecute(Sender: TObject);
begin
  if RecogerDatos then
  begin
    PreparaQuerys;
    Temporal;
    Listado;
    try
      QDatos.SQL.Clear;
      QDatos.SQL.Add('drop table cat_cal');
      QDatos.ExecSQL;
    except
      //ya vorem
    end;
  end;
end;

function TFLSalidasCatCal.RecogerDatos: Boolean;
begin
  Result:= False;
  if STEmpresa.Caption = '' then
  begin
    ShowMessage('Falta el código de la empresa o es incorrecto');
    EEmpresa.SetFocus;
    Exit;
  end;
  sEmpresa := Trim( EEmpresa.Text );

  if txtCentroOrigen.Caption = '' then
  begin
    ShowMessage('El código del centro es incorrecto');
    edtcentroOrigen.SetFocus;
    Exit;
  end;
  sCentroOrigen := Trim( edtCentroOrigen.Text );
  if txtCentroSalida.Caption = '' then
  begin
    ShowMessage('El código del centro es incorrecto');
    edtcentroSalida.SetFocus;
    Exit;
  end;
  sCentroSalida := Trim( edtCentroSalida.Text );

  if txtProducto.Caption = '' then
  begin
    ShowMessage('El código del producto es incorrecto');
    edtproducto.SetFocus;
    Exit;
  end;
  sproducto := Trim( edtproducto.Text );

  if txtCliente.Caption = '' then
  begin
    ShowMessage('El código del cliente es incorrecto');
    edtcliente.SetFocus;
    Exit;
  end;
  scliente := Trim( edtcliente.Text );
  bIgnorarRet:= chkIgnorarRet.Checked;

  scategoria:= Trim( edtCategoria.Text );
  bComercial:= chkComerciales.Checked;

  if rbCatCal.Checked then
  begin
    bCategoria:= True;
    bCalibre:= True;
  end
  else
  if rbCat.Checked then
  begin
    bCategoria:= True;
    bCalibre:= False;
  end
  else
  begin
    bCategoria:= False;
    bCalibre:= True;
  end;

  if not TryStrToDate( MEDesde.Text, dFechaIni ) then
  begin
    ShowMessage('La fecha de inicio es incorrecta');
    MEDesde.SetFocus;
    Exit;
  end;
  if not TryStrToDate( MEHasta.Text, dFechaFin ) then
  begin
    ShowMessage('La fecha de fin es incorrecta');
    MEHasta.SetFocus;
    Exit;
  end;
  if dfechaIni > dfechaFin then
  begin
    ShowMessage('Rango de fechas incorrecto');
    MEDesde.SetFocus;
    Exit;
  end;
  Result:= True;
end;

procedure TFLSalidasCatCal.PreparaQuerys;
begin
  with QDatos do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_sl, cliente_sl, producto_sl producto, ');

    if bCategoria then
      SQL.Add(' categoria_sl categoria, ')
    else
      SQL.Add(' 0 categoria, ');
    if bCalibre then
      SQL.Add(' calibre_sl calibre, ')
    else
      SQL.Add(' 0 calibre, ');
    SQL.Add('        year(fecha_sl)anyo, month(fecha_sl)mes,  ');
    SQL.Add('        sum(kilos_sl)kilos, sum(cajas_sl) cajas ');
    SQL.Add(' from frf_salidas_c, frf_salidas_l ');
    SQL.Add(' where (empresa_sl= :emp) ');
    SQL.Add(' and   (fecha_sl between :fec_d and :fec_h) ');

    SQL.Add(' and empresa_sc = empresa_sl ');
    SQL.Add(' and centro_salida_sc = centro_salida_sl ');
    SQL.Add(' and n_albaran_sc = n_albaran_sl ');
    SQL.Add(' and fecha_sc = fecha_sl ');

    SQL.Add(' and es_transito_sc <> 2 ');         //Tipo Salida: Devolucion

    if sCentroOrigen <> '' then
      SQL.Add(' and   (centro_origen_sl = :origen) ');
    if sCentroSalida <> '' then
      SQL.Add(' and   (centro_salida_sl = :salida) ');
    if sProducto <> '' then
      SQL.Add(' and   (producto_sl = :producto ) ');
    if sCliente <> '' then
      SQL.Add(' and   (cliente_sl = :cliente ) ');
    if bIgnorarRet and ( sCliente <> 'RET' ) then
      SQL.Add(' and   (cliente_sl <> ''RET'') ');

    if sCategoria <> '' then
    begin
      SQL.Add(' and   (categoria_sl  = :categoria ) ');
    end
    else
    begin
      if bComercial then
        SQL.Add(' and   (categoria_sl  = ''1'' or categoria_sl  = ''2'' or categoria_sl  = ''3'' ) ');
    end;

    //SQL.Add(' --and   calibre_sl in ('G','g','GG','gg','MMM','mmm') ');
    SQL.Add(' group by 1,2,3,4,5,6,7');
    SQL.Add(' into temp cat_cal ');
  end;
end;



function TFLSalidasCatCal.Temporal: boolean;
begin
  //pasar los parametros y abir la temporal;
  with QDatos do
  begin
    Close;
    ParamByName('emp').AsString := sEmpresa;
    ParamByName('fec_d').AsDate := dfechaIni;
    ParamByName('fec_h').AsDate := dfechaFin;

    if sCentroOrigen <> '' then
      ParamByName('origen').AsString := sCentroOrigen;
    if sCentrosalida <> '' then
      ParamByName('salida').AsString := sCentroSalida;

    if sCliente <> '' then
      ParamByName('cliente').AsString := sCliente;
    if sProducto <> '' then
      ParamByName('producto').AsString := sProducto;
    if sCategoria <> '' then
      ParamByName('categoria').AsString := sCategoria;
    ExecSQL;
  end;
  result := false;
end;

function TFLSalidasCatCal.Listado: boolean;
begin
  result := false;
  //Llamada al report que mostrara el informe
  QRLSalidasCatCal := TQRLSalidasCatCal.Create(Application);
  PonLogoGrupoBonnysa(QRLSalidasCatCal, EEmpresa.Text);

  with QRLSalidasCatCal.QListado do
  begin
    SQL.Clear;
    SQL.Add(' select cliente_sl cliente, anyo, mes, producto, categoria, calibre, ');
    SQL.Add('        sum(kilos) kilos, sum(cajas) cajas ');
    SQL.Add(' from cat_cal ');
    SQL.Add(' group by 1, anyo, mes, producto, categoria, calibre ');
    SQL.Add(' order by 1, producto, anyo, mes,  categoria, calibre ');
  end;
  QRLSalidasCatCal.QListado.Open;

  QRLSalidasCatCal.sEmpresa:= sEmpresa;
  QRLSalidasCatCal.bCategoria:= bCategoria;
  QRLSalidasCatCal.bCalibre:= bCalibre;
  QRLSalidasCatCal.qlCentroOrigen.Caption:= txtCentroOrigen.Caption;
  QRLSalidasCatCal.qlCentroSalida.Caption:= txtCentroSalida.Caption;
  QRLSalidasCatCal.lblProductos.Caption:= txtProducto.Caption;
  QRLSalidasCatCal.lblRango.Caption:= RangoFechas( MEDesde.Text, MEHasta.Text );

  Preview(QRLSalidasCatCal);
end;

procedure TFLSalidasCatCal.ACancelarExecute(Sender: TObject);
begin
  if cerrarform(false) then Close;
end;

procedure TFLSalidasCatCal.PonNombre(Sender: TObject);
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
       STEmpresa.Caption := desEmpresa(Eempresa.Text);
       PonNombre( edtcentroOrigen );
       PonNombre( edtCentroSalida );
       PonNombre( edtcliente );
       PonNombre( edtproducto );
    end;
    kCentro:
    begin
      if TEdit( Sender ).Name = 'edtcentroOrigen' then
      begin
        if edtcentroOrigen.Text = '' then
          txtCentroOrigen.Caption := 'TODOS LOS CENTROS DE ORIGEN.'
        else
          txtCentroOrigen.Caption := desCentro(Eempresa.Text, edtcentroOrigen.Text );
      end
      else
      begin
        if edtcentroSalida.Text = '' then
          txtCentroSalida.Caption := 'TODOS LOS CENTROS DE SALIDA.'
        else
          txtCentroSalida.Caption := desCentro(Eempresa.Text, edtcentroSalida.Text );
      end;
    end;
    kProducto:
    begin
      if edtproducto.Text = '' then
        txtProducto.Caption := 'TODOS LOS PRODUCTOS.'
      else
        txtProducto.Caption := desProducto(Eempresa.Text, edtproducto.Text );
    end;
    kCliente:
    begin
      if edtcliente.Text = '' then
        txtCliente.Caption := 'TODOS LOS CLIENTES.'
      else
        txtCliente.Caption := desCliente(edtcliente.Text );
    end;
  end;
end;

procedure TFLSalidasCatCal.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCentro:
    begin
      if edtcentroOrigen.Focused then
        DespliegaRejilla(btnCentroOrigen,[eempresa.Text])
      else
        DespliegaRejilla(btnCentroSalida,[eempresa.Text]);
    end;
    kCliente: DespliegaRejilla(btnCliente,[eempresa.Text]);
    kProducto: DespliegaRejilla(btnProducto,[eempresa.Text]);
    kCalendar:
      begin
        if MEDesde.Focused then
          DespliegaCalendario(BCBDesde)
        else
          DespliegaCalendario(BCBHasta);
      end;
  end;
end;

procedure TFLSalidasCatCal.FormActivate(Sender: TObject);
begin
  Top := 10;
end;

end.
