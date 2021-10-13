unit CostesDeEnvasadoResumenReport;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQRCostesDeEnvasadoResumen = class(TQuickRep)
    DetailBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    PsQRSysData1: TQRSysData;
    qrlblTitulo: TQRLabel;
    codigo: TQRExpr;
    QRGroup1: TQRGroup;
    descripcion: TQRExpr;
    QRGroup2: TQRGroup;
    PsQRLabel5: TQRLabel;
    PsQRLabel7: TQRLabel;
    lblPeriodo: TQRLabel;
    lblCentro: TQRLabel;
    QRExpr2: TQRExpr;
    QRExpr4: TQRExpr;
    QRLabel1: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    qrxProducto: TQRExpr;
    qrxDesProducto: TQRExpr;
    qrxEmpresa: TQRExpr;
    qrxCentro: TQRExpr;
    qrx1: TQRExpr;
    qrx2: TQRExpr;
    qrl1: TQRLabel;
    qrl2: TQRLabel;
    qrl3: TQRLabel;
    qrl4: TQRLabel;
    qrl5: TQRLabel;
    procedure qrxDesProductoPrint(sender: TObject; var Value: String);
    procedure descripcionPrint(sender: TObject; var Value: String);
    procedure QRExpr2Print(sender: TObject; var Value: String);
    procedure QRExpr4Print(sender: TObject; var Value: String);
  private

  public
    Empresa: string;

  end;

procedure QRCostesDeEnvasadoResumenPrint(const AEmpresa, ACentro, AProducto: string;
  const AFechaIni, AFechaFin: TDate; const APromedios: boolean );
implementation

{$R *.DFM}

uses CReportes, DPreview, UDMbaseDatos, bSQLUtils, UDMAuxDB, Dialogs,
  bTimeUtils, Variants, DB, bMath, CGlobal;


function PreparaQuery(const AEmpresa, ACentro, AProducto: string;
  const AFechaIni, AFechaFin: TDate; const APromedios: boolean ): Boolean;
var
  iPBase: integer;
  iAnyoIni, iMesINi, iDia, iAnyoFin, iMesFin: word;
begin
  //--Todos los productos
  //--Todos los centros
  with DMBaseDatos.QListado do
  begin
    SQL.Clear;
    if Trim(AProducto) <> '' then
    begin
      SQL.Add(' select producto_base_p ');
      SQL.Add(' from frf_productos ');
      SQL.Add(' where producto_p = :producto ');
      ParamByName('producto').AsString := AProducto;
      Open;
      if not IsEmpty then
        iPBase:= FieldByName('producto_base_p').AsInteger
      else
        iPBase:= -1;
      Close;
    end
    else
    begin
      iPBase:= -1;
    end;

    DecodeDate( AFechaIni, iAnyoIni, iMesINi, iDia );
    DecodeDate( AFechaFin, iAnyoFin, iMesFin, iDia );

    SQL.Clear;
    SQL.Add(' select empresa_ec, centro_ec, producto_ec, envase_ec, ');
    if gProgramVersion = pvSAT then
    begin
      if not APromedios then
      begin
        SQL.Add('        sum(( material_ec + coste_ec )) coste_envases, ');
        SQL.Add('        sum( case when nvl( material_ec + coste_ec, 0 ) <> 0 then 1 else 0 end ) meses_envases, ');
        SQL.Add('        sum(secciones_ec) coste_secciones, ');
        SQL.Add('        sum( case when nvl( secciones_ec, 0 ) <> 0 then 1 else 0 end ) meses_secciones ');
      end
      else
      begin
        SQL.Add('        sum(( pmaterial_ec + pcoste_ec )) coste_envases, ');
        SQL.Add('        sum( case when nvl( pmaterial_ec + pcoste_ec, 0 ) <> 0 then 1 else 0 end ) meses_envases, ');
        SQL.Add('        sum(psecciones_ec) coste_secciones, ');
        SQL.Add('        sum( case when nvl( psecciones_ec, 0 ) <> 0 then 1 else 0 end ) meses_secciones ');
      end;
    end
    else
    begin
      SQL.Add('        sum(material_ec) coste_envases, ');
      SQL.Add('        sum( case when nvl( material_ec, 0 ) <> 0 then 1 else 0 end ) meses_envases, ');
      SQL.Add('        sum(personal_ec + general_ec) coste_secciones, ');
      SQL.Add('        sum( case when nvl( personal_ec + general_ec, 0 ) <> 0 then 1 else 0 end ) meses_secciones ');
    end;


    SQL.Add(' from frf_env_costes ');
    SQL.Add(' where empresa_ec = :empresa ');
    SQL.Add(' and centro_ec = :centro ');

    if AProducto <> '' then
      SQL.Add(' and producto_ec = :producto ');

    SQL.Add(' and ( anyo_ec > :anyo_ini or ( anyo_ec = :anyo_ini and mes_ec >= :mes_ini ) ) ');
    SQL.Add(' and ( anyo_ec < :anyo_fin or ( anyo_ec = :anyo_fin and mes_ec <= :mes_fin ) ) ');

    SQL.Add(' group by empresa_ec, centro_ec, producto_ec, envase_ec ');
    SQL.Add(' order by empresa_ec, centro_ec, producto_ec, envase_ec  ');

    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('centro').AsString := ACentro;
    ParamByName('anyo_ini').AsInteger := iAnyoIni;
    ParamByName('mes_ini').AsInteger := iMesINi;
    ParamByName('anyo_fin').AsInteger := iAnyoFin;
    ParamByName('mes_fin').AsInteger := iMesFin;
    if AProducto <> '' then
      ParamByName('producto').asString := AProducto;

    Open;
    result := not IsEmpty;
    if not Result then
      Close
  end;
