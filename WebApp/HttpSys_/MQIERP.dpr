program MQIERP;

uses
  FastMM4,
  IWRtlFix,
  IWJclStackTrace,
  IWJclDebug,
  IWStartHSys,
  ServerController in '..\Shared\Forms_IW\ServerController.pas' {IWServerController: TIWServerControllerBase},
  UserSessionUnit in '..\Shared\Forms_IW\UserSessionUnit.pas' {IWUserSession: TIWUserSessionBase};

{$R *.res}

begin
  TIWStartHSys.Execute(True);
end.
