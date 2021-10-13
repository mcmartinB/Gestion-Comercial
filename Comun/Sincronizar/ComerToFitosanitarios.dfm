object DMComerToFitosanitarios: TDMComerToFitosanitarios
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 408
  Width = 785
  object qryPlantacion: TQuery
    DatabaseName = 'BDProyecto'
    Left = 48
    Top = 200
  end
  object conFito: TADOConnection
    ConnectionString = 
      'Provider=MSDASQL.1;Password=$lynx$;Persist Security Info=True;Us' +
      'er ID=root;Data Source=GesFit;Initial Catalog=crud'
    LoginPrompt = False
    Provider = 'MSDASQL.1'
    Left = 40
    Top = 48
  end
  object qrySelectUE: TADOQuery
    Connection = conFito
    CursorLocation = clUseServer
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from campo')
    Left = 112
    Top = 40
  end
  object qryInsertUE: TADOQuery
    Connection = conFito
    CursorLocation = clUseServer
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from campo')
    Left = 192
    Top = 40
  end
  object qryCodigoUE: TADOQuery
    Connection = conFito
    CursorLocation = clUseServer
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from campo')
    Left = 112
    Top = 96
  end
  object qryTipoCultivo: TADOQuery
    Connection = conFito
    CursorLocation = clUseServer
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from campo')
    Left = 200
    Top = 96
  end
end
