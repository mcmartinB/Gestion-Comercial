unit DListadoControlEntregas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, nbEdits, nbCombos, Buttons, nbLabels, BEdit;

type
  TFDListadoControlEntregas = class(TForm)
    eEmpresa: TnbDBSQLCombo;
    eCentro: TnbDBSQLCombo;
    eFechaFin: TnbDBCalendarCombo;
    nbLabel1: TnbLabel;
    nbLabel3: TnbLabel;
    nomEmpresa: TnbStaticText;
    btnOk: TSpeedButton;
    btnCancel: TSpeedButton;
    nomCentro: TnbStaticText;
    eFechaIni: TnbDBCalendarCombo;
    nbLabel5: TnbLabel;
    eProducto: TnbDBSQLCombo;
    nomProducto: TnbStaticText;
    cbxFecha: TComboBox;
    cbxCentro: TComboBox;
    cbxTermografo: TCheckBox;
    procedure BtnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function nomEmpresaGetDescription: String;
    procedure eEmpresaChange(Sender: TObject);
    procedure eCentroChange(Sender: TObject);
    function nomCentroGetDescription: String;
    procedure BtnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    function eProductoGetSQL: String;
    procedure eProductoChange(Sender: TObject);
    function eCentroGetSQL: String;
    function nomProductoGetDescription: String;
  private
    { Private declarations }
    function  ParametrosOK: boolean;
    procedure ListadoControl( const AEmpresa, ACentro, AProducto: String;
                              const AFechaIni, AFechaFin: TDateTime );
    procedure ListadoControlApaisado( const AEmpresa, ACentro, AProducto: String;
                              const AFechaIni, AFechaFin: TDateTime );

  public
    { Public declarations }
  end;

implementation

uses bSQLUtils, UDMAuxDB, DMListadoControlEntregas, DBTables, DB, bDialogs,
     CVariables, UDMConfig, bTextUtils, Principal, CGestionPrincipal,
     QListadoControlEntregas, QListadoControlEntregasApaisado,
     CReportes, DPreview;

{$R *.dfm}

var
  DMListControlEntregas: TDMListadoControlEntregasForm;

procedure TFDListadoControlEntregas.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  DMListControlEntregas:= TDMListadoControlEntregasForm.create( Application );
  eEmpresa.Text:= gsDefEmpresa;
  eCentro.Text:= gsDefCentro;
  eFechaIni.AsDate:= date;
  eFechaFin.AsDate:= date;
  nomProducto.Description;
end;

procedure TFDListadoControlEntregas.BtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFDListadoControlEntregas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  BEMensajes('');
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;

  FreeAndNil( DMListControlEntregas );
  Action:= caFree;
end;

function TFDListadoControlEntregas.eCentroGetSQL: String;
begin
  if eEmpresa.Text <> '' then
  begin
    result:= ' select empresa_c, centro_c, descripcion_c from frf_centros ' +
             ' where empresa_c ' + SQLEqualS( eEmpresa.Text );
  end
  else
  begin
    result:= ' select empresa_c, centro_c, descripcion_c from frf_centros ';
  end;
end;

function TFDListadoControlEntregas.eProductoGetSQL: String;
begin
  if eEmpresa.Text <> '' then
  begin
    result:= ' select empresa_p, producto_p, descripcion_p from frf_productos ' +
             ' where empresa_p ' + SQLEqualS( eEmpresa.Text );
  end
  else
  begin
    result:= ' select empresa_p, producto_p, descripcion_p from frf_productos ';
  end;
end;

function TFDListadoControlEntregas.nomEmpresaGetDescription: String;
begin
  result:= desEmpresa( eEmpresa.Text );
end;

function TFDListadoControlEntregas.nomCentroGetDescription: String;
begin
  if eCentro.Text = '' then
     result:= 'Vacio = Todos'
  else
    result:= desCentro( eEmpresa.Text, eCentro.Text );
end;

function TFDListadoControlEntregas.nomProductoGetDescription: String;
begin
  if eProducto.Text = '' then
     result:= 'Vacio = Todos'
  else
    result:= desProducto( eEmpresa.Text, eProducto.Text );

end;

procedure TFDListadoControlEntregas.eEmpresaChange(Sender: TObject);
begin
  nomEmpresa.Description;
  nomCentro.Description;
end;

procedure TFDListadoControlEntregas.eCentroChange(Sender: TObject);
begin
  nomCentro.Description;
end;

procedure TFDListadoControlEntregas.eProductoChange(Sender: TObject);
begin
  nomProducto.Description;
end;

function TFDListadoControlEntregas.ParametrosOK: boolean;
var
  dIni, dFin: TDateTime;
begin
  result:= True;
  if result and ( nomEmpresa.Caption = '' ) then
  begin
    ShowMessage('Código de empresa incorrecto.');
    eEmpresa.SetFocus;
    result:= false;
  end;
  if result and ( nomCentro.Caption = '' ) then
  begin
    ShowMessage('Código de centro incorrecto.');
    eCentro.SetFocus;
    result:= false;
  end;
  if result and ( nomProducto.Caption = '' ) then
  begin
    ShowMessage('Código de producto incorrecto.');
    eProducto.SetFocus;
    result:= false;
  end;
  if result and ( not TryStrToDate( eFechaini.Text, dIni ) ) then
  begin
    ShowMessage('Fecha de inicio incorrecta.');
    eFechaini.SetFocus;
    result:= false;
  end;
  if result and ( not TryStrToDate( eFechaFin.Text, dFin ) ) then
  begin
    ShowMessage('Fecha de fin incorrecta.');
    eFechaFin.SetFocus;
    result:= false;
  end;
  if result and ( dFin < dIni ) then
  begin
    ShowMessage('La fecha de fin no puede ser menor que la de inicio.');
    eFechaini.SetFocus;
    result:= false;
  end;
