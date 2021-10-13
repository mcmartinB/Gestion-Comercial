unit LiquidacionEntregaFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, nbLabels, nbCombos, nbEdits, BEdit, ExtCtrls;

type
  TFLLiquidacionEntrega = class(TForm)
    btnCerrar: TBitBtn;
    btnAceptar: TBitBtn;
    Label3: TLabel;
    lblEntrega: TnbLabel;
    eEntrega: TBEdit;
    cbxProducto: TComboBox;
    cbxVariedad: TComboBox;
    cbxCalibre: TComboBox;
    nbLabel1: TnbLabel;
    nbLabel2: TnbLabel;
    nbLabel3: TnbLabel;
    nbLabel4: TnbLabel;
    nbLabel5: TnbLabel;
    nbLabel6: TnbLabel;
    nbLabel7: TnbLabel;
    Bevel1: TBevel;
    lblPaletsIn: TLabel;
    lblPaletsOut: TLabel;
    lblKilosIn: TLabel;
    lblKilosOut: TLabel;
    stProducto: TLabel;
    stVariedad: TLabel;
    nbLabel8: TnbLabel;
    eAjusteKilosVenta: TBEdit;
    nbLabel9: TnbLabel;
    eAjusteKilosDestrio: TBEdit;
    nbLabel10: TnbLabel;
    lblKilosDestrio: TLabel;
    nbLabel11: TnbLabel;
    lblCuadre: TLabel;
    lblPaletsDestrio: TLabel;
    nbLabel12: TnbLabel;
    eImportePteVta: TBEdit;
    nbLabel13: TnbLabel;
    eImporteDestrio: TBEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCerrarClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbxProductoChange(Sender: TObject);
    procedure cbxVariedadChange(Sender: TObject);
    procedure cbxCalibreChange(Sender: TObject);
    procedure eAjusteKilosVentaChange(Sender: TObject);
    procedure eAjusteKilosDestrioChange(Sender: TObject);
    procedure eImportePteVtaChange(Sender: TObject);
    procedure eImporteDestrioChange(Sender: TObject);
  private
    { Private declarations }

    sEntrega, sEmpresa, sCentro, sProveedor, sProducto, sVariedad, sCalibre: string;
    iPaletsEntrega, iPaletsSalida, iPaletsDestrio: integer;
    rKilosEntrega, rKilosSalida, rKilosDestrio: real;
    rKilosAjusteVentas, rKilosAjusteDestrio, rKilosCuadre: real;
    rImportePteVta, rImporteDestrio: real;

    procedure ValidarCampos;

    procedure ObtenerDatosRemesa;
    procedure ObtenerLiquidacion;
    procedure CerrarPrograma;
    procedure PantallaInicial;

    procedure ActualizarComboVariedades;
    procedure ActualizarComboCalibres;
    procedure ActualizarCuadroKilos( const APintar: Boolean );
    procedure RepintarCuadroKilos;

    procedure KilosEntrega;
    procedure DatosPacking;
    procedure IncrementarValores;

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CVariables, Principal, CGestionPrincipal, UDMAuxDB,
     DPreview, UDMBaseDatos, UDMConfig, LiquidacionEntregaQL,
     LiquidacionEntregaDL;

procedure TFLLiquidacionEntrega.FormCreate(Sender: TObject);
begin
  FormType:=tfOther;
  BHFormulario;
  DLLiquidacionEntrega:= TDLLiquidacionEntrega.Create( self );

  lblPaletsIn.Caption:= '';
  lblPaletsOut.Caption:= '';
  lblPaletsDestrio.Caption:= '';
  lblKilosIn.Caption:= '';
  lblKilosOut.Caption:= '';
  lblKilosDestrio.Caption:= '';
  lblCuadre.Caption:= '';
end;

procedure TFLLiquidacionEntrega.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType:=tfDirector;
    BHFormulario;
  end;
  FreeAndNil( DLLiquidacionEntrega );
  Action:=caFree;
end;

procedure TFLLiquidacionEntrega.ValidarCampos;
begin
  if Length( Trim( eEntrega.Text ) ) < 12 then
  begin
    eEntrega.SetFocus;
    raise Exception.Create('Falta el código de la  entrega o esta incompleto.');
  end;
end;


procedure TFLLiquidacionEntrega.btnAceptarClick(Sender: TObject);
begin
  if btnAceptar.Tag = 0 then
  begin
    ObtenerDatosRemesa;
  end
  else
  begin
    ObtenerLiquidacion;
  end;
end;

