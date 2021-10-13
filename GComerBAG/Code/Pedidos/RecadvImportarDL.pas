unit RecadvImportarDL;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable;

const
   kCabecera = 1;
   kEmbalajes = 2;
   kDetalles = 3;
   kCantidades = 4;
   kObservaciones = 5;
   kMarcas = 6;

type
  TDLRecadvImportar = class(TDataModule)
    QInsert: TQuery;
    QAux: TQuery;
    mtCab: TkbmMemTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    sDir, sCodeList: string;
    sFileNameAux: string;
    slError: tstringlist;

    function GetDirectorio: String;
    function NombreFichero( const AFichero: Integer ) : string;
    function ImportarCabecera: Integer;
    function ImportarFichero( const AFichero: Integer ) : Integer;
    function ImportarLinea( const AFichero: Integer; const ALinea: string ) : boolean;
    function PasarCabecera( const ALinea: string ): boolean;
    function PasarEmbalaje( const ALinea: string ): boolean;
    function PasarDetalle( const ALinea: string ): boolean;
    function PasarCantidad( const ALinea: string ): boolean;
    function PasarObservacion( const ALinea: string ): boolean;
    function PasarMarca( const ALinea: string ): boolean;

    function ActualizarEmpresaCentroSalida( const AProveedor: string; const AALbaran: Integer; const AFecha: TDateTime;
                                            var AEmpresa, ACentroSalida: string ): boolean;

  public
    { Public declarations }
    function ImportarRecadv( var AMensaje: string ): Integer;
    function GetCodeList: string;
  end;

function ImportarRecadv( const AOwner: TComponent; var ACodeList, AMsg: string ): Integer;

implementation

{$R *.dfm}

uses CVariables, Math;

function ImportarRecadv( const AOwner: TComponent; var ACodeList, AMsg: string ): Integer;
var
  DLRecadvImportar: TDLRecadvImportar;
begin
  DLRecadvImportar:= TDLRecadvImportar.Create( AOwner);
  try
    result:= DLRecadvImportar.ImportarRecadv( AMsg );
    ACodeList:= DLRecadvImportar.GetCodeList;
  finally
    FreeAndNil( DLRecadvImportar );
  end;
end;

function PutCodeList( const ACodeList, ACode: string ): string;
begin
  if Trim(ACodeList) <> '' then
  begin
    result:= ACodeList + ',' + QuotedStr( ACode );
  end
  else
  begin
    result:= QuotedStr( ACode );
  end;
end;

function LimpiarLinea( const ALinea: string ): string;
var
  iIni, iFin: Integer;
  sAux, sIni, sFin: string;
begin
  sAux:= Trim( ALinea );
  iIni:= pos( '<', sAux );
  if iIni <> 0 then
  begin
    iFin:= pos( '>', sAux );
    if iIni > 1 then
    begin
      sIni:= Copy( sAux, 1, iIni -1 );
    end
    else
    begin
      sIni:='';
    end;
    if iFin < Length( sAux ) then
    begin
      sFin:= Copy( sAux, iFin+1, Length( sAux ) - iFin );
    end
    else
    begin
      sFin:='';
    end;
    sAux:= sIni + sFin;
    if sAux <> '' then
      sAux:= LimpiarLinea( sAux );
  end;
  result:= sAux;
end;

function PutString(var VValor: string; const ALinea: string; const AIni, AFin: integer ): boolean;
begin
  VValor:= Trim( Copy( ALinea, AIni, (AFin + 1) - AIni ) );
  result:= VValor <> '';
end;

function PutInteger(var VValor: Integer; const ALinea: string; const AIni, AFin: integer ): boolean;
var
  sAux: string;
begin
  sAux:= Trim( Copy( ALinea, AIni + 1, (AFin + 1) - AIni ) );
  result:= TryStrToInt( sAux, VValor );
  if result then
  begin
    if Copy( ALinea, AIni, 1 ) = '-' then
      VValor:= (-1) * VValor;
  end;
end;

function PutDecimal(var VValor: Real; const ALinea: string; const ALon, ADecimales, AIni, AFin: integer ): boolean;
var
  iEntera, iDecimal: Integer;
  sAux: string;
begin
  result:= False;
  sAux:= Copy( ALinea, AIni, (AFin + 1) - AIni );
  sAux:= Copy( ALinea, AIni + 1, AFin  - ( AIni + ADecimales )  );
  if TryStrToInt( sAux, iEntera ) then
  begin
    sAux:= Copy( ALinea, (AFin + 1) - ADecimales, ADecimales );
    if TryStrToInt(  sAux, iDecimal ) then
    begin
      VValor:=  iEntera + ( iDecimal / Power( 10, ADecimales ) );
      if Copy( ALinea, AIni, 1 ) = '-' then
        VValor:= (-1) * VValor;
      result:= True;
    end;
  end;
end;

function PutDate(var VValor: TDateTime; const ALinea: string; const AIni, AFin: integer ): boolean;
var
  iAnyo, iMes, iDia: Integer;
