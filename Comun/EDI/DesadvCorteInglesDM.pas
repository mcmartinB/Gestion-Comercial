
unit DesadvCorteInglesDM;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable,  ConexionAWSAurora, ConexionAWSAuroraConstantes,SqlExpr;

type
  TDMDesadvCorteIngles = class(TDataModule)
    qryCabOrden: TQuery;
    qryAux: TQuery;
    qryPacking: TQuery;
    qryLinOrden: TQuery;
    kmtVerificar: TkbmMemTable;
    kmtPalets: TkbmMemTable;
    kmtDetallePalet: TkbmMemTable;
    qryCajasPacking: TQuery;
    qryPaletsPacking: TQuery;
    qryCentral: TQuery;
    qryAuxCentral: TQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sCentro, sCliente, sSuministro: string;
    sEANArticulo: string;
    iAlbaran: integer;
    dFecha: TDateTime;
    sMsg: string;
    iContador, iOrden: Integer;
    FQLineasPedido: TSQLQuery;

    sEanBonnysa, sEanEmisor, sEanReceptor, sEanComprador, sDepartamento: string;

    //Lineas
    iEmbalajes, iLineas: Integer;

    //ficheros texto
    slCab, slEmb, slEmbAux, slLin: TStringList;

    //Totalizar
    iPalets, iCajas, iUnidades: Integer;
    rNeto, rTara: Real;
    rTOTQTY: Real;
    sEan128: string;
    iCajasPalet: Integer;
    rNetoPalet, rTaraPalet: Real;

    //Directorio donde grabar la salida
    sDirSalida: string;

    FBDAurora: TConexionAWSAurora;

    function  ObtenerDatos: Boolean;
    function  CrearFicheros: Boolean;
    procedure CerrarTablas;

    function GuardarFicherosEnDisco: Boolean;
    procedure InicializarTotales;
    procedure InicializarTotalesPalet;
    procedure AnyadirTotales;
    procedure GrabarCabecera;
    procedure GrabarEmbalajes;
    procedure GrabarLineas;

    function  GetContador: Integer;
    procedure IncContador;
    procedure AltaContador;
    procedure ModifContador;

    function   CabOrden: Boolean;
    function   GetNumOrden: integer;
    procedure  PackingOrden;
    function   ValidadPacking: Boolean;
    procedure  Deseados( const ANivel, ACodigo, ADescripcion: string; const AUnidades: Integer);
    procedure  Cargados( const ANivel, ACodigo, ADescripcion: string; const AUnidades: Integer);
    function   CargadosOk: Boolean;


    procedure EanBonnysa;
    procedure EanCliente;
    procedure PedidoAurora;

    function GetIDCAB:string;
    function GetNUMDES:string;
    function GetTIPO:string;
    function GetFUNCION:string;
    function GetFECDES:string;
    function GetFECENT:string;
    function GetNUMALB:string;
    function getFECALB:string;
    function GetNUMPED:string;
    function GetFECPED:string;
    function GetORIGEN:string;
    function GetDESTINO:string;
    function GetPROVEEDOR:string;
    function GetCOMPRADOR:string;
    function GetDPTO:string;
    function GetRECEPTOR:string;
    function GetEXPEDIDOR:string;
    function GetTOTQTY:string;
    function GetIDENTIF:string;
    function GetCIP:string;
    function GetPESBRUTOT:string;
    function GetPESNETTOT:string;
    function GetNUMTOTBUL:string;

    function GetIDEMB:string;
    function GetCPS:string;
    function GetCPSPADRE:string;
    function GetCANTEMB:string;
    function GetTIPEMB:string;
    function GetPESON:string;
    function GetPESOB:string;
    function GetPESONU:string;
    function GetPESOBU:string;
    function GetUNIPESO:string;
    function GetSSCC1:string;
    function GetTIPO2:string;
    function GetTCAJAS:string;

    function GetIDLIN:string;
    function GetEAN:string;
    function GetNUMEXP:string;
    function GetDESCRIP:string;
    function GetTIPART:string;
    function GetCENVFAC:string;
    function GetCUEXP:string;
    function GetNUMLINPED:string;
    function GetPESTOTBRULIN:string;
    function GetUNICANT:string;
    function GetCANTPED:string;
    function GetUNICANTPED:string;

  public
    { Public declarations }
    function CrearFicherosDesadv( const AEmpresa, ACentro: string;
                                  const AAlbaran: integer;
                                  const AFecha: TDateTime;
                                  const ACliente, ASuministro: string;
                                  var VMsg: string ): Boolean;

  end;

  function CrearFicherosDesadv( const AOwner: TComponent;
                                const AEmpresa, ACentro: string;
                                const AAlbaran: integer;
                                const AFecha: TDateTime;
                                const ACliente, ASuministro: string;
                                var VMsg: string ): Boolean;



implementation

{$R *.dfm}

uses
  UDMAuxDB, UDMBaseDatos, Variants, VerificarDesadvFD, FileCtrl, Dialogs,
  Controls, bTextUtils;

var
  DMDesadvCorteIngles: TDMDesadvCorteIngles;


function CrearFicherosDesadv( const AOwner: TComponent;
                              const AEmpresa, ACentro: string;
                              const AAlbaran: integer;
                              const AFecha: TDateTime;
                              const ACliente, ASuministro: string;
                              var VMsg: string ): Boolean;
begin
  DMDesadvCorteIngles:= TDMDesadvCorteIngles.Create( AOwner );
  try
    result:= DMDesadvCorteIngles.CrearFicherosDesadv( AEmpresa, ACentro, AAlbaran, AFecha, ACliente, ASuministro, VMsg );
  finally
    FreeAndNil( DMDesadvCorteIngles );
  end;
end;

function TDMDesadvCorteIngles.CrearFicherosDesadv( const AEmpresa, ACentro: string;
                              const AAlbaran: integer;
                              const AFecha: TDateTime;
                              const ACliente, ASuministro: string;
                              var VMsg: string ): Boolean;
