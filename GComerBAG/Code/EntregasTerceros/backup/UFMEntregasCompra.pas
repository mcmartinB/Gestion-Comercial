unit UFMEntregasCompra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, Grids, DBGrids, DB, DBTables;

type
  TFMEntregasCompra = class(TForm)
    btnBorrar: TButton;
    btnCancelar: TButton;
    btnAceptar: TButton;
    QCompras: TQuery;
    DSCompras: TDataSource;
    dbgCompras: TDBGrid;
    dbmmoNotas: TDBMemo;
    QDesligar: TQuery;
    QLigar: TQuery;
    QDesasignarGastos: TQuery;
    QBorrarGastos: TQuery;
    procedure FormCreate(Sender: TObject);
    procedure btnBorrarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure dbgComprasDblClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    bResultado: Boolean;
    sEntrega, sEmpresa, sProveedor: string;
    dFecha: TDateTime;
    sCentro, sCodigo, sCompra: string;

    procedure BotonDesligar;
    procedure AbrirQuery;
    procedure Desligar;
    procedure Ligar;
    function  EstaLigado: Boolean;
  public
    { Public declarations }

  end;

  function Execute( const AOwner: TComponent; const AEntrega, AEmpresa, AProveedor: string;
                    const AFecha: TDateTime; const ACentro, ACodigo, ACompra: string ): Boolean;

implementation

{$R *.dfm}

uses
  UDMBaseDatos;

var
  FMEntregasCompra: TFMEntregasCompra;

function Execute( const AOwner: TComponent; const AEntrega, AEmpresa, AProveedor: string;
                  const AFecha: TDateTime;  const ACentro, ACodigo, ACompra: string ): Boolean;
begin
  FMEntregasCompra:= TFMEntregasCompra.Create( AOwner );
  try

    FMEntregasCompra.sEntrega:= AEntrega;
    FMEntregasCompra.sEmpresa:= AEmpresa;
    FMEntregasCompra.sProveedor:= AProveedor;
    FMEntregasCompra.dFecha:= AFecha;
    FMEntregasCompra.sCentro:= ACentro;
    FMEntregasCompra.sCodigo:= ACodigo;
    FMEntregasCompra.sCompra:= ACompra;

    FMEntregasCompra.AbrirQuery;
    FMEntregasCompra.BotonDesligar;
    if FMEntregasCompra.QCompras.IsEmpty then
    begin
      ShowMessage('No hay compra seleccionable para la entrega actual.');
    end
    else
    begin
      FMEntregasCompra.ShowModal;
    end;
    Result:= FMEntregasCompra.bResultado;

  finally
    FMEntregasCompra.QCompras.Close;
    FreeAndNil( FMEntregasCompra );

  end;
end;

procedure TFMEntregasCompra.FormCreate(Sender: TObject);
begin
  bResultado:= False;
  QCompras.SQL.Clear;
  QCompras.SQL.Add('SELECT CENTRO_C CENTRO, NUMERO_C CODIGO, FECHA_C FECHA, REF_COMPRA_C COMPRA, OBSERVACIONES_C NOTAS ');
  QCompras.SQL.Add('FROM FRF_COMPRAS ');
  QCompras.SQL.Add('WHERE EMPRESA_C = :EMPRESA ');
  QCompras.SQL.Add('AND PROVEEDOR_C = :PROVEEDOR ');
  //QCompras.SQL.Add('AND FECHA_C <= :FECHA ');
  QCompras.SQL.Add('ORDER BY FECHA_C DESC, NUMERO_C DESC ');

  QDesligar.SQL.Clear;
  QDesligar.SQL.Add('Delete from frf_compras_entregas ');
  QDesligar.SQL.Add('where empresa_ce = :empresa ');
  QDesligar.SQL.Add('and compra_ce = :codigo ');
  QDesligar.SQL.Add('and entrega_ce = :entrega ');

  QLigar.SQL.Clear;
  QLigar.SQL.Add('insert into frf_compras_entregas values ');
  QLigar.SQL.Add('( :empresa, :centro, :codigo, :entrega )');

  QDesasignarGastos.SQL.Clear;
  QDesasignarGastos.SQL.Add('update frf_compras set status_gastos_c = -1 ');
  QDesasignarGastos.SQL.Add('where empresa_c = :empresa ');
  QDesasignarGastos.SQL.Add('and centro_c = :centro ');
  QDesasignarGastos.SQL.Add('and numero_c = :codigo  ');
  QDesasignarGastos.SQL.Add('and status_gastos_c = 1 ');

  with QBorrarGastos do
  begin
    SQL.Clear;
    SQL.Add(' delete ');
    SQL.Add(' from frf_gastos_entregas ');
    SQL.Add(' where codigo_ge = :entrega ');
    SQL.Add(' and nota_ge = :compra ');
    SQL.Add(' and solo_lectura_ge = 1 ');
  end;
