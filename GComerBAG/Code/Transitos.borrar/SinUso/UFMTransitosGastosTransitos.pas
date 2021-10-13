unit UFMTransitosGastosTransitos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  BCalendarButton, ComCtrls, BCalendario, BEdit, dbTables,
  DError, CVariables, StrUtils, DBActns, StdActns;

type
  TFMTransitosGastosTransitos = class(TForm)
    rejilla: TDBGrid;
    DSSalidasPosibles: TDataSource;
    QSalidasPosibles: TQuery;
    DBGrid1: TDBGrid;
    QSalidasSeleccionadas: TQuery;
    DSEntregasSeleccionadas: TDataSource;
    btnCerrar: TButton;
    btnAnyadir: TButton;
    btnBorrar: TButton;
    QSBorrar: TQuery;
    QSAnyadir: TQuery;
    lblNombre4: TLabel;
    lblNombre1: TLabel;
    lblMatricula: TLabel;
    edtMatricula: TEdit;
    btnFiltar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCerrarClick(Sender: TObject);
    procedure btnBorrarClick(Sender: TObject);
    procedure btnAnyadirClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure rejillaDblClick(Sender: TObject);
    procedure btnFiltarClick(Sender: TObject);


  private

    sEmpresa: string;
    bGastoModificado: boolean;

    procedure ReOpen;
    procedure Borrar;
    procedure Anyadir;
  public
    { Public declarations }

    procedure CargaParametros( const AEmpresa: string; const AServicio: integer;
                               const AFecha: TDateTime; const AMatricula: string );
    function GastosModificados: boolean;
  end;

var
  FMTransitosGastosTransitos: TFMTransitosGastosTransitos;

implementation

uses bDialogs, UDMBaseDatos, CAuxiliarDB, Principal, bSQLUtils,
     DConversor, uDMAuxDB;

{$R *.DFM}

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMTransitosGastosTransitos.CargaParametros( const AEmpresa: string; const AServicio: integer;
                                              const AFecha: TDateTime; const AMatricula: string );
begin
  edtMatricula.Text:= '*' + AMatricula + '*';
  with QSalidasPosibles do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('fecha').AsDateTime:= AFecha;
    ParamByName('matricula').Asstring:= edtMatricula.Text;
    Open;
  end;
  with QSalidasSeleccionadas do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('servicio').AsInteger:= AServicio;
    Open;
  end;
  with QSBorrar do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('servicio').AsInteger:= AServicio;
  end;
  with QSAnyadir do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('servicio').AsInteger:= AServicio;
  end;
end;

procedure TFMTransitosGastosTransitos.ReOpen;
begin
  QSalidasPosibles.Close;
  QSalidasPosibles.Open;
  QSalidasSeleccionadas.Close;
  QSalidasSeleccionadas.Open;
end;

