unit DMRecibirEntregasCentral;

interface

uses
  SysUtils, Classes, DB, DBTables, CheckLst;

type
  TFDMRecibirEntregasCentral = class(TDataModule)
    QEntregaCab: TQuery;
    QEntregaCabRemoto: TQuery;
    QEntregaLin: TQuery;
    QEntregaLinRemota: TQuery;
    DSEntregas: TDataSource;
    QEntregasPendientes: TQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    function  RecibirEntrega( const ACodigo: string; var AMsg: string ): boolean;
    function  HayEntregas( const ACodigo: String ): boolean;
    function  EstaGrabadaEntrega( var VModificable: boolean ): boolean;

    function  GrabarEntrega( var AMsg: string ): boolean;
    procedure GrabarCabecera;
    procedure GrabarLineas;

    function  ModificarEntrega( var AMsg: String ): boolean;
    procedure ModificarCabecera;
    procedure ModificarLineas;

    procedure MarcarComoEnviada( const ACodigo: string );
    procedure MarcarEnvio;
  public
    { Public declarations }
    function RecibirPendientes( const AEmpresa, ACentro: string; var ATotal: integer; var AMsg: TStringList ): integer;
    function RecibirEntregasMarcadas( AEntregas: TCheckListBox; var ATotal, AMarcados: integer; var AMsg: TStringList ): integer;
    function MarcarComoEnviadas( AEntregas: TCheckListBox; var ATotal: integer; var AMsg: TStringList ): integer;

  end;

implementation

uses UDMBaseDatos, bTextUtils, CVariables;

{$R *.dfm}

procedure TFDMRecibirEntregasCentral.DataModuleDestroy(Sender: TObject);
begin
  with QEntregasPendientes do
  begin
    Close;
    if Prepared then
      Unprepare;
  end;
  with QEntregaCabRemoto do
  begin
    Close;
    if Prepared then
      Unprepare;
  end;
  with QEntregaLinRemota do
  begin
    Close;
    if Prepared then
      Unprepare;
  end;
  with QEntregaCab do
  begin
    Close;
    if Prepared then
      Unprepare;
  end;
  with QEntregaLin do
  begin
    Close;
    if Prepared then
      Unprepare;
  end;
end;

procedure TFDMRecibirEntregasCentral.DataModuleCreate(Sender: TObject);
begin
  with QEntregasPendientes do
  begin
    SQL.Clear;
    //SQL.Add(' select codigo_ec codigo, proveedor_ec proveedor, almacen_ec almacen, albaran_ec albaran, ');
    //SQL.Add('        fecha_carga_ec carga, fecha_llegada_ec llegada, adjudicacion_ec conduce, vehiculo_ec vehiculo ');
    SQL.Add(' select codigo_ec ');
    SQL.Add(' from frf_entregas_c ');
    SQL.Add(' where empresa_ec = :empresa ');
    SQL.Add(' and centro_llegada_ec = :centro ');
    SQL.Add(' and centro_origen_ec = :centro ');
    SQL.Add('   and nvl(envio_ec,0) = 0 ');
    SQL.Add(' order by 1 desc');
    if not Prepared then
      Prepare;
  end;
  with QEntregaCabRemoto do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_entregas_c ');
    SQL.Add(' where codigo_ec = :codigo ');
    if not Prepared then
      Prepare;
  end;
  with QEntregaLinRemota do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_entregas_l ');
    SQL.Add(' where codigo_el = :codigo_ec ');
    if not Prepared then
      Prepare;
  end;
  with QEntregaCab do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_entregas_c ');
    SQL.Add(' where codigo_ec = :codigo_ec ');
    if not Prepared then
      Prepare;
  end;
  with QEntregaLin do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_entregas_l ');
    SQL.Add(' where codigo_el = :codigo_ec ');
    if not Prepared then
      Prepare;
  end;
end;

function TFDMRecibirEntregasCentral.RecibirPendientes( const AEmpresa, ACentro: string;
            var ATotal: integer; var AMsg: TStringList ): integer;
var
  sMsg: String;
begin
  ATotal:= 0;
  result:= 0;

  with QEntregasPendientes do
  begin
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    Open;
    try
      if IsEmpty then
      begin
        AMsg.Add('No hay entregas pendientes de recibir.');
      end
      else
      begin
        while not Eof do
        begin
          if RecibirEntrega( FieldByname('codigo_ec').AsString, sMsg ) then
            result:= result + 1;
          ATotal:= ATotal + 1;
          AMsg.Add( FieldByname('codigo_ec').AsString + ' '  + sMsg );
         Next;
        end;
      end;
    finally
      Close;
    end;
  end;
end;

function TFDMRecibirEntregasCentral.RecibirEntregasMarcadas( AEntregas: TCheckListBox; var ATotal, AMarcados: integer; var AMsg: TStringList ): integer;
var
  i: integer;
  sMsg: String;
