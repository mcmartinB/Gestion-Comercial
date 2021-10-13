unit DMRecibirEntregasAlmacen;

interface

uses
  SysUtils, Classes, DB, DBTables, CheckLst;

type
  TFDMRecibirEntregasAlmacen = class(TDataModule)
    QEntregaCab: TQuery;
    QEntregaCabRemoto: TQuery;
    QEntregaLin: TQuery;
    QEntregaLinRemota: TQuery;
    DSEntregas: TDataSource;
    QEntregasPendientes: TQuery;
    QBorrarCabRemoto: TQuery;
    QBorrarLinRemoto: TQuery;
    QEntregaEntRemota: TQuery;
    QEntregaEnt: TQuery;
    QEntregaPalRemota: TQuery;
    QEntregaPal: TQuery;
    QBorrarEntRemoto: TQuery;
    QBorrarPalRemoto: TQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    function  RecibirEntrega( const ACodigo: string; var AMsg: string ): boolean;
    function  BorrarEntrega( const ACodigo: string ): boolean;
    function  HayEntregas( const ACodigo: String ): boolean;
    function  EstaGrabadaEntrega( var VModificable: Boolean ): boolean;

    function  GrabarEntrega( var AMsg: string ): boolean;
    procedure GrabarCabecera;
    procedure GrabarLineas;

    function  ModificarEntrega( var AMsg: String ): boolean;
    procedure ModificarCabecera;
    procedure ModificarLineas;


  public
    { Public declarations }
    function RecibirPendientes( const AEmpresa, ACentro: string; var ATotal: integer; var AMsg: TStringList ): integer;

    function RecibirEntregasMarcadas( AEntregas: TCheckListBox; var ATotal, AMarcados: integer; var AMsg: TStringList ): integer;
    function BorrarEntregasMarcadas( AEntregas: TCheckListBox; var ATotal, AMarcados: integer; var AMsg: TStringList ): integer;
  end;

implementation

uses UDMBaseDatos, bTextUtils;

{$R *.dfm}

procedure TFDMRecibirEntregasAlmacen.DataModuleDestroy(Sender: TObject);
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
  with QEntregaEntRemota do
  begin
    Close;
    if Prepared then
      Unprepare;
  end;
  with QEntregaPalRemota do
  begin
    Close;
    if Prepared then
      Unprepare;
  end;
  with QBorrarCabRemoto do
  begin
    Close;
    if Prepared then
      Unprepare;
  end;
  with QBorrarLinRemoto do
  begin
    Close;
    if Prepared then
      Unprepare;
  end;
  with QBorrarEntRemoto do
  begin
    Close;
    if Prepared then
      Unprepare;
  end;
  with QBorrarPalRemoto do
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
  with QEntregaEnt do
  begin
    Close;
    if Prepared then
      Unprepare;
  end;
  with QEntregaPal do
  begin
    Close;
    if Prepared then
      Unprepare;
  end;
end;

procedure TFDMRecibirEntregasAlmacen.DataModuleCreate(Sender: TObject);
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
    SQL.Add(' from aux_entregas_c ');
    SQL.Add(' where codigo_ec = :codigo ');
    if not Prepared then
      Prepare;
  end;
  with QEntregaLinRemota do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from aux_entregas_l ');
    SQL.Add(' where codigo_el = :codigo_ec ');
    if not Prepared then
      Prepare;
  end;
  with QEntregaEntRemota do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from aux_entregas_rel ');
    SQL.Add(' where codigo_er = :codigo_ec ');
    if not Prepared then
      Prepare;
  end;
  with QEntregaPalRemota do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from aux_palet_pb ');
    SQL.Add(' where entrega = :codigo_ec ');
    if not Prepared then
      Prepare;
  end;
  with QBorrarCabRemoto do
  begin
    SQL.Clear;
    SQL.Add(' delete ');
    SQL.Add(' from aux_entregas_c ');
    SQL.Add(' where codigo_ec = :codigo ');
    if not Prepared then
      Prepare;
  end;
  with QBorrarLinRemoto do
  begin
    SQL.Clear;
    SQL.Add(' delete ');
    SQL.Add(' from aux_entregas_l ');
    SQL.Add(' where codigo_el = :codigo ');
    if not Prepared then
      Prepare;
  end;
  with QBorrarEntRemoto do
  begin
    SQL.Clear;
    SQL.Add(' delete ');
    SQL.Add(' from aux_entregas_rel ');
    SQL.Add(' where codigo_er = :codigo ');
    if not Prepared then
      Prepare;
  end;
  with QBorrarPalRemoto do
  begin
    SQL.Clear;
    SQL.Add(' delete ');
    SQL.Add(' from aux_palet_pb ');
    SQL.Add(' where entrega = :codigo ');
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
  with QEntregaEnt do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_entregas_rel ');
    SQL.Add(' where codigo_er = :codigo_ec ');
    if not Prepared then
      Prepare;
  end;
  with QEntregaPal do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from rf_palet_pb ');
    SQL.Add(' where entrega = :codigo_ec ');
    if not Prepared then
      Prepare;
  end;
