unit UFKilosComercializadosMes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DB, DBTables;

type
  TFKilosComercializadosMes = class(TForm)
    lblSeleccionarMes: TLabel;
    mmoResultado: TMemo;
    dtpMes: TDateTimePicker;
    btnCalcular: TButton;
    btnCerrar: TButton;
    lbldatos: TLabel;
    Query: TQuery;
    lbl1: TLabel;
    procedure btnCerrarClick(Sender: TObject);
    procedure btnCalcularClick(Sender: TObject);
    procedure dtpMesChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    dIni, dFin: TDateTime;
  public
    { Public declarations }
  end;

  procedure ShowKilosComercializadosMes( AOwner: TComponent );

implementation

{$R *.dfm}

uses
  bTimeUtils, bTextUtils;

procedure ShowKilosComercializadosMes( AOwner: TComponent );
var
  FKilosComercializadosMes: TFKilosComercializadosMes;
begin
  FKilosComercializadosMes:= TFKilosComercializadosMes.Create( AOwner );
  try
    FKilosComercializadosMes.ShowModal;
  finally
    FreeAndNil( FKilosComercializadosMes );
  end;
end;

procedure TFKilosComercializadosMes.FormCreate(Sender: TObject);
begin
  Query.SQL.Clear;
  Query.SQL.Add( 'select centro_origen_sl, categoria_sl, sum(kilos_sl) kilos');
  Query.SQL.Add( 'from frf_salidas_l ');
  Query.SQL.Add( 'where empresa_sl = ''050'' ');
  Query.SQL.Add( 'and fecha_sl between :fechaini and :fechafin ');
  Query.SQL.Add( 'and categoria_sl in (''1'',''2'') ');
  Query.SQL.Add( 'group by 1,2 ');
  Query.SQL.Add( 'order by 1,2 ');

  dtpMes.DateTime:= IncMonth( Now, -1 );
  dtpMesChange( dtpMes );
end;

procedure TFKilosComercializadosMes.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFKilosComercializadosMes.btnCalcularClick(Sender: TObject);
begin
  //Calcular;
  mmoResultado.Lines.Clear;
  mmoResultado.Lines.Add( 'ORIGEN CATEGORIA     KILOS');
  Query.ParamByName('fechaini').AsDate:= dIni;
  Query.ParamByName('fechafin').AsDate:= dFin;
  Query.Open;
  while not Query.Eof do
  begin
    mmoResultado.Lines.Add( RellenaDer( Query.FieldByName('centro_origen_sl').AsString, 7) +
                            RellenaDer( Query.FieldByName('categoria_sl').AsString, 3) +
                            RellenaIzq( FormatFloat('#,##0.00', Query.FieldByName('kilos').AsFloat ), 16)  );
    Query.Next;
  end;
  Query.Close;
end;

procedure TFKilosComercializadosMes.dtpMesChange(Sender: TObject);
var
  iYear, iMonth, iDay: word;
begin
  DecodeDate( dtpMes.DateTime, iYear, iMonth, iDay );
  lblDatos.Caption:= desMes( iMonth ) + ', ' + IntToStr( iYear );
  dIni:= PrimerDiaMes( dtpMes.DateTime );
  dFin:= UltimoDiaMes( dtpMes.DateTime );
end;


end.
