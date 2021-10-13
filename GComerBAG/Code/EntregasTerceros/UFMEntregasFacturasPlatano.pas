unit UFMEntregasFacturasPlatano;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestro, Buttons,
  ActnList, BSpeedButton, Grids, DBGrids, BGridButton, BGrid, BDEdit,
  BCalendarButton, ComCtrls, BCalendario, BEdit, dbTables,
  DError, CVariables, StrUtils, DBActns, StdActns;

type
  TFMEntregasFacturasPlatano = class(TForm)
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

    sEmpresa, sAnyoSemana: string;
    iFactura: integer;
    dFecha: TDateTime;

    procedure ReOpen;
    procedure Borrar;
    procedure Anyadir;
  public
    { Public declarations }

    procedure CargaParametros( const AEmpresa: string; const AFactura: Integer;
                               const AFecha: TDateTime; const AAnyoSemana: string );
  end;

var
  FMEntregasFacturasPlatano: TFMEntregasFacturasPlatano;

implementation

uses bDialogs, UDMBaseDatos, CAuxiliarDB, Principal, bSQLUtils,
     DConversor, uDMAuxDB;

{$R *.DFM}

//************************** CREAMOS EL FORMULARIO ************************

procedure TFMEntregasFacturasPlatano.CargaParametros( const AEmpresa: string; const AFactura: Integer;
                                                      const AFecha: TDateTime; const AAnyoSemana: string );
begin
  sEmpresa:= AEmpresa;
  sAnyoSemana:= AAnyoSemana;
  iFactura:= AFactura;
  dFecha:= AFecha;

  with QEntregasPosibles do
  begin
    //ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('fecha').AsDateTime:= dFecha - 90;
    ParamByName('anyosemana').AsString:= sAnyoSemana;//copy( sAnyoSemana, 3, 2 );
    Open;
  end;
  with QEntregasSeleccionadas do
  begin
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('factura').AsInteger:= iFactura;
    Open;
  end;

  with QBorrar do
  begin
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('factura').AsInteger:= iFactura;
  end;

  with QAnyadir do
  begin
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('factura').AsInteger:= iFactura;
  end;
end;

procedure TFMEntregasFacturasPlatano.ReOpen;
begin
  QEntregasPosibles.Close;
  QEntregasPosibles.Open;
  QEntregasSeleccionadas.Close;
  QEntregasSeleccionadas.Open;
end;

procedure TFMEntregasFacturasPlatano.FormCreate(Sender: TObject);
begin
  with QEntregasPosibles do
  begin
    SQL.Clear;
    SQL.Add(' select codigo_ec entrega, proveedor_ec proveedor,  ');
    SQL.Add('         fecha_carga_ec carga, anyo_semana_ec semana, albaran_ec albaran, adjudicacion_ec conduce, ');
    SQL.Add('         barco_ec, vehiculo_ec matricula, producto_ec producto, ');
    SQL.Add('         (select sum(cajas_el) from frf_entregas_l where codigo_el = codigo_Ec ) cajas, ');
    SQL.Add('         (select sum(kilos_el) from frf_entregas_l where codigo_el = codigo_Ec ) kilos ');
    SQL.Add(' from frf_entregas_c ');
    //SQL.Add(' where empresa_ec = :empresa ');
    SQL.Add(' where anyo_semana_ec = :anyosemana ');
    SQL.Add(' and producto_ec = ''PLA'' ');
    SQL.Add(' and fecha_origen_ec >= :fecha ');
    SQL.Add(' and not exists ');
    SQL.Add(' ( ');
    SQL.Add('  select * from frf_facturas_platano_l ');
    SQL.Add('  where entrega_fpl = codigo_ec ');
    SQL.Add(' ) ');
    SQL.Add(' order by carga, entrega ');
    Prepare;
  end;

  with QEntregasSeleccionadas do
  begin
    SQL.Clear;
    SQL.Add(' select codigo_ec entrega, proveedor_ec proveedor,  ');
    SQL.Add('         fecha_carga_ec carga, anyo_semana_ec semana, albaran_ec albaran, adjudicacion_ec conduce, ');
    SQL.Add('         barco_ec, vehiculo_ec matricula, producto_ec producto, ');
    SQL.Add('         (select sum(cajas_el) from frf_entregas_l where codigo_el = codigo_Ec ) cajas, ');
    SQL.Add('         (select sum(kilos_el) from frf_entregas_l where codigo_el = codigo_Ec ) kilos ');
    SQL.Add(' from frf_facturas_platano_l, frf_entregas_c ');
    SQL.Add(' where empresa_fpl = :empresa ');
    SQL.Add(' and n_factura_fpl = :factura  ');
    SQL.Add(' and entrega_fpl = codigo_ec ');
    SQL.Add(' order by carga, entrega ');
    Prepare;
  end;

  with QBorrar do
  begin
    SQL.Clear;
    SQL.Add(' delete ');
    SQL.Add(' from frf_facturas_platano_l ');
    SQL.Add(' where empresa_fpl = :empresa ');
    SQL.Add(' and n_factura_fpl = :factura  ');
    SQL.Add(' and entrega_fpl = :entrega ');
    Prepare;
  end;

  with QAnyadir do
  begin
    SQL.Clear;
    SQL.Add(' insert into frf_facturas_platano_l values ');
    SQL.Add(' (:empresa, :factura, :entrega )');
    Prepare;
  end;
end;

procedure TFMEntregasFacturasPlatano.btnCerrarClick(Sender: TObject);
begin
  Close;
end;


procedure TFMEntregasFacturasPlatano.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TFMEntregasFacturasPlatano.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMEntregasFacturasPlatano.Borrar;
begin
  with QBorrar do
  begin
    ParamByName('entrega').AsString:= QEntregasSeleccionadas.FieldByName('entrega').AsString;
    ExecSQL;
    ReOpen;
  end;
end;

procedure TFMEntregasFacturasPlatano.Anyadir;
begin
  with QAnyadir do
  begin
    ParamByName('entrega').AsString:= QEntregasPosibles.FieldByName('entrega').AsString;
    ExecSQL;
    ReOpen;
  end;
end;

procedure TFMEntregasFacturasPlatano.btnBorrarClick(Sender: TObject);
begin
  Borrar;
end;

procedure TFMEntregasFacturasPlatano.btnAnyadirClick(Sender: TObject);
begin
  Anyadir;
end;

procedure TFMEntregasFacturasPlatano.DBGrid1DblClick(Sender: TObject);
begin
  Borrar;
end;

procedure TFMEntregasFacturasPlatano.rejillaDblClick(Sender: TObject);
begin
  Anyadir;
end;

procedure TFMEntregasFacturasPlatano.eFiltroChange(Sender: TObject);
begin
  if eFiltro.Text = '' then
  begin
    QEntregasPosibles.Filtered:= False;
  end
  else
  begin
    case cbxFiltro.ItemIndex of
      0:QEntregasPosibles.Filter:= 'conduce = ' + QuotedStr( eFiltro.Text + '*' );
      1:QEntregasPosibles.Filter:= 'entrega = ' + QuotedStr( eFiltro.Text + '*' );
      2:QEntregasPosibles.Filter:= 'albaran = ' + QuotedStr( eFiltro.Text + '*' );
    end;
    QEntregasPosibles.Filtered:= True;
  end;
end;

procedure TFMEntregasFacturasPlatano.cbxFiltroChange(Sender: TObject);
begin
  eFiltroChange( eFiltro );
end;

end.


