unit TablaAnualCosteKgEnvasadoReport;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, kbmMemTable;

type
  TQRTablaAnualCosteKgEnvasado = class(TQuickRep)
    DetailBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    PsQRSysData1: TQRSysData;
    lblTitulo: TQRLabel;
    codigo: TQRExpr;
    QRGroup1: TQRGroup;
    descripcion: TQRExpr;
    QRGroup2: TQRGroup;
    qrlbl05: TQRLabel;
    lblRango: TQRLabel;
    lbl01: TQRExpr;
    lbl03: TQRExpr;
    qrlbl02: TQRLabel;
    qrlbl09: TQRLabel;
    qrlbl03: TQRLabel;
    lbl02: TQRExpr;
    lbl04: TQRExpr;
    qrlbl07: TQRLabel;
    qrlbl11: TQRLabel;
    qrl4: TQRLabel;
    kmtCostesEnvasado: TkbmMemTable;
    qrxprEmpresa: TQRExpr;
    qrxprCentro: TQRExpr;
    qrgrpProducto: TQRGroup;
    qrxProducto: TQRExpr;
    qrxDesProducto: TQRExpr;
    lbl05: TQRExpr;
    lbl06: TQRExpr;
    lbl07: TQRExpr;
    lbl08: TQRExpr;
    lbl09: TQRExpr;
    lbl10: TQRExpr;
    lbl11: TQRExpr;
    lbl12: TQRExpr;
    lblmeses: TQRExpr;
    lblmedia: TQRExpr;
    qrxpr11: TQRExpr;
    qrlbl01: TQRLabel;
    qrlbl04: TQRLabel;
    qrlbl06: TQRLabel;
    qrlbl08: TQRLabel;
    qrlbl10: TQRLabel;
    qrlbl12: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl8: TQRLabel;
    bndcSeciones: TQRChildBand;
    qrxpr12: TQRExpr;
    qrxpr13: TQRExpr;
    qrxpr14: TQRExpr;
    qrxpr15: TQRExpr;
    qrxpr16: TQRExpr;
    qrxpr17: TQRExpr;
    qrxpr18: TQRExpr;
    qrxpr19: TQRExpr;
    qrxpr20: TQRExpr;
    qrxpr21: TQRExpr;
    qrxpr22: TQRExpr;
    qrxpr23: TQRExpr;
    qrxpr24: TQRExpr;
    qrxpr25: TQRExpr;
    lblTipo: TQRLabel;
    qrlblSecc: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    qrxpr1: TQRExpr;
    qrxpr2: TQRExpr;
    qrxpr3: TQRExpr;
    qrxpr4: TQRExpr;
    qrxpr5: TQRExpr;
    qrlblEmpresa: TQRLabel;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl2: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl9: TQRLabel;
    qrxpr6: TQRExpr;
    qrxpr7: TQRExpr;
    qrxpr8: TQRExpr;
    qrxpr9: TQRExpr;
    qrlbl13: TQRLabel;
    qrlblCliente: TQRLabel;
    procedure bndcSecionesBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure SoloExcelPrint(sender: TObject; var Value: String);
    procedure QRGroup2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrgrpProductoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure qrl4Print(sender: TObject; var Value: String);
    procedure qrlbl7Print(sender: TObject; var Value: String);
  private
    sEmpresa, sCentro, sDesCentro, sProducto, sDesProducto, sAgrupacion, sEnvase, sDesEnvase: string;
    bImpririHijo: Boolean;
    arEnvasado, arSeccion: array [0..11] of Real;
    iTotal, iEnvasados, iSecciones: Integer;
    rTotal, rEnvasados, rSecciones: Real;

    procedure VerGastosDe( const ATipo: Integer );
    procedure RellenarTabalTemporal( const AAnyo: integer );
    procedure CabecerasAnyoMes( const AAnyo: integer );
    procedure AltaRegistro;
    procedure LimpiarArrays;
  public
    Empresa: string;
    bPromedios: Boolean;

    constructor Create( AOwner: TComponent ); override;
    destructor Destroy; override;
  end;

procedure QRTablaAnualCosteKgEnvasadoPrint(const AEmpresa, ACentro, AProducto, AEnvase, ACliente: string;
                                           const AFechaHasta: TDate; const ATipo: Integer; const APromedios: boolean );

implementation

{$R *.DFM}

