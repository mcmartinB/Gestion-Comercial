unit CFPCamionEntrega;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, nbCombos, StdCtrls, nbEdits, nbLabels, Buttons, DB, kbmMemTable,
  ExtCtrls, Grids, DBGrids;

type
  TFPCamionEntrega = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    nbLabel1: TnbLabel;
    nbLabel2: TnbLabel;
    eAlbaran: TnbDBAlfa;
    eFecha: TnbDBCalendarCombo;
    TMemEntregas: TkbmMemTable;
    nbLabel3: TnbLabel;
    eKilosLleno: TnbDBAlfa;
    nbLabel4: TnbLabel;
    eKilosVacio: TnbDBAlfa;
    eEntrega: TnbDBSQLCombo;
    nbLabel5: TnbLabel;
    DBGrid1: TDBGrid;
    btnAnyadir: TSpeedButton;
    Bevel1: TBevel;
    DSMemEntregas: TDataSource;
    nbLabel6: TnbLabel;
    lblKilosProducto: TLabel;
    lblTransporte: TnbLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function eEntregaGetSQL: String;
    procedure btnAnyadirClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure eKilosLlenoChange(Sender: TObject);
    procedure eEntregaChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    bAceptar: Boolean;

    sEmpresa, sTransporte: String;
    sProveedor, sAlmacen, sFechaCarga, sAlbaran, sMatricula: string;
    rKilosLleno, rKilosProducto: real;
    iPaletsTotales, iPaletsEntrega: integer;
    dFechaLlegada: TDateTime;

    function  ValidarValues: boolean;
    function  ExisteEntrega( const AEntrega: string ): boolean;
    procedure ActualizarKilos;

    procedure ActualizarEntregas;
    procedure ActualizarEntrega;

    function  TodasEntradasTienenPalet: boolean;
    function  TodasEntradasConKilos: boolean;

    //procedure RepercutirPesosRF( const AEntrega: string; const AKilos: Real );
    //procedure RepercutirPesosLineas( const AEntrega: string; const AKilos: Real );
    procedure RepercutirPesosEntregas( const AEntrega: string; const AKilos: Real );

  public
    { Public declarations }
    procedure LoadValues( const AEmpresa, AEntrega, AAlbaran, AFecha, ATransporte, ALleno, AVacio: string );

  end;

  function ExecuteDescargarEntrega( const AOwner: TComponent;
             const AEmpresa, AEntrega, AAlbaran, AFecha, ATransporte, ALleno, AVacio: string ): boolean;

implementation

{$R *.dfm}

uses
  bMath, UDMBaseDatos, CDBEntregas, DBTables, UDMAuxDB;

var
  FPCamionEntrega: TFPCamionEntrega;

function ExecuteDescargarEntrega( const AOwner: TComponent;
            const AEmpresa, AEntrega, AAlbaran, AFecha, ATransporte, ALleno, AVacio: string ): boolean;
begin
  FPCamionEntrega:= TFPCamionEntrega.Create( AOwner );
  try
    FPCamionEntrega.LoadValues( AEmpresa, AEntrega, AAlbaran, AFecha, ATransporte, ALleno, AVacio );
    FPCamionEntrega.ShowModal;
  finally
    result:= FPCamionEntrega.bAceptar;
    FreeAndNil(FPCamionEntrega );
  end;
end;

procedure TFPCamionEntrega.FormCreate(Sender: TObject);
begin
  CDBEntregas.InicializarModulo( self, DMBaseDatos.DBBaseDatos.DatabaseName );

  TMemEntregas.FieldDefs.Clear;
  TMemEntregas.FieldDefs.Add('entrega', ftString, 12, False);
  TMemEntregas.FieldDefs.Add('albaran', ftString, 10, False);
  TMemEntregas.FieldDefs.Add('proveedor', ftString, 3, False);
  TMemEntregas.FieldDefs.Add('fecha', ftDate, 0, False);

  TMemEntregas.FieldDefs.Add('paletsTotal', ftInteger, 0, False);
  TMemEntregas.FieldDefs.Add('kilosTotal', ftFloat, 0, False);

  TMemEntregas.FieldDefs.Add('paletsEntrega', ftInteger, 0, False);
  TMemEntregas.FieldDefs.Add('kilosEntrega', ftFloat, 0, False);

  TMemEntregas.FieldDefs.Add('matricula', ftString, 20, False);



  TMemEntregas.IndexFieldNames:= 'entrega';
  TMemEntregas.CreateTable;
  TMemEntregas.Open;

  bAceptar:= False;

  rKilosProducto:= 0;
  rKilosLleno:= 0;
  iPaletsTotales:= 0;


