unit AlbaranesAsociadosFacDM;

interface

uses
  SysUtils, Classes, DB, DBTables, uSalidaUtils;

type
  TDMAlbaranesAsociadosFac = class(TDataModule)
    qryAlbaranes: TQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    function PrevisualizarAlbaran( GGN : TGGN; const APrevisualizar: boolean = True ): Boolean;
    function PrevisualizarAlbaranSAT( GGN : TGGN; const APrevisualizar: boolean = True ): Boolean;
    function PrevisualizarAlbaranBAG( GGN : TGGN; const APrevisualizar: boolean = True ): Boolean;
    function ImprimirAlbaranesAsociadosEx( const APrevisualizar: boolean = True ): boolean;
  public
    { Public declarations }
    //function ImprimirAlbaranesAsociados( const AEmpresa: string; const AFecha: TDateTime; const AFactura: integer ): boolean;
    function ImprimirAlbaranesAsociados( const AFactura: string; const APrevisualizar: boolean = True ): boolean;
  end;

  //function ImprimirAlbaranesAsociados( const AEmpresa: string; const AFecha: TDateTime; const AFactura: integer ): boolean;
  function ImprimirAlbaranesAsociados( const AFactura: string; const APrevisualizar: boolean = True ): boolean;


implementation

{$R *.dfm}

uses
  Forms, Dialogs, UQRAlbaranAlemaniaNoVar, UDQAlbaranSalida, UDMAuxDB, CGlobal,
  UDQAlbaranSalidaWEB, AlbaranEntreCentrosMercadonaDM, UCAlbaran;

var
  DMAlbaranesAsociadosFac: TDMAlbaranesAsociadosFac;

//function ImprimirAlbaranesAsociados( const AEmpresa: string; const AFecha: TDateTime; const AFactura: integer ): boolean;
function ImprimirAlbaranesAsociados( const AFactura: string; const APrevisualizar: boolean = True ): boolean;
begin
  Application.CreateForm(TDMAlbaranesAsociadosFac, DMAlbaranesAsociadosFac );
  try
    UCAlbaran.giCopias:= 1;
    //result:= DMAlbaranesAsociadosFac.ImprimirAlbaranesAsociados( AEmpresa, AFecha, AFactura );
    result:= DMAlbaranesAsociadosFac.ImprimirAlbaranesAsociados( AFactura, APrevisualizar );
  finally
    FreeAndNil( DMAlbaranesAsociadosFac );
    UCAlbaran.giCopias:= 0;
  end;
end;

//function TDMAlbaranesAsociadosFac.ImprimirAlbaranesAsociados( const AEmpresa: string; const AFecha: TDateTime; const AFactura: integer ): boolean;
function TDMAlbaranesAsociadosFac.ImprimirAlbaranesAsociados( const AFactura: string; const APrevisualizar: boolean = True ): boolean;
begin
  (*
  qryAlbaranes.ParamByName('empresa').AsString:= AEmpresa;
  qryAlbaranes.ParamByName('fecha').AsDateTime:= AFecha;
  qryAlbaranes.ParamByName('factura').AsInteger:= AFactura;
  *)
  qryAlbaranes.ParamByName('factura').AsString:= AFactura;
  qryAlbaranes.Open;



  if CGlobal.gProgramVersion = CGlobal.pvBAG then
  begin
    if ( qryAlbaranes.FieldByname('empresa').AsString = '050' ) or ( qryAlbaranes.FieldByname('empresa').AsString = '080' ) then
    begin
      Result:= False;
      ShowMessage('Los albaranes de SAT se deben de sacar desde Gestión Comercial SAT');
    end
    else
    begin
      Result:= ImprimirAlbaranesAsociadosEx( APrevisualizar );
    end;
  end
  else
  begin
    if ( qryAlbaranes.FieldByname('empresa').AsString = '050' ) or ( qryAlbaranes.FieldByname('empresa').AsString = '080' ) then
    begin
      Result:= ImprimirAlbaranesAsociadosEx( APrevisualizar );
    end
    else
    begin
      Result:= False;
      ShowMessage('Los albaranes de SAT se deben de sacar desde Gestión Comercial SAT');
    end;
  end;
end;

function TDMAlbaranesAsociadosFac.ImprimirAlbaranesAsociadosEx( const APrevisualizar: boolean = True ): boolean;
var
  miGGN : TGGN;
begin
  result:= True;
  try
    while ( not qryAlbaranes.Eof ) do //and result do
    begin
      miGGN := ConfigurarGGN(qryAlbaranes.Databasename, qryAlbaranes.FieldByName('empresa').asstring,
        qryAlbaranes.FieldByName('centro').asstring,
        qryAlbaranes.FieldByName('albaran').asinteger,
        qryAlbaranes.FieldByName('fecha_albaran').asdatetime);

      result:= PrevisualizarAlbaran( miGGN, APrevisualizar );
      qryAlbaranes.Next;
    end;
  finally
     qryAlbaranes.Close;
  end;
end;


function TDMAlbaranesAsociadosFac.PrevisualizarAlbaran( GGN: TGGN; const APrevisualizar: boolean = True ): boolean;
begin
  if CGlobal.gProgramVersion = CGlobal.pvBAG then
  begin
    Result:= PrevisualizarAlbaranBAG( GGN, APrevisualizar );
  end
  else
  begin
      Result:= PrevisualizarAlbaranSAT( GGN, APrevisualizar );
  end;
