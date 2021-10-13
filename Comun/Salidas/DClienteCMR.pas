unit DClienteCMR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls, Buttons, Grids, DBGrids, UDMCmr;

type
  TFDClienteCMR = class(TForm)
    MemoOrigen: TMemo;
    MemoCliente: TMemo;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    lblEntrega: TLabel;
    mmoEntrega: TMemo;
    lblcarga: TLabel;
    mmoCarga: TMemo;
    qryCliente: TQuery;
    qryEmpresa: TQuery;

    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    sDesRemitente: string;

    procedure OpenData;
    procedure CloseData;

    procedure DatosRemitente;
    procedure DatosLugarCarga;
    procedure DatosConsignatario;
    procedure DatosLugarEntrega;

    procedure PutEmpresa( Memo: TStrings; const ANif: boolean );
    procedure PutCentro( Memo: TStrings; const ANif: boolean );
    procedure PutCliente( Memo: TStrings; const ANif: boolean );
    procedure PutSuministro(  Memo: TStrings; const ANif: boolean );
    procedure PutSuministroAmpliado(  Memo: TStrings; const ANif: boolean );
  public
    { Public declarations }
    sEmpresa, sCentro, sCliente, sSuministro: string;
    procedure LoadData;

  end;

procedure ClienteCMRExec(const AEmpresa, ACentro, ACliente, ASuministro: string; var CabCMR: RCabCMR);

implementation

{$R *.dfm}

uses UDMAuxDB;

var
  FDClienteCMR: TFDClienteCMR;

(*
DAI LOGISTIC SOLUTION SP. Z.O.O
ULICA PODWALNA 12
DZIERZONIOW
*)
(*
S.A.T.  Nº  9359  BONNYSA
O.P.F.H.  Nº  345
Camino de los Llanos,   22
03110   MUCHAMIEL   ( Alicante )
*)

procedure ClienteCMRExec(const AEmpresa, ACentro, ACliente, ASuministro: string; var CabCMR: RCabCMR);
begin
  Application.CreateForm( TFDClienteCMR, FDClienteCMR );
  try
    FDClienteCMR.sEmpresa:= AEmpresa;
    FDClienteCMR.sCentro:= ACentro;
    FDClienteCMR.sCliente:= ACliente;
    FDClienteCMR.sSuministro:= ASuministro;

    FDClienteCMR.LoadData;
    FDClienteCMR.ShowModal;

    CabCMR.Remitente.AddStrings(FDClienteCMR.MemoOrigen.Lines);
    CabCMR.Consignatario.AddStrings(FDClienteCMR.MemoCliente.Lines);
    CabCMR.Entrega.AddStrings( FDClienteCMR.mmoEntrega.Lines );
    CabCMR.Carga.AddStrings( FDClienteCMR.mmoCarga.Lines );
  finally
    FreeAndNil( FDClienteCMR );
  end;
end;


procedure TFDClienteCMR.FormCreate(Sender: TObject);
begin
    qryEmpresa.SQL.Clear;
    qryEmpresa.SQL.Add(' select nombre_e, nif_e, tipo_via_e, domicilio_e, cod_postal_e, poblacion_e, ''ES'' pais_e, ');
    qryEmpresa.SQL.Add('        descripcion_c, direccion_c, cod_postal_c, poblacion_c, pais_c ');
    qryEmpresa.SQL.Add(' from frf_empresas ');
    qryEmpresa.SQL.Add('      join frf_centros on empresa_e = empresa_c ');
    qryEmpresa.SQL.Add(' where empresa_e = :empresa ');
    qryEmpresa.SQL.Add(' and centro_c = :centro ');

    qryCliente.SQL.Clear;
    qryCliente.SQL.Add(' select nombre_c, nif_c, tipo_via_c, domicilio_c, cod_postal_c, poblacion_c, pais_c, ');
    qryCliente.SQL.Add(' nombre_ds, nif_ds, tipo_via_ds, domicilio_ds, cod_postal_ds, poblacion_ds, provincia_ds, pais_ds ');
    qryCliente.SQL.Add(' from frf_clientes ');
    qryCliente.SQL.Add('      join frf_dir_sum on cliente_ds = cliente_c ');
    qryCliente.SQL.Add(' where cliente_c = :cliente ');
    qryCliente.SQL.Add(' and dir_sum_ds = :dirsum ');
end;

