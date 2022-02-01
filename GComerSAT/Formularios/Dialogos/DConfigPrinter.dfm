object FDConfigPrinter: TFDConfigPrinter
  Left = 236
  Top = 153
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '     CONFIGURACI'#211'N DE LA IMPRESORA'
  ClientHeight = 258
  ClientWidth = 507
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 76
    Top = 26
    Width = 49
    Height = 13
    Caption = 'Impresora '
  end
  object Label2: TLabel
    Left = 116
    Top = 75
    Width = 130
    Height = 13
    Caption = 'N'#250'mero de copias. (Max. 9)'
  end
  object cbImpresoras: TComboBox
    Left = 76
    Top = 42
    Width = 348
    Height = 21
    ItemHeight = 13
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 350
    Top = 196
    Width = 75
    Height = 25
    Caption = '&Cancelar'
    TabOrder = 1
    Kind = bkCancel
  end
  object BitBtn2: TBitBtn
    Left = 270
    Top = 196
    Width = 75
    Height = 25
    Caption = '&Imprimir'
    ModalResult = 1
    TabOrder = 2
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object NumeroCopias: TSpinEdit
    Left = 76
    Top = 70
    Width = 31
    Height = 22
    MaxValue = 9
    MinValue = 1
    TabOrder = 3
    Value = 1
  end
  object GroupBox1: TGroupBox
    Left = 76
    Top = 102
    Width = 348
    Height = 73
    Caption = ' X hojas - Imprimir '
    TabOrder = 4
    object Label3: TLabel
      Left = 241
      Top = 34
      Width = 6
      Height = 13
      Caption = 'a'
    end
    object Hasta: TBEdit
      Left = 254
      Top = 30
      Width = 33
      Height = 21
      InputType = itInteger
      Enabled = False
      TabOrder = 3
    end
    object Desde: TBEdit
      Left = 203
      Top = 30
      Width = 33
      Height = 21
      InputType = itInteger
      Enabled = False
      TabOrder = 2
    end
    object RadioButton1: TRadioButton
      Left = 43
      Top = 32
      Width = 65
      Height = 17
      Caption = 'Todas'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = RadioButtonClick
    end
    object RadioButton2: TRadioButton
      Left = 131
      Top = 32
      Width = 65
      Height = 17
      Caption = 'Rango de  '
      TabOrder = 1
      OnClick = RadioButtonClick
    end
  end
end
