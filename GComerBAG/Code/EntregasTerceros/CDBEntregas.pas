unit CDBEntregas;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDBEntregas = class(TDataModule)
    QKeyAlbaran: TQuery;
    QGetAlbaran: TQuery;
    QPaletsPB: TQuery;
    QTaraPaletaPB: TQuery;
    QLineas: TQuery;
    QKilosVariedad: TQuery;
    QLineasSinKilos: TQuery;
    QEntregasCamion: TQuery;
    QKilosTeoricos: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }

    //function  DestararPalet( const APesoBruto: real ): real;
    function  TararPalet( const APesoNeto: real ): real;
    function  TararLinea: real;
  public
    { Public declarations }
  end;

  procedure InicializarModulo( AOwner: TComponent; const ADataBaseName: String );
  procedure FinalizarModulo;

  procedure EntradasCamion( const AVehiculo, AFecha: string; var AEntregas: TStringList );
  function  KilosTeorico( const AEntrega: string ): real;
  function  ExisteLineaSinKilos( const AEntrega: string ): boolean;
  function  ExisteAlbaranProveedor( const AEmpresa, AProveedor, AFecha, AAlbaran: string ): boolean;
  function  GetNumeroAlbaran( const ACodigo: string ): String;
  procedure RepercutirPesosPalets( const AEntrega: string );
  procedure RepercutirPesosEntrega( const AEntrega: string; const AKilosTeoricos, AKilosReal: real );


implementation

{$R *.dfm}

uses UDMBaseDatos, bMath, UDMConfig;

var
  DBEntregas: TDBEntregas;
  iInstancias: integer = 0;
  sDataBaseName: string;

procedure InicializarModulo( AOwner: TComponent; const ADataBaseName: String );
begin
  if iInstancias = 0 then
  begin
    sDataBaseName:= ADataBaseName;
    DBEntregas:= TDBEntregas.Create( AOwner );
  end;
  Inc( iInstancias );
end;

procedure FinalizarModulo;
begin
  Inc( iInstancias, -1 );
  if iInstancias = 0 then
  begin
    FreeAndNil( DBEntregas );
  end;
end;

procedure TDBEntregas.DataModuleCreate(Sender: TObject);
begin
  With QKeyAlbaran do
  begin
    DatabaseName:= sDataBaseName;
    SQL.Clear;
    SQL.Add(' select * from frf_entregas_c ');
    SQL.Add(' where empresa_ec = :empresa ');
    SQL.Add('   and TRIM(proveedor_ec) = :proveedor ');
    SQL.Add('   and fecha_carga_ec = :fecha ');
    SQL.Add('   and albaran_ec = :albaran ');
    Prepare;
  end;

  With QGetAlbaran do
  begin
    DatabaseName:= sDataBaseName;
    SQL.Clear;
    SQL.Add(' select albaran_ec ');
    SQL.Add(' from frf_entregas_c ');
    SQL.Add(' where codigo_ec = :codigo ');
    Prepare;
  end;

  if (DMConfig.EsMaset or DMConfig.EsFrutibon) then
  begin
    With QPaletsPB do
    begin
      DatabaseName:= sDataBaseName;
      SQL.Clear;
      SQL.Add(' select * ');
      SQL.Add(' from rf_palet_pb ');
      SQL.Add(' where entrega = :entrega ');
      SQL.Add(' and status <> ''B'' ');
      Prepare;
    end;
    With QKilosVariedad do
    begin
      DatabaseName:= sDataBaseName;
      SQL.Clear;
      SQL.Add(' select round( sum ( nvl(peso_el,0) ) / sum( cajas_el), 3) kilos_caja ');
      SQL.Add(' from frf_entregas_l ');
      SQL.Add(' where codigo_el = :entrega ');
      SQL.Add(' and variedad_el = :variedad ');
      Prepare;
    end;
    With QLineas do
    begin
      DatabaseName:= sDataBaseName;
      SQL.Clear;
      SQL.Add(' select * ');
      SQL.Add(' from frf_entregas_l ');
      SQL.Add(' where codigo_el = :entrega ');
      Prepare;
    end;
    With QTaraPaletaPB do
    begin
      DatabaseName:= sDataBaseName;
      SQL.Clear;
      SQL.Add(' select peso_paleta_pp, peso_cajas_pp ');
      SQL.Add(' from frf_productos_proveedor ');
      SQL.Add(' where proveedor_pp = :proveedor ');
      SQL.Add(' and producto_pp = :producto ');
      SQL.Add(' and variedad_pp = :variedad ');
      Prepare;
    end;

    With QLineasSinKilos do
    begin
      DatabaseName:= sDataBaseName;
      SQL.Clear;
      SQL.Add(' select * ');
      SQL.Add(' from frf_entregas_l ');
      SQL.Add(' where codigo_el = :entrega ');
      SQL.Add(' and nvl(kilos_el,0) = 0 ');
      Prepare;
    end;

    With QEntregasCamion do
    begin
      DatabaseName:= sDataBaseName;
      SQL.Clear;
      SQL.Add(' select codigo_ec ');
      SQL.Add(' from frf_entregas_c ');
      SQL.Add(' where vehiculo_ec like :matricula ');
      SQL.Add(' and fecha_llegada_ec = :fecha ');
      Prepare;
    end;

    With QKilosTeoricos do
    begin
      DatabaseName:= sDataBaseName;
      SQL.Clear;
      SQL.Add(' select sum( nvl(palets_el,0) * ( select nvl(peso_paleta_pp,0) from frf_productos_proveedor ');
      SQL.Add('                                  where proveedor_pp = proveedor_el ');
      SQL.Add('                                  and producto_pp = producto_el and variedad_pp = variedad_el ) ) + ');
      SQL.Add('        sum(nvl(cajas_el,0) * ( select nvl(peso_cajas_pp,0) from frf_productos_proveedor ');
      SQL.Add('                                where proveedor_pp = proveedor_el ');
      SQL.Add('                                and producto_pp = producto_el and variedad_pp = variedad_el ) )  + ');
      SQL.Add('        sum(nvl(kilos_el,0)) kilos ');
      SQL.Add(' from frf_entregas_l ');
      SQL.Add(' where codigo_el = :entrega ');
      Prepare;
    end;
  end;
