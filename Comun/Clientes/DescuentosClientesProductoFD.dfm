object FDDescuentosClientesProducto: TFDDescuentosClientesProducto
  Left = 739
  Top = 207
  Caption = '    DESCUENTOS DEL CLIENTE POR PRODUCTO'
  ClientHeight = 467
  ClientWidth = 913
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
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object btnAceptar: TSpeedButton
    Left = 662
    Top = 414
    Width = 100
    Height = 26
    Caption = 'Aceptar (F1)'
    Enabled = False
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF000000FF0000000080FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF000000FF000000FF000000FF0000000000FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF000000FF000000FF000000FF0000000000FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF000000FF000000FF000000FF000000FF000000FF0000000080FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF000000FF000000FF000000FF000000FF000000FF000000FF0000000080FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF3F7F7F
      7F000000FF000000FF0000000080FF00FF000000FF000000FF000000FF000000
      0000FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF007F7F7F000000
      FF0000000080FF00FF00FF00FF80FF00FF00FF00FF000000FF000000FF000000
      0000FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF000000FF000000FF000000
      FF0000000080FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF000000FF000000
      FF0000000080FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF000000
      FF000000FF0000000000FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF007F7F7F000000FF0000000080FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF3F7F7F7F000000FF0000000000FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF000000FF000000FF0000000000FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00
      FF00FF00FF80FF00FF00FF00FF80FF00FF00FF00FF80FF00FF00}
    OnClick = btnAceptarClick
  end
  object btnCancelar: TSpeedButton
    Left = 764
    Top = 414
    Width = 100
    Height = 26
    Caption = 'Cerrar (Esc)'
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000FF00FFBFFF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FFFFFF00FF00FF00FF00
      FF00FF00FF00FF00FF0000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00000000000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0000000000FFFFFF00FF00FFBFFF00FF00FF00
      FF00FF00FF00000000000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
      FF00FF00FF00FF00FF0000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00000000000000000000000000FFFFFF00FF00FFBFFF00
      FF00FF00FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FFFFFF00FF00
      FFBF0000000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
      000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000000000000000
      0000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
      000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FFFFFF00FF00
      FFBF00000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0000000000000000000000000000000000FFFFFF00FF00FFBFFF00
      FF00FF00FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00FFBFFF00
      FF0000000000000000000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
      FF00FF00FF00FF00FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
      FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF000000000000000000FFFFFF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
    OnClick = btnCancelarClick
  end
  object nbLabel2: TnbLabel
    Left = 33
    Top = 104
    Width = 100
    Height = 21
    Caption = 'Fecha Inicial'
    About = 'NB 0.1/20020725'
  end
  object nbLabel3: TnbLabel
    Left = 33
    Top = 54
    Width = 100
    Height = 21
    Caption = 'Empresa'
    About = 'NB 0.1/20020725'
  end
  object btnAnyadir: TSpeedButton
    Left = 794
    Top = 9
    Width = 34
    Height = 28
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00000000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00000000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0000000000000000000000000000000000FF000000000000000000
      00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0000000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF00000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0000000000000000000000000000000000FF000000000000000000
      00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00000000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00000000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
    OnClick = btnAnyadirClick
  end
  object btnBorrar: TSpeedButton
    Left = 829
    Top = 9
    Width = 34
    Height = 28
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF000000000000000000000000000000000000000000000000000000
      00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0000000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF00000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF000000000000000000000000000000000000000000000000000000
      00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
    OnClick = btnBorrarClick
  end
  object lblFechaFinal: TnbLabel
    Left = 241
    Top = 105
    Width = 100
    Height = 21
    Caption = 'Fecha Final'
    About = 'NB 0.1/20020725'
  end
  object btnModificar: TSpeedButton
    Left = 759
    Top = 9
    Width = 34
    Height = 28
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF000000000000000000FF00FF0000000000FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0000000000FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0000000000FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0000000000FF00FF00FF00FF007B7B7B007B7B7B0000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0000000000FF00FF007B7B7B0000FFFF0000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00000000007B7B7B0000FFFF007B7B7B007B7B7B000000
      0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00000000007B7B7B0000FFFF007B7B7B000000
      0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF000000000000FFFF007B7B7B0000FFFF007B7B
      7B0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000FFFF007B7B7B007B7B
      7B0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
      000000007B0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000007B7B7B000000
      7B007B7B7B0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000007B007B7B
      7B0000007B0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
    OnClick = btnModificarClick
  end
  object lblProductor: TnbLabel
    Left = 33
    Top = 27
    Width = 100
    Height = 21
    Caption = 'Cliente'
    About = 'NB 0.1/20020725'
  end
  object lbl3: TnbLabel
    Left = 33
    Top = 129
    Width = 100
    Height = 21
    Caption = '% Facturable'
    About = 'NB 0.1/20020725'
  end
  object lbl2: TnbLabel
    Left = 222
    Top = 153
    Width = 119
    Height = 21
    Caption = #8364'/Kg No Facturable'
    About = 'NB 0.1/20020725'
  end
  object lbl4: TnbLabel
    Left = 33
    Top = 153
    Width = 100
    Height = 21
    Caption = #8364'/Kg Facturable'
    About = 'NB 0.1/20020725'
  end
  object btnProducto: TBGridButton
    Left = 181
    Top = 80
    Width = 13
    Height = 21
    Enabled = False
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
      FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
      FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
      FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
      FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00000000BFFF00FF00FF00
      FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FFBFFF00FF00FF00FF00000000000000000000000000FF00
      FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FFBFFF00FF00000000000000000000000000000000000000
      00BFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
      000000000000FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
      FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00FFBFFF00FF00FF00
      FFBFFF00FF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
    OnClick = btnProductoClick
    Control = producto_dp
    Grid = RejillaFlotante
    GridAlignment = taDownRight
    GridWidth = 280
    GridHeigth = 100
  end
  object lblProducto: TnbLabel
    Left = 33
    Top = 80
    Width = 100
    Height = 21
    Caption = 'Producto'
    About = 'NB 0.1/20020725'
  end
  object lbl1: TnbLabel
    Left = 222
    Top = 129
    Width = 119
    Height = 21
    Caption = '% No Facturable Bruto'
    About = 'NB 0.1/20020725'
  end
  object nbLabel1: TnbLabel
    Left = 418
    Top = 129
    Width = 119
    Height = 21
    Caption = '% No Facturable Neto'
    About = 'NB 0.1/20020725'
  end
  object nbLabel4: TnbLabel
    Left = 33
    Top = 177
    Width = 100
    Height = 21
    Caption = #8364'/Pale Facturable'
    About = 'NB 0.1/20020725'
  end
  object nbLabel5: TnbLabel
    Left = 222
    Top = 177
    Width = 119
    Height = 21
    Caption = #8364'/Pale No Facturable'
    About = 'NB 0.1/20020725'
  end
  object empresa_dp: TBDEdit
    Left = 138
    Top = 54
    Width = 41
    Height = 21
    Enabled = False
    MaxLength = 3
    TabOrder = 3
    OnChange = empresa_dpChange
    DataField = 'empresa_dp'
    DataSource = DSDescuentos
  end
  object fecha_ini_dp: TnbDBCalendarCombo
    Left = 138
    Top = 104
    Width = 100
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Enabled = False
    TabOrder = 9
    DataField = 'fecha_ini_dp'
    DataSource = DSDescuentos
    DBLink = True
  end
  object DBGrid: TDBGrid
    Left = 42
    Top = 228
    Width = 822
    Height = 157
    DataSource = DSDescuentos
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 18
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'fecha_ini_dp'
        Title.Caption = 'Fecha Ini'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'fecha_fin_dp'
        Title.Caption = 'Fecha Fin'
        Width = 68
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'facturable_dp'
        Title.Alignment = taCenter
        Title.Caption = '% Facturable'
        Title.Color = clMenuHighlight
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 80
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'no_fact_bruto_dp'
        Title.Alignment = taCenter
        Title.Caption = '% No Fact. BI'
        Title.Color = clMenuHighlight
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 95
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'no_fact_neto_dp'
        Title.Caption = '% No Fact. TOTAL'
        Title.Color = clMenuHighlight
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 112
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'eurkg_facturable_dp'
        Title.Alignment = taCenter
        Title.Caption = ' '#8364'/Kg Fact.'
        Title.Color = clGradientActiveCaption
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'eurkg_no_facturable_dp'
        Title.Alignment = taCenter
        Title.Caption = #8364'/Kg No Fact.'
        Title.Color = clGradientActiveCaption
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'eurpale_facturable_dp'
        Title.Caption = #8364'/Pale Fact.'
        Title.Color = clBtnShadow
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'eurpale_no_facturable_dp'
        Title.Caption = #8364'/Pale No Fact.'
        Title.Color = clBtnShadow
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 95
        Visible = True
      end>
  end
  object fecha_fin_dp: TnbDBCalendarCombo
    Left = 339
    Top = 104
    Width = 100
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Enabled = False
    TabOrder = 10
    DataField = 'fecha_fin_dp'
    DataSource = DSDescuentos
    DBLink = True
  end
  object stProveedor: TStaticText
    Left = 186
    Top = 55
    Width = 4
    Height = 4
    TabOrder = 4
  end
  object stProductor: TStaticText
    Left = 186
    Top = 78
    Width = 4
    Height = 4
    TabOrder = 6
  end
  object cliente_dp: TBDEdit
    Left = 138
    Top = 27
    Width = 41
    Height = 21
    Enabled = False
    MaxLength = 3
    TabOrder = 0
    OnChange = cliente_dpChange
    DataField = 'cliente_dp'
    DataSource = DSDescuentos
  end
  object facturable_dp: TnbDBNumeric
    Left = 139
    Top = 126
    Width = 49
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Enabled = False
    TabOrder = 11
    DataField = 'facturable_dp'
    DataSource = DSDescuentos
    DBLink = True
    NumIntegers = 3
    NumDecimals = 3
  end
  object eurkg_no_facturable_dp: TnbDBNumeric
    Left = 339
    Top = 153
    Width = 49
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Enabled = False
    TabOrder = 15
    DataField = 'eurkg_no_facturable_dp'
    DataSource = DSDescuentos
    DBLink = True
    NumIntegers = 3
    NumDecimals = 3
  end
  object eurkg_facturable_dp: TnbDBNumeric
    Left = 138
    Top = 153
    Width = 49
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Enabled = False
    TabOrder = 14
    DataField = 'eurkg_facturable_dp'
    DataSource = DSDescuentos
    DBLink = True
    NumIntegers = 3
    NumDecimals = 3
  end
  object RejillaFlotante: TBGrid
    Left = 921
    Top = 43
    Width = 137
    Height = 135
    Color = clInfoBk
    FixedColor = clInfoText
    Options = [dgTabs, dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
  end
  object txtProducto: TStaticText
    Left = 202
    Top = 82
    Width = 245
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 8
  end
  object producto_dp: TBDEdit
    Left = 138
    Top = 80
    Width = 41
    Height = 21
    Enabled = False
    MaxLength = 3
    TabOrder = 7
    OnChange = producto_dpChange
    DataField = 'producto_dp'
    DataSource = DSDescuentos
  end
  object stDesCliente: TStaticText
    Left = 202
    Top = 27
    Width = 245
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 1
  end
  object stDesEmpresa: TStaticText
    Left = 202
    Top = 55
    Width = 245
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 5
  end
  object no_fact_bruto_dp: TnbDBNumeric
    Left = 339
    Top = 129
    Width = 49
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Enabled = False
    TabOrder = 12
    DataField = 'no_fact_bruto_dp'
    DataSource = DSDescuentos
    DBLink = True
    NumIntegers = 3
    NumDecimals = 3
  end
  object no_fact_neto_dp: TnbDBNumeric
    Left = 539
    Top = 129
    Width = 49
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Enabled = False
    TabOrder = 13
    DataField = 'no_fact_neto_dp'
    DataSource = DSDescuentos
    DBLink = True
    NumIntegers = 3
    NumDecimals = 3
  end
  object eurpale_facturable_dp: TnbDBNumeric
    Left = 138
    Top = 177
    Width = 49
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Enabled = False
    TabOrder = 16
    DataField = 'eurpale_facturable_dp'
    DataSource = DSDescuentos
    DBLink = True
    NumIntegers = 3
    NumDecimals = 3
  end
  object eurpale_no_facturable_dp: TnbDBNumeric
    Left = 339
    Top = 177
    Width = 49
    Height = 21
    About = 'NB 0.1/20020725'
    CharCase = ecUpperCase
    Enabled = False
    TabOrder = 17
    DataField = 'eurpale_no_facturable_dp'
    DataSource = DSDescuentos
    DBLink = True
    NumIntegers = 3
    NumDecimals = 3
  end
  object DSDescuentos: TDataSource
    DataSet = QDescuentos
    Left = 95
    Top = 262
  end
  object QDescuentos: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'select * '
      ' from frf_proveedores_almacen_calidad')
    Left = 58
    Top = 259
  end
  object QDescuentosAux: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'select * '
      ' from frf_proveedores_almacen_calidad')
    Left = 58
    Top = 291
  end
end
