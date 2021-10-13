(* SUSTITUIR
   QLListado, ListadoQL
   ListadoDL
   RParametrosListado
*)
unit ListadoQL;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables, ListadoDL;

type
  TQLListado = class(TQuickRep)
    bndTitulo: TQRBand;
    bndDetalle: TQRBand;
    bndCabeceraColumna: TQRBand;
    bndPiePagina: TQRBand;
    lblImpresoEl: TQRSysData;
    lblTitulo: TQRSysData;
    lblPaginaNum: TQRSysData;

  private

  public

  end;

procedure LoadReport( APadre: TComponent );
procedure UnloadReport;
procedure ExecuteReport( APadre: TComponent; AParametros: RParametrosListado );

implementation

{$R *.DFM}

uses UDMAuxDB, CReportes, Dpreview, Dialogs;

var
  QLListado: TQLListado;
  iContadorUso: integer = 0;

procedure LoadReport( APadre: TComponent );
begin
  Inc( iContadorUso );
  if iContadorUso = 1 then
  begin
    try
      QLListado:= TQLListado.Create( APadre );
    except
      iContadorUso:= 0;
      raise;
    end;
  end;
  ListadoDL.LoadModule( APadre );
end;

procedure UnloadReport;
begin
  if iContadorUso > 0  then
  begin
    Dec( iContadorUso );
    if iContadorUso = 0 then
    begin
      if QLListado <> nil then
        FreeAndNil( QLListado );
    end;
  end;
  ListadoDL.UnloadModule;
end;

procedure ExecuteReport( APadre: TComponent; AParametros: RParametrosListado );
begin
  LoadReport( APadre );
  if ListadoDL.OpenData( APadre, AParametros) <> 0 then
  begin
    QLListado.ReportTitle:= 'TITULO LISTADO';
    PonLogoListad_o( QLListado, AParametros.sEmpresa ); //Borrar guion
    Previsualizar( QLListado );
  end
  else
  begin
    ShowMessage('Sin datos para mostrar para los parametros de selección introducidos.');
  end;
  UnloadReport;
end;


end.
