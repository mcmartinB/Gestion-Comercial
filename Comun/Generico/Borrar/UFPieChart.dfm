object Form1: TForm1
  Left = 332
  Top = 151
  Width = 796
  Height = 744
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 16
    Top = 176
    Width = 753
    Height = 521
  end
  object lblNombre1: TLabel
    Left = 585
    Top = 32
    Width = 31
    Height = 13
    Caption = 'Ancho'
  end
  object btnNombre1: TButton
    Left = 21
    Top = 16
    Width = 80
    Height = 25
    Caption = 'btnNombre1'
    TabOrder = 0
    OnClick = btnNombre1Click
  end
  object e01: TEdit
    Left = 21
    Top = 73
    Width = 80
    Height = 21
    TabOrder = 1
    Text = '6205,46'
  end
  object e02: TEdit
    Left = 21
    Top = 98
    Width = 80
    Height = 21
    TabOrder = 2
    Text = '23946,85'
  end
  object e03: TEdit
    Left = 21
    Top = 124
    Width = 80
    Height = 21
    TabOrder = 3
    Text = '1381,97'
  end
  object e04: TEdit
    Left = 21
    Top = 149
    Width = 80
    Height = 21
    TabOrder = 4
    Text = '196248,84'
  end
  object e05: TEdit
    Left = 285
    Top = 47
    Width = 80
    Height = 21
    TabOrder = 5
    Text = '181551'
  end
  object e06: TEdit
    Left = 285
    Top = 72
    Width = 80
    Height = 21
    TabOrder = 6
    Text = '-29235,26'
  end
  object e07: TEdit
    Left = 285
    Top = 98
    Width = 80
    Height = 21
    TabOrder = 7
    Text = '0'
  end
  object e09: TEdit
    Left = 285
    Top = 149
    Width = 80
    Height = 21
    TabOrder = 8
  end
  object e08: TEdit
    Left = 285
    Top = 123
    Width = 80
    Height = 21
    TabOrder = 9
    Text = '1078251,89'
  end
  object e11: TEdit
    Left = 109
    Top = 73
    Width = 169
    Height = 21
    TabOrder = 10
    Text = 'Descuento'
  end
  object e12: TEdit
    Left = 109
    Top = 98
    Width = 169
    Height = 21
    TabOrder = 11
    Text = 'Gastos Ventas'
  end
  object e13: TEdit
    Left = 109
    Top = 124
    Width = 169
    Height = 21
    TabOrder = 12
    Text = 'Gastos Transitos'
  end
  object e14: TEdit
    Left = 109
    Top = 149
    Width = 169
    Height = 21
    TabOrder = 13
    Text = 'Coste Envasado'
  end
  object e15: TEdit
    Left = 373
    Top = 47
    Width = 169
    Height = 21
    TabOrder = 14
    Text = 'Coste Secciones'
  end
  object e16: TEdit
    Left = 373
    Top = 72
    Width = 169
    Height = 21
    TabOrder = 15
    Text = 'Costes Indirectos'
  end
  object e17: TEdit
    Left = 373
    Top = 98
    Width = 169
    Height = 21
    TabOrder = 16
    Text = 'Abonos'
  end
  object e19: TEdit
    Left = 373
    Top = 149
    Width = 169
    Height = 21
    TabOrder = 17
  end
  object e18: TEdit
    Left = 373
    Top = 123
    Width = 169
    Height = 21
    TabOrder = 18
    Text = 'Ganancia'
  end
  object e00: TEdit
    Left = 21
    Top = 48
    Width = 80
    Height = 21
    TabOrder = 19
    Text = '3172,78'
  end
  object e10: TEdit
    Left = 109
    Top = 48
    Width = 169
    Height = 21
    TabOrder = 20
    Text = 'Comison'
  end
  object eAncho: TEdit
    Left = 585
    Top = 48
    Width = 121
    Height = 21
    TabOrder = 21
    Text = '521'
  end
  object cbxLeyenda: TComboBox
    Left = 584
    Top = 72
    Width = 121
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 1
    TabOrder = 22
    Text = 'Pintar leyenda'
    Items.Strings = (
      'No pintar leyenda'
      'Pintar leyenda')
  end
end
