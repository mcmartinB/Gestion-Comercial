object FDFichaListado: TFDFichaListado
  Left = 448
  Top = 276
  Width = 347
  Height = 166
  Caption = 'FICHA o LISTADO'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblImprimir: TLabel
    Left = 14
    Top = 26
    Width = 139
    Height = 13
    Caption = 'Seleccione formato de salida.'
  end
  object btnFicha: TButton
    Left = 14
    Top = 89
    Width = 100
    Height = 25
    Caption = 'Ficha Envase'
    TabOrder = 0
    OnClick = btnFichaClick
  end
  object btnListado: TButton
    Left = 118
    Top = 89
    Width = 100
    Height = 25
    Caption = 'Listado Envases'
    TabOrder = 1
    OnClick = btnListadoClick
  end
  object btnCancelar: TButton
    Left = 222
    Top = 89
    Width = 100
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 2
    OnClick = btnCancelarClick
  end
  object chkVerClientes: TCheckBox
    Left = 40
    Top = 44
    Width = 169
    Height = 17
    Caption = 'Ver datos clientes'
    TabOrder = 3
  end
end
