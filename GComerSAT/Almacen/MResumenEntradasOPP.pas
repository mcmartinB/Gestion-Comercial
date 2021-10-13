unit MResumenEntradasOPP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, ActnList, ComCtrls, Db,
  CGestionPrincipal, BEdit, BCalendarButton, BSpeedButton, BGridButton,
  BCalendario, BGrid,DError, QuickRpt, Grids, DBGrids;

type
  TFMResumenEntradasOPP = class(TForm)
    ListaAcciones: TActionList;
    BAceptar: TAction;
    RejillaFlotante: TBGrid;
    CalendarioFlotante: TBCalendario;
    ADesplegarRejilla: TAction;
    ACancelar: TAction;
    GBEmpresa: TGroupBox;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    BGBEmpresa: TBGridButton;
    BGBCentro: TBGridButton;
    BGBProducto: TBGridButton;
    Desde: TLabel;
    BCBDesde: TBCalendarButton;
    Label14: TLabel;
    BCBHasta: TBCalendarButton;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    EProducto: TBEdit;
    ECentro: TBEdit;
    EEmpresa: TBEdit;
    STEmpresa: TStaticText;
    STCentro: TStaticText;
    STProducto: TStaticText;
    MEDesde: TBEdit;
    MEHasta: TBEdit;
    EDesde: TBEdit;
    EHasta: TBEdit;
    EDesde2: TBEdit;
    EHasta2: TBEdit;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure BBAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADesplegarRejillaExecute(Sender: TObject);
    procedure PonNombre(Sender:TObject);
    procedure MEHastaExit(Sender: TObject);
    procedure EHastaExit(Sender: TObject);
    procedure EHasta2Exit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ACancelarExecute(Sender: TObject);

  private

  public
    { Public declarations }
    empresa,centro,producto:string;
  end;

var
  Autorizado: boolean;

implementation

uses Principal, CVariables, CAuxiliarDB, UDMAuxDB, CReportes, bSQLUtils,
     LResumenEntradasOPP, DPreview, UDMBaseDatos;

{$R *.DFM}

procedure TFMResumenEntradasOPP.BBAceptarClick(Sender: TObject);
begin
     if not CerrarForm(true) then Exit;
        //Comprobamos que los campos esten todos con datos
        if EEmpresa.Text = '' then
          begin
           ShowError('Es necesario que rellene todos los campos de edición');
           EEmpresa.SetFocus;
           Exit;
          end;

        if EProducto.Text = '' then
          begin
           ShowError('Es necesario que rellene todos los campos de edición');
           EProducto.SetFocus;
           Exit;
          end;

        if ECentro.Text = '' then
          begin
           ShowError('Es necesario que rellene todos los campos de edición');
           ECentro.SetFocus;
           Exit;
          end;

        if EDesde.Text = '' then
          begin
           ShowError('Es necesario que rellene todos los campos de edición');
           EDesde.SetFocus;
           Exit;
          end;

        if EHasta.Text = '' then
          begin
           ShowError('Es necesario que rellene todos los campos de edición');
           EHasta.SetFocus;
           Exit;
          end;

        if EDesde2.Text = '' then
          begin
           ShowError('Es necesario que rellene todos los campos de edición');
           EDesde2.SetFocus;
           Exit;
          end;

        if EHasta2.Text = '' then
          begin
           ShowError('Es necesario que rellene todos los campos de edición');
           EHasta2.SetFocus;
           Exit;
          end;

//.......................NOMBRE CENTRO Y PRODUCTO.................
     empresa:=STEmpresa.Caption;
     centro:=STCentro.Caption;
     producto:=STProducto.Caption;

    QLResumenEntradasOPP:= TQLResumenEntradasOPP.Create(Application);
    try
      PonLogoGrupoBonnysa(QLResumenEntradasOPP,EEmpresa.Text);
      QLResumenEntradasOPP.QListado.SQL.Add(
         ' select ' +
         '   empresa_e2l, ' +
         '   cosechero_e2l cos, ' +
         '   (select nombre_c from frf_cosecheros ' +
         '   where empresa_c = empresa_e2l ' +
         '   and cosechero_c = cosechero_e2l ) nom_cos, ' +

         '   producto_e2l, ' +
         '   ano_sem_planta_e2l ano_semana, ' +
         '   plantacion_e2l pla, ' +
         '   (select descripcion_p from frf_plantaciones ' +
         '   where ano_semana_p = ano_sem_planta_e2l ' +
         '   and empresa_p = empresa_e2l ' +
         '   and producto_p = producto_e2l ' +
         '   and cosechero_p = cosechero_e2l ' +
         '   and plantacion_p = plantacion_e2l) nom_pla, ' +

         '   sum( total_cajas_e2l) cajas_per, ' +
         '   sum( total_kgs_e2l) kilos_per ' +

         ' from frf_entradas2_l ' +

         ' where empresa_e2l = :empresa ' +
         ' and centro_e2l = :centro ' +
         ' and producto_e2l = :producto ' +
         ' and fecha_e2l between :fechaini and :fechafin ' +
         ' and cosechero_e2l between :oppini and :oppfin ' +
         ' and plantacion_e2l between :productorini and :productorfin ' +

         ' group by empresa_e2l, cosechero_e2l, producto_e2l, plantacion_e2l, ano_sem_planta_e2l ' +
         ' order by empresa_e2l, cosechero_e2l, producto_e2l, plantacion_e2l, ano_sem_planta_e2l ');
      QLResumenEntradasOPP.QListado.ParamByName('empresa').AsString:= EEmpresa.Text;
      QLResumenEntradasOPP.QListado.ParamByName('centro').AsString:= eCentro.Text;
      QLResumenEntradasOPP.QListado.ParamByName('producto').AsString:= eProducto.Text;
      QLResumenEntradasOPP.QListado.ParamByName('fechaini').AsDateTime:= StrToDate(MEDesde.Text);
      QLResumenEntradasOPP.QListado.ParamByName('fechafin').AsDateTime:= StrToDate(MEHasta.Text);
      QLResumenEntradasOPP.QListado.ParamByName('oppini').AsString:= EDesde.Text;
      QLResumenEntradasOPP.QListado.ParamByName('oppfin').AsString:= EHasta.Text;
      QLResumenEntradasOPP.QListado.ParamByName('productorini').AsString:= EDesde2.Text;
      QLResumenEntradasOPP.QListado.ParamByName('productorfin').AsString:= EHasta2.Text;

      QLResumenEntradasOPP.QListado.Open;
      if QLResumenEntradasOPP.QListado.IsEmpty then
      begin
        QLResumenEntradasOPP.QListado.Close;
        FreeAndNil(QLResumenEntradasOPP);
        ShowMessage('No hay entradas que cumplan los parametros especificados.');
        Exit;
      end;

      with QLResumenEntradasOPP do
      begin
        //Coloco la fecha del rango en el informe
        QRLDesde.Caption:=MEDesde.Text + ' - ';
        QRLHasta.Caption:=MEHasta.Text;
        psCentro.Caption:=ECentro.Text+'  '+centro;
        psProducto.Caption:=EProducto.Text+'  '+producto;
      end;

      Preview(QLResumenEntradasOPP);
    finally
      BorrarTemporal('#tmp_listado');
    end;
