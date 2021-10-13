object FEnvSeccionesContables: TFEnvSeccionesContables
  Left = 622
  Top = 188
  ActiveControl = DBGrid
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = '    DESCRIPCI'#211'N DE ART'#205'CULOS POR CLIENTE'
  ClientHeight = 355
  ClientWidth = 479
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object btnCentro: TBGridButton
    Left = 199
    Top = 125
    Width = 13
    Height = 19
    Glyph.Data = {
      42020000424D4202000000000000420000002800000010000000100000000100
      1000030000000002000000000000000000000000000000000000007C0000E003
      00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000000000001F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000000000000000001F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C00000000000000000000000000001F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C}
    OnClick = btnCentroClick
    Control = centro_esc
    Grid = RejillaFlotante
    GridAlignment = taDownCenter
    GridWidth = 280
    GridHeigth = 200
  end
  object btnSeccion: TBGridButton
    Left = 199
    Top = 149
    Width = 13
    Height = 19
    Glyph.Data = {
      42020000424D4202000000000000420000002800000010000000100000000100
      1000030000000002000000000000000000000000000000000000007C0000E003
      00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000000000001F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000000000000000001F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C00000000000000000000000000001F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C}
    OnClick = btnSeccionClick
    Control = seccion_esc
    Grid = RejillaFlotante
    GridAlignment = taDownCenter
    GridWidth = 280
    GridHeigth = 200
  end
  object lblCodigo1: TnbLabel
    Left = 24
    Top = 149
    Width = 100
    Height = 21
    Caption = 'Seccion Contable'
    About = 'NB 0.1/20020725'
  end
  object lblCodigo2: TnbLabel
    Left = 24
    Top = 125
    Width = 100
    Height = 21
    Caption = 'Centro Salida'
    About = 'NB 0.1/20020725'
  end
  object lblCodigo3: TnbLabel
    Left = 24
    Top = 99
    Width = 100
    Height = 21
    Caption = 'Empresa'
    About = 'NB 0.1/20020725'
  end
  object lblEmpresa: TnbStaticText
    Left = 130
    Top = 98
    Width = 332
    Height = 21
    About = 'NB 0.1/20020725'
  end
  object empresa_esc: TBDEdit
    Left = 88
    Top = 98
    Width = 41
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 3
    TabOrder = 8
    OnChange = empresa_escChange
    DataField = 'empresa_esc'
    DataSource = DataSource
    Modificable = False
    PrimaryKey = True
  end
  object Panel1: TPanel
    Left = 0
    Top = 29
    Width = 479
    Height = 44
    Align = alTop
    BevelOuter = bvNone
    Enabled = False
    TabOrder = 1
    object nbLabel3: TnbLabel
      Left = 24
      Top = 10
      Width = 100
      Height = 21
      Caption = 'Art'#237'culo'
      About = 'NB 0.1/20020725'
    end
    object lblEnvase: TnbStaticText
      Left = 164
      Top = 10
      Width = 298
      Height = 21
      About = 'NB 0.1/20020725'
    end
    object envase: TnbDBAlfa
      Left = 88
      Top = 10
      Width = 75
      Height = 21
      About = 'NB 0.1/20020725'
      CharCase = ecUpperCase
      OnChange = envaseChange
      TabOrder = 0
    end
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 479
    Height = 29
    ButtonHeight = 21
    ButtonWidth = 50
    Caption = 'ToolBar1'
    ShowCaptions = True
    TabOrder = 0
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Action = AAnyadir
    end
    object ToolButton2: TToolButton
      Left = 50
      Top = 0
      Action = AModificar
    end
    object ToolButton3: TToolButton
      Left = 100
      Top = 0
      Action = ABorrar
    end
    object ToolButton4: TToolButton
      Left = 150
      Top = 0
      Width = 8
      Caption = 'ToolButton4'
      ImageIndex = 3
      Style = tbsSeparator
    end
    object ToolButton5: TToolButton
      Left = 158
      Top = 0
      Action = AAceptar
    end
    object ToolButton6: TToolButton
      Left = 208
      Top = 0
      Action = ACancelar
    end
    object ToolButton8: TToolButton
      Left = 258
      Top = 0
      Width = 8
      Caption = 'ToolButton8'
      ImageIndex = 6
      Style = tbsSeparator
    end
    object ToolButton7: TToolButton
      Left = 266
      Top = 0
      Action = ACerrar
    end
  end
  object RejillaFlotante: TBGrid
    Left = 398
    Top = 147
    Width = 113
    Height = 49
    Color = clInfoBk
    DataSource = DMBaseDatos.DSQDespegables
    Options = [dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 7
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
  end
  object centro_esc: TBDEdit
    Left = 128
    Top = 125
    Width = 22
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 1
    TabOrder = 3
    OnChange = centro_escChange
    DataField = 'centro_esc'
    DataSource = DataSource
    Modificable = False
    PrimaryKey = True
  end
  object txtCentro: TStaticText
    Left = 213
    Top = 125
    Width = 249
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 4
  end
  object seccion_esc: TBDEdit
    Left = 128
    Top = 149
    Width = 69
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 10
    TabOrder = 5
    OnChange = seccion_escChange
    DataField = 'seccion_esc'
    DataSource = DataSource
    Modificable = False
    PrimaryKey = True
  end
  object txtSeccion: TStaticText
    Left = 213
    Top = 149
    Width = 249
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 6
  end
  object DBGrid: TDBGrid
    Left = 5
    Top = 187
    Width = 464
    Height = 155
    TabStop = False
    DataSource = DataSource
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'empresa_esc'
        Title.Alignment = taCenter
        Title.Caption = 'Empresa'
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'centro_esc'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = 'Centro'
        Width = 55
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'envase_esc'
        Title.Alignment = taCenter
        Title.Caption = 'Art'#237'culo'
        Width = 80
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'seccion_esc'
        Title.Alignment = taCenter
        Title.Caption = 'Secci'#243'n'
        Width = 113
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'des_seccion_esc'
        Title.Caption = 'Descripci'#243'n'
        Width = 129
        Visible = True
      end>
  end
  object Query: TQuery
    BeforePost = QueryBeforePost
    OnCalcFields = QueryCalcFields
    DatabaseName = 'BDProyecto'
    RequestLive = True
    SQL.Strings = (
      'Select * from frf_env_sec_contables')
    Left = 32
    Top = 233
    object strngfldQueryempresa_esc: TStringField
      FieldName = 'empresa_esc'
      Origin = '"COMER.BAG".frf_env_sec_contables.empresa_esc'
      FixedChar = True
      Size = 3
    end
    object strngfldQuerycentro_esc: TStringField
      FieldName = 'centro_esc'
      Origin = '"COMER.BAG".frf_env_sec_contables.centro_esc'
      FixedChar = True
      Size = 1
    end
    object strngfldQueryenvase_esc: TStringField
      DisplayWidth = 9
      FieldName = 'envase_esc'
      Origin = '"COMER.BAG".frf_env_sec_contables.envase_esc'
      FixedChar = True
      Size = 9
    end
    object strngfldQueryseccion_esc: TStringField
      FieldName = 'seccion_esc'
      Origin = '"COMER.BAG".frf_env_sec_contables.seccion_esc'
      FixedChar = True
      Size = 10
    end
    object strngfldQuerydes_seccion_esc: TStringField
      FieldKind = fkCalculated
      FieldName = 'des_seccion_esc'
      Size = 30
      Calculated = True
    end
  end
  object DataSource: TDataSource
    AutoEdit = False
    DataSet = Query
    Left = 64
    Top = 233
  end
  object ActionList: TActionList
    OnUpdate = ActionListUpdate
    Left = 368
    Top = 168
    object AAnyadir: TAction
      Caption = 'A'#241'adir'
      ShortCut = 187
      OnExecute = AAnyadirExecute
    end
    object ABorrar: TAction
      Caption = 'Borrar'
      ShortCut = 111
      OnExecute = ABorrarExecute
    end
    object AModificar: TAction
      Caption = 'Modificar'
      ShortCut = 77
      OnExecute = AModificarExecute
    end
    object AAceptar: TAction
      Caption = 'Aceptar'
      ShortCut = 112
      OnExecute = AAceptarExecute
    end
    object ACancelar: TAction
      Caption = 'Cancelar'
      ShortCut = 27
      OnExecute = ACancelarExecute
    end
    object ACerrar: TAction
      Caption = 'Cerrar'
      OnExecute = ACerrarExecute
    end
  end
end
