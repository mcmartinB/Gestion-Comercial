unit DesadvAhorramasDM;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable;

type
  TDMDesadvAhorramas = class(TDataModule)
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
    iAlbaran: integer;
    dFecha: TDateTime;
    sMsg: string;
    iContador, iOrden: Integer;

    sEanBonnysa, sEanEmisor, sEanReceptor, sDepartamento: string;

    //Lineas
    iEmbalajes, iLineas: Integer;

    //ficheros texto
    slCab, slEmb, slEmbAux, slLin: TStringList;

    //Totalizar
    iPalets, iCajas, iUnidades: Integer;
    rNeto, rTara: Real;
    rTOTQTY: Real;
    sEan128, sLote: string;
    dCaducidad: TDateTime;
    iCajasPalet: Integer;
    rNetoPalet, rTaraPalet: Real;

    //Directorio donde grabar la salida
    sDirSalida: string;

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
    function GetFECENVIO:string;
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
    function GetLote:string;
    function GetTIPO2:string;
    function GetTCAJAS:string;
    function GetFECCAD:string;
    function GetPESOBRUTO:string;
    function GetPESONETO:string;
    function GetPORIGEN:string;
    function GetIMPNETOLIN:string;

    function GetIDLIN:string;
    function GetEAN:string;
    function GetNUMEXP:string;
    function GetDESCRIP:string;
    function GetTIPART:string;
    function GetCENVFAC:string;
    function GetCUEXP:string;
    function GetPESTOTBRULIN:string;

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
  Controls, bTextUtils, bMath;

var
  DMDesadvAhorramas: TDMDesadvAhorramas;


function CrearFicherosDesadv( const AOwner: TComponent;
                              const AEmpresa, ACentro: string;
                              const AAlbaran: integer;
                              const AFecha: TDateTime;
                              const ACliente, ASuministro: string;
                              var VMsg: string ): Boolean;
begin
  DMDesadvAhorramas:= TDMDesadvAhorramas.Create( AOwner );
  try
    result:= DMDesadvAhorramas.CrearFicherosDesadv( AEmpresa, ACentro, AAlbaran, AFecha, ACliente, ASuministro, VMsg );
  finally
    FreeAndNil( DMDesadvAhorramas );
  end;
end;

