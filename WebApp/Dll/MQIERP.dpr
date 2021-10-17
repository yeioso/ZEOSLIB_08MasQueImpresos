library MQIERP;

uses
  FastMM4,
  IWRtlFix,
  IWJclStackTrace,
  IWJclDebug,
  IWInitISAPI,
  IW.Isapi.ThreadPool,
  UserSessionUnit in '..\Shared\Forms_IW\UserSessionUnit.pas' {IWUserSession: TIWUserSessionBase},
  ServerController in '..\Shared\Forms_IW\ServerController.pas' {IWServerController: TIWServerControllerBase};

{$R *.RES}

exports
  GetExtensionVersion,
  HttpExtensionProc,
  TerminateExtension;

begin
  IWRun;
end.
