object FLEntradasSalidas: TFLEntradasSalidas
  Left = 399
  Top = 242
  Caption = '   ASIGNAR ENTRADA'
  ClientHeight = 278
  ClientWidth = 732
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object lblCentro: TLabel
    Left = 8
    Top = 218
    Width = 50
    Height = 18
    AutoSize = False
    Caption = ' Centro'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lbAlbaran: TLabel
    Left = 266
    Top = 218
    Width = 50
    Height = 18
    AutoSize = False
    Caption = ' Albar'#225'n'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lblFecha: TLabel
    Left = 395
    Top = 218
    Width = 50
    Height = 18
    AutoSize = False
    Caption = ' Fecha'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lblKilos: TLabel
    Left = 523
    Top = 218
    Width = 50
    Height = 18
    AutoSize = False
    Caption = ' Kilos'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lblDesCentro: TLabel
    Left = 92
    Top = 221
    Width = 168
    Height = 13
    AutoSize = False
    Caption = 'Des Centro'
  end
  object gridSalidas: TDBGrid
    Left = 0
    Top = 0
    Width = 732
    Height = 212
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
    OnCellClick = gridSalidasCellClick
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'empresa_sl'
        Title.Alignment = taCenter
        Title.Caption = 'Empresa'
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'centro_salida_sl'
        Title.Alignment = taCenter
        Title.Caption = 'Centro'
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'n_albaran_sl'
        Title.Alignment = taCenter
        Title.Caption = 'Salida'
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'fecha_sl'
        Title.Alignment = taCenter
        Title.Caption = 'Fecha'
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'centro_origen_sl'
        Title.Alignment = taCenter
        Title.Caption = 'Origen'
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'producto_sl'
        Title.Alignment = taCenter
        Title.Caption = 'Producto'
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'Cliente'
        Title.Alignment = taCenter
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'tipo'
        Title.Alignment = taCenter
        Title.Caption = 'Tipo'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'kilos_sl'
        Title.Alignment = taRightJustify
        Title.Caption = 'Kilos'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'kilos_pendientes'
        Title.Alignment = taRightJustify
        Title.Caption = 'Pendientes'
        Visible = True
      end>
  end
  object btnAceptar: TButton
    Left = 653
    Top = 220
    Width = 75
    Height = 25
    Caption = 'Aceptar'
    TabOrder = 1
    TabStop = False
    OnClick = btnAceptarClick
  end
  object btnCancelar: TButton
    Left = 653
    Top = 249
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 2
    TabStop = False
    OnClick = btnCancelarClick
  end
  object edtCentro: TBEdit
    Left = 64
    Top = 217
    Width = 25
    Height = 21
    ColorEdit = clBtnFace
    ColorNormal = clBtnFace
    ColorDisable = clBtnFace
    ReadOnly = True
    MaxLength = 1
    TabOrder = 3
    OnChange = edtCentroChange
  end
  object edtSalida: TBEdit
    Left = 320
    Top = 217
    Width = 70
    Height = 21
    ColorEdit = clBtnFace
    ColorNormal = clBtnFace
    ColorDisable = clBtnFace
    InputType = itInteger
    ReadOnly = True
    MaxLength = 6
    TabOrder = 4
  end
  object edtfecha: TBEdit
    Left = 448
    Top = 217
    Width = 70
    Height = 21
    ColorEdit = clBtnFace
    ColorNormal = clBtnFace
    ColorDisable = clBtnFace
    InputType = itDate
    ReadOnly = True
    TabOrder = 5
  end
  object edtKilos: TBEdit
    Left = 577
    Top = 217
    Width = 70
    Height = 21
    ColorEdit = clMoneyGreen
    ColorNormal = clMoneyGreen
    InputType = itReal
    MaxDecimals = 2
    MaxLength = 10
    TabOrder = 6
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
