unit DepositoAduanaImportesFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, nbCombos, StdCtrls, nbEdits, nbLabels, Buttons, DB, 
  ExtCtrls, Grids, DBGrids, DBTables, DBCtrls, BEdit, BDEdit;
                                                
type
  TFDDepositoAduanaImportes = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    nbLabel2: TnbLabel;
    fecha_ini_dai: TnbDBCalendarCombo;
    nbLabel3: TnbLabel;
    DBGrid: TDBGrid;
    btnAnyadir: TSpeedButton;
    DSFichaImportes: TDataSource;
    btnBorrar: TSpeedButton;
    lblFechaFinal: TnbLabel;
    fecha_fin_dai: TnbDBCalendarCombo;
    QFichaImportes: TQuery;
    btnModificar: TSpeedButton;
    stPlanta: TStaticText;
    stProveedor: TStaticText;
    stProductor: TStaticText;
    empresa_dai: TBDEdit;
    lblProductor: TnbLabel;
    importe_estadistico_dai: TnbDBNumeric;
    lblProduct_o: TLabel;
    lbl1: TnbLabel;
    importe_fijo_dai: TnbDBNumeric;
    lbl2: TLabel;
    lbl3: TnbLabel;
    coste_salida_dai: TnbDBNumeric;
    lbl4: TLabel;
    lbl5: TLabel;
    QFichaImportesAux: TQuery;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnBorrarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnAnyadirClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure empresa_daiChange(Sender: TObject);
  private
    { Private declarations }
    sEmpresa: String;
    bAlta: boolean;
    dFechaIni: TDateTime;

    function  ValidarValues: boolean;
    function  ActualizarFechaFinAlta ( var VFechaFin: TDateTime ): boolean;

  public
    { Public declarations }
    procedure LoadValues( const AEmpresa: string );

  end;

  procedure ExecuteDepositoAduanaImportes( const AOwner: TComponent; const AEmpresa: string );

implementation

{$R *.dfm}

uses
  bMath, UDMBaseDatos, UDMAuxDB;

var
  FDDepositoAduanaImportes: TFDDepositoAduanaImportes;

procedure ExecuteDepositoAduanaImportes( const AOwner: TComponent; const AEmpresa: string );
begin
  FDDepositoAduanaImportes:= TFDDepositoAduanaImportes.Create( AOwner );
  try
    FDDepositoAduanaImportes.LoadValues( AEmpresa );
    FDDepositoAduanaImportes.ShowModal;
  finally
    FreeAndNil(FDDepositoAduanaImportes );
  end;
end;

procedure TFDDepositoAduanaImportes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  QFichaImportes.Close;
  Action:= caFree;
end;

procedure TFDDepositoAduanaImportes.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFDDepositoAduanaImportes.LoadValues( const AEmpresa: string );
begin
  sEmpresa:= AEmpresa;
  bAlta:= False; 

  with QFichaImportes do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_depositos_aduana_importes ');
    SQL.Add(' where empresa_dai = :empresa ');
    SQL.Add(' order by fecha_ini_dai ');
    ParamByName('empresa').AsString:= AEmpresa;
    Open;
  end;

  with QFichaImportesAux do
  begin
    SQL.Clear;
    SQL.Add(' select * ');
    SQL.Add(' from frf_depositos_aduana_importes ');
    SQL.Add(' where empresa_dai = :empresa ');
    SQL.Add(' order by fecha_ini_dai ');
    ParamByName('empresa').AsString:= AEmpresa;
  end;
end;


function TFDDepositoAduanaImportes.ValidarValues: boolean;
begin
  if TryStrToDate( fecha_ini_dai.Text, dFechaIni ) then
  begin
    ValidarValues:= True;
    //Calcular fecha fin
  end
  else
  begin
    ShowMessage('Fecha incorrecta.');
    fecha_ini_dai.SetFocus;
    ValidarValues:= False;
  end;
end;

procedure TFDDepositoAduanaImportes.btnAnyadirClick(Sender: TObject);
begin
  bAlta:= True;
  btnAceptar.Enabled:= True;
  btnCancelar.Caption:= 'Cancelar (Esc)';

  btnAnyadir.Enabled:= False;
  btnModificar.Enabled:= False;
  btnBorrar.Enabled:= False;

  QFichaImportes.Insert;

  empresa_dai.Text:= sEmpresa;
  fecha_ini_dai.Text:= DateToStr( date );

  QFichaImportes.FieldByName('empresa_dai').AsString:= sEmpresa;
  QFichaImportes.FieldByName('fecha_ini_dai').AsDateTime:= Date;

  fecha_ini_dai.Enabled:= True;
  importe_estadistico_dai.Enabled:= True;
  importe_fijo_dai.Enabled:= True;
  coste_salida_dai.Enabled:= True;
  DBGrid.Enabled:= False;

  fecha_ini_dai.SetFocus;
end;

procedure TFDDepositoAduanaImportes.btnModificarClick(Sender: TObject);
begin
  bAlta:= False;
  if QFichaImportes.IsEmpty then
  begin
    ShowMessage('No hay ficha para modificar');
  end
  else
  begin
    btnAceptar.Enabled:= True;
    btnCancelar.Caption:= 'Cancelar (Esc)';

    btnAnyadir.Enabled:= False;
    btnModificar.Enabled:= False;
    btnBorrar.Enabled:= False;

    fecha_ini_dai.Enabled:= False;
    QFichaImportes.Edit;

    importe_estadistico_dai.Enabled:= True;
    importe_fijo_dai.Enabled:= True;
    coste_salida_dai.Enabled:= True;
    DBGrid.Enabled:= False;

    importe_estadistico_dai.SetFocus;
  end;
