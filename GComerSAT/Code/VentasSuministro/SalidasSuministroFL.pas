unit SalidasSuministroFL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, nbLabels, StdCtrls, BEdit, ComCtrls, ExtCtrls;

type
  TFLSalidasSuministro = class(TForm)
    edtEmpresa: TBEdit;
    lblEmpresa: TnbLabel;
    etqEmpresa: TnbStaticText;
    lblSumnistro: TnbLabel;
    edtSuministro: TBEdit;
    etqSuministro: TnbStaticText;
    lblCliente: TnbLabel;
    edtCliente: TBEdit;
    etqCliente: TnbStaticText;
    btnAceptar: TSpeedButton;
    btnCancelar: TSpeedButton;
    pgPageControl: TPageControl;
    tsPorPeriodo: TTabSheet;
    tsPorAnyos: TTabSheet;
    Label1: TLabel;
    PanelInf: TPanel;
    edtAnyoDesde: TBEdit;
    edtAnyoHasta: TBEdit;
    lblAnyoHasta: TnbLabel;
    lblAnyoDesde: TnbLabel;
    tsPorMeses: TTabSheet;
    tsPorSemanas: TTabSheet;
    tsPorDias: TTabSheet;
    lblFormatoAnyo: TLabel;
    lblPorAnyoDesde: TnbLabel;
    edtPorAnyoDesde: TBEdit;
    lblPorAnyoHasta: TnbLabel;
    edtPorAnyoHasta: TBEdit;
    lblPorMesDesde: TnbLabel;
    edtPorMesDesde: TBEdit;
    lblMesDesde: TnbLabel;
    edtMesDesde: TBEdit;
    lblPorMesHasta: TnbLabel;
    lblMesHasta: TnbLabel;
    edtPorMesHasta: TBEdit;
    edtMesHasta: TBEdit;
    lblFormatoAnyoMes: TLabel;
    lblPorSemanasDesde: TnbLabel;
    lblSemanaDesde: TnbLabel;
    edtPorSemanaDesde: TBEdit;
    edtSemanaDesde: TBEdit;
    edtPorSemanaHasta: TBEdit;
    lblPorSemanaHasta: TnbLabel;
    lblSemanaHasta: TnbLabel;
    edtSemanaHasta: TBEdit;
    lblFormatoAnyoSemana: TLabel;
    lblPorDiasDesde: TnbLabel;
    edtPorDiaDesde: TBEdit;
    lblPorDiasHasta: TnbLabel;
    edtPorDiaHasta: TBEdit;
    lblPorPeriodoDesde: TnbLabel;
    edtPorPeriodoDesde: TBEdit;
    lblPorPeriodoHasta: TnbLabel;
    edtPorPeriodoHasta: TBEdit;
    rbPorAnyo: TRadioButton;
    rbAnyo: TRadioButton;
    rbPorMes: TRadioButton;
    rbMes: TRadioButton;
    rbPorSemana: TRadioButton;
    rbSemana: TRadioButton;
    btnAExcel: TSpeedButton;
    lblEspere: TLabel;
    chkPedido: TCheckBox;
    edtDiasPedido: TBEdit;
    lblDias: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAceptarClick(Sender: TObject);
    procedure edtEmpresaChange(Sender: TObject);
    procedure edtClienteChange(Sender: TObject);
    procedure edtSuministroChange(Sender: TObject);
    procedure rbPorAnyoClick(Sender: TObject);
    procedure rbPorMesClick(Sender: TObject);
    procedure rbPorSemanaClick(Sender: TObject);
    procedure edtSemanaDesdeChange(Sender: TObject);
    procedure edtSemanaHastaChange(Sender: TObject);
    procedure edtPorSemanaDesdeChange(Sender: TObject);
    procedure edtPorSemanaHastaChange(Sender: TObject);
    procedure edtMesDesdeChange(Sender: TObject);
    procedure edtMesHastaChange(Sender: TObject);
    procedure edtPorMesDesdeChange(Sender: TObject);
    procedure edtPorMesHastaChange(Sender: TObject);
    procedure edtAnyoDesdeChange(Sender: TObject);
    procedure edtAnyoHastaChange(Sender: TObject);
    procedure edtPorAnyoDesdeChange(Sender: TObject);
    procedure edtPorAnyoHastaChange(Sender: TObject);
    procedure chkPedidoClick(Sender: TObject);
  private
    { Private declarations }
    dDesde, dHasta: TDateTime;
    
    function ValidarEntrada: Boolean;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses UDMAuxDB, Principal, CGestionPrincipal, CVariables, bTimeUtils,
     SalidasSuministroDL, DB, DateUtils;
