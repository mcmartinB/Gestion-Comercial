object DFLComHisSemVen: TDFLComHisSemVen
  Left = 295
  Top = 199
  Width = 474
  Height = 446
  BorderIcons = []
  Caption = '   COMPARATIVO HIST'#211'RICO SEMANAL DE VENTAS (BRUTO)'
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
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 458
    Height = 407
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      458
      407)
    object SBAceptar: TSpeedButton
      Left = 240
      Top = 357
      Width = 100
      Height = 31
      Anchors = [akRight, akBottom]
      Caption = 'Aceptar (F1)'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF000000FF0000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF000000FF000000FFBF0000FF00000000BFFF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF000000FF000000FFBF0000FF00000000BFFF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF000000FF000000FF000000FFBF0000FF000000FFBF00000000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF000000FF000000FFBF0000FF000000FFBF0000FF000000FFBF00000000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007F7F
        7F000000FF3F0000FFBF00000000FF00FF000000FF000000FFBF0000FF000000
        00BFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007F7F7F000000
        FF3F00000000FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000
        00BFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000
        FFBF00000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF000000
        FFBF00000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
        FF000000FF00000000BFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF007F7F7F000000FF3F00000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF007F7F7F000000FF3F000000BFFF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF000000FF000000FF00000000BFFF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      OnClick = SBAceptarClick
    end
    object SBCancelar: TSpeedButton
      Left = 343
      Top = 358
      Width = 100
      Height = 31
      Action = Cancelar
      Anchors = [akRight, akBottom]
      Caption = 'Cancelar (Esc)'
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        0800000000000001000000000000000000000001000000010000000000004000
        000080000000FF000000002000004020000080200000FF200000004000004040
        000080400000FF400000006000004060000080600000FF600000008000004080
        000080800000FF80000000A0000040A0000080A00000FFA0000000C0000040C0
        000080C00000FFC0000000FF000040FF000080FF0000FFFF0000000020004000
        200080002000FF002000002020004020200080202000FF202000004020004040
        200080402000FF402000006020004060200080602000FF602000008020004080
        200080802000FF80200000A0200040A0200080A02000FFA0200000C0200040C0
        200080C02000FFC0200000FF200040FF200080FF2000FFFF2000000040004000
        400080004000FF004000002040004020400080204000FF204000004040004040
        400080404000FF404000006040004060400080604000FF604000008040004080
        400080804000FF80400000A0400040A0400080A04000FFA0400000C0400040C0
        400080C04000FFC0400000FF400040FF400080FF4000FFFF4000000060004000
        600080006000FF006000002060004020600080206000FF206000004060004040
        600080406000FF406000006060004060600080606000FF606000008060004080
        600080806000FF80600000A0600040A0600080A06000FFA0600000C0600040C0
        600080C06000FFC0600000FF600040FF600080FF6000FFFF6000000080004000
        800080008000FF008000002080004020800080208000FF208000004080004040
        800080408000FF408000006080004060800080608000FF608000008080004080
        800080808000FF80800000A0800040A0800080A08000FFA0800000C0800040C0
        800080C08000FFC0800000FF800040FF800080FF8000FFFF80000000A0004000
        A0008000A000FF00A0000020A0004020A0008020A000FF20A0000040A0004040
        A0008040A000FF40A0000060A0004060A0008060A000FF60A0000080A0004080
        A0008080A000FF80A00000A0A00040A0A00080A0A000FFA0A00000C0A00040C0
        A00080C0A000FFC0A00000FFA00040FFA00080FFA000FFFFA0000000C0004000
        C0008000C000FF00C0000020C0004020C0008020C000FF20C0000040C0004040
        C0008040C000FF40C0000060C0004060C0008060C000FF60C0000080C0004080
        C0008080C000FF80C00000A0C00040A0C00080A0C000FFA0C00000C0C00040C0
        C00080C0C000FFC0C00000FFC00040FFC00080FFC000FFFFC0000000FF004000
        FF008000FF00FF00FF000020FF004020FF008020FF00FF20FF000040FF004040
        FF008040FF00FF40FF000060FF004060FF008060FF00FF60FF000080FF004080
        FF008080FF00FF80FF0000A0FF0040A0FF0080A0FF00FFA0FF0000C0FF0040C0
        FF0080C0FF00FFC0FF0000FFFF0040FFFF0080FFFF00FFFFFF00E3E3E3E3E3E3
        E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E300FFE3E3E3E300FF
        E3E3E3E3E3E3E3E3E3E3E3E3E3000000FFE3E3E3E3E3E300FFE3E3E3E3000000
        FFE3E3E3E3E300FFE3E3E3E3E3E3000000FFE3E3E30000FFE3E3E3E3E3E3E300
        0000FFE30000FFE3E3E3E3E3E3E3E3E30000000000FFE3E3E3E3E3E3E3E3E3E3
        E3000000FFE3E3E3E3E3E3E3E3E3E3E30000000000FFE3E3E3E3E3E3E3E3E300
        0000FFE300FFE3E3E3E3E3E3E300000000FFE3E3E30000FFE3E3E3E300000000
        FFE3E3E3E3E30000FFE3E3E30000FFE3E3E3E3E3E3E3E30000FFE3E3E3E3E3E3
        E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3E3}
    end
    object Label11: TLabel
      Left = 26
      Top = 367
      Width = 71
      Height = 13
      Caption = 'Cantidades en '
    end
    object grupo: TGroupBox
      Left = 26
      Top = 31
      Width = 417
      Height = 308
      TabOrder = 0
      object Bevel1: TBevel
        Left = 27
        Top = 159
        Width = 354
        Height = 57
      end
      object Label1: TLabel
        Left = 27
        Top = 32
        Width = 86
        Height = 19
        AutoSize = False
        Caption = ' Empresa'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label2: TLabel
        Left = 27
        Top = 56
        Width = 86
        Height = 19
        AutoSize = False
        Caption = ' Producto'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object BGBEmpresa: TBGridButton
        Left = 152
        Top = 31
        Width = 13
        Height = 21
        Action = DesplegarRejilla
        Glyph.Data = {
          C6000000424DC60000000000000076000000280000000A0000000A0000000100
          0400000000005000000000000000000000001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
          0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
          0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
          0000FFFFFFFFFF000000}
        Control = eEmpresa
        Grid = RejillaFlotante
        GridAlignment = taDownRight
        GridWidth = 280
        GridHeigth = 200
      end
      object BGBProducto: TBGridButton
        Left = 152
        Top = 55
        Width = 13
        Height = 21
        Action = DesplegarRejilla
        Glyph.Data = {
          C6000000424DC60000000000000076000000280000000A0000000A0000000100
          0400000000005000000000000000000000001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
          0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
          0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
          0000FFFFFFFFFF000000}
        Control = eProducto
        Grid = RejillaFlotante
        GridAlignment = taDownRight
        GridWidth = 280
        GridHeigth = 200
      end
      object BGBCliente: TBGridButton
        Left = 164
        Top = 169
        Width = 13
        Height = 21
        Action = DesplegarRejilla
        Glyph.Data = {
          C6000000424DC60000000000000076000000280000000A0000000A0000000100
          0400000000005000000000000000000000001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
          0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
          0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
          0000FFFFFFFFFF000000}
        Control = eCliente
        Grid = RejillaFlotante
        GridAlignment = taDownRight
        GridWidth = 280
        GridHeigth = 200
      end
      object Label6: TLabel
        Left = 39
        Top = 147
        Width = 45
        Height = 13
        Caption = 'Opcional '
      end
      object Label4: TLabel
        Left = 40
        Top = 193
        Width = 327
        Height = 13
        Caption = 
          'Si no indicamos el cliente solo se mostrar'#225' informaci'#243'n sobre lo' +
          's kilos.'
      end
      object Label7: TLabel
        Left = 40
        Top = 170
        Width = 86
        Height = 19
        AutoSize = False
        Caption = ' Cliente Salida'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label8: TLabel
        Left = 27
        Top = 232
        Width = 330
        Height = 13
        Caption = 
          'Con este informe podemos obtener datos de ventas anteriores al 2' +
          '001'
      end
      object Label9: TLabel
        Left = 27
        Top = 248
        Width = 361
        Height = 13
        Caption = 
          'La moneda del informe sera la que tenga el cliente en el hist'#243'ri' +
          'co, ya que no '
      end
      object Label10: TLabel
        Left = 27
        Top = 264
        Width = 173
        Height = 13
        Caption = 'poseemos la informaci'#243'n del cambio.'
      end
      object Label12: TLabel
        Left = 27
        Top = 79
        Width = 117
        Height = 19
        AutoSize = False
        Caption = ' A'#241'o/Semana Desde'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label15: TLabel
        Left = 233
        Top = 79
        Width = 55
        Height = 19
        AutoSize = False
        Caption = ' Hasta'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object lblAnoSemana: TLabel
        Left = 27
        Top = 103
        Width = 251
        Height = 13
        Caption = 'A'#241'o/Semana desde AAAASS hasta AAAASS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object Label13: TLabel
        Left = 27
        Top = 120
        Width = 325
        Height = 13
        Caption = 
          'En el hist'#243'rico solo tenemos la informaci'#243'n temporal del a'#241'o/sem' +
          'ana.'
      end
      object eEmpresa: TBEdit
        Left = 115
        Top = 31
        Width = 36
        Height = 21
        ColorEdit = clMoneyGreen
        MaxLength = 3
        TabOrder = 0
        OnChange = PonNombre
      end
      object eProducto: TBEdit
        Left = 115
        Top = 55
        Width = 36
        Height = 21
        ColorEdit = clMoneyGreen
        MaxLength = 3
        TabOrder = 2
        OnChange = PonNombre
      end
      object eCliente: TBEdit
        Left = 127
        Top = 169
        Width = 36
        Height = 21
        ColorEdit = clMoneyGreen
        ColorNormal = clWindow
        MaxLength = 3
        TabOrder = 7
        OnChange = PonNombre
      end
      object STEmpresa: TStaticText
        Left = 180
        Top = 33
        Width = 200
        Height = 17
        AutoSize = False
        BorderStyle = sbsSunken
        TabOrder = 1
      end
      object STProducto: TStaticText
        Left = 180
        Top = 57
        Width = 157
        Height = 17
        AutoSize = False
        BorderStyle = sbsSunken
        TabOrder = 3
      end
      object STCliente: TStaticText
        Left = 179
        Top = 171
        Width = 190
        Height = 17
        AutoSize = False
        BorderStyle = sbsSunken
        TabOrder = 8
      end
      object cbxTomate: TCheckBox
        Left = 344
        Top = 57
        Width = 97
        Height = 17
        Caption = 'T y E'
        TabOrder = 4
      end
      object eAnyoSemanaDesde: TBEdit
        Left = 152
        Top = 78
        Width = 77
        Height = 21
        ColorEdit = clMoneyGreen
        InputType = itInteger
        MaxLength = 6
        TabOrder = 5
      end
      object eAnyoSemanaHasta: TBEdit
        Left = 291
        Top = 78
        Width = 77
        Height = 21
        ColorEdit = clMoneyGreen
        InputType = itInteger
        MaxLength = 6
        TabOrder = 6
      end
    end
    object cbxCantidadesEn: TComboBox
      Left = 104
      Top = 363
      Width = 81
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 1
      Text = 'Kilogramos'
      Items.Strings = (
        'Kilogramos'
        'Bultos')
    end
  end
  object RejillaFlotante: TBGrid
    Left = 441
    Top = 64
    Width = 89
    Height = 105
    Color = clInfoBk
    Options = [dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
  end
  object ActionList1: TActionList
    Left = 8
    Top = 8
    object Aceptar: TAction
      Caption = 'Aceptar'
      ShortCut = 112
    end
    object Cancelar: TAction
      Caption = 'Cancelar'
      ShortCut = 27
      OnExecute = CancelarExecute
    end
    object DesplegarRejilla: TAction
      ShortCut = 113
      OnExecute = DesplegarRejillaExecute
    end
  end
end
