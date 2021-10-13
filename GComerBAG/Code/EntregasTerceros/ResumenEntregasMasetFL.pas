unit ResumenEntregasMasetFL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, ActnList, ComCtrls, Db,
  CGestionPrincipal, BEdit, BCalendarButton, BSpeedButton, BGridButton,
  BCalendario, BGrid,DError, QuickRpt, Grids, DBGrids;

type
  TFLResumenEntregasMaset = class(TForm)
    ListaAcciones: TActionList;
    BAceptar: TAction;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    ACancelar: TAction;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label2: TLabel;
    Label1: TLabel;
    btnEmpresa: TBGridButton;
    btnCentro: TBGridButton;
    btnProducto: TBGridButton;
    btnFechaDesde: TBCalendarButton;
    btnFechaHasta: TBCalendarButton;
    lblFecha: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    EProducto: TBEdit;
    ECentro: TBEdit;
    EEmpresa: TBEdit;
    STEmpresa: TStaticText;
    STCentro: TStaticText;
    STProducto: TStaticText;
    EFechaDesde: TBEdit;
    EFechaHasta: TBEdit;
    EProveedor: TBEdit;
    EAlmacen: TBEdit;
    Label7: TLabel;
    btnProveedor: TBGridButton;
    stProveedor: TStaticText;
    btnAlmacen: TBGridButton;
    stAlmacen: TStaticText;
    lblNombre1: TLabel;
    edtAnyoSemana: TBEdit;
    lblNombre2: TLabel;
    lblNombre3: TLabel;
    eSobrepeso: TBEdit;
    lblCentroLlegada: TLabel;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ACancelarExecute(Sender: TObject);
    procedure EEmpresaChange(Sender: TObject);
    procedure ECentroChange(Sender: TObject);
    procedure EProductoChange(Sender: TObject);
    procedure EProveedorChange(Sender: TObject);
    procedure EAlmacenChange(Sender: TObject);

  private

  public
    { Public declarations }
  end;

implementation

uses Principal, CVariables, CAuxiliarDB, UDMAuxDB, CReportes, bSQLUtils,
     ResumenEntregasMasetQL, DPreview, UDMBaseDatos, UDMConfig;

{$R *.DFM}

procedure TFLResumenEntregasMaset.BBAceptarClick(Sender: TObject);
var
  dIni, dFin: TDateTime;