function TDMDesadvAhorramas.CrearFicherosDesadv( const AEmpresa, ACentro: string;
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

procedure TDMDesadvAhorramas.DataModuleCreate(Sender: TObject);
begin
  sDirSalida:= 'C:\ASPEDI\PRODUCCION\SALIDA';

  //DATOS DE lA CENTRAL
  with qryCentral do
  begin
    sql.clear;
    sql.Add(' select quienpide_ce, quienrecibe_ce  ');
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
    sql.Add(' select ean128_pl, tipo_palet_pl, descripcion_tp, producto_pl, producto_base_pl, ');
    sql.Add('        ean13_pl, envase_pl, cajas_pl, peso_pl, ');  //peso_pl es bruto o neto
    sql.Add('        descripcion_e, ean13_e, peso_envase_e, peso_neto_e, peso_variable_e, ');
    sql.Add('        unidades_e, unidades_variable_e, tipo_unidad_e, lote, caducidad, ');
    sql.Add('        pais_pl, kilos_tp                                                ');
    sql.Add(' from frf_packing_list   join rf_palet_pc_det on ean128_pl = ean128_det ');
    sql.Add('                         left join frf_envases on envase_e = envase_pl ');
    sql.Add('                                             and producto_e = producto_pl ');
    sql.Add('                         left join frf_tipo_palets on codigo_tp = tipo_palet_pl ');
    sql.Add(' where orden_pl = :orden ');
    sql.Add(' order by ean128_pl, ean13_pl ');
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

procedure TDMDesadvAhorramas.CerrarTablas;
begin
  qryPacking.Close;
  qryCabOrden.Close;
  FreeAndNil(slCab);
  FreeAndNil(slEmb);
  FreeAndNil(slEmbAux);
  FreeAndNil(slLin);
end;

procedure TDMDesadvAhorramas.DataModuleDestroy(Sender: TObject);
begin
  //
end;

(*
select  *
from edi_desadv_cab
where empresa_edc = 'F18' and centro_salida_edc = '1' and fecha_edc = '14/4/2014' and n_albaran_edc = 26563
*)

function TDMDesadvAhorramas.GetContador;
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


procedure TDMDesadvAhorramas.IncContador;
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

procedure TDMDesadvAhorramas.AltaContador;
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

procedure TDMDesadvAhorramas.ModifContador;
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

function  TDMDesadvAhorramas.CabOrden: Boolean;
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

procedure  TDMDesadvAhorramas.PackingOrden;
begin
  with qryPacking do
  begin
    ParamByName('orden').AsInteger:= iOrden;
    Open;
  end;
end;

procedure TDMDesadvAhorramas.Deseados( const ANivel, ACodigo, ADescripcion: string; const AUnidades: Integer );
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

procedure TDMDesadvAhorramas.Cargados( const ANivel, ACodigo, ADescripcion: string; const AUnidades: Integer);
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

function TDMDesadvAhorramas.CargadosOK: Boolean;
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
function  TDMDesadvAhorramas.ValidadPacking: Boolean;
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

function  TDMDesadvAhorramas.GetNumOrden: integer;
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

function  TDMDesadvAhorramas.ObtenerDatos: boolean;
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
    sMsg:= 'No hay datos de carga para el albar�n seleccionado.';
  end;
end;

function  TDMDesadvAhorramas.CrearFicheros: Boolean;
begin
  InicializarTotales;

  EanBonnysa;
  EanCliente;

  qryPacking.First;
  sEan128:= qryPacking.fieldByName('ean128_pl').AsString;
  sLote:= qryPacking.fieldByName('lote').AsString;
  dCaducidad:= qryPacking.fieldByName('caducidad').AsDateTime;
  iEmbalajes:= 2;
  iLineas:= 1;

  while not qryPacking.Eof do
  begin
    AnyadirTotales;

    GrabarLineas;
    iLineas:= iLineas + 1;
    qryPacking.Next;
    sLote:= qryPacking.fieldByName('lote').AsString;
    dCaducidad:= qryPacking.fieldByName('caducidad').AsDateTime;
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

function TDMDesadvAhorramas.GuardarFicherosEnDisco: Boolean;
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
                     '�Seguro que desea continuar?',mtWarning, [mbYes, mbNo], 0	) = mrYes;

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
      sMsg:= 'Ya existen ficheros en el destino, s�balos a EDI antes de continuar.';
    end;
  end;
end;

procedure TDMDesadvAhorramas.GrabarCabecera;
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
  sAux:= sAux + getTOTQTY; //Ahorramas peso variable cajas
  sAux:= sAux + getIDENTIF;
  sAux:= sAux + '#';
  sAux:= sAux + getCIP;
  sAux:= sAux + getFECENVIO;
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
  sAux:= sAux + '#'; //getPESBRUTOT;
  sAux:= sAux + '#'; //getPESNETTOT;
  sAux:= sAux + getNUMTOTBUL; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#

  slCab.Add( sAux );
end;

procedure TDMDesadvAhorramas.GrabarEmbalajes;
var
  sAux: string;
