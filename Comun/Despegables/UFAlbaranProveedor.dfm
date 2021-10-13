object FAlbaranProveedor: TFAlbaranProveedor
  Left = 797
  Top = 271
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = ' Seleccione albar'#225'n ...'
  ClientHeight = 261
  ClientWidth = 342
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid: TDBGrid
    Left = 0
    Top = 0
    Width = 342
    Height = 261
    Align = alClient
    DataSource = DataSource
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = DBGridDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'empresa'
        Title.Caption = 'Empresa'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'proveedor'
        Title.Caption = 'Proveedor'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'albaran'
        Title.Caption = 'Albar'#225'n'
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'fecha_carga'
        Title.Caption = 'Fecha Carga'
        Width = 76
        Visible = True
      end>
  end
  object Query: TQuery
    DatabaseName = 'BDProyecto'
    Left = 220
    Top = 48
  end
  object DataSource: TDataSource
    AutoEdit = False
    DataSet = Query
    Left = 188
    Top = 48
  end
end
