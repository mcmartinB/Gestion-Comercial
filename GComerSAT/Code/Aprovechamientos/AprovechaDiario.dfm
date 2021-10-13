object FAprovechaDiario: TFAprovechaDiario
  Left = 315
  Top = 213
  ActiveControl = empresa
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    APROVECHAMIENTO DIARIO'
  ClientHeight = 328
  ClientWidth = 515
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
  object btnAceptar: TSpeedButton
    Left = 288
    Top = 272
    Width = 88
    Height = 25
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
    Left = 380
    Top = 272
    Width = 89
    Height = 25
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
  object nbLabel1: TnbLabel
    Left = 44
    Top = 35
    Width = 77
    Height = 21
    Caption = 'Empresa'
    About = 'NB 0.1/20020725'
  end
  object nbLabel2: TnbLabel
    Left = 44
    Top = 59
    Width = 77
    Height = 21
    Caption = 'Centro'
    About = 'NB 0.1/20020725'
  end
  object nbLabel3: TnbLabel
    Left = 44
    Top = 83
    Width = 77
    Height = 21
    Caption = 'Producto'
    About = 'NB 0.1/20020725'
  end
  object nbLabel4: TnbLabel
    Left = 44
    Top = 136
    Width = 77
    Height = 21
    Caption = 'Fecha'
    About = 'NB 0.1/20020725'
  end
  object nbLabel5: TnbLabel
    Left = 44
    Top = 160
    Width = 77
    Height = 21
    Caption = 'Cosechero'
    About = 'NB 0.1/20020725'
  end
  object nbLabel6: TnbLabel
    Left = 44
    Top = 184
    Width = 77
    Height = 21
    Caption = 'Plantaci'#243'n'
    About = 'NB 0.1/20020725'
  end
  object des_empresa: TnbStaticText
    Left = 159
    Top = 35
    Width = 190
    Height = 21
    Caption = 'des_empresa'
    About = 'NB 0.1/20020725'
  end
  object des_centro: TnbStaticText
    Left = 159
    Top = 59
    Width = 190
    Height = 21
    Caption = 'nbStaticText1'
    About = 'NB 0.1/20020725'
  end
  object des_producto: TnbStaticText
    Left = 159
    Top = 83
    Width = 190
    Height = 21
    Caption = 'nbStaticText1'
    About = 'NB 0.1/20020725'
  end
  object nbLabel7: TnbLabel
    Left = 125
    Top = 111
    Width = 65
    Height = 21
    Caption = 'Desde'
    About = 'NB 0.1/20020725'
  end
  object nbLabel8: TnbLabel
    Left = 192
    Top = 111
    Width = 65
    Height = 21
    Caption = 'Hasta'
    About = 'NB 0.1/20020725'
  end
  object lblPrimera: TLabel
    Left = 125
    Top = 215
    Width = 45
    Height = 13
    AutoSize = False
    Caption = 'Primera'
  end
  object lblSegunda: TLabel
    Left = 218
    Top = 215
    Width = 45
    Height = 13
    AutoSize = False
    Caption = 'Segunda'
  end
  object lblTercera: TLabel
    Left = 307
    Top = 215
    Width = 45
    Height = 13
    AutoSize = False
    Caption = 'Tercera'
  end
  object lblEscandallo: TnbLabel
    Left = 44
    Top = 211
    Width = 77
    Height = 21
    Caption = '% Escandallo'
    About = 'NB 0.1/20020725'
  end
  object lblDestrio: TLabel
    Left = 390
    Top = 215
    Width = 45
    Height = 13
    AutoSize = False
    Caption = 'Destr'#237'o'
  end
  object empresa: TBEdit
    Left = 125
    Top = 35
    Width = 33
    Height = 21
    ColorEdit = clMoneyGreen
    Zeros = True
    MaxLength = 3
    TabOrder = 0
    OnChange = empresaChange
  end
  object centro: TBEdit
    Left = 125
    Top = 59
    Width = 20
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 1
    TabOrder = 1
    OnChange = centroChange
  end
  object producto: TBEdit
    Left = 125
    Top = 83
    Width = 33
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 3
    TabOrder = 2
    OnChange = productoChange
  end
  object fecha_desde: TBEdit
    Left = 125
    Top = 136
    Width = 65
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itDate
    TabOrder = 3
  end
  object cosechero_desde: TBEdit
    Left = 125
    Top = 160
    Width = 29
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itInteger
    MaxLength = 3
    TabOrder = 5
  end
  object fecha_hasta: TBEdit
    Left = 192
    Top = 136
    Width = 65
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itDate
    TabOrder = 4
  end
  object cosechero_hasta: TBEdit
    Left = 192
    Top = 160
    Width = 29
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itInteger
    MaxLength = 3
    TabOrder = 6
  end
  object plantacion_desde: TBEdit
    Left = 125
    Top = 184
    Width = 29
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itInteger
    MaxLength = 3
    TabOrder = 7
  end
  object plantacion_hasta: TBEdit
    Left = 192
    Top = 184
    Width = 29
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itInteger
    MaxLength = 3
    TabOrder = 8
  end
  object desglose: TCheckBox
    Left = 44
    Top = 262
    Width = 140
    Height = 17
    Caption = 'Desglosar entradas'
    Checked = True
    State = cbChecked
    TabOrder = 14
  end
  object cbxTipoEntrada: TComboBox
    Left = 44
    Top = 238
    Width = 178
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 13
    Text = 'Todas las entradas'
    Items.Strings = (
      'Todas las entradas'
      'Producto Normal'
      'Producto Seleccionado'
      'Producto Industria'
      'Producto Sin ajustar')
  end
  object edtPrimera: TBEdit
    Left = 177
    Top = 211
    Width = 35
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itReal
    MaxDecimals = 2
    MaxLength = 6
    TabOrder = 9
  end
  object edtSegunda: TBEdit
    Left = 262
    Top = 211
    Width = 35
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itReal
    MaxDecimals = 2
    MaxLength = 6
    TabOrder = 10
  end
  object edtTErcera: TBEdit
    Left = 348
    Top = 211
    Width = 35
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itReal
    MaxDecimals = 2
    MaxLength = 6
    TabOrder = 11
  end
  object edtDestrio: TBEdit
    Left = 434
    Top = 211
    Width = 35
    Height = 21
    ColorEdit = clMoneyGreen
    InputType = itReal
    MaxDecimals = 2
    MaxLength = 6
    TabOrder = 12
  end
end