end;

procedure TFDListadoControlEntregas.BtnOkClick(Sender: TObject);
begin
  if ParametrosOK then
  begin
   ListadoControl( eEmpresa.Text, eCentro.Text, eProducto.Text, eFechaIni.AsDate, eFechaFin.AsDate  );
  end;
end;

procedure TFDListadoControlEntregas.ListadoControl( const AEmpresa, ACentro, AProducto: String;
                              const AFechaIni, AFechaFin: TDateTime );
var
  QRListadoControlEntregas: TQRListadoControlEntregas;
begin

  with DMListControlEntregas do
  begin
    ConfigurarListado( ACentro, AProducto, cbxFecha.ItemIndex, cbxCentro.ItemIndex = 0, not cbxTermografo.Checked );
    if ObtenerListado( AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin ) then
    begin
      QRListadoControlEntregas:= TQRListadoControlEntregas.Create( self );
      try
        PonLogoGrupoBonnysa(QRListadoControlEntregas, EEmpresa.Text);

        if eProducto.Text = '' then
          QRListadoControlEntregas.lblProducto.Caption:= 'TODOS LOS PRODUCTOS'
        else
          QRListadoControlEntregas.lblProducto.Caption:= nomProducto.Caption;
        if eCentro.Text = '' then
          QRListadoControlEntregas.lblCentro.Caption:= 'TODOS LOS CENTROS'
        else
        begin
          if cbxCentro.ItemIndex = 0 then
            QRListadoControlEntregas.lblCentro.Caption:= 'ORIGEN ' + nomCentro.Caption
          else
            QRListadoControlEntregas.lblCentro.Caption:= 'DESTINO ' + nomCentro.Caption;
        end;
        case cbxFecha.ItemIndex of
          0: QRListadoControlEntregas.lblFechas.Caption:= 'ORIGEN DEL ' + eFechaIni.Text + ' AL ' + eFechaFin.Text;
          1: QRListadoControlEntregas.lblFechas.Caption:= 'DESTINO DEL ' + eFechaIni.Text + ' AL ' + eFechaFin.Text;
          2: QRListadoControlEntregas.lblFechas.Caption:= 'CARGA DEL ' + eFechaIni.Text + ' AL ' + eFechaFin.Text;
        end;
        if cbxTermografo.Checked then
          QRListadoControlEntregas.lblDatosVar.Caption:= 'Termografo'
        else
          QRListadoControlEntregas.lblDatosVar.Caption:= 'Matricula';

        Preview( QRListadoControlEntregas );
      except
        FreeAndNil( QRListadoControlEntregas );
      end;
    end
    else
    begin
      ShowMessage('Sin Datos');
    end;
    QListado.Close;
  end;
end;

procedure TFDListadoControlEntregas.ListadoControlApaisado( const AEmpresa, ACentro, AProducto: String;
                              const AFechaIni, AFechaFin: TDateTime );
var
  QRListadoControlEntregasApaisado: TQRListadoControlEntregasApaisado;
begin

  with DMListControlEntregas do
  begin
    ConfigurarListado( ACentro, AProducto, cbxFecha.ItemIndex, cbxCentro.ItemIndex = 0, false );
    if ObtenerListado( AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin ) then
    begin
      QRListadoControlEntregasApaisado:= TQRListadoControlEntregasApaisado.Create( self );
      try
        PonLogoGrupoBonnysa(QRListadoControlEntregasApaisado, EEmpresa.Text);

        if eProducto.Text = '' then
          QRListadoControlEntregasApaisado.lblProducto.Caption:= 'TODOS LOS PRODUCTOS'
        else
          QRListadoControlEntregasApaisado.lblProducto.Caption:= nomProducto.Caption;
        if eCentro.Text = '' then
          QRListadoControlEntregasApaisado.lblCentro.Caption:= 'TODOS LOS CENTROS'
        else
        begin
          if cbxCentro.ItemIndex = 0 then
            QRListadoControlEntregasApaisado.lblCentro.Caption:= 'ORIGEN ' + nomCentro.Caption
          else
            QRListadoControlEntregasApaisado.lblCentro.Caption:= 'DESTINO ' + nomCentro.Caption;
        end;
        case cbxFecha.ItemIndex of
          0: QRListadoControlEntregasApaisado.lblFechas.Caption:= 'ORIGEN DEL ' + eFechaIni.Text + ' AL ' + eFechaFin.Text;
          1: QRListadoControlEntregasApaisado.lblFechas.Caption:= 'DESTINO DEL ' + eFechaIni.Text + ' AL ' + eFechaFin.Text;
          2: QRListadoControlEntregasApaisado.lblFechas.Caption:= 'CARGA DEL ' + eFechaIni.Text + ' AL ' + eFechaFin.Text;
        end;

        Preview( QRListadoControlEntregasApaisado );
      except
        FreeAndNil( QRListadoControlEntregasApaisado );
      end;
    end
    else
    begin
      ShowMessage('Sin Datos');
    end;
    QListado.Close;
  end;
end;

procedure TFDListadoControlEntregas.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_f1:btnOk.Click;
    vk_escape:btnCancel.Click;
  end;
end;

procedure TFDListadoControlEntregas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    //               y entre los Campos de Búsqueda en la localización
  case key of
    vk_Return, vk_down:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
      end;
    vk_up:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
      end;
  end;
end;

end.