end;

procedure TFMEntregasCompra.btnBorrarClick(Sender: TObject);
begin
  if not DMBaseDatos.DBBaseDatos.InTransaction then
  begin
    DMBaseDatos.DBBaseDatos.StartTransaction;
    try
      Desligar;
      DMBaseDatos.DBBaseDatos.Commit;
    except
      DMBaseDatos.DBBaseDatos.Rollback;
      raise;
    end;
    bResultado:= True;
    Close;
  end
  else
  begin
    ShowMessage('Error al intentar abrir la transacción, por favor intentelo mas tarde.');
  end;
end;

procedure TFMEntregasCompra.btnCancelarClick(Sender: TObject);
begin
  //Cancelamos cualquier cosa
  Close;
end;

procedure TFMEntregasCompra.btnAceptarClick(Sender: TObject);
begin
  if not DMBaseDatos.DBBaseDatos.InTransaction then
  begin
    DMBaseDatos.DBBaseDatos.StartTransaction;
    try
      if EstaLigado then
        Desligar;
      Ligar;
      DMBaseDatos.DBBaseDatos.Commit;
    except
      DMBaseDatos.DBBaseDatos.Rollback;
      raise;
    end;
    bResultado:= True;
    Close;
  end
  else
  begin
    ShowMessage('Error al intentar abrir la transacción, por favor intentelo mas tarde.');
  end;
end;

procedure TFMEntregasCompra.BotonDesligar;
begin
  if sCodigo <> '' then
  begin
    btnBorrar.Caption:= 'Desligar Compra ' + sCodigo + ' [F5]';
    btnBorrar.Enabled:= True;
    btnAceptar.Enabled:= False;
    while ( QCompras.FieldByName('codigo').AsString <> sCodigo ) and ( not QCompras.Eof ) do
    begin
      QCompras.Next;
    end;
  end
  else
  begin
    btnBorrar.Caption:= 'Desligar [F5]';
    btnBorrar.Enabled:= False;
    btnAceptar.Enabled:= True;
  end;
end;

procedure TFMEntregasCompra.AbrirQuery;
begin
    QCompras.ParamByName('empresa').AsString:= sEmpresa;
    QCompras.ParamByName('proveedor').AsString:= sProveedor;
    //QCompras.ParamByName('fecha').AsDate:= dFecha + 30;
    QCompras.Open;
end;

procedure TFMEntregasCompra.Desligar;
begin
  QDesligar.ParamByName('empresa').AsString:= sEmpresa;
  QDesligar.ParamByName('codigo').AsString:= sCodigo;
  QDesligar.ParamByName('entrega').AsString:= sEntrega;
  QDesligar.ExecSQL;

  QDesasignarGastos.ParamByName('empresa').AsString:= sEmpresa;
  QDesasignarGastos.ParamByName('codigo').AsString:= sCodigo;
  QDesasignarGastos.ParamByName('centro').AsString:= sCentro;
  QDesasignarGastos.ExecSQL;

  QBorrarGastos.ParamByName('compra').AsString:= 'COMPRA: ' + '(' + sEmpresa + ', ' + sCodigo + ', ' + sCentro  + ')';
  QBorrarGastos.ParamByName('entrega').AsString:= sEntrega;
  QBorrarGastos.ExecSQL;
end;

function  TFMEntregasCompra.EstaLigado: Boolean;
begin
  Result:= sCodigo <> '';
end;

procedure TFMEntregasCompra.Ligar;
begin
  QLigar.ParamByName('empresa').AsString:= sEmpresa;
  QLigar.ParamByName('centro').AsString:= QCompras.fieldByName('centro').AsString;
  QLigar.ParamByName('codigo').AsString:= QCompras.fieldByName('codigo').AsString;
  QLigar.ParamByName('entrega').AsString:= sEntrega;
  QLigar.ExecSQL;

  QDesasignarGastos.ParamByName('empresa').AsString:= sEmpresa;
  QDesasignarGastos.ParamByName('centro').AsString:= QCompras.fieldByName('centro').AsString;
  QDesasignarGastos.ParamByName('codigo').AsString:= QCompras.fieldByName('codigo').AsString;
  QDesasignarGastos.ExecSQL;
end;

procedure TFMEntregasCompra.dbgComprasDblClick(Sender: TObject);
begin
  if btnAceptar.Enabled then
    btnAceptar.Click;
end;

procedure TFMEntregasCompra.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F5: if btnBorrar.Enabled then btnBorrar.Click;
    VK_F1: if btnAceptar.Enabled then btnAceptar.Click;
    VK_ESCAPE: btnCancelar.Click;
  end;
end;

end.


