unit ParamConsultaTransitosFC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, BEdit, Buttons, BSpeedButton, BGridButton, ExtCtrls,
  Grids, DBGrids, BGrid;

type
  TFCParamConsultaTransitos = class(TForm)
    PMaestro: TPanel;
    CentroOrigen_: TLabel;
    Label1: TLabel;
    BGBEmpresa_tl: TBGridButton;
    Producto_: TLabel;
    BGBCentroOrigen: TBGridButton;
    BGBProducto_tl: TBGridButton;
    CentroDestino_: TLabel;
    BGBCentroDestino: TBGridButton;
    Label4: TLabel;
    Label5: TLabel;
    STEmpresa: TStaticText;
    STCentroOrigen: TStaticText;
    STProducto: TStaticText;
    eEmpresa: TBEdit;
    eCentroOrigen: TBEdit;
    eProducto: TBEdit;
    eCentroDestino: TBEdit;
    STCentroDestino: TStaticText;
    Label3: TLabel;
    eCentroSalida: TBEdit;
    BGBCentroSalida: TBGridButton;
    STCentroSalida: TStaticText;
    Label6: TLabel;
    Label7: TLabel;
    SBAceptar: TSpeedButton;
    SBCancelar: TSpeedButton;
    eFechaDesde: TBEdit;
    eFechaHasta: TBEdit;
    FechaDesde_: TLabel;
    FechaHasta_: TLabel;
    RejillaFlotante: TBGrid;
    procedure SBAceptarClick(Sender: TObject);
    procedure SBCancelarClick(Sender: TObject);
    procedure BtnClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure eEmpresaChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function CamposVacios: boolean;
  public
    { Public declarations }
    Resultado: boolean;
  end;

  function Ejecutar( const AOwner: TComponent;
                     var AEmpresa, ACSalida, ACOrigen, ACDestino, AProducto: string;
                     var AFIni, AFFin: TDateTime ): boolean;

implementation

{$R *.dfm}

uses CVariables, UDMAuxDB, DError, CAuxiliarDB, DBTables, UDMBaseDatos;

function GetFechaInicio( const AEmpresa, ACentro, AProducto: string ): TDate;
var
  iAnyo, iMes, iDia: Word;
begin
  begin
    DecodeDate( Date, iAnyo, iMes, iDia );
    result:= EncodeDate( iAnyo, 7, 1 );
    if result >= Date then
    begin
      result:= EncodeDate( iAnyo - 1, 7, 1 );
    end;
  end;

  iDia:= Trunc( Date - result );
  if  idia < 90 then
  begin
    result:=  Date - 90;
  end;
end;


function Ejecutar( const AOwner: TComponent;
                   var AEmpresa, ACSalida, ACOrigen, ACDestino, AProducto: string;
                   var AFIni, AFFin: TDateTime ): boolean;
var
  FCParamConsultaTransitos: TFCParamConsultaTransitos;
begin
  FCParamConsultaTransitos:= TFCParamConsultaTransitos.Create( AOwner );
  try
    FCParamConsultaTransitos.eEmpresa.Tag := kEmpresa;
    FCParamConsultaTransitos.eCentroSalida.Tag := kCentro;
    FCParamConsultaTransitos.eCentroOrigen.Tag := kCentro;
    FCParamConsultaTransitos.eCentroDestino.Tag := kCentro;
    FCParamConsultaTransitos.eProducto.Tag := kProducto;
    FCParamConsultaTransitos.eFechaDesde.Tag := kCalendar;
    FCParamConsultaTransitos.eFechaHasta.Tag := kCalendar;

    FCParamConsultaTransitos.eEmpresa.Text := AEmpresa;
    FCParamConsultaTransitos.eCentroSalida.Text := ACSalida;
    FCParamConsultaTransitos.eCentroOrigen.Text := ACOrigen;
    FCParamConsultaTransitos.eCentroDestino.Text := ACDestino;
    FCParamConsultaTransitos.eProducto.Text := AProducto;
    FCParamConsultaTransitos.eFechaDesde.Text := DateToStr( AFIni );
    FCParamConsultaTransitos.eFechaHasta.Text := DateToStr( AFFin );

    //Poner descripciones en el Textos Estaticos
    FCParamConsultaTransitos.STEmpresa.Caption :=
      desEmpresa(FCParamConsultaTransitos.eEmpresa.Text);
    FCParamConsultaTransitos.STCentroSalida.Caption :=
      desCentro(FCParamConsultaTransitos.eEmpresa.Text, FCParamConsultaTransitos.eCentroSalida.Text);
    FCParamConsultaTransitos.STCentroOrigen.Caption :=
      desCentro(FCParamConsultaTransitos.eEmpresa.Text, FCParamConsultaTransitos.eCentroOrigen.Text);
    FCParamConsultaTransitos.STCentroDestino.Caption :=
      desCentro(FCParamConsultaTransitos.eEmpresa.Text, FCParamConsultaTransitos.eCentroDestino.Text);
    FCParamConsultaTransitos.STProducto.Caption :=
      desProducto(FCParamConsultaTransitos.eEmpresa.Text, FCParamConsultaTransitos.eProducto.Text);

    FCParamConsultaTransitos.ShowModal;
    result:= FCParamConsultaTransitos.Resultado;
    if result then
    begin
      AEmpresa:= FCParamConsultaTransitos.eEmpresa.Text;
      ACSalida:= FCParamConsultaTransitos.eCentroSalida.Text;
      ACOrigen:= FCParamConsultaTransitos.eCentroOrigen.Text;
      ACDestino:= FCParamConsultaTransitos.eCentroDestino.Text;
      AProducto:= FCParamConsultaTransitos.eProducto.Text;
      AFIni:= StrToDate( FCParamConsultaTransitos.eFechaDesde.Text );
      AFFin:= StrToDate( FCParamConsultaTransitos.eFechaHasta.Text );
    end;
  finally
    FreeAndNil( FCParamConsultaTransitos );
  end;
