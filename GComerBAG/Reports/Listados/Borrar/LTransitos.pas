unit LTransitos;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db, DBTables, kbmMemTable;

type
  TQRLTransitos = class(TQuickRep)
    DetailBand1: TQRBand;
    TitleBand1: TQRBand;
    PageFooterBand1: TQRBand;
    PsQRSysData1: TQRSysData;
    qreplanta_destino_tc: TQRDBText;
    PsQRDBText2: TQRDBText;
    PsQRDBText3: TQRDBText;
    PsQRDBText4: TQRDBText;
    QRBand1: TQRBand;
    PsQRLabel1: TQRLabel;
    PsQRLabel2: TQRLabel;
    PsQRLabel3: TQRLabel;
    PsQRLabel4: TQRLabel;
    PsQRLabel5: TQRLabel;
    PsQRLabel6: TQRLabel;
    PsQRLabel7: TQRLabel;
    PsQRLabel8: TQRLabel;
    PsQRDBText5: TQRDBText;
    PsQRDBText6: TQRDBText;
    PsQRDBText7: TQRDBText;
    QListado: TQuery;
    PsQRLabel9: TQRLabel;
    PsQRDBText8: TQRDBText;
    PsQRLabel10: TQRLabel;
    qrecentro_destino_tc: TQRDBText;
    lbllPeriodo: TQRLabel;
    QRSysData1: TQRSysData;
    SummaryBand1: TQRBand;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRLabel1: TQRLabel;
    QPaletPB: TQuery;
    DSListado: TDataSource;
    bnddPalrtPB: TQRSubDetail;
    bndCapPaletPB: TQRBand;
    qresscc: TQRDBText;
    qrestatus: TQRDBText;
    qreproveedor: TQRDBText;
    qreproducto: TQRDBText;
    qrevariedad: TQRDBText;
    qrecalibre: TQRDBText;
    qrepeso: TQRDBText;
    qrecajas: TQRDBText;
    qretipo_palet: TQRDBText;
    qrl3: TQRLabel;
    qrl4: TQRLabel;
    qrl5: TQRLabel;
    qrl6: TQRLabel;
    qrl7: TQRLabel;
    qrl8: TQRLabel;
    qrl9: TQRLabel;
    qrl10: TQRLabel;
    qrl11: TQRLabel;
    qrl2: TQRLabel;
    qrlOrden: TQRLabel;
    qreorden_tc: TQRDBText;
    bndPiePaletPB: TQRBand;
    qrl16: TQRLabel;
    qrx1: TQRExpr;
    qreentrega: TQRDBText;
    qrlblEntrega: TQRLabel;
    qrdbtxtEntrega: TQRDBText;
    kmtListado: TkbmMemTable;
    qryEntregas: TQuery;
    procedure bndCapPaletPBBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    bPackingProveedor: boolean;
  public

    destructor Destroy; override;

  end;

procedure Listado(const AWhere, ARange, AWhereCab: string; const AEntrega, APaletsProveedor: boolean );

var
  QRLTransitos: TQRLTransitos;

implementation

uses UDMAuxDB, CVariables, DPreview, CReportes, Dialogs, Variants;

{$R *.DFM}

{ TQRLTransitos }

destructor TQRLTransitos.Destroy;
begin
  if QListado.Active then QListado.Close;
  inherited;
end;

procedure Listado(const AWhere, ARange, AWhereCab: string; const AEntrega, APaletsProveedor: boolean );
var
  QueryStr, sProducto: string;
  slEntregas: TStringList;
  i, iOrden: Integer;
