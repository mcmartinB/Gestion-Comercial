unit DMRecepcionEntregas;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TDMRecepcionEntregasForm = class(TDataModule)
    QEntregasCab: TQuery;
    QEntregasCabRemoto: TQuery;
    QEntregasLin: TQuery;
    QEntregasLinRemota: TQuery;
    DSEntregas: TDataSource;
    QEntregasPendientes: TQuery;
    DSEntregasPendientes: TDataSource;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    sError: String;

    procedure GrabarCabecera( const AFechaLlegada: TDateTime );
    procedure GrabarLineas;
  public
    { Public declarations }
    procedure EntregasPendientes( const AEmpresa, ACentro: string );
    function  HayEntregas( const AEmpresa, ACentro: String;
                const AFechaCarga: TDateTime; const AConduce: String ): boolean;
    function  EstaGrabadaEntrega: boolean;
    function  GrabarEntrega( const AFechaLlegada: TDateTime ): boolean;
    function  MensajeError: string;
  end;

implementation

uses UDMBaseDatos, bTextUtils;

{$R *.dfm}

procedure TDMRecepcionEntregasForm.DataModuleDestroy(Sender: TObject);
begin
  with QEntregasPendientes do
  begin
    Close;
    if Prepared then
      Unprepare;
  end;
  with QEntregasCabRemoto do
  begin
    Close;
    if Prepared then
      Unprepare;
  end;
  with QEntregasLinRemota do
  begin
    Close;
    if Prepared then
      Unprepare;
  end;
  with QEntregasCab do
  begin
    Close;
    if Prepared then
      Unprepare;
  end;
  with QEntregasLin do
  begin
    Close;
    if Prepared then
      Unprepare;
  end;
end;

procedure TDMRecepcionEntregasForm.DataModuleCreate(Sender: TObject);
begin
  with QEntregasPendientes do
  begin
    SQL.Clear;
    SQL.Add(' select adjudicacion_ec fact_conduce, fecha_carga_ec fecha_carga, codigo_ec codigo');
    SQL.Add(' from frf_entregas_c ');
    SQL.Add(' where empresa_ec = :empresa ');
    SQL.Add('   and centro_llegada_ec = :centro ');
    SQL.Add('   and nvl(fecha_llegada_ec,'''') = '''' ');
    SQL.Add(' order by 2 desc, 1 ');
    if not Prepared then
      Prepare;
  end;
  with QEntregasCabRemoto do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_entregas_c ');
    SQL.Add(' where empresa_ec = :empresa ');
    SQL.Add(' and centro_llegada_ec = :centro ');
    SQL.Add(' and fecha_carga_ec = :fecha ');
    SQL.Add(' and adjudicacion_ec = :conduce ');
    if not Prepared then
      Prepare;
  end;
  with QEntregasLinRemota do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_entregas_l ');
    SQL.Add(' where codigo_el = :codigo_ec ');
    if not Prepared then
      Prepare;
  end;
  with QEntregasCab do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_entregas_c ');
    SQL.Add(' where codigo_ec = :codigo_ec ');
    if not Prepared then
      Prepare;
  end;
  with QEntregasLin do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_entregas_l ');
    if not Prepared then
      Prepare;
  end;
end;

procedure TDMRecepcionEntregasForm.EntregasPendientes( const AEmpresa, ACentro: string );
begin
  with QEntregasPendientes do
  begin
    Close;
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    Open;
  end;
end;

function TDMRecepcionEntregasForm.HayEntregas( const AEmpresa, ACentro: String;
  const AFechaCarga: TDateTime; const AConduce: String ): boolean;
begin
  with QEntregasCabRemoto do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fecha').AsDateTime:= AFechaCarga;
    ParamByName('conduce').AsString:= AConduce;
    Open;
    result:= not IsEmpty;
    if result then
    begin
      QEntregasLinRemota.Open;
      QEntregasCab.Open;
      QEntregasLin.Open;
    end;
  end;
end;

function TDMRecepcionEntregasForm.EstaGrabadaEntrega: boolean;
begin
  result:= not QEntregasCab.IsEmpty;
end;

function TDMRecepcionEntregasForm.GrabarEntrega( const AFechaLlegada: TDateTime ): boolean;
begin
  if not DMBaseDatos.DBBaseDatos.InTransaction then
  begin
    try
      DMBaseDatos.DBBaseDatos.StartTransaction;
      GrabarCabecera( AFechaLlegada );
      GrabarLineas;
      DMBaseDatos.DBBaseDatos.Commit;
      result:= True;
    except
      on e: exception do
      begin
        sError:= e.Message;
        DMBaseDatos.DBBaseDatos.Rollback;
        result:= False;
      end;
    end;
  end
  else
  begin
    raise Exception.Create( 'No puedo realizar los cambios al no poder abrir una transaccion.');
  end;
end;

procedure TDMRecepcionEntregasForm.GrabarCabecera( const AFechaLlegada: TDateTime );
var
  i: integer;
begin
  QEntregasCab.Insert;
  for i:= 0 to QEntregasCab.FieldCount - 1 do
  begin
    if QEntregasCab.FieldByName( QEntregasCab.Fields[i].FieldName ).CanModify then
    begin
      QEntregasCab.FieldByName( QEntregasCab.Fields[i].FieldName ).Value:=
        QEntregasCabRemoto.FieldByName( QEntregasCab.Fields[i].FieldName ).Value;
    end;
    QEntregasCab.FieldByName( 'fecha_llegada_ec' ).AsDateTime:= AFechaLlegada;
  end;
  try
    QEntregasCab.Post;
  except
    QEntregasCab.Cancel;
    raise;
  end;

  QEntregasCabRemoto.Edit;
  QEntregasCabRemoto.FieldByName( 'fecha_llegada_ec' ).AsDateTime:= AFechaLlegada;
  try
    QEntregasCabRemoto.Post;
  except
    QEntregasCabRemoto.Cancel;
    raise;
  end;
end;

procedure TDMRecepcionEntregasForm.GrabarLineas;
var
  i: integer;
begin
  if not QEntregasLinRemota.IsEmpty then
  begin
    while not QEntregasLinRemota.Eof do
    begin
      QEntregasLin.Insert;
      for i:= 0 to QEntregasLin.FieldCount - 1 do
      begin
        if QEntregasLinRemota.FieldDefList.Find( QEntregasLin.Fields[i].FieldName ) <> nil then
        begin
          QEntregasLin.FieldByName( QEntregasLin.Fields[i].FieldName ).Value:=
            QEntregasLinRemota.FieldByName( QEntregasLin.Fields[i].FieldName ).Value;
        end;
      end;
      try
        QEntregasLin.Post;
      except
        QEntregasLin.Cancel;
        raise;
      end;
      QEntregasLinRemota.Next;
    end;
  end;
end;

function TDMRecepcionEntregasForm.MensajeError: string;
begin
  result:= Rellena( QEntregasCabRemoto.FieldByName('codigo_ec').AsString, 12, ' ', taLeftJustify) +
           sError;
end;

end.