begin
  ATotal:= 0;
  result:= 0;
  AMarcados:= 0;

  if AEntregas.Items.Count = 0 then
  begin
    AMsg.Add('No hay entregas pendientes de recibir.');
  end
  else
  begin
    for i:= 0 to AEntregas.Items.Count - 1 do
    begin
      if AEntregas.Checked[i] then
      begin
        if RecibirEntrega( AEntregas.Items[i], sMsg ) then
              result:= result + 1;
        AMarcados:= AMarcados + 1;
        AMsg.Add( AEntregas.Items[i] + ' '  + sMsg );
      end;
      ATotal:= ATotal + 1;
    end;
    if AMarcados = 0 then
    begin
      AMsg.Add('No hay marcada ninguna entrega para recibir.');
    end;
  end;
end;

function TFDMRecibirEntregasCentral.RecibirEntrega( const ACodigo: string; var AMsg: string ): boolean;
var
  bModificable: boolean;
begin
  if HayEntregas( ACodigo ) then
  begin
    try
      if not EstaGrabadaEntrega( bModificable ) then
      begin
        result:= GrabarEntrega( AMsg );
        if result then
          MarcarEnvio;
      end
      else
      begin
        if bModificable then
        begin
          result:= ModificarEntrega( AMsg );
          if result then
            MarcarEnvio;
        end
        else
        begin
          MarcarEnvio;
          AMsg:= 'Ya existe la entrega  "' + ACodigo + '" en la Base de Datos de destino.';
          result:= false;
        end;
      end;
    finally
      QEntregaLin.Close;
      QEntregaCab.Close;
      QEntregaLinRemota.Close;
      QEntregaCabRemoto.Close;
    end;
  end
  else
  begin
    result:= false;
    AMsg:= 'No existe la entrega  "' + ACodigo + '" en la Base de Datos de origen.';
  end;
end;

function TFDMRecibirEntregasCentral.MarcarComoEnviadas( AEntregas: TCheckListBox; var ATotal: integer; var AMsg: TStringList ): integer;
var
  i: integer;
begin
  ATotal:= 0;
  result:= 0;

  if AEntregas.Items.Count = 0 then
  begin
    AMsg.Add('No hay entregas pendientes de recibir.');
  end
  else
  begin
    for i:= 0 to AEntregas.Items.Count - 1 do
    begin
      if AEntregas.Checked[i] then
      begin
        MarcarComoEnviada( AEntregas.Items[i] );
        result:= result + 1;
        AMsg.Add( AEntregas.Items[i] + ' OK'  );
      end;
      ATotal:= ATotal + 1;
    end;
    if result = 0 then
    begin
      AMsg.Add('No hay marcada ninguna entrega.');
    end;
  end;
end;

procedure TFDMRecibirEntregasCentral.MarcarComoEnviada( const ACodigo: string );
begin
  if HayEntregas( ACodigo ) then
  begin
    try
      MarcarEnvio;
    finally
      QEntregaLin.Close;
      QEntregaCab.Close;
      QEntregaLinRemota.Close;
      QEntregaCabRemoto.Close;
    end;
  end;
end;

procedure TFDMRecibirEntregasCentral.MarcarEnvio;
begin
  QEntregaCabRemoto.Edit;
  QEntregaCabRemoto.FieldByName( 'envio_ec' ).AsInteger:= 1;
  try
    QEntregaCabRemoto.Post;
  except
    QEntregaCabRemoto.Cancel;
    raise;
  end;
end;

function TFDMRecibirEntregasCentral.HayEntregas( const ACodigo: String ): boolean;
begin
  with QEntregaCabRemoto do
  begin
    ParamByName('codigo').AsString:= ACodigo;
    Open;
    result:= not IsEmpty;
    if result then
    begin
      QEntregaLinRemota.Open;
      QEntregaCab.Open;
      QEntregaLin.Open;
    end;
  end;
end;

function TFDMRecibirEntregasCentral.EstaGrabadaEntrega( var VModificable: boolean ): boolean;
begin
  result:= not QEntregaCab.IsEmpty;
  VModificable:= QEntregaCab.FieldByName('status_ec').AsInteger = 0;
end;

function TFDMRecibirEntregasCentral.GrabarEntrega( var AMsg: String ): boolean;
begin
  result:= False;
  if not DMBaseDatos.DBBaseDatos.InTransaction then
  begin
    try
      DMBaseDatos.DBBaseDatos.StartTransaction;
      GrabarCabecera;
      GrabarLineas;
      DMBaseDatos.DBBaseDatos.Commit;
      AMsg:= 'OK';
      result:= True;
    except
      on e: exception do
      begin
        AMsg:=e.Message;
        DMBaseDatos.DBBaseDatos.Rollback;
      end;
    end;
  end
  else
  begin
    AMsg:='No puedo realizar los cambios al no poder abrir una transaccion.';
  end;
