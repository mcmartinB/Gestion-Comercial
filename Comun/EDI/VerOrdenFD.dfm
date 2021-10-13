object FDVerOrden: TFDVerOrden
  Left = 378
  Top = 288
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = '  VER DATOS DE LA ORDEN DE CARGA'
  ClientHeight = 310
  ClientWidth = 936
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 936
    Height = 41
    Align = alTop
    TabOrder = 0
    object btnDesadv: TButton
      Left = 700
      Top = 11
      Width = 111
      Height = 21
      Caption = 'Desadv'
      TabOrder = 0
      TabStop = False
      OnClick = btnDesadvClick
    end
    object btnSalir: TButton
      Left = 815
      Top = 11
      Width = 111
      Height = 21
      Caption = 'Salir'
      TabOrder = 1
      TabStop = False
      OnClick = btnSalirClick
    end
  end
  object dbgrdCa: TDBGrid
    Left = 0
    Top = 41
    Width = 936
    Height = 64
    Align = alTop
    DataSource = dsCab
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'orden_carga'
        Title.Caption = 'N'#186' Orden'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'hora_carga'
        Title.Caption = 'Hora'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cliente'
        Title.Caption = 'Cliente'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'suministro'
        Title.Caption = 'Plataforma'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'n_pedido'
        Title.Caption = 'N'#186' Pedido'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'fecha_pedido'
        Title.Caption = 'Fecha Pedido'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'departamento'
        Title.Caption = 'Departamento'
        Visible = True
      end>
  end
  object dbgrdLin: TDBGrid
    Left = 0
    Top = 105
    Width = 936
    Height = 205
    Align = alClient
    DataSource = dsLin
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ean128_pl'
        Title.Caption = 'Ean128'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descripcion_tp'
        Title.Caption = 'Palet'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'producto_pl'
        Title.Caption = 'Producto'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cajas_pl'
        Title.Caption = 'Cajas'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'envase_pl'
        Title.Caption = 'Envase'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ean13_pl'
        Title.Caption = 'Ean13'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descripcion_e'
        Title.Caption = 'Envase'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'lote'
        Title.Caption = 'Lote'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'caducidad'
        Title.Caption = 'Caducidad'
        Visible = True
      end>
  end
  object qryCabOrden: TQuery
    AfterOpen = qryCabOrdenAfterOpen
    BeforeClose = qryCabOrdenBeforeClose
    DatabaseName = 'BDProyecto'
    Left = 30
    Top = 21
  end
  object dsCab: TDataSource
    DataSet = qryCabOrden
    Left = 72
    Top = 24
  end
  object qryPacking: TQuery
    DatabaseName = 'BDProyecto'
    DataSource = dsCab
    Left = 33
    Top = 63
  end
  object dsLin: TDataSource
    DataSet = qryPacking
    Left = 72
    Top = 72
  end
end
