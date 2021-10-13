unit DatosCMRFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls, Buttons, Grids, DBGrids;

type
  TFDDatosCMR = class(TForm)
    mmoRemitente: TMemo;
    mmoConsignatario: TMemo;
    ComboOrigen: TComboBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    QAux: TQuery;
    ComboSuministro: TComboBox;
    DataSource: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    lblcarga: TLabel;
    mmoOrigen: TMemo;
    lblEntrega: TLabel;
    mmoEntrega: TMemo;
    private
    { Private declarations }

  public
    { Public declarations }

  end;

function ClienteCMRExec(const AEmpresa, ACliente, ASuministro: string;
                        var VRemitente, VOrigen, VConsignatario, VEntrega : TStringList): boolean;

implementation

{$R *.dfm}

uses UDMAuxDB;

var
  FDDatosCMR: TFDDatosCMR;


function ClienteCMRExec(const AEmpresa, ACliente, ASuministro: string;
                        var VRemitente, VOrigen, VConsignatario, VEntrega : TStringList): boolean;
begin
  FDDatosCMR := TFDDatosCMR.Create(Application);
  try
    FDDatosCMR.mmoRemitente.Clear;
    FDDatosCMR.mmoRemitente.Lines.AddStrings( VRemitente );

    FDDatosCMR.mmoOrigen.Clear;
    FDDatosCMR.mmoOrigen.Lines.AddStrings(VOrigen);
    FDDatosCMR.mmoConsignatario.Clear;
    FDDatosCMR.mmoConsignatario.Lines.AddStrings(VConsignatario);
    FDDatosCMR.mmoEntrega.Clear;
    FDDatosCMR.mmoEntrega.Lines.AddStrings(VEntrega);

    result := FDDatosCMR.ShowModal = mrOK;
    VRemitente.Clear;
    VRemitente.AddStrings(FDDatosCMR.mmoRemitente.Lines);

    VOrigen.Clear;
    VOrigen.AddStrings(FDDatosCMR.mmoOrigen.Lines);

    VConsignatario.Clear;
    VConsignatario.AddStrings(FDDatosCMR.mmoConsignatario.Lines);

    VEntrega.Clear;
    VEntrega.AddStrings(FDDatosCMR.mmoEntrega.Lines);
  finally
    FreeAndNil( FDDatosCMR );
  end;
end;


end.
