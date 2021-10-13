unit CDBEntregas;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDBEntregas = class(TDataModule)
    QKeyAlbaran: TQuery;
    QGetAlbaran: TQuery;
    QCajasPaletsPB: TQuery;
    QPaletsPB: TQuery;
    QTaraPaletaPB: TQuery;
    QLineas: TQuery;
    QCajasLineas: TQuery;
    QEntregas: TQuery;
    QKilosLineas: TQuery;
    QKilosVariedad: TQuery;
    QLineasSinKilos: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }

    function  DestararPalet( const APesoBruto: real ): real;
    function  TararPalet( const APesoNeto: real ): real;
    function  DestararLinea( const APesoBruto: real ): real;
    procedure PonerPesos;
  public
    { Public declarations }
  end;

  procedure InicializarModulo( AOwner: TComponent; const ADataBaseName: String );
  procedure FinalizarModulo;

  function  ExisteLineaSinKilos( const AEntrega: string ): boolean;
  function  ExisteAlbaranProveedor( const AEmpresa, AProveedor, AAlmacen, AFecha, AAlbaran: string ): boolean;
  function  GetNumeroAlbaran( const ACodigo: string ): String;
  (*
  procedure RepercutirPesosPaletsPB( const AEntrega: string; const AKilos: Real );
  procedure RepercutirPesosLineas( const AEntrega: string; const AKilos: Real );
  *)
  procedure RepercutirPesosPalets( const AEntrega: string; const AKilos: Real );
  procedure RepercutirPesosEntrega( const AEntrega: string; const AKilos: Real );

  procedure PonerPesos( AOwner: TComponent; const ADataBaseName: String );



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
    SQL.Add('   and almacen_ec = :almacen ');
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
end;

function ExisteAlbaranProveedor( const AEmpresa, AProveedor, AAlmacen, AFecha, AAlbaran: string ): boolean;
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
      ParamByName('almacen').AsString:= AAlmacen;
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

function TDBEntregas.DestararPalet( const APesoBruto: real ): real;
begin
  with DBEntregas do
  begin
    QTaraPaletaPB.ParamByName('empresa').AsString:= QPaletsPB.FieldByName('empresa').AsString;
    QTaraPaletaPB.ParamByName('proveedor').AsString:= QPaletsPB.FieldByName('proveedor').AsString;
    QTaraPaletaPB.ParamByName('producto').AsString:= QPaletsPB.FieldByName('producto').AsString;
    QTaraPaletaPB.ParamByName('variedad').AsInteger:= QPaletsPB.FieldByName('variedad').AsInteger;
    QTaraPaletaPB.Open;
    result:= APesoBruto - bRoundTo( QTaraPaletaPB.FieldByName('peso_paleta_pp').AsFloat +
             ( QTaraPaletaPB.FieldByName('peso_cajas_pp').AsFloat *
               QPaletsPB.FieldByName('cajas').AsInteger ), -2 );
    QTaraPaletaPB.Close;
  end;
end;

function TDBEntregas.TararPalet( const APesoNeto: real ): real;
begin
  with DBEntregas do
  begin
    QTaraPaletaPB.ParamByName('empresa').AsString:= QPaletsPB.FieldByName('empresa').AsString;
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

function TDBEntregas.DestararLinea( const APesoBruto: real ): real;
var
  iPalets: integer;
