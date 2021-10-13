object FLLiquidaValorarPalets: TFLLiquidaValorarPalets
  Left = 570
  Top = 247
  ActiveControl = edtAnyoSem
  Anchors = []
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    VALORAR PALETS'
  ClientHeight = 306
  ClientWidth = 302
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
    302
    306)
  PixelsPerInch = 96
  TextHeight = 13
  object btnCancelar: TSpeedButton
    Left = 184
    Top = 263
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
    Top = 60
    Width = 74
    Height = 21
    Caption = 'A'#241'o/Semana'
    About = 'NB 0.1/20020725'
  end
  object lblEntrega: TnbLabel
    Left = 29
    Top = 164
    Width = 74
    Height = 21
    Caption = 'Entrega'
    About = 'NB 0.1/20020725'
  end
  object lblCodigo1: TnbLabel
    Left = 29
    Top = 33
    Width = 74
    Height = 21
    Caption = 'Empresa'
    About = 'NB 0.1/20020725'
  end
  object lblCodigo2: TnbLabel
    Left = 29
    Top = 84
    Width = 74
    Height = 21
    Caption = 'Proveedor'
    About = 'NB 0.1/20020725'
  end
  object lblCodigo3: TnbLabel
    Left = 29
    Top = 110
    Width = 74
    Height = 21
    Caption = 'Productor'
    About = 'NB 0.1/20020725'
  end
  object nbLabel1: TnbLabel
    Left = 29
    Top = 137
    Width = 74
    Height = 21
    Caption = 'Producto'
    About = 'NB 0.1/20020725'
  end
  object edtAnyoSem: TBEdit
    Left = 108
    Top = 60
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    Zeros = True
    InputType = itInteger
    MaxLength = 6
    TabOrder = 1
  end
  object edtEntrega: TBEdit
    Left = 108
    Top = 164
    Width = 99
    Height = 21
    ColorEdit = clMoneyGreen
    Zeros = True
    MaxLength = 12
    TabOrder = 4
  end
  object edtEmpresa: TBEdit
    Left = 108
    Top = 33
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 3
    TabOrder = 0
  end
  object edtProveedor: TBEdit
    Left = 108
    Top = 84
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    Zeros = True
    InputType = itInteger
    MaxLength = 3
    TabOrder = 2
  end
  object btnValorarPalets: TButton
    Left = 105
    Top = 263
    Width = 75
    Height = 25
    Caption = 'Valorar Palets'
    TabOrder = 6
    OnClick = btnValorarPaletsClick
  end
  object chkVerPrecios: TCheckBox
    Left = 108
    Top = 192
    Width = 97
    Height = 17
    Caption = 'Ver Precios'
    Checked = True
    State = cbChecked
    TabOrder = 5
  end
  object edtProductor: TBEdit
    Left = 108
    Top = 110
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    Zeros = True
    InputType = itInteger
    MaxLength = 3
    TabOrder = 3
  end
  object edtProducto: TBEdit
    Left = 108
    Top = 137
    Width = 61
    Height = 21
    ColorEdit = clMoneyGreen
    Zeros = True
    MaxLength = 3
    TabOrder = 7
  end
end
