unit DError;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls, Buttons,
  DBCtrls, dbTables, Db, CVariables, BEdit, ExtCtrls, Printers;

const
     //Nueva linea
  kNewLine = #13 + #10;

type
  TFDError = class(TForm)
    original: TMemo;
    BitBtn1: TBitBtn;
    Usuario: TBEdit;
    fecha: TBEdit;
    Hora: TBEdit;
    formulario: TBEdit;
    login: TBEdit;
    Image: TImage;
    QErrores: TQuery;
    QInsertError: TQuery;
    BitBtn2: TBitBtn;
    QUpdateError: TQuery;

    procedure DBErroresLogin(Database: TDatabase; LoginParams: TStrings);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn2Click(Sender: TObject);

  private
    { Private declarations }
    CodigoError, CategoriaError, SubcodigoError, NativoError: Integer;
    TextoError, TextoNativoError: string;
    nivelError: Integer;

    procedure RellenaCabecera;
    procedure ExceptionDeBaseDatos(erro: EDBEngineError);
    procedure ExceptionOtra(erro: Exception);
    procedure Configurar;
  public
    { Public declarations }
  end;


  //MOSTRAR ERROR
procedure ShowError(erro: Exception; tipo: integer = 0); Overload;
procedure ShowError(erro: string; tipo: integer = 0); Overload;
function  MsgError(erro: Exception): string;

implementation

uses CGestionPrincipal, CMaestroDetalle, CMaestro, UDMBaseDatos, Principal, Dialogs,
  Variants, UDMConfig;

{$R *.DFM}


//Funcion local a este modulo

function EntreSubrayado(cadena: string): string;
var inicio: Integer;
begin
  inicio := Pos('_', cadena);
  if inicio = 0 then
  begin
    EntreSubrayado := '';
  end
  else
  begin
    cadena := Copy(cadena, inicio + 1, Length(cadena) - inicio);
    inicio := Pos('_', cadena);
    EntreSubrayado := '(' + Copy(cadena, 0, inicio - 1) + ')';
  end;
end;

procedure TFDError.ExceptionDeBaseDatos(erro: EDBEngineError);
begin
  // ----------------------------  OBTENER DATOS  -----------------------------
  original.Lines.Clear;

  with erro do
  begin
    CodigoError := Errors[ErrorCount - 1].ErrorCode;
    CategoriaError := Errors[ErrorCount - 1].Category;
    SubcodigoError := Errors[ErrorCount - 1].SubCode;
    TextoError := Message;
    NativoError := Errors[ErrorCount - 1].NativeError;
    TextoNativoError := Errors[ErrorCount - 1].Message;
  end;

  //Mensaje de error
  if QErrores.Active then QErrores.Close;
  QErrores.ParamByName('codigo').AsInteger := CodigoError;
  QErrores.ParamByName('nativo').AsInteger := NativoError;
  QErrores.Open;
  if QErrores.IsEmpty then
  begin
    //Si no existe el error en la base de datos lo introducimos como
    //error no clasificado
    original.Lines.Add('');
    original.Lines.add('Error no clasificado.');
    original.Lines.add('Por favor comuniquelo al departamento de informática.');
    original.Lines.Add('');

    QInsertError.ParamByName('codigo').AsInteger := CodigoError;
    QInsertError.ParamByName('nativo').AsInteger := NativoError;
    QInsertError.ParamByName('mensaje').AsString := 'Error no clasificado.';
    QInsertError.ParamByName('textoError').AsString := TextoError;
    QInsertError.ParamByName('nativoError').AsString := TextoNativoError;
    QInsertError.ExecSQL;

    BitBtn2.Visible := True;
  end
  else
  begin
    if (QErrores.FieldByName('texto_error_me').AsString = '') or
      (QErrores.FieldByName('texto_error_me').Value = NULL) then
    begin
      QUpdateError.ParamByName('codigo').AsInteger := CodigoError;
      QUpdateError.ParamByName('nativo').AsInteger := NativoError;
      QUpdateError.ParamByName('textoError').AsString := TextoError;
      QUpdateError.ParamByName('nativoError').AsString := TextoNativoError;
      QUpdateError.ExecSQL;
    end;
    original.Lines.Add('');
    original.Lines.add(QErrores.FieldByName('descripcion_me').AsString);
    if QErrores.FieldByName('tipo_me').AsInteger > 0 then
    begin
      if QErrores.FieldByName('tipo_me').AsInteger > nivelError then
        nivelError := QErrores.FieldByName('tipo_me').AsInteger;
    end;
    original.Lines.Add('');
  end;

  original.Lines.add('*************************************');
  original.Lines.add('CodigoError: ' + IntToStr(CodigoError));
  original.Lines.add('CategoriaError: ' + IntToStr(CategoriaError));
  original.Lines.add('SubcodigoError: ' + IntToStr(SubcodigoError));
  original.Lines.add('TextoError: ' + TextoError);
  original.Lines.add('*************************************');
  original.Lines.add('NativoError: ' + IntToStr(NativoError));
  original.Lines.add('TextoNativoError: ' + TextoNativoError);
  original.Lines.add('*************************************')