begin
  with DBEntregas do
  begin
    iPalets:= QLineas.FieldByName('palets_el').AsInteger;
    if iPalets = 0 then
      iPalets:= 1;
    QTaraPaletaPB.ParamByName('empresa').AsString:= QLineas.FieldByName('empresa_el').AsString;
    QTaraPaletaPB.ParamByName('proveedor').AsString:= QLineas.FieldByName('proveedor_el').AsString;
    QTaraPaletaPB.ParamByName('producto').AsString:= QLineas.FieldByName('producto_el').AsString;
    QTaraPaletaPB.ParamByName('variedad').AsInteger:= QLineas.FieldByName('variedad_el').AsInteger;
    QTaraPaletaPB.Open;
    result:= APesoBruto - bRoundTo( ( QTaraPaletaPB.FieldByName('peso_paleta_pp').AsFloat * iPalets ) +
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

procedure RepercutirPesosPalets( const AEntrega: string; const AKilos: Real );
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
(*
procedure RepercutirPesosPaletsPB( const AEntrega: string; const AKilos: Real );
var
  iCajas: integer;
  rKilosCaja: real;
begin
  if iInstancias = 0 then
  begin
    Raise Exception.Create('Falta inicializar modulo de datos entregas [CDBEntregas].');
  end;

  With DBEntregas.QCajasPaletsPB do
  begin
    ParamByName('entrega').AsString:= AEntrega;
    Open;
    iCajas:= FieldByName('cajas').AsInteger;
    Close;
  end;

  if iCajas <> 0 then
  begin
    rKilosCaja:= AKilos / iCajas;

    With DBEntregas.QPaletsPB do
    begin
      ParamByName('entrega').AsString:= AEntrega;
      Open;
      while not Eof do
      begin
        Edit;
        FieldByName('peso_bruto').AsFloat:= bRoundTo( FieldByName('cajas').AsInteger * rKilosCaja, -2 );
        FieldByName('peso').AsFloat:= DBEntregas.DestararPalet( FieldByName('peso_bruto').AsFloat );
        Post;

        Next;
      end;
      Close;
    end;
  end;
end;
*)

procedure RepercutirPesosEntrega( const AEntrega: string; const AKilos: Real );
var
  rKilos: integer;
  rKilosKilo: real;
begin
  (*MODIFOCADO A PETICION DE VANESSA EL 5/10/2009
    AHORA EN VEZ DE LA MEDIA ARITMETICA DE LAS CAJAS
    USAMOS LA MEDIA ARITMETICA DE LOS KILOS GRABADOS EN COMERCIAL*)
  if iInstancias = 0 then
  begin
    Raise Exception.Create('Falta inicializar modulo de datos entregas [CDBEntregas].');
  end;

  With DBEntregas.QKilosLineas do
  begin
    ParamByName('entrega').AsString:= AEntrega;
    Open;
    rKilos:= FieldByName('kilos').AsInteger;
    Close;
  end;

  if rKilos <> 0 then
  begin
    rKilosKilo:= AKilos / rKilos;

    With DBEntregas.QLineas do
    begin
      ParamByName('entrega').AsString:= AEntrega;
      Open;
      while not Eof do
      begin
        Edit;
        FieldByName('peso_el').AsFloat:= DBEntregas.DestararLinea( bRoundTo( FieldByName('kilos_el').AsInteger * rKilosKilo, -2 ) );
        Post;

        Next;
      end;
      Close;
    end;
  end;
  RepercutirPesosPalets( AEntrega, AKilos );
end;
(*
procedure RepercutirPesosLineas( const AEntrega: string; const AKilos: Real );
var
  iCajas: integer;
  rKilosCaja: real;
begin
  if iInstancias = 0 then
  begin
    Raise Exception.Create('Falta inicializar modulo de datos entregas [CDBEntregas].');
  end;

  With DBEntregas.QCajasLineas do
  begin
    ParamByName('entrega').AsString:= AEntrega;
    Open;
    iCajas:= FieldByName('cajas').AsInteger;
    Close;
  end;

  if iCajas <> 0 then
  begin
    rKilosCaja:= AKilos / iCajas;

    With DBEntregas.QLineas do
    begin
      ParamByName('entrega').AsString:= AEntrega;
      Open;
      while not Eof do
      begin
        Edit;
        FieldByName('peso_el').AsFloat:= DBEntregas.DestararLinea( bRoundTo( FieldByName('cajas_el').AsInteger * rKilosCaja, -2 ) );
        Post;

        Next;
      end;
      Close;
    end;
  end;
end;
*)

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

procedure PonerPesos( AOwner: TComponent; const ADataBaseName: String );
begin
  InicializarModulo( AOwner, ADataBaseName );
  try
    DBEntregas.PonerPesos;
  finally
    FinalizarModulo;
  end;
end;

procedure TDBEntregas.PonerPesos;
begin
  With QEntregas do
  begin
    DatabaseName:= sDataBaseName;
    SQL.Clear;
    SQL.Add(' select codigo_ec codigo, peso_entrada_ec - peso_salida_ec kilos ');
    SQL.Add(' from frf_entregas_c ');
    SQL.Add(' where peso_entrada_ec - peso_salida_ec > 0 ');
    Open;
    while not Eof do
    begin
      //RepercutirPesosPaletsPB( FieldByName('codigo').AsString, FieldByName('kilos').AsFloat );
      RepercutirPesosEntrega( FieldByName('codigo').AsString, FieldByName('kilos').AsFloat );
      Next;
    end;
    Close;
  end;
end;

end.
