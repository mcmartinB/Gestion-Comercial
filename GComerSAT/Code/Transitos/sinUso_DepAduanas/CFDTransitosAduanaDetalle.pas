unit CFDTransitosAduanaDetalle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, nbEdits, nbCombos, DB, DBCtrls, nbLabels, Grids,
  DBGrids;

type
  TFDTransitosAduanaDetalle = class(TForm)
    btnGuardar: TButton;
    btnSalir: TButton;
    nbLabel1: TnbLabel;
    nbLabel2: TnbLabel;
    nbLabel6: TnbLabel;
    nbLabel7: TnbLabel;
    nbLabel8: TnbLabel;
    DSDetalleDatosAduana: TDataSource;
    fecha_dal: TnbDBCalendarCombo;
    dua_consumo_dal: TnbDBAlfa;
    lblEmpresa: TLabel;
    lblDVD: TLabel;
    nbLabel3: TnbLabel;
    cliente_dal: TnbDBSQLCombo;
    dir_sum_dal: TnbDBSQLCombo;
    kilos_dal: TnbDBNumeric;
    stCliente: TnbStaticText;
    stDirSum: TnbStaticText;
    DBMemo1: TDBMemo;
    nbLabel4: TnbLabel;
    lblKilosFaltan: TLabel;
    lbl1: TnbLabel;
    lblCentro: TnbLabel;
    centro_destino_dal: TnbDBSQLCombo;
    stCentro: TnbStaticText;
    rbCliente: TRadioButton;
    rbCentro: TRadioButton;
    procedure btnSalirClick(Sender: TObject);
    procedure btnGuardarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function cliente_dalGetSQL: String;
    function dir_sum_dalGetSQL: String;
    procedure cliente_dalChange(Sender: TObject);
    function stClienteGetDescription: String;
    procedure dir_sum_dalChange(Sender: TObject);
    function stDirSumGetDescription: String;
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rbClienteClick(Sender: TObject);
    function centro_destino_dalGetSQL: String;
    function stCentroGetDescription: String;
    procedure centro_destino_dalChange(Sender: TObject);
  private
    { Private declarations }
    iCodigo: integer;
    sEmpresa, sDVD: string;
    dFechaTransito: TDate;
    rKilos, rKilosAnterior, rKilosTransito, rKilosDetalle, rKilosAsignados: Real;

    function  TieneAlgunDatoPendiente: boolean;
    function  MiPost: boolean;
    function  ValidarDatos: boolean;
  public
    { Public declarations }
  end;

  procedure Modificacion( const AOwner: TComponent; const ADVD: String;
                          const AFecha: TDate; const AKilosTransito, AKilosDetalle: real );
  procedure Alta( const AOwner: TComponent; const ACodigo: integer;
                  const AEmpresa, ADVD: String; const AFecha: TDate;
                  const AKilosTransito, AKilosDetalle: real );

implementation

{$R *.dfm}

uses
  CDDTransitosAduana, UDMAuxDB;

var
  FDTransitosAduanaDetalle: TFDTransitosAduanaDetalle;

procedure Modificacion( const AOwner: TComponent; const ADVD: String;
                        const AFecha: TDate; const AKilosTransito, AKilosDetalle: real );
var
  rKilosFaltan: real;