begin
  result:= False;
  if TryStrToInt( Copy( ALinea, AIni, 4 ), iAnyo ) then
  begin
    if TryStrToInt( Copy( ALinea, AIni + 4, 2 ), iMes ) then
    begin
      if TryStrToInt( Copy( ALinea, AIni + 6, 2 ), iDia ) then
      begin
        VValor:= EncodeDate( iAnyo, iMes, iDia );
        result:= True;
      end;
    end;
  end;
end;

function TDLRecadvImportar.GetCodeList: string;
begin
  result:= sCodeList;
end;

function TDLRecadvImportar.GetDirectorio: String;
begin
  with QAux do
  begin
    Sql.Clear;
    Sql.Add(' select directorio_cd ');
    Sql.Add(' from cnf_directorios ');
    Sql.Add(' where usuario_cd = :usuario ');
    Sql.Add(' and codigo_cd = :codigo ');
    ParamByName('usuario').AsString:= gsCodigo;
    ParamByName('codigo').AsString:= 'RECADV';
    Open;
    result:= FieldByname('directorio_cd').AsString;
    Close;
  end;
end;

function TDLRecadvImportar.NombreFichero( const AFichero: Integer ) : string;
begin
  case AFichero of
    kCabecera: result:= sFileNameAux;
    kEmbalajes: result:= StringReplace( sFileNameAux, 'CABCRE', 'EMBCRE', [] );
    kDetalles: result:= StringReplace( sFileNameAux, 'CABCRE', 'LINCRE', [] );
    kCantidades: result:= StringReplace( sFileNameAux, 'CABCRE', 'CANTCRE', [] );
    kObservaciones: result:= StringReplace( sFileNameAux, 'CABCRE', 'OBSCABRE', [] );
    kMarcas: result:= StringReplace( sFileNameAux, 'CABCRE', 'MARCRE', [] );
  end;
end;

function TDLRecadvImportar.ImportarLinea( const AFichero: Integer; const ALinea: string ) : boolean;
var
  sAux: string;
begin
  Result:= False;
  if PutString(sAux, Alinea, 1, 10) then
  begin
    if mtCab.Locate('codigo',sAux,[]) then
    begin
      case AFichero of
        //kCabecera: result:= PasarCabecera( ALinea );
        kEmbalajes: result:= PasarEmbalaje( ALinea );
        kDetalles: result:= PasarDetalle( ALinea );
        kCantidades: result:= PasarCantidad( ALinea );
        kObservaciones: result:= PasarObservacion( ALinea );
        kMarcas: result:= PasarMarca( ALinea );
        else result:= false;
      end;
    end;
  end;
end;

function TDLRecadvImportar.PasarCabecera( const ALinea: string ): boolean;
var
  sAux: string;
  dAux: TDateTime;
  iAux: Integer;
  AEmpresa, ACentroSalida: string;
