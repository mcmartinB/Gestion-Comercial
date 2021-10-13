object FMRepresentantes: TFMRepresentantes
  Left = 745
  Top = 112
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  REPRESENTANTES'
  ClientHeight = 265
  ClientWidth = 434
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
  object Label13: TLabel
    Left = 37
    Top = 75
    Width = 90
    Height = 19
    AutoSize = False
    Caption = 'Empresa'
    Color = cl3DLight
    ParentColor = False
  end
  object PMaestro: TPanel
    Left = 0
    Top = 0
    Width = 434
    Height = 265
    Align = alClient
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object LEmpresa_r: TLabel
      Left = 37
      Top = 22
      Width = 68
      Height = 19
      AutoSize = False
      Caption = ' C'#243'digo'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object LDescripcion_r: TLabel
      Left = 37
      Top = 51
      Width = 68
      Height = 19
      AutoSize = False
      Caption = ' Descripci'#243'n'
      Color = cl3DLight
      ParentColor = False
      Layout = tlCenter
    end
    object representante_r: TBDEdit
      Left = 118
      Top = 21
      Width = 31
      Height = 21
      ColorEdit = clMoneyGreen
      Zeros = True
      OnRequiredTime = RequiredTime
      MaxLength = 2
      TabOrder = 0
      DataField = 'representante_r'
      DataSource = DSMaestro
      Modificable = False
      PrimaryKey = True
    end
    object descripcion_r: TBDEdit
      Left = 118
      Top = 50
      Width = 283
      Height = 21
      ColorEdit = clMoneyGreen
      TabOrder = 1
      DataField = 'descripcion_r'
      DataSource = DSMaestro
    end
    object DBGrid1: TDBGrid
      Left = 38
      Top = 109
      Width = 363
      Height = 124
      TabStop = False
      Color = clBtnFace
      DataSource = DSDescuentos
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'comision'
          Title.Alignment = taCenter
          Title.Caption = 'Comisi'#243'n'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'inicio'
          Title.Caption = 'Inicio'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'fin'
          Title.Caption = 'Fin'
          Visible = True
        end>
    end
  end
  object btnDescuentos: TBitBtn
    Left = 287
    Top = 116
    Width = 113
    Height = 27
    Caption = 'Comisi'#243'n'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    TabStop = False
    OnClick = btnDescuentosClick
  end
  object RejillaFlotante: TBGrid
    Left = 160
    Top = 53
    Width = 137
    Height = 25
    Color = clInfoBk
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
    BControl = FDComisionRepresentante.fecha_ini_rc
  end
  object DSMaestro: TDataSource
    DataSet = QRepresentantes
    Left = 392
  end
  object ACosecheros: TActionList
    Images = DMBaseDatos.ImgBotones
    Top = 64
    object ARejillaFlotante: TAction
      Hint = 'Pulse F2 para ver una lista de valores validos. '
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ARejillaFlotanteExecute
    end
  end
  object QRepresentantes: TQuery
    AfterOpen = QRepresentantesAfterOpen
    BeforeClose = QRepresentantesBeforeClose
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM frf_representantes'
      'ORDER BY  representante_r')
    Left = 344
  end
  object QDescuentos: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = DSMaestro
    SQL.Strings = (
      
        'select comision_rc comision,  fecha_ini_rc inicio, fecha_fin_rc ' +
        'fin'
      'from frf_representantes_comision'
      'where empresa_rc = '#39'050'#39
      'and representante_rc = '#39'ED'#39
      'order by inicio desc')
    Left = 296
    Top = 208
    object QDescuentoscomision: TFloatField
      FieldName = 'comision'
      Origin = 'BDPROYECTO.frf_representantes_comision.comision_rc'
    end
    object QDescuentosinicio: TDateField
      FieldName = 'inicio'
      Origin = 'BDPROYECTO.frf_representantes_comision.fecha_ini_rc'
    end
    object QDescuentosfin: TDateField
      FieldName = 'fin'
      Origin = 'BDPROYECTO.frf_representantes_comision.fecha_fin_rc'
    end
  end
  object DSDescuentos: TDataSource
    DataSet = QDescuentos
    Left = 328
    Top = 208
  end
end