end;

procedure TFDError.ExceptionOtra(erro: Exception);
begin
  original.Lines.Clear;
  original.Lines.add('');
  original.Lines.add(erro.Message);
end;

procedure TFDError.RellenaCabecera;
begin
  //Usuario
  Login.Text := gsCodigo;
  Usuario.Text := gsNombre;
  //Fecha y hora
  Fecha.Text := DateToStr(now);
  Hora.Text := TimeToStr(Now);
  //Formulario activo
  try
    Formulario.Text := TForm(FPrincipal.ActiveMDIChild).Caption;
  except
    Formulario.Text := TForm(Screen.ActiveForm).Caption;
    Formulario.Text := 'Formulario Desconocido';
  end;
end;

procedure TFDError.Configurar;
begin
  case nivelError of
    -1, 0: //No clasificado, leve
      begin
        Caption := '                                                   ATENCIÓN';
        Image.Picture.LoadFromFile(gsDirActual + '\recursos\leve.bmp');
      end;
    1, 2: //Grave, mortal
      begin
        Caption := '                                                    ERROR';
        Image.Picture.LoadFromFile(gsDirActual + '\recursos\grave.bmp');
      end;
  end;
end;


procedure ShowError(erro: Exception; tipo: integer = 0);
begin
  with TFDError.Create(Application) do
  begin
    nivelError := tipo;
       //Cabecera **********************************************************
    RellenaCabecera;

       //Cuerpo   **********************************************************
    if erro is EDBEngineError then
      ExceptionDeBaseDatos(EDBEngineError(erro))
    else
      ExceptionOtra(erro);

       //Configuracion *****************************************************
    Configurar;

    ShowModal;
    Free;
    Exit;
  end;
end;

procedure ShowError(erro: string; tipo: integer = 0);
begin
  try
    with TFDError.Create(Application) do
    begin
      nivelError := tipo;
       //Cabecera **********************************************************
      RellenaCabecera;

       //Cuerpo   **********************************************************
      original.Lines.Clear;
      original.Lines.Add('');
      original.Lines.Add(erro);

       //Configuracion *****************************************************
      Configurar;

      ShowModal;
      Free;
      Exit;
    end;
  except
    ShowMessage(erro);
  end;
end;

function MsgError(erro: Exception): string;
begin
  try
    with TFDError.Create(Application) do
    begin
      if erro is EDBEngineError then
      begin
        with EDBEngineError(erro) do
        begin
          if QErrores.Active then QErrores.Close;
          QErrores.ParamByName('codigo').AsInteger := Errors[ErrorCount - 1].ErrorCode;
          QErrores.ParamByName('nativo').AsInteger := Errors[ErrorCount - 1].NativeError;
          QErrores.Open;
          if QErrores.IsEmpty then
            MsgError := 'Error no clasificado.' +
              EntreSubrayado(erro.Message)
          else
            MsgError := QErrores.FieldByName('descripcion_me').AsString +
              EntreSubrayado(erro.Message);
          if QErrores.Active then QErrores.Close;
        end;
      end
      else
        MsgError := erro.Message;
      Free;
    end;
  except
    MsgError := erro.Message;
  end;
end;

procedure TFDError.DBErroresLogin(Database: TDatabase;
  LoginParams: TStrings);
begin
  //Parametros de la base de datos de errores
  if DMConfig.EsLaFont then
  begin
    LoginParams.Values['USER NAME'] := 'info';
    LoginParams.Values['PASSWORD'] := 'unix1q2w';
  end
  else
  begin
    LoginParams.Values['USER NAME'] := 'informix';
    LoginParams.Values['PASSWORD'] := 'unix1q2w';
  end;
end;

procedure TFDError.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_F1 then BitBtn1.Click;
end;

procedure TFDError.BitBtn2Click(Sender: TObject);
//var
  //i: Integer;
begin
(*
  IBMProPrinter1.BeginDoc;
  IBMProPrinter1.CR;
  IBMProPrinter1.LF;

  IBMProPrinter1.Bold(True);
  IBMProPrinter1.WriteLn('PARTE DE ERRORES');
  IBMProPrinter1.CR;
  IBMProPrinter1.LF;
  IBMProPrinter1.Bold(False);

  IBMProPrinter1.WriteLn('  Usuario    : ' + gsCodigo + ' - ' + gsNombre);
  IBMProPrinter1.WriteLn('  Fecha      : ' + fecha.text + ' - ' + hora.Text);
  IBMProPrinter1.WriteLn('  Formulario : ' + formulario.Text);
  IBMProPrinter1.CR;
  IBMProPrinter1.LF;

  for i := 0 to original.Lines.Count - 1 do
    IBMProPrinter1.WriteLn(original.Lines[i]);

  IBMProPrinter1.EndDoc;

  BitBtn2.Enabled := False;
*)
end;

end.
