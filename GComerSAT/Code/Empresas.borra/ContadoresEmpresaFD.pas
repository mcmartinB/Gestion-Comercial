unit ContadoresEmpresaFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, nbCombos, StdCtrls, nbEdits, nbLabels, Buttons, DB,
  ExtCtrls, Grids, DBGrids, DBTables, DBCtrls, BEdit, BDEdit;
                                                
type
  TFDContadoresEmpresa = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnAnyadir: TSpeedButton;
    btnModificar: TSpeedButton;
    QContadores: TQuery;
    dsContadores: TDataSource;
    dbgContadores: TDBGrid;
    pnlMaestro: TPanel;
    nbLabel2: TnbLabel;
    nbLabel3: TnbLabel;
    lblFechaFinal: TnbLabel;
    lbl1: TnbLabel;
    empresa_emc: TBDEdit;
    fecha_abn_iva_emc: TnbDBCalendarCombo;
    fecha_fac_iva_emc: TnbDBCalendarCombo;
    stPlanta: TStaticText;
    anyo_emc: TnbDBNumeric;
    lblCodigo1: TnbLabel;
    fac_iva_emc: TnbDBNumeric;
    lblCodigo2: TnbLabel;
    abn_iva_emc: TnbDBNumeric;
    lblCodigo3: TnbLabel;
    lblCodigo4: TnbLabel;
    fecha_abn_igic_emc: TnbDBCalendarCombo;
    fecha_fac_igic_emc: TnbDBCalendarCombo;
    lblCodigo5: TnbLabel;
    fac_igic_emc: TnbDBNumeric;
    lblCodigo6: TnbLabel;
    abn_igic_emc: TnbDBNumeric;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnModificarClick(Sender: TObject);
    procedure btnAnyadirClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure empresa_emcChange(Sender: TObject);
  private
    { Private declarations }
    sEmpresa: String;
    bAlta: boolean;

  public
    { Public declarations }
    procedure LoadValues( const AEmpresa: string );

  end;

  procedure ExecuteContadoresEmpresa( const AOwner: TComponent; const AEmpresa: string );

implementation

{$R *.dfm}

uses
  bMath, UDMBaseDatos, UDMAuxDB;

var
  FDContadoresEmpresa: TFDContadoresEmpresa;

procedure ExecuteContadoresEmpresa( const AOwner: TComponent; const AEmpresa: string );
begin
  FDContadoresEmpresa:= TFDContadoresEmpresa.Create( AOwner );
  try
    FDContadoresEmpresa.LoadValues( AEmpresa );
    FDContadoresEmpresa.ShowModal;
  finally
    FreeAndNil(FDContadoresEmpresa );
  end;
end;

procedure TFDContadoresEmpresa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  QContadores.Close;
  Action:= caFree;
end;

procedure TFDContadoresEmpresa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    vk_f1:
    begin
      Key:= 0;
      btnAceptar.Click;
    end;
    vk_escape:
    begin
      Key:= 0;
      btnCancelar.Click;
    end;
    vk_add, ord('+'):
    begin
      Key:= 0;
      btnAnyadir.Click;
    end;
  end;
end;

procedure TFDContadoresEmpresa.LoadValues( const AEmpresa: string );
begin
  sEmpresa:= AEmpresa;
  bAlta:= False;

  with QContadores do
  begin
    SQL.Clear;
    SQL.Add(' select * from frf_empresas_contadores ');
    SQL.Add(' where empresa_emc = :empresa ');
    SQL.Add(' order by anyo_emc desc ');
    ParamByName('empresa').AsString:= AEmpresa;
    Open;
  end;
end;


procedure TFDContadoresEmpresa.btnAnyadirClick(Sender: TObject);
var
  iYear, iMont, iDay: word;
  iAnyo: Integer;
  sAnyo: string;
  dFecha: TDateTime;
