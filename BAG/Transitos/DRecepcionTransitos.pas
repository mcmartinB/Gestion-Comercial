unit DRecepcionTransitos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, nbEdits, nbCombos, Buttons, nbLabels;

type
  TFDRecepcionTransitos = class(TForm)
    edtPlantaOrigen: TnbDBSQLCombo;
    edtCentroOrigen: TnbDBSQLCombo;
    fechaSalida: TnbDBCalendarCombo;
    lblPlantaOrigen: TnbLabel;
    lblCentroOrigen: TnbLabel;
    nbLabel3: TnbLabel;
    nbLabel4: TnbLabel;
    nReferencia: TnbDBNumeric;
    stPlantaOrigen: TnbStaticText;
    stCentroOrigen: TnbStaticText;
    btnOk: TSpeedButton;
    btnCancel: TSpeedButton;
    lblMessage: TLabel;
    lblPlantaDestino: TnbLabel;
    lblCentroDestino: TnbLabel;
    edtPlantaDestino: TnbDBSQLCombo;
    edtCentroDestino: TnbDBSQLCombo;
    stPlantaDestino: TnbStaticText;
    stCentroDestino: TnbStaticText;
    procedure BtnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function edtCentroOrigenGetSQL: String;
    function stPlantaOrigenGetDescription: String;
    procedure edtPlantaOrigenChange(Sender: TObject);
    procedure edtCentroOrigenChange(Sender: TObject);
    function stCentroOrigenGetDescription: String;
    procedure BtnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    function edtCentroDestinoGetSQL: String;
    function stPlantaDestinoGetDescription: String;
    function stCentroDestinoGetDescription: String;
    procedure edtPlantaDestinoChange(Sender: TObject);
    procedure edtCentroDestinoChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure RecepcionFruta( const APlantaOrigen, ACentroOrigen: String;
                              const APlantaDestino, ACentroDestino: String;
                              const AFecha: TDate; const AReferencia: String );
    function HaSidoRecibido( const AEmpresa, ACentro: String;
                    const AFecha: TDate; const AReferencia: String ): boolean;
    function ExisteTransito( const AEmpresa, ACentro: String;
                          const AFecha: TDate; const AReferencia: String ): Boolean;
    procedure GrabarTransito( const APlantaOrigen, ACentroOrigen, APlantaDestino, ACentroDestino: string;
                              const AFecha: TDate; const AReferencia: String );
    procedure GrabarCabecera( const AEmpresa: String );
    procedure GrabarLinea( const AEmpresa: string );
    procedure GrabarPalets( const AEmpresa, ACentro: String );
    procedure GrabarPaletsComer( const APlantaOrigen, ACentroOrigen, APlantaDestino, ACentroDestino: String; const AFecha: TDate; const AReferencia: String );

    function ParametrosOK: boolean;

  public
    { Public declarations }
  end;

implementation

uses bSQLUtils, UDMAuxDB, UDMBaseDatos, DMRecepcion, DBTables, DB, bDialogs,
     CVariables, UDMConfig;

{$R *.dfm}

var
  DMRecepcionForm: TDMRecepcionForm;

procedure TFDRecepcionTransitos.FormCreate(Sender: TObject);
begin
  DMRecepcionForm:= TDMRecepcionForm.create( Application );
  fechaSalida.AsDate:= date;
  edtPlantaDestino.Text:= gsDefEmpresa;
  edtCentroDestino.Text:= gsDefCentro;

  lblMessage.Caption:= 'RECUERDE ACTIVAR EL TRÁNSITO CUANDO SE RECIBA EN EL ALMACÉN.';

  btnOk.Enabled:= True;
end;

procedure TFDRecepcionTransitos.BtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFDRecepcionTransitos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil( DMRecepcionForm );
  DMBaseDatos.BDCentral.Close;
  Action:= caFree;
end;

