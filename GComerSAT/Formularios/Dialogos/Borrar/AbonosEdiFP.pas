unit AbonosEdiFP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, Db, DBTables, ExtCtrls, DBCtrls, Grids, DBGrids, Dialogs,
  BEdit, DBClient, Buttons, provider, ComCtrls,
  Mask, BCalendario, BSpeedButton, BCalendarButton, BGrid,
  BGridButton;

type
  TSqlCad = (scInteger, scString, scDate, scReal);

type
  TFPAbonosEdi = class(TForm)
    abono: TBEdit;
    StaticText1: TStaticText;
    StaticText4: TStaticText;
    fecha: TBEdit;
    BtnOk: TBitBtn;
    BtnCancel: TBitBtn;
    BCalendarButton1: TBCalendarButton;
    BCalendario1: TBCalendario;
    StaticText6: TStaticText;
    empresa: TBEdit;
    nombreEmpresa: TStaticText;
    BGridButton1: TBGridButton;
    RejillaFlotante: TBGrid;
    cbxSoloBorrar: TComboBox;
    lblPedido: TLabel;
    txtPedido: TStaticText;
    edtPedido: TBEdit;
    txtAlbaran: TStaticText;
    edtAlbaran: TBEdit;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCalendarButton1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BGridButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure empresaChange(Sender: TObject);
    procedure abonoChange(Sender: TObject);
  private
    { Private declarations }
    salir: boolean;

    sEmpresa: string;
    iFactura: Integer;
    dFecha: TDateTime;

    function  CamposRellenos( const AShowError: boolean = True ): Boolean;
    procedure AbonoMercadona;

  public
    { Public declarations }
  end;

procedure CreaLineasAbonoEDI( const AEmpresa: string; const AAbono: integer;
  const AFecha: TDateTime; const AALbaran, APedido: string;  const ASoloBorrar: Boolean );

implementation

uses UDMAuxDB, CAuxiliarDB, DError, CgestionPrincipal, CVariables,
  UDMBaseDatos, bMath, UDMFacturacionEDI, bCodeUtils, bTextUtils;

type

  RCabFacturaEdi = record
    codEmpresa, eanEmpresa, codCliente: string;
    fecha, fecha_Albaran: TDateTime;
    factura, nodo: Integer;
    n_albaran, centro, idTicket, pedido, moneda: string;
    neto, porc_iva, iva, total: real;
    cod_cliente, comprador, receptor, cliente, pagador: string;
    nombre, domicilo, ciudad, cod_postal, nif, suministro: string;
  end;

  RLinFacturaEdi = record
    codProducto, codEnvase, producto, dun14, nombre, unidad: string;
    unidades, precio, neto, baseIva, iva, total: real;
  end;

{$R *.DFM}

procedure TFPAbonosEdi.FormShow(Sender: TObject);
begin
  BCalendario1.Date := Date;
  empresa.Text := '';
  abono.Text := '';
  fecha.Text := datetostr(date);

  salir := false;
end;

procedure TFPAbonosEdi.BitBtn1Click(Sender: TObject);
begin
  //Cerrar el program
  if BCalendario1.Visible then Exit;
  Salir := true;
  Close;
end;

procedure TFPAbonosEdi.Button1Click(Sender: TObject);
begin
  //Esperamos **********************************************
  BEMensajes(' Creando Abono EDI .....');
  self.Refresh;
  //Esperamos **********************************************

  if CamposRellenos then
  begin
    CreaLineasAbonoEDI( sEmpresa, iFactura, dFecha, edtAlbaran.Text, edtPedido.Text,
      cbxSoloBorrar.ItemIndex = 1  );
  end;

  //Esperamos **********************************************
  BEMensajes('');
  //Esperamos **********************************************
end;

function TFPAbonosEdi.CamposRellenos( const AShowError: boolean = True ): Boolean;
begin
  Result:= False;

  if nombreEmpresa.Caption = '' then
  begin
    if AShowError then
    begin
      if empresa.Visible and  empresa.Enabled then
        empresa.SetFocus;
      ShowError('Falta el código de la empresa o es incorrecto.');
    end;
    Exit;
  end;

  sEmpresa:= empresa.Text;

  if not TryStrToInt( abono.Text, iFactura ) then
  begin
    if AShowError then
    begin
      if abono.Visible and  abono.Enabled then
        abono.SetFocus;
      ShowError('Falta el número del abono o es incorrecto.');
    end;
    Exit;
  end;

  if not TryStrToDate( fecha.Text, dFecha ) then
  begin
    if AShowError then
    begin
      if fecha.Visible and  fecha.Enabled then
        fecha.SetFocus;
      ShowError('Falta la fecha del abono o es incorrecta.');
    end;
    Exit;
  end;

  Result:= True;
end;


procedure TFPAbonosEdi.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_Return, vk_down:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
      end;
    vk_up:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
      end;
    vk_f1: BtnOk.Click;
    vk_f2:
      begin
        if fecha.Focused then
          BCalendarButton1.Click;
        if empresa.Focused then
          BGridButton1.Click;
      end;
    vk_escape:
      begin
        if not RejillaFlotante.Visible and not BCalendario1.Visible then
          BtnCancel.Click;
      end;
  end;
end;

procedure TFPAbonosEdi.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if not Salir then Action := caNone
  else
  begin
    FormType := tfDirector;
    BHFormulario;
    Action := caFree;
  end;
end;

procedure TFPAbonosEdi.BCalendarButton1Click(Sender: TObject);
begin
  BCalendarButton1.CalendarShow;
end;

procedure TFPAbonosEdi.FormCreate(Sender: TObject);
begin
  empresa.Tag := kEmpresa;
  ActiveControl := empresa;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  FormType := tfOther;
  BHFormulario;
end;

procedure TFPAbonosEdi.FormActivate(Sender: TObject);
begin
  Top := 1;
end;

procedure TFPAbonosEdi.BGridButton1Click(Sender: TObject);
begin
  DespliegaRejilla(BGridButton1);
  ActiveControl := RejillaFlotante;
end;

