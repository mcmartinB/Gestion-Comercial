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
    lblCodigo1: TnbLabel;
    btnFiltrar: TButton;
    edtAnyo: TEdit;
    lblEmpresa: TnbLabel;
    edtEmpresa: TEdit;
    lblDesEmpresa: TLabel;
    dbgrd1: TDBGrid;
    lblCodigo3: TnbLabel;
    QContador: TQuery;
    dsContador: TDataSource;
    qryAsignar: TQuery;
    btnDesasignar: TSpeedButton;
    qryDesasignar: TQuery;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnModificarClick(Sender: TObject);
    procedure btnAnyadirClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure dbgContadoresDblClick(Sender: TObject);
    procedure edtEmpresaChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnDesasignarClick(Sender: TObject);
  private
    { Private declarations }
    procedure Resfrescar;

  public
    { Public declarations }
    procedure LoadValues( const AEmpresa: string; const AAnyo: integer );

  end;

  procedure ExecuteContadoresSerie( const AOwner: TComponent; const AEmpresa: string );

implementation

{$R *.dfm}

uses
  bMath, UDMBaseDatos, UDMAuxDB, SeriesFacturaFD;

var
  FDContadoresEmpresa: TFDContadoresEmpresa;

procedure ExecuteContadoresSerie( const AOwner: TComponent; const AEmpresa: string );
var
  iAnyo, iMes, iDia: Word;
begin
  DecodeDate( Now, iAnyo, iMes, iDia );
  FDContadoresEmpresa:= TFDContadoresEmpresa.Create( AOwner );
  try
    FDContadoresEmpresa.edtEmpresa.Text:= AEmpresa;
    FDContadoresEmpresa.edtAnyo.Text:= IntToStr( iAnyo );
    FDContadoresEmpresa.LoadValues( AEmpresa, iAnyo );
    FDContadoresEmpresa.ShowModal;
  finally
    FreeAndNil(FDContadoresEmpresa );
  end;
end;

procedure TFDContadoresEmpresa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  QContadores.Close;
  QContador.Close;
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

procedure TFDContadoresEmpresa.LoadValues( const AEmpresa: string; const AAnyo: integer );
begin
  with QContadores do
  begin
    Close;
    ParamByname('anyo').AsInteger:= AAnyo;
    Open;
  end;
  with QContador do
  begin
    Close;
    ParamByname('empresa').AsString:= AEmpresa;
    ParamByname('anyo').AsInteger:= AAnyo;
    Open;
  end;
end;


procedure TFDContadoresEmpresa.btnAnyadirClick(Sender: TObject);
var
  sSerie: string;
  iAnyo: integer;
begin
  //Insertar nuevo registro
  if SeriesFacturaFD.AltaContadoresSerie( Self, edtEmpresa.Text, sSerie, iAnyo  ) then
  begin
    FDContadoresEmpresa.LoadValues( edtEmpresa.Text, iAnyo );
  end;
end;

procedure TFDContadoresEmpresa.Resfrescar;
begin
    QContador.Close;
    QContador.Open;
    QContadores.Close;
    QContadores.Open;
end;

procedure TFDContadoresEmpresa.btnModificarClick(Sender: TObject);
begin
  if QContador.IsEmpty then
  begin
    ShowMessage('Solo se puede modificar la serie asignada a la empresa.');
  end
  else
  begin
    SeriesFacturaFD.ModificarContadoresSerie( Self, edtEmpresa.Text, QContadores.FieldByName('cod_serie_fs').AsString, QContadores.FieldByName('anyo_fs').AsInteger );
    Resfrescar;
  end;
end;

