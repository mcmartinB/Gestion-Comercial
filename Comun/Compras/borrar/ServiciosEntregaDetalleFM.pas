unit ServiciosEntregaDetalleFM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  BCalendarButton, ComCtrls, BCalendario, BEdit, dbTables,
  DError, CVariables, StrUtils, DBActns, StdActns;

type
  TFMServiciosEntregaDetalle = class(TForm)
    rejilla: TDBGrid;
    DSEntregasPosibles: TDataSource;
    QEntregasPosibles: TQuery;
    DBGrid1: TDBGrid;
    QEntregasSeleccionadas: TQuery;
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

    bGastoModificado: boolean;

    procedure ReOpen;
    procedure Borrar;
    procedure Anyadir;
  public
    { Public declarations }

    procedure CargaParametros( const AServicio: integer; const AFecha: TDateTime; const AMatricula: string );
    function GastosModificados: boolean;
  end;

var
  FMServiciosEntregaDetalle: TFMServiciosEntregaDetalle;

implementation

uses bDialogs, UDMBaseDatos, CAuxiliarDB, Principal, bSQLUtils,
     DConversor, uDMAuxDB;

{$R *.DFM}

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMServiciosEntregaDetalle.CargaParametros( const AServicio: integer;
                                                      const AFecha: TDateTime; const AMatricula: string );
begin
  edtMatricula.Text:= '*' + AMatricula + '*';
  with QEntregasPosibles do
  begin
    ParamByName('fecha').AsDateTime:= AFecha;
    ParamByName('matricula').Asstring:= edtMatricula.Text;
    Open;
  end;
  with QEntregasSeleccionadas do
  begin
    ParamByName('servicio').AsInteger:= AServicio;
    Open;
  end;
  with QSBorrar do
  begin
    ParamByName('servicio').AsInteger:= AServicio;
  end;
  with QSAnyadir do
  begin
    ParamByName('servicio').AsInteger:= AServicio;
  end;
end;

procedure TFMServiciosEntregaDetalle.ReOpen;
begin
  QEntregasPosibles.Close;
  QEntregasPosibles.Open;
  QEntregasSeleccionadas.Close;
  QEntregasSeleccionadas.Open;
end;

