unit WEBDM;

interface

uses
  SysUtils, Classes, DB, DBTables, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdFTP, Dialogs;

const
  kHost = '82.223.187.28';
  kUser = 'root';
  kPass = 'Madr1d2016';
  kRemoteDir = '/usr/tomcat/jakarta-tomcat-5.0.28/webapps/bonnysa/fotos/';
  kLocalDir = '\\192.168.1.93\Comercializacion\Clientes\Reclamaciones\';

type
  TDMWEB = class(TDataModule)
    BDWEB: TDatabase;
    QNumReclamacionesRemoto: TQuery;
    QReclamacionesRemoto: TQuery;
    QClientesWEBLocal: TQuery;
    QClientesWEBRemoto: TQuery;
    QClientesWEBLocalcliente_wcl: TStringField;
    QClientesWEBLocalnombre_cliente_wcl: TStringField;
    QClientesWEBLocalusuario_wcl: TStringField;
    QClientesWEBLocalpassword_wcl: TStringField;
    QClientesWEBLocalnombre_usuario_wcl: TStringField;
    QClientesWEBLocalemail_wcl: TStringField;
    QClientesWEBLocalidioma_wcl: TStringField;
    QProductosWEBLocal: TQuery;
    QProductosWEBRemoto: TQuery;
    QProductosWEBLocalproducto_wpd: TStringField;
    QProductosWEBLocalidioma_wpd: TStringField;
    QProductosWEBLocaldescripcion_wpd: TStringField;
    QMarcarReclamaRemoto: TQuery;
    IdFTP: TIdFTP;
    QImagenesRemoto: TQuery;
    QReclamaciones: TQuery;
    QReclamaFotos: TQuery;
    QReclamaFotosempresa_rft: TStringField;
    QReclamaFotoscliente_rft: TStringField;
    QReclamaFotosn_reclamacion_rft: TSmallintField;
    QReclamaFotosfichero_rft: TStringField;
    QReclamacionesempresa_rcl: TStringField;
    QReclamacionescliente_rcl: TStringField;
    QReclamacionesn_reclamacion_rcl: TSmallintField;
    QReclamacionesemail_rcl: TStringField;
    QReclamacionesnombre_rcl: TStringField;
    QReclamacionesfecha_rcl: TDateField;
    QReclamacioneshora_rcl: TStringField;
    QReclamacionesn_pedido_rcl: TIntegerField;
    QReclamacionesn_albaran_rcl: TIntegerField;
    QReclamacionesfecha_albaran_rcl: TDateField;
    QReclamacionesproducto_rcl: TStringField;
    QReclamacionesidioma_rcl: TStringField;
    QReclamacionescaj_kgs_uni_rcl: TStringField;
    QReclamacionescantidad_rcl: TSmallintField;
    QReclamacionesporc_rajado_rcl: TSmallintField;
    QReclamacionesporc_mancha_rcl: TSmallintField;
    QReclamacionesporc_blando_rcl: TSmallintField;
    QReclamacionesporc_moho_rcl: TSmallintField;
    QReclamacionesporc_color_rcl: TSmallintField;
    QReclamacionesporc_otros_rcl: TSmallintField;
    QReclamacionesdescripcion_otros_rcl: TStringField;
    QReclamacionesn_devolucion_rcl: TSmallintField;
    QReclamacionest_devolucion_rcl: TStringField;
    QReclamacionesn_reseleccion_rcl: TSmallintField;
    QReclamacionest_reseleccion_rcl: TStringField;
    QReclamacionesn_reventa_rcl: TSmallintField;
    QReclamacionest_reventa_rcl: TStringField;
    QReclamacionesn_otros_rcl: TSmallintField;
    QReclamacionest_otros_rcl: TStringField;
    QReclamacionesobservacion_rcl: TStringField;
    QReclamacionesstatus_r: TStringField;
    QReclamacionesdescargado_r: TStringField;
    QReclamacionesnotas_exporta_rcl: TStringField;
    QReclamacionesRemotoempresa_r: TStringField;
    QReclamacionesRemotocliente_r: TStringField;
    QReclamacionesRemoton_reclamacion_r: TSmallintField;
    QReclamacionesRemotoemail_r: TStringField;
    QReclamacionesRemotonombre_r: TStringField;
    QReclamacionesRemotofecha_r: TDateField;
    QReclamacionesRemotohora_r: TTimeField;
    QReclamacionesRemoton_pedido_r: TIntegerField;
    QReclamacionesRemoton_albaran_r: TIntegerField;
    QReclamacionesRemotofecha_albaran_r: TDateField;
    QReclamacionesRemotoproducto_r: TStringField;
    QReclamacionesRemotoidioma_r: TStringField;
    QReclamacionesRemotocaj_kgs_uni_r: TStringField;
    QReclamacionesRemotocantidad_r: TSmallintField;
    QReclamacionesRemotoporc_rajado_r: TSmallintField;
    QReclamacionesRemotoporc_mancha_r: TSmallintField;
    QReclamacionesRemotoporc_blando_r: TSmallintField;
    QReclamacionesRemotoporc_moho_r: TSmallintField;
    QReclamacionesRemotoporc_color_r: TSmallintField;
    QReclamacionesRemotoporc_otros_r: TSmallintField;
    QReclamacionesRemotodescripcion_otros_r: TStringField;
    QReclamacionesRemoton_devolucion_r: TSmallintField;
    QReclamacionesRemotot_devolucion_r: TStringField;
    QReclamacionesRemoton_reseleccion_r: TSmallintField;
    QReclamacionesRemotot_reseleccion_r: TStringField;
    QReclamacionesRemoton_reventa_r: TSmallintField;
    QReclamacionesRemotot_reventa_r: TStringField;
    QReclamacionesRemoton_otros_r: TSmallintField;
    QReclamacionesRemotot_otros_r: TStringField;
    QReclamacionesRemotoobservacion_r: TStringField;
    QReclamacionesRemotostatus_r: TStringField;
    QReclamacionesRemotodescargado_r: TStringField;
    QDesCliente: TQuery;
    QDesProducto: TQuery;
    QListado: TQuery;
    QMaestro: TQuery;
    QClientesWEBRemotousuario_cw: TStringField;
    QClientesWEBRemotopassword_cw: TStringField;
    QClientesWEBRemotocliente_cw: TStringField;
    QClientesWEBRemotonombre_cliente_cw: TStringField;
    QClientesWEBRemotonombre_usuario_cw: TStringField;
    QClientesWEBRemotoemail_cw: TStringField;
    QClientesWEBRemotoidioma_cw: TStringField;
    QProductosWEBRemotoproducto_pw: TStringField;
    QProductosWEBRemotoidioma_pw: TStringField;
    QProductosWEBRemotodescripcion_pw: TStringField;
    QParamLocal: TQuery;
    QParamRemoto: TQuery;
    QParamLocalcontador_wpr: TSmallintField;
    QParamLocalemail_wpr: TStringField;
    QParamLocalruta_imagenes_wpr: TStringField;
    QParamRemotocontador_p: TSmallintField;
    QParamRemotoemail_p: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure QReclamacionesBeforePost(DataSet: TDataSet);
    procedure QReclamacionesAfterPost(DataSet: TDataSet);
    procedure QReclamacionesAfterCancel(DataSet: TDataSet);
  private
    { Private declarations }
    iNumReclama: integer;
    procedure IncrementarNumeroReclamacion;

  public
    { Public declarations }
    bAlta: boolean;
    function  GetNumeroReclamacion: integer;
    function FTPDownloadImagen( const AClave, AEmpresa, ACliente: String; const AReclamacion: Integer ): string;
    //procedure FTPBorrarImagen( const AClave: string );
    //procedure FTPBorrarDirectorio( const AClave: string );

    function DesCliente( const ACliente: String): string;
    function DesProducto( const AProducto: String; const AIdioma: String = 'ES' ): string;
  end;