begin
  FDTransitosAduanaDetalle:= TFDTransitosAduanaDetalle.Create( AOwner );

  with FDTransitosAduanaDetalle do
  begin
    iCodigo:= DSDetalleDatosAduana.DataSet.FieldByName('codigo_dal').AsInteger;
    sEmpresa:= DSDetalleDatosAduana.DataSet.FieldByName('empresa_dal').AsString;
    sDVD:= ADVD;
    dFechaTransito:= AFecha;
    rKilosAnterior:= DSDetalleDatosAduana.DataSet.FieldByName('kilos_dal').AsFloat;
    rKilosTransito:= AKilosTransito;
    rKilosDetalle:= AKilosDetalle;

    With DDTransitosAduana_.QKilosDetalleSalidas do
    begin
      ParamByName('codigo').AsInteger:= DSDetalleDatosAduana.DataSet.FieldByName('codigo_dal').AsInteger;
      ParamByName('linea').AsInteger:= DSDetalleDatosAduana.DataSet.FieldByName('linea_dal').AsInteger;
      Open;
      rKilosAsignados:= FieldByname('kilos_das').AsFloat;
      Close;
    end;

    lblEmpresa.Caption:= sEmpresa + ' ' + desEmpresa( sEmpresa );
    lblDVD.Caption:= ADVD;

    rKilosFaltan:= ( AKilosTransito + rKilosAnterior ) - AKilosDetalle;
    if rKilosFaltan = 0 then
      lblKilosFaltan.Caption:= 'Todos los kilos asignados.'
    else
      lblKilosFaltan.Caption:= FormatFloat( 'Faltan #,##0.00 kg.', rKilosFaltan );
  end;

  try
    FDTransitosAduanaDetalle.DSDetalleDatosAduana.DataSet.Edit;

    FDTransitosAduanaDetalle.rbCliente.Checked:= FDTransitosAduanaDetalle.DSDetalleDatosAduana.DataSet.FieldByName('centro_destino_dal').Value = NULL;
    FDTransitosAduanaDetalle.rbCentro.Checked:= FDTransitosAduanaDetalle.DSDetalleDatosAduana.DataSet.FieldByName('centro_destino_dal').Value <> NULL;
    FDTransitosAduanaDetalle.rbCliente.Enabled:= False;
    FDTransitosAduanaDetalle.rbCentro.Enabled:= False;
    FDTransitosAduanaDetalle.cliente_dal.Enabled:= False;
    FDTransitosAduanaDetalle.dir_sum_dal.Enabled:= False;
    FDTransitosAduanaDetalle.centro_destino_dal.Enabled:= False;
    TEdit( FDTransitosAduanaDetalle.cliente_dal ).Color:= clBtnFace;
    TEdit( FDTransitosAduanaDetalle.dir_sum_dal ).Color:= clBtnFace;
    TEdit( FDTransitosAduanaDetalle.centro_destino_dal ).Color:= clBtnFace;
    if FDTransitosAduanaDetalle.DSDetalleDatosAduana.DataSet.FieldByName('centro_destino_dal').Value = NULL then
    begin
      FDTransitosAduanaDetalle.stCentro.Caption:= 'Venta - Seleccione un cliente';
      FDTransitosAduanaDetalle.stCliente.Description;
      FDTransitosAduanaDetalle.stDirSum.Description;
    end
    else
    begin
      FDTransitosAduanaDetalle.stCliente.Caption:= 'Transito - Seleccione un centro';
      FDTransitosAduanaDetalle.stCentro.Description;
    end;

    FDTransitosAduanaDetalle.ShowModal;
  finally
    FreeAndNil( FDTransitosAduanaDetalle );
  end;
end;

procedure Alta( const AOwner: TComponent; const ACodigo: integer;
                const AEmpresa, ADVD: String; const AFecha: TDate;
                const AKilosTransito, AKilosDetalle: real );
var
  rKilosFaltan: real;
begin
  FDTransitosAduanaDetalle:= TFDTransitosAduanaDetalle.Create( AOwner );

  FDTransitosAduanaDetalle.iCodigo:= ACodigo;
  FDTransitosAduanaDetalle.sEmpresa:= AEmpresa;
  FDTransitosAduanaDetalle.sDVD:= ADVD;
  FDTransitosAduanaDetalle.dFechaTransito:= AFecha;
  FDTransitosAduanaDetalle.rKilosAnterior:= 0;
  FDTransitosAduanaDetalle.rKilosTransito:= AKilosTransito;
  FDTransitosAduanaDetalle.rKilosDetalle:= AKilosDetalle;
  FDTransitosAduanaDetalle.rKilosAsignados:= 0;

  FDTransitosAduanaDetalle.lblEmpresa.Caption:= AEmpresa + ' ' + desEmpresa( AEmpresa );
  FDTransitosAduanaDetalle.lblDVD.Caption:= ADVD;

  rKilosFaltan:= ( AKilosTransito + FDTransitosAduanaDetalle.rKilosAnterior ) - AKilosDetalle;
  if rKilosFaltan = 0 then
    FDTransitosAduanaDetalle.lblKilosFaltan.Caption:= 'Todos los kilos asignados.'
  else
    FDTransitosAduanaDetalle.lblKilosFaltan.Caption:= FormatFloat( 'Faltan #,##0.00 kg.', rKilosFaltan );

  try
    FDTransitosAduanaDetalle.DSDetalleDatosAduana.DataSet.Insert;
    TEdit( FDTransitosAduanaDetalle.centro_destino_dal ).Color:= clBtnFace;
    FDTransitosAduanaDetalle.stCentro.Caption:= 'Venta - Seleccione un cliente';
    FDTransitosAduanaDetalle.ShowModal;
  finally
    FreeAndNil( FDTransitosAduanaDetalle );
  end;