end;

procedure TFDDepositoAduanaImportes.btnAceptarClick(Sender: TObject);
var
  dFechaFin: TDateTime;
  bookMark: TBookMark;
begin
  if ValidarValues then
  begin
    if bAlta then
    begin
      dFechaFin:= dFechaIni;
      if ActualizarFechaFinAlta( dFechaFin ) then
      begin
        QFichaImportes.FieldByName('fecha_fin_dai').AsDateTime:= dFechaFin;
      end;
    end;
    QFichaImportes.Post;

    btnAceptar.Enabled:= False;
    btnCancelar.Caption:= 'Cerrar (Esc)';
    ShowMessage('Ficha creada');

    fecha_ini_dai.Enabled:= False;
    importe_estadistico_dai.Enabled:= false;
    importe_fijo_dai.Enabled:= False;
    coste_salida_dai.Enabled:= False;
    DBGrid.Enabled:= True;

    btnAnyadir.Enabled:= True;
    btnModificar.Enabled:= True;
    btnBorrar.Enabled:= True;

    if bAlta then
    begin
      QFichaImportes.Close;
      QFichaImportes.Open;
      while not QFichaImportes.Eof do
      begin
        if QFichaImportes.FieldByName('fecha_ini_dai').AsDateTime = dFechaIni then
          Break;
        QFichaImportes.Next;
      end;
    end;
  end;
end;

procedure TFDDepositoAduanaImportes.btnCancelarClick(Sender: TObject);
begin
  if btnAceptar.Enabled = True then
  begin
    QFichaImportes.Cancel;
    btnAceptar.Enabled:= False;
    btnCancelar.Caption:= 'Cerrar (Esc)';
    ShowMessage('Ficha cancelada');

    fecha_ini_dai.Enabled:= False;
    importe_estadistico_dai.Enabled:= false;
    importe_fijo_dai.Enabled:= False;
    coste_salida_dai.Enabled:= False;
    DBGrid.Enabled:= True;

    btnAnyadir.Enabled:= True;
    btnModificar.Enabled:= True;
    btnBorrar.Enabled:= True;
  end
  else
  begin
    Close;
  end;
end;

procedure TFDDepositoAduanaImportes.btnBorrarClick(Sender: TObject);
var
  dIniAux: TDateTime;
begin
  if not QFichaImportes.IsEmpty then
  begin
    if QFichaImportes.FieldByName('fecha_fin_dai').AsString = '' then
    begin
      QFichaImportes.Delete;
      if not QFichaImportes.IsEmpty then
      begin
        QFichaImportes.Edit;
        QFichaImportes.FieldByName('fecha_fin_dai').AsString:= '';
        QFichaImportes.Post;
      end;
    end
    else
    begin
      QFichaImportes.Delete;
      dIniAux:=  QFichaImportes.FieldByName('fecha_ini_dai').AsDateTime;
      QFichaImportes.Prior;
      if dIniAux <> QFichaImportes.FieldByName('fecha_ini_dai').AsDateTime then
      begin
        QFichaImportes.Edit;
        QFichaImportes.FieldByName('fecha_fin_dai').AsDateTime:= dIniAux - 1;
        QFichaImportes.Post;
      end;
    end;
    ShowMessage('Ficha borrada');
  end
  else
  begin
    ShowMessage('No hay ficha para borrar');
  end;
end;

procedure TFDDepositoAduanaImportes.empresa_daiChange(Sender: TObject);
begin
  stPlanta.Caption:= desEmpresa( empresa_dai.Text );
end;

function TFDDepositoAduanaImportes.ActualizarFechaFinAlta ( var VFechaFin: TDateTime ): boolean;
var
  bAnt: boolean;
begin
  bAnt:= False;
  result:= False;
  QFichaImportesAux.Open;
  try
    if not QFichaImportesAux.IsEmpty then
    begin
      while ( QFichaImportesAux.FieldByName('fecha_ini_dai').AsDateTime < VFechaFin ) and
            ( not QFichaImportesAux.Eof ) do
      begin
        bAnt:= True;
        QFichaImportesAux.Next;
      end;
      if QFichaImportesAux.FieldByName('fecha_ini_dai').AsDateTime <> VFechaFin then
      begin
        if QFichaImportesAux.Eof then
        begin
          //Estoy en 
          QFichaImportesAux.Edit;
          QFichaImportesAux.FieldByName('fecha_fin_dai').AsDateTime:= VFechaFin - 1;
          QFichaImportesAux.Post;
        end
        else
        begin
          //hay anterior
          if bAnt then
          begin
            QFichaImportesAux.Prior;
            QFichaImportesAux.Edit;
            QFichaImportesAux.FieldByName('fecha_fin_dai').AsDateTime:= VFechaFin - 1;
            QFichaImportesAux.Post;
            QFichaImportesAux.Next;
          end;
          //Hay siguiente
          if not QFichaImportesAux.Eof then
          begin
            VFechaFin:= QFichaImportesAux.FieldByName('fecha_ini_dai').AsDateTime - 1;
            result:= True;
          end;
        end;
      end;
    end;
  finally
    QFichaImportesAux.Close;
  end;
end;

end.