end;

procedure TDBEntregas.DataModuleDestroy(Sender: TObject);
begin
  With QKeyAlbaran do
  begin
    if Prepared then
      UnPrepare;
  end;
  With QGetAlbaran do
  begin
    if Prepared then
      UnPrepare;
  end;
  if (DMConfig.EsMaset or DMConfig.EsFrutibon) then
  begin
    With QPaletsPB do
    begin
      if Prepared then
        UnPrepare;
    end;
    With QKilosVariedad do
    begin
      if Prepared then
        UnPrepare;
    end;
    With QLineaS do
    begin
      if Prepared then
        UnPrepare;
    end;
    With QTaraPaletaPB do
    begin
      if Prepared then
        UnPrepare;
    end;
    With QLineasSinKilos do
    begin
      if Prepared then
        UnPrepare;
    end;

    With QEntregasCamion do
    begin
      if Prepared then
        UnPrepare;
    end;

    With QKilosTeoricos do
    begin
      if Prepared then
        UnPrepare;
    end;
  end;
end;


function ExisteAlbaranProveedor( const AEmpresa, AProveedor, AFecha, AAlbaran: string ): boolean;
begin
  if iInstancias = 0 then
  begin
    Raise Exception.Create('Falta inicializar modulo de datos entregas [CDBEntregas].');
  end;

  if AAlbaran = '0' then
  begin
    result:= False;
  end
  else
  begin
    With DBEntregas.QKeyAlbaran do
    begin
      ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('proveedor').AsString:= AProveedor;
      ParamByName('fecha').AsString:= AFecha;
      ParamByName('albaran').AsString:= AAlbaran;
      Open;
      result:= not IsEmpty;
      Close;
    end;
  end;
end;

function GetNumeroAlbaran( const ACodigo: string ): String;
begin
  if iInstancias = 0 then
  begin
    Raise Exception.Create('Falta inicializar modulo de datos entregas [CDBEntregas].');
  end;

  if Length( ACodigo ) <> 12 then
  begin
    result:= '';
  end
  else
  begin
    With DBEntregas.QGetAlbaran do
    begin
      ParamByName('codigo').AsString:= ACodigo;
      Open;
      result:= FieldByName('albaran_ec').AsString;
      Close;
    end;
  end;
end;

function TDBEntregas.TararPalet( const APesoNeto: real ): real;
begin
  with DBEntregas do
  begin
    QTaraPaletaPB.ParamByName('proveedor').AsString:= QPaletsPB.FieldByName('proveedor').AsString;
    QTaraPaletaPB.ParamByName('producto').AsString:= QPaletsPB.FieldByName('producto').AsString;
    QTaraPaletaPB.ParamByName('variedad').AsInteger:= QPaletsPB.FieldByName('variedad').AsInteger;
    QTaraPaletaPB.Open;
    result:= APesoNeto + bRoundTo( QTaraPaletaPB.FieldByName('peso_paleta_pp').AsFloat +
             ( QTaraPaletaPB.FieldByName('peso_cajas_pp').AsFloat *
               QPaletsPB.FieldByName('cajas').AsInteger ), -2 );
    QTaraPaletaPB.Close;
  end;