begin
  QueryStr := ' select empresa_tc, planta_origen_tc, centro_tc, fecha_tc, referencia_tc, planta_destino_tc, centro_destino_tc, ' +
      '         producto_tl, n_orden_tc, sum(cajas_tl) cajas_tl, sum(kilos_tl) kilos_tl ' +
      ' from frf_transitos_c,frf_transitos_l ';

  if AWhere <> '' then QueryStr := QueryStr + AWhere + ' and empresa_tc=empresa_tl '
  else QueryStr := QueryStr + ' where empresa_tc=empresa_tl ';

  QueryStr := QueryStr + ' and centro_tc=centro_tl ' +
      ' and fecha_tc=fecha_tl ' +
      ' and referencia_tc=referencia_tl ' +
      ' group by empresa_tc, planta_origen_tc, centro_tc, fecha_tc, referencia_tc, planta_destino_tc, centro_destino_tc, ' +
      '         producto_tl, n_orden_tc ' +
      ' order by empresa_tc desc,centro_tc desc,centro_destino_tc desc,fecha_tc desc, referencia_tc desc,producto_tl desc';

  QRLTransitos := TQRLTransitos.Create(Application);

  QRLTransitos.bPackingProveedor:= APaletsProveedor;

  PonLogoGrupoBonnysa(QRLTransitos);
  QRLTransitos.lbllPeriodo.Caption := ARange;
  try
    ConsultaOpen(QRLTransitos.QListado, QueryStr, False, False);

    if QRLTransitos.QListado.IsEmpty then
    begin
      ShowMessage('Listado sin datos.');
      FreeAndNil( QRLTransitos );
    end
    else
    begin
      with QRLTransitos.kmtListado do
      begin
        FieldDefs.Clear;
        FieldDefs.Add('empresa_tc', ftString, 3, False);
        FieldDefs.Add('planta_origen_tc', ftString, 3, False);
        FieldDefs.Add('centro_tc', ftString, 3, False);
        FieldDefs.Add('fecha_tc', ftDate, 0, False);
        FieldDefs.Add('referencia_tc', ftInteger, 0, False);
        FieldDefs.Add('planta_destino_tc', ftString, 3, False);
        FieldDefs.Add('centro_destino_tc', ftString, 3, False);
        FieldDefs.Add('producto_tl', ftString, 3, False);
        FieldDefs.Add('n_orden_tc', ftInteger, 0, False);
        FieldDefs.Add('entrega', ftString, 12, False);
        FieldDefs.Add('cajas_tl', ftFloat, 0, False);
        FieldDefs.Add('kilos_tl', ftFloat, 0, False);
        CreateTable;
        Open;
      end;
      if AEntrega then
      begin
        with QRLTransitos.qryEntregas do
        begin
          Sql.Clear;
          Sql.Add(' select orden_carga, producto, entrega ');
          Sql.Add(' from frf_transitos_c inner join rf_palet_pb on orden_carga = n_orden_tc ');
          Sql.Add( AWhereCab );
          Sql.Add(' group by 1, 2, 3 ');
          Sql.Add(' order by 1, 2, 3 ');
          Open;
        end;
      end;
      while not QRLTransitos.QListado.Eof do
      begin
        if AEntrega then
        begin
          iOrden:= QRLTransitos.QListado.FieldByName('n_orden_tc').AsInteger;
          sProducto:= QRLTransitos.QListado.FieldByName('producto_tl').AsString;
          if QRLTransitos.qryEntregas.Locate( 'orden_carga;producto',varArrayOf([iOrden,sProducto]), [] ) then
          begin
            //slEntregas:= TStringList.Create;
            while ( iOrden = QRLTransitos.qryEntregas.FieldByName('orden_carga').AsInteger ) and
                  ( sProducto = QRLTransitos.qryEntregas.FieldByName('producto').AsString ) and
                  ( not QRLTransitos.qryEntregas.Eof ) do
            begin
              QRLTransitos.kmtListado.Insert;
              QRLTransitos.kmtListado.FieldByName('empresa_tc').AsString:= QRLTransitos.QListado.FieldByName('empresa_tc').AsString;
              QRLTransitos.kmtListado.FieldByName('planta_origen_tc').AsString:= QRLTransitos.QListado.FieldByName('planta_origen_tc').AsString;
              QRLTransitos.kmtListado.FieldByName('centro_tc').AsString:= QRLTransitos.QListado.FieldByName('centro_tc').AsString;
              QRLTransitos.kmtListado.FieldByName('fecha_tc').AsDateTime:= QRLTransitos.QListado.FieldByName('fecha_tc').AsDateTime;
              QRLTransitos.kmtListado.FieldByName('referencia_tc').AsInteger:= QRLTransitos.QListado.FieldByName('referencia_tc').AsInteger;
              QRLTransitos.kmtListado.FieldByName('planta_destino_tc').AsString:= QRLTransitos.QListado.FieldByName('planta_destino_tc').AsString;
              QRLTransitos.kmtListado.FieldByName('centro_destino_tc').AsString:= QRLTransitos.QListado.FieldByName('centro_destino_tc').AsString;
              QRLTransitos.kmtListado.FieldByName('producto_tl').AsString:= QRLTransitos.QListado.FieldByName('producto_tl').AsString;
              QRLTransitos.kmtListado.FieldByName('n_orden_tc').AsInteger:= QRLTransitos.QListado.FieldByName('n_orden_tc').AsInteger;
              QRLTransitos.kmtListado.FieldByName('entrega').AsString:= QRLTransitos.qryEntregas.FieldByName('entrega').AsString;
              QRLTransitos.kmtListado.FieldByName('cajas_tl').AsFloat:= QRLTransitos.QListado.FieldByName('cajas_tl').AsFloat;
              QRLTransitos.kmtListado.FieldByName('kilos_tl').AsFloat:= QRLTransitos.QListado.FieldByName('kilos_tl').AsFloat;
              QRLTransitos.kmtListado.Post;

              //slEntregas.Add( QRLTransitos.QPaletPB.FieldByName('entrega').AsString );
              QRLTransitos.qryEntregas.Next;
            end;
            (*
            iOrden:= slEntregas.Count;
            for i:= 0 to iOrden - 1 do
            begin
              QRLTransitos.kmtListado.InsertRecord([
              QRLTransitos.QListado.FieldByName('empresa_tc').AsString,
              QRLTransitos.QListado.FieldByName('planta_origen_tc').AsString,
              QRLTransitos.QListado.FieldByName('centro_tc').AsString,
              QRLTransitos.QListado.FieldByName('fecha_tc').AsDateTime,
              QRLTransitos.QListado.FieldByName('referencia_tc').AsInteger,
              QRLTransitos.QListado.FieldByName('planta_destino_tc').AsString,
              QRLTransitos.QListado.FieldByName('centro_destino_tc').AsString,
              QRLTransitos.QListado.FieldByName('producto_tl').AsString,
              QRLTransitos.QListado.FieldByName('n_orden_tc').AsInteger,
              slEntregas[i],
              QRLTransitos.QListado.FieldByName('cajas_tl').AsFloat,
              QRLTransitos.QListado.FieldByName('kilos_tl').AsFloat ]);
            end;
            FreeAndNil( slEntregas );
            *)
            (*
            QRLTransitos.kmtListado.FieldByName('empresa_tc').AsString:= QRLTransitos.QListado.FieldByName('empresa_tc').AsString;
            QRLTransitos.kmtListado.FieldByName('planta_origen_tc').AsString:= QRLTransitos.QListado.FieldByName('planta_origen_tc').AsString;
            QRLTransitos.kmtListado.FieldByName('centro_tc').AsString:= QRLTransitos.QListado.FieldByName('centro_tc').AsString;
            QRLTransitos.kmtListado.FieldByName('fecha_tc').AsDateTime:= QRLTransitos.QListado.FieldByName('fecha_tc').AsDateTime;
            QRLTransitos.kmtListado.FieldByName('referencia_tc').AsInteger:= QRLTransitos.QListado.FieldByName('referencia_tc').AsInteger;
            QRLTransitos.kmtListado.FieldByName('planta_destino_tc').AsString:= QRLTransitos.QListado.FieldByName('planta_destino_tc').AsString;
            QRLTransitos.kmtListado.FieldByName('centro_destino_tc').AsString:= QRLTransitos.QListado.FieldByName('centro_destino_tc').AsString;
            QRLTransitos.kmtListado.FieldByName('producto_tl').AsString:= QRLTransitos.QListado.FieldByName('producto_tl').AsString;
            QRLTransitos.kmtListado.FieldByName('n_orden_tc').AsInteger:= QRLTransitos.QListado.FieldByName('n_orden_tc').AsInteger;
            QRLTransitos.kmtListado.FieldByName('entrega').AsString:= QRLTransitos.qryEntregas.FieldByName('entrega').AsString;
            QRLTransitos.kmtListado.FieldByName('cajas_tl').AsFloat:= QRLTransitos.QListado.FieldByName('cajas_tl').AsFloat;
            QRLTransitos.kmtListado.FieldByName('kilos_tl').AsFloat:= QRLTransitos.QListado.FieldByName('kilos_tl').AsFloat;
            QRLTransitos.kmtListado.Post;
            *)
          end
          else
          begin
            QRLTransitos.kmtListado.Insert;
            QRLTransitos.kmtListado.FieldByName('empresa_tc').AsString:= QRLTransitos.QListado.FieldByName('empresa_tc').AsString;
            QRLTransitos.kmtListado.FieldByName('planta_origen_tc').AsString:= QRLTransitos.QListado.FieldByName('planta_origen_tc').AsString;
            QRLTransitos.kmtListado.FieldByName('centro_tc').AsString:= QRLTransitos.QListado.FieldByName('centro_tc').AsString;
            QRLTransitos.kmtListado.FieldByName('fecha_tc').AsDateTime:= QRLTransitos.QListado.FieldByName('fecha_tc').AsDateTime;
            QRLTransitos.kmtListado.FieldByName('referencia_tc').AsInteger:= QRLTransitos.QListado.FieldByName('referencia_tc').AsInteger;
            QRLTransitos.kmtListado.FieldByName('planta_destino_tc').AsString:= QRLTransitos.QListado.FieldByName('planta_destino_tc').AsString;
            QRLTransitos.kmtListado.FieldByName('centro_destino_tc').AsString:= QRLTransitos.QListado.FieldByName('centro_destino_tc').AsString;
            QRLTransitos.kmtListado.FieldByName('producto_tl').AsString:= QRLTransitos.QListado.FieldByName('producto_tl').AsString;
            QRLTransitos.kmtListado.FieldByName('n_orden_tc').AsInteger:= QRLTransitos.QListado.FieldByName('n_orden_tc').AsInteger;
            QRLTransitos.kmtListado.FieldByName('entrega').AsString:= '';
            QRLTransitos.kmtListado.FieldByName('cajas_tl').AsFloat:= QRLTransitos.QListado.FieldByName('cajas_tl').AsFloat;
            QRLTransitos.kmtListado.FieldByName('kilos_tl').AsFloat:= QRLTransitos.QListado.FieldByName('kilos_tl').AsFloat;
            QRLTransitos.kmtListado.Post;
          end;
        end
        else
        begin
          QRLTransitos.kmtListado.Insert;
          QRLTransitos.kmtListado.FieldByName('empresa_tc').AsString:= QRLTransitos.QListado.FieldByName('empresa_tc').AsString;
          QRLTransitos.kmtListado.FieldByName('planta_origen_tc').AsString:= QRLTransitos.QListado.FieldByName('planta_origen_tc').AsString;
          QRLTransitos.kmtListado.FieldByName('centro_tc').AsString:= QRLTransitos.QListado.FieldByName('centro_tc').AsString;
          QRLTransitos.kmtListado.FieldByName('fecha_tc').AsDateTime:= QRLTransitos.QListado.FieldByName('fecha_tc').AsDateTime;
          QRLTransitos.kmtListado.FieldByName('referencia_tc').AsInteger:= QRLTransitos.QListado.FieldByName('referencia_tc').AsInteger;
          QRLTransitos.kmtListado.FieldByName('planta_destino_tc').AsString:= QRLTransitos.QListado.FieldByName('planta_destino_tc').AsString;
          QRLTransitos.kmtListado.FieldByName('centro_destino_tc').AsString:= QRLTransitos.QListado.FieldByName('centro_destino_tc').AsString;
          QRLTransitos.kmtListado.FieldByName('producto_tl').AsString:= QRLTransitos.QListado.FieldByName('producto_tl').AsString;
          QRLTransitos.kmtListado.FieldByName('n_orden_tc').AsInteger:= QRLTransitos.QListado.FieldByName('n_orden_tc').AsInteger;
          QRLTransitos.kmtListado.FieldByName('entrega').AsString:= '';
          QRLTransitos.kmtListado.FieldByName('cajas_tl').AsFloat:= QRLTransitos.QListado.FieldByName('cajas_tl').AsFloat;
          QRLTransitos.kmtListado.FieldByName('kilos_tl').AsFloat:= QRLTransitos.QListado.FieldByName('kilos_tl').AsFloat;
          QRLTransitos.kmtListado.Post;
        end;
        QRLTransitos.QListado.Next;
      end;
      QRLTransitos.QListado.Close;
      QRLTransitos.qryEntregas.Close;

      QRLTransitos.kmtListado.First;
      if APaletsProveedor then
      begin
        QRLTransitos.QPaletPB.SQL.Clear;
        QRLTransitos.QPaletPB.SQL.Add(' select entrega, sscc, status, proveedor, producto, variedad, calibre, peso, cajas, tipo_palet');
        QRLTransitos.QPaletPB.SQL.Add(' from rf_palet_pb');
        QRLTransitos.QPaletPB.SQL.Add(' Where orden_carga = :n_orden_tc ');
        QRLTransitos.QPaletPB.SQL.Add(' and producto = :producto_tl ');
        QRLTransitos.QPaletPB.SQL.Add(' order by entrega, status, SSCC ');
        QRLTransitos.QPaletPB.Open;
      end;
      QRLTransitos.qrlblEntrega.Enabled:= AEntrega;
      QRLTransitos.qrdbtxtEntrega.Enabled:= AEntrega;
      try
        DPreview.Preview(QRLTransitos);
      except
        FreeAndNil( QRLTransitos );
      end;
    end;
  except
    FreeAndNil(QRLTransitos);
  end;
end;

procedure TQRLTransitos.bndCapPaletPBBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:= bPackingProveedor and ( not QPaletPB.IsEmpty );
end;

end.
