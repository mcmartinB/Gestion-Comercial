unit DSeleccionImpresoras;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ActnList, Buttons, DBCtrls, Db, CGestionPrincipal, BDEdit, DError, DBTables;

type
  TFDSeleccionImpresoras = class(TForm)
    StaticText1: TStaticText;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ActionList1: TActionList;
    AAceptar: TAction;
    ACancelar: TAction;
    CBPrintDef: TComboBox;
    StaticText4: TStaticText;
    CBAcrobatPDF: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure AAceptarExecute(Sender: TObject);
    procedure ACancelarExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses Printers, UDMBaseDatos, CAuxiliarDB, CVariables, IniFiles, UDMConfig;

{$R *.DFM}

procedure TFDSeleccionImpresoras.FormCreate(Sender: TObject);
var
  i: integer;
begin
  //Cargar comboBox
  CBPrintDef.Clear;
  for i := 0 to Printer.Printers.Count - 1 do
  begin
    CBPrintDef.Items.Add(Printer.Printers.Strings[i]);
    if Pos( 'PDF', UpperCase( Printer.Printers.Strings[i] ) ) > 0 then
      CBAcrobatPDF.Items.Add(Printer.Printers.Strings[i]);
  end;

  //Visualizar impresoras seleccionadas
//  if ( giPrintDef > -1 ) and ( giPrintDef < Printer.Printers.Count ) then
//    CBPrintDef.ItemIndex := giPrintDef;
  if ( giPrintDefault > -1 ) and ( giPrintDefault < Printer.Printers.Count ) then
    CBPrintDef.ItemIndex := giPrintDefault;
  if ( giPrintPDF > -1 ) and ( giPrintPDF < Printer.Printers.Count ) then
  begin
    for i := 0 to Printer.Printers.Count - 1 do
    begin
      if CBAcrobatPDF.Items[i] = Printer.Printers.Strings[giPrintPDF] then
        giPrintPDF := i;
     end;
  end;
  CBAcrobatPDF.ItemIndex := giPrintPDF;

  FormType := tfOther;
  BHFormulario;
end;


procedure TFDSeleccionImpresoras.AAceptarExecute(Sender: TObject);
var
  i: integer;
begin
//  giPrintDef := CBPrintDef.ItemIndex;
  giPrintDefault := CBPrintDef.ItemIndex;
  giPrintPDF := CBAcrobatPDF.ItemIndex;

  for i := 0 to Printer.Printers.Count - 1 do
  begin
    if CBAcrobatPDF.Items[giPrintPDF] = Printer.Printers.Strings[i] then
    begin
      giPrintPDF := i;
      Break;
    end;
  end;

  DMConfig.GrabarImpresoras;

  Close;
end;

procedure TFDSeleccionImpresoras.ACancelarExecute(Sender: TObject);
begin
  //Ignorar cambios
  Close;
end;

procedure TFDSeleccionImpresoras.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FormType := tfDirector;
  BHFormulario;
  action := caFree;
end;

end.
