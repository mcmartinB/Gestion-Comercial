unit DRecepcionTransitos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, nbEdits, nbCombos, Buttons, nbLabels, BEdit;

type
  TFDRecepcionTransitos = class(TForm)
    empresa: TnbDBSQLCombo;
    centro: TnbDBSQLCombo;
    fechaSalida: TnbDBCalendarCombo;
    fechaRecepcion: TnbDBCalendarCombo;
    nbLabel1: TnbLabel;
    nbLabel2: TnbLabel;
    nbLabel3: TnbLabel;
    nbLabel4: TnbLabel;
    lblFechaRecepcion: TnbLabel;
    nReferencia: TnbDBNumeric;
    nomEmpresa: TnbStaticText;
    nomCentroSalida: TnbStaticText;
    btnOk: TSpeedButton;
    btnCancel: TSpeedButton;
    lblMessage: TLabel;
    edtHora: TBEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    nbLabel5: TnbLabel;
    nomCentroDestino: TnbStaticText;
    centroDestino: TnbDBSQLCombo;
    procedure BtnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function centroGetSQL: String;
    function nomEmpresaGetDescription: String;
    procedure empresaChange(Sender: TObject);
    procedure centroChange(Sender: TObject);
    function nomCentrosalidaGetDescription: String;
    procedure BtnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure centroDestinoChange(Sender: TObject);
    function nomCentroDestinoGetDescription: string;
  private
    sEmpresa, sOrigen, sTransito, sHora, sDestino: string;
    dFechaSalida, dFechaEntrada: TDateTime;

    { Private declarations }
    procedure RecepcionFruta( const AEmpresa, ACentro: String;
                    const AFecha: TDate;
                    const AReferencia: String;
                    const AFechaRecepcion: TDate; const AHora: String ;
                    const ACentroDestino: string);
    function HaSidoRecibido( const AEmpresa, ACentro: String;
                    const AFecha: TDate; const AReferencia: String ): boolean;
    function ExisteTransito( const AEmpresa, ACentro: String;
                          const AFecha: TDate; const AReferencia, ACentroDestino: String ): Boolean;
    procedure GrabarTransito( const AEmpresa, ACentro: String;
                    const AFecha: TDate;
                    const AReferencia: String;
                    const AFechaRecepcion: TDate; const AHora: String );
    procedure GrabarCabecera( const AFechaRecepcion: TDate; const AHora: String );
    procedure GrabarLinea( const AEmpresa, ACentro: String;
                    const AFecha: TDate; const AReferencia: String );
    procedure GrabarPalets( const AEmpresa, ACentro: String );
    procedure GrabarPaletsComer( const AEmpresa, ACentro: String;
                    const AFecha: TDate; const AReferencia: String );
    procedure GrabarPaletsSGP( const AEmpresa, ACentro: String;
                    const AFecha: TDate; const AReferencia: String );

    function  ValidarDatos: boolean;

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
var
  sMsg: string;
begin
  DMRecepcionForm:= TDMRecepcionForm.create( Application );
  fechaSalida.AsDate:= date;
  fechaRecepcion.Text:= '';
  //fechaRecepcion.AsDate:= date;
  //edtHora.Text:= FormatDateTime('hh:mm', Now);

  empresa.Text:= gsDefEmpresa;
  if DMConfig.sCentroInstalacion = '1' then
    centro.Text:= '6'
  else
    centro.Text:= '1';

  btnOk.Enabled:= True;
  lblMessage.Caption:= '';
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

function TFDRecepcionTransitos.centroGetSQL: String;
begin
  if empresa.Text <> '' then
  begin
    result:= ' select empresa_c, centro_c, descripcion_c from frf_centros ' +
             ' where empresa_c ' + SQLEqualS( empresa.Text );
  end
  else
  begin
    result:= ' select empresa_c, centro_c, descripcion_c from frf_centros ';
  end;
end;

function TFDRecepcionTransitos.nomEmpresaGetDescription: String;
begin
  result:= desEmpresa( empresa.Text );
  nomCentroSalida.Description;
end;

