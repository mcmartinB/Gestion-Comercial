unit AprovechaVerifica;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, BEdit, nbLabels;

type
  TFAprovechaVerifica = class(TForm)
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    nbLabel1: TnbLabel;
    nbLabel2: TnbLabel;
    nbLabel3: TnbLabel;
    nbLabel4: TnbLabel;
    des_empresa: TnbStaticText;
    des_centro: TnbStaticText;
    des_producto: TnbStaticText;
    nbLabel7: TnbLabel;
    nbLabel8: TnbLabel;
    empresa: TBEdit;
    centro: TBEdit;
    producto: TBEdit;
    fecha_desde: TBEdit;
    fecha_hasta: TBEdit;
    chkDesglose: TCheckBox;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAceptarClick(Sender: TObject);
    procedure empresaChange(Sender: TObject);
    procedure centroChange(Sender: TObject);
    procedure productoChange(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure fecha_desdeChange(Sender: TObject);
  private
    { Private declarations }
    function RangoValidos: Boolean;
  public
    { Public declarations }
  end;

implementation

uses UDMAuxDB, Principal, CGestionPrincipal, CVariables, UDMBaseDatos,
  AprovechaVerificaReport, CReportes, DPreview, DBTables;

{$R *.dfm}

procedure TFAprovechaVerifica.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFAprovechaVerifica.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  BEMensajes('');
  if FPrincipal.MDIChildCount = 1 then
  begin
    FormType := tfDirector;
    BHFormulario;
  end;
  Action := caFree;
end;

procedure TFAprovechaVerifica.FormCreate(Sender: TObject);
var
  fecha: TDate;
begin
  FormType := tfOther;
  BHFormulario;

  empresa.Text := '050';
  centro.Text := '1';
  producto.Text := 'TOM';

  fecha := date;
  while DayOfWeek(fecha) <> 1 do fecha := fecha - 1;
  fecha_desde.Text := DateToStr(fecha - 6);
  fecha_hasta.Text := DateToStr(fecha);
end;

procedure TFAprovechaVerifica.FormKeyDown(Sender: TObject; var Key: Word;
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
        btnCancelar.Click;
      end;
    vk_f1:
      begin
        btnAceptar.Click;
      end;
  end;
end;

procedure TFAprovechaVerifica.btnAceptarClick(Sender: TObject);
var
  QRAprovechaVerifica: TQRAprovechaVerifica;
  flag: boolean;
begin
  if RangoValidos then
  begin
    DMBaseDatos.QListado.SQL.Clear;

    DMBaseDatos.QListado.SQL.Add(' Select * ');
    DMBaseDatos.QListado.SQL.Add(' From frf_entradas2_l ');
    DMBaseDatos.QListado.SQL.Add(' Where empresa_e2l = :empresa ');
    DMBaseDatos.QListado.SQL.Add(' and centro_e2l = :centro ');
    DMBaseDatos.QListado.SQL.Add(' and fecha_e2l between :fecha_ini and :fecha_fin ');
    DMBaseDatos.QListado.SQL.Add(' and producto_e2l = :producto ');

    DMBaseDatos.QListado.ParamByName('empresa').AsString := empresa.Text;
    DMBaseDatos.QListado.ParamByName('centro').AsString := centro.Text;
    DMBaseDatos.QListado.ParamByName('producto').AsString := producto.Text;
    DMBaseDatos.QListado.ParamByName('fecha_ini').AsString := fecha_desde.Text;
    DMBaseDatos.QListado.ParamByName('fecha_fin').AsString := fecha_hasta.Text;

    DMBaseDatos.QListado.Open;
    flag := DMBaseDatos.QListado.IsEmpty;
    DMBaseDatos.QListado.Close;
    if flag then
    begin
      MessageBox(self.Handle,
        'No hay entradas de fruta para los datos introducidos.' + #13 + #10 +
        'Compruebe que haya introducido correctamente los datos.',
        'ESCANDALLOS',
        MB_OK + MB_ICONEXCLAMATION);
      Exit;
    end;

    DMBaseDatos.QListado.SQL.Clear;

    DMBaseDatos.QListado.SQL.Add(' Select cosechero_e2l, ');
    DMBaseDatos.QListado.SQL.Add('   (select nombre_c ');
    DMBaseDatos.QListado.SQL.Add('    from frf_cosecheros ');
    DMBaseDatos.QListado.SQL.Add('    where empresa_c = :empresa ');
    DMBaseDatos.QListado.SQL.Add('      and cosechero_c = cosechero_e2l) des_cosechero, ');
    DMBaseDatos.QListado.SQL.Add('   plantacion_e2l, ');
    DMBaseDatos.QListado.SQL.Add('   (select descripcion_p ');
    DMBaseDatos.QListado.SQL.Add('    from frf_plantaciones ');
    DMBaseDatos.QListado.SQL.Add('    where ano_semana_p = ano_sem_planta_e2l ');
    DMBaseDatos.QListado.SQL.Add('      and empresa_p = :empresa ');
    DMBaseDatos.QListado.SQL.Add('      and producto_p = :producto ');
    DMBaseDatos.QListado.SQL.Add('      and cosechero_p = cosechero_e2l ');
    DMBaseDatos.QListado.SQL.Add('      and plantacion_p = plantacion_e2l) des_plantacion, ');

    if chkDesglose.Checked then
    begin
      DMBaseDatos.QListado.SQL.Add('   fecha_e2l, numero_entrada_e2l, calidad_ec ');
    end
    else
    begin
      DMBaseDatos.QListado.SQL.Add('   min(fecha_e2l) fecha_e2l, count(*) numero_entrada_e2l, '''' calidad_ec');
    end;

    DMBaseDatos.QListado.SQL.Add(' From frf_entradas2_l, frf_entradas_c ');
    DMBaseDatos.QListado.SQL.Add(' Where not exists ');
    DMBaseDatos.QListado.SQL.Add('  (Select * from frf_escandallo ');
    DMBaseDatos.QListado.SQL.Add('   where empresa_e = :empresa ');
    DMBaseDatos.QListado.SQL.Add('   and centro_e = :centro ');
    DMBaseDatos.QListado.SQL.Add('   and producto_e = :producto ');
    DMBaseDatos.QListado.SQL.Add('   and fecha_e between :fecha_ini and :fecha_fin ');
    DMBaseDatos.QListado.SQL.Add('   and fecha_e = fecha_e2l ');
    DMBaseDatos.QListado.SQL.Add('   and numero_entrada_e = numero_entrada_e2l ');
    DMBaseDatos.QListado.SQL.Add('   and cosechero_e = cosechero_e2l ');
    DMBaseDatos.QListado.SQL.Add('   and plantacion_e = plantacion_e2l) ');
    DMBaseDatos.QListado.SQL.Add(' and empresa_e2l = :empresa ');
    DMBaseDatos.QListado.SQL.Add(' and centro_e2l = :centro ');
    DMBaseDatos.QListado.SQL.Add(' and fecha_e2l between :fecha_ini and :fecha_fin ');
    DMBaseDatos.QListado.SQL.Add(' and producto_e2l = :producto ');
    DMBaseDatos.QListado.SQL.Add(' and empresa_e2l = empresa_ec ');
    DMBaseDatos.QListado.SQL.Add(' and centro_e2l = centro_ec ');
    DMBaseDatos.QListado.SQL.Add(' and fecha_e2l = fecha_ec ');
    DMBaseDatos.QListado.SQL.Add(' and numero_entrada_e2l = numero_entrada_ec ');

    if chkDesglose.Checked then
    begin
      DMBaseDatos.QListado.SQL.Add(' order by 1,3,5,6 ');
    end
    else
    begin
      DMBaseDatos.QListado.SQL.Add(' group by 1,2,3,4 ');
      DMBaseDatos.QListado.SQL.Add(' order by 1,3 ');
    end;

    DMBaseDatos.QListado.ParamByName('empresa').AsString := empresa.Text;
    DMBaseDatos.QListado.ParamByName('centro').AsString := centro.Text;
    DMBaseDatos.QListado.ParamByName('producto').AsString := producto.Text;
    DMBaseDatos.QListado.ParamByName('fecha_ini').AsString := fecha_desde.Text;
    DMBaseDatos.QListado.ParamByName('fecha_fin').AsString := fecha_hasta.Text;

    DMBaseDatos.QListado.Open;
    if DMBaseDatos.QListado.IsEmpty then
    begin
      MessageBox(self.Handle,
        'Todos los registros de escandallos ya estan grabados.',
        'ESCANDALLOS',
        MB_OK + MB_ICONINFORMATION);
    end
    else
    begin
      QRAprovechaVerifica := TQRAprovechaVerifica.Create(self);
      PonLogoGrupoBonnysa(QRAprovechaVerifica, empresa.text);
      QRAprovechaVerifica.lblCentro.Caption := centro.Text + ' ' + des_centro.Caption;
      QRAprovechaVerifica.lblProducto.Caption := producto.Text + ' ' + des_producto.Caption;
      QRAprovechaVerifica.lblFecha.Caption := 'Del ' + fecha_desde.Text +
        ' al ' + fecha_hasta.Text;
      Preview(QRAprovechaVerifica);
    end;
    DMBaseDatos.QListado.Close;
  end;
end;

function TFAprovechaVerifica.RangoValidos: Boolean;
var
  desde, hasta: TDate;
begin
  result := false;
  //Comprobar que las fechas sean correctas
  try
    desde := StrToDate(fecha_desde.Text);
  except
    fecha_desde.SetFocus;
    ShowMessage('Fecha incorrecta.');
    Exit;
  end;
  try
    hasta := StrToDate(fecha_hasta.Text);
  except
    fecha_hasta.SetFocus;
    ShowMessage('Fecha incorrecta.');
    Exit;
  end;

  //Comprobar que el rango sea correcto
  if desde > hasta then
  begin
    fecha_desde.SetFocus;
    ShowMessage('Rango de fechas incorrecto.');
    Exit;
  end;
  result := true;
end;

procedure TFAprovechaVerifica.empresaChange(Sender: TObject);
begin
  des_empresa.Caption := desEmpresa(empresa.Text);
end;

procedure TFAprovechaVerifica.centroChange(Sender: TObject);
begin
  des_centro.Caption := desCentro(empresa.Text, centro.Text);
end;

procedure TFAprovechaVerifica.productoChange(Sender: TObject);
begin
  des_producto.Caption := desProducto(empresa.Text, producto.Text);
end;

procedure TFAprovechaVerifica.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFAprovechaVerifica.fecha_desdeChange(Sender: TObject);
var
  dFecha: TDatetime;
begin
  if TryStrToDate( fecha_desde.Text, dFecha ) then
  begin
    fecha_Hasta.Text:= DateToStr( dFecha + 6 )
  end
  else
  begin
    fecha_Hasta.Text:= '';
  end;
end;

end.