end;

function TFDMRecibirEntregasCentral.ModificarEntrega( var AMsg: String ): boolean;
begin
  result:= False;
  if not DMBaseDatos.DBBaseDatos.InTransaction then
  begin
    try
      DMBaseDatos.DBBaseDatos.StartTransaction;
      ModificarLineas;
      ModificarCabecera;
      DMBaseDatos.DBBaseDatos.Commit;
      //BorrarEntregaTemporal( ACodigo );
      AMsg:= 'OK';
      result:= True;
    except
      on e: exception do
      begin
        AMsg:=e.Message;
        DMBaseDatos.DBBaseDatos.Rollback;
      end;
    end;
  end
  else
  begin
    AMsg:='No puedo realizar los cambios al no poder abrir una transaccion.';
  end;
end;

procedure TFDMRecibirEntregasCentral.GrabarCabecera;
var
  i: integer;
begin
  QEntregaCab.Insert;
  for i:= 0 to QEntregaCab.FieldCount - 1 do
  begin
    if QEntregaCab.FieldByName( QEntregaCab.Fields[i].FieldName ).CanModify then
    begin
      QEntregaCab.FieldByName( QEntregaCab.Fields[i].FieldName ).Value:=
        QEntregaCabRemoto.FieldByName( QEntregaCab.Fields[i].FieldName ).Value;
    end;
  end;
  try
    QEntregaCab.Post;
  except
    QEntregaCab.Cancel;
    raise;
  end;
end;

procedure TFDMRecibirEntregasCentral.ModificarCabecera;
var
  i: integer;
begin
  QEntregaCab.Edit;
  QEntregaCab.FieldByName('albaran_ec').AsString:= QEntregaCabRemoto.FieldByName('albaran_ec').AsString;
  QEntregaCab.FieldByName('fecha_llegada_ec').AsDateTime:= QEntregaCabRemoto.FieldByName('fecha_llegada_ec').AsDateTime;
  QEntregaCab.FieldByName('vehiculo_ec').AsString:= QEntregaCabRemoto.FieldByName('vehiculo_ec').AsString;
  QEntregaCab.FieldByName('peso_entrada_ec').AsFloat:= QEntregaCabRemoto.FieldByName('peso_entrada_ec').AsFloat;
  QEntregaCab.FieldByName('peso_salida_ec').AsFloat:= QEntregaCabRemoto.FieldByName('peso_salida_ec').AsFloat;
  QEntregaCab.FieldByName('status_ec').AsInteger:= QEntregaCabRemoto.FieldByName('status_ec').AsInteger;
  QEntregaCab.FieldByName('envio_ec').AsInteger:= QEntregaCabRemoto.FieldByName('envio_ec').AsInteger;
  try
    QEntregaCab.Post;
  except
    QEntregaCab.Cancel;
    raise;
  end;
end;

procedure TFDMRecibirEntregasCentral.GrabarLineas;
var
  i: integer;
begin
  if not QEntregaLinRemota.IsEmpty then
  begin
    while not QEntregaLinRemota.Eof do
    begin
      QEntregaLin.Insert;
      for i:= 0 to QEntregaLin.FieldCount - 1 do
      begin
        if QEntregaLinRemota.FieldDefList.Find( QEntregaLin.Fields[i].FieldName ) <> nil then
        begin
          QEntregaLin.FieldByName( QEntregaLin.Fields[i].FieldName ).Value:=
            QEntregaLinRemota.FieldByName( QEntregaLin.Fields[i].FieldName ).Value;
        end;
      end;
      try
        QEntregaLin.Post;
      except
        QEntregaLin.Cancel;
        raise;
      end;
      QEntregaLinRemota.Next;
    end;
  end;
end;

procedure TFDMRecibirEntregasCentral.ModificarLineas;
var
  i: integer;
begin
  while not QEntregaLin.Eof do
  begin
    QEntregaLin.Delete;
  end;
  if not QEntregaLinRemota.IsEmpty then
  begin
    while not QEntregaLinRemota.Eof do
    begin
      QEntregaLin.Insert;
      for i:= 0 to QEntregaLin.FieldCount - 1 do
      begin
        if QEntregaLinRemota.FieldDefList.Find( QEntregaLin.Fields[i].FieldName ) <> nil then
        begin
          QEntregaLin.FieldByName( QEntregaLin.Fields[i].FieldName ).Value:=
            QEntregaLinRemota.FieldByName( QEntregaLin.Fields[i].FieldName ).Value;
        end;
      end;
      try
        QEntregaLin.Post;
      except
        QEntregaLin.Cancel;
        raise;
      end;
      QEntregaLinRemota.Next;
    end;
  end;
end;

end.
