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
    nbLabel5: TnbLabel;
    DBGrid1: TDBGrid;
    btnAnyadir: TSpeedButton;
    Bevel1: TBevel;
    DSMemEntregas: TDataSource;
    nbLabel6: TnbLabel;
    lblKilosProducto: TLabel;
    lblTransporte: TnbLabel;
    eEntrega: TComboBox;
    btnBorrar: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAnyadirClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure eKilosLlenoChange(Sender: TObject);
    procedure edtcodigo_ecChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnBorrarClick(Sender: TObject);
  private
    { Private declarations }
    bAceptar: Boolean;

    sEmpresa, sTransporte: String;
    sProveedor, sFechaCarga, sAlbaran, sMatricula: string;
    rKilosCamionLleno, rKilosCamion, rKilosTotales: real;
    dFechaLlegada: TDateTime;

    function  ValidarValues: boolean;
    function  ExisteEntrega( const AEntrega: string ): boolean;
    procedure ActualizarKilos;

    procedure ActualizarEntregas;
    procedure ActualizarEntrega;
    procedure MarcarDescarga( const AEntrega: string );

    function  TodasEntradasConKilos: boolean;
    function  ValidarRF( var VMsg: string ): boolean;
    function  ValidarKilosTotales( var VMsg: string ): Boolean;

    //procedure RepercutirPesosRF( const AEntrega: string; const AKilos: Real );
    //procedure RepercutirPesosLineas( const AEntrega: string; const AKilos: Real );
    procedure RepercutirPesosEntregas( const AEntrega: string; const AKilosTeoricos, AKilosReales: Real );

  public
    { Public declarations }
    procedure LoadValues( const AEmpresa, AEntrega, AAlbaran, AFecha, AMatricula, ATransporte, ALleno, AVacio: string );

  end;

  function ExecuteDescargarEntrega( const AOwner: TComponent;
             const AEmpresa, AEntrega, AAlbaran, AFecha, AMatricula, ATransporte, ALleno, AVacio: string ): boolean;

implementation

{$R *.dfm}

uses
  bMath, UDMBaseDatos, CDBEntregas, DBTables, UDMAuxDB, AdvertenciaFD;

var
  FPCamionEntrega: TFPCamionEntrega;

function ExecuteDescargarEntrega( const AOwner: TComponent;
            const AEmpresa, AEntrega, AAlbaran, AFecha, Amatricula, ATransporte, ALleno, AVacio: string ): boolean;
begin
  FPCamionEntrega:= TFPCamionEntrega.Create( AOwner );
  try
    FPCamionEntrega.LoadValues( AEmpresa, AEntrega, AAlbaran, AFecha, Amatricula, ATransporte, ALleno, AVacio );
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

  TMemEntregas.FieldDefs.Add('kilosCamion', ftFloat, 0, False);
  TMemEntregas.FieldDefs.Add('kilosTeoricos', ftFloat, 0, False);
  TMemEntregas.FieldDefs.Add('porcentaje', ftFloat, 0, False);
  TMemEntregas.FieldDefs.Add('kilosReales', ftFloat, 0, False);

  TMemEntregas.FieldDefs.Add('matricula', ftString, 20, False);



  TMemEntregas.IndexFieldNames:= 'entrega';
  TMemEntregas.CreateTable;
  TMemEntregas.Open;

  bAceptar:= False;

  rKilosCamion:= 0;
  rKilosCamionLleno:= 0;
  rKilosTotales:= 0;
end;

procedure TFPCamionEntrega.FormDestroy(Sender: TObject);
begin
  CDBEntregas.FinalizarModulo;
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