var
  Parametros: RParametrosSalidasSuministro;

procedure TFLSalidasSuministro.FormCreate(Sender: TObject);
var
  fecha: TDateTime;
  iAnyo, iMes, iDia: word;
begin
  FormType := tfOther;
  BHFormulario;

  edtEmpresa.Text := '050';
  edtCliente.Text := 'MER';


  //Por periodo -> los siete dias anteriores
  edtPorPeriodoDesde.Text := DateToStr(date - 7);
  edtPorPeriodoHasta.Text := DateToStr(date - 1);

  //Por año -> año anterior
  iAnyo:= YearOf( IncYear( Date, -1 ) );
  //edtPorAnyoDesde.Text := DateToStr( EncodeDate( iAnyo, 1, 1 ) );
  //edtPorAnyoHasta.Text := DateToStr( EncodeDate( iAnyo, 1, 1 ) );
  edtAnyoDesde.Text:= IntToStr( iAnyo );
  edtAnyoHasta.Text:= edtAnyoDesde.Text;

  //Por mes -> mes anterior
  fecha:= IncMonth( Date, - 1 );
  DecodeDate( fecha, iAnyo, iMes, IDia );
  //iDia:= DaysInMonth( fecha);
  //edtPorMesDesde.Text := DateToStr( EncodeDate( iAnyo, iMes, 1 ) );
  //edtPorMesHasta.Text := DateToStr( EncodeDate( iAnyo, iMes, iDia ) );
  edtMesDesde.Text:= IntToStr( ( iAnyo * 100 ) + iMes );
  edtMesHasta.Text:= edtMesDesde.Text;

  //Por semana -> semana anterior
  fecha:= LunesAnterior( Date );
  //edtPorSemanaDesde.Text := DateToStr(fecha - 7);
  //edtPorSemanaHasta.Text := DateToStr(fecha - 1);
  edtSemanaDesde.Text:= AnyoSemana( fecha - 7 );
  edtSemanaHasta.Text:= edtSemanaDesde.Text;

  //Por dia -> dia anterior
  edtPorDiaDesde.Text := DateToStr(date - 1);
  edtPorDiaHasta.Text := DateToStr(date - 1);

  edtDiasPedido.Text:= '1';

  pgPageControl.ActivePage:= tsPorDias;
end;