procedure TFPAbonosEdi.empresaChange(Sender: TObject);
begin
  if not RejillaFlotante.Visible and not BCalendario1.Visible then
  begin
    nombreEmpresa.Caption := desEmpresa(empresa.Text);
    AbonoMercadona;
  end;
end;

function DatosAbonoCab( const AEmpresa: string; const AAbono: integer; const AFecha: TDateTime ): RCabFacturaEdi;
var
  qAux: TQuery;
begin
      result.nodo:= 0;
      result.moneda:= '';
      result.neto:= 0;
      result.porc_iva:= 0;
      result.iva:= 0;
      result.total:= 0;

  qAux:= TQuery.Create( nil );
  try
    qAux.DatabaseName:= 'BDProyecto';
    qAux.SQL.Add(' select  tipo_factura_f, moneda_f, importe_neto_f, ');
    qAux.SQL.Add('         porc_impuesto_f, total_impuesto_f, importe_total_f  ' );
    qAux.SQL.Add(' from frf_facturas ' );
    qAux.SQL.Add(' where empresa_f = :empresa ' );
    qAux.SQL.Add(' and n_factura_f = :abono ' );
    qAux.SQL.Add(' and fecha_factura_f = :fecha ' );
    qAux.ParamByName('empresa').AsString:= AEmpresa;
    qAux.ParamByName('abono').AsInteger:= AAbono;
    qAux.ParamByName('fecha').AsDateTime:= AFecha;
    qAux.open;
    if qAux.IsEmpty then
    begin
      qAux.Close;
      raise Exception.Create('No existe el abono.');
    end
    else
    begin
      result.nodo:= qAux.FieldByName('tipo_factura_f').AsInteger;
      result.moneda:= qAux.FieldByName('moneda_f').AsString;
      result.neto:= qAux.FieldByName('importe_neto_f').AsFloat;
      result.porc_iva:= qAux.FieldByName('porc_impuesto_f').AsFloat;
      result.iva:= qAux.FieldByName('total_impuesto_f').AsFloat;
      result.total:= qAux.FieldByName('importe_total_f').AsFloat;
      qAux.Close;
    end;
  finally
    FreeAndNil( qAux );
  end;
end;

function NetoAbonoLin( const AEmpresa: string; const AAbono: integer; const AFecha: TDateTime ): real;
var
  qAux: TQuery;
  iLineas: integer;
begin
  qAux:= TQuery.Create( nil );
  try
    qAux.DatabaseName:= 'BDProyecto';
    qAux.SQL.Add(' select  count(*) lineas, sum(importe_fal) importe' );
    qAux.SQL.Add(' from frf_fac_abonos_l ' );
    qAux.SQL.Add(' where empresa_fal = :empresa ' );
    qAux.SQL.Add(' and factura_fal = :abono ' );
    qAux.SQL.Add(' and fecha_fal = :fecha ' );
    qAux.ParamByName('empresa').AsString:= AEmpresa;
    qAux.ParamByName('abono').AsInteger:= AAbono;
    qAux.ParamByName('fecha').AsDateTime:= AFecha;
    qAux.open;
    iLineas:= qAux.FieldByName('lineas').AsInteger;
    result:= qAux.FieldByName('importe').AsFloat;
    qAux.Close;
    if iLineas = 0 then
      raise Exception.Create('No existen los detalles del abono.');
  finally
    FreeAndNil( qAux );
  end;
end;

 Function IsValidEAN(EANCode: String): Boolean;
 Var
   CheckSum1: String;
   Tmp, Tmp2: Integer;
   VerifyDigit: Integer;
   LectDigit: String;
 Begin
     // En principio, el valor por defecto en FALSE para IsValidEAN
     IsValidEAN := False;

     // Comprobar que no hay menos o más caracteres de los permitidos (8 ó 13)
     If ((Length(EANCode) <> 8) And (Length(EANCode) <> 13)) Then Exit;

     // Obtener el dígito de control leido en un principio
     LectDigit := Copy(EANCode, Length(EanCode), 1);

     // Quitar el dígito de control que se ha obtenido en la lectura para procesar
     // el código de barras y verificar su correcta lectura
     EANCode := Copy(EANCode, 1, Length(EanCode) - 1);

     CheckSum1 := '131313131313';

     Tmp2 := 0;

     For Tmp := 1 To Length(EANCode) do
      Begin
         Tmp2 := Tmp2 + (StrToInt (Copy (EANCode, Tmp, 1)) * StrToInt (Copy(CheckSum1, Tmp, 1)));
      End;

     // Extraer el valor de la derecha
     Tmp := StrToInt (Copy (IntToStr(Tmp2), Length(IntToStr(Tmp2)),1));

     // Restarlo de 10 si no es ya 0
     If Tmp > 0 Then Tmp := 10 - Tmp;

     // Almacenar el dígito de control obtenido
     VerifyDigit := Tmp;

     // Comparar dígito de control original con el obtenido y devolver un resultado
     If VerifyDigit <> StrToInt (LectDigit) Then
         IsValidEAN := False
     Else
         IsValidEAN := True;
 End;


function CodigoEdiEmpresa( const AEmpresa: string ): string;
var
  qAux: TQuery;
begin
  result:= '';
  qAux:= TQuery.Create( nil );
  try
    qAux.DatabaseName:= 'BDProyecto';
    qAux.SQL.Add(' select codigo_ean_e codigo' );
    qAux.SQL.Add(' from frf_empresas ' );
    qAux.SQL.Add(' where empresa_e = :empresa ' );
    qAux.ParamByName('empresa').AsString:= AEmpresa;
    qAux.open;

    if qAux.IsEmpty then
    begin
      raise Exception.Create('No existe la empresa.');
      qAux.Close;
    end
    else
    begin
      if Trim( qAux.FieldByName('codigo').AsString ) = '' then
      begin
        raise Exception.Create('No existe el codigo EAN13 de la empresa para la facturación EDI.');
        qAux.Close;
      end
      else
      begin
        result:= qAux.FieldByName('codigo').AsString;
        qAux.Close;
        if not IsValidEAN( result ) then
          raise Exception.Create('El codigo EAN13 de la empresa para la facturación EDI es incorrecto.');
      end;
    end;
  finally
    FreeAndNil( qAux );
  end;