function TFPCamionEntrega.ValidarRF( var VMsg: string ): boolean;
begin
  vMsg:= '';

  DMBaseDatos.QAux.SQL.Clear;
  DMBaseDatos.QAux.SQL.Add('select entrega, proveedor, producto, variedad,  descripcion_pp, case when cajas = 0 then 0 else round( peso/cajas ) end peso_caja  ');
  DMBaseDatos.QAux.SQL.Add('from rf_palet_pb left join frf_productos_proveedor on proveedor_pp = proveedor and producto_pp = producto and  variedad_pp = variedad  ');
  DMBaseDatos.QAux.SQL.Add('where entrega =  :entrega  ');
  DMBaseDatos.QAux.SQL.Add('and nvl(peso,0)<> 0  ');
  DMBaseDatos.QAux.SQL.Add('group by entrega, proveedor, producto, variedad, peso_caja, descripcion_pp  ');
  DMBaseDatos.QAux.SQL.Add('order by entrega, proveedor, producto, variedad, peso_caja  ');

  //Validar datos RF
  TMemEntregas.First;
  while not  TMemEntregas.Eof do
  begin
    DMBaseDatos.QAux.ParamByName('entrega').AsString:= TMemEntregas.FieldByName('entrega').AsString;
    DMBaseDatos.QAux.Open;
    if not DMBaseDatos.QAux.IsEmpty then
    begin
      while not  DMBaseDatos.QAux.Eof do
      begin
        if VMsg <> '' then
          VMsg:= VMsg + #13 + #10;
        VMsg:= VMsg + 'Entrega= ' + DMBaseDatos.QAux.FieldByName('entrega').AsString + ' - ' +
                      'Proveedor= ' + DMBaseDatos.QAux.FieldByName('proveedor').AsString + ' - ' +
                      'Proveedor= ' + DMBaseDatos.QAux.FieldByName('producto').AsString + ' - ' +
                      'Variedad= ' + DMBaseDatos.QAux.FieldByName('variedad').AsString + ' ' +
                      DMBaseDatos.QAux.FieldByName('descripcion_pp').AsString + ' -->> ' +
                      DMBaseDatos.QAux.FieldByName('peso_caja').AsString + ' Kgs/Caja ';
        DMBaseDatos.QAux.Next;
      end;
    end;
    DMBaseDatos.QAux.Close;
    TMemEntregas.Next;
  end;

  if VMsg <> '' then
  begin
    Result:= False;
    VMsg:= 'Ya existen palets con peso, si continua estos pesos seran recalculados.' + #13 + #10 + VMsg;
    if AdvertenciaFD.VerAdvertencia( Self, VMsg ) = mrIgnore then
    begin
      VMsg:= '';
      Result:= True;
    end
    else
    begin
      Result:= False;
      VMsg:= 'Operación cancelada por el usuario por no correspoder pesos.';
    end;
  end
  else
  begin
    Result:= True;
  end;
end;

function TFPCamionEntrega.ValidarKilosTotales( var VMsg: string ): Boolean;
var
  rAux: Real;
begin
  rAux:= abs( ( ( rKilosTotales / rKilosCamion ) - 1 ) * 100 );
  if rAux > 10 then
  begin
    if AdvertenciaFD.VerAdvertencia( Self,
                 'Hay una diferencia entre el peso del camión (' + FormatFloat( '#,###.00', rKilosCamion )+ 'kg) ' +
                 'y el teorico de la entrega (' + FormatFloat( '#,###.00', rKilosTotales )+ 'kg) ' +
                 'superior al 10% (' + FormatFloat( '#,###.00', rAux )+ '%). '
               ) = mrIgnore then
    begin
      Result:= True;
    end
    else
    begin
      Result:= False;
      VMsg:= 'Operación cancelada por el usuario por no correspoder pesos.';
    end;
  end
  else
  begin
    Result:= True;
  end;
end;

procedure TFPCamionEntrega.btnAceptarClick(Sender: TObject);
var
  sMsg: string;
begin
  if not TMemEntregas.IsEmpty then
  begin
    if ValidarKilosTotales( sMsg )  then
    begin
      if ValidarRF( sMsg ) then
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
        ShowMessage( sMsg );
      end;
    end
    else
    begin
      ShowMessage( sMsg );
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

procedure TFPCamionEntrega.LoadValues( const AEmpresa, AEntrega, AAlbaran, AFecha, Amatricula, ATransporte, ALleno, AVacio: string );
var
  slAux: TStringList;
begin
  sEmpresa:= AEmpresa;
  sTransporte:= ATransporte;

  eAlbaran.Text:= AAlbaran;
  eFecha.AsDate:= StrToDateDef( AFecha, Date );
  eKilosLleno.Text:= ALleno;
  eKilosVacio.Text:= AVacio;

  slAux:= TStringList.Create;
  CDBEntregas.EntradasCamion( AMatricula, AFecha, slAux);
  eEntrega.Items.AddStrings( slAux );
  FreeAndNil( slAux );
  eEntrega.Text:= AEntrega;

  lblTransporte.Caption:= desTransporte( sEmpresa, sTransporte ) + '(' + Amatricula + ')';
end;

function TFPCamionEntrega.ExisteEntrega( const AEntrega: string ): boolean;
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add(' select proveedor_ec, fecha_carga_ec, albaran_ec, vehiculo_ec ');
    SQL.Add(' from frf_entregas_c ');
    SQL.Add(' where codigo_ec = :entrega ');
    ParamByName('entrega').AsString:= AEntrega;
    Open;
    result:= not IsEmpty;
    if result then
    begin
      sProveedor:= FieldByName('proveedor_ec').AsString;
      sFechaCarga:= FieldByName('fecha_carga_ec').AsString;
      sAlbaran:= FieldByName('albaran_ec').AsString;
      sMatricula:= FieldByName('vehiculo_ec').AsString;

      Close;
    end
    else
    begin
      Close;

      sProveedor:= '';
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
  if ( sAlbaran <> eAlbaran.Text ) and CDBEntregas.ExisteAlbaranProveedor( sEmpresa, sProveedor, sFechaCarga, eAlbaran.Text ) then
  begin
    ShowMessage('Albarán de proveedor duplicado.');
  end
  else
  (* 30/04/2014 eliminada restriccion albaran Pepe/Juan por queja garita almacen
  if TMemEntregas.Locate('albaran', eAlbaran.Text, [] ) then
  begin
    ShowMessage('El albaran seleccionado ya ha sido añadido.');
  end
  else
  *)
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


