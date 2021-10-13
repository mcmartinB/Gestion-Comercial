(* SUSTITUIR
   QLSincronizarDiario, SincronizarDiarioQL
   RParametrosSincronizarDiario
*)
unit CRDResultadoEnvio;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables;

type
  TRPResultadoEnvio = class(TQuickRep)
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
  RPResultadoEnvio: TRPResultadoEnvio;
begin
  RPResultadoEnvio:= TRPResultadoEnvio.Create( Aform );
  RPResultadoEnvio.QRMemo1.Lines.AddStrings( ATexto );
  RPResultadoEnvio.ReportTitle:= 'RESUMEN SINCRONIZACION';
  try
    RPResultadoEnvio.Print;
  finally
    FreeAndNil( RPResultadoEnvio );
  end;
end;


procedure TRPResultadoEnvio.QRSubDetail1NeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  //MoreData:= bPrimera;
  //bPimera:= False;
end;

procedure TRPResultadoEnvio.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  //bPimera:= True;
end;

end.