begin
  //
  sAux:= getIDCAB;
  sAux:= sAux + getIDEMB;
  sAux:= sAux + getCPS;
  sAux:= sAux + getCPSPADRE;
  sAux:= sAux + getCANTEMB;
  sAux:= sAux + '#'; //TIPCOD
  sAux:= sAux + '#'; //COSEMB
  sAux:= sAux + getTIPEMB;
  sAux:= sAux + '#'; //# DESCEMB
  sAux:= sAux + '#'; //# PAGRET
  sAux:= sAux + '#'; //getPESON;
  sAux:= sAux + '#';//getPESOB;
  sAux:= sAux + '#'; //getPESONU;
  sAux:= sAux + '#'; //getPESOBU;
  sAux:= sAux + '#';//getUNIPESO;
  sAux:= sAux + '#'; //# ALTURA
  sAux:= sAux + '#'; //# LONGITUD
  sAux:= sAux + '#'; //# ANCHURA
  sAux:= sAux + '#'; //# UNIMED
  sAux:= sAux + '#'; //# CANCONSI
  sAux:= sAux + '#'; //# MANIPUL
  sAux:= sAux + '#'; //# DESCMANI
  sAux:= sAux + getSSCC1;
  sAux:= sAux + '#'; //# SSCC2
  sAux:= sAux + '#'; //# SSCC3
  sAux:= sAux + '#'; //# SSCC4
  sAux:= sAux + '#'; //# SSCC5
  sAux:= sAux + '#';
  sAux:= sAux + getTIPO2;
  sAux:= sAux + getTCAJAS;
  sAux:= sAux + '#'; //#  DESDIF
  sAux:= sAux + '#'; //#  FECMAT
  sAux:= sAux + '#';//GetFECCAD; //'#';
  sAux:= sAux + '#';//GetFECCAD; //'#'; FECCON
  sAux:= sAux + '#'; //#  VOLUMEN
  sAux:= sAux + '#'; //#  BULTFORMATO
  sAux:= sAux + '#'; //#  BULTPALET
  sAux:= sAux + '#'; //#  FORMATO
  sAux:= sAux + '#'; //#  NUMFORMATO
  sAux:= sAux + '#'; //#  NUMCAPAS

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

procedure TDMDesadvAhorramas.GrabarLineas;
var
  sAux: string;
begin
  //
  sAux:= getIDCAB;
  sAux:= sAux + getIDEMB;
  sAux:= sAux + getIDLIN;
  sAux:= sAux + getEAN; //DUN14 peso variable
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //getNUMEXP; //PESO VAR VACIO//DUN14 peso FIJO
  sAux:= sAux + getDESCRIP;
  sAux:= sAux + getTIPART;
  sAux:= sAux + getCENVFAC;
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + getCUEXP;
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + getNUMPED; //# getNUMPED
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + GetFECCAD; //#
  sAux:= sAux + GetLote; //'#';
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
  sAux:= sAux + getPESON; //'#';
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //GetFECCAD; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + getPORIGEN; //# getPORIGEN
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + GetPESOBRUTO; //GetPESOBRUTO
  sAux:= sAux + GetPESONETO; //GetPESONETO;
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
  sAux:= sAux + '#'; //getPESTOTBRULIN;
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //# ISBN
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + '#'; //#
  sAux:= sAux + getIMPNETOLIN; //# IMPNETOLIN


  slLin.Add( sAux );
end;

procedure TDMDesadvAhorramas.EanBonnysa;
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

procedure TDMDesadvAhorramas.EanCliente;
begin
  DMBaseDatos.BDCentral.Open;
  try
    qryCentral.ParamByName('empresa').AsString:= sEmpresa;
    qryCentral.ParamByName('cliente').AsString:= sCliente;
    qryCentral.ParamByName('suministro').AsString:= sSuministro;
    qryCentral.Open;
    sEanEmisor:=   qryCentral.FieldByName('quienpide_ce').AsString;
    sEanReceptor:= qryCentral.FieldByName('quienrecibe_ce').AsString;
  finally
    qryCentral.Close;
    DMBaseDatos.BDCentral.Close;
  end;
  sDepartamento:= '';
end;

function TDMDesadvAhorramas.GetIDCAB:string;
begin
  //IDCAB#Clave del registro de cabeceras
  result:= IntToStr(iContador) + '#';
