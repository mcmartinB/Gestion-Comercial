unit ServiciosEntregaAsignarGastosFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, nbLabels, nbCombos, nbEdits, BEdit, DB,
  DBTables;

type
  TFDServiciosEntregaAsignarGastos = class(TForm)
    btnCerrar: TBitBtn;
    btnImprimir: TBitBtn;
    nbLabel1: TnbLabel;
    eFechaDesde: TnbDBCalendarCombo;
    nbLabel3: TnbLabel;
    eFechaHasta: TnbDBCalendarCombo;
    QSelectServicios: TQuery;
    lbl1: TnbLabel;
    eMatricula: TnbCustomEdit;
    lbl2: TLabel;
    cbbUnidadDist: TComboBox;
    lblCodigo1: TnbLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCerrarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    sMatricula: string;
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
     UDMConfig, ServiciosEntregaDM;

procedure TFDServiciosEntregaAsignarGastos.FormCreate(Sender: TObject);
begin
  FormType:=tfOther;
  BHFormulario;

  eMatricula.Text:= '';

  eFechaDesde.Text:= FormatDateTime('dd/mm/yyyy', IncMonth( Date - 1, -3 ) );
  eFechaHasta.Text:= FormatDateTime('dd/mm/yyyy', Date-1 );
end;

procedure TFDServiciosEntregaAsignarGastos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType:=tfDirector;
    BHFormulario;
  end;
  Action:=caFree;
end;

procedure TFDServiciosEntregaAsignarGastos.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFDServiciosEntregaAsignarGastos.ValidarCampos;
begin
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


procedure TFDServiciosEntregaAsignarGastos.btnImprimirClick(Sender: TObject);
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

function TFDServiciosEntregaAsignarGastos.HayServiciosPendientes: Boolean;
begin
  with QSelectServicios do
  begin
    SQL.Clear;
    SQL.Add(' select servicio_sec ');
    SQL.Add(' from frf_servicios_entrega_c ');
    SQL.Add(' where fecha_sec between :ini and :fin ');
    SQL.Add(' and status_sec < 2 ');
    if sMatricula <> '' then
      SQL.Add(' and matricula_sec = :matricula ');
    SQL.Add(' and exists ');
    SQL.Add('  ( ');
    SQL.Add('    select * ');
    SQL.Add('    from frf_servicios_entrega_g ');
    SQL.Add('    where servicio_sec = servicio_seg ');
    SQL.Add('  ) ');

    if sMatricula <> '' then
      ParamByName('matricula').asString:= sMatricula;
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
    1: Result:= 'P'; //Forzar por Palets
    2: Result:= 'C'; //Forzar por Cajas
    3: Result:= 'K'; //Forzar por Kilos
    4: Result:= 'I'; //Forzar por Importe
  end;
end;

procedure TFDServiciosEntregaAsignarGastos.AsignarGastosASalidas;
var
  sAux: string;
  iTotal, iOk: Integer;
  slError, slOK: TStringList;
begin
  iTotal:= 0;
  iOk:= 0;

  DMServiciosEntrega:= TDMServiciosEntrega.Create( self );
  try
    slError:= TStringList.Create;
    slOK:= TStringList.Create;

    while not QSelectServicios.Eof do
    begin
      if DMServiciosEntrega.RepercutirGastosServicio(
           QSelectServicios.FieldByname('servicio_sec').AsInteger,
           UnidadDist( cbbUnidadDist.ItemIndex ),
           True, False, sAux ) then
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
                 'Asignado los gastos de ' + IntToStr( iOk ) + ' de ' + IntToStr( iTotal ) + ' servicios.' + #13 + #10 +
                 '*****  OK  *****.' + #13 + #10 +
                 slOK.Text  + #13 + #10 +
                 '***** ERROR *****.' + #13 + #10 +
                 slError.Text );
    end
    else
    begin
     ShowMessage('Proceso finalizado correctamente.' + #13 + #10 +
                 'Se han asignado los gastos de ' + IntToStr( iOk ) + ' servicios.' + #13 + #10 +
                 slOK.Text );
    end;
  finally
    FreeAndNil( DMServiciosEntrega );
    FreeAndNil( slError );
  end;
end;

procedure TFDServiciosEntregaAsignarGastos.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    Vk_escape: btnCerrar.Click;
    vk_f1: btnImprimir.Click;
  end;
end;

end.
