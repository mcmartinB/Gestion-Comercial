unit ValorarEntradaFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, StdCtrls, BEdit, DBCtrls;

type
  TFLValorarEntrada = class(TForm)
    gridSalidas: TDBGrid;
    qrySalidas: TQuery;
    dsSalidas: TDataSource;
    btnAceptar: TButton;
    btnCancelar: TButton;
    rbInformtiva: TRadioButton;
    rbDefinitiva: TRadioButton;
    lblLiquidacion: TLabel;
    chkRevalorar: TCheckBox;
    dbmmoNotas: TDBMemo;
    chkUsarCostesUltimoMes: TCheckBox;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkRevalorarClick(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sCentro: string;
    iEntrada: Integer;
    dFecha: TDateTime;

   function  QuerySalidas: Boolean;
   procedure ActualizarEstado;
  public
    { Public declarations }
  end;

function ValorarEntrada( const AOwner: TComponent; const AEmpresa, ACentro: string;
                         const AEntrada: Integer; const AFecha: TDateTime ): boolean;

implementation

{$R *.dfm}

uses
  UDMAuxDB, EntradasSalidasDM;

var
  FLValorarEntrada: TFLValorarEntrada;

function ValorarEntrada( const AOwner: TComponent; const AEmpresa, ACentro: string;
                         const AEntrada: Integer; const AFecha: TDateTime ): boolean;
begin
  FLValorarEntrada:= TFLValorarEntrada.Create( AOwner );
  try
    with FLValorarEntrada do
    begin
      sEmpresa:= AEmpresa;
      sCentro:= ACentro;
      dFecha:= AFecha;
      iEntrada:= AEntrada;

      if QuerySalidas then
      begin
        ShowModal;
        Result:= True;
      end
      else
      begin
        ShowMessage('No no se han encontrado salidas asignadas.');
        Result:= False;
      end;
    end;
  finally
    FLValorarEntrada.qrySalidas.Close;
    FreeAndNil( FLValorarEntrada );
  end;
end;

procedure TFLValorarEntrada.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caHide;
end;

procedure TFLValorarEntrada.btnAceptarClick(Sender: TObject);
var
  DMEntradasSalidas: TDMEntradasSalidas;
begin
  if EntradasSalidasDM.ValorarEntrada(self, sEmpresa, sCentro, dFecha, iEntrada, rbDefinitiva.Checked, chkUsarCostesUltimoMes.Checked ) then
  begin
    ActualizarEstado;
  end;
end;

procedure TFLValorarEntrada.ActualizarEstado;
begin
  qrySalidas.Close;
  qrySalidas.Open;

  chkRevalorar.Checked:= False;
  if qrySalidas.FieldByName('fecha_liquidacion_ec').AsString = '' then
  begin
    Caption:= '   VALORAR ENTREGA ';
    btnAceptar.Enabled:= True;
    chkRevalorar.Enabled:= False;
    rbInformtiva.Enabled:= True;
    rbDefinitiva.Enabled:= True;
    rbDefinitiva.Checked:= False;
  end
  else
  begin
    if qrySalidas.FieldByName('liquidacion_definitiva_ec').AsInteger = 1 then
    begin
      Caption:= '   VALORAR ENTREGA - FECHA LIQUIDACION DEFINITIVA: ' +
                qrySalidas.FieldByName('fecha_liquidacion_ec').AsString;
      btnAceptar.Enabled:= False;
      chkRevalorar.Enabled:= True;
      rbInformtiva.Enabled:= False;
      rbDefinitiva.Enabled:= False;
      rbDefinitiva.Checked:= True;
    end
    else
    begin
      Caption:= '   VALORAR ENTREGA - FECHA LIQUIDACION INFORMATIVA: ' +
                qrySalidas.FieldByName('fecha_liquidacion_ec').AsString;
      btnAceptar.Enabled:= True;
      chkRevalorar.Enabled:= False;
      rbInformtiva.Enabled:= True;
      rbDefinitiva.Enabled:= True;
      rbDefinitiva.Checked:= False;
    end;
  end;

end;

procedure TFLValorarEntrada.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

function TFLValorarEntrada.QuerySalidas: boolean;
begin
  with qrySalidas do
  begin
    SQL.Clear;
    SQL.Add(' select  empresa_es, centro_salida_es, n_salida_es, fecha_salida_es, producto_es, kilos_es, ');
    SQL.Add('         liquidacion_definitiva_ec, fecha_liquidacion_Ec, nota_liquidacion_ec, ');
    SQL.Add('         importe_es, descuento_es, gasto_es, abono_es, envasado_es, otros_es, ');
    SQL.Add('         importe_es - ( descuento_es + gasto_es + abono_es + envasado_es + otros_es ) liquida_es ');
    SQL.Add(' from frf_entradas_c, frf_entradas_sal ');
    SQL.Add(' where empresa_ec = :empresa ');
    SQL.Add(' and centro_ec = :centro ');
    SQL.Add(' and numero_entrada_ec = :entrada ');
    SQL.Add(' and fecha_ec = :fecha ');
    SQL.Add(' and empresa_es = :empresa ');
    SQL.Add(' and centro_entrada_es = :centro ');
    SQL.Add(' and n_entrada_es = :entrada ');
    SQL.Add(' and fecha_entrada_es = :fecha ');

    ParamByName('empresa').AsString:= sEmpresa;
    ParamByName('centro').AsString:= sCentro;
    ParamByName('entrada').AsInteger:= iEntrada;
    ParamByName('fecha').Asdate:= dFecha;

    ActualizarEstado;
    result:= not IsEmpty;
  end;
end;

procedure TFLValorarEntrada.chkRevalorarClick(Sender: TObject);
begin
  btnAceptar.Enabled:= chkRevalorar.Checked;
end;

end.