end;
function TDMDesadvAhorramas.GetNUMDES:string;
begin
  //NUMDES#N�mero de Aviso de Expedici�n
  (*TODO*)  //Que es el aviso de expedicion
  result:= sEmpresa + FormatDateTime( 'yy', dFecha ) + '-' + IntToStr( iAlbaran )+ '#';
  //result := sEmpresa + sCentro + Rellena( IntToStr( iAlbaran ), 5, '0', taLeftJustify ) + Coletilla( sEmpresa ) + '#';
end;
function TDMDesadvAhorramas.GetTIPO:string;
begin
  //TIPO#351
  result:= '351#';
end;
function TDMDesadvAhorramas.GetFUNCION:string;
begin
  //FUNCION#9
  result:= '9#';
end;
function TDMDesadvAhorramas.GetFECDES:string;
begin
  //FECDES#Fecha o Fecha/Hora del Aviso de Expedici�n --> AAAAMMDDHHmm
  result:= FormatDateTime('yyyymmdd',dFecha) + '#';
end;
function TDMDesadvAhorramas.GetFECENT:string;
begin
  //FECENT#Fecha o Fecha/Hora del Aviso de Entrega --> AAAAMMDDHHmm (Optativo)
  result:= FormatDateTime('yyyymmdd',dFecha) + '#';
end;
function TDMDesadvAhorramas.GetFECENVIO: string;
begin
  //FECENVIO - Fecha albaran
  if sCliente = 'MER' then
    result:= FormatDateTime('yyyymmdd',dFecha) + '#'
  else
    result := '#';
  
end;

function TDMDesadvAhorramas.GetNUMALB:string;
begin
  //NUMALB#N�mero de Albar�n
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

function TDMDesadvAhorramas.getFECALB:string;
begin
  //FECALB#Fecha del Albar�n
  result:= FormatDateTime('yyyymmdd',dFecha) + '#';
end;
function TDMDesadvAhorramas.GetNUMPED:string;
begin
  //NUMPED#N�mero de pedido
  //Sacar del albaran
  result:= qryCabOrden.FieldByName('n_pedido').AsString + '#';
end;
function TDMDesadvAhorramas.GetFECPED:string;
begin
  //FECPED#Fecha de Pedido (Optativo)
  result:= '#';
end;
function TDMDesadvAhorramas.GetORIGEN:string;
begin
  //ORIGEN#C�digo EAN-13 origen del mensaje. (BONNYSA)
  result:= sEanBonnysa + '#';
end;
function TDMDesadvAhorramas.GetDESTINO:string;
begin
  //DESTINO#C�digo EAN-13 destino del mensaje.
  result:= sEanEmisor + '#';
end;
function TDMDesadvAhorramas.GetPROVEEDOR:string;
begin
  //PROVEEDOR#C�digo EAN-13 del proveedor de las mercanc�as. (BONNYSA)
  result:= sEanBonnysa + '#';
end;
function TDMDesadvAhorramas.GetCOMPRADOR:string;
begin
  //COMPRADOR#C�digo EAN-13 del comprador
  result:= sEanReceptor + '#';
end;
function TDMDesadvAhorramas.GetDPTO:string;
begin
  //DPTO#C�digo del departamento que pide la mercanc�a. (OBLIGATORIO CORTE INGLES)
  //result:= qryCabOrden.FieldByName('departamneto').AsString + '#';
  result:= sDepartamento + '#';
end;
function TDMDesadvAhorramas.GetRECEPTOR:string;
begin
  //RECEPTOR#C�digo EAN-13 del receptor de la entrega
  result:= sEanReceptor + '#';
end;
function TDMDesadvAhorramas.GetEXPEDIDOR:string;
begin
  //EXPEDIDOR#C�digo EAN-13 del expedidor (Optativo --> Bonnysa)
  result:= sEanBonnysa + '#';
end;
function TDMDesadvAhorramas.GetTOTQTY:string;
begin
  //TOTQTY#Sumatorio de las cantidades indicadas los campo CENVFAC al nivel de l�nea.
  result:= FormatFloat( '#.###', rTOTQTY  ) + '#';
  result:= StringReplace( result, ',', '.', [rfReplaceAll]);
