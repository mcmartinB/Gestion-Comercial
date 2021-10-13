object FSincroWeb: TFSincroWeb
  OldCreateOrder = False
  OnCreate = ServiceCreate
  DisplayName = 'SincroWeb'
  AfterInstall = ServiceAfterInstall
  OnExecute = ServiceExecute
  Height = 288
  Width = 363
end
