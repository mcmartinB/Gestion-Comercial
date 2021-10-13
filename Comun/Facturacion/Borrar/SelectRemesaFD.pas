unit SelectRemesaFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BCalendarButton, nbLabels, Buttons, BSpeedButton, BGridButton,
  StdCtrls, BEdit, BDEdit, Grids, DBGrids, BGrid, ComCtrls, BCalendario,
  DB, DBTables;

type
  TFDSelectRemesa = class(TForm)
    CalendarioFlotante: TBCalendario;
    RejillaFlotante: TBGrid;
    LEmpresa_p: TLabel;
    edtempresa: TBEdit;
    btnempresa: TBGridButton;
    lblEmpresa: TnbStaticText;
    Label1: TLabel;
    edtreferencia: TBEdit;
    LFecha_inicio_p: TLabel;
    edtfecha: TBEdit;
    btnfecha: TBCalendarButton;
    lblBanco: TnbStaticText;
    btnbanco: TBGridButton;
    edtbanco: TBEdit;
    Label2: TLabel;
    LPlantacion_p: TLabel;
    edtmoneda: TBEdit;
    btnmoneda: TBGridButton;
    lblMoneda: TnbStaticText;
    etqCliente: TLabel;
    edtclliente: TBEdit;
    btncliente: TBGridButton;
    lblCliente: TnbStaticText;
    qryRemesaCab: TQuery;
    qryRemesaLin: TQuery;
    dsRemesaCab: TDataSource;
    dsRemesaLin: TDataSource;
    dbgrdRemesaCab: TDBGrid;
    dbgrdRemesaLin: TDBGrid;
    btnFiltro: TButton;
    procedure FormCreate(Sender: TObject);
    procedure PonNombre(Sender: TObject);
    procedure PutBoton(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;



implementation

{$R *.dfm}

uses
   CVariables, UDMAuxDB, CAuxiliarDB;

var
  FDSelectRemesa: TFDSelectRemesa;

procedure TFDSelectRemesa.FormCreate(Sender: TObject);
begin
  edtempresa.Tag := kEmpresa; //Para mostrar rejilla flotante
  edtclliente.Tag := kcliente; //Para mostrar rejilla flotante
  edtbanco.Tag := kBanco; //Para poner nombre rejilla
  edtmoneda.Tag := kMoneda;
  edtfecha.Tag := kCalendar; //Para mostrar el calendario

(*SAT

select empresa_r, referencia_r, fecha_r, banco_r, moneda_cobro_r, 
       importe_cobro_r facturado, otros_r, importe_cobro_r + otros_r acobrar, 
       sum( importe_cobrado_fr ) remesado, 
       ( importe_cobro_r + otros_r ) - sum( importe_cobrado_fr ) diff,
       gastos_euros_r, otros_euros_r, bruto_euros_r, liquido_euros_r

    
from frf_remesas
     left join frf_facturas_remesa on empresa_remesa_fr = empresa_r
               and fecha_remesa_fr = fecha_r and remesa_fr = referencia_r          

where empresa_r = '050'
--and referencia_r = 1
--and fecha_r = '7/2/2001'
--and banco_r = '051'
--and moneda_cobro_r = 'NOK'

--and exists
--(
--  select * from frf_facturas
--  where empresa_f = empresa_fr and fecha_factura_f = fecha_factura_fr 
--    and n_factura_f = factura_fr and cliente_fac_f = 'NG'
--)

and otros_r <> 0

group by empresa_r, referencia_r, fecha_r, banco_r, moneda_cobro_r, 
       importe_cobro_r, bruto_euros_r, liquido_euros_r,
       gastos_euros_r, otros_r, otros_euros_r

having ( importe_cobro_r + otros_r ) - sum( importe_cobrado_fr ) = 0

order by fecha_r desc

*)


end;

procedure TFDSelectRemesa.PonNombre(Sender: TObject);
begin
  if TBEdit( Sender ).Tag = kEmpresa then
  begin
    lblEmpresa.Caption:= desEmpresa( edtempresa.Text );
    lblBanco.Caption:= desBanco( edtbanco.Text );
    lblCliente.Caption:= desCliente( edtempresa.Text, edtclliente.Text );
  end
  else
  if TBEdit( Sender ).Tag = kBanco then
  begin
    lblBanco.Caption:= desBanco( edtbanco.Text );
  end
  else
  if TBEdit( Sender ).Tag = kCliente then
  begin
    lblCliente.Caption:= desCliente( edtempresa.Text, edtclliente.Text );
  end
  else
  if TBEdit( Sender ).Tag = kMoneda then
  begin
    lblMoneda.Caption:= desMoneda( edtmoneda.Text );
  end;

end;

procedure TFDSelectRemesa.PutBoton(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnempresa);
    kCliente: DespliegaRejilla(btncliente, [edtempresa.text]);
    kBanco: DespliegaRejilla(btnbanco, [edtempresa.text]);
    kMoneda: DespliegaRejilla(btnmoneda);
    kCalendar: DespliegaCalendario(btnfecha);
  end;
end;

end.