end;

function TDBEntregas.TararLinea: real;
var
  iPalets: integer;
begin
  with DBEntregas do
  begin
    iPalets:= QLineas.FieldByName('palets_el').AsInteger;
    QTaraPaletaPB.ParamByName('proveedor').AsString:= QLineas.FieldByName('proveedor_el').AsString;
    QTaraPaletaPB.ParamByName('producto').AsString:= QLineas.FieldByName('producto_el').AsString;
    QTaraPaletaPB.ParamByName('variedad').AsInteger:= QLineas.FieldByName('variedad_el').AsInteger;
    QTaraPaletaPB.Open;
    result:= bRoundTo( ( QTaraPaletaPB.FieldByName('peso_paleta_pp').AsFloat * iPalets ) +
                                         ( QTaraPaletaPB.FieldByName('peso_cajas_pp').AsFloat *
                                           QLineas.FieldByName('cajas_el').AsInteger ),
                                          -2 );
    QTaraPaletaPB.Close;
  end;
end;

function KilosCajaVariedad( const AEntrega: string;
                            const AVariedad: integer ): real;
begin
  with DBEntregas.QKilosVariedad do
  begin
    ParamByName('entrega').AsString:= AEntrega;
    ParamByName('variedad').AsInteger:= AVariedad;
    try
      try
        Open;
        result:= FieldByname('kilos_caja').AsFloat;
      except
        result:= 0;
      end;
    finally
      Close;
    end;
  end;
end;

procedure RepercutirPesosPalets( const AEntrega: string );
  (*MODIFOCADO A PETICION DE VANESSA EL 5/10/2009
    AHORA EN VEZ DE LA MEDIA ARITMETICA DE LAS CAJAS
    USAMOS LA MEDIA ARITMETICA DE LOS KILOS GRABADOS EN COMERCIAL*)
var
  rKilosCaja: real;
begin
  With DBEntregas.QPaletsPB do
  begin
    ParamByName('entrega').AsString:= AEntrega;
    Open;
    while not Eof do
    begin
      rKilosCaja:= KilosCajaVariedad( AEntrega, FieldByName('variedad').AsInteger );
      Edit;
      FieldByName('peso').AsFloat:= bRoundTo( FieldByName('cajas').AsInteger * rKilosCaja, -2 );
      FieldByName('peso_bruto').AsFloat:= DBEntregas.TararPalet( FieldByName('peso').AsFloat );
      Post;

      Next;
     end;
    Close;
  end;
end;
procedure RepercutirPesosEntrega( const AEntrega: string; const AKilosTeoricos, AKilosReal: Real );
var
  rAux, rTara: real;
begin
  (*MODIFOCADO A PETICION DE VANESSA EL 5/10/2009
    AHORA EN VEZ DE LA MEDIA ARITMETICA DE LAS CAJAS
    USAMOS LA MEDIA ARITMETICA DE LOS KILOS GRABADOS EN COMERCIAL*)
  if iInstancias = 0 then
  begin
    Raise Exception.Create('Falta inicializar modulo de datos entregas [CDBEntregas].');
  end;

  With DBEntregas.QLineas do
  begin
    ParamByName('entrega').AsString:= AEntrega;
    Open;
     while not Eof do
     begin
       rTara:= DBEntregas.TararLinea;
       rAux:= bRoundTo( ( ( FieldByName('kilos_el').AsFloat + rTara ) * AKilosReal ) / AKilosTeoricos, -2 );
       Edit;
       FieldByName('peso_el').AsFloat:= rAux - rTara;
       Post;
       Next;
     end;
     Close;
  end;
  RepercutirPesosPalets( AEntrega );
end;

function  ExisteLineaSinKilos( const AEntrega: string ): boolean;
begin
  with DBEntregas.QLineasSinKilos do
  begin
    ParamByName('entrega').AsString:= AEntrega;
    Open;
    result:= not IsEmpty;
    Close;
  end;
end;

procedure EntradasCamion( const AVehiculo, AFecha: string; var AEntregas: TStringList );
begin
  with DBEntregas.QEntregasCamion do
  begin
    ParamByName('matricula').AsString:= '%' + AVehiculo + '%';
    ParamByName('fecha').AsDate:= StrToDate( AFecha );
    Open;
    while not Eof do
    begin
      AEntregas.Add( FieldByName('codigo_ec').AsString );
      nEXT;
    end;
    Close;
  end;
end;

function KilosTeorico( const AEntrega: string ): real;
begin
  with DBEntregas.QKilosTeoricos do
  begin
    ParamByName('entrega').AsString:= AEntrega;
    Open;
    result:= FieldByname('kilos').AsFloat;
    Close;
  end;
end;

end.
