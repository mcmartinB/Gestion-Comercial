object FDPutPrecioLineaEntrega: TFDPutPrecioLineaEntrega
  Left = 586
  Top = 230
  ActiveControl = edtPrecio
  Caption = 'PUT PRECIO LINEA ENTREGA'
  ClientHeight = 188
  ClientWidth = 433
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object lblUnidadPrecio: TnbLabel
    Left = 14
    Top = 105
    Width = 100
    Height = 21
    Caption = 'Precio '
    About = 'NB 0.1/20020725'
  end
  object lblImporte: TnbLabel
    Left = 14
    Top = 129
    Width = 100
    Height = 21
    Caption = 'Importe'
    About = 'NB 0.1/20020725'
  end
  object lblEnvase: TLabel
    Left = 14
    Top = 22
    Width = 392
    Height = 13
    AutoSize = False
    Caption = 'lblEnvase'
  end
  object lbl1: TnbLabel
    Left = 14
    Top = 56
    Width = 100
    Height = 21
    Caption = 'Kilos '
    About = 'NB 0.1/20020725'
  end
  object lbl2: TnbLabel
    Left = 118
    Top = 56
    Width = 100
    Height = 21
    Caption = 'Cajas'
    About = 'NB 0.1/20020725'
  end
  object lbl3: TnbLabel
    Left = 222
    Top = 56
    Width = 100
    Height = 21
    Caption = 'Unidades'
    About = 'NB 0.1/20020725'
  end
  object lblCategoria: TLabel
    Left = 14
    Top = 39
    Width = 203
    Height = 13
    AutoSize = False
    Caption = 'object lblEnvase: TLabel'
  end
  object lblCalibre: TLabel
    Left = 203
    Top = 39
    Width = 203
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'object lblEnvase: TLabel'
  end
  object edtImporte: TBEdit
    Left = 118
    Top = 129
    Width = 100
    Height = 21
    InputType = itReal
    MaxDecimals = 2
    TabOrder = 8
    OnChange = edtImporteChange
  end
  object edtPrecio: TBEdit
    Left = 118
    Top = 107
    Width = 100
    Height = 21
    InputType = itReal
    MaxDecimals = 4
    TabOrder = 7
    OnChange = edtPrecioChange
  end
  object cbbUnidad_precio_el: TComboBox
    Left = 222
    Top = 105
    Width = 100
    Height = 21
    BevelInner = bvNone
    BevelOuter = bvNone
    Style = csDropDownList
    Color = clInactiveBorder
    Ctl3D = False
    ItemHeight = 13
    ItemIndex = 0
    ParentCtl3D = False
    TabOrder = 0
    Text = 'KILOS'
    OnChange = cbbUnidad_precio_elChange
    Items.Strings = (
      'KILOS'
      'CAJAS'
      'UNIDADES')
  end
  object btnAceptar: TButton
    Left = 332
    Top = 101
    Width = 75
    Height = 25
    Caption = 'Aceptar (F1)'
    TabOrder = 1
    OnClick = btnAceptarClick
  end
  object btnCancelar: TButton
    Left = 332
    Top = 129
    Width = 75
    Height = 25
    Caption = 'Cancelar (Esc)'
    TabOrder = 2
    OnClick = btnCancelarClick
  end
  object btnSiguiente: TButton
    Left = 332
    Top = 70
    Width = 75
    Height = 25
    Caption = 'Siguiente (F3)'
    Enabled = False
    TabOrder = 3
    Visible = False
    OnClick = btnSiguienteClick
  end
  object edtKilos: TEdit
    Left = 14
    Top = 80
    Width = 100
    Height = 21
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 4
  end
  object edtCajas: TEdit
    Left = 118
    Top = 80
    Width = 100
    Height = 21
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 5
  end
  object edtUnidades: TEdit
    Left = 222
    Top = 80
    Width = 100
    Height = 21
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 6
  end
end
