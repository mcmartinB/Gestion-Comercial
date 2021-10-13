object FMCuentasCorreo: TFMCuentasCorreo
  Left = 546
  Top = 148
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  MANTENIMIENTO CUENTAS DE CORREO'
  ClientHeight = 180
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
    Height = 180
    Align = alClient
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object lblClave: TLabel
      Left = 54
      Top = 124
      Width = 65
      Height = 19
      AutoSize = False
      Caption = ' Contrase'#241'a'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblDescripcion: TLabel
      Left = 54
      Top = 59
      Width = 65
      Height = 19
      AutoSize = False
      Caption = ' Descripci'#243'n '
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblSmtp: TLabel
      Left = 54
      Top = 81
      Width = 65
      Height = 19
      AutoSize = False
      Caption = ' Smtp'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblIdentificador: TLabel
      Left = 54
      Top = 103
      Width = 65
      Height = 19
      AutoSize = False
      Caption = ' Identificador'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lblCodigo: TLabel
      Left = 54
      Top = 36
      Width = 65
      Height = 19
      AutoSize = False
      Caption = ' C'#243'digo'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object clave_ccc: TBDEdit
      Left = 135
      Top = 123
      Width = 74
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = descripcion_cccRequiredTime
      CharCase = ecNormal
      MaxLength = 10
      TabOrder = 4
      DataField = 'clave_ccc'
      DataSource = DSMaestro
    end
    object descripcion_ccc: TBDEdit
      Left = 135
      Top = 58
      Width = 258
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Dato de inserci'#243'n obligatoria.'
      OnRequiredTime = descripcion_cccRequiredTime
      MaxLength = 30
      TabOrder = 1
      DataField = 'descripcion_ccc'
      DataSource = DSMaestro
    end
    object smtp_ccc: TBDEdit
      Left = 135
      Top = 80
      Width = 258
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Dato de inserci'#243'n obligatoria.'
      OnRequiredTime = descripcion_cccRequiredTime
      CharCase = ecNormal
      MaxLength = 50
      TabOrder = 2
      DataField = 'smtp_ccc'
      DataSource = DSMaestro
    end
    object identificador_ccc: TBDEdit
      Left = 135
      Top = 102
      Width = 258
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      RequiredMsg = 'Dato de inserci'#243'n obligatoria.'
      OnRequiredTime = descripcion_cccRequiredTime
      CharCase = ecNormal
      MaxLength = 50
      TabOrder = 3
      DataField = 'identificador_ccc'
      DataSource = DSMaestro
    end
    object codigo_ccc: TBDEdit
      Left = 135
      Top = 35
      Width = 26
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = descripcion_cccRequiredTime
      InputType = itInteger
      CharCase = ecNormal
      MaxLength = 10
      TabOrder = 0
      DataField = 'codigo_ccc'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
  end
  object DSMaestro: TDataSource
    DataSet = QCuentas
    Left = 40
    Top = 8
  end
  object QCuentas: TQuery
    OnNewRecord = QCuentasNewRecord
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