end;

procedure DatosCliente( const AEmpresa, ACliente: string; var ANombre, ADomicilio, ACiudad, ACodPostal, ANif: string );
var
  qAux: TQuery;
begin
  qAux:= TQuery.Create( nil );
  try
    qAux.DatabaseName:= 'BDProyecto';
    qAux.SQL.Add(' select nombre_c, domicilio_fac_c, poblacion_fac_c, cod_postal_fac_c, nif_c ' );
    qAux.SQL.Add(' from frf_clientes ' );
    qAux.SQL.Add(' where empresa_c = :empresa ' );
    qAux.SQL.Add(' and cliente_c = :cliente  ' );
    qAux.ParamByName('empresa').AsString:= AEmpresa;
    qAux.ParamByName('cliente').AsString:= ACliente;
    qAux.open;
    if qAux.IsEmpty then
    begin
      qAux.Close;
      raise Exception.Create('No existe el cliente.');
    end
    else
    begin
      ANombre:= qAux.FieldByName('nombre_c').AsString;
      ADomicilio:= qAux.FieldByName('domicilio_fac_c').AsString;
      ACiudad:= qAux.FieldByName('poblacion_fac_c').AsString;
      ACodPostal:= qAux.FieldByName('cod_postal_fac_c').AsString;
      ANif:= qAux.FieldByName('nif_c').AsString;
      qAux.Close;
    end;
  finally
    FreeAndNil( qAux );
  end;
end;

procedure CodigosEdiDirSum( const AEmpresa, AClienteFac, ASuministro: string; var AComprador, AReceptor, ACliente, APagador: string );
var
  qAux: TQuery;
begin
  qAux:= TQuery.Create( nil );
  try
    qAux.DatabaseName:= 'BDProyecto';
    qAux.SQL.Add(' select quienpide_ce, quienrecibe_ce, aquiensefactura_ce, quienpaga_ce ' );
    qAux.SQL.Add(' from frf_clientes_edi ' );
    qAux.SQL.Add(' where empresa_ce = :empresa ' );
    qAux.SQL.Add(' and cliente_ce = :cliente ' );
    qAux.SQL.Add(' and dir_sum_ce = :dirsum ' );
    qAux.ParamByName('empresa').AsString:= AEmpresa;
    qAux.ParamByName('cliente').AsString:= AClienteFac;
    qAux.ParamByName('dirsum').AsString:= ASuministro;
    qAux.open;
    if qAux.IsEmpty then
    begin
      raise Exception.Create('No existen los codigos EDI para la direncción de suministro.');
    end
    else
    begin
      AComprador:= qAux.FieldByName('quienpide_ce').AsString;
      //if not IsValidEAN( AComprador ) then
      //  raise Exception.Create('Código EAN13 invalido para "Quien Pide" para la facturación EDI' );
      AReceptor:= qAux.FieldByName('quienrecibe_ce').AsString;
      //if not IsValidEAN( AReceptor ) then
      //  raise Exception.Create('Código EAN13 invalido para "Quien Recibe" para la facturación EDI' );
      ACliente:= qAux.FieldByName('aquiensefactura_ce').AsString;
      //if not IsValidEAN( ACliente ) then
      //  raise Exception.Create('Código EAN13 invalido para "A Quien Se Factura" para la facturación EDI' );
      APagador:= qAux.FieldByName('quienpaga_ce').AsString;
      //if not IsValidEAN( APagador ) then
      //  raise Exception.Create('Código EAN13 invalido para "Quien Paga" para la facturación EDI' );

    end;
  finally
    qAux.Close;
    FreeAndNil( qAux );
  end;
end;

procedure DatosEdiCliente( const AEmpresa: string; const AAbono: Integer;  const AFecha: TDateTime;
                           const AALbaran, APedido: string; var result :RCabFacturaEdi );

var
  qAux: TQuery;
  sComprador, sReceptor, sCliente, sPagador: String;
  sNombre, sDomicilio, sCiudad, sCodPostal, sNif: string;
