unit DNoEuro;
interface

uses
  SysUtils, Classes, Controls, Forms, Dialogs, Graphics,
  StdCtrls, Buttons, CAuxiliarDB,
  dbtables, ExtCtrls, DError, ActnList, StdActns, ComCtrls, BCalendario,
  BSpeedButton, BCalendarButton, BEdit;

type
  TFDNoEuro = class(TForm)
    EdInput: TEdit;
    BtnConvert: TButton;
    RGSeleccion: TRadioGroup;
    GBResultados: TGroupBox;
    ActionList1: TActionList;
    ACancelar: TAction;
    BEdit1: TBEdit;
    BCalendarButton1: TBCalendarButton;
    BCalendario1: TBCalendario;
    procedure FormCreate(Sender: TObject);
    procedure BtnConvertClick(Sender: TObject);
    procedure RGCurrencyClick(Sender: TObject);
    procedure EdInputKeyPress(Sender: TObject; var Key: Char);
    procedure ACancelarExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BCalendarButton1Click(Sender: TObject);
  private
    { Private declarations }
    elementos: integer;
    etiquetas: array of string;
    valores: array of real;
    TextoEtiquetas: array of TStaticText;
    TextoValores: array of TLabel;
    procedure CurrConvert;
    procedure ConvertShow;
    procedure SetLabelInvisible;
    procedure CargaValores;
  public
    { Public declarations }
  end;

implementation

uses UDMBaseDatos;

{$R *.DFM}

var
  Euro: Real; // global variable for amount in Euro

procedure TFDNoEuro.BtnConvertClick(Sender: TObject);
begin
  CargaValores;
  CurrConvert;
end;

procedure TFDNoEuro.RGCurrencyClick(Sender: TObject);
begin
  CurrConvert;
end;

// At start of program, do first "automatic" conversion

procedure TFDNoEuro.FormCreate(Sender: TObject);
begin
  BEdit1.Text := DateToStr(Date);
  CargaValores;
  Width := 441;
  CurrConvert;
end;

{ Convert contents of the EDIT to EURO,
  convert to other currencies,
  show results in LABELs.               }

procedure TFDNoEuro.CurrConvert;
var
  Amount, // amount to convert
    CFactor: real; // conversion factor
begin
  try
    // Convert text of EDIT to numerical value
    Amount := StrToFloat(EdInput.Text);
    { Conversion factor depends from selected
      button in RADIOGROUP RGCurrency         }
    CFactor := valores[RGSeleccion.ItemIndex];
    if CFactor <> 0 then
      Euro := Amount / CFactor // plain arithmetics...
    else
      Euro := 0;
    // Convert to other currencies and show results
    ConvertShow;
    // Hide LABEL next to selected RADIOBUTTON
    SetLabelInvisible;
  except
    { When there is a conversion error,
      we end up here, IMMEDIATELY after trying
      to execute the function StrToFloat()     }
    on EConvertError do
      MessageDlg('Illegal input!', mtWarning, [mbOk], 0);
  end;
end;

{ Multiply value in Euro with conversion factors,
  convert to STRING-format and
  show results in correspondingLABELS             }

procedure TFDNoEuro.ConvertShow;
var
  i: integer;
begin
  { Convert from Euro to other currencies,
    format, append the currency names,
    add spaces as to obtain equal lengths,
    put resulting strings in CAPTIONs of LABELs }
  TextoValores[0].Caption := FormatFloat('0.000000', Euro);
  for i := 1 to elementos - 1 do
    TextoValores[i].caption := FormatFloat('0.000000', Euro * valores[i]);
end;

{ Hide LABEL next to selected RADIOBUTTON,
  make other LABELs visible               }

procedure TFDNoEuro.SetLabelInvisible;
var i: Integer;
begin
  for i := 0 to elementos - 1 do
    TextoValores[i].Visible := RGSeleccion.ItemIndex <> i;
end;