procedure TFLSalidasSuministro.FormClose(Sender: TObject;
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

procedure TFLSalidasSuministro.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_escape:
      begin
        btnCancelar.Click;
      end;
  end;
end;

procedure TFLSalidasSuministro.FormKeyDown(Sender: TObject; var Key: Word;
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

function TFLSalidasSuministro.ValidarEntrada: Boolean;
begin
  result := false;

  //El codigo del cliente es obligatorio
  if Trim( edtEmpresa.Text ) = '' then
  begin
    edtEmpresa.SetFocus;
    ShowMessage('El código de la empresa es obligatorio.');
    Exit;
  end;

  //El codigo del cliente es obligatorio
  if Trim( edtCliente.Text ) = '' then
  begin
    edtCliente.SetFocus;
    ShowMessage('El código del cliente es obligatorio.');
    Exit;
  end;

  if pgPageControl.ActivePage = tsPorPeriodo then
  begin
    if not TryStrToDate( edtPorPeriodoDesde.Text, dDesde ) then
    begin
      edtPorPeriodoDesde.SetFocus;
      ShowMessage('Fecha incorrecta.');
      Exit;
    end;
    if not TryStrToDate(edtPorPeriodoHasta.Text, dHasta ) then
    begin
      edtPorPeriodoHasta.SetFocus;
      ShowMessage('Fecha incorrecta.');
      Exit;
    end;
    if dDesde > dHasta then
    begin
      edtPorPeriodoDesde.SetFocus;
      ShowMessage('Rango de fechas incorrecto.');
      Exit;
    end;
  end
  else
  if pgPageControl.ActivePage = tsPorAnyos then
  begin
    if Length(edtAnyoDesde.Text) <> 4 then
    begin
      if edtAnyoDesde.Enabled then
        edtAnyoDesde.SetFocus
      else
        edtPorAnyoDesde.SetFocus;
      ShowMessage('El año debe tener 4 dígitos.');
      Exit;
    end;
    dDesde:= EncodeDate( StrToInt( edtAnyoDesde.Text ), 1, 1 );
    if Length(edtAnyoHasta.Text) <> 4 then
    begin
      if edtAnyoHasta.Enabled then
        edtAnyoHasta.SetFocus
      else
        edtPorAnyoHasta.SetFocus;
      ShowMessage('El año debe tener 4 dígitos.');
      Exit;
    end;
    dHasta:= EncodeDate( StrToInt( edtAnyoHasta.Text ), 12, 31 );
    if dDesde > dHasta then
    begin
      if edtAnyoDesde.Enabled then
        edtAnyoDesde.SetFocus
      else
        edtPorAnyoDesde.SetFocus;
      ShowMessage('Rango de años incorrecto.');
      Exit;
    end;
  end
  else
  if pgPageControl.ActivePage = tsPorMeses then
  begin
    if Length(edtMesDesde.Text) <> 6 then
    begin
      if edtMesDesde.Enabled then
        edtMesDesde.SetFocus
      else
        edtPorMesDesde.SetFocus;
      ShowMessage('El año/mes debe tener 6 dígitos.');
      Exit;
    end;
    dDesde:= PrimerDiaAnyoMes( edtMesDesde.Text );
    if Length(edtMesHasta.Text) <> 6 then
    begin
      if edtMesHasta.Enabled then
        edtMesHasta.SetFocus
      else
        edtPorMesHasta.SetFocus;
      ShowMessage('El año/mes debe tener 6 dígitos.');
      Exit;
    end;
    dHasta:= UltimoDiaAnyoMes( edtMesHasta.Text );
    if dDesde > dHasta then
    begin
      if edtMesDesde.Enabled then
        edtMesDesde.SetFocus
      else
        edtPorMesDesde.SetFocus;
      ShowMessage('Rango de año/mes incorrecto.');
      Exit;
    end;
  end
  else
  if pgPageControl.ActivePage = tsPorSemanas then
  begin
    if Length(edtSemanaDesde.Text) <> 6 then
    begin
      if edtSemanaDesde.Enabled then
        edtSemanaDesde.SetFocus
      else
        edtPorSemanaDesde.SetFocus;
      ShowMessage('El año/semana debe tener 6 dígitos.');
      Exit;
    end;
    dDesde:= LunesAnyoSemana( edtSemanaDesde.Text );
    if Length(edtSemanaHasta.Text) <> 6 then
    begin
      if edtSemanaHasta.Enabled then
        edtSemanaHasta.SetFocus
      else
        edtPorSemanaHasta.SetFocus;
      ShowMessage('El año/semana debe tener 6 dígitos.');
      Exit;
    end;
    dHasta:= LunesAnyoSemana( edtSemanaHasta.Text ) + 6;
    if dDesde > dHasta then
    begin
      if edtSemanaDesde.Enabled then
        edtSemanaDesde.SetFocus
      else
        edtPorSemanaDesde.SetFocus;
      ShowMessage('Rango de año/semana incorrecto.');
      Exit;
    end;
  end
  else
  if pgPageControl.ActivePage = tsPorDias then
  begin
    if not TryStrToDate( edtPorDiaDesde.Text, dDesde ) then
    begin
      edtPorDiaDesde.SetFocus;
      ShowMessage('Fecha incorrecta.');
      Exit;
    end;
    if not TryStrToDate(edtPorDiaHasta.Text, dHasta ) then
    begin
      edtPorDiaHasta.SetFocus;
      ShowMessage('Fecha incorrecta.');
      Exit;
    end;
    if dDesde > dHasta then
    begin
      edtPorDiaDesde.SetFocus;
      ShowMessage('Rango de fechas incorrecto.');
      Exit;
    end;
  end;
  result := true;
end;

procedure TFLSalidasSuministro.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFLSalidasSuministro.btnAceptarClick(Sender: TObject);
begin
  lblEspere.Visible:= True;
  Application.ProcessMessages;

  if ValidarEntrada then
  begin
    Parametros.sEmpresa:= Trim( edtEmpresa.Text );
    Parametros.sCliente:= Trim( edtCliente.Text );
    Parametros.sSuministro:= Trim( edtSuministro.Text );

    // 1-total, 2-anual, 3-mensual, 4-semanal, 5-diaria, 6-albaran
    Parametros.iAgrupar:= pgPageControl.ActivePageIndex + 1;

    //Fechas rango actual
    Parametros.dFechaDesde:= dDesde;
    Parametros.dFechaHasta:= dHasta;

    Parametros.bPedidos:= ( Parametros.iAgrupar = 5 ) and chkPedido.checked;
    if Parametros.bPedidos then
      Parametros.iDiasPedidos:= StrToIntDef( edtDiasPedido.Text, 0)
    else
      Parametros.iDiasPedidos:= 0;

    if TButton( Sender ).Name = 'btnAceptar' then
      SalidasSuministroDL.ImprimirListado( Self, Parametros )
    else
      SalidasSuministroDL.GuardarCsv( Self, Parametros );
  end;

  lblEspere.Visible:= False;
end;

procedure TFLSalidasSuministro.edtEmpresaChange(Sender: TObject);
begin
  etqEmpresa.Caption:= desEmpresa( edtEmpresa.Text );
  if Length(edtEmpresa.Text) <> 3 then
  begin
    etqCliente.Caption:= desCliente( edtCliente.Text );
    etqSuministro.Caption:= desSuministro( '050', edtCliente.Text, edtSuministro.Text );
  end
  else
  begin
    etqCliente.Caption:= desCliente( edtCliente.Text );
    etqSuministro.Caption:= desSuministro( edtEmpresa.Text, edtCliente.Text, edtSuministro.Text );
  end;
end;

procedure TFLSalidasSuministro.edtClienteChange(Sender: TObject);
begin
  if Length(edtEmpresa.Text) <> 3 then
  begin
    etqCliente.Caption:= desCliente( edtCliente.Text );
    etqSuministro.Caption:= desSuministro( '050', edtCliente.Text, edtSuministro.Text );
  end
  else
  begin
    etqCliente.Caption:= desCliente( edtCliente.Text );
    etqSuministro.Caption:= desSuministro( edtEmpresa.Text, edtCliente.Text, edtSuministro.Text );
  end;
end;

procedure TFLSalidasSuministro.edtSuministroChange(Sender: TObject);
begin
  if Length(edtEmpresa.Text) <> 3 then
  begin
    etqSuministro.Caption:= desSuministro( '050', edtCliente.Text, edtSuministro.Text );
  end
  else
  begin
    etqSuministro.Caption:= desSuministro( edtEmpresa.Text, edtCliente.Text, edtSuministro.Text );
  end;
end;

procedure TFLSalidasSuministro.rbPorAnyoClick(Sender: TObject);
begin
  edtPorAnyoDesde.Enabled:= rbAnyo.Checked;
  edtPorAnyoHasta.Enabled:= rbAnyo.Checked;
  edtAnyoDesde.Enabled:= rbPorAnyo.Checked;
  edtAnyoHasta.Enabled:= rbPorAnyo.Checked;
  if edtPorAnyoDesde.Enabled then
  begin
    edtPorAnyoDesde.OnChange( edtPorAnyoDesde );
    edtPorAnyoHasta.OnChange( edtPorAnyoHasta );
  end
  else
  begin
    edtAnyoDesde.OnChange( edtAnyoDesde );
    edtAnyoHasta.OnChange( edtAnyoHasta );
  end;
end;

procedure TFLSalidasSuministro.rbPorMesClick(Sender: TObject);
begin
  edtPorMesDesde.Enabled:= rbMes.Checked;
  edtPorMesHasta.Enabled:= rbMes.Checked;
  edtMesDesde.Enabled:= rbPorMes.Checked;
  edtMesHasta.Enabled:= rbPorMes.Checked;
  if edtPorMesDesde.Enabled then
  begin
    edtPorMesDesde.OnChange( edtPorMesDesde );
    edtPorMesHasta.OnChange( edtPorMesHasta );
  end
  else
  begin
    edtMesDesde.OnChange( edtMesDesde );
    edtMesHasta.OnChange( edtMesHasta );
  end;
end;

procedure TFLSalidasSuministro.rbPorSemanaClick(Sender: TObject);
begin
  edtPorSemanaDesde.Enabled:= rbSemana.Checked;
  edtPorSemanaHasta.Enabled:= rbSemana.Checked;
  edtSemanaDesde.Enabled:= rbPorSemana.Checked;
  edtSemanaHasta.Enabled:= rbPorSemana.Checked;
  if edtPorSemanaDesde.Enabled then
  begin
    edtPorSemanaDesde.OnChange( edtPorSemanaDesde );
    edtPorSemanaHasta.OnChange( edtPorSemanaHasta );
  end
  else
  begin
    edtSemanaDesde.OnChange( edtSemanaDesde );
    edtSemanaHasta.OnChange( edtSemanaHasta );
  end;
end;

procedure TFLSalidasSuministro.edtSemanaDesdeChange(Sender: TObject);
begin
  if edtSemanaDesde.Enabled then
  begin
    if Length( Trim( edtSemanaDesde.Text ) ) = 6 then
    begin
      edtPorSemanaDesde.Text:= DateToStr( LunesAnyoSemana( edtSemanaDesde.Text ) );
    end
    else
    begin
      edtPorSemanaDesde.Text:= '';
    end;
  end;
end;

procedure TFLSalidasSuministro.edtSemanaHastaChange(Sender: TObject);
begin
  if edtSemanaHasta.Enabled then
  begin
    if Length( Trim( edtSemanaHasta.Text ) ) = 6 then
    begin
      edtPorSemanaHasta.Text:= DateToStr( LunesAnyoSemana( edtSemanaHasta.Text ) + 6 );
    end
    else
    begin
      edtPorSemanaHasta.Text:= '';
    end;
  end;
end;

procedure TFLSalidasSuministro.edtPorSemanaDesdeChange(Sender: TObject);
var
  dFecha: TDateTime;
begin
  if edtPorSemanaDesde.Enabled then
  begin
    if TryStrToDate( edtPorSemanaDesde.Text, dFecha ) then
    begin
      edtSemanaDesde.Text:= AnyoSemana( dFecha );
    end
    else
    begin
      edtSemanaDesde.Text:= '';
    end;
  end;
end;

procedure TFLSalidasSuministro.edtPorSemanaHastaChange(Sender: TObject);
var
  dFecha: TDateTime;
begin
  if edtPorSemanaHasta.Enabled then
  begin
    if TryStrToDate( edtPorSemanaHasta.Text, dFecha ) then
    begin
      edtSemanaHasta.Text:= AnyoSemana( dFecha );
    end
    else
    begin
      edtSemanaHasta.Text:= '';
    end;
  end;
end;


procedure TFLSalidasSuministro.edtMesDesdeChange(Sender: TObject);
begin
  if edtMesDesde.Enabled then
  begin
    if Length( Trim( edtMesDesde.Text ) ) = 6 then
    begin
      edtPorMesDesde.Text:= DateToStr( PrimerDiaAnyoMes( edtMesDesde.Text ) );
    end
    else
    begin
      edtPorMesDesde.Text:= '';
    end;
  end;
end;

procedure TFLSalidasSuministro.edtMesHastaChange(Sender: TObject);
begin
  if edtMesHasta.Enabled then
  begin
    if Length( Trim( edtMesHasta.Text ) ) = 6 then
    begin
      edtPorMesHasta.Text:= DateToStr( UltimoDiaAnyoMes( edtMesHasta.Text ) );
    end
    else
    begin
      edtPorMesHasta.Text:= '';
    end;
  end;
end;

procedure TFLSalidasSuministro.edtPorMesDesdeChange(Sender: TObject);
var
  dFecha: TDateTime;
begin
  if edtPorMesDesde.Enabled then
  begin
    if TryStrToDate( edtPorMesDesde.Text, dFecha ) then
    begin
      edtMesDesde.Text:= AnyoMes( dFecha );
    end
    else
    begin
      edtMesDesde.Text:= '';
    end;
  end;
end;

procedure TFLSalidasSuministro.edtPorMesHastaChange(Sender: TObject);
var
  dFecha: TDateTime;
begin
  if edtPorMesDesde.Enabled then
  begin
    if TryStrToDate( edtPorMesDesde.Text, dFecha ) then
    begin
      edtMesDesde.Text:= AnyoMes( dFecha );
    end
    else
    begin
      edtMesDesde.Text:= '';
    end;
  end;
end;

procedure TFLSalidasSuministro.edtAnyoDesdeChange(Sender: TObject);
begin
  if edtAnyoDesde.Enabled then
  begin
    if Length( Trim( edtAnyoDesde.Text ) ) = 4 then
    begin
      edtPorAnyoDesde.Text:= DateToStr( EncodeDate( StrToInt(edtAnyoDesde.Text), 1, 1 ) );
    end
    else
    begin
      edtPorAnyoDesde.Text:= '';
    end;
  end;
end;

procedure TFLSalidasSuministro.edtAnyoHastaChange(Sender: TObject);
begin
  if edtAnyoHasta.Enabled then
  begin
    if Length( Trim( edtAnyoHasta.Text ) ) = 4 then
    begin
      edtPorAnyoHasta.Text:= DateToStr( EncodeDate( StrToInt(edtAnyoHasta.Text), 12, 31 ) );
    end
    else
    begin
      edtPorAnyoHasta.Text:= '';
    end;
  end;
end;

procedure TFLSalidasSuministro.edtPorAnyoDesdeChange(Sender: TObject);
var
  dFecha: TDateTime;
begin
  if edtPorAnyoDesde.Enabled then
  begin
    if TryStrToDate( edtPorAnyoDesde.Text, dFecha ) then
    begin
      edtAnyoDesde.Text:= IntToStr( YearOf( dFecha ) );
    end
    else
    begin
      edtAnyoDesde.Text:= '';
    end;
  end;
end;

procedure TFLSalidasSuministro.edtPorAnyoHastaChange(Sender: TObject);
var
  dFecha: TDateTime;
begin
  if edtPorAnyoHasta.Enabled then
  begin
    if TryStrToDate( edtPorAnyoHasta.Text, dFecha ) then
    begin
      edtAnyoHasta.Text:= IntToStr( YearOf( dFecha ) );
    end
    else
    begin
      edtAnyoHasta.Text:= '';
    end;
  end;
end;

procedure TFLSalidasSuministro.chkPedidoClick(Sender: TObject);
begin
  edtDiasPedido.Enabled:= chkPedido.Checked;
end;

end.

