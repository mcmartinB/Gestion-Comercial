unit SeriesFacturaFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, nbCombos, StdCtrls, nbEdits, nbLabels, Buttons, DB,
  ExtCtrls, Grids, DBGrids, DBTables, DBCtrls, BEdit, BDEdit;
                                                
type
  TFDSeriesFactura = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    QContadores: TQuery;                                                                    
    dsContadores: TDataSource;
    pnlMaestro: TPanel;
    nbLabel2: TnbLabel;
    nbLabel3: TnbLabel;
    lblFechaFinal: TnbLabel;
    lbl1: TnbLabel;
    cod_serie_fs: TBDEdit;
    fecha_abn_iva_fs: TnbDBCalendarCombo;
    fecha_fac_iva_fs: TnbDBCalendarCombo;
    lblCodigo1: TnbLabel;
    fac_iva_fs: TnbDBNumeric;
    lblCodigo2: TnbLabel;
    abn_iva_fs: TnbDBNumeric;
    lblCodigo3: TnbLabel;
    lblCodigo4: TnbLabel;
    fecha_abn_igic_fs: TnbDBCalendarCombo;
    fecha_fac_igic_fs: TnbDBCalendarCombo;
    lblCodigo5: TnbLabel;
    fac_igic_fs: TnbDBNumeric;
    lblCodigo6: TnbLabel;
    abn_igic_fs: TnbDBNumeric;
    nbLabel1: TnbLabel;
    pre_fac_iva_fs: TBDEdit;
    nbLabel4: TnbLabel;
    pre_abn_iva_fs: TBDEdit;
    nbLabel5: TnbLabel;
    pre_fac_igic_fs: TBDEdit;
    nbLabel6: TnbLabel;
    pre_abn_igic_fs: TBDEdit;
    anyo_fs: TBDEdit;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAceptarClick(Sender: TObject);                                             
  private
    { Private declarations }

  public
    { Public declarations }
    bFlag: Boolean;
    procedure Modificar( const AEmpresa, ASerie: string; const AAnyo: integer );
    procedure Alta( const AEmpresa: string );

  end;

  function AltaContadoresSerie( const AOwner: TComponent; const AEmpresa: string; var ASerie: string; var AANyo: integer ): boolean;
  function ModificarContadoresSerie( const AOwner: TComponent; const AEmpresa, ASerie: string; const AAnyo: integer ): boolean;

implementation

{$R *.dfm}

uses
  bMath, UDMBaseDatos, UDMAuxDB;

var
  FDSeriesFactura: TFDSeriesFactura;

function AltaContadoresSerie( const AOwner: TComponent; const AEmpresa: string; var ASerie: string; var AANyo: integer ): boolean;
begin
  FDSeriesFactura:= TFDSeriesFactura.Create( AOwner );
  try
    FDSeriesFactura.bFlag:= False;
    FDSeriesFactura.Alta( AEmpresa );
    FDSeriesFactura.ShowModal;
    Result:= FDSeriesFactura.bFlag;
    if Result then
    begin
      ASerie:= FDSeriesFactura.cod_serie_fs.Text;
      AANyo:= StrToInt( FDSeriesFactura.anyo_fs.Text )
    end
  finally
    FreeAndNil(FDSeriesFactura );
  end;
end;

function  ModificarContadoresSerie( const AOwner: TComponent; const AEmpresa, ASerie: string; const AAnyo: integer ): boolean;
begin
  FDSeriesFactura:= TFDSeriesFactura.Create( AOwner );
  try
    FDSeriesFactura.bFlag:= False;
    FDSeriesFactura.Modificar( AEmpresa, ASerie, AAnyo );
    FDSeriesFactura.ShowModal;
    Result:= FDSeriesFactura.bFlag;
  finally
    FreeAndNil(FDSeriesFactura );
  end;
end;

procedure TFDSeriesFactura.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  QContadores.Close;
  Action:= caFree;
end;

procedure TFDSeriesFactura.FormKeyDown(Sender: TObject; var Key: Word;
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
  end;
end;

procedure TFDSeriesFactura.Alta( const AEmpresa: string );
var
  iYear, iMont, iDay: word;
  sSerie: string;
  dFecha: TDateTime;
begin
  with QContadores do
  begin
    SQL.Clear;
    SQL.Add(' select * from frf_facturas_serie ');
    Open;
    Insert;
  end;
  //Insertar nuevo registro
  with DMAuxDB.QAux do
  begin
    DMAuxDB.QAux.SQL.Clear;
    DMAuxDB.QAux.SQL.Add(' select first 1 cod_serie_es, anyo_es ');
    DMAuxDB.QAux.SQL.Add(' from frf_empresas_serie, frf_facturas_serie ');
    DMAuxDB.QAux.SQL.Add(' where cod_empresa_es = :empresa and cod_serie_fs = cod_serie_es and anyo_fs = anyo_es ');
    DMAuxDB.QAux.SQL.Add(' order by anyo_fs desc  ');
    DMAuxDB.QAux.ParamByName('empresa').AsString:= AEmpresa;
    DMAuxDB.QAux.Open;

    DecodeDate( Now, iYear, iMont, iDay );
    if iYear < DMAuxDB.QAux.FieldByname('anyo_es').AsInteger then
      iYear:= DMAuxDB.QAux.FieldByname('anyo_es').AsInteger;
    iYear:= iYear + 1;
    dFecha:= EncodeDate( iYear, 1, 1 );

    if DMAuxDB.QAux.IsEmpty then
    begin
      sSerie:= AEmpresa;
    end
    else
    begin
      sSerie:=  DMAuxDB.QAux.FieldByname('cod_serie_es').AsString;
    end;

    QContadores.FieldByName('cod_serie_fs').AsString:= sSerie;
    QContadores.FieldByName('anyo_fs').AsInteger:= iYear;
    QContadores.FieldByName('fac_iva_fs').AsInteger:= 0;
    QContadores.FieldByName('fecha_fac_iva_fs').AsDateTime:= dFecha;
    QContadores.FieldByName('abn_iva_fs').AsInteger:= 300000;
    QContadores.FieldByName('fecha_abn_iva_fs').AsDateTime:= dFecha;
    QContadores.FieldByName('fac_igic_fs').AsInteger:= 200000;
    QContadores.FieldByName('fecha_fac_igic_fs').AsDateTime:= dFecha;
    QContadores.FieldByName('abn_igic_fs').AsInteger:= 400000;
    QContadores.FieldByName('fecha_abn_igic_fs').AsDateTime:= dFecha;

    DMAuxDB.QAux.Close;
  end;
end;

procedure TFDSeriesFactura.Modificar( const AEmpresa, ASerie: string; const AAnyo: integer );
begin
  with QContadores do
  begin
    SQL.Clear;
    SQL.Add(' select * from frf_facturas_serie ');
    SQL.Add(' where cod_serie_fs = :serie ');
    SQL.Add(' and anyo_fs = :anyo ');
    ParamByName('serie').AsString:= ASerie;
    ParamByName('anyo').AsInteger:= AAnyo;
    Open;
    Edit;
  end;
end;

procedure TFDSeriesFactura.btnAceptarClick(Sender: TObject);
begin
  QContadores.Post;
  QContadores.Close;
  Close;
  bFlag:= True;
end;

procedure TFDSeriesFactura.btnCancelarClick(Sender: TObject);
begin
  QContadores.Cancel;
  QContadores.Close;
  Close;
  bFlag:= False;
end;


end.



