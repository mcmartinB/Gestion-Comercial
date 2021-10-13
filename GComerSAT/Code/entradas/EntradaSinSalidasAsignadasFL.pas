unit EntradaSinSalidasAsignadasFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, StdCtrls, BEdit, BCalendarButton,
  BGrid, ComCtrls, BCalendario, nbLabels, Buttons, BSpeedButton,
  BGridButton;

type
  TFLEntradaSinSalidasAsignadas = class(TForm)
    btnAceptar: TButton;
    btnCancelar: TButton;
    lblEmpresa: TnbLabel;
    lblProducto: TnbLabel;
    lblCentro: TnbLabel;
    lblFechaDesde: TnbLabel;
    edtFechaDesde: TBEdit;
    edtCentro: TBEdit;
    btnCentro: TBGridButton;
    btnProducto: TBGridButton;
    edtProducto: TBEdit;
    edtEmpresa: TBEdit;
    btnEmpresa: TBGridButton;
    stEmpresa: TnbStaticText;
    stProducto: TnbStaticText;
    stCentro: TnbStaticText;
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    btnHasta: TBCalendarButton;
    nbLabel1: TnbLabel;
    edtFechaHasta: TBEdit;
    btnDesde: TBCalendarButton;
    cbbTipo: TComboBox;
    lblCodigo1: TnbLabel;
    chkEntradas: TRadioButton;
    chkSalidas: TRadioButton;
    cbbTipoSalida: TComboBox;
    lblNumEntrada: TnbLabel;
    edtNumero: TBEdit;
    lbl1: TLabel;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnBotonClick(Sender: TObject);
    procedure edtEmpresaChange(Sender: TObject);
    procedure edtCentroChange(Sender: TObject);
    procedure edtProductoChange(Sender: TObject);
    procedure TipoListadoClick(Sender: TObject);
  private
    { Private declarations }
    bFlag, bSalida: Boolean;
    iTipo, iSalida: Integer;
    sEmpresa, sCentro, sProducto, sNumero: string;
    dFechaIni, dFechaFin: TDateTime;

    function ValidarEntrada: Boolean;

  public
    { Public declarations }
  end;

function GetParametrosEntradasSinAsignar( const AOwner: TComponent; var AVerSalida: Boolean;
                                    var AEmpresa, ACentro, AProducto, ANumero: string;
                                    var AFechaIni, AFechaFin: TDateTime; var ATipo, ATipoSalida: integer ): boolean;

implementation

{$R *.dfm}

uses
  UDMAuxDB, CVariables, UDMBaseDatos, CAuxiliarDB, EntradaSinSalidasAsignadasQL;


function GetParametrosEntradasSinAsignar( const AOwner: TComponent; var AVerSalida: Boolean;
                                    var AEmpresa, ACentro, AProducto, ANumero: string;
                                    var AFechaIni, AFechaFin: TDateTime; var ATipo, ATipoSalida: integer ): boolean;
var
  FLEntradaSinSalidasAsignadas: TFLEntradaSinSalidasAsignadas;
