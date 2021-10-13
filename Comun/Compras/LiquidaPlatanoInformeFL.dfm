object FLLiquidaPlatanoInforme: TFLLiquidaPlatanoInforme
  Left = 656
  Top = 247
  ActiveControl = edtAnyoSem
  Anchors = []
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '   LIQUIDACION ENTREGAS PL'#193'TANO'
  ClientHeight = 467
  ClientWidth = 571
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  DesignSize = (
    571
    467)
  PixelsPerInch = 96
  TextHeight = 13
  object btnCancelar: TSpeedButton
    Left = 418
    Top = 395
    Width = 89
    Height = 25
    Anchors = []
    Caption = 'Cerrar'
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000FF00FFBFFF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FFFFFF00FF00FF00FF00
      FF00FF00FF00FF00FF0000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00000000000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0000000000FFFFFF00FF00FFBFFF00FF00FF00
      FF00FF00FF00000000000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
      FF00FF00FF00FF00FF0000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00000000000000000000000000FFFFFF00FF00FFBFFF00
      FF00FF00FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FFFFFF00FF00
      FFBF0000000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
      000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000000000000000
      0000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
      000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FFFFFF00FF00
      FFBF00000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0000000000000000000000000000000000FFFFFF00FF00FFBFFF00
      FF00FF00FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00FFBFFF00
      FF0000000000000000000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
      FF00FF00FF00FF00FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
      FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF000000000000000000FFFFFF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
    ParentShowHint = False
    ShowHint = True
    OnClick = btnCancelarClick
    ExplicitLeft = 409
    ExplicitTop = 314
  end
  object lblEmpresa: TnbLabel
    Left = 29
    Top = 45
    Width = 105
    Height = 21
    Caption = 'A'#241'o/Semana'
    About = 'NB 0.1/20020725'
  end
  object lblEntrega: TnbLabel
    Left = 29
    Top = 141
    Width = 105
    Height = 21
    Caption = 'Entrega'
    About = 'NB 0.1/20020725'
  end
  object lblCodigo1: TnbLabel
    Left = 29
    Top = 18
    Width = 105
    Height = 21
    Caption = 'Empresa'
    About = 'NB 0.1/20020725'
  end
  object lblCodigo2: TnbLabel
    Left = 29
    Top = 69
    Width = 105
    Height = 21
    Caption = 'Proveedor'
    About = 'NB 0.1/20020725'
  end
  object lbl1: TLabel
    Left = 29
    Top = 169
    Width = 39
    Height = 13
    Caption = 'Margen '
  end
  object lblCostesFinancieros: TLabel
    Left = 29
    Top = 192
    Width = 90
    Height = 13
    Caption = 'Coste Finan. Carga'
  end
  object lblDesEmpresa: TLabel
    Left = 226
    Top = 22
    Width = 137
    Height = 13
    Caption = '(Plantas  F17, F23, F24, F42)'
  end
  object lbl3: TLabel
    Left = 29
    Top = 282
    Width = 92
    Height = 13
    Caption = 'Tte. Cliente M'#237'nimo'
  end
  object lbl4: TLabel
    Left = 29
    Top = 305
    Width = 99
    Height = 13
    Caption = 'Tte. Canario  M'#237'nimo'
  end
  object lbl5: TLabel
    Left = 29
    Top = 328
    Width = 119
    Height = 13
    Caption = 'Coste Envasado  M'#237'nimo'
  end
  object lblCodigo3: TnbLabel
    Left = 29
    Top = 93
    Width = 105
    Height = 21
    Caption = 'Productor'
    About = 'NB 0.1/20020725'
  end
  object btnEmpresa: TBGridButton
    Left = 200
    Top = 18
    Width = 13
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
      FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
      FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
      FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
      FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
      FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00000000BFFF00FF00FF00
      FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FFBFFF00FF00FF00FF00000000000000000000000000FF00
      FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FFBFFF00FF00000000000000000000000000000000000000
      00BFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
      000000000000FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
      FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
      FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
    OnClick = btnEmpresaClick
    Control = edtEmpresa
    Grid = RejillaFlotante
    GridAlignment = taDownRight
    GridWidth = 280
    GridHeigth = 100
  end
  object bvl1: TBevel
    Left = 343
    Top = 165
    Width = 142
    Height = 112
  end
  object lbl2: TLabel
    Left = 29
    Top = 216
    Width = 101
    Height = 13
    Caption = 'Coste Finan. Volcado'
  end
  object lbl6: TLabel
    Left = 30
    Top = 239
    Width = 26
    Height = 13
    Caption = 'Flete '
  end
  object nbLabel1: TnbLabel
    Left = 29
    Top = 117
    Width = 105
    Height = 21
    Caption = 'Producto'
    About = 'NB 0.1/20020725'
  end
  object edtAnyoSem: TBEdit
    Left = 137
    Top = 45
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    Zeros = True
    InputType = itInteger
    MaxLength = 6
    TabOrder = 1
  end
  object edtEntrega: TBEdit
    Left = 137
    Top = 141
    Width = 99
    Height = 21
    ColorEdit = clMoneyGreen
    Zeros = True
    MaxLength = 12
    TabOrder = 7
  end
  object edtEmpresa: TBEdit
    Left = 137
    Top = 18
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    Zeros = True
    MaxLength = 3
    TabOrder = 0
    OnChange = edtEmpresaChange
  end
  object edtProveedor: TBEdit
    Left = 137
    Top = 69
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    Zeros = True
    InputType = itInteger
    MaxLength = 3
    TabOrder = 2
  end
  object btnValorarPalets: TButton
    Left = 337
    Top = 395
    Width = 75
    Height = 25
    Caption = 'Liquidar'
    TabOrder = 19
    OnClick = btnValorarPaletsClick
  end
  object edtMargen: TBEdit
    Left = 138
    Top = 165
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itReal
    MaxDecimals = 3
    MaxLength = 6
    TabOrder = 8
  end
  object edtCostesFinancierosCargados: TBEdit
    Left = 138
    Top = 188
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itReal
    MaxDecimals = 3
    MaxLength = 6
    TabOrder = 10
  end
  object chkProveedores: TCheckBox
    Left = 344
    Top = 121
    Width = 144
    Height = 17
    Caption = 'Ver Resumen Proveedor'
    TabOrder = 5
  end
  object edtMinimoTteCliente: TBEdit
    Left = 138
    Top = 278
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itReal
    MaxDecimals = 3
    MaxLength = 6
    TabOrder = 16
  end
  object edtMinimoTteCanario: TBEdit
    Left = 138
    Top = 301
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itReal
    MaxDecimals = 3
    MaxLength = 6
    TabOrder = 17
  end
  object edtMinimoCosteEnvasado: TBEdit
    Left = 138
    Top = 324
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itReal
    MaxDecimals = 3
    MaxLength = 6
    TabOrder = 18
  end
  object edtProductor: TBEdit
    Left = 137
    Top = 93
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    Zeros = True
    MaxLength = 3
    TabOrder = 3
  end
  object chkClientes: TCheckBox
    Left = 344
    Top = 138
    Width = 144
    Height = 17
    Caption = 'Ver Resumen Clientes'
    TabOrder = 6
  end
  object chkDestrios: TCheckBox
    Left = 360
    Top = 184
    Width = 97
    Height = 17
    Caption = 'Ver Destrio'
    TabOrder = 9
  end
  object chkPlaceros: TCheckBox
    Left = 360
    Top = 207
    Width = 97
    Height = 17
    Caption = 'Ver Placero'
    TabOrder = 12
  end
  object chkCargados: TCheckBox
    Left = 360
    Top = 230
    Width = 120
    Height = 17
    Caption = 'Ver Carga Directa'
    TabOrder = 14
  end
  object chkVolcados: TCheckBox
    Left = 360
    Top = 253
    Width = 97
    Height = 17
    Caption = 'Ver Volcado'
    TabOrder = 15
  end
  object edtCostesFinancierosVolcado: TBEdit
    Left = 138
    Top = 212
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itReal
    MaxDecimals = 3
    MaxLength = 6
    TabOrder = 13
  end
  object RejillaFlotante: TBGrid
    Left = 482
    Top = 200
    Width = 137
    Height = 135
    Color = clInfoBk
    FixedColor = clInfoText
    Options = [dgTabs, dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 11
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
  end
  object chkFinancieroCarga: TCheckBox
    Left = 216
    Top = 192
    Width = 113
    Height = 17
    Caption = 'Excluir en compras'
    TabOrder = 20
  end
  object chkFinancieroVolcado: TCheckBox
    Left = 216
    Top = 216
    Width = 113
    Height = 17
    Caption = 'Excluir en compras'
    TabOrder = 21
  end
  object edtFlete: TBEdit
    Left = 138
    Top = 235
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itReal
    MaxDecimals = 3
    MaxLength = 6
    TabOrder = 22
  end
  object chkFlete: TCheckBox
    Left = 216
    Top = 239
    Width = 113
    Height = 17
    Caption = 'Excluir en Informe'
    Checked = True
    State = cbChecked
    TabOrder = 23
  end
  object edtProducto: TBEdit
    Left = 137
    Top = 117
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    Zeros = True
    MaxLength = 3
    TabOrder = 4
  end
end
