unit CambiarCodigoEntregaFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, DBTables, Buttons, BSpeedButton,
  BGridButton, BEdit, BDEdit, BGrid;

type
  TFDCambiarCodigoEntrega = class(TForm)
    btnAceptar: TButton;
    btnCancelar: TButton;
    lblNombre7: TLabel;
    edtplanta: TBEdit;
    lblPlanta: TLabel;
    lblEntrega: TLabel;
    edtEntrega: TBEdit;
    lblCentro2: TLabel;
    edtCentro: TBEdit;
    lblCentro: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    chkQuiero: TCheckBox;
    procedure btnAceptarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtplantaChange(Sender: TObject);
    procedure edtCentroChange(Sender: TObject);
    procedure chkQuieroClick(Sender: TObject);
  private
    { Private declarations }
    sPlanta, sCentro, sOldCode, sNewCode: string;

    function VerificarDatos: Boolean;

  public
    { Public declarations }
  end;

  function CambiarCodigoEntrega( const AOwner: TComponent;  const AOldCode: string; var ANewCode: string ): boolean;

implementation

{$R *.dfm}

uses
  CVariables, CAuxiliarDB, UDMAuxDB, AdvertenciaFD, bCodeUtils, CambiarCodigoEntregaMD;

var
  FDCambiarCodigoEntrega: TFDCambiarCodigoEntrega;


function CambiarCodigoEntrega( const AOwner: TComponent;  const AOldCode: string; var ANewCode: string ): boolean;
begin
  FDCambiarCodigoEntrega:= TFDCambiarCodigoEntrega.Create( AOwner );
  try
    FDCambiarCodigoEntrega.edtEntrega.ReadOnly:= True;
    FDCambiarCodigoEntrega.edtEntrega.Text:= AOldCode;
    FDCambiarCodigoEntrega.sOldCode:= AOldCode;
    Result:= FDCambiarCodigoEntrega.ShowModal = 1;
    ANewCode:= FDCambiarCodigoEntrega.sNewCode;
  finally
    FreeAndNil( FDCambiarCodigoEntrega );
  end;
end;

procedure TFDCambiarCodigoEntrega.FormCreate(Sender: TObject);
begin
  //empresa_e.Tag := kEmpresa;
  edtPlanta.OnChange( edtPlanta );
end;


procedure TFDCambiarCodigoEntrega.btnAceptarClick(Sender: TObject);
begin
  if VerificarDatos then
  begin
    if CambiarCodigoEntregaMD.CambiarCodigoEntrega( Self, sOldCode, sPlanta, sCentro, sNewCode ) then
    begin
      ModalResult:= 1;
    end;
  end
end;

procedure TFDCambiarCodigoEntrega.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= -1;
end;


procedure TFDCambiarCodigoEntrega.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  (*
  if (bgrdRejillaFlotante.Visible) then
           //No hacemos nada
     Exit;
  *)
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

procedure TFDCambiarCodigoEntrega.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //qrypalet.Close;
end;


procedure TFDCambiarCodigoEntrega.edtplantaChange(Sender: TObject);
begin
  lblPlanta.Caption:= desEmpresa( edtplanta.Text );
  edtCentro.OnChange( edtCentro );
end;

procedure TFDCambiarCodigoEntrega.edtCentroChange(Sender: TObject);
begin
  lblCentro.Caption:= desCentro( edtplanta.Text, edtCentro.Text );
end;

function TFDCambiarCodigoEntrega.VerificarDatos: Boolean;
begin
  Result:= False;
  if lblPlanta.Caption = '' then
  begin
    ShowMessage('Falta el código de la planta o es incorrecto.');
  end
  else
  begin
    if ( Copy( sOldCode, 1, 4 ) = edtplanta.Text + edtcentro.Text )  then
    begin
      ShowMessage('El código de la planta y/o centro debe de ser diferente al de la entrega seleccionada.');
    end
    else
    begin
      if lblCentro.Caption = '' then
      begin
        ShowMessage('Falta el código del centro o es incorrecto.');
      end
      else
      begin
        sOldCode:= edtEntrega.Text;
        sPlanta:= edtplanta.Text;
        sCentro:= edtCentro.Text;
        sNewCode:= '';
        Result:= True;
      end;
    end;
  end;
end;

procedure TFDCambiarCodigoEntrega.chkQuieroClick(Sender: TObject);
begin
  btnAceptar.Enabled:= chkQuiero.Checked;
end;

end.