begin
  qAux:= TQuery.Create( nil );
  try
    qAux.DatabaseName:= 'BDProyecto';
    qAux.SQL.Add(' select empresa_sc, cliente_fac_sc, dir_sum_sc, n_albaran_sc, n_pedido_sc, centro_salida_sc, fecha_sc  ');
    qAux.SQL.Add(' from frf_fac_abonos_l, frf_salidas_c ');
    qAux.SQL.Add(' where empresa_fal = :empresa ');
    qAux.SQL.Add(' and factura_fal = :factura ');
    qAux.SQL.Add(' and fecha_fal = :fecha ');
    qAux.SQL.Add(' and empresa_sc = :empresa ');
    qAux.SQL.Add(' and centro_salida_sc = centro_salida_fal ');
    qAux.SQL.Add(' and fecha_sc = fecha_albaran_fal ');
    qAux.SQL.Add(' and n_albaran_sc = n_albaran_fal ');
    qAux.SQL.Add(' group by empresa_sc, cliente_fac_sc, dir_sum_sc,  n_albaran_sc, n_pedido_sc, centro_salida_sc, fecha_sc ');
    qAux.ParamByName('empresa').AsString:= AEmpresa;
    qAux.ParamByName('factura').AsInteger:= AAbono;
    qAux.ParamByName('fecha').AsDateTime:= AFecha;
    qAux.open;

    if qAux.IsEmpty then
    begin
      raise Exception.Create('No existe el albarán asociado al abono.');
      qAux.Close;
    end
    else
    begin
      qAux.First;
      qAux.Next;

      //Numero de albaran
      if AALbaran <> '' then
      begin
        result.n_albaran:= AALbaran;
      end
      else
      begin
        result.n_albaran:= qAux.FieldByName('n_albaran_sc').AsString;
      end;
      result.fecha_Albaran:= qAux.FieldByName('fecha_sc').AsDateTime;

      if  result.n_albaran = qAux.FieldByName('n_albaran_sc').AsString then
      begin
        if Copy( result.codEmpresa, 1, 1) = 'F' then
        begin
          result.n_albaran := result.codEmpresa +  result.centro +
            Rellena( result.n_albaran, 5, '0', taLeftJustify ) + Coletilla( result.codEmpresa );
        end;
      end;

      result.centro:= qAux.FieldByName('centro_salida_sc').AsString;
      //Numero de pedido
      if APedido <> '' then
        result.pedido:= APedido
      else
        result.pedido:= qAux.FieldByName('n_pedido_sc').AsString;
      //result.pedido:= qAux.FieldByName('n_pedido_sc').AsString;


      if not qAux.Eof then
      begin
        raise Exception.Create('Solo un albarán por abono EDI');
      end
      else
      begin
        //Datos del cliente
        DatosCliente( AEmpresa, qAux.FieldByName('cliente_fac_sc').AsString, sNombre,
                      sDomicilio, sCiudad, sCodPostal, sNif );
        result.codCliente:= qAux.FieldByName('cliente_fac_sc').AsString;
        result.nombre:= sNombre;
        result.domicilo:= sDomicilio;
        result.ciudad:= sCiudad;
        result.cod_postal:= sCodPostal;
        result.nif:= sNif;

        //Codigos EDI dir suministro
        CodigosEdiDirSum( AEmpresa, qAux.FieldByName('cliente_fac_sc').AsString,
           qAux.FieldByName('dir_sum_sc').AsString, sComprador, sReceptor, sCliente, sPagador );
        result.cod_cliente:= qAux.FieldByName('cliente_fac_sc').AsString;
        result.comprador:= sComprador;
        result.receptor:= sReceptor;
        result.cliente:= sCliente;
        result.pagador:= sPagador;
      end;
    end;
    qAux.Close;

  finally
    FreeAndNil( qAux );
  end;
end;

function ExisteFacturaEdi( const AEmpresa: string; const AAbono: Integer; const AFecha: TDateTime ): boolean;
var
  qAux: TQuery;
begin
  qAux:= TQuery.Create( nil );
  try
    qAux.DatabaseName:= 'BDProyecto';

    qAux.SQL.Add(' select *  from frf_facturas_edi_c ');
    qAux.SQL.Add(' where empresa_fec = :empresa ');
    qAux.SQL.Add('   and factura_fec = :factura ');
    qAux.SQL.Add('   and fecha_factura_fec = :fecha ');
    qAux.ParamByName('empresa').AsString:= AEmpresa;
    qAux.ParamByName('factura').AsInteger:= AAbono;
    qAux.ParamByName('fecha').AsDateTime:= AFecha;
    qAux.Open;

    result:= not qAux.IsEmpty;
    qAux.Close;

  finally
    FreeAndNil( qAux );
  end;
end;

procedure BorrarFacturaEdi( const AEmpresa: string; const AAbono: Integer; const AFecha: TDateTime );
var
  qAux: TQuery;
begin
  qAux:= TQuery.Create( nil );
  try
    qAux.DatabaseName:= 'BDProyecto';

    qAux.SQL.Add(' delete from frf_facturas_edi_l ');
    qAux.SQL.Add(' where empresa_fel = :empresa ');
    qAux.SQL.Add('   and factura_fel = :factura ');
    qAux.SQL.Add('   and fecha_factura_fel = :fecha ');
    qAux.ParamByName('empresa').AsString:= AEmpresa;
    qAux.ParamByName('factura').AsInteger:= AAbono;
    qAux.ParamByName('fecha').AsDateTime:= AFecha;
    qAux.ExecSQL;

    qAux.SQL.Clear;
    qAux.SQL.Add(' delete from frf_impues_edi_c ');
    qAux.SQL.Add(' where empresa_iec = :empresa ');
    qAux.SQL.Add('   and factura_iec = :factura ');
    qAux.SQL.Add('   and fecha_factura_iec = :fecha ');
    qAux.ParamByName('empresa').AsString:= AEmpresa;
    qAux.ParamByName('factura').AsInteger:= AAbono;
    qAux.ParamByName('fecha').AsDateTime:= AFecha;
    qAux.ExecSQL;

    qAux.SQL.Clear;
    qAux.SQL.Add(' delete from frf_impues_edi_l ');
    qAux.SQL.Add(' where empresa_iel = :empresa ');
    qAux.SQL.Add('   and factura_iel = :factura ');
    qAux.SQL.Add('   and fecha_factura_iel = :fecha ');
    qAux.ParamByName('empresa').AsString:= AEmpresa;
    qAux.ParamByName('factura').AsInteger:= AAbono;
    qAux.ParamByName('fecha').AsDateTime:= AFecha;
    qAux.ExecSQL;

    qAux.SQL.Clear;
    qAux.SQL.Add(' delete from frf_facturas_edi_c ');
    qAux.SQL.Add(' where empresa_fec = :empresa ');
    qAux.SQL.Add('   and factura_fec = :factura ');
    qAux.SQL.Add('   and fecha_factura_fec = :fecha ');
    qAux.ParamByName('empresa').AsString:= AEmpresa;
    qAux.ParamByName('factura').AsInteger:= AAbono;
    qAux.ParamByName('fecha').AsDateTime:= AFecha;
    qAux.ExecSQL;

  finally
    FreeAndNil( qAux );
  end;
end;

procedure InsertarDetalle( const ACabAbono: RCabFacturaEdi; const ALinAbono: RLinFacturaEdi; const ALinea: integer );
var
  qAux: TQuery;
  rPeso: real;
  iUnidades: integer;
