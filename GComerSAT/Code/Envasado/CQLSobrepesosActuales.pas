unit CQLSobrepesosActuales;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQLSobrepesosActuales = class(TQuickRep)
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    PsQRSysData1: TQRSysData;
    PsQRLabel1: TQRLabel;
    codigo: TQRExpr;
    descripcion: TQRExpr;
    sobrepeso: TQRExpr;
    PsQRLabel5: TQRLabel;
    qrx1: TQRExpr;
    qrx2: TQRExpr;
    qrx3: TQRExpr;
    qrx4: TQRExpr;
    qrx5: TQRExpr;
    qrl1: TQRLabel;
    qrl2: TQRLabel;
    qrl3: TQRLabel;
    qrl4: TQRLabel;
    qrl5: TQRLabel;
    qrl6: TQRLabel;
  private

  public
    Empresa: string;
  end;

procedure SobrepesosActuales(const AOwner: TComponent; const AEmpresa: string);

implementation

{$R *.DFM}

uses CReportes, DPreview, UDMbaseDatos, bSQLUtils, UDMAuxDB, Dialogs,
  bTimeUtils, Variants;

function PreparaQuery(const AEmpresa: string): Boolean;
begin
  with DMBaseDatos.QListado do
  begin
    SQL.Clear;
    SQL.Add(' select producto_e producto, ');
    SQL.Add('        envase_e, ');
    SQL.Add('        descripcion_e, ');
    SQL.Add('        peso_Envase_e, peso_neto_e, unidades_e, ');
    SQL.Add('        ( select max((anyo_es * 100) + mes_es) ');
    SQL.Add('          from frf_env_sobrepeso ');
    SQL.Add('          where empresa_es = :empresa ');
    SQL.Add('          and envase_es = envase_e ');
    SQL.Add('          and producto_es = producto_e ) anyo_mes, ');
    SQL.Add('        ( select s1.peso_es ');
    SQL.Add('          from frf_env_sobrepeso s1 ');
    SQL.Add('          where s1.empresa_es = :empresa ');
    SQL.Add('          and s1.envase_es = envase_e ');
    SQL.Add('          and s1.producto_es = producto_e ');
    SQL.Add('          and (s1.anyo_es * 100) + s1.mes_es = ');
    SQL.Add('          ( ');
    SQL.Add('            select max( (s2.anyo_es * 100) + s2.mes_es) ');
    SQL.Add('            from frf_env_sobrepeso s2 ');
    SQL.Add('            where s2.empresa_es = :empresa ');
    SQL.Add('            and s2.envase_es = envase_e ');
    SQL.Add('            and s2.producto_es = producto_e ');
    SQL.Add('          ) ');
    SQL.Add('        ) sobrepeso ');
    SQL.Add(' from frf_envases ');
    SQL.Add(' where producto_e is not null ');
    SQL.Add(' and fecha_baja_e is null ');

    SQL.Add(' UNION ');

        SQL.Add(' select producto_e  producto, ');
    SQL.Add('        envase_e, ');
    SQL.Add('        descripcion_e, ');
    SQL.Add('        peso_Envase_e, peso_neto_e, unidades_e, ');
    SQL.Add('        ( select max( (s1.anyo_es * 100) + s1.mes_es) ');
    SQL.Add('          from frf_env_sobrepeso s1 ');
    SQL.Add('          where s1.empresa_es = :empresa ');
    SQL.Add('          and s1.envase_es = envase_e ');
    SQL.Add('          and s1.producto_es = producto_es ) anyo_mes, ');
    SQL.Add('        nvl( ( select s1.peso_es ');
    SQL.Add('          from frf_env_sobrepeso s1 ');
    SQL.Add('          where s1.empresa_es = :empresa ');
    SQL.Add('          and s1.envase_es = envase_e ');
    SQL.Add('          and s1.producto_es = producto_e ');
    SQL.Add('          and (s1.anyo_es * 100) + s1.mes_es = ');
    SQL.Add('            ( select max( (s2.anyo_es * 100) + s2.mes_es) ');
    SQL.Add('              from frf_env_sobrepeso s2 ');
    SQL.Add('              where s2.empresa_es = :empresa ');
    SQL.Add('              and s2.envase_es = envase_e ');
    SQL.Add('              and s2.producto_es = producto_es ) ');
    SQL.Add('        ), 0) sobrepeso ');
    SQL.Add(' from frf_env_sobrepeso, frf_envases ');
    SQL.Add(' where empresa_es = :empresa ');
    SQL.Add(' and envase_e = envase_es ');
    SQL.Add(' and producto_e is null ');
    SQL.Add(' and fecha_baja_e is null ');
    SQL.Add(' group by 1,2,3,4,5,6,7,8 ');
    SQL.Add(' order by 1,2,3 ');

    ParamByname('empresa').AsString:= AEmpresa;

    Open;
    result := not IsEmpty;
    if not Result then Close
  end;
end;

procedure SobrepesosActuales(const AOwner: TComponent; const AEmpresa: string);
var
  QLSobrepesosActuales: TQLSobrepesosActuales;
begin
  if PreparaQuery( AEmpresa ) then
  begin
    QLSobrepesosActuales := TQLSobrepesosActuales.Create( AOwner );
    PonLogoGrupoBonnysa(QLSobrepesosActuales, AEmpresa);
    QLSobrepesosActuales.Empresa := AEmpresa;
    Preview(QLSobrepesosActuales);
    DMBaseDatos.QListado.Close;
  end
  else
  begin
    ShowMessage('Listado sin datos.');
  end;
end;

end.
