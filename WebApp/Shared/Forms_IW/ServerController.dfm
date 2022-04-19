object IWServerController: TIWServerController
  OldCreateOrder = False
  OnCreate = IWServerControllerBaseCreate
  OnDestroy = IWServerControllerBaseDestroy
  AppName = 'ASE_MQI'
  ComInitialization = ciMultiThreaded
  Compression.Level = 6
  Description = 'ASE WEB SERVICE '
  DebugHTML = True
  DisplayName = 'ASE - MQI'
  Port = 8888
  SSLOptions.SSLVersion = SSLv3
  Version = '15.2.53'
  IECompatibilityMode = 'IE=8'
  ExceptionLogger.PurgeAfterDays = 10
  LogCommandEnabled = False
  SessionOptions.SessionTimeout = 45
  SessionOptions.RestartExpiredSession = True
  OnCloseSession = IWServerControllerBaseCloseSession
  OnConfig = IWServerControllerBaseConfig
  OnException = IWServerControllerBaseException
  OnNewSession = IWServerControllerBaseNewSession
  OnBind = IWServerControllerBaseBind
  Height = 310
  Width = 342
  object Pool: TIWDataModulePool
    Active = False
    Version = '2.1.0'
    RaiseExceptions = True
    AutoGrow = False
    GrowToSize = 100
    PoolCount = 20
    Left = 60
    Top = 20
  end
end