procedure TFPCamionEntrega.btnAnyadirClick(Sender: TObject);
var
  rAux: real;
begin
  if ValidarValues then
  begin
    TMemEntregas.Insert;

    TMemEntregas.FieldByName('entrega').AsString:= eEntrega.Text;
    TMemEntregas.FieldByName('albaran').AsString:= eAlbaran.Text;
    TMemEntregas.FieldByName('proveedor').AsString:= sProveedor;
    TMemEntregas.FieldByName('fecha').AsDateTime:= StrToDate( eFecha.Text );

    TMemEntregas.FieldByName('kilosCamion').AsFloat:= rKilosCamion;
    rAux:= KilosTeorico(eEntrega.Text);
    rKilosTotales:= rKilosTotales + rAux;
    TMemEntregas.FieldByName('kilosTeoricos').AsFloat:= rAux;
    TMemEntregas.FieldByName('porcentaje').AsFloat:= 0;
    TMemEntregas.FieldByName('kilosReales').AsFloat:= 0;

    TMemEntregas.FieldByName('matricula').AsString:= sMatricula;

    TMemEntregas.Post;

    ActualizarKilos;

    eEntrega.SetFocus;
    eFecha.Enabled:= False;
    eKilosLleno.Enabled:= False;
    eKilosVacio.Enabled:= False;
  end;
end;

procedure TFPCamionEntrega.btnBorrarClick(Sender: TObject);
begin
  if not TMemEntregas.IsEmpty then
  begin
    rKilosTotales:= rKilosTotales - TMemEntregas.FieldByName('kilosTeoricos').AsFloat;
    TMemEntregas.Delete;
    ActualizarKilos;
    if eEntrega.CanFocus then
      eEntrega.SetFocus;
    if TMemEntregas.IsEmpty  then
    begin
      eFecha.Enabled:= True;
      eKilosLleno.Enabled:= True;
      eKilosVacio.Enabled:= True;
    end;
  end;
end;

procedure TFPCamionEntrega.eKilosLlenoChange(Sender: TObject);
var
  rAux: real;
begin
  //Calcular kilos

  rKilosCamionLleno:= StrToFloatDef( eKilosLleno.Text,  0 );
  rAux:= StrToFloatDef( eKilosVacio.Text, 0 );
  rKilosCamion:= rKilosCamionLleno - rAux;
  lblKilosProducto.Caption:= FormatFloat( '#,##0.00', rKilosCamion );
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
      rAux:= bRoundTo( ( 100 * TMemEntregas.FieldByName('kilosTeoricos').AsFloat ) / rKilosTotales, 4 );
      TMemEntregas.FieldByName('porcentaje').AsFloat:= rAux;
      TMemEntregas.FieldByName('kilosReales').AsFloat:= bRoundTo( ( rAux * TMemEntregas.FieldByName('kilosCamion').AsFloat ) / 100, 2);
      TMemEntregas.Post;
      TMemEntregas.Next;
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
      MarcarDescarga( TMemEntregas.fieldByName('entrega').AsString );
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
    SQL.Add( '     peso_salida_ec = :pesolleno - :pesoproducto ');
    SQL.Add( ' where codigo_ec =  :entrega ');

    ParamByName('entrega').AsString:= TMemEntregas.fieldByName('entrega').AsString;
    ParamByName('albaran').AsString:= TMemEntregas.fieldByName('albaran').AsString;
    ParamByName('fechallegada').AsDateTime:= dFEchaLlegada;
    ParamByName('pesolleno').AsFloat:= rKilosCamionLleno;
    ParamByName('pesoproducto').AsFloat:= TMemEntregas.fieldByName('kilosReales').AsFloat;

    ExecSQL;

    RepercutirPesosEntregas( TMemEntregas.fieldByName('entrega').AsString,
                             TMemEntregas.fieldByName('kilosTeoricos').AsFloat,
                             TMemEntregas.fieldByName('kilosReales').AsFloat );
  end;
end;

procedure TFPCamionEntrega.MarcarDescarga( const AEntrega: string );
begin
  with DMBaseDatos.QAux do
  begin
    SQL.Clear;
    SQL.Add( ' update frf_entregas_c ');
    SQL.Add( ' set status_ec = 2, ');
    SQL.Add( '     fecha_llegada_definitiva_ec = 1 ');
    SQL.Add( ' where codigo_ec =  :entrega ');

    ParamByName('entrega').AsString:= AEntrega;
    ExecSQL;
  end;
end;

procedure TFPCamionEntrega.edtcodigo_ecChange(Sender: TObject);
begin
  //seelccionar nuemro de albaran
  eAlbaran.Text:= CDBEntregas.GetNumeroAlbaran( eEntrega.Text );
end;

procedure TFPCamionEntrega.RepercutirPesosEntregas( const AEntrega: string; const AKilosTeoricos, AKilosReales: Real );
begin
  CDBEntregas.RepercutirPesosEntrega( AEntrega, AKilosTeoricos, AKilosReales );
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


