unit EntradasSalidasFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, StdCtrls, BEdit;

type
  TFLEntradasSalidas = class(TForm)
    gridSalidas: TDBGrid;
    qrySalidas: TQuery;
    dsSalidas: TDataSource;
    btnAceptar: TButton;
    btnCancelar: TButton;
    edtCentro: TBEdit;
    edtSalida: TBEdit;
    edtfecha: TBEdit;
    edtKilos: TBEdit;
    lblCentro: TLabel;
    lbAlbaran: TLabel;
    lblFecha: TLabel;
    lblKilos: TLabel;
    lblDesCentro: TLabel;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure gridSalidasCellClick(Column: TColumn);
    procedure edtCentroChange(Sender: TObject);
  private
    { Private declarations }
    bAceptar: Boolean;
    sEmpresa, sCentro, sProducto: string;
    iEntrada: Integer;
    dFecha: TDateTime;
    rKilosIn, rKilosOut: Real;

   function  QuerySalidas: Boolean;
   function  VerificarDatos: Boolean;

  public
    { Public declarations }
  end;

  function NuevaEntrada( const AOwner: TComponent;
                         const AEmpresa, ACentro, AProducto: string;
                         const AEntrada: Integer;
                         const AFecha: TDateTime;
                         const AKilos: real ): boolean;





implementation

{$R *.dfm}

uses
  UDMAuxDB, EntradasSalidasDM;

var
  FLEntradasSalidas: TFLEntradasSalidas;

function NuevaEntrada( const AOwner: TComponent; const AEmpresa, ACentro, AProducto: string; const AEntrada: Integer;
                       const AFecha: TDateTime; const AKilos: real ): boolean;
begin
  if AKilos > 0 then
  begin
    FLEntradasSalidas:= TFLEntradasSalidas.Create( AOwner );
    try
      with FLEntradasSalidas do
      begin
        rKilosIn:= AKilos;
        sEmpresa:= AEmpresa;
        sCentro:= ACentro;
        sProducto:= AProducto;
        dFecha:= AFecha;
        iEntrada:= AEntrada;

        Caption:= '   ASIGNAR SALIDA --> FALTAN ' + FloatToStr( rKilosIn ) + ' KILOS.';
        if QuerySalidas then
        begin
          ShowModal;
          qrySalidas.Close;
          Result:= bAceptar;
        end
        else
        begin
          qrySalidas.Close;
          ShowMessage('No quedan salidas con kilos pendientes de asignar.');
          Result:= False;
        end;
      end;
    finally
      FreeAndNil( FLEntradasSalidas );
    end;
  end
  else
  begin
    ShowMessage('Ya han sido asignados todos los kilos de la entrada.');
    Result:= False;
  end;
end;

procedure TFLEntradasSalidas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caHide;
end;

procedure TFLEntradasSalidas.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if bAceptar then
  begin
    if VerificarDatos then
    begin
      EntradasSalidasDM.InsertarSalidaAsignada( Self, sEmpresa, sCentro, dFecha, iEntrada,
                                                qrySalidas.fieldByname('centro_salida_sl').AsString,
                                                qrySalidas.fieldByname('fecha_sl').AsDateTime,
                                                qrySalidas.fieldByname('n_albaran_sl').AsInteger,
                                                sProducto, qrySalidas.fieldByname('tipo').AsString,
                                                StrToFloat( edtKilos.Text ) ) ;
    end
    else
    begin
      CanClose:= False;
    end;
  end
  else
  begin
    bAceptar:= False;
    ShowMessage('Operacion cancelada.');
  end;
end;

procedure TFLEntradasSalidas.btnAceptarClick(Sender: TObject);
begin
  bAceptar:= True;
  Close;
end;

procedure TFLEntradasSalidas.btnCancelarClick(Sender: TObject);
begin
  bAceptar:= False;
  Close;
end;

