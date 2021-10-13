unit UFMEntregasCompras;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  BCalendarButton, ComCtrls, BCalendario, BEdit, dbTables,
  DError, CVariables, StrUtils, DBActns, StdActns;

type
  TFMEntregasCompras = class(TForm)
    rejilla: TDBGrid;
    DSEntregasPosibles: TDataSource;
    QEntregasPosibles: TQuery;
    DBGrid1: TDBGrid;
    QEntregasSeleccionadas: TQuery;
    DSEntregasSeleccionadas: TDataSource;
    btnCerrar: TButton;
    btnAnyadir: TButton;
    btnBorrar: TButton;
    QBorrar: TQuery;
    QAnyadir: TQuery;
    eFiltro: TEdit;
    lblNombre4: TLabel;
    lblNombre1: TLabel;
    cbxFiltro: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCerrarClick(Sender: TObject);
    procedure btnBorrarClick(Sender: TObject);
    procedure btnAnyadirClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure rejillaDblClick(Sender: TObject);
    procedure eFiltroChange(Sender: TObject);
    procedure cbxFiltroChange(Sender: TObject);


  private

    sEmpresa, sCentro, sProveedor: string;
    iNumero: integer;
    dFecha: TDateTime;
    bGastoModificado: boolean;

    procedure ReOpen;
    procedure Borrar;
    procedure Anyadir;
  public
    { Public declarations }

    procedure CargaParametros( const AEmpresa, ACentro: string; const ANumero: integer;
                               const AFecha: TDateTime; const AProveedor: string );
    function GastosModificados: boolean;
  end;

var
  FMEntregasCompras: TFMEntregasCompras;

implementation

uses bDialogs, UDMBaseDatos, CAuxiliarDB, Principal, bSQLUtils,
     DConversor, uDMAuxDB;

{$R *.DFM}

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMEntregasCompras.CargaParametros( const AEmpresa, ACentro: string;
                                              const ANumero: integer;
                                              const AFecha: TDateTime;
                                              const AProveedor: string );
begin
  sEmpresa:= AEmpresa;
  sCentro:= ACentro;
  iNumero:= ANumero;
  dFecha:= AFecha;
  sProveedor:= AProveedor;
  with QEntregasPosibles do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    //ParamByName('centro').AsString:= ACentro;
    ParamByName('fecha').AsDateTime:= IncMonth( AFecha, -3 );
    ParamByName('proveedor').Asstring:= AProveedor;
    Open;
  end;
  with QEntregasSeleccionadas do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('compra').AsInteger:= ANumero;
    Open;
  end;
  with QBorrar do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('compra').AsInteger:= ANumero;
  end;
  with QAnyadir do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('compra').AsInteger:= ANumero;
  end;
end;

procedure TFMEntregasCompras.ReOpen;
begin
  QEntregasPosibles.Close;
  QEntregasPosibles.Open;
  QEntregasSeleccionadas.Close;
  QEntregasSeleccionadas.Open;
end;