var
  DMWEB: TDMWEB;

implementation

{$R *.dfm}


procedure TDMWEB.DataModuleCreate(Sender: TObject);
begin
  QNumReclamacionesRemoto.SQL.Clear;
  QNumReclamacionesRemoto.SQL.Add('select count(*) ');
  QNumReclamacionesRemoto.SQL.Add('from frf_reclamaciones ');
  QNumReclamacionesRemoto.SQL.Add('where descargado_r = ''0'' ');

  QReclamacionesRemoto.SQL.Clear;
  QReclamacionesRemoto.SQL.Add('select * ');
  QReclamacionesRemoto.SQL.Add('from frf_reclamaciones ');
  QReclamacionesRemoto.SQL.Add('where descargado_r = ''0'' ');
  QMarcarReclamaRemoto.SQL.Add(' order by n_reclamacion_r ');

  QMarcarReclamaRemoto.SQL.Clear;
  QMarcarReclamaRemoto.SQL.Add(' update frf_reclamaciones ');
  QMarcarReclamaRemoto.SQL.Add('    set descargado_r = ''1'' ');
  QMarcarReclamaRemoto.SQL.Add(' where empresa_r = :empresa ');
  QMarcarReclamaRemoto.SQL.Add('   and cliente_r = :cliente ');
  QMarcarReclamaRemoto.SQL.Add('   and n_reclamacion_r = :reclama ');

  QImagenesRemoto.SQL.Clear;
  QImagenesRemoto.SQL.Add(' select fichero_fr ');
  QImagenesRemoto.SQL.Add(' from frf_fotos_rec ');
  QImagenesRemoto.SQL.Add(' where empresa_fr = :empresa ');
  QImagenesRemoto.SQL.Add('   and cliente_fr = :cliente ');
  QImagenesRemoto.SQL.Add('   and n_reclamacion_fr = :reclama ');

  QClientesWEBLocal.SQL.Clear;
  QClientesWEBLocal.SQL.Add('select * ');
  QClientesWEBLocal.SQL.Add('from frf_web_clientes ');

  QClientesWEBRemoto.SQL.Clear;
  QClientesWEBRemoto.SQL.Add('select * ');
  QClientesWEBRemoto.SQL.Add('from  frf_clientes_web');

  QProductosWEBLocal.SQL.Clear;
  QProductosWEBLocal.SQL.Add('select * ');
  QProductosWEBLocal.SQL.Add('from frf_web_productos ');

  QProductosWEBRemoto.SQL.Clear;
  QProductosWEBRemoto.SQL.Add('select * ');
  QProductosWEBRemoto.SQL.Add('from  frf_productos_web');

  QDesCliente.SQL.Clear;
  QDesCliente.SQL.Add(' select nombre_cliente_wcl ');
  QDesCliente.SQL.Add(' from frf_web_clientes ');
  QDesCliente.SQL.Add(' where cliente_wcl = :cliente ');

  QDesProducto.SQL.Clear;
  QDesProducto.SQL.Add(' select descripcion_wpd ');
  QDesProducto.SQL.Add(' from frf_web_productos ');
  QDesProducto.SQL.Add(' where producto_wpd = :producto ');
  QDesProducto.SQL.Add(' and Upper(idioma_wpd) = :idioma ');

  QParamLocal.SQL.Clear;
  QParamLocal.SQL.Add('select * ');
  QParamLocal.SQL.Add('from frf_web_parametros ');

  QParamRemoto.SQL.Clear;
  QParamRemoto.SQL.Add('select * ');
  QParamRemoto.SQL.Add('from  frf_parametros');

  bAlta:= False;