begin
  if not CerrarForm(true) then Exit;

  //Comprobamos datos obligatorios
  if EEmpresa.Text = '' then
  begin
    ShowError('Falta el código de la empresa.');
    EEmpresa.SetFocus;
    Exit;
  end;

  if EFechaDesde.Text = '' then
  begin
    ShowMessage('Falta fecha de inicio.');
    EFechaDesde.SetFocus;
    Exit;
  end
  else
  if not TryStrToDate( EFechaDesde.Text, dIni ) then
  begin
    ShowMessage('Fecha de inicio incorrecta.');
    EFechaDesde.SetFocus;
    Exit;
  end;
  if EFechaHasta.Text = '' then
  begin
    ShowMessage('Falta fecha de fin.');
    EFechaHasta.SetFocus;
    Exit;
  end
  else
  if not TryStrToDate( EFechaHasta.Text, dFin ) then
  begin
    ShowMessage('Fecha de fin incorrecta.');
    EFechaHasta.SetFocus;
    Exit;
  end;
  if dFin < dIni then
  begin
    ShowMessage('Rango de fechas incorrecto.');
    EFechaDesde.SetFocus;
    Exit;
  end;

  //Datos optativos
  if ( ECentro.Text <> '' ) then
  begin
    if STCentro.Caption = '' then
    begin
      ShowError('El codigo del centro de entrega es incorrecto.');
      ECentro.SetFocus;
      Exit;
    end;
  end;

  if ( EProducto.Text <> '' ) then
  begin
    if STProducto.Caption = '' then
    begin
      ShowError('El codigo del producto es incorrecto.');
      EProducto.SetFocus;
      Exit;
    end;
  end;

  if ( EProveedor.Text <> '' ) then
  begin
    if stProveedor.Caption = '' then
    begin
      ShowError('El codigo del productor es incorrecto.');
      EProveedor.SetFocus;
      Exit;
    end;
  end;

  if ( EAlmacen.Text <> '' ) then
  begin
    if stAlmacen.Caption = '' then
    begin
      ShowError('El codigo del almacén es incorrecto.');
      EAlmacen.SetFocus;
      Exit;
    end;
  end;

  if ( edtAnyoSemana.Text <> '' ) then
  begin
    if Length( edtAnyoSemana.Text ) < 6 then
    begin
      ShowError('El año/semana debe tener como minimo 6 caracteres.');
      edtAnyoSemana.SetFocus;
      Exit;
    end;
  end;

  QLResumenEntregasMaset:= TQLResumenEntregasMaset.Create(Application);
  try
    PonLogoGrupoBonnysa(QLResumenEntregasMaset,EEmpresa.Text);
    with QLResumenEntregasMaset.QListado do
    begin
      SQL.Clear;

      SQL.Add('  select empresa_ec, proveedor_ec, ');
      SQL.Add('         (select nombre_p ');
      SQL.Add('           from frf_proveedores ');
      SQL.Add('         where 1 = 1 ');
      if EProveedor.Text <> '' then
        SQL.Add('           and proveedor_p = :proveedor) desProveedor, ')
      else
        SQL.Add('           and proveedor_p = proveedor_ec) desProveedor, ');
      SQL.Add('         almacen_el, ');
      SQL.Add('         codigo_ec, vehiculo_ec, albaran_ec, ');
      SQL.Add('         sum(palets_el) palets_el, ');
      SQL.Add('         sum(cajas_el) cajas_el, ');
      SQL.Add('         sum(kilos_el) kilos_albaran_el, ');
      SQL.Add('         ( select sum(nvl(peso,0)) from rf_palet_pb where entrega = codigo_ec ) kilos_destarados_el, ');
      SQL.Add('         sum(aprovechados_el) kilos_aprovechados_el ');

      SQL.Add(' from frf_entregas_c, frf_entregas_l ');
      SQL.Add(' where empresa_ec = :empresa ');
      SQL.Add(' and fecha_llegada_ec between :fechaini and :fechafin ');
      if ECentro.Text <> '' then
      begin
        SQL.Add(' and centro_llegada_ec = :centro ');
      end;
      if EProveedor.Text <> '' then
        SQL.Add(' and TRIM(proveedor_ec) = :proveedor ');
      if EAlmacen.Text <> '' then
        SQL.Add(' and almacen_el = :almacen ');
      SQL.Add(' and codigo_ec = codigo_el ');
      if edtAnyoSemana.Text <> '' then
        SQL.Add(' and anyo_semana_ec = :semana ');
      if EProducto.Text <> '' then
        SQL.Add(' and producto_el = :producto ');
      SQL.Add(' group by empresa_ec, proveedor_ec, almacen_el, codigo_ec, vehiculo_ec, albaran_ec ');
      SQL.Add(' order by empresa_ec, proveedor_ec, almacen_el, codigo_ec ');


      ParamByName('empresa').AsString:= EEmpresa.Text;
      ParamByName('fechaini').AsDateTime:= dIni;
      ParamByName('fechafin').AsDateTime:= dFin;

      if edtAnyoSemana.Text <> '' then
        ParamByName('semana').AsInteger:= StrToInt( edtAnyoSemana.Text );
      if ECentro.Text <> '' then
        ParamByName('centro').AsString:= ECentro.Text;
      if EProveedor.Text <> '' then
        ParamByName('proveedor').AsString:= EProveedor.Text;
      if EAlmacen.Text <> '' then
        ParamByName('almacen').AsString:= EAlmacen.Text;
      if EProducto.Text <> '' then
        ParamByName('producto').AsString:= eProducto.Text;

      Open;
      if IsEmpty then
      begin
        Close;
        FreeAndNil(QLResumenEntregasMaset);
        ShowMessage('No hay entradas que cumplan los parametros especificados.');
        Exit;
      end;
    end;

    with QLResumenEntregasMaset do
    begin
      //Coloco la fecha del rango en el informe
      QRLDesde.Caption:=EFechaDesde.Text + ' - ';
      QRLHasta.Caption:=EFechaHasta.Text;

      if EProducto.Text = '' then
        psProducto.Caption:= 'TODOS LOS PRODUCTOS'
      else
        psProducto.Caption:=EProducto.Text + '  ' + StProducto.Caption;

      if ECentro.Text = '' then
        psCentro.Caption:= 'TODOS LOS CENTROS'
      else
        psCentro.Caption:=ECentro.Text + '  ' + StCentro.Caption;

      if edtAnyoSemana.Text = '' then
        psSemana.Caption:= ''
      else
        psSemana.Caption:= 'SEMANA ' + edtAnyoSemana.Text;

      rSobrepeso:= StrToFloatDef( eSobrepeso.Text, 0 );

    end;

      Preview(QLResumenEntregasMaset);
    except
      FreeAndNil( QLResumenEntregasMaset );
    end;
