object FManFacturas: TFManFacturas
  Left = 372
  Top = 145
  BorderIcons = []
  Caption = 'Mantenimiento de Facturas'
  ClientHeight = 641
  ClientWidth = 995
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
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  DesignSize = (
    995
    641)
  PixelsPerInch = 96
  TextHeight = 13
  object dsMain: TdxDockSite
    Left = 0
    Top = 38
    Width = 995
    Height = 603
    ParentShowHint = False
    ShowHint = False
    Align = alClient
    OnHideControl = dsMainHideControl
    OnShowControl = dsMainShowControl
    DockingType = 5
    OriginalWidth = 995
    OriginalHeight = 603
    object ds2: TdxLayoutDockSite
      Left = 0
      Top = 0
      Width = 995
      Height = 575
      DockingType = 0
      OriginalWidth = 300
      OriginalHeight = 200
      object ds3: TdxLayoutDockSite
        Left = 0
        Top = 0
        Width = 995
        Height = 575
        DockingType = 0
        OriginalWidth = 300
        OriginalHeight = 200
      end
      object dpManFacturas: TdxDockPanel
        Left = 0
        Top = 0
        Width = 995
        Height = 575
        AllowFloating = False
        AutoHide = False
        CaptionButtons = []
        CustomCaptionButtons.Buttons = <>
        TabsProperties.CustomButtons.Buttons = <>
        DockingType = 0
        OriginalWidth = 185
        OriginalHeight = 140
        object cxPageControl: TcxPageControl
          Left = 0
          Top = 163
          Width = 981
          Height = 378
          Align = alClient
          TabOrder = 1
          Properties.ActivePage = tsCabeceraFactura
          Properties.CustomButtons.Buttons = <>
          Properties.ImageBorder = 1
          Properties.Images = DFactura.IFacturas
          Properties.MultiLine = True
          LookAndFeel.Kind = lfFlat
          LookAndFeel.NativeStyle = False
          LookAndFeel.SkinName = 'Foggy'
          ClientRectBottom = 373
          ClientRectLeft = 5
          ClientRectRight = 976
          ClientRectTop = 30
          object tsCabeceraFactura: TcxTabSheet
            Caption = 'Cabecera Factura'
            object gbImportes: TcxGroupBox
              Left = 0
              Top = 0
              Align = alLeft
              Enabled = False
              PanelStyle.OfficeBackgroundKind = pobkStyleColor
              Style.LookAndFeel.Kind = lfOffice11
              Style.LookAndFeel.NativeStyle = False
              Style.LookAndFeel.SkinName = 'Foggy'
              Style.Shadow = False
              Style.TextStyle = []
              StyleDisabled.LookAndFeel.Kind = lfOffice11
              StyleDisabled.LookAndFeel.NativeStyle = False
              StyleDisabled.LookAndFeel.SkinName = 'Foggy'
              StyleFocused.LookAndFeel.Kind = lfOffice11
              StyleFocused.LookAndFeel.NativeStyle = False
              StyleFocused.LookAndFeel.SkinName = 'Foggy'
              StyleHot.LookAndFeel.Kind = lfOffice11
              StyleHot.LookAndFeel.NativeStyle = False
              StyleHot.LookAndFeel.SkinName = 'Foggy'
              TabOrder = 0
              Height = 343
              Width = 473
              object shp1: TShape
                Left = 53
                Top = 234
                Width = 357
                Height = 1
              end
              object cxLabel19: TcxLabel
                Left = 103
                Top = 93
                Caption = 'Base'
                ParentFont = False
                Style.Font.Charset = DEFAULT_CHARSET
                Style.Font.Color = clWindowText
                Style.Font.Height = -11
                Style.Font.Name = 'MS Sans Serif'
                Style.Font.Style = [fsBold]
                Style.IsFontAssigned = True
              end
              object cxLabel20: TcxLabel
                Left = 215
                Top = 93
                Caption = 'Cuota'
                ParentFont = False
                Style.Font.Charset = DEFAULT_CHARSET
                Style.Font.Color = clWindowText
                Style.Font.Height = -11
                Style.Font.Name = 'MS Sans Serif'
                Style.Font.Style = [fsBold]
                Style.IsFontAssigned = True
              end
              object cxLabel22: TcxLabel
                Left = 327
                Top = 93
                Caption = 'Total'
                ParentFont = False
                Style.Font.Charset = DEFAULT_CHARSET
                Style.Font.Color = clWindowText
                Style.Font.Height = -11
                Style.Font.Name = 'MS Sans Serif'
                Style.Font.Style = [fsBold]
                Style.IsFontAssigned = True
              end
              object cxSuper: TcxLabel
                Left = 55
                Top = 114
                AutoSize = False
                Caption = '4 %'
                Properties.Alignment.Horz = taRightJustify
                Height = 17
                Width = 40
                AnchorX = 95
              end
              object ceNeto1: TcxCurrencyEdit
                Left = 104
                Top = 112
                TabStop = False
                Properties.Alignment.Horz = taRightJustify
                Properties.DecimalPlaces = 2
                Properties.DisplayFormat = ',0.00;-,0.00'
                Properties.ReadOnly = True
                TabOrder = 5
                Width = 80
              end
              object ceImpuesto1: TcxCurrencyEdit
                Left = 215
                Top = 112
                TabStop = False
                Properties.Alignment.Horz = taRightJustify
                Properties.DisplayFormat = ',0.00;-,0.00'
                Properties.ReadOnly = True
                TabOrder = 6
                Width = 80
              end
              object ceTotal1: TcxCurrencyEdit
                Left = 330
                Top = 112
                TabStop = False
                Properties.Alignment.Horz = taRightJustify
                Properties.DisplayFormat = ',0.00;-,0.00'
                Properties.ReadOnly = True
                TabOrder = 8
                Width = 80
              end
              object cxReducido: TcxLabel
                Left = 55
                Top = 138
                AutoSize = False
                Caption = '10 %'
                Properties.Alignment.Horz = taRightJustify
                Height = 17
                Width = 40
                AnchorX = 95
              end
              object ceNeto2: TcxCurrencyEdit
                Left = 104
                Top = 136
                TabStop = False
                Properties.Alignment.Horz = taRightJustify
                Properties.DisplayFormat = ',0.00;-,0.00'
                Properties.ReadOnly = True
                TabOrder = 9
                Width = 80
              end
              object ceImpuesto2: TcxCurrencyEdit
                Left = 215
                Top = 136
                TabStop = False
                Properties.Alignment.Horz = taRightJustify
                Properties.DisplayFormat = ',0.00;-,0.00'
                Properties.ReadOnly = True
                TabOrder = 10
                Width = 80
              end
              object ceTotal2: TcxCurrencyEdit
                Left = 330
                Top = 136
                TabStop = False
                Properties.Alignment.Horz = taRightJustify
                Properties.DisplayFormat = ',0.00;-,0.00'
                Properties.ReadOnly = True
                TabOrder = 12
                Width = 80
              end
              object cxGeneral: TcxLabel
                Left = 55
                Top = 162
                AutoSize = False
                Caption = '21 %'
                Properties.Alignment.Horz = taRightJustify
                Height = 17
                Width = 40
                AnchorX = 95
              end
              object ceNeto3: TcxCurrencyEdit
                Left = 104
                Top = 160
                TabStop = False
                Properties.Alignment.Horz = taRightJustify
                Properties.DisplayFormat = ',0.00;-,0.00'
                Properties.ReadOnly = True
                TabOrder = 13
                Width = 80
              end
              object ceImpuesto3: TcxCurrencyEdit
                Left = 215
                Top = 160
                TabStop = False
                Properties.Alignment.Horz = taRightJustify
                Properties.DisplayFormat = ',0.00;-,0.00'
                Properties.ReadOnly = True
                TabOrder = 14
                Width = 80
              end
              object ceTotal3: TcxCurrencyEdit
                Left = 330
                Top = 160
                TabStop = False
                Properties.Alignment.Horz = taRightJustify
                Properties.DisplayFormat = ',0.00;-,0.00'
                Properties.ReadOnly = True
                TabOrder = 16
                Width = 80
              end
              object cxExento: TcxLabel
                Left = 55
                Top = 202
                AutoSize = False
                Caption = '0 %'
                Properties.Alignment.Horz = taRightJustify
                Height = 17
                Width = 40
                AnchorX = 95
              end
              object ceNeto4: TcxCurrencyEdit
                Left = 104
                Top = 200
                TabStop = False
                Properties.Alignment.Horz = taRightJustify
                Properties.DisplayFormat = ',0.00;-,0.00'
                Properties.ReadOnly = True
                TabOrder = 17
                Width = 80
              end
              object ceImpuesto4: TcxCurrencyEdit
                Left = 215
                Top = 200
                TabStop = False
                Properties.Alignment.Horz = taRightJustify
                Properties.DisplayFormat = ',0.00;-,0.00'
                Properties.ReadOnly = True
                TabOrder = 18
                Width = 80
              end
              object ceTotal4: TcxCurrencyEdit
                Left = 330
                Top = 200
                TabStop = False
                Properties.Alignment.Horz = taRightJustify
                Properties.DisplayFormat = ',0.00;-,0.00'
                Properties.ReadOnly = True
                TabOrder = 20
                Width = 80
              end
              object cxLabel26: TcxLabel
                Left = 47
                Top = 250
                AutoSize = False
                Caption = 'TOTAL'
                ParentFont = False
                Style.Font.Charset = DEFAULT_CHARSET
                Style.Font.Color = clWindowText
                Style.Font.Height = -11
                Style.Font.Name = 'MS Sans Serif'
                Style.Font.Style = [fsBold]
                Style.IsFontAssigned = True
                Properties.Alignment.Horz = taRightJustify
                Height = 17
                Width = 50
                AnchorX = 97
              end
              object ceNetoT: TcxCurrencyEdit
                Left = 104
                Top = 249
                TabStop = False
                Properties.Alignment.Horz = taRightJustify
                Properties.DecimalPlaces = 3
                Properties.DisplayFormat = ',0.00;-,0.00'
                Properties.ReadOnly = True
                TabOrder = 24
                Width = 80
              end
              object ceImpuestoT: TcxCurrencyEdit
                Left = 215
                Top = 248
                TabStop = False
                Properties.Alignment.Horz = taRightJustify
                Properties.DecimalPlaces = 3
                Properties.DisplayFormat = ',0.00;-,0.00'
                Properties.ReadOnly = True
                TabOrder = 21
                Width = 80
              end
              object ceTotalT: TcxCurrencyEdit
                Left = 330
                Top = 248
                TabStop = False
                Properties.Alignment.Horz = taRightJustify
                Properties.DecimalPlaces = 3
                Properties.DisplayFormat = ',0.00;-,0.00'
                Properties.ReadOnly = True
                TabOrder = 22
                Width = 80
              end
              object cxLabel21: TcxLabel
                Left = 47
                Top = 276
                AutoSize = False
                Caption = 'EUROS'
                ParentFont = False
                Style.Font.Charset = DEFAULT_CHARSET
                Style.Font.Color = clWindowText
                Style.Font.Height = -11
                Style.Font.Name = 'MS Sans Serif'
                Style.Font.Style = [fsBold]
                Style.IsFontAssigned = True
                Properties.Alignment.Horz = taRightJustify
                Height = 17
                Width = 50
                AnchorX = 97
              end
              object ceNetoEuros: TcxCurrencyEdit
                Left = 104
                Top = 274
                TabStop = False
                Properties.Alignment.Horz = taRightJustify
                Properties.DisplayFormat = ',0.00;-,0.00'
                Properties.ReadOnly = True
                TabOrder = 25
                Width = 80
              end
              object ceImpuestoEuros: TcxCurrencyEdit
                Left = 215
                Top = 274
                TabStop = False
                Properties.Alignment.Horz = taRightJustify
                Properties.DisplayFormat = ',0.00;-,0.00'
                Properties.ReadOnly = True
                TabOrder = 26
                Width = 80
              end
              object ceTotalEuros: TcxCurrencyEdit
                Left = 330
                Top = 274
                TabStop = False
                Properties.Alignment.Horz = taRightJustify
                Properties.DisplayFormat = ',0.00;-,0.00'
                Properties.ReadOnly = True
                TabOrder = 29
                Width = 80
              end
              object ceDescuento: TcxCurrencyEdit
                Left = 330
                Top = 48
                TabStop = False
                Properties.Alignment.Horz = taRightJustify
                Properties.DisplayFormat = ',0.00;-,0.00'
                Properties.ReadOnly = True
                TabOrder = 2
                Width = 80
              end
              object cxLabel25: TcxLabel
                Left = 17
                Top = 15
                AutoSize = False
                Caption = 'IMPORTES FACTURA'
                ParentColor = False
                ParentFont = False
                Style.BorderStyle = ebs3D
                Style.Color = clBtnFace
                Style.Font.Charset = DEFAULT_CHARSET
                Style.Font.Color = clWindowText
                Style.Font.Height = -11
                Style.Font.Name = 'MS Sans Serif'
                Style.Font.Style = [fsBold]
                Style.HotTrack = False
                Style.LookAndFeel.NativeStyle = True
                Style.LookAndFeel.SkinName = 'Foggy'
                Style.IsFontAssigned = True
                StyleDisabled.LookAndFeel.NativeStyle = True
                StyleDisabled.LookAndFeel.SkinName = 'Foggy'
                StyleFocused.LookAndFeel.NativeStyle = True
                StyleFocused.LookAndFeel.SkinName = 'Foggy'
                StyleHot.LookAndFeel.NativeStyle = True
                StyleHot.LookAndFeel.SkinName = 'Foggy'
                Properties.Alignment.Horz = taCenter
                Height = 17
                Width = 140
                AnchorX = 87
              end
              object cxLabel33: TcxLabel
                Left = 208
                Top = 50
                AutoSize = False
                Caption = 'Total Descuentos'
                ParentFont = False
                Style.Font.Charset = DEFAULT_CHARSET
                Style.Font.Color = clWindowText
                Style.Font.Height = -11
                Style.Font.Name = 'MS Sans Serif'
                Style.Font.Style = [fsBold]
                Style.IsFontAssigned = True
                Properties.Alignment.Horz = taRightJustify
                Height = 17
                Width = 120
                AnchorX = 328
              end
              object cxRecargo: TcxLabel
                Left = 168
                Top = 15
                Caption = '** Factura con Recargo de Equivalencia **'
                ParentFont = False
                Style.Font.Charset = DEFAULT_CHARSET
                Style.Font.Color = clWindowText
                Style.Font.Height = -11
                Style.Font.Name = 'MS Sans Serif'
                Style.Font.Style = [fsBold]
                Style.IsFontAssigned = True
                Properties.Angle = 90
                Visible = False
              end
            end
            object gbRemesas: TcxGroupBox
              Left = 480
              Top = 0
              Align = alRight
              Enabled = False
              PanelStyle.OfficeBackgroundKind = pobkStyleColor
              Style.LookAndFeel.NativeStyle = False
              Style.LookAndFeel.SkinName = 'Foggy'
              StyleDisabled.LookAndFeel.NativeStyle = False
              StyleDisabled.LookAndFeel.SkinName = 'Foggy'
              StyleFocused.LookAndFeel.NativeStyle = False
              StyleFocused.LookAndFeel.SkinName = 'Foggy'
              StyleHot.LookAndFeel.NativeStyle = False
              StyleHot.LookAndFeel.SkinName = 'Foggy'
              TabOrder = 1
              Height = 343
              Width = 491
              object cxGrid: TcxGrid
                Left = 3
                Top = 87
                Width = 485
                Height = 253
                Align = alClient
                TabOrder = 1
                LookAndFeel.NativeStyle = False
                LookAndFeel.SkinName = 'Foggy'
                object tvRemesas: TcxGridDBTableView
                  Navigator.Buttons.CustomButtons = <>
                  DataController.DataSource = dsQRemesas
                  DataController.Summary.DefaultGroupSummaryItems = <>
                  DataController.Summary.FooterSummaryItems = <>
                  DataController.Summary.SummaryGroups = <>
                  OptionsView.ColumnAutoWidth = True
                  OptionsView.GroupByBox = False
                  object tvNumRemesa: TcxGridDBColumn
                    Caption = 'N'#250'mero Remesa'
                    DataBinding.FieldName = 'n_remesa_rc'
                    PropertiesClassName = 'TcxTextEditProperties'
                    Properties.ReadOnly = True
                    HeaderAlignmentHorz = taCenter
                    Options.Editing = False
                    SortIndex = 0
                    SortOrder = soAscending
                    Width = 90
                  end
                  object tvFechaRemesa: TcxGridDBColumn
                    Caption = 'Fecha Remesa'
                    DataBinding.FieldName = 'fecha_vencimiento_rc'
                    PropertiesClassName = 'TcxDateEditProperties'
                    Properties.Alignment.Horz = taCenter
                    Properties.ReadOnly = True
                    HeaderAlignmentHorz = taCenter
                    Options.Editing = False
                    SortIndex = 1
                    SortOrder = soAscending
                    Width = 90
                  end
                  object tvBancoRemesa: TcxGridDBColumn
                    Caption = 'Banco'
                    DataBinding.FieldName = 'descripcion_b'
                    Width = 200
                  end
                  object tvImporteCob: TcxGridDBColumn
                    Caption = 'Importe Cobrado'
                    DataBinding.FieldName = 'importe_cobrado_rf'
                    PropertiesClassName = 'TcxCurrencyEditProperties'
                    Properties.DisplayFormat = ',0.00;-,0.00'
                    Properties.ReadOnly = True
                    HeaderAlignmentHorz = taCenter
                    Options.Editing = False
                    Width = 120
                  end
                end
                object lvRemesas: TcxGridLevel
                  GridView = tvRemesas
                end
              end
              object grpPrincipal1: TcxGroupBox
                Left = 3
                Top = 8
                Align = alTop
                ParentBackground = False
                Style.BorderColor = clWindowFrame
                Style.BorderStyle = ebsNone
                Style.LookAndFeel.NativeStyle = False
                Style.LookAndFeel.SkinName = 'Foggy'
                StyleDisabled.LookAndFeel.NativeStyle = False
                StyleDisabled.LookAndFeel.SkinName = 'Foggy'
                StyleFocused.LookAndFeel.NativeStyle = False
                StyleFocused.LookAndFeel.SkinName = 'Foggy'
                StyleHot.LookAndFeel.NativeStyle = False
                StyleHot.LookAndFeel.SkinName = 'Foggy'
                TabOrder = 0
                Height = 79
                Width = 485
                object cxLabel27: TcxLabel
                  Left = 4
                  Top = 7
                  AutoSize = False
                  Caption = 'REMESAS'
                  ParentColor = False
                  ParentFont = False
                  Style.BorderStyle = ebs3D
                  Style.Color = clBtnFace
                  Style.Font.Charset = DEFAULT_CHARSET
                  Style.Font.Color = clWindowText
                  Style.Font.Height = -11
                  Style.Font.Name = 'MS Sans Serif'
                  Style.Font.Style = [fsBold]
                  Style.HotTrack = False
                  Style.LookAndFeel.NativeStyle = True
                  Style.LookAndFeel.SkinName = 'Foggy'
                  Style.IsFontAssigned = True
                  StyleDisabled.LookAndFeel.NativeStyle = True
                  StyleDisabled.LookAndFeel.SkinName = 'Foggy'
                  StyleFocused.LookAndFeel.NativeStyle = True
                  StyleFocused.LookAndFeel.SkinName = 'Foggy'
                  StyleHot.LookAndFeel.NativeStyle = True
                  StyleHot.LookAndFeel.SkinName = 'Foggy'
                  Properties.Alignment.Horz = taCenter
                  Height = 17
                  Width = 140
                  AnchorX = 74
                end
                object cxLabel29: TcxLabel
                  Left = 14
                  Top = 47
                  AutoSize = False
                  Caption = 'Importe Pendiente'
                  ParentFont = False
                  Style.Font.Charset = DEFAULT_CHARSET
                  Style.Font.Color = clWindowText
                  Style.Font.Height = -11
                  Style.Font.Name = 'MS Sans Serif'
                  Style.Font.Style = [fsBold]
                  Style.IsFontAssigned = True
                  Properties.Alignment.Horz = taRightJustify
                  Height = 17
                  Width = 120
                  AnchorX = 134
                end
                object cePdteRem: TcxCurrencyEdit
                  Left = 136
                  Top = 45
                  TabStop = False
                  Properties.Alignment.Horz = taRightJustify
                  Properties.DisplayFormat = ',0.00;-,0.00'
                  Properties.ReadOnly = True
                  TabOrder = 1
                  Width = 100
                end
                object cxLabel28: TcxLabel
                  Left = 249
                  Top = 47
                  AutoSize = False
                  Caption = 'IMPORTE COBRADO'
                  ParentFont = False
                  Style.Font.Charset = DEFAULT_CHARSET
                  Style.Font.Color = clWindowText
                  Style.Font.Height = -11
                  Style.Font.Name = 'MS Sans Serif'
                  Style.Font.Style = [fsBold]
                  Style.IsFontAssigned = True
                  Properties.Alignment.Horz = taRightJustify
                  Height = 17
                  Width = 130
                  AnchorX = 379
                end
                object ceCobradoRem: TcxCurrencyEdit
                  Left = 378
                  Top = 45
                  TabStop = False
                  Properties.Alignment.Horz = taRightJustify
                  Properties.DisplayFormat = ',0.00;-,0.00'
                  Properties.ReadOnly = True
                  TabOrder = 2
                  Width = 100
                end
              end
            end
          end
          object tsDetalleLineas: TcxTabSheet
            Caption = 'Detalle de Lineas'
            object pnlDetLineas: TPanel
              Left = 0
              Top = 0
              Width = 971
              Height = 65
              Align = alTop
              TabOrder = 0
              object cxLabel11: TcxLabel
                Left = 15
                Top = 10
                AutoSize = False
                Caption = 'Empresa Albaran'
                Style.Edges = [bLeft, bTop, bRight, bBottom]
                Style.TextStyle = []
                Properties.Alignment.Horz = taLeftJustify
                Height = 17
                Width = 85
              end
              object edtLinCodEmpresaAlb: TcxDBTextEdit
                Left = 101
                Top = 8
                DataBinding.DataField = 'cod_empresa_albaran_fd'
                DataBinding.DataSource = dsQDetFactura
                Properties.CharCase = ecUpperCase
                Properties.MaxLength = 3
                Properties.OnChange = PonNombre
                TabOrder = 0
                Width = 30
              end
              object cxLabel12: TcxLabel
                Left = 337
                Top = 10
                AutoSize = False
                Caption = 'Centro Salida'
                Style.Edges = [bLeft, bTop, bRight, bBottom]
                Style.TextStyle = []
                Properties.Alignment.Horz = taLeftJustify
                Height = 17
                Width = 72
              end
              object edtLinCentroAlb: TcxDBTextEdit
                Left = 410
                Top = 8
                DataBinding.DataField = 'cod_centro_albaran_fd'
                DataBinding.DataSource = dsQDetFactura
                Properties.CharCase = ecUpperCase
                Properties.MaxLength = 3
                Properties.OnChange = PonNombre
                TabOrder = 2
                Width = 30
              end
              object cxLabel13: TcxLabel
                Left = 624
                Top = 10
                AutoSize = False
                Caption = 'Num. Albaran'
                Properties.Alignment.Horz = taLeftJustify
                Height = 17
                Width = 70
              end
              object edtLinNumeroAlb: TcxDBTextEdit
                Left = 695
                Top = 8
                DataBinding.DataField = 'n_albaran_fd'
                DataBinding.DataSource = dsQDetFactura
                TabOrder = 4
                Width = 60
              end
              object cxLabel14: TcxLabel
                Left = 800
                Top = 10
                AutoSize = False
                Caption = 'Fec. Albaran'
                Height = 17
                Width = 70
              end
              object cxLabel15: TcxLabel
                Left = 15
                Top = 34
                AutoSize = False
                Caption = 'Cliente Albaran'
                Properties.Alignment.Horz = taLeftJustify
                Height = 17
                Width = 85
              end
              object edtLinCodClienteAlb: TcxDBTextEdit
                Left = 101
                Top = 32
                DataBinding.DataField = 'cod_cliente_albaran_fd'
                DataBinding.DataSource = dsQDetFactura
                Properties.CharCase = ecUpperCase
                Properties.MaxLength = 3
                Properties.OnChange = PonNombre
                TabOrder = 10
                Width = 30
              end
              object cxLabel16: TcxLabel
                Left = 337
                Top = 34
                AutoSize = False
                Caption = 'Dir. Suministro'
                Properties.Alignment.Horz = taLeftJustify
                Height = 17
                Width = 72
              end
              object edtLinCodSuministroAlb: TcxDBTextEdit
                Left = 410
                Top = 32
                DataBinding.DataField = 'cod_dir_sum_fd'
                DataBinding.DataSource = dsQDetFactura
                Properties.CharCase = ecUpperCase
                Properties.MaxLength = 3
                Properties.OnChange = PonNombre
                TabOrder = 12
                Width = 30
              end
              object cxLabel17: TcxLabel
                Left = 624
                Top = 34
                AutoSize = False
                Caption = 'Num. Pedido'
                Properties.Alignment.Horz = taLeftJustify
                Height = 17
                Width = 71
              end
              object edtLinPedidoAlb: TcxDBTextEdit
                Left = 695
                Top = 32
                DataBinding.DataField = 'pedido_fd'
                DataBinding.DataSource = dsQDetFactura
                Properties.MaxLength = 15
                TabOrder = 14
                Width = 99
              end
              object edtLinFechaAlb: TcxDBDateEdit
                Left = 871
                Top = 9
                DataBinding.DataField = 'fecha_albaran_fd'
                DataBinding.DataSource = dsQDetFactura
                Properties.ReadOnly = False
                TabOrder = 5
                Width = 80
              end
              object txLinDesEmpresaAlb: TcxTextEdit
                Left = 133
                Top = 8
                TabStop = False
                Properties.ReadOnly = True
                Style.BorderStyle = ebsFlat
                Style.Color = clBtnFace
                Style.LookAndFeel.Kind = lfFlat
                Style.LookAndFeel.NativeStyle = False
                Style.LookAndFeel.SkinName = ''
                Style.Shadow = False
                Style.TransparentBorder = True
                StyleDisabled.LookAndFeel.Kind = lfFlat
                StyleDisabled.LookAndFeel.NativeStyle = False
                StyleDisabled.LookAndFeel.SkinName = ''
                StyleFocused.LookAndFeel.Kind = lfFlat
                StyleFocused.LookAndFeel.NativeStyle = False
                StyleFocused.LookAndFeel.SkinName = ''
                StyleHot.LookAndFeel.Kind = lfFlat
                StyleHot.LookAndFeel.NativeStyle = False
                StyleHot.LookAndFeel.SkinName = ''
                TabOrder = 1
                Width = 190
              end
              object txLinDesClienteAlb: TcxTextEdit
                Left = 133
                Top = 32
                TabStop = False
                Properties.ReadOnly = True
                Style.BorderStyle = ebsFlat
                Style.Color = clBtnFace
                Style.LookAndFeel.Kind = lfFlat
                Style.LookAndFeel.NativeStyle = False
                Style.LookAndFeel.SkinName = ''
                Style.Shadow = False
                Style.TransparentBorder = True
                StyleDisabled.LookAndFeel.Kind = lfFlat
                StyleDisabled.LookAndFeel.NativeStyle = False
                StyleDisabled.LookAndFeel.SkinName = ''
                StyleFocused.LookAndFeel.Kind = lfFlat
                StyleFocused.LookAndFeel.NativeStyle = False
                StyleFocused.LookAndFeel.SkinName = ''
                StyleHot.LookAndFeel.Kind = lfFlat
                StyleHot.LookAndFeel.NativeStyle = False
                StyleHot.LookAndFeel.SkinName = ''
                TabOrder = 11
                Width = 190
              end
              object txLinDesCentroAlb: TcxTextEdit
                Left = 442
                Top = 8
                TabStop = False
                Properties.ReadOnly = True
                Style.BorderStyle = ebsFlat
                Style.Color = clBtnFace
                Style.LookAndFeel.Kind = lfFlat
                Style.LookAndFeel.NativeStyle = False
                Style.LookAndFeel.SkinName = ''
                Style.Shadow = False
                Style.TransparentBorder = True
                StyleDisabled.LookAndFeel.Kind = lfFlat
                StyleDisabled.LookAndFeel.NativeStyle = False
                StyleDisabled.LookAndFeel.SkinName = ''
                StyleFocused.LookAndFeel.Kind = lfFlat
                StyleFocused.LookAndFeel.NativeStyle = False
                StyleFocused.LookAndFeel.SkinName = ''
                StyleHot.LookAndFeel.Kind = lfFlat
                StyleHot.LookAndFeel.NativeStyle = False
                StyleHot.LookAndFeel.SkinName = ''
                TabOrder = 3
                Width = 177
              end
              object txLinDesSuministroAlb: TcxTextEdit
                Left = 442
                Top = 32
                TabStop = False
                Properties.ReadOnly = True
                Style.BorderStyle = ebsFlat
                Style.Color = clBtnFace
                Style.LookAndFeel.Kind = lfFlat
                Style.LookAndFeel.NativeStyle = False
                Style.LookAndFeel.SkinName = ''
                Style.Shadow = False
                Style.TransparentBorder = True
                StyleDisabled.LookAndFeel.Kind = lfFlat
                StyleDisabled.LookAndFeel.NativeStyle = False
                StyleDisabled.LookAndFeel.SkinName = ''
                StyleFocused.LookAndFeel.Kind = lfFlat
                StyleFocused.LookAndFeel.NativeStyle = False
                StyleFocused.LookAndFeel.SkinName = ''
                StyleHot.LookAndFeel.Kind = lfFlat
                StyleHot.LookAndFeel.NativeStyle = False
                StyleHot.LookAndFeel.SkinName = ''
                TabOrder = 13
                Width = 177
              end
              object cxLabel24: TcxLabel
                Left = 800
                Top = 34
                AutoSize = False
                Caption = 'Fec. Pedido'
                Height = 17
                Width = 70
              end
              object edtLinFecPedido: TcxDBDateEdit
                Left = 871
                Top = 33
                DataBinding.DataField = 'fecha_pedido_fd'
                DataBinding.DataSource = dsQDetFactura
                Properties.ReadOnly = False
                TabOrder = 15
                Width = 80
              end
            end
            object cxLineas: TcxGrid
              Left = 0
              Top = 65
              Width = 971
              Height = 278
              Align = alClient
              TabOrder = 1
              LookAndFeel.NativeStyle = False
              LookAndFeel.SkinName = 'Foggy'
              object tvDetalleLineas: TcxGridDBTableView
                Navigator.Buttons.CustomButtons = <>
                DataController.DataSource = dsQDetFactura
                DataController.Summary.DefaultGroupSummaryItems = <>
                DataController.Summary.FooterSummaryItems = <
                  item
                    Format = ',0.00;-,0.00'
                    Kind = skSum
                    FieldName = 'importe_linea_fd'
                    Column = tvImporte
                  end
                  item
                    Format = ',0.00;-,0.00'
                    Kind = skSum
                    FieldName = 'importe_total_descuento_fd'
                    Column = tvDescuentos
                  end
                  item
                    Format = ',0.00;-,0.00'
                    Kind = skSum
                    FieldName = 'importe_neto_fd'
                    Column = tvImporteNeto
                  end
                  item
                    Format = ',0.00;-,0.00'
                    Kind = skSum
                    FieldName = 'importe_impuesto_fd'
                    Column = tvImpImpuesto
                  end
                  item
                    Format = ',0.00;-,0.00'
                    Kind = skSum
                    FieldName = 'importe_total_fd'
                    Column = tvImporteTotal
                  end
                  item
                    Format = ',0.00;-,0.00'
                    Kind = skSum
                    FieldName = 'kilos_fd'
                    Column = tvKilos
                  end>
                DataController.Summary.SummaryGroups = <>
                OptionsData.CancelOnExit = False
                OptionsData.Deleting = False
                OptionsData.DeletingConfirmation = False
                OptionsData.Editing = False
                OptionsData.Inserting = False
                OptionsSelection.MultiSelect = True
                OptionsView.ColumnAutoWidth = True
                OptionsView.Footer = True
                OptionsView.GroupByBox = False
                object tvProducto: TcxGridDBColumn
                  Caption = 'Prod.'
                  DataBinding.FieldName = 'cod_producto_fd'
                  Width = 35
                end
                object tvDesProducto: TcxGridDBColumn
                  Caption = 'Descripci'#243'n'
                  DataBinding.FieldName = 'des_producto_fd'
                  Width = 150
                end
                object tvDesEnvase: TcxGridDBColumn
                  Caption = 'Art'#237'culo'
                  DataBinding.FieldName = 'des_envase_fd'
                  Width = 100
                end
                object tvUnidades: TcxGridDBColumn
                  Caption = 'Unidades'
                  DataBinding.FieldName = 'unidades_fd'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DecimalPlaces = 0
                  Properties.DisplayFormat = ',0;-,0'
                  FooterAlignmentHorz = taCenter
                  HeaderAlignmentHorz = taCenter
                  Width = 55
                end
                object tvCajas: TcxGridDBColumn
                  Caption = 'Cajas'
                  DataBinding.FieldName = 'cajas_fd'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DecimalPlaces = 0
                  Properties.DisplayFormat = ',0;-,0'
                  FooterAlignmentHorz = taCenter
                  HeaderAlignmentHorz = taCenter
                  Width = 55
                end
                object tvKilos: TcxGridDBColumn
                  Caption = 'Kilogramos'
                  DataBinding.FieldName = 'kilos_fd'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DisplayFormat = ',0.00;-,0.00'
                  HeaderAlignmentHorz = taCenter
                end
                object tvPrecio: TcxGridDBColumn
                  Caption = 'Precio'
                  DataBinding.FieldName = 'precio_fd'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DecimalPlaces = 4
                  Properties.DisplayFormat = ',0.0000;-,0.0000'
                  HeaderAlignmentHorz = taCenter
                  Width = 40
                end
                object tvUnidadesFac: TcxGridDBColumn
                  Caption = 'Unidad'
                  DataBinding.FieldName = 'unidad_facturacion_fd'
                  HeaderAlignmentHorz = taCenter
                  Width = 56
                end
                object tvImporte: TcxGridDBColumn
                  Caption = 'Importe'
                  DataBinding.FieldName = 'importe_linea_fd'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DisplayFormat = ',0.00;-,0.00'
                  HeaderAlignmentHorz = taCenter
                  Width = 75
                end
                object tvDescuentos: TcxGridDBColumn
                  Caption = 'Imp. Descuento'
                  DataBinding.FieldName = 'importe_total_descuento_fd'
                  PropertiesClassName = 'TcxCalcEditProperties'
                  HeaderAlignmentHorz = taCenter
                  Options.Editing = False
                  Width = 82
                end
                object tvImporteNeto: TcxGridDBColumn
                  Caption = 'Importe Neto'
                  DataBinding.FieldName = 'importe_neto_fd'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DecimalPlaces = 2
                  Properties.DisplayFormat = ',0.00;-,0.00'
                  HeaderAlignmentHorz = taCenter
                  Width = 75
                end
                object tvPorImpuesto: TcxGridDBColumn
                  Caption = '% IVA'
                  DataBinding.FieldName = 'porcentaje_impuesto_fd'
                  HeaderAlignmentHorz = taCenter
                  Width = 40
                end
                object tvImpImpuesto: TcxGridDBColumn
                  Caption = 'Imp. IVA'
                  DataBinding.FieldName = 'importe_impuesto_fd'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DisplayFormat = ',0.00;-,0.00'
                  HeaderAlignmentHorz = taCenter
                  Width = 75
                end
                object tvImporteTotal: TcxGridDBColumn
                  Caption = 'Importe Total'
                  DataBinding.FieldName = 'importe_total_fd'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DisplayFormat = ',0.00;-,0.00'
                  HeaderAlignmentHorz = taCenter
                  Width = 75
                end
              end
              object lvDetalleLineas: TcxGridLevel
                GridView = tvDetalleLineas
              end
            end
          end
          object tsDetalleGastos: TcxTabSheet
            Caption = 'Detalle de Gastos'
            object cxGastos: TcxGrid
              Left = 0
              Top = 41
              Width = 971
              Height = 282
              Align = alClient
              BorderStyle = cxcbsNone
              TabOrder = 1
              LevelTabs.Images = DFactura.IFacturas2
              LookAndFeel.NativeStyle = False
              LookAndFeel.SkinName = 'Foggy'
              object tvDetalleGastos: TcxGridDBTableView
                Navigator.Buttons.CustomButtons = <>
                FilterBox.Visible = fvNever
                DataController.DataSource = dsQGasFactura
                DataController.Summary.DefaultGroupSummaryItems = <>
                DataController.Summary.FooterSummaryItems = <
                  item
                    Format = ',0.00;-,0.00'
                    Kind = skSum
                    FieldName = 'importe_impuesto_fg'
                    Column = tvGasImporteIva
                  end
                  item
                    Format = ',0.00;-,0.00'
                    Kind = skSum
                    FieldName = 'importe_neto_fg'
                    Column = tvGasImporteNeto
                  end
                  item
                    Format = ',0.00;-,0.00'
                    Kind = skSum
                    FieldName = 'importe_total_fg'
                    Column = tvGasImporteTotal
                  end>
                DataController.Summary.SummaryGroups = <>
                OptionsSelection.MultiSelect = True
                OptionsView.ColumnAutoWidth = True
                OptionsView.Footer = True
                OptionsView.GroupByBox = False
                object tvGasTipoGasto: TcxGridDBColumn
                  Caption = 'Tipo Gasto'
                  DataBinding.FieldName = 'cod_tipo_gasto_fg'
                  MinWidth = 64
                  Options.Editing = False
                  Width = 100
                end
                object tvGasDesGasto: TcxGridDBColumn
                  Caption = 'Descripcion'
                  DataBinding.FieldName = 'des_tipo_gasto_fg'
                  MinWidth = 64
                  Options.Editing = False
                  Width = 480
                end
                object tvGasImporteNeto: TcxGridDBColumn
                  Caption = 'Importe Neto'
                  DataBinding.FieldName = 'importe_neto_fg'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DisplayFormat = ',0.00;-,0.00'
                  MinWidth = 100
                  Options.Editing = False
                  Width = 110
                end
                object tvGasPorImpuesto: TcxGridDBColumn
                  Caption = '% IVA'
                  DataBinding.FieldName = 'porcentaje_impuesto_fg'
                  MinWidth = 64
                  Options.Editing = False
                end
                object tvGasImporteIva: TcxGridDBColumn
                  Caption = 'Importe IVA'
                  DataBinding.FieldName = 'importe_impuesto_fg'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DisplayFormat = ',0.00;-,0.00'
                  MinWidth = 100
                  Options.Editing = False
                  Width = 110
                end
                object tvGasImporteTotal: TcxGridDBColumn
                  Caption = 'Total'
                  DataBinding.FieldName = 'importe_total_fg'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DisplayFormat = ',0.00;-,0.00'
                  MinWidth = 100
                  Options.Editing = False
                  Width = 110
                end
              end
              object lvDetalleGastos: TcxGridLevel
                GridView = tvDetalleGastos
              end
            end
            object pnlDetGastos: TPanel
              Left = 0
              Top = 0
              Width = 971
              Height = 41
              Align = alTop
              TabOrder = 0
              object cxLabel7: TcxLabel
                Left = 15
                Top = 10
                AutoSize = False
                Caption = 'Empresa Albaran'
                Style.Edges = [bLeft, bTop, bRight, bBottom]
                Style.TextStyle = []
                Properties.Alignment.Horz = taLeftJustify
                Height = 17
                Width = 85
              end
              object edtGasCodEmpresaAlb: TcxDBTextEdit
                Left = 101
                Top = 8
                DataBinding.DataField = 'cod_empresa_albaran_fg'
                DataBinding.DataSource = dsQGasFactura
                Properties.CharCase = ecUpperCase
                Properties.MaxLength = 3
                Properties.OnChange = PonNombre
                TabOrder = 0
                Width = 30
              end
              object cxLabel8: TcxLabel
                Left = 337
                Top = 10
                AutoSize = False
                Caption = 'Centro Salida'
                Style.Edges = [bLeft, bTop, bRight, bBottom]
                Style.TextStyle = []
                Properties.Alignment.Horz = taLeftJustify
                Height = 17
                Width = 72
              end
              object edtGasCentroAlb: TcxDBTextEdit
                Left = 410
                Top = 8
                DataBinding.DataField = 'cod_centro_albaran_fg'
                DataBinding.DataSource = dsQGasFactura
                Properties.CharCase = ecUpperCase
                Properties.MaxLength = 3
                Properties.OnChange = PonNombre
                TabOrder = 2
                Width = 30
              end
              object cxLabel9: TcxLabel
                Left = 648
                Top = 10
                AutoSize = False
                Caption = 'Num. Albaran'
                Properties.Alignment.Horz = taLeftJustify
                Height = 17
                Width = 70
              end
              object edtGasNumeroAlb: TcxDBTextEdit
                Left = 719
                Top = 8
                DataBinding.DataField = 'n_albaran_fg'
                DataBinding.DataSource = dsQGasFactura
                TabOrder = 4
                Width = 60
              end
              object cxLabel10: TcxLabel
                Left = 792
                Top = 10
                AutoSize = False
                Caption = 'Fec. Albaran'
                Height = 17
                Width = 70
              end
              object edtGasFechaAlb: TcxDBDateEdit
                Left = 863
                Top = 9
                DataBinding.DataField = 'fecha_albaran_fg'
                DataBinding.DataSource = dsQGasFactura
                TabOrder = 5
                Width = 80
              end
              object txGasDesEmpresaAlb: TcxTextEdit
                Left = 133
                Top = 8
                TabStop = False
                Properties.ReadOnly = True
                Style.BorderStyle = ebsFlat
                Style.Color = clBtnFace
                Style.LookAndFeel.Kind = lfFlat
                Style.LookAndFeel.NativeStyle = False
                Style.LookAndFeel.SkinName = ''
                Style.Shadow = False
                Style.TransparentBorder = True
                StyleDisabled.LookAndFeel.Kind = lfFlat
                StyleDisabled.LookAndFeel.NativeStyle = False
                StyleDisabled.LookAndFeel.SkinName = ''
                StyleFocused.LookAndFeel.Kind = lfFlat
                StyleFocused.LookAndFeel.NativeStyle = False
                StyleFocused.LookAndFeel.SkinName = ''
                StyleHot.LookAndFeel.Kind = lfFlat
                StyleHot.LookAndFeel.NativeStyle = False
                StyleHot.LookAndFeel.SkinName = ''
                TabOrder = 1
                Width = 190
              end
              object txGasDesCentroAlb: TcxTextEdit
                Left = 442
                Top = 8
                TabStop = False
                Properties.ReadOnly = True
                Style.BorderStyle = ebsFlat
                Style.Color = clBtnFace
                Style.LookAndFeel.Kind = lfFlat
                Style.LookAndFeel.NativeStyle = False
                Style.LookAndFeel.SkinName = ''
                Style.Shadow = False
                Style.TransparentBorder = True
                StyleDisabled.LookAndFeel.Kind = lfFlat
                StyleDisabled.LookAndFeel.NativeStyle = False
                StyleDisabled.LookAndFeel.SkinName = ''
                StyleFocused.LookAndFeel.Kind = lfFlat
                StyleFocused.LookAndFeel.NativeStyle = False
                StyleFocused.LookAndFeel.SkinName = ''
                StyleHot.LookAndFeel.Kind = lfFlat
                StyleHot.LookAndFeel.NativeStyle = False
                StyleHot.LookAndFeel.SkinName = ''
                TabOrder = 3
                Width = 190
              end
            end
            object st1: TdxStatusBar
              Left = 0
              Top = 323
              Width = 971
              Height = 20
              Panels = <>
              PaintStyle = stpsUseLookAndFeel
              LookAndFeel.NativeStyle = False
              LookAndFeel.SkinName = 'Foggy'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
            end
          end
          object tsNotasFactura: TcxTabSheet
            Caption = 'Notas Factura'
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object mmxNotas: TcxDBMemo
              Left = 0
              Top = 0
              Align = alClient
              DataBinding.DataField = 'notas_fc'
              DataBinding.DataSource = dsQCabFactura
              Properties.ReadOnly = True
              Properties.ScrollBars = ssVertical
              Style.LookAndFeel.NativeStyle = False
              Style.LookAndFeel.SkinName = 'Foggy'
              StyleDisabled.LookAndFeel.NativeStyle = False
              StyleDisabled.LookAndFeel.SkinName = 'Foggy'
              StyleFocused.LookAndFeel.NativeStyle = False
              StyleFocused.LookAndFeel.SkinName = 'Foggy'
              StyleHot.LookAndFeel.NativeStyle = False
              StyleHot.LookAndFeel.SkinName = 'Foggy'
              TabOrder = 0
              Height = 343
              Width = 971
            end
          end
        end
        object gbCabecera: TcxGroupBox
          Left = 0
          Top = 0
          Align = alTop
          ParentBackground = False
          Style.Edges = [bLeft, bTop, bRight, bBottom]
          Style.LookAndFeel.Kind = lfUltraFlat
          Style.LookAndFeel.NativeStyle = False
          Style.LookAndFeel.SkinName = 'Foggy'
          Style.Shadow = False
          Style.TransparentBorder = True
          StyleDisabled.LookAndFeel.Kind = lfUltraFlat
          StyleDisabled.LookAndFeel.NativeStyle = False
          StyleDisabled.LookAndFeel.SkinName = 'Foggy'
          StyleFocused.LookAndFeel.Kind = lfUltraFlat
          StyleFocused.LookAndFeel.NativeStyle = False
          StyleFocused.LookAndFeel.SkinName = 'Foggy'
          StyleHot.LookAndFeel.Kind = lfUltraFlat
          StyleHot.LookAndFeel.NativeStyle = False
          StyleHot.LookAndFeel.SkinName = 'Foggy'
          TabOrder = 0
          Height = 163
          Width = 981
          object cxLabel5: TcxLabel
            Left = 369
            Top = 64
            Caption = 'Moneda'
          end
          object edtMoneda: TcxDBTextEdit
            Left = 414
            Top = 60
            DataBinding.DataField = 'moneda_fc'
            DataBinding.DataSource = dsQCabFactura
            Properties.CharCase = ecUpperCase
            Properties.MaxLength = 3
            Properties.OnChange = PonNombre
            TabOrder = 11
            Width = 30
          end
          object cxLabel2: TcxLabel
            Left = 15
            Top = 62
            AutoSize = False
            Caption = 'Cliente Fact.'
            Properties.Alignment.Horz = taLeftJustify
            Height = 17
            Width = 75
          end
          object edtCodClienteFac: TcxDBTextEdit
            Left = 91
            Top = 60
            DataBinding.DataField = 'cod_cliente_fc'
            DataBinding.DataSource = dsQCabFactura
            Properties.CharCase = ecUpperCase
            Properties.MaxLength = 3
            Properties.OnChange = PonNombre
            TabOrder = 7
            Width = 30
          end
          object cxLabel4: TcxLabel
            Left = 15
            Top = 86
            AutoSize = False
            Caption = 'Tipo Impuesto'
            Properties.Alignment.Horz = taLeftJustify
            Height = 17
            Width = 75
          end
          object edtTipoImpuesto: TcxDBTextEdit
            Left = 91
            Top = 82
            DataBinding.DataField = 'tipo_impuesto_fc'
            DataBinding.DataSource = dsQCabFactura
            Properties.CharCase = ecUpperCase
            Properties.MaxLength = 2
            Properties.OnChange = PonNombre
            TabOrder = 15
            Width = 30
          end
          object cxLabel6: TcxLabel
            Left = 779
            Top = 50
            AutoSize = False
            Caption = 'FACTURA'
            ParentColor = False
            ParentFont = False
            Style.BorderColor = clHotLight
            Style.BorderStyle = ebsUltraFlat
            Style.Color = clSkyBlue
            Style.Font.Charset = EASTEUROPE_CHARSET
            Style.Font.Color = clMenuBar
            Style.Font.Height = -19
            Style.Font.Name = 'MS Sans Serif'
            Style.Font.Style = []
            Style.LookAndFeel.Kind = lfUltraFlat
            Style.LookAndFeel.NativeStyle = False
            Style.LookAndFeel.SkinName = 'Caramel'
            Style.Shadow = True
            Style.TextStyle = []
            Style.TransparentBorder = False
            Style.IsFontAssigned = True
            StyleDisabled.LookAndFeel.Kind = lfUltraFlat
            StyleDisabled.LookAndFeel.NativeStyle = False
            StyleDisabled.LookAndFeel.SkinName = 'Caramel'
            StyleFocused.LookAndFeel.Kind = lfUltraFlat
            StyleFocused.LookAndFeel.NativeStyle = False
            StyleFocused.LookAndFeel.SkinName = 'Caramel'
            StyleHot.LookAndFeel.Kind = lfUltraFlat
            StyleHot.LookAndFeel.NativeStyle = False
            StyleHot.LookAndFeel.SkinName = 'Caramel'
            Properties.Alignment.Horz = taCenter
            Properties.Alignment.Vert = taVCenter
            Properties.LineOptions.OuterColor = clBtnText
            Height = 38
            Width = 121
            AnchorX = 840
            AnchorY = 69
          end
          object cxlb10: TcxLabel
            Left = 353
            Top = 84
            AutoSize = False
            Caption = 'Prevision Cobro'
            ParentFont = False
            Style.Font.Charset = DEFAULT_CHARSET
            Style.Font.Color = clWindowText
            Style.Font.Height = -11
            Style.Font.Name = 'MS Sans Serif'
            Style.Font.Style = [fsBold]
            Style.TextStyle = []
            Style.IsFontAssigned = True
            Properties.Alignment.Horz = taRightJustify
            Height = 17
            Width = 90
            AnchorX = 443
          end
          object edtPrevisionCobro: TcxDBTextEdit
            Left = 446
            Top = 82
            DataBinding.DataField = 'prevision_cobro_fc'
            DataBinding.DataSource = dsQCabFactura
            TabOrder = 17
            Width = 70
          end
          object cbFactContabilizada: TcxDBCheckBox
            Left = 715
            Top = 136
            Caption = 'Factura Contabilizada'
            DataBinding.DataField = 'contabilizado_fc'
            DataBinding.DataSource = dsQCabFactura
            Properties.Alignment = taLeftJustify
            Properties.NullStyle = nssUnchecked
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            Style.LookAndFeel.Kind = lfUltraFlat
            Style.LookAndFeel.NativeStyle = True
            Style.LookAndFeel.SkinName = 'Foggy'
            StyleDisabled.LookAndFeel.Kind = lfUltraFlat
            StyleDisabled.LookAndFeel.NativeStyle = True
            StyleDisabled.LookAndFeel.SkinName = 'Foggy'
            StyleFocused.LookAndFeel.Kind = lfUltraFlat
            StyleFocused.LookAndFeel.NativeStyle = True
            StyleFocused.LookAndFeel.SkinName = 'Foggy'
            StyleHot.LookAndFeel.Kind = lfUltraFlat
            StyleHot.LookAndFeel.NativeStyle = True
            StyleHot.LookAndFeel.SkinName = 'Foggy'
            TabOrder = 33
            Width = 133
          end
          object cxAnula: TcxLabel
            Left = 692
            Top = 87
            AutoSize = False
            Caption = 'Anula a'
            ParentColor = False
            ParentFont = False
            Style.BorderColor = clHotLight
            Style.BorderStyle = ebsUltraFlat
            Style.Color = clSkyBlue
            Style.Font.Charset = EASTEUROPE_CHARSET
            Style.Font.Color = clMenuBar
            Style.Font.Height = -12
            Style.Font.Name = 'MS Sans Serif'
            Style.Font.Style = [fsBold]
            Style.LookAndFeel.Kind = lfUltraFlat
            Style.LookAndFeel.NativeStyle = False
            Style.LookAndFeel.SkinName = 'Caramel'
            Style.Shadow = True
            Style.TextStyle = []
            Style.TransparentBorder = False
            Style.IsFontAssigned = True
            StyleDisabled.LookAndFeel.Kind = lfUltraFlat
            StyleDisabled.LookAndFeel.NativeStyle = False
            StyleDisabled.LookAndFeel.SkinName = 'Caramel'
            StyleFocused.LookAndFeel.Kind = lfUltraFlat
            StyleFocused.LookAndFeel.NativeStyle = False
            StyleFocused.LookAndFeel.SkinName = 'Caramel'
            StyleHot.LookAndFeel.Kind = lfUltraFlat
            StyleHot.LookAndFeel.NativeStyle = False
            StyleHot.LookAndFeel.SkinName = 'Caramel'
            Properties.Alignment.Horz = taCenter
            Properties.Alignment.Vert = taVCenter
            Properties.LineOptions.OuterColor = clBtnText
            Height = 19
            Width = 290
            AnchorX = 837
            AnchorY = 97
          end
          object cxEmpresa: TcxLabel
            Left = 15
            Top = 18
            AutoSize = False
            Caption = 'Empresa Fact.'
            Style.Edges = [bLeft, bTop, bRight, bBottom]
            Style.TextStyle = []
            Properties.Alignment.Horz = taLeftJustify
            Height = 17
            Width = 75
          end
          object edtCodEmpresaFac: TcxDBTextEdit
            Left = 91
            Top = 16
            DataBinding.DataField = 'cod_empresa_fac_fc'
            DataBinding.DataSource = dsQCabFactura
            Properties.CharCase = ecUpperCase
            Properties.MaxLength = 3
            Properties.OnChange = PonNombre
            StyleFocused.Color = clWindow
            TabOrder = 1
            Width = 30
          end
          object txDesEmpresaFac: TcxTextEdit
            Left = 123
            Top = 16
            TabStop = False
            Properties.ReadOnly = True
            Style.BorderStyle = ebsFlat
            Style.Color = clBtnFace
            Style.LookAndFeel.Kind = lfFlat
            Style.LookAndFeel.NativeStyle = False
            Style.LookAndFeel.SkinName = ''
            Style.Shadow = False
            Style.TransparentBorder = True
            StyleDisabled.LookAndFeel.Kind = lfFlat
            StyleDisabled.LookAndFeel.NativeStyle = False
            StyleDisabled.LookAndFeel.SkinName = ''
            StyleFocused.LookAndFeel.Kind = lfFlat
            StyleFocused.LookAndFeel.NativeStyle = False
            StyleFocused.LookAndFeel.SkinName = ''
            StyleHot.LookAndFeel.Kind = lfFlat
            StyleHot.LookAndFeel.NativeStyle = False
            StyleHot.LookAndFeel.SkinName = ''
            TabOrder = 2
            Width = 225
          end
          object cxLabel1: TcxLabel
            Left = 355
            Top = 18
            AutoSize = False
            Caption = 'N'#250'mero Factura'
            Properties.Alignment.Horz = taRightJustify
            Height = 17
            Width = 90
            AnchorX = 445
          end
          object edtFactura: TcxDBTextEdit
            Left = 446
            Top = 16
            DataBinding.DataField = 'n_factura_fc'
            DataBinding.DataSource = dsQCabFactura
            TabOrder = 3
            Width = 70
          end
          object cxLabel3: TcxLabel
            Left = 527
            Top = 18
            AutoSize = False
            Caption = 'Fecha Factura'
            Properties.Alignment.Horz = taRightJustify
            Height = 17
            Width = 80
            AnchorX = 607
          end
          object edtFechaFactura: TcxDBTextEdit
            Left = 609
            Top = 16
            DataBinding.DataField = 'fecha_factura_fc'
            DataBinding.DataSource = dsQCabFactura
            TabOrder = 4
            Width = 70
          end
          object txDesClienteFac: TcxTextEdit
            Left = 123
            Top = 60
            TabStop = False
            Properties.ReadOnly = True
            Style.BorderStyle = ebsFlat
            Style.Color = clBtnFace
            Style.LookAndFeel.Kind = lfFlat
            Style.LookAndFeel.NativeStyle = False
            Style.LookAndFeel.SkinName = ''
            Style.Shadow = False
            Style.TransparentBorder = True
            StyleDisabled.LookAndFeel.Kind = lfFlat
            StyleDisabled.LookAndFeel.NativeStyle = False
            StyleDisabled.LookAndFeel.SkinName = ''
            StyleFocused.LookAndFeel.Kind = lfFlat
            StyleFocused.LookAndFeel.NativeStyle = False
            StyleFocused.LookAndFeel.SkinName = ''
            StyleHot.LookAndFeel.Kind = lfFlat
            StyleHot.LookAndFeel.NativeStyle = False
            StyleHot.LookAndFeel.SkinName = ''
            TabOrder = 8
            Width = 225
          end
          object txDesTipoImpuesto: TcxTextEdit
            Left = 123
            Top = 82
            TabStop = False
            Properties.ReadOnly = True
            Style.BorderStyle = ebsFlat
            Style.Color = clBtnFace
            Style.LookAndFeel.Kind = lfFlat
            Style.LookAndFeel.NativeStyle = False
            Style.LookAndFeel.SkinName = ''
            Style.Shadow = False
            Style.TransparentBorder = True
            StyleDisabled.LookAndFeel.Kind = lfFlat
            StyleDisabled.LookAndFeel.NativeStyle = False
            StyleDisabled.LookAndFeel.SkinName = ''
            StyleFocused.LookAndFeel.Kind = lfFlat
            StyleFocused.LookAndFeel.NativeStyle = False
            StyleFocused.LookAndFeel.SkinName = ''
            StyleHot.LookAndFeel.Kind = lfFlat
            StyleHot.LookAndFeel.NativeStyle = False
            StyleHot.LookAndFeel.SkinName = ''
            TabOrder = 16
            Width = 225
          end
          object txDesMoneda: TcxTextEdit
            Left = 446
            Top = 60
            TabStop = False
            Properties.ReadOnly = True
            Style.BorderStyle = ebsFlat
            Style.Color = clBtnFace
            Style.LookAndFeel.Kind = lfFlat
            Style.LookAndFeel.NativeStyle = False
            Style.LookAndFeel.SkinName = ''
            Style.Shadow = False
            Style.TransparentBorder = True
            StyleDisabled.LookAndFeel.Kind = lfFlat
            StyleDisabled.LookAndFeel.NativeStyle = False
            StyleDisabled.LookAndFeel.SkinName = ''
            StyleFocused.LookAndFeel.Kind = lfFlat
            StyleFocused.LookAndFeel.NativeStyle = False
            StyleFocused.LookAndFeel.SkinName = ''
            StyleHot.LookAndFeel.Kind = lfFlat
            StyleHot.LookAndFeel.NativeStyle = False
            StyleHot.LookAndFeel.SkinName = ''
            TabOrder = 12
            Width = 234
          end
          object pnl1: TPanel
            Left = 730
            Top = 8
            Width = 217
            Height = 41
            TabOrder = 0
            object cxLabel18: TcxLabel
              Left = 11
              Top = 11
              AutoSize = False
              Caption = 'C'#243'digo Factura'
              ParentFont = False
              Style.Font.Charset = DEFAULT_CHARSET
              Style.Font.Color = clWindowText
              Style.Font.Height = -11
              Style.Font.Name = 'MS Sans Serif'
              Style.Font.Style = [fsBold]
              Style.IsFontAssigned = True
              Properties.Alignment.Horz = taRightJustify
              Height = 17
              Width = 90
              AnchorX = 101
            end
            object edCodFactura: TcxDBTextEdit
              Left = 103
              Top = 9
              TabStop = False
              DataBinding.DataField = 'cod_factura_fc'
              DataBinding.DataSource = dsQCabFactura
              ParentFont = False
              Properties.Alignment.Horz = taCenter
              Style.Font.Charset = DEFAULT_CHARSET
              Style.Font.Color = clWindowText
              Style.Font.Height = -11
              Style.Font.Name = 'MS Sans Serif'
              Style.Font.Style = [fsBold]
              Style.TextStyle = []
              Style.IsFontAssigned = True
              TabOrder = 0
              Width = 100
            end
          end
          object cxLabel23: TcxLabel
            Left = 294
            Top = 130
            AutoSize = False
            Caption = 'TOTAL FACTURA'
            ParentFont = False
            Style.Font.Charset = DEFAULT_CHARSET
            Style.Font.Color = clWindowText
            Style.Font.Height = -11
            Style.Font.Name = 'MS Sans Serif'
            Style.Font.Style = [fsBold]
            Style.IsFontAssigned = True
            Properties.Alignment.Horz = taRightJustify
            Height = 17
            Width = 110
            AnchorX = 404
          end
          object cxImporteNeto: TcxDBCurrencyEdit
            Left = 408
            Top = 128
            AutoSize = False
            DataBinding.DataField = 'importe_neto_fc'
            DataBinding.DataSource = dsQCabFactura
            Properties.DisplayFormat = ',0.00;-,0.00'
            TabOrder = 20
            Height = 21
            Width = 80
          end
          object cxImporteImpuesto: TcxDBCurrencyEdit
            Left = 504
            Top = 128
            AutoSize = False
            DataBinding.DataField = 'importe_impuesto_fc'
            DataBinding.DataSource = dsQCabFactura
            Properties.DisplayFormat = ',0.00;-,0.00'
            TabOrder = 21
            Height = 21
            Width = 80
          end
          object cxImporteTotal: TcxDBCurrencyEdit
            Left = 600
            Top = 128
            AutoSize = False
            DataBinding.DataField = 'importe_total_fc'
            DataBinding.DataSource = dsQCabFactura
            Properties.DisplayFormat = ',0.00;-,0.00'
            TabOrder = 23
            Height = 21
            Width = 80
          end
          object cxLabel30: TcxLabel
            Left = 406
            Top = 113
            Caption = 'Base'
            ParentFont = False
            Style.Font.Charset = DEFAULT_CHARSET
            Style.Font.Color = clWindowText
            Style.Font.Height = -11
            Style.Font.Name = 'MS Sans Serif'
            Style.Font.Style = [fsBold]
            Style.IsFontAssigned = True
          end
          object cxLabel31: TcxLabel
            Left = 502
            Top = 113
            Caption = 'Cuota'
            ParentFont = False
            Style.Font.Charset = DEFAULT_CHARSET
            Style.Font.Color = clWindowText
            Style.Font.Height = -11
            Style.Font.Name = 'MS Sans Serif'
            Style.Font.Style = [fsBold]
            Style.IsFontAssigned = True
          end
          object cxLabel32: TcxLabel
            Left = 597
            Top = 113
            Caption = 'Total'
            ParentFont = False
            Style.Font.Charset = DEFAULT_CHARSET
            Style.Font.Color = clWindowText
            Style.Font.Height = -11
            Style.Font.Name = 'MS Sans Serif'
            Style.Font.Style = [fsBold]
            Style.IsFontAssigned = True
          end
          object cxlbl1: TcxLabel
            Left = 518
            Top = 84
            AutoSize = False
            Caption = 'Previsi'#243'n Tesoreria'
            ParentFont = False
            Style.Font.Charset = DEFAULT_CHARSET
            Style.Font.Color = clWindowText
            Style.Font.Height = -11
            Style.Font.Name = 'MS Sans Serif'
            Style.Font.Style = [fsBold]
            Style.TextStyle = []
            Style.IsFontAssigned = True
            Properties.Alignment.Horz = taRightJustify
            Height = 17
            Width = 93
            AnchorX = 611
          end
          object cxdbtxtdtprevision_cobro_fc: TcxDBTextEdit
            Left = 610
            Top = 82
            DataBinding.DataField = 'prevision_tesoreria_fc'
            DataBinding.DataSource = dsQCabFactura
            TabOrder = 18
            Width = 70
          end
          object cxLabel34: TcxLabel
            Left = 15
            Top = 40
            AutoSize = False
            Caption = 'Serie Fact.'
            Style.Edges = [bLeft, bTop, bRight, bBottom]
            Style.TextStyle = []
            Properties.Alignment.Horz = taLeftJustify
            Height = 17
            Width = 75
          end
          object edtCodSerieFac: TcxDBTextEdit
            Left = 91
            Top = 38
            DataBinding.DataField = 'cod_serie_fac_fc'
            DataBinding.DataSource = dsQCabFactura
            Properties.CharCase = ecUpperCase
            Properties.MaxLength = 3
            Properties.OnChange = PonNombre
            StyleFocused.Color = clWindow
            TabOrder = 6
            Width = 30
          end
          object cbNumRegistroAcuerdo: TcxDBCheckBox
            Left = 715
            Top = 112
            Caption = 'N'#250'm. de registro acuerdo comercial'
            DataBinding.DataField = 'es_reg_acuerdo_fc'
            DataBinding.DataSource = dsQCabFactura
            Properties.Alignment = taLeftJustify
            Properties.NullStyle = nssUnchecked
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            TabOrder = 19
            Width = 256
          end
        end
      end
    end
    object dpRelacionFacturas: TdxDockPanel
      Left = 0
      Top = 0
      Width = 185
      Height = 393
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ManagerColor = False
      ManagerFont = False
      Visible = False
      AllowFloating = True
      AutoHide = True
      Caption = 'Relacion de Facturas'
      CaptionButtons = []
      CustomCaptionButtons.Buttons = <>
      TabsProperties.CustomButtons.Buttons = <>
      AutoHidePosition = 1
      DockingType = 2
      OriginalWidth = 185
      OriginalHeight = 393
      object cxFacturas: TcxGrid
        Left = 0
        Top = 0
        Width = 0
        Height = 359
        Align = alClient
        TabOrder = 0
        LookAndFeel.NativeStyle = False
        LookAndFeel.SkinName = 'Foggy'
        object tvRelFacturas: TcxGridDBTableView
          OnDblClick = tvRelFacturasDblClick
          Navigator.Buttons.CustomButtons = <>
          FilterBox.Visible = fvNever
          DataController.DataSource = dsQCabFactura
          DataController.KeyFieldNames = 'cod_factura_fc'
          DataController.Summary.DefaultGroupSummaryItems = <
            item
              Kind = skCount
              Position = spFooter
              Column = tvCabImporteNeto
            end
            item
              Kind = skMax
              Column = tvCabImporteNeto
            end>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = '#,0.00'
              Kind = skSum
              FieldName = 'importe_neto_fc'
              Column = tvCabImporteNeto
              DisplayText = 'Importe Neto'
            end
            item
              Format = '#,0.00'
              Kind = skSum
              FieldName = 'importe_impuesto_fc'
              Column = tvCabImporteImpuesto
              DisplayText = 'Imp. Impuesto'
            end
            item
              Format = '#,0.00'
              Kind = skSum
              FieldName = 'importe_total_fc'
              Column = tvCabImporteTotal
              DisplayText = 'TOTAL'
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.HideSelection = True
          OptionsSelection.MultiSelect = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object tvCabCodEmpresa: TcxGridDBColumn
            Caption = 'Empresa'
            DataBinding.FieldName = 'cod_empresa_fac_fc'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            MinWidth = 50
            SortIndex = 0
            SortOrder = soAscending
            Width = 50
          end
          object tvCabSerEmpresa: TcxGridDBColumn
            Caption = 'Serie'
            DataBinding.FieldName = 'cod_serie_fac_fc'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            SortIndex = 1
            SortOrder = soAscending
            Width = 50
          end
          object tvDesEmpFactura: TcxGridDBColumn
            Caption = 'Descripci'#243'n'
            DataBinding.ValueType = 'String'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Options.Editing = False
            Width = 130
          end
          object tvCabNumFactura: TcxGridDBColumn
            Caption = 'Factura'
            DataBinding.FieldName = 'n_factura_fc'
            HeaderAlignmentHorz = taCenter
            SortIndex = 3
            SortOrder = soAscending
            Width = 60
          end
          object tvCabFecFactura: TcxGridDBColumn
            Caption = 'Fec. Factura'
            DataBinding.FieldName = 'fecha_factura_fc'
            PropertiesClassName = 'TcxDateEditProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            SortIndex = 2
            SortOrder = soAscending
            Width = 90
          end
          object tvCabTipoFac: TcxGridDBColumn
            DataBinding.FieldName = 'tipo_factura_fc'
            Visible = False
            IsCaptionAssigned = True
          end
          object tvCabDesTipoFac: TcxGridDBColumn
            Caption = 'Tipo Factura'
            DataBinding.ValueType = 'String'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 64
          end
          object tvCabAutomatica: TcxGridDBColumn
            DataBinding.FieldName = 'automatica_fc'
            Visible = False
          end
          object tvCabDesAutomatica: TcxGridDBColumn
            Caption = 'M / A'
            DataBinding.ValueType = 'String'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 90
          end
          object tvCabCodCliente: TcxGridDBColumn
            Caption = 'Cliente'
            DataBinding.FieldName = 'cod_cliente_fc'
            HeaderAlignmentHorz = taCenter
            MinWidth = 45
            Width = 45
          end
          object tvCabDesCliente: TcxGridDBColumn
            Caption = 'Descripcion'
            DataBinding.FieldName = 'des_cliente_fc'
            MinWidth = 64
            Width = 150
          end
          object tvCabMoneda: TcxGridDBColumn
            Caption = 'Moneda'
            DataBinding.FieldName = 'moneda_fc'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            MinWidth = 50
            Width = 50
          end
          object tvCabImporteNeto: TcxGridDBColumn
            Caption = 'Importe Neto'
            DataBinding.FieldName = 'importe_neto_fc'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00 ;-,0.00'
            HeaderAlignmentHorz = taCenter
            MinWidth = 80
            Width = 80
          end
          object tvCabDesTipoImpuesto: TcxGridDBColumn
            Caption = 'Tipo. Impuesto'
            DataBinding.FieldName = 'des_tipo_impuesto_fc'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            MinWidth = 50
            SortIndex = 4
            SortOrder = soDescending
            Width = 50
          end
          object tvCabImporteImpuesto: TcxGridDBColumn
            Caption = 'Impuesto'
            DataBinding.FieldName = 'importe_impuesto_fc'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00 ;-,0.00'
            HeaderAlignmentHorz = taCenter
            MinWidth = 80
            Width = 80
          end
          object tvCabImporteTotal: TcxGridDBColumn
            Caption = 'Importe Total'
            DataBinding.FieldName = 'importe_total_fc'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00 ;-,0.00'
            MinWidth = 80
            Width = 80
          end
        end
        object lvRelFacturas: TcxGridLevel
          GridView = tvRelFacturas
        end
      end
    end
  end
  object bmxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Herramientas'
      'Imprimir')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      False
      True)
    ImageOptions.Images = DFactura.IFacturas
    ImageOptions.LargeImages = DFactura.IFacturas
    LookAndFeel.Kind = lfStandard
    LookAndFeel.NativeStyle = False
    LookAndFeel.SkinName = 'Blue'
    PopupMenuLinks = <>
    ShowShortCutInHint = True
    UseSystemFont = True
    Left = 680
    Top = 8
    DockControlHeights = (
      0
      0
      38
      0)
    object bmPrincipal: TdxBar
      BorderStyle = bbsNone
      Caption = 'Herramientas'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 1654
      FloatTop = 162
      FloatClientWidth = 0
      FloatClientHeight = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      Images = DFactura.IFacturas
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxLocalizar'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxPrimero'
        end
        item
          Visible = True
          ItemName = 'dxAnterior'
        end
        item
          Visible = True
          ItemName = 'dxSiguiente'
        end
        item
          Visible = True
          ItemName = 'dxUltimo'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxImprimir'
        end
        item
          Visible = True
          ItemName = 'dxbrsbtm1'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxAlta'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBaja'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxMod'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxSalir'
        end>
      OneOnRow = True
      Row = 0
      ShowMark = False
      UseOwnFont = True
      Visible = True
      WholeRow = False
    end
    object dxLocalizar: TdxBarLargeButton
      Caption = 'Localizar'
      Category = 0
      Hint = 'Consulta de Facturas'
      Visible = ivAlways
      LargeImageIndex = 9
      OnClick = dxLocalizarClick
      AutoGrayScale = False
      Width = 75
      SyncImageIndex = False
      ImageIndex = 9
    end
    object dxPrimero: TdxBarLargeButton
      Caption = 'Primero'
      Category = 0
      Hint = 'Primero'
      Visible = ivAlways
      LargeImageIndex = 5
      OnClick = dxPrimeroClick
      AutoGrayScale = False
      Width = 60
      SyncImageIndex = False
      ImageIndex = 5
    end
    object dxAnterior: TdxBarLargeButton
      Caption = 'Anterior'
      Category = 0
      Hint = 'Registro Anterior'
      Visible = ivAlways
      LargeImageIndex = 8
      OnClick = dxAnteriorClick
      AutoGrayScale = False
      Width = 60
    end
    object dxSiguiente: TdxBarLargeButton
      Caption = 'Siguiente'
      Category = 0
      Hint = 'Registro Siguiente'
      Visible = ivAlways
      LargeImageIndex = 7
      OnClick = dxSiguienteClick
      AutoGrayScale = False
      Width = 60
    end
    object dxUltimo: TdxBarLargeButton
      Caption = 'Ultimo'
      Category = 0
      Hint = 'Ultimo Registro'
      Visible = ivAlways
      LargeImageIndex = 6
      OnClick = dxUltimoClick
      AutoGrayScale = False
      Width = 60
    end
    object dxImprimir: TdxBarLargeButton
      Caption = 'Imprimir'
      Category = 0
      Hint = 'Imprimir Factura'
      Visible = ivAlways
      LargeImageIndex = 2
      OnClick = dxImprimirClick
      AutoGrayScale = False
      Width = 60
    end
    object dxAlta: TdxBarLargeButton
      Caption = 'Alta'
      Category = 0
      Hint = 'Alta Registro'
      Visible = ivAlways
      LargeImageIndex = 12
      OnClick = dxAltaClick
      AutoGrayScale = False
      Width = 60
    end
    object dxBaja: TdxBarLargeButton
      Caption = 'Borrar'
      Category = 0
      Hint = 'Borrar Factura'
      Visible = ivAlways
      LargeImageIndex = 13
      OnClick = dxBajaClick
      AutoGrayScale = False
      Width = 60
      SyncImageIndex = False
      ImageIndex = 13
    end
    object dxMod: TdxBarLargeButton
      Caption = 'Modificar'
      Category = 0
      Hint = 'Modificar'
      Visible = ivAlways
      LargeImageIndex = 16
      OnClick = dxModClick
      AutoGrayScale = False
      SyncImageIndex = False
      ImageIndex = 16
    end
    object dxSalir: TdxBarLargeButton
      Caption = 'Salir'
      Category = 0
      Hint = 'Salir'
      Visible = ivAlways
      LargeImageIndex = 14
      OnClick = dxSalirClick
      AutoGrayScale = False
      Width = 60
    end
    object dxbrsbtm1: TdxBarSubItem
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'mnuPrevisualizarAlbaranes'
        end
        item
          Visible = True
          ItemName = 'mnuImprimirAlbaranes'
        end
        item
          Visible = True
          ItemName = 'btnFacturaDeposito'
        end>
    end
    object mnuPrevisualizarAlbaranes: TdxBarButton
      Caption = 'Previsualizar Albaranes'
      Category = 0
      Hint = 'Previsualizar Albaranes'
      Visible = ivAlways
      OnClick = mnuPrevisualizarAlbaranesClick
    end
    object mnuImprimirAlbaranes: TdxBarButton
      Caption = 'Imprimir Albaranes'
      Category = 0
      Hint = 'Imprimir Albaranes'
      Visible = ivAlways
      OnClick = mnuImprimirAlbaranesClick
    end
    object btnFacturaDeposito: TdxBarButton
      Caption = 'Factura Deposito'
      Category = 0
      Hint = 'Factura Deposito'
      Visible = ivAlways
      OnClick = mnuFacturasDeposito
    end
    object dxbrbtnImprimeAlbaran: TdxBarButton
      Caption = 'New Item'
      Category = 1
      Hint = 'New Item'
      Visible = ivAlways
    end
  end
  object gpmRelFacturas: TcxGridPopupMenu
    PopupMenus = <>
    Left = 838
    Top = 7
  end
  object dxDockingManager1: TdxDockingManager
    Color = clBtnFace
    DefaultHorizContainerSiteProperties.CustomCaptionButtons.Buttons = <>
    DefaultHorizContainerSiteProperties.Dockable = True
    DefaultHorizContainerSiteProperties.ImageIndex = -1
    DefaultVertContainerSiteProperties.CustomCaptionButtons.Buttons = <>
    DefaultVertContainerSiteProperties.Dockable = True
    DefaultVertContainerSiteProperties.ImageIndex = -1
    DefaultTabContainerSiteProperties.ManagerColor = False
    DefaultTabContainerSiteProperties.CustomCaptionButtons.Buttons = <>
    DefaultTabContainerSiteProperties.Dockable = True
    DefaultTabContainerSiteProperties.ImageIndex = -1
    DefaultTabContainerSiteProperties.TabsProperties.CustomButtons.Buttons = <>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    LookAndFeel.NativeStyle = False
    LookAndFeel.SkinName = 'Foggy'
    Left = 763
    Top = 8
    PixelsPerInch = 96
  end
  object dsQCabFactura: TDataSource
    OnDataChange = dsQCabFacturaDataChange
    Left = 757
    Top = 38
  end
  object dsQDetFactura: TDataSource
    OnDataChange = dsQDetFacturaDataChange
    Left = 797
    Top = 38
  end
  object dsQGasFactura: TDataSource
    OnDataChange = dsQGasFacturaDataChange
    Left = 837
    Top = 38
  end
  object dsQBasFactura: TDataSource
    Left = 877
    Top = 40
  end
  object dsQRemesas: TDataSource
    Left = 915
    Top = 41
  end
  object ActionList: TActionList
    Left = 714
    Top = 39
    object actCancelar: TAction
      Caption = 'Cancelar'
      ShortCut = 27
      OnExecute = actCancelarExecute
    end
    object actLocalizar: TAction
      Caption = 'Localizar'
      ShortCut = 76
      OnExecute = actLocalizarExecute
    end
    object actAlta: TAction
      Caption = 'Alta'
      ShortCut = 187
      OnExecute = actAltaExecute
    end
  end
  object BEFacturas: TBusquedaExperta
    Titulo = 'Consulta de Facturas Venta'
    Tablas = 
      'tfacturas_cab left join tfacturas_det on cod_factura_fd = cod_fa' +
      'ctura_fc '
    Campos = <
      item
        Etiqueta = 'Empresa'
        Campo = 'cod_empresa_fac_fc'
        Tipo = ctCadena
        Lupa = True
        SSTitulo = 'Busqueda de Empresa'
        SSTabla = 'frf_empresas'
        SSCampoResultado = 'empresa_e'
        SSCampos = <
          item
            Etiqueta = 'Empresa'
            Campo = 'empresa_e'
            Ancho = 100
            Tipo = ctCadena
          end
          item
            Etiqueta = 'Descripci'#243'n'
            Campo = 'nombre_e'
            Ancho = 400
            Tipo = ctCadena
          end>
        SSReferencias = <>
        SSConcatenar = True
      end
      item
        Etiqueta = 'Cliente'
        Campo = 'cod_cliente_fc'
        Tipo = ctCadena
        Lupa = True
        SSTitulo = 'Busqueda de Clientes'
        SSTabla = 'frf_clientes'
        SSCampoResultado = 'cliente_c'
        SSCampos = <
          item
            Etiqueta = 'Cliente'
            Campo = 'cliente_c'
            Ancho = 100
            Tipo = ctCadena
          end
          item
            Etiqueta = 'Descripci'#243'n'
            Campo = 'nombre_c'
            Ancho = 400
            Tipo = ctCadena
          end>
        SSReferencias = <
          item
            ReferenciaBE = 'cod_empresa_fac_fc'
            ReferenciaSS = 'empresa_c'
          end>
        SSConcatenar = True
      end
      item
        Etiqueta = 'Fecha Factura'
        Campo = 'fecha_factura_fc'
        Tipo = ctFecha
        Lupa = False
        SSCampos = <>
        SSReferencias = <>
        SSConcatenar = False
      end
      item
        Etiqueta = 'Numero Factura'
        Campo = 'n_factura_fc'
        Tipo = ctNumero
        Lupa = False
        SSCampos = <>
        SSReferencias = <>
        SSConcatenar = False
      end
      item
        Etiqueta = 'Codigo Factura'
        Campo = 'cod_factura_fc'
        Tipo = ctCadena
        Lupa = False
        SSCampos = <>
        SSReferencias = <>
        SSConcatenar = False
      end
      item
        Etiqueta = 'Producto'
        Campo = 'cod_producto_fd'
        Tipo = ctCadena
        Lupa = True
        SSTitulo = 'Busqueda de Productos'
        SSTabla = 'frf_productos'
        SSCampoResultado = 'producto_p'
        SSCampos = <
          item
            Etiqueta = 'Producto'
            Campo = 'producto_p'
            Ancho = 100
            Tipo = ctCadena
          end
          item
            Etiqueta = 'Descripcion'
            Campo = 'descripcion_p'
            Ancho = 400
            Tipo = ctCadena
          end>
        SSReferencias = <
          item
            ReferenciaBE = 'cod_empresa_fac_fc'
            ReferenciaSS = 'empresa_p'
          end>
        SSConcatenar = True
      end
      item
        Etiqueta = 'Envase'
        Campo = 'cod_envase_fd'
        Tipo = ctCadena
        Lupa = True
        SSTitulo = 'Busqueda de Envases'
        SSTabla = 'frf_envases'
        SSCampoResultado = 'envase_e'
        SSCampos = <
          item
            Etiqueta = 'Envase'
            Campo = 'envase_e'
            Ancho = 100
            Tipo = ctCadena
          end
          item
            Etiqueta = 'Descripcion'
            Campo = 'descripcion_e'
            Ancho = 400
            Tipo = ctCadena
          end>
        SSReferencias = <
          item
            ReferenciaBE = 'cod_empresa_fac_fc'
            ReferenciaSS = 'empresa_e'
          end>
        SSConcatenar = True
      end
      item
        Etiqueta = 'Importe Total'
        Campo = 'importe_total_fc'
        Tipo = ctNumero
        Lupa = False
        SSCampos = <>
        SSReferencias = <>
        SSConcatenar = False
      end
      item
        Etiqueta = 'Fact. Cont. (0/1)'
        Campo = 'contabilizado_fc'
        Tipo = ctNumero
        Lupa = False
        SSCampos = <>
        SSReferencias = <>
        SSConcatenar = False
      end
      item
        Etiqueta = 'Fecha Cont.'
        Campo = 'fecha_conta_fc'
        Tipo = ctFecha
        Lupa = False
        SSCampos = <>
        SSReferencias = <>
        SSConcatenar = False
      end
      item
        Etiqueta = 'Fact. Anuladas (0/1)'
        Campo = 'anulacion_fc'
        Tipo = ctNumero
        Lupa = False
        SSCampos = <>
        SSReferencias = <>
        SSConcatenar = False
      end
      item
        Etiqueta = 'Empresa Albaran'
        Campo = 'cod_empresa_albaran_fd'
        Tipo = ctCadena
        Lupa = False
        SSCampos = <>
        SSReferencias = <>
        SSConcatenar = False
      end
      item
        Etiqueta = 'Centro Albaran'
        Campo = 'cod_centro_albaran_fd'
        Tipo = ctCadena
        Lupa = False
        SSCampos = <>
        SSReferencias = <>
        SSConcatenar = False
      end
      item
        Etiqueta = 'Numero Albaran'
        Campo = 'n_albaran_fd'
        Tipo = ctNumero
        Lupa = False
        SSCampos = <>
        SSReferencias = <>
        SSConcatenar = False
      end
      item
        Etiqueta = 'Fecha Albaran'
        Campo = 'fecha_albaran_fd'
        Tipo = ctFecha
        Lupa = False
        SSCampos = <>
        SSReferencias = <>
        SSConcatenar = False
      end
      item
        Etiqueta = 'Serie'
        Campo = 'cod_serie_fac_fc'
        Tipo = ctCadena
        Lupa = False
        SSTitulo = 'Busqueda Serie'
        SSTabla = 'frf_empresas_serie'
        SSCampoResultado = 'cod_serie_es'
        SSCampos = <>
        SSReferencias = <
          item
            ReferenciaBE = 'cod_empresa_fac_fc'
            ReferenciaSS = 'cod_empresa_es'
          end>
        SSConcatenar = False
      end
      item
        Etiqueta = 'N'#250'm. registro acuerdo'
        Campo = 'es_reg_acuerdo_fc'
        Tipo = ctNumero
        Lupa = False
        SSCampos = <>
        SSReferencias = <>
        SSConcatenar = False
      end>
    Restringido = True
    Left = 964
    Top = 40
  end
end