procedure TFDClienteCMR.OpenData;
begin
  qryEmpresa.ParamByName('empresa').AsString:= sEmpresa;
  qryEmpresa.ParamByName('centro').AsString:= sCentro;
  qryEmpresa.Open;

  qryCliente.ParamByName('cliente').AsString:= sCliente;
  qryCliente.ParamByName('dirsum').AsString:= sSuministro;
  qryCliente.Open;
end;

procedure TFDClienteCMR.CloseData;
begin
  qryCliente.Close;
  qryEmpresa.Close;
end;

procedure TFDClienteCMR.LoadData;
var
  i, x: integer;
begin
  OpenData;

  if Copy( sEmpresa, 1, 1 ) = 'F' then
  begin
    sDesRemitente:= 'BONNYSA AGROALIMENTARIA';
  end
  else
  begin
    sDesRemitente:= qryEmpresa.FieldByName('nombre_e').AsString;
  end;

  (*
      QRLCMREdeka.qrmRazon.Lines.Add(' S.A.T.  Nº  9359  BONNYSA ');
      QRLCMREdeka.qrmRazon.Lines.Add(' O.P.F.H.  Nº  345 ');
      QRLCMREdeka.qrmRazon.Lines.Add(' CIF: F03842671 ');
  *)
  DatosRemitente;
  DatosLugarCarga;

  DatosConsignatario;
  DatosLugarEntrega;

  CloseData;
end;

procedure TFDClienteCMR.DatosRemitente;
var
  sProvincia: string;
begin
  MemoOrigen.Lines.Clear;
  if ( scliente = 'DAI' ) or ( scliente = 'LEN' ) or ( scliente = 'BEC' ) or ( scliente = 'HND' ) then
  begin
    if sCliente = 'LEN' then
    begin
      MemoOrigen.Lines.Clear;
      MemoOrigen.Lines.Add('LENFRUITS,S.L. CIF:B98528789');
      MemoOrigen.Lines.Add('Gandia,Valencia ( España)');
      MemoOrigen.Lines.Add('By order «TAVITON COMMERCIAL LTD »');
      MemoOrigen.Lines.Add('Craigmuir  Chambers, Road Town, B.V.I.');
      MemoOrigen.Lines.Add('Contract Nr:1506/12 from 15.06.2012');
    end
    else
    begin

      PutCliente( MemoOrigen.lines, true);
    end;
  end
  else
  begin
    PutEmpresa(MemoOrigen.Lines, true);
  end;
  MemoOrigen.SelStart := 0;
  MemoOrigen.SelLength := 0;
end;

procedure TFDClienteCMR.DatosLugarCarga;
var
  sAux, sProvincia: string;
begin
  MmoCarga.Lines.Clear;
  PutCentro(MmoCarga.Lines, false);
  MmoCarga.SelStart := 0;
  MmoCarga.SelLength := 0;
  (*
  if ( scliente = 'DAI' ) or ( scliente = 'LEN' ) or ( scliente = 'BEC' ) or ( scliente = 'HND' ) then
  begin
    if Copy(sEmpresa,1,1) = 'F' then
    begin
      MmoCarga.Lines.Add( 'BONNYSA S.A.T. Nº 9359');
      MmoCarga.Lines.Add( 'ESPAÑA');
    end
    else
    begin
      MmoCarga.Lines.Add( 'BONNYSA AGROALIMENTARIA');
      MmoCarga.Lines.Add( 'ESPAÑA');
    end;
  end
  else
  begin
    PutCentro(MmoCarga, false);
  end;
  *)
end;

procedure TFDClienteCMR.DatosConsignatario;
begin
  MemoCliente.Lines.Clear;
  if ( scliente = 'DAI' ) or ( scliente = 'LEN' ) or ( scliente = 'BEC' ) or ( scliente = 'HND' ) then
  begin
    if sCliente = 'LEN' then
    begin
      MemoCliente.Lines.Add('OOO “Fruktovy alians”');
      MemoCliente.Lines.Add('Of. 23, Build. 32, Ochakovskoe shosse');
      MemoCliente.Lines.Add('119530 Moscow , Russia');
      MemoCliente.Lines.Add('INN 7721672210');
    end
    else
    begin
      PutSuministro( MemoCliente.Lines, False );
      //PutSuministroAmpliado( MemoCliente.Lines, true );
      //PutCliente( MemoCliente.Lines, true );
    end;
  end
  else
  begin
    PutCliente( MemoCliente.Lines, true );
  End;
  MemoCliente.SelStart := 0;
  MemoCliente.SelLength := 0;
end;


