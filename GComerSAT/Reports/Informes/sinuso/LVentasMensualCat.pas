unit LVentasMensualCat;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQRLVentasMensualCat = class(TQuickRep)
    TitleBand1: TQRBand;
    DetailBand1: TQRBand;
    QRGrupo: TQRGroup;
    PsQRLabel4: TQRLabel;
    DBMes: TQRDBText;
    PsQRLabel5: TQRLabel;
    PsQRSysData1: TQRSysData;
    LCliente: TQRLabel;
    LPeriodo: TQRLabel;
    DBKilos: TQRDBText;
    PsQRLabel7: TQRLabel;
    DBAnyo: TQRDBText;
    QRBand1: TQRBand;
    PsQRExpr1: TQRExpr;
    PsQRLabel11: TQRLabel;
    DBimporte: TQRDBText;
    PsQRExpr4: TQRExpr;
    PsQRLabel12: TQRLabel;
    LMoneda: TQRLabel;
    DBCategoria: TQRDBText;
    lblProducto: TQRLabel;
    procedure DBMesPrint(sender: TObject; var Value: string);
    procedure DBCategoriaPrint(sender: TObject; var Value: String);
  private

  public

  end;

var
  QRLVentasMensualCat: TQRLVentasMensualCat;

implementation

{$R *.DFM}

procedure TQRLVentasMensualCat.DBMesPrint(sender: TObject; var Value: string);
begin
  if Value = '1' then
    Value := 'Enero'
  else
    if Value = '2' then
      Value := 'Febrero'
    else
      if Value = '3' then
        value := 'Marzo'
      else
        if Value = '4' then
          Value := 'Abril'
        else
          if Value = '5' then
            Value := 'Mayo'
          else
            if Value = '6' then
              value := 'Junio'
            else
              if Value = '7' then
                Value := 'Julio'
              else
                if Value = '8' then
                  Value := 'Agosto'
                else
                  if Value = '9' then
                    value := 'Septiembre'
                  else
                    if Value = '10' then
                      Value := 'Octubre'
                    else
                      if Value = '11' then
                        Value := 'Noviembre'
                      else
                        if Value = '12' then
                          value := 'Diciembre'
end;

procedure TQRLVentasMensualCat.DBCategoriaPrint(sender: TObject;
  var Value: String);
begin
  Value:= 'CAT. ' + Value + 'ª';
end;

end.
