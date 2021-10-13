object FMListTransitos: TFMListTransitos
  Left = 328
  Top = 253
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    LISTADO DE TR'#193'NSITOS'
  ClientHeight = 188
  ClientWidth = 379
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  DesignSize = (
    379
    188)
  PixelsPerInch = 96
  TextHeight = 13
  object nbLabel1: TnbLabel
    Left = 32
    Top = 24
    Width = 100
    Height = 21
    Caption = 'Empresa'
    About = 'NB 0.1/20020725'
  end
  object nbLabel2: TnbLabel
    Left = 32
    Top = 48
    Width = 100
    Height = 21
    Caption = 'Centro Salida'
    About = 'NB 0.1/20020725'
  end
  object btnOk: TSpeedButton
    Left = 153
    Top = 139
    Width = 99
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Aceptar'
    OnClick = BtnOkClick
  end
  object btnCancel: TSpeedButton
    Left = 253
    Top = 139
    Width = 99
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancelar'
    OnClick = BtnCancelClick
  end
  object nbLabel3: TnbLabel
    Left = 32
    Top = 72
    Width = 100
    Height = 21
    Caption = 'Producto'
    About = 'NB 0.1/20020725'
  end
  object empresaDesde: TnbDBSQLCombo
    Left = 136
    Top = 24
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 0
    SQL.Strings = (
      'select empresa_e, nombre_e'
      'from frf_empresas'
      'order by empresa_e')
    DatabaseName = 'BDProyecto'
    NumChars = 3
  end
  object centroDesde: TnbDBSQLCombo
    Left = 136
    Top = 48
    Width = 38
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 2
    SQL.Strings = (
      'select empresa_c, centro_c, descripcion_c from frf_centros'
      'order by empresa_c, centro_c')
    DatabaseName = 'BDProyecto'
    ColumnResult = 1
    NumChars = 1
  end
  object fechaDesde: TnbDBCalendarCombo
    Left = 136
    Top = 96
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '27/02/2004'
    TabOrder = 7
  end
  object fechaHasta: TnbDBCalendarCombo
    Left = 232
    Top = 96
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '27/02/2004'
    TabOrder = 8
  end
  object empresaHasta: TnbDBSQLCombo
    Left = 232
    Top = 24
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 1
    SQL.Strings = (
      'select empresa_e, nombre_e'
      'from frf_empresas'
      'order by empresa_e')
    DatabaseName = 'BDProyecto'
    NumChars = 3
  end
  object centroHasta: TnbDBSQLCombo
    Left = 232
    Top = 48
    Width = 38
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 3
    SQL.Strings = (
      'select empresa_c, centro_c, descripcion_c from frf_centros'
      'order by empresa_c, centro_c')
    DatabaseName = 'BDProyecto'
    ColumnResult = 1
    NumChars = 1
  end
  object cbxFecha: TComboBox
    Left = 32
    Top = 96
    Width = 100
    Height = 21
    Style = csDropDownList
    Color = clSilver
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 6
    Text = 'Fecha Salida'
    OnKeyDown = cbxFechaKeyDown
    Items.Strings = (
      'Fecha Salida'
      'Fecha Entrada')
  end
  object productoDesde: TnbDBSQLCombo
    Left = 136
    Top = 72
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 4
    SQL.Strings = (
      'select empresa_p, producto_p, descripcion_p'
      'from frf_productos'
      'order by empresa_p, producto_p')
    DatabaseName = 'BDProyecto'
    ColumnResult = 1
    OnlyNumbers = False
    NumChars = 3
  end
  object productoHasta: TnbDBSQLCombo
    Left = 232
    Top = 72
    Width = 38
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 5
    SQL.Strings = (
      'select empresa_p, producto_p, descripcion_p'
      'from frf_productos'
      'order by empresa_p, producto_p')
    DatabaseName = 'BDProyecto'
    ColumnResult = 1
    OnlyNumbers = False
    NumChars = 1
  end
end