function TFDRecepcionTransitos.edtCentroOrigenGetSQL: String;
begin
  if edtPlantaOrigen.Text <> '' then
  begin
    result:= ' select empresa_c, centro_c, descripcion_c from frf_centros ' +
             ' where empresa_c ' + SQLEqualS( edtPlantaOrigen.Text );
  end
  else
  begin
    result:= ' select empresa_c, centro_c, descripcion_c from frf_centros ';
  end;
end;

function TFDRecepcionTransitos.edtCentroDestinoGetSQL: String;
begin
  if edtPlantaDestino.Text <> '' then
  begin
    result:= ' select empresa_c, centro_c, descripcion_c from frf_centros ' +
             ' where empresa_c ' + SQLEqualS( edtPlantaDestino.Text );
  end
  else
  begin
    result:= ' select empresa_c, centro_c, descripcion_c from frf_centros ';
  end;
end;

function TFDRecepcionTransitos.stPlantaOrigenGetDescription: String;
begin
  result:= desEmpresa( edtPlantaOrigen.Text );
  stCentroOrigen.Description;
end;

function TFDRecepcionTransitos.stPlantaDestinoGetDescription: String;
begin
  result:= desEmpresa( edtPlantaDestino.Text );
  stCentroDestino.Description;
end;

function TFDRecepcionTransitos.stCentroOrigenGetDescription: String;
begin
  result:= desCentro( edtPlantaOrigen.Text, edtCentroOrigen.Text );
end;

function TFDRecepcionTransitos.stCentroDestinoGetDescription: String;
begin
  result:= desCentro( edtPlantaDestino.Text, edtCentroDestino.Text );
end;

procedure TFDRecepcionTransitos.edtPlantaOrigenChange(Sender: TObject);
begin
  stPlantaOrigen.Description;
end;

procedure TFDRecepcionTransitos.edtPlantaDestinoChange(Sender: TObject);
begin
  stPlantaDestino.Description;
end;

procedure TFDRecepcionTransitos.edtCentroOrigenChange(Sender: TObject);
begin
  stCentroOrigen.Description;
end;

procedure TFDRecepcionTransitos.edtCentroDestinoChange(Sender: TObject);
begin
  stCentroDestino.Description;
end;

function TFDRecepcionTransitos.ParametrosOK: boolean;
var
  dAux: TDateTime;
begin
  result:= True;
  if result and ( lblPlantaOrigen.Caption = '' ) then
  begin
    ShowMessage('Código de planta origen incorrecto.');
    edtPlantaOrigen.SetFocus;
    result:= false;
  end;
  if result and ( lblPlantaDestino.Caption = '' ) then
  begin
    ShowMessage('Código de planta destino incorrecto.');
    edtPlantaDestino.SetFocus;
    result:= false;
  end;

  if result and ( lblCentroOrigen.Caption = '' ) then
  begin
    ShowMessage('Código de centro origen incorrecto.');
    edtCentroOrigen.SetFocus;
    result:= false;
  end;

  if result and ( lblCentroDestino.Caption = '' ) then
  begin
    ShowMessage('Código de centro destino incorrecto.');
    edtCentroDestino.SetFocus;
    result:= false;
  end;

  if result and ( not TryStrToDate( fechaSalida.Text, dAux ) ) then
  begin
    ShowMessage('Fecha de salida incorrecta.');
    fechaSalida.SetFocus;
    result:= false;
  end;

  if result and ( nReferencia.Text = '' ) then
  begin
    ShowMessage('Falta la referencia del tránsito.');
    nReferencia.SetFocus;
    result:= false;
  end;

end;

