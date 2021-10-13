object FLCompras: TFLCompras
  Left = 570
  Top = 250
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  LISTADO COMPRAS'
  ClientHeight = 279
  ClientWidth = 504
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
    Width = 504
    Height = 279
    Align = alClient
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label2: TLabel
      Left = 40
      Top = 85
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Centro'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 40
      Top = 36
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBEmpresa_c: TBGridButton
      Left = 161
      Top = 35
      Width = 13
      Height = 21
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = ARejillaFlotanteExecute
      Control = edtempresa
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 230
      GridHeigth = 200
    end
    object BGBCentro_c: TBGridButton
      Left = 161
      Top = 84
      Width = 13
      Height = 21
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = ARejillaFlotanteExecute
      Control = edtcentro
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 230
      GridHeigth = 200
    end
    object LFecha: TLabel
      Left = 40
      Top = 61
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Fecha  Desde'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BCBFecha_c: TBCalendarButton
      Left = 201
      Top = 60
      Width = 13
      Height = 21
      Hint = 'Pulse F2 para ver una lista de valores validos. '
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
      OnClick = ARejillaFlotanteExecute
      Control = edtfechaIni
      Calendar = CalendarioFlotante
      CalendarAlignment = taDownRight
      CalendarWidth = 197
      CalendarHeigth = 153
    end
    object lblNombre1: TLabel
      Left = 40
      Top = 109
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Num. Compra'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre2: TLabel
      Left = 40
      Top = 134
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Proveedor'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object BGBProveedor_c: TBGridButton
      Left = 161
      Top = 133
      Width = 13
      Height = 21
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      Glyph.Data = {
        C6000000424DC60000000000000076000000280000000A0000000A0000000100
        0400000000005000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF00
        0000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFF0FFFFF00
        0000FFF000FFFF000000FF00000FFF000000F0000000FF000000FFFFFFFFFF00
        0000FFFFFFFFFF000000}
      OnClick = ARejillaFlotanteExecute
      Control = edtproveedor
      Grid = RejillaFlotante
      GridAlignment = taDownRight
      GridWidth = 230
      GridHeigth = 200
    end
    object lblNombre6: TLabel
      Left = 40
      Top = 158
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Ref. Proveedor'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object btnOk: TSpeedButton
      Left = 252
      Top = 224
      Width = 99
      Height = 25
      Caption = 'Listado (F1)'
      OnClick = btnOkClick
    end
    object btnCancel: TSpeedButton
      Left = 352
      Top = 224
      Width = 99
      Height = 25
      Caption = 'Cerrar (Esc)'
      OnClick = btnCancelClick
    end
    object btnFechaHasta1: TBCalendarButton
      Left = 344
      Top = 60
      Width = 13
      Height = 21
      Hint = 'Pulse F2 para ver una lista de valores validos. '
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
      OnClick = ARejillaFlotanteExecute
      Control = edtFechaFin
      Calendar = CalendarioFlotante
      CalendarAlignment = taDownRight
      CalendarWidth = 197
      CalendarHeigth = 153
    end
    object lblFechaHasta: TLabel
      Left = 218
      Top = 61
      Width = 49
      Height = 19
      AutoSize = False
      Caption = ' Hasta'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblNombre3: TLabel
      Left = 40
      Top = 182
      Width = 80
      Height = 19
      AutoSize = False
      Caption = ' Gastos'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object stEmpresa_c: TStaticText
      Left = 176
      Top = 37
      Width = 280
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 2
    end

    object stCentro_c: TStaticText
      Left = 176
      Top = 86
      Width = 280
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 6
    end
    object stProveedor_c: TStaticText
      Left = 176
      Top = 135
      Width = 280
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      TabOrder = 9
    end
    object edtempresa: TBEdit
      Left = 126
      Top = 35
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      MaxLength = 3
      TabOrder = 1
      OnChange = edtempresaChange
    end
    object edtcentro: TBEdit
      Left = 126
      Top = 84
      Width = 17
      Height = 21
      ColorEdit = clMoneyGreen
      TabOrder = 5
      OnChange = edtcentroChange
    end
    object edtfechaIni: TBEdit
      Tag = 999
      Left = 126
      Top = 60
      Width = 73
      Height = 21
      ColorEdit = clMoneyGreen
      ColorDisable = cl3DLight
      InputType = itDate
      MaxLength = 10
      TabOrder = 3
    end
    object edtnumero: TBEdit
      Left = 126
      Top = 108
      Width = 73
      Height = 21
      ColorEdit = clMoneyGreen
      InputType = itInteger
      MaxLength = 5
      TabOrder = 7
    end
    object edtproveedor: TBEdit
      Left = 126
      Top = 133
      Width = 33
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      MaxLength = 3
      TabOrder = 8
      OnChange = edtproveedorChange
    end
    object edtref_compra: TBEdit
      Left = 126
      Top = 157
      Width = 151
      Height = 21
      ColorEdit = clMoneyGreen
      MaxLength = 20
      TabOrder = 10
    end
    object edtFechaFin: TBEdit
      Tag = 999
      Left = 269
      Top = 60
      Width = 73
      Height = 21
      ColorEdit = clMoneyGreen
      ColorDisable = cl3DLight
      InputType = itDate
      MaxLength = 10
      TabOrder = 4
    end
    object cbbGastos: TComboBox
      Left = 126
      Top = 181
      Width = 151
      Height = 21
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 11
      Text = 'Indiferente'
      Items.Strings = (
        'Indiferente'
        'Asignados'
        'Sin Asignar')
    end
  end
  object CalendarioFlotante: TBCalendario
    Left = 438
    Top = 52
    Width = 177
    Height = 136
    AutoSize = True
    Date = 36717.4337062037
    ShowToday = False
    TabOrder = 1
    Visible = False
    WeekNumbers = True
  end
    object RejillaFlotante: TBGrid
      Left = 479
      Top = 18
      Width = 73
      Height = 33
      Color = clInfoBk
      Options = [dgRowSelect, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Visible = False
      BControl = edtempresa
    end
end
