unit CartaTransitoDL;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDLCartaTransito = class(TDataModule)
    QAlbaranCab: TQuery;
    QEmpresa: TQuery;
    QTransportista: TQuery;
    QAlbaranLin: TQuery;
    QCargador: TQuery;
    QOrigen: TQuery;
    QDestino: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }

    procedure AbrirQuerys( const AEmpresa, ACentro: string;
                      const AAlbaran: integer; const AFecha: TDateTime );
    procedure CerrarQuerys;
    //function  GetCentroVirtual( const AEmpresa, ACentro: string; const AFecha: TDateTime ): string;
  public
    { Public declarations }
  end;

  procedure Ejecutar( const AOwner: TComponent; const AEmpresa, ACentro: string;
                      const AAlbaran: integer; const AFecha: TDateTime;
                      const AFirma: string );

implementation

{$R *.dfm}

uses CartaTransitoQL;

var
  DLCartaTransito: TDLCartaTransito;

procedure Ejecutar( const AOwner: TComponent; const AEmpresa, ACentro: string;
                    const AAlbaran: integer; const AFecha: TDateTime;
                    const AFirma: string );
begin
  DLCartaTransito:= TDLCartaTransito.Create( AOwner );
  try
    DLCartaTransito.AbrirQuerys( AEmpresa, ACentro, AAlbaran, AFecha );
    CartaTransitoQL.Previsualizar( AOwner, DLCartaTransito , AFirma );
    DLCartaTransito.CerrarQuerys;
  finally
    FreeAndNil( DLCartaTransito );
  end;
end;

procedure TDLCartaTransito.DataModuleCreate(Sender: TObject);
begin
  with QAlbaranCab do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_transitos_c ');
    SQL.Add(' where empresa_tc = :empresa ');
    SQL.Add(' and centro_tc = :centro ');
    SQL.Add(' and referencia_tc = :albaran ');
    SQL.Add(' and fecha_tc = :fecha ');
    Prepare;
  end;

  with QAlbaranLin do
  begin
    SQL.Clear;
    SQL.Add(' select producto_tl producto, ');
    SQL.Add(' envase_tl envase, ');
    SQL.Add('         tipo_palet_tl, ');
    SQL.Add('         ( select peso_envase_e ');
    SQL.Add('            from frf_envases ');
    SQL.Add('             where envase_e = envase_tl ');
    SQL.Add('               and producto_E = producto_tl ) peso_envase, ');
    SQL.Add('         ( select kilos_tp ');
    SQL.Add('           from frf_tipo_palets ');
    SQL.Add('           where codigo_tp  = tipo_palet_tl ) peso_palet, ');
    SQL.Add('         sum(palets_tl) palets, ');
    SQL.Add('         sum(cajas_tl) bultos, ');
    SQL.Add('         sum(kilos_tl)  kilos ');

    SQL.Add('  from frf_transitos_l');
    SQL.Add(' where empresa_tl= :empresa ');
    SQL.Add(' and centro_tl= :centro ');
    SQL.Add(' and referencia_tl= :albaran ');
    SQL.Add(' and fecha_tl= :fecha ');
    SQL.Add('  group by 1, 2, 3, 4, 5');
    SQL.Add('  order by 1, 2 ');
    Prepare;
  end;

  with QEmpresa do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_empresas ');
    SQL.Add(' where empresa_e = :empresa ');
    Prepare;
  end;

  with QCargador do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_empresas ');
    SQL.Add(' where empresa_e = :empresa ');
    Prepare;
  end;
  with QDestino do
  begin
    SQL.Clear;
    SQL.Add(' select nombre_e, nif_e, descripcion_c, direccion_c, poblacion_c, cod_postal_c, pais_c ');
    SQL.Add(' from frf_empresas, frf_centros ');
    SQL.Add(' where empresa_e = :empresa ');
    SQL.Add(' and empresa_c = empresa_e ');
    SQL.Add(' and centro_c = :centro ');
    Prepare;
  end;
  with QOrigen do
  begin
    SQL.Clear;
    SQL.Add(' select nombre_e, nif_e, descripcion_c, direccion_c, poblacion_c, cod_postal_c, pais_c ');
    SQL.Add(' from frf_empresas, frf_centros ');
    SQL.Add(' where empresa_e = :empresa ');
    SQL.Add(' and empresa_c = empresa_e ');
    SQL.Add(' and centro_c = :centro ');
    Prepare;
  end;

  with QTransportista do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_transportistas ');
    SQL.Add(' where transporte_t = :transporte ');
    Prepare;
  end;