end;
function TDMDesadvAhorramas.GetIDENTIF:string;
begin
  //IDENTIF#X6 -> Indica si el palet viene identificado por un SSCC o matricula (Obligatorio Corte Ingles)
  result:= 'X6#';
end;
function TDMDesadvAhorramas.GetCIP:string;
begin
  //CIP#C�digo Interno de Proveedor (solo Alcampo)
  //result:= '112979#';
  result:='#';
end;
function TDMDesadvAhorramas.GetPESBRUTOT:string;
begin
  //PESBRUTOT#Peso Bruto Total del Env�o(Opativo -> Obligatorio Corte ingles perecederos)
  result:= FormatFloat( '#.###', rTara + rNeto ) + '#';
  result:= StringReplace( result, ',', '.', [rfReplaceAll]);
end;
function TDMDesadvAhorramas.GetPESNETTOT:string;
begin
  //PESNETTOT#Peso Neto Total del Env�o(Opativo -> Obligatorio Corte ingles perecederos)
  result:= FormatFloat( '#.###', rNeto ) + '#';
  result:= StringReplace( result, ',', '.', [rfReplaceAll]);
end;
function TDMDesadvAhorramas.GetNUMTOTBUL:string;
begin
  //NUMTOTBUL#N�mero Total de Bultos (Opativo -> Obligatorio Corte ingles perecederos)
  if sCliente = 'MER' then
    result:= IntToStr( iCajas ) + '#'
  else
    result:= '#';
end;

function TDMDesadvAhorramas.GetIDEMB:string;
begin
  //IDEMB#Idenificador de embalajes.
  result:= IntToStr( iEmbalajes ) + '#';
end;
function TDMDesadvAhorramas.GetCPS:string;
begin
  //CPS#32 N�mero de identificaci�n en la jerarqu�a de niveles de empaquetamiento. (secuencial)
  result:= IntToStr( iEmbalajes ) + '#';
end;
function TDMDesadvAhorramas.GetCPSPADRE:string;
begin
  //CPSPADRE#Nivel jer�rquico del que depende el nivel actual.
  if iEmbalajes = 1 then
    result:= '#'
  else
    result:= '1#';
end;
function TDMDesadvAhorramas.GetCANTEMB:string;
begin
  //CANTEMB#N�mero de paquetes dentro de esta unidad de embalaje.
  if iEmbalajes = 1 then
    result:= IntToStr( iPalets ) + '#'
  else
    result:= '1#'; //un palet
end;
function TDMDesadvAhorramas.GetTIPEMB:string;
begin
  //TIPEMB#Tipo de embalaje. (201 = Palet ISO 1 (80 x 120 cm.))
  result:= '201#';
end;
function TDMDesadvAhorramas.GetPESON:string;
begin
  //PESON#Peso Neto Total -> Corte Ingles para Peso variable
  if iEmbalajes > 1 then
    result:= FormatFloat( '#,##0.00', rNetoPalet ) + '#'
  else
    result:= '#';
//  result:= StringReplace( result, ',', '.', [rfReplaceAll]);
end;
function TDMDesadvAhorramas.GetPESOB:string;
begin
  //PESOB#Peso Bruto Total. -> Corte Ingles para Peso variable
  (*
  if iEmbalajes > 1 then
    result:= FormatFloat( '##.#', rBrutoPalet ) + '#'
  else
  *)
    result:= '#';
  result:= StringReplace( result, ',', '.', [rfReplaceAll]);
end;
function TDMDesadvAhorramas.GetPESONU:string;
begin
  //PESONU#Peso Neto Unitario. -> Corte Ingles para Peso variable
  result:= '#';
end;
function TDMDesadvAhorramas.GetPESOBU:string;
begin
  //PESOBU#Peso Bruto Unitario. -> Corte Ingles para Peso variable
  result:= '#';