procedure TFLLiquidacionEntrega.ObtenerDatosRemesa;
begin
  ValidarCampos;
  sEntrega:= eEntrega.Text;
  if DLLiquidacionEntrega.DatosEntrega( sEntrega ) then
  begin
    btnCerrar.Tag:= 1;
    btnAceptar.Tag:= 1;
    btnCerrar.Caption:= 'Cancelar (Esc)';
    btnAceptar.Caption:= 'Liquidar (F1)';

    eEntrega.Enabled:= false;

    cbxProducto.Items.Clear;
    cbxProducto.Items.Add('-');
    cbxProducto.ItemIndex:= 0;
    cbxProducto.Enabled:= True;
    stProducto.Caption:= 'Todos los productos';
    cbxVariedad.Items.Clear;
    cbxVariedad.Items.Add('-');
    cbxVariedad.ItemIndex:= 0;
    cbxVariedad.Enabled:= false;
    stVariedad.Caption:= 'Todas las variedades';
    cbxCalibre.Items.Clear;
    cbxCalibre.Items.Add('Todos');
    cbxCalibre.ItemIndex:= 0;
    cbxCalibre.Enabled:= false;
    eAjusteKilosVenta.Enabled:= True;
    eAjusteKilosDestrio.Enabled:= True;
    eImportePteVta.Enabled:= True;
    eImporteDestrio.Enabled:= True;

    //ActualizarCuadroKilos( False );

    sEmpresa:= DLLiquidacionEntrega.QEntrega.FieldByName('empresa_ec').AsString;
    sCentro:= DLLiquidacionEntrega.QEntrega.FieldByName('centro_llegada_ec').AsString;
    sProveedor:= DLLiquidacionEntrega.QEntrega.FieldByName('proveedor_ec').AsString;
    sProducto:= '';
    sVariedad:= '';
    sCalibre:= '';

    while not DLLiquidacionEntrega.QEntrega.eof do
    begin
      if cbxProducto.Items.IndexOf( DLLiquidacionEntrega.QEntrega.FieldByName('producto_el').AsString ) = -1 then
        cbxProducto.Items.Add( DLLiquidacionEntrega.QEntrega.FieldByName('producto_el').AsString );
      DLLiquidacionEntrega.QEntrega.Next;
    end;
    ActualizarCuadroKilos( true );
  end
  else
  begin
      ShowMEssage('No hay datos para el código de entrega seleccionado.');
  end;
  //DLLiquidacionEntrega.QEntrega.Close;
end;

procedure TFLLiquidacionEntrega.ObtenerLiquidacion;
begin
  if DLLiquidacionEntrega.DatosLiquidacion( sEntrega, sProducto, sVariedad, sCalibre, sProveedor,
                                            rKilosAjusteVentas, rKilosAjusteDestrio,
                                            rImportePteVta, rImporteDestrio ) then
  begin
    VerLiquidacionEntrega( self, sEntrega );
  end
  else
  begin
    ShowMessage('Sin datos para realizar la liquidación.');
  end;
  (*
   sEmpresa, sCentro, sProveedor, sProducto, sVariedad, sCalibre: string;
    iPaletsEntrega, iPaletsSalida, iPaletsDestrio: integer;
    rKilosEntrega, rKilosSalida, rKilosDestrio: real;
    rKilosAjusteVentas, rKilosAjusteDestrio, rKilosCuadre: real;
    rKilosTotales: real;
  *)
end;

procedure TFLLiquidacionEntrega.btnCerrarClick(Sender: TObject);
begin
  if btnCerrar.Tag = 0 then
  begin
    CerrarPrograma;
  end
  else
  begin
    PantallaInicial;
  end;
end;

procedure TFLLiquidacionEntrega.CerrarPrograma;
begin
  Close;
end;

procedure TFLLiquidacionEntrega.PantallaInicial;
begin
  btnCerrar.Tag:= 0;
  btnAceptar.Tag:= 0;
  btnCerrar.Caption:= 'Cerrar (Esc)';
  btnAceptar.Caption:= 'Aceptar (Esc)';

  eEntrega.Enabled:= True;
  eEntrega.Focused;

  cbxProducto.Items.Clear;
  cbxProducto.ItemIndex:= -1;
  cbxProducto.Enabled:= False;
  stProducto.Caption:= '';
  cbxVariedad.Items.Clear;
  cbxVariedad.ItemIndex:= -1;
  cbxVariedad.Enabled:= false;
  stVariedad.Caption:= '';
  cbxCalibre.Items.Clear;
  cbxCalibre.ItemIndex:= -1;
  cbxCalibre.Enabled:= false;
  eAjusteKilosVenta.Enabled:= False;
  eAjusteKilosVenta.Text:= '';
  eAjusteKilosDestrio.Enabled:= False;
  eAjusteKilosDestrio.Text:= '';
  eImportePteVta.Enabled:= False;
  eImportePteVta.Text:= '';
  eImporteDestrio.Enabled:= False;
  eImporteDestrio.Text:= '';

  ActualizarCuadroKilos( False );
