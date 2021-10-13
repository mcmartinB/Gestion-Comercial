unit CFLComHisSemVen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, BCalendarButton, Buttons, BSpeedButton, BGridButton,
  BEdit, ActnList, Grids, DBGrids, BGrid, ComCtrls,
  BCalendario, DBTables, Db, DateUtils;

type
  TDFLComHisSemVen = class(TForm)
    Panel1: TPanel;
    grupo: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    eEmpresa: TBEdit;
    eProducto: TBEdit;
    eCliente: TBEdit;
    BGBEmpresa: TBGridButton;
    BGBProducto: TBGridButton;
    BGBCliente: TBGridButton;
    STEmpresa: TStaticText;
    STProducto: TStaticText;
    STCliente: TStaticText;
    SBAceptar: TSpeedButton;
    SBCancelar: TSpeedButton;
    ActionList1: TActionList;
    Aceptar: TAction;
    Cancelar: TAction;
    DesplegarRejilla: TAction;
    RejillaFlotante: TBGrid;
    cbxTomate: TCheckBox;
    Bevel1: TBevel;
    Label6: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    cbxCantidadesEn: TComboBox;
    Label12: TLabel;
    Label15: TLabel;
    lblAnoSemana: TLabel;
    Label13: TLabel;
    eAnyoSemanaDesde: TBEdit;
    eAnyoSemanaHasta: TBEdit;
    procedure PonNombre(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure DesplegarRejillaExecute(Sender: TObject);
    procedure CancelarExecute(Sender: TObject);
    procedure SBAceptarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbClienteSalidaChange(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sProducto, sCliente: string;
    bTomate: Boolean;
    sSemanaDesde1, sSemanaDesde2, sSemanaDesde3: string;
    sSemanaHasta1, sSemanaHasta2, sSemanaHasta3: string;
    dFechaDesde1, dFechaDesde2, dFechaDesde3: TDate;
    dFechaHasta1, dFechaHasta2, dFechaHasta3: TDate;

    function  ValidarDatosFormulario( var AMsg: string ): boolean;
    procedure ObtenerDatosFormulario;
  public

  end;

//var
//  FLHisVentas: TFLHisVentas;

implementation

uses bDialogs, UDMAuxDB, CVariables, CAuxiliarDB, CGestionPrincipal, Principal,
  UDMBaseDatos, DError, DPreview, bTimeUtils, bSQLUtils,
  CReportes, bMath, CQLComHisSemVen, CMLComHisSemVen;

{$R *.DFM}

var
  DQLComHisSemVen: TDQLComHisSemVen;

procedure TDFLComHisSemVen.PonNombre(Sender: TObject);
begin
    if (gRF <> nil) then
      if esVisible( gRF ) then
        Exit;
    if (gCF <> nil) then
      if esVisible( gCF ) then
        Exit;
  case TComponent(Sender).Tag of
    kEmpresa: STEmpresa.Caption := desEmpresa(eEmpresa.Text);
    kProducto:
      begin
        STProducto.Caption := desProducto(eEmpresa.Text, eProducto.Text);
        if (eProducto.Text = 'E') or (eProducto.Text = 'T') then
        begin
          cbxTomate.Enabled := True;
        end
        else
        begin
          cbxTomate.Checked := False;
          cbxTomate.Enabled := False;
        end;
      end;
    kCliente: STCliente.Caption := desCliente(eEmpresa.Text, eCliente.Text);
  end;
end;

procedure TDFLComHisSemVen.FormCreate(Sender: TObject);
begin
  FormType := tfOther;
  BHFormulario;

  eEmpresa.Tag := kEmpresa;
  eCliente.Tag := kCliente;
  eProducto.Tag := kProducto;
  gRF := rejillaFlotante;
  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
  gCF := nil;

  eEmpresa.Text := gsDefEmpresa;
  eProducto.Text := gsDefProducto;

     //Crear tabla temporal
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' CREATE TEMP TABLE tmp_salidas_l ( ');
    SQL.Add('   fecha_sl DATE, ');
    SQL.Add('   moneda_sl CHAR( 3 ), ');
    SQL.Add('   kilos_sl DECIMAL( 10, 2), ');
    SQL.Add('   importe_neto_sl DECIMAL( 10, 2) ');
    SQL.Add(' ) ');
    ExecSQL;
  end;

end;

procedure TDFLComHisSemVen.FormDestroy(Sender: TObject);
begin
  //Crear tabla temporal
  with DMAuxDB.QAux do
  begin
    SQL.Clear;
    SQL.Add(' DROP TABLE tmp_salidas_l ');
    ExecSQL;
  end;
end;

procedure TDFLComHisSemVen.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  case key of
    $0D, $28: //vk_return,vk_down
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
        Exit;
      end;
    $26: //vk_up
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
        Exit;
      end;
    vk_f1:
      begin
        SBAceptar.Click;
      end;
  end;
end;

procedure TDFLComHisSemVen.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  gRF := nil;
  gCF := nil;
     //Vaciar la tabla que se utliza para sacar el listado
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  BEMensajes('');
  DMBaseDatos.DBBaseDatos.CloseDataSets;
  Action := caFree;
end;

procedure TDFLComHisSemVen.FormActivate(Sender: TObject);
begin
  ActiveControl := eEmpresa;
end;

procedure TDFLComHisSemVen.DesplegarRejillaExecute(Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(BGBEmpresa);
    kProducto: DespliegaRejilla(BGBProducto, [eEmpresa.Text]);
    kCliente: DespliegaRejilla(BGBCliente, [eEmpresa.Text]);
  end;
end;

procedure TDFLComHisSemVen.CancelarExecute(Sender: TObject);
begin
  if RejillaFlotante.Visible then
  begin
    RejillaFlotante.Hide;
    Exit;
  end;
  Close;
end;

function TDFLComHisSemVen.ValidarDatosFormulario( var AMsg: string ): boolean;
  procedure PonFoco( const AControl: TWinControl );
  begin
    if AControl.CanFocus then
      AControl.SetFocus;
  end;
begin
  result:= False;
  //Empresa
  if Trim( eEmpresa.Text ) = '' then
  begin
    AMsg:= 'Falta el código de la empresa.';
    PonFoco( eEmpresa );
    Exit;
  end;
  if STEmpresa.Caption = '' then
  begin
    AMsg:= 'Código de empresa incorrecto.';
    PonFoco( eEmpresa );
    Exit;
  end;

  //Producto
  if Trim( eProducto.Text ) = '' then
  begin
    AMsg:= 'Falta el código del producto.';
    PonFoco( eProducto );
    Exit;
  end;
  if STProducto.Caption = '' then
  begin
    AMsg:= 'Código del producto incorrecto.';
    PonFoco( eProducto );
    Exit;
  end;


  //Rango temporal
  if Length(Trim(eAnyoSemanaDesde.Text)) <> 6 then
  begin
    AMsg:= 'Falta el Año/Semana de inicio.';
    PonFoco( eAnyoSemanaDesde );
    Exit;
  end;
  if Length(Trim(eAnyoSemanaHasta.Text)) <> 6 then
  begin
    AMsg:= 'Falta el Año/Semana de fin.';
    PonFoco( eAnyoSemanaHasta );
    Exit;
  end;
  if StrToInt( eAnyoSemanaHasta.Text ) < StrToInt( eAnyoSemanaDesde.Text ) then
  begin
    AMsg:= 'Rango de Años/Semanas incorrecto.';
    PonFoco( eAnyoSemanaDesde );
    Exit;
  end;

  //Cliente
  if Trim( eCliente.Text ) <> '' then
  begin
    if STCliente.Caption = '' then
    begin
      AMsg:= 'Código de cliente incorrecto.';
      PonFoco( eCliente );
      Exit;
    end;
  end;

  Result:= true;
  AMsg:= 'Parametros OK';
end;

procedure TDFLComHisSemVen.ObtenerDatosFormulario;
begin
  sEmpresa:= Trim(eEmpresa.Text);
  sProducto:= Trim(eProducto.Text);
  bTomate:= cbxTomate.Checked and ( ( sProducto = 'T' ) or ( sProducto = 'E' ) );
  sCliente:= Trim(eCliente.Text);

  sSemanaDesde1:= eAnyoSemanaDesde.Text;
  sSemanaDesde2:= IncAnyoSemana( sSemanaDesde1, -1 );
  sSemanaDesde3:= IncAnyoSemana( sSemanaDesde1, -2 );

  sSemanaHasta1:= eAnyoSemanaHasta.Text;
  sSemanaHasta2:= IncAnyoSemana( sSemanaHasta1, -1 );
  sSemanaHasta3:= IncAnyoSemana( sSemanaHasta1, -2 );

  dFechaDesde1:= LunesAnyoSemana( sSemanaDesde1 );
  dFechaDesde2:= LunesAnyoSemana( sSemanaDesde2 );
  dFechaDesde3:= LunesAnyoSemana( sSemanaDesde3 );

  dFechaHasta1:= DomingoSiguiente( LunesAnyoSemana( sSemanaHasta1 ) );
  dFechaHasta2:= DomingoSiguiente( LunesAnyoSemana( sSemanaHasta2 ) );
  dFechaHasta3:= DomingoSiguiente( LunesAnyoSemana( sSemanaHasta3 ) );

end;

procedure TDFLComHisSemVen.SBAceptarClick(Sender: TObject);
var
  sMsg: string;
  //tiempo: cardinal;
begin
  sMsg:= '';
  if ValidarDatosFormulario( sMsg )then
  begin
    ObtenerDatosFormulario;


    DQLComHisSemVen := TDQLComHisSemVen.Create(self);
    DMLComHisSemVen := TDMLComHisSemVen.Create(self);

    try
      try
       //tiempo:= GetTickCount;
        //RELLENA TABLA LISTADO
        DMLComHisSemVen.RellenarTabla( sEmpresa, sCliente, sProducto,
                                       bTomate, cbxCantidadesEn.ItemIndex=0,
                                       dFechaDesde1, dFechaHasta1, dFechaDesde2,
                                       dFechaHasta2, dFechaDesde3, dFechaHasta3 );
        //tiempo:= GetTickCount - tiempo;
        //ShowMessage(IntToStr(tiempo));

        //IMPRIMIR PRECIO
        DQLComHisSemVen.bVerPrecio:= DMLComHisSemVen.bImporte;

        //PRODUCTO
        if cbxTomate.Checked and ((eProducto.Text = 'E') or (eProducto.Text = 'T')) then
          DQLComHisSemVen.PsProducto.Caption := 'TE - TOMATE'
        else
          DQLComHisSemVen.PsProducto.Caption := eProducto.Text + ' - ' + desProducto(eEmpresa.Text, eProducto.Text);

        //MONEDA
        DQLComHisSemVen.psMoneda.Caption:= desMoneda( DMLComHisSemVen.sMoneda );

        //CLIENTE
        if sCliente <> '' then
          DQLComHisSemVen.PsCliente.Caption := eCliente.Text + ' - ' + DesCliente(eEmpresa.Text, eCliente.Text)
        else
          DQLComHisSemVen.psCliente.Caption := 'TODOS LOS CLIENTES';

        //Periodos
        DQLComHisSemVen.lblPeriodo1.Caption:= sSemanaDesde1 + ' - ' + sSemanaHasta1;
        DQLComHisSemVen.lblPeriodo2.Caption:= sSemanaDesde2 + ' - ' + sSemanaHasta2;
        DQLComHisSemVen.lblPeriodo3.Caption:= sSemanaDesde3 + ' - ' + sSemanaHasta3;
        DQLComHisSemVen.lblPeriodo1_.Caption:= DateToStr( dFechaDesde1 ) + ' - ' + DateToStr( dFechaHasta1 );
        DQLComHisSemVen.lblPeriodo2_.Caption:= DateToStr( dFechaDesde2 ) + ' - ' + DateToStr( dFechaHasta2 );
        DQLComHisSemVen.lblPeriodo3_.Caption:= DateToStr( dFechaDesde3 ) + ' - ' + DateToStr( dFechaHasta3 );

        //Kilos/cajas
        if cbxCantidadesEn.ItemIndex = 0 then
        begin
          DQLComHisSemVen.LUnidad1.Caption:= 'Kilos';
          DQLComHisSemVen.LUnidad2.Caption:= 'Kilos';
          DQLComHisSemVen.LUnidad3.Caption:= 'Kilos';
        end
        else
        begin
          DQLComHisSemVen.LUnidad1.Caption:= 'Cajas';
          DQLComHisSemVen.LUnidad2.Caption:= 'Cajas';
          DQLComHisSemVen.LUnidad3.Caption:= 'Cajas';
        end;

        PonLogoGrupoBonnysa(DQLComHisSemVen, eEmpresa.Text);
        Preview(DQLComHisSemVen);
      finally
        FreeAndNil(DMLComHisSemVen);
      end;
    except
      FreeAndNil(DQLComHisSemVen);
    end;
  end
  else
  begin
    ShowMessage( 'ERROR: ' + sMsg );
  end;
end;

procedure TDFLComHisSemVen.cbClienteSalidaChange(Sender: TObject);
begin
  PonNombre(ecliente);
end;

end.