end;
function TDMDesadvAhorramas.GetPESOBRUTO:string;
var
  rPesoAux: Real;
begin
  if sCliente = 'MER' then
  begin
    //PESOTBRUTO#Peso Total Bruto de la L�nea
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
                            qryPacking.FieldByName('peso_envase_e').AsFloat )
                        + ( qryPacking.FieldByName('kilos_tp').AsFloat );

    result:= FormatFloat('#,##0.00', rPesoAux ) +'#';
  end
  else
    result:= '#';
end;
function TDMDesadvAhorramas.GetPESONETO:string;
var
  rPesoAux: Real;
begin
  if sCliente = 'MER' then
  begin
    //PESONETO#Peso Neto de la L�nea
    if qryPacking.FieldByName('peso_pl').AsFloat <> 0 then
    begin
      rPesoAux:= qryPacking.FieldByName('peso_pl').AsFloat;
    end
    else
    begin
      rPesoAux:= ( qryPacking.FieldByName('cajas_pl').AsInteger *
                            qryPacking.FieldByName('peso_neto_e').AsFloat );
    end;

    result:= FormatFloat('#,##0.00', rPesoAux ) +'#';
  end
  else
    result:= '#';
end;
function TDMDesadvAhorramas.GetPORIGEN: string;
begin
  if sCliente = 'MER' then
  begin
    result :=  qryPacking.FieldByName('pais_pl').AsString + '#'
  end
  else
    result:= '#';
end;
function TDMDesadvAhorramas.GetIMPNETOLIN:string;
var rPrecio, rAux: real;
    sUnidadFact: String;
begin

    if sCliente = 'MER' then
    begin
      with qryAux do
      begin
        sql.clear;
        sql.Add(' select  precio_sl, unidad_precio_sl');
        sql.Add(' from frf_salidas_l ');
        sql.Add(' where empresa_sl = :empresa ');
        sql.Add('   and centro_salida_sl = :centro ');
        sql.Add('   and n_albaran_sl = :albaran ');
        sql.Add('   and fecha_sl = :fecha ');
        sql.Add('   and envase_sl = :envase ');

        ParamByName('empresa').AsString:= sEmpresa;
        ParamByName('centro').AsString:= sCentro;
        ParamByName('albaran').AsInteger:= iAlbaran;
        ParamByName('fecha').AsDateTime:= dFecha;
        ParamByName('envase').AsString:= qryPacking.FieldByName('envase_pl').AsString;
        Open;
        if not IsEmpty then
        begin
          rPrecio:= FieldByName('precio_sl').AsFloat;
          sUnidadFact := FieldByName('unidad_precio_sl').AsString;
        end
        else
        begin
          rPrecio:= 0;
          sUnidadFact := 'KGS';
        end;
        Close;
      end;

      if sUnidadFact = 'UND' then
      begin
        rAux := qryPacking.FieldByName('cajas_pl').AsInteger * qryPacking.FieldByName('unidades_e').AsInteger;
      end
      else if sUnidadFact = 'CAJ' then
      begin
        rAux := qryPacking.FieldByName('cajas_pl').AsInteger;
      end
      else
      //if FieldByName('unidad_precio_sl').AsSting = 'KGS' then
      begin
        rAux := qryPacking.FieldByName('peso_pl').AsFloat;
      end;

      rAux := bRoundTo(rAux * rPrecio, -2);
      result := FormatFloat('#,##0.00', rAux ) + '#';
    end
    else
      result:= '#';
end;
function TDMDesadvAhorramas.GetUNIPESO:string;
begin
  //UNIPESO#KGMUnidad de Medida de Pesos
  result:= 'KGM#';
end;
function TDMDesadvAhorramas.GetSSCC1:string;
begin
  //SSCC1#SSCC de la Unidad de Expedici�n descrita 1. Para ECI (gran consumo) es obligatorio a nivel de PALET
  if iEmbalajes > 1 then
    result:= Copy( sEan128, 3, 18 ) + '#'
  else
    result:= '#';
