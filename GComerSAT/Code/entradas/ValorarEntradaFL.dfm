object FLValorarEntrada: TFLValorarEntrada
  Left = 429
  Top = 270
  Width = 788
  Height = 313
  Caption = '   ENTREGA VALORADA'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lblLiquidacion: TLabel
    Left = 428
    Top = 190
    Width = 100
    Height = 16
    Caption = 'LIQUIDACI'#211'N:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object gridSalidas: TDBGrid
    Left = 0
    Top = 0
    Width = 780
    Height = 185
    TabStop = False
    Align = alTop
    DataSource = dsSalidas
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'empresa_es'
        Title.Alignment = taCenter
        Title.Caption = 'Empresa'
        Width = 45
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'centro_salida_es'
        Title.Alignment = taCenter
        Title.Caption = 'Centro'
        Width = 45
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'n_salida_es'
        Title.Alignment = taCenter
        Title.Caption = 'Salida'
        Width = 45
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'fecha_salida_es'
        Title.Alignment = taCenter
        Title.Caption = 'Fecha'
        Width = 60
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'producto_es'
        Title.Alignment = taCenter
        Title.Caption = 'Producto'
        Width = 45
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'kilos_es'
        Title.Alignment = taRightJustify
        Title.Caption = 'Kilos'
        Width = 60
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'importe_es'
        Title.Alignment = taRightJustify
        Title.Caption = 'Importe'
        Width = 60
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'descuento_es'
        Title.Alignment = taRightJustify
        Title.Caption = 'Descuento'
        Width = 60
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'gasto_es'
        Title.Alignment = taRightJustify
        Title.Caption = 'Gasto'
        Width = 60
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'abono_es'
        Title.Alignment = taRightJustify
        Title.Caption = 'Abonos'
        Width = 60
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'envasado_es'
        Title.Alignment = taRightJustify
        Title.Caption = 'Envasado'
        Width = 60
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'otros_es'
        Title.Alignment = taRightJustify
        Title.Caption = 'Otros'
        Width = 60
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'liquida_es'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Title.Alignment = taRightJustify
        Title.Caption = 'Liquidar'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 60
        Visible = True
      end>
  end
  object btnAceptar: TButton
    Left = 615
    Top = 241
    Width = 75
    Height = 25
    Caption = 'Valorar'
    TabOrder = 6
    TabStop = False
    OnClick = btnAceptarClick
  end
  object btnCancelar: TButton
    Left = 694
    Top = 241
    Width = 75
    Height = 25
    Caption = 'Cerrar'
    TabOrder = 7
    TabStop = False
    OnClick = btnCancelarClick
  end
  object rbInformtiva: TRadioButton
    Left = 428
    Top = 209
    Width = 80
    Height = 17
    Caption = 'Informativa'
    Checked = True
    TabOrder = 2
    TabStop = True
  end
  object rbDefinitiva: TRadioButton
    Left = 510
    Top = 209
    Width = 80
    Height = 17
    Caption = 'Definitiva'
    TabOrder = 3
  end
  object chkRevalorar: TCheckBox
    Left = 428
    Top = 227
    Width = 112
    Height = 17
    Caption = 'Revalorar entrada'
    TabOrder = 5
    OnClick = chkRevalorarClick
  end
  object dbmmoNotas: TDBMemo
    Left = 0
    Top = 185
    Width = 409
    Height = 88
    DataField = 'nota_liquidacion_ec'
    DataSource = dsSalidas
    TabOrder = 1
  end
  object chkUsarCostesUltimoMes: TCheckBox
    Left = 591
    Top = 209
    Width = 180
    Height = 17
    Caption = 'Usar Costes Ultimo Mes Grabado'
    TabOrder = 4
  end
  object qrySalidas: TQuery
    DatabaseName = 'BDProyecto'
    Left = 91
    Top = 47
  end
  object dsSalidas: TDataSource
    DataSet = qrySalidas
    Left = 123
    Top = 48
  end
end
