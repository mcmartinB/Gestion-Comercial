object FMFichBancos: TFMFichBancos
  Left = 290
  Top = 225
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    BANCOS'
  ClientHeight = 541
  ClientWidth = 692
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
  OnDeactivate = FormDeactivate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object PMaestro: TPanel
    Left = 0
    Top = 0
    Width = 692
    Height = 105
    Align = alTop
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label10: TLabel
      Left = 34
      Top = 23
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Empresa'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Tipo: TLabel
      Left = 34
      Top = 69
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Descripcion'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl2: TLabel
      Left = 34
      Top = 46
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Cod. Banco'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object empresa_bnc: TBDEdit
      Left = 119
      Top = 22
      Width = 30
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      OnRequiredTime = RequiredTime
      MaxLength = 3
      TabOrder = 0
      DataField = 'empresa_bnc'
      DataSource = DSBancosCab
      Modificable = False
      PrimaryKey = True
    end
    object descripcion_bnc: TBDEdit
      Left = 119
      Top = 68
      Width = 513
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = RequiredTime
      MaxLength = 40
      TabOrder = 2
      DataField = 'descripcion_bnc'
      DataSource = DSBancosCab
    end
    object codigo_bnc: TBDEdit
      Left = 119
      Top = 45
      Width = 40
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      OnRequiredTime = RequiredTime
      MaxLength = 4
      TabOrder = 1
      DataField = 'codigo_bnc'
      DataSource = DSBancosCab
      Modificable = False
      PrimaryKey = True
    end
  end
  object pnlBancos: TPanel
    Left = 0
    Top = 105
    Width = 692
    Height = 140
    Align = alTop
    TabOrder = 2
    object Label1: TLabel
      Left = 34
      Top = 11
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' N'#250'mero Cuenta'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object linea_bnd: TDBText
      Left = 119
      Top = 12
      Width = 14
      Height = 17
      DataField = 'linea_bnd'
      DataSource = DSBancosDet
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl1: TLabel
      Left = 34
      Top = 34
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Swift Code'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl3: TLabel
      Left = 34
      Top = 57
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Iban Cuenta'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl4: TLabel
      Left = 34
      Top = 80
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Direcci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl5: TLabel
      Left = 34
      Top = 103
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Poblaci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object swift_bnd: TBDEdit
      Left = 119
      Top = 33
      Width = 90
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = RequiredTime
      MaxLength = 11
      TabOrder = 0
      DataField = 'swift_bnd'
      DataSource = DSBancosDet
      Modificable = False
      PrimaryKey = True
    end
    object iban_bnd: TBDEdit
      Left = 119
      Top = 56
      Width = 298
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = RequiredTime
      MaxLength = 34
      TabOrder = 1
      DataField = 'iban_bnd'
      DataSource = DSBancosDet
      Modificable = False
      PrimaryKey = True
    end
    object direccion_bnd: TBDEdit
      Left = 119
      Top = 79
      Width = 513
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = RequiredTime
      MaxLength = 40
      TabOrder = 2
      DataField = 'direccion_bnd'
      DataSource = DSBancosDet
    end
    object poblacion_bnd: TBDEdit
      Left = 119
      Top = 102
      Width = 513
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = RequiredTime
      MaxLength = 40
      TabOrder = 3
      DataField = 'poblacion_bnd'
      DataSource = DSBancosDet
    end
  end
  object RBancos: TDBGrid
    Left = 0
    Top = 245
    Width = 692
    Height = 296
    Align = alClient
    DataSource = DSBancosDet
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'linea_bnd'
        Title.Caption = 'N'#250'mero'
        Width = 43
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'swift_bnd'
        Title.Caption = 'Swift Code'
        Width = 102
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'iban_bnd'
        Title.Caption = 'IBAN Cuenta'
        Width = 182
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'poblacion_bnd'
        Title.Caption = 'Poblaci'#243'n'
        Width = 305
        Visible = True
      end>
  end
  object RejillaFlotante: TBGrid
    Left = 506
    Top = 52
    Width = 73
    Height = 97
    Color = clInfoBk
    DataSource = DMBaseDatos.DSQGeneral
    FixedColor = clInfoText
    Options = [dgTabs, dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
    ColumnFind = 1
  end
  object DSBancosCab: TDataSource
    DataSet = QBancosCab
    Left = 272
    Top = 16
  end
  object ACosecheros: TActionList
    Images = DMBaseDatos.ImgBotones
    Top = 104
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
  end
  object QBancosCab: TQuery
    AfterOpen = QBancosCabAfterOpen
    BeforeClose = QBancosCabBeforeClose
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_cosecheros'
      'ORDER BY empresa_c, cosechero_c')
    Left = 232
    Top = 16
  end
  object QBancosDet: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSBancosCab
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_proveedores_almacen')
    Left = 16
    Top = 128
  end
  object DSBancosDet: TDataSource
    DataSet = QBancosDet
    Left = 48
    Top = 136
  end
end