procedure TFMServiciosEntregaDetalle.FormCreate(Sender: TObject);
begin
  with QEntregasPosibles do
  begin
    SQL.Clear;
    SQL.Add(' select  empresa_ec empresa, codigo_ec entrega, ');
    SQL.Add('          vehiculo_ec matricula, ');
    SQL.Add('          transporte_ec cod_transporte, ( select descripcion_t from frf_transportistas ');
    SQL.Add('                                          where empresa_t = empresa_ec and transporte_t = transporte_ec ) transporte, ');
    SQL.Add('          producto_el cod_producto, ( select descripcion_p from frf_productos ');
    SQL.Add('                                      where empresa_p = empresa_ec and producto_p = producto_el ) producto, ');
    SQL.Add('          sum(palets_el) palets, ');
    SQL.Add('          sum(cajas_el) cajas, ');
    SQL.Add('          sum(kilos_el) kilos, ');
    SQL.Add('          proveedor_Ec cod_proveedor, ( select nombre_p from frf_proveedores ');
    SQL.Add('                                        where empresa_p = empresa_ec and proveedor_p = proveedor_ec ) proveedor, ');
    SQL.Add('          almacen_EL cod_almacen, ( select nombre_pa from frf_proveedores_almacen ');
    SQL.Add('                                    where empresa_pa = empresa_ec and proveedor_pa = proveedor_ec and almacen_pa = almacen_eL ) almacen ');

    SQL.Add('  from frf_entregas_c, frf_entregas_l ');

    SQL.Add('  where vehiculo_ec matches :matricula ');
    SQL.Add('  and fecha_llegada_ec = :fecha ');

    SQL.Add('  and not exists ');
    SQL.Add('   ( ');
    SQL.Add('     select * ');
    SQL.Add('     from frf_servicios_entrega_l ');
    SQL.Add('     where entrega_sel = codigo_ec ');
    SQL.Add('   ) ');

    SQL.Add('  and codigo_el = codigo_ec ');
    SQL.Add('   group by empresa, entrega, matricula, cod_transporte, transporte, cod_producto, ');
    SQL.Add('           producto, cod_proveedor, proveedor, cod_almacen, almacen ');
    SQL.Add('  order by entrega ');

    Prepare;
  end;

  with QEntregasSeleccionadas do
  begin
    SQL.Clear;
    SQL.Add(' select  empresa_ec empresa, codigo_ec entrega, ');
    SQL.Add('         vehiculo_ec matricula, ');
    SQL.Add('         transporte_ec cod_transporte, transporte_ec || '' - '' || ( select descripcion_t from frf_transportistas ');
    SQL.Add('                                                                   where empresa_t = empresa_ec and transporte_t = transporte_ec ) transporte, ');
    SQL.Add('         producto_el cod_producto, ( select descripcion_p from frf_productos ');
    SQL.Add('                                     where empresa_p = empresa_ec and producto_p = producto_el ) producto, ');
    SQL.Add('         sum(palets_el) palets, ');
    SQL.Add('         sum(cajas_el) cajas, ');
    SQL.Add('         sum(kilos_el) kilos, ');
    SQL.Add('         proveedor_Ec cod_proveedor, ( select nombre_p from frf_proveedores ');
    SQL.Add('                                       where empresa_p = empresa_ec and proveedor_p = proveedor_ec ) proveedor, ');
    SQL.Add('         almacen_EL cod_almacen, ( select nombre_pa from frf_proveedores_almacen ');
    SQL.Add('                                   where empresa_pa = empresa_ec and proveedor_pa = proveedor_ec and almacen_pa = almacen_eL ) almacen ');

    SQL.Add(' from frf_servicios_entrega_l, frf_entregas_c, frf_entregas_l ');

    SQL.Add(' where servicio_sel = :servicio ');
    SQL.Add(' and codigo_ec = entrega_sel ');
    SQL.Add(' and codigo_el = codigo_ec ');
    SQL.Add('   group by empresa, entrega, matricula, cod_transporte, transporte, cod_producto, ');
    SQL.Add('           producto, cod_proveedor, proveedor, cod_almacen, almacen ');
    SQL.Add('  order by entrega ');
    Prepare;
  end;

  with QSBorrar do
  begin
    SQL.Clear;
    SQL.Add(' delete  ');
    SQL.Add(' from frf_servicios_entrega_l ');
    SQL.Add(' where servicio_sel = :servicio ');
    SQL.Add(' and entrega_sel = :entrega ');
    Prepare;
  end;

  with QSAnyadir do
  begin
    SQL.Clear;
    SQL.Add(' insert into frf_servicios_entrega_l values ');
    SQL.Add(' ( :servicio, :entrega ) ');
    Prepare;
  end;

  bGastoModificado:= False;
end;

procedure TFMServiciosEntregaDetalle.btnCerrarClick(Sender: TObject);
begin
  Close;
end;


procedure TFMServiciosEntregaDetalle.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFMServiciosEntregaDetalle.FormKeyDown(Sender: TObject; var Key: Word;
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

function TFMServiciosEntregaDetalle.GastosModificados: boolean;
begin
  result := bGastoModificado;
end;

procedure TFMServiciosEntregaDetalle.Borrar;
begin
  if not QEntregasSeleccionadas.IsEmpty then
  with QSBorrar do
  begin
    ParamByName('entrega').AsString:= QEntregasSeleccionadas.FieldByName('entrega').AsString;
    ExecSQL;
    bGastoModificado:= True;
    ReOpen;
  end;
end;

procedure TFMServiciosEntregaDetalle.Anyadir;
begin
  if not QEntregasPosibles.IsEmpty then
  with QSAnyadir do
  begin
    ParamByName('entrega').AsString:= QEntregasPosibles.FieldByName('entrega').AsString;
    ExecSQL;
    bGastoModificado:= True;
    ReOpen;
  end;
end;

procedure TFMServiciosEntregaDetalle.btnBorrarClick(Sender: TObject);
begin
  Borrar;
end;

procedure TFMServiciosEntregaDetalle.btnAnyadirClick(Sender: TObject);
begin
  Anyadir;
end;

procedure TFMServiciosEntregaDetalle.DBGrid1DblClick(Sender: TObject);
begin
  Borrar;
end;

procedure TFMServiciosEntregaDetalle.rejillaDblClick(Sender: TObject);
begin
  Anyadir;
end;

procedure TFMServiciosEntregaDetalle.btnFiltarClick(Sender: TObject);
begin
  with QEntregasPosibles do
  begin
    Close;
    ParamByName('matricula').Asstring:= edtMatricula.Text;
    Open;
  end;
end;

end.