begin
  qAux:= TQuery.Create( nil );
  try
    qAux.DatabaseName:= 'BDProyecto';

    qAux.SQL.Clear;
    qAux.SQL.Add(' select peso_neto_e, unidades_e ');
    qAux.SQL.Add(' from frf_envases ');
    qAux.SQL.Add(' where empresa_e = :empresa ');
    qAux.SQL.Add(' and envase_e = :envase ');
    qAux.SQL.Add(' and producto_base_e = ( ');
    qAux.SQL.Add('                         select producto_base_p ');
    qAux.SQL.Add('                         from frf_productos ');
    qAux.SQL.Add('                         where empresa_p = :empresa ');
    qAux.SQL.Add('                         and producto_p = :producto ');
    qAux.SQL.Add('                       ) ');
    qAux.ParamByname('empresa').AsString:= ACabAbono.codEmpresa;
    qAux.ParamByname('envase').AsString:= ALinAbono.codEnvase;
    qAux.ParamByname('producto').AsString:= ALinAbono.codProducto;
    qAux.Open;
    rPeso:= qAux.FieldByname('peso_neto_e').AsFloat;
    iUnidades:= qAux.FieldByname('unidades_e').AsInteger;
    qAux.Close;

    qAux.SQL.Clear;
    qAux.SQL.Add(' INSERT INTO frf_facturas_edi_l ( ');
    qAux.SQL.Add(' vendedor_fel, empresa_fel, factura_fel, fecha_factura_fel ,num_linea_fel ,producto_fel , dun14_fel, ');
    qAux.SQL.Add(' descripcion_fel ,cantidad_fel ,medida_fel ,unidad_medida_fel , ');
    qAux.SQL.Add(' precio_bruto_fel ,precio_neto_fel ,porc_cargo_fel ,cargos_fel , ');
    qAux.SQL.Add(' porc_descuen_fel ,descuentos_fel ,neto_fel, bruto_fel, ');
    qAux.SQL.Add(' kilos_fel ,cajas_fel ,unidades_caja_fel, peso_caja_fel ) ');

    qAux.SQL.Add(' VALUES( ');
    qAux.SQL.Add(' :vendedor_fel, :empresa_fel, :factura_fel,:fecha_factura_fel ,:num_linea_fel ,:producto_fel , :dun14_fel,');
    qAux.SQL.Add(' :descripcion_fel ,:cantidad_fel ,:medida_fel ,:unidad_medida_fel , ');
    qAux.SQL.Add(' :precio_bruto_fel ,:precio_neto_fel ,:porc_cargo_fel ,:cargos_fel , ');
    qAux.SQL.Add(' :porc_descuen_fel ,:descuentos_fel ,:neto_fel, :bruto_fel,  ');
    qAux.SQL.Add(' :kilos_fel ,:cajas_fel ,:unidades_caja_fel, :peso_caja_fel ) ');

    qAux.ParamByName('empresa_fel').AsString :=  ACabAbono.codEmpresa;
    qAux.ParamByName('vendedor_fel').AsString :=  ACabAbono.eanEmpresa;
    qAux.ParamByName('factura_fel').AsInteger := ACabAbono.factura;
    qAux.ParamByName('fecha_factura_fel').AsDateTime := ACabAbono.fecha;
    qAux.ParamByName('num_linea_fel').AsInteger := ALinea;

     //Funcion que saca los codigos EDI segun el envase y la categoria
    qAux.ParamByName('producto_fel').AsString := ALinAbono.producto;
    qAux.ParamByName('dun14_fel').AsString := ALinAbono.dun14;
     //Hay que poner la descripcion del envase
    qAux.ParamByName('descripcion_fel').AsString := ALinAbono.nombre;

    qAux.ParamByName('cantidad_fel').AsFloat := 0.0;

    qAux.ParamByName('medida_fel').AsString := FloatToStr( ALinAbono.unidades );

    qAux.ParamByName('unidad_medida_fel').DataType:= ftString;
    if ALinAbono.unidad = 'KGS' then
    begin
      qAux.ParamByName('unidad_medida_fel').AsString := 'KGM';
      qAux.ParamByName('kilos_fel').AsFloat := ALinAbono.unidades;
      if rPeso > 0 then
      begin
        qAux.ParamByName('cajas_fel').AsInteger := Trunc( ALinAbono.unidades / rPeso );
      end
      else
      begin
        qAux.ParamByName('cajas_fel').AsInteger := 0;
      end;
    end
    else
    if ALinAbono.unidad = 'UND' then
    begin
      qAux.ParamByName('unidad_medida_fel').AsString := 'PCE';
      if iUnidades > 0 then
      begin
        qAux.ParamByName('cajas_fel').AsInteger := Trunc( ALinAbono.unidades / iUnidades );
      end
      else
      begin
        qAux.ParamByName('cajas_fel').AsInteger := 0;
      end;
      qAux.ParamByName('kilos_fel').AsFloat := bRoundTo( qAux.ParamByName('cajas_fel').AsInteger * rPeso, 2 );
    end
    else
    if ALinAbono.unidad = 'CAJ' then
    begin
      qAux.ParamByName('unidad_medida_fel').AsString := 'PCE';
      qAux.ParamByName('cajas_fel').AsInteger := Trunc( ALinAbono.unidades );
      qAux.ParamByName('kilos_fel').AsFloat := bRoundTo( ALinAbono.unidades * rPeso, 2 );
    end
    else
    begin
      qAux.ParamByName('cajas_fel').AsInteger := 0;
      qAux.ParamByName('kilos_fel').AsFloat := 0;
    end;
    qAux.ParamByName('unidades_caja_fel').AsInteger := iUnidades;
    qAux.ParamByName('peso_caja_fel').AsFloat := rPeso;

    qAux.ParamByName('precio_bruto_fel').AsFloat := Abs( ALinAbono.precio );
    qAux.ParamByName('precio_neto_fel').AsFloat := Abs( ALinAbono.precio );
    qAux.ParamByName('neto_fel').AsFloat := Abs( ALinAbono.neto );
    qAux.ParamByName('bruto_fel').AsFloat := Abs( ALinAbono.neto );
    qAux.ParamByName('cargos_fel').AsFloat := 0.0;
    qAux.ParamByName('porc_cargo_fel').AsFloat := 0.0;
    qAux.ParamByName('porc_descuen_fel').AsFloat := 0.0;
    qAux.ParamByName('descuentos_fel').AsFloat := 0.0;

    qAux.ExecSQL;

  finally
    FreeAndNil( qAux );
  end;
