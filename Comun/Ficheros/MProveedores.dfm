object FMProveedores: TFMProveedores
  Left = 439
  Top = 168
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  PROVEEDORES'
  ClientHeight = 731
  ClientWidth = 903
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
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnKeyDown = FormKeyDown
  DesignSize = (
    903
    731)
  PixelsPerInch = 96
  TextHeight = 13
  object PMaestro: TPanel
    Left = 0
    Top = 0
    Width = 903
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
      Top = 134
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
      Top = 90
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
      Top = 112
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
      Top = 68
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
      Top = 23
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
      Top = 134
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
      Top = 200
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
      Top = 156
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
      Top = 178
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' E-Mail'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label12: TLabel
      Left = 226
      Top = 200
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Forma Pago'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBFormaPago: TBGridButton
      Left = 332
      Top = 199
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
    object Label24: TLabel
      Left = 43
      Top = 45
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
      Top = 44
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
    object lbl2: TLabel
      Left = 351
      Top = 200
      Width = 94
      Height = 19
      AutoSize = False
      Caption = 'Prov. a Liquidar'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object telefono1_p: TBDEdit
      Left = 128
      Top = 133
      Width = 104
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 16
      TabOrder = 8
      DataField = 'telefono1_p'
      DataSource = DSMaestro
    end
    object proveedor_p: TBDEdit
      Left = 128
      Top = 22
      Width = 30
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 3
      TabOrder = 0
      OnExit = proveedor_pExit
      DataField = 'proveedor_p'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object nombre_p: TBDEdit
      Left = 184
      Top = 22
      Width = 209
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 30
      TabOrder = 1
      DataField = 'nombre_p'
      DataSource = DSMaestro
    end
    object domicilio_p: TBDEdit
      Left = 128
      Top = 89
      Width = 337
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 50
      TabOrder = 6
      DataField = 'domicilio_p'
      DataSource = DSMaestro
    end
    object poblacion_p: TBDEdit
      Left = 128
      Top = 111
      Width = 337
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 50
      TabOrder = 7
      DataField = 'poblacion_p'
      DataSource = DSMaestro
    end
    object cod_postal_p: TBDEdit
      Left = 128
      Top = 67
      Width = 40
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 5
      TabOrder = 4
      OnChange = cod_postal_pChange
      DataField = 'cod_postal_p'
      DataSource = DSMaestro
    end
    object STProvincia: TStaticText
      Left = 184
      Top = 69
      Width = 209
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 5
    end
    object telefono2_p: TBDEdit
      Left = 234
      Top = 133
      Width = 104
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 16
      TabOrder = 9
      DataField = 'telefono2_p'
      DataSource = DSMaestro
    end
    object fax_p: TBDEdit
      Left = 360
      Top = 133
      Width = 105
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 16
      TabOrder = 10
      DataField = 'fax_p'
      DataSource = DSMaestro
    end
    object cta_contable_p: TBDEdit
      Left = 128
      Top = 199
      Width = 89
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 8
      TabOrder = 13
      DataField = 'cta_contable_p'
      DataSource = DSMaestro
    end
    object pagina_web_p: TBDEdit
      Left = 128
      Top = 155
      Width = 337
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      CharCase = ecNormal
      MaxLength = 50
      TabOrder = 11
      DataField = 'pagina_web_p'
      DataSource = DSMaestro
    end
    object email_p: TBDEdit
      Left = 128
      Top = 177
      Width = 216
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      CharCase = ecNormal
      MaxLength = 50
      TabOrder = 12
      DataField = 'email_p'
      DataSource = DSMaestro
    end
    object forma_pago_p: TBDEdit
      Left = 310
      Top = 199
      Width = 20
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 2
      TabOrder = 14
      OnChange = forma_pago_pChange
      DataField = 'forma_pago_p'
      DataSource = DSMaestro
    end
    object mmoFormaPago: TMemo
      Left = 43
      Top = 223
      Width = 422
      Height = 58
      TabStop = False
      BevelInner = bvNone
      BevelOuter = bvNone
      Color = clBtnFace
      Ctl3D = False
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 15
    end
    object pais_p: TBDEdit
      Left = 128
      Top = 44
      Width = 24
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 2
      TabOrder = 2
      OnChange = pais_pChange
      DataField = 'pais_p'
      DataSource = DSMaestro
      PrimaryKey = True
    end
    object stPais_p: TStaticText
      Left = 184
      Top = 46
      Width = 209
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 3
    end
    object propio_p: TDBCheckBox
      Left = 447
      Top = 202
      Width = 18
      Height = 17
      DataField = 'propio_p'
      DataSource = DSMaestro
      TabOrder = 16
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 307
    Width = 903
    Height = 424
    ActivePage = tsCostes
    Align = alClient
    TabOrder = 3
    OnChange = PageControlChange
    object tsAlmacenes: TTabSheet
      Caption = 'Almacenes'
      object PAlmacenes: TPanel
        Left = 0
        Top = 0
        Width = 895
        Height = 57
        Align = alTop
        TabOrder = 0
        Visible = False
        object Label1: TLabel
          Left = 21
          Top = 20
          Width = 95
          Height = 19
          AutoSize = False
          Caption = ' C'#243'digo / Nombre'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object lblEmail: TLabel
          Left = 335
          Top = 20
          Width = 43
          Height = 19
          AutoSize = False
          Caption = ' E-Mail'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object lblpais_pa: TLabel
          Left = 562
          Top = 20
          Width = 43
          Height = 19
          AutoSize = False
          Caption = ' Pa'#237's'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object btnPais_pa: TBGridButton
          Left = 634
          Top = 19
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
          Control = pais_pa
          Grid = RejillaFlotante
          GridAlignment = taDownRight
          GridWidth = 280
          GridHeigth = 160
        end
        object almacen_pa: TBDEdit
          Left = 120
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
          Left = 153
          Top = 19
          Width = 180
          Height = 21
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          MaxLength = 30
          TabOrder = 1
          DataField = 'nombre_pa'
          DataSource = DSAlmacenes
        end
        object TBDEdit
          Left = 378
          Top = 19
          Width = 180
          Height = 21
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          MaxLength = 30
          TabOrder = 2
          DataField = 'email_pa'
          DataSource = DSAlmacenes
        end
        object pais_pa: TBDEdit
          Left = 609
          Top = 19
          Width = 24
          Height = 21
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          MaxLength = 2
          TabOrder = 3
          OnChange = pais_paChange
          DataField = 'pais_pa'
          DataSource = DSAlmacenes
          PrimaryKey = True
        end
        object txtPais_pa: TStaticText
          Left = 648
          Top = 21
          Width = 145
          Height = 17
          AutoSize = False
          BorderStyle = sbsSunken
          TabOrder = 4
        end
      end
      object RAlmacenes: TDBGrid
        Left = 0
        Top = 57
        Width = 895
        Height = 339
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
          end
          item
            Expanded = False
            FieldName = 'email_pa'
            Title.Caption = 'E-Mail'
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'pais_pa'
            Title.Alignment = taCenter
            Title.Caption = 'Pa'#237's'
            Visible = True
          end>
      end
    end
    object tsProductos: TTabSheet
      Caption = 'Productos'
      ImageIndex = 1
      object PProductos: TPanel
        Left = 0
        Top = 0
        Width = 895
        Height = 130
        Align = alTop
        TabOrder = 0
        Visible = False
        object Label3: TLabel
          Left = 261
          Top = 6
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
          Left = 358
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
          Left = 353
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
          Left = 12
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
          Left = 265
          Top = 100
          Width = 60
          Height = 19
          AutoSize = False
          Caption = ' Und. Precio'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object lblFechaBaja: TLabel
          Left = 513
          Top = 100
          Width = 60
          Height = 19
          AutoSize = False
          Caption = ' Fecha Baja'
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
          Width = 26
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
          Left = 372
          Top = 11
          Width = 133
          Height = 17
          AutoSize = False
          BorderStyle = sbsSunken
          TabOrder = 3
        end
        object stPais: TStaticText
          Left = 368
          Top = 55
          Width = 137
          Height = 17
          AutoSize = False
          BorderStyle = sbsSunken
          TabOrder = 9
        end
        object unidades_caja_pp: TBDEdit
          Left = 79
          Top = 99
          Width = 45
          Height = 21
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          InputType = itReal
          MaxDecimals = 2
          MaxLength = 6
          TabOrder = 14
          DataField = 'unidades_caja_pp'
          DataSource = DSProductos
        end
        object unidad_precio_pp: TBDEdit
          Left = 407
          Top = 98
          Width = 26
          Height = 21
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          InputType = itInteger
          Enabled = False
          Visible = False
          ReadOnly = True
          MaxLength = 3
          TabOrder = 13
          OnChange = unidad_precio_ppChange
          DataField = 'unidad_precio_pp'
          DataSource = DSProductos
        end
        object cbxUnidad_precio_pp: TComboBox
          Left = 327
          Top = 99
          Width = 81
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 15
          Text = 'KILOS'
          OnChange = cbxUnidad_precio_ppChange
          OnEnter = cbxUnidad_precio_ppEnter
          OnExit = cbxUnidad_precio_ppExit
          Items.Strings = (
            'KILOS'
            'CAJAS'
            'UNIDADES')
        end
        object fecha_baja_pp: TBDEdit
          Left = 583
          Top = 99
          Width = 64
          Height = 21
          HelpType = htKeyword
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          InputType = itDate
          MaxLength = 10
          TabOrder = 16
          DataField = 'fecha_baja_pp'
          DataSource = DSProductos
        end
      end
      object RProductos: TcxGrid
        Left = 0
        Top = 130
        Width = 895
        Height = 266
        Align = alClient
        TabOrder = 1
        LookAndFeel.Kind = lfFlat
        LookAndFeel.NativeStyle = False
        LookAndFeel.SkinName = 'DevExpressStyle'
        object tvDetalleLineas: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          FindPanel.DisplayMode = fpdmAlways
          DataController.DataSource = DSProductos
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'importe_linea_fd'
              Column = tvPesoPaleta
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'importe_total_descuento_fd'
              Column = tvPesoCaja
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'importe_neto_fd'
              Column = tvCajasPaleta
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'importe_impuesto_fd'
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'importe_total_fd'
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              FieldName = 'kilos_fd'
              Column = tvMarca
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.CellHints = True
          OptionsBehavior.FocusCellOnCycle = True
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnMoving = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.GroupByBox = False
          object tvProducto: TcxGridDBColumn
            Caption = 'Prod.'
            DataBinding.FieldName = 'producto_pp'
            Width = 34
          end
          object tvVariedad: TcxGridDBColumn
            Caption = 'Var.'
            DataBinding.FieldName = 'variedad_pp'
            Width = 37
          end
          object tvCodigo_ean: TcxGridDBColumn
            Caption = 'EAN'
            DataBinding.FieldName = 'codigo_ean_pp'
            Width = 106
          end
          object tvDescripcion: TcxGridDBColumn
            Caption = 'Descripcion'
            DataBinding.FieldName = 'descripcion_pp'
            FooterAlignmentHorz = taCenter
            Width = 274
          end
          object tvDescripcionBreve: TcxGridDBColumn
            Caption = 'Desc. Breve'
            DataBinding.FieldName = 'descripcion_breve_pp'
            FooterAlignmentHorz = taCenter
            Width = 186
          end
          object tvMarca: TcxGridDBColumn
            Caption = 'Marca'
            DataBinding.FieldName = 'marca_pp'
            HeaderAlignmentHorz = taCenter
            Width = 90
          end
          object tvPaisOrigen: TcxGridDBColumn
            Caption = 'Pa'#237's'
            DataBinding.FieldName = 'pais_origen_pp'
            HeaderAlignmentHorz = taCenter
            Width = 34
          end
          object tvPresentacion: TcxGridDBColumn
            Caption = 'Presentaci'#243'n'
            DataBinding.FieldName = 'presentacion_pp'
            HeaderAlignmentHorz = taCenter
            Width = 70
          end
          object tvPesoPaleta: TcxGridDBColumn
            Caption = 'P. Paleta'
            DataBinding.FieldName = 'peso_paleta_pp'
            HeaderAlignmentHorz = taCenter
            Width = 24
          end
          object tvPesoCaja: TcxGridDBColumn
            Caption = 'P. Caja'
            DataBinding.FieldName = 'peso_cajas_pp'
            HeaderAlignmentHorz = taCenter
            Width = 32
          end
          object tvCajasPaleta: TcxGridDBColumn
            Caption = 'Cajas Paleta'
            DataBinding.FieldName = 'cajas_paleta_pp'
            HeaderAlignmentHorz = taCenter
            Width = 35
          end
          object tvFechaBaja: TcxGridDBColumn
            Caption = 'Baja'
            DataBinding.FieldName = 'fecha_baja_pp'
            HeaderAlignmentHorz = taCenter
            Width = 53
          end
        end
        object lvDetalleLineas: TcxGridLevel
          GridView = tvDetalleLineas
        end
      end
    end
    object tsCostes: TTabSheet
      Caption = 'Costes de Proveedor'
      ImageIndex = 2
      object rCostes: TDBGrid
        Left = 0
        Top = 73
        Width = 625
        Height = 323
        TabStop = False
        Align = alLeft
        Color = clWhite
        DataSource = dsCostes
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'tipo_coste_pc'
            Title.Alignment = taCenter
            Title.Caption = 'Tipo Coste'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descripcion'
            Title.Caption = 'Descripcion'
            Width = 200
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'importe_pc'
            Title.Alignment = taCenter
            Title.Caption = 'Importe'
            Width = 121
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'fecha_ini_pc'
            Title.Alignment = taCenter
            Title.Caption = 'Fecha Inicio'
            Width = 101
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'fecha_fin_pc'
            Title.Alignment = taCenter
            Title.Caption = 'Fecha Fin'
            Width = 101
            Visible = True
          end>
      end
      object PCostes: TPanel
        Left = 0
        Top = 0
        Width = 895
        Height = 73
        Align = alTop
        TabOrder = 1
        Visible = False
        object lbl3: TLabel
          Left = 17
          Top = 15
          Width = 80
          Height = 19
          AutoSize = False
          Caption = 'Tipo Coste'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object BGBTipoCoste: TBGridButton
          Left = 143
          Top = 14
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
          Control = tipo_coste_pc
          Grid = RejillaFlotante
          GridAlignment = taDownRight
          GridWidth = 280
          GridHeigth = 160
        end
        object lbl4: TLabel
          Left = 17
          Top = 36
          Width = 80
          Height = 19
          AutoSize = False
          Caption = 'Importe'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object lbl5: TLabel
          Left = 215
          Top = 36
          Width = 80
          Height = 19
          AutoSize = False
          Caption = 'Fecha Inicio'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object lbl6: TLabel
          Left = 417
          Top = 36
          Width = 80
          Height = 19
          AutoSize = False
          Caption = 'Fecha Fin'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object tipo_coste_pc: TBDEdit
          Left = 103
          Top = 14
          Width = 39
          Height = 21
          Hint = 'El campo Tipo Coste es obligatorio'
          ColorEdit = clMoneyGreen
          ColorDisable = clWindow
          Required = True
          OnRequiredTime = RequiredTime
          MaxLength = 3
          TabOrder = 0
          OnChange = tipo_coste_pcChange
          DataField = 'tipo_coste_pc'
          DataSource = dsCostes
          Modificable = False
          PrimaryKey = True
        end
        object stDesTipoCoste: TStaticText
          Left = 159
          Top = 16
          Width = 250
          Height = 17
          AutoSize = False
          BorderStyle = sbsSunken
          TabOrder = 1
        end
        object fecha_fin_pc: TnbDBCalendarCombo
          Left = 503
          Top = 36
          Width = 104
          Height = 21
          About = 'NB 0.1/20020725'
          CharCase = ecUpperCase
          Enabled = False
          TabOrder = 3
          DataField = 'fecha_fin_pc'
          DataSource = dsCostes
          DBLink = True
        end
        object fecha_ini_pc: TnbDBCalendarCombo
          Left = 305
          Top = 36
          Width = 104
          Height = 21
          About = 'NB 0.1/20020725'
          CharCase = ecUpperCase
          Enabled = False
          TabOrder = 4
          DataField = 'fecha_ini_pc'
          DataSource = dsCostes
          DBLink = True
          Modificable = False
        end
        object importe_pc: TBDEdit
          Left = 103
          Top = 36
          Width = 90
          Height = 21
          ColorEdit = clMoneyGreen
          OnRequiredTime = RequiredTime
          InputType = itReal
          MaxDecimals = 3
          MaxLength = 13
          TabOrder = 2
          DataField = 'importe_pc'
          DataSource = dsCostes
          PrimaryKey = True
        end
      end
      object rbCostesTodos: TRadioButton
        Left = 635
        Top = 32
        Width = 181
        Height = 17
        Caption = 'Ver todos los Costes'
        TabOrder = 2
        OnClick = rbCostesActivosClick
      end
      object rbCostesActivos: TRadioButton
        Left = 635
        Top = 15
        Width = 181
        Height = 17
        Caption = 'Ver Costes Activos'
        Checked = True
        TabOrder = 3
        TabStop = True
        OnClick = rbCostesActivosClick
      end
    end
  end
  object pnlBoton: TPanel
    Left = 814
    Top = 260
    Width = 81
    Height = 41
    Anchors = [akTop, akRight]
    BevelOuter = bvNone
    TabOrder = 2
  end
  object RejillaFlotante: TBGrid
    Left = 784
    Top = 61
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
    OnDataChange = DSMaestroDataChange
    Left = 608
    Top = 208
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
    object AModificar: TAction
      Caption = 'Modificar'
      ShortCut = 77
      OnExecute = AModificarExecute
    end
  end
  object QProveedores: TQuery
    AfterOpen = QProveedoresAfterOpen
    BeforeClose = QProveedoresBeforeClose
    AfterPost = QProveedoresAfterPost
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_proveedores'
      'ORDER BY proveedor_p')
    Left = 576
    Top = 208
  end
  object QAlmacenes: TQuery
    AfterPost = QAlmacenesAfterPost
    OnNewRecord = QAlmacenesNewRecord
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_proveedores_almacen')
    Left = 640
    Top = 208
  end
  object DSAlmacenes: TDataSource
    DataSet = QAlmacenes
    Left = 608
    Top = 240
  end
  object QProductos: TQuery
    AfterPost = QProductosAfterPost
    OnNewRecord = QProductosNewRecord
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_productos_proveedor'
      '')
    Left = 672
    Top = 208
  end
  object DSProductos: TDataSource
    DataSet = QProductos
    Left = 608
    Top = 272
  end
  object QAlmacenesAux: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_proveedores_almacen')
    Left = 656
    Top = 240
  end
  object QProductosAux: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_productos_proveedor'
      '')
    Left = 656
    Top = 272
  end
  object QCostes: TQuery
    OnCalcFields = QCostesCalcFields
    OnNewRecord = QCostesNewRecord
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_proveedores_costes'
      '')
    Left = 488
    Top = 256
    object QCostesproveedor_pc: TStringField
      FieldName = 'proveedor_pc'
      Origin = 'BDPROYECTO.frf_proveedores_costes.proveedor_pc'
      FixedChar = True
      Size = 3
    end
    object QCostestipo_coste_pc: TStringField
      FieldName = 'tipo_coste_pc'
      Origin = 'BDPROYECTO.frf_proveedores_costes.tipo_coste_pc'
      FixedChar = True
      Size = 2
    end
    object QCostesimporte_pc: TFloatField
      FieldName = 'importe_pc'
      Origin = 'BDPROYECTO.frf_proveedores_costes.importe_pc'
      DisplayFormat = '#0.000'
      EditFormat = '#0.000'
    end
    object QCostesfecha_ini_pc: TDateField
      FieldName = 'fecha_ini_pc'
      Origin = 'BDPROYECTO.frf_proveedores_costes.fecha_ini_pc'
    end
    object QCostesfecha_fin_pc: TDateField
      FieldName = 'fecha_fin_pc'
      Origin = 'BDPROYECTO.frf_proveedores_costes.fecha_fin_pc'
    end
    object QCostesdescripcion: TStringField
      FieldKind = fkCalculated
      FieldName = 'descripcion'
      Size = 50
      Calculated = True
    end
  end
  object dsCostes: TDataSource
    DataSet = QCostes
    Left = 520
    Top = 256
  end
  object qCostesAux: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_proveedores_costes'
      '')
    Left = 560
    Top = 256
  end
end
