object FLLiquidaValoraCargaDirecta: TFLLiquidaValoraCargaDirecta
  Left = 661
  Top = 245
  Anchors = []
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    PRECIOS VENTA CARGA DIRECTA'
  ClientHeight = 265
  ClientWidth = 418
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
    418
    265)
  PixelsPerInch = 96
  TextHeight = 13
  object btnCancelar: TSpeedButton
    Left = 297
    Top = 219
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
    Left = 36
    Top = 104
    Width = 93
    Height = 21
    Caption = 'A'#241'o/Semana'
    About = 'NB 0.1/20020725'
  end
  object lblEntrega: TnbLabel
    Left = 36
    Top = 129
    Width = 93
    Height = 21
    Caption = 'Entrega'
    About = 'NB 0.1/20020725'
  end
  object lblCodigo1: TnbLabel
    Left = 36
    Top = 30
    Width = 93
    Height = 21
    Caption = 'Empresa'
    About = 'NB 0.1/20020725'
  end
  object lblCodigo2: TnbLabel
    Left = 36
    Top = 153
    Width = 93
    Height = 21
    Caption = 'Proveedor'
    About = 'NB 0.1/20020725'
  end
  object lblCodigo3: TnbLabel
    Left = 36
    Top = 178
    Width = 93
    Height = 21
    Caption = 'Productor'
    About = 'NB 0.1/20020725'
  end
  object lbl1: TnbLabel
    Left = 36
    Top = 79
    Width = 93
    Height = 21
    Caption = 'Fecha carga del'
    About = 'NB 0.1/20020725'
  end
  object lbl2: TnbLabel
    Left = 224
    Top = 79
    Width = 67
    Height = 21
    Caption = 'hasta'
    About = 'NB 0.1/20020725'
  end
  object stEmpresa: TnbStaticText
    Left = 196
    Top = 30
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
  end
  object stProveedor: TnbStaticText
    Left = 196
    Top = 153
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
  end
  object stProductor: TnbStaticText
    Left = 196
    Top = 178
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
  end
  object lblProducto: TnbLabel
    Left = 36
    Top = 55
    Width = 93
    Height = 21
    Caption = 'Producto'
    About = 'NB 0.1/20020725'
  end
  object stProducto: TnbStaticText
    Left = 196
    Top = 54
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
  end
  object edtAnyoSem: TBEdit
    Left = 132
    Top = 104
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    Zeros = True
    InputType = itInteger
    Enabled = False
    MaxLength = 6
    TabOrder = 5
  end
  object edtEntrega: TBEdit
    Left = 132
    Top = 129
    Width = 99
    Height = 21
    ColorEdit = clMoneyGreen
    Zeros = True
    Enabled = False
    MaxLength = 12
    TabOrder = 7
  end
  object edtEmpresa: TBEdit
    Left = 132
    Top = 30
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 3
    TabOrder = 0
    OnChange = edtEmpresaChange
  end
  object edtProveedor: TBEdit
    Left = 132
    Top = 153
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    Zeros = True
    InputType = itInteger
    MaxLength = 3
    TabOrder = 9
    OnChange = edtProveedorChange
  end
  object btnValorarPalets: TButton
    Left = 220
    Top = 219
    Width = 75
    Height = 25
    Caption = 'Precios Venta'
    TabOrder = 11
    OnClick = btnValorarPaletsClick
  end
  object edtProductor: TBEdit
    Left = 132
    Top = 178
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    Zeros = True
    InputType = itInteger
    MaxLength = 3
    TabOrder = 10
    OnChange = edtProductorChange
  end
  object dtpFechaIni: TnbDBCalendarCombo
    Left = 132
    Top = 79
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '24/08/2016'
    TabOrder = 2
  end
  object dtpFechaFin: TnbDBCalendarCombo
    Left = 296
    Top = 79
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '24/08/2016'
    TabOrder = 3
  end
  object rbFecha: TRadioButton
    Left = 16
    Top = 81
    Width = 20
    Height = 17
    Checked = True
    TabOrder = 4
    TabStop = True
    OnClick = rbFechaClick
  end
  object rbSemana: TRadioButton
    Left = 16
    Top = 106
    Width = 20
    Height = 17
    TabOrder = 6
    OnClick = rbSemanaClick
  end
  object rbEntrega: TRadioButton
    Left = 16
    Top = 131
    Width = 20
    Height = 17
    TabOrder = 8
    OnClick = rbEntregaClick
  end
  object edtProducto: TBEdit
    Left = 132
    Top = 54
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 3
    TabOrder = 1
    OnChange = edtProductoChange
  end
end
