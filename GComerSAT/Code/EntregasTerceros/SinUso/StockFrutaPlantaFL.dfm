object FLStockFrutaPlanta: TFLStockFrutaPlanta
  Left = 547
  Top = 201
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    Listado Stock Actual de Fruta de Proveedor'
  ClientHeight = 411
  ClientWidth = 561
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  DesignSize = (
    561
    411)
  PixelsPerInch = 96
  TextHeight = 13
  object lblEmpresa: TnbLabel
    Left = 32
    Top = 32
    Width = 100
    Height = 21
    Caption = 'Empresa'
    About = 'NB 0.1/20020725'
  end
  object nbLabel2: TnbLabel
    Left = 32
    Top = 56
    Width = 100
    Height = 21
    Caption = 'Centro'
    About = 'NB 0.1/20020725'
  end
  object stEmpresa: TLabel
    Left = 192
    Top = 36
    Width = 153
    Height = 13
    AutoSize = False
    Caption = '(Falta c'#243'digo de la empresa)'
  end
  object stCentro: TLabel
    Left = 192
    Top = 60
    Width = 153
    Height = 13
    AutoSize = False
    Caption = '(Falta c'#243'digo del centro)'
  end
  object Label1: TLabel
    Left = 110
    Top = 287
    Width = 307
    Height = 13
    Caption = 
      'Este listado muestra en tiempo real los palets recibidos y en st' +
      'ock'
  end
  object Label2: TLabel
    Left = 110
    Top = 303
    Width = 181
    Height = 13
    Caption = 'que en este momento estan en planta.'
  end
  object Label3: TLabel
    Left = 83
    Top = 295
    Width = 408
    Height = 13
    Caption = 'POR FAVOR ESPERE MIENTRAS SE EXTRAEN LOS DATOS PEDIDOS'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object nbLabel1: TnbLabel
    Left = 32
    Top = 80
    Width = 100
    Height = 21
    Caption = 'Producto'
    About = 'NB 0.1/20020725'
  end
  object stProducto: TLabel
    Left = 192
    Top = 84
    Width = 153
    Height = 13
    AutoSize = False
    Caption = '(Vacio =Todos los productos)'
  end
  object nbLabel3: TnbLabel
    Left = 32
    Top = 152
    Width = 100
    Height = 21
    Caption = 'Entrega'
    About = 'NB 0.1/20020725'
  end
  object Label5: TLabel
    Left = 224
    Top = 156
    Width = 153
    Height = 13
    AutoSize = False
    Caption = '(Vacio =Todas las entradas)'
  end
  object lblProveedor: TnbLabel
    Left = 32
    Top = 176
    Width = 100
    Height = 21
    Caption = 'Proveedor'
    About = 'NB 0.1/20020725'
  end
  object lblVariedad: TnbLabel
    Left = 32
    Top = 200
    Width = 100
    Height = 21
    Caption = 'Variedad'
    About = 'NB 0.1/20020725'
  end
  object lblCalibre: TnbLabel
    Left = 32
    Top = 224
    Width = 100
    Height = 21
    Caption = 'Calibre'
    About = 'NB 0.1/20020725'
  end
  object stProveedor: TLabel
    Left = 192
    Top = 180
    Width = 153
    Height = 13
    AutoSize = False
    Caption = '(Vacio =Todas los proveedores)'
  end
  object stVariedad: TLabel
    Left = 192
    Top = 204
    Width = 153
    Height = 13
    AutoSize = False
    Caption = '(Vacio =Todas las variedades)'
  end
  object lblPais: TnbLabel
    Left = 32
    Top = 248
    Width = 100
    Height = 21
    Caption = 'Pais'
    About = 'NB 0.1/20020725'
  end
  object stPais: TLabel
    Left = 192
    Top = 252
    Width = 153
    Height = 13
    AutoSize = False
    Caption = '(Vacio =Todos los paises)'
  end
  object stCalibre: TLabel
    Left = 242
    Top = 227
    Width = 153
    Height = 13
    AutoSize = False
    Caption = '(Vacio =Todas los calibres)'
  end
  object nbLabel4: TnbLabel
    Left = 32
    Top = 128
    Width = 100
    Height = 21
    Caption = 'Fecha Llegada del'
    About = 'NB 0.1/20020725'
  end
  object nbLabel5: TnbLabel
    Left = 232
    Top = 128
    Width = 33
    Height = 21
    Caption = 'Al'
    About = 'NB 0.1/20020725'
  end
  object nbLabel6: TnbLabel
    Left = 32
    Top = 104
    Width = 100
    Height = 21
    Caption = 'Semana'
    About = 'NB 0.1/20020725'
  end
  object lblSemana: TLabel
    Left = 192
    Top = 108
    Width = 257
    Height = 13
    AutoSize = False
    Caption = '(Optativo, los dos primeros d'#237'gitos campo albar'#225'n)'
  end
  object btnCerrar: TBitBtn
    Left = 445
    Top = 362
    Width = 90
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cerrar (Esc)'
    TabOrder = 0
    TabStop = False
    OnClick = btnCerrarClick
    Kind = bkCancel
  end
  object btnImprimir: TBitBtn
    Left = 348
    Top = 362
    Width = 90
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Imprimir (F1)'
    ModalResult = 1
    TabOrder = 1
    TabStop = False
    OnClick = btnImprimirClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object eEmpresa: TnbDBSQLCombo
    Left = 136
    Top = 32
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = eEmpresaChange
    TabOrder = 2
    SQL.Strings = (
      'select empresa_e, nombre_e '
      'from frf_empresas'
      'order by empresa_e')
    DatabaseName = 'BDProyecto'
    FillAuto = True
    NumChars = 3
  end
  object eCentro: TnbDBSQLCombo
    Left = 136
    Top = 56
    Width = 41
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = eCentroChange
    TabOrder = 3
    DatabaseName = 'BDProyecto'
    OnGetSQL = eCentroGetSQL
    NumChars = 1
  end
  object cbxVariedad: TCheckBox
    Left = 408
    Top = 35
    Width = 145
    Height = 17
    Caption = 'Agrupar por variedad.'
    TabOrder = 13
    OnClick = cbxVariedadClick
  end
  object cbxValorar: TCheckBox
    Left = 408
    Top = 69
    Width = 145
    Height = 17
    Caption = 'Valorar Stock'
    TabOrder = 15
  end
  object cbxCalibre: TCheckBox
    Left = 408
    Top = 51
    Width = 145
    Height = 17
    Caption = 'Agrupar por calibre.'
    Enabled = False
    TabOrder = 14
  end
  object eProducto: TnbDBSQLCombo
    Left = 136
    Top = 80
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = eProductoChange
    TabOrder = 4
    DatabaseName = 'BDProyecto'
    OnGetSQL = eProductoGetSQL
    OnlyNumbers = False
    NumChars = 3
  end
  object eEntrega: TBEdit
    Left = 136
    Top = 152
    Width = 80
    Height = 21
    MaxLength = 12
    TabOrder = 8
  end
  object eCalibre: TnbDBSQLCombo
    Left = 136
    Top = 224
    Width = 105
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 11
    DatabaseName = 'BDProyecto'
    OnGetSQL = eCalibreGetSQL
    OnlyNumbers = False
    NumChars = 8
  end
  object eVariedad: TnbDBSQLCombo
    Left = 136
    Top = 200
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = eVariedadChange
    TabOrder = 10
    DatabaseName = 'BDProyecto'
    OnGetSQL = eVariedadGetSQL
    NumChars = 3
  end
  object eProveedor: TnbDBSQLCombo
    Left = 136
    Top = 176
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = eProveedorChange
    TabOrder = 9
    SQL.Strings = (
      'select empresa_e, nombre_e '
      'from frf_empresas'
      'order by empresa_e')
    DatabaseName = 'BDProyecto'
    OnGetSQL = eProveedorGetSQL
    FillAuto = True
    NumChars = 3
  end
  object ePais: TnbDBSQLCombo
    Left = 136
    Top = 248
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = ePaisChange
    TabOrder = 12
    SQL.Strings = (
      'select pais_p, descripcion_p'
      'from frf_paises'
      'order by pais_p')
    DatabaseName = 'BDProyecto'
    OnlyNumbers = False
    NumChars = 2
  end
  object eDesde: TnbDBCalendarCombo
    Left = 136
    Top = 128
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '30/04/2009'
    TabOrder = 6
  end
  object eHasta: TnbDBCalendarCombo
    Left = 272
    Top = 128
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '30/04/2009'
    TabOrder = 7
  end
  object eSemana: TBEdit
    Left = 136
    Top = 104
    Width = 25
    Height = 21
    MaxLength = 2
    TabOrder = 5
  end
  object chkIgnorarPlatano: TCheckBox
    Left = 352
    Top = 82
    Width = 105
    Height = 17
    Caption = 'Ignorar Pl'#225'tano'
    TabOrder = 16
  end
end
