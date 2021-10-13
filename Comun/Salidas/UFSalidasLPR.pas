unit UFSalidasLPR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  CMaestroDetalle, Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, ComCtrls, dxCore, cxDateUtils, Menus, ActnList, StdCtrls,
  cxButtons, SimpleSearch, cxMaskEdit, cxDropDownEdit, cxCalendar, cxLabel,
  cxGroupBox, Gauges, ExtCtrls, cxTextEdit, BonnyQuery, CGestionPrincipal, CVariables,
  dxSkinsCore, dxSkinBlue, dxSkinBlueprint, dxSkinFoggy, dxSkinMoneyTwins,
  dxSkinBlack, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinGlassOceans,
  dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue;



type

  TFSalidasLPR = class(TForm)
    tx1: TcxTextEdit;
    pnl1: TPanel;
    Gauge1: TGauge;
    gbCriterios: TcxGroupBox;
    lb2: TcxLabel;
    txDesdeFactura: TcxTextEdit;
    lb3: TcxLabel;
    txHastaFactura: TcxTextEdit;
    lb4: TcxLabel;
    deDesdeFecha: TcxDateEdit;
    lbCliente: TcxLabel;
    txCliente: TcxTextEdit;
    txDesCliente: TcxTextEdit;
    lb5: TcxLabel;
    txEmpresa: TcxTextEdit;
    txDesEmpresa: TcxTextEdit;
    lb1: TcxLabel;
    deHastaFecha: TcxDateEdit;
    btAceptar: TcxButton;
    btCancelar: TcxButton;
    lb7: TcxLabel;
    lbAlbaranes: TcxLabel;
    txRuta: TcxTextEdit;
    lb6: TcxLabel;
    btnRuta: TcxButton;
    ActionList: TActionList;
    ACancelar: TAction;
    AAceptar: TAction;
    ssEmpresa: TSimpleSearch;
    ssCliente: TSimpleSearch;
    procedure btnRutaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PonNombre(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btAceptarClick(Sender: TObject);
    procedure ACancelarExecute(Sender: TObject);
    procedure AAceptarExecute(Sender: TObject);
  private
    iFactIni, iFactFin, n_linea: Integer;
    dFechaIni, dFechaFin: TDateTime;
    QAlbaranesLPR, QDirSuministro :TBonnyQuery;
    cabeceras, errores: TStringList;


    procedure RellenarDatosIni;
    function Parametros: boolean;
    function CrearFicheros(var VMensaje: string):boolean;
    procedure GuardarFichero(ARuta: string);
    procedure LimpiarBuffers;
    procedure CerrarTablas;
    procedure BorrarListas;
    procedure CreaQAlbaranesLPR;
    procedure CreaQDirSuministro;
    function EjecutaQAlbaranesLPR: boolean;
    function EjecutaQDirSuministro: boolean;
    function GetFechaAlbaran: String;
    function GetNumeroAlbaran: String;
    procedure AddCabecera;
    function CamposObligatorios: String;

  public
    { Public declarations }
  end;

var
  FSalidasLPR: TFSalidasLPR;

implementation

{$R *.dfm}
uses UDFactura, Principal, UDMAuxDB, DError, FileCtrl, CGlobal, bTextUtils, UDMBaseDatos, CFactura;

procedure TFSalidasLPR.btnRutaClick(Sender: TObject);
var dir: string;
begin
  dir := txRuta.Text;
  if SelectDirectory(' Selecciona directorio destino.', 'c:\', dir) then
  begin
    if copy(dir, length(dir) - 1, length(dir)) <> '\' then
    begin
      txRuta.Text := dir + '\';
      txRuta.Hint:= txRuta.Text;
    end
    else
    begin
      txRuta.Text := dir;
    end;
  end;
  Application.BringToFront;
end;

procedure TFSalidasLPR.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  if gsDirEdi <> '' then
    txRuta.Text := Lowercase( gsDirEdi + '\');
  txRuta.Hint:= txRuta.Text;

  cabeceras := TStringList.Create;
  errores := TStringList.Create;

  CreaQAlbaranesLPR;
  CreaQDirSuministro;
end;

procedure TFSalidasLPR.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

  CerrarTablas;
  BorrarListas;

  BEMensajes('');
  Action := caFree;

  CloseQuerys([QAlbaranesLPR, QDirSuministro]);
end;

procedure TFSalidasLPR.RellenarDatosIni;
begin
   //Borrar contenido de las tablas
  CerrarTablas;

   //Rellenamos datos iniciales
  txEmpresa.Text := gsDefEmpresa;
  txDesdeFactura.Text := '1';
  txHastaFactura.Text := '999999';
  deDesdeFecha.Text := DateToStr(Date);
  deHastaFecha.Text := DateToStr(Date);

  Gauge1.progress:=0;
  Gauge1.maxvalue:=0;
  lbAlbaranes.Caption := 'Total Albaranes: 0';

  txEmpresa.SetFocus;
end;

procedure TFSalidasLPR.PonNombre(Sender: TObject);
begin
  txDesEmpresa.Text := desEmpresa(txEmpresa.Text);
  txDesCliente.Text := desCliente(txCliente.Text);
end;

procedure TFSalidasLPR.FormShow(Sender: TObject);
begin
  RellenarDatosIni;
end;

procedure TFSalidasLPR.btCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFSalidasLPR.FormKeyDown(Sender: TObject; var Key: Word;
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
  VK_ESCAPE:
    begin
      btCancelarClick(Self);
    end;
  end;
end;

procedure TFSalidasLPR.btAceptarClick(Sender: TObject);
var
  sMsg: string;
begin
  //Esperamos **********************************************
  BEMensajes(' Creando ficheros de texto .....');
  self.Refresh;
  //Esperamos **********************************************
  sMsg := '';

  //Datos del formulario correctos
  if not Parametros then exit;

  if not EjecutaQAlbaranesLPR then
  begin
    ShowMessage('No se han conseguido albaranes para la generación de los ficheros.');
    txCliente.SetFocus;
    Exit;
  end;

  CrearFicheros(sMsg); 
  MessageDlg( sMsg, mtInformation, [mbOK], 0);
  GuardarFichero(txRuta.Text);

//  RellenarDatosIni;
  BEMensajes('');
end;

function TFSalidasLPR.Parametros: boolean;
begin
  Result := False;

  if txDesEmpresa.Text = '' then
  begin
    txEmpresa.SetFocus;
    ShowError('Falta codigo de la empresa o es incorrecto.');
    exit;
  end;

  if txDesCliente.Text = '' then
  begin
    txCliente.SetFocus;
    ShowError('Falta codigo del cliente o es incorrecto.');
    exit;
  end;

  if not TryStrToInt( Trim( txDesdeFactura.Text ), iFactIni ) then
  begin
    txDesdeFactura.SetFocus;
    ShowError('Falta el número del albarán inicial o es incorrecto.');
    exit;
  end;

  if not TryStrToInt( Trim( txHastaFactura.Text ), iFactFin ) then
  begin
    txHastaFactura.SetFocus;
    ShowError('Falta el número del albarán final o es incorrecto.');
    exit;
  end;

  if iFactIni > iFactFin then
  begin
    txDesdeFactura.SetFocus;
    ShowError('Rango de albaranes incorrecto.');
    exit;
  end;

  if  not TryStrToDate( Trim( deDesdeFecha.Text ), dFechaIni ) then
  begin
    deDesdeFecha.SetFocus;
    ShowError('Falta Fecha de Albarán inicial.');
    exit;
  end;

  if not TryStrToDate( Trim( deHastaFecha.Text ), dFechaFin ) then
  begin
    deHastaFecha.SetFocus;
    ShowError('Falta Fecha de Albarán final.');
    exit;
  end;

  if dFechaIni > dFechaFin then
  begin
    deDesdeFecha.SetFocus;
    ShowError('Rango de fechas incorrecto.');
    exit;
  end;

  if not DirectoryExists( txRuta.Text ) then
  begin
    txRuta.SetFocus;
    ShowError('La ruta destino no es valida.');
    exit;
  end;

  Result:= true;

end;

function TFSalidasLPR.EjecutaQAlbaranesLPR: boolean;
begin
  with QAlbaranesLPR do
  begin
    if Active then
      Close;

    ParamByName('empresa').AsString := txEmpresa.Text;
    ParamByName('cliente').AsString := txCliente.Text;
    ParamByName('fechadesde').AsDate := deDesdeFecha.Date;
    ParamByName('fechahasta').AsDate := deHastaFecha.Date;
    ParamByName('albarandesde').AsString := txDesdeFactura.Text;
    ParamByName('albaranhasta').AsString := txHastaFactura.Text;
    Open;

    Result := not IsEmpty;
  end;
end;

procedure TFSalidasLPR.CreaQAlbaranesLPR;
begin
  QAlbaranesLPR := TBonnyQuery.Create(Self);
  with QAlbaranesLPR do
  begin
    SQL.Add('  select empresa_sc, cliente_sal_sc, dir_sum_sc, n_albaran_sc, fecha_sc, tipo_palets_sl, descripcion_tp,                          ');
    SQL.Add('         codigo_lpr_tp, sum(n_palets_sl) cantidad                                                                                 ');
    SQL.Add('     from frf_salidas_c, frf_salidas_l                                                                                            ');
    SQL.Add('  	left join frf_tipo_palets on tipo_palets_sl = codigo_tp                                                                        ');
    SQL.Add('   where empresa_sc = :empresa                                                                                    ');
    SQL.Add('      and cliente_sal_sc = :cliente                                                                               ');
    SQL.Add('      and fecha_sc between :fechadesde and :fechahasta                                                            ');
    SQL.Add('      and n_albaran_sc between :albarandesde and :albaranhasta                                                    ');
    SQL.Add('      and empresa_sl = empresa_sc                                                                                 ');
    SQL.Add('      and centro_salida_sl = centro_salida_sc                                                                     ');
    SQL.Add('      and fecha_sl = fecha_sc                                                                                     ');
    SQL.Add('      and n_albaran_sl = n_albaran_sc                                                                             ');

    SQL.Add('   group by empresa_sc, cliente_sal_sc, dir_sum_sc, n_albaran_sc, fecha_sc, tipo_palets_sl, descripcion_tp, codigo_lpr_tp          ');
    SQL.Add('   order by empresa_sc, cliente_sal_sc, dir_sum_sc, n_albaran_sc, fecha_sc, tipo_palets_sl, descripcion_tp, codigo_lpr_tp          ');

  end;

end;

procedure TFSalidasLPR.CreaQDirSuministro;
begin
  QDirSuministro := TBonnyQuery.Create(Self);
  with QDirSuministro do
  begin
    SQL.Add('  select nombre_ds, domicilio_ds, poblacion_ds, cod_postal_ds, pais_ds, telefono_ds  ');
    SQL.Add('    from frf_dir_sum                                                                 ');
    SQL.Add('   where cliente_ds = :cliente                                                       ');
    SQL.Add('     and dir_sum_ds = :suministro                                                    ');

  end;

end;

function TFSalidasLPR.EjecutaQDirSuministro: boolean;
begin
  with QDirSuministro do
  begin
    if Active then
      Close;

    ParamByName('cliente').AsString :=QAlbaranesLPR.FieldByName('cliente_sal_sc').AsString;
    ParamByName('suministro').AsString := QAlbaranesLPR.FieldByName('dir_sum_sc').AsString;
    Open;

    Result := not IsEmpty;
  end;
end;

function TFSalidasLPR.CrearFicheros(var VMensaje: String): boolean;
var iTotal, iPasados: Integer;
    bAlbError : boolean;
    VError: String;
begin
  LimpiarBuffers;
  DeleteFile(txRuta.Text + 'Errores_FicheroLPR.txt');

  QAlbaranesLPR.Last;
  QAlbaranesLPR.First;
  iTotal:= QAlbaranesLPR.RecordCount;
  Gauge1.maxvalue:= iTotal;
  LbAlbaranes.Caption:= 'Total Albaranes: '+formatfloat(',0',iTotal);
  iPasados:= 0;
  n_linea:= 1;

  QAlbaranesLPR.First;
  while not QAlbaranesLPR.Eof do
  begin
    bAlbError := false;

    EjecutaQDirSuministro;
    VError := CamposObligatorios;
    bAlbError := (VError <> '');
    

    if not bAlbError then
    begin
      AddCabecera;

      Gauge1.progress:=Gauge1.progress+1;
      iPasados:= iPasados + 1;
      Inc(n_linea);
    end
    else
    begin
        errores.Add(VError + ' --> ' + 'Cliente: ' +  QAlbaranesLPR.FieldByName('cliente_sal_sc').AsString +  ' ' +
                                     'Dir. Suministro: ' + QAlbaranesLPR.FieldByName('dir_sum_sc').AsString +  ' ' +
                                     'Empresa: ' + QAlbaranesLPR.FieldByName('empresa_sc').AsString +  ' ' +
                                     'Albaran: ' + QAlbaranesLPR.FieldByName('n_albaran_sc').AsString +  ' ' +
                                     'Fecha Albaran: ' + QAlbaranesLPR.FieldByName('fecha_sc').AsString + ' ' +
                                     'Tipo Pallet: ' + QAlbaranesLPR.FieldByName('tipo_palets_sl').AsString + ' ' + QAlbaranesLPR.FieldByName('descripcion_tp').AsString );
    end;

  {
      if VMensaje = '' then
        VMensaje:=  VError +  #13 + #10 +
                    QAlbaranesLPR.FieldByName('dir_sum_sc').AsString +  ' ' +
                    QAlbaranesLPR.FieldByName('empresa_sc').AsString +  ' ' +
                    QAlbaranesLPR.FieldByName('n_albaran_sc').AsString +  ' ' +
                    QAlbaranesLPR.FieldByName('fecha_sc').AsString
      else
        VMensaje:=  VMensaje + #13 + #10 +
                    VError +  #13 + #10 +
                    QAlbaranesLPR.FieldByName('dir_sum_sc').AsString +  ' ' +
                    QAlbaranesLPR.FieldByName('empresa_sc').AsString +  ' ' +
                    QAlbaranesLPR.FieldByName('n_albaran_sc').AsString +  ' ' +
                    QAlbaranesLPR.FieldByName('fecha_sc').AsString    end;
   }
    QAlbaranesLPR.Next;
  end;

  if iPasados < iTotal then
  begin
    VMensaje:= 'Pasadas ' + IntToStr( iPasados ) + ' de ' +   IntToStr( iTotal ) + ' albaranes.'  + #13 + #10 +
               'No se ha podido generar el fichero completamente.'+  #13 + #10 + 'VER ERRORES EN  ' + txRuta.Text + 'Errores_FicheroLPR.txt' +  #13 + #10;

  end
  else
  begin
    VMensaje:= 'Pasadas ' + IntToStr( iPasados ) + ' albaranes.'  + #13 + #10 +
               'PROCESO FINALIZADO CORRECTAMENTE.';
  end;
  result:= iPasados > 0;

end;

procedure TFSalidasLPR.LimpiarBuffers;
begin
  cabeceras.Clear;
  errores.Clear;
end;


function TFSalidasLPR.CamposObligatorios: String;
var vError: string;
begin
  vError := '';
  if QAlbaranesLPR.Fieldbyname('dir_sum_sc').AsString = '' then
  begin
    vError := 'Falta Direccion Suministro';
    result := vError;
    exit;
  end
  else if QAlbaranesLPR.Fieldbyname('codigo_lpr_tp').AsString = '' then
  begin
    vError := 'Falta Código Pallet';
    result := vError;
    exit;
  end
  else if QAlbaranesLPR.Fieldbyname('n_albaran_sc').AsString = '' then
  begin
    vError := 'Falta Código Referencia cliente';
    result := vError;
    exit;
  end
  else if QDirSuministro.FieldByName('nombre_ds').AsString = '' then
  begin
    vError := 'Falta Nombre Destinario';
    result := vError;
    exit;
  end
  else if QDirSuministro.FieldByName('domicilio_ds').AsString = '' then
  begin
    vError := 'Falta Dirección Destinario';
    result := vError;
    exit;
  end
  else if QDirSuministro.FieldByName('poblacion_ds').AsString = '' then
  begin
    vError := 'Falta Municipio Destinario';
    result := vError;
    exit;
  end
  else if QDirSuministro.FieldByName('pais_ds').AsString = '' then
  begin
    vError := 'Falta Pais Destinario';
    result := vError;
    exit;
  end;

  Result := vError;
end;

procedure TFSalidasLPR.CerrarTablas;
begin
  CloseQuerys([ QAlbaranesLPR, QDirSuministro ]);
end;

procedure TFSalidasLPR.AddCabecera;
begin
  cabeceras.Add(
      'LIN' + '^' +                                                                  //1 - Nuevo Registro: O          0 - Obligatorio  P- Opcional
      IntToStr(n_linea) + '^' +                                                      //2 - Número Registro: O
      'INT' + '^' +                                                                  //3 - Calificador codigo cliente: O
      'BONNYSA' + '^' +                                                              //4 - Codigo remitente: O
      'INT' + '^' +                                                                  //5 - Calificador codigo destinatario: O
      QAlbaranesLPR.FieldByName('dir_sum_sc').AsString + '^' +                       //6 - Codigo destinatario: O
      'LPR' + '^' +                                                                  //7 - Calificador codigo pallet: O
      QAlbaranesLPR.FieldByNAme('codigo_lpr_tp').AsString + '^' +                    //8 - Codigo pallet: O
      GetFechaAlbaran + '^' +                                                        //9 - fecha movimiento (albaran): O
      QAlbaranesLPR.FieldByName('cantidad').AsString + '^' +                         //10 - cantidad: O
      GetNumeroAlbaran + '^' +                                                       //11 - Referencia cliente (albaran): O
      '^' +                                                                          //12 - Referencia destino: P
      QDirSuministro.FieldByName('nombre_ds').AsString + '^' +                       //13 - Nombre destinatario: O
      QDirSuministro.FieldByName('domicilio_ds').AsString + '^' +                    //14 - Direccion destinatario: O
      QDirSuministro.FieldByName('poblacion_ds').AsString + '^' +                    //15 - Municipio destinatario: O
      QDirSuministro.FieldByName('cod_postal_ds').AsString + '^' +                   //16 - CP dedstinatario: P
      QDirSuministro.FieldByName('pais_ds').AsString + '^' +                         //17 - Pais destinatario: O
      QDirSuministro.FieldByName('telefono_ds').AsString + '^' +                     //18 - Telefono destinatario: P
      '^' +                                                                          //19 - Codigo Flujo: P
      '^' +                                                                          //20 - Señalizador movimiento especial: P
      '^' +                                                                          //21 - Comentario: P
      'EOR'                                                                          //22 - Fin Registro: O
    );
end;

procedure TFSalidasLPR.GuardarFichero(ARuta: string);
var sNombre: String;
begin
  //Guardar ficheros
  if cabeceras.count > 0 then
  begin
    sNombre := 'FicheroLPR' + '_' + FormatDateTime( 'yyyymmddhhnnss', Now ) + '.txt';
    cabeceras.savetofile(ARuta + sNombre);
  end;

  //Guardar fichero de errores
  if errores.Count > 0 then
  begin
    sNombre := 'Errores_FicheroLPR.txt';
    errores.savetofile(ARuta + sNombre);
  end;
end;

function TFSalidasLPR.GetFechaAlbaran: String;
begin
  result := FormatDateTime('yyyymmdd', QAlbaranesLPR.FieldByName('fecha_sc').Asdatetime );
end;

function TFSalidasLPR.GetNumeroAlbaran: String;
begin
  result := QAlbaranesLPR.FieldByName('n_albaran_sc').AsString;
end;

procedure TFSalidasLPR.BorrarListas;
begin
  FreeAndNil(cabeceras);
end;

procedure TFSalidasLPR.ACancelarExecute(Sender: TObject);
begin
  btCancelar.Click;
end;

procedure TFSalidasLPR.AAceptarExecute(Sender: TObject);
begin
  btAceptar.Click;
end;

end.