end;

function TDMDesadvAhorramas.GetLote:string;
begin
  //SSCC1#SSCC de la Unidad de Expedici�n descrita 1. Para ECI (gran consumo) es obligatorio a nivel de PALET
  if iEmbalajes > 1 then
    result:= sLote + '#'
  else
    result:= '#';
end;

function TDMDesadvAhorramas.GetTIPO2:string;
begin
  //TIPO2#Tipo de embalaje contenido (�nicamente cuando estamos a nivel de PALET)
  if iEmbalajes > 1 then
    result:= 'CT#'
  else
    result:= '#';
(*
CT = Caja de cart�n
CS = Caja r�gida
PK = Paquete / Embalaje
SL = Placa de pl�stico (Hoja de Embalaje)
SW = Retractilado
RO = Rollo
*)
end;
function TDMDesadvAhorramas.GetTCAJAS:string;
begin
  //TCAJAS#N�mero total de cajas contenidas (�nicamente cuando estamos a nivel de PALET)
  if iEmbalajes > 1 then
    result:= IntToStr( iCajasPalet) + '#'
  else
    result:= '#';
end;

function TDMDesadvAhorramas.GetFECCAD:string;
begin
  //FECDES#Fecha o Fecha/Hora del Aviso de Expedici�n --> AAAAMMDDHHmm
  result:= FormatDateTime('yyyymmdd',dCaducidad) + '#';
end;

function TDMDesadvAhorramas.GetIDLIN:string;
begin
  //IDLIN#Identificaci�n de l�nea de albar�n.
  result:= intToStr( iLineas ) + '#';