begin
  FLEntradaSinSalidasAsignadas:= TFLEntradaSinSalidasAsignadas.Create( AOwner );
  try
    with FLEntradaSinSalidasAsignadas do
    begin
      if AEmpresa <> '' then
        sEmpresa:= AEmpresa
      else
        sEmpresa:= gsDefEmpresa;
      if ACentro <> '' then
        sCentro:= ACentro
      else
        sCentro:= gsDefCentro;
      if AProducto <> '' then
        sProducto:= AProducto
      else
        sProducto:= gsDefProducto;
      dFechaIni:= AFechaIni;
      dFechaFin:= AFechaFin;

      iTipo:= ATipo;
      cbbTipo.ItemIndex:= iTipo;

      bSalida:= AVerSalida;
      chkSalidas.Checked:= bSalida;
      iSalida:= ATipoSalida;
      cbbTipoSalida.ItemIndex:= iSalida;

      sNumero:= ANumero;
      edtNumero.Text:= sNumero;

      edtEmpresa.Text := sEmpresa;
      edtCentro.Text := sCentro;
      edtProducto.Text:= sProducto;
      edtFechaDesde.Text := DateToStr( dFechaIni );
      edtFechaHasta.Text := DateToStr( dFechaFin );

      Caption:= '   LISTADO ENTREGAS SIN SALIDAS ASIGNADAS ';
      bFlag:= False;
      ShowModal;
      Result:= bFlag;
      if Result then
      begin
        AVerSalida:= bSalida;
        AEmpresa := sEmpresa;
        ACentro := sCentro;
        AProducto := sProducto;
        AFechaIni := dFechaIni;
        AFechaFin := dFechaFin;
        ATipo:= iTipo;
        ATipoSalida:= iSalida;
        ANumero:= sNumero;
      end;
    end;
  finally
    FreeAndNil( FLEntradaSinSalidasAsignadas );
  end;
end;

procedure TFLEntradaSinSalidasAsignadas.FormCreate(Sender: TObject);
begin
  edtEmpresa.Tag := kEmpresa;
  edtProducto.Tag := kProducto;
  edtCentro.Tag := kCentro;
  edtFechaHasta.Tag := kCalendar;

  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  CalendarioFlotante.Date := Date;
end;

procedure TFLEntradaSinSalidasAsignadas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caHide;
end;

procedure TFLEntradaSinSalidasAsignadas.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
    //               y entre los Campos de Búsqueda en la localización
  case key of
    vk_Return, vk_down:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
      end;
    vk_F2:
      begin
        Key := 0;
        btnBotonClick( ActiveControl );
      end;
    vk_up:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
      end;
    vk_escape:
      begin
        btnCancelar.Click;
      end;
    vk_f1:
      begin
        btnAceptar.Click;
      end;
  end;
end;