end;

procedure TFPCamionEntrega.FormDestroy(Sender: TObject);
begin
  CDBEntregas.FinalizarModulo;
end;

function TFPCamionEntrega.TodasEntradasTienenPalet: boolean;
begin
  result:= True;
  TMemEntregas.First;
  while not TMemEntregas.Eof and result do
  begin
    result:= TMemEntregas.FieldByName('paletsEntrega').AsFloat > 0;
    TMemEntregas.Next;
  end;
end;

function TFPCamionEntrega.TodasEntradasConKilos: boolean;
begin
  result:= True;
  TMemEntregas.First;
  while not TMemEntregas.Eof and result do
  begin
    result:= not ExisteLineaSinKilos( TMemEntregas.FieldByName('entrega').AsString );
    TMemEntregas.Next;
  end;
end;

procedure TFPCamionEntrega.btnAceptarClick(Sender: TObject);
begin
  if not TMemEntregas.IsEmpty then
  begin
    if TodasEntradasTienenPalet then
    begin
      if TodasEntradasConKilos then
      begin
        ActualizarEntregas;
        bAceptar:= True;
        Close;
      end
      else
      begin
        ShowMessage('Una de las entregas seleccinadas tiene lineas sin kilos teoricos, por favor solucione este problema antes de asignar los kilos.');
      end;
    end
    else
    begin
      ShowMessage('Una de las entregas seleccinadas no tiene palets, por favor solucione este problema antes de asignar los kilos.');
    end;
  end
  else
  begin
    ShowMessage('Es necesario por lo menos introducir una entrega.');
  end;
end;

procedure TFPCamionEntrega.btnCancelarClick(Sender: TObject);
begin
   bAceptar:= False;
   Close;
end;

procedure TFPCamionEntrega.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caHide;
end;

procedure TFPCamionEntrega.LoadValues( const AEmpresa, AEntrega, AAlbaran, AFecha, ATransporte, ALleno, AVacio: string );
begin
  sEmpresa:= AEmpresa;
  sTransporte:= ATransporte;

  eAlbaran.Text:= AAlbaran;
  eFecha.AsDate:= StrToDateDef( AFecha, Date );
  eKilosLleno.Text:= ALleno;
  eKilosVacio.Text:= AVacio;
  eEntrega.Text:= AEntrega;

  lblTransporte.Caption:= desTransporte( sEmpresa, sTransporte );
end;

function TFPCamionEntrega.ExisteEntrega( const AEntrega: string ): boolean;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select proveedor_ec, almacen_ec, fecha_carga_ec, albaran_ec, vehiculo_ec ');
    SQL.Add(' from frf_entregas_c ');
    SQL.Add(' where codigo_ec = :entrega ');
    ParamByName('entrega').AsString:= AEntrega;
    Open;
    result:= not IsEmpty;
    if result then
    begin
      sProveedor:= FieldByName('proveedor_ec').AsString;
      sAlmacen:= FieldByName('almacen_ec').AsString;
      sFechaCarga:= FieldByName('fecha_carga_ec').AsString;
      sAlbaran:= FieldByName('albaran_ec').AsString;
      sMatricula:= FieldByName('vehiculo_ec').AsString;

      Close;

      SQL.Clear;
      (*
      SQL.Add(' select sum(palets_el) palets_entrega ');
      SQL.Add(' from frf_entregas_l ');
      SQL.Add(' where codigo_el = :entrega ');
      *)
      SQL.Add(' select count( distinct sscc ) palets_entrega ');
      SQL.Add(' from rf_palet_pb ');
      SQL.Add(' where entrega = :entrega ');
      ParamByName('entrega').AsString:= AEntrega;
      Open;
      iPaletsEntrega:= FieldByName('palets_entrega').AsInteger;
      Close;
    end
    else
    begin
      Close;

      sProveedor:= '';
      sAlmacen:= '';
      sFechaCarga:= '';
      sAlbaran:= '';
      sMatricula:= '';
    end;
  end;
end;

function TFPCamionEntrega.ValidarValues: boolean;
var
  rLleno, rVacio: Single;
