unit DSelectFactura;

///////////////////////////////////////////////////////////////////////
// ATENCION: PREPARADO PARA FACTURACION POR KILOS
///////////////////////////////////////////////////////////////////////

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Buttons, StdCtrls, BEdit, ExtCtrls,
  ActnList, Db, DBTables;

type
  TFDSelectFactura = class(TForm)
    Panel1: TPanel;
    sbAceptar: TSpeedButton;
    Grid: TDBGrid;
    ActionList1: TActionList;
    AAceptar: TAction;
    DataSource: TDataSource;
    procedure AAceptarExecute(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


function SelecionarFactura( const AOwner: TComponent; const AQuery: TQuery; var AEmpresa: string;
                            var AFactura: Integer; var AFecha: TDateTime ):boolean;


implementation

uses CVariables, UDMBaseDatos, DError, UDMAuxDB;

{$R *.DFM}

var
  FDSelectFactura: TFDSelectFactura;

function SelecionarFactura( const AOwner: TComponent; const AQuery: TQuery; var AEmpresa: string;
                            var AFactura: Integer; var AFecha: TDateTime ):boolean;
begin
  result:= True;
  FDSelectFactura:= TFDSelectFactura.Create( AOwner );
  try
    FDSelectFactura.DataSource.DataSet:= AQuery;
    FDSelectFactura.ShowModal;
    AEmpresa:= AQuery.FieldByName('empresa_f').AsString;
    AFactura:= AQuery.FieldByName('n_factura_f').AsInteger;
    AFecha:= AQuery.FieldByName('fecha_factura_f').AsDateTime;
  finally
    FreeAndNil(FDSelectFactura);
  end;
end;


procedure TFDSelectFactura.AAceptarExecute(Sender: TObject);
begin
  Close;
end;

procedure TFDSelectFactura.GridDblClick(Sender: TObject);
begin
  Close;
end;

end.
