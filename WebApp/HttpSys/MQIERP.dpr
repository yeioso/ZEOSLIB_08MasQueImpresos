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
  {$IFDEF DEBUG}
  TIWStartHSys.Execute(True);
  {$ELSE}
  TIWStartHSys.Execute(False);
  {$ENDIF}
end.
