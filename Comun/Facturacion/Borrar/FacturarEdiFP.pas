unit FacturarEdiFP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, Db, DBTables, ExtCtrls, DBCtrls, Grids, DBGrids, Dialogs,
  BEdit, DBClient, Buttons, provider, ComCtrls,
  Mask, BCalendario, BSpeedButton, BCalendarButton, BGrid,
  BGridButton, FileCtrl;

type
  TSqlCad = (scInteger, scString, scDate, scReal);

type
  TFPFacturarEdi = class(TForm)
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    edtFactHasta: TBEdit;
    edtFactDesde: TBEdit;
    StaticText1: TStaticText;
    StaticText4: TStaticText;
    edtFecha: TBEdit;
    BtnFind: TBitBtn;
    edtRuta: TStaticText;
    BtnOk: TBitBtn;
    BtnCancel: TBitBtn;
    BCalendarButton1: TBCalendarButton;
    BCalendario1: TBCalendario;
    StaticText5: TStaticText;
    Bevel1: TBevel;
    StaticText6: TStaticText;
    edtEmpresa: TBEdit;
    stEmpresa: TStaticText;
    BGridButton1: TBGridButton;
    RejillaFlotante: TBGrid;
    lblCliente: TStaticText;
    edtCliente: TComboBox;
    stCliente: TStaticText;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnFindClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCalendarButton1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BGridButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtEmpresaChange(Sender: TObject);
    procedure edtClienteChange(Sender: TObject);
  private
    { Private declarations }
    salir: boolean;
    sEmpresa, sVendedor, sCliente: string;
    iFactIni, iFactFin: Integer;
    dFechaFact: TDateTime;
    sRuta: string;

    function  CamposRellenos: Boolean;
    //procedure MensajeFin;
  public
    { Public declarations }
  end;

implementation

uses UDMAuxDB, StrUtils, CAuxiliarDB, DError, CgestionPrincipal, CVariables,
  UDMBaseDatos, UDMFacturacion, FacturarEdiDP, FacturarEdiMercadonaUP,
  FacturarEdiTescoUP, CGlobal;

{$R *.DFM}

procedure TFPFacturarEdi.FormShow(Sender: TObject);
begin
  BCalendario1.Date := Date;

  edtFecha.Text := datetostr(date);
  edtFactDesde.Text := '1';
  edtFactHasta.Text := '999999';
  edtEmpresa.Text := gsDefEmpresa;
  salir := false;
end;

procedure TFPFacturarEdi.BitBtn1Click(Sender: TObject);
begin
  //Cerrar el program
  if BCalendario1.Visible then Exit;
  Salir := true;
  Close;
end;