end;

procedure TFDTransitosAduanaDetalle.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caHide;
end;

function TFDTransitosAduanaDetalle.TieneAlgunDatoPendiente: boolean;
begin
  result:= DSDetalleDatosAduana.DataSet.Modified;
end;

function TFDTransitosAduanaDetalle.ValidarDatos: boolean;
var
  dAux: TDateTime;
begin
  result:= false;
  if rbCentro.Checked then
  begin
    if stCentro.Caption = '' then
    begin
      ShowMessage('Falta o centro incorrecto.');
      centro_destino_dal.SetFocus;
      Exit;
    end;
  end
  else
  begin
    if stCliente.Caption = '' then
    begin
      ShowMessage('Falta o cliente incorrecto.');
      cliente_dal.SetFocus;
      Exit;
    end;

    if stDirSum.Caption = '' then
    begin
      ShowMessage('Dirección de Suministro incorrecta.');
      dir_sum_dal.SetFocus;
      Exit;
    end;
  end;

  if not TryStrToDate( fecha_dal.Text, dAux ) then
  begin
    ShowMessage('Falta o fecha incorrecta.');
    fecha_dal.SetFocus;
    Exit;
  end;
  if dAux < dFechaTransito then
  begin
    ShowMessage('La fecha de la salida no puede ser inferior a la fecha del transito.');
    fecha_dal.SetFocus;
    Exit;
  end;

  if not TryStrToFloat( kilos_dal.Text, double(rKilos) ) then
  begin
    ShowMessage('Falta o kilos incorrectos.');
    kilos_dal.SetFocus;
    Exit;
  end;
  //Que no se superen los kilos del transito
  if ( rKilosDetalle + rKilos - rKilosAnterior ) > rKilosTransito then
  begin
    ShowMessage('Hemos sobrepasado el número máximo de kilos que quedan en el tránsito ' +
                '(Max:'+FormatFloat('#,##0.00', ( rKilosTransito + rKilosAnterior ) - rKilosDetalle )+'kgs ).' );
    kilos_dal.SetFocus;
    Exit;
  end;

  //Que no pueda reducir el nuemro de kilos por debajo de los ya asignados
  if rKilos < rKilosAsignados then
  begin
    ShowMessage('Ya tenemos asignados mas kilos que los indicados. ' +
                '(Asignados:'+FormatFloat('#,##0.00', rKilosAsignados ) +'kgs ).' );
    kilos_dal.SetFocus;
    Exit;
  end;

  result:= True;
end;

function TFDTransitosAduanaDetalle.MiPost: boolean;
begin
  if ValidarDatos then
  begin
    if DSDetalleDatosAduana.DataSet.State = dsInsert then
    begin
      DSDetalleDatosAduana.DataSet.FieldByName('codigo_dal').AsInteger:= iCodigo;
      DSDetalleDatosAduana.DataSet.FieldByName('empresa_dal').AsString:= sEmpresa;
    end;

    if rbCliente.Checked then
    begin
      DSDetalleDatosAduana.DataSet.FieldByName('centro_destino_dal').Value:= NULL;
    end
    else
    begin
      DSDetalleDatosAduana.DataSet.FieldByName('cliente_dal').Value:= NULL;
      DSDetalleDatosAduana.DataSet.FieldByName('dir_sum_dal').Value:= NULL;
    end;

    DSDetalleDatosAduana.DataSet.Post;
    result:= true;
  end
  else
  begin
    result:= False;
  end;
end;

procedure TFDTransitosAduanaDetalle.btnSalirClick(Sender: TObject);
var
  iBoton: integer;
begin
  if TieneAlgunDatoPendiente then
  begin
    iBoton:= MessageDlg('¿Antes de salir desea guardar los cambios realizados?', mtConfirmation, [mbYes, mbNo, mbCancel], 0 );
    if iBoton = mrYes then
    begin
      if MiPost then;
        Close;
    end
    else
    if iBoton = mrNo then
    begin
      DSDetalleDatosAduana.DataSet.Cancel;
      Close;
    end;
  end
  else
  begin
    DSDetalleDatosAduana.DataSet.Cancel;
    Close;
  end;
end;

