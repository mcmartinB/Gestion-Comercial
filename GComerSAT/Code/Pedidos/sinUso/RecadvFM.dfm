object FMRecadv: TFMRecadv
  Left = 367
  Top = 162
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  RECADV'
  ClientHeight = 628
  ClientWidth = 991
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object TBBarraMaestroDetalle: TToolBar
    Left = 0
    Top = 0
    Width = 991
    Height = 22
    ButtonWidth = 24
    Caption = 'TBBarraMaestroDetalle'
    EdgeBorders = []
    Flat = True
    Images = DMBaseDatos.ImgBarraHerramientas
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Wrapable = False
    object btnLocalizar: TToolButton
      Left = 0
      Top = 0
      Action = ALocalizar
      ParentShowHint = False
      ShowHint = True
    end
    object TBMaestroDetalleSeparador1: TToolButton
      Left = 24
      Top = 0
      Width = 24
      Caption = 'TBMaestroDetalleSeparador1'
      ParentShowHint = False
      ShowHint = True
      Style = tbsDivider
    end
    object btnImprimir: TToolButton
      Left = 48
      Top = 0
      Action = AImprimir
      ParentShowHint = False
      ShowHint = True
    end
    object btnSepImprimir: TToolButton
      Left = 72
      Top = 0
      Width = 24
      Caption = 'btnSepImprimir'
      ImageIndex = 19
      Style = tbsDivider
    end
    object btnPrimero: TToolButton
      Left = 96
      Top = 0
      Action = APrimero
      ParentShowHint = False
      ShowHint = True
    end
    object btnAnterior: TToolButton
      Left = 120
      Top = 0
      Action = AAnterior
      ParentShowHint = False
      ShowHint = True
    end
    object btnSiguiente: TToolButton
      Left = 144
      Top = 0
      Action = ASiguiente
      ParentShowHint = False
      ShowHint = True
    end
    object btnUltimo: TToolButton
      Left = 168
      Top = 0
      Action = AUltimo
      ParentShowHint = False
      ShowHint = True
    end
    object TBMaestroDetalleSeparador2: TToolButton
      Left = 192
      Top = 0
      Width = 24
      Caption = 'TBMaestroDetalleSeparador2'
      ParentShowHint = False
      ShowHint = True
      Style = tbsDivider
    end
    object btnSalir: TToolButton
      Left = 216
      Top = 0
      Action = ASalir
      ParentShowHint = False
      ShowHint = True
    end
  end
  object pgControl: TPageControl
    Left = 0
    Top = 22
    Width = 991
    Height = 606
    ActivePage = tsFicha
    Align = alClient
    TabIndex = 0
    TabOrder = 1
    TabStop = False
    TabWidth = 100
    object tsFicha: TTabSheet
      Caption = 'FICHA'
      OnShow = tsFichaShow
      object PMaestro: TPanel
        Left = 0
        Top = 0
        Width = 983
        Height = 177
        Align = alTop
        BevelInner = bvLowered
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object lblCodigo: TLabel
          Left = 39
          Top = 9
          Width = 95
          Height = 19
          AutoSize = False
          Caption = 'C'#243'digo'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object lblConfirmacion: TLabel
          Left = 433
          Top = 9
          Width = 95
          Height = 19
          AutoSize = False
          Caption = 'Confirmaci'#243'n'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object lblFechaDocumento: TLabel
          Left = 39
          Top = 53
          Width = 95
          Height = 19
          AutoSize = False
          Caption = 'Fecha Documento'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object lblFechaRecepcion: TLabel
          Left = 433
          Top = 53
          Width = 95
          Height = 19
          AutoSize = False
          Caption = 'Fecha Recepci'#243'n'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object lblDestino: TLabel
          Left = 433
          Top = 120
          Width = 95
          Height = 19
          AutoSize = False
          Caption = 'Destino'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object lblOrigen: TLabel
          Left = 39
          Top = 120
          Width = 95
          Height = 19
          AutoSize = False
          Caption = 'Origen'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object lblFacturarA: TLabel
          Left = 433
          Top = 142
          Width = 90
          Height = 19
          AutoSize = False
          Caption = 'Facturar A'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object lblTipo: TLabel
          Left = 39
          Top = 31
          Width = 95
          Height = 19
          AutoSize = False
          Caption = 'Tipo'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object lblFuncion: TLabel
          Left = 433
          Top = 31
          Width = 95
          Height = 19
          AutoSize = False
          Caption = 'Funci'#243'n'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object lblProveedor: TLabel
          Left = 39
          Top = 142
          Width = 95
          Height = 19
          AutoSize = False
          Caption = 'Proveedor'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object lblAlbaran: TLabel
          Left = 39
          Top = 76
          Width = 95
          Height = 19
          AutoSize = False
          Caption = 'Albar'#225'n'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object lblPedido: TLabel
          Left = 39
          Top = 98
          Width = 95
          Height = 19
          AutoSize = False
          Caption = 'Pedido'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object lblFechaCarga: TLabel
          Left = 433
          Top = 76
          Width = 90
          Height = 19
          AutoSize = False
          Caption = 'Fecha Carga'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object lblmatricula: TLabel
          Left = 433
          Top = 98
          Width = 90
          Height = 19
          AutoSize = False
          Caption = 'Matricula'
          Color = cl3DLight
          ParentColor = False
          Layout = tlCenter
        end
        object edtidcab_ecr: TBDEdit
          Tag = 1
          Left = 140
          Top = 8
          Width = 80
          Height = 21
          ColorEdit = clMoneyGreen
          Zeros = True
          MaxLength = 10
          TabOrder = 0
          DataField = 'idcab_ecr'
          DataSource = DSMaestro
          Modificable = False
          PrimaryKey = True
        end
        object edtnumcon_ecr: TBDEdit
          Left = 534
          Top = 8
          Width = 200
          Height = 21
          ColorEdit = clMoneyGreen
          MaxLength = 35
          TabOrder = 1
          DataField = 'numcon_ecr'
          DataSource = DSMaestro
          Modificable = False
          PrimaryKey = True
        end
        object edtfuncion_ecr: TBDEdit
          Left = 534
          Top = 30
          Width = 33
          Height = 21
          ColorEdit = clMoneyGreen
          MaxLength = 3
          TabOrder = 3
          OnChange = edtfuncion_ecrChange
          DataField = 'funcion_ecr'
          DataSource = DSMaestro
          Modificable = False
        end
        object edttipo_ecr: TBDEdit
          Left = 140
          Top = 30
          Width = 33
          Height = 21
          ColorEdit = clMoneyGreen
          MaxLength = 3
          TabOrder = 2
          OnChange = edttipo_ecrChange
          DataField = 'tipo_ecr'
          DataSource = DSMaestro
          Modificable = False
        end
        object edtproveedor_ecr: TBDEdit
          Left = 140
          Top = 141
          Width = 110
          Height = 21
          ColorEdit = clMoneyGreen
          MaxLength = 17
          TabOrder = 16
          OnChange = edtproveedor_ecrChange
          DataField = 'proveedor_ecr'
          DataSource = DSMaestro
        end
        object edtorigen_ecr: TBDEdit
          Left = 140
          Top = 119
          Width = 110
          Height = 21
          ColorEdit = clMoneyGreen
          MaxLength = 17
          TabOrder = 12
          OnChange = edtorigen_ecrChange
          DataField = 'origen_ecr'
          DataSource = DSMaestro
          Modificable = False
        end
        object edtnumped_ecr: TBDEdit
          Left = 140
          Top = 97
          Width = 200
          Height = 21
          ColorEdit = clMoneyGreen
          MaxLength = 35
          TabOrder = 10
          DataField = 'numped_ecr'
          DataSource = DSMaestro
          Modificable = False
        end
        object edtaqsfac_ecr: TBDEdit
          Left = 534
          Top = 141
          Width = 110
          Height = 21
          ColorEdit = clMoneyGreen
          MaxLength = 17
          TabOrder = 17
          OnChange = edtaqsfac_ecrChange
          DataField = 'aqsfac_ecr'
          DataSource = DSMaestro
          Modificable = False
        end
        object edtfecdoc_ecr: TBDEdit
          Tag = 1
          Left = 140
          Top = 52
          Width = 90
          Height = 21
          ColorEdit = clMoneyGreen
          Zeros = True
          InputType = itDate
          MaxLength = 13
          TabOrder = 6
          DataField = 'fecdoc_ecr'
          DataSource = DSMaestro
          Modificable = False
          PrimaryKey = True
        end
        object edtdestino_ecr: TBDEdit
          Tag = 1
          Left = 534
          Top = 119
          Width = 110
          Height = 21
          ColorEdit = clMoneyGreen
          Zeros = True
          MaxLength = 17
          TabOrder = 13
          OnChange = edtdestino_ecrChange
          DataField = 'destino_ecr'
          DataSource = DSMaestro
          Modificable = False
          PrimaryKey = True
        end
        object edtfecrec_ecr: TBDEdit
          Left = 534
          Top = 52
          Width = 90
          Height = 21
          ColorEdit = clMoneyGreen
          InputType = itDate
          MaxLength = 2
          TabOrder = 7
          DataField = 'fecrec_ecr'
          DataSource = DSMaestro
          Modificable = False
        end
        object edtfcarga_ecr: TBDEdit
          Left = 534
          Top = 75
          Width = 90
          Height = 21
          ColorEdit = clMoneyGreen
          InputType = itDate
          MaxLength = 2
          TabOrder = 9
          DataField = 'fcarga_ecr'
          DataSource = DSMaestro
        end
        object storigen_ecr: TStaticText
          Left = 253
          Top = 121
          Width = 174
          Height = 17
          AutoSize = False
          BorderStyle = sbsSunken
          TabOrder = 14
        end
        object edtnumalb_ecr: TBDEdit
          Tag = 1
          Left = 140
          Top = 75
          Width = 200
          Height = 21
          ColorEdit = clMoneyGreen
          MaxLength = 35
          TabOrder = 8
          DataField = 'numalb_ecr'
          DataSource = DSMaestro
          Modificable = False
          PrimaryKey = True
        end
        object edtmatric_ecr: TBDEdit
          Tag = 1
          Left = 534
          Top = 97
          Width = 200
          Height = 21
          ColorEdit = clMoneyGreen
          MaxLength = 35
          TabOrder = 11
          DataField = 'matric_ecr'
          DataSource = DSMaestro
          Modificable = False
          PrimaryKey = True
        end
        object stdestino_ecr: TStaticText
          Left = 648
          Top = 121
          Width = 174
          Height = 17
          AutoSize = False
          BorderStyle = sbsSunken
          TabOrder = 15
        end
        object sttipo_ecr: TStaticText
          Left = 176
          Top = 32
          Width = 174
          Height = 17
          AutoSize = False
          BorderStyle = sbsSunken
          TabOrder = 4
        end
        object stfuncion_ecr: TStaticText
          Left = 571
          Top = 32
          Width = 174
          Height = 17
          AutoSize = False
          BorderStyle = sbsSunken
          TabOrder = 5
        end
        object stproveedor_ecr: TStaticText
          Left = 253
          Top = 143
          Width = 174
          Height = 17
          AutoSize = False
          BorderStyle = sbsSunken
          TabOrder = 18
        end
        object staqsfac_ecr: TStaticText
          Left = 648
          Top = 143
          Width = 174
          Height = 17
          AutoSize = False
          BorderStyle = sbsSunken
          TabOrder = 19
        end
      end
      object PDetalle: TPanel
        Left = 0
        Top = 177
        Width = 983
        Height = 401
        Align = alClient
        TabOrder = 1
        object dbgDetalle: TDBGrid
          Left = 1
          Top = 1
          Width = 981
          Height = 235
          Align = alTop
          DataSource = DSDetalle
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          Columns = <
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'idlin_elr'
              Title.Alignment = taCenter
              Title.Caption = 'Linea'
              Width = 50
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ean_elr'
              Title.Alignment = taCenter
              Title.Caption = 'Ean13'
              Width = 170
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'refprov_elr'
              Title.Alignment = taCenter
              Title.Caption = 'Cod.Provee.'
              Width = 70
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'refcli_elr'
              Title.Alignment = taCenter
              Title.Caption = 'Cod.Cliente'
              Width = 70
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'envase'
              Title.Caption = 'Descripci'#243'n'
              Width = 250
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'cantace_elr'
              Title.Alignment = taCenter
              Title.Caption = 'Unidades'
              Width = 70
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'cantue_elr'
              Title.Alignment = taCenter
              Title.Caption = 'Und.Cajas'
              Width = 70
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'unidad_fac'
              Title.Alignment = taCenter
              Title.Caption = 'Unidad'
              Width = 70
              Visible = True
            end>
        end
        object pnlLineas: TPanel
          Left = 1
          Top = 236
          Width = 981
          Height = 164
          Align = alClient
          TabOrder = 1
          object pgcControl: TPageControl
            Left = 1
            Top = 1
            Width = 979
            Height = 162
            ActivePage = tsAlbaran
            Align = alClient
            MultiLine = True
            TabIndex = 1
            TabOrder = 0
            TabPosition = tpRight
            OnChange = pgcControlChange
            object tsNotas: TTabSheet
              Caption = 'Notas'
              object dbgObservaciones: TDBGrid
                Left = 447
                Top = 0
                Width = 505
                Height = 154
                Align = alLeft
                DataSource = DSObservaciones
                Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
                ReadOnly = True
                TabOrder = 0
                TitleFont.Charset = DEFAULT_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -11
                TitleFont.Name = 'MS Sans Serif'
                TitleFont.Style = []
                Columns = <
                  item
                    Expanded = False
                    FieldName = 'idobs_eor'
                    Title.Alignment = taCenter
                    Title.Caption = 'Observaci'#243'n'
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'texto1_eor'
                    Title.Alignment = taCenter
                    Title.Caption = 'Texto 1'
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'texto2_eor'
                    Title.Alignment = taCenter
                    Title.Caption = 'Texto 2'
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'texto3_eor'
                    Title.Alignment = taCenter
                    Title.Caption = 'Texto 3'
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'texto4_eor'
                    Title.Alignment = taCenter
                    Title.Caption = 'Texto 4'
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'texto5_eor'
                    Title.Alignment = taCenter
                    Title.Caption = 'Texto 5'
                    Visible = True
                  end>
              end
              object dbgCantidades: TDBGrid
                Left = 0
                Top = 0
                Width = 447
                Height = 154
                Align = alLeft
                DataSource = DSCantidades
                Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
                ReadOnly = True
                TabOrder = 1
                TitleFont.Charset = DEFAULT_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -11
                TitleFont.Name = 'MS Sans Serif'
                TitleFont.Style = []
                Columns = <
                  item
                    Alignment = taCenter
                    Expanded = False
                    FieldName = 'calificador'
                    Title.Alignment = taCenter
                    Title.Caption = 'Calificador'
                    Width = 100
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'cantidad_enr'
                    Title.Alignment = taCenter
                    Title.Caption = 'Cantidad'
                    Width = 100
                    Visible = True
                  end
                  item
                    Alignment = taCenter
                    Expanded = False
                    FieldName = 'discrepancia'
                    Title.Alignment = taCenter
                    Title.Caption = 'Discrepancia'
                    Width = 100
                    Visible = True
                  end
                  item
                    Alignment = taCenter
                    Expanded = False
                    FieldName = 'razon'
                    Title.Alignment = taCenter
                    Title.Caption = 'Razon'
                    Width = 100
                    Visible = True
                  end>
              end
            end
            object tsAlbaran: TTabSheet
              Caption = 'Albaran'
              ImageIndex = 1
              object dbgAlbaran: TDBGrid
                Left = 0
                Top = 0
                Width = 952
                Height = 154
                Align = alClient
                DataSource = DSAlbaranDet
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -8
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
                ParentFont = False
                ReadOnly = True
                TabOrder = 0
                TitleFont.Charset = DEFAULT_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -11
                TitleFont.Name = 'MS Sans Serif'
                TitleFont.Style = []
                Columns = <
                  item
                    Alignment = taCenter
                    Expanded = False
                    FieldName = 'envase'
                    Title.Alignment = taCenter
                    Title.Caption = 'Envase'
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'descripcion'
                    Title.Alignment = taCenter
                    Title.Caption = 'Descripcion Cli.'
                    Width = 200
                    Visible = True
                  end
                  item
                    Alignment = taRightJustify
                    Expanded = False
                    FieldName = 'palets'
                    Title.Alignment = taCenter
                    Title.Caption = 'Palets'
                    Visible = True
                  end
                  item
                    Alignment = taRightJustify
                    Expanded = False
                    FieldName = 'cajas'
                    Title.Alignment = taCenter
                    Title.Caption = 'Cajas'
                    Visible = True
                  end
                  item
                    Alignment = taRightJustify
                    Expanded = False
                    FieldName = 'kilos'
                    Title.Alignment = taCenter
                    Title.Caption = 'Kilos'
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'unidades'
                    Title.Alignment = taCenter
                    Title.Caption = 'Unidades'
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'unidad_factura'
                    Title.Alignment = taCenter
                    Title.Caption = 'Unidad'
                    Visible = True
                  end>
              end
            end
          end
        end
      end
    end
    object tsBusqueda: TTabSheet
      Caption = 'BUSQUEDA'
      ImageIndex = 1
      OnShow = tsBusquedaShow
      object dbgBusqueda: TDBGrid
        Left = 0
        Top = 0
        Width = 983
        Height = 578
        Align = alClient
        DataSource = DSMaestro
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDblClick = dbgBusquedaDblClick
      end
    end
  end
  object pnlVerDetalle: TPanel
    Left = 848
    Top = 225
    Width = 116
    Height = 22
    TabOrder = 2
    object cbbVerDetalle: TComboBox
      Left = 0
      Top = 0
      Width = 115
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = 'Datos Cliente'
      OnChange = cbbVerDetalleChange
      Items.Strings = (
        'Datos Cliente'
        'Cajas Logifuit'
        'Palets'
        'Todos los datos')
    end
  end
  object DSMaestro: TDataSource
    DataSet = DMRecadv.QMaestro
    Left = 336
    Top = 80
  end
  object actlstRecadv: TActionList
    Images = DMBaseDatos.ImgBarraHerramientas
    Left = 337
    Top = 248
    object ASalir: TAction
      Caption = 'Salir'
      ImageIndex = 18
      OnExecute = ASalirExecute
    end
    object ALocalizar: TAction
      Caption = 'ALocalizar'
      ImageIndex = 8
      ShortCut = 76
      OnExecute = ALocalizarExecute
    end
    object APrimero: TAction
      Caption = 'Primero'
      ImageIndex = 0
      ShortCut = 36
      OnExecute = APrimeroExecute
    end
    object AAnterior: TAction
      Caption = 'Anterior'
      ImageIndex = 1
      OnExecute = AAnteriorExecute
    end
    object ASiguiente: TAction
      Caption = 'Siguiente'
      ImageIndex = 2
      OnExecute = ASiguienteExecute
    end
    object AUltimo: TAction
      Caption = 'Ultimo'
      ImageIndex = 3
      ShortCut = 35
      OnExecute = AUltimoExecute
    end
    object AImprimir: TAction
      Caption = 'Imprimir'
      ImageIndex = 19
      ShortCut = 73
      OnExecute = AImprimirExecute
    end
  end
  object DSDetalle: TDataSource
    AutoEdit = False
    DataSet = DMRecadv.QDetalle
    Left = 22
    Top = 247
  end
  object DSCantidades: TDataSource
    AutoEdit = False
    DataSet = DMRecadv.QCantidades
    Left = 27
    Top = 487
  end
  object DSObservaciones: TDataSource
    AutoEdit = False
    DataSet = DMRecadv.QObservaciones
    Left = 473
    Top = 487
  end
  object DSAlbaranDet: TDataSource
    AutoEdit = False
    DataSet = DMRecadv.QAlbaranDet
    Left = 273
    Top = 551
  end
end