{
procedure TFPFacturarEdi.MensajeFin;
var
  iFacturas, iPasadas, iManuales: integer;
begin
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' Select count(*) registros');
    SQL.Add(' FROM frf_facturas, frf_clientes ');
    SQL.Add(' WHERE empresa_f = :empresa ');
    SQL.Add(' and n_factura_f  BETWEEN  :facini  AND :facfin ');
    SQL.Add(' AND fecha_factura_f = :fecha ');
    SQL.Add(' and cliente_fac_f = :cliente');
    SQL.Add(' and empresa_c = :empresa ');
    SQL.Add(' and cliente_c = cliente_fac_f ');
    SQL.Add(' and edi_c = ''S'' ');

    ParamByName('empresa').AsString := sEmpresa;
    ParamByName('cliente').AsString := sCliente;
    ParamByName('facini').AsInteger := iFactIni;
    ParamByName('facfin').AsInteger := iFactFin;
    ParamByName('fecha').AsDateTime := dFechaFact;

    Open;
    iFacturas:= FieldByName('registros').AsInteger;
    Close;

    SQL.Clear;
    SQL.Add(' SELECT count(*) registros');
    SQL.Add(' FROM frf_facturas_edi_c ');
    SQL.Add(' WHERE factura_fec  BETWEEN  :desde  AND :hasta ');
    SQL.Add(' AND fecha_factura_fec = :fecha ');
    SQL.Add(' AND empresa_fec = :empresa ');
    SQL.Add('  and cliente_fec in ( select aquiensefactura_ce ');
    SQL.Add('                       from frf_clientes_edi');
    SQL.Add('                       where empresa_ce = :empresa');
    SQL.Add('                       and cliente_ce = :cliente )');
    ParamByName('desde').AsInteger := iFactIni;
    ParamByName('hasta').AsInteger := iFactFin;
    ParamByName('fecha').AsDateTime := dFechaFact;
    ParamByName('empresa').AsString := sEmpresa;
    ParamByName('cliente').AsString := sCliente;

    Open;
    iPasadas:= FieldByName('registros').AsInteger;
    Close;

    if iPasadas < iFacturas then
    begin
      SQL.Clear;
      SQL.Add(' Select count(*) registros');
      SQL.Add(' FROM frf_facturas, frf_clientes ');
      SQL.Add(' WHERE empresa_f = :empresa ');
      SQL.Add(' and n_factura_f  BETWEEN  :facini  AND :facfin ');
      SQL.Add(' AND fecha_factura_f = :fecha ');
      SQL.Add(' and cliente_fac_f = :cliente');
      SQL.Add(' and concepto_f = ''M'' ');
      SQL.Add(' and empresa_c = :empresa ');
      SQL.Add(' and cliente_c = cliente_fac_f ');
      SQL.Add(' and edi_c = ''S'' ');

      ParamByName('empresa').AsString := sEmpresa;
      ParamByName('cliente').AsString := sCliente;
      ParamByName('facini').AsInteger := iFactIni;
      ParamByName('facfin').AsInteger := iFactFin;
      ParamByName('fecha').AsDateTime := dFechaFact;

      open;
      iManuales:= FieldByName('registros').AsInteger;
      Close;

      if iManuales > 0 then
      begin
        ShowError('Fichero incompleto, se han pasado ' + IntToStr(iPasadas) + ' de ' +
                IntToStr(iFacturas) + ' facturas.' + #13 + #10 +
                'Hay ' + IntToStr( iManuales ) + ' abonos/facturas manuales, ' + #13 + #10 +
                'por favor verifique que la información EDI ha sido creada.' + #13 + #10 +
                'Operación Finalizada.')
      end
      else
      begin
        ShowError('Fichero incompleto, se han pasado ' + IntToStr(iPasadas) + ' de ' +
                IntToStr(iFacturas) + ' facturas.' + #13 + #10 +
                'Operación Finalizada.')
      end;
    end
    else
      MessageDlg('' + #13 + #10 + '         Operación Finalizada Correctamente (' + IntToStr( iPasadas ) + ' facturas).          ', mtCustom, [mbOK], 0);
  end;
end;
}


procedure TFPFacturarEdi.Button1Click(Sender: TObject);
var
  sMsg: string;
begin
  //Esperamos **********************************************
  BEMensajes(' Creando ficheros de texto .....');
  self.Refresh;
  //Esperamos **********************************************

  if CamposRellenos then
  begin
    if DPFacturarEdi.EsClienteEDI( sEmpresa, sCliente ) then
    begin
      sMsg:= '';
      if DPFacturarEdi.HayDatos( sEmpresa, sVendedor, sCliente, iFactIni, iFactFin, dFechaFact, sMsg )  then
      begin
        if DPFacturarEdi.CrearFicheros( sMsg ) then
          DPFacturarEdi.GuardarFicheros( sRuta );
        MessageDlg( sMsg, mtInformation, [mbOK], 0);
        //MensajeFin;
      end
      else
      begin
        MessageDlg( sMsg, mtWarning, [mbOK], 0);
      end;
    end
    else
    begin
      ShowMessage('Este cliente no esta marcado como cliente EDI.');
    end;
  end;

  //Esperamos **********************************************
  BEMensajes('');
  //Esperamos **********************************************
end;