end;

procedure TFLLiquidacionEntrega.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    Vk_escape: btnCerrar.Click;
    vk_f1: btnAceptar.Click;
  end;
end;

procedure TFLLiquidacionEntrega.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    // Tecla ENTER - Cambio entre los Controles de Datos en modo edición
    //               y entre los Campos de Búsqueda en la localización
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
  end;
end;

procedure TFLLiquidacionEntrega.cbxProductoChange(Sender: TObject);
begin
  sProducto:= '';
  if cbxProducto.ItemIndex > 0 then
  begin
    sProducto:= cbxProducto.Items[ cbxProducto.Itemindex ];
    stProducto.Caption:= desProducto( sEmpresa, sProducto );
  end
  else
  if cbxProducto.ItemIndex = 0 then
  begin
    stProducto.Caption:= 'Todos los productos';
  end
  else
  begin
    stProducto.Caption:= '';
  end;
  ActualizarComboVariedades;
  ActualizarComboCalibres;
  ActualizarCuadroKilos( true );
end;

procedure TFLLiquidacionEntrega.cbxVariedadChange(Sender: TObject);
begin
  sVariedad:= '';
  if cbxVariedad.ItemIndex > 0 then
  begin
    sVariedad:= cbxVariedad.Items[ cbxVariedad.Itemindex ];
    stVariedad.Caption:= desVariedad( sEmpresa, sProveedor, sProducto, sVariedad );
  end
  else
  if cbxVariedad.ItemIndex = 0 then
  begin
    stVariedad.Caption:= 'Todas las variedades';
  end
  else
  begin
    stVariedad.Caption:= '';
  end;
  ActualizarComboCalibres;
  ActualizarCuadroKilos( true );
end;

procedure TFLLiquidacionEntrega.cbxCalibreChange(Sender: TObject);
begin
  if cbxCalibre.ItemIndex > 0 then
  begin
    sCalibre:= cbxCalibre.Items[ cbxCalibre.Itemindex ];
  end
  else
  begin
    sCalibre:= '';
  end;
  ActualizarCuadroKilos( true );
end;

procedure TFLLiquidacionEntrega.ActualizarComboVariedades;
begin
  if cbxProducto.ItemIndex > 0 then
  begin
    cbxVariedad.Items.Clear;
    cbxVariedad.Items.Add('-');
    cbxVariedad.ItemIndex:= 0;
    cbxVariedad.Enabled:= true;

    DLLiquidacionEntrega.QEntrega.First;
    while not DLLiquidacionEntrega.QEntrega.eof do
    begin
      if DLLiquidacionEntrega.QEntrega.FieldByName('producto_el').AsString = sproducto then
      begin
        if cbxVariedad.Items.IndexOf( DLLiquidacionEntrega.QEntrega.FieldByName('variedad_el').AsString ) = -1 then
          cbxVariedad.Items.Add( DLLiquidacionEntrega.QEntrega.FieldByName('variedad_el').AsString );
      end;
      DLLiquidacionEntrega.QEntrega.Next;
    end;

  end
  else
  if cbxProducto.ItemIndex = 0 then
  begin
    cbxVariedad.Items.Clear;
    cbxVariedad.Items.Add('-');
    cbxVariedad.ItemIndex:= 0;
    cbxVariedad.Enabled:= false;
    stVariedad.Caption:= 'Todas las variedades';
  end
  else
  begin
    cbxVariedad.Items.Clear;
    cbxVariedad.ItemIndex:= -1;
    cbxVariedad.Enabled:= false;
    stVariedad.Caption:= 'Todas las variedades';
  end;
end;

