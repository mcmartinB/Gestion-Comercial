object FLBeneficioProducto: TFLBeneficioProducto
  Left = 711
  Top = 267
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    BENEFICIO PRODUCTO'
  ClientHeight = 281
  ClientWidth = 460
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
    460
    281)
  PixelsPerInch = 96
  TextHeight = 13
  object lblEmpresa: TnbLabel
    Left = 32
    Top = 56
    Width = 115
    Height = 21
    Caption = 'Planta'
    About = 'NB 0.1/20020725'
  end
  object stEmpresa: TLabel
    Left = 211
    Top = 60
    Width = 125
    Height = 13
    Caption = '(Vacio =Todas las plantas)'
  end
  object lblMsg1: TLabel
    Left = 32
    Top = 186
    Width = 408
    Height = 13
    Caption = 'POR FAVOR ESPERE MIENTRAS SE EXTRAEN LOS DATOS PEDIDOS'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Visible = False
  end
  object lblProducto: TnbLabel
    Left = 32
    Top = 83
    Width = 115
    Height = 21
    Caption = 'Producto'
    About = 'NB 0.1/20020725'
  end
  object stProducto: TLabel
    Left = 211
    Top = 87
    Width = 138
    Height = 13
    Caption = '(Vacio =Todos los productos)'
  end
  object lblFechaDesde: TnbLabel
    Left = 32
    Top = 32
    Width = 115
    Height = 21
    Caption = 'Fecha Llegada Desde'
    About = 'NB 0.1/20020725'
  end
  object lblFechaHasta: TnbLabel
    Left = 240
    Top = 32
    Width = 42
    Height = 21
    Caption = 'Hasta'
    About = 'NB 0.1/20020725'
  end
  object lblProveedor: TnbLabel
    Left = 32
    Top = 107
    Width = 115
    Height = 21
    Caption = 'Proveedor'
    About = 'NB 0.1/20020725'
  end
  object stProveedor: TLabel
    Left = 211
    Top = 111
    Width = 150
    Height = 13
    Caption = '(Vacio =Todos los proveedores)'
  end
  object lblEntrega: TnbLabel
    Left = 32
    Top = 131
    Width = 115
    Height = 21
    Caption = 'Entrega'
    About = 'NB 0.1/20020725'
  end
  object lblNombre1: TLabel
    Left = 247
    Top = 135
    Width = 132
    Height = 13
    Caption = '(Vacio =Todas las entregas)'
  end
  object lblMsg2: TLabel
    Left = 32
    Top = 198
    Width = 200
    Height = 13
    Caption = 'PROCESANDO ENTRADA X DE Y'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -8
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    Transparent = True
    Visible = False
  end
  object nbLabel1: TnbLabel
    Left = 32
    Top = 155
    Width = 115
    Height = 21
    Caption = 'Porcentaje Aprovecha'
    About = 'NB 0.1/20020725'
  end
  object lbl1: TLabel
    Left = 205
    Top = 159
    Width = 8
    Height = 13
    Caption = '%'
  end
  object lbl2: TLabel
    Left = 32
    Top = 226
    Width = 177
    Height = 39
    Caption = 
      'NOTA:'#13#10'Los precios de venta se calculan con'#13#10'los valores de la s' +
      'emana siguiente.'
  end
  object eFechaHasta: TnbDBCalendarCombo
    Left = 284
    Top = 32
    Width = 85
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '04/09/2008'
    TabOrder = 1
  end
  object eFechaDesde: TnbDBCalendarCombo
    Left = 155
    Top = 32
    Width = 85
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '04/09/2008'
    TabOrder = 0
  end
  object btnCerrar: TBitBtn
    Left = 347
    Top = 234
    Width = 90
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cerrar (Esc)'
    TabOrder = 7
    TabStop = False
    OnClick = btnCerrarClick
    Kind = bkCancel
  end
  object btnImprimir: TBitBtn
    Left = 250
    Top = 234
    Width = 90
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Imprimir (F1)'
    ModalResult = 1
    TabOrder = 6
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
    Left = 155
    Top = 56
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
    OnlyNumbers = False
    NumChars = 3
  end
  object eProducto: TnbDBSQLCombo
    Left = 155
    Top = 83
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = eProductoChange
    TabOrder = 3
    DatabaseName = 'BDProyecto'
    OnGetSQL = eProductoGetSQL
    OnlyNumbers = False
    NumChars = 3
  end
  object eProveedor: TnbDBSQLCombo
    Left = 155
    Top = 107
    Width = 54
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = eProveedorChange
    TabOrder = 4
    DatabaseName = 'BDProyecto'
    OnGetSQL = eProveedorGetSQL
    OnlyNumbers = False
    NumChars = 3
  end
  object eEntrega: TnbDBAlfa
    Left = 155
    Top = 131
    Width = 85
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 5
    NumChars = 12
  end
  object eAprovecha: TnbDBAlfa
    Left = 155
    Top = 155
    Width = 46
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 8
    OnlyNumbers = True
    NumChars = 3
  end
end
