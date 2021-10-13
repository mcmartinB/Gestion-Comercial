unit BajarReclamacionesFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFDBajarReclamaciones = class(TForm)
    btnBajar: TButton;
    btnCerrar: TButton;
    lblMensaje: TLabel;
    procedure btnBajarClick(Sender: TObject);
    procedure btnCerrarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    bPrimeraVez, bLiberarDMWEB: Boolean;

    function  BajarReclamacion( var AMsgError: String ): Integer;
    function  InsertarReclamacion( var AMsgError: String ): Integer;
    procedure MarcarBajado;
    procedure BajarImagenes( var AMsgError: String );
    procedure AnyadeImagen( const AImagen: string );
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses WEBDM, bSQLUtils;

function TFDBajarReclamaciones.InsertarReclamacion( var AMsgError: String ): Integer;
begin
  with DMWEB do
  begin
   QReclamaciones.Insert;
   QReclamacionesempresa_rcl.AsString:= UPPERCASE(QReclamacionesRemotoempresa_r.AsString);
   QReclamacionescliente_rcl.AsString:= UPPERCASE(QReclamacionesRemotocliente_r.AsString);
   QReclamacionesn_reclamacion_rcl.AsInteger:= QReclamacionesRemoton_reclamacion_r.AsInteger;
   QReclamacionesemail_rcl.AsString:= QReclamacionesRemotoemail_r.AsString;
   QReclamacionesnombre_rcl.AsString:= UPPERCASE(QReclamacionesRemotonombre_r.AsString);
   QReclamacionesfecha_rcl.AsDateTime:= QReclamacionesRemotofecha_r.AsDateTime;
   QReclamacioneshora_rcl.AsString:= QReclamacionesRemotohora_r.AsString;
   QReclamacionesn_pedido_rcl.AsInteger:= QReclamacionesRemoton_pedido_r.AsInteger;
   QReclamacionesn_albaran_rcl.AsInteger:= QReclamacionesRemoton_albaran_r.AsInteger;
   QReclamacionesfecha_albaran_rcl.AsDateTime:= QReclamacionesRemotofecha_albaran_r.AsDateTime;
   QReclamacionesproducto_rcl.AsString:= UPPERCASE(QReclamacionesRemotoproducto_r.AsString);
   QReclamacionesidioma_rcl.AsString:= LOWERCASE(QReclamacionesRemotoidioma_r.AsString);
   QReclamacionescaj_kgs_uni_rcl.AsString:= UPPERCASE(QReclamacionesRemotocaj_kgs_uni_r.AsString);
   QReclamacionescantidad_rcl.AsInteger:= QReclamacionesRemotocantidad_r.AsInteger;
   QReclamacionesporc_rajado_rcl.AsInteger:= QReclamacionesRemotoporc_rajado_r.AsInteger;
   QReclamacionesporc_mancha_rcl.AsInteger:= QReclamacionesRemotoporc_mancha_r.AsInteger;
   QReclamacionesporc_blando_rcl.AsInteger:= QReclamacionesRemotoporc_blando_r.AsInteger;
   QReclamacionesporc_moho_rcl.AsInteger:= QReclamacionesRemotoporc_moho_r.AsInteger;
   QReclamacionesporc_color_rcl.AsInteger:= QReclamacionesRemotoporc_color_r.AsInteger;
   QReclamacionesporc_otros_rcl.AsInteger:= QReclamacionesRemotoporc_otros_r.AsInteger;
   QReclamacionesdescripcion_otros_rcl.AsString:= QReclamacionesRemotodescripcion_otros_r.AsString;
   QReclamacionesn_devolucion_rcl.AsInteger:= QReclamacionesRemoton_devolucion_r.AsInteger;
   QReclamacionest_devolucion_rcl.AsString:= QReclamacionesRemotot_devolucion_r.AsString;
   QReclamacionesn_reseleccion_rcl.AsInteger:= QReclamacionesRemoton_reseleccion_r.AsInteger;
   QReclamacionest_reseleccion_rcl.AsString:= QReclamacionesRemotot_reseleccion_r.AsString;
   QReclamacionesn_reventa_rcl.AsInteger:= QReclamacionesRemoton_reventa_r.AsInteger;
   QReclamacionest_reventa_rcl.AsString:= QReclamacionesRemotot_reventa_r.AsString;
   QReclamacionesn_otros_rcl.AsInteger:= QReclamacionesRemoton_otros_r.AsInteger;
   QReclamacionest_otros_rcl.AsString:= QReclamacionesRemotot_otros_r.AsString;
   QReclamacionesobservacion_rcl.AsString:= QReclamacionesRemotoobservacion_r.AsString;
   QReclamacionesstatus_r.AsString:= UPPERCASE(QReclamacionesRemotostatus_r.AsString);
   QReclamacionesdescargado_r.AsString:= UPPERCASE(QReclamacionesRemotodescargado_r.AsString);
   try
     QReclamaciones.Post;
     MarcarBajado;
     result:= -1;
   except
     on E: Exception do
     begin
       result:= QReclamacionesRemoton_reclamacion_r.AsInteger;
       AMsgError:= e.message;
     end;
   end;
  end;
