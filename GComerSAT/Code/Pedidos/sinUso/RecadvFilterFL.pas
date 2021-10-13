unit RecadvFilterFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, nbLabels, nbCombos, nbEdits, DB, Grids,
  DBGrids, Mask, DBCtrls, BCalendarButton, BSpeedButton, BGridButton, BEdit,
  BGrid, ComCtrls, BCalendario;

type
  TFLRecadvFilter = class(TForm)
    btnCerrar: TBitBtn;
    btnBuscar: TBitBtn;
    lblNombre1: TLabel;
    lblNombre2: TLabel;
    eFechaIni: TnbDBCalendarCombo;
    eEmpresa: TnbDBSQLCombo;
    eAlbaran: TBEdit;
    ePedido: TBEdit;
    eMatricula: TBEdit;
    lblNombre3: TLabel;
    lblNombre4: TLabel;
    lblNombre5: TLabel;
    lblNombre6: TLabel;
    eFechaFin: TnbDBCalendarCombo;
    stEmpresa: TnbStaticText;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCerrarClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnBuscarClick(Sender: TObject);
    procedure eEmpresaChange(Sender: TObject);
  private
    { Private declarations }
    rResult: boolean;

    function ValidarCampos: Boolean;
  public
    { Public declarations }
    sEmpresa, sAlbaran, sPedido, sMatricula: string;
    dFechaIni, dFechaFin: TDateTime;

    function Execute: boolean;
  end;

implementation

{$R *.dfm}

uses CVariables, UDMAuxDB;

procedure TFLRecadvFilter.FormCreate(Sender: TObject);
begin
  eEmpresa.Text:= gsDefEmpresa;
  eFechaIni.AsDate:= Date;
  eFechaFin.AsDate:= Date;
  eAlbaran.Text:= '';
  eMatricula.Text:= '';
  ePedido.Text:= '';
end;

procedure TFLRecadvFilter.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if rResult then
  begin
    sEmpresa:= eEmpresa.Text;
    dFechaIni:= eFechaIni.AsDate;
    dFechaFin:= eFechaFin.AsDate;
    sAlbaran:= eAlbaran.Text;
    sMatricula:= eMatricula.Text;
    sPedido:= ePedido.Text;
  end;
  Action:=caHide;
end;

procedure TFLRecadvFilter.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    Vk_escape: btnCerrar.Click;
    vk_f1: btnBuscar.Click;
  end;
end;

procedure TFLRecadvFilter.btnCerrarClick(Sender: TObject);
begin
  rResult:= False;
  Close;
end;

procedure TFLRecadvFilter.btnBuscarClick(Sender: TObject);
begin
  if Validarcampos then
  begin
    rResult:= True;
    Close;
  end;
end;

procedure TFLRecadvFilter.eEmpresaChange(Sender: TObject);
begin
  stEmpresa.Caption:= desEmpresa( eEmpresa.Text );
end;

function TFLRecadvFilter.ValidarCampos: boolean;
var
  dIni, dFin: TDateTime;
begin
  result:= false;
  if stEmpresa.Caption = '' then
  begin
    ShowMessage('Falta el código de la empresa o es incorrecto.');
    eEmpresa.SetFocus;
  end;

  if not tryStrToDateTime( eFechaIni.Text, dIni ) then
  begin
    ShowMessage('Falta la fecha de inicio o es incorrecta.');
    eFechaIni.SetFocus;
  end;

  if not tryStrToDateTime( eFechaFin.Text, dFin ) then
  begin
    ShowMessage('Falta la fecha de fin o es incorrecta.');
    eFechaFin.SetFocus;
  end;

  if dIni > dFin then
  begin
    ShowMessage('Rango de fechas incorrecto.');
    eFechaIni.SetFocus;
  end;
  result:= True;
end;

function TFLRecadvFilter.Execute: boolean;
begin
  ShowModal;
  result:= rResult;
end;

end.