procedure TFLLiquidacionEntrega.ActualizarComboCalibres;
begin
  if cbxVariedad.ItemIndex > 0 then
  begin
    cbxCalibre.Items.Clear;
    cbxCalibre.Items.Add('Todos');
    cbxCalibre.ItemIndex:= 0;
    cbxCalibre.Enabled:= true;

    DLLiquidacionEntrega.QEntrega.First;
    while not DLLiquidacionEntrega.QEntrega.eof do
    begin
      if ( DLLiquidacionEntrega.QEntrega.FieldByName('producto_el').AsString = sproducto ) and
         ( DLLiquidacionEntrega.QEntrega.FieldByName('variedad_el').AsString = sVariedad )then
      begin
        if cbxCalibre.Items.IndexOf( DLLiquidacionEntrega.QEntrega.FieldByName('calibre_el').AsString ) = -1 then
          cbxCalibre.Items.Add( DLLiquidacionEntrega.QEntrega.FieldByName('calibre_el').AsString );
        rKilosEntrega:= rKilosEntrega + DLLiquidacionEntrega.QEntrega.FieldByName('kilos_el').AsFloat;
      end;
      DLLiquidacionEntrega.QEntrega.Next;
    end;

  end
  else
  if cbxVariedad.ItemIndex = 0 then
  begin
    cbxCalibre.Items.Clear;
    cbxCalibre.Items.Add('Todos');
    cbxCalibre.ItemIndex:= 0;
    cbxCalibre.Enabled:= false;
  end
  else
  begin
    cbxCalibre.Items.Clear;
    cbxCalibre.ItemIndex:= -1;
    cbxCalibre.Enabled:= false;
  end;
end;

procedure TFLLiquidacionEntrega.ActualizarCuadroKilos( const APintar: Boolean );
begin
  if not APintar then
  begin
    lblPaletsIn.Caption:= '';
    lblPaletsOut.Caption:= '';
    lblPaletsDestrio.Caption:= '';
    lblKilosIn.Caption:= '';
    lblKilosOut.Caption:= '';
    lblKilosDestrio.Caption:= '';
    lblCuadre.Caption:= '';

    iPaletsEntrega:= 0;
    iPaletsSalida:= 0;
    iPaletsDestrio:= 0;
    rKilosEntrega:= 0;
    rKilosSalida:= 0;
    rKilosDestrio:= 0;
    rKilosAjusteVentas:= 0;
    rKilosAjusteDestrio:= 0;
    rKilosCuadre:= 0;
  end
  else
  begin
    KilosEntrega;
    lblKilosIn.Caption:= FormatFloat( '#,##0.00', rKilosEntrega );

    DatosPacking;
    lblPaletsIn.Caption:= FormatFloat( '#,##0', iPaletsEntrega );
    lblPaletsOut.Caption:= FormatFloat( '#,##0', iPaletsSalida );
    lblPaletsDestrio.Caption:= FormatFloat( '#,##0', iPaletsDestrio );
    lblKilosOut.Caption:= FormatFloat( '#,##0.00', rKilosSalida );
    lblKilosDestrio.Caption:= FormatFloat( '#,##0.00', rKilosDestrio );

    rKilosCuadre:= rKilosEntrega - (rKilosSalida+rKilosDestrio+rKilosAjusteVentas+rKilosAjusteDestrio);
    lblCuadre.Caption:= FormatFloat( '#,##0.00', rKilosCuadre );
  end;
end;

procedure TFLLiquidacionEntrega.RepintarCuadroKilos;
begin
  lblKilosIn.Caption:= FormatFloat( '#,##0.00', rKilosEntrega );
  lblPaletsIn.Caption:= FormatFloat( '#,##0', iPaletsEntrega );
  lblPaletsOut.Caption:= FormatFloat( '#,##0', iPaletsSalida );
  lblPaletsDestrio.Caption:= FormatFloat( '#,##0', iPaletsDestrio );
  lblKilosOut.Caption:= FormatFloat( '#,##0.00', rKilosSalida );
  lblKilosDestrio.Caption:= FormatFloat( '#,##0.00', rKilosDestrio );
  rKilosCuadre:= rKilosEntrega - (rKilosSalida+rKilosDestrio+rKilosAjusteVentas+rKilosAjusteDestrio);
  lblCuadre.Caption:= FormatFloat( '#,##0.00', rKilosCuadre );
end;

procedure TFLLiquidacionEntrega.eAjusteKilosVentaChange(Sender: TObject);
begin
  rKilosAjusteVentas:= StrToFloatDef( eAjusteKilosVenta.Text, 0);
  RepintarCuadroKilos;
end;

procedure TFLLiquidacionEntrega.eAjusteKilosDestrioChange(Sender: TObject);
begin
  rKilosAjusteDestrio:= StrToFloatDef( eAjusteKilosDestrio.Text, 0);
  RepintarCuadroKilos;
end;

procedure TFLLiquidacionEntrega.eImportePteVtaChange(Sender: TObject);
begin
  rImportePteVta:= StrToFloatDef( eImportePteVta.Text, 0);
end;

procedure TFLLiquidacionEntrega.eImporteDestrioChange(Sender: TObject);
begin
  rImporteDestrio:= StrToFloatDef( eImporteDestrio.Text, 0);