uses CReportes, DPreview, UDMbaseDatos, bSQLUtils, UDMAuxDB, Dialogs,
  bTimeUtils, Variants, bMath, DBTables, CGlobal;

function StrAnyoMes( const AAnyoMes: Integer ): String;
var
  iMes, iAnyo: Integer;
begin
  iAnyo:= (AAnyoMes div 100 );
  iMes:= (AAnyoMes mod 100 );
  if iMes > 9 then
    Result:= IntToStr( iAnyo ) + '.' + IntToStr( iMes )
  else
    Result:= IntToStr( iAnyo ) + '.0' + IntToStr( iMes );
end;
function DecMes( const AAnyoMes: Integer; const AValue: integer ): Integer;
var
  iMes, iAnyo: Integer;
  iMeses, iAnyos: Integer;
begin
  //Años
  iAnyo:= (AAnyoMes div 100 );
  iAnyos:= ( AValue div 12 );
  iAnyo:= iAnyo - iAnyos;

  //Meses
  iMes:= (AAnyoMes mod 100 );
  if ( iMes > 12 ) or ( iMes = 0 ) then
    raise Exception.Create('Mes incorrecto -> ' + StrAnyoMes( AAnyoMes ) );
  iMeses:= ( AValue mod 12 );
  iMes:= iMes - iMeses;
  if iMes <= 0 then
  begin
    //Cambio de año
    iMes:= 12 + iMes;
    iAnyo:= iAnyo - 1;
  end;
  result:= iAnyo * 100 + iMes;
end;

function DifMes( const AAnyoMes1, AAnyoMes2: Integer ): Integer;
var
  AAnyoMesMayor, AAnyoMesMenor: Integer;
  iAnyos, iMeses: Integer;
begin
  //Ordenar
  if AAnyoMes1 > AAnyoMes2 then
  begin
    AAnyoMesMayor:= AAnyoMes1;
    AAnyoMesMenor:= AAnyoMes2;
  end
  else
  begin
    AAnyoMesMayor:= AAnyoMes2;
    AAnyoMesMenor:= AAnyoMes1;
  end;

  //Meses
  iAnyos:= ( AAnyoMesMayor mod 100 );
  if ( iAnyos > 12 ) or ( iAnyos = 0 ) then
    raise Exception.Create('Mes incorrecto -> ' + StrAnyoMes( AAnyoMesMayor ) );
  iMeses:= ( AAnyoMesMenor mod 100 );
  if ( iMeses > 12 ) or ( iMeses = 0 ) then
    raise Exception.Create('Mes incorrecto -> ' + StrAnyoMes( AAnyoMesMenor ) );
  iMeses:=  iAnyos - iMeses;

  //Años
  iAnyos:= ( AAnyoMesMayor div 100 ) - ( AAnyoMesMenor div 100 );

  //Resultado
  Result:= ( iAnyos * 12 ) + iMeses;
end;


function PreparaQuery(const AEmpresa, ACentro, AProducto, AEnvase, ACliente: string; const AAnyo: integer; const APromedios: boolean ): Boolean;
begin
  //--Todos los productos
  //--Todos los centros
  with DMBaseDatos.QListado do
  begin

    SQL.Clear;
    SQL.Add(' select ');
    SQL.Add('   empresa_ec empresa, ');
    SQL.Add('   centro_ec centro, ( select descripcion_c from frf_centros where empresa_c = empresa_ec and centro_c = centro_ec ) des_centro, ');
    SQL.Add('   producto_ec producto, ( select descripcion_p from frf_productos where producto_p = producto_ec ) des_producto, ');
    SQL.Add('   ( select agrupacion_e from frf_envases where envase_e = envase_ec ) agrupacion, ');
    SQL.Add('   envase_Ec envase, ( select descripcion_e from frf_envases where envase_e = envase_ec ) des_envase, ');
    SQL.Add('   anyo_ec * 100 + mes_Ec anyo_mes, ');
//    if gProgramVersion = pvSAT then
//    begin
    if APromedios then
    begin
      SQL.Add('   pcoste_ec + pmaterial_ec envasado, ');
      SQL.Add('   psecciones_ec secciones ');
    end
    else
    begin
      SQL.Add('   coste_ec + material_ec envasado, ');
      SQL.Add('   secciones_ec secciones ');
    end;
