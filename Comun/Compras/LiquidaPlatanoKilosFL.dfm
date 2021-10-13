object FLLiquidaPlatanoKilos: TFLLiquidaPlatanoKilos
  Left = 711
  Top = 317
  ActiveControl = edtAnyoSem
  Anchors = []
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '   KILOS LIQUIDACION ENTREGAS'
  ClientHeight = 299
  ClientWidth = 377
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
    377
    299)
  PixelsPerInch = 96
  TextHeight = 13
  object btnCancelar: TSpeedButton
    Left = 266
    Top = 242
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
  end
  object lblEmpresa: TnbLabel
    Left = 29
    Top = 98
    Width = 74
    Height = 21
    Caption = 'A'#241'o/Semana'
    About = 'NB 0.1/20020725'
  end
  object lblEntrega: TnbLabel
    Left = 29
    Top = 171
    Width = 74
    Height = 21
    Caption = 'Entrega'
    About = 'NB 0.1/20020725'
  end
  object lblCodigo1: TnbLabel
    Left = 29
    Top = 48
    Width = 74
    Height = 21
    Caption = 'Empresa'
    About = 'NB 0.1/20020725'
  end
  object lblCodigo2: TnbLabel
    Left = 29
    Top = 122
    Width = 74
    Height = 21
    Caption = 'Proveedor'
    About = 'NB 0.1/20020725'
  end
  object lblDesPlanta: TLabel
    Left = 181
    Top = 52
    Width = 137
    Height = 13
    Caption = '(Plantas  F17, F23, F24, F42)'
  end
  object lblCodigo3: TnbLabel
    Left = 29
    Top = 24
    Width = 74
    Height = 21
    Caption = 'Agrupar por'
    About = 'NB 0.1/20020725'
  end
  object lblProducto: TnbLabel
    Left = 29
    Top = 73
    Width = 74
    Height = 21
    Caption = 'Producto'
    About = 'NB 0.1/20020725'
  end
  object lblCategoria: TnbLabel
    Left = 29
    Top = 146
    Width = 74
    Height = 21
    Caption = 'Categoria'
    About = 'NB 0.1/20020725'
  end
  object lblDesProducto: TLabel
    Left = 181
    Top = 77
    Width = 137
    Height = 13
    Caption = '(Plantas  F17, F23, F24, F42)'
  end
  object lblDesProveedor: TLabel
    Left = 181
    Top = 126
    Width = 137
    Height = 13
    Caption = '(Plantas  F17, F23, F24, F42)'
  end
  object lblDesCategoria: TLabel
    Left = 181
    Top = 150
    Width = 137
    Height = 13
    Caption = '(Plantas  F17, F23, F24, F42)'
  end
  object edtAnyoSem: TBEdit
    Left = 108
    Top = 98
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    Zeros = True
    InputType = itInteger
    MaxLength = 6
    TabOrder = 4
  end
  object edtEntrega: TBEdit
    Left = 108
    Top = 171
    Width = 99
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 12
    TabOrder = 7
  end
  object edtEmpresa: TBEdit
    Left = 108
    Top = 48
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    Zeros = True
    MaxLength = 3
    TabOrder = 2
    OnChange = edtEmpresaChange
  end
  object edtProveedor: TBEdit
    Left = 108
    Top = 122
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itInteger
    MaxLength = 3
    TabOrder = 5
    OnChange = edtProveedorChange
  end
  object btnValorarPalets: TButton
    Left = 186
    Top = 244
    Width = 75
    Height = 25
    Caption = 'Ver Kilos'
    TabOrder = 10
    OnClick = btnValorarPaletsClick
  end
  object chkVerEntrega: TCheckBox
    Left = 109
    Top = 199
    Width = 144
    Height = 17
    Caption = 'Ver entrega'
    Checked = True
    State = cbChecked
    TabOrder = 8
  end
  object rbProveedor: TRadioButton
    Left = 108
    Top = 26
    Width = 113
    Height = 17
    Caption = 'Proveedor'
    Checked = True
    TabOrder = 0
    TabStop = True
  end
  object rbCategorias: TRadioButton
    Left = 227
    Top = 26
    Width = 138
    Height = 17
    Caption = 'Categorias y Variedad'
    TabOrder = 1
  end
  object edtProducto: TBEdit
    Left = 108
    Top = 73
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 3
    TabOrder = 3
    OnChange = edtProductoChange
  end
  object edtCategoria: TBEdit
    Left = 108
    Top = 146
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itInteger
    MaxLength = 3
    TabOrder = 6
    OnChange = edtCategoriaChange
  end
  object chkPlantas: TCheckBox
    Left = 109
    Top = 217
    Width = 144
    Height = 17
    Caption = 'Separar plantas'
    Checked = True
    State = cbChecked
    TabOrder = 9
  end
end
