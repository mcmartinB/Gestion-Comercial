object FMClientes: TFMClientes
  Left = 411
  Top = 175
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  CLIENTES'
  ClientHeight = 737
  ClientWidth = 1096
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
  OnDeactivate = FormDeactivate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object PDetalle2: TPanel
    Left = 0
    Top = 422
    Width = 1096
    Height = 315
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 2
    object pgcDetalle: TPageControl
      Left = 2
      Top = 2
      Width = 1092
      Height = 311
      ActivePage = tsUnidades
      Align = alClient
      TabOrder = 0
      object tsSuministro: TTabSheet
        Caption = 'Suministros'
        object pnlCabDetalle: TPanel
          Left = 0
          Top = 0
          Width = 1084
          Height = 221
          Align = alTop
          TabOrder = 0
          object LCliente: TLabel
            Left = 37
            Top = 15
            Width = 90
            Height = 19
            AutoSize = False
            Caption = ' Cliente'
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
          end
          object LDireccionD: TLabel
            Left = 35
            Top = 51
            Width = 90
            Height = 21
            AutoSize = False
            Caption = ' Suministro'
            Color = cl3DLight
            ParentColor = False
            Layout = tlCenter
          end
          object LNombreD: TLabel
            Left = 174
            Top = 51
            Width = 77
            Height = 21
            AutoSize = False
            Caption = ' Descripci'#243'n'
            Color = cl3DLight
            ParentColor = False
            Layout = tlCenter
          end
          object LDomicilioD: TLabel
            Left = 35
            Top = 73
            Width = 90
            Height = 21
            AutoSize = False
            Caption = ' Domicilio'
            Color = cl3DLight
            ParentColor = False
            Layout = tlCenter
          end
          object LCodPosD: TLabel
            Left = 35
            Top = 95
            Width = 90
            Height = 21
            AutoSize = False
            Caption = ' C'#243'digo Postal'
            Color = cl3DLight
            ParentColor = False
            Layout = tlCenter
          end
          object LPoblacionD: TLabel
            Left = 35
            Top = 117
            Width = 90
            Height = 21
            AutoSize = False
            Caption = ' Poblaci'#243'n'
            Color = cl3DLight
            ParentColor = False
            Layout = tlCenter
          end
          object LTelefonoD: TLabel
            Left = 547
            Top = 117
            Width = 90
            Height = 21
            AutoSize = False
            Caption = ' Pa'#237's'
            Color = cl3DLight
            ParentColor = False
            Layout = tlCenter
          end
          object BGBtipo_via_ds: TBGridButton
            Left = 174
            Top = 72
            Width = 13
            Height = 23
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
            Control = tipo_via_ds
            Grid = RejillaFlotante
            GridAlignment = taDownRight
            GridWidth = 230
            GridHeigth = 200
          end
          object Label22: TLabel
            Left = 35
            Top = 140
            Width = 90
            Height = 21
            AutoSize = False
            Caption = ' Tel'#233'fono'
            Color = cl3DLight
            ParentColor = False
            Layout = tlCenter
          end
          object lblNif: TLabel
            Left = 547
            Top = 51
            Width = 90
            Height = 21
            AutoSize = False
            Caption = ' NIF'
            Color = cl3DLight
            ParentColor = False
            Layout = tlCenter
          end
          object lblEmail: TLabel
            Left = 246
            Top = 140
            Width = 90
            Height = 21
            AutoSize = False
            Caption = ' Email Albaranes'
            Color = cl3DLight
            ParentColor = False
            Layout = tlCenter
          end
          object lbl7: TLabel
            Left = 246
            Top = 162
            Width = 90
            Height = 21
            AutoSize = False
            Caption = ' Email Facturas'
            Color = cl3DLight
            ParentColor = False
            Layout = tlCenter
          end
          object lblNombre8: TLabel
            Left = 547
            Top = 11
            Width = 87
            Height = 19
            AutoSize = False
            Caption = ' Fecha de Baja'
            Color = clBtnFace
            ParentColor = False
            Layout = tlCenter
          end
          object Label11: TLabel
            Left = 35
            Top = 189
            Width = 90
            Height = 21
            AutoSize = False
            Caption = 'Plataforma'
            Color = cl3DLight
            ParentColor = False
            Layout = tlCenter
          end
          object stCodCliente: TStaticText
            Left = 133
            Top = 17
            Width = 34
            Height = 17
            AutoSize = False
            BorderStyle = sbsSunken
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
          end
          object STCliente_: TStaticText
            Left = 171
            Top = 17
            Width = 242
            Height = 17
            AutoSize = False
            BorderStyle = sbsSunken
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
          end
          object dir_sum_ds: TBDEdit
            Left = 133
            Top = 51
            Width = 41
            Height = 21
            ColorEdit = clMoneyGreen
            Required = True
            RequiredMsg = 
              'El c'#243'digo de la direcci'#243'n de suministro es de obligada inserci'#243'n' +
              '.'
            OnRequiredTime = RequiredTime
            MaxLength = 3
            TabOrder = 3
            OnChange = dir_sum_dsChange
            DataField = 'dir_sum_ds'
            DataSource = DSDetalle
            Modificable = False
            PrimaryKey = True
          end
          object nombre_ds: TBDEdit
            Left = 254
            Top = 51
            Width = 287
            Height = 21
            ColorEdit = clMoneyGreen
            Required = True
            OnRequiredTime = RequiredTime
            MaxLength = 50
            TabOrder = 4
            DataField = 'nombre_ds'
            DataSource = DSDetalle
          end
          object tipo_via_ds: TBDEdit
            Left = 133
            Top = 73
            Width = 41
            Height = 21
            ColorEdit = clMoneyGreen
            MaxLength = 2
            TabOrder = 6
            DataField = 'tipo_via_ds'
            DataSource = DSDetalle
          end
          object domicilio_ds: TBDEdit
            Left = 195
            Top = 73
            Width = 346
            Height = 21
            ColorEdit = clMoneyGreen
            MaxLength = 60
            TabOrder = 7
            DataField = 'domicilio_ds'
            DataSource = DSDetalle
          end
          object cod_postal_ds: TBDEdit
            Left = 133
            Top = 95
            Width = 77
            Height = 21
            ColorEdit = clMoneyGreen
            MaxLength = 10
            TabOrder = 8
            OnChange = cod_postal_dsChange
            DataField = 'cod_postal_ds'
            DataSource = DSDetalle
          end
          object poblacion_ds: TBDEdit
            Left = 133
            Top = 117
            Width = 408
            Height = 21
            ColorEdit = clMoneyGreen
            MaxLength = 30
            TabOrder = 11
            DataField = 'poblacion_ds'
            DataSource = DSDetalle
          end
          object telefono_ds: TBDEdit
            Left = 133
            Top = 140
            Width = 108
            Height = 21
            ColorEdit = clMoneyGreen
            MaxLength = 16
            TabOrder = 14
            DataField = 'telefono_ds'
            DataSource = DSDetalle
          end
          object STProvinciaD: TStaticText
            Left = 213
            Top = 95
            Width = 328
            Height = 19
            AutoSize = False
            BorderStyle = sbsSunken
            TabOrder = 10
          end
          object provincia_ds: TBDEdit
            Left = 211
            Top = 95
            Width = 330
            Height = 21
            ColorEdit = clMoneyGreen
            MaxLength = 30
            TabOrder = 9
            DataField = 'provincia_ds'
            DataSource = DSDetalle
          end
          object pais_ds: TBDEdit
            Left = 645
            Top = 117
            Width = 41
            Height = 21
            ColorEdit = clMoneyGreen
            MaxLength = 8
            TabOrder = 12
            OnChange = pais_dsChange
            DataField = 'pais_ds'
            DataSource = DSDetalle
          end
          object STPaisD: TStaticText
            Left = 687
            Top = 118
            Width = 237
            Height = 19
            AutoSize = False
            BorderStyle = sbsSunken
            TabOrder = 13
          end
          object nif_ds: TBDEdit
            Left = 645
            Top = 51
            Width = 103
            Height = 21
            ColorEdit = clMoneyGreen
            OnRequiredTime = RequiredTime
            MaxLength = 14
            TabOrder = 5
            DataField = 'nif_ds'
            DataSource = DSDetalle
          end
          object Email_ds: TBDEdit
            Left = 341
            Top = 140
            Width = 417
            Height = 21
            ColorEdit = clMoneyGreen
            MaxLength = 125
            TabOrder = 15
            DataField = 'Email_ds'
            DataSource = DSDetalle
          end
          object email_fac_ds: TBDEdit
            Left = 341
            Top = 162
            Width = 417
            Height = 21
            ColorEdit = clMoneyGreen
            MaxLength = 125
            TabOrder = 16
            DataField = 'email_fac_ds'
            DataSource = DSDetalle
          end
          object fecha_baja_ds: TBDEdit
            Left = 645
            Top = 9
            Width = 73
            Height = 21
            InputType = itDate
            TabOrder = 0
            DataField = 'fecha_baja_ds'
            DataSource = DSDetalle
          end
          object plataforma_ds: TBDEdit
            Left = 133
            Top = 189
            Width = 408
            Height = 21
            ColorEdit = clMoneyGreen
            MaxLength = 40
            TabOrder = 17
            DataField = 'plataforma_ds'
            DataSource = DSDetalle
          end
        end
        object Panel1: TPanel
          Left = 922
          Top = 221
          Width = 162
          Height = 62
          Align = alRight
          TabOrder = 2
          object rbSuministroActivos: TRadioButton
            Left = 53
            Top = 29
            Width = 99
            Height = 17
            Caption = 'Ver solo Activas'
            Checked = True
            TabOrder = 1
            TabStop = True
            OnClick = rbVerDireccionActivos
          end
          object rbSuministroBaja: TRadioButton
            Left = 53
            Top = 46
            Width = 99
            Height = 17
            Caption = 'Ver solo Bajas'
            TabOrder = 2
            OnClick = rbVerDireccionActivos
          end
          object rbSuministroTodos: TRadioButton
            Left = 53
            Top = 12
            Width = 99
            Height = 18
            Caption = 'Ver Todas'
            TabOrder = 0
            OnClick = rbVerDireccionActivos
          end
        end
        object RVisualizacion: TDBGrid
          Left = 0
          Top = 221
          Width = 881
          Height = 62
          Align = alLeft
          DataSource = DSDetalle
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          ParentFont = False
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'dir_sum_ds'
              ReadOnly = True
              Title.Alignment = taCenter
              Title.Caption = 'Cod.'
              Width = 56
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'nombre_ds'
              ReadOnly = True
              Title.Alignment = taCenter
              Title.Caption = 'Nombre'
              Width = 223
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'domicilio_ds'
              ReadOnly = True
              Title.Alignment = taCenter
              Title.Caption = 'Domicilio'
              Width = 191
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'cod_postal_ds'
              ReadOnly = True
              Title.Alignment = taCenter
              Title.Caption = 'C.P.'
              Width = 60
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'poblacion_ds'
              ReadOnly = True
              Title.Alignment = taCenter
              Title.Caption = 'Poblaci'#243'n'
              Width = 82
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'provincia_esp_ds'
              Title.Alignment = taCenter
              Title.Caption = 'Provincia'
              Width = 101
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'telefono_ds'
              ReadOnly = True
              Title.Alignment = taCenter
              Title.Caption = 'Tel'#233'fono'
              Width = 61
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'des_pais_ds'
              ReadOnly = True
              Title.Alignment = taCenter
              Title.Caption = 'Pa'#237's'
              Width = 68
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'plataforma_ds'
              Title.Caption = 'Plataforma'
              Width = 223
              Visible = True
            end>
        end
      end
      object tsDescuentos: TTabSheet
        Caption = 'Descuentos'
        ImageIndex = 1
        object lbl5: TLabel
          Left = 904
          Top = 102
          Width = 129
          Height = 78
          Caption = 
            'Los descuentos por '#13#10'cliente se aplican a '#13#10'todos los productos ' +
            #13#10'menos a los que'#13#10'tienen uno espec'#237'fico '#13#10'para ellos.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object btnDescuentos: TBitBtn
          Left = 900
          Top = 69
          Width = 117
          Height = 27
          Caption = 'Por Cliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          TabStop = False
          OnClick = btnDescuentosClick
        end
        object dbgrdComisiones: TDBGrid
          Left = 0
          Top = 0
          Width = 905
          Height = 283
          TabStop = False
          Align = alLeft
          Color = clWhite
          DataSource = DSDescuentos
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
              FieldName = 'empresa'
              Title.Alignment = taCenter
              Title.Caption = 'Emp.'
              Width = 30
              Visible = True
            end
            item
              Alignment = taRightJustify
              Expanded = False
              FieldName = 'fecha_ini'
              Title.Alignment = taCenter
              Title.Caption = 'Inicio'
              Width = 65
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'fecha_fin'
              Title.Alignment = taCenter
              Title.Caption = 'Fin'
              Width = 65
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'centro'
              Title.Alignment = taCenter
              Title.Caption = 'Cen'
              Width = 24
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'producto'
              Title.Alignment = taCenter
              Title.Caption = 'Producto'
              Width = 119
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'porcen_facturable'
              Title.Alignment = taCenter
              Title.Caption = '% Fact.'
              Title.Color = clMenuHighlight
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 62
              Visible = True
            end
            item
              Alignment = taRightJustify
              Expanded = False
              FieldName = 'porcen_no_fact_bruto'
              Title.Alignment = taCenter
              Title.Caption = '%No Fact. BI'
              Title.Color = clMenuHighlight
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 96
              Visible = True
            end
            item
              Alignment = taRightJustify
              Expanded = False
              FieldName = 'porcen_no_fact_neto'
              Title.Alignment = taCenter
              Title.Caption = '%No Fact.TOTAL'
              Title.Color = clMenuHighlight
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 98
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'eurkg_facturable'
              Title.Alignment = taCenter
              Title.Caption = #8364'/Kg Fact.'
              Title.Color = clGradientActiveCaption
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 62
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'eurkg_no_facturable'
              Title.Alignment = taCenter
              Title.Caption = #8364'/Kg No Fac.'
              Title.Color = clGradientActiveCaption
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 78
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'eurpale_facturable'
              Title.Alignment = taCenter
              Title.Caption = #8364'/Pale Fact.'
              Title.Color = clBtnShadow
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 74
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'eurpale_no_facturable'
              Title.Alignment = taCenter
              Title.Caption = #8364'/Pale No Fac.'
              Title.Color = clBtnShadow
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 89
              Visible = True
            end>
        end
        object btnProducto: TBitBtn
          Left = 900
          Top = 40
          Width = 117
          Height = 27
          Caption = 'Por Producto'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          TabStop = False
          OnClick = btnProductoClick
        end
        object rbDescuentosTodos: TRadioButton
          Left = 900
          Top = 17
          Width = 181
          Height = 17
          Caption = 'Ver todos los descuentos'
          TabOrder = 2
          OnClick = rbVerDescuentosClick
        end
        object rbDescuentosActivos: TRadioButton
          Left = 900
          Top = 0
          Width = 181
          Height = 18
          Caption = 'Ver descuentos activos'
          Checked = True
          TabOrder = 1
          TabStop = True
          OnClick = rbVerDescuentosClick
        end
      end
      object tsUnidades: TTabSheet
        Caption = 'Unidades'
        ImageIndex = 2
        object BtnUniFac: TBitBtn
          Left = 887
          Top = 15
          Width = 130
          Height = 27
          Caption = 'Unidad Facturaci'#243'n'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          TabStop = False
          OnClick = BtnUniFacClick
        end
        object DBGrid: TDBGrid
          Left = 0
          Top = 0
          Width = 569
          Height = 283
          TabStop = False
          Align = alLeft
          DataSource = DSUnidades
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
              FieldName = 'empresa_ce'
              Title.Alignment = taCenter
              Title.Caption = 'Empresa'
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'producto_ce'
              Title.Alignment = taCenter
              Title.Caption = 'Prod.'
              Width = 45
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'envase_ce'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = 'Art'#237'culo'
              Width = 80
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'des_envase'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = 'Descripcion'
              Width = 293
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'unidad_fac_ce'
              Title.Caption = 'Facturar Por'
              Width = 72
              Visible = True
            end>
        end
        object DBGridPalets: TDBGrid
          Left = 737
          Top = 0
          Width = 136
          Height = 283
          Align = alLeft
          DataSource = DSUnidades
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          TabOrder = 2
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'n_palets_ce'
              Title.Alignment = taCenter
              Title.Caption = 'Palets'
              Width = 38
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'kgs_palet_ce'
              Title.Alignment = taCenter
              Title.Caption = 'KGS'
              Width = 43
              Visible = True
            end>
        end
        object dbgrdCaducidad: TDBGrid
          Left = 569
          Top = 0
          Width = 168
          Height = 283
          Align = alLeft
          DataSource = DSUnidades
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'caducidad_cliente_ce'
              Title.Caption = 'Caducidad'
              Width = 40
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'min_vida_cliente_ce'
              Title.Caption = 'Min.'
              Width = 40
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'max_vida_cliente_ce'
              Title.Caption = 'Max.'
              Width = 40
              Visible = True
            end>
        end
      end
      object tsRecargo: TTabSheet
        Caption = 'Recargo'
        ImageIndex = 4
        object dbgRecargo: TDBGrid
          Left = 0
          Top = 0
          Width = 294
          Height = 283
          TabStop = False
          Align = alLeft
          Color = clWhite
          DataSource = DSRecargo
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
              FieldName = 'empresa'
              Title.Alignment = taCenter
              Title.Caption = 'Empresa'
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'recargo'
              Title.Alignment = taCenter
              Title.Caption = 'Recargo IVA'
              Visible = True
            end
            item
              Alignment = taRightJustify
              Expanded = False
              FieldName = 'inicio'
              Title.Alignment = taCenter
              Title.Caption = 'Inicio'
              Visible = True
            end
            item
              Alignment = taRightJustify
              Expanded = False
              FieldName = 'fin'
              Title.Alignment = taCenter
              Title.Caption = 'Fin'
              Visible = True
            end>
        end
        object btnRecargo: TBitBtn
          Left = 300
          Top = 3
          Width = 150
          Height = 27
          Caption = 'Recargo IVA'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          TabStop = False
          OnClick = btnRecargoClick
        end
      end
      object tsFormaPago: TTabSheet
        Caption = 'Forma Pago'
        ImageIndex = 3
        object pnlFormaPago: TPanel
          Left = 0
          Top = 0
          Width = 1084
          Height = 283
          Align = alClient
          TabOrder = 0
          object lbl3: TLabel
            Left = 8
            Top = 264
            Width = 118
            Height = 19
            AutoSize = False
            Caption = ' Forma de Pago'
            Color = cl3DLight
            Enabled = False
            ParentColor = False
            Layout = tlCenter
            Visible = False
          end
          object lbl4: TLabel
            Left = 504
            Top = 9
            Width = 84
            Height = 19
            AutoSize = False
            Caption = ' Forma de Pago'
            Color = cl3DLight
            ParentColor = False
            Layout = tlCenter
          end
          object txtst2: TStaticText
            Left = 508
            Top = 62
            Width = 305
            Height = 17
            AutoSize = False
            BorderStyle = sbsSunken
            TabOrder = 4
          end
          object txtst3: TStaticText
            Left = 508
            Top = 79
            Width = 305
            Height = 17
            AutoSize = False
            BorderStyle = sbsSunken
            TabOrder = 5
          end
          object txtst4: TStaticText
            Left = 508
            Top = 97
            Width = 305
            Height = 17
            AutoSize = False
            BorderStyle = sbsSunken
            TabOrder = 6
          end
          object txtst5: TStaticText
            Left = 508
            Top = 114
            Width = 305
            Height = 17
            AutoSize = False
            BorderStyle = sbsSunken
            TabOrder = 7
          end
          object txtst6: TStaticText
            Left = 508
            Top = 132
            Width = 305
            Height = 17
            AutoSize = False
            BorderStyle = sbsSunken
            TabOrder = 8
          end
          object txtst7: TStaticText
            Left = 508
            Top = 150
            Width = 305
            Height = 17
            AutoSize = False
            BorderStyle = sbsSunken
            TabOrder = 9
          end
          object txtst8: TStaticText
            Left = 508
            Top = 185
            Width = 305
            Height = 17
            AutoSize = False
            BorderStyle = sbsSunken
            TabOrder = 11
          end
          object txtst9: TStaticText
            Left = 508
            Top = 167
            Width = 305
            Height = 17
            AutoSize = False
            BorderStyle = sbsSunken
            TabOrder = 10
          end
          object txtst11: TStaticText
            Left = 508
            Top = 44
            Width = 305
            Height = 17
            AutoSize = False
            BorderStyle = sbsSunken
            TabOrder = 3
          end
          object dbgFormaPago: TDBGrid
            Left = 1
            Top = 1
            Width = 501
            Height = 281
            TabStop = False
            Align = alLeft
            Color = clWhite
            DataSource = DSTesoreria
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
                FieldName = 'empresa_ct'
                Title.Alignment = taCenter
                Title.Caption = 'Empresa'
                Visible = True
              end
              item
                Alignment = taCenter
                Expanded = False
                FieldName = 'banco_ct'
                Title.Alignment = taCenter
                Title.Caption = 'Banco'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'des_banco'
                Title.Caption = 'Descripcion'
                Width = 220
                Visible = True
              end
              item
                Alignment = taCenter
                Expanded = False
                FieldName = 'dias_tesoreria_ct'
                Title.Alignment = taCenter
                Title.Caption = 'Dias Prevision'
                Width = 70
                Visible = True
              end
              item
                Alignment = taCenter
                Expanded = False
                FieldName = 'forma_pago_ct'
                Title.Caption = 'Forma Pago'
                Visible = True
              end>
          end
          object btnFormasPago: TBitBtn
            Left = 855
            Top = 15
            Width = 130
            Height = 27
            Caption = 'Forma de Pago'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
            TabStop = False
            OnClick = btnFormasPagoClick
          end
          object forma_pago_ct: TBDEdit
            Left = 588
            Top = 9
            Width = 38
            Height = 21
            ColorEdit = clMoneyGreen
            OnRequiredTime = RequiredTime
            MaxLength = 30
            TabOrder = 1
            DataField = 'forma_pago_ct'
            DataSource = DSTesoreria
          end
        end
      end
      object ts1: TTabSheet
        Caption = 'Riesgo Cliente'
        ImageIndex = 5
        object dbgRiesgo: TDBGrid
          Left = 0
          Top = 0
          Width = 501
          Height = 283
          TabStop = False
          Align = alLeft
          Color = clWhite
          DataSource = dsRiesgo
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
              FieldName = 'empresa_cr'
              Title.Alignment = taCenter
              Title.Caption = 'Empresa'
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'max_riesgo_cr'
              Title.Alignment = taCenter
              Title.Caption = 'Maximo Riesgo (Euro)'
              Width = 121
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'fecha_riesgo_cr'
              Title.Alignment = taCenter
              Title.Caption = 'Fecha Inicio'
              Width = 101
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'fecha_fin_cr'
              Title.Alignment = taCenter
              Title.Caption = 'Fecha Fin'
              Width = 101
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'seguro'
              Title.Alignment = taCenter
              Title.Caption = 'Seguro Cobertura'
              Width = 103
              Visible = True
            end>
        end
        object btnRiesgo: TBitBtn
          Left = 527
          Top = 57
          Width = 130
          Height = 27
          Caption = 'Riesgo Cliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          TabStop = False
          OnClick = btnRiesgoClick
        end
        object rbRiesgosActivos: TRadioButton
          Left = 524
          Top = 0
          Width = 181
          Height = 17
          Caption = 'Ver Riesgo activo'
          Checked = True
          TabOrder = 1
          TabStop = True
          OnClick = rbRiesgosActivosClick
        end
        object rbRiesgosTodos: TRadioButton
          Left = 524
          Top = 17
          Width = 181
          Height = 17
          Caption = 'Ver todos los riesgos'
          TabOrder = 2
          OnClick = rbRiesgosActivosClick
        end
      end
      object tsGastos: TTabSheet
        Caption = 'Gastos Fijos'
        ImageIndex = 6
        object DBGrid1: TDBGrid
          Left = 0
          Top = 0
          Width = 433
          Height = 283
          TabStop = False
          Align = alLeft
          Color = clWhite
          DataSource = dsGastos
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
              FieldName = 'empresa_gc'
              Title.Alignment = taCenter
              Title.Caption = 'Empresa'
              Width = 60
              Visible = True
            end
            item
              Alignment = taRightJustify
              Expanded = False
              FieldName = 'fecha_ini_gc'
              Title.Alignment = taCenter
              Title.Caption = 'Fecha Inicio'
              Width = 100
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'fecha_fin_gc'
              Title.Alignment = taCenter
              Title.Caption = 'Fecha Fin'
              Width = 100
              Visible = True
            end
            item
              Alignment = taRightJustify
              Expanded = False
              FieldName = 'no_facturable_gc'
              Title.Alignment = taCenter
              Title.Caption = #8364'/Kg No Fact.'
              Title.Color = clMenuHighlight
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWindowText
              Title.Font.Height = -11
              Title.Font.Name = 'MS Sans Serif'
              Title.Font.Style = [fsBold]
              Width = 100
              Visible = True
            end>
        end
        object rbGastosActivos: TRadioButton
          Left = 459
          Top = 13
          Width = 181
          Height = 18
          Caption = 'Ver gastos activos'
          Checked = True
          TabOrder = 1
          TabStop = True
          OnClick = rbVerGastosClick
        end
        object rbGastosTodos: TRadioButton
          Left = 459
          Top = 31
          Width = 181
          Height = 17
          Caption = 'Ver todos los gastos'
          TabOrder = 2
          OnClick = rbVerGastosClick
        end
        object btnGastos: TBitBtn
          Left = 459
          Top = 59
          Width = 138
          Height = 27
          Caption = 'Gastos Fijos Cliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          TabStop = False
          OnClick = btnGastosClick
        end
      end
    end
  end
  object PMaestro: TPanel
    Left = 0
    Top = 0
    Width = 1096
    Height = 422
    Align = alTop
    BevelInner = bvLowered
    BevelOuter = bvSpace
    Color = clMedGray
    TabOrder = 0
    object pnlSuperior: TPanel
      Left = 2
      Top = 2
      Width = 1092
      Height = 50
      Align = alTop
      TabOrder = 0
      object LEmpresa_p: TLabel
        Left = 18
        Top = 15
        Width = 58
        Height = 19
        AutoSize = False
        Caption = 'Cliente'
        Color = cl3DLight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
      end
      object lblIvaWeb: TLabel
        Left = 167
        Top = 2
        Width = 3
        Height = 13
      end
      object cliente_c: TBDEdit
        Left = 121
        Top = 15
        Width = 38
        Height = 21
        ColorEdit = clMoneyGreen
        Required = True
        RequiredMsg = 'El c'#243'digo de centro es de obligada inserci'#243'n.'
        OnRequiredTime = RequiredTime
        MaxLength = 3
        TabOrder = 0
        OnChange = cliente_cChange
        DataField = 'cliente_c'
        DataSource = DSMaestro
        PrimaryKey = True
      end
      object nombre_c: TBDEdit
        Left = 167
        Top = 15
        Width = 331
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 50
        TabOrder = 1
        DataField = 'nombre_c'
        DataSource = DSMaestro
      end
    end
    object pnlDerecho: TPanel
      Left = 532
      Top = 52
      Width = 562
      Height = 368
      Align = alClient
      Alignment = taRightJustify
      TabOrder = 2
      object Label13: TLabel
        Left = 8
        Top = 59
        Width = 118
        Height = 19
        AutoSize = False
        Caption = ' Direcci'#243'n Factura'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object BGBDirFactura: TBGridButton
        Left = 170
        Top = 58
        Width = 13
        Height = 22
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
        Control = tipo_via_fac_c
        Grid = RejillaFlotante
        GridAlignment = taDownRight
        GridWidth = 230
        GridHeigth = 200
      end
      object Label19: TLabel
        Left = 8
        Top = 130
        Width = 118
        Height = 19
        AutoSize = False
        Caption = ' Cod. Postal'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label20: TLabel
        Left = 8
        Top = 107
        Width = 118
        Height = 19
        AutoSize = False
        Caption = ' Pa'#237's'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object BGBPaisFactura: TBGridButton
        Left = 170
        Top = 106
        Width = 13
        Height = 22
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
        Control = pais_fac_c
        Grid = RejillaFlotante
        GridAlignment = taDownCenter
        GridWidth = 230
        GridHeigth = 200
      end
      object Label18: TLabel
        Left = 8
        Top = 83
        Width = 118
        Height = 19
        AutoSize = False
        Caption = ' Poblaci'#243'n'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label24: TLabel
        Left = 8
        Top = 154
        Width = 118
        Height = 19
        AutoSize = False
        Caption = ' E-Mail Facturas'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label17: TLabel
        Left = 8
        Top = 179
        Width = 118
        Height = 19
        AutoSize = False
        Caption = ' N'#186' Copias Factura'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object lbl1: TLabel
        Left = 8
        Top = 203
        Width = 118
        Height = 19
        AutoSize = False
        Caption = ' Condici'#243'n Entrega'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object lbl2: TLabel
        Left = 8
        Top = 227
        Width = 118
        Height = 19
        AutoSize = False
        Caption = ' Plaza Entrega'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object BGBincoterm_c: TBGridButton
        Left = 170
        Top = 202
        Width = 13
        Height = 22
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
        Control = incoterm_c
        Grid = RejillaFlotante
        GridAlignment = taDownRight
        GridWidth = 230
        GridHeigth = 200
      end
      object lblNombre3: TLabel
        Left = 8
        Top = 12
        Width = 117
        Height = 19
        AutoSize = False
        Caption = ' Cta. Ingresos P.G.C.'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label25: TLabel
        Left = 8
        Top = 290
        Width = 118
        Height = 19
        AutoSize = False
        Caption = ' M'#225'ximo Riesgo (Euros)'
        Color = cl3DLight
        Enabled = False
        ParentColor = False
        Layout = tlCenter
        Visible = False
      end
      object Label26: TLabel
        Left = 217
        Top = 293
        Width = 101
        Height = 13
        Caption = '(En blanco sin riesgo)'
        Enabled = False
        Visible = False
      end
      object lblFEcha: TLabel
        Left = 369
        Top = 290
        Width = 33
        Height = 19
        AutoSize = False
        Caption = 'Fecha'
        Color = cl3DLight
        Enabled = False
        ParentColor = False
        Layout = tlCenter
        Visible = False
      end
      object Label9: TLabel
        Left = 8
        Top = 35
        Width = 118
        Height = 19
        AutoSize = False
        Caption = ' Moneda'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object BGBmoneda_c: TBGridButton
        Left = 170
        Top = 34
        Width = 13
        Height = 22
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
        Control = moneda_c
        Grid = RejillaFlotante
        GridAlignment = taDownCenter
        GridWidth = 170
        GridHeigth = 200
      end
      object lblCuentaAnalitica: TLabel
        Left = 302
        Top = 12
        Width = 118
        Height = 19
        AutoSize = False
        Caption = ' Cta. Ingresos P.G.A.'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object lblBanco: TLabel
        Left = 8
        Top = 314
        Width = 118
        Height = 19
        AutoSize = False
        Caption = ' Banco'
        Color = cl3DLight
        Enabled = False
        ParentColor = False
        Layout = tlCenter
        Visible = False
      end
      object LAno_semana_p: TLabel
        Left = 8
        Top = 338
        Width = 118
        Height = 19
        AutoSize = False
        Caption = ' Forma de Pago'
        Color = cl3DLight
        Enabled = False
        ParentColor = False
        Layout = tlCenter
        Visible = False
      end
      object btnBanco: TBGridButton
        Left = 162
        Top = 313
        Width = 13
        Height = 22
        Action = ARejillaFlotante
        Enabled = False
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
        Visible = False
        Control = banco_c
        Grid = RejillaFlotante
        GridAlignment = taDownCenter
        GridWidth = 320
        GridHeigth = 200
      end
      object BGBforma_pago_c: TBGridButton
        Left = 171
        Top = 338
        Width = 13
        Height = 22
        Action = ARejillaFlotante
        Enabled = False
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
        Visible = False
        Control = forma_pago_c
        Grid = RejillaFlotante
        GridAlignment = taDownCenter
        GridWidth = 320
        GridHeigth = 200
      end
      object lblcip: TLabel
        Left = 270
        Top = 226
        Width = 118
        Height = 19
        AutoSize = False
        Caption = ' Cod.Interno Proveedor'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object lblTesoreria: TLabel
        Left = 8
        Top = 361
        Width = 118
        Height = 19
        AutoSize = False
        Caption = ' D'#237'as previsi'#243'n tesorer'#237'a'
        Color = cl3DLight
        Enabled = False
        ParentColor = False
        Layout = tlCenter
        Visible = False
      end
      object Label1: TLabel
        Left = 8
        Top = 251
        Width = 118
        Height = 19
        AutoSize = False
        Caption = ' Periodo Facturaci'#243'n'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object tipo_via_fac_c: TBDEdit
        Left = 131
        Top = 58
        Width = 38
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 2
        TabOrder = 5
        DataField = 'tipo_via_fac_c'
        DataSource = DSMaestro
      end
      object domicilio_fac_c: TBDEdit
        Left = 192
        Top = 58
        Width = 305
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 50
        TabOrder = 6
        DataField = 'domicilio_fac_c'
        DataSource = DSMaestro
      end
      object cod_postal_fac_c: TBDEdit
        Left = 131
        Top = 129
        Width = 77
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 10
        TabOrder = 10
        OnChange = cod_postal_fac_cChange
        DataField = 'cod_postal_fac_c'
        DataSource = DSMaestro
      end
      object STProvinciaFactura: TStaticText
        Left = 212
        Top = 131
        Width = 285
        Height = 17
        AutoSize = False
        BorderStyle = sbsSunken
        TabOrder = 11
      end
      object pais_fac_c: TBDEdit
        Left = 131
        Top = 106
        Width = 38
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 2
        TabOrder = 8
        OnChange = pais_fac_cChange
        DataField = 'pais_fac_c'
        DataSource = DSMaestro
      end
      object STPaisFactura: TStaticText
        Left = 192
        Top = 108
        Width = 305
        Height = 17
        AutoSize = False
        BorderStyle = sbsSunken
        TabOrder = 9
      end
      object poblacion_fac_c: TBDEdit
        Left = 131
        Top = 82
        Width = 366
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 50
        TabOrder = 7
        DataField = 'poblacion_fac_c'
        DataSource = DSMaestro
      end
      object email_fac_c: TBDEdit
        Left = 131
        Top = 153
        Width = 366
        Height = 21
        ColorEdit = clMoneyGreen
        CharCase = ecLowerCase
        TabOrder = 12
        DataField = 'email_fac_c'
        DataSource = DSMaestro
      end
      object n_copias_fac_c: TBDEdit
        Left = 131
        Top = 178
        Width = 38
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        InputType = itInteger
        TabOrder = 13
        DataField = 'n_copias_fac_c'
        DataSource = DSMaestro
      end
      object edi_c: TDBCheckBox
        Left = 359
        Top = 36
        Width = 138
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Facturaci'#243'n EDI'
        DataField = 'edi_c'
        DataSource = DSMaestro
        TabOrder = 4
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object incoterm_c: TBDEdit
        Left = 131
        Top = 202
        Width = 35
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 3
        TabOrder = 14
        OnChange = incoterm_cChange
        DataField = 'incoterm_c'
        DataSource = DSMaestro
      end
      object plaza_incoterm_c: TBDEdit
        Left = 131
        Top = 226
        Width = 135
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 30
        TabOrder = 17
        DataField = 'plaza_incoterm_c'
        DataSource = DSMaestro
      end
      object stIncoterm: TStaticText
        Left = 185
        Top = 204
        Width = 312
        Height = 17
        AutoSize = False
        BorderStyle = sbsSunken
        TabOrder = 15
      end
      object cta_ingresos_pgc_c: TBDEdit
        Left = 131
        Top = 11
        Width = 74
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 8
        TabOrder = 0
        DataField = 'cta_ingresos_pgc_c'
        DataSource = DSMaestro
      end
      object max_riesgo_c: TBDEdit
        Left = 131
        Top = 289
        Width = 85
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        InputType = itReal
        MaxDecimals = 2
        ShowDecimals = True
        Enabled = False
        Visible = False
        MaxLength = 13
        TabOrder = 20
        DataField = 'max_riesgo_c'
        DataSource = DSMaestro
      end
      object fecha_riesgo_c: TBDEdit
        Left = 417
        Top = 289
        Width = 80
        Height = 21
        InputType = itDate
        Enabled = False
        Visible = False
        TabOrder = 21
        DataField = 'fecha_riesgo_c'
        DataSource = DSMaestro
      end
      object seguro_c: TDBCheckBox
        Left = 362
        Top = 251
        Width = 135
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Seguro de Cobertura'
        DataField = 'seguro_c'
        DataSource = DSMaestro
        Enabled = False
        TabOrder = 19
        ValueChecked = '1'
        ValueUnchecked = '0'
        Visible = False
      end
      object moneda_c: TBDEdit
        Left = 132
        Top = 32
        Width = 38
        Height = 21
        ColorEdit = clMoneyGreen
        Zeros = True
        Required = True
        RequiredMsg = 'La moneda del cliente es obligatoria.'
        OnRequiredTime = RequiredTime
        MaxLength = 3
        TabOrder = 2
        OnChange = moneda_cChange
        DataField = 'moneda_c'
        DataSource = DSMaestro
      end
      object STMoneda_c: TStaticText
        Left = 192
        Top = 36
        Width = 159
        Height = 17
        AutoSize = False
        BorderStyle = sbsSunken
        TabOrder = 3
      end
      object cta_ingresos_pga_c: TBDEdit
        Left = 423
        Top = 11
        Width = 74
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 8
        TabOrder = 1
        DataField = 'cta_ingresos_pga_c'
        DataSource = DSMaestro
      end
      object banco_c: TBDEdit
        Left = 132
        Top = 311
        Width = 33
        Height = 21
        ColorEdit = clMoneyGreen
        Zeros = True
        OnRequiredTime = RequiredTime
        Enabled = False
        Visible = False
        MaxLength = 3
        TabOrder = 22
        OnChange = banco_cChange
        DataField = 'banco_c'
        DataSource = DSMaestro
      end
      object forma_pago_c: TBDEdit
        Left = 131
        Top = 337
        Width = 38
        Height = 21
        ColorEdit = clMoneyGreen
        Zeros = True
        OnRequiredTime = RequiredTime
        Enabled = False
        Visible = False
        MaxLength = 2
        TabOrder = 24
        OnChange = forma_pago_cChange
        DataField = 'forma_pago_c'
        DataSource = DSMaestro
      end
      object txtBanco: TStaticText
        Left = 192
        Top = 315
        Width = 305
        Height = 17
        AutoSize = False
        BorderStyle = sbsSunken
        Enabled = False
        TabOrder = 23
        Visible = False
      end
      object txtst1: TStaticText
        Left = 192
        Top = 339
        Width = 305
        Height = 17
        AutoSize = False
        BorderStyle = sbsSunken
        Enabled = False
        TabOrder = 25
        Visible = False
      end
      object cip_c: TBDEdit
        Left = 392
        Top = 225
        Width = 105
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        CharCase = ecNormal
        MaxLength = 15
        TabOrder = 16
        DataField = 'cip_c'
        DataSource = DSMaestro
      end
      object dias_tesoreria_c: TBDEdit
        Left = 131
        Top = 360
        Width = 30
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        InputType = itInteger
        Enabled = False
        Visible = False
        MaxLength = 2
        TabOrder = 26
        DataField = 'dias_tesoreria_c'
        DataSource = DSMaestro
      end
      object periodo_factura_c: TDBComboBox
        Left = 131
        Top = 250
        Width = 135
        Height = 21
        Style = csDropDownList
        DataField = 'periodo_factura_c'
        DataSource = DSMaestro
        ItemHeight = 13
        Items.Strings = (
          'D - Diaria'
          'S - Semanal'
          'Q - Quincenal'
          'M - Mensual'
          '')
        TabOrder = 18
      end
      object albaran_factura_c: TComboBox
        Left = 304
        Top = 177
        Width = 193
        Height = 21
        ItemHeight = 13
        TabOrder = 27
        OnChange = albaran_factura_cChange
        Items.Strings = (
          'Agrupaci'#243'n Albaranes por factura'
          'Un Albaran por factura'
          'Agrupaci'#243'n Dir. Suministro por factura')
      end
    end
    object Pago: TPanel
      Left = 2
      Top = 52
      Width = 530
      Height = 368
      Align = alLeft
      Constraints.MinWidth = 500
      TabOrder = 1
      object Label2: TLabel
        Left = 9
        Top = 58
        Width = 101
        Height = 19
        AutoSize = False
        Caption = ' Direcci'#243'n Social'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object BGBtipo_via_c: TBGridButton
        Left = 142
        Top = 57
        Width = 13
        Height = 22
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
        Control = tipo_via_c
        Grid = RejillaFlotante
        GridAlignment = taDownRight
        GridWidth = 230
        GridHeigth = 200
      end
      object Label3: TLabel
        Left = 9
        Top = 82
        Width = 101
        Height = 19
        AutoSize = False
        Caption = ' Poblaci'#243'n'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label4: TLabel
        Left = 9
        Top = 106
        Width = 101
        Height = 19
        AutoSize = False
        Caption = ' Pa'#237's'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label6: TLabel
        Left = 9
        Top = 130
        Width = 101
        Height = 19
        AutoSize = False
        Caption = ' Cod. Postal'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object BGBpais_c: TBGridButton
        Left = 141
        Top = 102
        Width = 13
        Height = 22
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
        Control = pais_c
        Grid = RejillaFlotante
        GridAlignment = taDownCenter
        GridWidth = 230
        GridHeigth = 200
      end
      object Label10: TLabel
        Left = 9
        Top = 202
        Width = 101
        Height = 19
        AutoSize = False
        Caption = ' Tel'#233'fonos'
        Color = cl3DLight
        ParentColor = False
      end
      object Label8: TLabel
        Left = 9
        Top = 12
        Width = 101
        Height = 19
        AutoSize = False
        Caption = ' Cif'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label7: TLabel
        Left = 9
        Top = 226
        Width = 101
        Height = 19
        AutoSize = False
        Caption = ' Representante'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object BGBrepresentante_c: TBGridButton
        Left = 142
        Top = 225
        Width = 13
        Height = 22
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
        Control = representante_c
        Grid = RejillaFlotante
        GridAlignment = taDownCenter
        GridWidth = 245
        GridHeigth = 200
      end
      object Label5: TLabel
        Left = 9
        Top = 250
        Width = 101
        Height = 19
        AutoSize = False
        Caption = ' Resp. Compras'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label21: TLabel
        Left = 9
        Top = 153
        Width = 101
        Height = 19
        AutoSize = False
        Caption = ' N'#186' Copias Albar'#225'n'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label23: TLabel
        Left = 9
        Top = 177
        Width = 101
        Height = 19
        AutoSize = False
        Caption = ' E-Mail Albaranes'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label28: TLabel
        Left = 313
        Top = 203
        Width = 27
        Height = 19
        AutoSize = False
        Caption = ' Fax'
        Color = cl3DLight
        ParentColor = False
      end
      object lblNotas: TLabel
        Left = 9
        Top = 274
        Width = 31
        Height = 13
        Caption = ' Notas'
      end
      object lblNombre2: TLabel
        Left = 381
        Top = 11
        Width = 52
        Height = 19
        AutoSize = False
        Caption = 'C'#243'digo X3'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object lbl6: TLabel
        Left = 9
        Top = 35
        Width = 101
        Height = 19
        AutoSize = False
        Caption = ' Tipo Cliente'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object btnTipoCliente: TBGridButton
        Left = 142
        Top = 34
        Width = 13
        Height = 22
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
        Control = tipo_cliente_c
        Grid = RejillaFlotante
        GridAlignment = taDownCenter
        GridWidth = 245
        GridHeigth = 200
      end
      object lblTipoAlbaran: TLabel
        Left = 142
        Top = 154
        Width = 39
        Height = 19
        AutoSize = False
        Caption = 'Tipo'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object lbl8: TLabel
        Left = 200
        Top = 12
        Width = 26
        Height = 13
        Caption = 'EORI'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object tipo_via_c: TBDEdit
        Left = 104
        Top = 58
        Width = 38
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 2
        TabOrder = 6
        DataField = 'tipo_via_c'
        DataSource = DSMaestro
      end
      object domicilio_c: TBDEdit
        Left = 161
        Top = 55
        Width = 308
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 60
        TabOrder = 5
        DataField = 'domicilio_c'
        DataSource = DSMaestro
      end
      object poblacion_c: TBDEdit
        Left = 104
        Top = 82
        Width = 366
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 50
        TabOrder = 7
        DataField = 'poblacion_c'
        DataSource = DSMaestro
      end
      object pais_c: TBDEdit
        Left = 104
        Top = 106
        Width = 38
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 2
        TabOrder = 8
        OnChange = pais_cChange
        DataField = 'pais_c'
        DataSource = DSMaestro
      end
      object cod_postal_c: TBDEdit
        Left = 104
        Top = 130
        Width = 77
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 10
        TabOrder = 11
        OnChange = cod_postal_cChange
        DataField = 'cod_postal_c'
        DataSource = DSMaestro
      end
      object STProvincia: TStaticText
        Left = 182
        Top = 132
        Width = 288
        Height = 17
        AutoSize = False
        BorderStyle = sbsSunken
        TabOrder = 12
      end
      object STPais_c: TStaticText
        Left = 165
        Top = 108
        Width = 214
        Height = 17
        AutoSize = False
        BorderStyle = sbsSunken
        TabOrder = 9
      end
      object telefono_c: TBDEdit
        Left = 104
        Top = 202
        Width = 102
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 16
        TabOrder = 18
        DataField = 'telefono_c'
        DataSource = DSMaestro
      end
      object nif_c: TBDEdit
        Left = 104
        Top = 12
        Width = 90
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 14
        TabOrder = 0
        DataField = 'nif_c'
        DataSource = DSMaestro
      end
      object representante_c: TBDEdit
        Left = 104
        Top = 226
        Width = 38
        Height = 21
        ColorEdit = clMoneyGreen
        Zeros = True
        RequiredMsg = 'El c'#243'digo del representante es de obligada inserci'#243'n.'
        OnRequiredTime = RequiredTime
        MaxLength = 2
        TabOrder = 21
        OnChange = representante_cChange
        DataField = 'representante_c'
        DataSource = DSMaestro
      end
      object STRepresentante_c: TStaticText
        Left = 162
        Top = 228
        Width = 308
        Height = 17
        AutoSize = False
        BorderStyle = sbsSunken
        TabOrder = 22
      end
      object resp_compras_c: TBDEdit
        Left = 104
        Top = 250
        Width = 366
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 30
        TabOrder = 23
        DataField = 'resp_compras_c'
        DataSource = DSMaestro
      end
      object es_comunitario_c: TDBCheckBox
        Left = 389
        Top = 108
        Width = 81
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Comunitario'
        DataField = 'es_comunitario_c'
        DataSource = DSMaestro
        TabOrder = 10
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object n_copias_alb_c: TBDEdit
        Left = 104
        Top = 153
        Width = 38
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        InputType = itInteger
        TabOrder = 13
        DataField = 'n_copias_alb_c'
        DataSource = DSMaestro
      end
      object email_alb_c: TBDEdit
        Left = 104
        Top = 177
        Width = 366
        Height = 21
        ColorEdit = clMoneyGreen
        CharCase = ecLowerCase
        TabOrder = 17
        DataField = 'email_alb_c'
        DataSource = DSMaestro
      end
      object telefono2_c: TBDEdit
        Left = 209
        Top = 202
        Width = 102
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 16
        TabOrder = 19
        DataField = 'telefono2_c'
        DataSource = DSMaestro
      end
      object fax_c: TBDEdit
        Left = 368
        Top = 202
        Width = 102
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 16
        TabOrder = 20
        DataField = 'fax_c'
        DataSource = DSMaestro
      end
      object notas_c: TDBMemo
        Left = 104
        Top = 275
        Width = 366
        Height = 79
        DataField = 'notas_c'
        DataSource = DSMaestro
        TabOrder = 24
      end
      object cta_cliente_c: TBDEdit
        Left = 435
        Top = 10
        Width = 88
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 10
        TabOrder = 2
        DataField = 'cta_cliente_c'
        DataSource = DSMaestro
      end
      object tipo_cliente_c: TBDEdit
        Left = 104
        Top = 35
        Width = 38
        Height = 21
        ColorEdit = clMoneyGreen
        Zeros = True
        OnRequiredTime = RequiredTime
        MaxLength = 2
        TabOrder = 3
        OnChange = tipo_cliente_cChange
        DataField = 'tipo_cliente_c'
        DataSource = DSMaestro
      end
      object stTipoCliente: TStaticText
        Left = 162
        Top = 37
        Width = 308
        Height = 17
        AutoSize = False
        BorderStyle = sbsSunken
        TabOrder = 4
      end
      object grabrar_transporte_c: TDBCheckBox
        Left = 383
        Top = 154
        Width = 87
        Height = 20
        Alignment = taLeftJustify
        Caption = 'Grabar  portes '
        DataField = 'grabrar_transporte_c'
        DataSource = DSMaestro
        TabOrder = 15
        ValueChecked = '1'
        ValueUnchecked = '0'
      end
      object tipo_albaran_c: TDBComboBox
        Left = 182
        Top = 153
        Width = 38
        Height = 21
        Style = csDropDownList
        DataField = 'tipo_albaran_c'
        DataSource = DSMaestro
        ItemHeight = 13
        Items.Strings = (
          '0'
          '1'
          '2'
          '3')
        TabOrder = 14
        OnChange = tipo_albaran_cChange
      end
      object des_tipo_albaran_c: TStaticText
        Left = 222
        Top = 155
        Width = 153
        Height = 17
        AutoSize = False
        BorderStyle = sbsSunken
        TabOrder = 16
      end
      object eori_cliente_c: TBDEdit
        Left = 232
        Top = 10
        Width = 143
        Height = 21
        ColorEdit = clMoneyGreen
        MaxLength = 17
        TabOrder = 1
        DataField = 'eori_cliente_c'
        DataSource = DSMaestro
      end
    end
  end
  object RejillaFlotante: TBGrid
    Left = 1046
    Top = 384
    Width = 41
    Height = 57
    Color = clInfoBk
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
  end
  object DSMaestro: TDataSource
    DataSet = QClientes
    OnDataChange = DSMaestroDataChange
    Left = 944
  end
  object ACosecheros: TActionList
    Images = DMBaseDatos.ImgBotones
    Left = 1016
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
  end
  object DSDetalle: TDataSource
    DataSet = QSuministro
    Left = 984
    Top = 545
  end
  object QDirClientes: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSSuministros
    SQL.Strings = (
      
        'SELECT dir_sum_ds, nombre_ds, tipo_via_ds, domicilio_ds, cod_pos' +
        'tal_ds,'
      '       poblacion_ds,  telefono_ds,  provincia_ds, pais_ds'
      'FROM   frf_dir_sum'
      'WHERE cliente_ds = :cliente_c'
      ''
      ' ')
    Left = 984
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'cliente_c'
        ParamType = ptUnknown
      end>
  end
  object DSSuministros: TDataSource
    Left = 1061
    Top = 536
  end
  object DSDescuentos: TDataSource
    DataSet = QDescuentos
    Left = 1056
    Top = 584
  end
  object QAuxCli: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM frf_clientes2 Frf_clientes2'
      'ORDER BY nombre_c')
    Left = 1056
  end
  object QUnidades: TQuery
    OnCalcFields = QUnidadesCalcFields
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    SQL.Strings = (
      'select *'
      'from frf_clientes_env')
    Left = 1051
    Top = 460
    object strngfldQUnidadesempresa_ce: TStringField
      FieldName = 'empresa_ce'
      Origin = 'COMERCIALIZACION.frf_clientes_env.empresa_ce'
      FixedChar = True
      Size = 3
    end
    object strngfldQUnidadesenvase_ce: TStringField
      FieldName = 'envase_ce'
      Origin = 'COMERCIALIZACION.frf_clientes_env.envase_ce'
      FixedChar = True
      Size = 3
    end
    object strngfldQUnidadescliente_ce: TStringField
      FieldName = 'cliente_ce'
      Origin = 'COMERCIALIZACION.frf_clientes_env.cliente_ce'
      FixedChar = True
      Size = 3
    end
    object QUnidadesproducto_ce: TStringField
      FieldName = 'producto_ce'
      Origin = 'BDPROYECTO.frf_clientes_env.producto_ce'
      FixedChar = True
      Size = 3
    end
    object strngfldQUnidadesunidad_fac_ce: TStringField
      FieldName = 'unidad_fac_ce'
      Origin = 'COMERCIALIZACION.frf_clientes_env.unidad_fac_ce'
      FixedChar = True
      Size = 1
    end
    object strngfldQUnidadesdescripcion_ce: TStringField
      FieldName = 'descripcion_ce'
      Origin = 'COMERCIALIZACION.frf_clientes_env.descripcion_ce'
      Size = 30
    end
    object QUnidadesn_palets_ce: TSmallintField
      FieldName = 'n_palets_ce'
      Origin = '"COMER.DESARROLLO".frf_clientes_env.n_palets_ce'
    end
    object QUnidadeskgs_palet_ce: TSmallintField
      FieldName = 'kgs_palet_ce'
      Origin = '"COMER.DESARROLLO".frf_clientes_env.kgs_palet_ce'
    end
    object intgrfldQUnidadescaducidad_cliente_ce: TIntegerField
      FieldName = 'caducidad_cliente_ce'
      Origin = 'BDPROYECTO.frf_clientes_env.caducidad_cliente_ce'
    end
    object intgrfldQUnidadesmin_vida_cliente_ce: TIntegerField
      FieldName = 'min_vida_cliente_ce'
      Origin = 'BDPROYECTO.frf_clientes_env.min_vida_cliente_ce'
    end
    object intgrfldQUnidadesmax_vida_cliente_ce: TIntegerField
      FieldName = 'max_vida_cliente_ce'
      Origin = 'BDPROYECTO.frf_clientes_env.max_vida_cliente_ce'
    end
    object strngfldQUnidadesdes_envase: TStringField
      FieldKind = fkCalculated
      FieldName = 'des_envase'
      Size = 50
      Calculated = True
    end
  end
  object DSUnidades: TDataSource
    AutoEdit = False
    DataSet = QUnidades
    Left = 1028
    Top = 580
  end
  object QRecargo: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    SQL.Strings = (
      'select descuento_cd descuento, facturable_cd facturable,'
      '       fecha_ini_cd inicio, fecha_fin_cd fin'
      'from frf_clientes_descuento'
      'where empresa_cd = '#39'050'#39
      'and cliente_cd = '#39'ED'#39
      'order by inicio desc')
    Left = 1024
    Top = 504
  end
  object DSRecargo: TDataSource
    DataSet = QRecargo
    Left = 1024
    Top = 544
  end
  object QClientes: TQuery
    AfterOpen = QClientesAfterOpen
    BeforeClose = QClientesBeforeClose
    AfterPost = QClientesAfterPost
    AfterScroll = QClientesAfterScroll
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'select * from frf_clientes'
      'order by cliente_c'
      '')
    Left = 1024
    Top = 32
  end
  object QDescuentos: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    SQL.Strings = (
      'select facturable_dc facturable, no_facturable_dc descuento,  '
      '        fecha_ini_dc inicio, fecha_fin_dc fin  '
      ' from frf_descuentos_cliente')
    Left = 1064
    Top = 504
  end
  object DSTesoreria: TDataSource
    DataSet = QTesoreria
    OnDataChange = DSTesoreriaDataChange
    Left = 988
    Top = 612
  end
  object QTesoreria: TQuery
    OnCalcFields = QTesoreriaCalcFields
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    SQL.Strings = (
      'select *'
      'from frf_clientes_tes')
    Left = 992
    Top = 504
    object QTesoreriaempresa_ct: TStringField
      FieldName = 'empresa_ct'
      Origin = 'BDPROYECTO.frf_clientes_tes.empresa_ct'
      FixedChar = True
      Size = 3
    end
    object QTesoreriacliente_ct: TStringField
      FieldName = 'cliente_ct'
      Origin = 'BDPROYECTO.frf_clientes_tes.cliente_ct'
      FixedChar = True
      Size = 3
    end
    object QTesoreriabanco_ct: TStringField
      FieldName = 'banco_ct'
      Origin = 'BDPROYECTO.frf_clientes_tes.banco_ct'
      FixedChar = True
      Size = 3
    end
    object QTesoreriaforma_pago_ct: TStringField
      FieldName = 'forma_pago_ct'
      Origin = 'BDPROYECTO.frf_clientes_tes.forma_pago_ct'
      FixedChar = True
      Size = 2
    end
    object iQTesoreriadias_tesoreria_ct: TIntegerField
      FieldName = 'dias_tesoreria_ct'
      Origin = 'BDPROYECTO.frf_clientes_tes.dias_tesoreria_ct'
    end
    object QTesoreriades_banco: TStringField
      FieldKind = fkCalculated
      FieldName = 'des_banco'
      Size = 50
      Calculated = True
    end
  end
  object dsRiesgo: TDataSource
    DataSet = QRiesgo
    Left = 1036
    Top = 620
  end
  object QRiesgo: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    SQL.Strings = (
      
        'Select empresa_cr, cliente_cr, max_riesgo_cr, fecha_riesgo_cr, f' +
        'echa_fin_cr, case when seguro_cr = 0 then '#39'NO'#39' else '#39'SI'#39' end seg' +
        'uro'
      '  from frf_clientes_rie')
    Left = 992
    Top = 464
    object QRiesgoempresa_cr: TStringField
      FieldName = 'empresa_cr'
      Origin = 'BDPROYECTO.frf_clientes_rie.empresa_cr'
      FixedChar = True
      Size = 3
    end
    object QRiesgocliente_cr: TStringField
      FieldName = 'cliente_cr'
      Origin = 'BDPROYECTO.frf_clientes_rie.cliente_cr'
      FixedChar = True
      Size = 3
    end
    object QRiesgomax_riesgo_cr: TFloatField
      FieldName = 'max_riesgo_cr'
      Origin = 'BDPROYECTO.frf_clientes_rie.max_riesgo_cr'
    end
    object QRiesgofecha_riesgo_cr: TDateField
      FieldName = 'fecha_riesgo_cr'
      Origin = 'BDPROYECTO.frf_clientes_rie.fecha_riesgo_cr'
    end
    object QRiesgoseguro: TStringField
      FieldName = 'seguro'
      FixedChar = True
      Size = 2
    end
    object QRiesgofecha_fin_cr: TDateField
      FieldName = 'fecha_fin_cr'
    end
  end
  object dsGastos: TDataSource
    DataSet = qGastos
    Left = 992
    Top = 584
  end
  object qGastos: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    SQL.Strings = (
      'select no_facturable_gc gasto,  '
      '        fecha_ini_gc inicio, fecha_fin_gc fin  '
      ' from frf_gastos_cliente')
    Left = 960
    Top = 504
  end
  object QSuministro: TQuery
    OnCalcFields = QSuministroCalcFields
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    RequestLive = True
    SQL.Strings = (
      'select facturable_dc facturable, no_facturable_dc descuento,  '
      '        fecha_ini_dc inicio, fecha_fin_dc fin  '
      ' from frf_descuentos_cliente')
    Left = 959
    Top = 464
    object QSuministrocliente_ds: TStringField
      FieldName = 'cliente_ds'
    end
    object QSuministrodir_sum_ds: TStringField
      FieldName = 'dir_sum_ds'
    end
    object QSuministronombre_ds: TStringField
      DisplayWidth = 50
      FieldName = 'nombre_ds'
      Size = 50
    end
    object QSuministronif_ds: TStringField
      FieldName = 'nif_ds'
    end
    object QSuministrotipo_via_ds: TStringField
      FieldName = 'tipo_via_ds'
    end
    object QSuministrodomicilio_ds: TStringField
      DisplayWidth = 60
      FieldName = 'domicilio_ds'
      Size = 60
    end
    object QSuministrocod_postal_ds: TStringField
      FieldName = 'cod_postal_ds'
    end
    object QSuministroprovincia_ds: TStringField
      DisplayWidth = 30
      FieldName = 'provincia_ds'
      Size = 30
    end
    object QSuministropoblacion_ds: TStringField
      DisplayWidth = 30
      FieldName = 'poblacion_ds'
      Size = 30
    end
    object QSuministropais_ds: TStringField
      FieldName = 'pais_ds'
    end
    object QSuministrotelefono_ds: TStringField
      FieldName = 'telefono_ds'
    end
    object QSuministroemail_ds: TStringField
      DisplayWidth = 255
      FieldName = 'email_ds'
      Size = 255
    end
    object QSuministroemail_fac_ds: TStringField
      DisplayWidth = 255
      FieldName = 'email_fac_ds'
      Size = 255
    end
    object QSuministroprovincia_esp_ds: TStringField
      DisplayWidth = 30
      FieldKind = fkCalculated
      FieldName = 'provincia_esp_ds'
      Size = 30
      Calculated = True
    end
    object QSuministrodes_pais_ds: TStringField
      DisplayWidth = 50
      FieldKind = fkCalculated
      FieldName = 'des_pais_ds'
      Size = 50
      Calculated = True
    end
    object QSuministroplataforma_ds: TStringField
      FieldName = 'plataforma_ds'
      Size = 40
    end
    object QSuministrofecha_baja_ds: TDateField
      FieldName = 'fecha_baja_ds'
    end
  end
end
