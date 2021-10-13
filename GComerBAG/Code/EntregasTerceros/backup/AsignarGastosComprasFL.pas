unit AsignarGastosComprasFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, nbLabels, nbCombos, nbEdits, BEdit, DB,
  DBTables;

type
  TFLAsignarGastosCompras = class(TForm)
    btnCerrar: TBitBtn;
    btnImprimir: TBitBtn;
    lblEmpresa: TnbLabel;
    nbLabel2: TnbLabel;
    stEmpresa: TLabel;
    stCentro: TLabel;
    empresa: TnbDBSQLCombo;
    centro: TnbDBSQLCombo;
    nbLabel1: TnbLabel;
    eDesde: TnbDBCalendarCombo;
    nbLabel3: TnbLabel;
    eHasta: TnbDBCalendarCombo;
    nbLabel4: TnbLabel;
    lblProveedor: TLabel;
    proveedor: TnbDBSQLCombo;
    QSelectFacturas: TQuery;
    DSSelectFacturas: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCerrarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    function centroGetSQL: String;
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure empresaChange(Sender: TObject);
    procedure centroChange(Sender: TObject);
    function proveedorGetSQL: String;
    procedure proveedorChange(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, scentro, sProveedor: string;
    dIni, dFin: TDateTime;

    procedure ValidarCampos;
    function  HayEntregas: Boolean;
    procedure AsignarGastosAEntregas;

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CVariables, Principal, CGestionPrincipal, UDMAuxDB, DPreview, UDMBaseDatos,
     UDMConfig, CDGastosCompra;

procedure TFLAsignarGastosCompras.FormCreate(Sender: TObject);
begin
  FormType:=tfOther;
  BHFormulario;

  empresa.Text:= gsDefEmpresa;
  centro.Text:= '';
  proveedor.Text:= '';

  eDesde.Text:= FormatDateTime('dd/mm/yyyy', IncMonth( Date, -3 ) );
  eHasta.Text:= FormatDateTime('dd/mm/yyyy', Date );
end;

procedure TFLAsignarGastosCompras.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType:=tfDirector;
    BHFormulario;
  end;
  Action:=caFree;
end;

procedure TFLAsignarGastosCompras.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLAsignarGastosCompras.ValidarCampos;
begin
  if Trim(stEmpresa.Caption) = '' then
  begin
    empresa.SetFocus;
    raise Exception.Create('Falta el codigo de la empresa o es incorrecto.');
  end;
  sEmpresa:= empresa.Text;

  if Trim(stCentro.Caption) = '' then
  begin
    centro.SetFocus;
    raise Exception.Create('El codigo del centro es incorrecto.');
  end;
  scentro:= centro.Text;

  if Trim(lblProveedor.Caption) = '' then
  begin
    proveedor.SetFocus;
    raise Exception.Create('El codigo del proveedor es incorrecto.');
  end;
  sProveedor:= proveedor.Text;

  //validar fechas
  if not tryStrTodate( eDesde.Text, dIni ) then
  begin
    eDesde.SetFocus;
    raise Exception.Create('Fecha de inicio incorrecta.');
  end;
  if not tryStrTodate( eHasta.Text, dFin ) then
  begin
    eHasta.SetFocus;
    raise Exception.Create('Fecha de fin incorrecta.');
  end;
  if ( eDesde.Text <> '' ) and ( eHasta.Text <> '' ) then
  begin
    if dIni > dFin then
    begin
      eDesde.SetFocus;
      raise Exception.Create('Rango de fechas incorrecto.');
    end;
  end;
end;


procedure TFLAsignarGastosCompras.btnImprimirClick(Sender: TObject);
begin
  ValidarCampos;
  try
    if HayEntregas then
      AsignarGastosAEntregas
    else
      ShowMessage('No hay compras o todos los gastos ya han sido asignados.'  );
  finally
    QSelectFacturas.Close;
  end;
end;

function TFLAsignarGastosCompras.HayEntregas: Boolean;
begin
  with QSelectFacturas do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_c, centro_c, numero_c, fecha_c, proveedor_c, ref_compra_c ');
    SQL.Add(' from frf_compras ');
    SQL.Add(' where empresa_c = :empresa ');
    if sCentro <> '' then
      SQL.Add(' and centro_c = :centro ');
    if sProveedor <> '' then
      SQL.Add(' and proveedor_c = :proveedor ');
    SQL.Add(' and fecha_c between :ini and :fin ');
    SQL.Add(' and status_gastos_c < 1 ');
    SQL.Add(' and numero_c > 0 ');
    SQL.Add(' and exists ');
    SQL.Add(' ( select *');
    SQL.Add('   from frf_gastos_compras ');
    SQL.Add('   where empresa_gc = :empresa ');
    SQL.Add('   and centro_gc = centro_c ');
    SQL.Add('   and numero_gc = numero_c )');

    ParamByName('empresa').asString:= sEmpresa;
    if sCentro <> '' then
      ParamByName('centro').asString:= scentro;
    if sProveedor <> '' then
      ParamByName('proveedor').asString:= sProveedor;
    ParamByName('ini').AsDateTime:= dIni;
    ParamByName('fin').AsDateTime:= dfin;
  end;
  QSelectFacturas.Open;
  Result:= not QSelectFacturas.IsEmpty;
end;

procedure TFLAsignarGastosCompras.AsignarGastosAEntregas;
var
  sAux: string;
  iTotal, iOk: Integer;
  slError, slOK: TStringList;
begin
  iTotal:= 0;
  iOk:= 0;

  DGastosCompra:= TDGastosCompra.Create( self );
  try
    slError:= TStringList.Create;
    slOK:= TStringList.Create;
    
    while not QSelectFacturas.Eof do
    begin
      if DGastosCompra.GastosFacturaSeleccionada( QSelectFacturas.FieldByname('empresa_c').AsString,
           QSelectFacturas.FieldByname('centro_c').AsString,
           QSelectFacturas.FieldByname('numero_c').AsInteger, True, sAux ) then
      begin
         iOk:= iOk + 1;
         slOk.Add( sAux );
      end
      else
      begin
        slError.Add( sAux );
      end;
      iTotal:= iTotal + 1;
      QSelectFacturas.Next;
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
    FreeAndNil( DGastosCompra );
    FreeAndNil( slError );
  end;
end;


function TFLAsignarGastosCompras.centroGetSQL: String;
begin
  if Empresa.Text <> '' then
    result:= 'select centro_c, descripcion_c from frf_centros where empresa_c = ' +
             Empresa.GetSQLText + ' order by centro_c'
  else
    result:= 'select centro_c, descripcion_c from frf_centros order by centro_c';
end;

procedure TFLAsignarGastosCompras.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    Vk_escape: btnCerrar.Click;
    vk_f1: btnImprimir.Click;
  end;
end;

procedure TFLAsignarGastosCompras.empresaChange(Sender: TObject);
begin
  stEmpresa.Caption:= desEmpresa( empresa.Text );
  centroChange( centro );
end;

procedure TFLAsignarGastosCompras.centroChange(Sender: TObject);
begin
  if centro.Text <> '' then
  begin
    stCentro.Caption:= desCentro( empresa.Text, centro.Text );
  end
  else
  begin
    stCentro.Caption:= '(Vacio, todos los centros)';
  end;
end;

function TFLAsignarGastosCompras.proveedorGetSQL: String;
begin
  if empresa.Text <> '' then
  begin
    Result:= 'select proveedor_p, nombre_p' + #13 + #10;
    Result:= Result + 'from frf_proveedores' + #13 + #10;
    Result:= Result + 'where empresa_p = ' + QuotedStr(empresa.Text) + #13 + #10;
    Result:= Result + 'order by 1,2' + #13 + #10;
  end
  else
  begin
    Result:= 'select proveedor_p, nombre_p' + #13 + #10;
    Result:= Result + 'from frf_proveedores' + #13 + #10;
    Result:= Result + 'group by 1,2' + #13 + #10;
    Result:= Result + 'order by 1,2' + #13 + #10;
  end;
end;

procedure TFLAsignarGastosCompras.proveedorChange(Sender: TObject);
begin
  if proveedor.Text <> '' then
  begin
    lblProveedor.Caption:= desProveedor( empresa.Text, proveedor.Text );
  end
  else
  begin
    lblProveedor.Caption:= '(Vacio, todos los proveedores)';
  end;
end;

end.
