unit AsignarTransitoFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, StdCtrls;

type
  TFDAsignarTransito = class(TForm)
    dbgrdTransitos: TDBGrid;
    dsTransitos: TDataSource;
    qryTransitos: TQuery;
    btnClose: TButton;
    lblKilosSal: TLabel;
    lblKilosTra: TLabel;
    btnAplicar: TButton;
    qrySalidas: TQuery;
    lblKilosPuedo: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    qryEnvase: TQuery;
    lbl4: TLabel;
    lblCajas: TLabel;
    lbl6: TLabel;
    lblPalets: TLabel;
    lbl8: TLabel;
    lblImporte: TLabel;
    lbl10: TLabel;
    lblIva: TLabel;
    lbl12: TLabel;
    lblTotal: TLabel;
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qryTransitosAfterScroll(DataSet: TDataSet);
    procedure btnAplicarClick(Sender: TObject);
  private
    { Private declarations }
    rKilosSal, rKilosTra: real;
    iCajasPuedo, iPaletsPuedo: integer;
    rKilosPuedo, rImportePuedo, rIvaPuedo, rTotalPuedo: real;

    procedure ActualizarKilos;
    procedure AplicarTransito;
    procedure GrabarTransito;
    procedure Actualizar;
    procedure Salir;
    procedure SepararLineaSalida;
    procedure PasaRegistro( const AFuente, ADestino: TDataSet );
    procedure GrabarKilosTransito;
    procedure RepartirLineaSegunEnvase;
    procedure RepartirLineaPesoFijo( const APesoCaja: real );
    procedure RepartirLineaPesoVar;
    procedure PintaEtiquetas;
    procedure DatosLinea;
  public
    { Public declarations }
    tablaSalidas: TTable;

    function LoadTransitos: boolean;

  end;

  procedure AsignarTransito( var AQuery: TTable );

implementation

{$R *.dfm}

uses
  DateUtils, bMath;

var
  FDAsignarTransito: TFDAsignarTransito;

procedure AsignarTransito( var AQuery: TTable );
begin
  Application.createForm( TFDAsignarTransito, FDAsignarTransito);
  try
    FDAsignarTransito.tablaSalidas:= AQuery;
    if FDAsignarTransito.LoadTransitos then
      FDAsignarTransito.ShowModal;
  finally
    FreeAndNil( FDAsignarTransito );
  end;
end;

procedure TFDAsignarTransito.btnCloseClick(Sender: TObject);
begin
  Salir;
end;

procedure TFDAsignarTransito.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  qryTransitos.Close;
end;

procedure TFDAsignarTransito.FormCreate(Sender: TObject);
begin
  with qryTransitos do
  begin
    Sql.Clear;
    Sql.Add('select empresa_tc, centro_tc, referencia_tc, fecha_tc, fecha_entrada_tc, producto_tl,  ');
    Sql.Add('       max(nvl(( ');
    Sql.Add('         select sum(kilos_sl) kilos_sal ');
    Sql.Add('         from frf_salidas_l ');
    Sql.Add('         where ( case when producto_sl = ''TOM'' then ''TOM'' else producto_sl end ) = producto_tl ');
    Sql.Add('         and empresa_sl = empresa_tc ');
    Sql.Add('         and centro_transito_sl = centro_tc ');
    Sql.Add('         and fecha_transito_sl = fecha_tc ');
    Sql.Add('         and ref_transitos_sl = referencia_tc ');
    Sql.Add('        ),0)) kilos_sal, ');
    Sql.Add('        sum(kilos_tl) kilos_tra ');
    Sql.Add('from frf_transitos_c ');
    Sql.Add('     join frf_transitos_l on empresa_tc = empresa_tl and centro_tc = centro_tl ');
    Sql.Add('                           and referencia_tc = referencia_tl and fecha_tc = fecha_tl ');
    Sql.Add('where empresa_tc = :empresa ');
    Sql.Add('and fecha_entrada_tc between :fechaini and :fechafin ');
    Sql.Add('and producto_tl = :producto ');
    Sql.Add('group by empresa_tc, centro_tc, referencia_tc, fecha_tc, fecha_entrada_tc, producto_tl ');
    Sql.Add('having max(nvl(( ');
    Sql.Add('         select sum(kilos_sl) kilos_sal ');
    Sql.Add('         from frf_salidas_l ');
    Sql.Add('         where ( case when producto_sl = ''TOM'' then ''TOM'' else producto_sl end ) = producto_tl ');
    Sql.Add('         and empresa_sl = empresa_tc ');
    Sql.Add('         and centro_transito_sl = centro_tc ');
    Sql.Add('         and fecha_transito_sl = fecha_tc ');
    Sql.Add('         and ref_transitos_sl = referencia_tc ');
    Sql.Add('        ),0)) < sum(kilos_tl) ');
    Sql.Add('order by fecha_entrada_tc ');
  end;

  with qrySalidas do
  begin
    Sql.Clear;
    Sql.Add('select * from frf_salidas_l ');
    RequestLive:= True;
  end;

  with qryEnvase do
  begin
    Sql.Clear;
    Sql.Add(' select peso_neto_e, peso_variable_e ');
    Sql.Add(' from frf_envases ');
    Sql.Add(' where envase_e = :envase ');
  end;