procedure TFDRecepcionTransitos.BtnOkClick(Sender: TObject);
begin
  if not ParametrosOK then
    Exit;

  lblMessage.Caption:='Espere por favor ....';
  Application.ProcessMessages;
  lblMessage.Font.Color:= clBlack;

  try
    DMBaseDatos.BDCentral.Open;
    RecepcionFruta( edtPlantaOrigen.Text, edtCentroOrigen.Text, edtPlantaDestino.Text,
                    edtCentroDestino.Text, fechaSalida.AsDate, nReferencia.Text );
  except
    on e: Exception do
    begin
      lblMessage.Caption:='Se ha producido un error inesperado.';
      lblMessage.Font.Color:= clRed;
      DMBaseDatos.BDCentral.Close;
      ShowMessage( e.Message );
    end;
  end;
end;

procedure TFDRecepcionTransitos.RecepcionFruta( const APlantaOrigen, ACentroOrigen: String;
                                                const APlantaDestino, ACentroDestino: String;
                                                const AFecha: TDate; const AReferencia: String );
begin
  if not HaSidoRecibido( APlantaDestino, ACentroOrigen, AFecha, AReferencia ) then
  begin
    if ExisteTransito( APlantaOrigen, ACentroOrigen, AFecha, AReferencia ) then
    begin
      GrabarTransito( APlantaOrigen, ACentroOrigen, APlantaDestino, ACentroDestino, AFecha, AReferencia );
      //DMRecepcionForm.QTransito.Close;
      //DMRecepcionForm.QTransitoRemoto.Close;
      lblMessage.Caption:='La recepción del tránsito ha sido realizada con éxito.';
      lblMessage.Font.Color:= clNavy;
    end
    else
    begin
      DMRecepcionForm.QTransito.Close;
      lblMessage.Caption:='El tránsito no ha sido grabado en el origen.';
      lblMessage.Font.Color:= clGreen;
    end;
  end
  else
  begin
    lblMessage.Caption:='El tránsito ya ha sido importado anteriormente.';
    lblMessage.Font.Color:= clGreen;
  end;
end;

function TFDRecepcionTransitos.HaSidoRecibido( const AEmpresa, ACentro: String;
                          const AFecha: TDate; const AReferencia: String ): Boolean;
begin
  with DMRecepcionForm.QTransito do
  begin
    Close;
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fecha').AsDateTime:= AFecha;
    ParamByName('referencia').AsString:= AReferencia;
    Open;
    result:= not IsEmpty;
    if result then Close;
  end;
end;

function TFDRecepcionTransitos.ExisteTransito( const AEmpresa, ACentro: String;
                          const AFecha: TDate; const AReferencia: String ): Boolean;
begin
  with DMRecepcionForm.QTransitoRemoto do
  begin
    Close;
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fecha').AsDateTime:= AFecha;
    ParamByName('referencia').AsString:= AReferencia;
    Open;
    result:= not IsEmpty;
    if not result then Close;
  end;
end;

procedure TFDRecepcionTransitos.GrabarTransito( const APlantaOrigen, ACentroOrigen, APlantaDestino, ACentroDestino: string;
                                                const AFecha: TDate; const AReferencia: String );
begin
  if not DMBaseDatos.DBBaseDatos.InTransaction then
  begin
    try
      DMBaseDatos.DBBaseDatos.StartTransaction;
      GrabarCabecera( APlantaDestino );
      GrabarLinea( APlantaDestino );
      GrabarPalets( APlantaDestino, ACentroDestino );
      GrabarPaletsComer( APlantaOrigen, ACentroOrigen, APlantaDestino, ACentroDestino,  AFecha, AReferencia );
      DMBaseDatos.DBBaseDatos.Commit;
    except
      DMBaseDatos.DBBaseDatos.Rollback;
      raise;
    end;
  end
  else
  begin
    raise Exception.Create( 'No puedo realizar los cambios al no poder abrir una transaccion.');
  end;
end;

procedure TFDRecepcionTransitos.GrabarCabecera( const AEmpresa: string );
var
  i: integer;
  tfAux: TField;
