object FDSincronizarParametros: TFDSincronizarParametros
  Left = 577
  Top = 293
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    PARAMETROS WEB'
  ClientHeight = 224
  ClientWidth = 639
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    639
    224)
  PixelsPerInch = 96
  TextHeight = 13
  object lblEmpresa: TLabel
    Left = 47
    Top = 45
    Width = 125
    Height = 19
    AutoSize = False
    Caption = ' E-Mail Deparatmento'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lblCliente: TLabel
    Left = 47
    Top = 70
    Width = 125
    Height = 19
    AutoSize = False
    Caption = ' Contador Reclamaci'#243'n'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object lblReclamacion: TLabel
    Left = 47
    Top = 94
    Width = 125
    Height = 19
    AutoSize = False
    Caption = ' Directorio Fotos Local'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object Label1: TLabel
    Left = 47
    Top = 118
    Width = 125
    Height = 19
    AutoSize = False
    Caption = ' Directorio Fotos Remoto'
    Color = cl3DLight
    ParentColor = False
    Layout = tlCenter
  end
  object edtContador: TBEdit
    Left = 180
    Top = 69
    Width = 41
    Height = 21
    ColorEdit = clMoneyGreen
    ColorDisable = clMenuBar
    InputType = itInteger
    Enabled = False
    TabOrder = 6
  end
  object btnBajar: TButton
    Left = 460
    Top = 171
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Sincronizar'
    Enabled = False
    TabOrder = 0
    OnClick = btnBajarClick
  end
  object btnCerrar: TButton
    Left = 540
    Top = 171
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cerrar'
    TabOrder = 1
    OnClick = btnCerrarClick
  end
  object edtEMail: TEdit
    Left = 180
    Top = 45
    Width = 373
    Height = 21
    TabOrder = 2
  end
  object cbxInicializarContador: TCheckBox
    Left = 228
    Top = 71
    Width = 237
    Height = 17
    Caption = 'Actualizar contador'
    TabOrder = 3
    OnClick = cbxInicializarContadorClick
  end
  object edtDirLocal: TEdit
    Left = 180
    Top = 94
    Width = 373
    Height = 21
    Color = clMenuBar
    Enabled = False
    TabOrder = 4
  end
  object edtDirRemoto: TEdit
    Left = 180
    Top = 118
    Width = 373
    Height = 21
    Color = clMenuBar
    Enabled = False
    TabOrder = 5
  end
end