end;

function TFDAsignarTransito.LoadTransitos: boolean;
begin
  with qryTransitos do
  begin
    ParamByName('empresa').AsString:= tablaSalidas.FieldByname('empresa_sl').AsString;
    if tablaSalidas.FieldByname('producto_sl').AsString = 'TOM' then
      ParamByName('producto').AsString:= 'TOM'
    else
      ParamByName('producto').AsString:= tablaSalidas.FieldByname('producto_sl').AsString;
    ParamByName('fechafin').AsDateTime:= tablaSalidas.FieldByname('fecha_sl').AsDateTime;
    ParamByName('fechaini').AsDateTime:= IncDay( tablaSalidas.FieldByname('fecha_sl').AsDateTime, -60 );
    Open;
    result:= not isEmpty;
    if result then
      ActualizarKilos
    else
      ShowMessage('Sin tránsitos por asignar.');
  end;
end;

procedure TFDAsignarTransito.qryTransitosAfterScroll(DataSet: TDataSet);
begin
  ActualizarKilos;
end;

procedure TFDAsignarTransito.ActualizarKilos;
begin
  rKilosSal:= tablaSalidas.FieldByname('kilos_sl').AsFloat;
  rKilosTra:= qryTransitos.FieldByname('kilos_tra').asfloat-qryTransitos.FieldByname('kilos_sal').asfloat;
  if rKilosTra > rKilosSal then
  begin
    rKilosPuedo:= rKilosSal;
    DatosLinea;
  end
  else
  begin
    RepartirLineaSegunEnvase;
  end;
  PintaEtiquetas;
end;

procedure TFDAsignarTransito.PintaEtiquetas;
begin
  lblKilosSal.Caption:= FormatFloat('#,##0.00', rKilosSal);
  lblKilosTra.Caption:= FormatFloat('#,##0.00', rKilosTra);
  lblKilosPuedo.Caption:= FormatFloat('#,##0.00', rKilosPuedo);

  lblTotal.Caption:= FormatFloat('#,##0.00', rTotalPuedo);
  lblImporte.Caption:= FormatFloat('#,##0.00', rImportePuedo);
  lblIva.Caption:= FormatFloat('#,##0.00', rIvaPuedo);
  lblCajas.Caption:= FormatFloat('#,##0', iCajasPuedo);
  lblPalets.Caption:= FormatFloat('#,##0', iPaletsPuedo);
end;

procedure TFDAsignarTransito.btnAplicarClick(Sender: TObject);
begin
  AplicarTransito;
end;

procedure TFDAsignarTransito.AplicarTransito;
begin
  if rKilosPuedo > 0 then
  begin
    if rKilosSal < rKilosTra then
    begin
     GrabarTransito;
     Actualizar;
     Salir;
    end
    else
    begin
      SepararLineaSalida;
      Actualizar;
      Salir;
    end;
  end;
end;
                                                         
procedure TFDAsignarTransito.GrabarTransito;
var
  sAux: string;
begin
  sAux:= tablaSalidas.FieldByName('tipo_iva_sl').AsString;
  tablaSalidas.Edit;
  tablaSalidas.FieldByName('centro_origen_sl').AsString:= qryTransitos.FieldByname('centro_tc').AsString;
  tablaSalidas.FieldByName('centro_transito_sl').AsString:= qryTransitos.FieldByname('centro_tc').AsString;
  tablaSalidas.FieldByName('fecha_transito_sl').AsDateTime:= qryTransitos.FieldByname('fecha_tc').AsDateTime;
  tablaSalidas.FieldByName('ref_transitos_sl').Asinteger:= qryTransitos.FieldByname('referencia_tc').Asinteger;
  tablaSalidas.FieldByName('producto_sl').AsString:= qryTransitos.FieldByname('producto_tl').AsString;
  tablaSalidas.FieldByName('tipo_iva_sl').AsString:= sAux;
  try
    tablaSalidas.Post;
  except
    tablaSalidas.Cancel;
    raise;
  end;
end;

procedure TFDAsignarTransito.GrabarKilosTransito;
var
  sAux: string;
begin
  sAux:= tablaSalidas.FieldByName('tipo_iva_sl').AsString;
  tablaSalidas.Edit;
  tablaSalidas.FieldByName('centro_origen_sl').AsString:= qryTransitos.FieldByname('centro_tc').AsString;
  tablaSalidas.FieldByName('centro_transito_sl').AsString:= qryTransitos.FieldByname('centro_tc').AsString;
  tablaSalidas.FieldByName('fecha_transito_sl').AsDateTime:= qryTransitos.FieldByname('fecha_tc').AsDateTime;
  tablaSalidas.FieldByName('ref_transitos_sl').Asinteger:= qryTransitos.FieldByname('referencia_tc').Asinteger;
  tablaSalidas.FieldByName('producto_sl').AsString:= qryTransitos.FieldByname('producto_tl').AsString;

  tablaSalidas.FieldByName('kilos_sl').AsFloat:= rKilosPuedo;
  tablaSalidas.FieldByName('cajas_sl').AsInteger:= iCajasPuedo;
  tablaSalidas.FieldByName('n_palets_sl').AsInteger:= iPaletsPuedo;
  tablaSalidas.FieldByName('importe_neto_sl').AsFloat:= rImportePuedo;
  tablaSalidas.FieldByName('iva_sl').AsFloat:= rIvaPuedo;
  tablaSalidas.FieldByName('importe_total_sl').AsFloat:= rTotalPuedo;

  tablaSalidas.FieldByName('tipo_iva_sl').AsString:= sAux;  
  try
    tablaSalidas.Post;
  except
    tablaSalidas.Cancel;
    raise;
  end;
