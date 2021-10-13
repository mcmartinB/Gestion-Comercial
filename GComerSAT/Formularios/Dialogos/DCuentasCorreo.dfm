object FDCuentasCorreo: TFDCuentasCorreo
  Left = 556
  Top = 178
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  SELECCI'#211'N CUENTA DE CORREO PARA ENVIOS'
  ClientHeight = 143
  ClientWidth = 455
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object PMaestro: TPanel
    Left = 0
    Top = 0
    Width = 455
    Height = 143
    Align = alClient
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object lblCuentas: TLabel
      Left = 43
      Top = 54
      Width = 100
      Height = 19
      AutoSize = False
      Caption = ' Cuentas de correo'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblCuentaActiva: TLabel
      Left = 43
      Top = 31
      Width = 100
      Height = 19
      AutoSize = False
      Caption = ' Cuenta activa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object desCuentaActiva: TLabel
      Left = 157
      Top = 34
      Width = 81
      Height = 13
      Caption = 'desCuentaActiva'
    end
    object cbxCuentas: TComboBox
      Left = 157
      Top = 53
      Width = 233
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = cbxCuentasChange
    end
    object btnCerrar: TBitBtn
      Left = 315
      Top = 91
      Width = 75
      Height = 25
      Caption = 'Cerrar'
      TabOrder = 1
      OnClick = btnCerrarClick
      Kind = bkCancel
    end
    object btnAplicar: TBitBtn
      Left = 43
      Top = 91
      Width = 75
      Height = 25
      Caption = 'Aplicar'
      Default = True
      ModalResult = 6
      TabOrder = 2
      OnClick = btnAplicarClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333300000000
        0000333377777777777733330FFFFFFFFFF033337F3FFF3F3FF733330F000F0F
        00F033337F777373773733330FFFFFFFFFF033337F3FF3FF3FF733330F00F00F
        00F033337F773773773733330FFFFFFFFFF033337FF3333FF3F7333300FFFF00
        F0F03333773FF377F7373330FB00F0F0FFF0333733773737F3F7330FB0BF0FB0
        F0F0337337337337373730FBFBF0FB0FFFF037F333373373333730BFBF0FB0FF
        FFF037F3337337333FF700FBFBFB0FFF000077F333337FF37777E0BFBFB000FF
        0FF077FF3337773F7F37EE0BFB0BFB0F0F03777FF3733F737F73EEE0BFBF00FF
        00337777FFFF77FF7733EEEE0000000003337777777777777333}
      NumGlyphs = 2
    end
    object btnEditar: TBitBtn
      Left = 122
      Top = 91
      Width = 75
      Height = 25
      Caption = 'Editar'
      ModalResult = 4
      TabOrder = 3
      OnClick = btnEditarClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
        000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
        00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
        F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
        0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
        FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
        FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
        0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
        00333377737FFFFF773333303300000003333337337777777333}
      NumGlyphs = 2
    end
  end
  object DSMaestro: TDataSource
    DataSet = QCuentas_
    Left = 40
    Top = 8
  end
  object QCuentas_: TQuery
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT campo_c, tipo_c, descripcion_c'
      'FROM frf_campos Frf_campos'
      'ORDER BY campo_c, tipo_c')
    Left = 8
    Top = 8
  end
end