procedure TFDClienteCMR.DatosLugarEntrega;
begin
  mmoEntrega.Lines.Clear;
  if ( scliente = 'DAI' ) or ( scliente = 'LEN' ) or ( scliente = 'BEC' ) or ( scliente = 'HND' ) then
  begin
    if sCliente = 'LEN' then
    begin
      mmoEntrega.Lines.Add('Moscu,g.Moskovskiy,centralnaya expedicia promzony');
    end
    else
    begin
      PutSuministro( mmoEntrega.Lines, false );
    end;
  end
  else
  if ( scliente = 'BEY' ) then
  begin
    mmoEntrega.Lines.Add('Russia, St.Petersburg, Sofiyskaya str., 60, skl 5 ');
    mmoEntrega.Lines.Add('LO, Lomonosovskii r-n, MO Villozskoe s.p., "Oficerskoe selo", Volhonsfoe Shosse, , kvart 1, d.11 B');
    mmoEntrega.Lines.Add('MO, Luberetsky r-n, pos. Tomilino, mkr. "Ptitsefabrika" KPP ?3, sklad K25 ');
    mmoEntrega.Lines.Add('MO, Naro-Fominskiy r-n, Sof''ino d. Petrovskii s/o. ');
    mmoEntrega.Lines.Add('MO, Mytischinskii r-n, g. Lobnya, Krasnopolyanskiy pr., d.1 ');
  end
  else
  begin
    PutSuministro( mmoEntrega.Lines, true );
  end;
  mmoEntrega.SelStart := 0;
  mmoEntrega.SelLength := 0;
end;

procedure TFDClienteCMR.PutEmpresa( Memo: TStrings; const ANif: boolean );
var
  sPais, sCIF,sProvincia: string;
begin
  //descripcion_c
  if qryEmpresa.FieldByName('pais_e').AsString <> '' then
    sPais:= qryEmpresa.FieldByName('pais_e').AsString
  else
    sPais:= 'ES';
  if sPais = 'ES' then
    sCIF:= ' (CIF: '
  else
    sCIF:= ' (VAT: ';
  sPais:= DesPais( sPais );
  sCIF:=  sCIF + qryEmpresa.FieldByName('nif_e').AsString + ')';

  if ANif then
    Memo.Add( sDesRemitente + sCIF )
  else
    Memo.Add( sDesRemitente );
  Memo.Add( Trim( qryEmpresa.FieldByName('tipo_via_e').AsString +  ' ' + qryEmpresa.FieldByName('domicilio_e').AsString ) );
  if Trim( qryEmpresa.FieldByName('cod_postal_e').AsString ) <>  '' then
  begin
    Memo.Add( qryEmpresa.FieldByName('cod_postal_e').AsString  + ' ' +
                          qryEmpresa.FieldByName('poblacion_e').AsString );
    sProvincia:= desProvincia( Copy( qryEmpresa.FieldByName('cod_postal_e').AsString, 1, 2 ) );
    if sProvincia <> '' then
      Memo.Add( sProvincia  + ' - ESPAÑA' )
    else
      Memo.Add( 'ESPAÑA' );
  end
  else
  begin
    Memo.Add( qryEmpresa.FieldByName('poblacion_e').AsString );
    Memo.Add( 'ESPAÑA' );
  end;
end;

procedure TFDClienteCMR.PutCentro( Memo: TStrings; const ANif: boolean );
var
  sPais, sCIF, sAux, sProvincia: string;
begin
  //descripcion_c
  if qryEmpresa.FieldByName('pais_c').AsString <> '' then
    sPais:= qryEmpresa.FieldByName('pais_c').AsString
  else
    sPais:= 'ES';
  if sPais = 'ES' then
    sCIF:= ' (CIF: '
  else
    sCIF:= ' (VAT: ';

  sPais:= DesPais( sPais );
  sCIF:=  sCIF + qryCliente.FieldByName('nif_c').AsString + ')';
  if ANif then
    Memo.Add( sDesRemitente + sCIF )
  else
    Memo.Add( sDesRemitente );

  Memo.Add( qryEmpresa.FieldByName('direccion_c').AsString );
  if Trim( qryEmpresa.FieldByName('cod_postal_c').AsString ) <>  '' then
  begin
    sAux:= qryEmpresa.FieldByName('cod_postal_c').AsString  + ' ' + qryEmpresa.FieldByName('poblacion_c').AsString;
    sProvincia:= desProvincia( Copy( qryEmpresa.FieldByName('cod_postal_c').AsString, 1, 2 ) );
    if sProvincia <> '' then
      sAux:= sAux + ' (' + sProvincia  + ') ' + sPais
    else
      sAux:= sAux + ' - ESPAÑA';
  end
  else
  begin
    sAux:= qryEmpresa.FieldByName('poblacion_e').AsString + ' -  ' + sPais;
  end;
  Memo.Add( sAux );