//  end
//    else
//    begin
//      SQL.Add('   material_ec envasado, ');
//      SQL.Add('   personal_ec + general_ec secciones ');
//      SQL.Add('   coste_ec + secciones_ec secciones ');
//    end;
    SQL.Add(' from frf_env_costes ');
    SQL.Add(' where empresa_ec = :empresa ');
    SQL.Add(' and ( anyo_ec * 100 + mes_Ec ) between  :anyomesini and :anyomesfin ');
    if ACentro <> '' then
      SQL.Add(' and centro_ec = :centro ');
    if AProducto <> '' then
      SQL.Add(' and producto_ec = :producto ');
    if AEnvase <> '' then
      SQL.Add(' and envase_ec = :envase ');

    if ACliente <> '' then
    begin
      SQL.Add('  and exists ');
      SQL.Add(' ( ');
      SQL.Add('    select * ');
      SQL.Add('    from frf_salidas_l ');
      SQL.Add('    where empresa_sl = empresa_ec ');
      SQL.Add('    and envase_sl = envase_ec ');
      SQL.Add('    and producto_sl = producto_ec ');
      SQL.Add('    and cliente_sl = :cliente ');
      SQL.Add('  ) ');
    end;

    SQL.Add(' order by 1 desc,2 desc,4 desc,6 desc,8 ');

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('anyomesini').AsInteger := DecMes( AAnyo, 11 );
    ParamByName('anyomesfin').AsInteger := AAnyo;
    if ACentro <> '' then
      ParamByName('centro').AsString := ACentro;
    if AProducto <> '' then
      ParamByName('producto').AsString := AProducto;
    if AEnvase <> '' then
      ParamByName('envase').AsString := AEnvase;
    if ACliente <> '' then
      ParamByName('cliente').AsString := ACliente;

    Open;
    result := not IsEmpty;
    if not Result then
      Close
  end;
end;
(*


*)
procedure QRTablaAnualCosteKgEnvasadoPrint(const AEmpresa, ACentro, AProducto, AEnvase, ACliente: string;
                                           const AFechaHasta: TDate; const ATipo: Integer; const APromedios: boolean );
var
  QRTablaAnualCosteKgEnvasado: TQRTablaAnualCosteKgEnvasado;
  iAnyo, iMes, iDia: word;
  iAnyoMesHasta: Integer;
begin
  QRTablaAnualCosteKgEnvasado := TQRTablaAnualCosteKgEnvasado.Create(nil);
  try
    try
      DecodeDate( AFechaHasta, iAnyo, iMes, iDia );
      iAnyoMesHasta:= ( iAnyo * 100 ) + iMes;
      if PreparaQuery(AEmpresa, ACentro, AProducto, AEnvase, ACliente, iAnyoMesHasta, APromedios ) then
      begin
        QRTablaAnualCosteKgEnvasado.bPromedios:= APromedios;
        QRTablaAnualCosteKgEnvasado.CabecerasAnyoMes( iAnyoMesHasta );
        QRTablaAnualCosteKgEnvasado.VerGastosDE( ATipo );
        QRTablaAnualCosteKgEnvasado.RellenarTabalTemporal( iAnyoMesHasta );
        PonLogoGrupoBonnysa(QRTablaAnualCosteKgEnvasado, AEmpresa);
        QRTablaAnualCosteKgEnvasado.Empresa := AEmpresa;
        if ACliente  <> '' then
        begin
          QRTablaAnualCosteKgEnvasado.qrlblCliente.Caption:= ACliente + ' ' + desCliente( ACliente );
        end
        else
        begin
          QRTablaAnualCosteKgEnvasado.qrlblCliente.Caption:= '';
        end;
        QRTablaAnualCosteKgEnvasado.lblRango.Caption := 'Desde el mes ' + StrAnyoMes( DecMes( iAnyoMesHasta,11)) + ' al ' + StrAnyoMes(iAnyoMesHasta);
        Preview(QRTablaAnualCosteKgEnvasado);
      end
      else
      begin
        ShowMessage('Listado sin datos.');
      end;
    finally
      DMBaseDatos.QListado.Close;
    end;
  except
    FreeAndNil( QRTablaAnualCosteKgEnvasado );
    raise;
  end;
end;

