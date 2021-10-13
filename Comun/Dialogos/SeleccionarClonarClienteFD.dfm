object FDSeleccionarClonarCliente: TFDSeleccionarClonarCliente
  Left = 470
  Top = 272
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  SELECCIONE SI QUIERE DAR UNA NUEVA ALTA O CLONAR UNA EXISTENTE'
  ClientHeight = 217
  ClientWidth = 525
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 525
    Height = 217
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 397
      Top = 134
      Width = 89
      Height = 25
      Hint = 'Pulse F1 para aceptar los datos introducidos.'
      Caption = 'Aceptar'
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
      OnClick = BAceptarExecute
    end
    object lblNueva: TLabel
      Left = 55
      Top = 134
      Width = 137
      Height = 19
      AutoSize = False
      Caption = ' Nuevo Codigo Cliente'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object GBEmpresa: TGroupBox
      Left = 40
      Top = 69
      Width = 446
      Height = 52
      TabOrder = 2
      object Label1: TLabel
        Left = 15
        Top = 20
        Width = 82
        Height = 19
        AutoSize = False
        Caption = 'Cliente'
        Color = cl3DLight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
      end
      object edtCliente: TBEdit
        Left = 73
        Top = 18
        Width = 40
        Height = 21
        ColorEdit = clMoneyGreen
        Enabled = False
        MaxLength = 3
        TabOrder = 0
        OnChange = PonNombre
      end
      object txtCliente: TStaticText
        Left = 114
        Top = 21
        Width = 266
        Height = 17
        AutoSize = False
        BorderStyle = sbsSunken
        TabOrder = 1
      end
    end
    object rbNueva: TRadioButton
      Left = 40
      Top = 24
      Width = 113
      Height = 17
      Caption = 'Nueva'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rbClonarClick
    end
    object rbClonar: TRadioButton
      Left = 40
      Top = 47
      Width = 297
      Height = 17
      Caption = 'Seleccione el c'#243'digo del cliente que quiere clonar'
      TabOrder = 1
      OnClick = rbClonarClick
    end
    object edtClienteNew: TBEdit
      Left = 182
      Top = 134
      Width = 49
      Height = 21
      ColorEdit = clMoneyGreen
      Enabled = False
      MaxLength = 3
      TabOrder = 3
      OnChange = PonNombre
    end
  end
  object RejillaFlotante: TBGrid
    Left = 480
    Top = 24
    Width = 50
    Height = 25
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
  object CalendarioFlotante: TBCalendario
    Left = 496
    Top = 88
    Width = 177
    Height = 153
    Date = 36822.829442060190000000
    ShowToday = False
    TabOrder = 2
    Visible = False
    WeekNumbers = True
  end
  object ListaAcciones: TActionList
    Images = DMBaseDatos.ImgBotones
    Left = 8
    Top = 8
    object BAceptar: TAction
      Caption = 'Aceptar'
      ImageIndex = 1
      ShortCut = 112
      OnExecute = BAceptarExecute
    end
    object BCancelar: TAction
      Caption = 'Cancelar'
      ImageIndex = 2
      ShortCut = 27
    end
    object RejillaDespegable: TAction
      ImageIndex = 0
      ShortCut = 113
    end
  end
end
