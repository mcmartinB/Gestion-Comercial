unit VerOrdenFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, ExtCtrls, StdCtrls;

type
  TFDVerOrden = class(TForm)
    qryCabOrden: TQuery;
    dsCab: TDataSource;
    pnl1: TPanel;
    dbgrdCa: TDBGrid;
    btnDesadv: TButton;
    dbgrdLin: TDBGrid;
    qryPacking: TQuery;
    dsLin: TDataSource;
    btnSalir: TButton;
    procedure FormCreate(Sender: TObject);
    procedure qryCabOrdenAfterOpen(DataSet: TDataSet);
    procedure qryCabOrdenBeforeClose(DataSet: TDataSet);
    procedure btnDesadvClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSalirClick(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sCentro: string;
    iALbaran: integer;
    dFecha: TDateTime;
  public
    { Public declarations }
    procedure LoadData( const AEmpresa, ACentro: string; const AALbaran: integer; const AFecha: TDateTime );
  end;

  procedure MakeDsadv( const AEmpresa, ACentro: string; const AALbaran: integer; const AFecha: TDateTime );


implementation

uses
  DesadvCorteInglesDM, DesadvAhorramasDM, CSistema, DError;

{$R *.dfm}

procedure TFDVerOrden.FormCreate(Sender: TObject);
begin
  with qryCabOrden do
  begin
    sql.clear;
    sql.Add(' select orden_occ orden_carga, hora_occ hora_carga, cliente_sal_occ cliente, ');
    sql.Add('        dir_sum_occ suministro, n_pedido_occ n_pedido, fecha_pedido_occ fecha_pedido, ');
    sql.Add('        depto_occ departamento ');
    sql.Add(' from frf_orden_carga_c ');
    sql.Add(' where empresa_occ = :empresa ');
    sql.Add(' and centro_salida_occ = :centro ');
    sql.Add(' and fecha_occ = :fecha ');
    sql.Add(' and n_albaran_occ = :albaran ');
  end;

  with qryPacking do
  begin
    sql.clear;
    sql.Add(' select ean128_pl, tipo_palet_pl, descripcion_tp, producto_pl, producto_base_pl, ');
    sql.Add('        ean13_pl, envase_pl, cajas_pl, peso_pl, ');  //peso_pl es bruto o neto
    sql.Add('        envase_e, descripcion_e, ean13_e, peso_envase_e, peso_neto_e, peso_variable_e, ');
    sql.Add('        unidades_e, unidades_variable_e, tipo_unidad_e, lote_pl, caducidad_pl ');
    sql.Add(' from frf_packing_list  ');
    sql.Add('                         left join frf_envases on envase_e = envase_pl ');
    sql.Add('                                             and producto_e = producto_pl ');
    sql.Add('                         left join frf_tipo_palets on codigo_tp = tipo_palet_pl ');
    sql.Add(' where orden_pl = :orden_carga ');
    sql.Add(' order by ean128_pl, ean13_pl ');
  end;

end;

procedure TFDVerOrden.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qryCabOrden.Close;
end;

procedure TFDVerOrden.qryCabOrdenAfterOpen(DataSet: TDataSet);
begin
  qryPacking.Open;
end;

procedure TFDVerOrden.qryCabOrdenBeforeClose(DataSet: TDataSet);
begin
  qryPacking.Close;
end;

procedure MakeDsadv( const AEmpresa, ACentro: string; const AALbaran: integer; const AFecha: TDateTime );
var
  FDVerOrden: TFDVerOrden;
begin
  Application.CreateForm(TFDVerOrden, FDVerOrden);
  try
    FDVerOrden.LoadData( AEmpresa, ACentro, AALbaran, AFecha );
    FDVerOrden.ShowModal;
  finally
    FreeAndNil( FDVerOrden );
  end;
end;

procedure TFDVerOrden.LoadData( const AEmpresa, ACentro: string; const AALbaran: integer; const AFecha: TDateTime );
begin
  sEmpresa:= AEmpresa;
  sCentro:= ACentro;
  iALbaran:= AALbaran;
  dFecha:= AFecha;

  qryCabOrden.ParamByName('empresa').AsString:= AEmpresa;
  qryCabOrden.ParamByName('centro').AsString:= ACentro;
  qryCabOrden.ParamByName('fecha').AsDateTime:= AFecha;
  qryCabOrden.ParamByName('albaran').AsInteger:= AALbaran;
  qryCabOrden.Open;
end;

procedure TFDVerOrden.btnDesadvClick(Sender: TObject);
var
  sMsg: string;
begin
  sMsg:= '';

  if FileExists( 'C:\ASPEDI\PRODUCCION\SUBIR.BAT' ) then
  begin
    if (qryCabOrden.fieldByname('cliente').AsString = 'ECI') or (qryCabOrden.fieldByname('cliente').AsString = 'SOK')
    then
    begin
      if DesadvCorteInglesDM.CrearFicherosDesadv( Self, sEmpresa,sCentro, iAlbaran, dFecha,
                                    qryCabOrden.fieldByname('cliente').AsString,
                                    qryCabOrden.fieldByname('suministro').AsString,
                                    sMsg )   then
      begin
        //ShowMessage('OK --> Desadv creado con exito.');
        if ExecNewProcess( 'C:\ASPEDI\PRODUCCION\SUBIR.BAT', True ) then
          ShowMessage('OK --> Desadv creado con exito.')
        else
          ShowMessage('ERROR --> C:\ASPEDI\PRODUCCION\SUBIR.BAT' );
      end
      else
      begin
        DError.ShowError( sMsg );
      end;
    end
    else
    if  (qryCabOrden.fieldByname('cliente').AsString = 'AMA') or (qryCabOrden.fieldByname('cliente').AsString = 'MER') then
    begin
      if DesadvAhorramasDM.CrearFicherosDesadv( Self, sEmpresa,sCentro, iAlbaran, dFecha,
                                    qryCabOrden.fieldByname('cliente').AsString,
                                    qryCabOrden.fieldByname('suministro').AsString,
                                    sMsg )   then
      begin
        //ShowMessage('OK --> Desadv creado con exito.');
        if ExecNewProcess( 'C:\ASPEDI\PRODUCCION\SUBIR.BAT', True ) then
          ShowMessage('OK --> Desadv creado con exito.')
        else
          ShowMessage('ERROR --> C:\ASPEDI\PRODUCCION\SUBIR.BAT' );
      end
      else
      begin
        DError.ShowError( sMsg );
      end;
    end
    else
    begin
      ShowMessage('Cliente no valido.');
    end;
  end
  else
  begin
    ShowMessage('Falta instalar el programa para subir ficheros a EDI.');
  end;

  Close;
end;


procedure TFDVerOrden.btnSalirClick(Sender: TObject);
begin
  Close;
end;

end.
