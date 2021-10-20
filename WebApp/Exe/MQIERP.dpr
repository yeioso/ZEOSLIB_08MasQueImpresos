program MQIERP;

uses
  IWRtlFix,
  IWJclStackTrace,
  IWJclDebug,
  Forms,
  IWStart,
  UserSessionUnit in '..\Shared\Forms_IW\UserSessionUnit.pas' {IWUserSession: TIWUserSessionBase},
  ServerController in '..\Shared\Forms_IW\ServerController.pas' {IWServerController: TIWServerControllerBase};

begin
  TIWStart.Execute(True);
end.