function TFPFacturarEdi.CamposRellenos: Boolean;
begin
  Result := False;

  if stEmpresa.Caption = '' then
  begin
    edtEmpresa.SetFocus;
    ShowError('Falta codigo de la empresa o es incorrecto.');
  end
  else
  if stCliente.Caption = '' then
  begin
    edtCliente.SetFocus;
    ShowError('Falta codigo del cliente o es incorrecto.');
  end
  else
  if not TryStrToInt( Trim( edtFactDesde.Text ), iFactIni ) then
  begin
    edtFactDesde.SetFocus;
    ShowError('Falta el número de la factura inicial o es incorrecto.');
  end
  else
  if not TryStrToInt( Trim( edtFactHasta.Text ), iFactFin ) then
  begin
    edtFactHasta.SetFocus;
    ShowError('Falta el número de la factura final o es incorrecto.');
  end
  else
  if iFactIni > iFactFin then
  begin
    edtFactDesde.SetFocus;
    ShowError('Rango de facturas incorrecto.');
  end
  else
  if  not TryStrToDate( Trim( edtFecha.Text ), dFechaFact ) then
  begin
    edtFecha.SetFocus;
    ShowError('La fecha facturación es de obligada inserción.');
  end
  else
  if not DirectoryExists( edtRuta.Caption ) then
  begin
    edtRuta.SetFocus;
    ShowError('La ruta destino no es valida.');
  end
  else
  begin
    sEmpresa:= edtEmpresa.Text;
    sCliente:= edtCliente.Text;
    sRuta:= edtRuta.Caption;

    sVendedor:= sEmpresa;

    if sVendedor = '' then
      MessageDlg('' + #13 + #10 + 'No se ha podido localizar el código EAN del Vendedor,      ' + #13 + #10 + 'este código es necesario para la facturación EDI.' + #13 + #10 + '' + #13 + #10 + 'Por favor, compruebe que el campo "Codigo EAN13"    ' + #13 + #10 + 'en el mantenimiento de empresas tiene valor. Gracias.', mtWarning, [mbOK], 0)
    else
      Result := True;
  end;
end;

procedure TFPFacturarEdi.FormKeyUp(Sender: TObject; var Key: Word;
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
        if edtFecha.Focused then
          BCalendarButton1.Click;
        if edtEmpresa.Focused then
          BGridButton1.Click;
      end;
    vk_escape:
      begin
        if not RejillaFlotante.Visible and not BCalendario1.Visible then
          BtnCancel.Click;
      end;
  end;
end;

procedure TFPFacturarEdi.BtnFindClick(Sender: TObject);
var
  dir: string;
begin
  dir := edtRuta.caption;
  if SelectDirectory('   Selecciona directorio destino.', 'c:\', dir) then
  begin
    if copy(dir, length(dir) - 1, length(dir)) <> '\' then
    begin
      edtRuta.Caption := dir + '\';
      edtRuta.Hint:= edtRuta.Caption;
    end
    else
    begin
      edtRuta.caption := dir;
    end;
  end;
  Application.BringToFront;
end;

procedure TFPFacturarEdi.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if not Salir then
  begin
    Action := caNone
  end
  else
  begin
    FormType := tfDirector;
    BHFormulario;
    Action := caFree;

    FreeAndNil( DPFacturarEdi );
  end;
end;

procedure TFPFacturarEdi.BCalendarButton1Click(Sender: TObject);
begin
  BCalendarButton1.CalendarShow;
end;

procedure TFPFacturarEdi.FormCreate(Sender: TObject);
begin
  edtEmpresa.Tag := kEmpresa;
  ActiveControl := edtEmpresa;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  FormType := tfOther;
  BHFormulario;

  DPFacturarEdi:= TDPFacturarEdi.Create( self );

  if gsDirEdi <> '' then
    edtRuta.Caption:= Lowercase( gsDirEdi + '\');
  edtRuta.Hint:= edtRuta.Caption;
end;

procedure TFPFacturarEdi.FormActivate(Sender: TObject);
begin
  Top := 1;
end;

procedure TFPFacturarEdi.BGridButton1Click(Sender: TObject);
begin
  DespliegaRejilla(BGridButton1);
  ActiveControl := RejillaFlotante;
end;

procedure TFPFacturarEdi.edtEmpresaChange(Sender: TObject);
var
  i: integer;
  bFlag: Boolean;
  lista: TStringList;
begin
  if not RejillaFlotante.Visible and not BCalendario1.Visible then
  begin
    stEmpresa.Caption:= desEmpresa(edtEmpresa.Text);


    edtCliente.Items.Clear;
    lista:= TStringList.Create;
    DPFacturarEdi.ClientesEDI( edtempresa.Text, lista );
    edtCliente.Items.AddStrings( lista );
    FreeAndNil(lista);

    i:= 0;
    bFlag:= False;
    while ( i < edtCliente.Items.Count ) and ( not bFlag ) do
    begin
      bFlag:= edtCliente.Items[i] = 'MER';
      Inc( i );
    end;
    if bFlag then
      edtCliente.ItemIndex:= i - 1
    else
      edtCliente.ItemIndex:= 0;
    stCliente.Caption:=  desCliente( edtempresa.Text, edtCliente.Text );
  end;
end;

procedure TFPFacturarEdi.edtClienteChange(Sender: TObject);
begin
  if not RejillaFlotante.Visible and not BCalendario1.Visible then
  begin
    stCliente.Caption:=  desCliente( edtEmpresa.Text, edtCliente.Text );
  end;
end;

end.
