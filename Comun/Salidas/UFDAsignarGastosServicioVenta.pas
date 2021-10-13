unit UFDAsignarGastosServicioVenta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, nbLabels, nbCombos, nbEdits, BEdit, DB,
  DBTables;

type
  TFDAsignarGastosServicioVenta = class(TForm)
    btnCerrar: TBitBtn;
    btnImprimir: TBitBtn;
    lblEmpresa: TnbLabel;
    stEmpresa: TLabel;
    eEmpresa: TnbDBSQLCombo;
    nbLabel1: TnbLabel;
    eFechaDesde: TnbDBCalendarCombo;
    nbLabel3: TnbLabel;
    eFechaHasta: TnbDBCalendarCombo;
    nbLabel4: TnbLabel;
    lblTransportista: TLabel;
    eTransportista: TnbDBSQLCombo;
    QSelectServicios: TQuery;
    lbl1: TnbLabel;
    eMatricula: TnbCustomEdit;
    lbl2: TLabel;
    cbbUnidadDist: TComboBox;
    lblCodigo1: TnbLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCerrarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure eEmpresaChange(Sender: TObject);
    function eTransportistaGetSQL: String;
    procedure eTransportistaChange(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sMatricula, sTransportista: string;
    dIni, dFin: TDateTime;

    procedure ValidarCampos;
    function  HayServiciosPendientes: Boolean;
    procedure AsignarGastosASalidas;

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CVariables, Principal, CGestionPrincipal, UDMAuxDB, DPreview, UDMBaseDatos,
     UDMConfig, CDAsignarGastosServicioVenta;

procedure TFDAsignarGastosServicioVenta.FormCreate(Sender: TObject);
begin
  FormType:=tfOther;
  BHFormulario;

  eEmpresa.Text:= gsDefEmpresa;
  eTransportista.Text:= '';
  eMatricula.Text:= '';

  eFechaDesde.Text:= FormatDateTime('dd/mm/yyyy', IncMonth( Date - 1, -3 ) );
  eFechaHasta.Text:= FormatDateTime('dd/mm/yyyy', Date-1 );
end;

procedure TFDAsignarGastosServicioVenta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType:=tfDirector;
    BHFormulario;
  end;
  Action:=caFree;
end;

procedure TFDAsignarGastosServicioVenta.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFDAsignarGastosServicioVenta.ValidarCampos;
begin
  if Trim(stEmpresa.Caption) = '' then
  begin
    eEmpresa.SetFocus;
    raise Exception.Create('Falta el codigo de la empresa o es incorrecto.');
  end;
  sEmpresa:= eEmpresa.Text;

  if Trim(lblTransportista.Caption) = '' then
  begin
    eTransportista.SetFocus;
    raise Exception.Create('El codigo del transportista es incorrecto.');
  end;
  sTransportista:= eTransportista.Text;

  sMatricula:= Trim( eMatricula.Text );

  //validar fechas
  if not tryStrTodate( eFechaDesde.Text, dIni ) then
  begin
    eFechaDesde.SetFocus;
    raise Exception.Create('Fecha de inicio incorrecta.');
  end;
  if not tryStrTodate( eFechaHasta.Text, dFin ) then
  begin
    eFechaHasta.SetFocus;
    raise Exception.Create('Fecha de fin incorrecta.');
  end;
  if ( eFechaDesde.Text <> '' ) and ( eFechaHasta.Text <> '' ) then
  begin
    if dIni > dFin then
    begin
      eFechaDesde.SetFocus;
      raise Exception.Create('Rango de fechas incorrecto.');
    end;
  end;
end;


procedure TFDAsignarGastosServicioVenta.btnImprimirClick(Sender: TObject);
begin
  ValidarCampos;
  try
    if HayServiciosPendientes then
      AsignarGastosASalidas
    else
      ShowMessage('No hay servicios de transporte o todos los gastos ya han sido asignados.'  );
  finally
    QSelectServicios.Close;
  end;
end;

function TFDAsignarGastosServicioVenta.HayServiciosPendientes: Boolean;
begin
  with QSelectServicios do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_sv, servicio_sv ');
    SQL.Add(' from frf_servicios_venta ');
    SQL.Add(' where empresa_sv = :empresa ');
    if sMatricula <> '' then
      SQL.Add(' and matricula_sv = :matricula ');
    if sTransportista <> '' then
    begin
      SQL.Add(' and exists ');
      SQL.Add(' ( ');
      SQL.Add('   select * ');
      SQL.Add('   from frf_salidas_servicios_venta, frf_salidas_c ');
      SQL.Add('   where empresa_ssv = :empresa ');
      SQL.Add('   and servicio_ssv= servicio_sv ');
      SQL.Add('   and empresa_sc = :empresa ');
      SQL.Add('   and centro_salida_sc = centro_salida_ssv ');
      SQL.Add('   and n_albaran_sc = n_albaran_ssv ');
      SQL.Add('   and fecha_sc = fecha_ssv ');
      SQL.Add('   and transporte_sc = :transporte ');
      SQL.Add(' ) ');
    end;
    SQL.Add(' and fecha_sv between :ini and :fin ');
    SQL.Add(' and status_sv < 2 ');
    SQL.Add(' and exists ');
    SQL.Add('  ( ');
    SQL.Add('    select * ');
    SQL.Add('    from frf_gastos_servicios_venta ');
    SQL.Add('    where empresa_gsv = :empresa ');
    SQL.Add('    and servicio_gsv = servicio_sv ');
    SQL.Add('  ) ');

    ParamByName('empresa').asString:= sEmpresa;
    if sMatricula <> '' then
      ParamByName('matricula').asString:= sMatricula;
    if sTransportista <> '' then
      ParamByName('transporte').asString:= sTransportista;
    ParamByName('ini').AsDateTime:= dIni;
    ParamByName('fin').AsDateTime:= dfin;
  end;
  QSelectServicios.Open;
  Result:= not QSelectServicios.IsEmpty;
end;

function UnidadDist( const AIndex: Integer ): string;
begin
  case AIndex of
    0: Result:= '';  //grabado en tipo gastos
    1: Result:= 'K'; //Forzar por Kilos
  (*
    0: Result:= '';  //grabado en tipo gastos
    1: Result:= 'P'; //Forzar por Palets
    2: Result:= 'C'; //Forzar por Cajas
    3: Result:= 'K'; //Forzar por Kilos
    4: Result:= 'I'; //Forzar por Importe
  *)
  end;
end;

procedure TFDAsignarGastosServicioVenta.AsignarGastosASalidas;
var
  sAux: string;
  iTotal, iOk: Integer;
  slError, slOK: TStringList;
begin
  iTotal:= 0;
  iOk:= 0;

  DAsignarGastosServicioVenta:= TDAsignarGastosServicioVenta.Create( self );
  try
    slError:= TStringList.Create;
    slOK:= TStringList.Create;

    while not QSelectServicios.Eof do
    begin
      if DAsignarGastosServicioVenta.RepercutirGastosServicio(
           QSelectServicios.FieldByname('empresa_sv').AsString,
           QSelectServicios.FieldByname('servicio_sv').AsInteger,
           UnidadDist( cbbUnidadDist.ItemIndex ),
           True, sAux ) then
      begin
         iOk:= iOk + 1;
         slOk.Add( sAux );
      end
      else
      begin
        slError.Add( sAux );
      end;
      iTotal:= iTotal + 1;
      QSelectServicios.Next;
    end;
    if iOk <> iTotal then
    begin
     ShowMessage('Proceso finalizado con errores.' + #13 + #10 +
                 'Asignado los gastos de ' + IntToStr( iOk ) + ' de ' + IntToStr( iTotal ) + ' compras.' + #13 + #10 +
                 '*****  OK  *****.' + #13 + #10 +
                 slOK.Text  + #13 + #10 +
                 '***** ERROR *****.' + #13 + #10 +
                 slError.Text );
    end
    else
    begin
     ShowMessage('Proceso finalizado correctamente.' + #13 + #10 +
                 'Se han asignado los gastos de ' + IntToStr( iOk ) + ' compras.' + #13 + #10 +
                 slOK.Text );
    end;
  finally
    FreeAndNil( DAsignarGastosServicioVenta );
    FreeAndNil( slError );
  end;
end;

procedure TFDAsignarGastosServicioVenta.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    Vk_escape: btnCerrar.Click;
    vk_f1: btnImprimir.Click;
  end;
end;

procedure TFDAsignarGastosServicioVenta.eEmpresaChange(Sender: TObject);
begin
  stEmpresa.Caption:= desEmpresa( eEmpresa.Text );
  eTransportistaChange( eTransportista );
end;

function TFDAsignarGastosServicioVenta.eTransportistaGetSQL: String;
begin
  Result:= 'select transporte_t, descripcion_t' + #13 + #10;
  Result:= Result + 'from frf_transportistas' + #13 + #10;
  Result:= Result + 'order by 1,2' + #13 + #10;
end;

procedure TFDAsignarGastosServicioVenta.eTransportistaChange(Sender: TObject);
begin
  if eTransportista.Text <> '' then
  begin
    lblTransportista.Caption:= desTransporte( eEmpresa.Text, eTransportista.Text );
  end
  else
  begin
    lblTransportista.Caption:= '(Vacio, todos los transportistas)';
  end;
end;

end.