begin
  result:= False;
  if not TryStrToDate( eFecha.Text, dFEchaLlegada ) then
  begin
    ShowMessage('Fecha incorrecta.');
  end
  else
  if not TryStrToFloat( eKilosLleno.Text, rLleno ) then
  begin
    ShowMessage('Peso camión lleno incorrecto.');
  end
  else
  if not TryStrToFloat( eKilosVacio.Text, rVacio ) then
  begin
    ShowMessage('Peso camión vacio incorrecto.');
  end
  else
  if Trim( eEntrega.Text ) = '' then
  begin
    ShowMessage('Falta el código de la entrega.');
  end
  else
  if TMemEntregas.Locate('entrega', eEntrega.Text, [] ) then
  begin
    ShowMessage('La entrega seleccionada ya ha sido añadida.');
  end
  else
  if not ExisteEntrega( eEntrega.Text ) then
  begin
    ShowMessage('No existe la entrega seleccionada.');
  end
  else
  if Trim( eAlbaran.Text ) = '' then
  begin
    ShowMessage('Falta el numero de albarán del proveedor.');
  end
  else
  if ( sAlbaran <> eAlbaran.Text ) and CDBEntregas.ExisteAlbaranProveedor( sEmpresa, sProveedor, sAlmacen, sFechaCarga, eAlbaran.Text ) then
  begin
    ShowMessage('Albarán de proveedor duplicado.');
  end
  else
  if TMemEntregas.Locate('albaran', eAlbaran.Text, [] ) then
  begin
    ShowMessage('El albaran seleccionado ya ha sido añadido.');
  end
  else
  if eKilosLleno.Enabled and  ( ( rLLeno - rVacio ) <= 0  )then
  begin
    if ( rLLeno - rVacio ) < 0 then
    begin
      ShowMessage('La diferencia entre el peso del camión lleno y vacio no puede ser menor de 0.');
    end
    else
    begin
      result:= Application.MessageBox('La diferencia entre el peso del camión lleno y vacio es igual a 0.' + #13 + #10 +
                           '¿Esta seguro de querer continuar? ','SIN KILOS PARA ASIGNAR', MB_YESNO ) = idyes;
    end;
  end
(*
  else
  if iPaletsEntrega = 0 then
  begin
    ShowMessage('No se puede añadir una entrega sin palets.');
  end
*)
  else
  begin
    result:= True;
  end;
end;

function TFPCamionEntrega.eEntregaGetSQL: String;
begin
  result:= ' select codigo_ec codigo, fecha_origen_ec fecha, ' +
           '        proveedor_ec proveedor, nombre_pa almacen, ' +
           '        vehiculo_ec matricula ' +
           ' from frf_entregas_c, frf_proveedores_almacen ' +
           ' where empresa_ec = ' + QuotedStr( sEmpresa ) +
           ' and transporte_ec = ' + sTransporte +
           ' and ( status_ec = 0 or peso_salida_ec = 0 )' +
           ' and proveedor_pa = proveedor_ec ' +
           ' and almacen_pa = almacen_ec ' +
           ' order by codigo_ec ';
end;

procedure TFPCamionEntrega.btnAnyadirClick(Sender: TObject);
begin
  if ValidarValues then
  begin
    TMemEntregas.Insert;

    TMemEntregas.FieldByName('entrega').AsString:= eEntrega.Text;
    TMemEntregas.FieldByName('albaran').AsString:= eAlbaran.Text;
    TMemEntregas.FieldByName('proveedor').AsString:= sProveedor;
    TMemEntregas.FieldByName('fecha').AsDateTime:= StrToDate( eFecha.Text );

    TMemEntregas.FieldByName('paletsTotal').AsInteger:= 0;
    TMemEntregas.FieldByName('kilosTotal').AsFloat:= rKilosProducto;
    TMemEntregas.FieldByName('paletsEntrega').AsInteger:= iPaletsEntrega;
    TMemEntregas.FieldByName('kilosEntrega').AsInteger:= 0;

    TMemEntregas.FieldByName('matricula').AsString:= sMatricula;

    TMemEntregas.Post;

    iPaletsTotales:=  iPaletsTotales + iPaletsEntrega;
    ActualizarKilos;

    eEntrega.SetFocus;
    eFecha.Enabled:= False;
    eKilosLleno.Enabled:= False;
    eKilosVacio.Enabled:= False;
  end;
end;

procedure TFPCamionEntrega.eKilosLlenoChange(Sender: TObject);
var
  rAux: real;
begin
  //Calcular kilos producto
  rKilosLleno:= StrToFloatDef( eKilosLleno.Text,  0 );
  rAux:= StrToFloatDef( eKilosVacio.Text, 0 );
  rKilosProducto:= rKilosLleno - rAux;
  lblKilosProducto.Caption:= FormatFloat( '#,##0.00', rKilosProducto );
end;

procedure TFPCamionEntrega.ActualizarKilos;
var
  Bookmark: TBookmark;
  rAux: real;