end;

function FicheroRemoto( const AClave: String; var ARuta: string ): string;
begin
  ARuta:= kRemoteDir +  copy( AClave, 1, Length( AClave ) - 1 );
  Result:= ARuta + '/' + copy( AClave, Length( AClave ), 1 ) + '.jpeg';
end;

function FicheroLocal( const AClave, AEmpresa, ACliente: String; const AReclamacion: Integer;
  var ANombre: string ): string;
var
  iAux: integer;
  sAux: string;
begin
  case Length( AEmpresa ) of
    0: result:= '___';
    1: result:= '__' + AEmpresa;
    2: result:= '_' + AEmpresa;
    3: result:= AEmpresa;
  end;
  case Length( ACliente ) of
    0: result:= result + '___';
    1: result:= result + '__' + ACliente;
    2: result:= result + '_' + ACliente;
    3: result:= result + ACliente;
  end;
  iAux:= 1000000 + AReclamacion;
  sAux:= IntToStr( iAux );
  sAux:= copy( sAux, 2, Length( sAux ) - 1 );
  result:= result + sAux;

  sAux:= copy( AClave, Length( AClave ), 1 );
  ANombre:= result + sAux;
  result:= kLocalDir + ANombre + '.jpg';
end;

function TDMWEB.FTPDownloadImagen( const AClave, AEmpresa, ACliente: String; const AReclamacion: Integer ): String;
var
  sRemoto, sRuta: string;
  sLocal, sNombre: string;
