object FDCambiarCodigoEntrega: TFDCambiarCodigoEntrega
  Left = 601
  Top = 269
  ActiveControl = edtplanta
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'CAMBIAR LA PLANTA DE LA ENTREGA '
  ClientHeight = 192
  ClientWidth = 533
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
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object lblNombre7: TLabel
    Left = 27
    Top = 102
    Width = 108
    Height = 17
    AutoSize = False
    Caption = ' Planta'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lblPlanta: TLabel
    Left = 179
    Top = 105
    Width = 30
    Height = 13
    Caption = 'Planta'
  end
  object lblEntrega: TLabel
    Left = 27
    Top = 80
    Width = 108
    Height = 17
    AutoSize = False
    Caption = ' Entrega'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lblCentro2: TLabel
    Left = 27
    Top = 125
    Width = 108
    Height = 17
    AutoSize = False
    Caption = ' Centro'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lblCentro: TLabel
    Left = 179
    Top = 128
    Width = 31
    Height = 13
    Caption = 'Centro'
  end
  object lbl1: TLabel
    Left = 27
    Top = 13
    Width = 462
    Height = 13
    Caption = 
      'Esta aplicaci'#243'n genera una copia de la entrega selecionada con u' +
      'n nuevo c'#243'digo y luego la borra'
  end
  object lbl2: TLabel
    Left = 27
    Top = 29
    Width = 452
    Height = 13
    Caption = 
      'Para que funcione correctamente es necesario que existan los mis' +
      'mos proveedores, productos, '
  end
  object lbl3: TLabel
    Left = 27
    Top = 46
    Width = 172
    Height = 13
    Caption = 'transportistas,  ...  en ambas plantas.'
  end
  object btnAceptar: TButton
    Left = 316
    Top = 156
    Width = 100
    Height = 25
    Caption = 'Cambiar'
    Enabled = False
    TabOrder = 3
    OnClick = btnAceptarClick
  end
  object btnCancelar: TButton
    Left = 422
    Top = 156
    Width = 100
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 4
    OnClick = btnCancelarClick
  end
  object edtplanta: TBEdit
    Left = 139
    Top = 101
    Width = 32
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 13
    TabOrder = 1
    OnChange = edtplantaChange
  end
  object edtEntrega: TBEdit
    Left = 139
    Top = 79
    Width = 112
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 13
    TabOrder = 0
    OnChange = edtplantaChange
  end
  object edtCentro: TBEdit
    Left = 139
    Top = 124
    Width = 32
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 13
    TabOrder = 2
    OnChange = edtCentroChange
  end
  object chkQuiero: TCheckBox
    Left = 336
    Top = 44
    Width = 153
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Quiero cambiar la planta'
    TabOrder = 5
    OnClick = chkQuieroClick
  end
end