function TFDRecepcionTransitos.nomCentroDestinoGetDescription: string;
begin
  result:= desCentro( empresa.Text, centroDestino.Text );
end;

function TFDRecepcionTransitos.nomCentrosalidaGetDescription: String;
begin
  result:= desCentro( empresa.Text, centro.Text );
end;

procedure TFDRecepcionTransitos.empresaChange(Sender: TObject);
begin
  nomEmpresa.Description;
end;

procedure TFDRecepcionTransitos.centroChange(Sender: TObject);
begin
  nomCentroSalida.Description;
end;

procedure TFDRecepcionTransitos.centroDestinoChange(Sender: TObject);
begin
  nomCentroDestino.Description;
end;

function TFDRecepcionTransitos.ValidarDatos: boolean;
begin
  Result := False;
  //Comprobamos que los campos esten todos con datos
  if nomEmpresa.Caption = '' then
  begin
    ShowMessage('Falta c?digo de empresa o c?digo incorrecto.');
    empresa.SetFocus;
    Exit;
  end;
  sEmpresa:= Trim(empresa.Text);

  if nomCentroSalida.Caption = '' then
  begin
    ShowMessage('Falta c?digo de centro o c?digo incorrecto..');
    centro.SetFocus;
    Exit;
  end;
  sOrigen:= Trim(centro.Text);

  if nomCentroDestino.Caption = '' then
  begin
    ShowMessage('Falta c?digo de centro destino o c?digo incorrecto..');
    centroDestino.SetFocus;
    Exit;
  end;
  sDestino:= Trim(centroDestino.Text);

  if sOrigen = sDestino then
  begin
    ShowMessage('El Centro Origen y Destino no pueden ser iguales..');
    centroDestino.SetFocus;
    Exit;
  end;

  if nReferencia.Text = '' then
  begin
    ShowMessage('Falta la referencia del tr?nsito.');
    nReferencia.SetFocus;
    Exit;
  end;
  sTransito:= Trim(nReferencia.Text);

  if not TryStrToDate( fechaSalida.Text, dFechaSalida ) then
  begin
    ShowMessage('Falta fecha de salida o fecha incorrecta.');
    fechaSalida.SetFocus;
    Exit;
  end;
  if not TryStrToDate( fechaRecepcion.Text, dFechaEntrada ) then
  begin
    ShowMessage('Falta fecha de entrada o fecha incorrecta.');
    fechaSalida.SetFocus;
    Exit;
  end;
  if dFechaEntrada < dFechaSalida then
  begin
    ShowMessage('La fecha salida no puede se mayor que la fecha de entrada.');
    fechaRecepcion.SetFocus;
    Exit;
  end;
  if ( dFechaEntrada - dFechaSalida ) > 30 then
  begin
    ShowMessage('La fecha entrada no puede ser mayor a 30 dias desde la fecha de salida del tr?nsito.');
    fechaRecepcion.SetFocus;
    Exit;
  end;

  if ( Length( edtHora.Text ) < 5 ) or  ( Copy( edtHora.Text, 3, 1 ) <> ':' ) then
  begin
    ShowMessage('Falta la hora o el formato no es correcto (hh:mm).');
    edtHora.SetFocus;
    Exit;
  end;
  sHora:= edtHora.Text;

  Result := True;
end;

procedure TFDRecepcionTransitos.BtnOkClick(Sender: TObject);
begin
  if ValidarDatos then
  begin
    lblMessage.Caption:='Espere por favor ....';
    Application.ProcessMessages;
    lblMessage.Font.Color:= clBlack;
    try
      DMBaseDatos.BDCentral.Open;
      RecepcionFruta( empresa.Text, centro.Text, fechaSalida.AsDate, nReferencia.Text, fechaRecepcion.AsDate, sHora, centroDestino.Text );
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
end;

procedure TFDRecepcionTransitos.RecepcionFruta( const AEmpresa, ACentro: String;
                                       const AFecha: TDate;
                                       const AReferencia: String;
                                       const AFechaRecepcion: TDate; const AHora: String;
                                       const ACentroDestino: String );