constructor TQRTablaAnualCosteKgEnvasado.Create( AOwner: TComponent );
begin
  inherited;
  with kmtCostesEnvasado do
  begin
    FieldDefs.Clear;

    FieldDefs.Add('empresa', ftString, 3, False);
    FieldDefs.Add('centro', ftString, 1, False);
    FieldDefs.Add('producto', ftString, 3, False);
    FieldDefs.Add('agrupacion', ftString, 20, False);
    FieldDefs.Add('envase', ftString, 9, False);

    FieldDefs.Add('des_centro', ftString, 30, False);
    FieldDefs.Add('des_producto', ftString, 30, False);
    FieldDefs.Add('des_envase', ftString, 30, False);

    FieldDefs.Add('envase01', ftFloat, 0, False);
    FieldDefs.Add('envase02', ftFloat, 0, False);
    FieldDefs.Add('envase03', ftFloat, 0, False);
    FieldDefs.Add('envase04', ftFloat, 0, False);
    FieldDefs.Add('envase05', ftFloat, 0, False);
    FieldDefs.Add('envase06', ftFloat, 0, False);
    FieldDefs.Add('envase07', ftFloat, 0, False);
    FieldDefs.Add('envase08', ftFloat, 0, False);
    FieldDefs.Add('envase09', ftFloat, 0, False);
    FieldDefs.Add('envase10', ftFloat, 0, False);
    FieldDefs.Add('envase11', ftFloat, 0, False);
    FieldDefs.Add('envase12', ftFloat, 0, False);
    FieldDefs.Add('meses_envase', ftInteger, 0, False);
    FieldDefs.Add('media_envase', ftFloat, 0, False);

    FieldDefs.Add('seccion01', ftFloat, 0, False);
    FieldDefs.Add('seccion02', ftFloat, 0, False);
    FieldDefs.Add('seccion03', ftFloat, 0, False);
    FieldDefs.Add('seccion04', ftFloat, 0, False);
    FieldDefs.Add('seccion05', ftFloat, 0, False);
    FieldDefs.Add('seccion06', ftFloat, 0, False);
    FieldDefs.Add('seccion07', ftFloat, 0, False);
    FieldDefs.Add('seccion08', ftFloat, 0, False);
    FieldDefs.Add('seccion09', ftFloat, 0, False);
    FieldDefs.Add('seccion10', ftFloat, 0, False);
    FieldDefs.Add('seccion11', ftFloat, 0, False);
    FieldDefs.Add('seccion12', ftFloat, 0, False);
    FieldDefs.Add('meses_seccion', ftInteger, 0, False);
    FieldDefs.Add('media_seccion', ftFloat, 0, False);

    FieldDefs.Add('meses_total', ftInteger, 0, False);
    FieldDefs.Add('media_total', ftFloat, 0, False);

    IndexFieldNames:= 'empresa;centro;producto;envase';
    CreateTable;
    Open;
  end;
  bImpririHijo:= False;
end;

destructor TQRTablaAnualCosteKgEnvasado.Destroy;
begin
  kmtCostesEnvasado.Close;
  inherited;
end;

