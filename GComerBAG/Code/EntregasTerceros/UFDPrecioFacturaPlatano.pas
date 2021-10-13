unit UFDPrecioFacturaPlatano;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, BEdit;

type
  TFDPrecioFacturaPlatano = class(TForm)
    chkSinPrecio: TRadioButton;
    chkTodas: TRadioButton;
    lblPrecio: TLabel;
    edtPrecio: TBEdit;
    btnAceptar: TButton;
    btnCancelar: TButton;
    lblSemana: TLabel;
    edtSemana: TBEdit;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtSemanaChange(Sender: TObject);
  private
    { Private declarations }

    function GetPrecioSemana( const AEmpresa, ASemana: string ): real;
  public
    { Public declarations }
  end;

procedure PrecioFacturaPlatano( const AOwner: TComponent; const AEmpresa, ASemana: string );

implementation

uses UDMAuxDB, DBTables;

{$R *.dfm}

var
  FDPrecioFacturaPlatano: TFDPrecioFacturaPlatano;

procedure PrecioFacturaPlatano( const AOwner: TComponent; const AEmpresa, ASemana: string );
begin
  FDPrecioFacturaPlatano:= TFDPrecioFacturaPlatano.Create( AOwner );
  FDPrecioFacturaPlatano.edtSemana.Text:= ASemana;
  try
    FDPrecioFacturaPlatano.ShowModal;
  finally
    FreeAndNil( FDPrecioFacturaPlatano );
  end;
end;

function TFDPrecioFacturaPlatano.GetPrecioSemana( const AEmpresa, ASemana: string ): real;
begin
  result:= 0;
  //Sacar el precio de la semana
  with DMAuxDB.QAux do
  begin
    Sql.Clear;
    SQl.Add( 'select precio_fpc , count(*) ');
    SQl.Add( 'from frf_facturas_platano_c ');
    SQl.Add( 'where empresa_fpc = :empresa ');
    SQl.Add( 'and anyo_semana_fpc = :anyosemana ');
    SQl.Add( 'and precio_fpc <> 0 ');
    SQl.Add( 'group by precio_fpc ');
    SQl.Add( 'order by 2 desc ');
    ParamByName('empresa').AsString := AEmpresa;
    ParamByName('anyosemana').AsString := ASemana;
    Open;
    if not IsEmpty then
    begin
      result:= FieldByName('precio_fpc').AsFloat;
    end;
    Close;
  end;
end;

procedure TFDPrecioFacturaPlatano.btnAceptarClick(Sender: TObject);
begin
  if Length(edtSemana.Text) < 6 then
  begin
    ShowMessage('El Año/Semana debe ser de 6 digitos');
    Exit;
  end;
  if chkSinPrecio.Checked then
  begin
    with DMAuxDB.QAux do
    begin
      Sql.Clear;
      SQl.Add( 'update frf_facturas_platano_c ');
      SQl.Add( 'set precio_fpc = :precio ');
      SQl.Add( 'where empresa_fpc = :empresa ');
      SQl.Add( 'and anyo_semana_fpc = :anyosemana ');
      SQl.Add( 'and nvl(precio_fpc,0) = 0 ');
      ParamByName('empresa').AsString := 'BAG';
      ParamByName('anyosemana').AsString := edtSemana.Text;
      ParamByName('precio').AsFloat:= StrToFloatDef( edtPrecio.Text, 0);
      ExecSQL;
    end;
  end
  else
  begin
    with DMAuxDB.QAux do
    begin
      Sql.Clear;
      SQl.Add( 'update frf_facturas_platano_c ');
      SQl.Add( 'set precio_fpc = :precio ');
      SQl.Add( 'where empresa_fpc = :empresa ');
      SQl.Add( 'and anyo_semana_fpc = :anyosemana ');
      ParamByName('empresa').AsString := 'BAG';
      ParamByName('anyosemana').AsString := edtSemana.Text;
      ParamByName('precio').AsFloat:= StrToFloatDef( edtPrecio.Text, 0);
      ExecSQL;
    end;
  end;
  ShowMEssage('Proceso finalizado. Se han modificado ' + IntToStr( DMAuxDB.QAux.RowsAffected ) + ' registros.');
  Close;
end;

procedure TFDPrecioFacturaPlatano.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFDPrecioFacturaPlatano.edtSemanaChange(Sender: TObject);
var
  rAux: real;
begin
  rAux:= GetPrecioSemana( 'BAG', edtSemana.Text );
  if rAux <> 0 then
    edtPrecio.Text:= FloatToStr( rAux );
end;

end.