procedure TFDTransitosAduanaDetalle.btnGuardarClick(Sender: TObject);
begin
  if TieneAlgunDatoPendiente then
  begin
    if DSDetalleDatosAduana.DataSet.State = dsInsert then
    begin
      if MiPost then
      begin
        rKilosDetalle:= rKilosDetalle + rKilos;
        FDTransitosAduanaDetalle.lblKilosFaltan.Caption:= FormatFloat( 'Faltan #,##0.00 kg.', rKilosTransito - rKilosDetalle );

        ShowMessage('Registro guardado.');
        DSDetalleDatosAduana.DataSet.Insert;
        if cliente_dal.CanFocus then
          cliente_dal.SetFocus
        else
          centro_destino_dal.SetFocus;
      end;
    end
    else
    begin
      if MiPost then
      begin
        ShowMessage('Registro modificado.');
        Close;
      end;
    end;
  end
  else
  begin
    Close;
  end;
end;


function TFDTransitosAduanaDetalle.cliente_dalGetSQL: String;
begin
  result:= 'select cliente_c, nombre_c' + #13 + #10 +
           'from frf_clientes' + #13 + #10 +
           'where empresa_c = ' + QuotedStr( sEmpresa ) + #13 + #10 +
           'order by cliente_c';
end;

function TFDTransitosAduanaDetalle.dir_sum_dalGetSQL: String;
begin
  result:= 'select dir_sum_ds, cliente_ds,  nombre_ds' + #13 + #10 +
           'from frf_dir_sum' + #13 + #10 +
           'where empresa_ds = ' + QuotedStr( sEmpresa ) + #13 + #10;
  if cliente_dal.Text <> '' then
  begin
    result:= result + '  and cliente_ds = ' + QuotedStr( cliente_dal.Text ) + #13 + #10;
  end;
  result:= result + 'order by cliente_ds, dir_sum_ds';
end;

procedure TFDTransitosAduanaDetalle.cliente_dalChange(Sender: TObject);
begin
  stCliente.Description;
  stDirSum.Description;
end;

function TFDTransitosAduanaDetalle.stClienteGetDescription: String;
begin
  result:= desCliente( sEmpresa, cliente_dal.Text );
end;

procedure TFDTransitosAduanaDetalle.dir_sum_dalChange(Sender: TObject);
begin
  stDirSum.Description;
end;

function TFDTransitosAduanaDetalle.stDirSumGetDescription: String;
begin
  if dir_sum_dal.Text = '' then
  begin
    result:= 'TODAS LAS DIRECCIONES.';
  end
  else
  begin
    result:= desSuministro( sEmpresa, cliente_dal.Text, dir_sum_dal.Text );
  end;
end;

procedure TFDTransitosAduanaDetalle.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_f1 then
  begin
    btnGuardar.Click;
    Key:= 0;
  end
  else
  if Key = vk_escape then
  begin
    btnSalir.Click;
    Key:= 0;
  end;
end;

procedure TFDTransitosAduanaDetalle.rbClienteClick(Sender: TObject);
begin
  if rbCliente.Checked then
  begin
    cliente_dal.Enabled:= True;
    stCliente.Description;
    dir_sum_dal.Enabled:= True;
    stDirSum.Description;

    centro_destino_dal.Enabled:= false;
    centro_destino_dal.Text:= '';
    stCentro.Caption:= 'Venta - Seleccione un cliente';

    TEdit( cliente_dal ).Color:= clWindow;
    TEdit( dir_sum_dal ).Color:= clWindow;
    TEdit( centro_destino_dal ).Color:= clBtnFace;
  end
  else
  begin
    cliente_dal.Enabled:= False;
    cliente_dal.Text:= '';
    stCliente.Caption:= 'Tránsito - Seleccione un centro.';
    dir_sum_dal.Enabled:= false;
    dir_sum_dal.Text:= '';

    centro_destino_dal.Enabled:= True;
    stCentro.Description;

    TEdit( cliente_dal ).Color:= clBtnFace;
    TEdit( dir_sum_dal ).Color:= clBtnFace;
    TEdit( centro_destino_dal ).Color:= clWindow;
  end;
end;

function TFDTransitosAduanaDetalle.centro_destino_dalGetSQL: String;
begin
  result:= 'select centro_c, descripcion_c' + #13 + #10 +
           'from frf_centros' + #13 + #10 +
           'where empresa_c = ' + QuotedStr( sEmpresa ) + #13 + #10 +
           'order by centro_c';
end;

function TFDTransitosAduanaDetalle.stCentroGetDescription: String;
begin
  result:= desCentro( sEmpresa, centro_destino_dal.Text );
end;

procedure TFDTransitosAduanaDetalle.centro_destino_dalChange(
  Sender: TObject);
begin
  stCentro.Description;
end;

end.