end;

procedure InsertarCabImpuesto( const ACabAbono: RCabFacturaEdi );
var
  qAux: TQuery;
begin
  qAux:= TQuery.Create( nil );
  try
    qAux.DatabaseName:= 'BDProyecto';

    qAux.SQL.Add(' INSERT INTO frf_impues_edi_c ( ');
    qAux.SQL.Add(' vendedor_iec, empresa_iec, factura_iec, fecha_factura_iec, tipo_iec, ');
    qAux.SQL.Add(' base_iec, porcentaje_iec, importe_iec ) ');
    qAux.SQL.Add(' VALUES( ');
    qAux.SQL.Add(' :vendedor_iec, :empresa_iec, :factura_iec, :fecha_factura_iec, :tipo_iec, ');
    qAux.SQL.Add(' :base_iec,  :porcentaje_iec, :importe_iec ) ');

    qAux.ParamByName('empresa_iec').AsString := ACabAbono.codEmpresa;
    qAux.ParamByName('vendedor_iec').AsString := ACabAbono.eanEmpresa;
    qAux.ParamByName('factura_iec').AsInteger := ACabAbono.factura;
    qAux.ParamByName('fecha_factura_iec').AsDateTime := ACabAbono.fecha;

    if ACabAbono.porc_iva = 0 then
    begin
      qAux.ParamByName('tipo_iec').AsString := 'IGI';
    end
    else
    begin
      qAux.ParamByName('tipo_iec').AsString := 'VAT';
    end;

    qAux.ParamByName('base_iec').AsFloat := Abs( ACabAbono.neto );
    qAux.ParamByName('porcentaje_iec').AsFloat := Abs( ACabAbono.porc_iva );
    qAux.ParamByName('importe_iec').AsFloat := Abs( ACabAbono.iva );

    qAux.ExecSQL;

  finally
    FreeAndNil( qAux );
  end;
end;

procedure InsertarLinImpuesto( const ACabAbono: RCabFacturaEdi; const ALinAbono: RLinFacturaEdi; const ALinea: integer );
var
  qAux: TQuery;
begin
  qAux:= TQuery.Create( nil );
  try
    qAux.DatabaseName:= 'BDProyecto';

    qAux.SQL.Add(' INSERT INTO frf_impues_edi_l ( ');
    qAux.SQL.Add(' vendedor_iel, empresa_iel, factura_iel ,  fecha_factura_iel ,  num_linea_iel ,  tipo_iel , ');
    qAux.SQL.Add(' base_iel ,  porcentaje_iel ,  importe_iel ) ');
    qAux.SQL.Add(' VALUES( ');
    qAux.SQL.Add(' :vendedor_iel, :empresa_iel, :factura_iel ,  :fecha_factura_iel ,  :num_linea_iel ,  :tipo_iel , ');
    qAux.SQL.Add(' :base_iel ,  :porcentaje_iel , :importe_iel ) ');

    qAux.ParamByName('empresa_iel').AsString := ACabAbono.codEmpresa;
    qAux.ParamByName('vendedor_iel').AsString := ACabAbono.eanEmpresa;
    qAux.ParamByName('factura_iel').AsInteger := ACabAbono.factura;
    qAux.ParamByName('fecha_factura_iel').AsDateTime := ACabAbono.fecha;
    qAux.ParamByName('num_linea_iel').AsFloat := ALinea;

    if ALinAbono.baseIva = 0 then
    begin
      qAux.ParamByName('tipo_iel').AsString := 'IGI';
    end
    else
    begin
      qAux.ParamByName('tipo_iel').AsString := 'VAT';
    end;

    qAux.ParamByName('base_iel').AsFloat := Abs( ALinAbono.neto );
    qAux.ParamByName('porcentaje_iel').AsFloat := Abs( ALinAbono.baseIva );
    qAux.ParamByName('importe_iel').AsFloat := Abs( ALinAbono.iva );

    qAux.ExecSQL;

  finally
    FreeAndNil( qAux );
  end;
end;

procedure InsertarLineasEdi( const ACabAbono: RCabFacturaEdi );
var
  qAux: TQuery;
  i, cont: integer;
  neto, iva, total: real;
  rLinFacturaEdiVar: RLinFacturaEdi;
  sDun14: string;
begin
  qAux:= TQuery.Create( nil );
  try
    qAux.DatabaseName:= 'BDProyecto';

    qAux.SQL.Add(' select count(*) ');
    qAux.SQL.Add(' from frf_fac_abonos_l ');
    qAux.SQL.Add(' where empresa_fal = :empresa ');
    qAux.SQL.Add(' and factura_fal = :factura ');
    qAux.SQL.Add(' and fecha_fal = :fecha ');
    qAux.ParamByName('empresa').AsString:= ACabAbono.codEmpresa;
    qAux.ParamByName('factura').AsInteger:= ACabAbono.factura;
    qAux.ParamByName('fecha').AsDateTime:= ACabAbono.fecha;
    qAux.open;
    cont:= qAux.fields[0].AsInteger;
    qAux.Close;

    qAux.SQL.Clear;
    qAux.SQL.Add(' select producto_fal, categoria_fal, envase_fal, unidad_fal, ');
    qAux.SQL.Add('        unidades_fal, precio_fal, importe_fal ');
    qAux.SQL.Add(' from frf_fac_abonos_l ');
    qAux.SQL.Add(' where empresa_fal = :empresa ');
    qAux.SQL.Add(' and factura_fal = :factura ');
    qAux.SQL.Add(' and fecha_fal = :fecha ');
    qAux.ParamByName('empresa').AsString:= ACabAbono.codEmpresa;
    qAux.ParamByName('factura').AsInteger:= ACabAbono.factura;
    qAux.ParamByName('fecha').AsDateTime:= ACabAbono.fecha;
    qAux.open;

    neto:= 0;
    iva:= 0;
    total:= 0;

    for i:= 1 to cont do
    begin
      //probat
      rLinFacturaEdiVar.codProducto:= qAux.FieldByName('producto_fal').AsString;
      rLinFacturaEdiVar.codEnvase:= qAux.FieldByName('envase_fal').AsString;
      rLinFacturaEdiVar.producto:= GetCodEdi(ACabAbono.codEmpresa, ACabAbono.codCliente,
        qAux.FieldByName('envase_fal').AsString, rLinFacturaEdiVar.nombre, sDun14 );
      rLinFacturaEdiVar.dun14:= sDun14;//Dun14Code( rLinFacturaEdiVar.producto, 0 );