begin
  Result:= False;
  if PutString(sAux, Alinea, 111, 145) then
  begin
    //*if TrySTrToInt( sAux, iAux ) then
    iAux:= STrToIntDef( sAux, 0 );
    if PutString(sAux, Alinea, 249, 265) then
    if PutDate(dAux, Alinea, 508, 519) then
    begin
      TryStrToInt( AEmpresa, iAux );
      //if ActualizarEmpresaCentroSalida( sAux, iAux, dAux, AEmpresa, ACentroSalida ) then
      ActualizarEmpresaCentroSalida( sAux, iAux, dAux, AEmpresa, ACentroSalida );
      begin
        with QInsert do
        begin
          Close;
          RequestLive:= True;
          SQL.Clear;
          SQL.Add('select * from edi_cabcre where idcab_ecr = ''-1'' ');
          Open;
          Insert;

          if PutString(sAux, Alinea, 1, 10) then
            FieldByName('IDCAB_ECR').AsString:= sAux;
          if PutString(sAux, Alinea, 11, 45) then
            FieldByName('NUMCON_ECR').AsString:= sAux;
          if PutString(sAux, Alinea, 46, 48) then
            FieldByName('TIPO_ECR').AsString:= sAux;
          if PutString(sAux, Alinea, 49, 51) then
            FieldByName('FUNCION_ECR').AsString:= sAux;
          if PutDate(dAux, Alinea,  52, 63) then
            FieldByName('FECDOC_ECR').AsDateTime:= dAux;
          if PutDate(dAux, Alinea, 64, 75) then
            FieldByName('FECREC_ECR').AsDateTime:= dAux;
          if PutString(sAux, Alinea, 76, 110) then
            FieldByName('NUMAVI_ECR').AsString:= sAux;
          if PutString(sAux, Alinea, 111, 145) then
            FieldByName('NUMALB_ECR').AsString:= sAux;
          if PutString(sAux, Alinea, 146, 180) then
            FieldByName('NUMPED_ECR').AsString:= sAux;
          if PutString(sAux, Alinea, 181, 197) then
            FieldByName('ORIGEN_ECR').AsString:= sAux;
          if PutString(sAux, Alinea, 198, 214) then
            FieldByName('DESTINO_ECR').AsString:= sAux;
          if PutString(sAux, Alinea, 215, 231) then
            FieldByName('CLIENTE_ECR').AsString:= sAux;
          if PutString(sAux, Alinea, 232, 248) then
            FieldByName('DPTO_ECR').AsString:= sAux;
          if PutString(sAux, Alinea, 249, 265) then
            FieldByName('PROVEEDOR_ECR').AsString:= sAux;
          if PutString(sAux, Alinea, 266, 282) then
            FieldByName('RECEPTOR_ECR').AsString:= sAux;
          if PutString(sAux, Alinea, 283, 299) then
            FieldByName('MUELLE_ECR').AsString:= sAux;
          if PutString(sAux, Alinea, 300, 316) then
            FieldByName('ENTREGA_ECR').AsString:= sAux;
          if PutString(sAux, Alinea, 317, 333) then
            FieldByName('EXPEDIDOR_ECR').AsString:= sAux;
          if PutString(sAux, Alinea, 334, 368) then
            FieldByName('CONTACTO_ECR').AsString:= sAux;
          if PutString(sAux, Alinea, 369, 385) then
            FieldByName('TELEF_ECR').AsString:= sAux;
          if PutString(sAux, Alinea, 386, 40) then
            FieldByName('FAX_ECR').AsString:= sAux;
          if PutString(sAux, Alinea, 403, 437) then
            FieldByName('EMAIL_ECR').AsString:= sAux;
          if PutString(sAux, Alinea, 438, 440) then
            FieldByName('TIPTRANS_ECR').AsString:= sAux;
          if PutString(sAux, Alinea, 441, 443) then
            FieldByName('MEDTRANS_ECR').AsString:= sAux;
          if PutString(sAux, Alinea, 444, 460) then
            FieldByName('IDTRANS_ECR').AsString:= sAux;
          if PutString(sAux, Alinea, 461, 495) then
            FieldByName('MATRIC_ECR').AsString:= sAux;
          if PutDate(dAux, Alinea, 496, 50) then
            FieldByName('FECVAL_ECR').AsDateTime:= dAux;
          if PutDate(dAux, Alinea, 508, 519) then
            FieldByName('FCARGA_ECR').AsDateTime:= dAux;
          if PutString(sAux, Alinea, 520, 536) then
            FieldByName('AQSFAC_ECR').AsString:= sAux;
          if PutDate(dAux, Alinea, 537, 548) then
            FieldByName('FPEDIDO_ECR').AsDateTime:= dAux;
          if PutDate(dAux, Alinea, 549, 560) then
            FieldByName('FALBARAN_ECR').AsDateTime:= dAux;

          FieldByName('empresa_ecr').AsString:= AEmpresa;
          FieldByName('centro_salida_ecr').AsString:= ACentroSalida;

          try
            Post;
            mtCab.Insert;
            mtCab.FieldByName('codigo').AsString:= FieldByName('IDCAB_ECR').AsString;
            mtCab.Post;
            sCodeList:= PutCodeList( sCodeList, FieldByName('IDCAB_ECR').AsString );
            result:= True;
          except
            on e:Exception do
            begin
              slError.Add( 'CABECERA:' + ALinea + #13 + #10 + e.Message + #13 + #10 );
              Cancel;
              result:= false;
            end;
          end;
        end;
      end;
    end;
  end;
end;

function TDLRecadvImportar.PasarEmbalaje( const ALinea: string ): boolean;
var
  sAux: string;
  iAux: Integer;
begin
  with QInsert do
  begin
    Close;
    RequestLive:= True;
    SQL.Clear;
    SQL.Add('select * from edi_embcre where idcab_eer = ''-1'' ');
    Open;
    Insert;

    if PutString(sAux, Alinea, 1, 10) then
      FieldByName('IDCAB_EER').AsString:= sAux;
    if PutString(sAux, Alinea, 11, 20) then
      FieldByName('IDEMB_EER').AsString:= sAux;
    if PutString(sAux, Alinea, 21, 32) then
      FieldByName('CPS_EER').AsString:= sAux;
    if PutString(sAux, Alinea, 33, 44) then
      FieldByName('CPSPADRE_EER').AsString:= sAux;
    if PutInteger(iAux, Alinea, 45, 59) then
      FieldByName('CANTEMB_EER').AsInteger:= iAux;
    if PutInteger(iAux, Alinea, 60, 74) then
      FieldByName('VARCANT_EER').AsInteger:= iAux;
    if PutString(sAux, Alinea, 75, 77) then
      FieldByName('DISCREP_EER').AsString:= sAux;
    if PutString(sAux, Alinea, 78, 80) then
      FieldByName('TIPCOD_EER').AsString:= sAux;
    if PutString(sAux, Alinea, 81, 83) then
      FieldByName('TIPEMB_EER').AsString:= sAux;
    if PutString(sAux, Alinea, 84, 86) then
      FieldByName('CONDEMB_EER').AsString:= sAux;
    if PutString(sAux, Alinea, 87, 89) then
      FieldByName('PAGTRANS_EER').AsString:= sAux;
    if PutInteger(iAux, Alinea, 90, 104) then
      FieldByName('PESO_EER').AsInteger:= iAux;
    if PutInteger(iAux, Alinea, 105, 119) then
      FieldByName('PESOB_EER').AsInteger:= iAux;
    if PutInteger(iAux, Alinea, 120, 134) then
      FieldByName('ALTURA_EER').AsInteger:= iAux;
    if PutInteger(iAux, Alinea, 135, 149) then
      FieldByName('LONGITUD_EER').AsInteger:= iAux;
    if PutInteger(iAux, Alinea, 150, 164) then
      FieldByName('ANCHURA_EER').AsInteger:= iAux;
    if PutString(sAux, Alinea, 165, 199) then
      FieldByName('MARCAS1_EER').AsString:= sAux;
    if PutString(sAux, Alinea, 200, 234) then
      FieldByName('MARCAS2_EER').AsString:= sAux;
    if PutString(sAux, Alinea, 235, 269) then
      FieldByName('MARCAS3_EER').AsString:= sAux;
    if PutString(sAux, Alinea, 270, 304) then
      FieldByName('MARCAS4_EER').AsString:= sAux;
    if PutString(sAux, Alinea, 305, 339) then
      FieldByName('MARCAS5_EER').AsString:= sAux;
    if PutString(sAux, Alinea, 340, 409) then
      FieldByName('SSCC1_EER').AsString:= sAux;
    if PutString(sAux, Alinea, 410, 479) then
      FieldByName('SSCC2_EER').AsString:= sAux;
    if PutString(sAux, Alinea, 480, 549) then
      FieldByName('SSCC3_EER').AsString:= sAux;
    if PutString(sAux, Alinea, 550, 619) then
      FieldByName('SSCC4_EER').AsString:= sAux;
    if PutString(sAux, Alinea, 620, 689) then
      FieldByName('SSCC5_EER').AsString:= sAux;

    try
      Post;
      result:= True;
    except
                on e:Exception do
            begin
              slError.Add( 'EMBALAJES:' + ALinea + #13 + #10 + e.Message + #13 + #10 );
              Cancel;
              result:= false;
            end;
      //Cancel;
      //result:= false;
    end;
  end;
end;

function TDLRecadvImportar.PasarDetalle( const ALinea: string ): boolean;
var
  sAux: string;
  rAux: Real;
  dAux: TDateTime;
begin
  with QInsert do
  begin
    Close;
    RequestLive:= True;
    SQL.Clear;
    SQL.Add('select * from edi_lincre where idcab_elr = ''-1'' ');
    Open;
    Insert;

    if PutString(sAux, Alinea, 1, 10) then
      FieldByName('IDCAB_ELR').AsString:= sAux;
    if PutString(sAux, Alinea, 11, 20) then
      FieldByName('IDEMB_ELR').AsString:= sAux;
    if PutString(sAux, Alinea, 21, 30) then
      FieldByName('IDLIN_ELR').AsString:= sAux;
    if PutString(sAux, Alinea, 31, 65) then
      FieldByName('EAN_ELR').AsString:= sAux;
    if PutString(sAux, Alinea, 66, 67) then
      FieldByName('VP_ELR').AsString:= sAux;
    if PutString(sAux, Alinea, 68, 102) then
      FieldByName('REFPROV_ELR').AsString:= sAux;
    if PutString(sAux, Alinea, 103, 137) then
      FieldByName('REFCLI_ELR').AsString:= sAux;
    if PutString(sAux, Alinea, 138, 140) then
      FieldByName('FAMILIA_ELR').AsString:= sAux;
    if PutString(sAux, Alinea, 141, 145) then
      FieldByName('BARRA_ELR').AsString:= sAux;
    if PutString(sAux, Alinea, 146, 148) then
      FieldByName('TALLA_ELR').AsString:= sAux;
    if PutString(sAux, Alinea, 149, 183) then
      FieldByName('LOTE_ELR').AsString:= sAux;
    if PutString(sAux, Alinea, 184, 218) then
      FieldByName('SERIE_ELR').AsString:= sAux;
    if PutString(sAux, Alinea, 219, 253) then
      FieldByName('NUMEXP_ELR').AsString:= sAux;
    if PutString(sAux, Alinea, 254, 323) then
      FieldByName('DESCRIP_ELR').AsString:= sAux;
    if PutString(sAux, Alinea, 324, 326) then
      FieldByName('TIPART_ELR').AsString:= sAux;
    if PutDate(dAux, Alinea, 327, 338) then
      FieldByName('FECREC_ELR').AsDateTime:= dAux;
    if PutString(sAux, Alinea, 339, 373) then
      FieldByName('NUMPED_ELR').AsString:= sAux;
    if PutString(sAux, Alinea, 374, 408) then
      FieldByName('NUMALB_ELR').AsString:= sAux;
    if PutString(sAux, Alinea, 409, 443) then
      FieldByName('NUMAVI_ELR').AsString:= sAux;
    if PutString(sAux, Alinea, 444, 478) then
      FieldByName('MARCAS1_ELR').AsString:= sAux;
    if PutString(sAux, Alinea, 479, 513) then
      FieldByName('MARCAS2_ELR').AsString:= sAux;
    if PutString(sAux, Alinea, 514, 548) then
      FieldByName('MARCAS3_ELR').AsString:= sAux;
    if PutString(sAux, Alinea, 549, 583) then
      FieldByName('MARCAS4_ELR').AsString:= sAux;
    if PutString(sAux, Alinea, 584, 618) then
      FieldByName('MARCAS5_ELR').AsString:= sAux;
    if PutString(sAux, Alinea, 619, 688) then
      FieldByName('SSCC1_ELR').AsString:= sAux;
    if PutString(sAux, Alinea, 689, 758) then
      FieldByName('SSCC2_ELR').AsString:= sAux;
    if PutString(sAux, Alinea, 759, 828) then
      FieldByName('SSCC3_ELR').AsString:= sAux;
    if PutString(sAux, Alinea, 829, 898) then
      FieldByName('SSCC4_ELR').AsString:= sAux;
    if PutString(sAux, Alinea, 899, 968) then
      FieldByName('SSCC5_ELR').AsString:= sAux;
    if PutString(sAux, Alinea, 969, 1003) then
      FieldByName('LOTE1_ELR').AsString:= sAux;
    if PutString(sAux, Alinea, 1004, 1038) then
      FieldByName('LOTE2_ELR').AsString:= sAux;
    if PutString(sAux, Alinea, 1039, 1073) then
      FieldByName('LOTE3_ELR').AsString:= sAux;
    if PutString(sAux, Alinea, 1074, 1108) then
      FieldByName('LOTE4_ELR').AsString:= sAux;
    if PutString(sAux, Alinea, 1109, 1143) then
      FieldByName('LOTE5_ELR').AsString:= sAux;
    if PutDecimal(rAux, Alinea, 15, 3, 1144, 1158) then
      FieldByName('CANTPED_ELR').AsFloat:= rAux;
    if PutDecimal(rAux, Alinea, 15, 3, 1159, 1173) then
      FieldByName('CANTENV_ELR').AsFloat:= rAux;
    if PutDecimal(rAux, Alinea, 15, 3, 1174, 1188) then
      FieldByName('CANTENT_ELR').AsFloat:= rAux;
    if PutDecimal(rAux, Alinea, 15, 3, 1189, 1203) then
      FieldByName('CANTACE_ELR').AsFloat:= rAux;
    if PutDecimal(rAux, Alinea, 15, 3, 1204, 1218) then
      FieldByName('CANTDEV_ELR').AsFloat:= rAux;
    if PutString(sAux, Alinea, 1219, 1221) then
      FieldByName('MOTDEV_ELR').AsString:= sAux;
    if PutDecimal(rAux, Alinea, 15, 3, 1222, 1236) then
      FieldByName('CANTDES_ELR').AsFloat:= rAux;
    if PutString(sAux, Alinea, 1237, 1239) then
      FieldByName('MOTDES_ELR').AsString:= sAux;
    if PutDecimal(rAux, Alinea, 15, 3, 1240, 1254) then
      FieldByName('CANTDIF_ELR').AsFloat:= rAux;
    if PutString(sAux, Alinea, 1255, 1257) then
      FieldByName('MOTDIF_ELR').AsString:= sAux;
    if PutDecimal(rAux, Alinea, 15, 3, 1258, 1272) then
      FieldByName('CANTREC_ELR').AsFloat:= rAux;
    if PutDecimal(rAux, Alinea, 15, 3, 1273, 1287) then
      FieldByName('CANTUE_ELR').AsFloat:= rAux;

    try

      Post;
      result:= True;
    except
            on e:Exception do
            begin
              slError.Add( 'DETALLE:' + ALinea + #13 + #10 + e.Message + #13 + #10 );
              Cancel;
              result:= false;
            end;    
      //Cancel;
      //result:= false;
    end;
  end;
end;

function TDLRecadvImportar.PasarCantidad( const ALinea: string ): boolean;
var
  sAux: string;
  rAux: Real;
begin
  with QInsert do
  begin
    Close;
    RequestLive:= True;
    SQL.Clear;
    SQL.Add('select * from edi_cantcre where idcab_enr = ''-1'' ');
    Open;
    Insert;

    if PutString(sAux, Alinea, 1, 10) then
      FieldByName('IDCAB_ENR').AsString:= sAux;
    if PutString(sAux, Alinea, 11, 20) then
      FieldByName('IDEMB_ENR').AsString:= sAux;
    if PutString(sAux, Alinea, 21, 30) then
      FieldByName('IDLIN_ENR').AsString:= sAux;
    if PutString(sAux, Alinea, 31, 33) then
      FieldByName('CALIF_ENR').AsString:= sAux;
    if PutDecimal(rAux, Alinea, 15, 3, 34, 48) then
      FieldByName('CANTIDAD_ENR').AsFloat:= rAux;
    if PutString(sAux, Alinea, 49, 51) then
      FieldByName('DISCREP_ENR').AsString:= sAux;
    if PutString(sAux, Alinea, 52, 54) then
      FieldByName('RAZON_ENR').AsString:= sAux;

    try
      Post;
      result:= True;
    except
            on e:Exception do
            begin
              slError.Add( 'CANTIDAD:' + ALinea + #13 + #10 + e.Message + #13 + #10 );
              Cancel;
              result:= false;
            end;    
      //Cancel;
      //result:= false;
    end;
  end;
end;

function TDLRecadvImportar.PasarObservacion( const ALinea: string ): boolean;
var
  sAux: string;
begin
  with QInsert do
  begin
    Close;
    RequestLive:= True;
    SQL.Clear;
    SQL.Add('select * from edi_obscabre where idcab_eor = ''-1'' ');
    Open;
    Insert;

    if PutString(sAux, Alinea, 1, 10) then
      FieldByName('IDCAB_EOR').AsString:= sAux;
    if PutString(sAux, Alinea, 11, 20) then
      FieldByName('IDOBS_EOR').AsString:= sAux;
    if PutString(sAux, Alinea, 21, 90) then
      FieldByName('TEXTO1_EOR').AsString:= sAux;
    if PutString(sAux, Alinea, 91, 160) then
      FieldByName('TEXTO2_EOR').AsString:= sAux;
    if PutString(sAux, Alinea, 161, 230) then
      FieldByName('TEXTO3_EOR').AsString:= sAux;
    if PutString(sAux, Alinea, 231, 300) then
      FieldByName('TEXTO4_EOR').AsString:= sAux;
    if PutString(sAux, Alinea, 301, 370) then
      FieldByName('TEXTO5_EOR').AsString:= sAux;

    try
      Post;
      result:= True;
    except
            on e:Exception do
            begin
              slError.Add( 'NOTAS:' + ALinea + #13 + #10 + e.Message + #13 + #10 );
              Cancel;
              result:= false;
            end;    
      //Cancel;
      //result:= false;
    end;
  end;
end;

function TDLRecadvImportar.PasarMarca( const ALinea: string ): boolean;
var
  sAux: string;
begin
  with QInsert do
  begin
    Close;
    RequestLive:= True;
    SQL.Clear;
    SQL.Add('select * from edi_marcre where idcab_emr = ''-1'' ');
    Open;
    Insert;

    if PutString(sAux, Alinea, 1, 10) then
      FieldByName('IDCAB_EMR').AsString:= sAux;
    if PutString(sAux, Alinea, 11, 20) then
      FieldByName('IDEMB_EMR').AsString:= sAux;
    if PutString(sAux, Alinea, 21, 30) then
      FieldByName('IDLIN_EMR').AsString:= sAux;
    if PutString(sAux, Alinea, 31, 40) then
      FieldByName('IDMARCA_EMR').AsString:= sAux;
    if PutString(sAux, Alinea, 41, 75) then
      FieldByName('MARCA1_EMR').AsString:= sAux;
    if PutString(sAux, Alinea, 76, 110) then
      FieldByName('MARCA2_EMR').AsString:= sAux;
    if PutString(sAux, Alinea, 111, 145) then
      FieldByName('MARCA3_EMR').AsString:= sAux;
    if PutString(sAux, Alinea, 146, 180) then
      FieldByName('MARCA4_EMR').AsString:= sAux;
    if PutString(sAux, Alinea, 181, 215) then
      FieldByName('MARCA5_EMR').AsString:= sAux;
    if PutString(sAux, Alinea, 216, 285) then
      FieldByName('SSCC_EMR').AsString:= sAux;
    if PutString(sAux, Alinea, 286, 320) then
      FieldByName('LOTE_EMR').AsString:= sAux;

    try
      Post;
      result:= True;
    except
            on e:Exception do
            begin
              slError.Add( 'MARCA:' + ALinea + #13 + #10 + e.Message + #13 + #10 );
              Cancel;
              result:= false;
            end;
      //Cancel;
      //result:= false;
    end;
  end;
end;

procedure GuardarBackup( const slLineas: TStringList; const AFichero: string; const AOK: boolean );
var
  sAux: string;
begin
  if slLineas.Count > 0 then
  begin
    sAux:= ExtractFilePath( AFichero ) + '\recadv\';
    if not DirectoryExists( sAux ) then
    begin
      CreateDir( sAux );
    end;
    sAux:= sAux + FormatDateTime('yyyymmddhhnn_', Now ) + ExtractFileName( AFichero );
    if AOK then
      sAux:= sAux + '.ok'
    else
      sAux:= sAux + '.err';
    slLineas.SaveToFile( sAux );
  end;
end;

procedure GuardarLog( const ARuta, ATexto: string );
var
  sAux: string;
  slAux: TStringList;
begin
  if Trim( ATexto ) <> '' then
  begin
    sAux:= ExtractFilePath( ARuta ) + '\logs\';
    if not DirectoryExists( sAux ) then
    begin
      CreateDir( sAux );
    end;
    sAux:= sAux + 'recadv' + FormatDateTime('yyyymmddhhnnss_', Now ) + '.log';

    slAux:= TStringList.Create;
    try
      if FileExists( sAux ) then
      begin
        slAux.LoadFromFile( sAux );
        DeleteFile( sAux );
      end;
      slAux.Add( ATexto );
      slAux.SaveToFile( sAux );
    finally
      FreeAndNil( slAux );
    end;
  end;
end;

//0: importacion OK
//1: ERROR: importado parcialmente
//2: ERROR: no existe el fichero
//3: ERROR: sin datos
//4: ERROR: no importado
function TDLRecadvImportar.ImportarCabecera: Integer;
var
  sFichero, sAux: string;
  slAux, slLineasOk, slLineasError: TStringList;
  iLinea, iTotal, iOk: integer;
begin
  sFichero:= NombreFichero( kCabecera );
  if FileExists( sFichero ) then
  begin
    slLineasOk:= TStringList.Create;
    slLineasError:= TStringList.Create;
    slAux:= TStringList.Create;
    slAux.LoadFromFile( sFichero );

    try
      DeleteFile( sFichero );
    except
      //No hacemos nada
    end;

    iTotal:= 0;
    iOk:= 0;
    iLinea:= 0;
    while ( iLinea < slAux.Count ) do
    begin
      sAux:= LimpiarLinea( slAux[iLinea] );
      if Trim( sAux ) <> '' then
      begin
        iTotal:= iTotal + 1;
        if PasarCabecera( sAux )  then
        begin
          iOk:= iOk + 1;
          slLineasOk.Add( slAux[iLinea] );
        end
        else
        begin
          slLineasError.Add( slAux[iLinea] );
        end;
      end;
      Inc( iLinea );
    end;

    if iTotal > 0 then
    begin
      //Guardar copia de seguridad
      try
        GuardarBackup( slLineasOk, sFichero, True );
        GuardarBackup( slLineasError, sFichero, False );
      finally
        FreeAndNil( slLineasOk );
        FreeAndNil( slLineasError );
      end;

      if iOk > 0 then
      begin
        if iOk = iTotal then
        begin
          result:= 0; // OK
        end
        else
        begin
          result:= 1; // Pasado parcialmente
        end;
      end
      else
      begin
        result:= 4; // no se ha pasado ningun registro
      end;
    end
    else
    begin
      result:= 3; //Sin datos
    end;
    FreeAndNil( slAux );
  end
  else
  begin
    result:= 2; // Noxiste fichero
  end;
end;


//0: importacion OK
//1: ERROR: importado parcialmente
//2: ERROR: no existe el fichero
//3: ERROR: sin datos
//4: ERROR: no importado
function TDLRecadvImportar.ImportarFichero( const AFichero: Integer ) : Integer;
var
  sFichero, sAux: string;
  slAux, slLineasOk, slLineasError: TStringList;
  iLinea, iTotal, iOk: integer;
begin
  sFichero:= NombreFichero( AFichero );
  if FileExists( sFichero ) then
  begin
    slLineasOk:= TStringList.Create;
    slLineasError:= TStringList.Create;
    slAux:= TStringList.Create;
    slAux.LoadFromFile( sFichero );

    try
      DeleteFile( sFichero );
    except
      //No hacemos nada
    end;

    iTotal:= 0;
    iOk:= 0;
    for iLinea:= 0 to slAux.Count -1 do
    begin
      sAux:= LimpiarLinea( slAux[iLinea] );
      if Trim( sAux ) <> '' then
      begin
        iTotal:= iTotal + 1;

        if ImportarLinea( AFichero, sAux ) then
        begin
          iOk:= iOk + 1;
          slLineasOk.Add( slAux[iLinea] );
        end
        else
        begin
          slLineasError.Add( slAux[iLinea] );
        end;
      end;
    end;

    if iTotal > 0 then
    begin
      //Guardar copia de seguridad
      try
        GuardarBackup( slLineasOk, sFichero, True );
        GuardarBackup( slLineasError, sFichero, False );
      finally
        FreeAndNil( slLineasOk );
        FreeAndNil( slLineasError );
      end;

      if iOk > 0 then
      begin
        if iOk = iTotal then
        begin
          result:= 0; // OK
        end
        else
        begin
          result:= 1; // Pasado parcialmente
        end;
      end
      else
      begin
        result:= 4; // no se ha pasado ningun registro
      end;
    end
    else
    begin
      result:= 3; //Sin datos
    end;
    FreeAndNil( slAux );
  end
  else
  begin
    result:= 2; // Noxiste fichero
  end;
end;

procedure AnyadirLinea( var ALinea: string; const AFichero: string );
begin
  if ALinea <> '' then
    ALinea:= ALinea + #13 + #10;
  ALinea:= ALinea + 'PASADO CON ERRORES: No se han podido pasar todas las lineas del fichero de ' +
             AFichero + '.';
end;

function TDLRecadvImportar.ImportarRecadv( var AMensaje: string ): Integer;
var
  sr: TSearchRec;
  sAux: string;
begin
  AMensaje:= '';
  mtCab.Close;
  mtCab.Open;
  //Directorio de los ficheros
  sDir:= GetDirectorio;
  //Existe ficheros
  slError.Clear;
  if FindFirst(sDir+'\CABCRE*.TXT', 0, sr ) = 0 then
  begin
    //0: importacion OK
    //1: ERROR: importado parcialmente
    //2: ERROR: no existe el fichero
    //3: ERROR: sin datos
    //4: ERROR: datos erroneos

    repeat
      sAux:= '';
      sFileNameAux:= sDir + '\' + sr.Name;

      sCodeList:= '';
      result:= ImportarCabecera;
      if ( result < 2 ) then
      begin
        if result = 1 then
          AnyadirLinea( sAux, 'cabeceras' );
        (*
        if ImportarFichero( kEmbalajes ) = 1 then
          AnyadirLinea( sAux, 'embalajes' );
        if ImportarFichero( kDetalles ) = 1 then
          AnyadirLinea( sAux, 'detalles' );
        if ImportarFichero( kCantidades ) = 1 then
          AnyadirLinea( sAux, 'cantidades' );
        if ImportarFichero( kObservaciones ) = 1 then
          AnyadirLinea( sAux, 'observaciones' );
        if ImportarFichero( kMarcas ) = 1 then
           AnyadirLinea( sAux, 'marcas' );
        *)
        if AMensaje = '' then
        begin
          sAux:= '*************************************************************' + #13 + #10 +
                     '-> ' +  sFileNameAux + #13 + #10 +
                     'OK: Importacion de datos ralizada correctamente';
        end
        else
        begin
          sAux:= '*************************************************************' + #13 + #10 +
                     '-> ' +  sFileNameAux + #13 + #10 +'Importacion de datos ralizada parcialmente' + #13 + #10 +
                     AMensaje + #13 + #10 +
                     'Se ha generado un/os fichero/s con los errores encontrados.' + #13 + #10 +
                     'Por favor pongalo en conocimento del departamento de informática, gracias.';
        end;
      end
      else
      begin
        if result = 3 then
          sAux:= '*************************************************************' + #13 + #10 +
                     '-> ' +  sFileNameAux + #13 + #10 +'ERROR: Fichero de cabeceras vacio.'
        else
          sAux:= '*************************************************************' + #13 + #10 +
                     '-> ' +  sFileNameAux + #13 + #10 +'ERROR: Datos del fichero de cabeceras incorrecto.';
      end;

      if AMensaje = '' then
        AMensaje:= sAux
      else
        AMensaje:= AMensaje + #13 + #10 + sAux;

    until FindNext(sr) <> 0;
    FindClose(sr);
    GuardarLog( sFileNameAux, AMensaje );
  end
  else
  begin
    AMensaje:= 'ERROR: No existe el fichero de cabeceras.';
    result:= 2;
  end;
  slError.SaveToFile('C:\Temp\recadv.err');
end;


function TDLRecadvImportar.ActualizarEmpresaCentroSalida( const AProveedor: string; const AALbaran: Integer; const AFecha: TDateTime;
                                            var AEmpresa, ACentroSalida: string ): boolean;
begin
  Result:= False;
  //Rellena codigo de empresa
  with QAux do
  begin
    Sql.Clear;
    SQL.Add(' select empresa_e from frf_empresas where codigo_ean_e = :proveedor  ');
    ParamByName('proveedor').AsString:= AProveedor;
    try
      Open;
      Result:= not IsEmpty;
      AEmpresa:= FieldByName('empresa_e').AsString;
      Close;
    except
    end;
  end;
  //Rellena centro salida
  if Result then
  begin
    with QAux do
    begin
      Sql.Clear;
      SQL.Add(' select centro_salida_sc ');
      SQL.Add(' from frf_salidas_c ');
      SQL.Add(' where empresa_sc = :empresa ');
      SQL.Add('   and fecha_sc = :fecha ');
      SQL.Add('   and n_albaran_sc = :albaran ');
      ParamByName('empresa').AsString:= AEmpresa;
      ParamByName('fecha').AsDateTime:= AFecha;
      ParamByName('albaran').AsInteger:= AALbaran;
      try
        Open;
        ACentroSalida:= FieldByName('centro_salida_sc').AsString;
        Close;
      except
      end;
    end
  end
  else
  begin
    ACentroSalida:= '';
  end;
end;

procedure TDLRecadvImportar.DataModuleCreate(Sender: TObject);
begin
  slError:= tstringlist.Create;
  with mtCab do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('codigo', ftString, 10, False);
    CreateTable;
    Open;
  end;
end;

procedure TDLRecadvImportar.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil( slError );
  with mtCab do
  begin
    Close;
  end;
end;

end.
