object FDPrecioFacturaPlatano: TFDPrecioFacturaPlatano
  Left = 783
  Top = 254
  ActiveControl = edtSemana
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = '    ASIGNAR PRECIO SEMANA'
  ClientHeight = 150
  ClientWidth = 330
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblPrecio: TLabel
    Left = 185
    Top = 74
    Width = 50
    Height = 13
    Caption = 'Precio Kilo'
  end
  object lblSemana: TLabel
    Left = 16
    Top = 74
    Width = 106
    Height = 13
    Caption = 'A'#241'o/Semana (aaaass)'
  end
  object chkSinPrecio: TRadioButton
    Left = 16
    Top = 18
    Width = 281
    Height = 17
    Caption = 'Asignar precio a las facturas de la semana sin precio'
    Checked = True
    TabOrder = 0
    TabStop = True
  end
  object chkTodas: TRadioButton
    Left = 16
    Top = 42
    Width = 289
    Height = 17
    Caption = 'Asignar precio a todas las facturas de la semana'
    TabOrder = 1
  end
  object edtPrecio: TBEdit
    Left = 242
    Top = 70
    Width = 50
    Height = 21
    TabOrder = 3
  end
  object btnAceptar: TButton
    Left = 166
    Top = 113
    Width = 75
    Height = 25
    Caption = 'Aceptar'
    TabOrder = 4
    OnClick = btnAceptarClick
  end
  object btnCancelar: TButton
    Left = 246
    Top = 113
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 5
    OnClick = btnCancelarClick
  end
  object edtSemana: TBEdit
    Left = 127
    Top = 70
    Width = 50
    Height = 21
    InputType = itInteger
    MaxLength = 6
    TabOrder = 2
    OnChange = edtSemanaChange
  end
end
