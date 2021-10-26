unit UFDPutEscandalloSemanal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, BEdit, Buttons, BSpeedButton, BGridButton, BDEdit,
  ComCtrls, BCalendario, Grids, DBGrids, BGrid, ActnList, ExtCtrls;

type
  TFDPutEscandalloSemanal = class(TForm)
    Label2: TLabel;
    LEmpresa_p: TLabel;
    Label11: TLabel;
    lblDestrio: TLabel;
    lblTotal: TLabel;
    lblTotal1: TLabel;
    btnAceptar: TButton;
    btnCancelar: TButton;
    edtPrimera: TBEdit;
    edtSegunda: TBEdit;
    edtTercera: TBEdit;
    edtDestrio: TBEdit;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    Label1: TLabel;
    edtEmpresa: TBEdit;
    btnEmpresa: TBGridButton;
    LProducto_p: TLabel;
    edtProducto: TBEdit;
    btnProducto: TBGridButton;
    STEmpresa_p: TStaticText;
    STProducto_p: TStaticText;
    LCosechero_p: TLabel;
    edtCosechero: TBEdit;
    btnCosechero: TBGridButton;
    STCosechero_p: TStaticText;
    LPlantacion_p: TLabel;
    edtPlantacion: TBEdit;
    LAno_semana_p: TLabel;
    edtAnoSemana: TBEdit;
    btnPlantacion: TBGridButton;
    txtPlantacion: TStaticText;
    actlstBotones: TActionList;
    actARejillaFlotante: TAction;
    lbl1: TLabel;
    edtAnyoSemanaEsnandallo: TBEdit;
    bvlPlantacion: TBevel;
    chkSobreescribir: TCheckBox;
    bvl1: TBevel;
    lblFechas: TLabel;
    rbPorDia: TRadioButton;
    rbPorSemana: TRadioButton;
    edtFecha: TBEdit;
    procedure edtPrimeraChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actARejillaFlotanteExecute(Sender: TObject);
    procedure edtEmpresaChange(Sender: TObject);
    procedure edtProductoChange(Sender: TObject);
    procedure edtCosecheroChange(Sender: TObject);
    procedure edtPlantacionChange(Sender: TObject);
    procedure edtAnoSemanaChange(Sender: TObject);
    procedure edtAnyoSemanaEsnandalloChange(Sender: TObject);
    procedure rbPorDiaClick(Sender: TObject);
    procedure rbPorSemanaClick(Sender: TObject);
  private
    { Private declarations }
    sEmpresa, sProducto, sCosechero, sPlantacion, sAnyoSemana, sAnyoSemanaEscandallo, sFechaEscandallo: string;
    rPrimera, rSegunda, rTercera, rDestrio, rFalta: Real;
    bSoloNuevas: Boolean;
    dFecha: TDateTime;

    function ValidarParametros: Boolean;
    function BuscaPlanatacion: Boolean;
  public
    { Public declarations }
  end;

  function PutEscandalloSemanalExec( const AOwner: TComponent; const AEmpresa, AProducto, ACosechero, APlantacion, AFecha, AAnyoSemana, AAnyoSemanaEscandallo: string ): Boolean;


implementation

{$R *.dfm}

uses
  bMath, CVariables, CAuxiliarDB, UDMAuxDB, UMDPutEscandalloSemanal,
  UDMBaseDatos, AdvertenciaFD, bTimeUtils;

var
  FDPutEscandalloSemanal: TFDPutEscandalloSemanal;

function PutEscandalloSemanalExec( const AOwner: TComponent; const AEmpresa, AProducto, ACosechero, APlantacion, AFecha, AAnyoSemana, AAnyoSemanaEscandallo: string  ): Boolean;
begin
  FDPutEscandalloSemanal:= TFDPutEscandalloSemanal.Create( AOwner );
  FDPutEscandalloSemanal.edtEmpresa.Text:= AEmpresa;
  FDPutEscandalloSemanal.edtProducto.Text:= AProducto;
  FDPutEscandalloSemanal.edtCosechero.Text:= ACosechero;
  FDPutEscandalloSemanal.edtPlantacion.Text:= APlantacion;
  FDPutEscandalloSemanal.edtFecha.Text:= AFecha;
  FDPutEscandalloSemanal.edtAnoSemana.Text:= AAnyoSemana;
  FDPutEscandalloSemanal.edtAnyoSemanaEsnandallo.Text:= AAnyoSemanaEscandallo;
  try
    Result:= FDPutEscandalloSemanal.ShowModal = mrOk;
  finally
    FreeAndNil( FDPutEscandalloSemanal );
  end;
end;