begin
  TMemEntregas.DisableControls;
  try
    Bookmark:= TMemEntregas.GetBookmark;
    TMemEntregas.First;
    rAux:= 0;
    while not TMemEntregas.Eof do
    begin
      TMemEntregas.Edit;
      TMemEntregas.FieldByName('paletsTotal').AsFloat:= iPaletsTotales;
      if iPaletsTotales = 0 then
        TMemEntregas.FieldByName('kilosEntrega').AsFloat:= 0
      else
        TMemEntregas.FieldByName('kilosEntrega').AsFloat:=
                     bRoundTo( ( rKilosProducto * TMemEntregas.FieldByName('paletsEntrega').AsInteger ) / iPaletsTotales, -2 );
      rAux:= rAux + TMemEntregas.FieldByName('kilosEntrega').AsFloat;
      TMemEntregas.Post;
      TMemEntregas.Next;
    end;

    rAux:= bRoundTo( rKilosProducto - rAux, -2 );
    if rAux <> 0 then
    begin
      TMemEntregas.Edit;
      TMemEntregas.FieldByName('kilosEntrega').AsFloat:=
                     TMemEntregas.FieldByName('kilosEntrega').AsFloat + rAux;
      TMemEntregas.Post;
    end;

    TMemEntregas.GotoBookmark( Bookmark );
    TMemEntregas.FreeBookmark( Bookmark );
  finally
    TMemEntregas.EnableControls;
  end;
end;

procedure TFPCamionEntrega.ActualizarEntregas;
begin
  TMemEntregas.DisableControls;
  try
    TMemEntregas.First;
    while not TMemEntregas.Eof do
    begin
      ActualizarEntrega;
      TMemEntregas.Next;
    end;
  finally
    TMemEntregas.EnableControls;
  end;
end;

procedure TFPCamionEntrega.ActualizarEntrega;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add( ' update frf_entregas_c ');
    SQL.Add( ' set albaran_ec = :albaran, ');
    SQL.Add( '     fecha_llegada_ec = :fechallegada, ');
    SQL.Add( '     peso_entrada_ec = :pesolleno, ');
    SQL.Add( '     peso_salida_ec = :pesolleno - :pesoproducto, ');
    SQL.Add( '     status_ec = 1 ');
    SQL.Add( ' where codigo_ec =  :entrega ');

    ParamByName('entrega').AsString:= TMemEntregas.fieldByName('entrega').AsString;
    ParamByName('albaran').AsString:= TMemEntregas.fieldByName('albaran').AsString;
    ParamByName('fechallegada').AsDateTime:= dFEchaLlegada;
    ParamByName('pesolleno').AsFloat:= rKilosLleno;
    ParamByName('pesoproducto').AsFloat:= TMemEntregas.fieldByName('kilosEntrega').AsFloat;

    ExecSQL;

    RepercutirPesosEntregas( TMemEntregas.fieldByName('entrega').AsString, TMemEntregas.fieldByName('kilosEntrega').AsFloat );
    //RepercutirPesosLineas( TMemEntregas.fieldByName('entrega').AsString, TMemEntregas.fieldByName('kilosEntrega').AsFloat );
    //RepercutirPesosRF( TMemEntregas.fieldByName('entrega').AsString, TMemEntregas.fieldByName('kilosEntrega').AsFloat );
  end;
end;

procedure TFPCamionEntrega.eEntregaChange(Sender: TObject);
begin
  //seelccionar nuemro de albaran
  eAlbaran.Text:= CDBEntregas.GetNumeroAlbaran( eEntrega.Text );
end;

(*TODO*)
(*Repartir segun el peso de la caja si tiene diferentes envases*)
(*
procedure TFPCamionEntrega.RepercutirPesosRF( const AEntrega: string; const AKilos: Real );
begin
  CDBEntregas.RepercutirPesosPaletsPB( AEntrega, AKilos );
end;
*)

(*
procedure TFPCamionEntrega.RepercutirPesosLineas( const AEntrega: string; const AKilos: Real );
begin
  CDBEntregas.RepercutirPesosLineas( AEntrega, AKilos );
end;
*)

procedure TFPCamionEntrega.RepercutirPesosEntregas( const AEntrega: string; const AKilos: Real );
begin
  CDBEntregas.RepercutirPesosEntrega( AEntrega, AKilos );
end;

procedure TFPCamionEntrega.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    vk_f1:
    begin
      Key:= 0;
      btnAceptar.Click;
    end;
    vk_escape:
    begin
      Key:= 0;
      btnCancelar.Click;
    end;
    vk_add, ord('+'):
    begin
      Key:= 0;
      btnAnyadir.Click;
    end;
  end;
end;

end.