begin
  if not HaSidoRecibido( AEmpresa, ACentro, AFecha, AReferencia ) then
  begin
    if ExisteTransito( AEmpresa, ACentro, AFecha, AReferencia, ACentroDestino ) then
    begin
      GrabarTransito( AEmpresa, ACentro, AFecha, AReferencia, AFechaRecepcion, AHora );
      //DMRecepcionForm.QTransito.Close;
      //DMRecepcionForm.QTransitoRemoto.Close;
      lblMessage.Caption:='La recepci?n del tr?nsito ha sido realizada con ?xito.';
      lblMessage.Font.Color:= clNavy;
    end
    else
    begin
      DMRecepcionForm.QTransito.Close;
      lblMessage.Caption:='El tr?nsito no ha sido grabado en el origen.';
      lblMessage.Font.Color:= clGreen;
    end;
  end
  else
  begin
    lblMessage.Caption:='El tr?nsito ya ha sido importado anteriormente.';
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
                          const AFecha: TDate; const AReferencia, ACentroDestino: String ): Boolean;
begin
  with DMRecepcionForm.QTransitoRemoto do
  begin
    Close;
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('centro').AsString:= ACentro;
    ParamByName('fecha').AsDateTime:= AFecha;
    ParamByName('referencia').AsString:= AReferencia;
    ParamByName('centro_destino').AsString:= ACentroDestino;
    Open;
    result:= not IsEmpty;
    if not result then Close;
  end;
end;

procedure TFDRecepcionTransitos.GrabarTransito( const AEmpresa, ACentro: String;
                    const AFecha: TDate;
                    const AReferencia: String;
                    const AFechaRecepcion: TDate; const AHora: String );
begin
  if not DMBaseDatos.DBBaseDatos.InTransaction then
  begin
    try
      DMBaseDatos.DBBaseDatos.StartTransaction;
      GrabarCabecera( AFechaRecepcion, AHora);
      GrabarLinea( AEmpresa, ACentro, AFecha, AReferencia );
      DMBaseDatos.DBBaseDatos.Commit;
    except
      DMBaseDatos.DBBaseDatos.Rollback;
      raise;
    end;
    //if ( Empresa.Text = '050' ) or ( Empresa.Text = '080' ) then
    begin
      try
        if DMConfig.EsLosLLanos then
        begin
          GrabarPalets ( AEmpresa, ACentro );
          GrabarPaletsSGP( AEmpresa, ACentro, AFecha, AReferencia )
        end
        else
          begin
          GrabarPalets ( AEmpresa, ACentro );
          GrabarPaletsComer( AEmpresa, ACentro, AFecha, AReferencia );
          end;
      except
        raise Exception.Create('Tr?nsito grabado con errores en el packing list.');
      end;
    end;
  end
  else
  begin
    raise Exception.Create( 'No puedo realizar los cambios al no poder abrir una transaccion.');
  end;
end;

procedure TFDRecepcionTransitos.GrabarCabecera( const AFechaRecepcion: TDate; const AHora: String );
var
  i: integer;
begin
  lblMessage.Caption:= 'Grabando cabecera.';
  Application.ProcessMessages;

  with DMRecepcionForm do
  begin
    QTransito.Insert;
    for i:= 0 to QTransito.FieldCount - 1 do
    begin
      if QTransito.FieldByName( QTransito.Fields[i].FieldName ).CanModify then
      begin
        QTransito.FieldByName( QTransito.Fields[i].FieldName ).Value:=
          QTransitoRemoto.FieldByName( QTransito.Fields[i].FieldName ).Value;
      end;
    end;
    QTransito.FieldByName( 'fecha_entrada_tc' ).AsDateTime:= AFechaRecepcion;
    QTransito.FieldByName( 'hora_entrada_tc' ).AsString:= AHora;
    QTransito.Post;
  end;
end;

procedure TFDRecepcionTransitos.GrabarLinea( const AEmpresa, ACentro: String;
                    const AFecha: TDate; const AReferencia: String );
var
  i, iLinea, iLineas: integer;
