unit PaisesDM;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMPaises = class(TDataModule)
    QMaestro: TQuery;
    QListado: TQuery;
    QMaestropais_p: TStringField;
    QMaestrodescripcion_p: TStringField;
    QMaestrooriginal_name_p: TStringField;
    QMaestromoneda_p: TStringField;
    QMaestrocomunitario_p: TSmallintField;
    QListadopais_p: TStringField;
    QListadodescripcion_p: TStringField;
    QListadooriginal_name_p: TStringField;
    QListadomoneda_p: TStringField;
    QListadocomunitario_p: TSmallintField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    sSelect, sFrom, sWhere, sOrder: string;
    sSelectL, sFromL, sWhereL, sGroupL, sOrderL: string;

  public
    { Public declarations }
    procedure VisualizarListado( const AFiltro: String );
    procedure Localizar( const AFiltro: String );
  end;

var
  DMPaises: TDMPaises;

implementation

{$R *.dfm}

uses bTextUtils, UDMAuxDB, PaisesQM;

procedure TDMPaises.DataModuleCreate(Sender: TObject);
begin
  with QMaestro do
  begin
    SQL.Clear;
    SQL.Add(' select * from frf_paises where pais_p = ''##'' ');
  end;

  //Mantenimiento cab
  sSelect:= 'select * ';
  sFrom:= 'From frf_paises ';
  sWhere:= '';
  sOrder:= 'order by pais_p';

  //Listado
  sSelectL:= 'select * ';
  sFromL:= 'From frf_paises ';
  sWhereL:= '';
  sGroupL:= '';
  sOrderL:= 'order by pais_p';
end;

procedure TDMPaises.Localizar( const AFiltro: String );
begin
  sWhere:= AFiltro;
  with QMaestro do
  begin
    Close;
    SQL.Clear;
    SQL.Add( sSelect );
    SQL.Add( sFrom );
    SQL.Add( sWhere );
    SQL.Add( sOrder );
    try
      Open;
    except
      raise Exception.Create( 'Error a aplicar el filtro.' );
    end;
  end;
end;

procedure TDMPaises.VisualizarListado( const AFiltro: String );
begin
  sWhere:= AFiltro;
  with QListado do
  begin
    SQL.Clear;
    SQL.Add( sSelectL );
    SQL.Add( sFromL );
    SQL.Add( sWhereL );
    SQL.Add( sGroupL );
    SQL.Add( sOrderL );
    Open;
    try
      if not IsEmpty then
      begin
        PaisesQM.VisualizarListado( self );
      end;
    finally
      Close;
    end;
  end;
end;

end.
