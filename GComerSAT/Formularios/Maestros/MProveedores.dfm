object FMProveedores: TFMProveedores
  Left = 191
  Top = 197
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  PROVEEDORES'
  ClientHeight = 568
  ClientWidth = 793
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
  object PMaestro: TPanel
    Left = 0
    Top = 0
    Width = 793
    Height = 307
    Align = alTop
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label2: TLabel
      Left = 43
      Top = 149
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Tel'#233'fonos'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label5: TLabel
      Left = 43
      Top = 105
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Domicilio'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label7: TLabel
      Left = 43
      Top = 127
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Poblaci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label8: TLabel
      Left = 43
      Top = 83
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' C'#243'digo Postal'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label10: TLabel
      Left = 43
      Top = 38
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' C'#243'digo/Nombre'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label4: TLabel
      Left = 338
      Top = 149
      Width = 22
      Height = 19
      AutoSize = False
      Caption = ' Fax'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label11: TLabel
      Left = 43
      Top = 215
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Cta. Contable'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label6: TLabel
      Left = 43
      Top = 171
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' P'#225'gina Web'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label9: TLabel
      Left = 43
      Top = 193
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' E-Mail'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label12: TLabel
      Left = 346
      Top = 215
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Forma Pago'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBFormaPago: TBGridButton
      Left = 452
      Top = 214
      Width = 13
      Height = 21
      Action = ARejillaFlotante
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
      Control = forma_pago_p
      Grid = RejillaFlotante
      GridAlignment = taUpRight
      GridWidth = 280
      GridHeigth = 160
    end
    object Label13: TLabel
      Left = 43
      Top = 18
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBEmpresa: TBGridButton
      Left = 170
      Top = 17
      Width = 13
      Height = 21
      Action = ARejillaFlotante
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
      Control = empresa_p
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 160
    end
    object Label24: TLabel
      Left = 43
      Top = 60
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Pa'#237's'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBPais_p: TBGridButton
      Left = 170
      Top = 59
      Width = 13
      Height = 21
      Action = ARejillaFlotante
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
      Control = pais_p
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 160
    end
    object telefono1_p: TBDEdit
      Left = 128
      Top = 148
      Width = 104
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 16
      TabOrder = 10
      DataField = 'telefono1_p'
      DataSource = DSMaestro
    end
    object proveedor_p: TBDEdit
      Left = 128
      Top = 37
      Width = 30
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 3
      TabOrder = 2
      DataField = 'proveedor_p'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object nombre_p: TBDEdit
      Left = 184
      Top = 37
      Width = 209
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 30
      TabOrder = 3
      DataField = 'nombre_p'
      DataSource = DSMaestro
    end
    object domicilio_p: TBDEdit
      Left = 128
      Top = 104
      Width = 337
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 50
      TabOrder = 8
      DataField = 'domicilio_p'
      DataSource = DSMaestro
    end
    object poblacion_p: TBDEdit
      Left = 128
      Top = 126
      Width = 337
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 50
      TabOrder = 9
      DataField = 'poblacion_p'
      DataSource = DSMaestro
    end
    object cod_postal_p: TBDEdit
      Left = 128
      Top = 82
      Width = 40
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 5
      TabOrder = 6
      OnChange = cod_postal_pChange
      DataField = 'cod_postal_p'
      DataSource = DSMaestro
    end
    object STProvincia: TStaticText
      Left = 184
      Top = 84
      Width = 209
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 7
    end
    object telefono2_p: TBDEdit
      Left = 234
      Top = 148
      Width = 104
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 16
      TabOrder = 11
      DataField = 'telefono2_p'
      DataSource = DSMaestro
    end
    object fax_p: TBDEdit
      Left = 360
      Top = 148
      Width = 105
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 16
      TabOrder = 12
      DataField = 'fax_p'
      DataSource = DSMaestro
    end
    object cta_contable_p: TBDEdit
      Left = 128
      Top = 214
      Width = 89
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 8
      TabOrder = 15
      DataField = 'cta_contable_p'
      DataSource = DSMaestro
    end
    object pagina_web_p: TBDEdit
      Left = 128
      Top = 170
      Width = 337
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      CharCase = ecNormal
      MaxLength = 50
      TabOrder = 13
      DataField = 'pagina_web_p'
      DataSource = DSMaestro
    end
    object email_p: TBDEdit
      Left = 128
      Top = 192
      Width = 337
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      CharCase = ecNormal
      MaxLength = 50
      TabOrder = 14
      DataField = 'email_p'
      DataSource = DSMaestro
    end
    object forma_pago_p: TBDEdit
      Left = 430
      Top = 214
      Width = 20
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 2
      TabOrder = 16
      OnChange = forma_pago_pChange
      DataField = 'forma_pago_p'
      DataSource = DSMaestro
    end
    object mmoFormaPago: TMemo
      Left = 43
      Top = 238
      Width = 422
      Height = 58
      TabStop = False
      BevelInner = bvNone
      BevelOuter = bvNone
      Color = clBtnFace
      Ctl3D = False
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 17
    end
    object empresa_p: TBDEdit
      Left = 128
      Top = 17
      Width = 30
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 3
      TabOrder = 0
      OnChange = empresa_pChange
      DataField = 'empresa_p'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object stEmpresa: TStaticText
      Left = 184
      Top = 19
      Width = 209
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 1
    end
    object pais_p: TBDEdit
      Left = 128
      Top = 59
      Width = 24
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 2
      TabOrder = 4
      OnChange = pais_pChange
      DataField = 'pais_p'
      DataSource = DSMaestro
      PrimaryKey = True
    end
    object stPais_p: TStaticText
      Left = 184
      Top = 61
      Width = 209
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 5
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 307
    Width = 793
    Height = 261
    ActivePage = tsProductos
    Align = alClient
    TabOrder = 2
    OnChange = PageControlChange
    object tsAlmacenes: TTabSheet
      Caption = 'Almacenes'
      object PAlmacenes: TPanel
        Left = 0
        Top = 0
        Width = 785
        Height = 57
        Align = alTop
        TabOrder = 0
        Visible = False
        object Label1: TLabel
          Left = 78
          Top = 20
          Width = 95
          Height = 19
          AutoSize = False
          Caption = ' C'#243'digo / Nombre'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object almacen_pa: TBDEdit
          Left = 177
          Top = 19
          Width = 30
          Height = 21
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          InputType = itInteger
          MaxLength = 3
          TabOrder = 0
          DataField = 'almacen_pa'
          DataSource = DSAlmacenes
          Modificable = False
          PrimaryKey = True
        end
        object nombre_pa: TBDEdit
          Left = 210
          Top = 19
          Width = 209
          Height = 21
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          MaxLength = 30
          TabOrder = 1
          DataField = 'nombre_pa'
          DataSource = DSAlmacenes
        end
      end
      object RAlmacenes: TDBGrid
        Left = 0
        Top = 57
        Width = 785
        Height = 118
        Align = alClient
        DataSource = DSAlmacenes
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'almacen_pa'
            Title.Caption = 'Almac'#233'n'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nombre_pa'
            Title.Caption = 'Descripci'#243'n'
            Visible = True
          end>
      end
    end
    object tsProductos: TTabSheet
      Caption = 'Productos'
      ImageIndex = 1
      object RProductos: TDBGrid
        Left = 0
        Top = 130
        Width = 785
        Height = 103
        Align = alClient
        DataSource = DSProductos
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'producto_pp'
            Title.Caption = 'Producto'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'variedad_pp'
            Title.Caption = 'Variedad'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'codigo_ean_pp'
            Title.Caption = 'EAN'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descripcion_pp'
            Title.Caption = 'Descripci'#243'n'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descripcion_breve_pp'
            Title.Caption = 'Des. Breve'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'marca_pp'
            Title.Caption = 'Marca'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'pais_origen_pp'
            Title.Caption = 'Pa'#237's Origen'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'presentacion_pp'
            Title.Caption = 'Presentaci'#243'n'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'peso_paleta_pp'
            Title.Caption = 'Peso Paleta'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'peso_cajas_pp'
            Title.Caption = 'Peso Caja'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cajas_paleta_pp'
            Title.Caption = 'Cajas Paleta'
            Visible = True
          end>
      end
      object PProductos: TPanel
        Left = 0
        Top = 0
        Width = 785
        Height = 130
        Align = alTop
        TabOrder = 0
        Visible = False
        object Label3: TLabel
          Left = 265
          Top = 10
          Width = 60
          Height = 19
          AutoSize = False
          Caption = ' Producto'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object Label14: TLabel
          Left = 12
          Top = 10
          Width = 65
          Height = 19
          AutoSize = False
          Caption = ' Variedad'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object Label15: TLabel
          Left = 12
          Top = 32
          Width = 65
          Height = 19
          AutoSize = False
          Caption = ' Descripci'#243'n'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object Label16: TLabel
          Left = 513
          Top = 32
          Width = 68
          Height = 19
          AutoSize = False
          Caption = ' Des.Breve'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object Label17: TLabel
          Left = 12
          Top = 54
          Width = 65
          Height = 19
          AutoSize = False
          Caption = ' Marca'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object Label18: TLabel
          Left = 265
          Top = 54
          Width = 60
          Height = 19
          AutoSize = False
          Caption = ' Pa'#237's'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object Label19: TLabel
          Left = 513
          Top = 54
          Width = 68
          Height = 19
          AutoSize = False
          Caption = ' Presentaci'#243'n'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object Label20: TLabel
          Left = 12
          Top = 78
          Width = 65
          Height = 19
          AutoSize = False
          Caption = ' Peso Paleta'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object Label21: TLabel
          Left = 265
          Top = 78
          Width = 60
          Height = 19
          AutoSize = False
          Caption = ' Peso Caja'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object Label22: TLabel
          Left = 513
          Top = 78
          Width = 68
          Height = 19
          AutoSize = False
          Caption = ' Cajas Paleta'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object Label23: TLabel
          Left = 513
          Top = 10
          Width = 68
          Height = 19
          AutoSize = False
          Caption = ' EAN13'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object BGBProducto: TBGridButton
          Left = 357
          Top = 9
          Width = 13
          Height = 21
          Action = ARejillaFlotante
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
          Control = producto_pp
          Grid = RejillaFlotante
          GridAlignment = taDownRight
          GridWidth = 280
          GridHeigth = 160
        end
        object BGBPais: TBGridButton
          Left = 357
          Top = 53
          Width = 13
          Height = 21
          Action = ARejillaFlotante
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
          Control = pais_origen_pp
          Grid = RejillaFlotante
          GridAlignment = taDownRight
          GridWidth = 280
          GridHeigth = 160
        end
        object Label25: TLabel
          Left = 265
          Top = 100
          Width = 60
          Height = 19
          AutoSize = False
          Caption = ' Unids. Caja'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object Label26: TLabel
          Left = 513
          Top = 100
          Width = 68
          Height = 19
          AutoSize = False
          Caption = ' Und. Precio'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object producto_pp: TBDEdit
          Left = 327
          Top = 9
          Width = 30
          Height = 21
          Hint = 'El c'#243'digo del producto es obligatorio.'
          ColorEdit = clMoneyGreen
          Required = True
          OnRequiredTime = RequiredTime
          MaxLength = 3
          TabOrder = 1
          OnChange = producto_ppChange
          DataField = 'producto_pp'
          DataSource = DSProductos
          Modificable = False
          PrimaryKey = True
        end
        object descripcion_pp: TBDEdit
          Left = 79
          Top = 31
          Width = 426
          Height = 21
          Hint = 'La descripci'#243'n del producto es necesaria.'
          ColorEdit = clMoneyGreen
          Required = True
          OnRequiredTime = RequiredTime
          MaxLength = 50
          TabOrder = 4
          DataField = 'descripcion_pp'
          DataSource = DSProductos
        end
        object variedad_pp: TBDEdit
          Left = 79
          Top = 9
          Width = 26
          Height = 21
          Hint = 'El c'#243'digo de la variedad del proveedor es necesario.'
          ColorEdit = clMoneyGreen
          Required = True
          OnRequiredTime = RequiredTime
          InputType = itInteger
          MaxLength = 3
          TabOrder = 0
          DataField = 'variedad_pp'
          DataSource = DSProductos
          Modificable = False
          PrimaryKey = True
        end
        object descripcion_breve_pp: TBDEdit
          Left = 583
          Top = 31
          Width = 180
          Height = 21
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          MaxLength = 25
          TabOrder = 5
          DataField = 'descripcion_breve_pp'
          DataSource = DSProductos
        end
        object marca_pp: TBDEdit
          Left = 79
          Top = 53
          Width = 180
          Height = 21
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          MaxLength = 20
          TabOrder = 6
          DataField = 'marca_pp'
          DataSource = DSProductos
        end
        object pais_origen_pp: TBDEdit
          Left = 327
          Top = 53
          Width = 30
          Height = 21
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          MaxLength = 2
          TabOrder = 7
          OnChange = pais_origen_ppChange
          OnEnter = pais_origen_ppEnter
          DataField = 'pais_origen_pp'
          DataSource = DSProductos
        end
        object presentacion_pp: TBDEdit
          Left = 583
          Top = 53
          Width = 180
          Height = 21
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          MaxLength = 20
          TabOrder = 8
          DataField = 'presentacion_pp'
          DataSource = DSProductos
        end
        object peso_paleta_pp: TBDEdit
          Left = 79
          Top = 77
          Width = 45
          Height = 21
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          InputType = itReal
          MaxDecimals = 2
          MaxLength = 6
          TabOrder = 10
          DataField = 'peso_paleta_pp'
          DataSource = DSProductos
        end
        object peso_cajas_pp: TBDEdit
          Left = 327
          Top = 77
          Width = 45
          Height = 21
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          InputType = itReal
          MaxDecimals = 2
          MaxLength = 6
          TabOrder = 11
          DataField = 'peso_cajas_pp'
          DataSource = DSProductos
        end
        object cajas_paleta_pp: TBDEdit
          Left = 583
          Top = 77
          Width = 26
          Height = 21
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          InputType = itInteger
          MaxLength = 3
          TabOrder = 12
          DataField = 'cajas_paleta_pp'
          DataSource = DSProductos
        end
        object codigo_ean_pp: TBDEdit
          Left = 583
          Top = 9
          Width = 90
          Height = 21
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          MaxLength = 13
          TabOrder = 2
          DataField = 'codigo_ean_pp'
          DataSource = DSProductos
          Modificable = False
          PrimaryKey = True
        end
        object stProducto: TStaticText
          Left = 371
          Top = 11
          Width = 134
          Height = 17
          AutoSize = False
          BorderStyle = sbsSunken
          TabOrder = 3
        end
        object stPais: TStaticText
          Left = 371
          Top = 55
          Width = 134
          Height = 17
          AutoSize = False
          BorderStyle = sbsSunken
          TabOrder = 9
        end
        object unidades_caja_pp: TBDEdit
          Left = 327
          Top = 99
          Width = 45
          Height = 21
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          InputType = itReal
          MaxDecimals = 2
          MaxLength = 6
          TabOrder = 13
          DataField = 'unidades_caja_pp'
          DataSource = DSProductos
        end
        object unidad_precio_pp: TBDEdit
          Left = 666
          Top = 99
          Width = 26
          Height = 21
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          InputType = itInteger
          Enabled = False
          Visible = False
          ReadOnly = True
          MaxLength = 3
          TabOrder = 15
          OnChange = unidad_precio_ppChange
          DataField = 'unidad_precio_pp'
          DataSource = DSProductos
        end
        object cbxUnidad_precio_pp: TComboBox
          Left = 583
          Top = 99
          Width = 81
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 14
          Text = 'KILOS'
          OnChange = cbxUnidad_precio_ppChange
          OnEnter = cbxUnidad_precio_ppEnter
          OnExit = cbxUnidad_precio_ppExit
          Items.Strings = (
            'KILOS'
            'CAJAS'
            'UNIDADES')
        end
      end
    end
  end
  object RejillaFlotante: TBGrid
    Left = 568
    Top = 80
    Width = 73
    Height = 97
    Color = clInfoBk
    DataSource = DMBaseDatos.DSQGeneral
    FixedColor = clInfoText
    Options = [dgTabs, dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
    ColumnFind = 1
  end
  object DSMaestro: TDataSource
    DataSet = QProveedores
    Left = 104
    Top = 224
  end
  object ACosecheros: TActionList
    Images = DMBaseDatos.ImgBotones
    Top = 104
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
  end
  object QProveedores: TQuery
    AfterOpen = QProveedoresAfterOpen
    BeforeClose = QProveedoresBeforeClose
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_cosecheros'
      'ORDER BY empresa_c, cosechero_c')
    Left = 72
    Top = 224
  end
  object QAlmacenes: TQuery
    OnNewRecord = QAlmacenesNewRecord
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_proveedores_almacen')
    Left = 136
    Top = 224
  end
  object DSAlmacenes: TDataSource
    DataSet = QAlmacenes
    Left = 168
    Top = 224
  end
  object QProductos: TQuery
    OnNewRecord = QProductosNewRecord
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_productos_proveedor'
      '')
    Left = 136
    Top = 256
  end
  object DSProductos: TDataSource
    DataSet = QProductos
    Left = 168
    Top = 256
  end
end
