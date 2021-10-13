object FLSalidasSuministro: TFLSalidasSuministro
  Left = 708
  Top = 254
  ActiveControl = edtEmpresa
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '    SALIDAS POR CENTRO SUMINISTRO'
  ClientHeight = 324
  ClientWidth = 484
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
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object lblEmpresa: TnbLabel
    Left = 32
    Top = 17
    Width = 97
    Height = 21
    Caption = 'Empresa'
    About = 'NB 0.1/20020725'
  end
  object etqEmpresa: TnbStaticText
    Left = 167
    Top = 17
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
  end
  object lblSumnistro: TnbLabel
    Left = 32
    Top = 67
    Width = 97
    Height = 21
    Caption = 'Centro Suministro'
    About = 'NB 0.1/20020725'
  end
  object etqSuministro: TnbStaticText
    Left = 167
    Top = 67
    Width = 134
    Height = 21
    About = 'NB 0.1/20020725'
  end
  object lblCliente: TnbLabel
    Left = 32
    Top = 42
    Width = 97
    Height = 21
    Caption = 'Cliente'
    About = 'NB 0.1/20020725'
  end
  object etqCliente: TnbStaticText
    Left = 167
    Top = 42
    Width = 190
    Height = 21
    About = 'NB 0.1/20020725'
  end
  object Label1: TLabel
    Left = 308
    Top = 71
    Width = 69
    Height = 13
    Caption = 'Vacio = Todos'
  end
  object lblEspere: TLabel
    Left = 56
    Top = 137
    Width = 374
    Height = 13
    Caption = 'POR FAVOR ESPERE MIENTRAS SE REALIZAN LOS CALCULOS'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object edtEmpresa: TBEdit
    Left = 132
    Top = 17
    Width = 32
    Height = 21
    ColorEdit = clMoneyGreen
    Zeros = True
    MaxLength = 3
    TabOrder = 0
    OnChange = edtEmpresaChange
  end
  object edtSuministro: TBEdit
    Left = 132
    Top = 67
    Width = 32
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 3
    TabOrder = 2
    OnChange = edtSuministroChange
  end
  object edtCliente: TBEdit
    Left = 132
    Top = 42
    Width = 32
    Height = 21
    ColorEdit = clMoneyGreen
    MaxLength = 3
    TabOrder = 1
    OnChange = edtClienteChange
  end
  object PanelInf: TPanel
    Left = 0
    Top = 264
    Width = 484
    Height = 60
    Align = alBottom
    TabOrder = 4
    DesignSize = (
      484
      60)
    object btnAceptar: TSpeedButton
      Left = 292
      Top = 17
      Width = 88
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Listado'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF000000FF0000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF000000FF000000FFBF0000FF00000000BFFF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF000000FF000000FFBF0000FF00000000BFFF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF000000FF000000FF000000FFBF0000FF000000FFBF00000000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF000000FF000000FFBF0000FF000000FFBF0000FF000000FFBF00000000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007F7F
        7F000000FF3F0000FFBF00000000FF00FF000000FF000000FFBF0000FF000000
        00BFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007F7F7F000000
        FF3F00000000FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000
        00BFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000
        FFBF00000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF000000
        FFBF00000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
        FF000000FF00000000BFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF007F7F7F000000FF3F00000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF007F7F7F000000FF3F000000BFFF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF000000FF000000FF00000000BFFF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnAceptarClick
    end
    object btnCancelar: TSpeedButton
      Left = 381
      Top = 17
      Width = 89
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Cerrar'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FFBFFF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FFFFFF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00000000000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0000000000FFFFFF00FF00FFBFFF00FF00FF00
        FF00FF00FF00000000000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
        FF00FF00FF00FF00FF0000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00000000000000000000000000FFFFFF00FF00FFBFFF00
        FF00FF00FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FFFFFF00FF00
        FFBF0000000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
        000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000000000000000
        0000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
        000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FFFFFF00FF00
        FFBF00000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000000000000000000000000000FFFFFF00FF00FFBFFF00
        FF00FF00FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00FFBFFF00
        FF0000000000000000000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
        FF00FF00FF00FF00FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00
        FF000000000000000000FFFFFF00FF00FFBFFF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF000000000000000000FFFFFF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnCancelarClick
    end
    object btnAExcel: TSpeedButton
      Left = 203
      Top = 17
      Width = 88
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Guardar'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF007F7F
        7F00000000007F7F7F007F7F7F007F7F7F0000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000BFBFBF007F7F
        7F00000000007F7F7F00000000000000000000000000FF00FF00FF00FF00FF00
        FF00FF00FF007F7F7F00000000007F7F7F00FF00FF0000000000000000000000
        00007F7F7F007F7F7F0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00000000007F7F7F00000000000000000000000000BFBFBF00BFBF
        BF007F7F7F0000000000000000007F7F7F00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF007F7F7F0000000000000000007F7F7F007F7F7F007F7F7F000000
        000000000000000000007F7F7F0000000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00000000007F7F7F007F7F7F00000000007F7F7F000000
        0000FF00FF007F7F7F00000000007F7F7F00FF00FF00FF00FF00FF00FF00FF00
        FF00000000000000000000000000BFBFBF00000000007F7F7F00000000000000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00000000007F7F7F007F7F7F00BFBFBF0000000000BFBFBF00FF00FF00FF00
        FF00FF00FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
        FF00000000000000000000000000BFBFBF00000000007F7F7F00000000007F7F
        7F00FF00FF00000000007F7F7F0000000000FF00FF007F7F7F00000000007F7F
        7F00FF00FF00FF00FF00000000007F7F7F00BFBFBF00000000007F7F7F000000
        000000000000000000007F7F7F000000000000000000000000007F7F7F000000
        0000FF00FF007F7F7F0000000000000000007F7F7F00BFBFBF00000000000000
        00007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F0000000000000000007F7F
        7F00FF00FF00000000007F7F7F00000000000000000000000000000000007F7F
        7F007F7F7F000000000000000000000000007F7F7F007F7F7F0000000000FF00
        FF00FF00FF007F7F7F00000000007F7F7F00FF00FF000000000000000000BFBF
        BF00000000007F7F7F007F7F7F007F7F7F00000000007F7F7F00000000000000
        000000000000FF00FF00FF00FF00FF00FF00FF00FF00000000007F7F7F00BFBF
        BF0000000000BFBFBF00000000007F7F7F00000000007F7F7F007F7F7F007F7F
        7F0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000BFBF
        BF00000000007F7F7F00BFBFBF007F7F7F00000000007F7F7F00000000000000
        000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000007F7F
        7F00BFBFBF000000000000000000000000007F7F7F007F7F7F0000000000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnAceptarClick
    end
  end
  object pgPageControl: TPageControl
    Left = 0
    Top = 157
    Width = 484
    Height = 107
    ActivePage = tsPorDias
    Align = alBottom
    TabOrder = 3
    TabWidth = 75
    object tsPorPeriodo: TTabSheet
      Caption = 'Por Periodo'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lblPorPeriodoDesde: TnbLabel
        Left = 36
        Top = 12
        Width = 110
        Height = 21
        Caption = 'Fecha  Desde'
        About = 'NB 0.1/20020725'
      end
      object lblPorPeriodoHasta: TnbLabel
        Left = 232
        Top = 12
        Width = 20
        Height = 21
        Caption = 'al'
        About = 'NB 0.1/20020725'
      end
      object edtPorPeriodoDesde: TBEdit
        Left = 149
        Top = 12
        Width = 65
        Height = 21
        ColorEdit = clMoneyGreen
        InputType = itDate
        TabOrder = 0
      end
      object edtPorPeriodoHasta: TBEdit
        Left = 259
        Top = 12
        Width = 65
        Height = 21
        ColorEdit = clMoneyGreen
        InputType = itDate
        TabOrder = 1
      end
    end
    object tsPorAnyos: TTabSheet
      Caption = 'Por A'#241'os'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lblAnyoHasta: TnbLabel
        Left = 232
        Top = 12
        Width = 20
        Height = 21
        Caption = 'al'
        About = 'NB 0.1/20020725'
      end
      object lblAnyoDesde: TnbLabel
        Left = 36
        Top = 12
        Width = 110
        Height = 21
        Caption = 'A'#241'o Desde'
        About = 'NB 0.1/20020725'
      end
      object lblFormatoAnyo: TLabel
        Left = 316
        Top = 16
        Width = 68
        Height = 13
        Caption = 'Formato: aaaa'
      end
      object lblPorAnyoDesde: TnbLabel
        Left = 36
        Top = 40
        Width = 110
        Height = 21
        Caption = 'Fecha  Desde'
        About = 'NB 0.1/20020725'
      end
      object lblPorAnyoHasta: TnbLabel
        Left = 232
        Top = 40
        Width = 20
        Height = 21
        Caption = 'al'
        About = 'NB 0.1/20020725'
      end
      object edtAnyoDesde: TBEdit
        Left = 149
        Top = 12
        Width = 52
        Height = 21
        ColorEdit = clMoneyGreen
        InputType = itInteger
        MaxLength = 4
        TabOrder = 0
        OnChange = edtAnyoDesdeChange
      end
      object edtAnyoHasta: TBEdit
        Left = 259
        Top = 12
        Width = 52
        Height = 21
        ColorEdit = clMoneyGreen
        InputType = itInteger
        MaxLength = 4
        TabOrder = 1
        OnChange = edtAnyoHastaChange
      end
      object edtPorAnyoDesde: TBEdit
        Left = 149
        Top = 40
        Width = 65
        Height = 21
        ColorEdit = clMoneyGreen
        InputType = itDate
        Enabled = False
        TabOrder = 3
        OnChange = edtPorAnyoDesdeChange
      end
      object edtPorAnyoHasta: TBEdit
        Left = 259
        Top = 40
        Width = 65
        Height = 21
        ColorEdit = clMoneyGreen
        InputType = itDate
        Enabled = False
        TabOrder = 4
        OnChange = edtPorAnyoHastaChange
      end
      object rbPorAnyo: TRadioButton
        Left = 15
        Top = 14
        Width = 17
        Height = 17
        Checked = True
        TabOrder = 2
        TabStop = True
        OnClick = rbPorAnyoClick
      end
      object rbAnyo: TRadioButton
        Left = 15
        Top = 42
        Width = 17
        Height = 17
        TabOrder = 5
        OnClick = rbPorAnyoClick
      end
    end
    object tsPorMeses: TTabSheet
      Caption = 'Por Meses'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lblPorMesDesde: TnbLabel
        Left = 36
        Top = 40
        Width = 110
        Height = 21
        Caption = 'Fecha  Desde'
        About = 'NB 0.1/20020725'
      end
      object lblMesDesde: TnbLabel
        Left = 36
        Top = 12
        Width = 110
        Height = 21
        Caption = 'A'#241'o/Semana Desde'
        About = 'NB 0.1/20020725'
      end
      object lblPorMesHasta: TnbLabel
        Left = 232
        Top = 40
        Width = 20
        Height = 21
        Caption = 'al'
        About = 'NB 0.1/20020725'
      end
      object lblMesHasta: TnbLabel
        Left = 232
        Top = 12
        Width = 20
        Height = 21
        Caption = 'al'
        About = 'NB 0.1/20020725'
      end
      object lblFormatoAnyoMes: TLabel
        Left = 316
        Top = 16
        Width = 84
        Height = 13
        Caption = 'Formato: aaaamm'
      end
      object edtPorMesDesde: TBEdit
        Left = 149
        Top = 40
        Width = 65
        Height = 21
        ColorEdit = clMoneyGreen
        InputType = itDate
        Enabled = False
        TabOrder = 3
        OnChange = edtPorMesDesdeChange
      end
      object edtMesDesde: TBEdit
        Left = 149
        Top = 12
        Width = 52
        Height = 21
        ColorEdit = clMoneyGreen
        InputType = itInteger
        MaxLength = 6
        TabOrder = 0
        OnChange = edtMesDesdeChange
      end
      object edtPorMesHasta: TBEdit
        Left = 259
        Top = 40
        Width = 65
        Height = 21
        ColorEdit = clMoneyGreen
        InputType = itDate
        Enabled = False
        TabOrder = 4
        OnChange = edtPorMesHastaChange
      end
      object edtMesHasta: TBEdit
        Left = 259
        Top = 12
        Width = 52
        Height = 21
        ColorEdit = clMoneyGreen
        InputType = itInteger
        MaxLength = 6
        TabOrder = 1
        OnChange = edtMesHastaChange
      end
      object rbPorMes: TRadioButton
        Left = 15
        Top = 14
        Width = 17
        Height = 17
        Checked = True
        TabOrder = 2
        TabStop = True
        OnClick = rbPorMesClick
      end
      object rbMes: TRadioButton
        Left = 15
        Top = 42
        Width = 17
        Height = 17
        TabOrder = 5
        OnClick = rbPorMesClick
      end
    end
    object tsPorSemanas: TTabSheet
      Caption = 'Por Semanas'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lblPorSemanasDesde: TnbLabel
        Left = 36
        Top = 40
        Width = 110
        Height = 21
        Caption = 'Fecha  Desde'
        About = 'NB 0.1/20020725'
      end
      object lblSemanaDesde: TnbLabel
        Left = 36
        Top = 12
        Width = 110
        Height = 21
        Caption = 'A'#241'o/Semana Desde'
        About = 'NB 0.1/20020725'
      end
      object lblPorSemanaHasta: TnbLabel
        Left = 232
        Top = 40
        Width = 20
        Height = 21
        Caption = 'al'
        About = 'NB 0.1/20020725'
      end
      object lblSemanaHasta: TnbLabel
        Left = 232
        Top = 12
        Width = 20
        Height = 21
        Caption = 'al'
        About = 'NB 0.1/20020725'
      end
      object lblFormatoAnyoSemana: TLabel
        Left = 316
        Top = 16
        Width = 78
        Height = 13
        Caption = 'Formato: aaaass'
      end
      object edtPorSemanaDesde: TBEdit
        Left = 149
        Top = 40
        Width = 65
        Height = 21
        ColorEdit = clMoneyGreen
        InputType = itDate
        Enabled = False
        TabOrder = 3
        OnChange = edtPorSemanaDesdeChange
      end
      object edtSemanaDesde: TBEdit
        Left = 149
        Top = 12
        Width = 52
        Height = 21
        ColorEdit = clMoneyGreen
        InputType = itInteger
        MaxLength = 6
        TabOrder = 0
        OnChange = edtSemanaDesdeChange
      end
      object edtPorSemanaHasta: TBEdit
        Left = 259
        Top = 40
        Width = 65
        Height = 21
        ColorEdit = clMoneyGreen
        InputType = itDate
        Enabled = False
        TabOrder = 4
        OnChange = edtPorSemanaHastaChange
      end
      object edtSemanaHasta: TBEdit
        Left = 259
        Top = 12
        Width = 52
        Height = 21
        ColorEdit = clMoneyGreen
        InputType = itInteger
        MaxLength = 6
        TabOrder = 1
        OnChange = edtSemanaHastaChange
      end
      object rbPorSemana: TRadioButton
        Left = 15
        Top = 14
        Width = 17
        Height = 17
        Checked = True
        TabOrder = 2
        TabStop = True
        OnClick = rbPorSemanaClick
      end
      object rbSemana: TRadioButton
        Left = 15
        Top = 42
        Width = 17
        Height = 17
        TabOrder = 5
        OnClick = rbPorSemanaClick
      end
    end
    object tsPorDias: TTabSheet
      Caption = 'Por D'#237'as'
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lblPorDiasDesde: TnbLabel
        Left = 36
        Top = 12
        Width = 110
        Height = 21
        Caption = 'Fecha  Desde'
        About = 'NB 0.1/20020725'
      end
      object lblPorDiasHasta: TnbLabel
        Left = 232
        Top = 12
        Width = 20
        Height = 21
        Caption = 'al'
        About = 'NB 0.1/20020725'
      end
      object lblDias: TLabel
        Left = 175
        Top = 45
        Width = 24
        Height = 13
        Caption = 'd'#237'as.'
      end
      object edtPorDiaDesde: TBEdit
        Left = 149
        Top = 12
        Width = 65
        Height = 21
        ColorEdit = clMoneyGreen
        InputType = itDate
        TabOrder = 0
      end
      object edtPorDiaHasta: TBEdit
        Left = 259
        Top = 12
        Width = 65
        Height = 21
        ColorEdit = clMoneyGreen
        InputType = itDate
        TabOrder = 1
      end
      object chkPedido: TCheckBox
        Left = 36
        Top = 43
        Width = 97
        Height = 17
        Caption = 'A'#241'adir pedidos'
        TabOrder = 2
        OnClick = chkPedidoClick
      end
      object edtDiasPedido: TBEdit
        Left = 149
        Top = 41
        Width = 22
        Height = 21
        ColorEdit = clMoneyGreen
        InputType = itInteger
        Enabled = False
        MaxLength = 2
        TabOrder = 3
      end
    end
  end
end