begin
  with DMRecepcionForm do
  begin
    lblMessage.Caption:= 'Obtener lineas.';
    Application.ProcessMessages;

    //Obtener lineas
    //QLineaRemota.Close;
    //QLineaRemota.ParamByName('empresa_tc').AsString:= AEmpresa;
    //QLineaRemota.ParamByName('centro_tc').AsString:= ACentro;
    //QLineaRemota.ParamByName('fecha_tc').AsDateTime:= AFecha;
    //QLineaRemota.ParamByName('referencia_tc').AsString:= AReferencia;
    QLineaRemota.Open;
    iLineas:= QLineaRemota.RecordCount;

    if not QLineaRemota.IsEmpty then
    begin

      lblMessage.Caption:= 'Preparado para grabar ' + IntToStr( iLineas ) + ' lineas.';
      Application.ProcessMessages;

      iLinea:= 0;
      QLinea.Open;
      while not QLineaRemota.Eof do
      begin
        inc( iLinea );
        lblMessage.Caption:= 'Grabando linea n?mero ' + IntToStr( iLinea ) + ' de '  + IntToStr( iLineas ) + '.';
        Application.ProcessMessages;

        QLinea.Insert;
        for i:= 0 to QLinea.FieldCount - 1 do
        begin
          if QLineaRemota.FieldDefList.Find( QLinea.Fields[i].FieldName ) <> nil then
            QLinea.FieldByName( QLinea.Fields[i].FieldName ).Value:=
               QLineaRemota.FieldByName( QLinea.Fields[i].FieldName ).Value;
        end;
        QLinea.Post;
        QLineaRemota.Next;
      end;
      QLinea.Close;
    end;
    QLineaRemota.Close;
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
          //Borrar movimiento 3, por si ya se hubiera transmitido antes.
          BorrarPBLog( QPaletPBRemota.FieldByName('orden_carga').AsString, QPaletPBRemota.FieldByName('sscc').AsString, 3);
          //Insertamos en el LOG - rf_palet_pb_log
          InsertarPBLog( QPaletPBRemota.FieldBYName('empresa').AsString,
                         QPaletPBRemota.FieldByName('centro').AsString,
                         QPaletPBRemota.FieldByName('sscc').AsString,
                         CVariables.gsCodigo,
                         QPaletPBRemota.FieldByName('orden_carga').AsString,
                         QPaletPBRemota.FieldByName('peso').AsFloat,
                         QPaletPBRemota.FieldByName('cajas').AsFloat,
                         3);
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

procedure TFDRecepcionTransitos.GrabarPaletsComer( const AEmpresa, ACentro: String;
                    const AFecha: TDate; const AReferencia: String );
var
  i, iPalet, iPalets, iErrores: integer;
  fAux: TField;
  bFlag: boolean;
