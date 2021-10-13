object FKilosComercializadosMes: TFKilosComercializadosMes
  Left = 921
  Top = 146
  Width = 482
  Height = 282
  Caption = 'Kilos Comercializados Mes'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblSeleccionarMes: TLabel
    Left = 16
    Top = 42
    Width = 79
    Height = 13
    Caption = 'Seleccionar Mes'
  end
  object lbldatos: TLabel
    Left = 224
    Top = 42
    Width = 38
    Height = 13
    Caption = 'lblDatos'
  end
  object lbl1: TLabel
    Left = 16
    Top = 14
    Width = 346
    Height = 13
    Caption = 
      'Todos los productos categoria 1'#170' y 2'#170' de la empresa 050 SAT BONN' +
      'YSA'
  end
  object mmoResultado: TMemo
    Left = 16
    Top = 72
    Width = 441
    Height = 161
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
  end
  object dtpMes: TDateTimePicker
    Left = 120
    Top = 38
    Width = 89
    Height = 21
    CalAlignment = dtaLeft
    Date = 40772.7795934606
    Time = 40772.7795934606
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 1
    OnChange = dtpMesChange
  end
  object btnCalcular: TButton
    Left = 382
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Calcular'
    TabOrder = 2
    OnClick = btnCalcularClick
  end
  object btnCerrar: TButton
    Left = 382
    Top = 36
    Width = 75
    Height = 25
    Caption = 'Cerrar'
    TabOrder = 3
    OnClick = btnCerrarClick
  end
  object Query: TQuery
    DatabaseName = 'BDProyecto'
    Left = 336
    Top = 32
  end
end