end;

procedure TDLCartaTransito.DataModuleDestroy(Sender: TObject);
begin
  QTransportista.Close;
  if QTransportista.Prepared then
    QTransportista.UnPrepare;

  QEmpresa.Close;
  if QEmpresa.Prepared then
    QEmpresa.UnPrepare;

  QDestino.Close;
  if QDestino.Prepared then
    QDestino.UnPrepare;

  QCargador.Close;
  if QCargador.Prepared then
    QCargador.UnPrepare;

  QOrigen.Close;
  if QOrigen.Prepared then
    QOrigen.UnPrepare;

  QAlbaranLin.Close;
  if QAlbaranLin.Prepared then
    QAlbaranLin.UnPrepare;

  QAlbaranCab.Close;
  if QAlbaranCab.Prepared then
    QAlbaranCab.UnPrepare;
end;

procedure TDLCartaTransito.AbrirQuerys( const AEmpresa, ACentro: string; const AAlbaran: integer;
                                     const AFecha: TDateTime );
begin
  with QAlbaranCab do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('albaran').AsInteger:= AAlbaran;
    ParamByName('fecha').AsDate:= AFecha;
    Open;
  end;
  with QAlbaranLin do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('albaran').AsInteger:= AAlbaran;
    ParamByName('fecha').AsDate:= AFecha;
    Open;
  end;
  with QEmpresa do
  begin
    if ( Copy(AEmpresa,1,1) = 'F' )then
       ParamByName('empresa').AsString:= 'BAG'
    else
      ParamByName('empresa').AsString:= AEmpresa;
    Open;
  end;
  with QOrigen do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    Open;
  end;
  with QDestino do
  begin
    ParamByName('empresa').AsString:= QAlbaranCab.FieldByName('planta_destino_tc').AsString;
    ParamByName('centro').AsString:= QAlbaranCab.FieldByName('centro_destino_tc').AsString;
    Open;
  end;
  with QCargador do
  begin
    if ( AEmpresa = '505' ) or ( AEmpresa = '510' ) or ( AEmpresa = '506' ) or ( Copy(AEmpresa,1,1) = 'F' )then
       ParamByName('empresa').AsString:= 'BAG'
    else
      ParamByName('empresa').AsString:= AEmpresa;
    Open;
  end;
  with QTransportista do
  begin
    ParamByName('transporte').AsString:= QAlbaranCab.FieldByName('transporte_tc').AsString;
    Open;
  end;
end;

procedure TDLCartaTransito.CerrarQuerys;
begin
  QTransportista.Close;
  QEmpresa.Close;
  QOrigen.Close;
  QCargador.Close;
  QAlbaranLin.Close;
  QAlbaranCab.Close;
end;

(*PARCHE*)
(*
function TDLCartaPorte.GetCentroVirtual( const AEmpresa, ACentro: string; const AFecha: TDateTime ): string;
begin
  result:= ACentro;
  if ( ( AEmpresa = '078' ) or ( AEmpresa = 'F21' ) ) and ( AFecha > StrTodate( '1/12/2009' ) ) then
  begin
    QAlbaranLin.First;
    while ( not QAlbaranLin.Eof ) and ( result = ACentro ) do
    begin
      if ( QAlbaranLin.FieldByName('envase').AsString = '171' ) or
         ( QAlbaranLin.FieldByName('envase').AsString = '172' ) or
         ( QAlbaranLin.FieldByName('envase').AsString = '173' ) or
         ( QAlbaranLin.FieldByName('envase').AsString = '344' ) or
         ( QAlbaranLin.FieldByName('envase').AsString = '359' ) or
         ( QAlbaranLin.FieldByName('envase').AsString = '133' ) then
      begin
        //GALICIA
        result:= '2';
        break;
      end;
      QAlbaranLin.Next;
    end;
    QAlbaranLin.First;
  end;
end;
*)

end.

