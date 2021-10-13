object DMLFacturasPendientesX3: TDMLFacturasPendientesX3
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 733
  Top = 242
  Height = 296
  Width = 434
  object QFacturas: TQuery
    DatabaseName = 'dbMaster'
    Left = 120
    Top = 104
  end
  object kbmListado: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    Version = '4.08b'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 48
    Top = 24
  end
  object qryPedido: TQuery
    DatabaseName = 'BDProyecto'
    Left = 201
    Top = 111
  end
  object kbmClientes: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    Version = '4.08b'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 144
    Top = 24
  end
end