procedure TQRTablaAnualCosteKgEnvasado.AltaRegistro;
begin
  with DMBaseDatos.QListado do
  begin
    kmtCostesEnvasado.Insert;

    kmtCostesEnvasado.FieldByName('empresa').AsString:= sEmpresa;
    kmtCostesEnvasado.FieldByName('centro').AsString:= sCentro;
    kmtCostesEnvasado.FieldByName('producto').AsString:= sProducto;
    kmtCostesEnvasado.FieldByName('agrupacion').AsString:= sAgrupacion;
    kmtCostesEnvasado.FieldByName('envase').AsString:= sEnvase;

    kmtCostesEnvasado.FieldByName('des_centro').AsString:= sDesCentro;
    kmtCostesEnvasado.FieldByName('des_producto').AsString:= sDesProducto;
    kmtCostesEnvasado.FieldByName('des_envase').AsString:= sDesEnvase;

    kmtCostesEnvasado.FieldByName('envase01').AsFloat:= arEnvasado[0];
    kmtCostesEnvasado.FieldByName('envase02').AsFloat:= arEnvasado[1];
    kmtCostesEnvasado.FieldByName('envase03').AsFloat:= arEnvasado[2];
    kmtCostesEnvasado.FieldByName('envase04').AsFloat:= arEnvasado[3];
    kmtCostesEnvasado.FieldByName('envase05').AsFloat:= arEnvasado[4];
    kmtCostesEnvasado.FieldByName('envase06').AsFloat:= arEnvasado[5];
    kmtCostesEnvasado.FieldByName('envase07').AsFloat:= arEnvasado[6];
    kmtCostesEnvasado.FieldByName('envase08').AsFloat:= arEnvasado[7];
    kmtCostesEnvasado.FieldByName('envase09').AsFloat:= arEnvasado[8];
    kmtCostesEnvasado.FieldByName('envase10').AsFloat:= arEnvasado[9];
    kmtCostesEnvasado.FieldByName('envase11').AsFloat:= arEnvasado[10];
    kmtCostesEnvasado.FieldByName('envase12').AsFloat:= arEnvasado[11];
    kmtCostesEnvasado.FieldByName('meses_envase').AsInteger:= iEnvasados;
    if iEnvasados > 0 then
      kmtCostesEnvasado.FieldByName('media_envase').AsFloat:= bRoundTo( rEnvasados / iEnvasados, 5)
    else
      kmtCostesEnvasado.FieldByName('media_envase').AsFloat:= 0;


    kmtCostesEnvasado.FieldByName('seccion01').AsFloat:= arSeccion[0];
    kmtCostesEnvasado.FieldByName('seccion02').AsFloat:= arSeccion[1];
    kmtCostesEnvasado.FieldByName('seccion03').AsFloat:= arSeccion[2];
    kmtCostesEnvasado.FieldByName('seccion04').AsFloat:= arSeccion[3];
    kmtCostesEnvasado.FieldByName('seccion05').AsFloat:= arSeccion[4];
    kmtCostesEnvasado.FieldByName('seccion06').AsFloat:= arSeccion[5];
    kmtCostesEnvasado.FieldByName('seccion07').AsFloat:= arSeccion[6];
    kmtCostesEnvasado.FieldByName('seccion08').AsFloat:= arSeccion[7];
    kmtCostesEnvasado.FieldByName('seccion09').AsFloat:= arSeccion[8];
    kmtCostesEnvasado.FieldByName('seccion10').AsFloat:= arSeccion[9];
    kmtCostesEnvasado.FieldByName('seccion11').AsFloat:= arSeccion[10];
    kmtCostesEnvasado.FieldByName('seccion12').AsFloat:= arSeccion[11];
    kmtCostesEnvasado.FieldByName('meses_seccion').AsInteger:= iSecciones;
    if iSecciones > 0 then
      kmtCostesEnvasado.FieldByName('media_seccion').AsFloat:= bRoundTo( rSecciones / iSecciones, 5)
    else
      kmtCostesEnvasado.FieldByName('media_seccion').AsFloat:= 0;

    kmtCostesEnvasado.FieldByName('meses_total').AsInteger:= iTotal;
    if iTotal > 0 then
      kmtCostesEnvasado.FieldByName('media_total').AsFloat:= bRoundTo( rTotal / iTotal, 5)
    else
      kmtCostesEnvasado.FieldByName('media_total').AsFloat:= 0;

    kmtCostesEnvasado.post;
  end;
end;

procedure TQRTablaAnualCosteKgEnvasado.LimpiarArrays;
var
  i: Integer;
begin
  for i:= 0  to 11 do
  begin
    arEnvasado[i]:= 0;
    arSeccion[i]:= 0;
  end;
  iTotal:= 0;
  iEnvasados:= 0;
  iSecciones:= 0;
  rTotal:= 0;
  rEnvasados:= 0;
  rSecciones:= 0;
end;

procedure TQRTablaAnualCosteKgEnvasado.RellenarTabalTemporal( const AAnyo: Integer );
var
  sCodigo: string;
  iIndex: Integer;