begin
  //Insertar nuevo registro
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add('select max(anyo_emc) anyo ');
    SQL.Add('from frf_empresas_contadores ');
    SQL.Add('where empresa_emc = :empresa ');
    ParamByName('empresa').AsString:= sEmpresa;
    Open;
    if IsEmpty then
    begin
      DecodeDate( Now, iYear, iMont, iDay );
    end
    else
    begin
      iYear:= FieldByName('anyo').AsInteger;
    end;
    Close;
  end;
  iAnyo:= iYear + 1;

  sAnyo:= IntToStr( iAnyo );
  if InputQuery('Crear nueva ficha de contadores','Introduce Año:', sAnyo) then
  begin
    if TryStrToInt( sAnyo, iAnyo ) then
    begin
      dFecha:= EncodeDate( iAnyo, 1, 1 );
      with QContadores do
      begin
        (*FACTAÑOS*)
        Insert;
        FieldByName('empresa_emc').AsString:= sEmpresa;
        FieldByName('anyo_emc').AsInteger:= iAnyo;
        FieldByName('fac_iva_emc').AsInteger:= 0;
        FieldByName('fecha_fac_iva_emc').AsDateTime:= dFecha;
        FieldByName('abn_iva_emc').AsInteger:= 300000;
        FieldByName('fecha_abn_iva_emc').AsDateTime:= dFecha;
        FieldByName('fac_igic_emc').AsInteger:= 200000;
        FieldByName('fecha_fac_igic_emc').AsDateTime:= dFecha;
        FieldByName('abn_igic_emc').AsInteger:= 400000;
        FieldByName('fecha_abn_igic_emc').AsDateTime:= dFecha;
        try
          Post;
        except
          on e:Exception do
          begin
            ShowMessage(e.Message);
            Cancel;
          end;
        end;
      end;
    end
    else
    begin
      ShowMessage('Año Incorrecto');
    end;
  end
  else
  begin
    ShowMessage('Alta cancelada');
  end;
end;

procedure TFDContadoresEmpresa.btnModificarClick(Sender: TObject);
begin
  bAlta:= False;
  if QContadores.IsEmpty then
  begin
    ShowMessage('No hay ficha para modificar');
  end
  else
  begin
    pnlMaestro.Enabled:= True;
    btnAceptar.Enabled:= True;
    btnCancelar.Caption:= 'Cancelar (Esc)';
    btnAnyadir.Enabled:= False;
    btnModificar.Enabled:= False;

    QContadores.Edit;

    dbgContadores.Enabled:= False;

    fac_iva_emc.SetFocus;
  end;
end;

procedure TFDContadoresEmpresa.btnAceptarClick(Sender: TObject);
var
  dFechaFin: TDateTime;
  bookMark: TBookMark;
begin
  QContadores.Post;

  pnlMaestro.Enabled:= False;
  btnAceptar.Enabled:= False;
  btnCancelar.Caption:= 'Cerrar (Esc)';
  btnAnyadir.Enabled:= True;
  btnModificar.Enabled:= True;
  dbgContadores.Enabled:= True;
  ShowMessage('Ficha modificada');

  QContadores.Close;
  QContadores.Open;
end;

procedure TFDContadoresEmpresa.btnCancelarClick(Sender: TObject);
begin
  if btnAceptar.Enabled = True then
  begin
    QContadores.Cancel;
    pnlMaestro.Enabled:= False;
    btnAceptar.Enabled:= False;
    btnCancelar.Caption:= 'Cerrar (Esc)';
    btnAnyadir.Enabled:= True;
    btnModificar.Enabled:= True;
    dbgContadores.Enabled:= True;

    ShowMessage('Cambio cancelado');
  end
  else
  begin
    Close;
  end;
end;


procedure TFDContadoresEmpresa.empresa_emcChange(Sender: TObject);
begin
  stPlanta.Caption:= desEmpresa( empresa_emc.Text );
end;

end.