function TFLEntradasSalidas.QuerySalidas: boolean;
begin
  with qrySalidas do
  begin
    SQL.Clear;
    SQL.Add(' ( ');
    SQL.Add(' select empresa_sl, centro_salida_sl, n_albaran_sl, fecha_sl, centro_origen_sl, producto_sl, cliente_sl cliente, ''SALIDA'' tipo, sum(kilos_sl) kilos_sl, ');
    SQL.Add('         sum(kilos_sl)- nvl( ( select sum(kilos_es) from frf_entradas_sal where empresa_es = empresa_sl and centro_salida_es = centro_salida_sl ');
    SQL.Add('                              and fecha_salida_es = fecha_sl and n_salida_es = n_albaran_sl ');
    SQL.Add('                              and transito_es = 0 ), 0) kilos_pendientes ');
    SQL.Add('  from frf_salidas_l ');
    SQL.Add('  where empresa_sl = :empresa ');
    SQL.Add('  and centro_salida_sl = :centro ');
    SQL.Add('  and fecha_sl >= :fecha ');
    SQL.Add('  and producto_sl = :producto ');
    SQL.Add('  group by empresa_sl, centro_salida_sl, n_albaran_sl, fecha_sl, centro_origen_sl, producto_sl, cliente_sl ');
    SQL.Add('  having nvl( ( select sum(kilos_es) from frf_entradas_sal where empresa_es = empresa_sl and centro_salida_es = centro_salida_sl ');
    SQL.Add('                              and fecha_salida_es = fecha_sl and n_salida_es = n_albaran_sl  ');
    SQL.Add('                              and transito_es = 0 ), 0) < sum(kilos_sl) ');
    SQL.Add(' ) ');
    SQL.Add(' union ');
    SQL.Add(' ( ');
    SQL.Add(' select empresa_tl, centro_tl, referencia_tl, fecha_tl, centro_origen_tl, producto_tl, '''' Cliente, ''TRANSITO'' tipo, sum(kilos_tl) kilos_tl, ');
    SQL.Add('         sum(kilos_tl)- nvl( ( select sum(kilos_es) from frf_entradas_sal where empresa_es = empresa_tl and centro_salida_es = centro_tl ');
    SQL.Add('                              and fecha_salida_es = fecha_tl and n_salida_es = referencia_tl  ');
    SQL.Add('                              and transito_es = 1 ), 0) kilos_pendientes ');
    SQL.Add('  from frf_transitos_l ');
    SQL.Add('  where empresa_tl = :empresa ');
    SQL.Add('  and centro_tl = :centro ');
    SQL.Add('  and fecha_tl >= :fecha ');
    SQL.Add('  and producto_tl = :producto ');
    SQL.Add('  group by empresa_tl, centro_tl, referencia_tl, fecha_tl, centro_origen_tl, producto_tl, 7 ');
    SQL.Add('  having nvl( ( select sum(kilos_es) from frf_entradas_sal where empresa_es = empresa_tl and centro_salida_es = centro_tl ');
    SQL.Add('                              and fecha_salida_es = fecha_tl and n_salida_es = referencia_tl  ');
    SQL.Add('                              and transito_es = 1 ), 0) < sum(kilos_tl) ');
    SQL.Add(' ) ');
    SQL.Add('  order by 1,2,4,3,5,6 ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('producto').AsString:= sProducto;
    ParamByName('fecha').Asdate:= dFecha;
    Open;
    result:= not IsEmpty;
  end;
end;

function TFLEntradasSalidas.VerificarDatos: Boolean;
begin
  result:= False;
  rKilosOut:= StrToFloatDef( edtKilos.Text , 0 );
  if edtCentro.Text = '' then
  begin
    ShowMessage('Debe seleccionar una salida.');
  end
  else
  if rKilosOut <= 0 then
  begin
    ShowMessage('Debe seleccionar una cantidad de kilos positiva mayor que 0.');
  end
  else
  if rKilosOut > rKilosIn then
  begin
    ShowMessage('Como maximo son necesarios ' + FloatToStr( rKilosIn) + ' kilos.');
  end
  else
  if rKilosOut > qrySalidas.FieldByName('kilos_pendientes').AsFloat then
  begin
    ShowMessage('Como maximo son seleccionables ' + FloatToStr( qrySalidas.FieldByName('kilos_pendientes').AsFloat) + ' kilos.');
  end
  else
  begin
    result:= True;
  end;
end;

procedure TFLEntradasSalidas.gridSalidasCellClick(Column: TColumn);
begin
  edtCentro.Text:= qrySalidas.FieldByName('centro_salida_sl').AsString;
  edtSalida.Text:= qrySalidas.FieldByName('n_albaran_sl').AsString;
  edtfecha.Text:= qrySalidas.FieldByName('fecha_sl').AsString;
  if qrySalidas.FieldByName('kilos_pendientes').AsFloat > rKilosIn then
    edtKilos.Text:= FloatToStr(rKilosIn)
  else
    edtKilos.Text:= qrySalidas.FieldByName('kilos_pendientes').AsString;
end;

procedure TFLEntradasSalidas.edtCentroChange(Sender: TObject);
begin
  lblDesCentro.Caption:= DesCentro( sEmpresa, edtCentro.Text );
end;

end.
