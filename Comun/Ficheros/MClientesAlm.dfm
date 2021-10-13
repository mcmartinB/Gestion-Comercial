object FMClientesAlm: TFMClientesAlm
  Left = 469
  Top = 142
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  CLIENTES'
  ClientHeight = 589
  ClientWidth = 763
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
  object PMaestroGlobal: TPanel
    Left = 0
    Top = 0
    Width = 763
    Height = 334
    Align = alTop
    BevelInner = bvRaised
    BevelWidth = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object PMaestro: TPanel
      Left = 4
      Top = 4
      Width = 755
      Height = 326
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object LEmpresa_p: TLabel
        Left = 56
        Top = 30
        Width = 90
        Height = 19
        AutoSize = False
        Caption = ' Cliente'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label2: TLabel
        Left = 56
        Top = 97
        Width = 90
        Height = 19
        AutoSize = False
        Caption = ' Direcci'#243'n Social'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object BGBtipo_via_c: TBGridButton
        Left = 187
        Top = 96
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
        Left = 56
        Top = 119
        Width = 90
        Height = 19
        AutoSize = False
        Caption = ' Poblaci'#243'n'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label4: TLabel
        Left = 56
        Top = 141
        Width = 90
        Height = 19
        AutoSize = False
        Caption = ' Pa'#237's'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label6: TLabel
        Left = 56
        Top = 164
        Width = 90
        Height = 19
        AutoSize = False
        Caption = ' Cod. Postal'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object BGBpais_c: TBGridButton
        Left = 187
        Top = 140
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
        Left = 56
        Top = 208
        Width = 90
        Height = 19
        AutoSize = False
        Caption = ' Tel'#233'fono'
        Color = cl3DLight
        ParentColor = False
      end
      object Label8: TLabel
        Left = 56
        Top = 52
        Width = 90
        Height = 19
        AutoSize = False
        Caption = ' Cif'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label5: TLabel
        Left = 56
        Top = 230
        Width = 90
        Height = 19
        AutoSize = False
        Caption = ' Resp. Compras'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label21: TLabel
        Left = 504
        Top = 119
        Width = 101
        Height = 19
        AutoSize = False
        Caption = ' N'#186' Copias Albar'#225'n'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label23: TLabel
        Left = 56
        Top = 253
        Width = 90
        Height = 19
        AutoSize = False
        Caption = ' E-Mail Albaranes'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label9: TLabel
        Left = 56
        Top = 186
        Width = 90
        Height = 19
        AutoSize = False
        Caption = ' Moneda'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object BGBmoneda_c: TBGridButton
        Left = 187
        Top = 185
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
      object Label28: TLabel
        Left = 367
        Top = 208
        Width = 27
        Height = 19
        AutoSize = False
        Caption = ' Fax'
        Color = cl3DLight
        ParentColor = False
      end
      object lbl1: TLabel
        Left = 56
        Top = 275
        Width = 90
        Height = 19
        AutoSize = False
        Caption = ' Condici'#243'n Entrega'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object BGBincoterm_c: TBGridButton
        Left = 187
        Top = 274
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
        GridAlignment = taUpRight
        GridWidth = 230
        GridHeigth = 200
      end
      object lbl2: TLabel
        Left = 56
        Top = 297
        Width = 90
        Height = 19
        AutoSize = False
        Caption = ' Plaza Entrega'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object lbl6: TLabel
        Left = 56
        Top = 75
        Width = 90
        Height = 19
        AutoSize = False
        Caption = ' Tipo Cliente'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object btnTipoCliente: TBGridButton
        Left = 187
        Top = 74
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
      object cliente_c: TBDEdit
        Left = 149
        Top = 29
        Width = 38
        Height = 21
        ColorEdit = clMoneyGreen
        Required = True
        RequiredMsg = 'El c'#243'digo de centro es de obligada inserci'#243'n.'
        OnRequiredTime = RequiredTime
        MaxLength = 3
        TabOrder = 0
        DataField = 'cliente_c'
        DataSource = DSMaestro
        PrimaryKey = True
      end
      object nombre_c: TBDEdit
        Left = 196
        Top = 29
        Width = 302
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 50
        TabOrder = 1
        DataField = 'nombre_c'
        DataSource = DSMaestro
      end
      object tipo_via_c: TBDEdit
        Left = 149
        Top = 96
        Width = 38
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 2
        TabOrder = 5
        DataField = 'tipo_via_c'
        DataSource = DSMaestro
      end
      object domicilio_c: TBDEdit
        Left = 209
        Top = 96
        Width = 289
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 50
        TabOrder = 6
        DataField = 'domicilio_c'
        DataSource = DSMaestro
      end
      object poblacion_c: TBDEdit
        Left = 149
        Top = 118
        Width = 349
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 50
        TabOrder = 7
        DataField = 'poblacion_c'
        DataSource = DSMaestro
      end
      object pais_c: TBDEdit
        Left = 149
        Top = 140
        Width = 38
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 2
        TabOrder = 9
        DataField = 'pais_c'
        DataSource = DSMaestro
      end
      object cod_postal_c: TBDEdit
        Left = 149
        Top = 163
        Width = 77
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 10
        TabOrder = 14
        DataField = 'cod_postal_c'
        DataSource = DSMaestro
      end
      object STProvincia: TStaticText
        Left = 227
        Top = 165
        Width = 271
        Height = 17
        AutoSize = False
        BorderStyle = sbsSunken
        TabOrder = 15
      end
      object STPais_c: TStaticText
        Left = 210
        Top = 142
        Width = 200
        Height = 17
        AutoSize = False
        BorderStyle = sbsSunken
        TabOrder = 12
      end
      object telefono_c: TBDEdit
        Left = 149
        Top = 207
        Width = 114
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 16
        TabOrder = 18
        DataField = 'telefono_c'
        DataSource = DSMaestro
      end
      object nif_c: TBDEdit
        Left = 149
        Top = 51
        Width = 90
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 14
        TabOrder = 2
        DataField = 'nif_c'
        DataSource = DSMaestro
      end
      object resp_compras_c: TBDEdit
        Left = 149
        Top = 229
        Width = 349
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 30
        TabOrder = 21
        DataField = 'resp_compras_c'
        DataSource = DSMaestro
      end
      object es_comunitario_c: TDBCheckBox
        Left = 417
        Top = 140
        Width = 81
        Height = 21
        Caption = 'Comunitario'
        DataField = 'es_comunitario_c'
        DataSource = DSMaestro
        TabOrder = 10
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object n_copias_alb_c: TBDEdit
        Left = 614
        Top = 118
        Width = 38
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        InputType = itInteger
        TabOrder = 8
        DataField = 'n_copias_alb_c'
        DataSource = DSMaestro
      end
      object email_alb_c: TBDEdit
        Left = 149
        Top = 252
        Width = 516
        Height = 21
        ColorEdit = clMoneyGreen
        CharCase = ecLowerCase
        TabOrder = 22
        DataField = 'email_alb_c'
        DataSource = DSMaestro
      end
      object moneda_c: TBDEdit
        Left = 149
        Top = 185
        Width = 38
        Height = 21
        ColorEdit = clMoneyGreen
        Zeros = True
        OnRequiredTime = RequiredTime
        MaxLength = 3
        TabOrder = 16
        DataField = 'moneda_c'
        DataSource = DSMaestro
      end
      object STMoneda_c: TStaticText
        Left = 210
        Top = 187
        Width = 289
        Height = 17
        AutoSize = False
        BorderStyle = sbsSunken
        TabOrder = 17
      end
      object telefono2_c: TBDEdit
        Left = 263
        Top = 207
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
        Left = 396
        Top = 207
        Width = 102
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 16
        TabOrder = 20
        DataField = 'fax_c'
        DataSource = DSMaestro
      end
      object incoterm_c: TBDEdit
        Left = 149
        Top = 274
        Width = 35
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 3
        TabOrder = 23
        OnChange = incoterm_cChange
        DataField = 'incoterm_c'
        DataSource = DSMaestro
      end
      object stIncoterm: TStaticText
        Left = 210
        Top = 276
        Width = 289
        Height = 17
        AutoSize = False
        BorderStyle = sbsSunken
        TabOrder = 24
      end
      object plaza_incoterm_c: TBDEdit
        Left = 149
        Top = 296
        Width = 135
        Height = 21
        ColorEdit = clMoneyGreen
        OnRequiredTime = RequiredTime
        MaxLength = 30
        TabOrder = 25
        DataField = 'plaza_incoterm_c'
        DataSource = DSMaestro
      end
      object tipo_cliente_c: TBDEdit
        Left = 149
        Top = 74
        Width = 38
        Height = 21
        ColorEdit = clMoneyGreen
        Zeros = True
        Required = True
        RequiredMsg = 'El c'#243'digo del representante es de obligada inserci'#243'n.'
        OnRequiredTime = RequiredTime
        MaxLength = 2
        TabOrder = 3
        DataField = 'tipo_cliente_c'
        DataSource = DSMaestro
      end
      object txtTipoCliente: TStaticText
        Left = 209
        Top = 76
        Width = 289
        Height = 17
        AutoSize = False
        BorderStyle = sbsSunken
        TabOrder = 4
      end
      object grabrar_transporte_c: TDBCheckBox
        Left = 364
        Top = 296
        Width = 135
        Height = 20
        Alignment = taLeftJustify
        Caption = 'Grabar costes de portes '
        DataField = 'grabrar_transporte_c'
        DataSource = DSMaestro
        TabOrder = 26
        ValueChecked = '1'
        ValueUnchecked = '0'
      end
      object des_tipo_albaran_c: TStaticText
        Left = 542
        Top = 142
        Width = 110
        Height = 17
        AutoSize = False
        BorderStyle = sbsSunken
        TabOrder = 13
      end
      object tipo_albaran_c: TDBComboBox
        Left = 504
        Top = 140
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
        TabOrder = 11
        OnChange = tipo_albaran_cChange
      end
    end
  end
  object PDetalle: TPanel
    Left = 0
    Top = 543
    Width = 763
    Height = 46
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 6
    object LDireccionD: TLabel
      Left = 60
      Top = 2
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' C'#243'digo'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label22: TLabel
      Left = 464
      Top = 2
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' Tel'#233'fono'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNif: TLabel
      Left = 206
      Top = 2
      Width = 90
      Height = 19
      AutoSize = False
      Caption = ' NIF'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblemail_ds: TLabel
      Left = 60
      Top = 24
      Width = 44
      Height = 19
      AutoSize = False
      Caption = ' E-Mail'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object dir_sum_ds: TBDEdit
      Left = 153
      Top = 2
      Width = 41
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 
        'El c'#243'digo de la direcci'#243'n de suministro es de obligada inserci'#243'n' +
        '.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 1
      DataField = 'dir_sum_ds'
      DataSource = DSDetalle
      Modificable = False
      PrimaryKey = True
    end
    object telefono_ds: TBDEdit
      Left = 562
      Top = 1
      Width = 108
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 16
      TabOrder = 0
      DataField = 'telefono_ds'
      DataSource = DSDetalle
    end
    object nif_ds: TBDEdit
      Left = 298
      Top = 2
      Width = 154
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 
        'El c'#243'digo de la direcci'#243'n de suministro es de obligada inserci'#243'n' +
        '.'
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 2
      DataField = 'nif_ds'
      DataSource = DSDetalle
      Modificable = False
      PrimaryKey = True
    end
    object email_ds: TBDEdit
      Left = 153
      Top = 23
      Width = 516
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 16
      TabOrder = 3
      DataField = 'email_ds'
      DataSource = DSDetalle
    end
  end
  object PRejilla: TPanel
    Left = 0
    Top = 334
    Width = 763
    Height = 209
    Align = alClient
    TabOrder = 5
    object RVisualizacion: TDBGrid
      Left = 1
      Top = 1
      Width = 761
      Height = 207
      Align = alClient
      DataSource = DSDetalle
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      TabOrder = 0
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
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nombre_ds'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'Nombre'
          Width = 154
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'domicilio_ds'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'Domicilio'
          Width = 193
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cod_postal_ds'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'C.P.'
          Width = 58
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'poblacion_ds'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'Poblaci'#243'n'
          Width = 118
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'provincia_ds'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'Provincia'
          Width = 104
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'des_pais_ds'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'Pa'#237's'
          Width = 66
          Visible = True
        end>
    end
  end
  object BtnUniFac: TBitBtn
    Left = 508
    Top = 30
    Width = 148
    Height = 27
    Caption = 'Unidad Facturaci'#243'n'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    TabStop = False
    OnClick = BtnUniFacClick
  end
  object RejillaFlotante: TBGrid
    Left = 520
    Top = 200
    Width = 41
    Height = 57
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
  object btnRecargo: TBitBtn
    Left = 508
    Top = 59
    Width = 148
    Height = 27
    Caption = 'Recargo IVA'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    TabStop = False
    OnClick = btnRecargoClick
  end
  object pnlPasarSGP: TPanel
    Left = 529
    Top = 295
    Width = 139
    Height = 25
    Cursor = crHandPoint
    Caption = 'Pasar al SGP'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = pnlPasarSGPClick
  end
  object DSMaestro: TDataSource
    DataSet = QClientes
    OnDataChange = DSMaestroDataChange
    Left = 562
    Top = 210
  end
  object ACosecheros: TActionList
    Images = DMBaseDatos.ImgBotones
    Left = 8
    Top = 72
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
  end
  object DSDetalle: TDataSource
    DataSet = TSuministros
    OnDataChange = DSDetalleDataChange
    Left = 634
    Top = 210
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
    Left = 602
    Top = 242
    ParamData = <
      item
        DataType = ftFixedChar
        Name = 'cliente_c'
        ParamType = ptUnknown
      end>
  end
  object QClientes: TQuery
    AfterScroll = QClientesAfterScroll
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM frf_clientes Frf_clientes'
      'ORDER BY nombre_c')
    Left = 530
    Top = 210
  end
  object TSuministros: TTable
    AutoCalcFields = False
    OnCalcFields = TSuministrosCalcFields
    DatabaseName = 'BDProyecto'
    IndexFieldNames = 'cliente_ds'
    MasterFields = 'cliente_c'
    MasterSource = DSMaestro
    TableName = 'frf_dir_sum'
    Left = 602
    Top = 210
    object TSuministroscliente_ds: TStringField
      FieldName = 'cliente_ds'
      Required = True
      Size = 3
    end
    object TSuministrosdir_sum_ds: TStringField
      FieldName = 'dir_sum_ds'
      Required = True
      Size = 3
    end
    object TSuministrosnombre_ds: TStringField
      DisplayWidth = 50
      FieldName = 'nombre_ds'
      Size = 50
    end
    object TSuministrostipo_via_ds: TStringField
      FieldName = 'tipo_via_ds'
      Size = 2
    end
    object TSuministrosdomicilio_ds: TStringField
      DisplayWidth = 60
      FieldName = 'domicilio_ds'
      Size = 60
    end
    object TSuministroscod_postal_ds: TStringField
      FieldName = 'cod_postal_ds'
      Size = 8
    end
    object TSuministrospoblacion_ds: TStringField
      FieldName = 'poblacion_ds'
      Size = 30
    end
    object TSuministrostelefono_ds: TStringField
      FieldName = 'telefono_ds'
      Size = 16
    end
    object TSuministrosprovincia_ds: TStringField
      FieldName = 'provincia_ds'
      Size = 30
    end
    object TSuministrosprovincia_esp_ds: TStringField
      FieldKind = fkCalculated
      FieldName = 'provincia_esp_ds'
      Size = 30
      Calculated = True
    end
    object TSuministrospais_ds: TStringField
      FieldName = 'pais_ds'
      Size = 2
    end
    object strngfldTSuministrosdes_pais_ds: TStringField
      FieldKind = fkCalculated
      FieldName = 'des_pais_ds'
      Size = 30
      Calculated = True
    end
    object strngfldTSuministrosnif_ds: TStringField
      FieldName = 'nif_ds'
      FixedChar = True
      Size = 14
    end
    object strngfldTSuministrosemail_ds: TStringField
      FieldName = 'email_ds'
      FixedChar = True
      Size = 255
    end
  end
  object DSSuministros: TDataSource
    OnDataChange = DSMaestroDataChange
    Left = 562
    Top = 242
  end
end