begin
  with DMRecepcionForm do
  begin
    QTransito.Insert;
    for i:= 0 to QTransito.FieldCount - 1 do
    begin
      tfAux:= QTransitoRemoto.FindField( QTransito.Fields[i].FieldName );
      if ( tfAux <> nil ) and QTransito.Fields[i].CanModify then
      begin
        QTransito.Fields[i].Value:= tfAux.Value;
      end;
    end;
    QTransito.FieldByName('empresa_tc').AsString:= QTransitoRemoto.FieldByName('planta_destino_tc').AsString;
    QTransito.FieldByName('status_tc').AsInteger:= 4;
    QTransito.Post;

    QTransitoRemoto.Edit;
    QTransitoRemoto.FieldByName('status_tc').AsInteger:= 3;
    QTransitoRemoto.Post;
  end;
end;

procedure TFDRecepcionTransitos.GrabarLinea( const AEmpresa: string );
var
  i: integer;
  tfAux: TField;
begin
  with DMRecepcionForm do
  begin
    //Obtener lineas
    QLineaRemota.Open;

    if not QLineaRemota.IsEmpty then
    begin
      QLinea.Open;
      while not QLineaRemota.Eof do
      begin
        QLinea.Insert;
        for i:= 0 to QLinea.FieldCount - 1 do
        begin
          tfAux:= QLineaRemota.FindField( QLinea.Fields[i].FieldName );
          if ( tfAux <> nil ) and QLinea.Fields[i].CanModify then
          begin
            QLinea.Fields[i].Value:= tfAux.Value;
          end;
        end;
        QLinea.FieldByName('empresa_tl').AsString:= AEmpresa;
        QLinea.Post;
        QLineaRemota.Next;
      end;
      QLinea.Close;
    end;
    QLineaRemota.Close;
  end;
end;

procedure TFDRecepcionTransitos.GrabarPaletsComer( const APlantaOrigen, ACentroOrigen, APlantaDestino, ACentroDestino: String;
                                                   const AFecha: TDate; const AReferencia: String );
var
  i, iPalet, iPalets, iErrores: integer;
  fAux: TField;
  bFlag: boolean;
