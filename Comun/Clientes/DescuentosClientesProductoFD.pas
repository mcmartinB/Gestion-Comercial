unit DescuentosClientesProductoFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, nbCombos, StdCtrls, nbEdits, nbLabels, Buttons, DB, 
  ExtCtrls, Grids, DBGrids, DBTables, DBCtrls, BEdit, BDEdit, BGrid,
  BSpeedButton, BGridButton;
                                                
type
  TFDDescuentosClientesProducto = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    nbLabel2: TnbLabel;
    fecha_ini_dp: TnbDBCalendarCombo;
    nbLabel3: TnbLabel;
    DBGrid: TDBGrid;
    btnAnyadir: TSpeedButton;
    DSDescuentos: TDataSource;
    btnBorrar: TSpeedButton;
    lblFechaFinal: TnbLabel;
    fecha_fin_dp: TnbDBCalendarCombo;
    QDescuentos: TQuery;
    btnModificar: TSpeedButton;
    stProveedor: TStaticText;
    stProductor: TStaticText;
    empresa_dp: TBDEdit;
    lblProductor: TnbLabel;
    lbl3: TnbLabel;
    QDescuentosAux: TQuery;
    cliente_dp: TBDEdit;
    facturable_dp: TnbDBNumeric;
    lbl2: TnbLabel;
    eurkg_no_facturable_dp: TnbDBNumeric;
    eurkg_facturable_dp: TnbDBNumeric;
    lbl4: TnbLabel;
    RejillaFlotante: TBGrid;
    btnProducto: TBGridButton;
    txtProducto: TStaticText;
    lblProducto: TnbLabel;
    producto_dp: TBDEdit;
    stDesCliente: TStaticText;
    stDesEmpresa: TStaticText;
    lbl1: TnbLabel;
    no_fact_bruto_dp: TnbDBNumeric;
    nbLabel1: TnbLabel;
    no_fact_neto_dp: TnbDBNumeric;
    nbLabel4: TnbLabel;
    eurpale_facturable_dp: TnbDBNumeric;
    nbLabel5: TnbLabel;
    eurpale_no_facturable_dp: TnbDBNumeric;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnBorrarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnAnyadirClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure empresa_dpChange(Sender: TObject);
    procedure btnProductoClick(Sender: TObject);
    procedure producto_dpChange(Sender: TObject);
    procedure cliente_dpChange(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sCliente, sProducto: String;
    bAlta: boolean;
    dFechaIni: TDateTime;

    function  ValidarValues: boolean;
    function  ActualizarFechaFinAlta ( var VFechaFin: TDateTime ): boolean;

  public
    { Public declarations }
    procedure LoadValues( const AEmpresa, ACliente, AProducto: string );

  end;

  procedure ExecuteDescuentosClientesProducto( const AOwner: TComponent; const AEmpresa, ACliente, AProducto: string );

implementation

{$R *.dfm}

uses
  bMath, UDMBaseDatos, UDMAuxDB, CAuxiliarDB, SincronizacionBonny;

var
  FDDescuentosClientesProducto: TFDDescuentosClientesProducto;

procedure ExecuteDescuentosClientesProducto( const AOwner: TComponent; const AEmpresa, ACliente, AProducto: string );
begin
  FDDescuentosClientesProducto:= TFDDescuentosClientesProducto.Create( AOwner );
  try
    FDDescuentosClientesProducto.LoadValues( AEmpresa, ACliente, AProducto );
    FDDescuentosClientesProducto.ShowModal;
  finally
    FreeAndNil(FDDescuentosClientesProducto );
  end;
end;

procedure TFDDescuentosClientesProducto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  QDescuentos.Close;
  Action:= caFree;
end;

procedure TFDDescuentosClientesProducto.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFDDescuentosClientesProducto.LoadValues( const AEmpresa, ACliente, AProducto: string );
begin
  sEmpresa:= AEmpresa;
  sCliente:= ACliente;
  sProducto:= AProducto;
  bAlta:= False;

  cliente_dp.Text := sCliente;
  empresa_dp.Text := sEmpresa;
  producto_dp.Text := sProducto;

  with QDescuentos do
  begin
    SQL.Clear;
    SQL.Add(' select empresa_dp, cliente_dp, producto_dp, no_fact_bruto_dp, no_fact_neto_dp, facturable_dp, ');
    SQL.Add('        eurkg_no_facturable_dp, eurkg_facturable_dp, eurpale_no_facturable_dp, eurpale_facturable_dp, ');
    SQL.Add('        fecha_ini_dp, fecha_fin_dp ');
    SQL.Add(' from frf_descuentos_producto ');
    SQL.Add(' where empresa_dp = :empresa ');
    SQL.Add(' and cliente_dp = :cliente ');
    SQL.Add(' and producto_dp = :producto ');
    SQL.Add(' order by fecha_ini_dp ');
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('cliente').AsString:= ACliente;
    ParamByName('producto').AsString:= AProducto;
    Open;
  end;

  with QDescuentosAux do
  begin
    SQL.Clear;
    SQL.AddStrings( QDescuentos.SQL );
    ParamByName('empresa').AsString:= AEmpresa;
    ParamByName('cliente').AsString:= ACliente;
    ParamByName('producto').AsString:= AProducto;
  end;

  txtProducto.Caption:= desProducto(QDescuentos.FieldByName('empresa_dp').AsString,
                                    QDescuentos.FieldByName('producto_dp').AsString);

  stDesCliente.Caption := desCliente(QDescuentos.FieldByName('cliente_dp').AsString);
end;


function TFDDescuentosClientesProducto.ValidarValues: boolean;
begin
  if TryStrToDate( fecha_ini_dp.Text, dFechaIni ) then
  begin
    ValidarValues:= True;
    //Calcular fecha fin
  end
  else
  begin
    ShowMessage('Fecha incorrecta.');
    fecha_ini_dp.SetFocus;
    ValidarValues:= False;
  end;
  if no_fact_bruto_dp.Text = '' then
  begin
    QDescuentos.FieldByName('no_fact_bruto_dp').AsFloat:= 0;
  end;
  if no_fact_neto_dp.Text = '' then
  begin
    QDescuentos.FieldByName('no_fact_neto_dp').AsFloat:= 0;
  end;
  if facturable_dp.Text = '' then
  begin
    QDescuentos.FieldByName('facturable_dp').AsFloat:= 0;
  end;
  if eurkg_no_facturable_dp.Text = '' then
  begin
    QDescuentos.FieldByName('eurkg_no_facturable_dp').AsFloat:= 0;
  end;
  if eurkg_facturable_dp.Text = '' then
  begin
    QDescuentos.FieldByName('eurkg_facturable_dp').AsFloat:= 0;
  end;
  if eurpale_no_facturable_dp.Text = '' then
  begin
    QDescuentos.FieldByName('eurpale_no_facturable_dp').AsFloat:= 0;
  end;
  if eurpale_facturable_dp.Text = '' then
  begin
    QDescuentos.FieldByName('eurpale_facturable_dp').AsFloat:= 0;
  end;
end;

procedure TFDDescuentosClientesProducto.btnAnyadirClick(Sender: TObject);
begin
  bAlta:= True;
  btnAceptar.Enabled:= True;
  btnCancelar.Caption:= 'Cancelar (Esc)';

  btnAnyadir.Enabled:= False;
  btnModificar.Enabled:= False;
  btnBorrar.Enabled:= False;

  QDescuentos.Insert;

  empresa_dp.Text:= sEmpresa;
  cliente_dp.Text:= sCliente;
  fecha_ini_dp.Text:= DateToStr( date );

  QDescuentos.FieldByName('empresa_dp').AsString:= sEmpresa;
  QDescuentos.FieldByName('cliente_dp').AsString:= sCliente;
  QDescuentos.FieldByName('producto_dp').AsString:= sProducto;
  QDescuentos.FieldByName('facturable_dp').AsInteger:= 0;
  QDescuentos.FieldByName('no_fact_bruto_dp').AsInteger:= 0;
  QDescuentos.FieldByName('no_fact_neto_dp').AsInteger:= 0;
  QDescuentos.FieldByName('eurkg_facturable_dp').AsInteger:= 0;
  QDescuentos.FieldByName('eurkg_no_facturable_dp').AsInteger:= 0;
  QDescuentos.FieldByName('eurpale_facturable_dp').AsInteger:= 0;
  QDescuentos.FieldByName('eurpale_no_facturable_dp').AsInteger:= 0;
  QDescuentos.FieldByName('fecha_ini_dp').AsDateTime:= Date;

  fecha_ini_dp.Enabled:= True;
  facturable_dp.Enabled:= True;
  no_fact_bruto_dp.Enabled:= True;
  no_fact_neto_dp.Enabled:= True;
  eurkg_facturable_dp.Enabled:= True;
  eurkg_no_facturable_dp.Enabled:= True;
  eurpale_facturable_dp.Enabled:= True;
  eurpale_no_facturable_dp.Enabled:= True;
  DBGrid.Enabled:= False;

  fecha_ini_dp.SetFocus;
end;

procedure TFDDescuentosClientesProducto.btnModificarClick(Sender: TObject);
begin
  bAlta:= False;
  if QDescuentos.IsEmpty then
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

    fecha_ini_dp.Enabled:= False;
    QDescuentos.Edit;

    facturable_dp.Enabled:= True;
    no_fact_bruto_dp.Enabled:= True;
    no_fact_neto_dp.Enabled:= True;
    eurkg_no_facturable_dp.Enabled:= True;
    eurkg_facturable_dp.Enabled:= True;
    eurpale_no_facturable_dp.Enabled:= True;
    eurpale_facturable_dp.Enabled:= True;
    DBGrid.Enabled:= False;

    facturable_dp.SetFocus;
  end;
end;

procedure TFDDescuentosClientesProducto.btnAceptarClick(Sender: TObject);
var
  dFechaFin: TDateTime;
begin
  if ValidarValues then
  begin
    if bAlta then
    begin
      dFechaFin:= dFechaIni;
      if ActualizarFechaFinAlta( dFechaFin ) then
      begin
        QDescuentos.FieldByName('fecha_fin_dp').AsDateTime:= dFechaFin;
      end;
    end;
    QDescuentos.Post;
    
    SincroBonnyAurora.SincronizarDescuentoProducto(
      QDescuentos.FieldByName('empresa_dp').AsString,
      QDescuentos.FieldByName('cliente_dp').AsString,
      QDescuentos.FieldByName('producto_dp').AsString,
      QDescuentos.FieldByName('fecha_ini_dp').AsDateTime
    );
    SincroBonnyAurora.Sincronizar;

    btnAceptar.Enabled:= False;
    btnCancelar.Caption:= 'Cerrar (Esc)';
    ShowMessage('Ficha creada');

    fecha_ini_dp.Enabled:= False;
    facturable_dp.Enabled:= False;
    no_fact_bruto_dp.Enabled:= false;
    no_fact_neto_dp.Enabled:= false;
    eurkg_facturable_dp.Enabled:= False;
    eurkg_no_facturable_dp.Enabled:= false;
    eurpale_facturable_dp.Enabled:= False;
    eurpale_no_facturable_dp.Enabled:= false;
    DBGrid.Enabled:= True;

    btnAnyadir.Enabled:= True;
    btnModificar.Enabled:= True;
    btnBorrar.Enabled:= True;

    if bAlta then
    begin
      QDescuentos.Close;
      QDescuentos.Open;
      while not QDescuentos.Eof do
      begin
        if QDescuentos.FieldByName('fecha_ini_dp').AsDateTime = dFechaIni then
          Break;
        QDescuentos.Next;
      end;
    end;
  end;
end;

procedure TFDDescuentosClientesProducto.btnCancelarClick(Sender: TObject);
begin
  if btnAceptar.Enabled = True then
  begin
    QDescuentos.Cancel;
    btnAceptar.Enabled:= False;
    btnCancelar.Caption:= 'Cerrar (Esc)';
    ShowMessage('Ficha cancelada');

    fecha_ini_dp.Enabled:= False;
    facturable_dp.Enabled:= false;
    no_fact_bruto_dp.Enabled:= False;
    no_fact_neto_dp.Enabled:= False;
    eurkg_facturable_dp.Enabled:= false;
    eurkg_no_facturable_dp.Enabled:= False;
    eurpale_facturable_dp.Enabled:= false;
    eurpale_no_facturable_dp.Enabled:= False;
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

procedure TFDDescuentosClientesProducto.btnBorrarClick(Sender: TObject);
var
  dIniAux: TDateTime;
begin
  if not QDescuentos.IsEmpty then
  begin
    if QDescuentos.FieldByName('fecha_fin_dp').AsString = '' then
    begin
      QDescuentos.Delete;
      SincroBonnyAurora.SincronizarDescuentoProducto(
        QDescuentos.FieldByName('empresa_dp').AsString,
        QDescuentos.FieldByName('cliente_dp').AsString,
        QDescuentos.FieldByName('producto_dp').AsString,
        QDescuentos.FieldByName('fecha_ini_dp').AsDateTime
      );
      SincroBonnyAurora.Sincronizar;

      if not QDescuentos.IsEmpty then
      begin
        QDescuentos.Edit;
        QDescuentos.FieldByName('fecha_fin_dp').AsString:= '';
        QDescuentos.Post;

        SincroBonnyAurora.SincronizarDescuentoProducto(
          QDescuentos.FieldByName('empresa_dp').AsString,
          QDescuentos.FieldByName('cliente_dp').AsString,
          QDescuentos.FieldByName('producto_dp').AsString,
          QDescuentos.FieldByName('fecha_ini_dp').AsDateTime
        );
        SincroBonnyAurora.Sincronizar;
      end;
    end
    else
    begin
      QDescuentos.Delete;
      SincroBonnyAurora.SincronizarDescuentoProducto(
        QDescuentos.FieldByName('empresa_dp').AsString,
        QDescuentos.FieldByName('cliente_dp').AsString,
        QDescuentos.FieldByName('producto_dp').AsString,
        QDescuentos.FieldByName('fecha_ini_dp').AsDateTime
      );
      SincroBonnyAurora.Sincronizar;
      dIniAux:=  QDescuentos.FieldByName('fecha_ini_dp').AsDateTime;
      QDescuentos.Prior;
      if dIniAux <> QDescuentos.FieldByName('fecha_ini_dp').AsDateTime then
      begin
        QDescuentos.Edit;
        QDescuentos.FieldByName('fecha_fin_dp').AsDateTime:= dIniAux - 1;
        QDescuentos.Post;
        SincroBonnyAurora.SincronizarDescuentoProducto(
          QDescuentos.FieldByName('empresa_dp').AsString,
          QDescuentos.FieldByName('cliente_dp').AsString,
          QDescuentos.FieldByName('producto_dp').AsString,
          QDescuentos.FieldByName('fecha_ini_dp').AsDateTime
        );
        SincroBonnyAurora.Sincronizar;
      end;
    end;
    ShowMessage('Ficha borrada');
  end
  else
  begin
    ShowMessage('No hay ficha para borrar');
  end;
end;

procedure TFDDescuentosClientesProducto.empresa_dpChange(Sender: TObject);
begin
  stDesEmpresa.Caption:= desEmpresa( empresa_dp.Text );
end;

function TFDDescuentosClientesProducto.ActualizarFechaFinAlta ( var VFechaFin: TDateTime ): boolean;
var
  bAnt: boolean;
begin
  bAnt:= False;
  result:= False;
  QDescuentosAux.Open;
  try
    if not QDescuentosAux.IsEmpty then
    begin
      while ( QDescuentosAux.FieldByName('fecha_ini_dp').AsDateTime < VFechaFin ) and
            ( not QDescuentosAux.Eof ) do
      begin
        bAnt:= True;
        QDescuentosAux.Next;
      end;
      if QDescuentosAux.FieldByName('fecha_ini_dp').AsDateTime <> VFechaFin then
      begin
        if QDescuentosAux.Eof then
        begin
          //Estoy en
          QDescuentosAux.Edit;
          QDescuentosAux.FieldByName('fecha_fin_dp').AsDateTime:= VFechaFin - 1;
          QDescuentosAux.Post;
          SincroBonnyAurora.SincronizarDescuentoProducto(
            QDescuentosAux.FieldByName('empresa_dp').AsString,
            QDescuentosAux.FieldByName('cliente_dp').AsString,
            QDescuentosAux.FieldByName('producto_dp').AsString,
            QDescuentosAux.FieldByName('fecha_ini_dp').AsDateTime
          );
          SincroBonnyAurora.Sincronizar;
      end
        else
        begin
          //hay anterior
          if bAnt then
          begin
            QDescuentosAux.Prior;
            QDescuentosAux.Edit;
            QDescuentosAux.FieldByName('fecha_fin_dp').AsDateTime:= VFechaFin - 1;
            QDescuentosAux.Post;
            SincroBonnyAurora.SincronizarDescuentoProducto(
              QDescuentosAux.FieldByName('empresa_dp').AsString,
              QDescuentosAux.FieldByName('cliente_dp').AsString,
              QDescuentosAux.FieldByName('producto_dp').AsString,
              QDescuentosAux.FieldByName('fecha_ini_dp').AsDateTime
            );
            SincroBonnyAurora.Sincronizar;
            QDescuentosAux.Next;
          end;
          //Hay siguiente
          if not QDescuentosAux.Eof then
          begin
            VFechaFin:= QDescuentosAux.FieldByName('fecha_ini_dp').AsDateTime - 1;
            result:= True;
          end;
        end;
      end;
    end;
  finally
    QDescuentosAux.Close;
  end;
end;

procedure TFDDescuentosClientesProducto.btnProductoClick(Sender: TObject);
begin
  DespliegaRejilla(btnProducto, [empresa_dp.Text] );
end;

procedure TFDDescuentosClientesProducto.cliente_dpChange(Sender: TObject);
begin
  stDesCliente.Caption := desCliente(cliente_dp.Text);
end;

procedure TFDDescuentosClientesProducto.producto_dpChange(Sender: TObject);
begin
  txtProducto.Caption:= desProducto(empresa_dp.Text, producto_dp.Text );
end;

end.


