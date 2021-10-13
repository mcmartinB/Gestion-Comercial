object FMReclamaciones: TFMReclamaciones
  Left = 242
  Top = 344
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  RECLAMACIONES DE CLIENTES'
  ClientHeight = 523
  ClientWidth = 867
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Label13: TLabel
    Left = 37
    Top = 75
    Width = 90
    Height = 19
    AutoSize = False
    Caption = 'Empresa'
    Color = cl3DLight
    ParentColor = False
  end
  object PMaestro: TPanel
    Left = 0
    Top = 0
    Width = 867
    Height = 523
    Align = alClient
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Bevel2: TBevel
      Left = 440
      Top = 189
      Width = 380
      Height = 273
    end
    object Bevel1: TBevel
      Left = 440
      Top = 29
      Width = 380
      Height = 142
    end
    object lblEmpresa: TLabel
      Left = 39
      Top = 29
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblCliente: TLabel
      Left = 39
      Top = 78
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Cliente'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblReclamacion: TLabel
      Left = 39
      Top = 54
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' N'#186' Reclamaci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblEmail: TLabel
      Left = 39
      Top = 126
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' E-Mail'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre: TLabel
      Left = 39
      Top = 150
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Nombre'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 39
      Top = 318
      Width = 200
      Height = 19
      AutoSize = False
      Caption = ' Observaciones Cliente'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 39
      Top = 174
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Pedido'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label3: TLabel
      Left = 39
      Top = 198
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' N'#186' Albar'#225'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label4: TLabel
      Left = 39
      Top = 222
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Fecha Recepci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label5: TLabel
      Left = 39
      Top = 246
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Producto Base'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label6: TLabel
      Left = 39
      Top = 270
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Idioma'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label7: TLabel
      Left = 39
      Top = 294
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' N'#250'mero de'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label9: TLabel
      Left = 447
      Top = 34
      Width = 55
      Height = 19
      AutoSize = False
      Caption = ' Rajado'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label10: TLabel
      Left = 508
      Top = 34
      Width = 55
      Height = 19
      AutoSize = False
      Caption = ' Mancha'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label11: TLabel
      Left = 569
      Top = 34
      Width = 55
      Height = 19
      AutoSize = False
      Caption = ' Blando'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label12: TLabel
      Left = 630
      Top = 34
      Width = 55
      Height = 19
      AutoSize = False
      Caption = ' Moho'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label14: TLabel
      Left = 691
      Top = 34
      Width = 55
      Height = 19
      AutoSize = False
      Caption = ' Color'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label15: TLabel
      Left = 753
      Top = 34
      Width = 55
      Height = 19
      AutoSize = False
      Caption = ' Otros'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label17: TLabel
      Left = 447
      Top = 196
      Width = 200
      Height = 19
      AutoSize = False
      Caption = ' Devoluci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label18: TLabel
      Left = 447
      Top = 284
      Width = 200
      Height = 19
      AutoSize = False
      Caption = ' Reselecci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label19: TLabel
      Left = 447
      Top = 372
      Width = 200
      Height = 19
      AutoSize = False
      Caption = ' Otros'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label16: TLabel
      Left = 447
      Top = 82
      Width = 200
      Height = 19
      AutoSize = False
      Caption = ' Descripci'#243'n Otros'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label8: TLabel
      Left = 39
      Top = 404
      Width = 200
      Height = 19
      AutoSize = False
      Caption = ' Notas Departamento Comercial'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label20: TLabel
      Left = 494
      Top = 60
      Width = 8
      Height = 13
      Caption = '%'
    end
    object Label21: TLabel
      Left = 555
      Top = 60
      Width = 8
      Height = 13
      Caption = '%'
    end
    object Label22: TLabel
      Left = 677
      Top = 60
      Width = 8
      Height = 13
      Caption = '%'
    end
    object Label23: TLabel
      Left = 616
      Top = 60
      Width = 8
      Height = 13
      Caption = '%'
    end
    object Label24: TLabel
      Left = 800
      Top = 60
      Width = 8
      Height = 13
      Caption = '%'
    end
    object Label25: TLabel
      Left = 738
      Top = 60
      Width = 8
      Height = 13
      Caption = '%'
    end
    object lblDevolucion: TLabel
      Left = 712
      Top = 199
      Width = 64
      Height = 13
      Caption = 'lblDevolucion'
    end
    object lblReseleccion: TLabel
      Left = 712
      Top = 287
      Width = 69
      Height = 13
      Caption = 'lblReseleccion'
    end
    object lblOtros: TLabel
      Left = 712
      Top = 375
      Width = 35
      Height = 13
      Caption = 'lblOtros'
    end
    object Label26: TLabel
      Left = 39
      Top = 101
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Fecha Reclama.'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label27: TLabel
      Left = 231
      Top = 101
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Hora Reclama.'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object empresa_rcl: TBDEdit
      Tag = 1
      Left = 140
      Top = 28
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      RequiredMsg = 'El c'#243'digo de la empresa es obligatorio.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      OnChange = PonNombreEmpresa
      DataField = 'empresa_rcl'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object STEmpresa: TStaticText
      Left = 189
      Top = 28
      Width = 211
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 1
    end
    object cliente_rcl: TBDEdit
      Left = 140
      Top = 77
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El c'#243'digo del cliente es de obligada inserserci'#243'n.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 9
      OnChange = PonNombreCliente
      DataField = 'cliente_rcl'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object n_reclamacion_rcl: TBDEdit
      Left = 140
      Top = 53
      Width = 70
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'El n'#250'mero de la reclamaci'#243'n es obligatorio.'
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 5
      TabOrder = 2
      DataField = 'n_reclamacion_rcl'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object email_rcl: TBDEdit
      Left = 140
      Top = 125
      Width = 261
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      CharCase = ecNormal
      MaxLength = 100
      TabOrder = 14
      DataField = 'email_rcl'
      DataSource = DSMaestro
    end
    object nombre_rcl: TBDEdit
      Left = 140
      Top = 149
      Width = 261
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 30
      TabOrder = 15
      DataField = 'nombre_rcl'
      DataSource = DSMaestro
    end
    object observacion_rcl: TDBMemo
      Left = 39
      Top = 339
      Width = 362
      Height = 62
      DataField = 'observacion_rcl'
      DataSource = DSMaestro
      TabOrder = 30
    end
    object n_pedido_rcl: TBDEdit
      Left = 140
      Top = 173
      Width = 70
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 10
      TabOrder = 16
      DataField = 'n_pedido_rcl'
      DataSource = DSMaestro
    end
    object n_albaran_rcl: TBDEdit
      Left = 140
      Top = 197
      Width = 70
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 10
      TabOrder = 18
      DataField = 'n_albaran_rcl'
      DataSource = DSMaestro
    end
    object fecha_albaran_rcl: TBDEdit
      Left = 140
      Top = 221
      Width = 70
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      InputType = itDate
      MaxLength = 10
      TabOrder = 20
      DataField = 'fecha_albaran_rcl'
      DataSource = DSMaestro
    end
    object producto_rcl: TBDEdit
      Left = 140
      Top = 245
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 1
      TabOrder = 21
      OnChange = PonNombreProducto
      DataField = 'producto_rcl'
      DataSource = DSMaestro
    end
    object idioma_rcl: TBDEdit
      Left = 232
      Top = 269
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = RequiredTime
      Enabled = False
      Visible = False
      CharCase = ecLowerCase
      MaxLength = 3
      TabOrder = 24
      OnChange = idioma_rclChange
      DataField = 'idioma_rcl'
      DataSource = DSMaestro
    end
    object caj_kgs_uni_rcl: TBDEdit
      Left = 311
      Top = 293
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = RequiredTime
      Enabled = False
      Visible = False
      MaxLength = 1
      TabOrder = 27
      OnChange = caj_kgs_uni_rclChange
      DataField = 'caj_kgs_uni_rcl'
      DataSource = DSMaestro
    end
    object cantidad_rcl: TBDEdit
      Left = 232
      Top = 293
      Width = 70
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 5
      TabOrder = 26
      DataField = 'cantidad_rcl'
      DataSource = DSMaestro
    end
    object porc_rajado_rcl: TBDEdit
      Left = 447
      Top = 56
      Width = 45
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 4
      TabOrder = 3
      DataField = 'porc_rajado_rcl'
      DataSource = DSMaestro
    end
    object porc_mancha_rcl: TBDEdit
      Left = 508
      Top = 56
      Width = 45
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 4
      TabOrder = 4
      DataField = 'porc_mancha_rcl'
      DataSource = DSMaestro
    end
    object porc_moho_rcl: TBDEdit
      Left = 630
      Top = 56
      Width = 45
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 4
      TabOrder = 6
      DataField = 'porc_moho_rcl'
      DataSource = DSMaestro
    end
    object porc_blando_rcl: TBDEdit
      Left = 569
      Top = 56
      Width = 45
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 4
      TabOrder = 5
      DataField = 'porc_blando_rcl'
      DataSource = DSMaestro
    end
    object porc_otros_rcl: TBDEdit
      Left = 753
      Top = 56
      Width = 45
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 4
      TabOrder = 8
      DataField = 'porc_otros_rcl'
      DataSource = DSMaestro
    end
    object porc_color_rcl: TBDEdit
      Left = 691
      Top = 56
      Width = 45
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 4
      TabOrder = 7
      DataField = 'porc_color_rcl'
      DataSource = DSMaestro
    end
    object descripcion_otros_rcl: TDBMemo
      Left = 448
      Top = 102
      Width = 360
      Height = 62
      DataField = 'descripcion_otros_rcl'
      DataSource = DSMaestro
      TabOrder = 13
    end
    object n_devolucion_rcl: TBDEdit
      Left = 651
      Top = 195
      Width = 50
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 4
      TabOrder = 17
      DataField = 'n_devolucion_rcl'
      DataSource = DSMaestro
    end
    object t_devolucion_rcl: TDBMemo
      Left = 448
      Top = 217
      Width = 360
      Height = 62
      DataField = 't_devolucion_rcl'
      DataSource = DSMaestro
      TabOrder = 19
    end
    object n_reseleccion_rcl: TBDEdit
      Left = 651
      Top = 283
      Width = 50
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 4
      TabOrder = 25
      DataField = 'n_reseleccion_rcl'
      DataSource = DSMaestro
    end
    object t_reseleccion_rcl: TDBMemo
      Left = 448
      Top = 305
      Width = 360
      Height = 62
      DataField = 't_reseleccion_rcl'
      DataSource = DSMaestro
      TabOrder = 29
    end
    object n_otros_rcl: TBDEdit
      Left = 651
      Top = 371
      Width = 50
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 4
      TabOrder = 31
      DataField = 'n_otros_rcl'
      DataSource = DSMaestro
    end
    object t_otros_rcl: TDBMemo
      Left = 448
      Top = 393
      Width = 360
      Height = 62
      DataField = 't_otros_rcl'
      DataSource = DSMaestro
      TabOrder = 32
    end
    object cbxUnidad: TComboBox
      Left = 140
      Top = 294
      Width = 89
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 28
      Text = 'CAJAS'
      OnChange = cbxUnidadChange
      Items.Strings = (
        'CAJAS'
        'KILOS'
        'UNIDADES')
    end
    object notas_exporta_rcl: TDBMemo
      Left = 39
      Top = 425
      Width = 362
      Height = 62
      DataField = 'notas_exporta_rcl'
      DataSource = DSMaestro
      TabOrder = 33
    end
    object STCliente: TStaticText
      Left = 189
      Top = 79
      Width = 211
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 10
    end
    object StProducto: TStaticText
      Left = 189
      Top = 245
      Width = 211
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 22
    end
    object cbxIdiomas: TComboBox
      Left = 140
      Top = 269
      Width = 89
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 23
      Text = 'ESPA'#209'OL'
      OnChange = cbxIdiomasChange
      Items.Strings = (
        'ESPA'#209'OL'
        'INGL'#201'S'
        'ALEM'#193'N')
    end
    object fecha_rcl: TBDEdit
      Left = 140
      Top = 100
      Width = 70
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = RequiredTime
      InputType = itDate
      MaxLength = 10
      TabOrder = 11
      DataField = 'fecha_rcl'
      DataSource = DSMaestro
      Modificable = False
    end
    object hora_rcl: TBDEdit
      Left = 332
      Top = 100
      Width = 70
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = RequiredTime
      InputType = itHour
      MaxLength = 8
      TabOrder = 12
      DataField = 'hora_rcl'
      DataSource = DSMaestro
      Modificable = False
    end
  end
  object Button1: TButton
    Left = 440
    Top = 472
    Width = 182
    Height = 25
    Caption = 'VER FOTOS'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 640
    Top = 472
    Width = 182
    Height = 25
    Caption = 'IMPRIMIR FOTOS'
    TabOrder = 2
    OnClick = Button2Click
  end
  object DSMaestro: TDataSource
    DataSet = DMWEB.QReclamaciones
    Left = 48
    Top = 8
  end
  object ACosecheros: TActionList
    Left = 8
    Top = 8
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
  end
end
