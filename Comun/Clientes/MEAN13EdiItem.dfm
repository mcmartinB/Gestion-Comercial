object FMEAN13EdiItem: TFMEAN13EdiItem
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'C'#243'digo de facturaci'#243'n EDI'
  ClientHeight = 199
  ClientWidth = 856
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Scaled = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LCodigo_e: TLabel
    Left = 27
    Top = 103
    Width = 72
    Height = 19
    AutoSize = False
    Caption = ' EAN 13'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object LEnvase_e: TLabel
    Left = 27
    Top = 25
    Width = 62
    Height = 19
    AutoSize = False
    Caption = ' Art'#237'culo'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object LEmpresa_e: TLabel
    Left = 27
    Top = 76
    Width = 86
    Height = 19
    AutoSize = False
    Caption = ' Empresa'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Label1: TLabel
    Left = 27
    Top = 50
    Width = 86
    Height = 19
    AutoSize = False
    Caption = ' Descripci'#243'n'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Label4: TLabel
    Left = 27
    Top = 157
    Width = 86
    Height = 19
    AutoSize = False
    Caption = ' Fecha de Baja'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lblDun14: TLabel
    Left = 281
    Top = 103
    Width = 53
    Height = 19
    AutoSize = False
    Caption = ' DUN 14'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object BGBEan13_ee: TBGridButton
    Left = 218
    Top = 101
    Width = 15
    Height = 21
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
      0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
      000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
    OnClick = BGBEan13_eeClick
    Control = ean13_ee
    Grid = RejillaFlotante
    GridAlignment = taDownRight
    GridWidth = 290
    GridHeigth = 100
  end
  object Label3: TLabel
    Left = 465
    Top = 26
    Width = 43
    Height = 13
    Caption = 'Producto'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Label6: TLabel
    Left = 27
    Top = 133
    Width = 46
    Height = 13
    Caption = 'Comercial'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Label7: TLabel
    Left = 465
    Top = 76
    Width = 33
    Height = 13
    Caption = 'Centro'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object btCancelar: TcxButton
    Left = 764
    Top = 148
    Width = 81
    Height = 39
    Hint = 'Pulse Esc para cancelar el proceso de Facturaci'#243'n.'
    Caption = 'Cerrar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 18
    TabStop = False
    OnClick = btCancelarClick
    OptionsImage.ImageIndex = 4
    OptionsImage.Images = DFactura.IFacturas
  end
  object ean13_ee: TBDEdit
    Left = 110
    Top = 101
    Width = 105
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 13
    TabOrder = 12
    OnKeyPress = ean13_eeKeyPress
    DataField = 'ean13_ee'
    DataSource = DS
  end
  object descripcion_ee: TBDEdit
    Left = 110
    Top = 50
    Width = 335
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 60
    TabOrder = 5
    DataField = 'descripcion_ee'
    DataSource = DS
  end
  object fecha_baja_ee: TBDEdit
    Left = 110
    Top = 157
    Width = 73
    Height = 21
    InputType = itDate
    TabOrder = 19
    DataField = 'fecha_baja_ee'
    DataSource = DS
  end
  object dun14_ee: TBDEdit
    Left = 340
    Top = 101
    Width = 105
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 14
    TabOrder = 13
    OnKeyPress = ean13_eeKeyPress
    DataField = 'dun14_ee'
    DataSource = DS
  end
  object envase_ee: TcxDBTextEdit
    Left = 110
    Top = 23
    DataBinding.DataField = 'envase_ee'
    DataBinding.DataSource = DS
    Properties.CharCase = ecUpperCase
    Properties.MaxLength = 9
    Style.BorderStyle = ebs3D
    Style.LookAndFeel.Kind = lfUltraFlat
    Style.LookAndFeel.NativeStyle = False
    StyleDisabled.LookAndFeel.Kind = lfUltraFlat
    StyleDisabled.LookAndFeel.NativeStyle = False
    StyleFocused.LookAndFeel.Kind = lfUltraFlat
    StyleFocused.LookAndFeel.NativeStyle = False
    StyleHot.LookAndFeel.Kind = lfUltraFlat
    StyleHot.LookAndFeel.NativeStyle = False
    TabOrder = 0
    OnExit = envase_eeExit
    Width = 75
  end
  object ssEnvase: TSimpleSearch
    Left = 191
    Top = 23
    Width = 21
    Height = 21
    Hint = 'B'#250'squeda de Art'#237'culo'
    TabOrder = 1
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
    Join = 'fecha_baja_e is null'
    CampoResultado = 'envase_e'
    Enlace = envase_ee
    Tecla = 'F2'
    Concatenar = False
  end
  object dbeProducto: TDBEdit
    Left = 514
    Top = 23
    Width = 60
    Height = 21
    TabStop = False
    Color = clBtnFace
    DataField = 'calProductoCod'
    DataSource = DS
    Enabled = False
    ReadOnly = True
    TabOrder = 3
  end
  object dbeProductoDescripcion: TDBEdit
    Left = 580
    Top = 23
    Width = 265
    Height = 21
    TabStop = False
    Color = clBtnFace
    DataField = 'calProductoDes'
    DataSource = DS
    Enabled = False
    ReadOnly = True
    TabOrder = 4
  end
  object DBEdit3: TDBEdit
    Left = 218
    Top = 23
    Width = 227
    Height = 21
    TabStop = False
    Color = clBtnFace
    DataField = 'calArticuloDes'
    DataSource = DS
    Enabled = False
    ReadOnly = True
    TabOrder = 2
  end
  object dbeEmpresaDescripcion: TDBEdit
    Left = 187
    Top = 76
    Width = 258
    Height = 21
    TabStop = False
    Color = clBtnFace
    DataField = 'calEmpresaDes'
    DataSource = DS
    Enabled = False
    ReadOnly = True
    TabOrder = 8
  end
  object dbeComercialDescripcion: TDBEdit
    Left = 181
    Top = 130
    Width = 264
    Height = 21
    TabStop = False
    Color = clBtnFace
    DataField = 'calComercialDes'
    DataSource = DS
    Enabled = False
    ReadOnly = True
    TabOrder = 16
  end
  object dbeCentroDescripcion: TDBEdit
    Left = 580
    Top = 73
    Width = 265
    Height = 21
    TabStop = False
    Color = clBtnFace
    DataField = 'calCentroDes'
    DataSource = DS
    Enabled = False
    ReadOnly = True
    TabOrder = 11
  end
  object ssCentro: TSimpleSearch
    Left = 553
    Top = 73
    Width = 21
    Height = 21
    TabOrder = 10
    TabStop = False
    LookAndFeel.NativeStyle = False
    LookAndFeel.SkinName = 'MoneyTwins'
    OptionsImage.ImageIndex = 2
    OptionsImage.Images = FDM.ilxImagenes
    Titulo = 'B'#250'squeda de centro'
    Tabla = 'frf_centros'
    Campos = <
      item
        Etiqueta = 'C'#243'digo'
        Campo = 'centro_c'
        Ancho = 1
        Tipo = ctCadena
      end
      item
        Etiqueta = 'Centro'
        Campo = 'descripcion_c'
        Ancho = 30
        Tipo = ctCadena
      end>
    Database = 'BDProyecto'
    CampoResultado = 'centro_c'
    Enlace = dbeCentro
    Tecla = 'F2'
    AntesEjecutar = ssCentroAntesEjecutar
    Concatenar = False
  end
  object dbeCentro: TcxDBTextEdit
    Left = 514
    Top = 73
    DataBinding.DataField = 'centro_ee'
    DataBinding.DataSource = DS
    Properties.CharCase = ecUpperCase
    Style.LookAndFeel.Kind = lfStandard
    Style.LookAndFeel.NativeStyle = False
    StyleDisabled.LookAndFeel.Kind = lfStandard
    StyleDisabled.LookAndFeel.NativeStyle = False
    StyleFocused.LookAndFeel.Kind = lfStandard
    StyleFocused.LookAndFeel.NativeStyle = False
    StyleHot.LookAndFeel.Kind = lfStandard
    StyleHot.LookAndFeel.NativeStyle = False
    TabOrder = 9
    Width = 36
  end
  object ssComercial: TSimpleSearch
    Left = 154
    Top = 130
    Width = 21
    Height = 21
    TabOrder = 15
    TabStop = False
    LookAndFeel.NativeStyle = False
    LookAndFeel.SkinName = 'MoneyTwins'
    OptionsImage.ImageIndex = 2
    OptionsImage.Images = FDM.ilxImagenes
    Titulo = 'B'#250'squeda de comerciales'
    Tabla = 'frf_comerciales'
    Campos = <
      item
        Etiqueta = 'C'#243'digo'
        Campo = 'codigo_c'
        Ancho = 3
        Tipo = ctCadena
      end
      item
        Etiqueta = 'Comercial'
        Campo = 'descripcion_c'
        Ancho = 50
        Tipo = ctCadena
      end>
    Database = 'BDProyecto'
    CampoResultado = 'codigo_c'
    Enlace = dbeComercial
    Tecla = 'F2'
    Concatenar = False
  end
  object dbeComercial: TcxDBTextEdit
    Left = 110
    Top = 130
    DataBinding.DataField = 'comercial_ee'
    DataBinding.DataSource = DS
    Properties.CharCase = ecUpperCase
    Properties.MaxLength = 3
    Style.LookAndFeel.Kind = lfStandard
    Style.LookAndFeel.NativeStyle = False
    StyleDisabled.LookAndFeel.Kind = lfStandard
    StyleDisabled.LookAndFeel.NativeStyle = False
    StyleFocused.LookAndFeel.Kind = lfStandard
    StyleFocused.LookAndFeel.NativeStyle = False
    StyleHot.LookAndFeel.Kind = lfStandard
    StyleHot.LookAndFeel.NativeStyle = False
    TabOrder = 14
    Width = 38
  end
  object ssEmpresa: TSimpleSearch
    Left = 160
    Top = 76
    Width = 21
    Height = 21
    TabOrder = 7
    TabStop = False
    LookAndFeel.NativeStyle = False
    LookAndFeel.SkinName = 'MoneyTwins'
    OptionsImage.ImageIndex = 2
    OptionsImage.Images = FDM.ilxImagenes
    Titulo = 'B'#250'squeda de empresa'
    Tabla = 'frf_empresas'
    Campos = <
      item
        Etiqueta = 'C'#243'digo'
        Campo = 'empresa_e'
        Ancho = 3
        Tipo = ctCadena
      end
      item
        Etiqueta = 'Empresa'
        Campo = 'nombre_e'
        Ancho = 30
        Tipo = ctCadena
      end>
    Database = 'BDProyecto'
    CampoResultado = 'empresa_e'
    Enlace = dbeEmpresa
    Tecla = 'F2'
    Concatenar = False
  end
  object dbeEmpresa: TcxDBTextEdit
    Left = 110
    Top = 75
    DataBinding.DataField = 'empresa_ee'
    DataBinding.DataSource = DS
    Properties.CharCase = ecUpperCase
    Properties.MaxLength = 3
    Style.LookAndFeel.Kind = lfStandard
    Style.LookAndFeel.NativeStyle = False
    StyleDisabled.LookAndFeel.Kind = lfStandard
    StyleDisabled.LookAndFeel.NativeStyle = False
    StyleFocused.LookAndFeel.Kind = lfStandard
    StyleFocused.LookAndFeel.NativeStyle = False
    StyleHot.LookAndFeel.Kind = lfStandard
    StyleHot.LookAndFeel.NativeStyle = False
    TabOrder = 6
    Width = 41
  end
  object btAceptar: TcxButton
    Left = 677
    Top = 148
    Width = 81
    Height = 39
    Hint = 'Pulse F1 para comenzar el proceso de Facturaci'#243'n.'
    Caption = 'Aceptar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 17
    TabStop = False
    OnClick = btAceptarClick
    OptionsImage.ImageIndex = 10
    OptionsImage.Images = DFactura.IFacturas
  end
  object RejillaFlotante: TBGrid
    Left = 503
    Top = 100
    Width = 41
    Height = 57
    Color = clInfoBk
    DataSource = DMBaseDatos.DSQDespegables
    FixedColor = clInfoText
    Options = [dgTabs, dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 20
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Visible = False
  end
  object DS: TDataSource
    Left = 14
    Top = 2
  end
  object ActionList: TActionList
    Left = 446
    Top = 7
    object ACancelar: TAction
      Caption = 'Cancelar'
      ShortCut = 27
    end
    object AAceptar: TAction
      Caption = 'Aceptar'
      ShortCut = 112
    end
  end
end
