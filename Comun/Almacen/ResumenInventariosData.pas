unit ResumenInventariosData;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable, DBClient;

type
  TDMResumenInventarios = class(TDataModule)
    QInventarios: TQuery;
    cdsResumen2: TClientDataSet;
    strngfldResumenempresa: TStringField;
    strngfldResumencentro: TStringField;
    strngfldResumenproducto: TStringField;
    dtfldResumenfecha: TDateField;
    fltfldResumencampo: TFloatField;
    fltfldResumenintermedia1: TFloatField;
    fltfldResumenintermedia2: TFloatField;
    fltfldResumentercera: TFloatField;
    fltfldResumendestrio: TFloatField;
    fltfldResumenexpedicion_c1: TFloatField;
    fltfldResumenexpedicion_c2: TFloatField;
    fltfldResumenprimera: TFloatField;
    fltfldResumensegunda: TFloatField;
    strngfldResumendes_envase: TStringField;
    cdsResumen2envase: TStringField;
    cdsResumen: TClientDataSet;
    cdsResumenempresa: TStringField;
    cdsResumencentro: TStringField;
    cdsResumenproducto: TStringField;
    cdsResumenfecha: TDateField;
    cdsResumencampo: TFloatField;
    cdsResumenintermedia1: TFloatField;
    cdsResumenintermedia2: TFloatField;
    cdsResumentercera: TFloatField;
    cdsResumendestrio: TFloatField;
    cdsResumenenvase: TStringField;
    cdsResumendes_envase: TStringField;
    cdsResumenexpedicion_c1: TFloatField;
    cdsResumenexpedicion_c2: TFloatField;
    cdsResumenprimera: TFloatField;
    cdsResumensegunda: TFloatField;
  private
    { Private declarations }
    sEmpresa, sCentro, sProducto, sAgrupacion: string;
    dFechaIni: TDateTime;
    iTipo: integer;

    procedure PreparaQuerys;

    function  ObtenerDatos( var AMsg: string ): boolean;
    function  GrabarDatos( var AMsg: string ): boolean;
    function  GrabarResumen( var AMsg: string ): boolean;

  public
    { Public declarations }
  end;

  function ExecuteResumenInventarios( const AOwner: TComponent;
                                    const AEmpresa, ACentro, AProducto, AAgrupacion: string;
                                    const AFechaIni: TDateTime; const iATipo: integer;
                                    var AMsg: string  ): boolean;


implementation

{$R *.dfm}

uses
  ResumenInventariosReport, DetalleInventariosReport, bMath;

var
  DMResumenInventarios: TDMResumenInventarios;

function ExecuteResumenInventarios( const AOwner: TComponent;
                                  const AEmpresa, ACentro, AProducto, AAgrupacion: string;
                                  const AFechaIni: TDateTime; const iATipo: integer;
                                  var AMsg: string  ): boolean;
begin
  DMResumenInventarios:= TDMResumenInventarios.Create( AOwner );

  //CODIGO
  try
    with DMResumenInventarios do
    begin
      sEmpresa:= AEmpresa;
      sCentro:= ACentro;
      sProducto:= AProducto;
      sAgrupacion:=AAgrupacion;
      dFechaIni:= AFechaIni;
      iTipo:= iATipo;

      PreparaQuerys;
      result:= ObtenerDatos( AMsg );
      if result then
      begin
        cdsResumen.Open;
        try
          if iATipo = 0 then
          begin
            result:= GrabarResumen( AMsg );
            if result then
            begin
              cdsResumen.IndexFieldNames:='empresa;centro;producto;fecha';
              ResumenInventariosReport.PrintResumenInventarios( AOwner, AEmpresa, ACentro, AProducto, AFechaIni, iATipo );
            end;
          end
          else
          begin
            result:= GrabarDatos( AMsg );
            if result then
            begin
              cdsResumen.IndexFieldNames:='empresa;centro;producto;fecha;envase';
              DetalleInventariosReport.PrintDetalleInventarios( AOwner, AEmpresa, ACentro, AProducto, AFechaIni, iATipo );
            end;
          end;
        except
            cdsResumen.Close;
        end;
      end;
    end;
  finally
    FreeAndNil( DMResumenInventarios );
  end;
end;


procedure TDMResumenInventarios.PreparaQuerys;
begin
  with QInventarios do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_ic empresa, centro_ic centro, producto_ic producto, fecha_ic fecha, ');
    SQL.Add(' kilos_cec_ic campo, kilos_cim_c1_ic + kilos_cia_c1_ic intermedia1, ');
    SQL.Add('        kilos_cim_c2_ic + kilos_cia_c2_ic intermedia2, kilos_zd_c3_ic tercera, kilos_zd_d_ic destrio, ');
    SQL.Add('        envase_il envase, descripcion_e des_envase, ');
    SQL.Add('        kilos_ce_c1_il expedicion_c1, kilos_ce_c2_il expedicion_c2 ');

    SQL.Add(' from frf_inventarios_c ');
    SQL.Add('      left join frf_inventarios_l on empresa_ic = empresa_il and centro_ic = centro_il and ');
    SQL.Add('                                producto_ic = producto_il and fecha_ic = fecha_il ');
    SQL.Add('      left join frf_envases on envase_e = envase_il ');

    SQL.Add(' where fecha_ic = :fecha ');

    if ( sEmpresa = 'BAG' )  then
      SQL.Add(' and substr(empresa_ic) = ''F'' ')
    else
    if ( sEmpresa = 'SAT' ) then
      SQL.Add(' and ( empresa_ic = ''080'' or empresa_ic = ''050'' )')
    else
      SQL.Add(' and empresa_ic = :empresa ');
    if ( sCentro <> '' )  then
      SQL.Add(' and centro_ic = :centro ');
    if ( sProducto <> '' )  then
      SQL.Add(' and producto_ic = :producto ');
    if sAgrupacion <> '' then
      SQl.Add(' and producto_ic in (select producto_a from frf_agrupacion where codigo_a = :agrupacion) ');

  end;
