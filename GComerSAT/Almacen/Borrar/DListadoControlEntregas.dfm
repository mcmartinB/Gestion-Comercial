object FDListadoControlEntregas: TFDListadoControlEntregas
  Left = 575
  Top = 237
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    CONTROL DE ENTREGAS'
  ClientHeight = 211
  ClientWidth = 421
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
    Left = 29
    Top = 24
    Width = 110
    Height = 21
    Caption = 'Empresa'
    About = 'NB 0.1/20020725'
  end
  object nbLabel3: TnbLabel
    Left = 235
    Top = 48
    Width = 62
    Height = 21
    Caption = 'al'
    About = 'NB 0.1/20020725'
  end
  object nomEmpresa: TnbStaticText
    Left = 201
    Top = 24
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
    FocusControl = eEmpresa
    OnGetDescription = nomEmpresaGetDescription
  end
  object nomCentro: TnbStaticText
    Left = 201
    Top = 72
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
    FocusControl = eCentro
    OnGetDescription = nomCentroGetDescription
  end
  object btnOk: TSpeedButton
    Left = 196
    Top = 159
    Width = 99
    Height = 25
    Caption = 'Listado (F1)'
    OnClick = BtnOkClick
  end
  object btnCancel: TSpeedButton
    Left = 296
    Top = 159
    Width = 99
    Height = 25
    Caption = 'Cerrar (Esc)'
    OnClick = BtnCancelClick
  end
  object nbLabel5: TnbLabel
    Left = 29
    Top = 96
    Width = 110
    Height = 21
    Caption = 'Producto'
    About = 'NB 0.1/20020725'
  end
  object nomProducto: TnbStaticText
    Left = 201
    Top = 96
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
    FocusControl = eProducto
    OnGetDescription = nomProductoGetDescription
  end
  object eEmpresa: TnbDBSQLCombo
    Left = 143
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
    NumChars = 3
  end
  object eCentro: TnbDBSQLCombo
    Left = 143
    Top = 72
    Width = 40
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = eCentroChange
    TabOrder = 3
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
    Left = 301
    Top = 48
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '23/07/2007'
    TabOrder = 2
  end
  object eFechaIni: TnbDBCalendarCombo
    Left = 143
    Top = 48
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '27/02/2004'
    TabOrder = 1
  end
  object eProducto: TnbDBSQLCombo
    Left = 143
    Top = 96
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = eProductoChange
    TabOrder = 4
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
    Left = 29
    Top = 48
    Width = 110
    Height = 21
    Style = csDropDownList
    Color = clSilver
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 5
    TabStop = False
    Text = 'Fecha origen del'
    Items.Strings = (
      'Fecha origen del'
      'Fecha destino del'
      'Fecha carga del')
  end
  object cbxCentro: TComboBox
    Left = 29
    Top = 72
    Width = 110
    Height = 21
    Style = csDropDownList
    Color = clSilver
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 6
    TabStop = False
    Text = 'Centro origen'
    Items.Strings = (
      'Centro origen'
      'Centro destino ')
  end
  object cbxTermografo: TCheckBox
    Left = 143
    Top = 122
    Width = 236
    Height = 17
    Caption = 'Mostrar termografo en vez de la matricula'
    TabOrder = 7
  end
end