(*
      rLinFacturaEdiVar.producto:= CodigosEdiEx(ACabAbono.eanEmpresa, qAux.FieldByName('producto_fal').AsString,
        qAux.FieldByName('envase_fal').AsString, rLinFacturaEdiVar.nombre );
*)
      rLinFacturaEdiVar.unidad:= qAux.FieldByName('unidad_fal').AsString;
      rLinFacturaEdiVar.unidades:= qAux.FieldByName('unidades_fal').AsFloat;
      rLinFacturaEdiVar.precio:= qAux.FieldByName('precio_fal').AsFloat;
      rLinFacturaEdiVar.neto:= qAux.FieldByName('importe_fal').AsFloat;
      rLinFacturaEdiVar.baseIva:= ACabAbono.porc_iva;
      rLinFacturaEdiVar.Iva:= bRoundTo( ( rLinFacturaEdiVar.neto * rLinFacturaEdiVar.baseIva ) / 100, -2 );
      rLinFacturaEdiVar.total:= rLinFacturaEdiVar.neto + rLinFacturaEdiVar.Iva;

      neto:= neto + rLinFacturaEdiVar.neto;
      iva:= iva + rLinFacturaEdiVar.iva;
      total:= total + rLinFacturaEdiVar.total;

      if i = cont then
      begin
        rLinFacturaEdiVar.neto:= rLinFacturaEdiVar.neto + ( ACabAbono.neto - neto );
        rLinFacturaEdiVar.iva:= rLinFacturaEdiVar.iva + ( ACabAbono.iva - iva );
        rLinFacturaEdiVar.total:= rLinFacturaEdiVar.total + ( ACabAbono.total - total );
      end;

      InsertarDetalle( ACabAbono, rLinFacturaEdiVar, i );
      InsertarLinImpuesto( ACabAbono, rLinFacturaEdiVar, i );
    end;

  finally
    qAux.Close;
    FreeAndNil( qAux );
  end;
end;

procedure CrearAbonoEdi( const ACabAbono: RCabFacturaEdi );
var
  qAux: TQuery;
begin
  qAux:= TQuery.Create( nil );
  try
    qAux.DatabaseName:= 'BDProyecto';

    qAux.SQL.Clear;
    qAux.SQL.Add(' INSERT INTO frf_facturas_edi_c ');
    qAux.SQL.Add('(empresa_fec, factura_fec,  vendedor_fec,  cobrador_fec,  comprador_fec, ');
    qAux.SQL.Add('receptor_fec,  cliente_fec,  pagador_fec,  pedido_fec, ');
    qAux.SQL.Add('fecha_factura_fec,  nodo_fec,  rsocial_fec,  domicilio_fec, ');
    qAux.SQL.Add('ciudad_fec,  cp_fec,  nif_fec,  albaran_fec,  bruto_fec, ');
    qAux.SQL.Add('porc_cargos_fec, cargos_fec,  porc_descuen_fec,  descuentos_fec, ');
    qAux.SQL.Add('impuestos_fec,  total_factura_fec,  moneda_fec,  vencimiento1_fec, ');
    qAux.SQL.Add('importe_vto1_fec, fecha_albaran_fec, fecha_entrega_fec )');
    qAux.SQL.Add('VALUES ');
    qAux.SQL.Add('(:empresa_fec, :factura_fec,  :vendedor_fec,  :cobrador_fec,  :comprador_fec, ');
    qAux.SQL.Add(':receptor_fec,  :cliente_fec,  :pagador_fec,  :pedido_fec, ');
    qAux.SQL.Add(':fecha_factura_fec,  :nodo_fec,  :rsocial_fec,  :domicilio_fec, ');
    qAux.SQL.Add(':ciudad_fec, :cp_fec,  :nif_fec,  :albaran_fec,  :bruto_fec, ');
    qAux.SQL.Add(':porc_cargos_fec,  :cargos_fec,  :porc_descuen_fec,  :descuentos_fec, ');
    qAux.SQL.Add(':impuestos_fec,  :total_factura_fec,  :moneda_fec,  :vencimiento1_fec, ');
    qAux.SQL.Add(':importe_vto1_fec, :fecha_albaran_fec, :fecha_entrega_fec ) ');

    qAux.ParamByName('empresa_fec').Asstring := ACabAbono.codEmpresa;
    qAux.ParamByName('factura_fec').AsInteger := ACabAbono.factura;
    qAux.ParamByName('vendedor_fec').AsString := ACabAbono.eanEmpresa;
    qAux.ParamByName('cobrador_fec').AsString := ACabAbono.eanEmpresa;
    qAux.ParamByName('comprador_fec').AsString := ACabAbono.comprador;
    qAux.ParamByName('receptor_fec').AsString := ACabAbono.receptor;
    qAux.ParamByName('cliente_fec').AsString := ACabAbono.cliente;
    qAux.ParamByName('pagador_fec').AsString := ACabAbono.pagador;
    qAux.ParamByName('pedido_fec').AsString := ACabAbono.pedido;
    qAux.ParamByName('fecha_factura_fec').AsDateTime := ACabAbono.fecha;
    qAux.ParamByName('nodo_fec').AsInteger := ACabAbono.nodo;
    qAux.ParamByName('rsocial_fec').AsString := ACabAbono.nombre;
    qAux.ParamByName('domicilio_fec').AsString := ACabAbono.domicilo;
    qAux.ParamByName('ciudad_fec').AsString := ACabAbono.ciudad;
    qAux.ParamByName('cp_fec').AsString := ACabAbono.cod_postal;
    qAux.ParamByName('nif_fec').AsString := ACabAbono.nif;
    qAux.ParamByName('albaran_fec').AsString := ACabAbono.n_albaran;
    qAux.ParamByName('fecha_albaran_fec').AsDateTime := ACabAbono.fecha_Albaran;
    qAux.ParamByName('fecha_entrega_fec').AsDateTime := ACabAbono.fecha_Albaran;
    qAux.ParamByName('bruto_fec').AsFloat := Abs( ACabAbono.neto );
    qAux.ParamByName('porc_cargos_fec').AsFloat := 0.0;
    qAux.ParamByName('cargos_fec').AsFloat := 0.0;
    qAux.ParamByName('porc_descuen_fec').AsFloat := 0.0;
    qAux.ParamByName('descuentos_fec').AsFloat := 0.0;
    qAux.ParamByName('impuestos_fec').AsFloat := Abs( ACabAbono.iva );
    qAux.ParamByName('total_factura_fec').AsFloat := Abs( ACabAbono.total );
    qAux.ParamByName('moneda_fec').AsString := ACabAbono.moneda;
    qAux.ParamByName('vencimiento1_fec').AsDateTime := GetFechaVencimiento( ACabAbono.codEmpresa, ACabAbono.cod_cliente, ACabAbono.fecha );
    qAux.ParamByName('importe_vto1_fec').Asfloat := Abs( ACabAbono.total ) ;

    qAux.ExecSQL;

    InsertarCabImpuesto( ACabAbono );
    InsertarLineasEdi( ACabAbono );

  finally
    FreeAndNil( qAux );
  end;
