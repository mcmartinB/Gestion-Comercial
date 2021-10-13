unit AprovechaAjusteMerma;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, BEdit, nbLabels;

type
  RDatosAjuste = record
    kgs_in: real;
    kgs_out: real;
    kgs_ini: real;
    kgs_fin: real;
    kgs_merma: real;

    kgs_campo_ini: real;
    kgs_campo_fin: real;
    kgs_cam_i_ini: real;
    kgs_cam_i_fin: real;
    kgs_cam_e_ini: real;
    kgs_cam_e_fin: real;

    kgs_procesados: real;
    kgs_confeccionados: real;
    porcen_merma: real;
  end;

  TFAprovechaAjusteMerma = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    nbLabel1: TnbLabel;
    nbLabel3: TnbLabel;
    nbLabel4: TnbLabel;
    des_empresa: TnbStaticText;
    des_producto: TnbStaticText;
    empresa: TBEdit;
    producto: TBEdit;
    fecha_desde: TBEdit;
    nbLabel2: TnbLabel;
    centro: TBEdit;
    des_centro: TnbStaticText;
    memo: TMemo;
    btnAceptar2: TSpeedButton;
    btnCancelar2: TSpeedButton;
    btnImprimir: TSpeedButton;
    nbLabel6: TnbLabel;
    fechaHasta: TBEdit;
    nbLabel5: TnbLabel;
    eMermaMaxima: TBEdit;
    cbxTipoMerma: TComboBox;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAceptarClick(Sender: TObject);
    procedure empresaChange(Sender: TObject);
    procedure productoChange(Sender: TObject);
    procedure centroChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnAceptar2Click(Sender: TObject);
    procedure btnCancelar2Click(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure fecha_desdeChange(Sender: TObject);
  private
    { Private declarations }
    p_merma, p_sobrePesoC1, p_sobrePesoC2, p_sobrePesoC3: Real;
    kin_sobrepeso1, kin_sobrepeso2, kin_sobrepeso3, kin_merma_general: real;
    sLunes, sDomingo: string;
    dDesde: TDateTime;

    function  RangoValidos: Boolean;
    procedure ComprobarFechaLiquidacion;
    procedure EnableRightButtons(const AEnable: Boolean; const AMerma: real );
    procedure MemoInforme(const Adatos: RDatosAjuste;
      Amerma, AsobrePesoC1, AsobrePesoC2, AsobrePesoC3,
      Ap_merma, Ap_sobrePesoC1, Ap_sobrePesoC2, Ap_sobrePesoC3: real;
      const ATipo: integer);
    function PuedoAplicarAjusteMerma(const AEmpresa, ACentro, AProducto: string;
      const ALunes: TDateTime): Boolean;
    function CalculaDatosAjusteMerma(const AEmpresa, ACentro, AProducto,
      AFechaIni, AFechaFin: string; const ATipo: integer ): RDatosAjuste;
  public
    { Public declarations }
  end;


implementation

uses UDMAuxDB, Principal, CGestionPrincipal, CVariables, UDMBaseDatos,
  bSQLUtils, bMath, DB, DBTables, bNumericUtils, bTextUtils, DError,
  UEntradasUC, USalidasUC, UInventariosUC, USobrepesosUC, UEscandallosUC,
  UDMConfig;

{$R *.dfm}

procedure TFAprovechaAjusteMerma.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFAprovechaAjusteMerma.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;
end;

procedure TFAprovechaAjusteMerma.FormCreate(Sender: TObject);
var
  fecha: TDate;
begin
  Top := 1;
  Height:= 520;
  memo.Height:= 289;

  FormType := tfOther;
  BHFormulario;

  //btnImprimir.Top := btnCancelar.Top;

  empresa.Text := gsDefEmpresa;
  centro.Text := gsDefCentro;
  producto.Text := gsDefProducto;
  eMermaMaxima.Text:= '5';

  fecha := date;
  while DayOfWeek(fecha) <> 1 do fecha := fecha - 1;
  fecha_desde.Text := DateToStr(fecha - 6);
end;

procedure TFAprovechaAjusteMerma.FormKeyDown(Sender: TObject; var Key: Word;
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
    vk_escape:
      begin
        if btnCancelar.Enabled then
          btnCancelar.Click
        else
          btnCancelar2.Click;
      end;
    vk_f1:
      begin
        if btnAceptar.Enabled then
          btnAceptar.Click
        else
          btnAceptar2.Click;
      end;
  end;
end;

function TFAprovechaAjusteMerma.CalculaDatosAjusteMerma(const AEmpresa, ACentro, AProducto,
  AFechaIni, AFechaFin: string; const ATipo: integer ): RDatosAjuste;
var
  Aux: RDatosAjuste;
  AuxFecha: string;
begin
  AuxFecha := DateToStr(StrToDate(AFechaIni) - 1);

  Aux.kgs_in := KgsEntrada(AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin);
  Aux.kgs_out := KgsSalida(AEmpresa, ACentro, AProducto, AFechaIni, AFechaFin);

  Aux.kgs_ini := KgsInventario(AEmpresa, ACentro, AProducto, AuxFecha);
  Aux.kgs_fin := KgsInventario(AEmpresa, ACentro, AProducto, AFechaFin);
  Aux.kgs_fin := Aux.kgs_fin + KgsInventarioAjuste(AEmpresa, ACentro, AProducto, AFechaFin);

  Aux.kgs_campo_ini := KgsInventarioCampo(AEmpresa, ACentro, AProducto, AuxFecha);
  Aux.kgs_campo_fin := KgsInventarioCampo(AEmpresa, ACentro, AProducto, AFechaFin);
  Aux.kgs_campo_fin := Aux.kgs_campo_fin + KgsInventarioCampoAjuste(AEmpresa, ACentro, AProducto, AFechaFin);

  Aux.kgs_cam_i_ini := KgsInventarioIntermedia(AEmpresa, ACentro, AProducto, AuxFecha);
  Aux.kgs_cam_i_fin := KgsInventarioIntermedia(AEmpresa, ACentro, AProducto, AFechaFin);
  Aux.kgs_cam_i_fin := Aux.kgs_cam_i_fin + KgsInventarioIntermediaAjuste(AEmpresa, ACentro, AProducto, AFechaFin);

  Aux.kgs_cam_e_ini := KgsInventarioExpedicion(AEmpresa, ACentro, AProducto, AuxFecha);
  Aux.kgs_cam_e_fin := KgsInventarioExpedicion(AEmpresa, ACentro, AProducto, AFechaFin);

  Aux.kgs_procesados := Aux.kgs_in + Aux.kgs_campo_ini - Aux.kgs_campo_fin;
  Aux.kgs_confeccionados := ( Aux.kgs_in + ( Aux.kgs_campo_ini + Aux.kgs_cam_i_ini ) ) -
                            ( Aux.kgs_campo_fin + Aux.kgs_cam_i_fin );

  if ATipo = 0 then
  begin
    if Aux.kgs_procesados = 0 then
    begin
      Aux.kgs_merma := 0;
      Aux.porcen_merma := 0;
    end
    else
    begin
      Aux.kgs_merma := (Aux.kgs_in + Aux.kgs_ini) - (Aux.kgs_out + Aux.kgs_fin);
      Aux.porcen_merma := bRoundTo((Aux.kgs_merma * 100) / Aux.kgs_procesados, -5);
    end;
  end
  else
  begin
    if Aux.kgs_confeccionados = 0 then
    begin
      Aux.kgs_merma := 0;
      Aux.porcen_merma := 0;
    end
    else
    begin
      Aux.kgs_merma := (Aux.kgs_in + Aux.kgs_ini) - (Aux.kgs_out + Aux.kgs_fin);
      Aux.porcen_merma := bRoundTo((Aux.kgs_merma * 100) / Aux.kgs_confeccionados, -5);
    end;
  end;
(*
  Aux.kgs_merma := (Aux.kgs_in + Aux.kgs_ini) - (Aux.kgs_out + Aux.kgs_fin);
  if Aux.kgs_procesados <> 0 then
  begin
    Aux.porcen_merma := bRoundTo((Aux.kgs_merma * 100) / Aux.kgs_procesados, -5);
  end
  else
  begin
    if Aux.kgs_confeccionados <> 0 then
      Aux.porcen_merma := bRoundTo((Aux.kgs_merma * 100) / Aux.kgs_confeccionados, -5)
    else
      Aux.porcen_merma := bRoundTo((Aux.kgs_merma * 100) / Aux.kgs_in, -5);
  end;
*)
  result := Aux;
end;

procedure TFAprovechaAjusteMerma.MemoInforme(const Adatos: RDatosAjuste;
  Amerma, AsobrePesoC1, AsobrePesoC2, AsobrePesoC3,
  Ap_merma, Ap_sobrePesoC1, Ap_sobrePesoC2, Ap_sobrePesoC3: real;
  const ATipo: integer );
begin
  memo.clear;
  memo.Lines.Add('  ');
  memo.Lines.Add('  KGS INICIO        = ' +
    RellenaIzq(FormatFloat('#,##0.00', ADatos.kgs_ini), 14));
  memo.Lines.Add('  KGS FIN           = ' +
    RellenaIzq(FormatFloat('#,##0.00', ADatos.kgs_fin), 14));
  memo.Lines.Add('  KGS INICIO CAMPO  = ' +
    RellenaIzq(FormatFloat('#,##0.00', ADatos.kgs_campo_ini), 14));
  memo.Lines.Add('  KGS FIN CAMPO     = ' +
    RellenaIzq(FormatFloat('#,##0.00', ADatos.kgs_campo_fin), 14));
  memo.Lines.Add('');
  memo.Lines.Add('  KGS ENTRADA       = ' +
    RellenaIzq(FormatFloat('#,##0.00', ADatos.kgs_in), 14));
  memo.Lines.Add('  KGS SALIDA        = ' +
    RellenaIzq(FormatFloat('#,##0.00', ADatos.kgs_out), 14));
  if ATipo = 0 then
  begin
    memo.Lines.Add('  KGS PROCESADOS    = ' +
      RellenaIzq(FormatFloat('#,##0.00', ADatos.kgs_procesados), 14));
    memo.Lines.Add('');
  end
  else
  begin
    memo.Lines.Add('  KGS CONFECCIONADOS= ' +
      RellenaIzq(FormatFloat('#,##0.00', ADatos.kgs_confeccionados), 14));
    memo.Lines.Add('');
  end;
  memo.Lines.Add('  SOBREPESO  CAT 1  = ' +
    RellenaIzq(FormatFloat('#,##0.00', AsobrePesoC1), 14) +
    RellenaIzq(FormatFloat('##0.000000', Ap_sobrePesoC1), 14) + '%');
  memo.Lines.Add('  SOBREPESO  CAT 2  = ' +
    RellenaIzq(FormatFloat('#,##0.00', AsobrePesoC2), 14) +
    RellenaIzq(FormatFloat('##0.000000', Ap_sobrePesoC2), 14) + '%');
  memo.Lines.Add('  SOBREPESO  CAT 3  = ' +
    RellenaIzq(FormatFloat('#,##0.00', AsobrePesoC3), 14) +
    RellenaIzq(FormatFloat('##0.000000', Ap_sobrePesoC3), 14) + '%');
  memo.Lines.Add('  MERMA GENERAL     = ' +
    RellenaIzq(FormatFloat('#,##0.00', Amerma), 14) +
    RellenaIzq(FormatFloat('##0.000000', Ap_merma), 14) + '%');
  memo.Lines.Add('  -----------------   ----------------------------');

  memo.Lines.Add('  KGS MERMA TOTAL   = ' +
    RellenaIzq(FormatFloat('#,##0.00', ADatos.kgs_merma), 14) +
    RellenaIzq(FormatFloat('##0.000000', ADatos.porcen_merma), 14));
  memo.Lines.Add('');
  memo.SelStart := 0;
  memo.SelLength := 0;
end;

function TFAprovechaAjusteMerma.PuedoAplicarAjusteMerma(const AEmpresa, ACentro, AProducto: string;
  const ALunes: TDateTime): Boolean;
var
  iFaltan: Integer;
begin
  Result := false;
  //los meses AGOSTO y SEPTIEMBRE del 2003 no se tocan
  if ALunes < StrToDate('22/9/2003') then
  begin
    ShowMessage(' Sólo se admiten periodos de tiempo superiores al "22/9/2003" ');
    Exit;
  end;

  if EstaEscandalloGrabado(AEmpresa, ACentro, AProducto, ALunes, iFaltan) then
  begin
    result := true;
    if EstaMermaGrabada(AEmpresa, ACentro, AProducto, ALunes) then
    begin
      if MessageBox(Application.Handle, 'El ajuste ya fue calculado para esta semana.' +
        #13 + #10 + '¿ Desea volver a recalcularlo ?',
        'Ajuste de aprovechamientos,',
        MB_OKCANCEL + MB_ICONINFORMATION + MB_DEFBUTTON2) <> ID_OK then
      begin
        result := false;
      end;
    end;
  end
  else
  begin
    MessageBox(Application.Handle,
      ' Falta grabar aprovechamientos para alguna entrada de fruta.',
      'APROVECHAMIENTOS',
      MB_OK + MB_ICONEXCLAMATION);
  end;
end;

procedure TFAprovechaAjusteMerma.ComprobarFechaLiquidacion;
var
  dFecha, dLiquida: TDateTime;
begin
  dFecha:= StrToDate( fecha_desde.Text );
  dLiquida:= GetFechaUltimaLiquidacion( empresa.Text, centro.Text, producto.Text );
  if dFecha < dLiquida then
  begin
    ShowMessage('No se puede modificar la merma con fecha anterior a la ultima liquidación definitiva (' +
                DateToStr( dLiquida ) +  ').');
    Abort;
  end;
end;

procedure TFAprovechaAjusteMerma.btnAceptarClick(Sender: TObject);
var
  Datos: RDatosAjuste;
  merma, rAux, rProcesados: Real;
  sobrePesoC1, sobrePesoC2, sobrePesoC3: Real;
  bFlag: Boolean;
begin
  bFlag:= True;
  if RangoValidos then
  begin
    ComprobarFechaLiquidacion;

    Application.ProcessMessages;
    if PuedoAplicarAjusteMerma(empresa.Text, centro.Text, producto.Text, dDesde) then
    begin
      BEMensajes('Calculando sobrepeso de los envases ...');
      Application.ProcessMessages;
      sobrePesoC1:= 0;
      sobrePesoC2:= 0;
      sobrePesoC3:= 0;
      (*PARCHE*)
      if ( producto.Text = 'E' ) and ( sLunes = '31/10/2005' ) then
      begin
        sobrePesoC1:=6780;
        sobrePesoC2:=408.25;
        sobrePesoC3:=0;
      end
      else
      begin
        KgsSobrepeso(empresa.Text, centro.Text, producto.Text, sLunes, sDomingo,
           sobrePesoC1, sobrePesoC2, sobrePesoC3);
      end;

      BEMensajes('Calculando merma general ...');
      Application.ProcessMessages;
      Datos := CalculaDatosAjusteMerma(empresa.Text, centro.Text, producto.Text, sLunes, sDomingo, cbxTipoMerma.ItemIndex );

      //if ( producto.Text = 'E' ) then
      (*
      if ( centro.Text = '6' ) then
      begin
        merma :=  sobrePesoC1 + sobrePesoC2 + sobrePesoC3;
        if merma > datos.kgs_merma then
        begin
          datos.kgs_merma:= merma;
        end;
      end;
      *)
      if datos.kgs_merma < 0 then
      begin
        ShowMessage('La merma general no puede ser menor que 0 (Salidas > Entradas).');
        bFlag:= False;
      end;

      (**)
      if cbxTipoMerma.ItemIndex = 0 then
        rProcesados:= datos.kgs_procesados
      else
        rProcesados:= datos.kgs_confeccionados;
      if datos.kgs_procesados = 0 then
      begin
        datos.kgs_merma:= 0;
      end
      else
      if datos.kgs_procesados < 100 then
      begin
        rAux:= (datos.kgs_procesados * 0.05);
        if rAux < datos.kgs_merma then
        begin
          datos.kgs_merma:= rAux;
        end;
      end;
      (**)

     (*
      if datos.kgs_procesados <> 0 then
      begin
        rProcesados:= datos.kgs_procesados;
      end
      else
      begin
        if datos.kgs_confeccionados <> 0 then
          rProcesados:= datos.kgs_confeccionados
        else
          rProcesados:= datos.kgs_in;
      end;
     *)

      if datos.kgs_merma > 0 then
      begin
        datos.porcen_merma := bRoundTo((datos.kgs_merma * 100) / rProcesados, -5)
      end
      else
      begin
        datos.porcen_merma:= 0;
      end;

      merma:= datos.kgs_merma;

      if merma > 0 then
      begin
        AjustarCantidadesMerma(merma, sobrePesoC1, sobrePesoC2, sobrePesoC3);
        p_sobrePesoC1 := bRoundTo(sobrePesoC1 * 100 / rProcesados, -5);
        p_sobrePesoC2 := bRoundTo(sobrePesoC2 * 100 / rProcesados, -5);
        p_sobrePesoC3 := bRoundTo(sobrePesoC3 * 100 /rProcesados, -5);
        p_merma := bRoundTo(merma * 100 / rProcesados, -5);
      end
      else
      begin
        sobrePesoC1 := 0;
        sobrePesoC2 := 0;
        sobrePesoC2 := 0;
        p_sobrePesoC1 := 0;
        p_sobrePesoC2 := 0;
        p_sobrePesoC2 := 0;
        p_merma := 0;
      end;

      MemoInforme(datos, merma, sobrePesoC1, sobrePesoC2, sobrePesoC3,
        p_merma, p_sobrePesoC1, p_sobrePesoC2, p_sobrePesoC3, cbxTipoMerma.ItemIndex);

      kin_sobrepeso1:= sobrepesoc1;
      kin_sobrepeso2:= sobrepesoc2;
      kin_sobrepeso3:= sobrepesoc3;
      kin_merma_general:= merma;

      if bFlag then
        EnableRightButtons(false, p_merma);
    end;
  end;
  BEMensajes('');
end;

procedure TFAprovechaAjusteMerma.empresaChange(Sender: TObject);
begin
  des_empresa.Caption := desEmpresa(empresa.Text);
end;

procedure TFAprovechaAjusteMerma.productoChange(Sender: TObject);
begin
  des_producto.Caption := desProducto(empresa.Text, producto.Text);
end;

procedure TFAprovechaAjusteMerma.centroChange(Sender: TObject);
begin
  des_centro.Caption := desCentro(empresa.Text, centro.Text);
end;

function TFAprovechaAjusteMerma.RangoValidos: Boolean;
begin
  result := false;
  //Comprobar que las fechas sean correctas
  try
    dDesde := StrToDate(fecha_desde.Text);
  except
    fecha_desde.SetFocus;
    ShowMessage('Fecha incorrecta.');
    Exit;
  end;
  if DayOfWeek(dDesde) <> 2 then
  begin
    fecha_desde.SetFocus;
    ShowMessage('El dia de inicio debe ser Lunes.');
    Exit;
  end;
  sLunes := fecha_desde.Text;
  sDomingo := DateToStr(dDesde + 6);
  result := true;
end;

procedure TFAprovechaAjusteMerma.FormActivate(Sender: TObject);
begin
  Top := 10;
end;

procedure TFAprovechaAjusteMerma.EnableRightButtons(const AEnable: Boolean; const AMerma: real );
begin
  btnAceptar.Enabled := AEnable;
  btnCancelar.Enabled := AEnable;

  if not AEnable then
  begin
    if AMerma < 0 then
    begin
      btnAceptar2.Enabled:= False;
      ShowMessage('La merma calculada no puede ser menor que cero, ' +
                  'compruebe que los datos de entrada, salida e inventarios de fruta ' +
                  'sean correctos.');
    end
    else
    begin
      btnAceptar2.Enabled:= AMerma <= StrToFloatDef( eMermaMaxima.Text, 0 );
      if not btnAceptar2.Enabled then
      begin
        ShowMessage('La merma calculada supera el máximo permitido, por favor ' +
                  'compruebe que los datos de entrada, salida e inventarios de fruta ' +
                  'sean correctos. Si todo es correcto puede modificar el valor de la merma maxima permitida.');
      end;
    end;
    btnAceptar2.Visible := True;

    btnCancelar2.Visible := not AEnable;
    btnCancelar2.Enabled := not AEnable;

    empresa.Enabled := AEnable;
    centro.Enabled := AEnable;
    producto.Enabled := AEnable;
    fecha_desde.Enabled := AEnable;
    eMermaMaxima.Enabled := AEnable;
    if AEnable then
      empresa.SetFocus;
  end
  else
  begin
    btnAceptar2.Visible := not AEnable;
    btnAceptar2.Enabled := not AEnable;
    btnCancelar2.Visible := not AEnable;
    btnCancelar2.Enabled := not AEnable;

    empresa.Enabled := AEnable;
    centro.Enabled := AEnable;
    producto.Enabled := AEnable;
    fecha_desde.Enabled := AEnable;
    eMermaMaxima.Enabled := AEnable;
    if AEnable then
      empresa.SetFocus;
  end;
end;

procedure TFAprovechaAjusteMerma.btnAceptar2Click(Sender: TObject);
begin
  if gbAjustarSeleccionado then
  begin
    AjustarMerma(empresa.Text, centro.Text, producto.Text, dDesde,
      p_merma, p_sobrepesoc1, p_sobrepesoc2, p_sobrepesoc3);
  end
  else
  begin
    AjustarMermaEx(empresa.Text, centro.Text, producto.Text, dDesde,
      kin_merma_general, kin_sobrepeso1, kin_sobrepeso2, kin_sobrepeso3);
  end;
  EnableRightButtons(true, 0);
end;

procedure TFAprovechaAjusteMerma.btnCancelar2Click(Sender: TObject);
begin
  EnableRightButtons(true, 0);
end;

procedure TFAprovechaAjusteMerma.btnImprimirClick(Sender: TObject);
begin
{
  if memo.Lines.Count = 0 then Exit;
  IBMProPrinter.BeginDoc;
  IBMProPrinter.WriteLn(' ');
  IBMProPrinter.WriteLn(' ************************************************************');
  IBMProPrinter.WriteLn(' *      AJUSTE APROVECHAMIENTOS POR MERMA DE PRODUCTO       *');
  IBMProPrinter.WriteLn(' ************************************************************');
  IBMProPrinter.WriteLn(RellenaDer(' * ' + empresa.Text + ' ' + des_empresa.Caption, 30) +
    ' ' + RellenaIzq(sLunes + ' - ' + sDomingo + ' *', 30));
  IBMProPrinter.WriteLn(RellenaDer(' * ' + centro.Text + ' ' + des_centro.Caption, 30) +
    ' ' + RellenaIzq(producto.Text + ' ' + des_producto.Caption + ' *', 30));
  IBMProPrinter.WriteLn(' ************************************************************');
  IBMProPrinter.WriteLn(' ');

  for i := 1 to memo.Lines.Count - 1 do
  begin
    IBMProPrinter.WriteLn(Memo.Lines[i]);
  end;
  IBMProPrinter.EndDoc;
}
end;

procedure TFAprovechaAjusteMerma.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFAprovechaAjusteMerma.fecha_desdeChange(Sender: TObject);
var
  dFecha: TDatetime;
begin
  if TryStrToDate( fecha_desde.Text, dFecha ) then
  begin
    fechaHasta.Text:= DateToStr( dFecha + 6 )
  end
  else
  begin
    fechaHasta.Text:= '';
  end;
end;

end.


