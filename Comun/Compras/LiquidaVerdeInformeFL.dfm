object FLLiquidaVerdeInforme: TFLLiquidaVerdeInforme
  Left = 642
  Top = 220
  ActiveControl = edtAnyoSem
  Anchors = []
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '   LIQUIDACION ENTREGAS PLANTAS SIN RF'
  ClientHeight = 453
  ClientWidth = 401
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
    401
    453)
  PixelsPerInch = 96
  TextHeight = 13
  object btnCancelar: TSpeedButton
    Left = 275
    Top = 381
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
    ExplicitTop = 323
  end
  object lblEmpresa: TnbLabel
    Left = 37
    Top = 41
    Width = 119
    Height = 21
    Caption = 'A'#241'o/Semana'
    About = 'NB 0.1/20020725'
  end
  object lblEntrega: TnbLabel
    Left = 37
    Top = 133
    Width = 119
    Height = 21
    Caption = 'Entrega'
    About = 'NB 0.1/20020725'
  end
  object lblCodigo1: TnbLabel
    Left = 37
    Top = 17
    Width = 119
    Height = 21
    Caption = 'Empresa'
    About = 'NB 0.1/20020725'
  end
  object lblCodigo2: TnbLabel
    Left = 37
    Top = 65
    Width = 119
    Height = 21
    Caption = 'Proveedor'
    About = 'NB 0.1/20020725'
  end
  object lbl1: TLabel
    Left = 37
    Top = 162
    Width = 39
    Height = 13
    Caption = 'Margen '
  end
  object lbl3: TLabel
    Left = 39
    Top = 214
    Width = 92
    Height = 13
    Caption = 'Tte. Cliente M'#237'nimo'
  end
  object lbl4: TLabel
    Left = 39
    Top = 238
    Width = 99
    Height = 13
    Caption = 'Tte. Canario  M'#237'nimo'
  end
  object lbl5: TLabel
    Left = 39
    Top = 262
    Width = 119
    Height = 13
    Caption = 'Coste Envasado  M'#237'nimo'
  end
  object lblCodigo3: TnbLabel
    Left = 37
    Top = 87
    Width = 125
    Height = 21
    Caption = 'Productor'
    About = 'NB 0.1/20020725'
  end
  object lblCostesFinancieros: TLabel
    Left = 37
    Top = 188
    Width = 79
    Height = 13
    Caption = 'Coste Financiero'
  end
  object nbLabel1: TnbLabel
    Left = 37
    Top = 110
    Width = 125
    Height = 21
    Caption = 'Producto'
    About = 'NB 0.1/20020725'
  end
  object edtAnyoSem: TBEdit
    Left = 165
    Top = 41
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    Zeros = True
    InputType = itInteger
    MaxLength = 6
    TabOrder = 1
  end
  object edtEntrega: TBEdit
    Left = 165
    Top = 133
    Width = 99
    Height = 21
    ColorEdit = clMoneyGreen
    Zeros = True
    MaxLength = 12
    TabOrder = 4
  end
  object edtEmpresa: TBEdit
    Left = 165
    Top = 17
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    Zeros = True
    Enabled = False
    MaxLength = 3
    TabOrder = 0
  end
  object edtProveedor: TBEdit
    Left = 165
    Top = 65
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    Zeros = True
    InputType = itInteger
    MaxLength = 3
    TabOrder = 2
  end
  object btnValorarPalets: TButton
    Left = 200
    Top = 381
    Width = 75
    Height = 25
    Caption = 'Liquidar'
    TabOrder = 12
    OnClick = btnValorarPaletsClick
  end
  object chkVerPrecios: TCheckBox
    Left = 166
    Top = 285
    Width = 97
    Height = 17
    Caption = 'Ver Precios'
    Checked = True
    State = cbChecked
    TabOrder = 10
  end
  object edtMargen: TBEdit
    Left = 165
    Top = 158
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itReal
    MaxDecimals = 3
    MaxLength = 6
    TabOrder = 5
  end
  object chkProveedores: TCheckBox
    Left = 168
    Top = 305
    Width = 144
    Height = 17
    Caption = 'Ver Resumen Proveedor'
    TabOrder = 11
  end
  object edtMinimoTteCliente: TBEdit
    Left = 165
    Top = 210
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itReal
    MaxDecimals = 3
    MaxLength = 6
    TabOrder = 7
  end
  object edtMinimoTteCanario: TBEdit
    Left = 165
    Top = 234
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itReal
    MaxDecimals = 3
    MaxLength = 6
    TabOrder = 8
  end
  object edtMinimoCosteEnvasado: TBEdit
    Left = 165
    Top = 258
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itReal
    MaxDecimals = 3
    MaxLength = 6
    TabOrder = 9
  end
  object edtProductor: TBEdit
    Left = 165
    Top = 87
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    Zeros = True
    InputType = itInteger
    MaxLength = 3
    TabOrder = 3
  end
  object edtCostesFinancierosC: TBEdit
    Left = 165
    Top = 182
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itReal
    MaxDecimals = 3
    MaxLength = 6
    TabOrder = 6
  end
  object edtProducto: TBEdit
    Left = 165
    Top = 110
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    Zeros = True
    MaxLength = 3
    TabOrder = 13
  end
end
