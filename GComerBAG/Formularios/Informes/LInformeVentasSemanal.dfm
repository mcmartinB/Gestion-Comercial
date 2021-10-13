object FLInformeVentasSemanal: TFLInformeVentasSemanal
  Left = 281
  Top = 286
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    INFORME SEMANAL DE VENTAS POR ARTICULOS'
  ClientHeight = 280
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
    Top = 55
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
    Top = 231
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
    Top = 231
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
    Top = 194
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
    Top = 54
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
    Top = 197
    Width = 137
    Height = 13
    Caption = '(Vacio=Todas las categorias)'
  end
  object Label10: TLabel
    Left = 0
    Top = 264
    Width = 161
    Height = 13
    Caption = 'Los productos T y E est'#225'n unidos.'
  end
  object edtCategoria: TBEdit
    Left = 157
    Top = 193
    Width = 25
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 2
    TabOrder = 2
  end
  object edtCliente: TnbDBSQLCombo
    Left = 157
    Top = 54
    Width = 57
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    OnChange = edtClienteChange
    TabOrder = 0
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
    Top = 81
    Width = 339
    Height = 105
    ActivePage = tsFechas
    TabOrder = 1
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
    TabOrder = 3
    SQL.Strings = (
      'select empresa_e, nombre_e'
      'from frf_empresas'
      'order by 1')
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
