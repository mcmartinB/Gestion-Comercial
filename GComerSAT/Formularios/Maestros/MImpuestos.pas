unit MImpuestos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Grids, DBGrids, ActnList, Buttons, ExtCtrls,
  StdCtrls, BEdit, BDEdit, CGestionPrincipal, DBTables, DBCtrls;

type
  TFMImpuestos = class(TForm)
    dsImpuestosCab: TDataSource;
    Rejilla: TDBGrid;
    Panel1: TPanel;
    ListaAcciones: TActionList;
    Salir: TAction;
    Siguiente: TAction;
    Anterior: TAction;
    Previsualizar: TAction;
    lbl1: TLabel;
    btnSBPrior: TSpeedButton;
    btnSBNext: TSpeedButton;
    btn1: TSpeedButton;
    btnSalir: TSpeedButton;
    dlblTipo: TDBText;
    dlblCodigo: TDBText;
    dlblDescripcion: TDBText;
    qryImpuestosCab: TQuery;
    qryImpuestosLin: TQuery;
    dsImpuestosLin: TDataSource;
    qryListado: TQuery;
    procedure FormCreate(Sender: TObject);
    procedure SalirExecute(Sender: TObject);
    procedure SiguienteExecute(Sender: TObject);
    procedure AnteriorExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PrevisualizarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses CVariables, UDMBaseDatos, LImpuestos, Principal, DPreview, CReportes;

{$R *.DFM}

procedure TFMImpuestos.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

     //Botones
  Anterior.Enabled := true;
  Siguiente.Enabled := true;
  Salir.Enabled := true;
  Salir.ShortCut := vk_escape;

  //Abrir tablas
  with qryImpuestosCab do
  begin
    SQL.Clear;
    SQL.Add(' select tipo_i, codigo_i, descripcion_i ');
    SQL.Add(' from frf_impuestos ');
    SQL.Add(' order by 1,2 ');
    Open;
  end;
  with qryImpuestosLin do
  begin
    SQL.Clear;
    SQL.Add(' select fecha_ini_il Inicio, fecha_fin_il Fin, super_il Super, reducido_il Reducido, general_il General ');
    SQL.Add(' from frf_impuestos_l ');
    SQL.Add(' where codigo_il = :codigo_i ');
    SQL.Add(' order by 1 ');
    Open;
  end;

  with qryListado do
  begin
    SQL.Clear;
    SQL.Add(' select tipo_i, codigo_i, descripcion_i, fecha_ini_il, fecha_fin_il, super_il, reducido_il, general_il ');
    SQL.Add(' from frf_impuestos, frf_impuestos_l ');
    SQL.Add(' where codigo_i = codigo_il ');
    SQL.Add(' order by tipo_i, codigo_i, fecha_ini_il ');
  end;
end;

procedure TFMImpuestos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FormType := tfDirector;
  BHFormulario;

  qryImpuestosLin.Close;
  qryImpuestosCab.Close;

  Action := caFree;
end;

procedure TFMImpuestos.SalirExecute(Sender: TObject);
begin
     //Salir
  Close;
end;

procedure TFMImpuestos.SiguienteExecute(Sender: TObject);
begin
  qryImpuestosCab.Next
end;

procedure TFMImpuestos.AnteriorExecute(Sender: TObject);
begin
  qryImpuestosCab.Prior;
end;

procedure TFMImpuestos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
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

procedure TFMImpuestos.PrevisualizarExecute(Sender: TObject);
begin
  QRLImpuestos := TQRLImpuestos.Create(Application);
  PonLogoGrupoBonnysa(QRLImpuestos);
  qryListado.Open;
  try
    try
      QRLImpuestos.DataSet:= qryListado;
      Preview(QRLImpuestos);
    except
       FreeAndNil( QRLImpuestos );
       raise;
    end;
  finally
    qryListado.Close;
  end;
end;

end.

