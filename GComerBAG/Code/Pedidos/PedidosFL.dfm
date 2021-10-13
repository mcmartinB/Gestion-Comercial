object FLPedidos: TFLPedidos
  Left = 468
  Top = 226
  ActiveControl = edtEmpresa
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    LISTADO DE PEDIDOS'
  ClientHeight = 218
  ClientWidth = 466
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
    466
    218)
  PixelsPerInch = 96
  TextHeight = 13
  object btnAceptar: TSpeedButton
    Left = 276
    Top = 180
    Width = 88
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Listado'
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF000000FF0000000000FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF000000FF000000FFBF0000FF00000000BFFF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF000000FF000000FFBF0000FF00000000BFFF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF000000FF000000FF000000FFBF0000FF000000FFBF00000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF000000FF000000FFBF0000FF000000FFBF0000FF000000FFBF00000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007F7F
      7F000000FF3F0000FFBF00000000FF00FF000000FF000000FFBF0000FF000000
      00BFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007F7F7F000000
      FF3F00000000FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000
      00BFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000
      FFBF00000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF000000
      FFBF00000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
      FF000000FF00000000BFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF007F7F7F000000FF3F00000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF007F7F7F000000FF3F000000BFFF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF000000FF000000FF00000000BFFF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
    ParentShowHint = False
    ShowHint = True
    OnClick = btnAceptarClick
  end
  object btnCancelar: TSpeedButton
    Left = 367
    Top = 180
    Width = 89
    Height = 25
    Anchors = [akRight, akBottom]
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
    Left = 44
    Top = 27
    Width = 97
    Height = 21
    Caption = 'Empresa'
    About = 'NB 0.1/20020725'
  end
  object etqEmpresa: TnbStaticText
    Left = 179
    Top = 27
    Width = 238
    Height = 21
    About = 'NB 0.1/20020725'
  end
  object lblFechaDesde: TnbLabel
    Left = 44
    Top = 79
    Width = 97
    Height = 21
    Caption = 'Fecha del'
    About = 'NB 0.1/20020725'
  end
  object lblFechaHasta: TnbLabel
    Left = 212
    Top = 79
    Width = 52
    Height = 21
    Caption = 'al'
    About = 'NB 0.1/20020725'
  end
  object nbLabel1: TnbLabel
    Left = 44
    Top = 53
    Width = 97
    Height = 21
    Caption = 'Centro'
    About = 'NB 0.1/20020725'
  end
  object etqCentro: TnbStaticText
    Left = 179
    Top = 53
    Width = 238
    Height = 21
    About = 'NB 0.1/20020725'
  end
  object nbLabel2: TnbLabel
    Left = 44
    Top = 129
    Width = 97
    Height = 21
    Caption = 'Cliente'
    About = 'NB 0.1/20020725'
  end
  object etqCliente: TnbStaticText
    Left = 179
    Top = 129
    Width = 238
    Height = 21
    About = 'NB 0.1/20020725'
  end
  object nbLabel3: TnbLabel
    Left = 44
    Top = 155
    Width = 97
    Height = 21
    Caption = 'Dir. Suministro'
    About = 'NB 0.1/20020725'
  end
  object etqDirSum: TnbStaticText
    Left = 179
    Top = 155
    Width = 238
    Height = 21
    About = 'NB 0.1/20020725'
  end
  object nbLabel4: TnbLabel
    Left = 44
    Top = 105
    Width = 97
    Height = 21
    Caption = 'Producto'
    About = 'NB 0.1/20020725'
  end
  object etqProducto: TnbStaticText
    Left = 179
    Top = 105
    Width = 238
    Height = 21
    About = 'NB 0.1/20020725'
  end
  object edtEmpresa: TBEdit
    Left = 144
    Top = 27
    Width = 32
    Height = 21
    ColorEdit = clMoneyGreen
    Zeros = True
    MaxLength = 3
    TabOrder = 0
    OnChange = edtEmpresaChange
  end
  object edtFechaDesde: TBEdit
    Left = 144
    Top = 79
    Width = 65
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itDate
    TabOrder = 2
  end
  object edtFechaHasta: TBEdit
    Left = 266
    Top = 79
    Width = 65
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itDate
    TabOrder = 3
  end
  object edtCentro: TBEdit
    Left = 144
    Top = 53
    Width = 17
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 1
    TabOrder = 1
    OnChange = edtCentroChange
  end
  object edtCliente: TBEdit
    Left = 144
    Top = 129
    Width = 32
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 3
    TabOrder = 5
    OnChange = edtClienteChange
  end
  object edtDirSum: TBEdit
    Left = 144
    Top = 155
    Width = 32
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 3
    TabOrder = 6
    OnChange = edtDirSumChange
  end
  object edtProducto: TBEdit
    Left = 144
    Top = 105
    Width = 32
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 3
    TabOrder = 4
    OnChange = edtProductoChange
  end
  object cbxNotas: TCheckBox
    Left = 48
    Top = 184
    Width = 169
    Height = 17
    Caption = 'Ver Observaciones'
    TabOrder = 7
  end
end