end;

function TFCParamConsultaTransitos.CamposVacios: boolean;
var
  dIni, dFin: TDateTime;
begin
  Result := True;
  //no puede haber ningun campo vacio para localizar
  if eEmpresa.Text = '' then
  begin
    ShowError('Debe rellenar el código la empresa para realizar la busqueda');
    eEmpresa.SetFocus;
  end
  else
  if not TryStrToDate( eFechaDesde.Text, dIni ) then
  begin
    ShowError('Fecha de inicio incorrecta.');
    eFechaDesde.SetFocus;
  end
  else
  if not TryStrToDate( eFechaHasta.Text, dFin ) then
  begin
    ShowError('Fecha de fin incorrecta.');
    eFechaHasta.SetFocus;
  end
  else
  if dFin < dIni then
  begin
    ShowError('Rango de fechas incorrecto.');
    eFechaDesde.SetFocus;
  end
  else
  if ( dFin - dIni ) > 365 then
  begin
    ShowError('Rango maximo de un año.');
    eFechaDesde.SetFocus;
  end
  else
  begin
    if dIni < StrToDate('1/7/2001') then
    begin
      eFechaDesde.Text := '01/07/2001';
    end;
    Result := False;
  end;
end;

procedure TFCParamConsultaTransitos.SBAceptarClick(Sender: TObject);
begin
  if CamposVacios then Exit;
  Resultado:= True;
  Close;
end;

procedure TFCParamConsultaTransitos.SBCancelarClick(Sender: TObject);
begin
  if RejillaFlotante.Visible then
  begin
    RejillaFlotante.Hide;
    Exit;
  end;
  Close;
end;

procedure TFCParamConsultaTransitos.BtnClick(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa_tl);
    kCentro:
      if eCentroOrigen.Focused then
        DespliegaRejilla(BGBCentroOrigen, [eEmpresa.Text])
      else
      if eCentroSalida.Focused then
        DespliegaRejilla(BGBCentroSalida, [eEmpresa.Text])
      else
        DespliegaRejilla(BGBCentroDestino, [eEmpresa.Text]);
    kProducto: DespliegaRejilla(BGBProducto_tl, [eEmpresa.Text])
  end;
end;

procedure TFCParamConsultaTransitos.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
{*}//Si la rejilla esta desplegada no hacemos nada
   if (RejillaFlotante.Visible) then
   begin
      if Key = vk_Escape then
      begin
        RejillaFlotante.Visible := False;
        Exit;
      end;
   end;
           //No hacemos nada


    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    // y entre los Campos de Búsqueda en la localización
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
    vk_f1: SBAceptar.Click;
    vk_escape: SBCancelar.Click;
  end;
end;

procedure TFCParamConsultaTransitos.eEmpresaChange(Sender: TObject);
begin
  case TComponent(Sender).Tag of
    kEmpresa:
      begin
        STEmpresa.Caption := desEmpresa(eEmpresa.Text);
        STCentroOrigen.Caption := desCentro(eEmpresa.Text, eCentroOrigen.Text);
        STCentroDestino.Caption := desCentro(eEmpresa.Text, eCentroDestino.Text);
        STCentroSalida.Caption := desCentro(eEmpresa.Text, eCentroSalida.Text);

        eFechaDesde.Text:= DateToStr( GetFechaInicio( eEmpresa.Text, eCentroSalida.Text, eProducto.Text ) );
      end;
    kCentro:
        if eCentroOrigen.Focused then
        begin
          STCentroOrigen.Caption := desCentro(eEmpresa.Text, eCentroOrigen.Text);
        end
        else
        if eCentroDestino.Focused then
        begin
          STCentroDestino.Caption := desCentro(eEmpresa.Text, eCentroDestino.Text)
        end
        else
        begin
          STCentroSalida.Caption := desCentro(eEmpresa.Text, eCentroSalida.Text);
          eFechaDesde.Text:= DateToStr( GetFechaInicio( eEmpresa.Text, eCentroSalida.Text, eProducto.Text ) );
        end;
    kProducto:
    begin
      STProducto.Caption := desProducto(eEmpresa.Text, eProducto.Text);
      eFechaDesde.Text:= DateToStr( GetFechaInicio( eEmpresa.Text, eCentroSalida.Text, eProducto.Text ) );
    end;
  end;
end;

procedure TFCParamConsultaTransitos.FormCreate(Sender: TObject);
begin
  Resultado:= False;
end;

end.
