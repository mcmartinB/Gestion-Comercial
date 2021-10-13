(* SUSTITUIR
   QLSincronizarDiario, SincronizarDiarioQL
   RParametrosSincronizarDiario
*)
unit SincroResumenQD;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TQDSincroResumen = class(TQuickRep)
    bndTitulo: TQRBand;
    bndPiePagina: TQRBand;
    lblImpresoEl: TQRSysData;
    lblTitulo: TQRSysData;
    lblPaginaNum: TQRSysData;
    QRSubDetail1: TQRSubDetail;
    QRMemo1: TQRMemo;
    procedure QRSubDetail1NeedData(Sender: TObject; var MoreData: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);

  private
    //bPimera: boolean;
  public

  end;

  procedure Ejecutar( const AForm: TForm; const ATexto: TStrings );

implementation

{$R *.DFM}

uses DPreview;

procedure Ejecutar( const AForm: TForm; const ATexto: TStrings );
var
  QDSincroResumen: TQDSincroResumen;
begin
  QDSincroResumen:= TQDSincroResumen.Create( Aform );
  QDSincroResumen.QRMemo1.Lines.AddStrings( ATexto );
  QDSincroResumen.ReportTitle:= 'RESUMEN SINCRONIZACION';
  try
    QDSincroResumen.Print;
  finally
    FreeAndNil( QDSincroResumen );
  end;
end;


procedure TQDSincroResumen.QRSubDetail1NeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  //MoreData:= bPrimera;
  //bPimera:= False;
end;

procedure TQDSincroResumen.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  //bPimera:= True;
end;

end.