{ When EdInput has the focus, and a key is pressed:
  if it was the ENTER key, the conversion has to be executed;
  if it was the COMMA key and Windows is set up for
  numerical format "decimal point", this comma is converted
  to a POINT;
  if it was the POINT key and Windows' decimal symbol is set
  to COMMA, convert this POINT to a COMMA.                   }

procedure TFDNoEuro.EdInputKeyPress(Sender: TObject; var Key: Char);
begin
  // the code for the ENTER key is 13
  if Key = #13 then
    CurrConvert
  { DecimalSeparator is a GLOBAL variabele in Delphi
    depending from Windows' "Regional Settings"      }
  else
    if (Key = ',') and (DecimalSeparator = '.') then
      Key := '.'
    else
      if (Key = '.') and (DecimalSeparator = ',') then
        Key := ',';
end;

procedure TFDNoEuro.CargaValores;
var i: Integer;
begin
     //Realizamos query para sacar valores
  with DMBaseDatos.QGeneral do
  begin
    if Active then
    begin
      Cancel;
      Close;
    end;
    SQL.Clear;

    SQL.Add(' SELECT moneda_ce, cambio_ce, descripcion_m ' +
      ' FROM frf_cambios_euros, OUTER frf_monedas  ' +
      ' WHERE moneda_ce = moneda_m AND fecha_ce =:fecha');
    ParamByName('fecha').AsDateTime := StrToDate(BEdit1.Text);
    try
      Open;
    except
      on E: EDBEngineError do
      begin
        ShowError(e);
        Self.Close;
        Exit;
      end;
    end;
    RGSeleccion.Items.Clear;
    for i := 0 to elementos - 1 do
    begin
      TextoEtiquetas[i].Free;
      TextoValores[i].Free;
    end;

    elementos := RecordCount + 1;
    SetLength(valores, elementos);
    SetLength(etiquetas, elementos);
    SetLength(TextoEtiquetas, elementos);
    SetLength(TextoValores, elementos);
    valores[0] := 1;
    etiquetas[0] := ' EURO';
    RGSeleccion.Items.Add('EUR');
    i := 1;
    while not EOF do
    begin
      if Trim(Fields[2].AsString) <> '' then
        etiquetas[i] := ' ' + Fields[2].AsString
      else
        etiquetas[i] := ' ' + Fields[0].AsString;
      RGSeleccion.Items.Add(Fields[0].AsString);
      valores[i] := Fields[1].AsFloat;
      Inc(i);
      Next;
    end;
    Cancel;
    Close;
  end;

  RGSeleccion.Height := (elementos * 21) + 28;
  GBResultados.Height := (elementos * 21) + 28;
  for i := 0 to elementos - 1 do
  begin
    TextoValores[i] := TLabel.Create(GBResultados);
    with TextoValores[i] do
    begin
      Parent := GBResultados;
      Autosize := False;
      Alignment := taRightJustify;
      Layout := tlCenter;
      Height := 21;
      Left := 10;
      Width := 120;
      Top := 20 + (21 * i);
      Caption := etiquetas[i];
      Color := clSilver;
      Font.Color := clNavy;
    end;
    TextoEtiquetas[i] := TStaticText.Create(GBResultados);
    with TextoEtiquetas[i] do
    begin
      Parent := GBResultados;
      BorderStyle := sbsSunken;
      Autosize := False;
      Height := 21;
      Left := 140;
      Width := 120;
      Top := 20 + (21 * i);
      Caption := etiquetas[i];
    end;
  end;

  RGSeleccion.ItemIndex := 0;
  Height := 140 + (21 * (elementos));
  if Height < 266 then Height := 266;
end;

procedure TFDNoEuro.ACancelarExecute(Sender: TObject);
begin
  Close;
end;

procedure TFDNoEuro.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  ACancelar.Execute;
end;

procedure TFDNoEuro.BCalendarButton1Click(Sender: TObject);
begin
  BCalendarButton1.CalendarShow;
end;

end.
