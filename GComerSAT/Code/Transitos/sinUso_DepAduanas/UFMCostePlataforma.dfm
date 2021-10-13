object FMCostePlataforma: TFMCostePlataforma
  Left = 439
  Top = 222
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = '    COSTE PLATAFORMA'
  ClientHeight = 541
  ClientWidth = 976
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object bvl1: TBevel
    Left = 8
    Top = 8
    Width = 681
    Height = 42
  end
  object lblFecha: TLabel
    Left = 15
    Top = 20
    Width = 85
    Height = 19
    AutoSize = False
    Caption = ' Fecha Desde'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object btnFecha: TBCalendarButton
    Left = 186
    Top = 19
    Width = 17
    Height = 21
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F00FF00FF00FF00FF00FF00FF00FF00
      FF0000000000000000007F000000000000007F0000007F000000000000007F00
      000000000000000000007F0000007F7F7F00FF00FF007F7F7F00FF00FF00FF00
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF007F0000007F7F7F00FF00FF007F7F7F00FF00FF00FF00
      FF00FFFFFF00000000000000000000000000FFFFFF0000000000000000000000
      0000BFBFBF00FFFFFF007F0000007F7F7F00FF00FF007F7F7F00FF00FF00FF00
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00BFBFBF00FFFFFF00BFBF
      BF0000000000FFFFFF007F0000007F7F7F00FF00FF007F7F7F00FF00FF00FF00
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF007F0000007F7F7F00FF00FF007F7F7F00FF00FF00FF00
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000000000000000
      0000BFBFBF00FFFFFF007F0000007F7F7F00FF00FF007F7F7F00FF00FF00FF00
      FF00FFFFFF000000000000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF007F0000007F7F7F00FF00FF007F7F7F00FF00FF00FF00
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000000000000000
      000000000000FFFFFF007F0000007F7F7F00FF00FF007F7F7F00FF00FF00FF00
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF007F0000007F7F7F00FF00FF007F7F7F00FF00FF00FF00
      FF00FFFFFF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
      BF00BFBFBF00FFFFFF007F0000007F7F7F00FF00FF007F7F7F00FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF00FF00FF00FF00FF00FF007F7F7F00}
    OnClick = btnFechaClick
    Control = edtFecha
    Calendar = CalendarioFlotante
    CalendarAlignment = taCenterCenter
    CalendarWidth = 197
    CalendarHeigth = 153
  end
  object lblTransito: TLabel
    Left = 215
    Top = 20
    Width = 85
    Height = 19
    AutoSize = False
    Caption = ' Matr'#237'cula'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lblFactura: TLabel
    Left = 15
    Top = 54
    Width = 85
    Height = 19
    AutoSize = False
    Caption = ' Factura'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lblImporte: TLabel
    Left = 215
    Top = 54
    Width = 85
    Height = 19
    AutoSize = False
    Caption = ' Importe'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lbl1: TLabel
    Left = 826
    Top = 64
    Width = 143
    Height = 13
    Caption = 'ALBARANES DE SALIDA'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object lblSalidasDeposito: TLabel
    Left = 8
    Top = 362
    Width = 208
    Height = 13
    Caption = 'SALIDAS DEPOSITO MODIFICADAS'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object lbl3: TLabel
    Left = 776
    Top = 204
    Width = 193
    Height = 13
    Caption = 'SALIDAS FRUTA DEL DEPOSITO'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object edtFecha: TBEdit
    Left = 104
    Top = 19
    Width = 81
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itDate
    MaxLength = 10
    TabOrder = 3
  end
  object edtMatricula: TBEdit
    Left = 305
    Top = 19
    Width = 33
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itInteger
    MaxLength = 4
    TabOrder = 4
  end
  object dbgSalidasDeposito: TDBGrid
    Left = 8
    Top = 220
    Width = 961
    Height = 120
    Color = clInfoBk
    DataSource = DSSalidasDeposito
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 9
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = dbgSalidasDepositoDrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'carpeta'
        Title.Alignment = taCenter
        Title.Caption = 'Carpeta'
        Width = 53
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'empresa'
        Title.Alignment = taCenter
        Title.Caption = 'Empresa'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'centro'
        Title.Alignment = taCenter
        Title.Caption = 'Centro'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'albaran'
        Title.Alignment = taCenter
        Title.Caption = 'Albar'#225'n'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'fecha'
        Title.Alignment = taCenter
        Title.Caption = 'Fecha'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'operador'
        Title.Alignment = taCenter
        Title.Caption = 'Operador'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'transporte'
        Title.Alignment = taCenter
        Title.Caption = 'Transporte'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'vehiculo'
        Title.Alignment = taCenter
        Title.Caption = 'Veh'#237'culo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cmr'
        Title.Alignment = taCenter
        Title.Caption = 'CMR'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'pedido'
        Title.Alignment = taCenter
        Title.Caption = 'Pedido'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'kilos'
        Title.Alignment = taCenter
        Title.Caption = 'Kilos'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'importe'
        Title.Alignment = taCenter
        Title.Caption = 'Importe'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'factura'
        Title.Alignment = taCenter
        Title.Caption = 'Factura'
        Visible = True
      end>
  end
  object btnSalidas: TButton
    Left = 539
    Top = 17
    Width = 120
    Height = 25
    Caption = 'Buscar Salidas'
    TabOrder = 2
    OnClick = btnSalidasClick
  end
  object edtFactura: TBEdit
    Left = 104
    Top = 53
    Width = 100
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 10
    TabOrder = 5
  end
  object edtImporte: TBEdit
    Left = 305
    Top = 53
    Width = 103
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itReal
    MaxDecimals = 2
    MaxLength = 12
    TabOrder = 6
  end
  object dbgSalidas: TDBGrid
    Left = 8
    Top = 81
    Width = 961
    Height = 120
    Color = clInfoBk
    DataSource = DSSalidas
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 7
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = dbgSalidasCellClick
    OnDrawColumnCell = dbgSalidasDrawColumnCell
    OnKeyUp = dbgSalidasKeyUp
    Columns = <
      item
        Expanded = False
        FieldName = 'empresa'
        Title.Alignment = taCenter
        Title.Caption = 'Empresa'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'centro'
        Title.Alignment = taCenter
        Title.Caption = 'Centro'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'albaran'
        Title.Alignment = taCenter
        Title.Caption = 'Albar'#225'n'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'fecha'
        Title.Alignment = taCenter
        Title.Caption = 'Fecha'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'operador'
        Title.Alignment = taCenter
        Title.Caption = 'Operador'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'transporte'
        Title.Alignment = taCenter
        Title.Caption = 'Transporte'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'matricula'
        Title.Alignment = taCenter
        Title.Caption = 'Matricula'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cliente'
        Title.Alignment = taCenter
        Title.Caption = 'Cliente'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'palets'
        Title.Alignment = taCenter
        Title.Caption = 'Palets'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cajas'
        Title.Alignment = taCenter
        Title.Caption = 'Cajas'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'kilos'
        Title.Alignment = taCenter
        Title.Caption = 'Kilos'
        Visible = True
      end>
  end
  object btnAlta: TButton
    Left = 849
    Top = 347
    Width = 120
    Height = 25
    Caption = 'A'#241'adir Lineas'
    TabOrder = 10
    OnClick = btnAltaClick
  end
  object dbgCostePlataforma: TDBGrid
    Left = 8
    Top = 376
    Width = 961
    Height = 120
    Color = clSkyBlue
    DataSource = DSCostePlataforma
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 11
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'codigo_das'
        Title.Caption = 'C'#243'digo'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'linea_das'
        Title.Caption = 'Linea'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'empresa_das'
        Title.Caption = 'Empresa'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'centro_salida_das'
        Title.Caption = 'Centro'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'n_albaran_das'
        Title.Caption = 'Albar'#225'n'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'fecha_das'
        Title.Caption = 'Fecha'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'operador_transporte_das'
        Title.Caption = 'Operador'
        Width = 58
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'transporte_das'
        Title.Caption = 'Transporte'
        Width = 58
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'vehiculo_das'
        Title.Caption = 'Matr'#237'cula'
        Width = 89
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'n_cmr_das'
        Title.Caption = 'CMR'
        Width = 53
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'n_pedido_das'
        Title.Caption = 'N'#186'Pedido'
        Width = 71
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'kilos_das'
        Title.Caption = 'Kilos'
        Width = 56
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'frigorifico_das'
        Title.Caption = 'Importe'
        Width = 52
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'n_factura_das'
        Title.Caption = 'N'#186'Factura'
        Visible = True
      end>
  end
  object btnAplicar: TButton
    Left = 849
    Top = 502
    Width = 120
    Height = 25
    Caption = 'Aplicar'
    TabOrder = 13
    OnClick = btnAplicarClick
  end
  object btnCancelar: TButton
    Left = 727
    Top = 502
    Width = 120
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 12
    OnClick = btnCancelarClick
  end
  object btnCerrar: TButton
    Left = 849
    Top = 8
    Width = 120
    Height = 25
    Caption = 'Cerrar'
    TabOrder = 0
    OnClick = btnCerrarClick
  end
  object btnTransitos: TButton
    Left = 432
    Top = 17
    Width = 97
    Height = 16
    Caption = 'Buscar Tr'#225'nsitos'
    TabOrder = 1
    Visible = False
    OnClick = btnTransitosClick
  end
  object CalendarioFlotante: TBCalendario
    Left = -165
    Top = 96
    Width = 201
    Height = 153
    Date = 36717.687642963
    ShowToday = False
    TabOrder = 8
    Visible = False
    WeekNumbers = True
  end
  object DSSalidasDeposito: TDataSource
    DataSet = DMCostePlataforma.QSalidasDeposito
    Left = 128
    Top = 224
  end
  object DSSalidas: TDataSource
    DataSet = DMCostePlataforma.QSalidas
    Left = 120
    Top = 89
  end
  object DSCostePlataforma: TDataSource
    DataSet = DMCostePlataforma.mtSalidasDeposito
    Left = 128
    Top = 403
  end
end
