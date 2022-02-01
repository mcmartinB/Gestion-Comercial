unit DConfigPrinter;

interface

uses
  SysUtils, Forms, quickrpt, Spin, BEdit,
  Classes, Controls, StdCtrls, Buttons;

type
  TFDConfigPrinter = class(TForm)
    cbImpresoras: TComboBox;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    NumeroCopias: TSpinEdit;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label3: TLabel;
    Desde: TBEdit;
    Hasta: TBEdit;
    procedure FormCreate(Sender: TObject);
    procedure RadioButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FDConfigPrinter: TFDConfigPrinter;

function ExecuteConfigPrinter(Report: TQuickRep; var nCopias: Integer): Boolean;

implementation

uses Printers;

{$R *.DFM}

function ExecuteConfigPrinter(Report: TQuickRep; var nCopias: Integer): Boolean;
var
  iHasta, iDesde: integer;
begin
  //
  with TFDConfigPrinter.Create(Application) do
  begin
    {Impresora seleccionada}
    if Report.PrinterSettings.PrinterIndex = -1 then
      cbImpresoras.ItemIndex := cbImpresoras.Items.IndexOf(Printer.Printers[Printer.PrinterIndex])
    else
      cbImpresoras.ItemIndex := Report.PrinterSettings.PrinterIndex;

    {Numero de copias}
    NumeroCopias.Text := IntToStr(nCopias);

    {Rango de hojas a imprimir}
    Desde.Text := '1';
    Hasta.Text := IntToStr(Report.PageNumber);
//    Hasta.Text := IntToStr(Report.PrinterSettings.LastPage);


    if ShowModal = mrOk then
    begin
      Result := True;
      //Impresora
      Report.PrinterSettings.PrinterIndex := cbImpresoras.ItemIndex;

      //Rango de impresion
      if RadioButton1.Checked then
      begin
        //Imprimir todas los hojas
        Report.PrinterSettings.FirstPage := 1;
        Report.PrinterSettings.LastPage := Report.PrinterSettings.LastPage; //Report.PageNumber;
      end
      else
        if RadioButton2.Checked then
        begin
        //Rando de impresion
          if Trim(Desde.Text) = '' then
            iDesde := 1
          else
          begin
            iDesde := StrToInt(Desde.Text);
            if iDesde < 1 then iDesde := 1;
          end;

          if Trim(Hasta.Text) = '' then
            iHasta := Report.PageNumber
          else
          begin
            iHasta := StrToInt(Hasta.Text);
            if iHasta > Report.PageNumber then iHasta := Report.PageNumber;
          end;

          if iDesde > iHasta then iDesde := iHasta;
          Report.PrinterSettings.FirstPage := iDesde;
          Report.PrinterSettings.LastPage := iHasta;
        end;

      //Numero de copias
      nCopias := StrToInt(NumeroCopias.Text);
    end
    else
      Result := False;
    Free;
  end;
end;

procedure TFDConfigPrinter.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  {Rellenar combo con el nombre de las impresoras}
  cbImpresoras.Clear;
  for i := 0 to Printer.Printers.Count - 1 do
  begin
    cbImpresoras.Items.Add(Printer.Printers[i]);
    cbImpresoras.ItemIndex := 0;
  end;
end;

procedure TFDConfigPrinter.RadioButtonClick(Sender: TObject);
begin
  if RadioButton1.Checked then
  begin
    Desde.Enabled := False;
    Hasta.Enabled := False;
  end
  else
    if RadioButton2.Checked then
    begin
      Desde.Enabled := True;
      Hasta.Enabled := True;
    end;
end;

end.