end;

procedure TFDAsignarTransito.Actualizar;
begin
  tablaSalidas.Close;
  tablaSalidas.Open;
end;

procedure TFDAsignarTransito.Salir;
begin
  Close;
end;

procedure TFDAsignarTransito.PasaRegistro( const AFuente, ADestino: TDataSet );
var
  i: integer;
  //sAux: string;
  campo: TField;
begin
  ADestino.Insert;
  i:= 0;
  while i < ADestino.Fields.Count do
  begin
    campo:= AFuente.FindField(ADestino.Fields[i].FieldName);
    if campo <> nil then
    begin
      ADestino.Fields[i].Value:= campo.Value;
    end;
    inc( i );
  end;

  ADestino.FieldByName('kilos_sl').AsFloat:= ADestino.FieldByName('kilos_sl').AsFloat - rKilosPuedo;
  ADestino.FieldByName('cajas_sl').AsInteger:= ADestino.FieldByName('cajas_sl').AsInteger - iCajasPuedo;
  ADestino.FieldByName('n_palets_sl').AsInteger:= ADestino.FieldByName('n_palets_sl').AsInteger - iPaletsPuedo;
  ADestino.FieldByName('importe_neto_sl').AsFloat:= ADestino.FieldByName('importe_neto_sl').AsFloat - rImportePuedo;
  ADestino.FieldByName('iva_sl').AsFloat:= ADestino.FieldByName('iva_sl').AsFloat - rIvaPuedo;
  ADestino.FieldByName('importe_total_sl').AsFloat:= ADestino.FieldByName('importe_total_sl').AsFloat - rTotalPuedo;

  try
    ADestino.Post;
  except
    tablaSalidas.Cancel;
    raise;
  end;
end;

procedure TFDAsignarTransito.SepararLineaSalida;
begin
  qrySalidas.Open;
  PasaRegistro( tablaSalidas, qrySalidas );
  qrySalidas.Close;
  GrabarKilosTransito;
end;

procedure TFDAsignarTransito.RepartirLineaSegunEnvase;
begin
  with qryEnvase do
  begin
    ParamByName('envase').AsString:= tablaSalidas.FieldByname('envase_sl').AsString;
    Open;
    if FieldByName('peso_variable_e').AsInteger = 0 then
      RepartirLineaPesoFijo( FieldByName('peso_neto_e').AsFloat )
    else
      RepartirLineaPesoVar;
    Close;
  end;
end;

procedure TFDAsignarTransito.RepartirLineaPesoFijo( const APesoCaja: real );
begin
  rKilosPuedo:= Trunc( rKilosTra/APesoCaja) *  APesoCaja;
  DatosLinea;
end;

procedure TFDAsignarTransito.RepartirLineaPesoVar;
begin
  rKilosPuedo:= rKilosTra;
  DatosLinea;
end;

procedure TFDAsignarTransito.DatosLinea;
begin
  iCajasPuedo:= Trunc( ( tablaSalidas.FieldByname('cajas_sl').AsInteger * rKilosPuedo ) / tablaSalidas.FieldByname('kilos_sl').AsFloat );
  iPaletsPuedo:= Trunc( ( tablaSalidas.FieldByname('n_palets_sl').AsInteger * rKilosPuedo ) / tablaSalidas.FieldByname('kilos_sl').AsFloat );
  if tablaSalidas.FieldByname('unidad_precio_sl').AsString = 'KGS' then
    rImportePuedo:=  bRoundTo( rKilosPuedo * tablaSalidas.FieldByname('precio_sl').AsFloat, 2 )
  else
  if tablaSalidas.FieldByname('unidad_precio_sl').AsString = 'UND' then
    rImportePuedo:=  bRoundTo( iCajasPuedo * tablaSalidas.FieldByname('unidades_caja_sl').AsFloat * tablaSalidas.FieldByname('precio_sl').AsFloat, 2 )
  else
  if tablaSalidas.FieldByname('unidad_precio_sl').AsString = 'CAJ' then
    rImportePuedo:=  bRoundTo( iCajasPuedo * tablaSalidas.FieldByname('precio_sl').AsFloat, 2 );
  rIvaPuedo:=  bRoundTo( rImportePuedo * tablaSalidas.FieldByname('porc_iva_sl').AsFloat, 2 );
  rTotalPuedo:= rImportePuedo + rIvaPuedo;
end;

end.