begin
  bFlag:= False;
  with DMRecepcionForm do
  begin
    //Borrar palets asociados
    lblMessage.Caption:= 'Limpiando palets asociados (DET).';
    Application.ProcessMessages;
    QBorrarPaletDetLocal.ParamByName('empresa').AsString:= APlantaDestino;
    QBorrarPaletDetLocal.ParamByName('centro').AsString:= ACentroDestino;
    QBorrarPaletDetLocal.ParamByName('fecha').AsDate:= AFecha;
    QBorrarPaletDetLocal.ParamByName('referencia').AsString:= AReferencia;
    QBorrarPaletDetLocal.ExecSQL;

    lblMessage.Caption:= 'Limpiando palets asociados (CAB).';
    Application.ProcessMessages;
    QBorrarPaletCabLocal.ParamByName('empresa').AsString:= APlantaDestino;
    QBorrarPaletCabLocal.ParamByName('centro').AsString:= ACentroDestino;
    QBorrarPaletCabLocal.ParamByName('fecha').AsDate:= AFecha;
    QBorrarPaletCabLocal.ParamByName('referencia').AsString:= AReferencia;
    QBorrarPaletCabLocal.ExecSQL;

    //Obtener lineas
    lblMessage.Caption:= 'Obtener palets tránsito (CAB).';
    Application.ProcessMessages;
    QPaletCabRemota.Close;
    QPaletCabRemota.ParamByName('empresa').AsString:= APlantaOrigen;
    QPaletCabRemota.ParamByName('centro').AsString:= ACentroOrigen;
    QPaletCabRemota.ParamByName('fecha').AsDate:= AFecha;
    QPaletCabRemota.ParamByName('referencia').AsString:= AReferencia;
    try
      QPaletCabRemota.Open;
      iPalets:= QPaletCabRemota.RecordCount;
    except
      on E: EDBEngineError do
      begin
        ErrorSQL( QPaletCabRemota, E );
      end;
    end;

    if not QPaletCabRemota.IsEmpty then
    begin
      lblMessage.Caption:= 'Abrir tabla palets (CAB).';
      Application.ProcessMessages;

      QPaletCabLocal.Open;
      iPalet:= 0;
      iErrores:= 0;
      while not QPaletCabRemota.Eof do
      begin
        inc( iPalet );
        lblMessage.Caption:= 'Prepara palet ' + intToStr( iPalet ) + ' de ' + intToStr( iPalets ) + '(CAB). ' + intToStr( iErrores ) + ' errores.';
        Application.ProcessMessages;

        QPaletCabLocal.Insert;
        for i:= 0 to QPaletCabLocal.FieldCount - 1 do
        begin
          fAux:= QPaletCabRemota.Fields.FindField( QPaletCabLocal.Fields[i].FieldName );
          //if ( fAux <> nil ) and QPaletCab.FieldByName( QPaletCab.Fields[i].FieldName ).CanModify then
          if ( fAux <> nil ) and QPaletCabLocal.Fields[i].CanModify then
          begin
            QPaletCabLocal.Fields[i].Value:= fAux.Value;
          end;
        end;
        QPaletCabLocal.FieldByName( 'empresa_cab' ).Value:= APlantaDestino;
        QPaletCabLocal.FieldByName( 'centro_cab' ).Value:= ACentroDestino;

        QPaletCabLocal.FieldByName( 'Status_cab' ).Value:= 'T';
        QPaletCabLocal.FieldByName( 'Orden_carga_cab' ).Value:= NULL;
        QPaletCabLocal.FieldByName( 'Fecha_carga_cab' ).Value:= NULL;

        try
          lblMessage.Caption:= 'Insertando palet ' + intToStr( iPalet ) + ' de ' + intToStr( iPalets ) + '(CAB). ' + intToStr( iErrores ) + ' errores.';
          Application.ProcessMessages;
          QPaletCabLocal.Post;
        except
          QPaletCabLocal.Cancel;
          inc( iErrores );
          bFlag:= True;
        end;
        QPaletCabRemota.Next;
      end;
      QPaletCabLocal.Close;
    end;
    QPaletCabRemota.Close;
  end;

  with DMRecepcionForm do
  begin
    //Obtener lineas
    lblMessage.Caption:= 'Obtener palets tránsito (DET).';
    Application.ProcessMessages;
    QPaletDetRemota.Close;
    QPaletDetRemota.ParamByName('empresa').AsString:= APlantaOrigen;
    QPaletDetRemota.ParamByName('centro').AsString:= ACentroOrigen;
    QPaletDetRemota.ParamByName('fecha').AsDate:= AFecha;
    QPaletDetRemota.ParamByName('referencia').AsString:= AReferencia;
    try
      QPaletDetRemota.Open;
      iPalet:= QPaletDetRemota.RecordCount;
    except
      on E: EDBEngineError do
      begin
        ErrorSQL( QPaletDetRemota, E );
      end;
    end;

    if not QPaletDetRemota.IsEmpty then
    begin
      lblMessage.Caption:= 'Abrir tabla palets tránsito (DET).';
      Application.ProcessMessages;

      QPaletDetLocal.Open;
      iPalet:= 0;
      iErrores:= 0;
      while not QPaletDetRemota.Eof do
      begin
        inc( iPalet );
        lblMessage.Caption:= 'Prepara palet ' + intToStr( iPalet ) + ' de ' + intToStr( iPalets ) + '(DET). ' + intToStr( iErrores ) + ' errores.';
        Application.ProcessMessages;

        QPaletDetLocal.Insert;
        for i:= 0 to QPaletDetLocal.FieldCount - 1 do
        begin
          fAux:= QPaletDetRemota.Fields.FindField( QPaletDetLocal.Fields[i].FieldName );
          if ( fAux <> nil ) and QPaletDetLocal.Fields[i].CanModify then
          begin
            if ( QPaletDetLocal.Fields[i].FieldName <> 'movimiento' )then
            begin
              QPaletDetLocal.Fields[i].Value:= fAux.Value;
            end;
          end;
        end;
        try
          lblMessage.Caption:= 'Insertando palet ' + intToStr( iPalet ) + ' de ' + intToStr( iPalets ) + '(DET). ' + intToStr( iErrores ) + ' errores.';
          Application.ProcessMessages;
          QPaletDetLocal.Post;
        except
          QPaletDetLocal.Cancel;
          Inc( iErrores );
          bFlag:= True;
        end;
        QPaletDetRemota.Next;
      end;
      QPaletDetLocal.Close;
    end;
    QPaletDetRemota.Close;
  end;

  (*
  grabar palet pb

  ¿grabar orden carga?¿para que?

  activar transito tambien tiene que modificar palet_pc_CAB/DET
  *)
  if bFlag then
  begin
    Raise Exception.Create('Error al grabar el packing list.');
  end;
