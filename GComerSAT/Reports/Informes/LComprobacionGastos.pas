unit LComprobacionGastos;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TQRLComprobacionGastos = class(TQuickRep)
    ColumnHeaderBand1: TQRBand;
    bndCabecera: TQRBand;
    DetailBand1: TQRBand;
    LAlbaran: TQRLabel;
    LFecha: TQRLabel;

    LVariable: TQRLabel;
    LTitulo: TQRLabel;
    DBAlbaran: TQRDBText;
    DBFecha: TQRDBText;
    DBVariable: TQRDBText;
    PsQRSysData1: TQRSysData;
    LPeriodo: TQRLabel;
    LCliente: TQRLabel;
    DBCliente: TQRDBText;
    LMatricula: TQRLabel;
    DBMatricula: TQRDBText;
    QRGroup1: TQRGroup;
    QRLabel1: TQRLabel;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    lblTipoTransito: TQRLabel;
    lblTipoGastos: TQRLabel;
    lblCliente: TQRLabel;
    qrlPalets: TQRLabel;
    qrePalets: TQRDBText;
    procedure LVariablePrint(sender: TObject; var Value: string);
    procedure LClientePrint(sender: TObject; var Value: string);
    procedure LMatriculaPrint(sender: TObject; var Value: string);
    procedure LAlbaranPrint(sender: TObject; var Value: string);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public
    seleccion: Integer;

  end;

var
  QRLComprobacionGastos: TQRLComprobacionGastos;

implementation

{$R *.DFM}

procedure TQRLComprobacionGastos.LAlbaranPrint(sender: TObject;
  var Value: string);
begin
  if (seleccion = 1) then
    Value := 'Tránsito'
  else
    Value := 'Albarán';
end;

procedure TQRLComprobacionGastos.LVariablePrint(sender: TObject;
  var Value: string);
begin
  if (seleccion = 0) or (seleccion = 1) then
  begin
    Value := '';
  end
end;

procedure TQRLComprobacionGastos.LClientePrint(sender: TObject;
  var Value: string);
begin
  if (seleccion = 0) or (seleccion = 1) then
  begin
    Value := '';
  end;
end;

procedure TQRLComprobacionGastos.LMatriculaPrint(sender: TObject;
  var Value: string);
begin
  if (seleccion = 0) or (seleccion = 1) then
  begin
    Value := '';
  end;
end;

procedure TQRLComprobacionGastos.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if DataSet.FieldByName('Tipo').AsString = 'T' then
    QRGroup1.Height := 19
  else
    QRGroup1.Height := 0;
end;

end.