end;

procedure TFLResumenEntregasMaset.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  CloseAuxQuerys;
     gRF:=nil;
     gCF:=nil;
     if FPrincipal.MDIChildCount = 1 then
     begin
        FormType:=tfDirector;
        BHFormulario;
     end;
     BEMensajes('');
     Action:=caFree;
end;

procedure TFLResumenEntregasMaset.FormCreate(Sender: TObject);
begin
     FormType:=tfOther;
     BHFormulario;

     EEmpresa.Tag:=kEmpresa;
     ECentro.Tag:=kCentro;
     EProducto.Tag:=kProducto;
     EProveedor.Tag:=kProveedor;
     EAlmacen.Tag:=kProveedorAlmacen;
     EFechaDesde.Tag:=kCalendar;
     EFechaHasta.Tag:=kCalendar;
     gRF :=rejillaFlotante;
     RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
     gCF:=calendarioFlotante;

     EEmpresa.Text:= gsDefEmpresa;
     CalendarioFlotante.Date:= Date;
     EFechaDesde.Text:= DateToStr( Date );
     EFechaHasta.Text:= EFechaDesde.Text;
     EProveedor.Text:='';
     EAlmacen.Text:= '';
end;

procedure TFLResumenEntregasMaset.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    case key of
         $0D,$28: //vk_return,vk_down
         begin
              Key := 0;
              PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
              Exit;
         end;
         $26:  //vk_up
         begin
              Key := 0;
              PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
              Exit;
         end;
    end;
end;

procedure TFLResumenEntregasMaset.ADesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa:DespliegaRejilla(btnEmpresa);
    kProducto:DespliegaRejilla(btnProducto,[EEmpresa.Text]);
    kCentro:DespliegaRejilla(btnCentro,[EEmpresa.Text]);
    kProveedor:DespliegaRejilla(btnProveedor,[EEmpresa.Text]);
    kProveedorAlmacen:DespliegaRejilla(btnAlmacen,[EEmpresa.Text,EProveedor.Text]);
    kCalendar:
    begin
      if EFechaDesde.Focused then
        DespliegaCalendario(btnFechaDesde)
      else
        DespliegaCalendario(btnFechaHasta);
    end;
  end;
end;

procedure TFLResumenEntregasMaset.FormActivate(Sender: TObject);
begin
  Top:=1;
  ActiveControl:=EEmpresa;
end;

procedure TFLResumenEntregasMaset.ACancelarExecute(Sender: TObject);
begin
   if CerrarForm(false) then Close;
end;

procedure TFLResumenEntregasMaset.EEmpresaChange(Sender: TObject);
begin
  STEmpresa.Caption:=desEmpresa(Eempresa.Text);
  ECentroChange( ECentro );
  EProductoChange( EProducto );
  EProveedorChange( EProveedor );
  EAlmacenChange( EAlmacen );
end;

procedure TFLResumenEntregasMaset.ECentroChange(Sender: TObject);
begin
  STCentro.Caption:=desCentro(Eempresa.Text,Ecentro.Text);
  if ( STCentro.Caption = '' ) and ( ECentro.Text = '' ) then
  begin
    STCentro.Caption:= 'Vacio muestra todos los centros de entrega.'
  end;
end;

procedure TFLResumenEntregasMaset.EProductoChange(Sender: TObject);
begin
  STProducto.Caption:=desProducto(Eempresa.Text,Eproducto.Text);
  if ( STProducto.Caption = '' ) and ( EProducto.Text = '' ) then
  begin
    STProducto.Caption:= 'Vacio muestra todos los productos.'
  end;
end;

procedure TFLResumenEntregasMaset.EProveedorChange(Sender: TObject);
begin
  stProveedor.Caption:= desProveedor(EEmpresa.Text, EProveedor.Text);
  if ( stProveedor.Caption = '' ) and ( EProveedor.Text = '' ) then
  begin
    stProveedor.Caption:= 'Vacio muestra todos los OPP/proveedores.'
  end;
  EAlmacenChange( EAlmacen );
end;

procedure TFLResumenEntregasMaset.EAlmacenChange(Sender: TObject);
begin
  stAlmacen.Caption:= desProveedorAlmacen(EEmpresa.Text, EProveedor.Text, EAlmacen.Text);
  if ( stAlmacen.Caption = '' ) and ( EAlmacen.Text = '' ) then
  begin
    stAlmacen.Caption:= 'Vacio muestra todos los almacenes.'
  end;
end;

end.
