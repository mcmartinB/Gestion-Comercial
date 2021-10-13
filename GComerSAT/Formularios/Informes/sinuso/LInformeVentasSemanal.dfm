object FLInformeVentasSemanal: TFLInformeVentasSemanal
  Left = 367
  Top = 243
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    INFORME PERIODO VENTAS POR ENVASE'
  ClientHeight = 381
  ClientWidth = 499
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
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Label5: TLabel
    Left = 67
    Top = 54
    Width = 84
    Height = 19
    AutoSize = False
    Caption = '  Cliente'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object SpeedButton1: TSpeedButton
    Left = 262
    Top = 315
    Width = 89
    Height = 25
    Action = BAceptar
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
    ParentShowHint = False
    ShowHint = True
  end
  object SpeedButton2: TSpeedButton
    Left = 359
    Top = 315
    Width = 89
    Height = 25
    Action = BCancelar
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000FF00FFBFFF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FFFFFF00FF00FF00FF00
      FF00FF00FF00FF00FF0000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00000000000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0000000000FFFFFF00FF00FFBFFF00FF00FF00
      FF00FF00FF00000000000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
      FF00FF00FF00FF00FF0000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00000000000000000000000000FFFFFF00FF00FFBFFF00
      FF00FF00FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FFFFFF00FF00
      FFBF0000000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
      000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000000000000000
      0000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
      000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FFFFFF00FF00
      FFBF00000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0000000000000000000000000000000000FFFFFF00FF00FFBFFF00
      FF00FF00FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00FFBFFF00
      FF0000000000000000000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
      FF00FF00FF00FF00FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
      FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF000000000000000000FFFFFF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
    ParentShowHint = False
    ShowHint = True
  end
  object Label2: TLabel
    Left = 67
    Top = 278
    Width = 84
    Height = 19
    AutoSize = False
    Caption = ' Categoria'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object stCliente: TnbStaticText
    Left = 215
    Top = 53
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
  end
  object Label8: TLabel
    Left = 68
    Top = 28
    Width = 84
    Height = 19
    AutoSize = False
    Caption = ' Empresa'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object stEmpresa: TnbStaticText
    Left = 216
    Top = 27
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
  end
  object Label9: TLabel
    Left = 195
    Top = 281
    Width = 137
    Height = 13
    Caption = '(Vacio=Todas las categorias)'
  end
  object Label10: TLabel
    Left = 0
    Top = 312
    Width = 161
    Height = 13
    Caption = 'Los productos T y E est'#225'n unidos.'
  end
  object lbl1: TLabel
    Left = 67
    Top = 132
    Width = 84
    Height = 19
    AutoSize = False
    Caption = '  Agrupar por'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lblroducto: TLabel
    Left = 67
    Top = 80
    Width = 84
    Height = 19
    AutoSize = False
    Caption = '  Centro Venta'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lblCentroVenta: TnbStaticText
    Left = 215
    Top = 79
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
  end
  object lblCentroOrigen: TLabel
    Left = 67
    Top = 106
    Width = 84
    Height = 19
    AutoSize = False
    Caption = '  Centro Origen'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object desCentroOrigen: TnbStaticText
    Left = 215
    Top = 105
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
  end
  object edtCategoria: TBEdit
    Left = 157
    Top = 277
    Width = 25
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 2
    TabOrder = 7
  end
  object edtCliente: TnbDBSQLCombo
    Left = 157
    Top = 53
    Width = 57
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = edtClienteChange
    TabOrder = 1
    SQL.Strings = (
      'select distinct cliente_c, nombre_c'
      'from frf_clientes'
      'order by 1,2')
    DatabaseName = 'BDProyecto'
    OnlyNumbers = False
    NumChars = 3
  end
  object pcRangoTiempo: TPageControl
    Left = 67
    Top = 165
    Width = 339
    Height = 105
    ActivePage = tsFechas
    TabIndex = 1
    TabOrder = 6
    TabWidth = 100
    object tsSemanas: TTabSheet
      Caption = 'Semanas'
      object Semana: TLabel
        Left = 19
        Top = 14
        Width = 84
        Height = 19
        AutoSize = False
        Caption = ' Desde Semana'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label3: TLabel
        Left = 19
        Top = 42
        Width = 84
        Height = 19
        AutoSize = False
        Caption = ' Hasta Semana'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label1: TLabel
        Left = 146
        Top = 14
        Width = 45
        Height = 19
        AutoSize = False
        Caption = ' A'#241'o'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label4: TLabel
        Left = 146
        Top = 42
        Width = 45
        Height = 19
        AutoSize = False
        Caption = ' A'#241'o'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object edtSemanaIni: TBEdit
        Left = 109
        Top = 14
        Width = 25
        Height = 21
        ColorEdit = clMoneyGreen
        InputType = itInteger
        MaxLength = 2
        TabOrder = 0
      end
      object edtSemanaFin: TBEdit
        Left = 109
        Top = 40
        Width = 25
        Height = 21
        ColorEdit = clMoneyGreen
        InputType = itInteger
        MaxLength = 2
        TabOrder = 2
      end
      object edtAnyoIni: TBEdit
        Left = 197
        Top = 14
        Width = 36
        Height = 21
        ColorEdit = clMoneyGreen
        InputType = itInteger
        MaxLength = 4
        TabOrder = 1
      end
      object edtAnyoFin: TBEdit
        Left = 197
        Top = 40
        Width = 36
        Height = 21
        ColorEdit = clMoneyGreen
        InputType = itInteger
        MaxLength = 4
        TabOrder = 3
      end
    end
    object tsFechas: TTabSheet
      Caption = 'Fechas'
      ImageIndex = 1
      object Label6: TLabel
        Left = 32
        Top = 18
        Width = 84
        Height = 19
        AutoSize = False
        Caption = ' Desde'
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object Label7: TLabel
        Left = 32
        Top = 42
        Width = 84
        Height = 19
        AutoSize = False
        Caption = ' Hasta '
        Color = cl3DLight
        ParentColor = False
        Layout = tlCenter
      end
      object fechaIni: TnbDBCalendarCombo
        Left = 120
        Top = 18
        Width = 90
        Height = 21
        About = 'NB 0.1/20020725'
        CharCase = ecUpperCase
        Text = '04/02/2005'
        TabOrder = 0
      end
      object fechaFin: TnbDBCalendarCombo
        Left = 120
        Top = 42
        Width = 90
        Height = 21
        About = 'NB 0.1/20020725'
        CharCase = ecUpperCase
        Text = '04/02/2005'
        TabOrder = 1
      end
    end
  end
  object edtEmpresa: TnbDBSQLCombo
    Left = 158
    Top = 27
    Width = 57
    Height = 21
    TabStop = False
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '050'
    OnChange = edtEmpresaChange
    TabOrder = 0
    SQL.Strings = (
      'select empresa_e, nombre_e'
      'from frf_empresas'
      'order by 1')
    DatabaseName = 'BDProyecto'
    OnlyNumbers = False
    NumChars = 3
  end
  object rbEnvase: TRadioButton
    Left = 157
    Top = 133
    Width = 113
    Height = 17
    Caption = 'Envase'
    Checked = True
    TabOrder = 4
    TabStop = True
  end
  object rbAgrupacion: TRadioButton
    Left = 251
    Top = 133
    Width = 134
    Height = 17
    Caption = 'Agrupaci'#243'n Comercial'
    TabOrder = 5
  end
  object edtCentroVenta: TnbDBSQLCombo
    Left = 157
    Top = 79
    Width = 57
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = edtCentroVentaChange
    TabOrder = 2
    SQL.Strings = (
      'select distinct cliente_c, nombre_c'
      'from frf_clientes'
      'order by 1,2')
    DatabaseName = 'BDProyecto'
    OnlyNumbers = False
    NumChars = 3
  end
  object edtCentroOrigen: TnbDBSQLCombo
    Left = 157
    Top = 105
    Width = 57
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = edtCentroOrigenChange
    TabOrder = 3
    SQL.Strings = (
      'select distinct cliente_c, nombre_c'
      'from frf_clientes'
      'order by 1,2')
    DatabaseName = 'BDProyecto'
    OnlyNumbers = False
    NumChars = 3
  end
  object ListaAcciones: TActionList
    Images = DMBaseDatos.ImgBotones
    Left = 91
    Top = 39
    object BAceptar: TAction
      Caption = 'Aceptar'
      ShortCut = 112
      OnExecute = BBAceptarClick
    end
    object BCancelar: TAction
      Caption = 'Cancelar'
      ShortCut = 27
      OnExecute = BBCancelarClick
    end
    object ADesplegarRejilla: TAction
      ImageIndex = 0
      ShortCut = 113
    end
  end
end
