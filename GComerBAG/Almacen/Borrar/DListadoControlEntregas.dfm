object FDListadoControlEntregas: TFDListadoControlEntregas
  Left = 426
  Top = 223
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    CONTROL DE ENTREGAS'
  ClientHeight = 341
  ClientWidth = 491
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object nbLabel1: TnbLabel
    Left = 57
    Top = 24
    Width = 110
    Height = 21
    Caption = 'Empresa'
    About = 'NB 0.1/20020725'
  end
  object nbLabel3: TnbLabel
    Left = 263
    Top = 48
    Width = 62
    Height = 21
    Caption = 'al'
    About = 'NB 0.1/20020725'
  end
  object nomEmpresa: TnbStaticText
    Left = 229
    Top = 24
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
    FocusControl = eEmpresa
    OnGetDescription = nomEmpresaGetDescription
  end
  object nomCentro: TnbStaticText
    Left = 229
    Top = 122
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
    FocusControl = eCentro
    OnGetDescription = nomCentroGetDescription
  end
  object btnOk: TSpeedButton
    Left = 267
    Top = 273
    Width = 99
    Height = 25
    Caption = 'Listado (F1)'
    OnClick = BtnOkClick
  end
  object btnCancel: TSpeedButton
    Left = 367
    Top = 273
    Width = 99
    Height = 25
    Caption = 'Cerrar (Esc)'
    OnClick = BtnCancelClick
  end
  object nbLabel5: TnbLabel
    Left = 57
    Top = 146
    Width = 110
    Height = 21
    Caption = 'Producto'
    About = 'NB 0.1/20020725'
  end
  object nomProducto: TnbStaticText
    Left = 229
    Top = 146
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
    FocusControl = eProducto
    OnGetDescription = nomProductoGetDescription
  end
  object lblCentroLlegada: TnbLabel
    Left = 57
    Top = 122
    Width = 110
    Height = 21
    Caption = 'Centro Llegada'
    About = 'NB 0.1/20020725'
  end
  object lbl1: TnbLabel
    Left = 57
    Top = 73
    Width = 110
    Height = 21
    Caption = 'Fecha Llegada'
    About = 'NB 0.1/20020725'
  end
  object lblTipo: TnbLabel
    Left = 57
    Top = 97
    Width = 110
    Height = 21
    Caption = 'Tipo Entrega'
    About = 'NB 0.1/20020725'
  end
  object lblCodigo1: TnbLabel
    Left = 57
    Top = 171
    Width = 110
    Height = 21
    Caption = 'Proveedor'
    About = 'NB 0.1/20020725'
  end
  object nomProveedor: TnbStaticText
    Left = 229
    Top = 171
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
    FocusControl = eProveedor
    OnGetDescription = nomProveedorGetDescription
  end
  object lblAlmacen: TnbLabel
    Left = 57
    Top = 196
    Width = 110
    Height = 21
    Caption = 'Almac'#233'n'
    About = 'NB 0.1/20020725'
  end
  object nomAlmacen: TnbStaticText
    Left = 229
    Top = 196
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
    FocusControl = eAlmacen
    OnGetDescription = nomAlmacenGetDescription
  end
  object lblAgrupar: TnbLabel
    Left = 57
    Top = 223
    Width = 110
    Height = 21
    Caption = 'Agrupar por'
    About = 'NB 0.1/20020725'
  end
  object eEmpresa: TnbDBSQLCombo
    Left = 171
    Top = 24
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = eEmpresaChange
    TabOrder = 0
    SQL.Strings = (
      'select empresa_e, nombre_e'
      'from frf_empresas'
      'order by empresa_e')
    DatabaseName = 'BDProyecto'
    FillAuto = True
    OnlyNumbers = False
    NumChars = 3
  end
  object eCentro: TnbDBSQLCombo
    Left = 171
    Top = 122
    Width = 40
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = eCentroChange
    TabOrder = 6
    SQL.Strings = (
      'select empresa_e, nombre_e'
      'from frf_empresas'
      'order by empresa_e')
    DatabaseName = 'BDProyecto'
    ColumnResult = 1
    OnGetSQL = eCentroGetSQL
    NumChars = 1
  end
  object eFechaFin: TnbDBCalendarCombo
    Left = 329
    Top = 48
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '23/07/2007'
    TabOrder = 3
  end
  object eFechaIni: TnbDBCalendarCombo
    Left = 171
    Top = 48
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '27/02/2004'
    TabOrder = 2
  end
  object eProducto: TnbDBSQLCombo
    Left = 171
    Top = 146
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = eProductoChange
    TabOrder = 7
    SQL.Strings = (
      'select empresa_e, nombre_e'
      'from frf_empresas'
      'order by empresa_e')
    DatabaseName = 'BDProyecto'
    ColumnResult = 1
    OnGetSQL = eProductoGetSQL
    OnlyNumbers = False
    NumChars = 3
  end
  object cbxFecha: TComboBox
    Left = 57
    Top = 48
    Width = 110
    Height = 21
    Style = csDropDownList
    Color = clSilver
    ItemHeight = 13
    ItemIndex = 1
    TabOrder = 1
    TabStop = False
    Text = 'Fecha llegada del'
    Items.Strings = (
      'Fecha grabacion del'
      'Fecha llegada del'
      'Fecha carga del')
  end
  object cbbEstadoFecha: TComboBox
    Left = 171
    Top = 73
    Width = 113
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 2
    TabOrder = 4
    Text = 'INDIFERENTE'
    Items.Strings = (
      'DEFINITIVA'
      'PROVISIONAL'
      'INDIFERENTE')
  end
  object cbbTipo: TComboBox
    Left = 171
    Top = 97
    Width = 113
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 2
    TabOrder = 5
    Text = 'TODAS'
    Items.Strings = (
      'NORMAL'
      'DIRECTA'
      'TODAS')
  end
  object eProveedor: TnbDBSQLCombo
    Left = 171
    Top = 171
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = eProveedorChange
    TabOrder = 8
    SQL.Strings = (
      'select empresa_p, proveedor_p, nombre_p'
      'from frf_proveedores'
      'order by empresa_p, proveedor_p')
    DatabaseName = 'BDProyecto'
    ColumnResult = 1
    OnGetSQL = eProveedorGetSQL
    OnlyNumbers = False
    NumChars = 3
  end
  object eAlmacen: TnbDBSQLCombo
    Left = 171
    Top = 196
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = eAlmacenChange
    TabOrder = 9
    SQL.Strings = (
      'select empresa_p, proveedor_p, nombre_p'
      'from frf_proveedores'
      'order by empresa_p, proveedor_p')
    DatabaseName = 'BDProyecto'
    ColumnResult = 2
    OnGetSQL = eAlmacenGetSQL
    OnlyNumbers = False
    NumChars = 3
  end
  object cbbAgrupar: TComboBox
    Left = 171
    Top = 223
    Width = 113
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 10
    Text = 'Nada'
    Items.Strings = (
      'Nada'
      'Almac'#233'n'
      'Producto')
  end
end
