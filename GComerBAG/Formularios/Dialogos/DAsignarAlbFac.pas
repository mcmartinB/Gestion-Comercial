unit DAsignarAlbFac;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BCalendarButton, StdCtrls, Buttons, BSpeedButton, BGridButton,
  BEdit, BDEdit, Grids, DBGrids, BGrid, ComCtrls, BCalendario;

type
  TFDAsignarAlbFac = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    empresa_sc: TBEdit;
    BGBEmpresa_sc: TBGridButton;
    STEmpresa_sc: TStaticText;
    Label4: TLabel;
    n_factura_sc: TBEdit;
    Label5: TLabel;
    fecha_factura_sc: TBEdit;
    BCBFecha_factura_sc: TBCalendarButton;
    btnAceptar: TButton;
    btnCancelar: TButton;
    CalendarioFlotante: TBCalendario;
    procedure FormCreate(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BCBFecha_factura_scClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    bAceptar: boolean;
  end;


  function GetFacturaAsignar( var AEmpresa: string; var AFecha: TDateTime; var AFactura: integer ): boolean;

implementation

{$R *.dfm}

uses
  CAuxiliarDB;

function GetFacturaAsignar( var AEmpresa: string; var AFecha: TDateTime; var AFactura: integer ): boolean;
var
  FDAsignarAlbFac: TFDAsignarAlbFac;
begin
  FDAsignarAlbFac:= TFDAsignarAlbFac.Create( nil );
  try
    FDAsignarAlbFac.empresa_sc.Text:= AEmpresa;
    FDAsignarAlbFac.fecha_factura_sc.Text:= DateToStr( AFecha );
    FDAsignarAlbFac.n_factura_sc.Text:= IntToStr( AFactura );
    FDAsignarAlbFac.ShowModal;
    result:= FDAsignarAlbFac.bAceptar;
    if FDAsignarAlbFac.bAceptar then
    begin
      AEmpresa:= FDAsignarAlbFac.empresa_sc.Text;
      TryStrToDate( FDAsignarAlbFac.fecha_factura_sc.Text, AFecha );
      TryStrToInt( FDAsignarAlbFac.n_factura_sc.Text, AFactura );
    end;
  finally
    FreeAndNil( FDAsignarAlbFac );
  end
end;

procedure TFDAsignarAlbFac.FormCreate(Sender: TObject);
begin
  bAceptar:= False;
  CalendarioFlotante.Date:= Date;
end;

procedure TFDAsignarAlbFac.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TFDAsignarAlbFac.btnAceptarClick(Sender: TObject);
begin
  bAceptar:= True;
  Close;
end;

procedure TFDAsignarAlbFac.btnCancelarClick(Sender: TObject);
begin
  bAceptar:= False;
  Close;
end;

procedure TFDAsignarAlbFac.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{*}//Si  el calendario esta desplegado no hacemos nada
  if (CalendarioFlotante <> nil) then
    if (CalendarioFlotante.Visible) then
            //No hacemos nada
      Exit;

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
    vk_F1:
      begin
        Key := 0;
        btnAceptar.Click;
      end;
    vk_Escape:
      begin
        Key := 0;
        btnCancelar.Click;
      end;
  end;
end;

procedure TFDAsignarAlbFac.BCBFecha_factura_scClick(Sender: TObject);
begin
  DespliegaCalendario(BCBFecha_factura_sc)
end;

end.
