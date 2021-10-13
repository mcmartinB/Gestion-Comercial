object FLRecadvFilter: TFLRecadvFilter
  Left = 440
  Top = 178
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = '    RECADV - Confirmaci'#243'n de Recepci'#243'n de Mercancias EDI'
  ClientHeight = 221
  ClientWidth = 385
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  DesignSize = (
    385
    221)
  PixelsPerInch = 96
  TextHeight = 13
  object lblNombre1: TLabel
    Left = 28
    Top = 28
    Width = 80
    Height = 19
    AutoSize = False
    Caption = ' Empresa'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lblNombre2: TLabel
    Left = 28
    Top = 52
    Width = 80
    Height = 19
    AutoSize = False
    Caption = ' Fecha Del'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lblNombre3: TLabel
    Left = 28
    Top = 76
    Width = 80
    Height = 19
    AutoSize = False
    Caption = ' Albar'#225'n'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lblNombre4: TLabel
    Left = 28
    Top = 100
    Width = 80
    Height = 19
    AutoSize = False
    Caption = ' Pedido'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lblNombre5: TLabel
    Left = 28
    Top = 124
    Width = 80
    Height = 19
    AutoSize = False
    Caption = ' Matr'#237'cula'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lblNombre6: TLabel
    Left = 204
    Top = 52
    Width = 29
    Height = 19
    AutoSize = False
    Caption = ' Al'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object stEmpresa: TnbStaticText
    Left = 169
    Top = 27
    Width = 190
    Height = 21
    Caption = 'stEmpresa'
    About = 'NB 0.1/20020725'
  end
  object btnCerrar: TBitBtn
    Left = 270
    Top = 172
    Width = 90
    Height = 25
    Anchors = []
    Caption = 'Cerrar (Esc)'
    TabOrder = 7
    TabStop = False
    OnClick = btnCerrarClick
    Kind = bkCancel
  end
  object btnBuscar: TBitBtn
    Left = 173
    Top = 172
    Width = 90
    Height = 25
    Anchors = []
    Caption = 'Buscar (L)'
    ModalResult = 1
    TabOrder = 6
    TabStop = False
    OnClick = btnBuscarClick
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF008484840000000000000000000000000084848400FF00FF0000FF
      FF008484840000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00000000008484840084848400848484008484840084848400000000000000
      000000FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
      000084848400FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00848484000000
      0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00848484008484
      8400FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF008484
      840084848400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000008484
      8400C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C6008484
      840000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000008484
      8400FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF008484
      840000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000008484
      8400C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C6008484
      840000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00848484008484
      8400FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF008484
      840084848400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
      000084848400FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00848484000000
      0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0000000000848484008484840084848400848484008484840000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF008484840000000000000000000000000084848400FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
  end
  object eFechaIni: TnbDBCalendarCombo
    Left = 113
    Top = 51
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '17/07/2009'
    TabOrder = 1
  end
  object eEmpresa: TnbDBSQLCombo
    Left = 113
    Top = 27
    Width = 52
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = 'NBDBSQLCOMBO1'
    OnChange = eEmpresaChange
    TabOrder = 0
    SQL.Strings = (
      'select empresa_e, nombre_e'
      'from frf_empresas'
      'order by empresa_e')
    DatabaseName = 'bdProyecto'
  end
  object eAlbaran: TBEdit
    Left = 113
    Top = 75
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object ePedido: TBEdit
    Left = 113
    Top = 99
    Width = 121
    Height = 21
    TabOrder = 4
  end
  object eMatricula: TBEdit
    Left = 113
    Top = 123
    Width = 121
    Height = 21
    TabOrder = 5
  end
  object eFechaFin: TnbDBCalendarCombo
    Left = 239
    Top = 51
    Width = 90
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Text = '17/07/2009'
    TabOrder = 2
  end
end