end;


procedure TFDClienteCMR.PutCliente( Memo: TStrings; const ANif: boolean );
var
  sPais, sCIF, sProvincia: string;
begin
  if qryCliente.FieldByName('pais_c').AsString <> '' then
    sPais:= qryCliente.FieldByName('pais_c').AsString
  else
    sPais:= 'ES';
  if sPais = 'ES' then
    sCIF:= ' (CIF: '
  else
    sCIF:= ' (VAT: ';

  if sPais = 'ES' then
    sProvincia:= DesProvincia( Copy( qryCliente.FieldByName('cod_postal_c').AsString, 1, 2 ))
  else
    sProvincia:= '';

  sPais:= DesPais( sPais, True );
  sCIF:=  sCIF + qryCliente.FieldByName('nif_c').AsString + ')';


  if ANif then
    Memo.Add(qryCliente.FieldByName('nombre_c').AsString + sCIF )
  else
    Memo.Add(qryCliente.FieldByName('nombre_c').AsString );
  Memo.Add(Trim( qryCliente.FieldByName('tipo_via_c').AsString + ' ' + qryCliente.FieldByName('domicilio_c').AsString) );
  Memo.Add(Trim( qryCliente.FieldByName('cod_postal_c').AsString + ' ' + qryCliente.FieldByName('poblacion_c').AsString));

  if Trim( sProvincia ) <> '' then
    Memo.Add( sProvincia + ' - ' + sPais )
  else
    Memo.Add( sPais );
end;

procedure TFDClienteCMR.PutSuministroAmpliado( Memo: TStrings; const ANif: boolean );
var
  sPais, sCIF: string;
begin
  if qryCliente.FieldByName('pais_c').AsString <> '' then
    sPais:= qryCliente.FieldByName('pais_c').AsString
  else
    sPais:= 'ES';
  if sPais = 'ES' then
    sCIF:= ' (CIF: '
  else
    sCIF:= ' (VAT: ';
  if Trim( qryCliente.FieldByName('nif_ds').AsString ) <> '' then
    sCIF:=  sCIF + qryCliente.FieldByName('nif_ds').AsString + ')'
  else
    sCIF:=  sCIF + qryCliente.FieldByName('nif_c').AsString + ')';


  if ANif then
    Memo.Add(qryCliente.FieldByName('nombre_c').AsString + sCIF )
  else
    Memo.Add(qryCliente.FieldByName('nombre_c').AsString );

  PutSuministro( Memo, False );
end;

procedure TFDClienteCMR.PutSuministro( Memo: TStrings; const ANif: boolean );
var
  sPais, sCIF, sProvincia: string;
begin
  if qryCliente.FieldByName('pais_ds').AsString <> '' then
    sPais:= qryCliente.FieldByName('pais_ds').AsString
  else
    if qryCliente.FieldByName('pais_c').AsString <> '' then
      sPais:= qryCliente.FieldByName('pais_c').AsString
    else
      sPais:= 'ES';
  if sPais = 'ES' then
    sCIF:= ' (CIF: '
  else
    sCIF:= ' (VAT: ';

  if sPais = 'ES' then
    sProvincia:= DesProvincia( Copy( qryCliente.FieldByName('cod_postal_ds').AsString, 1, 2 ))
  else
    sProvincia:= qryCliente.FieldByName('provincia_ds').AsString;

  sPais:= DesPais( sPais, True );

  if Trim( qryCliente.FieldByName('nif_ds').AsString ) <> '' then
    sCIF:=  sCIF + qryCliente.FieldByName('nif_ds').AsString + ')'
  else
    sCIF := '';
//  else
//    sCIF:=  sCIF + qryCliente.FieldByName('nif_c').AsString + ')';


  if ANif then
    Memo.Add(qryCliente.FieldByName('nombre_ds').AsString + sCIF )
  else
    Memo.Add(qryCliente.FieldByName('nombre_ds').AsString );

  Memo.Add(Trim( qryCliente.FieldByName('tipo_via_ds').AsString + ' ' + qryCliente.FieldByName('domicilio_ds').AsString) );

  Memo.Add(Trim( qryCliente.FieldByName('cod_postal_ds').AsString + ' ' + qryCliente.FieldByName('poblacion_ds').AsString));
  if Trim( sProvincia ) <> '' then
    Memo.Add( sProvincia + ' - ' + sPais )
  else
    Memo.Add( sPais );
end;

end.
