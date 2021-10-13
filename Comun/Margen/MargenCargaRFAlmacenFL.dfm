object FLMargenCargaRFAlmacen: TFLMargenCargaRFAlmacen
  Left = 366
  Top = 251
  Anchors = []
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '   VALORAR FRUTA PROVEEDOR - (En Desarrollo)'
  ClientHeight = 426
  ClientWidth = 572
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
  PixelsPerInch = 96
  TextHeight = 13
  object lblCodigo1: TnbLabel
    Left = 36
    Top = 121
    Width = 120
    Height = 21
    Caption = 'Fecha Desde'
    About = 'NB 0.1/20020725'
  end
  object lblDesEmpresa: TLabel
    Left = 228
    Top = 73
    Width = 137
    Height = 13
    Caption = '(Plantas  F17, F23, F24, F42)'
  end
  object btnEmpresa: TBGridButton
    Left = 201
    Top = 69
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
  object lblCodigo4: TnbLabel
    Left = 36
    Top = 146
    Width = 120
    Height = 21
    Caption = 'Coste Finan. Carga'
    About = 'NB 0.1/20020725'
  end
  object lblCodigo5: TnbLabel
    Left = 253
    Top = 120
    Width = 42
    Height = 21
    Caption = 'Hasta'
    About = 'NB 0.1/20020725'
  end
  object lblCodigo6: TnbLabel
    Left = 36
    Top = 69
    Width = 120
    Height = 21
    Caption = 'Empresa'
    About = 'NB 0.1/20020725'
  end
  object btnProducto: TBGridButton
    Left = 202
    Top = 93
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
    Control = edtProducto
    Grid = RejillaFlotante
    GridAlignment = taDownRight
    GridWidth = 280
    GridHeigth = 100
  end
  object lblCodigo7: TnbLabel
    Left = 36
    Top = 95
    Width = 120
    Height = 21
    Caption = 'Producto'
    About = 'NB 0.1/20020725'
  end
  object lblDesProducto: TLabel
    Left = 228
    Top = 97
    Width = 154
    Height = 13
    Caption = 'Por favor selecione un producto.'
  end
  object lblCodigo2: TnbLabel
    Left = 253
    Top = 146
    Width = 120
    Height = 21
    Caption = 'Coste Finan. Volcados'
    About = 'NB 0.1/20020725'
  end
  object lblCodigo3: TnbLabel
    Left = 36
    Top = 171
    Width = 120
    Height = 21
    Caption = 'A'#241'o/Semana (aaaamm)'
    About = 'NB 0.1/20020725'
  end
  object lblEntrega: TnbLabel
    Left = 36
    Top = 196
    Width = 120
    Height = 21
    Caption = 'Entrega'
    About = 'NB 0.1/20020725'
  end
  object lbl2: TLabel
    Left = 231
    Top = 175
    Width = 48
    Height = 13
    Caption = '(Opcional)'
  end
  object lbl3: TLabel
    Left = 260
    Top = 200
    Width = 48
    Height = 13
    Caption = '(Opcional)'
  end
  object lblCodigo8: TnbLabel
    Left = 36
    Top = 278
    Width = 120
    Height = 21
    Caption = 'Palets tr'#225'nsito'
    About = 'NB 0.1/20020725'
  end
  object mmo1: TMemo
    Left = 0
    Top = 311
    Width = 572
    Height = 115
    TabStop = False
    Align = alBottom
    Lines.Strings = (
      
        'STOCK -> palets con status S con fecha status del palet entre la' +
        's fechas seleccionada'
      
        'CARGA -> palets con status C con fecha carga de la orden asociad' +
        'a entre las fechas seleccionada'
      
        'VOLCADO -> palets con status V o R con fecha status del palet en' +
        'tre las fechas seleccionada'
      
        'DESTRIO -> palets con status D con fecha status del palet entre ' +
        'las fechas seleccionada'
      ''
      
        'NOTA: Para cada producto se debe exigir siempre las mismas condi' +
        'ciones para obtener datos coherentes.'
      
        'Distintas exigencias dan medias diferentes con importes parciale' +
        's diferentes.')
    ReadOnly = True
    TabOrder = 14
  end
  object edtEmpresa: TBEdit
    Left = 159
    Top = 69
    Width = 40
    Height = 21
    ColorEdit = clMoneyGreen
    Zeros = True
    MaxLength = 3
    TabOrder = 1
    OnChange = edtEmpresaChange
  end
  object btnMargen: TButton
    Left = 399
    Top = 276
    Width = 75
    Height = 25
    Caption = 'Margen'
    TabOrder = 12
    OnClick = btnMargenClick
  end
  object edtCostesFinancierosCargados: TBEdit
    Left = 159
    Top = 146
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itReal
    MaxDecimals = 3
    MaxLength = 6
    TabOrder = 5
  end
  object edtDesde: TnbDBCalendarCombo
    Left = 159
    Top = 120
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '26/04/2004'
    TabOrder = 3
  end
  object edtHasta: TnbDBCalendarCombo
    Left = 299
    Top = 120
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '26/04/2004'
    TabOrder = 4
  end
  object edtProducto: TBEdit
    Left = 158
    Top = 93
    Width = 40
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 3
    TabOrder = 2
    OnChange = edtProductoChange
  end
  object btnCancelar: TButton
    Left = 479
    Top = 275
    Width = 75
    Height = 25
    Caption = 'Cerrar'
    TabOrder = 11
    OnClick = btnCancelarClick
  end
  object pnlTipo: TPanel
    Left = 23
    Top = 15
    Width = 531
    Height = 42
    TabOrder = 0
    object Label1: TLabel
      Left = 353
      Top = 27
      Width = 58
      Height = 13
      Caption = '= C + V + D '
    end
    object rbStock: TRadioButton
      Left = 18
      Top = 12
      Width = 75
      Height = 17
      Caption = 'STOCK'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -8
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = rbStockClick
    end
    object rbCarga: TRadioButton
      Left = 89
      Top = 12
      Width = 75
      Height = 17
      Caption = 'CARGA'
      TabOrder = 1
      OnClick = rbStockClick
    end
    object rbVolcado: TRadioButton
      Left = 161
      Top = 12
      Width = 75
      Height = 17
      Caption = 'VOLCADOS'
      TabOrder = 2
      OnClick = rbStockClick
    end
    object rbDestrio: TRadioButton
      Left = 250
      Top = 12
      Width = 75
      Height = 17
      Caption = 'DESTRIO'
      TabOrder = 3
      OnClick = rbStockClick
    end
    object rbTodo: TRadioButton
      Left = 437
      Top = 12
      Width = 70
      Height = 17
      Caption = 'TODO'
      TabOrder = 5
      OnClick = rbStockClick
    end
    object rbConsumido: TRadioButton
      Left = 334
      Top = 12
      Width = 90
      Height = 17
      Caption = 'CONSUMIDO'
      Checked = True
      TabOrder = 4
      TabStop = True
      OnClick = rbStockClick
    end
  end
  object TPanel
    Left = 23
    Top = 226
    Width = 531
    Height = 42
    TabOrder = 10
    object lbl1: TLabel
      Left = 28
      Top = 14
      Width = 187
      Height = 13
      Caption = 'Exigir que coincida con los datos de RF'
    end
    object chkVariedad: TCheckBox
      Left = 221
      Top = 12
      Width = 90
      Height = 17
      Caption = 'VARIEDAD'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object chkCategoria: TCheckBox
      Left = 317
      Top = 12
      Width = 90
      Height = 17
      Caption = 'CATEGOR'#205'A'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object chkCalibre: TCheckBox
      Left = 413
      Top = 12
      Width = 90
      Height = 17
      Caption = 'CALIBRE'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
  end
  object edtCostesFinancierosVolcados: TBEdit
    Left = 376
    Top = 146
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itReal
    MaxDecimals = 3
    MaxLength = 6
    TabOrder = 6
  end
  object edtAnyoSemana: TBEdit
    Left = 159
    Top = 171
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itInteger
    MaxLength = 6
    TabOrder = 8
  end
  object edtEntrega: TBEdit
    Left = 159
    Top = 196
    Width = 90
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 12
    TabOrder = 9
  end
  object cbbVerTransitos: TComboBox
    Left = 159
    Top = 278
    Width = 226
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 13
    Text = 'No ver palets enviados'
    Items.Strings = (
      'No ver palets enviados'
      'Ver solo palets enviados'
      'Ver todos los palets (Ojo duplicados)')
  end
  object RejillaFlotante: TBGrid
    Left = 538
    Top = 146
    Width = 137
    Height = 135
    Color = clInfoBk
    FixedColor = clInfoText
    Options = [dgTabs, dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 7
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
  end
end
