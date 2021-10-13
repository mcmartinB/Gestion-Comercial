unit DFacturaManual;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBCtrls, ExtCtrls,
  Db, DBTables, BEdit, BDEdit;

type
  TFDFacturaManual = class(TForm)
    DBMemo: TDBMemo;
    Panel2: TPanel;
    LEmpresa_f: TLabel;
    LCliente_fac_f: TLabel;
    LN_Factura_f: TLabel;
    LFecha_factura_f: TLabel;
    empresaText: TStaticText;
    cliente_facText: TStaticText;
    fechaText: TStaticText;
    TFacManual: TTable;
    DSFacManual: TDataSource;
    DSFactura: TDataSource;
    empresa: TBDEdit;
    fecha: TBDEdit;
    factura: TBDEdit;
    cliente: TBEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses DError;

{$R *.DFM}

procedure TFDFacturaManual.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  TFacManual.Close;
end;

procedure TFDFacturaManual.BitBtn1Click(Sender: TObject);
begin
  try
        //Guardamos registro si tiene valores
    if Trim(DBMemo.Text) = '' then
    begin
      TFacManual.Cancel;
      TFacManual.Delete;
    end
    else
      TFacManual.Post;
  except
    on E: EDBEngineError do
    begin
      ShowError(E);
      Self.Close;
      Exit;
    end;
  end;
end;

procedure TFDFacturaManual.BitBtn2Click(Sender: TObject);
begin
  try
        //Dejamos las cosas como estaban
    TFacManual.Cancel;
  except
    on E: EDBEngineError do
    begin
      ShowError(E);
      Self.Close;
      Exit;
    end;
  end;
end;

procedure TFDFacturaManual.FormActivate(Sender: TObject);
begin
     //Activamos registro
  with TFacManual do
  begin
    try
      Open;
    except
      on E: EDBEngineError do
      begin
        ShowError(E);
        Self.Close;
        Exit;
      end;
    end;
          //puede haber registro o no
    if RecordCount > 0 then
    begin
      try
                //Ponemos en ediccion el registro activo
        Edit;
      except
        on E: EDBEngineError do
        begin
          ShowError(E);
          Self.Close;
          Exit;
        end;
      end;
    end
    else
    try
                //Insertamos un registro
      Insert;
    except
      on E: EDBEngineError do
      begin
        ShowError(E);
        Self.Close;
        Exit;
      end;
    end;
  end;

     //Foco
  DBMemo.SetFocus;
end;

end.
