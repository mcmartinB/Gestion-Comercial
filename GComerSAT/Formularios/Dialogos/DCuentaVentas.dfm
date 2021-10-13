object FDCuentaVentas: TFDCuentaVentas
  Left = 386
  Top = 287
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    CUENTAS DE VENTAS'
  ClientHeight = 287
  ClientWidth = 633
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 633
    Height = 41
    Align = alTop
    TabOrder = 0
    object sbAceptar: TSpeedButton
      Left = 16
      Top = 8
      Width = 97
      Height = 22
      Action = AAceptar
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF000000FF0000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF000000FF000000FF000000FF0000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF000000FF000000FF000000FF0000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF000000FF000000FF000000FF000000FF000000FF0000000000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF000000FF000000FF000000FF000000FF000000FF000000FF0000000000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007B7B
        7B000000FF000000FF0000000000FF00FF000000FF000000FF000000FF000000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007B7B7B000000
        FF0000000000FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000
        FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF000000
        FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
        FF000000FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF007B7B7B000000FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF007B7B7B000000FF0000000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF000000FF000000FF0000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
    end
    object sbCancelar: TSpeedButton
      Left = 120
      Top = 8
      Width = 97
      Height = 22
      Action = ACancelar
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FFFFFF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000FFFFFF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00000000000000000000000000FFFFFF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0000000000FFFFFF00FF00FF00FF00FF00FF00
        FF00FF00FF00000000000000000000000000FFFFFF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000FFFFFF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00000000000000000000000000FFFFFF00FF00FF00FF00
        FF00FF00FF000000000000000000FFFFFF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FFFFFF00FF00
        FF000000000000000000FFFFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
        000000000000FFFFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000000000000000
        0000FFFFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
        000000000000FFFFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FFFFFF00FF00
        FF0000000000FFFFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000000000000000000000000000FFFFFF00FF00FF00FF00
        FF00FF00FF000000000000000000FFFFFF00FF00FF00FF00FF00FF00FF00FF00
        FF0000000000000000000000000000000000FFFFFF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF000000000000000000FFFFFF00FF00FF00FF00FF00FF00
        FF000000000000000000FFFFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF000000000000000000FFFFFF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      ParentShowHint = False
      ShowHint = True
    end
    object Panel2: TPanel
      Left = 345
      Top = 0
      Width = 265
      Height = 40
      BorderStyle = bsSingle
      Enabled = False
      TabOrder = 0
      object Label1: TLabel
        Left = 25
        Top = 8
        Width = 89
        Height = 21
        AutoSize = False
        Caption = '  Total Neto'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Total: TBEdit
        Left = 118
        Top = 8
        Width = 121
        Height = 21
        TabOrder = 0
      end
    end
  end
  object Grid: TDBGrid
    Left = 0
    Top = 41
    Width = 633
    Height = 246
    Align = alClient
    DataSource = DataSource
    DefaultDrawing = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnColEnter = GridColEnter
    OnDrawColumnCell = GridDrawColumnCell
    OnEnter = GridColEnter
    OnKeyDown = GridKeyDown
    OnKeyPress = GridKeyPress
    Columns = <
      item
        Expanded = False
        FieldName = 'producto_cv'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'Producto'
        Width = 127
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'envase_cv'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'Envase'
        Width = 132
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'marca_cv'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'Marca'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'calibre_cv'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'Calib.'
        Width = 31
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'color_cv'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'Color'
        Width = 27
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cajas_cv'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'Cajas'
        Width = 56
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'kilos_cv'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'Kilos'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'neto_cv'
        Title.Alignment = taCenter
        Title.Caption = 'Importe'
        Width = 67
        Visible = True
      end>
  end
  object ActionList1: TActionList
    Images = DMBaseDatos.ImgBotones
    Left = 56
    Top = 176
    object AMinimizar: TAction
      Hint = 'Minimiza aplicaci'#243'n'
      ImageIndex = 6
      OnExecute = AMinimizarExecute
    end
    object AAceptar: TAction
      Caption = 'Aceptar'
      Hint = 'Acepta operaciones realizadas y cierra el formulario.'
      ImageIndex = 1
      ShortCut = 112
      OnExecute = AAceptarExecute
    end
    object ACancelar: TAction
      Caption = 'Cancelar'
      Hint = 'Cancela operaciones realizadas y cierra el formulario.'
      ImageIndex = 2
      ShortCut = 27
      OnExecute = ACancelarExecute
    end
  end
  object Table: TTable
    AfterPost = TableAfterPost
    DatabaseName = 'BDProyecto'
    TableName = 'tmp_cuenta_ventas'
    Left = 56
    Top = 208
    object Tableusuario_cv: TStringField
      FieldName = 'usuario_cv'
      Size = 8
    end
    object Tableempresa_cv: TStringField
      FieldName = 'empresa_cv'
      Size = 3
    end
    object Tablen_albaran_cv: TIntegerField
      FieldName = 'n_albaran_cv'
    end
    object Tablefecha_sl: TDateField
      FieldName = 'fecha_sl'
    end
    object Tableunidad_fac_cv: TStringField
      FieldName = 'unidad_fac_cv'
      Size = 3
    end
    object Tablecentro_cv: TStringField
      FieldName = 'centro_cv'
      Size = 1
    end
    object Tableproducto_cv: TStringField
      FieldName = 'producto_cv'
      Size = 1
    end
    object Tableenvase_cv: TStringField
      FieldName = 'envase_cv'
      Size = 3
    end
    object Tablemarca_cv: TStringField
      FieldName = 'marca_cv'
      Size = 2
    end
    object Tablecalibre_cv: TStringField
      FieldName = 'calibre_cv'
      Size = 6
    end
    object Tablecolor_cv: TStringField
      FieldName = 'color_cv'
      Size = 1
    end
    object Tablecajas_cv: TIntegerField
      FieldName = 'cajas_cv'
    end
    object Tableunidades_cv: TIntegerField
      FieldName = 'unidades_cv'
    end
    object Tablekilos_cv: TFloatField
      FieldName = 'kilos_cv'
    end
    object Tableneto_cv: TFloatField
      FieldName = 'neto_cv'
    end
  end
  object DataSource: TDataSource
    DataSet = Table
    Left = 88
    Top = 208
  end
  object QLineas: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      
        'SELECT empresa_sl, centro_salida_sl, n_albaran_sl, fecha_sl, cen' +
        'tro_origen_sl, producto_sl, envase_sl, marca_sl, categoria_sl, c' +
        'alibre_sl, color_sl, ref_transitos_sl, cajas_sl, kilos_sl, preci' +
        'o_sl, unidad_precio_sl, importe_neto_sl, porc_iva_sl, iva_sl, im' +
        'porte_total_sl, tipo_iva_sl'
      'FROM frf_salidas_l '
      'where empresa_sl=:empresa '
      ' and centro_salida_sl=:centro '
      ' and n_albaran_sl=:albaran '
      ' and fecha_sl=:fecha ')
    UpdateObject = UpdateLineas
    Left = 248
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'empresa'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'centro'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'albaran'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fecha'
        ParamType = ptUnknown
      end>
    object QLineasempresa_sl: TStringField
      FieldName = 'empresa_sl'
      Origin = 'frf_salidas_l.empresa_sl'
      Size = 3
    end
    object QLineascentro_salida_sl: TStringField
      FieldName = 'centro_salida_sl'
      Origin = 'frf_salidas_l.centro_salida_sl'
      Size = 1
    end
    object QLineasn_albaran_sl: TIntegerField
      FieldName = 'n_albaran_sl'
      Origin = 'frf_salidas_l.n_albaran_sl'
    end
    object QLineasfecha_sl: TDateField
      FieldName = 'fecha_sl'
      Origin = 'frf_salidas_l.fecha_sl'
    end
    object QLineascentro_origen_sl: TStringField
      FieldName = 'centro_origen_sl'
      Origin = 'frf_salidas_l.centro_origen_sl'
      Size = 1
    end
    object QLineasproducto_sl: TStringField
      DisplayWidth = 3
      FieldName = 'producto_sl'
      Origin = 'frf_salidas_l.producto_sl'
      Size = 3
    end
    object QLineasenvase_sl: TStringField
      FieldName = 'envase_sl'
      Origin = 'frf_salidas_l.envase_sl'
      Size = 3
    end
    object QLineasmarca_sl: TStringField
      FieldName = 'marca_sl'
      Origin = 'frf_salidas_l.marca_sl'
      Size = 2
    end
    object QLineascategoria_sl: TStringField
      FieldName = 'categoria_sl'
      Origin = 'frf_salidas_l.categoria_sl'
      Size = 2
    end
    object QLineascalibre_sl: TStringField
      FieldName = 'calibre_sl'
      Origin = 'frf_salidas_l.calibre_sl'
      Size = 6
    end
    object QLineascolor_sl: TStringField
      FieldName = 'color_sl'
      Origin = 'frf_salidas_l.color_sl'
      Size = 1
    end
    object QLineasref_transitos_sl: TIntegerField
      FieldName = 'ref_transitos_sl'
      Origin = 'frf_salidas_l.ref_transitos_sl'
    end
    object QLineascajas_sl: TIntegerField
      FieldName = 'cajas_sl'
      Origin = 'frf_salidas_l.cajas_sl'
    end
    object QLineasunidades_caja_sl: TIntegerField
      FieldName = 'unidades_caja_sl'
      Origin = 'frf_salidas_l.unidades_caja_sl'
    end
    object QLineaskilos_sl: TFloatField
      FieldName = 'kilos_sl'
      Origin = 'frf_salidas_l.kilos_sl'
    end
    object QLineasprecio_sl: TFloatField
      FieldName = 'precio_sl'
      Origin = 'frf_salidas_l.precio_sl'
    end
    object QLineasunidad_precio_sl: TStringField
      FieldName = 'unidad_precio_sl'
      Origin = 'frf_salidas_l.unidad_precio_sl'
      Size = 3
    end
    object QLineasimporte_neto_sl: TFloatField
      FieldName = 'importe_neto_sl'
      Origin = 'frf_salidas_l.importe_neto_sl'
    end
    object QLineasporc_iva_sl: TFloatField
      FieldName = 'porc_iva_sl'
      Origin = 'frf_salidas_l.porc_iva_sl'
    end
    object QLineasiva_sl: TFloatField
      FieldName = 'iva_sl'
      Origin = 'frf_salidas_l.iva_sl'
    end
    object QLineasimporte_total_sl: TFloatField
      FieldName = 'importe_total_sl'
      Origin = 'frf_salidas_l.importe_total_sl'
    end
    object QLineastipo_iva_sl: TStringField
      FieldName = 'tipo_iva_sl'
      Origin = 'frf_salidas_l.tipo_iva_sl'
      Size = 2
    end
  end
  object UpdateLineas: TUpdateSQL
    ModifySQL.Strings = (
      'update frf_salidas_l'
      'set'
      '  precio_sl = :precio_sl,'
      '  importe_neto_sl = :importe_neto_sl,'
      '  iva_sl = :iva_sl,'
      '  importe_total_sl = :importe_total_sl,'
      'where'
      '  empresa_sl = :OLD_empresa_sl and'
      '  centro_salida_sl = :OLD_centro_salida_sl and'
      '  n_albaran_sl = :OLD_n_albaran_sl and'
      '  fecha_sl = :OLD_fecha_sl and'
      '  centro_origen_sl = :OLD_centro_origen_sl and'
      '  producto_sl = :OLD_producto_sl and'
      '  envase_sl = :OLD_envase_sl and'
      '  marca_sl = :OLD_marca_sl and'
      '  categoria_sl = :OLD_categoria_sl and'
      '  calibre_sl = :OLD_calibre_sl and'
      '  color_sl = :OLD_color_sl and'
      '  ref_transitos_sl = :OLD_ref_transitos_sl')
    Left = 280
    Top = 144
  end
  object QTotal: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select sum(importe_neto_sl)'
      'from frf_salidas_l'
      'where empresa_sl=:empresa'
      'and centro_salida_sl=:centro'
      'and n_albaran_sl=:albaran'
      'and fecha_sl=:fecha')
    Left = 248
    Top = 176
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'empresa'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'centro'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'albaran'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fecha'
        ParamType = ptUnknown
      end>
  end
end