procedure TFDPutEscandalloSemanal.edtPrimeraChange(Sender: TObject);
begin
  rPrimera:= StrToFloatDef(edtPrimera.Text,0);
  rSegunda:= StrToFloatDef(edtSegunda.Text,0);
  rTercera:= StrToFloatDef(edtTercera.Text,0);
  rDestrio:= StrToFloatDef(edtDestrio.Text,0);
  rFalta:=  broundTo( 100 - ( rPrimera + rSegunda +  rTercera +  rDestrio ), 2);
  lblTotal1.Caption:= FormatFloat( '##0.00', rFalta )
end;

procedure TFDPutEscandalloSemanal.FormCreate(Sender: TObject);
begin
  rPrimera:= 0;
  rSegunda:= 0;
  rTercera:= 0;
  rDestrio:= 0;
  rFalta:= 100;

  edtEmpresa.Tag := kEmpresa;
  edtProducto.Tag := kProducto;
  edtCosechero.Tag := kCosechero;
  edtPlantacion.Tag := kPlantacion;

  lbl1.Caption := 'Fecha';

  RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
end;

function TFDPutEscandalloSemanal.ValidarParametros: Boolean;
var
  dAux: TDateTime;
  sAux: string;
begin
  result:= False;
  if ( STEmpresa_p.Caption <> '' ) and
     ( STProducto_p.Caption <> '' ) and
     ( STCosechero_p.Caption <> '' ) and
     ( txtPlantacion.Caption <> '' )  then
  begin
    sEmpresa:= edtEmpresa.Text;
    sProducto:= edtProducto.Text;
    sCosechero:= edtCosechero.Text;
    sPlantacion:= edtPlantacion.Text;
    sAnyoSemana:= edtAnoSemana.Text;
    bSoloNuevas:= not chkSobreescribir.Checked;
    if rbPorSemana.Checked then
    begin
      if Length( edtAnoSemana.Text) = 6 then
      begin
        sAnyoSemanaEscandallo:= edtAnyoSemanaEsnandallo.Text;
        dAux:= LunesAnyoSemana( sAnyoSemanaEscandallo );

        if rFalta <> 0 then
        begin
          ShowMessage('El sumatorio de los porcentajes debe de ser 100');
        end
        else
        begin
          if dAux < ( Now - 30 ) then
          begin
            sAux:= '["' + sAnyoSemanaEscandallo + '" -> ' + FormatDateTime('dd/mm/yyyy', dAux ) + ' - ' + FormatDateTime('dd/mm/yyyy', dAux + 6 ) + ']';
            Result:= AdvertenciaFD.VerAdvertencia(Self, 'La fecha inicial de la semana del escandallo tiene mas de 30 dias de antiguedad ' + sAux + '.' )  = mrIgnore;
          end
          else
          begin
            if dAux > Now  then
            begin
              sAux:= '["' + sAnyoSemanaEscandallo + '" -> ' + FormatDateTime('dd/mm/yyyy', dAux ) + ' - ' + FormatDateTime('dd/mm/yyyy', dAux + 6 ) + ']';
              Result:= AdvertenciaFD.VerAdvertencia(Self, 'La fecha inicial de la semana del escandallo es superior a la fecha actual ' + sAux + '.' )  = mrIgnore;
            end
            else
            begin
              Result:= True;
            end;
          end;
        end;
      end
      else
      begin
        ShowMessage('El año/semana del escandallo debe de ser de 6 digitos.');
      end;
    end
    else if rbPorDia.Checked then
    begin
      if not TryStrToDate( Trim( edtFecha.Text ), dFecha ) then
      begin
        edtFecha.SetFocus;
        ShowMessage('Falta Fecha de Escandallo por Dia.');
      end
      else if rFalta <> 0 then
      begin
        ShowMessage('El sumatorio de los porcentajes debe de ser 100');
      end
      else
        Result := True;
    end
    else
    begin
      ShowMessage('Falta por rellenar algun dato o es incorrecto.');
    end;
  end;
end;


procedure TFDPutEscandalloSemanal.btnAceptarClick(Sender: TObject);
var
  iModificados: Integer;
  bPorSemana: boolean;
begin
  if ValidarParametros then
  begin
    bPorSemana := rbPorSemana.Checked = true;
    iModificados:=  UMDPutEscandalloSemanal.AplicarEscandallos( sEmpresa, sProducto, sCosechero, sPlantacion, sAnyoSemana, sAnyoSemanaEscandallo, dFecha, rPrimera, rSegunda, rTercera, rDestrio, bSoloNuevas, bPorSemana );
    ShowMessage('Modificados ' + IntToStr( iModificados ) + ' escandallos.');
    //ModalResult:= mrOk;
  end;
