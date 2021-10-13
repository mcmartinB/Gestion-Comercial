unit VerificarDesadvFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, Grids, DBGrids;

type
  TFDVerificarDesadv = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    dbgrdResumen: TDBGrid;
    dsResumen: TDataSource;
    lblTexto: TLabel;
    chkConfirmo: TCheckBox;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure chkConfirmoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function VerResultadoVerificacion( const AOwner: TComponent; const AVerifOK: Boolean; const ADatos: TDataSet; var VMsg: string  ): Boolean;



implementation

{$R *.dfm}

function VerResultadoVerificacion( const AOwner: TComponent; const AVerifOK: Boolean; const ADatos: TDataSet; var VMsg: string ): Boolean;
var
  FDVerificarDesadv: TFDVerificarDesadv;
begin
  FDVerificarDesadv:= TFDVerificarDesadv.Create( AOwner );
  try
    FDVerificarDesadv.btnOk.enabled:= AVerifOK;
    FDVerificarDesadv.dsResumen.DataSet:= ADatos;
    FDVerificarDesadv.chkConfirmo.visible:= not AVerifOK;
    if AVerifOK then
      FDVerificarDesadv.lblTexto.Caption:= 'Los datos de la carga son los esperados.'
    else
      FDVerificarDesadv.lblTexto.Caption:= 'Los datos de la carga no coincien con los esperados.';
    Result:= FDVerificarDesadv.ShowModal = mrOk;
    if not Result then
    begin
      if AVerifOK then
      begin
        VMsg:= 'Operacion cancelada por el usuario.';
      end
      else
      begin
        VMsg:= FDVerificarDesadv.lblTexto.Caption;
      end;
    end;
  finally
    FreeAndNil( FDVerificarDesadv );
  end;
end;

procedure TFDVerificarDesadv.btnOkClick(Sender: TObject);
begin
  ModalResult:= mrOk;
end;

procedure TFDVerificarDesadv.btnCancelClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TFDVerificarDesadv.chkConfirmoClick(Sender: TObject);
begin
  btnOk.Enabled:= chkConfirmo.Checked;
end;

end.