procedure TFMTransitosGastosTransitos.FormCreate(Sender: TObject);
begin
  with QSalidasPosibles do
  begin
    SQL.Clear;
    SQL.Add(' select centro_salida_sc centro, n_albaran_sc albaran, fecha_sc fecha, ');
    SQL.Add('        cliente_sal_sc cliente, dir_sum_sc suministro, vehiculo_sc matricula, ');
    SQL.Add('        transporte_sc, ( select descripcion_t from frf_transportistas where empresa_t = :empresa and transporte_t = transporte_sc ) transportista, ');
    SQL.Add('        sum(n_palets_sl) palets ');

    SQL.Add(' from frf_salidas_c, frf_salidas_l ');

    SQL.Add(' where empresa_sc = :empresa ');
    SQL.Add(' and vehiculo_sc matches :matricula ');
    SQL.Add(' and fecha_sc = :fecha ');

    SQL.Add(' and not exists ');
    SQL.Add(' ( ');
    SQL.Add('   select * ');
    SQL.Add('   from frf_salidas_servicios_venta ');
    SQL.Add('   where empresa_ssv = :empresa ');
    SQL.Add('   and centro_salida_sc = centro_salida_ssv ');
    SQL.Add('   and n_albaran_sc = n_albaran_ssv ');
    SQL.Add('   and fecha_sc = fecha_ssv ');
    SQL.Add(' ) ');

    SQL.Add(' and empresa_sl = :empresa ');
    SQL.Add(' and centro_salida_sl = centro_salida_sc ');
    SQL.Add(' and fecha_sl = :fecha ');
    SQL.Add(' and n_albaran_sl = n_albaran_sc ');

    SQL.Add(' group by  centro_salida_sc, n_albaran_sc, fecha_sc, cliente_sal_sc, dir_sum_sc, vehiculo_sc, transporte_sc' );

    SQL.Add(' order by n_albaran_sc ');
    Prepare;

  end;

  with QSalidasSeleccionadas do
  begin
    SQL.Clear;
    SQL.Add(' select centro_salida_sc centro, n_albaran_sc albaran, fecha_sc fecha, ');
    SQL.Add('        cliente_sal_sc cliente, dir_sum_sc suministro, vehiculo_sc matricula, ');
    SQL.Add('        transporte_sc transporte, ( select descripcion_t from frf_transportistas where empresa_t = :empresa and transporte_t = transporte_sc ) transportista, ');
    SQL.Add('        sum(n_palets_sl) palets ');

    SQL.Add(' from frf_salidas_servicios_venta, frf_salidas_c, frf_salidas_l ');

    SQL.Add(' where empresa_ssv = :empresa ');
    SQL.Add(' and servicio_ssv = :servicio ');

    SQL.Add(' and empresa_sc = :empresa ');
    SQL.Add(' and centro_salida_sc = centro_salida_ssv ');
    SQL.Add(' and n_albaran_sc = n_albaran_ssv ');
    SQL.Add(' and fecha_sc = fecha_ssv ');

    SQL.Add(' and empresa_sl = :empresa ');
    SQL.Add(' and centro_salida_sl = centro_salida_sc ');
    SQL.Add(' and fecha_sl = fecha_sc ');
    SQL.Add(' and n_albaran_sl = n_albaran_sc ');

    SQL.Add(' group by  centro_salida_sc, n_albaran_sc, fecha_sc, cliente_sal_sc, dir_sum_sc, vehiculo_sc, transporte_sc' );
    SQL.Add(' order by n_albaran_sc ');
    Prepare;
  end;

  with QSBorrar do
  begin
    SQL.Clear;
    SQL.Add(' delete  ');
    SQL.Add(' from frf_salidas_servicios_venta ');
    SQL.Add(' where empresa_ssv = :empresa ');
    SQL.Add(' and servicio_ssv = :servicio ');
    SQL.Add(' and centro_salida_ssv = :centro_salida ');
    SQL.Add(' and n_albaran_ssv = :n_albaran ');
    SQL.Add(' and fecha_ssv = :fecha ');
    Prepare;
  end;

  with QSAnyadir do
  begin
    SQL.Clear;
    SQL.Add(' insert into frf_salidas_servicios_venta values ');
    SQL.Add(' ( :empresa, :servicio, :centro_salida, :n_albaran, :fecha ) ');
    Prepare;
  end;

  bGastoModificado:= False;
end;

procedure TFMTransitosGastosTransitos.btnCerrarClick(Sender: TObject);
begin
  Close;
end;


procedure TFMTransitosGastosTransitos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with QSalidasPosibles do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;
  with QSalidasSeleccionadas do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;
  Action := caFree;
end;

procedure TFMTransitosGastosTransitos.FormKeyDown(Sender: TObject; var Key: Word;
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
        Key := 0;
        btnCerrar.Click;
      end;
  end;
end;

function TFMTransitosGastosTransitos.GastosModificados: boolean;
begin
  result := bGastoModificado;
end;

procedure TFMTransitosGastosTransitos.Borrar;
begin
  if not QSalidasSeleccionadas.IsEmpty then
  with QSBorrar do
  begin
    ParamByName('centro_salida').AsString:= QSalidasSeleccionadas.FieldByName('centro').AsString;
    ParamByName('n_albaran').AsInteger:= QSalidasSeleccionadas.FieldByName('albaran').AsInteger;
    ParamByName('fecha').AsDateTime:= QSalidasSeleccionadas.FieldByName('fecha').AsDateTime;
    ExecSQL;
    bGastoModificado:= True;
    ReOpen;
  end;
end;

procedure TFMTransitosGastosTransitos.Anyadir;
begin
  if not QSalidasPosibles.IsEmpty then
  with QSAnyadir do
  begin
    ParamByName('centro_salida').AsString:= QSalidasPosibles.FieldByName('centro').AsString;
    ParamByName('n_albaran').AsInteger:= QSalidasPosibles.FieldByName('albaran').AsInteger;
    ParamByName('fecha').AsDateTime:= QSalidasPosibles.FieldByName('fecha').AsDateTime;
    ExecSQL;
    bGastoModificado:= True;
    ReOpen;
  end;
end;

procedure TFMTransitosGastosTransitos.btnBorrarClick(Sender: TObject);
begin
  Borrar;
end;

procedure TFMTransitosGastosTransitos.btnAnyadirClick(Sender: TObject);
begin
  Anyadir;
end;

procedure TFMTransitosGastosTransitos.DBGrid1DblClick(Sender: TObject);
begin
  Borrar;
end;

procedure TFMTransitosGastosTransitos.rejillaDblClick(Sender: TObject);
begin
  Anyadir;
end;

procedure TFMTransitosGastosTransitos.btnFiltarClick(Sender: TObject);
begin
  with QSalidasPosibles do
  begin
    Close;
    ParamByName('matricula').Asstring:= edtMatricula.Text;
    Open;
  end;
end;

end.