begin
  IdFTP.Host:= kHost;
  IdFTP.User:= kUser;
  IdFTP.Password:= kPass;
  IdFTP.TransferType:= ftBinary;
  IdFTP.Connect( true );
  try
    sRemoto:= FicheroRemoto( AClave, sRuta );
    sLocal:= FicheroLocal( AClave, AEmpresa, ACliente, AReclamacion, sNombre );
    IdFTP.get( sRemoto, sLocal, True );
    result:=  sNombre;
  finally
    IdFTP.Quit;
  end;
end;

function TDMWEB.DesCliente( const ACliente: String): string;
begin
  with QDesCliente do
  begin
    ParamByName('cliente').AsString:= ACliente;
    try
      Open;
      result:= Fields[0].AsString;
      Close;
    except
      result:= '';
    end;
  end;
end;

function TDMWEB.DesProducto( const AProducto: String; const AIdioma: String = 'ES' ): string;
begin
  with QDesProducto do
  begin
    ParamByName('producto').AsString:= AProducto;
    ParamByName('idioma').AsString:= AIdioma;
    try
      Open;
      result:= Fields[0].AsString;
      Close;
    except
      result:= '';
    end;
  end;
end;

(*
procedure TDMWEB.FTPBorrarImagen( const AClave: string );
var
  sRemoto, sRuta: string;
begin
  IdFTP.Host:= kHost;
  IdFTP.User:= kUser;
  IdFTP.Password:= kPass;
  IdFTP.TransferType:= ftBinary;
  IdFTP.Connect( true );
  try
    sRemoto:= FicheroRemoto( AClave, sRuta );
    IdFTP.Delete( sRemoto );
  finally
    IdFTP.Quit;
  end;
end;

procedure TDMWEB.FTPBorrarDirectorio( const AClave: string );
var
  sRuta: string;
begin

  IdFTP.Host:= kHost;
  IdFTP.User:= kUser;
  IdFTP.Password:= kPass;
  IdFTP.TransferType:= ftBinary;
  IdFTP.Connect( true );
  try
    FicheroRemoto( AClave, sRuta );
    IdFTP.RemoveDir( sRuta );
  finally
    IdFTP.Quit;
  end;
end;
*)

procedure TDMWEB.QReclamacionesBeforePost(DataSet: TDataSet);
begin
  if bAlta then
  begin
    iNumReclama:= GetNumeroReclamacion;
    QReclamacionesn_reclamacion_rcl.AsInteger:= iNumReclama;
  end;
end;

procedure TDMWEB.QReclamacionesAfterPost(DataSet: TDataSet);
begin
  if bAlta then
  begin
    IncrementarNumeroReclamacion;
    bAlta:= False;
  end;
end;

procedure TDMWEB.QReclamacionesAfterCancel(DataSet: TDataSet);
begin
  bAlta:= False;
end;

function TDMWEB.GetNumeroReclamacion: integer;
begin
  with QParamRemoto do
  begin
    Open;
    result:= FieldByName('contador_p').AsInteger;
    Close;
  end;
end;

procedure TDMWEB.IncrementarNumeroReclamacion;
begin
  with QParamRemoto do
  begin
    Open;
    if FieldByName('contador_p').AsInteger <= iNumReclama then
    begin
      Edit;
      FieldByName('contador_p').AsInteger:= iNumReclama + 1;
      Post;
    end;
    Close;
  end;
end;

end.
