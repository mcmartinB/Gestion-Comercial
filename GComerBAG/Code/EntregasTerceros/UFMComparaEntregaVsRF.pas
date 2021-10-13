unit UFMComparaEntregaVsRF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, DBTables, Grids, DBGrids;

type
  TFMComparaEntregaVsRF = class(TForm)
    DSEntrega: TDataSource;
    DSRF: TDataSource;
    dbgEntrega: TDBGrid;
    dbgRF: TDBGrid;
    QEntrega: TQuery;
    QRF: TQuery;
    lblEntrega: TLabel;
    lblRF: TLabel;
    lblMsg: TLabel;
    btnCerrar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnCerrarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function ExistenDifEntregaVsRF( const AEntrega: string ): Boolean;
  end;

  function ExistenDifEntregaVsRF( const AOwner: TComponent; const AEntrega: string ): Boolean;


implementation

{$R *.dfm}

var
  FMComparaEntregaVsRF: TFMComparaEntregaVsRF;

function ExistenDifEntregaVsRF( const AOwner: TComponent; const AEntrega: string ): Boolean;
begin
  FMComparaEntregaVsRF:= TFMComparaEntregaVsRF.Create( AOwner );
  try
    if FMComparaEntregaVsRF.ExistenDifEntregaVsRF( AEntrega ) then
    begin
     result:= True;
     FMComparaEntregaVsRF.ShowModal;
    end
    else
    begin
      result:= False;
    end;
  finally
    FreeAndNil( FMComparaEntregaVsRF );
  end;
end;

procedure TFMComparaEntregaVsRF.FormCreate(Sender: TObject);
begin
  with QEntrega do
  begin
    SQL.Clear;
    SQL.Add(' select proveedor_el proveedor, producto_el producto, variedad_el variedad, ');
    SQL.Add('        categoria_el categoria, calibre_el calibre, ');
    SQL.Add('        sum( palets_el ) palets, sum(cajas_el) cajas '); //, sum(kilos_el) kilos ');
    SQL.Add(' from frf_entregas_l ');
    SQL.Add(' where codigo_el = :entrega ');
    SQL.Add(' group by proveedor_el, producto_el, variedad_el, categoria_el, calibre_el ');
    SQL.Add(' order by proveedor_el, producto_el, variedad_el, categoria_el, calibre_el ');
  end;
  with QRF do
  begin
    SQL.Clear;  SQL.Add(' select proveedor, producto, variedad, categoria, calibre, ');
    SQL.Add('        count( distinct sscc ) palets, sum(cajas) cajas '); //, sum(peso) cajas ');
    SQL.Add(' from rf_palet_pb ');
    SQL.Add(' where entrega = :entrega ');
    SQL.Add(' group by proveedor, producto, variedad, categoria, calibre ');
    SQL.Add('order by proveedor, producto, variedad, categoria, calibre ');
  end;
end;

procedure TFMComparaEntregaVsRF.FormDestroy(Sender: TObject);
begin
  QEntrega.Close;
  QRF.Close;
end;

procedure TFMComparaEntregaVsRF.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

function TFMComparaEntregaVsRF.ExistenDifEntregaVsRF( const AEntrega: string ): Boolean;
var
  i: integer;
begin
  result:= True;

  QEntrega.ParamByName('entrega').AsString:= AEntrega;
  QEntrega.Open;
  if not QEntrega.IsEmpty then
  begin
    QRF.ParamByName('entrega').AsString:= AEntrega;
    QRF.Open;
    if not QRF.IsEmpty then
    begin
      result:= False;
      while not QEntrega.Eof and not result do
      begin
        i:= 0;
        while ( i < QEntrega.FieldCount ) and not result do
        begin
          result:= QEntrega.Fields[i].Value <> QRF.Fields[i].Value;
        end;
        if not result then
        begin
          QEntrega.Next;
          QRF.Next;
        end;
      end;
      result:= not QEntrega.Eof;
    end;
  end;
end;


end.
