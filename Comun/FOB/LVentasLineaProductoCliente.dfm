object FLVentasLineaProductoCliente: TFLVentasLineaProductoCliente
  Left = 512
  Top = 175
  BorderIcons = [biMinimize]
  BorderStyle = bsSingle
  Caption = '    RESUMEN SALIDAS FOB'
  ClientHeight = 593
  ClientWidth = 721
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
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  DesignSize = (
    721
    593)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 37
    Top = 120
    Width = 90
    Height = 19
    AutoSize = False
    Caption = ' Empresa'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Label2: TLabel
    Left = 37
    Top = 166
    Width = 90
    Height = 19
    AutoSize = False
    Caption = ' Producto'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Label3: TLabel
    Left = 37
    Top = 190
    Width = 90
    Height = 19
    AutoSize = False
    Caption = ' Centro Origen'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Label4: TLabel
    Left = 37
    Top = 215
    Width = 90
    Height = 19
    AutoSize = False
    Caption = ' Centro Salida'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Label14: TLabel
    Left = 235
    Top = 142
    Width = 90
    Height = 19
    AutoSize = False
    Caption = ' Hasta'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Label5: TLabel
    Left = 37
    Top = 239
    Width = 90
    Height = 19
    AutoSize = False
    Caption = ' Cliente'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Label7: TLabel
    Left = 232
    Top = 362
    Width = 321
    Height = 13
    Caption = 
      'Lista de categorias seperadas por coma.  Vacio todas las categor' +
      'ias'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clDefault
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel
    Left = 37
    Top = 285
    Width = 90
    Height = 19
    AutoSize = False
    Caption = ' Pais Cliente'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Label15: TLabel
    Left = 37
    Top = 334
    Width = 90
    Height = 19
    AutoSize = False
    Caption = ' Art'#237'culo'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lblDesCalibre: TLabel
    Left = 229
    Top = 386
    Width = 114
    Height = 13
    Caption = 'Vacio todos las calibres.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clDefault
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 37
    Top = 359
    Width = 90
    Height = 19
    AutoSize = False
    Caption = ' Categoria'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lbl3: TLabel
    Left = 37
    Top = 383
    Width = 90
    Height = 19
    AutoSize = False
    Caption = ' Calibre'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lbl4: TLabel
    Left = 37
    Top = 142
    Width = 90
    Height = 19
    AutoSize = False
    Caption = ' Fecha Desde'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lbl1: TLabel
    Left = 37
    Top = 57
    Width = 90
    Height = 19
    AutoSize = False
    Caption = ' Agrupaci'#243'n'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lbl5: TLabel
    Left = 37
    Top = 97
    Width = 90
    Height = 19
    AutoSize = False
    Caption = ' Ver Albaranes'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lbl6: TLabel
    Left = 37
    Top = 310
    Width = 90
    Height = 19
    AutoSize = False
    Caption = ' Cliente Facturable'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object btnAddProducto: TSpeedButton
    Left = 420
    Top = 164
    Width = 23
    Height = 22
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000000000000000
      0000000000020000000A170D0738542D1894814626D193502AEA924F2AE87F45
      25D0522C17931209053000000009000000010000000000000000000000000000
      00030201011159311B97A96239FAC58957FFD6A36DFFDDAF75FFDDAF74FFD6A4
      6BFFC58956FFA46137F53C2112730000000F0000000300000000000000020201
      0110744226B9BC7C4DFFDDAE77FFDEB076FFE2B782FFE3BB87FFE3BC86FFE1B7
      82FFDEAF74FFDBAB72FFBD7E4EFF6F3E24B50000001000000002000000085C36
      2095BE8053FFE0B37CFFDFB076FFDEB177FFB78254FFAA7144FFAB7245FFBC88
      59FFDFB279FFDFB277FFDEB077FFC08253FF55321D920000000A190F0932B070
      47FADFB27DFFDFB27AFFE0B37BFFE0B57DFFA56B3FFFF5EFEAFFF8F3EEFFAB72
      45FFE2B67EFFE0B47CFFE0B47BFFDEB079FFB3734AFB130B072F613C2795CD9B
      6FFFE2B780FFE5BD89FFE7C291FFE8C393FFA56B3FFFF1E6DEFFF9F5F1FFAA71
      44FFE8C494FFE8C393FFE5BF8CFFE1B77FFFD09C6EFF5434218B935E3DD2DCB3
      83FFE3B781FFBA8659FFA97043FFAB7245FFAC7346FFF5EDE6FFFAF6F3FFAD75
      47FFB0784AFFB17A4BFFC29162FFE4B983FFDEB17EFF8E5B3BD0B0744CF2E3BF
      8FFFE4BB84FFA56B3FFFF3EBE6FFFAF6F3FFF6EFE8FFF7F0EAFFFBF7F5FFFAF7
      F4FFFAF7F3FFFAF6F2FFAB7245FFE5BD87FFE5BE8BFFAB714CEEAE764FECE9C9
      A0FFE5BE89FFA56B3FFFE0D2CAFFE1D3CCFFE3D5CFFFF2EAE4FFF8F3EFFFEADF
      D9FFE6DAD4FFE9DED9FFAA7144FFE7C08CFFEACA9DFFAE764FEE9A6A49D0E9CD
      ACFFEAC796FFB78456FFA56B3FFFA56B3FFFA56B3FFFF1EAE5FFFAF6F3FFA56B
      3FFFA56B3FFFA56B3FFFB78457FFEACA99FFEBD1ADFF996A49D46E4E3697DDBB
      9DFFEED3A9FFEECFA2FFEED2A5FFF0D6A9FFA56B3FFFF0EAE7FFFDFCFBFFA56B
      3FFFF1D6AAFFF0D5A8FFEED2A5FFEFD4A7FFE0C2A2FF6246318F1C140E2BC794
      6CFCF5E8CCFFEFD6ABFFF1D8AEFFF2DAB0FFA56B3FFFDECFC9FFDFD1CBFFA56B
      3FFFF3DCB2FFF1DBB0FFF1D8ADFFF7EACDFFC69470FA1A120D2E000000036F52
      3C92D7B08CFFF8EFD3FFF3E0B9FFF3DFB7FFB98A5FFFA56B3FFFA56B3FFFBA8A
      5FFFF4E1B9FFF4E2BDFFFAF1D5FFD9B390FF664B368C00000006000000010202
      0107906C4EB8D9B38FFFF7EDD3FFF8EED0FFF7EBC9FFF6E8C4FFF6E8C5FFF7EC
      CAFFF8EED0FFF4E8CDFFD7AF8BFF88664AB30202010B00000001000000000000
      00010202010770543F8FCFA078FCE2C4A2FFEBD7B8FFF4E9CDFFF4EACEFFECD8
      B9FFE3C5A3FFC59973F24C392A67000000060000000100000000000000000000
      000000000001000000022019122C6C543E89A47E5FCCC59770F1C19570EEA47E
      60CD6C543F8B16110D2200000003000000010000000000000000}
    OnClick = btnAddProductoClick
  end
  object btnSubProducto: TSpeedButton
    Left = 444
    Top = 164
    Width = 23
    Height = 22
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000000000000000
      0000000000020000000A170D0738542D1894814626D193502AEA924F2AE87F45
      25D0522C17931209053000000009000000010000000000000000000000000000
      00030201011159311B97A96239FAC58957FFD6A36DFFDDAF75FFDDAF74FFD6A4
      6BFFC58956FFA46137F53C2112730000000F0000000300000000000000020201
      0110744226B9BC7C4DFFDDAE77FFDEB076FFDEAF75FFDEAF75FFDEB074FFDDAF
      75FFDEAF74FFDBAB72FFBD7E4EFF6F3E24B50000001000000002000000085C36
      2095BE8053FFE0B37CFFDFB076FFDEB177FFDFB279FFE0B379FFE0B27AFFE0B2
      79FFDFB279FFDFB277FFDEB077FFC08253FF55321D920000000A190F0932B070
      47FADFB27DFFDFB27AFFE0B37BFFE0B57DFFE1B67EFFE2B67FFFE2B77FFFE2B7
      7FFFE2B67EFFE0B47CFFE0B47BFFDEB079FFB3734AFB130B072F613C2795CD9B
      6FFFE2B780FFE5BD89FFE7C291FFE8C393FFE8C494FFE8C594FFE8C495FFE8C4
      95FFE8C494FFE8C393FFE5BF8CFFE1B77FFFD09C6EFF5434218B935E3DD2DCB3
      83FFE3B781FFBA8659FFA97043FFAB7245FFAC7346FFB0794AFFAB7245FFAD75
      47FFB0784AFFB17A4BFFC29162FFE4B983FFDEB17EFF8E5B3BD0B0744CF2E3BF
      8FFFE4BB84FFA56B3FFFF5EEE9FFFAF6F3FFFAF7F3FFFBF7F4FFFBF7F5FFFAF7
      F4FFFAF7F3FFFAF6F2FFAB7245FFE5BD87FFE5BE8BFFAB714CEEAE764FECE9C9
      A0FFE5BE89FFA56B3FFFE6D9D2FFE7DBD4FFE9DED7FFEAE0D9FFEAE0DAFFEBE1
      DBFFEBE0DBFFEEE5E1FFAA7144FFE7C08CFFEACA9DFFAE764FEE9A6A49D0E9CD
      ACFFEAC796FFB78456FFA56B3FFFA56B3FFFA56B3FFFA56B3FFFA56B3FFFA56B
      3FFFA56B3FFFA56B3FFFB78457FFEACA99FFEBD1ADFF996A49D46E4E3697DDBB
      9DFFEED3A9FFEECFA2FFEED2A5FFF0D6A9FFF1D7ABFFF1D8ADFFF1D8ADFFF1D8
      ADFFF1D6AAFFF0D5A8FFEED2A5FFEFD4A7FFE0C2A2FF6246318F1C140E2BC794
      6CFCF5E8CCFFEFD6ABFFF1D8AEFFF2DAB0FFF3DCB3FFF3DEB4FFF3DEB4FFF3DE
      B4FFF3DCB2FFF1DBB0FFF1D8ADFFF7EACDFFC69470FA1A120D2E000000036F52
      3C92D7B08CFFF8EFD3FFF3E0B9FFF3DFB7FFF4E1B9FFF5E3BBFFF5E2BBFFF5E2
      BBFFF4E1B9FFF4E2BDFFFAF1D5FFD9B390FF664B368C00000006000000010202
      0107906C4EB8D9B38FFFF7EDD3FFF8EED0FFF7EBC9FFF6E8C4FFF6E8C5FFF7EC
      CAFFF8EED0FFF4E8CDFFD7AF8BFF88664AB30202010B00000001000000000000
      00010202010770543F8FCFA078FCE2C4A2FFEBD7B8FFF4E9CDFFF4EACEFFECD8
      B9FFE3C5A3FFC59973F24C392A67000000060000000100000000000000000000
      000000000001000000022019122C6C543E89A47E5FCCC59770F1C19570EEA47E
      60CD6C543F8B16110D2200000003000000010000000000000000}
    OnClick = btnSubProductoClick
  end
  object btnClearProducto: TSpeedButton
    Left = 468
    Top = 164
    Width = 23
    Height = 22
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00020000000900000012000000180000001A0000001A00000018000000100000
      0005000000010000000000000000000000000000000000000000000000020000
      000D3524146A936338E5A56B3AFFA36938FFA16736FF9D6233FB633E20B70805
      022800000006000000010000000000000000000000000000000000000008442F
      1D78C18B59FEE1AC76FFE4C296FFB5793BFFB5793CFFB5793CFFAD7239FF7E50
      2AD80302042A00000006000000010000000000000000000000000000000DB07D
      4EF3E6B17AFFE9B47DFFE9B47DFFE7C79DFFB67A3DFFB57A3DFFB57A3DFF6953
      7BFF090E5ED50001052800000006000000010000000000000000000000086A4E
      329DEFD7B3FFE9B47DFFE9B47DFFE9B47DFFEACDA4FFB57B3EFF735C86FF313F
      CCFF2935B8FF0B1161D501010627000000050000000100000000000000010000
      000C745538A5F2DDBBFFE9B47DFFE9B47DFFE9B47DFFD1CEE1FF3443CEFF3443
      CDFF3443CEFF2C39BAFF0D1463D4010106260000000500000001000000000000
      00020000000B76583BA4F5E2C1FFE9B47DFFB5A9B8FF829FF1FFB1C9F5FF3949
      D1FF3A4AD1FF3A49D1FF303FBDFF111767D30101062500000005000000000000
      0000000000010000000B785B3DA3E9E1D2FF87A3F2FF87A4F1FF87A3F2FFB9D0
      F7FF3E50D5FF3E50D5FF3F50D5FF3545C2FF141B6AD201010622000000000000
      000000000000000000010000000A2C386FA2C9E2F9FF8CA8F3FF8DA8F3FF8CA8
      F3FFC0D8F9FF4457D9FF4356D9FF4456D9FF3949C2FF141A61C2000000000000
      000000000000000000000000000100000009303D74A1CFE7FBFF92ADF3FF91AD
      F4FF92ADF4FFC6DEFAFF495EDBFF495DDCFF475AD7FF232F8BF0000000000000
      00000000000000000000000000000000000100000008334177A0D4ECFCFF97B2
      F5FF97B2F4FF97B3F5FFCCE4FBFF4A5FDAFF3141A4F6090C214A000000000000
      000000000000000000000000000000000000000000010000000736457A9FD8F0
      FDFF9DB7F5FF9CB7F5FFD9F1FEFF6B81CAF50B0E234700000006000000000000
      0000000000000000000000000000000000000000000000000001000000063947
      7D9EDBF3FEFFDBF3FFFF677FCFF513192C440000000500000001000000000000
      0000000000000000000000000000000000000000000000000000000000010000
      00053543728E4F63AACD151A2D40000000040000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0001000000030000000400000002000000000000000000000000}
    OnClick = btnClearProductoClick
  end
  object lblTipoCliente: TLabel
    Left = 37
    Top = 261
    Width = 90
    Height = 19
    AutoSize = False
    Caption = ' Tipo Cliente'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lbl7: TLabel
    Left = 37
    Top = 16
    Width = 149
    Height = 19
    AutoSize = False
    Caption = ' Obtener datos de'
    Color = cl3DLight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
  end
  object Calibre: TBEdit
    Left = 130
    Top = 382
    Width = 90
    Height = 21
    CharCase = ecNormal
    TabOrder = 42
  end
  object STEmpresa: TStaticText
    Left = 186
    Top = 121
    Width = 232
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 15
  end
  object STProducto: TStaticText
    Left = 186
    Top = 167
    Width = 232
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 22
  end
  object cbxNacionalidad: TComboBox
    Left = 186
    Top = 284
    Width = 233
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 35
    Text = 'Todos'
    OnKeyDown = cbxNacionalidadKeyDown
    Items.Strings = (
      'Todos'
      'Nacionales'
      'Extranjeros')
  end
  object empresa: TnbDBSQLCombo
    Left = 130
    Top = 119
    Width = 55
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = empresaChange
    TabOrder = 14
    SQL.Strings = (
      'select empresa_e, nombre_e '
      'from frf_empresas'
      'order by empresa_e')
    DatabaseName = 'BDProyecto'
    FillAuto = True
    OnlyNumbers = False
    NumChars = 3
  end
  object producto: TnbDBSQLCombo
    Left = 130
    Top = 165
    Width = 55
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = productoChange
    TabOrder = 20
    DatabaseName = 'BDProyecto'
    OnGetSQL = productoGetSQL
    OnlyNumbers = False
    NumChars = 3
  end
  object edtCentroOrigen: TnbDBSQLCombo
    Left = 130
    Top = 189
    Width = 55
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = edtCentroOrigenChange
    TabOrder = 23
    DatabaseName = 'BDProyecto'
    OnGetSQL = edtCentroOrigenGetSQL
    NumChars = 1
  end
  object edtCentroSalida: TnbDBSQLCombo
    Left = 130
    Top = 214
    Width = 55
    Height = 21
    About = 'NB 0.1/20020725'
    Alignment = taDownRight
    CharCase = ecUpperCase
    OnChange = edtCentroSalidaChange
    TabOrder = 26
    DatabaseName = 'BDProyecto'
    OnGetSQL = edtCentroOrigenGetSQL
    NumChars = 1
  end
  object edtCliente: TnbDBSQLCombo
    Left = 130
    Top = 238
    Width = 55
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = edtClienteChange
    TabOrder = 28
    DatabaseName = 'BDProyecto'
    OnGetSQL = edtClienteGetSQL
    OnlyNumbers = False
    NumChars = 3
  end
  object fechaDesde: TnbDBCalendarCombo
    Left = 130
    Top = 141
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '26/04/2004'
    TabOrder = 17
  end
  object fechaHasta: TnbDBCalendarCombo
    Left = 328
    Top = 141
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    Alignment = taDownRight
    CharCase = ecUpperCase
    Text = '26/04/2004'
    TabOrder = 18
  end
  object pais: TnbDBSQLCombo
    Left = 130
    Top = 284
    Width = 55
    Height = 21
    About = 'NB 0.1/20020725'
    Alignment = taDownRight
    CharCase = ecUpperCase
    TabOrder = 34
    SQL.Strings = (
      'select pais_p, descripcion_p from frf_paises order by pais_p')
    DatabaseName = 'BDProyecto'
    OnlyNumbers = False
    NumChars = 2
  end
  object categoria: TnbDBAlfa
    Left = 130
    Top = 358
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    TabOrder = 41
    NumChars = 20
  end
  object stCliente: TStaticText
    Left = 186
    Top = 240
    Width = 232
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 29
  end
  object stOrigen: TStaticText
    Left = 186
    Top = 191
    Width = 232
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 24
  end
  object stSalida: TStaticText
    Left = 186
    Top = 216
    Width = 232
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 27
  end
  object stEnvase: TStaticText
    Left = 227
    Top = 335
    Width = 193
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 39
  end
  object pnlTipoFactura: TPanel
    Left = 423
    Top = 144
    Width = 194
    Height = 22
    BevelOuter = bvNone
    TabOrder = 19
    object rbFechaSalidas: TRadioButton
      Left = 7
      Top = -2
      Width = 90
      Height = 20
      Caption = 'Fecha Salida'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rbFechaSalidasClick
    end
    object rbFechaFacturas: TRadioButton
      Left = 103
      Top = 0
      Width = 113
      Height = 17
      Caption = 'Fecha Factura'
      TabOrder = 1
      OnClick = rbFechaSalidasClick
    end
  end
  object btnOk: TBitBtn
    Left = 609
    Top = 506
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Imprimir'
    TabOrder = 49
    TabStop = False
    OnClick = btnOkClick
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
  object btnCancel: TBitBtn
    Left = 609
    Top = 533
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 52
    TabStop = False
    OnClick = btnCancelClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object cbbUno: TComboBox
    Left = 130
    Top = 56
    Width = 145
    Height = 19
    Style = csOwnerDrawFixed
    DropDownCount = 9
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 4
    Text = 'Sin agrupar'
    OnChange = cbbUnoChange
    Items.Strings = (
      'Sin agrupar'
      'Comercial Venta'
      'Cliente'
      'Producto'
      'Pais'
      'Agrupacion Comercial'
      'Art'#237'culo'
      'Categoria'
      'Periodo Facturaci'#243'n')
  end
  object cbbDos: TComboBox
    Left = 282
    Top = 57
    Width = 145
    Height = 19
    Style = csOwnerDrawFixed
    DropDownCount = 9
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 5
    Text = 'Sin agrupar'
    OnChange = cbbDosChange
    Items.Strings = (
      'Sin agrupar'
      'Comercial Venta'
      'Cliente'
      'Producto'
      'Pais'
      'Agrupacion Comercial'
      'Art'#237'culo'
      'Categoria'
      'Periodo Facturaci'#243'n')
  end
  object cbbTres: TComboBox
    Left = 433
    Top = 56
    Width = 145
    Height = 19
    Style = csOwnerDrawFixed
    DropDownCount = 9
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 6
    Text = 'Sin agrupar'
    OnChange = cbbTresChange
    Items.Strings = (
      'Sin agrupar'
      'Comercial Venta'
      'Cliente'
      'Producto'
      'Pais'
      'Agrupacion Comercial'
      'Art'#237'culo'
      'Categoria'
      'Periodo Facturaci'#243'n')
  end
  object chkAbonos: TCheckBox
    Left = 237
    Top = 550
    Width = 185
    Height = 17
    Caption = 'Incluir abonos y facturas manuales '
    Checked = True
    Enabled = False
    State = cbChecked
    TabOrder = 51
    OnClick = chkAbonosClick
  end
  object chkSoloManuales: TCheckBox
    Left = 237
    Top = 568
    Width = 185
    Height = 17
    Caption = 'Solo abonos y facturas manuales '
    Enabled = False
    TabOrder = 54
  end
  object chkEnvase: TCheckBox
    Left = 51
    Top = 546
    Width = 162
    Height = 17
    Caption = 'Costes de envasado'
    Checked = True
    State = cbChecked
    TabOrder = 50
  end
  object chkSecciones: TCheckBox
    Left = 51
    Top = 562
    Width = 162
    Height = 17
    Caption = 'Costes secciones almac'#233'n'
    Checked = True
    State = cbChecked
    TabOrder = 53
  end
  object rbTodos: TRadioButton
    Left = 130
    Top = 98
    Width = 80
    Height = 17
    Caption = 'Todos'
    Checked = True
    TabOrder = 11
    TabStop = True
  end
  object rbFacturados: TRadioButton
    Left = 193
    Top = 98
    Width = 80
    Height = 17
    Caption = 'Facturados'
    TabOrder = 12
  end
  object rbSinFacturar: TRadioButton
    Left = 288
    Top = 98
    Width = 80
    Height = 17
    Caption = 'Sin facturar'
    TabOrder = 13
  end
  object cbbClienteFac: TComboBox
    Left = 130
    Top = 309
    Width = 290
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 1
    TabOrder = 36
    Text = 'Clientes facturables'
    Items.Strings = (
      'Todos los clientes'
      'Clientes facturables'
      
        'Clientes no facturables (RET, REA, REP, GAN, EG, BAN y empiezan ' +
        'por 0)')
  end
  object chkComisiones: TCheckBox
    Left = 33
    Top = 493
    Width = 200
    Height = 17
    Caption = 'Descuentos y comisiones facturables'
    Checked = True
    State = cbChecked
    TabOrder = 44
  end
  object chkDescuentos: TCheckBox
    Left = 238
    Top = 493
    Width = 379
    Height = 17
    Caption = 
      'Descuentos no facturables (Se aplica en columna de importes brut' +
      'o)'
    Checked = True
    State = cbChecked
    TabOrder = 45
  end
  object chkGastosFac: TCheckBox
    Left = 33
    Top = 513
    Width = 162
    Height = 17
    Caption = 'Gastos facturables del albar'#225'n'
    Checked = True
    State = cbChecked
    TabOrder = 46
  end
  object chkGastosNoFac: TCheckBox
    Left = 238
    Top = 513
    Width = 283
    Height = 17
    Caption = 'Gastos no facturables asociados al albar'#225'n'
    Checked = True
    State = cbChecked
    TabOrder = 47
  end
  object txtLista: TStaticText
    Left = 494
    Top = 166
    Width = 194
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 21
  end
  object edtTipoCliente: TnbDBSQLCombo
    Left = 130
    Top = 260
    Width = 55
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = edtTipoClienteChange
    TabOrder = 31
    DatabaseName = 'BDProyecto'
    OnGetSQL = edtTipoClienteGetSQL
    OnlyNumbers = False
    NumChars = 3
  end
  object txtTipoCliente: TStaticText
    Left = 186
    Top = 262
    Width = 232
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 32
  end
  object chkExcluirTipoCliente: TCheckBox
    Left = 420
    Top = 262
    Width = 211
    Height = 17
    Caption = 'Excluir tipo cliente'
    TabOrder = 33
  end
  object chkPromedios: TCheckBox
    Left = 33
    Top = 530
    Width = 202
    Height = 17
    Caption = 'Usar costes de envasado promedios'
    TabOrder = 48
  end
  object btnComer: TButton
    Left = 568
    Top = 356
    Width = 115
    Height = 25
    Caption = 'Categorias 1, 2, 3'
    TabOrder = 40
    TabStop = False
    OnClick = btnComerClick
  end
  object cbbFuente: TComboBox
    Left = 193
    Top = 17
    Width = 234
    Height = 19
    Style = csOwnerDrawFixed
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ItemHeight = 13
    ItemIndex = 0
    ParentFont = False
    TabOrder = 1
    Text = 'Gesti'#243'n Comercial SAT'
    OnChange = cbbFuenteChange
    Items.Strings = (
      'Gesti'#243'n Comercial SAT'
      'Gesti'#243'n Comercial BAG'
      'Unir las dos bases de datos ')
  end
  object rgTipoProducto: TRadioGroup
    Left = 420
    Top = 191
    Width = 271
    Height = 49
    Caption = ' Tipo Producto '
    Columns = 4
    ItemIndex = 0
    Items.Strings = (
      'Todos'
      'Tomates'
      'Hortalizas'
      'Fruta')
    TabOrder = 25
  end
  object chkNoP4h: TCheckBox
    Left = 430
    Top = 121
    Width = 211
    Height = 17
    Caption = 'Excluir P4H'
    TabOrder = 16
  end
  object chkAgrupar1: TCheckBox
    Left = 130
    Top = 72
    Width = 143
    Height = 17
    TabStop = False
    Caption = 'Agrupar '
    Checked = True
    State = cbChecked
    TabOrder = 8
  end
  object chkAgrupar2: TCheckBox
    Left = 282
    Top = 72
    Width = 143
    Height = 17
    TabStop = False
    Caption = 'Agrupar'
    Enabled = False
    TabOrder = 9
  end
  object chkTotal: TCheckBox
    Left = 433
    Top = 72
    Width = 102
    Height = 17
    TabStop = False
    Caption = 'Totalizar Informe'
    Checked = True
    State = cbChecked
    TabOrder = 10
  end
  object chkVerTotalesXLS: TCheckBox
    Left = 584
    Top = 57
    Width = 116
    Height = 17
    TabStop = False
    Caption = 'Ver Totales Excel'
    Checked = True
    State = cbChecked
    TabOrder = 7
  end
  object chkCosteFruta: TCheckBox
    Left = 433
    Top = 5
    Width = 272
    Height = 17
    Caption = 'A'#241'adir Coste Campo SAT/ Coste Compra BAG'
    TabOrder = 0
  end
  object chkAddEstructura: TCheckBox
    Left = 433
    Top = 34
    Width = 176
    Height = 17
    Caption = 'A'#241'adir Coste Estructura'
    TabOrder = 3
  end
  object chkExcluirInterplanta: TCheckBox
    Left = 420
    Top = 240
    Width = 120
    Height = 17
    Caption = 'Excluir Interplanta'
    Checked = True
    State = cbChecked
    TabOrder = 30
  end
  object chkAyudas: TCheckBox
    Left = 433
    Top = 19
    Width = 272
    Height = 17
    Caption = 'A'#241'adir Ayudas - POSEI '
    TabOrder = 2
  end
  object chkVerFecha: TCheckBox
    Left = 430
    Top = 98
    Width = 227
    Height = 17
    TabStop = False
    Caption = 'Mostrar Fecha y N'#186' Albaran en Informe'
    TabOrder = 55
  end
  object edtEnvase: TcxTextEdit
    Left = 130
    Top = 333
    Properties.CharCase = ecUpperCase
    Properties.MaxLength = 9
    Properties.OnChange = edtEnvaseChange
    Style.BorderStyle = ebs3D
    Style.LookAndFeel.Kind = lfUltraFlat
    Style.LookAndFeel.NativeStyle = False
    StyleDisabled.LookAndFeel.Kind = lfUltraFlat
    StyleDisabled.LookAndFeel.NativeStyle = False
    StyleFocused.LookAndFeel.Kind = lfUltraFlat
    StyleFocused.LookAndFeel.NativeStyle = False
    StyleHot.LookAndFeel.Kind = lfUltraFlat
    StyleHot.LookAndFeel.NativeStyle = False
    TabOrder = 37
    OnExit = edtEnvaseExit
    Width = 75
  end
  object ssEnvase: TSimpleSearch
    Left = 205
    Top = 333
    Width = 21
    Height = 21
    TabOrder = 38
    TabStop = False
    LookAndFeel.NativeStyle = False
    LookAndFeel.SkinName = 'MoneyTwins'
    OptionsImage.ImageIndex = 2
    OptionsImage.Images = FDM.ilxImagenes
    Titulo = 'Busqueda de Art'#237'culos'
    Tabla = 'frf_envases'
    Campos = <
      item
        Etiqueta = 'Art'#237'culo'
        Campo = 'envase_e'
        Ancho = 100
        Tipo = ctCadena
      end
      item
        Etiqueta = 'Descripci'#243'n'
        Campo = 'descripcion_e'
        Ancho = 400
        Tipo = ctCadena
      end>
    Database = 'BDProyecto'
    CampoResultado = 'envase_e'
    Enlace = edtEnvase
    Tecla = 'F2'
    AntesEjecutar = ssEnvaseAntesEjecutar
    Concatenar = False
  end
  object chkGastosFijos: TCheckBox
    Left = 238
    Top = 530
    Width = 283
    Height = 17
    Caption = 'Gastos fijos no facturables'
    TabOrder = 56
  end
  object GroupBox1: TGroupBox
    Left = 33
    Top = 403
    Width = 651
    Height = 72
    TabOrder = 43
    object lblTipoGasto: TLabel
      Left = 7
      Top = 15
      Width = 87
      Height = 19
      AutoSize = False
      Caption = ' Tipo Gasto'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label6: TLabel
      Left = 238
      Top = 43
      Width = 357
      Height = 13
      Caption = 
        'Lista de tipo de gastos seperadas por coma. Vacio todas los tipo' +
        's de gastos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object eTipoGasto: TnbDBSQLCombo
      Left = 97
      Top = 16
      Width = 55
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      OnChange = eTipoGastoChange
      TabOrder = 0
      SQL.Strings = (
        
          'select tipo_tg cod, descripcion_tg gasto, unidad_dist_tg unidad,' +
          ' '
        '       case when gasto_transito_tg = 0 then '#39'SALIDAS'#39
        '            else '#39'TRANSITOS'#39
        '       end tipo'
        'from frf_tipo_gastos'
        'where gasto_transito_tg in (0,1)'
        'order by tipo_tg')
      DatabaseName = 'BDProyecto'
      OnlyNumbers = False
      NumChars = 3
    end
    object txtTipoGasto: TStaticText
      Left = 153
      Top = 17
      Width = 241
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 1
    end
    object chkExcluirGasto: TCheckBox
      Left = 502
      Top = 17
      Width = 82
      Height = 17
      Caption = 'Excluir gasto seleccionado'
      TabOrder = 3
      OnClick = chkExcluirGastoClick
    end
    object grupoGasto: TnbDBAlfa
      Left = 97
      Top = 40
      Width = 135
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      TabOrder = 2
      NumChars = 20
    end
  end
  object ListaAcciones: TActionList
    Left = 664
    Top = 112
    object BAceptar: TAction
      Caption = 'BAceptar'
      ShortCut = 112
      OnExecute = btnOkClick
    end
    object BCancelar: TAction
      Caption = 'BCancelar'
      ShortCut = 27
      OnExecute = btnCancelClick
    end
  end
end
