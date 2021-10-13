object FMListTransitos: TFMListTransitos
  Left = 653
  Top = 226
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    LISTADO DE TR'#193'NSITOS'
  ClientHeight = 248
  ClientWidth = 377
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
    377
    248)
  PixelsPerInch = 96
  TextHeight = 13
  object nbLabel2: TnbLabel
    Left = 32
    Top = 80
    Width = 100
    Height = 21
    Caption = 'Centro Salida'
    About = 'NB 0.1/20020725'
  end
  object btnOk: TSpeedButton
    Left = 151
    Top = 199
    Width = 99
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Aceptar'
    OnClick = BtnOkClick
  end
  object btnCancel: TSpeedButton
    Left = 251
    Top = 199
    Width = 99
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancelar'
    OnClick = BtnCancelClick
  end
  object nbLabel3: TnbLabel
    Left = 32
    Top = 104
    Width = 100
    Height = 21
    Caption = 'Producto'
    About = 'NB 0.1/20020725'
  end
  object lbl1: TLabel
    Left = 196
    Top = 84
    Width = 80
    Height = 13
    Caption = '(Campo optativo)'
  end
  object lbl2: TLabel
    Left = 196
    Top = 108
    Width = 80
    Height = 13
    Caption = '(Campo optativo)'
  end
  object lblTransito: TnbLabel
    Left = 32
    Top = 128
    Width = 100
    Height = 21
    Caption = 'Tr'#225'nsito'
    About = 'NB 0.1/20020725'
  end
  object lblEmpresa: TnbLabel
    Left = 32
    Top = 32
    Width = 100
    Height = 21
    Caption = 'Empresa'
    About = 'NB 0.1/20020725'
  end
  object empresaDesde: TnbDBSQLCombo
    Left = 136
    Top = 32
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
    OnlyNumbers = False
    NumChars = 3
  end
  object centroDesde: TnbDBSQLCombo
    Left = 136
    Top = 80
    Width = 38
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 4
    SQL.Strings = (
      'select empresa_c, centro_c, descripcion_c from frf_centros'
      'order by empresa_c, centro_c')
    DatabaseName = 'BDProyecto'
    ColumnResult = 1
    NumChars = 1
  end
  object fechaDesde: TnbDBCalendarCombo
    Left = 136
    Top = 56
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '27/02/2004'
    TabOrder = 2
  end
  object fechaHasta: TnbDBCalendarCombo
    Left = 232
    Top = 56
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '27/02/2004'
    TabOrder = 3
  end
  object cbxFecha: TComboBox
    Left = 32
    Top = 56
    Width = 100
    Height = 21
    Style = csDropDownList
    Color = clSilver
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 1
    Text = 'Fecha Salida'
    OnKeyDown = cbxFechaKeyDown
    Items.Strings = (
      'Fecha Salida'
      'Fecha Entrada')
  end
  object productoDesde: TnbDBSQLCombo
    Left = 136
    Top = 104
    Width = 54
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
    NumChars = 3
  end
  object chkPaletsProveedor: TCheckBox
    Left = 136
    Top = 155
    Width = 169
    Height = 17
    Caption = 'Ver Palets Proveedor (Entregas)'
    TabOrder = 8
  end
  object eTransito: TnbDBNumeric
    Left = 136
    Top = 128
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 6
  end
  object chkCodEntrega: TCheckBox
    Left = 32
    Top = 155
    Width = 88
    Height = 17
    Caption = 'Ver Entrega'
    TabOrder = 7
  end
end
