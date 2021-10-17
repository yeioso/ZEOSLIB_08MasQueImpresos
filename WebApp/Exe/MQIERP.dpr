program MQIERP;

uses
  IWRtlFix,
  IWJclStackTrace,
  IWJclDebug,
  Forms,
  IWStart,
  UserSessionUnit in '..\Shared\Forms_IW\UserSessionUnit.pas' {IWUserSession: TIWUserSessionBase},
  ServerController in '..\Shared\Forms_IW\ServerController.pas' {IWServerController: TIWServerControllerBase},
  UtilsIW.Numero_Siguiente in '..\Shared\Utils\UtilsIW.Numero_Siguiente.pas';

begin
  TIWStart.Execute(True);
end.