end;

function TFDMRecibirEntregasAlmacen.RecibirPendientes( const AEmpresa, ACentro: string;
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

function TFDMRecibirEntregasAlmacen.RecibirEntregasMarcadas( AEntregas: TCheckListBox; var ATotal, AMarcados: integer; var AMsg: TStringList ): integer;
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
        if RecibirEntrega( Copy( AEntregas.Items[i], 1, 12 ), sMsg ) then
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

function TFDMRecibirEntregasAlmacen.BorrarEntregasMarcadas( AEntregas: TCheckListBox; var ATotal, AMarcados: integer; var AMsg: TStringList ): integer;
var
  i: integer;
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
        if BorrarEntrega( Copy( AEntregas.Items[i], 1, 12 ) ) then
              result:= result + 1;
        AMarcados:= AMarcados + 1;
        AMsg.Add( AEntregas.Items[i] + ' OK'  );
      end;
      ATotal:= ATotal + 1;
    end;
    if AMarcados = 0 then
    begin
      AMsg.Add('No hay marcada ninguna entrega.');
    end;
  end;
end;

function TFDMRecibirEntregasAlmacen.RecibirEntrega( const ACodigo: string; var AMsg: string ): boolean;
var
  bModificable: boolean;
begin
  result:= false;
  if HayEntregas( ACodigo ) then
  begin
    try
      if not EstaGrabadaEntrega( bModificable ) then
      begin
        result:= GrabarEntrega( AMsg );
        if result then
          BorrarEntrega( ACodigo );
      end
      else
      begin
        if bModificable then
        begin
          result:= ModificarEntrega( AMsg );
          if result then
            BorrarEntrega( ACodigo );
        end
        else
        begin
          BorrarEntrega( ACodigo );
          AMsg:= ' ERROR - ENTREGA YA DESCARGADA.';
        end;
      end;
    finally
      QEntregaLin.Close;
      QEntregaEnt.Close;
      QEntregaPal.Close;
      QEntregaCab.Close;
      QEntregaLinRemota.Close;
      QEntregaEntRemota.Close;
      QEntregaPalRemota.Close;
      QEntregaCabRemoto.Close;
    end;
  end
  else
  begin
    AMsg:= 'ERROR - ENTREGA INEXISTENTE.';
  end;
end;

function TFDMRecibirEntregasAlmacen.BorrarEntrega( const ACodigo: string ): boolean;
begin
  with QBorrarLinRemoto do
  begin
    ParamByName( 'codigo' ).AsString:= ACodigo;
    ExecSQL;
  end;
  with QBorrarEntRemoto do
  begin
    ParamByName( 'codigo' ).AsString:= ACodigo;
    ExecSQL;
  end;
  with QBorrarPalRemoto do
  begin
    ParamByName( 'codigo' ).AsString:= ACodigo;
    ExecSQL;
  end;
  with QBorrarCabRemoto do
  begin
    ParamByName( 'codigo' ).AsString:= ACodigo;
    ExecSQL;
  end;
  result:= True;
end;

function TFDMRecibirEntregasAlmacen.HayEntregas( const ACodigo: String ): boolean;
begin
  with QEntregaCabRemoto do
  begin
    ParamByName('codigo').AsString:= ACodigo;
    Open;
    result:= not IsEmpty;
    if result then
    begin
      QEntregaLinRemota.Open;
      QEntregaEntRemota.Open;
      QEntregaPalRemota.Open;
      QEntregaCab.Open;
      QEntregaLin.Open;
      QEntregaEnt.Open;
      QEntregaPal.Open;
    end;
  end;
end;

function TFDMRecibirEntregasAlmacen.EstaGrabadaEntrega( var VModificable: boolean ): boolean;
begin
  result:= not QEntregaCab.IsEmpty;
  VModificable:= QEntregaCab.FieldByName('status_ec').AsInteger = 0;
end;

function TFDMRecibirEntregasAlmacen.GrabarEntrega( var AMsg: String ): boolean;
begin
  result:= False;
  if not DMBaseDatos.DBBaseDatos.InTransaction then
  begin
    try
      DMBaseDatos.DBBaseDatos.StartTransaction;
      GrabarCabecera;
      GrabarLineas;
      DMBaseDatos.DBBaseDatos.Commit;
      AMsg:= 'OK - NUEVA ENTREGA';
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

function TFDMRecibirEntregasAlmacen.ModificarEntrega( var AMsg: String ): boolean;
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
      AMsg:= 'OK - ENTREGA MODIFICADA';
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

procedure TFDMRecibirEntregasAlmacen.GrabarCabecera;
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

procedure TFDMRecibirEntregasAlmacen.ModificarCabecera;
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

procedure TFDMRecibirEntregasAlmacen.GrabarLineas;
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

  if not QEntregaEntRemota.IsEmpty then
  begin
    while not QEntregaEntRemota.Eof do
    begin
      QEntregaEnt.Insert;
      for i:= 0 to QEntregaEnt.FieldCount - 1 do
      begin
        if QEntregaEntRemota.FieldDefList.Find( QEntregaEnt.Fields[i].FieldName ) <> nil then
        begin
          QEntregaEnt.FieldByName( QEntregaEnt.Fields[i].FieldName ).Value:=
            QEntregaEntRemota.FieldByName( QEntregaEnt.Fields[i].FieldName ).Value;
        end;
      end;
      try
        QEntregaEnt.Post;
      except
        QEntregaEnt.Cancel;
        raise;
      end;
      QEntregaEntRemota.Next;
    end;
  end;

  if not QEntregaPalRemota.IsEmpty then
  begin
    while not QEntregaPalRemota.Eof do
    begin
      QEntregaPal.Insert;
      for i:= 0 to QEntregaPal.FieldCount - 1 do
      begin
        if QEntregaPalRemota.FieldDefList.Find( QEntregaPal.Fields[i].FieldName ) <> nil then
        begin
          QEntregaPal.FieldByName( QEntregaPal.Fields[i].FieldName ).Value:=
            QEntregaPalRemota.FieldByName( QEntregaPal.Fields[i].FieldName ).Value;
        end;
      end;
      try
        QEntregaPal.Post;
      except
        QEntregaPal.Cancel;
        raise;
      end;
      QEntregaPalRemota.Next;
    end;
  end;
end;

procedure TFDMRecibirEntregasAlmacen.ModificarLineas;
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

  while not QEntregaEnt.Eof do
  begin
    QEntregaEnt.Delete;
  end;
  if not QEntregaEntRemota.IsEmpty then
  begin
    while not QEntregaEntRemota.Eof do
    begin
      QEntregaEnt.Insert;
      for i:= 0 to QEntregaEnt.FieldCount - 1 do
      begin
        if QEntregaEntRemota.FieldDefList.Find( QEntregaEnt.Fields[i].FieldName ) <> nil then
        begin
          QEntregaEnt.FieldByName( QEntregaEnt.Fields[i].FieldName ).Value:=
            QEntregaEntRemota.FieldByName( QEntregaEnt.Fields[i].FieldName ).Value;
        end;
      end;
      try
        QEntregaEnt.Post;
      except
        QEntregaEnt.Cancel;
        raise;
      end;
      QEntregaEntRemota.Next;
    end;
  end;

  while not QEntregaPal.Eof do
  begin
    QEntregaPal.Delete;
  end;
  if not QEntregaPalRemota.IsEmpty then
  begin
    while not QEntregaPalRemota.Eof do
    begin
      QEntregaPal.Insert;
      for i:= 0 to QEntregaPal.FieldCount - 1 do
      begin
        if QEntregaPalRemota.FieldDefList.Find( QEntregaPal.Fields[i].FieldName ) <> nil then
        begin
          QEntregaPal.FieldByName( QEntregaPal.Fields[i].FieldName ).Value:=
            QEntregaPalRemota.FieldByName( QEntregaPal.Fields[i].FieldName ).Value;
        end;
      end;
      try
        QEntregaPal.Post;
      except
        QEntregaPal.Cancel;
        raise;
      end;
      QEntregaPalRemota.Next;
    end;
  end;
end;

end.
