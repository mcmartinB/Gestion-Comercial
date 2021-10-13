object FLLiquidacionEntrega: TFLLiquidacionEntrega
  Left = 635
  Top = 255
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    Informe Liquidaci'#243'n Remesa de Entrega'
  ClientHeight = 383
  ClientWidth = 418
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
  OnKeyUp = FormKeyUp
  DesignSize = (
    418
    383)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 16
    Top = 50
    Width = 385
    Height = 248
  end
  object Label3: TLabel
    Left = 5
    Top = 310
    Width = 412
    Height = 13
    Caption = 'POR FAVOR INTRODUZCA EL N'#218'MERO DE LA ENTREGA A LIQUIDAR'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblEntrega: TnbLabel
    Left = 32
    Top = 18
    Width = 100
    Height = 21
    Caption = 'Entrega'
    About = 'NB 0.1/20020725'
  end
  object nbLabel1: TnbLabel
    Left = 31
    Top = 68
    Width = 100
    Height = 21
    Caption = 'Producto'
    About = 'NB 0.1/20020725'
  end
  object nbLabel2: TnbLabel
    Left = 31
    Top = 92
    Width = 100
    Height = 21
    Caption = 'Variedad'
    About = 'NB 0.1/20020725'
  end
  object nbLabel3: TnbLabel
    Left = 31
    Top = 116
    Width = 100
    Height = 21
    Caption = 'Calibre'
    About = 'NB 0.1/20020725'
  end
  object nbLabel4: TnbLabel
    Left = 136
    Top = 140
    Width = 80
    Height = 21
    Caption = 'Entrega'
    About = 'NB 0.1/20020725'
  end
  object nbLabel5: TnbLabel
    Left = 31
    Top = 164
    Width = 100
    Height = 21
    Caption = 'Palets'
    About = 'NB 0.1/20020725'
  end
  object nbLabel6: TnbLabel
    Left = 31
    Top = 188
    Width = 100
    Height = 21
    Caption = 'Kilos'
    About = 'NB 0.1/20020725'
  end
  object nbLabel7: TnbLabel
    Left = 220
    Top = 140
    Width = 80
    Height = 21
    Caption = 'Salida'
    About = 'NB 0.1/20020725'
  end
  object lblPaletsIn: TLabel
    Left = 136
    Top = 168
    Width = 80
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'lblPaletsIn'
  end
  object lblPaletsOut: TLabel
    Left = 220
    Top = 168
    Width = 80
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'lblPaletsOut'
  end
  object lblKilosIn: TLabel
    Left = 136
    Top = 192
    Width = 80
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'lblKilosIn'
  end
  object lblKilosOut: TLabel
    Left = 220
    Top = 192
    Width = 80
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'lblKilosOut'
  end
  object stProducto: TLabel
    Left = 195
    Top = 72
    Width = 190
    Height = 13
    AutoSize = False
  end
  object stVariedad: TLabel
    Left = 195
    Top = 96
    Width = 190
    Height = 13
    AutoSize = False
  end
  object nbLabel8: TnbLabel
    Left = 32
    Top = 213
    Width = 100
    Height = 21
    Caption = 'Ajuste Kgs Vta'
    About = 'NB 0.1/20020725'
  end
  object nbLabel9: TnbLabel
    Left = 32
    Top = 237
    Width = 100
    Height = 21
    Caption = 'Ajuste Destrio'
    About = 'NB 0.1/20020725'
  end
  object nbLabel10: TnbLabel
    Left = 305
    Top = 140
    Width = 80
    Height = 21
    Caption = 'Destrio'
    About = 'NB 0.1/20020725'
  end
  object lblKilosDestrio: TLabel
    Left = 305
    Top = 192
    Width = 80
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'lblKilosDestrio'
  end
  object nbLabel11: TnbLabel
    Left = 31
    Top = 262
    Width = 100
    Height = 21
    Caption = 'Cuadre KG'
    About = 'NB 0.1/20020725'
  end
  object lblCuadre: TLabel
    Left = 136
    Top = 266
    Width = 80
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'lblCuadre'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblPaletsDestrio: TLabel
    Left = 305
    Top = 168
    Width = 80
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'lblPaletsDestrio'
  end
  object nbLabel12: TnbLabel
    Left = 220
    Top = 213
    Width = 80
    Height = 21
    Caption = 'Importe Pte Vta'
    About = 'NB 0.1/20020725'
  end
  object nbLabel13: TnbLabel
    Left = 220
    Top = 237
    Width = 80
    Height = 21
    Caption = 'Importe Destrio'
    About = 'NB 0.1/20020725'
  end
  object btnCerrar: TBitBtn
    Left = 301
    Top = 334
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cerrar (Esc)'
    TabOrder = 0
    TabStop = False
    OnClick = btnCerrarClick
    Kind = bkCancel
  end
  object btnAceptar: TBitBtn
    Left = 195
    Top = 334
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Aceptar (F1)'
    ModalResult = 1
    TabOrder = 1
    TabStop = False
    OnClick = btnAceptarClick
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
  object eEntrega: TBEdit
    Left = 137
    Top = 18
    Width = 80
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 12
    TabOrder = 2
  end
  object cbxProducto: TComboBox
    Left = 136
    Top = 68
    Width = 57
    Height = 21
    Style = csDropDownList
    Enabled = False
    ItemHeight = 13
    MaxLength = 3
    TabOrder = 3
    OnChange = cbxProductoChange
  end
  object cbxVariedad: TComboBox
    Left = 136
    Top = 92
    Width = 57
    Height = 21
    Style = csDropDownList
    Enabled = False
    ItemHeight = 13
    TabOrder = 4
    OnChange = cbxVariedadChange
  end
  object cbxCalibre: TComboBox
    Left = 136
    Top = 116
    Width = 145
    Height = 21
    Style = csDropDownList
    Enabled = False
    ItemHeight = 13
    TabOrder = 5
    OnChange = cbxCalibreChange
  end
  object eAjusteKilosVenta: TBEdit
    Left = 136
    Top = 213
    Width = 80
    Height = 21
    ColorEdit = clMoneyGreen
    Enabled = False
    MaxLength = 12
    TabOrder = 6
    OnChange = eAjusteKilosVentaChange
  end
  object eAjusteKilosDestrio: TBEdit
    Left = 136
    Top = 237
    Width = 80
    Height = 21
    ColorEdit = clMoneyGreen
    Enabled = False
    MaxLength = 12
    TabOrder = 7
    OnChange = eAjusteKilosDestrioChange
  end
  object eImportePteVta: TBEdit
    Left = 305
    Top = 213
    Width = 80
    Height = 21
    ColorEdit = clMoneyGreen
    Enabled = False
    MaxLength = 12
    TabOrder = 8
    OnChange = eImportePteVtaChange
  end
  object eImporteDestrio: TBEdit
    Left = 305
    Top = 237
    Width = 80
    Height = 21
    ColorEdit = clMoneyGreen
    Enabled = False
    MaxLength = 12
    TabOrder = 9
    OnChange = eImporteDestrioChange
  end
end