end;


procedure TFDBajarReclamaciones.MarcarBajado;
begin
  with DMWEB do
  begin
    QMarcarReclamaRemoto.ParamByName('empresa').AsString:=
      QReclamacionesRemotoempresa_r.AsString;
    QMarcarReclamaRemoto.ParamByName('cliente').AsString:=
      QReclamacionesRemotocliente_r.AsString;
    QMarcarReclamaRemoto.ParamByName('reclama').AsInteger:=
      QReclamacionesRemoton_reclamacion_r.AsInteger;
    QMarcarReclamaRemoto.ExecSQL;
  end;
end;

procedure TFDBajarReclamaciones.AnyadeImagen( const AImagen: string );
begin
  with DMWEB do
  begin
    QReclamaFotos.Insert;
    QReclamaFotosempresa_rft.AsString:= QReclamacionesRemotoempresa_r.AsString;
    QReclamaFotoscliente_rft.AsString:= QReclamacionesRemotocliente_r.AsString;
    QReclamaFotosn_reclamacion_rft.Asinteger:= QReclamacionesRemoton_reclamacion_r.AsInteger;
    QReclamaFotosfichero_rft.AsString:= AImagen;
    QReclamaFotos.Post;
  end;
end;

procedure TFDBajarReclamaciones.BajarImagenes( var AMsgError: String );
var
  sListaMsg: TStringList;
  sImagen: String;
begin
  sListaMsg:= TStringList.Create;
  with DMWEB do
  begin
    QImagenesRemoto.ParamByName('empresa').AsString:= QReclamacionesRemotoempresa_r.AsString;
    QImagenesRemoto.ParamByName('cliente').AsString:= QReclamacionesRemotocliente_r.AsString;
    QImagenesRemoto.ParamByName('reclama').AsInteger:= QReclamacionesRemoton_reclamacion_r.AsInteger;
    QImagenesRemoto.Open;
    while not QImagenesRemoto.Eof do
    begin
      try
        sImagen:= DMWEB.FTPDownloadImagen( QImagenesRemoto.FieldByName('fichero_fr').AsString,
          QReclamacionesRemotoempresa_r.AsString, QReclamacionesRemotocliente_r.AsString,
          QReclamacionesRemoton_reclamacion_r.AsInteger );
        AnyadeImagen( sImagen );
        //DMWEB.FTPBorrarImagen( QImagenesRemoto.FieldByName('fichero_fr').AsString );
      except
        on e: exception do
        begin
          sListaMsg.Add( e.Message );
        end;
      end;
      QImagenesRemoto.Next;
    end;
    (*
    try
      DMWEB.FTPBorrarDirectorio( QImagenesRemoto.FieldByName('fichero_fr').AsString );
    except
      on e: exception do
      begin
        sListaMsg.Add( e.Message );
      end;
    end;
    *)
    QImagenesRemoto.Close;
  end;
  FreeAndNil( sListaMsg );
end;

function TFDBajarReclamaciones.BajarReclamacion( var AMsgError: String ): Integer;
var
  //sImagen,
  sError: string;