end;


function TDMResumenInventarios.ObtenerDatos( var AMsg: string ): boolean;
begin
  result:= True;

  with QInventarios do
  begin
    if ( sEmpresa <> 'BAG' ) and ( sEmpresa <> 'SAT' ) then
      ParamByName('empresa').AsString:= sEmpresa;
    if ( sCentro <> '' )  then
      ParamByName('centro').AsString:= sCentro;
    if ( sProducto <> '' )  then
      ParamByName('producto').AsString:= sProducto;
    ParamByName('fecha').AsdateTime:= dFechaIni;
    if sAgrupacion <> '' then
      ParamByName('agrupacion').AsString := sAgrupacion;

    Open;
    if IsEmpty then
    begin
      result:= false;
      AMsg:= 'Falta el inventario del d�a "' + FormatDateTime( 'dd/mm/yyyy', dFechaIni ) + '"';
    end;
  end;
end;


function TDMResumenInventarios.GrabarDatos( var AMsg: string ): boolean;
begin
  while not QInventarios.Eof do
  begin
    with cdsResumen do
    begin
      Insert;

      FieldByName('empresa').Asstring:= QInventarios.FieldByName('empresa').Asstring;
      FieldByName('centro').Asstring:= QInventarios.FieldByName('centro').Asstring;
      FieldByName('producto').Asstring:= QInventarios.FieldByName('producto').Asstring;
      FieldByName('fecha').AsDateTime:= QInventarios.FieldByName('fecha').AsDateTime;

      FieldByName('campo').AsFloat:= QInventarios.FieldByName('campo').AsFloat;
      FieldByName('intermedia1').AsFloat:= QInventarios.FieldByName('intermedia1').AsFloat;
      FieldByName('intermedia2').AsFloat:= QInventarios.FieldByName('intermedia2').AsFloat;
      FieldByName('tercera').AsFloat:= QInventarios.FieldByName('tercera').AsFloat;
      FieldByName('destrio').AsFloat:= QInventarios.FieldByName('destrio').AsFloat;

      FieldByName('envase').Asstring:= QInventarios.FieldByName('envase').Asstring;
      FieldByName('des_envase').Asstring:= QInventarios.FieldByName('des_envase').Asstring;
      FieldByName('expedicion_c1').AsFloat:= QInventarios.FieldByName('expedicion_c1').AsFloat;
      FieldByName('expedicion_c2').AsFloat:= QInventarios.FieldByName('expedicion_c2').AsFloat;

      //FieldByName('primera').AsFloat, 0, False);
      //FieldByName('segunda').AsFloat, 0, False);
      Post;
    end;
    QInventarios.Next;
  end;
  QInventarios.Close;
  result:= true;
end;


function TDMResumenInventarios.GrabarResumen( var AMsg: string ): boolean;
var
  sLinea, sAux: string;
begin
  sLinea:= '';
  while not QInventarios.Eof do
  begin
    sAux:= QInventarios.FieldByName('empresa').Asstring +
           QInventarios.FieldByName('centro').Asstring +
           QInventarios.FieldByName('producto').Asstring +
           QInventarios.FieldByName('fecha').Asstring;
    if sLinea <> sAux then
    begin
      sLinea:=  sAux;
      with cdsResumen do
      begin
        Insert;

        FieldByName('empresa').Asstring:= QInventarios.FieldByName('empresa').Asstring;
        FieldByName('centro').Asstring:= QInventarios.FieldByName('centro').Asstring;
        FieldByName('producto').Asstring:= QInventarios.FieldByName('producto').Asstring;
        FieldByName('fecha').AsDateTime:= QInventarios.FieldByName('fecha').AsDateTime;

        FieldByName('campo').AsFloat:= QInventarios.FieldByName('campo').AsFloat;
        FieldByName('intermedia1').AsFloat:= QInventarios.FieldByName('intermedia1').AsFloat;
        FieldByName('intermedia2').AsFloat:= QInventarios.FieldByName('intermedia2').AsFloat;
        FieldByName('tercera').AsFloat:= QInventarios.FieldByName('tercera').AsFloat;
        FieldByName('destrio').AsFloat:= QInventarios.FieldByName('destrio').AsFloat;

        FieldByName('expedicion_c1').AsFloat:= QInventarios.FieldByName('expedicion_c1').AsFloat;
        FieldByName('expedicion_c2').AsFloat:= QInventarios.FieldByName('expedicion_c2').AsFloat;

        Post;
      end;
    end
    else
    begin
      with cdsResumen do
      begin
        Edit;

        FieldByName('expedicion_c1').AsFloat:= FieldByName('expedicion_c1').AsFloat + QInventarios.FieldByName('expedicion_c1').AsFloat;
        FieldByName('expedicion_c2').AsFloat:= FieldByName('expedicion_c2').AsFloat + QInventarios.FieldByName('expedicion_c2').AsFloat;

        Post;
      end;
    end;

    QInventarios.Next;
  end;
  QInventarios.Close;
  result:= true;
end;


end.