end;

procedure TFMResumenEntradasOPP.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  CloseAuxQuerys;
     gRF:=nil;
     gCF:=nil;
     if FPrincipal.MDIChildCount = 1 then
     begin
        FormType:=tfDirector;
        BHFormulario;
     end;
     BEMensajes('');
     Action:=caFree;
end;

procedure TFMResumenEntradasOPP.FormCreate(Sender: TObject);
begin
     FormType:=tfOther;
     BHFormulario;

     EEmpresa.Tag:=kEmpresa;
     ECentro.Tag:=kCentro;
     EProducto.Tag:=kProducto;
     MEDesde.Tag:=kCalendar;
     MEHasta.Tag:=kCalendar;
     gRF :=rejillaFlotante;
     RejillaFlotante.DataSource := DMBaseDatos.DSQDespegables;
     gCF:=calendarioFlotante;

     EEmpresa.Text:= gsDefEmpresa;
     ECentro.Text:= gsDefCentro;
     EProducto.Text:= gsDefProducto;
     CalendarioFlotante.Date:= Date;
     MEDesde.Text:= DateToStr( Date );
     MEHasta.Text:= MEDesde.Text;
     EDesde.Text:='1';
     EHasta.Text:= '999';
     EDesde2.Text:='1';
     EHasta2.Text:= '999';
end;

procedure TFMResumenEntradasOPP.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    case key of
         $0D,$28: //vk_return,vk_down
         begin
              Key := 0;
              PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
              Exit;
         end;
         $26:  //vk_up
         begin
              Key := 0;
              PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
              Exit;
         end;
    end;
end;

procedure TFMResumenEntradasOPP.ADesplegarRejillaExecute(Sender: TObject);
begin
     case ActiveControl.Tag of
          kEmpresa:DespliegaRejilla(BGBEmpresa);
          kProducto:DespliegaRejilla(BGBProducto,[EEmpresa.Text]);
          kCentro:DespliegaRejilla(BGBCentro,[EEmpresa.Text]);
          kCalendar:
          begin
               if MEDesde.Focused then
                  DespliegaCalendario(BCBDesde)
               else
                  DespliegaCalendario(BCBHasta);
          end;
     end;
end;

procedure TFMResumenEntradasOPP.PonNombre(Sender:TObject);
begin
     if ((gRF<>nil) and gRF.Visible) or
        ((gCF<>nil) and gCF.Visible) then
        Exit;
     case TComponent(Sender).Tag of
          kEmpresa:
          begin
            STEmpresa.Caption:=desEmpresa(Eempresa.Text);
            STCentro.Caption:=desCentro(Eempresa.Text,Ecentro.Text);
          end;
          kProducto:STProducto.Caption:=desProducto(Eempresa.Text,Eproducto.Text);
          kCentro:STCentro.Caption:=desCentro(Eempresa.Text,Ecentro.Text);
     end;
end;

procedure TFMResumenEntradasOPP.MEHastaExit(Sender: TObject);
begin
     if StrToDate(MEHasta.Text) < StrToDate(MEDesde.Text) then
     begin
          MessageDlg('Debe escribir un rango de fechas correcto',
                           mtError,[mbOk],0);
          MEDesde.SetFocus;
     end;
end;

procedure TFMResumenEntradasOPP.EHastaExit(Sender: TObject);
begin
     if StrToInt(EHasta.Text) < StrToInt(EDesde.Text) then
     begin
          MessageDlg('Debe escribir un rango de cosecheros correcto',
                           mtError,[mbOk],0);
          EDesde.SetFocus;
     end;
end;

procedure TFMResumenEntradasOPP.EHasta2Exit(Sender: TObject);
begin
     if StrToInt(EHasta2.Text) < StrToInt(EDesde2.Text) then
     begin
          MessageDlg('Debe escribir un rango de plantaciones correcto',
                           mtError,[mbOk],0);
          EDesde2.SetFocus;
     end;
end;

procedure TFMResumenEntradasOPP.FormActivate(Sender: TObject);
begin
  Top:=1;
  ActiveControl:=EEmpresa;
end;

procedure TFMResumenEntradasOPP.ACancelarExecute(Sender: TObject);
begin
   if CerrarForm(false) then Close;
end;

end.
