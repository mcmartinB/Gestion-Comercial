unit LUndConsumo;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls, db,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, DBTables;

type
  TQRLUndConsumo = class(TQuickRep)
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    fecha: TQRSysData;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    ChildBand1: TQRChildBand;
    PsQRLabel1: TQRLabel;
    PsQRLabel2: TQRLabel;
    PsQRLabel4: TQRLabel;
    PsQRLabel5: TQRLabel;
    PsQRLabel6: TQRLabel;
    PsQRLabel7: TQRLabel;
    PsQRDBText1: TQRDBText;
    PsQRDBText2: TQRDBText;
    PsQRDBText3: TQRDBText;
    PsQRDBText5: TQRDBText;
    PsQRDBText6: TQRDBText;
    PsQRDBText7: TQRDBText;
    PsQRDBText4: TQRDBText;
    procedure PsQRDBText2Print(sender: TObject; var Value: string);
    procedure PsQRDBText3Print(sender: TObject; var Value: string);
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure PsQRDBText6Print(sender: TObject; var Value: String);
  private

  public
    EjercicioDataSet: TDataSet;
    ColorDataSet: TDataSet;
    CalibreDataSet: TDataSet;
    CategoriaDataSet: TDataSet;

  end;

var
  QRLUndConsumo: TQRLUndConsumo;

implementation

{$R *.DFM}

uses UDMBaseDatos, UDMAuxDB, Dialogs;

procedure TQRLUndConsumo.PsQRDBText2Print(sender: TObject;
  var Value: string);
begin
  Value := DMBasedatos.QListado.FieldByName('codigo_uc').AsString + ' ' + Value;
end;

procedure TQRLUndConsumo.PsQRDBText3Print(sender: TObject;
  var Value: string);
begin
  Value := Value + ' ' +
    desProductoBase(DMBasedatos.QListado.FieldByName('empresa_uc').AsString, Value);
end;

procedure TQRLUndConsumo.ChildBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  try
  PrintBand := Trim(DMBaseDatos.QListado.FieldByName('descripcion2_uc').AsString) <> '';
  except
    ShowMessage(DMBasedatos.QListado.FieldByName('codigo_uc').AsString);
  end;
end;

procedure TQRLUndConsumo.PsQRDBText6Print(sender: TObject;
  var Value: String);
begin
  Value:= Value + ' Kgs';
end;

end.
