object FDDatosCMR: TFDDatosCMR
  Left = 373
  Top = 202
  Width = 443
  Height = 551
  Caption = 'Datos CMR'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 153
    Width = 109
    Height = 13
    Caption = 'Casilla 2: Consignatario'
  end
  object Label2: TLabel
    Left = 16
    Top = 14
    Width = 93
    Height = 13
    Caption = 'Casilla 1: Remitente'
  end
  object lblcarga: TLabel
    Left = 16
    Top = 394
    Width = 114
    Height = 13
    Caption = 'Casilla 4:Lugar de carga'
  end
  object lblEntrega: TLabel
    Left = 16
    Top = 293
    Width = 200
    Height = 13
    Caption = 'Casilla 3: Lugar de entrega ( Max 3 lineas )'
  end
  object mmoRemitente: TMemo
    Left = 16
    Top = 57
    Width = 399
    Height = 89
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object mmoConsignatario: TMemo
    Left = 16
    Top = 198
    Width = 399
    Height = 89
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object ComboOrigen: TComboBox
    Left = 16
    Top = 33
    Width = 399
    Height = 22
    Style = csDropDownList
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 269
    Top = 480
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 6
    Kind = bkCancel
  end
  object BitBtn2: TBitBtn
    Left = 350
    Top = 480
    Width = 75
    Height = 25
    Caption = 'Aceptar'
    TabOrder = 7
    Kind = bkOK
  end
  object ComboSuministro: TComboBox
    Left = 16
    Top = 172
    Width = 399
    Height = 22
    Style = csDropDownList
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    TabOrder = 2
  end
  object mmoOrigen: TMemo
    Left = 16
    Top = 410
    Width = 399
    Height = 62
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object mmoEntrega: TMemo
    Left = 16
    Top = 310
    Width = 399
    Height = 78
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object QAux: TQuery
    DatabaseName = 'BDProyecto'
    SQL.Strings = (
      'select * '
      'from frf_clientes')
    Left = 88
    Top = 41
  end
  object DataSource: TDataSource
    DataSet = QAux
    Left = 120
    Top = 49
  end
end
