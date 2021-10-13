unit CRLFacturasDepositoAduanas;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, Dialogs;

type
  TRLFacturasDepositoAduanas = class(TQuickRep)
    bndDetalle: TQRBand;
    qrereferencia_tc: TQRDBText;
    qrecajas: TQRDBText;
    qrecategoria: TQRDBText;
    qredvd_dac: TQRDBText;
    qredvd_dac1: TQRDBText;
    dlgSave: TSaveDialog;
    bnd1: TQRBand;
    qrl1: TQRLabel;
    bnd2: TQRBand;
    qrl3: TQRLabel;
    qrl19: TQRLabel;
    qrl18: TQRLabel;
    qrl17: TQRLabel;
    qrl16: TQRLabel;
    qrlFechas: TQRLabel;
  private

  public

  end;

  procedure Previsualizar( const AForm: TForm; const AEmpresa, ACentro: string;
                           const AFechainicio, AFechafin: TDateTime );

implementation

{$R *.DFM}

uses
  CDLFacturasDepositoAduanas, UDMAUXDB, CReportes, DPreview, QRExport, Shellapi,
  DB, UDMFacturacion, CFacturacion, CVariables, LFacturas;

var
  RLFacturasDepositoAduanas: TRLFacturasDepositoAduanas;


procedure RepetirFactura( const AEmpresa: string; const AFecha: TDateTime; const AFactura: Integer );
begin
  Limpiar;
  try
    PreparaRepeticion(AEmpresa, IntToStr( AFactura ), IntToStr( AFactura ), DateToStr( AFecha ), DateToStr( AFecha ), '', '', True );
    //Abrir tablas
    DMFacturacion.QCabeceraFactura.ParamByName('usuario').AsString := gsCodigo;
    DMFacturacion.QCabeceraFactura.Open;
    DMFacturacion.QLineaFactura.Open;
    DMFacturacion.QLineaGastos.Open;

    try
      QRLFacturas := TQRLFacturas.Create(Application);

      QRLFacturas.Configurar( AEmpresa );
      QRLFacturas.definitivo := True;
      QRLFacturas.printOriginal := False;
      QRLFacturas.printEmpresa := True;
      QRLFacturas.Tag:= 2;
      QRLFacturas.bCopia := True;

      QRLFacturas.Print;
      Limpiar;
      //Preview(QRLFacturas, 1, False, True);
    finally
      FreeAndNil(QRLFacturas);
    end;

  except
    on e: Exception do
    begin
      Limpiar;
      ShowMessage(e.Message);
      Exit;
    end;
  end;
end;

procedure RepetirFacturas;
var
  bPuedoFacturar: boolean;
  usuario, sFactura, sAux: string;
  iFacturas: integer;
begin
  iFacturas:= 0;
  with DLFacturasDepositoAduanas.QTransitos do
  begin
    First;
    sFactura:= '';
    while not eof do
    begin
      sAux:= FieldByName('empresa').AsString + FieldByName('fecha').AsString +FieldByName('factura').AsString;
      if sAux = sFactura then
      begin
        //siguiente factura
      end
      else
      begin
        //factura nueva, imprimir
        sFactura:= FieldByName('empresa').AsString + FieldByName('fecha').AsString +FieldByName('factura').AsString;
        iFacturas:= iFacturas + 1;
      end;
      Next;
    end;
  end;

  if iFacturas = 0 then
  begin
    ShowMessage('Sin facturas.');
    Exit;
  end
  else
  begin
    if iFacturas > 1 then
    begin
      sAux:= 'Se van a imprimir ' + IntToStr( iFacturas ) + ' facturas, ¿seguro que desea continuar?.' + #13 + #10 +
             'Por favor, compruebe nadie este facturando y tenga en cuenta que mientras se impriman las facturas nadie podra facturar.';
    end
    else
    begin
      sAux:= '¿Seguro que quiere imprimir la factura seleccionada?' + #13 + #10 +
             'Por favor, compruebe nadie este facturando.';
    end;
  end;

  if MessageDlg( sAux, mtConfirmation, [mbYes, mbNo], 0 ) = mrYes then
  begin
    usuario:=  gsCodigo;
    bPuedoFacturar:= QuieroFacturar( gsCodigo, usuario );
    if not bPuedoFacturar then
    begin
      ShowMessage('En este momento esta facturando el usuario ' + gsCodigo);
      Exit;
    end;

    try
      gbPlataforma:= True;
      with DLFacturasDepositoAduanas.QTransitos do
      begin
        First;
        sFactura:= '';
        while not eof do
        begin
          sAux:= FieldByName('empresa').AsString + FieldByName('fecha').AsString +FieldByName('factura').AsString;
          if sAux = sFactura then
          begin
            //siguiente factura
          end
          else
          begin
            //factura nueva, imprimir
            sFactura:= FieldByName('empresa').AsString + FieldByName('fecha').AsString +FieldByName('factura').AsString;
            RepetirFactura( FieldByName('empresa').AsString, FieldByName('fecha').AsDateTime, FieldByName('factura').AsInteger );
          end;
          Next;
        end;
        ShowMessage('PROCESO FINALIZADO');
      end;
    finally
      gbPlataforma:= False;
      AcaboFacturar( gsCodigo );
    end;
  end;
end;


procedure Previsualizar( const AForm: TForm; const AEmpresa, ACentro: string;
                         const AFechainicio, AFechafin: TDateTime );

begin
  RLFacturasDepositoAduanas:= TRLFacturasDepositoAduanas.Create( nil );
  try
    RLFacturasDepositoAduanas.qrlFechas.Caption:= 'Del ' + DateToStr(AFechainicio) + ' al ' + DateToStr(AFechaFin );
    Preview( RLFacturasDepositoAduanas );
  except
    FreeAndNil( RLFacturasDepositoAduanas );
  end;

  RepetirFacturas;
end;


end.

