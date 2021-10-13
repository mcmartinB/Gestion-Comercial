unit UEntradaDatos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, DBTables, ComCtrls, ExtCtrls, Buttons, BSpeedButton,
  BGridButton, BEdit, BDEdit, Grids, DBGrids, BGrid, ActnList, DError;

type
  TFEntradaDatos = class(TForm)
    Panel: TPanel;
    MonthCalendar: TMonthCalendar;
    rbtTodos: TRadioButton;
    rbtDia: TRadioButton;
    QMaestro: TQuery;
    QDetalle: TQuery;
    QDestino: TQuery;
    DSMaestro: TDataSource;
    QOrigen: TQuery;
    mmoResultado: TMemo;
    Label1: TLabel;
    DbSGPLosLlanos: TDatabase;
    lbl1: TLabel;
    lblLEmpresa_p: TLabel;
    BGBEmpresa: TBGridButton;
    STEmpresa: TStaticText;
    ECentro: TBEdit;
    btnCentro: TBGridButton;
    STCentro: TStaticText;
    RejillaFlotante: TBGrid;
    EEmpresa: TBEdit;
    actlstListaAcciones: TActionList;
    actBAceptar: TAction;
    actBCancelar: TAction;
    actADesplegarRejilla: TAction;
    btnTransferir: TSpeedButton;
    btnCerrar: TSpeedButton;
    procedure btnTransferirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnCerrarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rbtTodosClick(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure DesplegarRejillaExecute(Sender: TObject);
  private
    { Private declarations }
    fecha, hora: String;
    fechaInicio, fechaFin: String;
    slPasados: TStringList;

    procedure BorrarAlbaranDestino;
    procedure PasarAlbaran;
    procedure MarcarAlbaranOrigen;

    procedure PreparaQuerys;

    function  AbrirBDSGP( var AMsg: string ): boolean;
    procedure CerrarBDSGP;

    function CamposVacios: boolean;

  public
    { Public declarations }
  end;

implementation

uses bSQLUtils, UDMBaseDatos, CVariables, UDMAuxDB, CAuxiliarDB;

{$R *.dfm}

function  TFEntradaDatos.AbrirBDSGP( var AMsg: string ): boolean;
begin
    if not DbSGPLosLlanos.Connected then
    begin
      try
        DbSGPLosLlanos.Connected:= true;
      except
        on e: Exception do
        begin
          AMsg:= 'ERROR';
          AMsg:= AMsg + #13 + #10 + 'No puedo conectar con la base de datos del Sistema de Gestión de Planta.';
          AMsg:= AMsg + #13 + #10 + e.Message;
        end;
      end;
    end;
    result:= DbSGPLosLlanos.Connected;
end;

function TFEntradaDatos.CamposVacios: boolean;
begin
  Result := False;
  if (EEmpresa.Text <> '') and (stEmpresa.Caption = '')  then
  begin
    ShowError('Falta o es incorrecto el código del empresa.');
    EEmpresa.SetFocus;
    Result := True;
    Exit;
  end;

  if (stEmpresa.Caption <> '') and (stCentro.Caption = '') then
  begin
    ShowError('Falta o es incorrecto el código del centro.');
    ECentro.SetFocus;
    Result := True;
    Exit;
  end;
end;

procedure TFEntradaDatos.CerrarBDSGP;
begin
  if DbSGPLosLlanos.Connected then
  begin
    DbSGPLosLlanos.CloseDataSets;
    DbSGPLosLlanos.Close;
  end;
end;

procedure TFEntradaDatos.PonNombre(Sender: TObject);
begin
  if (gRF <> nil) then
    if esVisible( gRF ) then
      Exit;
  case TComponent(Sender).Tag of
    kEmpresa:
    begin
      STEmpresa.Caption := desEmpresa(Eempresa.Text);
      if STEmpresa.Caption  <> '' then
      begin
      ECentro.ReadOnly := False;
      PonNombre( ECentro );
      end
      else
      begin
        ECentro.Text := '';
        ECentro.ReadOnly := True;
      end;
    end;
    kCentro:
    begin
      stCentro.Caption := desCentro(Eempresa.Text, ECentro.Text);
    end;
  end;
end;

procedure TFEntradaDatos.btnTransferirClick(Sender: TObject);
var
  errores: boolean;
  registros, insertados: integer;
  sMsg: string;
begin
  slPasados.Clear;

  if CamposVacios then Exit;

  if not AbrirBDSGP( sMsg ) then
  begin
    mmoResultado.Lines.Clear;
    mmoResultado.Lines.Add( sMsg );
    Exit;
  end;

  Panel.Enabled:= false;
  Cursor:= crHourGlass;

  registros:= 0;
  insertados:= 0;

  if rbtDia.Checked then
  begin
    fechaInicio:= DateToStr(MonthCalendar.Date);
    fechaFin:= DateToStr(MonthCalendar.Date + 1);
  end;
  PreparaQuerys;

  errores:= false;
  QMaestro.Open;
  QMaestro.First;
  if not QMaestro.IsEmpty then
  begin
    QDetalle.Open;
    while not QMaestro.Eof do
    begin
      if DMBaseDatos.DBBaseDatos.InTransaction then
      begin
        ShowMessage('Transaccion ya abierta, no puedo pasar los datos.');
        QMaestro.Close;
        QDetalle.Close;
        Exit
      end;
      try
        DMBaseDatos.DBBaseDatos.StartTransaction;
        fecha:= DateOfDT(QMaestro.FieldByName('FechaGrabacion').AsDateTime);
        hora:= TimeOfDT(QMaestro.FieldByName('FechaGrabacion').AsDateTime,False);

        //El cosechero 0 creo que es la entrada de fruta verde,
        //no tener en cuenta
        if ( QMaestro.FieldByName('IdCosechero').AsInteger <> 0 ) or
           ( ( QMaestro.FieldByName('IdCosechero').AsInteger = 0 ) and
             (( QMaestro.FieldByName('IdPlantacion').AsInteger = 999 ) or ( QMaestro.FieldByName('IdPlantacion').AsInteger = 998 ) or ( QMaestro.FieldByName('IdPlantacion').AsInteger = 997 ) ) ) then
        begin
          Inc( registros);
          BorrarAlbaranDestino;
          PasarAlbaran;
          Inc( insertados);
        end;
        DMBaseDatos.DBBaseDatos.Commit;

        slPasados.Add( QMaestro.FieldByName('IdEmpresa').AsString + ' ' +
          QMaestro.FieldByName('IdCentro').AsString  + ' ' +
          QMaestro.FieldByName('NumAlbaran').AsString + ' ' +
          QMaestro.FieldByName('FechaGrabacion').AsString );

        MarcarAlbaranOrigen;
      except
        errores:= true;
        DMBaseDatos.DBBaseDatos.Rollback;
      end;
      QMaestro.Next;
    end;
    QDetalle.Close;
  end;
  QMaestro.Close;

  mmoResultado.Lines.Clear;
  mmoResultado.Lines.Add( 'Resultado');
  if errores then
  begin
    ShowMessage( 'PROCESO FINALIZADO CON ERRORES.');
    mmoResultado.Lines.Add( 'PROCESO FINALIZADO CON ERRORES.');
    mmoResultado.Lines.Add( 'Entradas pasadas correctamente:');
    mmoResultado.Lines.AddStrings( slPasados );
  end
  else
  begin
    if registros = 0 then
    begin
      ShowMessage( 'No hay datos en la base de datos destino.');
      mmoResultado.Lines.Add( 'No hay datos en la base de datos destino.');
    end
    else
    begin
      ShowMessage( 'Proceso finalizado correctamente.');
      mmoResultado.Lines.Add( 'Proceso finalizado correctamente.');
      mmoResultado.Lines.AddStrings( slPasados );
    end;
  end;
  if registros > 0 then
  begin
    if registros <> insertados then
    begin
      mmoResultado.Lines.Add( IntToStr(insertados) + ' albaranes de ' + IntToStr(registros) + ' fueron insertados correctamente.');
    end
    else
    begin
      mmoResultado.Lines.Add( IntToStr(registros) + ' albaranes fueron insertados correctamente.');
    end;
  end;

  Panel.Enabled:= true;
  Cursor:= crDefault;
end;

procedure TFEntradaDatos.PreparaQuerys;
begin
  with QMaestro do
  begin
    SQL.Clear;
    SQL.Add(' select maestro.IdEmpresa, maestro.IdCentro, maestro.NumAlbaran, ');
    SQL.Add('        maestro.FechaGrabacion, maestro.IdTransporte, maestro.IdCosechero, ');
    SQL.Add('        maestro.IdPlantacion, maestro.IdAnyoSemana, maestro.IdProductoBase, ');
    SQL.Add('        maestro.PesoBrutoVehiculo, ');
    SQL.Add('        count( distinct IdPalet ) NumPalets, --maestro.NumPalets, ');
    SQL.Add('        SUM(detalle.NumCajasPalet) NumCajas,  -- maestro.NumCajas, ');
    SQL.Add('        SUM(detalle.PesoBrutoPalet) PesoBruto, SUM(detalle.PesoNetoPalet) PesoNeto,  ');
    SQL.Add('        maestro.Sector, maestro.Observaciones, maestro.tipoentrada ');

    SQL.Add(' from ALBARAN_CAMPO_CAB maestro, ALBARAN_CAMPO_DET detalle ');

    SQL.Add(' where maestro.IdEmpresa = detalle.IdEmpresa ');
    SQL.Add('   and maestro.IdCentro = detalle.IdCentro ');
    SQL.Add('   and maestro.NumAlbaran = detalle.NumAlbaran ');
    if rbtDia.Checked then
    begin
      SQL.Add('   and maestro.FechaGrabacion ' + SQLEQUALD(fechaInicio,'>'));
      SQL.Add('   and maestro.FechaGrabacion ' + SQLEQUALD(fechaFin,'<'));
    end;
    SQL.Add('   and maestro.status is null ');

    if Trim( EEmpresa.Text ) <> '' then
      SQl.Add(' and maestro.IdEmpresa = ' + QuotedStr(EEmpresa.Text) );
    if Trim( ECentro.Text ) <> '' then
      SQl.Add(' and maestro.IDCentro = ' + QuotedStr(ECentro.Text) );

    SQL.Add(' group by maestro.IdEmpresa, maestro.IdCentro, maestro.NumAlbaran, ');
    SQL.Add('          maestro.FechaGrabacion, maestro.IdTransporte, maestro.IdCosechero, ');
    SQL.Add('          maestro.IdPlantacion, maestro.IdAnyoSemana, maestro.IdProductoBase, ');
    SQL.Add('          maestro.PesoBrutoVehiculo, ');
    SQL.Add('          maestro.Sector, maestro.Observaciones, maestro.tipoentrada ');
    SQL.Add(' order by maestro.IdEmpresa, maestro.IdCentro, ');
    SQL.Add('          maestro.FechaGrabacion desc, maestro.NumAlbaran ');
  end;
  with QDetalle do
  begin
    SQL.Clear;
    SQL.Add(' select maestro.IdEmpresa, maestro.IdCentro, maestro.NumAlbaran, ');
    SQL.Add('        maestro.FechaGrabacion, detalle.FechaEntrada, ');
    SQL.Add('        maestro.IdTransporte, maestro.IdCosechero, maestro.IdPlantacion, ');
    SQL.Add('        maestro.IdAnyoSemana, detalle.IdPalet, maestro.IdProductoBase, ');
    SQL.Add('        detalle.NumCajasPalet ');

    SQL.Add(' from ALBARAN_CAMPO_CAB maestro, ALBARAN_CAMPO_DET detalle ');

    SQL.Add(' where maestro.IdEmpresa = :IdEmpresa ');
    SQL.Add('   and maestro.IdCentro = :IdCentro ');
    SQL.Add('   and maestro.NumAlbaran = :NumAlbaran ');
    SQL.Add('   and maestro.IdEmpresa = detalle.IdEmpresa ');
    SQL.Add('   and maestro.IdCentro = detalle.IdCentro ');
    SQL.Add('   and maestro.NumAlbaran = detalle.NumAlbaran ');
  end;
end;

procedure TFEntradaDatos.FormCreate(Sender: TObject);
begin
  EEmpresa.Tag := kEmpresa;
  ECentro.Tag := kCentro;

  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  MonthCalendar.Date:= Date;
  slPasados:= TStringList.Create;

  ECentro.ReadOnly := True;
end;

procedure TFEntradaDatos.PasarAlbaran;
begin
  //insertar cabecera
  QDestino.SQL.Clear;
  QDestino.SQL.Add(' insert into frf_entradas_c (empresa_ec, centro_ec, numero_entrada_ec, ' );
  QDestino.SQL.Add('        producto_ec, fecha_ec, hora_ec, transportista_ec, total_cajas_ec, ' );
  QDestino.SQL.Add('        total_palets_ec, peso_bruto_ec, peso_neto_ec) ');
  QDestino.SQL.Add(' values ( ');
  QDestino.SQL.Add('        ' + SQLString(QMaestro.FieldByName('IdEmpresa').AsString) + ',');
  QDestino.SQL.Add('        ' + SQLString(QMaestro.FieldByName('IdCentro').AsString) + ',');
  QDestino.SQL.Add('        ' + SQLNumeric(QMaestro.FieldByName('NumAlbaran').AsString) + ',');
  QDestino.SQL.Add('        ' + SQLString(QMaestro.FieldByName('IdProductoBase').AsString) + ',');
  QDestino.SQL.Add('        ' + SQLDate(fecha) + ',');
  QDestino.SQL.Add('        ' + SQLString(hora) + ',');
  QDestino.SQL.Add('        ' + SQLNumeric(QMaestro.FieldByName('IdTransporte').AsString) + ',');
  QDestino.SQL.Add('        ' + SQLNumeric(QMaestro.FieldByName('NumCajas').AsString) + ',');
  QDestino.SQL.Add('        ' + SQLNumeric(QMaestro.FieldByName('NumPalets').AsString) + ',');

  if QMaestro.FieldByName('PesoBrutoVehiculo').AsInteger = 0 then
    QDestino.SQL.Add('        ' + SQLNumeric(QMaestro.FieldByName('PesoBruto').AsString) + ',')
  else
    QDestino.SQL.Add('        ' + SQLNumeric(QMaestro.FieldByName('PesoBrutoVehiculo').AsString) + ',');

  QDestino.SQL.Add('        ' + SQLNumeric(QMaestro.FieldByName('PesoNeto').AsString));
  //QDestino.SQL.Add('        NULL, ');
  //QDestino.SQL.Add('        ' + SQLNumeric(QMaestro.FieldByName('Observaciones').AsString) );
  QDestino.SQL.Add(' ) ');
  QDestino.ExecSQL;

  //insertar detalle resumen
  QDestino.SQL.Clear;
  QDestino.SQL.Add(' insert into frf_entradas2_l values ( ');
  QDestino.SQL.Add('        ' + SQLString(QMaestro.FieldByName('IdEmpresa').AsString) + ',');
  QDestino.SQL.Add('        ' + SQLString(QMaestro.FieldByName('IdCentro').AsString) + ',');
  QDestino.SQL.Add('        ' + SQLNumeric(QMaestro.FieldByName('NumAlbaran').AsString) + ',');
  QDestino.SQL.Add('        ' + SQLDate(fecha) + ',');
  QDestino.SQL.Add('        ' + SQLNumeric(QMaestro.FieldByName('IdCosechero').AsString) + ',');
  QDestino.SQL.Add('        ' + SQLNumeric(QMaestro.FieldByName('IdPlantacion').AsString) + ',');
  QDestino.SQL.Add('        ' + SQLString(QMaestro.FieldByName('IdAnyoSemana').AsString) + ',');
  QDestino.SQL.Add('        ' + SQLNumeric(QMaestro.FieldByName('NumCajas').AsString) + ',');
  QDestino.SQL.Add('        ' + SQLNumeric(QMaestro.FieldByName('PesoNeto').AsString) + ',');
  QDestino.SQL.Add('        ' + SQLString(QMaestro.FieldByName('IdProductoBase').AsString) + ',');
  QDestino.SQL.Add('        ' + SQLString(QMaestro.FieldByName('Sector').AsString));
  QDestino.SQL.Add(' ) ');
  QDestino.ExecSQL;

  if ( QMaestro.FieldByName('tipoentrada').AsInteger = 1 ) or
     ( QMaestro.FieldByName('tipoentrada').AsInteger = 3 ) then
  begin
    QDestino.SQL.Clear;
    QDestino.SQL.Add(' insert into frf_escandallo values ( ');
    QDestino.SQL.Add('        ' + SQLString(QMaestro.FieldByName('IdEmpresa').AsString) + ',');
    QDestino.SQL.Add('        ' + SQLString(QMaestro.FieldByName('IdCentro').AsString) + ',');
    QDestino.SQL.Add('        ' + SQLNumeric(QMaestro.FieldByName('NumAlbaran').AsString) + ',');
    QDestino.SQL.Add('        ' + SQLDate(fecha) + ',');
    QDestino.SQL.Add('        ' + SQLNumeric(QMaestro.FieldByName('IdCosechero').AsString) + ',');
    QDestino.SQL.Add('        ' + SQLNumeric(QMaestro.FieldByName('IdPlantacion').AsString) + ',');
    QDestino.SQL.Add('        ' + SQLString(QMaestro.FieldByName('IdAnyoSemana').AsString) + ',');
    QDestino.SQL.Add('        ' + SQLString(QMaestro.FieldByName('IdProductoBase').AsString) + ',');

    //Tipo entrada
    if ( QMaestro.FieldByName('tipoentrada').AsInteger = 1 ) then
      QDestino.SQL.Add('        1,')
    else
    if ( QMaestro.FieldByName('tipoentrada').AsInteger = 3 ) then
      QDestino.SQL.Add('        2,')
    else
      QDestino.SQL.Add('        0,');

    //Porcentajes
    if ( QMaestro.FieldByName('tipoentrada').AsInteger = 1 ) then
      QDestino.SQL.Add('        100,')
    else
      QDestino.SQL.Add('        0,');
    QDestino.SQL.Add('        0,');
    if ( QMaestro.FieldByName('tipoentrada').AsInteger = 3 ) then
      QDestino.SQL.Add('        100,')
    else
      QDestino.SQL.Add('        0,');
    QDestino.SQL.Add('        0,');

    QDestino.SQL.Add('        0,');
    QDestino.SQL.Add('        0,');
    QDestino.SQL.Add('        0,');
    QDestino.SQL.Add('        0,');
    QDestino.SQL.Add('        0');


    QDestino.SQL.Add(' ) ');
    QDestino.ExecSQL;
  end;

  QDetalle.First;
  while not QDetalle.Eof do
  begin
    hora:= TimeOfDT(QDetalle.FieldByName('FechaEntrada').AsDateTime,False);
    //insertar linea almacen
    QDestino.SQL.Clear;
    QDestino.SQL.Add(' insert into frf_entradas1_l ( ');
    QDestino.SQL.Add('          empresa_e1l, centro_e1l, numero_entrada_e1l, fecha_e1l, hora_e1l, transportista_e1l, cosechero_e1l, ');
    QDestino.SQL.Add('          plantacion_e1l, ano_sem_planta_e1l, codigo_palet_e1l, producto_e1l, total_cajas_e1l ');
    QDestino.SQL.Add('        ) values ( ');
    QDestino.SQL.Add('        ' + SQLString(QDetalle.FieldByName('IdEmpresa').AsString) + ',');
    QDestino.SQL.Add('        ' + SQLString(QDetalle.FieldByName('IdCentro').AsString) + ',');
    QDestino.SQL.Add('        ' + SQLNumeric(QDetalle.FieldByName('NumAlbaran').AsString) + ',');
    QDestino.SQL.Add('        ' + SQLDate(fecha) + ',');
    QDestino.SQL.Add('        ' + SQLString(hora) + ',');
    QDestino.SQL.Add('        ' + SQLNumeric(QDetalle.FieldByName('IdTransporte').AsString) + ',');
    QDestino.SQL.Add('        ' + SQLNumeric(QDetalle.FieldByName('IdCosechero').AsString) + ',');
    QDestino.SQL.Add('        ' + SQLNumeric(QDetalle.FieldByName('IdPlantacion').AsString) + ',');
    QDestino.SQL.Add('        ' + SQLString(QDetalle.FieldByName('IdAnyoSemana').AsString) + ',');
    QDestino.SQL.Add('        ' + SQLString(QDetalle.FieldByName('IdPalet').AsString) + ',');
    QDestino.SQL.Add('        ' + SQLString(QDetalle.FieldByName('IdProductoBase').AsString) + ',');
    QDestino.SQL.Add('        ' + SQLNumeric(QDetalle.FieldByName('NumCajasPalet').AsString) );
    QDestino.SQL.Add(' ) ');
    QDestino.ExecSQL;

    QDetalle.Next;
  end;
end;

procedure TFEntradaDatos.MarcarAlbaranOrigen;
begin
  QOrigen.SQL.Clear;
  QOrigen.SQL.Add(' update ALBARAN_CAMPO_CAB ');
  QOrigen.SQL.Add(' set status = 1 ');
  QOrigen.SQL.Add(' where IdEmpresa ' + SQLEqualS(QMaestro.FieldbyName('IdEmpresa').AsString) );
  QOrigen.SQL.Add('   and IdCentro '  + SQLEqualS(QMaestro.FieldbyName('IdCentro').AsString) );
  QOrigen.SQL.Add('   and NumAlbaran ' + SQLEqualN(QMaestro.FieldbyName('NumAlbaran').AsString) );
  QOrigen.ExecSql;

  QOrigen.SQL.Clear;
  QOrigen.SQL.Add(' update ALBARAN_CAMPO_DET ');
  QOrigen.SQL.Add(' set status = 1 ');
  QOrigen.SQL.Add(' where IdEmpresa ' + SQLEqualS(QMaestro.FieldbyName('IdEmpresa').AsString) );
  QOrigen.SQL.Add('   and IdCentro '  + SQLEqualS(QMaestro.FieldbyName('IdCentro').AsString) );
  QOrigen.SQL.Add('   and NumAlbaran ' + SQLEqualN(QMaestro.FieldbyName('NumAlbaran').AsString) );
  QOrigen.ExecSql;
end;

procedure TFEntradaDatos.DesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kCentro: DespliegaRejilla(btnCentro, [EEmpresa.Text]);
  end;
end;

procedure TFEntradaDatos.BorrarAlbaranDestino;
begin
  QDestino.SQL.Clear;
  QDestino.SQL.Add(' delete from frf_entradas_c ');
  QDestino.SQL.Add(' where empresa_ec ' + SQLEqualS(QMaestro.FieldbyName('IdEmpresa').AsString) );
  QDestino.SQL.Add('   and centro_ec '  + SQLEqualS(QMaestro.FieldbyName('IdCentro').AsString) );
  QDestino.SQL.Add('   and numero_entrada_ec ' + SQLEqualN(QMaestro.FieldbyName('NumAlbaran').AsString) );
  QDestino.SQL.Add('   and fecha_ec '  + SQLEqualD(fecha) );
  QDestino.ExecSql;

  if QDestino.RowsAffected <> 0 then
  begin
    QDestino.SQL.Clear;
    QDestino.SQL.Add(' delete from frf_entradas1_l ');
    QDestino.SQL.Add(' where empresa_e1l ' + SQLEqualS(QMaestro.FieldbyName('IdEmpresa').AsString) );
    QDestino.SQL.Add('   and centro_e1l '  + SQLEqualS(QMaestro.FieldbyName('IdCentro').AsString) );
    QDestino.SQL.Add('   and numero_entrada_e1l ' + SQLEqualN(QMaestro.FieldbyName('NumAlbaran').AsString) );
    QDestino.SQL.Add('   and fecha_e1l '  + SQLEqualD(fecha) );
    QDestino.ExecSql;

    QDestino.SQL.Clear;
    QDestino.SQL.Add(' delete from frf_entradas2_l ');
    QDestino.SQL.Add(' where empresa_e2l ' + SQLEqualS(QMaestro.FieldbyName('IdEmpresa').AsString) );
    QDestino.SQL.Add('   and centro_e2l '  + SQLEqualS(QMaestro.FieldbyName('IdCentro').AsString) );
    QDestino.SQL.Add('   and numero_entrada_e2l ' + SQLEqualN(QMaestro.FieldbyName('NumAlbaran').AsString) );
    QDestino.SQL.Add('   and fecha_e2l '  + SQLEqualD(fecha) );
    QDestino.ExecSql;
  end;
end;

procedure TFEntradaDatos.BtnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFEntradaDatos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  gRF := nil;
  FreeAndNil( slPasados );
  CerrarBDSGP;
  Action:= caFree;
end;

procedure TFEntradaDatos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    $0D, $28: //vk_return,vk_down
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
        Exit;
      end;
    $26: //vk_up
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
        Exit;
      end;
  end;
end;

procedure TFEntradaDatos.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F1: btnTransferir.Click;
    VK_ESCAPE: BtnCerrar.Click;
  end;
end;

procedure TFEntradaDatos.rbtTodosClick(Sender: TObject);
begin
  if rbtTodos.Checked then
  begin
    MonthCalendar.Enabled:= False;
    MonthCalendar.Visible:= False;
  end
  else
  begin
    MonthCalendar.Enabled:= True;
    MonthCalendar.Visible:= True;
  end;
end;

end.
