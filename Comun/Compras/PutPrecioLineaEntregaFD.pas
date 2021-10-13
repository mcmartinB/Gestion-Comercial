unit PutPrecioLineaEntregaFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, nbLabels, BEdit;

type
  TFDPutPrecioLineaEntrega = class(TForm)
    cbbUnidad_precio_el: TComboBox;
    lblUnidadPrecio: TnbLabel;
    btnAceptar: TButton;
    btnCancelar: TButton;
    lblImporte: TnbLabel;
    btnSiguiente: TButton;
    lblEnvase: TLabel;
    lbl1: TnbLabel;
    edtKilos: TEdit;
    lbl2: TnbLabel;
    edtCajas: TEdit;
    lbl3: TnbLabel;
    edtUnidades: TEdit;
    lblCategoria: TLabel;
    lblCalibre: TLabel;
    edtPrecio: TBEdit;
    edtImporte: TBEdit;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtPrecioChange(Sender: TObject);
    procedure edtImporteChange(Sender: TObject);
    procedure cbbUnidad_precio_elChange(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSiguienteClick(Sender: TObject);
  private
    { Private declarations }
    rKilos, rCajas, rUnidades: Real;
    rPrecio, rImporte: Real;
    iUnidad: Integer;

    procedure PonPrecio;
    procedure PonImporte;

  public
    { Public declarations }
    bOk, bNext: Boolean;
    procedure PutDescripcion( const AVariedad, ACategoria, ACalibre: string; const AKilos, ACajas, AUnidades: Real );
    procedure PutCantidades( const AKilos, ACajas, AUnidades, APrecio: Real; const AUnidad: Integer );
    function  PutResult( var VPrecio: Real; var VUnidad: Integer; var VNext: Boolean  ): Boolean;
  end;

  function PutPrecioLineaEntregaExecute( const AVariedad, ACategoria, ACalibre: string; const AKilos, ACajas, AUnidades: Real; var VPrecio: Real; var VUnidad: Integer; var VNext: boolean ): Boolean;

implementation

{$R *.dfm}

uses
  bMath, UDMAuxDB;

var
  FDPutPrecioLineaEntrega: TFDPutPrecioLineaEntrega;

function PutPrecioLineaEntregaExecute( const AVariedad, ACategoria, ACalibre: string; const AKilos, ACajas, AUnidades: Real; var VPrecio: Real; var VUnidad: Integer; var VNext: boolean ): Boolean;
begin

  Application.CreateForm(TFDPutPrecioLineaEntrega, FDPutPrecioLineaEntrega );
  try
    FDPutPrecioLineaEntrega.PutDescripcion( AVariedad, ACategoria, ACalibre, AKilos, ACajas, AUnidades );
    FDPutPrecioLineaEntrega.PutCantidades( AKilos, ACajas, AUnidades, VPrecio, VUnidad );
    FDPutPrecioLineaEntrega.ShowModal;
    Result:= FDPutPrecioLineaEntrega.PutResult( VPrecio, VUnidad, VNext );
  finally
    FreeAndNil(FDPutPrecioLineaEntrega);
  end;
end;


procedure TFDPutPrecioLineaEntrega.PutDescripcion( const AVariedad, ACategoria, ACalibre: string; const AKilos, ACajas, AUnidades: Real );
begin
  edtKilos.Text:= FloatToStr( AKilos );
  edtCajas.Text:= FloatToStr( ACajas );
  edtUnidades.Text:= FloatToStr( AUnidades );
  lblEnvase.Caption:= AVariedad;
  lblCategoria.Caption:= 'Categoria: ' + ACategoria;
  lblCalibre.Caption:= 'Calibre: ' + ACalibre;
end;

function  TFDPutPrecioLineaEntrega.PutResult( var VPrecio: Real; var VUnidad: Integer; var VNext: Boolean ): Boolean;
begin
  Result:= bOk;
  if result then
  begin
    VPrecio:= rPrecio;
    VUnidad:= iUnidad;
    VNext:= bNext;
  end;
end;

procedure TFDPutPrecioLineaEntrega.PutCantidades( const AKilos, ACajas, AUnidades, APrecio: Real; const AUnidad: Integer );
begin
  rKilos:= AKilos;
  rCajas:= ACajas;
  rUnidades:= AUnidades;
  rPrecio:= APrecio;
  iUnidad:= AUnidad;

  edtPrecio.Text:= FloatToStr( rPrecio );
  cbbUnidad_precio_el.ItemIndex:= iUnidad;
  PonImporte;

  bOk:= False;
  bNext:= False;
end;


procedure TFDPutPrecioLineaEntrega.btnSiguienteClick(Sender: TObject);
begin
  if TryStrToFloat( edtPrecio.Text, double( rPrecio ) ) then
  begin
    (*TODO*)
    //validar rango de precios
    bNext:= True;
    bOk:= True;
    Close;
  end
  else
  begin
    ShowMessage('Por favor introduzca un precio correcto.');
  end;
end;

procedure TFDPutPrecioLineaEntrega.btnAceptarClick(Sender: TObject);
begin
  if TryStrToFloat( edtPrecio.Text, double( rPrecio ) ) then
  begin
    (*TODO*)
    //validar rango de precios
    bNext:= False;
    bOk:= True;
    Close;
  end
  else
  begin
    ShowMessage('Por favor introduzca un precio correcto.');
  end;
end;

procedure TFDPutPrecioLineaEntrega.btnCancelarClick(Sender: TObject);
begin
  bNext:= False;
  bOk:= False;
  Close;
end;

procedure TFDPutPrecioLineaEntrega.edtPrecioChange(Sender: TObject);
begin
  if edtPrecio.Focused then
  begin
    iUnidad:= cbbUnidad_precio_el.ItemIndex;
    rPrecio:= StrToFloatDef( edtPrecio.Text, 0 );
    PonImporte;
  end;
end;

procedure TFDPutPrecioLineaEntrega.PonImporte;
begin
  case iUnidad of
    0: //kilos
    begin
      rImporte:= bRoundTo( rKilos * rPrecio, 2 );
    end;
    1: //cajas
    begin
      rImporte:= bRoundTo( rCajas * rPrecio, 2 );
    end;
    2: //unidades
    begin
      rImporte:= bRoundTo( rUnidades * rPrecio, 2 );
    end;
  end;
  edtImporte.Text:= FloatToStr( rImporte );
end;

procedure TFDPutPrecioLineaEntrega.edtImporteChange(Sender: TObject);
begin
  if edtImporte.Focused then
  begin
    iUnidad:= cbbUnidad_precio_el.ItemIndex;
    rImporte:= StrToFloatDef( edtImporte.Text, 0 );
    PonPrecio;
  end;
end;

procedure TFDPutPrecioLineaEntrega.PonPrecio;
begin
  case iUnidad of
    0: //kilos
    begin
      if rKilos <> 0 then
        rPrecio:= bRoundTo( rImporte / rKilos, 5 )
      else
        rPrecio:= 0;
    end;
    1: //cajas
    begin
      if rCajas <> 0 then
        rPrecio:= bRoundTo( rImporte / rCajas, 5 )
      else
        rPrecio:= 0;
    end;
    2: //unidades
    begin
      if rUnidades <> 0 then
        rPrecio:= bRoundTo( rImporte / rUnidades, 5 )
      else
        rPrecio:= 0;
    end;
  end;
  edtPrecio.Text:= FloatToStr( rPrecio );
end;

procedure TFDPutPrecioLineaEntrega.cbbUnidad_precio_elChange(
  Sender: TObject);
begin
  iUnidad:= cbbUnidad_precio_el.ItemIndex;
  rPrecio:= StrToFloatDef( edtPrecio.Text, 0 );
  PonImporte;
end;

procedure TFDPutPrecioLineaEntrega.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if  Key = vk_escape then
  begin
    btnCancelar.Click;
    Key:= 0;
  end
  else
  if  Key = vk_F1 then
  begin
    btnAceptar.Click;
    Key:= 0;
  end
  else
  if  Key = vk_F3 then
  begin
    btnSiguiente.Click;
    Key:= 0;
  end;
end;

end.