begin
  bFlag:= False;
  with DMRecepcionForm do
  begin
{
    //Borrar palets asociados
    lblMessage.Caption:= 'Limpiando palets asociados (DET).';
    Application.ProcessMessages;
    QBorrarPaletDetLocal.ParamByName('empresa').AsString:= AEmpresa;
    QBorrarPaletDetLocal.ParamByName('centro').AsString:= ACentro;
    QBorrarPaletDetLocal.ParamByName('fecha').AsDateTime:= AFecha;
    QBorrarPaletDetLocal.ParamByName('referencia').AsString:= AReferencia;
    QBorrarPaletDetLocal.ExecSQL;

    lblMessage.Caption:= 'Limpiando palets asociados (CAB).';
    Application.ProcessMessages;
    QBorrarPaletCabLocal.ParamByName('empresa').AsString:= AEmpresa;
    QBorrarPaletCabLocal.ParamByName('centro').AsString:= ACentro;
    QBorrarPaletCabLocal.ParamByName('fecha').AsDateTime:= AFecha;
    QBorrarPaletCabLocal.ParamByName('referencia').AsString:= AReferencia;
    QBorrarPaletCabLocal.ExecSQL;
}
    //Obtener lineas
    lblMessage.Caption:= 'Obtener palets tr?nsito (CAB).';
    Application.ProcessMessages;
    QPaletCabRemota.Close;
    QPaletCabRemota.ParamByName('empresa').AsString:= AEmpresa;
    QPaletCabRemota.ParamByName('centro').AsString:= ACentro;
    QPaletCabRemota.ParamByName('fecha').AsDateTime:= AFecha;
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

        //Insertar plaet en BBDD local
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

        QPaletCabLocal.FieldByName( 'Status_cab' ).Value:= 'T';
        QPaletCabLocal.FieldByName( 'Orden_carga_cab' ).Value:= NULL;
        QPaletCabLocal.FieldByName( 'Fecha_carga_cab' ).Value:= NULL;

        try
          //Borrar palet en BBDD Local
          lblMessage.Caption:= 'Limpiando palets asociados (CAB).';
          Application.ProcessMessages;
          if QBorrarPaletCabLocal.Active then QBorrarPaletCabLocal.Close;
          QBorrarPaletCabLocal.ParamByName('sscc').AsString:= QPaletCabRemota.FieldByName('ean128_cab').AsString;
          QBorrarPaletCabLocal.ExecSQL;

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
    lblMessage.Caption:= 'Obtener palets tr?nsito (DET).';
    Application.ProcessMessages;
    QPaletDetRemota.Close;
    QPaletDetRemota.ParamByName('empresa').AsString:= AEmpresa;
    QPaletDetRemota.ParamByName('centro').AsString:= ACentro;
    QPaletDetRemota.ParamByName('fecha').AsDateTime:= AFecha;
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
      lblMessage.Caption:= 'Abrir tabla palets tr?nsito (DET).';
      Application.ProcessMessages;

      QPaletDetLocal.Open;
      iPalet:= 0;
      iErrores:= 0;
      while not QPaletDetRemota.Eof do
      begin
        inc( iPalet );
        lblMessage.Caption:= 'Prepara palet ' + intToStr( iPalet ) + ' de ' + intToStr( iPalets ) + '(DET). ' + intToStr( iErrores ) + ' errores.';
        Application.ProcessMessages;

        QInsertarPaletLog.Close;
        QInsertarPaletLog.ParamByName('empresa_cab').AsString:= AEmpresa;
        QInsertarPaletLog.ParamByName('centro_cab').AsString:= ACentro;
        QInsertarPaletLog.ParamByName('ean128_cab').AsString:= QPaletDetRemota.FieldByName('ean128_det').AsString;
        qInsertarPaletLog.Open;

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
          //Borrar palet en BBDD Local
          lblMessage.Caption:= 'Limpiando palets asociados (DET).';
          Application.ProcessMessages;
          if QBorrarPaletDetLocal.Active then QBorrarPaletDetLocal.Close;
          QBorrarPaletDetLocal.ParamByName('sscc').AsString:= QPaletDetRemota.FieldByName('ean128_det').AsString;
          QBorrarPaletDetLocal.ExecSQL;

          QPaletDetLocal.Post;

          //Borrar movimiento 3, por si ya se hubiera transmitido antes.
          BorrarPCLog( QInsertarPaletLog.FieldByName('ref_transito').AsString, QInsertarPaletLog.FieldByName('ean128_cab').AsString, 3);
          //Insertamos en el LOG - rf_palet_pb_log
          InsertarPCLog( QInsertarPaletLog.FieldBYName('empresa_cab').AsString,
                         QInsertarPaletLog.FieldByName('centro_cab').AsString,
                         QInsertarPaletLog.FieldByName('ean128_cab').AsString,
                         CVariables.gsCodigo,
                         QInsertarPaletLog.FieldByName('ref_transito').AsString,
                         QPaletDetLocal.FieldByName('peso_det').AsFloat,
                         QPaletDetLocal.FieldByName('unidades_det').AsFloat,
                         3);
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

  ?grabar orden carga??para que?

  activar transito tambien tiene que modificar palet_pc_CAB/DET
  *)
  if bFlag then
  begin
    Raise Exception.Create('Error al grabar el packing list.');
  end;
end;

procedure TFDRecepcionTransitos.GrabarPaletsSGP( const AEmpresa, ACentro: String;
                    const AFecha: TDate; const AReferencia: String );