end;

procedure CreaLineasAbonoEDI( const AEmpresa: string; const AAbono: integer;
  const AFecha: TDateTime; const AALbaran, APedido: string; const ASoloBorrar: Boolean );
var
  rCabFacturaEdiVar: RCabFacturaEdi;
begin
  //Datos empresa y factura (cabecera)
  rCabFacturaEdiVar:= DatosAbonoCab( AEmpresa, AAbono, AFecha );

  rCabFacturaEdiVar.codEmpresa:= AEmpresa;
  rCabFacturaEdiVar.factura:= AAbono;
  rCabFacturaEdiVar.fecha:= AFecha;
  rCabFacturaEdiVar.eanEmpresa:= CodigoEdiEmpresa( AEmpresa );

  //rCabFacturaEdiVar.fechaAlbaran:= GetFechaAlbaran( AEmpresa, rCabFacturaEdiVar.

  if not ASoloBorrar then
  begin
    DatosEdiCliente( AEmpresa, AAbono, AFecha, AALbaran, APedido, rCabFacturaEdiVar  );
    if rCabFacturaEdiVar.neto <> NetoAbonoLin( AEmpresa, AAbono, AFecha ) then
    begin
      raise Exception.Create('No coinciden el importe de la cabecera con la suma de las lineas.');
    end;
  end;

  //Esto deberia estar dentro de una transaccion
  if ExisteFacturaEdi( rCabFacturaEdiVar.codEmpresa, AAbono, AFecha ) then
    BorrarFacturaEdi( rCabFacturaEdiVar.codEmpresa, AAbono, AFecha );
  if not ASoloBorrar then
  begin
    CrearAbonoEdi( rCabFacturaEdiVar );
  end;

  ShowMessage('Proceso finalizado.');
end;

procedure TFPAbonosEdi.abonoChange(Sender: TObject);
begin
  AbonoMercadona;
end;

procedure TFPAbonosEdi.AbonoMercadona;
begin
  if CamposRellenos( False ) then
  begin
   with DMAuxDB.QAux do
    begin
      SQL.Clear;
      SQL.Add( ' select empresa_fal, cliente_fac_f,  centro_salida_fal, fecha_albaran_fal, n_albaran_fal, n_pedido_sc, albaran_fec, pedido_fec ');
      SQL.Add( ' from frf_facturas ');
      SQL.Add( '      left join frf_fac_abonos_l on empresa_fal = empresa_f and factura_fal = n_factura_f and fecha_fal = fecha_factura_f ');
      SQL.Add( '      left join frf_salidas_c on empresa_sc = empresa_fal and centro_salida_sc = centro_salida_fal  and ');
      SQL.Add( '                                 n_albaran_sc = n_albaran_fal and  fecha_sc = fecha_albaran_fal ');
      SQL.Add( '      left join frf_facturas_edi_c on empresa_fec = empresa_f and factura_fec = n_factura_f and fecha_factura_fec = fecha_factura_f ');
      SQL.Add( ' where empresa_f = :empresa and n_factura_f = :factura and fecha_factura_f = :fecha ');
      ParamByName('empresa').AsString:= sEmpresa;
      ParamByName('factura').AsInteger:= iFactura;
      ParamByName('fecha').AsDate:= dFecha;

      Open;
      if not IsEmpty then
      begin
        if FieldByName('cliente_fac_f').AsString = 'MER' then
        begin
          txtPedido.Enabled:= True;
          lblPedido.Enabled:= True;
          edtPedido.Enabled:= True;
          txtAlbaran.Enabled:= True;
          edtAlbaran.Enabled:= True;
          edtPedido.Text:= FieldByName('pedido_fec').AsString;
          edtAlbaran.Text:= FieldByName('albaran_fec').AsString;
        end
        else
        begin
          txtPedido.Enabled:= False;
          lblPedido.Enabled:= False;
          edtPedido.Enabled:= False;
          txtAlbaran.Enabled:= False;
          edtAlbaran.Enabled:= False;
          edtPedido.Text:= '';
          edtAlbaran.Text:= '';
        end;
      end
      else
      begin
        txtPedido.Enabled:= False;
        lblPedido.Enabled:= False;
        edtPedido.Enabled:= False;
        txtAlbaran.Enabled:= False;
        edtAlbaran.Enabled:= False;
        edtPedido.Text:= '';
        edtAlbaran.Text:= '';
      end;
      Close;
    end;
  end;
end;

end.