end;

procedure TFDRecepcionTransitos.GrabarPalets( const AEmpresa, ACentro: string );
var
  i: integer;
  fAux: TField;
begin
  with DMRecepcionForm do
  begin
    QPaletPbRemota.Open;
    if not QPaletPbRemota.IsEmpty then
    begin
      while not QPaletPbRemota.Eof do
      begin
        QPaletPbLocal.ParamByName('sscc').AsString:=  QPaletPbRemota.FieldByName('sscc').AsString;
        QPaletPbLocal.Open;
        if QPaletPbLocal.IsEmpty then
        begin
          QPaletPbLocal.Insert;
          for i:= 0 to QPaletPbLocal.FieldCount - 1 do
          begin
            fAux:= QPaletPbRemota.Fields.FindField( QPaletPbLocal.Fields[i].FieldName );
            if ( fAux <> nil ) and QPaletPbLocal.Fields[i].CanModify then
            begin
              QPaletPbLocal.Fields[i].Value:= fAux.Value;
            end;
          end;

          QPaletPbLocal.FieldByName( 'empresa' ).Value:= AEmpresa;
          QPaletPbLocal.FieldByName( 'centro' ).Value:= ACentro;
          QPaletPbLocal.FieldByName( 'Status' ).Value:= 'T';
          //QPaletPbLocal.FieldByName( 'Orden_carga' ).Value:= NULL;

          QPaletPbLocal.Post;
        end
        else
        begin
          if QPaletPbLocal.FieldByName( 'Status' ).AsString = 'C' then
          begin
            QPaletPbLocal.Edit;
            QPaletPbLocal.FieldByName( 'orden_carga' ).AsString:= QPaletPbRemota.FieldByName( 'orden_carga' ).AsString;
            QPaletPbLocal.FieldByName( 'Status' ).AsString:= 'T';
            QPaletPbLocal.Post;
          end
          else
          begin
            raise Exception.Create('Palet de proveedor "' + QPaletPbRemota.FieldByName('sscc').AsString + '" duplicado.');
          end;
        end;
        QPaletPbLocal.Close;
        QPaletPbRemota.Next;
      end;
    end;
    QPaletPbRemota.Close;
    //Borrar palets asociados de la central
    QBorrarPaletPb.ExecSQL;
  end;
end;

procedure TFDRecepcionTransitos.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_f1:btnOk.Click;
    vk_escape:btnCancel.Click;
  end;
end;

procedure TFDRecepcionTransitos.FormShow(Sender: TObject);
var SAux: String;
begin
  sAux := Valortmensajes;
  if sAux <> '' then
  begin
    ShowMessage(SAux);
    btnOk.Enabled := false;
  end
  else
    btnOk.enabled := true;
end;

end.