begin
  DMBaseDatos.QListado.First;
  sCodigo:= '';
  LimpiarArrays;
  while not DMBaseDatos.QListado.Eof do
  begin
    if sCodigo <> DMBaseDatos.QListado.FieldByName('empresa').AsString +
                  DMBaseDatos.QListado.FieldByName('centro').AsString +
                  DMBaseDatos.QListado.FieldByName('producto').AsString +
                  DMBaseDatos.QListado.FieldByName('envase').AsString  then
    begin
      if sCodigo <> '' then
      begin
        AltaRegistro;
      end;
      sEmpresa:= DMBaseDatos.QListado.FieldByName('empresa').AsString;
      sCentro:= DMBaseDatos.QListado.FieldByName('centro').AsString;
      sDesCentro:= DMBaseDatos.QListado.FieldByName('des_centro').AsString;
      sProducto:= DMBaseDatos.QListado.FieldByName('producto').AsString;
      sAgrupacion:= DMBaseDatos.QListado.FieldByName('agrupacion').AsString;
      sDesProducto:= DMBaseDatos.QListado.FieldByName('des_producto').AsString;
      sEnvase:= DMBaseDatos.QListado.FieldByName('envase').AsString;
      sDesEnvase:= DMBaseDatos.QListado.FieldByName('des_envase').AsString;
      sCodigo:= DMBaseDatos.QListado.FieldByName('empresa').AsString +
                DMBaseDatos.QListado.FieldByName('centro').AsString +
                DMBaseDatos.QListado.FieldByName('producto').AsString +
                DMBaseDatos.QListado.FieldByName('envase').AsString;
      LimpiarArrays;
    end;
    iIndex:= DifMes( AAnyo, DMBaseDatos.QListado.FieldByName('anyo_mes').AsInteger );
    if ( iIndex >= 0 ) and ( iIndex < 12 ) then
    begin
      arEnvasado[iIndex]:= DMBaseDatos.QListado.FieldByName('envasado').AsFloat;
      arSeccion[iIndex]:= DMBaseDatos.QListado.FieldByName('secciones').AsFloat;
      if ( arEnvasado[iIndex] <> 0 ) or ( arSeccion[iIndex] <> 0 ) then
      begin
        if arEnvasado[iIndex] <> 0 then
        begin
          Inc( iEnvasados );
          rEnvasados:= rEnvasados + arEnvasado[iIndex];
        end;
        if arSeccion[iIndex] <> 0 then
        begin
          Inc( iSecciones );
          rSecciones:= rSecciones + arSeccion[iIndex];
        end;

        Inc( iTotal );
        rTotal:= rTotal + arEnvasado[iIndex] + arSeccion[iIndex];
      end;
    end;
    DMBaseDatos.QListado.Next;
  end;
  AltaRegistro;
  //kmtCostesEnvasado.Sort([]);
end;

procedure TQRTablaAnualCosteKgEnvasado.CabecerasAnyoMes( const AAnyo: Integer );
var
  iAux: Integer;
begin
  iAux:= AAnyo;
  qrlbl12.Caption:= StrAnyoMes( iAux );
  iAux:= DecMes( iAux, 1);
  qrlbl11.Caption:= StrAnyoMes( iAux );
  iAux:= DecMes( iAux, 1);
  qrlbl10.Caption:= StrAnyoMes( iAux);
  iAux:= DecMes( iAux, 1);
  qrlbl09.Caption:= StrAnyoMes( iAux );
  iAux:= DecMes( iAux, 1);
  qrlbl08.Caption:= StrAnyoMes( iAux );
  iAux:= DecMes( iAux, 1);
  qrlbl07.Caption:= StrAnyoMes( iAux );
  iAux:= DecMes( iAux, 1);
  qrlbl06.Caption:= StrAnyoMes( iAux );
  iAux:= DecMes( iAux, 1);
  qrlbl05.Caption:= StrAnyoMes( iAux );
  iAux:= DecMes( iAux, 1);
  qrlbl04.Caption:= StrAnyoMes( iAux );
  iAux:= DecMes( iAux, 1);
  qrlbl03.Caption:= StrAnyoMes( iAux );
  iAux:= DecMes( iAux, 1);
  qrlbl02.Caption:= StrAnyoMes( iAux );
  iAux:= DecMes( iAux, 1);
  qrlbl01.Caption:= StrAnyoMes( iAux );
end;

