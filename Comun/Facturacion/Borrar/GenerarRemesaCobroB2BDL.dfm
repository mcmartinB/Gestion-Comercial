object DLGenerarRemesaCobroB2B: TDLGenerarRemesaCobroB2B
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 558
  Top = 239
  Height = 256
  Width = 369
  object qryAux: TQuery
    DatabaseName = 'BDProyecto'
    Left = 32
    Top = 24
  end
  object qryFacturas: TQuery
    DatabaseName = 'BDProyecto'
    Left = 112
    Top = 24
  end
  object qryOrdenante: TQuery
    DatabaseName = 'BDProyecto'
    Left = 200
    Top = 24
  end
  object dlgSave: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Ficheros de Texto | *.txt|*.txt'
    Left = 272
    Top = 24
  end
  object kmtGiros: TkbmMemTable
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
    Left = 32
    Top = 80
  end
end
