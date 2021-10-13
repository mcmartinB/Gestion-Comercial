object FMRemesas: TFMRemesas
  Left = 383
  Top = 147
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    REMESAS DE COBROS (GENERAL)'
  ClientHeight = 559
  ClientWidth = 659
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
    Width = 659
    Height = 289
    Align = alTop
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Bevel1: TBevel
      Left = 47
      Top = 95
      Width = 556
      Height = 3
      Style = bsRaised
    end
    object LPlantacion_p: TLabel
      Left = 47
      Top = 108
      Width = 156
      Height = 19
      AutoSize = False
      Caption = ' Moneda'
      Color = cl3DLight
      ParentColor = False
    end
    object LFecha_inicio_p: TLabel
      Left = 268
      Top = 45
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Fecha'
      Color = cl3DLight
      ParentColor = False
    end
    object BCFecha: TBCalendarButton
      Left = 440
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
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00000000BFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FF00000000000000000000000000FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00000000000000000000000000000000000000
        00BFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
        000000000000FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      Control = fecha_r
      Calendar = CalendarioFlotante
      CalendarAlignment = taDownLeft
      CalendarWidth = 197
      CalendarHeigth = 153
    end
    object LEmpresa_p: TLabel
      Left = 89
      Top = 23
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
    end
    object BGEmpresa: TBGridButton
      Left = 219
      Top = 21
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
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00000000BFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FF00000000000000000000000000FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00000000000000000000000000000000000000
        00BFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
        000000000000FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      Control = empresa_r
      Grid = RejillaFlotante
      GridAlignment = taDownCenter
      GridWidth = 280
      GridHeigth = 200
    end
    object Label1: TLabel
      Left = 89
      Top = 45
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Referencia'
      Color = cl3DLight
      ParentColor = False
    end
    object Label2: TLabel
      Left = 89
      Top = 67
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Banco'
      Color = cl3DLight
      ParentColor = False
    end
    object BGBanco: TBGridButton
      Left = 219
      Top = 65
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
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00000000BFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FF00000000000000000000000000FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00000000000000000000000000000000000000
        00BFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
        000000000000FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      Control = banco_r
      Grid = RejillaFlotante
      GridAlignment = taDownCenter
      GridWidth = 280
      GridHeigth = 200
    end
    object lblImporte: TLabel
      Left = 213
      Top = 108
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Importe'
      Color = cl3DLight
      ParentColor = False
    end
    object Label4: TLabel
      Left = 313
      Top = 108
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Importe (Euros)'
      Color = cl3DLight
      ParentColor = False
    end
    object Label5: TLabel
      Left = 413
      Top = 108
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Gastos (Euros)'
      Color = cl3DLight
      ParentColor = False
    end
    object Label6: TLabel
      Left = 513
      Top = 108
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Neto (Euros)'
      Color = cl3DLight
      ParentColor = False
    end
    object BGMoneda: TBGridButton
      Left = 80
      Top = 129
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
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00000000BFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FF00000000000000000000000000FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00000000000000000000000000000000000000
        00BFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
        000000000000FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
        FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      Control = moneda_cobro_r
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 280
      GridHeigth = 200
    end
    object Label9: TLabel
      Left = 47
      Top = 152
      Width = 156
      Height = 19
      AutoSize = False
      Caption = ' Otras Compensaciones'
      Color = cl3DLight
      ParentColor = False
    end
    object Label11: TLabel
      Left = 413
      Top = 153
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Cta. Contable'
      Color = cl3DLight
      ParentColor = False
    end
    object Label12: TLabel
      Left = 463
      Top = 67
      Width = 89
      Height = 19
      AutoSize = False
      Caption = ' Contabilizado'
      Color = cl3DLight
      ParentColor = False
    end
    object Label3: TLabel
      Left = 47
      Top = 175
      Width = 156
      Height = 19
      AutoSize = False
      Caption = ' Total / Cambio'
      Color = cl3DLight
      ParentColor = False
    end
    object lblEmpresa: TnbStaticText
      Left = 234
      Top = 22
      Width = 217
      Height = 21
      About = 'NB 0.1/20020725'
    end
    object lblBanco: TnbStaticText
      Left = 234
      Top = 66
      Width = 217
      Height = 21
      About = 'NB 0.1/20020725'
    end
    object lblMoneda: TnbStaticText
      Left = 94
      Top = 129
      Width = 109
      Height = 21
      About = 'NB 0.1/20020725'
    end
    object lblEtiquetaDiasCobro: TLabel
      Left = 413
      Top = 176
      Width = 156
      Height = 19
      AutoSize = False
      Caption = ' Dias Cobro Ponderado Importe'
      Color = cl3DLight
      ParentColor = False
    end
    object lblDiasCobro: TLabel
      Left = 582
      Top = 179
      Width = 20
      Height = 13
      Alignment = taRightJustify
      Caption = 'Ldiff'
    end
    object lbl1: TLabel
      Left = 46
      Top = 203
      Width = 46
      Height = 19
      AutoSize = False
      Caption = ' NOTAS'
      Color = cl3DLight
      ParentColor = False
    end
    object contabilizado_r: TDBCheckBox
      Left = 538
      Top = 68
      Width = 14
      Height = 17
      TabStop = False
      Alignment = taLeftJustify
      DataField = 'contabilizado_r'
      DataSource = DSMaestro
      ReadOnly = True
      TabOrder = 4
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object moneda_cobro_r: TBDEdit
      Left = 46
      Top = 129
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 5
      OnChange = moneda_cobro_rChange
      DataField = 'moneda_cobro_r'
      DataSource = DSMaestro
    end
    object fecha_r: TBDEdit
      Left = 360
      Top = 44
      Width = 80
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = RequiredTime
      InputType = itDate
      MaxLength = 10
      TabOrder = 2
      DataField = 'fecha_r'
      DataSource = DSMaestro
      Modificable = False
    end
    object empresa_r: TBDEdit
      Tag = 1
      Left = 181
      Top = 22
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      OnChange = empresa_rChange
      DataField = 'empresa_r'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object referencia_r: TBDEdit
      Left = 181
      Top = 44
      Width = 65
      Height = 21
      TabStop = False
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      InputType = itInteger
      MaxLength = 9
      TabOrder = 1
      DataField = 'referencia_r'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object banco_r: TBDEdit
      Tag = 1
      Left = 181
      Top = 66
      Width = 38
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 3
      OnChange = banco_rChange
      DataField = 'banco_r'
      DataSource = DSMaestro
    end
    object importe_cobro_r: TBDEdit
      Left = 213
      Top = 129
      Width = 90
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = RequiredTime
      InputType = itReal
      MaxDecimals = 2
      MaxLength = 11
      TabOrder = 6
      OnChange = importe_cobro_rChange
      DataField = 'importe_cobro_r'
      DataSource = DSMaestro
    end
    object bruto_euros_r: TBDEdit
      Left = 313
      Top = 129
      Width = 90
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = RequiredTime
      InputType = itReal
      MaxDecimals = 2
      MaxLength = 11
      TabOrder = 7
      OnChange = bruto_euros_rChange
      DataField = 'bruto_euros_r'
      DataSource = DSMaestro
    end
    object gastos_euros_r: TBDEdit
      Left = 413
      Top = 129
      Width = 90
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = RequiredTime
      InputType = itReal
      MaxDecimals = 2
      MaxLength = 11
      TabOrder = 8
      OnChange = gastos_euros_rChange
      DataField = 'gastos_euros_r'
      DataSource = DSMaestro
    end
    object liquido_euros_r: TBDEdit
      Left = 513
      Top = 129
      Width = 90
      Height = 21
      TabStop = False
      ColorEdit = clSilver
      ColorNormal = clSilver
      OnRequiredTime = RequiredTime
      InputType = itReal
      MaxDecimals = 2
      ReadOnly = True
      MaxLength = 11
      TabOrder = 9
      DataField = 'liquido_euros_r'
      DataSource = DSMaestro
    end
    object otros_r: TBDEdit
      Left = 213
      Top = 152
      Width = 90
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      InputType = itReal
      MaxDecimals = 2
      MaxLength = 11
      TabOrder = 10
      OnChange = gastos_euros_rChange
      DataField = 'otros_r'
      DataSource = DSMaestro
    end
    object otros_euros_r: TBDEdit
      Left = 313
      Top = 152
      Width = 90
      Height = 21
      TabStop = False
      ColorEdit = clMoneyGreen
      ColorNormal = clSilver
      OnRequiredTime = RequiredTime
      InputType = itReal
      MaxDecimals = 2
      ReadOnly = True
      MaxLength = 11
      TabOrder = 11
      DataField = 'otros_euros_r'
      DataSource = DSMaestro
    end
    object cta_contable_r: TBDEdit
      Left = 513
      Top = 152
      Width = 90
      Height = 21
      ColorEdit = clMoneyGreen
      OnRequiredTime = RequiredTime
      MaxLength = 8
      TabOrder = 12
      DataField = 'cta_contable_r'
      DataSource = DSMaestro
    end
    object eTotal: TBEdit
      Left = 213
      Top = 175
      Width = 90
      Height = 21
      TabStop = False
      ColorEdit = clSilver
      ColorNormal = clSilver
      InputType = itReal
      ReadOnly = True
      TabOrder = 13
    end
    object eCambio: TBEdit
      Left = 313
      Top = 175
      Width = 90
      Height = 21
      TabStop = False
      ColorEdit = clSilver
      ColorNormal = clSilver
      InputType = itReal
      ReadOnly = True
      TabOrder = 14
    end
    object notas_r: TDBMemo
      Left = 94
      Top = 203
      Width = 509
      Height = 74
      DataField = 'notas_r'
      DataSource = DSMaestro
      TabOrder = 15
    end
  end
  object PTotales: TPanel
    Left = 0
    Top = 535
    Width = 659
    Height = 24
    Align = alBottom
    Enabled = False
    TabOrder = 5
    object Label8: TLabel
      Left = 464
      Top = 5
      Width = 30
      Height = 13
      Caption = 'Total :'
    end
    object Ldiff: TLabel
      Left = 583
      Top = 5
      Width = 20
      Height = 13
      Caption = 'Ldiff'
    end
    object Label10: TLabel
      Left = 39
      Top = 5
      Width = 44
      Height = 13
      Caption = 'Facturas '
    end
    object TotalRemesa: TBEdit
      Left = 499
      Top = 1
      Width = 82
      Height = 21
      TabOrder = 1
    end
    object BFacturas: TBEdit
      Left = 10
      Top = 1
      Width = 28
      Height = 21
      TabOrder = 0
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 289
    Width = 659
    Height = 246
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 4
    object PDetalle: TPanel
      Left = 1
      Top = 1
      Width = 657
      Height = 56
      Align = alTop
      TabOrder = 0
      object Label7: TLabel
        Left = 203
        Top = 16
        Width = 62
        Height = 19
        AutoSize = False
        Caption = ' Factura'
        Color = cl3DLight
        ParentColor = False
      end
      object Label14: TLabel
        Left = 339
        Top = 16
        Width = 62
        Height = 19
        AutoSize = False
        Caption = ' Fecha'
        Color = cl3DLight
        ParentColor = False
      end
      object Label15: TLabel
        Left = 475
        Top = 16
        Width = 62
        Height = 19
        AutoSize = False
        Caption = ' A Cobrar'
        Color = cl3DLight
        ParentColor = False
      end
      object lblEmpresa_: TLabel
        Left = 67
        Top = 16
        Width = 90
        Height = 19
        AutoSize = False
        Caption = ' Empresa'
        Color = cl3DLight
        ParentColor = False
      end
      object factura_fr: TBDEdit
        Left = 269
        Top = 15
        Width = 65
        Height = 21
        ColorEdit = clMoneyGreen
        InputType = itInteger
        MaxLength = 6
        TabOrder = 1
        OnChange = MCambiaFactura
        DataField = 'factura_fr'
        DataSource = DSDetalle
        Modificable = False
        PrimaryKey = True
      end
      object fecha_factura_fr: TBDEdit
        Left = 405
        Top = 15
        Width = 65
        Height = 21
        ColorEdit = clMoneyGreen
        InputType = itDate
        MaxLength = 10
        TabOrder = 2
        OnChange = CambiarFechaFactura
        DataField = 'fecha_factura_fr'
        DataSource = DSDetalle
        Modificable = False
        PrimaryKey = True
      end
      object importe_cobrado_fr: TBDEdit
        Left = 541
        Top = 15
        Width = 65
        Height = 21
        ColorEdit = clMoneyGreen
        InputType = itReal
        MaxDecimals = 2
        MaxLength = 9
        TabOrder = 3
        DataField = 'importe_cobrado_fr'
        DataSource = DSDetalle
        Modificable = False
        PrimaryKey = True
      end
      object empresa_fr: TBDEdit
        Tag = 1
        Left = 159
        Top = 15
        Width = 38
        Height = 21
        ColorEdit = clMoneyGreen
        Zeros = True
        Required = True
        MaxLength = 3
        TabOrder = 0
        DataField = 'empresa_fr'
        DataSource = DSDetalle
        Modificable = False
        PrimaryKey = True
      end
    end
    object Rvisualizacion: TDBGrid
      Left = 1
      Top = 49
      Width = 657
      Height = 196
      Align = alBottom
      DataSource = DSDetalle
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'cliente_fr'
          Title.Alignment = taCenter
          Title.Caption = 'Cliente Fac.'
          Width = 80
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'factura_fr'
          Title.Alignment = taCenter
          Title.Caption = 'Factura'
          Width = 80
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'fecha_factura_fr'
          Title.Alignment = taCenter
          Title.Caption = 'Fecha Fac.'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'importe_factura_fr'
          Title.Alignment = taCenter
          Title.Caption = 'Importe Fac.'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cobrado_total_fr'
          Title.Alignment = taCenter
          Title.Caption = 'Total Cobrado'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'importe_cobrado_fr'
          Title.Alignment = taCenter
          Title.Caption = 'Cobrado Remesa'
          Width = 90
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'moneda_fr'
          Title.Alignment = taCenter
          Title.Caption = 'Moneda'
          Width = 80
          Visible = True
        end>
    end
  end
  object Panel2: TPanel
    Left = 463
    Top = 24
    Width = 89
    Height = 31
    Caption = 'Panel2'
    TabOrder = 2
    object Button1: TButton
      Left = 3
      Top = 3
      Width = 84
      Height = 25
      Caption = 'Contabilizar'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object RejillaFlotante: TBGrid
    Left = 624
    Top = 173
    Width = 137
    Height = 25
    Color = clInfoBk
    FixedColor = clInfoText
    Options = [dgTabs, dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
  end
  object CalendarioFlotante: TBCalendario
    Left = 628
    Top = 4
    Width = 197
    Height = 153
    Date = 36717.4966925
    ShowToday = False
    TabOrder = 1
    Visible = False
    WeekNumbers = True
  end
  object DSMaestro: TDataSource
    AutoEdit = False
    DataSet = QRemesasExp
    Left = 48
    Top = 328
  end
  object ACosecheros: TActionList
    Top = 96
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
    object ACampos: TAction
      Caption = 'Mantenimiento de Campos (F3)'
      ImageIndex = 3
      ShortCut = 114
    end
  end
  object DSDetalle: TDataSource
    AutoEdit = False
    DataSet = QDetalle
    Left = 112
    Top = 329
  end
  object QDetalle: TQuery
    AfterPost = QDetalleAfterPost
    OnCalcFields = QDetalleCalcFields
    OnNewRecord = QDetalleNewRecord
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM  frf_facturas_remesa '
      'ORDER BY factura_fr')
    Left = 81
    Top = 330
    object QDetalleempresa_fr: TStringField
      FieldName = 'empresa_fr'
      Origin = 'BDPROYECTO.frf_facturas_remesa.empresa_fr'
      FixedChar = True
      Size = 3
    end
    object QDetallefactura_fr: TIntegerField
      FieldName = 'factura_fr'
      Origin = 'BDPROYECTO.frf_facturas_remesa.factura_fr'
    end
    object QDetallefecha_factura_fr: TDateField
      FieldName = 'fecha_factura_fr'
      Origin = 'BDPROYECTO.frf_facturas_remesa.fecha_factura_fr'
    end
    object strngfldQDetalleempresa_remesa_fr: TStringField
      FieldName = 'empresa_remesa_fr'
      Size = 3
    end
    object QDetalleremesa_fr: TIntegerField
      FieldName = 'remesa_fr'
      Origin = 'BDPROYECTO.frf_facturas_remesa.remesa_fr'
    end
    object QDetallefecha_remesa_fr: TDateField
      FieldName = 'fecha_remesa_fr'
      Origin = 'BDPROYECTO.frf_facturas_remesa.fecha_remesa_fr'
    end
    object QDetalleimporte_cobrado_fr: TFloatField
      FieldName = 'importe_cobrado_fr'
      Origin = 'BDPROYECTO.frf_facturas_remesa.importe_cobrado_fr'
    end
    object QDetallecliente_fr: TStringField
      FieldKind = fkCalculated
      FieldName = 'cliente_fr'
      Size = 3
      Calculated = True
    end
    object QDetalleimporte_factura_fr: TFloatField
      FieldKind = fkCalculated
      FieldName = 'importe_factura_fr'
      Calculated = True
    end
    object QDetallemoneda_fr: TStringField
      FieldKind = fkCalculated
      FieldName = 'moneda_fr'
      Size = 3
      Calculated = True
    end
    object QDetallecobrado_total_fr: TFloatField
      FieldKind = fkCalculated
      FieldName = 'cobrado_total_fr'
      Calculated = True
    end
  end
  object QRemesasExp: TQuery
    AfterOpen = QRemesasExpAfterOpen
    BeforeClose = QRemesasExpBeforeClose
    AfterScroll = QRemesasExpAfterScroll
    OnNewRecord = QRemesasExpNewRecord
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_remesas Frf_remesas'
      'WHERE  empresa_r = '#39'pep'#39' ')
    Left = 16
    Top = 329
    object QRemesasExpempresa_r: TStringField
      FieldName = 'empresa_r'
      Origin = 'BDPROYECTO.frf_remesas.empresa_r'
      FixedChar = True
      Size = 3
    end
    object QRemesasExpreferencia_r: TIntegerField
      FieldName = 'referencia_r'
      Origin = 'BDPROYECTO.frf_remesas.referencia_r'
    end
    object QRemesasExpfecha_r: TDateField
      FieldName = 'fecha_r'
      Origin = 'BDPROYECTO.frf_remesas.fecha_r'
    end
    object QRemesasExpbanco_r: TStringField
      FieldName = 'banco_r'
      Origin = 'BDPROYECTO.frf_remesas.banco_r'
      FixedChar = True
      Size = 3
    end
    object QRemesasExpmoneda_cobro_r: TStringField
      FieldName = 'moneda_cobro_r'
      Origin = 'BDPROYECTO.frf_remesas.moneda_cobro_r'
      FixedChar = True
      Size = 3
    end
    object QRemesasExpimporte_cobro_r: TFloatField
      FieldName = 'importe_cobro_r'
      Origin = 'BDPROYECTO.frf_remesas.importe_cobro_r'
    end
    object QRemesasExpbruto_euros_r: TFloatField
      FieldName = 'bruto_euros_r'
      Origin = 'BDPROYECTO.frf_remesas.bruto_euros_r'
    end
    object QRemesasExpgastos_euros_r: TFloatField
      FieldName = 'gastos_euros_r'
      Origin = 'BDPROYECTO.frf_remesas.gastos_euros_r'
    end
    object QRemesasExpliquido_euros_r: TFloatField
      FieldName = 'liquido_euros_r'
      Origin = 'BDPROYECTO.frf_remesas.liquido_euros_r'
    end
    object QRemesasExprelacion_r: TStringField
      FieldName = 'relacion_r'
      Origin = 'BDPROYECTO.frf_remesas.relacion_r'
      FixedChar = True
      Size = 17
    end
    object QRemesasExpotros_r: TFloatField
      FieldName = 'otros_r'
      Origin = 'BDPROYECTO.frf_remesas.otros_r'
    end
    object QRemesasExpotros_euros_r: TFloatField
      FieldName = 'otros_euros_r'
      Origin = 'BDPROYECTO.frf_remesas.otros_euros_r'
    end
    object QRemesasExpcta_contable_r: TStringField
      FieldName = 'cta_contable_r'
      Origin = 'BDPROYECTO.frf_remesas.cta_contable_r'
      FixedChar = True
      Size = 8
    end
    object QRemesasExpcontabilizado_r: TStringField
      FieldName = 'contabilizado_r'
      Origin = 'BDPROYECTO.frf_remesas.contabilizado_r'
      FixedChar = True
      Size = 1
    end
    object QRemesasExpnotas_r: TStringField
      FieldName = 'notas_r'
      Origin = '"COMER.SAT".frf_remesas.notas_r'
      FixedChar = True
      Size = 255
    end
  end
  object QDetalleTotal: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    SQL.Strings = (
      'SELECT *'
      'FROM  frf_facturas_remesa '
      'ORDER BY factura_fr')
    Left = 81
    Top = 362
  end
  object QImporteFactura: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    SQL.Strings = (
      'SELECT *'
      'FROM  frf_facturas_remesa '
      'ORDER BY factura_fr')
    Left = 81
    Top = 394
  end
  object QCobradoFactura: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    SQL.Strings = (
      'SELECT *'
      'FROM  frf_facturas_remesa '
      'ORDER BY factura_fr')
    Left = 113
    Top = 394
  end
  object QCobradoFacturaRemesa: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    SQL.Strings = (
      'SELECT *'
      'FROM  frf_facturas_remesa '
      'ORDER BY factura_fr')
    Left = 145
    Top = 394
  end
  object QFechaFactura: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    SQL.Strings = (
      'SELECT *'
      'FROM  frf_facturas_remesa '
      'ORDER BY factura_fr')
    Left = 177
    Top = 394
  end
  object QImporteFacturaRemesa: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    SQL.Strings = (
      'SELECT *'
      'FROM  frf_facturas_remesa '
      'ORDER BY factura_fr')
    Left = 209
    Top = 394
  end
end