procedure TQRTablaAnualCosteKgEnvasado.VerGastosDe( const ATipo: Integer );
begin
  case ATipo of
    0: begin
      bImpririHijo:= False;
      lblTipo.Caption:= '';
      if bPromedios then
        lblTitulo.Caption:= 'TABLA COSTES DE ENVASADO PROMEDIO'
      else
        lblTitulo.Caption:= 'TABLA COSTES DE ENVASADO';
    end;
    1: begin
      bImpririHijo:= False;
      lblTipo.Caption:= '';
      lblmeses.Expression:= '[meses_seccion]';
      lblmedia.Expression:= '[media_seccion]';
      lbl01.Expression:= '[seccion12]';
      lbl02.Expression:= '[seccion11]';
      lbl03.Expression:= '[seccion10]';
      lbl04.Expression:= '[seccion09]';
      lbl05.Expression:= '[seccion08]';
      lbl06.Expression:= '[seccion07]';
      lbl07.Expression:= '[seccion06]';
      lbl08.Expression:= '[seccion05]';
      lbl09.Expression:= '[seccion04]';
      lbl10.Expression:= '[seccion03]';
      lbl11.Expression:= '[seccion02]';
      lbl12.Expression:= '[seccion01]';
      if bPromedios then
        lblTitulo.Caption:= 'TABLA COSTES DE SECCION PROMEDIO'
      else
        lblTitulo.Caption:= 'TABLA COSTES DE SECCION';
    end;
    2: begin
      bImpririHijo:= True;
      if bPromedios then
        lblTitulo.Caption:= 'TABLA COSTES DE ENVASADO Y SECCION PROMEDIO'
      else
        lblTitulo.Caption:= 'TABLA COSTES DE ENVASADO Y SECCION';
    end;
    3: begin
      bImpririHijo:= False;
      lblTipo.Caption:= '';
      lblmeses.Expression:= '[meses_total]';
      lblmedia.Expression:= '[media_total]';
      lbl01.Expression:= '[envase12]+[seccion12]';
      lbl02.Expression:= '[envase11]+[seccion11]';
      lbl03.Expression:= '[envase10]+[seccion10]';
      lbl04.Expression:= '[envase09]+[seccion09]';
      lbl05.Expression:= '[envase08]+[seccion08]';
      lbl06.Expression:= '[envase07]+[seccion07]';
      lbl07.Expression:= '[envase06]+[seccion06]';
      lbl08.Expression:= '[envase05]+[seccion05]';
      lbl09.Expression:= '[envase04]+[seccion04]';
      lbl10.Expression:= '[envase03]+[seccion03]';
      lbl11.Expression:= '[envase02]+[seccion02]';
      lbl12.Expression:= '[envase01]+[seccion01]';
      if bPromedios then
        lblTitulo.Caption:= 'TABLA COSTES DE ENVASADO MAS SECCION PROMEDIO'
      else
        lblTitulo.Caption:= 'TABLA COSTES DE ENVASADO MAS SECCION';
    end;
  end;
end;

procedure TQRTablaAnualCosteKgEnvasado.bndcSecionesBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= bImpririHijo;
end;

procedure TQRTablaAnualCosteKgEnvasado.SoloExcelPrint(sender: TObject;
  var Value: String);
begin
  if not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value:= '';
  end;
end;

procedure TQRTablaAnualCosteKgEnvasado.QRGroup2BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:=  not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQRTablaAnualCosteKgEnvasado.qrgrpProductoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= not ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) );
end;

procedure TQRTablaAnualCosteKgEnvasado.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  QRExpr1.AutoSize:= True;
  QRExpr2.AutoSize:= True;
  QRExpr3.AutoSize:= True;
  QRExpr4.AutoSize:= True;
  QRExpr5.AutoSize:= True;
  qrxpr1.AutoSize:= True;
  qrxpr2.AutoSize:= True;
  qrxpr3.AutoSize:= True;
  qrxpr4.AutoSize:= True;
  qrxpr5.AutoSize:= True;
  qrlblEmpresa.AutoSize:= True;
  qrlbl2.AutoSize:= True;
  qrlbl3.AutoSize:= True;
  qrlbl4.AutoSize:= True;
  qrlbl5.AutoSize:= True;
  qrlbl6.AutoSize:= True;
  qrlbl9.AutoSize:= True;
  qrlbl13.AutoSize:= True;
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    descripcion.AutoSize:= True;
    qrxpr7.AutoSize:= True;
    qrxpr8.AutoSize:= True;
    qrxpr9.AutoSize:= True;
  end
end;

procedure TQRTablaAnualCosteKgEnvasado.qrl4Print(sender: TObject;
  var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value:= '';
  end
  else
  begin
    Value:= 'Empresa/Centro/Producto/Agrupación/Artículo';
  end;
end;

procedure TQRTablaAnualCosteKgEnvasado.qrlbl7Print(sender: TObject;
  var Value: String);
begin
  if ( Exporting and ( Pos( 'XLS', UpperCase( ExportFilter.ClassName ) ) > 0 ) ) then
  begin
    Value:= 'Meses';
  end
  else
  begin
    Value:= 'Mes';
  end;
end;

end.
