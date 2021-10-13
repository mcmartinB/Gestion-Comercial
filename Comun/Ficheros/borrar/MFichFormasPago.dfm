object FMFichFormasPago: TFMFichFormasPago
  Left = 219
  Top = 315
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    FORMAS DE PAGO'
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
    Height = 89
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
      Caption = 'Codigo'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object Tipo: TLabel
      Left = 34
      Top = 45
      Width = 79
      Height = 19
      AutoSize = False
      Caption = ' Tipo Pago'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object lbl2: TLabel
      Left = 215
      Top = 23
      Width = 79
      Height = 19
      AutoSize = False
      Caption = 'Codigo Adonix'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object codigo_fpc: TBDEdit
      Left = 119
      Top = 22
      Width = 30
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      OnRequiredTime = RequiredTime
      MaxLength = 2
      TabOrder = 0
      DataField = 'codigo_fpc'
      DataSource = DSFormasPagoCab
      Modificable = False
      PrimaryKey = True
    end
    object descripcion_fpc: TBDEdit
      Left = 119
      Top = 46
      Width = 513
      Height = 21
      ColorEdit = clMoneyGreen
      Required = True
      OnRequiredTime = RequiredTime
      MaxLength = 55
      TabOrder = 2
      DataField = 'descripcion_fpc'
      DataSource = DSFormasPagoCab
    end
    object codigo_adonix_fpc: TBDEdit
      Left = 298
      Top = 22
      Width = 30
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      Required = True
      OnRequiredTime = RequiredTime
      MaxLength = 2
      TabOrder = 1
      DataField = 'codigo_adonix_fpc'
      DataSource = DSFormasPagoCab
    end
  end
  object pnlPFormasPago: TPanel
    Left = 0
    Top = 89
    Width = 692
    Height = 161
    Align = alTop
    TabOrder = 2
    object Label1: TLabel
      Left = 34
      Top = 9
      Width = 67
      Height = 19
      AutoSize = False
      Caption = ' Forma Pago'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object dlbllinea_fpd: TDBText
      Left = 102
      Top = 12
      Width = 14
      Height = 17
      DataField = 'linea_fpd'
      DataSource = DSFormasPagoDet
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object texto_fpd: TDBMemo
      Left = 119
      Top = 9
      Width = 513
      Height = 136
      DataField = 'texto_fpd'
      DataSource = DSFormasPagoDet
      TabOrder = 0
      WantTabs = True
      OnEnter = texto_fpdEnter
      OnExit = texto_fpdExit
    end
  end
  object RFormasPago: TDBGrid
    Left = 0
    Top = 250
    Width = 692
    Height = 291
    Align = alClient
    DataSource = DSFormasPagoDet
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
        FieldName = 'linea_fpd'
        Title.Caption = 'Forma'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'texto_fpd'
        Title.Caption = 'Descripci'#243'n'
        Width = 572
        Visible = True
      end>
  end
  object RejillaFlotante: TBGrid
    Left = 568
    Top = 16
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
  object DSFormasPagoCab: TDataSource
    DataSet = QFormasPagoCab
    Left = 48
    Top = 24
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
  object QFormasPagoCab: TQuery
    AfterOpen = QFormasPagoCabAfterOpen
    BeforeClose = QFormasPagoCabBeforeClose
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_cosecheros'
      'ORDER BY empresa_c, cosechero_c')
    Left = 16
    Top = 16
  end
  object QFormasPagoDet: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSFormasPagoCab
    RequestLive = True
    SQL.Strings = (
      'SELECT *'
      'FROM frf_proveedores_almacen')
    Left = 16
    Top = 128
  end
  object DSFormasPagoDet: TDataSource
    DataSet = QFormasPagoDet
    Left = 48
    Top = 136
  end
end
