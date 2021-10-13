unit CosteKgEnvasadoMensual;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, DB, Grids, DBGrids, nbEdits,
  nbCombos;

type
  TFCosteKgEnvasadoMensual = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    empresa: TBEdit;
    nbLabel1: TnbLabel;
    des_empresa: TnbStaticText;
    nbLabel4: TnbLabel;
    des_centro: TnbStaticText;
    nbLabel2: TnbLabel;
    nbLabel3: TnbLabel;
    fechaIni: TnbDBCalendarCombo;
    fechaFin: TnbDBCalendarCombo;
    nbLabel5: TnbLabel;
    producto: TBEdit;
    des_producto: TnbStaticText;
    centro: TBEdit;
    chkPromedios: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure empresaChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure centroChange(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure productoChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses UDMAuxDB, Principal, CGestionPrincipal, CVariables, bTimeUtils,
  CostesDeEnvasadoResumenReport, UDMBaseDatos, bSQLUtils, CGlobal;

procedure TFCosteKgEnvasadoMensual.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  BEMensajes('');
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;
end;

procedure TFCosteKgEnvasadoMensual.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFCosteKgEnvasadoMensual.empresaChange(Sender: TObject);
begin
  des_empresa.Caption := desEmpresa(empresa.Text);
  productoChange(producto);
  centroChange(centro);
end;

procedure TFCosteKgEnvasadoMensual.FormKeyDown(Sender: TObject; var Key: Word;
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


procedure TFCosteKgEnvasadoMensual.FormCreate(Sender: TObject);
var
  year, month, day: word;
begin
  FormType := tfOther;
  BHFormulario;

  {des_empresa.Caption:= desEmpresa( empresa.Text );
  des_centro.Caption:= desCentro( empresa.Text, centro.Text );
  des_producto.Caption:= desProducto( empresa.Text, producto.Text );}


  centro.Text := gsDefCentro;
  producto.Text := '';
  empresa.Text := gsDefEmpresa;
  empresaChange(empresa);
  
  DecodeDate(Date, year, month, day);
  if month = 1 then
  begin
    year := year - 1;
    month := 12;
  end
  else
  begin
    Dec(month);
  end;
  fechaini.AsDate := Date - 7;
  fechafin.AsDate := Date;

  chkPromedios.Visible:= ( gProgramVersion = pvSAT );
end;

procedure TFCosteKgEnvasadoMensual.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFCosteKgEnvasadoMensual.centroChange(Sender: TObject);
begin
  des_centro.Caption := desCentro(empresa.Text, centro.Text);
end;

procedure TFCosteKgEnvasadoMensual.btnAceptarClick(Sender: TObject);
var
  dIni, dFin: TDateTime;
begin
  if des_empresa.Caption = '' then
  begin
    empresa.SetFocus;
    ShowMessage('Falta código de la empresa o es incorrecto');
  end
  else
  if des_centro.Caption = '' then
  begin
    centro.SetFocus;
    ShowMessage('Falta código del centro o es incorrecto');
  end
  else
  if des_producto.Caption = '' then
  begin
    producto.SetFocus;
    ShowMessage('Falta código del producto o es incorrecto');
  end
  else
  if not TryStrToDate( fechaIni.Text, dIni ) then
  begin
    fechaIni.SetFocus;
    ShowMessage('Falta fecha de inicio o es incorrecta');
  end
  else
  if not TryStrToDate( fechaFin.Text, dFin ) then
  begin
    fechaFin.SetFocus;
    ShowMessage('Falta fecha de fin o es incorrecta');
  end
  else
  if dIni > dFin then
  begin
    fechaIni.SetFocus;
    ShowMessage('Rango de fechas incorrecto');
  end
  else
  begin
    QRCostesDeEnvasadoResumenPrint(Empresa.Text, Centro.Text, Producto.Text, FechaIni.AsDate, FechaFin.AsDate, chkPromedios.Checked )
  end;
(*
select empresa_ec empresa, centro_ec centro, 
       producto_base_ec producto, ( select descripcion_pb from frf_productos_base where empresa_ec = empresa_pb and producto_base_ec = producto_base_pb ) des_producto,
       ( material_ec + coste_ec ) coste_ec, ( select descripcion_e from frf_envases where empresa_ec = empresa_e and envase_ec = envase_e
                                                            and producto_base_ec = nvl(producto_base_e, producto_base_ec) ) des_envase,
       
       sum( case when nvl(secciones_ec,0) <> 0 then 1 else 0 end ) n_secciones,
       sum( case when ( anyo_ec *100+ mes_ec) = 201102 then material_ec + coste_ec else 0 end ) envasado_01,
       sum( case when ( anyo_ec *100+ mes_ec) = 201103 then material_ec + coste_ec else 0 end ) envasado_02,
       sum( case when ( anyo_ec *100+ mes_ec) = 201104 then material_ec + coste_ec else 0 end ) envasado_03,
       sum( case when ( anyo_ec *100+ mes_ec) = 201105 then material_ec + coste_ec else 0 end ) envasado_04,
       sum( case when ( anyo_ec *100+ mes_ec) = 201106 then material_ec + coste_ec else 0 end ) envasado_04,
       sum( case when ( anyo_ec *100+ mes_ec) = 201107 then material_ec + coste_ec else 0 end ) envasado_06,
       sum( case when ( anyo_ec *100+ mes_ec) = 201108 then material_ec + coste_ec else 0 end ) envasado_07,
       sum( case when ( anyo_ec *100+ mes_ec) = 201109 then material_ec + coste_ec else 0 end ) envasado_08,
       sum( case when ( anyo_ec *100+ mes_ec) = 201110 then material_ec + coste_ec else 0 end ) envasado_09,
       sum( case when ( anyo_ec *100+ mes_ec) = 201111 then material_ec + coste_ec else 0 end ) envasado_10,
       sum( case when ( anyo_ec *100+ mes_ec) = 201112 then material_ec + coste_ec else 0 end ) envasado_11,
       sum( case when ( anyo_ec *100+ mes_ec) = 201201 then material_ec + coste_ec else 0 end ) envasado_12,
       sum( nvl(material_ec + coste_ec,0) ) coste_envasado,
       sum( case when nvl(material_ec + coste_ec,0) <> 0 then 1 else 0 end ) n_envasado,

       sum( case when ( anyo_ec *100+ mes_ec) = 201102 then secciones_ec else 0 end ) seccion_01,
       sum( case when ( anyo_ec *100+ mes_ec) = 201103 then secciones_ec else 0 end ) seccion_02,
       sum( case when ( anyo_ec *100+ mes_ec) = 201104 then secciones_ec else 0 end ) seccion_03,
       sum( case when ( anyo_ec *100+ mes_ec) = 201105 then secciones_ec else 0 end ) seccion_04,
       sum( case when ( anyo_ec *100+ mes_ec) = 201106 then secciones_ec else 0 end ) seccion_05,
       sum( case when ( anyo_ec *100+ mes_ec) = 201107 then secciones_ec else 0 end ) seccion_06,
       sum( case when ( anyo_ec *100+ mes_ec) = 201108 then secciones_ec else 0 end ) seccion_07,
       sum( case when ( anyo_ec *100+ mes_ec) = 201109 then secciones_ec else 0 end ) seccion_08,
       sum( case when ( anyo_ec *100+ mes_ec) = 201110 then secciones_ec else 0 end ) seccion_09,
       sum( case when ( anyo_ec *100+ mes_ec) = 201111 then secciones_ec else 0 end ) seccion_10,
       sum( case when ( anyo_ec *100+ mes_ec) = 201112 then secciones_ec else 0 end ) seccion_11,
       sum( case when ( anyo_ec *100+ mes_ec) = 201201 then secciones_ec else 0 end ) seccion_12,
       sum( nvl(secciones_ec,0) ) coste_seccion,
       sum( case when nvl(secciones_ec,0) <> 0 then 1 else 0 end ) n_seccion

from frf_env_costes
where empresa_ec = '050'
and centro_ec = 6
and ( anyo_ec *100+ mes_ec) >= 201102 and  ( anyo_ec *100+ mes_ec) <= 201201
--and envase_ec = '042'
group by empresa_ec, centro_ec, producto_base_ec, envase_ec 
order by empresa_ec, centro_ec, producto_base_ec, envase_ec
*)
end;

procedure TFCosteKgEnvasadoMensual.productoChange(Sender: TObject);
begin
  if producto.Text = '' then
    des_producto.Caption := 'VACIO TODOS LOS PRODUCTOS'
  else
    des_producto.Caption := desproducto(empresa.Text, producto.Text);
end;

end.