end;
function TDMDesadvAhorramas.GetEAN:string;
begin
  //si peso variable coger dun14
  //EAN#C�digo EAN-13 del art�culo.
  with qryAuxCentral do
  begin
    SQL.Clear;
    SQL.Add('select ean13_ee, dun14_ee from frf_ean13_edi ');
    SQL.Add('where empresa_ee = :empresa ');
    SQL.Add('and cliente_fac_ee = :cliente ');
    SQL.Add('and envase_ee = :envase ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('cliente').AsString:= qryCabOrden.FieldByName('cliente').AsString;
    ParamByName('envase').AsString:= qryPacking.FieldByName('envase_pl').AsString;
    Open;
    //result:= FieldByName('ean13_ee').AsString + '#';
    if sCliente = 'MER' then
      result:= FieldByName('ean13_ee').AsString + '#'
    else
      result:= FieldByName('dun14_ee').AsString + '#';

    Close;
  end;
  //result:= qryPacking.FieldByName('ean13_pl').AsString + '#';
  //result:= '8436534683006#';
end;
function TDMDesadvAhorramas.GetNUMEXP:string;
begin
  //si peso variable coger ean13
  //NUMEXP#N�mero de Unidad de Expedici�n. ���DUN14??? El Corte Ingles Gran consumo
  with qryAuxCentral do
  begin
    SQL.Clear;
    SQL.Add('select ean13_ee, dun14_ee from frf_ean13_edi ');
    SQL.Add('where empresa_ee = :empresa ');
    SQL.Add('and cliente_fac_ee = :cliente ');
    SQL.Add('and envase_ee = :envase ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('cliente').AsString:= qryCabOrden.FieldByName('cliente').AsString;
    ParamByName('envase').AsString:= qryPacking.FieldByName('envase_pl').AsString;
    Open;
    //result:= FieldByName('dun14_ee').AsString + '#';
    result:= FieldByName('ean13_ee').AsString + '#';
    Close;
  end;
end;
function TDMDesadvAhorramas.GetDESCRIP:string;
begin
  //DESCRIP#Descripci�n en formato libre del producto.
  result:= qryPacking.FieldByName('descripcion_e').AsString + '#';
end;
function TDMDesadvAhorramas.GetTIPART:string;
begin
  //TIPART#Descripci�n del art�culo codificada. �DU = Unidad de expedici�n?
  //Peso variable DU
  //result:= 'CU#';
  result:= 'DU#';
(*
CU = Unidad de consumo
DU = Unidad de expedici�n
TU= Unidad Comerciada.
VQ = Producto de medida variable
*)
end;
function TDMDesadvAhorramas.GetCENVFAC:string;
var
  rCENVFAC: real;
begin
  //CENVFAC# Cantidad enviada total. En caso de productos de PESO VARIABLE, indicar el total de KGS servidos.
  //if qryPacking.FieldByName('peso_variable_e').

  //si es peso variable, cajas para ahorramas
  //if qryPacking.FieldByName('unidades_e').AsInteger > 0 then
  //  rCENVFAC:= qryPacking.FieldByName('unidades_e').AsInteger * qryPacking.FieldByName('cajas_pl').AsInteger
  //else
  //  rCENVFAC:= qryPacking.FieldByName('cajas_pl').AsInteger;


  //Si piden unidades (agrupacion = 1) devolver unidades, sino cajas
  with qryAuxCentral do
  begin
    SQL.Clear;
    SQL.Add('select nvl(agrupacion_e,2) agrupacion ');
    SQL.Add('from frf_ean13_edi ');
    SQL.Add('     join frf_ean13 on empresa_ee = empresa_e and ean13_ee = codigo_e ');
    SQL.Add('where empresa_ee = :empresa ');
    SQL.Add('and cliente_fac_ee = :cliente ');
    SQL.Add('and envase_ee = :envase ');
    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('cliente').AsString:= qryCabOrden.FieldByName('cliente').AsString;
    ParamByName('envase').AsString:= qryPacking.FieldByName('envase_pl').AsString;
    Open;
    if sCliente = 'MER' then
    begin
      if qryPacking.FieldByName('unidades_e').AsInteger <> 0 then
        rCENVFAC:= qryPacking.FieldByName('cajas_pl').AsInteger * qryPacking.FieldByName('unidades_e').AsInteger
      else
        rCENVFAC:= qryPacking.FieldByName('cajas_pl').AsInteger;
    end
    else
    begin
      if FieldByName('agrupacion').AsInteger = 1 then
      begin
        if qryPacking.FieldByName('unidades_e').AsInteger <> 0 then
          rCENVFAC:= qryPacking.FieldByName('cajas_pl').AsInteger * qryPacking.FieldByName('unidades_e').AsInteger
        else
          rCENVFAC:= qryPacking.FieldByName('cajas_pl').AsInteger;
      end
      else
        rCENVFAC:= qryPacking.FieldByName('cajas_pl').AsInteger;
    end;
    Close;
  end;



  result:= FormatFloat('#',rCENVFAC) + '#';
  rTOTQTY:= rTOTQTY + rCENVFAC;
  result:= StringReplace( result, ',', '.', [rfReplaceAll]);
end;
function TDMDesadvAhorramas.GetCUEXP:string;
begin
  //CUEXP#N�mero de Unidades de consumo en unidad de expedici�n.
  if qryPacking.FieldByName('unidades_e').AsInteger > 0 then
    result:= qryPacking.FieldByName('unidades_e').AsString + '#'
  else
    result:= '#';
end;
function TDMDesadvAhorramas.GetPESTOTBRULIN:string;
var
  rPesoAux: Real;
begin
  //PESTOTBRULIN#Peso Total Bruto de la L�nea
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
  result:= StringReplace( result, ',', '.', [rfReplaceAll]);
end;

procedure TDMDesadvAhorramas.InicializarTotales;
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

procedure TDMDesadvAhorramas.InicializarTotalesPalet;
begin
  iCajasPalet:= 0;
  rNetoPalet:= 0;
  rTaraPalet:= 0;
end;


procedure TDMDesadvAhorramas.AnyadirTotales;
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