procedure TFDContadoresEmpresa.btnAceptarClick(Sender: TObject);                                                       
begin
  //Asignar serie
  qryAsignar.ParamByname('empresa').AsString:= edtEmpresa.Text;
  qryAsignar.ParamByname('serie').AsString:= QContadores.fieldByName('cod_serie_fs').AsString;
  qryAsignar.ParamByname('anyo').AsInteger:= QContadores.fieldByName('anyo_fs').AsInteger;
  qryAsignar.Open;
  if qryAsignar.IsEmpty then
  begin
    qryAsignar.Edit;
    qryAsignar.FieldByName('cod_empresa_es').AsString:= edtEmpresa.Text;
    qryAsignar.FieldByName('cod_serie_es').AsString:= QContadores.FieldByName('cod_serie_fs').AsString;
    qryAsignar.FieldByName('anyo_es').AsInteger:= QContadores.FieldByName('anyo_fs').AsInteger;
    qryAsignar.Post;
  end;
{
  else
  begin
    qryAsignar.Edit;
    qryAsignar.FieldByName('cod_serie_es').AsString:= QContadores.FieldByName('cod_serie_fs').AsString;
    qryAsignar.Post;
  end;
}
  qryAsignar.Close;
  Resfrescar;
end;

procedure TFDContadoresEmpresa.btnCancelarClick(Sender: TObject);
begin
  Close;
end;


procedure TFDContadoresEmpresa.btnDesasignarClick(Sender: TObject);
begin
  //Dessignar serie
  qryDesasignar.ParamByname('empresa').AsString:= edtEmpresa.Text;
  qryDesasignar.ParamByname('serie').AsString:= QContador.fieldByName('cod_serie_fs').AsString;
  qryDesasignar.ParamByname('anyo').AsInteger:= QContador.fieldByName('anyo_fs').AsInteger;
  qryDesasignar.Open;
{
  if qryAsignar.IsEmpty then
  begin
    qryAsignar.Edit;
    qryAsignar.FieldByName('cod_empresa_es').AsString:= edtEmpresa.Text;
    qryAsignar.FieldByName('cod_serie_es').AsString:= QContadores.FieldByName('cod_serie_fs').AsString;
    qryAsignar.FieldByName('anyo_es').AsInteger:= QContadores.FieldByName('anyo_fs').AsInteger;
    qryAsignar.Post;
  end
  else
}
  if not qryDesasignar.IsEmpty then
  begin
    qryDesasignar.Delete;
  end;
  qryDesasignar.Close;
  Resfrescar;
end;

procedure TFDContadoresEmpresa.btnFiltrarClick(Sender: TObject);
begin
  LoadValues( edtEmpresa.Text, StrToInt( edtAnyo.Text ) );
end;

procedure TFDContadoresEmpresa.dbgContadoresDblClick(Sender: TObject);
begin
  //btnModificar.Click;
  btnAceptar.Click;
end;

procedure TFDContadoresEmpresa.edtEmpresaChange(Sender: TObject);
begin
  lblDesEmpresa.Caption:= desEmpresa( edtEmpresa.Text );
end;

procedure TFDContadoresEmpresa.FormCreate(Sender: TObject);
begin
  with QContadores do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_facturas_serie ');
    SQL.Add(' where anyo_fs = :anyo ');
    SQL.Add(' order by anyo_fs desc ');
  end;
  with QContador do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_facturas_serie ');
    SQL.Add(' join frf_empresas_serie on cod_serie_fs = cod_serie_es and anyo_fs = anyo_es ');
    SQL.Add(' where anyo_fs = :anyo and cod_empresa_es = :empresa ');
    SQL.Add(' order by anyo_fs desc ');
  end;

  qryAsignar.SQL.clear;
  qryAsignar.SQL.Add(' select cod_empresa_es, cod_serie_es, anyo_es ');
  qryAsignar.SQL.Add(' from frf_empresas_serie ');
  qryAsignar.SQL.Add(' where cod_empresa_es = :empresa ');
  qryAsignar.SQL.Add(' and anyo_es = :anyo ');
  qryAsignar.SQL.Add(' and cod_serie_es = :serie ');


  qryDesasignar.SQL.clear;
  qryDesasignar.SQL.Add(' select cod_empresa_es, cod_serie_es, anyo_es ');
  qryDesasignar.SQL.Add(' from frf_empresas_serie ');
  qryDesasignar.SQL.Add(' where cod_empresa_es = :empresa ');
  qryDesasignar.SQL.Add(' and anyo_es = :anyo ');
  qryDesasignar.SQL.Add(' and cod_serie_es = :serie ');

end;

end.