begin
  result:= InsertarReclamacion( AMsgError );
  if AMsgError = '' then
  begin
    sError:= '';
    BajarImagenes( sError );
    if sError <> '' then
    begin
      AMsgError:= 'ERROR RECLAMACION [' +
        DMWEB.QReclamacionesRemoton_reclamacion_r.AsString +
          '] IMAGENES';
      AMsgError:= AMsgError + #13 + #10 + sError;
    end;
  end;
end;

procedure TFDBajarReclamaciones.btnBajarClick(Sender: TObject);
var
  sMsgError: String;
  iInsertados, iErroneos, iReclamacionErronea: integer;
  sListaErrores: TStringList;
begin
  iInsertados:= 0;
  iErroneos:= 0;
  sListaErrores:= TStringList.Create;

  DMWEB.QReclamacionesRemoto.Open;
  if not DMWEB.QReclamacionesRemoto.IsEmpty then
  begin
    DMWEB.QReclamaFotos.SQL.Clear;
    DMWEB.QReclamaFotos.SQL.Add(' SELECT * ');
    DMWEB.QReclamaFotos.SQL.Add(' FROM frf_reclama_fotos ');
    DMWEB.QReclamaFotos.Open;

    DMWEB.QReclamaciones.Open;
    DMWEB.QReclamacionesRemoto.First;
  end;
  while not DMWEB.QReclamacionesRemoto.Eof do
  begin
    sMsgError:= '';
    iReclamacionErronea:= BajarReclamacion( sMsgError );
    if iReclamacionErronea < 0 then
    begin
      Inc( iInsertados );
      if sMsgError <> '' then
      begin
        sListaErrores.Add( sMsgError );
      end;
    end
    else
    begin
      Inc( iErroneos );
      sListaErrores.Add( 'ERROR[' + IntToStr( iErroneos ) +  ']' );
      sListaErrores.Add( 'RECLAMACION Nº' + IntToStr( iReclamacionErronea ) );
      sListaErrores.Add( sMsgError );
    end;
    DMWEB.QReclamacionesRemoto.Next;
  end;
  DMWEB.QReclamaFotos.Close;
  DMWEB.QReclamaciones.Close;
  DMWEB.QReclamacionesRemoto.Close;

  btnBajar.Enabled:= False;
  if sListaErrores.Count > 0 then
  begin
    lblMensaje.Caption:= IntToStr( iInsertados ) + '/' + IntToStr( iInsertados + iErroneos ) + ' Reclamaciones bajadas.' ;
    ShowMessage( sListaErrores.Text );
  end
  else
  begin
    lblMensaje.Caption:= 'Proceso finalizado con éxito.';
  end;
  FreeAndNil( sListaErrores );
end;

procedure TFDBajarReclamaciones.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFDBajarReclamaciones.FormActivate(Sender: TObject);
begin
  if bPrimeraVez then
  begin
    bPrimeraVez:= False;
    if DMWEB = nil then
    begin
      DMWEB:= TDMWEB.Create( self );
      bLiberarDMWEB:= True;
    end
    else
    begin
      bLiberarDMWEB:= false;
    end;
    try
      DMWEB.BDWEB.Connected:= true;
    except
      ShowMessage('ERROR: No puedo conectar con la Base de Datos Remota.');
    end;
    DMWEB.QNumReclamacionesRemoto.Open;
    if DMWEB.QNumReclamacionesRemoto.Fields[0].AsInteger > 0 then
    begin
      if DMWEB.QNumReclamacionesRemoto.Fields[0].AsInteger = 1 then
        lblMensaje.Caption:= 'ATENCIÓN, queda una reclamación por bajar.'
      else
        lblMensaje.Caption:= 'ATENCIÓN, quedan ' + DMWEB.QNumReclamacionesRemoto.Fields[0].AsString + ' reclamaciones por bajar.';
      DMWEB.QNumReclamacionesRemoto.Close;
      btnBajar.Enabled:= True;
    end
    else
    begin
      DMWEB.QNumReclamacionesRemoto.Close;
      lblMensaje.Caption:= 'No hay  nuevas reclamaciones.';
    end;
  end;
end;

procedure TFDBajarReclamaciones.FormCreate(Sender: TObject);
begin
  bPrimeraVez:= true;
end;

procedure TFDBajarReclamaciones.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if bLiberarDMWEB and ( DMWEB <> nil ) then
    FreeAndNil( DMWEB );
end;

end.