procedure TFLEntradaSinSalidasAsignadas.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFLEntradaSinSalidasAsignadas.btnBotonClick(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kProducto: DespliegaRejilla(btnProducto, [edtEmpresa.Text]);
    kCentro: DespliegaRejilla(btnCentro, [edtEmpresa.Text]);
    kCalendar: DespliegaCalendario(btnHasta);
  end;
end;

procedure TFLEntradaSinSalidasAsignadas.edtEmpresaChange(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  stEmpresa.Caption:= desEmpresa( edtEmpresa.Text );
  edtProductoChange( edtProducto );
  edtCentroChange( edtCentro );
end;

procedure TFLEntradaSinSalidasAsignadas.edtCentroChange(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  stCentro.Caption:= desCentro( edtEmpresa.Text, edtCentro.Text );
end;

procedure TFLEntradaSinSalidasAsignadas.edtProductoChange(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  stProducto.Caption:= desProducto( edtEmpresa.Text, edtProducto.Text );
end;

procedure TFLEntradaSinSalidasAsignadas.btnAceptarClick(Sender: TObject);
begin
  if ValidarEntrada then
  begin
    bFlag:= True;
    Close;
  end;
end;

procedure TFLEntradaSinSalidasAsignadas.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

function TFLEntradaSinSalidasAsignadas.ValidarEntrada: Boolean;
begin
  result := false;
  //El codigo de empresa es obligatorio
  if Trim( stEmpresa.Caption ) = '' then
  begin
    edtEmpresa.SetFocus;
    ShowMessage('Falta código de empresa o es incorrecto.');
    Exit;
  end;
  sEmpresa:= edtEmpresa.Text;

  if Trim( stCentro.Caption ) = '' then
  begin
    edtCentro.SetFocus;
    ShowMessage('Falta código de centro o es incorrecto.');
    Exit;
  end;
  sCentro:= edtCentro.Text;

  if Trim( stProducto.Caption ) = '' then
  begin
    edtProducto.SetFocus;
    ShowMessage('Falta código de producto o es incorrecto.');
    Exit;
  end;
  sProducto:= edtProducto.Text;


  //Comprobar que las fechas sean correctas
  if not TryStrToDate(edtFechaDesde.Text, dFechaIni ) then
  begin
    edtFechaDesde.SetFocus;
    ShowMessage('Fecha de inicio incorrecta.');
    Exit;
  end;
  if not TryStrToDate(edtFechaHasta.Text, dFechaFin ) then
  begin
    edtFechaHasta.SetFocus;
    ShowMessage('Fecha de fin incorrecta.');
    Exit;
  end;
  if dFechaIni > dFechaFin then
  begin
    edtFechaDesde.SetFocus;
    ShowMessage('Rango de fechas incorrecto.');
    Exit;
  end;

  iTipo:= cbbTipo.ItemIndex;

  bSalida:= chkSalidas.Checked;
  if bSalida then
  begin
    iSalida:= cbbTipoSalida.ItemIndex;
  end
  else
  begin
    iSalida:= 0;
  end;

  sNumero:= edtNumero.Text;

  result := true;
end;

procedure TFLEntradaSinSalidasAsignadas.TipoListadoClick(Sender: TObject);
begin
  //
  if chkEntradas.Checked then
  begin
    Caption:= '   ENTRADAS DE CAMPO - ASIGNACION DE SALIDAS';
    lblCentro.Caption:= 'Centro Entrada';
    cbbTipoSalida.Enabled:= False;
    lblNumEntrada.Caption:= 'Num. Entrada';
  end
  else
  begin
    Caption:= '   SALIDAS DE ALMACEN - ASIGNACION DE ENTRADAS';
    lblCentro.Caption:= 'Centro Salida';
    cbbTipoSalida.Enabled:= True;
    lblNumEntrada.Caption:= 'Num. Salida';
  end;
end;

(*

-- entradas sin salidas asignadas -> ver cosecheros
---------------------------------------------------------------------------------------------------

select empresa_ec, centro_ec,  numero_entrada_ec, fecha_ec, producto_ec, peso_neto_ec,
       cosechero_e2l,
       ( select nombre_c from frf_cosecheros where empresa_c = empresa_e2l and cosechero_c = cosechero_e2l ) des_cosechero,
       plantacion_e2l, ano_sem_planta_e2l,
       ( select descripcion_p from frf_plantaciones where empresa_p = empresa_e2l and producto_p = producto_e2l and cosechero_p = cosechero_e2l
                                             and plantacion_p = plantacion_e2l and ano_semana_p = ano_sem_planta_e2l ) des_plantacion,
       sum( total_kgs_e2l) kilos_e2l,
       nvl( ( select sum(kilos_es) from frf_entradas_sal where empresa_ec = empresa_es and centro_ec = centro_entrada_es
                              and fecha_ec = fecha_entrada_es and numero_entrada_ec = n_entrada_es and producto_es = producto_ec ), 0) kilos_total_es


from ( frf_entradas_c left join frf_entradas2_l on empresa_ec = empresa_e2l
                                         and centro_ec = centro_e2l
                                         and fecha_ec = fecha_e2l
                                         and numero_entrada_ec = numero_entrada_e2l
                                         and producto_e2l = 'I')

where empresa_ec = '080'
and centro_ec = '6'
and producto_ec = 'I'
and fecha_ec between '1/1/2013' and '31/1/2013'

group by empresa_ec, centro_ec,  numero_entrada_ec, fecha_ec, producto_ec, peso_neto_ec,
         cosechero_e2l, plantacion_e2l, ano_sem_planta_e2l, 8, 11

having sum( total_kgs_e2l) =
       nvl( ( select sum(kilos_es) from frf_entradas_sal where empresa_ec = empresa_es and centro_ec = centro_entrada_es
                              and fecha_ec = fecha_entrada_es and numero_entrada_ec = n_entrada_es and producto_es = 'I' ), 0)

order by empresa_ec, centro_ec,  numero_entrada_ec, fecha_ec

*)

end.
