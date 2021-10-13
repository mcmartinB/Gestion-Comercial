unit DConversor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, BCalendario, Buttons, BSpeedButton, BCalendarButton, StdCtrls,
  BEdit, BDEdit, ExtCtrls;

type
  TFDConversor = class(TForm)
    comboFecha: TBEdit;
    Calendario: TBCalendario;
    cantidadDestino: TStaticText;
    comboDestino: TComboBox;
    comboOrigen: TComboBox;
    botonFecha: TBCalendarButton;
    Bevel1: TBevel;
    cantidadOrigen: TBDEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Bevel2: TBevel;
    StaticText2: TStaticText;
    procedure botonFechaClick(Sender: TObject);
    procedure changeValue(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure comboFechaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure Convertir;
  public
    { Public declarations }
    procedure RellenaCombos;
  end;

function Execute( const APAdre: TForm; fecha: TDate; Origen, Destino: string): string;

var
  FDConversor: TFDConversor;

implementation

{$R *.DFM}

uses UDMAuxDB, CAuxiliarDB, UDMCambioMoneda;

function Execute( const APAdre: TForm; fecha: TDate; Origen, Destino: string): string;
var i: integer;
begin
  with TFDConversor.Create(Application) do
  begin
    Top:= APadre.Top + ( APAdre.Height - 21 - Height );
    Left:= APAdre.Left + 41;
    
    //FECHA
    Calendario.Date := fecha;
    comboFecha.Text := DateToStr(fecha);

    //MONEDAS
    rellenaCombos;

    //MONEDA DESTINO
    for i := 0 to comboDestino.Items.Count - 1 do
    begin
      if Trim(comboDestino.Items[i]) = Trim(Destino) then
      begin
        comboDestino.ItemIndex := i;
        break;
      end
      else
        comboDestino.ItemIndex := 0;
    end;

    //MONEDA ORIGEN
    for i := 0 to comboDestino.Items.Count - 1 do
    begin
      if Trim(comboOrigen.Items[i]) = Trim(Origen) then
      begin
        comboOrigen.ItemIndex := i;
        break;
      end
      else
        comboOrigen.ItemIndex := 0;
    end;

    //MOSTAR FORM
    if ShowModal = mrOk then
      Execute := cantidadDestino.Caption;
    Free;
  end;
end;

procedure TFDConversor.botonFechaClick(Sender: TObject);
begin
  if comboFecha.Text <> '' then
  try
    Calendario.Date := StrToDate(comboFecha.Text);
  except
    Calendario.Date := Date;
  end;
  botonFecha.CalendarShow;
end;

procedure TFDConversor.RellenaCombos;
var
  i: Integer;
begin
  comboDestino.Items.Add('EUR');
  comboOrigen.Items.Add('EUR');

  if ConsultaOpen(DMAuxDB.QAux, ' select distinct(moneda_ce) from frf_cambios_euros ' +
    ' order by moneda_ce ') > 0 then
  begin
    for i := 0 to DMAuxDB.QAux.RecordCount - 1 do
    begin
      comboDestino.Items.Add(DMAuxDB.QAux.Fields[0].AsString);
      comboOrigen.Items.Add(DMAuxDB.QAux.Fields[0].AsString);
      DMAuxDB.QAux.Next;
    end;
  end;
  DMAuxDB.QAux.Cancel;
  DMAuxDB.QAux.Close;
end;

procedure TFDConversor.changeValue(Sender: TObject);
begin
  Convertir;
end;

procedure TFDConversor.Convertir;
var
  cantidad: Real;
begin
  if Trim(cantidadOrigen.Text) <> '' then
  begin
    if comboOrigen.Items[comboOrigen.ItemIndex] = 'EUR' then
    begin
      //Desde EUROS
      cantidad := ChangeFromEuro(
        comboDestino.Items[comboDestino.ItemIndex],
        comboFecha.Text,
        strToFloat(cantidadOrigen.Text), 5);
    end
    else
      if comboDestino.Items[comboDestino.ItemIndex] = 'EUR' then
      begin
     //Hasta EUROS
        cantidad := ChangeToEuro(
          comboOrigen.Items[comboOrigen.ItemIndex],
          comboFecha.Text,
          strToFloat(cantidadOrigen.Text), 5);
      end
      else
      begin
        cantidad := ChangeMoney(
          comboOrigen.Items[comboOrigen.ItemIndex],
          comboDestino.Items[comboDestino.ItemIndex],
          comboFecha.Text,
          strToFloat(cantidadOrigen.Text), 5);
      end;
    cantidadDestino.Caption := FloatToStr(cantidad);
  end
  else
  begin
    cantidadDestino.Caption := '';
  end;
end;



procedure TFDConversor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_return, vk_down:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 0, 0);
      end;
    vk_up:
      begin
        Key := 0;
        PostMessage(Handle, WM_NEXTDLGCTL, 1, 0);
      end;
    vk_f1:
      begin
        BitBtn1.Click;
      end;
  end;
end;

procedure TFDConversor.comboFechaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_f2:
      begin
        botonFecha.Click;
      end;
  end;
end;

end.