end;

function TDMAlbaranesAsociadosFac.PrevisualizarAlbaranSAT( GGN : TGGN; const APrevisualizar: boolean = True ): boolean;
var
  sEmpresa, sCentro, sCliente: string;
  iAlbaran, iTipoAlbaran: Integer;
  dFecha: TDateTime;
  bPedirFirma, bOriginal: Boolean;
begin
  sEmpresa:= qryAlbaranes.FieldByname('empresa').AsString;
  sCentro:= qryAlbaranes.FieldByname('centro').AsString;
  sCliente:= qryAlbaranes.FieldByname('cliente').AsString;
  iAlbaran:= qryAlbaranes.FieldByname('albaran').AsInteger;
  dFecha:= qryAlbaranes.FieldByname('fecha').AsDateTime;


  bPedirFirma:= False;
  bOriginal:= True;
  iTipoAlbaran:= TipoAlbaran( sEmpresa, sCliente );
  if iTipoAlbaran = 2 then
    iTipoAlbaran:= 1
  else
    iTipoAlbaran:= 0;
  Result:= False;
  if iTipoAlbaran = 0 then
  begin
    if ( sCliente = 'GOM' ) or ( sCliente = 'ERO' ) or ( sCliente = 'THA' ) or ( sCliente = 'M&W' ) or ( sCliente = 'APS' ) then
    begin
      result:= UDQAlbaranSalida.PreAlbaran( Self, sEmpresa, sCentro, iAlbaran, dFecha, bPedirFirma, bOriginal, GGN, APrevisualizar );
    end
    else
    begin
       result:= UDQAlbaranSalida.PreAlbaranSAT( Self, sEmpresa, sCentro, iAlbaran, dFecha, bPedirFirma, bOriginal, GGN, APrevisualizar );
    end;
  end
  else
  if iTipoAlbaran = 1 then
  begin
    result:= UQRAlbaranAlemaniaNoVar.PreAlbaranAleman( sEmpresa, sCentro, sCliente, iAlbaran, dFecha, bPedirFirma, bOriginal, GGN, APrevisualizar );
  end;
end;

function TDMAlbaranesAsociadosFac.PrevisualizarAlbaranBAG( GGN : TGGN; const APrevisualizar: boolean = True ): boolean;
var
  sEmpresa, sCentro, sCliente: string;
  iAlbaran, iTipoAlbaran: Integer;
  dFecha: TDateTime;
  bPedirFirma, bOriginal: Boolean;
begin
  sEmpresa:= qryAlbaranes.FieldByname('empresa').AsString;
  sCentro:= qryAlbaranes.FieldByname('centro').AsString;
  sCliente:= qryAlbaranes.FieldByname('cliente').AsString;
  iAlbaran:= qryAlbaranes.FieldByname('albaran').AsInteger;
  dFecha:= qryAlbaranes.FieldByname('fecha').AsDateTime;

  bPedirFirma:= False;
  bOriginal:= True;
  iTipoAlbaran:= TipoAlbaran( sEmpresa, sCliente );
  if iTipoAlbaran = 2 then
    iTipoAlbaran:= 1
  else
    iTipoAlbaran:= 0;
  if iTipoAlbaran = 0 then
  begin
    if sCliente = 'WEB' then
    begin
       result:= UDQAlbaranSalidaWEB.PreAlbaran( Self, sEmpresa, sCentro,
                   iAlbaran, dFecha, bPedirFirma, bOriginal,  GGN, APrevisualizar );
    end
    else
    if sEmpresa = '506'  then
    begin
       result:= AlbaranEntreCentrosMercadonaDM.PreAlbaran( Self, sEmpresa, sCentro,
                   iAlbaran, dFecha, bPedirFirma, bOriginal, GGN, APrevisualizar );
    end
    else
    begin
       result:= UDQAlbaranSalida.PreAlbaran( Self, sEmpresa, sCentro,
                 iAlbaran, dFecha, bPedirFirma, bOriginal,  GGN, APrevisualizar );
    end
  end
  else
  if iTipoAlbaran = 1 then
  begin
    result:= UQRAlbaranAlemaniaNoVar.PreAlbaranAleman( sEmpresa, sCentro, sCliente, iAlbaran,
                               dFecha, bPedirFirma, bOriginal,  GGN, APrevisualizar );
  end
  else
  begin
    Result:= False;
  end;
end;

procedure TDMAlbaranesAsociadosFac.DataModuleCreate(Sender: TObject);
begin
  (*
  qryAlbaranes.SQL.Clear;
  qryAlbaranes.SQL.Add('select * ');
  qryAlbaranes.SQL.Add('from frf_salidas_c ');
  qryAlbaranes.SQL.Add('where empresa_fac_sc = :empresa ');
  qryAlbaranes.SQL.Add('and n_factura_sc = :factura ');
  qryAlbaranes.SQL.Add('and fecha_factura_sc = :fecha ');
  *)

  qryAlbaranes.SQL.Clear;
  qryAlbaranes.SQL.Add(' select distinct cod_empresa_albaran_fd empresa, cod_centro_albaran_fd centro, ');
  qryAlbaranes.SQL.Add('        cod_cliente_albaran_fd cliente, n_albaran_fd albaran, fecha_albaran_fd fecha ');
  qryAlbaranes.SQL.Add(' from tfacturas_det ');
  qryAlbaranes.SQL.Add(' where cod_factura_fd = :factura ');

end;

end.