end;

procedure TFLLiquidacionEntrega.KilosEntrega;
begin
  rKilosEntrega:= 0;
  DLLiquidacionEntrega.QEntrega.First;
  while not DLLiquidacionEntrega.QEntrega.eof do
  begin
    if sProducto = '' then
    begin
      rKilosEntrega:= rKilosEntrega +  DLLiquidacionEntrega.QEntrega.FieldByName('kilos_el').AsFloat;
    end
    else
    begin
      if DLLiquidacionEntrega.QEntrega.FieldByName('producto_el').AsString = sProducto then
      begin
        if sVariedad = '' then
        begin
          rKilosEntrega:= rKilosEntrega +  DLLiquidacionEntrega.QEntrega.FieldByName('kilos_el').AsFloat;
        end
        else
        begin
          if DLLiquidacionEntrega.QEntrega.FieldByName('variedad_el').AsString = sVariedad then
          begin
            if sCalibre = '' then
            begin
              rKilosEntrega:= rKilosEntrega +  DLLiquidacionEntrega.QEntrega.FieldByName('kilos_el').AsFloat;
            end
            else
            begin
              if DLLiquidacionEntrega.QEntrega.FieldByName('calibre_el').AsString = sCalibre then
              begin
                rKilosEntrega:= rKilosEntrega +  DLLiquidacionEntrega.QEntrega.FieldByName('kilos_el').AsFloat;
              end;
            end;
          end;
        end;
      end;
    end;
    DLLiquidacionEntrega.QEntrega.Next;
  end;
end;

procedure TFLLiquidacionEntrega.DatosPacking;
begin
//sscc, ean128_pl, empresa, entrega, centro, proveedor,
//       ( select cliente_sal_occ from frf_orden_carga_c where orden_occ = orden_pl ) cliente,
//       producto, producto_pl, variedad, envase_pl, calibre, calibre_pl,
//       peso_bruto, peso, peso_pl, cajas, cajas_pl

//    iPaletsEntrega, iPaletsSalida, iPaletsDestrio: integer;
//    rKilosEntrega, rKilosSalida, rKilosDestrio: real;
//    rKilosAjusteVentas, rKilosAjusteDestrio, rKilosCuadre: real;

  iPaletsEntrega:= 0;
  iPaletsSalida:= 0;
  iPaletsDestrio:= 0;
  rKilosSalida:= 0;
  rKilosDestrio:= 0;
  rKilosAjusteVentas:= 0;
  rKilosAjusteDestrio:= 0;
  rKilosCuadre:= 0;

  DLLiquidacionEntrega.QPacking.First;
  while not DLLiquidacionEntrega.QPacking.eof do
  begin
    if sProducto = '' then
    begin
      IncrementarValores;
    end
    else
    begin
      if DLLiquidacionEntrega.QPacking.FieldByName('producto').AsString = sProducto then
      begin
        if sVariedad = '' then
        begin
          IncrementarValores;
        end
        else
        begin
          if DLLiquidacionEntrega.QPacking.FieldByName('variedad').AsString = sVariedad then
          begin
            if sCalibre = '' then
            begin
              IncrementarValores;
            end
            else
            begin
              if DLLiquidacionEntrega.QPacking.FieldByName('calibre').AsString = sCalibre then
              begin
                IncrementarValores;
              end;
            end;
          end;
        end;
      end;
    end;
    DLLiquidacionEntrega.QPacking.Next;
  end;
end;

procedure TFLLiquidacionEntrega.IncrementarValores ;
begin
  iPaletsEntrega:= iPaletsEntrega + 1;
  if DLLiquidacionEntrega.QPacking.FieldByName('ean128_pl').AsString <> '' then
  begin
    if DLLiquidacionEntrega.QPacking.FieldByName('cliente').AsString <> '003' then
    begin
      iPaletsSalida:= iPaletsSalida + 1;
      rKilosSalida:= rKilosSalida +  DLLiquidacionEntrega.QPacking.FieldByName('peso_pl').AsFloat;
    end
    else
    begin
      iPaletsDestrio:= iPaletsDestrio + 1;
      rKilosDestrio:= rKilosDestrio +  DLLiquidacionEntrega.QPacking.FieldByName('peso_pl').AsFloat;
    end;
  end
  else
  begin
    if DLLiquidacionEntrega.QPacking.FieldByName('status').AsString = 'D' then
    begin
      iPaletsDestrio:= iPaletsDestrio + 1;
      rKilosDestrio:= rKilosDestrio +  DLLiquidacionEntrega.QPacking.FieldByName('peso').AsFloat;
    end;
  end;
end;

end.
