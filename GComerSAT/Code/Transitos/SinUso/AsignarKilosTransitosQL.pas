unit AsignarKilosTransitosQL;

interface

uses
  Classes, Controls, ExtCtrls, QuickRpt, Qrctrls, Db, DBTables;

type
  TQLAsignarKilosTransitos = class(TQuickRep)
    bndCabPagina: TQRBand;
    QRSysData2: TQRSysData;
    QRSysData3: TQRSysData;
    lCliente: TQRLabel;
    lFechas: TQRLabel;
    lCentro: TQRLabel;

  private

  public

  end;

implementation

{$R *.DFM}

uses AsignarKilosTransitosDL, UDMAuxDB, SysUtils;

end.