procedure TFMEntregasCompras.FormCreate(Sender: TObject);
begin
  bGastoModificado:= False;


  with QEntregasPosibles do
  begin
    SQL.Clear;
    SQL.Add(' select codigo_ec entrega, proveedor_ec proveedor, almacen_ec almacen, ');
    SQL.Add('        fecha_carga_ec carga, albaran_ec albaran, vehiculo_ec matricula');
    SQL.Add(' from frf_entregas_c ');
    SQL.Add(' where empresa_ec = :empresa ');
    //SQL.Add(' and centro_llegada_ec = :centro ');
    SQL.Add(' and fecha_carga_ec >= :fecha ');
    SQL.Add(' and proveedor_ec = :proveedor ');
    SQL.Add(' and not exists ');
    SQL.Add(' ( ');
    SQL.Add('  select * from frf_compras_entregas ');
    SQL.Add('  where entrega_ce = codigo_ec ');
    SQL.Add(' ) ');
    SQL.Add(' and not exists ');
    SQL.Add('  ( ');
    SQL.Add('  select * from frf_entregas_falb ');
    SQL.Add('  where codigo_alb_efa = codigo_ec ');
    SQL.Add('  ) ');
    SQL.Add('  and not exists ');
    SQL.Add('  ( ');
    SQL.Add('  select * from frf_gastos_entregas ');
    SQL.Add('  where codigo_ge = codigo_ec ');
    SQL.Add('    and tipo_ge = 110 ');
    SQL.Add('  ) ');
    SQL.Add(' order by carga, entrega ');
    Prepare;
  end;

  with QEntregasSeleccionadas do
  begin
    SQL.Clear;
    SQL.Add(' select entrega_ce entrega, proveedor_ec proveedor, almacen_ec almacen, ');
    SQL.Add('        fecha_carga_ec carga, albaran_ec albaran, vehiculo_ec matricula ');
    SQL.Add(' from frf_compras_entregas, frf_entregas_c ');
    SQL.Add(' where empresa_ce = :empresa ');
    SQL.Add(' and centro_ce = :centro  ');
    SQL.Add(' and compra_ce = :compra ');
    SQL.Add(' and codigo_ec = entrega_ce ');
    SQL.Add(' order by carga, entrega ');
    Prepare;
  end;

  with QBorrar do
  begin
    SQL.Clear;
    SQL.Add(' delete ');
    SQL.Add(' from frf_compras_entregas ');
    SQL.Add(' where empresa_ce = :empresa ');
    SQL.Add(' and centro_ce = :centro ');
    SQL.Add(' and compra_ce = :compra ');
    SQL.Add(' and entrega_ce = :entrega ');
    Prepare;
  end;

  with QAnyadir do
  begin
    SQL.Clear;
    SQL.Add(' insert into frf_compras_entregas values ');
    SQL.Add(' (:empresa, :centro, :compra, :entrega )');
    Prepare;
  end;
end;

procedure TFMEntregasCompras.btnCerrarClick(Sender: TObject);
begin
  Close;
end;


procedure TFMEntregasCompras.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with QEntregasPosibles do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;
  with QEntregasSeleccionadas do
  begin
    Close;
    if Prepared then
      UnPrepare;
  end;
  Action := caFree;
end;

procedure TFMEntregasCompras.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    // Tecla ENTER - Cambio entre los Controles de Datos en modo edici�n
    //               y entre los Campos de B�squeda en la localizaci�n
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

function TFMEntregasCompras.GastosModificados: boolean;
begin
  result:= bGastoModificado;
end;

procedure TFMEntregasCompras.Borrar;
begin
  with QBorrar do
  begin
    ParamByName('entrega').AsString:= QEntregasSeleccionadas.FieldByName('entrega').AsString;
    ExecSQL;
    bGastoModificado:= True;
    ReOpen;
  end;
end;

procedure TFMEntregasCompras.Anyadir;
begin
  with QAnyadir do
  begin
    ParamByName('entrega').AsString:= QEntregasPosibles.FieldByName('entrega').AsString;
    ExecSQL;
    bGastoModificado:= True;
    ReOpen;
  end;
end;

procedure TFMEntregasCompras.btnBorrarClick(Sender: TObject);
begin
  Borrar;
end;

procedure TFMEntregasCompras.btnAnyadirClick(Sender: TObject);
begin
  Anyadir;
end;

procedure TFMEntregasCompras.DBGrid1DblClick(Sender: TObject);
begin
  Borrar;
end;

procedure TFMEntregasCompras.rejillaDblClick(Sender: TObject);
begin
  Anyadir;
end;

procedure TFMEntregasCompras.eFiltroChange(Sender: TObject);
begin
  if eFiltro.Text = '' then
  begin
    QEntregasPosibles.Filtered:= False;
  end
  else
  begin
    if cbxFiltro.ItemIndex = 0 then
      QEntregasPosibles.Filter:= 'entrega = ' + QuotedStr( eFiltro.Text + '*' )
    else
      QEntregasPosibles.Filter:= 'albaran = ' + QuotedStr( eFiltro.Text + '*' );
    QEntregasPosibles.Filtered:= True;
  end;
end;

procedure TFMEntregasCompras.cbxFiltroChange(Sender: TObject);
begin
  eFiltroChange( eFiltro );
end;

end.


