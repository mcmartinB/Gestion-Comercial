unit DConTransitos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ExtCtrls, StdCtrls, Mask, DBCtrls, CMaestroDetalle, Buttons,
  ActnList, Grids, DBGrids, BGridButton, BGrid, BDEdit, BEdit,
  CVariables, derror, BSpeedButton, DBTables, Menus;

type
  TFConTransitos = class(TForm)
    DSMaestro: TDataSource;
    PSuperior: TPanel;
    btnLocalizar: TSpeedButton;
    btnSalir: TSpeedButton;
    QConTransitosC: TTable;
    btnImprimir: TSpeedButton;
    RResultado: TDBGrid;
    cbxPendientes: TCheckBox;
    cbxSobreventa: TCheckBox;
    cbxVendidos: TCheckBox;
    PopupMenu: TPopupMenu;
    mnuReferencia: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure RResultadoDblClick(Sender: TObject);
    procedure ALocalizarExecute(Sender: TObject);
    procedure ASalirExecute(Sender: TObject);
    procedure RResultadoTitleClick(Column: TColumn);
    procedure AImprimirExecute(Sender: TObject);
    procedure pmBuscaClick(Sender: TObject);
    procedure cbxEstadoChange(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure mnuReferenciaClick(Sender: TObject);
  private
    { Private declarations }
    bPrimera: boolean;
    sEmpresa, sCentroSalida, sCentroOrigen, sCentroDestino, sProducto: string;
    dFechaInicio, dFechaFin: TDateTime;
    ListaComponentes: TList;

    //Nuevas funciones
    procedure BorrarTablasTemporales;
    function  CrearTablasTemporales: Boolean;
    procedure VaciarTablas;
    function  TablaEntradas: Boolean;
    function  TablaSalidas: Boolean;
    procedure TablaReunion;
    procedure NullToZero;
  end;

implementation

uses bDialogs, CGestionPrincipal, UDMBaseDatos, UDMAuxDB, CAuxiliarDB,
     Principal, DPreview, LConsultaTransitos, bSQLUtils, CReportes,
     ParamConsultaTransitosFC, DesgloseTransitosFC;

{$R *.DFM}

//************************** CREAMOS EL FORMULARIO ************************

procedure TFConTransitos.FormCreate(Sender: TObject);
begin
  bPrimera:= True;
     //Lista de componentes
  ListaComponentes := TList.Create;

     //Decimos de que clase es el formulario y el principal adapta el menu
  FormType := tfOther;
  BHFormulario;


  //Para intentar reducir el numero de veces que abrimos la consulta
  DMBaseDatos.QDespegables.Tag := 0;

  //Inicializo variables
  if CrearTablasTemporales then Tag := 0
  else Tag := -1;

  QConTransitosC.TableName := 'tmp_transitos';
end;

procedure TFConTransitos.FormActivate(Sender: TObject);
begin
  if Tag = -1 then Close;
  Top := 1;
end;

procedure TFConTransitos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ListaComponentes.Free;

  //Restauramos algunas propiedades
  DMBaseDatos.QDespegables.Tag := 0;

  //Cerrar tablas
  QConTransitosC.close;

  //Borrar temporales
  BorrarTablasTemporales;

     //Restauramos barra de herramientas si es necesario
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

  BETexto('', '');

  // Cambia acción por defecto para Form hijas en una aplicación MDI
  // Cierra el Form y libera toda la memoria ocupada por el Form
  Action := caFree;
end;

//********************************************************************
//*****************************************************************************
//FUNCIONES VARIAS
//*****************************************************************************
//*****************************************************************************
procedure TFConTransitos.TablaReunion;
begin
  ConsultaExec(' INSERT INTO tmp_transitos ' +
    ' SELECT empresa_ti,centro_salida_ti, referencia_ti, fecha_ti,' +
    '        centro_origen_ti, centro_destino_ti, kilos_ti, kilos_to, ' +
    '        kilos_ti-kilos_to  ' +
    ' FROM tmp_transitos_in ,OUTER tmp_transitos_out  ' +
    ' WHERE empresa_ti=empresa_to ' +
    ' AND centro_origen_ti=centro_origen_to ' +
    ' AND referencia_ti=referencia_to');
end;

function TFConTransitos.TablaSalidas: Boolean;
var
  sCad: string;
begin
  //SALIDAS DIRECTAS
  sCad:= ' INSERT INTO tmp_transitos_out ' +
    ' SELECT empresa_sl,centro_origen_sl,ref_transitos_sl,SUM(kilos_sl), ' +
    QuotedStr('D') + ' ' +
    ' FROM frf_salidas_l ' +
    ' WHERE empresa_sl=' + QuotedStr(sEmpresa);

  //if Trim(sCentroSalida) <> '' then
  //  sCad:= sCad + '   AND centro_sl=' + QuotedStr(sCentroOrigen);
  if Trim(sCentroOrigen) <> '' then
    sCad:= sCad + '   AND centro_origen_sl=' + QuotedStr(sCentroOrigen);
  //if Trim(sCentroDestino) <> '' then
  //  sCad:= sCad + '   AND centro_destino_sl=' + QuotedStr(sCentroDestino);
  if Trim(sProducto) <> '' then
    sCad:= sCad + '   AND producto_sl=' + QuotedStr(sProducto);


  sCad:= sCad + '   AND fecha_sl < ' + SQLDate(DateToStr(IncMonth(dFechaFin,3)));
  sCad:= sCad + '   AND fecha_sl >= ' + SQLDate(DateToStr(dFechaInicio)) +
    '   AND ref_transitos_sl IS NOT NULL ' +
    ' GROUP BY empresa_sl,centro_origen_sl,ref_transitos_sl';
  if ConsultaExec(sCad) = -1
    then result := False
  else result := True;

  sCad:= ' INSERT INTO tmp_transitos_out ' +
    ' SELECT empresa_tl,centro_origen_tl,ref_origen_tl, ' +
    '        SUM(kilos_tl), ' + QuotedStr('I') + ' ' +
    ' FROM frf_transitos_l ' +
    ' WHERE empresa_tl=' + QuotedStr(sEmpresa) ;

  if Trim(sCentroDestino) <> '' then
    sCad:= sCad + '   AND centro_tl=' + QuotedStr(sCentroDestino);
  if Trim(sCentroOrigen) <> '' then
    sCad:= sCad + '   AND centro_origen_tl=' + QuotedStr(sCentroOrigen);

  if Trim(sProducto) <> '' then
    sCad:= sCad + '   AND producto_tl=' + QuotedStr(sProducto);

  sCad:= sCad + '   AND fecha_tl < ' + SQLDate(DateToStr(IncMonth(dFechaFin,3)));
  sCad:= sCad + '   AND fecha_tl>= ' + SQLDate(dFechaInicio) +
    '   AND ref_origen_tl IS NOT NULL ' +
    ' GROUP BY empresa_tl,centro_origen_tl,ref_origen_tl';
  if not ConsultaExec(sCad) = -1
    then result := True;
  //SALIDAS TOTALES (UNIR LAS DOS)
  if result then
  begin
    ConsultaExec(' SELECT empresa_to,centro_origen_to,referencia_to,SUM(kilos_to) kilos, ' +
      QuotedStr('T') + ' tipo' +
      ' FROM tmp_transitos_out ' +
      ' WHERE tipo_to = ' + QuotedStr('D') + ' or tipo_to = ' +
      QuotedStr('I') + ' ' +
      ' GROUP BY empresa_to,centro_origen_to,referencia_to' +
      ' INTO TEMP pp ');

    ConsultaExec(' DELETE FROM tmp_transitos_out ' +
      ' WHERE 1=1 '); ;

    ConsultaExec(' INSERT INTO tmp_transitos_out ' +
      ' SELECT * ' +
      ' FROM pp ');


    ConsultaExec(' DROP TABLE pp ');
  end;
end;

function TFConTransitos.TablaEntradas: Boolean;
var
  sCad: string;
begin
  sCad:= ' INSERT INTO tmp_transitos_in ' +
    ' SELECT empresa_tl, centro_tl, referencia_tl, fecha_tl, ' +
    '        centro_origen_tl, centro_destino_tl, SUM(kilos_tl) ' +
    ' FROM frf_transitos_l ' +
    ' WHERE empresa_tl = ' + QuotedStr(sEmpresa);

  if Trim(sCentroSalida) <> '' then
    sCad:= sCad + '   AND centro_tl=' + QuotedStr(sCentroSalida);
  if Trim(sCentroOrigen) <> '' then
    sCad:= sCad + '   AND centro_origen_tl=' + QuotedStr(sCentroOrigen);
  if Trim(sCentroDestino) <> '' then
    sCad:= sCad + '   AND centro_destino_tl=' + QuotedStr(sCentroDestino);

  sCad:= sCad + '   AND fecha_tl between ' + SQLDate(dFechaInicio) +
    ' and '  + SQLDate(dFechaFin);
  if ( sProducto <> '' ) then
      sCad:= sCad + '   AND producto_tl = ' + QuotedStr(sProducto);
  sCad:= sCad + ' GROUP BY empresa_tl, centro_tl, referencia_tl, fecha_tl, ' +
    '        centro_origen_tl, centro_destino_tl';
  if ConsultaExec( sCad ) = -1
    then result := False
  else result := True;
end;

procedure TFConTransitos.NullToZero;
begin
  ConsultaExec(' Update tmp_transitos set kilos_salen_t = 0, kilos_quedan_t = kilos_entran_t  ' +
    ' where kilos_quedan_t is NULL ', False, False);
end;

procedure TFConTransitos.VaciarTablas;
begin
  ConsultaExec(' DELETE FROM tmp_transitos_in ', False, false);
  ConsultaExec(' DELETE FROM tmp_transitos_out ', False, false);
  ConsultaExec(' DELETE FROM tmp_transitos ', False, false);
end;

procedure TFConTransitos.BorrarTablasTemporales;
begin
  ConsultaExec(' DROP TABLE tmp_transitos_in ', False, false);
  ConsultaExec(' DROP TABLE tmp_transitos_out ', False, false);
  ConsultaExec(' DROP TABLE tmp_transitos ', False, false);
end;

function TFConTransitos.CrearTablasTemporales: Boolean;
begin
  CrearTablasTemporales := False;
  if ConsultaExec(' CREATE TEMP TABLE tmp_transitos_in ( ' +
    ' empresa_ti CHAR(3), ' +
    ' centro_salida_ti CHAR(1), ' +
    ' referencia_ti INTEGER , ' +
    ' fecha_ti DATE, ' +
    ' centro_origen_ti CHAR(1), ' +
    ' centro_destino_ti CHAR(1), ' +
    ' kilos_ti DECIMAL(10,2) DEFAULT 0, ' +
    ' UNIQUE (empresa_ti, centro_salida_ti, referencia_ti, fecha_ti, '+
    '         centro_origen_ti, centro_destino_ti ))', False, False) = -1
    then Exit;

  if ConsultaExec(' CREATE TEMP TABLE tmp_transitos_out ( ' +
    ' empresa_to CHAR(3), ' +
    ' centro_origen_to CHAR(1), ' +
    ' referencia_to INTEGER , ' +
    ' kilos_to DECIMAL(10,2) DEFAULT 0, ' +
    ' tipo_to CHAR(1), ' +
    ' UNIQUE (empresa_to, centro_origen_to, referencia_to,tipo_to))', False, False) = -1
    then Exit;

  if ConsultaExec(' CREATE TEMP TABLE tmp_transitos ( ' +
    ' empresa_t CHAR(3), ' +
    ' centro_salida_t CHAR(1), ' +
    ' referencia_t INTEGER , ' +
    ' fecha_t DATE, ' +
    ' centro_origen_t CHAR(1), ' +
    ' centro_destino_t CHAR(1), ' +
    ' kilos_entran_t DECIMAL(10,2) DEFAULT 0, ' +
    ' kilos_salen_t DECIMAL(10,2)  DEFAULT 0, ' +
    ' kilos_quedan_t DECIMAL(10,2) DEFAULT 0, ' +
    ' UNIQUE (empresa_t, centro_salida_t, referencia_t, fecha_t, ' +
    '         centro_origen_t, centro_destino_t ))', False, False) = -1
    then Exit;

  CrearTablasTemporales := True;
end;

procedure TFConTransitos.RResultadoDblClick(Sender: TObject);
begin
  if not QConTransitosC.Active  or QConTransitosC.IsEmpty Then
  begin
    MessageDlg('No hay datos a mostrar', mtInformation, [mbOk], 0);
    Exit;
  end;
  //Llamada al otro formulario
  ConsultaTransito( self, sEmpresa,
    QConTransitosC.FIeldByName('centro_salida_t').AsString,
    QConTransitosC.FieldByName('referencia_t').AsInteger,
    QConTransitosC.FieldByName('fecha_t').AsDateTime);
end;

procedure TFConTransitos.ALocalizarExecute(Sender: TObject);
begin
  sEmpresa:= '050';
  sCentroSalida:= '';
  sCentroOrigen:= '';
  sCentroDestino:= '';
  sProducto:= '';
  dFechaInicio:= IncMonth( Date, -3 );
  dFechaFin:= Date;

  if ParamConsultaTransitosFC.Ejecutar( self, sEmpresa, sCentroSalida, sCentroOrigen, sCentroDestino, sProducto,
            dFechaInicio, dFechaFin ) then
  begin
    QConTransitosC.Close;

    VaciarTablas;

    if not TablaEntradas then
    begin
      MessageDlg('' + #13 + #10 + 'No hay tránsitos para los datos introducidos    ' + #13 + #10 + 'en el formulario.', mtInformation, [mbOK], 0);
      Exit;
    end;
    if TablaSalidas then
      TablaReunion;
    NullToZero;

    cbxVendidos.Checked:= False;
    cbxSobreventa.Checked:= True;
    cbxPendientes.Checked:= True;
    QConTransitosC.Filter:= 'kilos_quedan_t <> 0';
    QConTransitosC.Open;
  end;
end;

procedure TFConTransitos.AImprimirExecute(Sender: TObject);
var enclave: TBookMark;
begin
  if not QConTransitosC.Active  or QConTransitosC.IsEmpty Then
  begin
    MessageDlg('No hay datos a mostrar', mtInformation, [mbOk], 0);
    Exit;
  end;
  //Imprimir listado
  enclave := QConTransitosC.GetBookmark;
  QConsultaTransitos := TQConsultaTransitos.Create(Application);

  PonLogoGrupoBonnysa(QConsultaTransitos, sEmpresa);
  if Trim(sProducto) = '' then
  begin
    QConsultaTransitos.lblProducto.Caption := 'TODOS LOS PRODUCTOS';
  end
  else
  begin
    QConsultaTransitos.lblProducto.Caption := 'PRODUCTO : [' + sProducto + ']' +
                                            desProducto( sEmpresa, sProducto );
  end;
  QConsultaTransitos.lblRangoFechas.Caption := 'Desde el ' + DateToStr( dFechaInicio ) +
                                               ' al ' + DateToStr( dFechaFin );

  Preview(QConsultaTransitos);
  QConTransitosC.GotoBookmark(enclave);
  QConTransitosC.FreeBookmark(enclave);
end;

procedure TFConTransitos.ASalirExecute(Sender: TObject);
begin
  Close;
end;


procedure TFConTransitos.RResultadoTitleClick(Column: TColumn);
begin
  //Metodo de ordenación
  QConTransitosC.IndexFieldNames := Column.FieldName;
end;

procedure TFConTransitos.pmBuscaClick(Sender: TObject);
var
  enclave: TBookMark;
  transito: string;
  encontrado: Boolean;
begin
  //Refencia a buscar
  transito := '';
  if not InputQuery('Introduce referencia de tránsito a buscar.', '', transito) then
    Exit;

  if transito = '' then
    Exit;

  //Preparacion
  enclave := QConTransitosC.GetBookmark;
  QConTransitosC.DisableControls;

  //Busqueda
  encontrado := False;
  QConTransitosC.First;
  while ((not encontrado) and (not QConTransitosC.EOF)) do
    if QConTransitosC.FieldByName('referencia_t').AsString = transito then encontrado := True
    else QConTransitosC.Next;

  //Activar registro
  if not encontrado then begin
    QConTransitosC.GotoBookmark(enclave);
    MessageDlg('' + #13 + #10 + '   Tránsito (' + transito + ') no encontrado.      ', mtInformation, [mbOK], 0);
  end;
  QConTransitosC.FreeBookmark(enclave);
  QConTransitosC.EnableControls;

end;

procedure TFConTransitos.cbxEstadoChange(Sender: TObject);
var
  sFiltro: string;
begin
  sFiltro:= '';
  if cbxPendientes.Checked then
  begin
    sFiltro:= 'kilos_quedan_t > 0';
  end;
  if cbxSobreventa.Checked then
  begin
    if sFiltro <> '' then
      sFiltro:= sFiltro +  ' or kilos_quedan_t < 0'
    else
      sFiltro:= 'kilos_quedan_t < 0';
  end;
  if cbxVendidos.Checked then
  begin
    if sFiltro <> '' then
      sFiltro:= sFiltro +  ' or kilos_quedan_t = 0'
    else
      sFiltro:= 'kilos_quedan_t = 0';
  end;
  QConTransitosC.Filter:= sFiltro;
end;

procedure TFConTransitos.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    vk_F1: btnLocalizar.Click;
    vk_ESCAPE: btnSalir.Click;
    ord('I'),ord('i'): btnImprimir.Click;
    ord('B'),ord('b'): mnuReferencia.Click;
  end;
end;

procedure TFConTransitos.FormShow(Sender: TObject);
begin
  if bPrimera then
  begin
    bPrimera:= False;
    btnLocalizar.Click;
  end;
end;

procedure TFConTransitos.mnuReferenciaClick(Sender: TObject);
var
  sReferencia: string;
begin
  if InputQuery('BUSQUEDA TRÁNSITO.','Introduce referencia',sReferencia) then
  begin
    QConTransitosC.Locate('referencia_t',sReferencia,[loCaseInsensitive, loPartialKey])
  end;
end;

end.