var
  i, iPalet, iPalets, iErrores: integer;
  fAux: TField;
  bFlag: boolean;
begin
  bFlag:= False;
  with DMRecepcionForm do
  begin
{
    //Borrar palets asociados
    lblMessage.Caption:= 'Limpiando palets asociados (DET).';
    Application.ProcessMessages;
    qryBorrarPaletDetSGP.ParamByName('empresa').AsString:= AEmpresa;
    qryBorrarPaletDetSGP.ParamByName('centro').AsString:= ACentro;
    qryBorrarPaletDetSGP.ParamByName('fecha').AsDateTime:= AFecha;
    qryBorrarPaletDetSGP.ParamByName('referencia').AsString:= AReferencia;
    qryBorrarPaletDetSGP.ExecSQL;

    lblMessage.Caption:= 'Limpiando palets asociados (CAB).';
    Application.ProcessMessages;
    qryBorrarPaletCabSGP.ParamByName('empresa').AsString:= AEmpresa;
    qryBorrarPaletCabSGP.ParamByName('centro').AsString:= ACentro;
    qryBorrarPaletCabSGP.ParamByName('fecha').AsDateTime:= AFecha;
    qryBorrarPaletCabSGP.ParamByName('referencia').AsString:= AReferencia;
    qryBorrarPaletCabSGP.ExecSQL;
 }
    //Obtener lineas
    lblMessage.Caption:= 'Obtener palets tr?nsito (CAB).';
    Application.ProcessMessages;
    QPaletCabRemota.Close;
    QPaletCabRemota.ParamByName('empresa').AsString:= AEmpresa;
    QPaletCabRemota.ParamByName('centro').AsString:= ACentro;
    QPaletCabRemota.ParamByName('fecha').AsDateTime:= AFecha;
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
      iPalet:= 0;
      iErrores:= 0;
      while not QPaletCabRemota.Eof do
      begin
        inc( iPalet );
        lblMessage.Caption:= 'Insertando palet ' + intToStr( iPalet ) + ' de ' + intToStr( iPalets ) + '(CAB). ' + intToStr( iErrores ) + ' errores.';
        Application.ProcessMessages;

        qryPaletCabSGP.ParamByName( 'Status_cab' ).Value:= 'T';
        //qryPaletCabSGP.ParamByName( 'Orden_carga_cab' ).Value:= NULL;
        //qryPaletCabSGP.ParamByName( 'Fecha_carga_cab' ).Value:= NULL;
        //qryPaletCabSGP.ParamByName( 'terminal_carga_cab' ).Value:= NULL;                s

        qryPaletCabSGP.ParamByName( 'empresa_cab' ).AsString:= QPaletCabRemota.FieldByName('empresa_cab').AsString;
        qryPaletCabSGP.ParamByName( 'centro_cab' ).AsString:= QPaletCabRemota.FieldByName('centro_cab').AsString;
        qryPaletCabSGP.ParamByName( 'ean128_cab' ).AsString:= QPaletCabRemota.FieldByName('ean128_cab').AsString;
        qryPaletCabSGP.ParamByName( 'tipo_palet_cab' ).AsString:= QPaletCabRemota.FieldByName('tipo_palet_cab').AsString;
        qryPaletCabSGP.ParamByName( 'cliente_cab' ).AsString:= QPaletCabRemota.FieldByName('cliente_cab').AsString;
        qryPaletCabSGP.ParamByName( 'dirsum_cab' ).AsString:= QPaletCabRemota.FieldByName('dirsum_cab').AsString;
        qryPaletCabSGP.ParamByName( 'terminal_cab' ).AsString:= QPaletCabRemota.FieldByName('terminal_cab').AsString;
        qryPaletCabSGP.ParamByName( 'fecha_alta_cab' ).AsDateTime:= QPaletCabRemota.FieldByName('fecha_alta_cab').AsDateTime;
        //qryPaletCabSGP.ParamByName( 'fecha_volcado_cab' ).AsDateTime:= QPaletCabRemota.FieldByName('fecha_volcado_cab').AsDateTime;
        //qryPaletCabSGP.ParamByName( 'le_volcado_cab' ).AsString:= QPaletCabRemota.FieldByName('le_volcado_cab').AsString;
        //qryPaletCabSGP.ParamByName( 'terminal_volcado_cab' ).AsString:= QPaletCabRemota.FieldByName('terminal_volcado_cab').AsString;
        //qryPaletCabSGP.ParamByName( 'fecha_borrado_cab' ).Value:= QPaletCabRemota.FieldByName('fecha_borrado_cab').Value;
        //qryPaletCabSGP.ParamByName( 'terminal_borrado_cab' ).AsString:= QPaletCabRemota.FieldByName('terminal_borrado_cab').AsString;
        qryPaletCabSGP.ParamByName( 'eti_conserva' ).AsString:= QPaletCabRemota.FieldByName('eti_conserva').AsString;
        qryPaletCabSGP.ParamByName( 'ref_transito' ).AsString:= QPaletCabRemota.FieldByName('ref_transito').AsString;
        qryPaletCabSGP.ParamByName( 'fecha_transito' ).AsDateTime:= QPaletCabRemota.FieldByName('fecha_transito').AsDateTime;
        //qryPaletCabSGP.ParamByName( 'previsto_carga' ).Value:= QPaletCabRemota.FieldByName('previsto_carga').Value;
        qryPaletCabSGP.ParamByName( 'lote' ).AsString:= QPaletCabRemota.FieldByName('lote').AsString;
        qryPaletCabSGP.ParamByName( 'fecha_modificacion' ).AsDateTime:= Now;

        try
          //Borrar palet en BBDD Local
          lblMessage.Caption:= 'Limpiando palets asociados (CAB).';
          Application.ProcessMessages;
          if qryBorrarPaletCabSGP.Active then qryBorrarPaletCabSGP.Close;
          qryBorrarPaletCabSGP.ParamByName('sscc').AsString:= QPaletCabRemota.FieldByName('ean128_cab').AsString;
          qryBorrarPaletCabSGP.ExecSQL;

          qryPaletCabSGP.ExecSQL;
        except
          inc( iErrores );
          bFlag:= True;
        end;
        QPaletCabRemota.Next;
      end;
    end;
    QPaletCabRemota.Close;
  end;

  with DMRecepcionForm do
  begin
    //Obtener lineas
    lblMessage.Caption:= 'Obtener palets tr?nsito (DET).';
    Application.ProcessMessages;
    QPaletDetRemota.Close;
    QPaletDetRemota.ParamByName('empresa').AsString:= AEmpresa;
    QPaletDetRemota.ParamByName('centro').AsString:= ACentro;
    QPaletDetRemota.ParamByName('fecha').AsDateTime:= AFecha;
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
      lblMessage.Caption:= 'Abrir tabla palets tr?nsito (DET).';
      Application.ProcessMessages;

      iPalet:= 0;
      iErrores:= 0;
      while not QPaletDetRemota.Eof do
      begin
        inc( iPalet );
        lblMessage.Caption:= 'Insertando palet ' + intToStr( iPalet ) + ' de ' + intToStr( iPalets ) + '(DET). ' + intToStr( iErrores ) + ' errores.';
        Application.ProcessMessages;

        QInsertarPaletLog.Close;
        QInsertarPaletLog.ParamByName('empresa_cab').AsString:= AEmpresa;
        QInsertarPaletLog.ParamByName('centro_cab').AsString:= ACentro;
        QInsertarPaletLog.ParamByName('ean128_cab').AsString:= QPaletDetRemota.FieldByName('ean128_det').AsString;
        QInsertarPaletLog.Open;

        //qryPaletDetSGP.ParamByName( 'movimiento' ).AsInteger:= QPaletDetRemota.FieldByName('movimiento').AsInteger;
        qryPaletDetSGP.ParamByName( 'ean128_det' ).AsString:= QPaletDetRemota.FieldByName('ean128_det').AsString;
        qryPaletDetSGP.ParamByName( 'ean13_det' ).AsString:= QPaletDetRemota.FieldByName('ean13_det').AsString;
        qryPaletDetSGP.ParamByName( 'fecha_alta_det' ).AsDateTime:= QPaletDetRemota.FieldByName('fecha_alta_det').AsDateTime;
        qryPaletDetSGP.ParamByName( 'envase_det' ).AsString:= QPaletDetRemota.FieldByName('envase_det').AsString;
        qryPaletDetSGP.ParamByName( 'unidades_det' ).AsInteger:= QPaletDetRemota.FieldByName('unidades_det').AsInteger;
        qryPaletDetSGP.ParamByName( 'calibre_det' ).AsString:= QPaletDetRemota.FieldByName('calibre_det').AsString;
        qryPaletDetSGP.ParamByName( 'color_det' ).AsString:= QPaletDetRemota.FieldByName('color_det').AsString;
        qryPaletDetSGP.ParamByName( 'le_det' ).AsString:= QPaletDetRemota.FieldByName('le_det').AsString;
        qryPaletDetSGP.ParamByName( 'peso_det' ).AsFloat:= QPaletDetRemota.FieldByName('peso_det').AsFloat;
        qryPaletDetSGP.ParamByName( 'ean128_orig_det' ).AsString:= QPaletDetRemota.FieldByName('ean128_orig_det').AsString;
        qryPaletDetSGP.ParamByName( 'ean128_dest_det' ).AsString:= QPaletDetRemota.FieldByName('ean128_dest_det').AsString;
        qryPaletDetSGP.ParamByName( 'terminal_det' ).AsString:= QPaletDetRemota.FieldByName('terminal_det').AsString;
        qryPaletDetSGP.ParamByName( 'albaran_entrada_tfe' ).AsString:= QPaletDetRemota.FieldByName('albaran_entrada_tfe').AsString;
        qryPaletDetSGP.ParamByName( 'recoleccion' ).AsString:= QPaletDetRemota.FieldByName('recoleccion').AsString;
        qryPaletDetSGP.ParamByName( 'plantacion' ).AsString:= QPaletDetRemota.FieldByName('plantacion').AsString;
        qryPaletDetSGP.ParamByName( 'lotecliente' ).AsString:= QPaletDetRemota.FieldByName('lotecliente').AsString;
        qryPaletDetSGP.ParamByName( 'bestbefore' ).AsString:= QPaletDetRemota.FieldByName('bestbefore').AsString;
        qryPaletDetSGP.ParamByName( 'fecha_modificacion' ).AsDateTime:= Now;
        try
          //Borrar palet en BBDD Local
          lblMessage.Caption:= 'Limpiando palets asociados (CAB).';
          Application.ProcessMessages;
          if qryBorrarPaletDetSGP.Active then qryBorrarPaletDetSGP.Close;
          qryBorrarPaletDetSGP.ParamByName('sscc').AsString:= QPaletDetRemota.FieldByName('ean128_det').AsString;
          qryBorrarPaletDetSGP.ExecSQL;

          qryPaletDetSGP.ExecSQL;
          //Borrar movimiento 3, por si ya se hubiera transmitido antes.
          BorrarPCLog( QInsertarPaletLog.FieldByName('ref_transito').AsString, QInsertarPaletLog.FieldByName('ean128_cab').AsString, 3);
          //Insertamos en el LOG - rf_palet_pb_log
          InsertarPCLog( QInsertarPaletLog.FieldBYName('empresa_cab').AsString,
                         QInsertarPaletLog.FieldByName('centro_cab').AsString,
                         QInsertarPaletLog.FieldByName('ean128_cab').AsString,
                         CVariables.gsCodigo,
                         QInsertarPaletLog.FieldByName('ref_transito').AsString,
                         QPaletDetRemota.FieldByName('peso_det').AsFloat,
                         QPaletDetRemota.FieldByName('unidades_det').AsFloat,
                         3);
        except
          Inc( iErrores );
          bFlag:= True;
        end;
        QPaletDetRemota.Next;
      end;
    end;
    QPaletDetRemota.Close;
  end;

  if bFlag then
  begin
    Raise Exception.Create('Error al grabar el packing list.');
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

end.