end;

procedure TFDPutEscandalloSemanal.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TFDPutEscandalloSemanal.FormKeyDown(Sender: TObject; var Key: Word;
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
  end;
end;

procedure TFDPutEscandalloSemanal.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_F1:
      begin
        btnAceptar.Click;
      end;
  end;
end;

procedure TFDPutEscandalloSemanal.rbPorDiaClick(Sender: TObject);
begin
  lbl1.Caption := ' Fecha';
  edtFecha.Visible := true;
  edtAnyoSemanaEsnandallo.Visible := false;
  edtAnyoSemanaEsnandalloChange (Self);
end;

procedure TFDPutEscandalloSemanal.rbPorSemanaClick(Sender: TObject);
begin
  lbl1.Caption := ' Año - Semana';
  edtFecha.Visible := false;
  edtAnyoSemanaEsnandallo.Visible := true;
  edtAnyoSemanaEsnandalloChange (Self);
end;

procedure TFDPutEscandalloSemanal.actARejillaFlotanteExecute(
  Sender: TObject);
begin
  case ActiveControl.Tag of
    kEmpresa: DespliegaRejilla(btnEmpresa);
    kProducto: DespliegaRejilla(btnProducto, [edtEmpresa.Text]);
    kCosechero: DespliegaRejilla(btnCosechero, [edtEmpresa.Text]);
    kPlantacion: DespliegaRejilla(btnPlantacion, [edtEmpresa.Text, edtProducto.Text, edtCosechero.Text]);
  end;
end;

procedure TFDPutEscandalloSemanal.edtEmpresaChange(Sender: TObject);
begin
  //
  STEmpresa_p.Caption:= desEmpresa( edtEmpresa.Text );
  edtProductoChange( edtProducto );

end;

procedure TFDPutEscandalloSemanal.edtProductoChange(Sender: TObject);
begin
  //
  STProducto_p.Caption:= desProducto( edtEmpresa.Text, edtProducto.Text );
  edtCosecheroChange( edtCosechero );
end;

procedure TFDPutEscandalloSemanal.edtCosecheroChange(Sender: TObject);
begin
  //
  STCosechero_p.Caption:= desCosechero( edtEmpresa.Text, edtCosechero.Text );
  edtPlantacionChange( edtPlantacion );
end;

function TFDPutEscandalloSemanal.BuscaPlanatacion: Boolean;
begin
  Result:= ( edtEmpresa.Text <> '' ) and ( edtProducto.Text <> '' ) and (  edtCosechero.Text <> '' ) and (  edtPlantacion.Text <> '' );
end;

procedure TFDPutEscandalloSemanal.edtPlantacionChange(Sender: TObject);
begin
  if BuscaPlanatacion then
  begin
    edtAnoSemana.Text:= CalcularAnoSemana( edtEmpresa.Text, edtProducto.Text, edtCosechero.Text, edtPlantacion.Text, FormatDateTime( 'dd/mm/yyyy', Now ) );
  end;
  edtAnoSemanaChange( edtAnoSemana );
end;

procedure TFDPutEscandalloSemanal.edtAnoSemanaChange(Sender: TObject);
begin
  //
  if ( Length( edtAnoSemana.Text ) = 6 ) and BuscaPlanatacion then
  begin
    txtPlantacion.Caption:= desPlantacion( edtEmpresa.Text, edtProducto.Text, edtCosechero.Text, edtPlantacion.Text, edtAnoSemana.Text );
  end
  else
  begin
    txtPlantacion.Caption:= '';
  end;
end;

procedure TFDPutEscandalloSemanal.edtAnyoSemanaEsnandalloChange(
  Sender: TObject);
var
  dAux: TDate;
begin

  if rbPorDia.Checked then
  begin
    if Length( edtFecha.Text ) = 10 then
    begin
      dAux := StrToDate(edtFecha.Text);
      lblFechas.Caption:= FormatDateTime('dd/mm/yyyy', dAux ) + ' -> ' + FormatDateTime('dd/mm/yyyy', dAux);
    end;
  end
  else if (Length( edtAnyoSemanaEsnandallo.Text ) = 6) and rbPorSemana.Checked then
  begin
    dAux:= LunesAnyoSemana( edtAnyoSemanaEsnandallo.Text );
    lblFechas.Caption:= FormatDateTime('dd/mm/yyyy', dAux ) + ' -> ' + FormatDateTime('dd/mm/yyyy', dAux + 6 );
  end
  else
  begin
    lblFechas.Caption:= '';
  end;
end;

end.