begin
  sEmpresa:= AEmpresa;
  sCentro:= ACentro;
  iAlbaran:= AAlbaran;
  dFecha:= AFecha;
  sCliente:= ACliente;
  sSuministro:= ASuministro;
  sMsg:= '';

  slCab:= TStringList.Create;
  slEmb:= TStringList.Create;
  slEmbAux:= TStringList.Create;
  slLin:= TStringList.Create;

  FBDAurora := TConexionAWSAurora.Create;
  FBDAurora.Connected := true;
  FQLineasPedido := FBDAurora.NewSQLQuery;
  FQLineasPedido.SQL.Add(' SELECT empresa_lp,det.id,producto_lp,articulo_lp,ean13_ee, observaciones_lp, peso_variable_e, unidades_e,            ');
  FQLineasPedido.SQL.Add('        unidades_lp, kilos_lp                                                                                         ');
  FQLineasPedido.SQL.Add('   FROM frf_linea_pedidos det                                                                                         ');
  FQLineasPedido.SQL.Add('   LEFT JOIN frf_cabecera_pedidos cab on numero_pedido_lp=cab.id                                                      ');
  FQLineasPedido.SQL.Add('   LEFT JOIN frf_ean13 ean on articulo_lp = ean.envase_ee and empresa_lp = empresa_ee and cliente_cp = cliente_fac_ee ');
  FQLineasPedido.SQL.Add('   LEFT JOIN frf_envases on envase_e = articulo_lp                                                                    ');
  FQLineasPedido.SQL.Add('  WHERE cab.deleted_at is null                                                                                        ');
  FQLineasPedido.SQL.Add('    AND det.deleted_at is null                                                                                        ');
  FQLineasPedido.SQL.Add('    AND numero_pedido_cliente_cp = :pedido                                                                            ');
  FQLineasPedido.SQL.Add('    AND cliente_cp =:cliente                                                                                          ');
  FQLineasPedido.SQL.Add('  ORDER BY observaciones_lp                                                                                           ');


  //A currar
  Result:= False;
  try
    if ObtenerDatos then
    begin
      Result:= CrearFicheros;
      if Result then
        IncContador;
    end;
  finally
    CerrarTablas;
  end;

  VMsg:= sMsg;
end;

procedure TDMDesadvCorteIngles.DataModuleCreate(Sender: TObject);
begin
  sDirSalida:= 'C:\ASPEDI\PRODUCCION\SALIDA';

  //DATOS DE lA CENTRAL
  with qryCentral do
  begin
    sql.clear;
    sql.Add(' select quienpide_ce, quienrecibe_ce, quienpaga_ce  ');
    sql.Add(' from frf_clientes_edi ');
    sql.Add(' where empresa_ce = :empresa ');
    sql.Add(' and cliente_ce = :cliente  ');
    sql.Add(' and dir_sum_ce = :suministro ');
  end;

  //DATOS DEL DESADV
  with qryCabOrden do
  begin
    sql.clear;
    sql.Add(' select orden_occ orden_carga, hora_occ hora_carga, cliente_sal_occ cliente, ');
    sql.Add('        dir_sum_occ suministro, n_pedido_occ n_pedido, fecha_pedido_occ fecha_pedido, ');
    sql.Add('        depto_occ departamento ');
    sql.Add(' from frf_orden_carga_c ');
    sql.Add(' where empresa_occ = :empresa ');
    sql.Add(' and centro_salida_occ = :centro ');
    sql.Add(' and fecha_occ = :fecha ');
    sql.Add(' and n_albaran_occ = :albaran ');
  end;

  with qryPacking do
  begin
    sql.clear;
    sql.Add(' select ean128_pl, tipo_palet_pl, descripcion_tp, producto_pl, producto_base_pl,     ');
    sql.Add('        ean13_pl, envase_pl, cajas_pl, peso_pl,                                      ');  //peso_pl es bruto o neto
    sql.Add('        descripcion_e, ean13_e, peso_envase_e, peso_neto_e, peso_variable_e,         ');
    sql.Add('        unidades_e, unidades_variable_e, tipo_unidad_e                               ');
    sql.Add(' from frf_packing_list left join frf_envases on envase_e = envase_pl                 ');
    sql.Add('                                             and producto_e = producto_pl            ');
    sql.Add('                         left join frf_tipo_palets on codigo_tp = tipo_palet_pl      ');
    sql.Add(' where orden_pl = :orden                                                             ');
    sql.Add(' order by ean128_pl, ean13_pl                                                        ');
  end;

  //VERIFICAR CARGA ALBARAN
  with qryLinOrden do
  begin
    sql.clear;
    sql.Add(' select envase_ocl, unidades_caja_ocl, cajas_ocl, n_palets_ocl, tipo_palets_ocl, descripcion_tp, ');
    sql.Add('        kilos_packing_ocl, cajas_packing_ocl, palets_packing_ocl,  ');
    sql.Add('        descripcion_e, ean13_e, peso_envase_e, peso_neto_e, peso_variable_e, ');
    sql.Add('        unidades_e, unidades_variable_e, tipo_unidad_e  ');
    sql.Add(' from frf_orden_carga_l  left join frf_envases on envase_e = envase_ocl ');
    sql.Add('                                             and producto_e = producto_ocl  ');
    sql.Add('                         left join frf_tipo_palets on codigo_tp = tipo_palets_ocl ');
    sql.Add(' where orden_ocl = :orden ');
    sql.Add(' order by envase_ocl ');
  end;

  with qryCajasPacking do
  begin
    sql.clear;
    sql.Add(' select  envase_pl, descripcion_e, sum(cajas_pl) cajas_pl ');
    sql.Add(' from frf_packing_list left join frf_envases on envase_e = envase_pl  ');
    sql.Add('                                              and producto_e = producto_pl  ');
    sql.Add(' where orden_pl = :orden  ');
    sql.Add(' group by envase_pl, descripcion_e ');
  end;


  with qryPaletsPacking do
  begin
    sql.clear;
    sql.Add(' select ean128_pl, tipo_palet_pl, descripcion_tp ');
    sql.Add(' from frf_packing_list left join frf_tipo_palets on codigo_tp = tipo_palet_pl  ');
    sql.Add(' where orden_pl = :orden     ');
    sql.Add(' group by ean128_pl, tipo_palet_pl, descripcion_tp  ');
  end;


  kmtVerificar.Close;
  kmtVerificar.FieldDefs.Clear;
  kmtVerificar.FieldDefs.Add('nivel', ftString, 5, False);
  kmtVerificar.FieldDefs.Add('codigo', ftString, 9, False);
  kmtVerificar.FieldDefs.Add('descripcion', ftString, 30, False);
  kmtVerificar.FieldDefs.Add('esperados', ftInteger, 0, False);
  kmtVerificar.FieldDefs.Add('cargados', ftInteger, 0, False);

  kmtVerificar.IndexFieldNames:= 'nivel;codigo';
  kmtVerificar.SortFields:= 'nivel;codigo';
  kmtVerificar.CreateTable;
  kmtVerificar.Open;
