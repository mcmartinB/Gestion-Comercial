object FDSincronizarClientes: TFDSincronizarClientes
  Left = 299
  Top = 202
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    SINCRONIZAR CLIENTES WEB'
  ClientHeight = 159
  ClientWidth = 471
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
    471
    159)
  PixelsPerInch = 96
  TextHeight = 13
  object lblMensaje: TLabel
    Left = 24
    Top = 24
    Width = 392
    Height = 70
    Caption = 
      'ACCIONES'#13#10'------------------------------------------------------' +
      '--'#13#10'1/ Borrar todos los clientes en el servidor de Internet.'#13#10'2/' +
      ' Copiar todos los clientes web de comercializaci'#243'n '#13#10'    en el s' +
      'ervidor de Internet.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
  end
  object btnBajar: TButton
    Left = 292
    Top = 111
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Sincronizar'
    Enabled = False
    TabOrder = 0
    OnClick = btnBajarClick
  end
  object btnCerrar: TButton
    Left = 372
    Top = 111
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cerrar'
    TabOrder = 1
    OnClick = btnCerrarClick
  end
end