end;

procedure QRCostesDeEnvasadoResumenPrint(const AEmpresa, ACentro, AProducto: string;
  const AFechaIni, AFechaFin: TDate; const APromedios: boolean);
var
  QRCostesDeEnvasadoResumen: TQRCostesDeEnvasadoResumen;
begin
  if PreparaQuery(AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin, APromedios) then
  begin
    QRCostesDeEnvasadoResumen := TQRCostesDeEnvasadoResumen.Create(nil);
    PonLogoGrupoBonnysa(QRCostesDeEnvasadoResumen, AEmpresa);
    if not APromedios then
      QRCostesDeEnvasadoResumen.qrlblTitulo.Caption:= 'RESUMEN COSTES DE ENVASADO'
    else
      QRCostesDeEnvasadoResumen.qrlblTitulo.Caption:= 'RESUMEN COSTES DE ENVASADO PROMEDIO';
    QRCostesDeEnvasadoResumen.Empresa := AEmpresa;
    QRCostesDeEnvasadoResumen.lblPeriodo.Caption :=
      'Desde ' + DateToStr(AFechaIni) + ' hasta ' + DateToStr(AFechaFin);
    QRCostesDeEnvasadoResumen.lblCentro.Caption := desCentro(AEmpresa, ACentro);
    Preview(QRCostesDeEnvasadoResumen);
    DMBaseDatos.QListado.Close;
  end
  else
  begin
    ShowMessage('Listado sin datos.');
  end;
end;

procedure TQRCostesDeEnvasadoResumen.qrxDesProductoPrint(sender: TObject;
  var Value: String);
begin
  Value:=  desProducto( Empresa, Value );
end;

procedure TQRCostesDeEnvasadoResumen.descripcionPrint(sender: TObject;
  var Value: String);
begin
  Value:=  desEnvase( Empresa, Value );
end;

procedure TQRCostesDeEnvasadoResumen.QRExpr2Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('meses_envases').AsInteger <> 0 then
    Value:= FormatFloat( '#,##0.0000', DataSet.FieldByName('coste_envases').asfloat /
                                       DataSet.FieldByName('meses_envases').asfloat )
  else
    Value:= FormatFloat( '#,##0.0000', 0 ) ;
end;

procedure TQRCostesDeEnvasadoResumen.QRExpr4Print(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByName('meses_secciones').AsInteger <> 0 then
    Value:= FormatFloat( '#,##0.0000', DataSet.FieldByName('coste_secciones').asfloat /
                                       DataSet.FieldByName('meses_secciones').asfloat )
  else
    Value:= FormatFloat( '#,##0.0000', 0 ) ;
end;

end.
