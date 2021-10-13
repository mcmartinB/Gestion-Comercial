unit CRLDepositoAduanasDOC;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, Dialogs;

type
  TRLDepositoAduanasDOC = class(TQuickRep)
    bndDetalle: TQRBand;
    qrereferencia_tc: TQRDBText;
    qrekilos_das: TQRDBText;
    qrecajas: TQRDBText;
    qrecategoria: TQRDBText;
    naviera: TQRDBText;
    qredvd_dac1: TQRDBText;
    qredes_puerto_tc: TQRDBText;
    QRDBText1: TQRDBText;
    qren_palets: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    qredto_rappel: TQRDBText;
    qrecoste_manipulacion: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    dlgSave: TSaveDialog;
    QRDBText2: TQRDBText;
    bnd1: TQRBand;
    bndcChildBand1: TQRChildBand;
    qrl1: TQRLabel;
    qrl2: TQRLabel;
    qrl4: TQRLabel;
    qrl5: TQRLabel;
    qrl6: TQRLabel;
    qrl7: TQRLabel;
    qrl8: TQRLabel;
    qrl9: TQRLabel;
    qrl10: TQRLabel;
    qrl11: TQRLabel;
    qrl12: TQRLabel;
    qrl13: TQRLabel;
    qrl14: TQRLabel;
    qrl15: TQRLabel;
    qrl16: TQRLabel;
    qrl17: TQRLabel;
    qrl18: TQRLabel;
    qrl19: TQRLabel;
    qrl3: TQRLabel;
    qredestino: TQRDBText;
    qrgGrupo: TQRGroup;
    bndPieHoja: TQRBand;
    qrlPagina: TQRLabel;
    bndPieGrupo: TQRBand;
    qrxTotal: TQRExpr;
    qrxFrigoDDA: TQRExpr;
    qrxFrigo: TQRExpr;
    qrxSeguridad: TQRExpr;
    qrxBaf: TQRExpr;
    qrxmnipula: TQRExpr;
    qrxmercancia: TQRExpr;
    qrxFlete: TQRExpr;
    qrxRappel: TQRExpr;
    qrxPeso: TQRExpr;
    qrlblTotal: TQRLabel;
    procedure qredestinoPrint(sender: TObject; var Value: String);
    procedure qrgGrupoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrlPaginaPrint(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure bnd1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndDetalleBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndPieGrupoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    nPage: integer;
    sDestino, sPuertoSalida: string;
    bFlag: Boolean;
    rTotal: real;
  public
    sFechas: string;
  end;

  procedure Previsualizar( const AForm: TForm; const AEmpresa, ACentro, APuertoSalida: string;
                           const AFechainicio, AFechafin: TDateTime );
  procedure CrearBaseDatos( const AForm: TForm; const AEmpresa, ACentro, APuertoSalida: string;
                            const AFechainicio, AFechafin: TDateTime );

implementation

{$R *.DFM}

uses
  CDLDepositoAduanasDOC, UDMAUXDB, CReportes, DPreview, QRExport, Shellapi,
  DB;

var
  RLDepositoAduanasDOC: TRLDepositoAduanasDOC;

procedure Previsualizar( const AForm: TForm; const AEmpresa, ACentro, APuertoSalida: string;
                         const AFechainicio, AFechafin: TDateTime );
begin
  RLDepositoAduanasDOC:= TRLDepositoAduanasDOC.Create( nil );
  try
    DLDepositoAduanasDOC.OrdenarDestino;
    RLDepositoAduanasDOC.sFechas:= ' del ' + DateToStr(AFechainicio) + ' al ' + DateToStr(AFechaFin );
    RLDepositoAduanasDOC.qredestino.DataField:= 'Destino';
    RLDepositoAduanasDOC.qrgGrupo.Expression:= 'Destino';
    RLDepositoAduanasDOC.bndPieHoja.Enabled:= True;
    RLDepositoAduanasDOC.bndPieGrupo.Enabled:= True;
    RLDepositoAduanasDOC.sPuertoSalida:= APuertoSalida;
    Preview( RLDepositoAduanasDOC );
  except
    FreeAndNil( RLDepositoAduanasDOC );
  end;
end;

procedure CrearBaseDatos( const AForm: TForm; const AEmpresa, ACentro, APuertoSalida: string;
                          const AFechainicio, AFechafin: TDateTime );
begin
  RLDepositoAduanasDOC:= TRLDepositoAduanasDOC.Create( nil );
  try
    RLDepositoAduanasDOC.sPuertoSalida:= APuertoSalida;
    DLDepositoAduanasDOC.OrdenarId;
    RLDepositoAduanasDOC.qredestino.DataField:= '';
    RLDepositoAduanasDOC.qrgGrupo.Expression:= '';
    RLDepositoAduanasDOC.bndPieHoja.Enabled:= False;
    RLDepositoAduanasDOC.bndPieGrupo.Enabled:= False;
    RLDepositoAduanasDOC.dlgSave.FileName:= 'DepositoAduanasBD.xls';
    if RLDepositoAduanasDOC.dlgSave.Execute then
    begin
      RLDepositoAduanasDOC.ExportToFilter(TQRXLSFilter.Create(RLDepositoAduanasDOC.dlgSave.FileName));
      if FileExists( RLDepositoAduanasDOC.dlgSave.FileName ) then
        ShellExecute(AForm.Handle, nil, PChar(RLDepositoAduanasDOC.dlgSave.FileName), nil, nil, SW_NORMAL)
      else
        ShowMessage('Error an intentar abrir el fichero ' + RLDepositoAduanasDOC.dlgSave.FileName );
    end;

    DLDepositoAduanasDOC.OrdenarDestino;
    RLDepositoAduanasDOC.sFechas:= ' del ' + DateToStr(AFechainicio) + ' al ' + DateToStr(AFechaFin );
    RLDepositoAduanasDOC.qredestino.DataField:= 'Destino';
    RLDepositoAduanasDOC.qrgGrupo.Expression:= 'Destino';
    RLDepositoAduanasDOC.bndPieHoja.Enabled:= True;
    RLDepositoAduanasDOC.bndPieGrupo.Enabled:= True;
    Preview( RLDepositoAduanasDOC );
  except
    FreeAndNil( RLDepositoAduanasDOC );
  end;
end;


procedure TRLDepositoAduanasDOC.qredestinoPrint(sender: TObject;
  var Value: String);
begin
  if sPuertoSalida <> '' then
    Value:= desAduana( sPuertoSalida ) + ' - ' + Value + sFechas
  else
    Value:= Value + sFechas;
end;

procedure TRLDepositoAduanasDOC.qrgGrupoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qrgGrupo.Height:= 0;
end;

procedure TRLDepositoAduanasDOC.qrlPaginaPrint(sender: TObject;
  var Value: String);
begin
  Value:= 'Página nº ' + IntToStr( nPage );
end;

procedure TRLDepositoAduanasDOC.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  bFlag:= False;
  rTotal:= 0;
end;

procedure TRLDepositoAduanasDOC.bnd1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if bFlag then
  begin
    if sDestino = DataSet.FieldByName('destino').AsString then
    begin
      nPage:= nPage + 1;;
    end
    else
    begin
      sDestino:= DataSet.FieldByName('destino').AsString;
      nPage:= 1;
    end;
  end
  else
  begin
    nPage:= 1;
    sDestino:= DataSet.FieldByName('destino').AsString;
    bFlag:= True;
  end;
end;

procedure TRLDepositoAduanasDOC.bndDetalleBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  rTotal:= rTotal + DataSet.fieldbyName( 'total' ).AsFloat;
end;

procedure TRLDepositoAduanasDOC.bndPieGrupoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  qrlblTotal.Caption:= FormatFloat('#,##0.00', rTotal);
  rTotal:= 0;
end;

end.