end;

procedure TDMDesadvCorteIngles.CerrarTablas;
begin
  qryPacking.Close;
  qryCabOrden.Close;
  FreeAndNil(slCab);
  FreeAndNil(slEmb);
  FreeAndNil(slEmbAux);
  FreeAndNil(slLin);
end;

procedure TDMDesadvCorteIngles.DataModuleDestroy(Sender: TObject);
begin
  //
  FBDAurora.Connected := false;
  FBDAurora.Destroy;
end;

(*
select  *
from edi_desadv_cab
//where empresa_edc = 'F18' and centro_salida_edc = '1' and fecha_edc = '14/4/2014' and n_albaran_edc = 26563
*)

function TDMDesadvCorteIngles.GetContador;
begin
  with qryAux do
  begin
    sql.clear;
    sql.Add(' select  max(contador_edc) contador ');
    sql.Add(' from edi_desadv_cab ');
    sql.Add(' where empresa_edc = :empresa ');
    ParamByName('empresa').AsString:= sEmpresa;
    Open;
    if not IsEmpty then
      Result:= FieldByName('contador').AsInteger + 1
    else
      result:= 1;
    Close;
  end;
end;


procedure TDMDesadvCorteIngles.IncContador;
begin
  with qryAux do
  begin
    sql.clear;
    sql.Add(' select *  ');
    sql.Add(' from edi_desadv_cab  ');
    sql.Add(' where empresa_edc = :empresa ');
    sql.Add(' and centro_salida_edc = :centro  ');
    sql.Add(' and n_albaran_edc = :albaran  ');
    sql.Add(' and fecha_edc = :fecha  ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('fecha').AsDate:= dFecha;
    ParamByName('albaran').AsInteger:= iAlbaran;
    Open;
    if IsEmpty then
    begin
      Close;
      AltaContador;
    end
    else
    begin
      Close;
      ModifContador;
    end;
  end;
end;

procedure TDMDesadvCorteIngles.AltaContador;
begin
  with qryAux do
  begin
    sql.clear;
    sql.Add(' insert into edi_desadv_cab   ');
    sql.Add(' (empresa_edc, contador_edc, centro_salida_edc, n_albaran_edc, fecha_edc)   ');
    sql.Add(' values  ');
    sql.Add(' (:empresa, :contador, :centro, :albaran, :fecha)    ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('fecha').AsDate:= dFecha;
    ParamByName('albaran').AsInteger:= iAlbaran;
    ParamByName('contador').AsInteger:= iContador;
    ExecSQL;
  end;
end;

procedure TDMDesadvCorteIngles.ModifContador;
begin
  with qryAux do
  begin
    sql.clear;
    sql.Add(' update edi_desadv_cab  ');
    sql.Add(' set contador_edc = :contador  ');
    sql.Add(' where empresa_edc = :empresa ');
    sql.Add(' and centro_salida_edc = :centro  ');
    sql.Add(' and n_albaran_edc = :albaran  ');
    sql.Add(' and fecha_edc = :fecha  ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('fecha').AsDate:= dFecha;
    ParamByName('albaran').AsInteger:= iAlbaran;
    ParamByName('contador').AsInteger:= iContador;
    ExecSQL;
  end;
end;

function  TDMDesadvCorteIngles.CabOrden: Boolean;
begin
  with qryCabOrden do
  begin
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('fecha').AsDate:= dFecha;
    ParamByName('albaran').AsInteger:= iAlbaran;
    Open;
    Result:= not IsEmpty;
  end;
end;

procedure  TDMDesadvCorteIngles.PackingOrden;
begin
  with qryPacking do
  begin
    ParamByName('orden').AsInteger:= iOrden;
    Open;
  end;
end;

procedure TDMDesadvCorteIngles.Deseados( const ANivel, ACodigo, ADescripcion: string; const AUnidades: Integer );
begin
  if kmtVerificar.Locate( 'nivel;codigo', varArrayOf( [ANivel, ACodigo] ), [] ) then
  begin
    kmtVerificar.Edit;
    kmtVerificar.FieldByName('esperados').AsInteger:=  kmtVerificar.FieldByName('esperados').AsInteger +  AUnidades;
    kmtVerificar.Post;
  end
  else
  begin
    kmtVerificar.Insert;
    kmtVerificar.FieldByName('nivel').AsString:= ANivel;
    kmtVerificar.FieldByName('codigo').AsString:= ACodigo;
    kmtVerificar.FieldByName('descripcion').AsString:= ADescripcion;
    kmtVerificar.FieldByName('esperados').AsInteger:=  AUnidades;
    kmtVerificar.FieldByName('cargados').AsInteger:= 0;
    kmtVerificar.Post;
  end;
end;

procedure TDMDesadvCorteIngles.Cargados( const ANivel, ACodigo, ADescripcion: string; const AUnidades: Integer);
begin
  if kmtVerificar.Locate( 'nivel;codigo', varArrayOf( [ANivel, ACodigo] ), [] ) then
  begin
    kmtVerificar.Edit;
    kmtVerificar.FieldByName('cargados').AsInteger:=  kmtVerificar.FieldByName('cargados').AsInteger +  AUnidades;
    kmtVerificar.Post;
  end
  else
  begin
    kmtVerificar.Insert;
    kmtVerificar.FieldByName('nivel').AsString:= ANivel;
    kmtVerificar.FieldByName('codigo').AsString:= ACodigo;
    kmtVerificar.FieldByName('descripcion').AsString:= ADescripcion;
    kmtVerificar.FieldByName('cargados').AsInteger:=  AUnidades;
    kmtVerificar.FieldByName('esperados').AsInteger:= 0;
    kmtVerificar.Post;
  end;

end;

function TDMDesadvCorteIngles.CargadosOK: Boolean;
begin
  kmtVerificar.First;
  Result:= True;
  while ( not kmtVerificar.Eof ) and Result do
  begin
    Result:= kmtVerificar.FieldByName('cargados').AsInteger  = kmtVerificar.FieldByName('esperados').AsInteger;
    kmtVerificar.Next;
  end;
  kmtVerificar.First;
end;

//Totales, linea primer nivel del fichero embalajes
function  TDMDesadvCorteIngles.ValidadPacking: Boolean;
var
  iCajas, iPalets: Integer;
  bFlag: boolean;
begin
  //comprobar coinciden nuemro de cajas y palet por envase
  //ALBARAN
  with qryLinOrden do
  begin
    ParamByName('orden').AsInteger:= iOrden;
    Open;
  end;
  try
    while not qryLinOrden.Eof do
    begin
      //Cajas y palets  deseadas
      Deseados( 'CAJA', qryLinOrden.FieldByName('envase_ocl').AsString,
                qryLinOrden.FieldByName('descripcion_e').AsString,
                qryLinOrden.FieldByName('cajas_ocl').Asinteger );
      Deseados( 'PALET', qryLinOrden.FieldByName('tipo_palets_ocl').AsString,
                qryLinOrden.FieldByName('descripcion_tp').AsString,
               qryLinOrden.FieldByName('n_palets_ocl').Asinteger );
      qryLinOrden.Next;
    end;
  finally
    qryLinOrden.Close;
  end;

  //PACKING
  with qryCajasPacking do
  begin
    ParamByName('orden').AsInteger:= iOrden;
    Open;
  end;
  with qryPaletsPacking do
  begin
    ParamByName('orden').AsInteger:= iOrden;
    Open;
  end;
  try
    while not qryPaletsPacking.Eof do
    begin
      Cargados( 'PALET', qryPaletsPacking.FieldByName('tipo_palet_pl').AsString,
                qryPaletsPacking.FieldByName('descripcion_tp').AsString, 1 );
      qryPaletsPacking.Next;
    end;
    while not qryCajasPacking.Eof do
    begin
      Cargados( 'CAJA', qryCajasPacking.FieldByName('envase_pl').AsString,
                qryCajasPacking.FieldByName('descripcion_e').AsString,
                qryCajasPacking.FieldByName('cajas_pl').Asinteger );
      qryCajasPacking.Next;
    end;
  finally
    qryCajasPacking.Close;
    qryPaletsPacking.Close;
  end;

  //VERIFICAR QUE SEA OK
  kmtVerificar.Sort([]);
  Result:= VerificarDesadvFD.VerResultadoVerificacion( Self, CargadosOK, TDataSet( kmtVerificar ), sMsg );
end;

function  TDMDesadvCorteIngles.GetNumOrden: integer;
begin
  if not qryCabOrden.IsEmpty then
  begin
    result:= qryCabOrden.fieldByName('orden_carga').AsInteger;
  end
  else
  begin
    result:= -1;
  end;
end;

function  TDMDesadvCorteIngles.ObtenerDatos: boolean;
begin
  if CabOrden then
  begin
    iOrden:= GetNumOrden;
    Result:= ValidadPacking;
    if Result then
    begin
      iContador:= GetContador;
      PackingOrden;
    end;
  end
  else
  begin
    Result:= False;
    sMsg:= 'No hay datos de carga para el albarán seleccionado.';
  end;
end;

function  TDMDesadvCorteIngles.CrearFicheros: Boolean;
begin
  InicializarTotales;

  EanBonnysa;
  EanCliente;
  PedidoAurora;

  qryPacking.First;
  sEan128:= qryPacking.fieldByName('ean128_pl').AsString;
  iEmbalajes:= 2;
  iLineas:= 1;

  while not qryPacking.Eof do
  begin
    AnyadirTotales;

    GrabarLineas;
    iLineas:= iLineas + 1;
    qryPacking.Next;

    if ( sEan128 <> qryPacking.fieldByName('ean128_pl').AsString ) or qryPacking.Eof then
    begin
      GrabarEmbalajes;
      iEmbalajes:= iEmbalajes + 1;
      sEan128:= qryPacking.fieldByName('ean128_pl').AsString;
      InicializarTotalesPalet;
      iPalets:= iPalets + 1;
    end;
  end;

  iEmbalajes:= 1;
  GrabarEmbalajes;
  GrabarCabecera;

  result:= GuardarFicherosEnDisco;
end;

function TDMDesadvCorteIngles.GuardarFicherosEnDisco: Boolean;
var
  sDir: string;
begin
  sDir := sDirSalida;
  //if SelectDirectory('   Selecciona directorio destino.', 'c:\', sDir) then
  begin
    if copy(sDir, length(sDir) - 1, length(sDir)) <> '\' then
    begin
      sDir := sDir + '\';
    end;

    if FileExists( sDir + 'CABALB.txt' ) then
    begin
      result:= MessageDlg( 'Ya existen ficheros en el destino, si continua los borrara.' + #13 + #10 +
                     'Por favor, considere subirlos a EDI antes de continuar.' + #13 + #10 +
                     '¿Seguro que desea continuar?',mtWarning, [mbYes, mbNo], 0	) = mrYes;

    end
    else
    begin
      result:= True;
    end;

    if Result then
    begin
      slCab.SaveToFile( sDir + 'CABALB.txt');
      slEmb.SaveToFile( sDir + 'EMBALB.txt');
      slLin.SaveToFile( sDir + 'LINALB.txt');
    end
    else
    begin
      sMsg:= 'Ya existen ficheros en el destino, súbalos a EDI antes de continuar.';
    end;
  end;
end;

procedure TDMDesadvCorteIngles.GrabarCabecera;
var
  sAux: string;
begin
  //
  sAux:= GetIDCAB;
  sAux:= sAux + getNUMDES;
  sAux:= sAux + getTIPO;
  sAux:= sAux + getFUNCION;
  sAux:= sAux + getFECDES;
  sAux:= sAux + getFECENT;
  sAux:= sAux + '#';
  sAux:= sAux + '#';
  sAux:= sAux + '#';
  sAux:= sAux + '#';
  sAux:= sAux + getNUMALB;
  sAux:= sAux + getFECALB;
  sAux:= sAux + getNUMPED;
  sAux:= sAux + getFECPED;
  sAux:= sAux + '#';
  sAux:= sAux + '#';
  sAux:= sAux + getORIGEN;
  sAux:= sAux + getDESTINO;
  sAux:= sAux + getPROVEEDOR;
  sAux:= sAux + getCOMPRADOR;
  sAux:= sAux + getDPTO;
  sAux:= sAux + getRECEPTOR;
  sAux:= sAux + '#';
  sAux:= sAux + '#';
  sAux:= sAux + getEXPEDIDOR;
  sAux:= sAux + '#';
  sAux:= sAux + '#';
  sAux:= sAux + '#';
  sAux:= sAux + '#';
  sAux:= sAux + '#';
  sAux:= sAux + '#';
  sAux:= sAux + '#';
  sAux:= sAux + '#';
  sAux:= sAux + getTOTQTY;
  sAux:= sAux + getIDENTIF;
  sAux:= sAux + '#';
  sAux:= sAux + getCIP;
  sAux:= sAux + '#';
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + getPESBRUTOT;
  sAux:= sAux + getPESNETTOT;
  sAux:= sAux + getNUMTOTBUL;
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#

  slCab.Add( sAux );
end;

procedure TDMDesadvCorteIngles.GrabarEmbalajes;
var
  sAux: string;
begin
  //
  sAux:= getIDCAB;
  sAux:= sAux + getIDEMB;
  sAux:= sAux + getCPS;
  sAux:= sAux + getCPSPADRE;
  sAux:= sAux + getCANTEMB;
  sAux:= sAux + '#';
  sAux:= sAux + '#';
  sAux:= sAux + getTIPEMB;
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + getPESON;
  sAux:= sAux + getPESOB;
  sAux:= sAux + getPESONU;
  sAux:= sAux + getPESOBU;
  sAux:= sAux + getUNIPESO;
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + getSSCC1;
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + getTIPO2;
  sAux:= sAux + getTCAJAS;
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#

  if iEmbalajes = 1 then
  begin
    slEmb.Add( sAux );
    slEmb.AddStrings( slEmbAux );
  end
  else
  begin
    slEmbAux.Add( sAux );
  end;
end;

procedure TDMDesadvCorteIngles.GrabarLineas;
var
  sAux: string;
begin
  //Obtener datos
  sEANArticulo := getEAN;

  sAux:= getIDCAB;
  sAux:= sAux + getIDEMB;
  sAux:= sAux + getIDLIN;
  sAux:= sAux + sEANArticulo;
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + getNUMEXP;
  sAux:= sAux + getDESCRIP;
  sAux:= sAux + getTIPART;
  sAux:= sAux + getCENVFAC;
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + getCUEXP;
  sAux:= sAux + getUNICANT; //#           //UNICANT
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + getNUMPED; //#      //NUMPED
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + getNUMLINPED + '#'; //NUMLINPED
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + getCANTPED; //#     //CANTPED
  sAux:= sAux + getUNICANTPED; //#            //UNICANTPED
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + getPESTOTBRULIN;
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#

  slLin.Add( sAux );
end;

procedure TDMDesadvCorteIngles.EanBonnysa;
begin
  with qryAux do
  begin
    SQL.Clear;
    SQL.Add(' select codigo_ean_e ');
    SQL.Add(' from frf_empresas ');
    SQL.Add(' where empresa_e = :empresa ');
    ParamByName('empresa').AsString:= sEmpresa;
    Open;
    sEanBonnysa:= FieldByName('codigo_ean_e').AsString;
    Close;
  end;
end;

procedure TDMDesadvCorteIngles.EanCliente;
begin
  DMBaseDatos.BDCentral.Open;
  try
    qryCentral.ParamByName('empresa').AsString:= sEmpresa;
    qryCentral.ParamByName('cliente').AsString:= sCliente;
    qryCentral.ParamByName('suministro').AsString:= sSuministro;
    qryCentral.Open;
    sEanEmisor:=   qryCentral.FieldByName('quienpide_ce').AsString;
    sEanReceptor:= qryCentral.FieldByName('quienrecibe_ce').AsString;
    sEanComprador:= qryCentral.FieldByName('quienpaga_ce').AsString;
  finally
    qryCentral.Close;
    DMBaseDatos.BDCentral.Close;
  end;
  sDepartamento:= '188';
end;

procedure TDMDesadvCorteIngles.PedidoAurora;
begin
  //NUMLINPED
  FQLineasPedido.ParamByName('pedido').AsString := qryCabOrden.FieldByName('n_pedido').AsString;
  FQLineasPedido.ParamByName('cliente').AsString := qryCabOrden.FieldByName('cliente').AsString;
  FQLineasPedido.Open;
end;

function TDMDesadvCorteIngles.GetIDCAB:string;
begin
  //IDCAB#Clave del registro de cabeceras
  result:= IntToStr(iContador) + '#';
end;
function TDMDesadvCorteIngles.GetNUMDES:string;
begin
  //NUMDES#Número de Aviso de Expedición
  (*TODO*)  //Que es el aviso de expedicion
  result:= sEmpresa + FormatDateTime( 'yy', dFecha ) + '-' + IntToStr( iAlbaran )+ '#';
  //result := sEmpresa + sCentro + Rellena( IntToStr( iAlbaran ), 5, '0', taLeftJustify ) + Coletilla( sEmpresa ) + '#';
end;
function TDMDesadvCorteIngles.GetTIPO:string;
begin
  //TIPO#351
  result:= '351#';
end;
function TDMDesadvCorteIngles.GetFUNCION:string;
begin
  //FUNCION#9
  result:= '9#';
end;
function TDMDesadvCorteIngles.GetFECDES:string;
begin
  //FECDES#Fecha o Fecha/Hora del Aviso de Expedición --> AAAAMMDDHHmm
  result:= FormatDateTime('yyyymmdd',dFecha) + '#';
end;
function TDMDesadvCorteIngles.GetFECENT:string;
begin
  //FECENT#Fecha o Fecha/Hora del Aviso de Entrega --> AAAAMMDDHHmm (Optativo)
  result:= FormatDateTime('yyyymmdd',dFecha) + '#';
end;
function TDMDesadvCorteIngles.GetNUMALB:string;
begin
  //NUMALB#Número de Albarán
  //ECI
  //comprobar que esto funciona
  if ( Copy( sEmpresa, 1, 1) = 'F' ) and ( qryCabOrden.FieldByName('cliente').AsString <> 'ECI' ) then
  begin
    result := sEmpresa + sCentro + Rellena( IntToStr( iAlbaran ), 5, '0', taLeftJustify ) + Coletilla( sEmpresa ) + '#';
  end
  else
  (*
  if ( Copy( sEmpresa, 1, 1) = 'F' ) and ( qryCabOrden.FieldByName('cliente').AsString = 'ECI' ) then
  begin
    Result := Copy( sEmpresa, 2, 2) + sCentro + Rellena( IntToStr( iAlbaran ), 5, '0', taLeftJustify ) + Coletilla( sEmpresa ) + '#';
  end
  else
  *)
  begin
    result:= IntToStr( iAlbaran ) + '#';
  end;
end;

function TDMDesadvCorteIngles.getFECALB:string;
begin
  //FECALB#Fecha del Albarán
  result:= FormatDateTime('yyyymmdd',dFecha) + '#';
end;
function TDMDesadvCorteIngles.GetNUMPED:string;
begin
  //NUMPED#Número de pedido
  //Sacar del albaran
  result:= qryCabOrden.FieldByName('n_pedido').AsString + '#';
end;
function TDMDesadvCorteIngles.GetFECPED:string;
begin
  //FECPED#Fecha de Pedido (Optativo)
  result:= '#';
end;
function TDMDesadvCorteIngles.GetORIGEN:string;
begin
  //ORIGEN#Código EAN-13 origen del mensaje. (BONNYSA)
  result:= sEanBonnysa + '#';
end;
function TDMDesadvCorteIngles.GetDESTINO:string;
begin
  //DESTINO#Código EAN-13 destino del mensaje.
  result:= sEanEmisor + '#';
end;
function TDMDesadvCorteIngles.GetPROVEEDOR:string;
begin
  //PROVEEDOR#Código EAN-13 del proveedor de las mercancías. (BONNYSA)
  result:= sEanBonnysa + '#';
end;
function TDMDesadvCorteIngles.GetCOMPRADOR:string;
begin
  //COMPRADOR#Código EAN-13 del  comprador
  if sCliente = 'SOK' then  // Para SOK
    result := sEanComprador + '#'
  else  //Para ECI
    result:= sEanReceptor + '#';
end;
function TDMDesadvCorteIngles.GetDPTO:string;
begin
  //DPTO#Código del departamento que pide la mercancía. (OBLIGATORIO CORTE INGLES)
  //result:= qryCabOrden.FieldByName('departamneto').AsString + '#';
  result:= sDepartamento + '#';
end;
function TDMDesadvCorteIngles.GetRECEPTOR:string;
begin
  //RECEPTOR#Código EAN-13 del receptor de la entrega
  result:= sEanReceptor + '#';
end;
function TDMDesadvCorteIngles.GetEXPEDIDOR:string;
begin
  //EXPEDIDOR#Código EAN-13 del expedidor (Optativo --> Bonnysa)
  result:= sEanBonnysa + '#';
end;
function TDMDesadvCorteIngles.GetTOTQTY:string;
begin
  //TOTQTY#Sumatorio de las cantidades indicadas los campo CENVFAC al nivel de línea.
  result:= FormatFloat( '#.###', rTOTQTY  ) + '#';
end;
function TDMDesadvCorteIngles.GetIDENTIF:string;
begin
  //IDENTIF#X6 -> Indica si el palet viene identificado por un SSCC o matricula (Obligatorio Corte Ingles)
  result:= 'X6#';
end;
function TDMDesadvCorteIngles.GetCIP:string;
begin
  //CIP#Código Interno de Proveedor (solo Alcampo)
  result:= '112979#';
end;
function TDMDesadvCorteIngles.GetPESBRUTOT:string;
begin
  //PESBRUTOT#Peso Bruto Total del Envío(Opativo -> Obligatorio Corte ingles perecederos)
  result:= FormatFloat( '#.###', rTara + rNeto ) + '#';
end;
function TDMDesadvCorteIngles.GetPESNETTOT:string;
begin
  //PESNETTOT#Peso Neto Total del Envío(Opativo -> Obligatorio Corte ingles perecederos)
  result:= FormatFloat( '#.###', rNeto ) + '#';
end;
function TDMDesadvCorteIngles.GetNUMTOTBUL:string;
begin
  //NUMTOTBUL#Número Total de Bultos (Opativo -> Obligatorio Corte ingles perecederos)
  result:= IntToStr( iCajas ) + '#';
end;

function TDMDesadvCorteIngles.GetIDEMB:string;
begin
  //IDEMB#Idenificador de embalajes.
  result:= IntToStr( iEmbalajes ) + '#';
end;
function TDMDesadvCorteIngles.GetCPS:string;
begin
  //CPS#32 Número de identificación en la jerarquía de niveles de empaquetamiento. (secuencial)
  result:= IntToStr( iEmbalajes ) + '#';
end;
function TDMDesadvCorteIngles.GetCPSPADRE:string;
begin
  //CPSPADRE#Nivel jerárquico del que depende el nivel actual.
  if iEmbalajes = 1 then
    result:= '#'
  else
    result:= '1#';
end;
function TDMDesadvCorteIngles.GetCANTEMB:string;
begin
  //CANTEMB#Número de paquetes dentro de esta unidad de embalaje.
  if iEmbalajes = 1 then
    result:= IntToStr( iPalets ) + '#'
  else
    result:= '1#'; //un palet
end;
function TDMDesadvCorteIngles.GetCANTPED: string;
var rCANTPED:real;
begin
  if qryCabOrden.FieldByName('cliente').AsString = 'SOK' then
  begin
    FQLineasPedido.First;
    while not FQLineasPedido.Eof do
    begin
      if FQLineasPedido.FieldByName('ean13_ee').AsString = copy( sEANArticulo, 1, Length(sEANArticulo)-1) then
      begin
        if FQLineasPedido.FieldByName('peso_variable_e').AsInteger = 1 then
          rCANTPED := FQLineasPedido.FieldByName('kilos_lp').AsFloat
        else if FQLineasPedido.FieldByName('unidades_e').AsInteger > 1 then
          rCANTPED :=  FQLineasPedido.FieldByName('unidades_lp').AsFloat
        else
          rCANTPED:= FQLineasPedido.FieldByName('kilos_lp').AsFloat;

          result := FormatFloat('0.00', rCANTPED) + '#';
          exit;
      end;

      FQLineasPedido.Next;
    end;
  end
  else
    result := '#';

end;

function TDMDesadvCorteIngles.GetTIPEMB:string;
begin
  //TIPEMB#Tipo de embalaje. (201 = Palet ISO 1 (80 x 120 cm.))
  if sCliente = 'SOK' then
    result:= 'PE#'
  else
    result:= '201#';
end;
function TDMDesadvCorteIngles.GetPESON:string;
begin
  //PESON#Peso Neto Total
  //Peso Variable
  if iEmbalajes = 1 then
   result := '#'
  else
  begin
    result := FormatFloat ('#,##0.00', rNetoPalet ) + '#';
  end;
//    result:= '#';
end;
function TDMDesadvCorteIngles.GetPESOB:string;
begin
  //PESOB#Peso Bruto Total. -> Corte Ingles para Peso variable
  (*
  if iEmbalajes > 1 then
    result:= FormatFloat( '##.#' + rBrutoPalet ) + '#'
  else*)
    result:= '#';
end;
function TDMDesadvCorteIngles.GetPESONU:string;
begin
  //PESONU#Peso Neto Unitario. -> Corte Ingles para Peso variable
  result:= '#';
end;
function TDMDesadvCorteIngles.GetPESOBU:string;
begin
  //PESOBU#Peso Bruto Unitario. -> Corte Ingles para Peso variable
  result:= '#';
end;
function TDMDesadvCorteIngles.GetUNICANT: string;
var sUNICANT: string;
begin
  sUNICANT := '';
  if qryCabOrden.FieldByName('cliente').AsString = 'SOK' then
  begin
    if qryPacking.FieldByName('peso_variable_e').AsInteger = 1 then
      sUNICANT := 'KGM'
    else if qryPacking.FieldByName('unidades_e').AsInteger > 1 then
      sUNICANT :=  'PCE'
    else
       sUNICANT:= 'KGM';
  end;
  result:= sUNICANT + '#';
end;

function TDMDesadvCorteIngles.GetUNICANTPED: string;
var sUNICANT: string;
begin
  if qryCabOrden.FieldByName('cliente').AsString = 'SOK' then
  begin
    FQLineasPedido.First;
    while not FQLineasPedido.Eof do
    begin
      if FQLineasPedido.FieldByName('ean13_ee').AsString = copy( sEANArticulo, 1, Length(sEANArticulo)-1) then
      begin
        if FQLineasPedido.FieldByName('peso_variable_e').AsInteger = 1 then
          sUNICANT := 'KGM'
        else if FQLineasPedido.FieldByName('unidades_e').AsInteger > 1 then
          sUNICANT :=  'PCE'
        else
          sUNICANT:= 'KGM';

          result := sUNICANT + '#';
          exit;
      end;

      FQLineasPedido.Next;
    end;
  end
  else
    result := '#';
end;

function TDMDesadvCorteIngles.GetUNIPESO:string;
begin
  //UNIPESO#KGMUnidad de Medida de Pesos
  result:= 'KGM#';
end;
function TDMDesadvCorteIngles.GetSSCC1:string;
begin
  //SSCC1#SSCC de la Unidad de Expedición descrita 1. Para ECI (gran consumo) es obligatorio a nivel de PALET
  if iEmbalajes > 1 then
    result:= Copy( sEan128, 3, 18 ) + '#'
  else
    result:= '#';
end;
function TDMDesadvCorteIngles.GetTIPO2:string;
begin
  //TIPO2#Tipo de embalaje contenido (únicamente cuando estamos a nivel de PALET)
  if iEmbalajes > 1 then
    result:= 'CT#'
  else
    result:= '#';
(*
CT = Caja de cartón
CS = Caja rígida
PK = Paquete / Embalaje
SL = Placa de plástico (Hoja de Embalaje)
SW = Retractilado
RO = Rollo
*)
end;
function TDMDesadvCorteIngles.GetTCAJAS:string;
begin
  //TCAJAS#Número total de cajas contenidas (únicamente cuando estamos a nivel de PALET)
  if iEmbalajes > 1 then
    result:= IntToStr( iCajasPalet) + '#'
  else
    result:= '#';
end;

function TDMDesadvCorteIngles.GetIDLIN:string;
begin
  //IDLIN#Identificación de línea de albarán.
  result:= intToStr( iLineas ) + '#';
end;
function TDMDesadvCorteIngles.GetEAN:string;
begin
  //EAN#Código EAN-13 del artículo.
  with qryAuxCentral do
  begin
    SQL.Clear;
    SQL.Add('select ean13_ee from frf_ean13_edi ');
    SQL.Add('where empresa_ee = :empresa ');
    SQL.Add('and cliente_fac_ee = :cliente ');
    SQL.Add('and envase_ee = :envase ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('cliente').AsString:= qryCabOrden.FieldByName('cliente').AsString;
    ParamByName('envase').AsString:= qryPacking.FieldByName('envase_pl').AsString;
    Open;
    result:= FieldByName('ean13_ee').AsString + '#';
    Close;
  end;
  //result:= qryPacking.FieldByName('ean13_pl').AsString + '#';
  //result:= '8436534683006#';
end;
function TDMDesadvCorteIngles.GetNUMEXP:string;
begin
  //NUMEXP#Número de Unidad de Expedición. ¿¿¿DUN14??? El Corte Ingles Gran consumo
  with qryAuxCentral do
  begin
    SQL.Clear;
    SQL.Add('select dun14_ee from frf_ean13_edi ');
    SQL.Add('where empresa_ee = :empresa ');
    SQL.Add('and cliente_fac_ee = :cliente ');
    SQL.Add('and envase_ee = :envase ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('cliente').AsString:= qryCabOrden.FieldByName('cliente').AsString;
    ParamByName('envase').AsString:= qryPacking.FieldByName('envase_pl').AsString;
    Open;
    result:= FieldByName('dun14_ee').AsString + '#';
    Close;
  end;
end;

function TDMDesadvCorteIngles.GetNUMLINPED:string;
var  iPosIni, iPosFin: smallint;
     sLinea: String;
begin
  FQLineasPedido.First;
  while not FQLineasPedido.Eof do
  begin
    iPosIni := 0;
    iPosFin := 0;
    if FQLineasPedido.FieldByName('ean13_ee').AsString = copy( sEANArticulo, 1, Length(sEANArticulo)-1) then
    begin
      iPosIni := Pos('[', FQLineasPedido.FieldByName('observaciones_lp').AsString);
      iPosFin := Pos(']', FQLineasPedido.FieldByName('observaciones_lp').AsString);
      if (iPosIni <> 0) and (iPosFin <> 0)  then
      begin
        sLinea := Copy( FQLineasPedido.FieldByName('observaciones_lp').AsString, iPosIni + 1, iPosFin - (iPosIni+1));
        result := sLinea;
        exit;
      end;
    end;

    FQLineasPedido.Next;
  end;
end;

function TDMDesadvCorteIngles.GetDESCRIP:string;
var sDescripcion: string;
begin
  //DESCRIP#Descripción en formato libre del producto.
  with qryAuxCentral do
  begin
    SQL.Clear;
    SQL.Add('select descripcion_ee from frf_ean13_edi ');
    SQL.Add('where empresa_ee = :empresa ');
    SQL.Add('and cliente_fac_ee = :cliente ');
    SQL.Add('and envase_ee = :envase ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('cliente').AsString:= qryCabOrden.FieldByName('cliente').AsString;
    ParamByName('envase').AsString:= qryPacking.FieldByName('envase_pl').AsString;
    Open;
    sDescripcion:= FieldByName('descripcion_ee').AsString;
    Close;
  end;
  if sDescripcion <> '' then
    result := sDescripcion + '#'
  else
    result:= qryPacking.FieldByName('descripcion_e').AsString + '#';
end;
function TDMDesadvCorteIngles.GetTIPART:string;
begin
  //TIPART#Descripción del artículo codificada. ¿DU = Unidad de expedición?
  result:= 'CU#';
(*
CU = Unidad de consumo
DU = Unidad de expedición
TU= Unidad Comerciada.
VQ = Producto de medida variable
*)
end;
function TDMDesadvCorteIngles.GetCENVFAC:string;
var
  rCENVFAC: real;
begin
  //CENVFAC# Cantidad enviada total. En caso de productos de PESO VARIABLE, indicar el total de KGS servidos.
  //if qryPacking.FieldByName('peso_variable_e').
  if qryCabOrden.FieldByName('cliente').AsString = 'SOK' then
  begin
    if qryPacking.FieldByName('peso_variable_e').AsInteger = 1 then
      rCENVFAC := qryPacking.FieldByName('peso_pl').AsFloat
    else if qryPacking.FieldByName('unidades_e').AsInteger > 1 then
      rCENVFAC :=  qryPacking.FieldByName('unidades_e').AsInteger * qryPacking.FieldByName('cajas_pl').AsInteger
    else
       rCENVFAC:= qryPacking.FieldByName('cajas_pl').AsInteger * qryPacking.FieldByName('peso_neto_e').AsFloat;
  end
  else
  begin
    if qryPacking.FieldByName('unidades_e').AsInteger > 0 then
      rCENVFAC:= qryPacking.FieldByName('unidades_e').AsInteger * qryPacking.FieldByName('cajas_pl').AsInteger
    else
      rCENVFAC:= qryPacking.FieldByName('cajas_pl').AsInteger;
  end;

  result:= FormatFloat('#',rCENVFAC) + '#';
  rTOTQTY:= rTOTQTY + rCENVFAC;
end;

function TDMDesadvCorteIngles.GetCUEXP:string;
begin
  //CUEXP#Número de Unidades de consumo en unidad de expedición.
  if qryPacking.FieldByName('unidades_e').AsInteger > 0 then
    result:= qryPacking.FieldByName('unidades_e').AsString + '#'
  else
    result:= '#';
end;
function TDMDesadvCorteIngles.GetPESTOTBRULIN:string;
var
  rPesoAux: Real;
begin
  //PESTOTBRULIN#Peso Total Bruto de la Línea
  if qryPacking.FieldByName('peso_pl').AsFloat <> 0 then
  begin
    rPesoAux:= qryPacking.FieldByName('peso_pl').AsFloat;
  end
  else
  begin
    rPesoAux:= ( qryPacking.FieldByName('cajas_pl').AsInteger *
                          qryPacking.FieldByName('peso_neto_e').AsFloat );
  end;

  //TARA
  rPesoAux:= rPesoAux + ( qryPacking.FieldByName('cajas_pl').AsInteger *
                          qryPacking.FieldByName('peso_envase_e').AsFloat );

  result:= FormatFloat('#.###', rPesoAux ) +'#';
end;

procedure TDMDesadvCorteIngles.InicializarTotales;
begin
  iPalets:= 0;
  iCajas:= 0;
  iUnidades:= 0;
  rNeto:= 0;
  rTara:= 0;

  iCajasPalet:= 0;
  rNetoPalet:= 0;
  rTaraPalet:= 0;

  rTOTQTY:= 0;
end;

procedure TDMDesadvCorteIngles.InicializarTotalesPalet;
begin
  iCajasPalet:= 0;
  rNetoPalet:= 0;
  rTaraPalet:= 0;
end;


procedure TDMDesadvCorteIngles.AnyadirTotales;
var
  rNetoAux: Real;
begin

    //CAJAS
    iCajas:= iCajas + qryPacking.FieldByName('cajas_pl').AsInteger;
    iCajasPalet:= iCajasPalet + qryPacking.FieldByName('cajas_pl').AsInteger;

    //UNIDADES
    if qryPacking.FieldByName('unidades_variable_e').AsInteger = 0 then
    begin
      iUnidades:= iUnidades + ( qryPacking.FieldByName('cajas_pl').AsInteger *
                                qryPacking.FieldByName('unidades_e').AsInteger );
    end
    else
    begin
      (*TODO*)
      //De donde saco las unidades variables
      iUnidades:= iUnidades + ( qryPacking.FieldByName('cajas_pl').AsInteger *
                                qryPacking.FieldByName('unidades_e').AsInteger );
    end;

    //NETO
    if qryPacking.FieldByName('peso_pl').AsFloat <> 0 then
    begin
      rNetoAux:= qryPacking.FieldByName('peso_pl').AsFloat;
    end
    else
    begin
      if qryPacking.FieldByName('peso_variable_e').AsInteger = 0 then
      begin
        rNetoAux:= ( qryPacking.FieldByName('cajas_pl').AsInteger *
                          qryPacking.FieldByName('peso_neto_e').AsFloat );
      end
      else
      begin
        (*TODO*)
        //De donde saco el peso variable
        rNetoAux:= ( qryPacking.FieldByName('cajas_pl').AsInteger *
                          qryPacking.FieldByName('peso_neto_e').AsFloat );
      end;
    end;

    rNeto:= rNeto + rNetoAux;
    rNetoPalet:= rNetoPalet + rNetoAux;

    //TARA
    rTara:= rTara + ( qryPacking.FieldByName('cajas_pl').AsInteger *
                      qryPacking.FieldByName('peso_envase_e').AsFloat );
    rTaraPalet:= rTaraPalet + ( qryPacking.FieldByName('cajas_pl').AsInteger *
                      qryPacking.FieldByName('peso_envase_e').AsFloat );
end;


end.
