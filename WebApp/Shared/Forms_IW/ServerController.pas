unit ServerController;

interface

uses
  SysUtils, Classes, IWServerControllerBase, IWBaseForm, HTTPApp,
  // For OnNewSession Event
  UserSessionUnit, IWApplication, IWAppForm, IW.Browser.Browser,
  IW.HTTP.Request, IW.HTTP.Reply, UtilsIW.Cfg, IWDataModulePool, UtConexion,
  Generics.Collections;

Const
  Const_Version = 'Versión 2022.04.22 Rev 1.0 - Delphi Syndey 10.4 (Community) - Intraweb 15.2.53';
  Const_Max_Record = 2000;

Type
  TIWServerController = class(TIWServerControllerBase)
    Pool: TIWDataModulePool;
    procedure IWServerControllerBaseNewSession(ASession: TIWApplication);
    procedure IWServerControllerBaseConfig(Sender: TObject);
    procedure IWServerControllerBaseCreate(Sender: TObject);
    procedure IWServerControllerBaseException(AApplication: TIWApplication;  AException: Exception; var Handled: Boolean);
    procedure IWServerControllerBaseCloseSession(aSession: TIWApplication);
    procedure IWServerControllerBaseDestroy(Sender: TObject);
    procedure IWServerControllerBaseBind(const aHttpBindings,
      aHttpsBindings: TStrings);
  private
     FDB : TDB;
     FCNX : TConexion;
     FPATH_LOG  : String;
     FCONNECTED : Boolean;
     FPATH_CACHE  : String;
     FPATH_FILES  : String;
     FPATH_CONFIG : String;
     Procedure Prepare_Container;
  public
    Property DB          : TDB      Read FDB         ;
    Property PATH_LOG    : String   Read FPATH_LOG   ;
    Property CONNECTED   : Boolean  Read FCONNECTED  ;
    Property PATH_FILES  : String   Read FPATH_FILES ;
    Property PATH_CACHE  : String   Read FPATH_CACHE ;
    Property PATH_CONFIG : String   Read FPATH_CONFIG;
    Procedure Close_Session(ASession: TIWApplication);
    Function CountSessions : Integer;
    Function Session_Active(Const pAuthUse : String; Var pIP : String)  : Boolean;
    Function GetPassword_Items(Const pCodigo_Usuario : String; Var pNombre, pEmail, pPassword, pError : string) : Boolean;
  end;

  function UserSession: TIWUserSession;
  function IWServerController: TIWServerController;

implementation

{$R *.dfm}

uses
  IWInit,
  IWGlobal,
  UtFuncion,
  Form_IWLogin,
  Criptografia,
  IW.Common.AppInfo,
  TBL000.Info_Tabla,
  UtilsIW.ManagerLog,
  TBL001.Create_Tabla;

function IWServerController: TIWServerController;
begin
  Try
    Result := TIWServerController(GServerController);
  Except
    On E: Exception Do
      Utils_ManagerLog_Add('ServerController', 'IWServerController', 'TIWServerController', E.Message);
  End;
end;

function UserSession: TIWUserSession;
begin
  Result := Nil;
  Try
    If Assigned(WebApplication) And Assigned(WebApplication.Data) Then
      Result := TIWUserSession(WebApplication.Data);
  Except
    On E: Exception Do
      Utils_ManagerLog_Add('ServerController', 'UserSession', 'TIWUserSession', E.Message);
  End;
end;

procedure TIWServerController.IWServerControllerBaseBind(const aHttpBindings, aHttpsBindings: TStrings);
begin
  aHttpBindings.Add('http://+:8888/MQIERP/');
end;

procedure TIWServerController.IWServerControllerBaseCloseSession(aSession: TIWApplication);
begin
  TFrIWLogin.SetAsMainForm;
end;

procedure TIWServerController.IWServerControllerBaseConfig(Sender: TObject);
Var
  lPath : String;
begin
  Try
    lPath := IncludeTrailingPathDelimiter(TIWAppInfo.GetAppPath);
//  lPath := IncludeTrailingBackslash(ExtractFilePath(GetModuleName(HInstance)));
    Utils_ManagerLog_Add('ServerController', 'TIWServerController', 'IWServerControllerBaseConfig', 'Cargando ruta de trabajo: ' + lPath);

    Self.FPATH_LOG    := IncludeTrailingPathDelimiter(lPath + 'log');
    ForceDirectories(Self.FPATH_LOG);

    Self.FPATH_FILES  := IncludeTrailingPathDelimiter(lPath + 'files');
    ForceDirectories(Self.FPATH_FILES);

    Self.FPATH_CONFIG := IncludeTrailingPathDelimiter(lPath + 'config');
    ForceDirectories(Self.FPATH_CONFIG);

    Self.FPATH_CACHE := IncludeTrailingPathDelimiter(lPath + 'cache');
    ForceDirectories(Self.FPATH_CACHE);

    lPath := IncludeTrailingPathDelimiter(Self.FPATH_CACHE);
    lPath := IncludeTrailingPathDelimiter(lPath + FormatDateTime('YYYYMMDD', Now));
    lPath := IncludeTrailingPathDelimiter(lPath + FormatDateTime('HHNNSSZZ', Now));
    ForceDirectories(lPath);
    Self.CacheDir := lPath;
    Self.ExceptionLogger.Enabled := True;
    Self.ExceptionLogger.FilePath := Self.FPATH_LOG;
    Self.ExceptionLogger.FileName := ChangeFileExt(ExtractFileName(TIWAppInfo.GetAppFullFileName), '.log');
    Utils_ManagerLog_Add('ServerController', 'TIWServerController', 'IWServerControllerBaseConfig', 'Cargando ruta de configuraci�n: ' + lPath);
  Except
    On E: Exception Do
      Utils_ManagerLog_Add('ServerController', 'TIWServerController', 'IWServerControllerBaseConfig',  E.Message);
  End;
end;

Function TIWServerController.GetPassword_Items(Const pCodigo_Usuario : String; Var pNombre, pEmail, pPassword, pError : string) : Boolean;
Var
  lHash : String;
  lPassword : String;
Begin
  Result := False;
  pError := '';
  Try
    FCNX.AUX.Active := False;
    FCNX.AUX.SQL.Clear;
    FCNX.AUX.SQL.Add(' SELECT * FROM ' + Info_TablaGet(Id_TBL_Usuario).Name + ' ' + FCNX.No_Lock);
    FCNX.AUX.SQL.Add(' WHERE ID_ACTIVO = ' + QuotedStr(Trim('S')));
    FCNX.AUX.SQL.Add('  AND ');
    FCNX.AUX.SQL.Add('  ( ');
    FCNX.AUX.SQL.Add('      ' + FCNX.Trim_Sentence('CODIGO_USUARIO') + ' = ' + QuotedStr(Trim(pCodigo_Usuario)));
    FCNX.AUX.SQL.Add('  OR  ' + FCNX.Trim_Sentence('EMAIL') + ' = ' + QuotedStr(Trim(pEmail)));
    FCNX.AUX.SQL.Add('  ) ');
    FCNX.AUX.Active := True;
    If FCNX.AUX.Active And (FCNX.AUX.RecordCount > 0) Then
    Begin
      If Not Vacio(FCNX.AUX.FieldByName('EMAIL').AsString) Then
      Begin
        If Not Vacio(FCNX.AUX.FieldByName('CONTRASENA').AsString) Then
        Begin
          lPassword := RetornarDecodificado(Const_KEY, FCNX.AUX.FieldByName('CONTRASENA').AsString, lHash);
          pEmail := LowerCase(Trim(FCNX.AUX.FieldByName('EMAIL').AsString));
          pNombre := Trim(FCNX.AUX.FieldByName('NOMBRE').AsString);
          If Not Vacio(lPassword) Then
          Begin
            pPassword := Trim(lPassword);
            Result := True;
          End
          Else
            pError := 'No es posible definir la contrase�a almacenada';
        End
        Else
          pError := 'No tiene una contrase�a asociada, por favor comuniquese con el personal de soporte';
      End
      Else
        pError := 'El identificador no tiene asociado un correo electronico, por favor comuniquese con el personal de soporte';
    End
    Else
      pError := 'No hay usuario asociado a ese identificador o se encuentra inactivo';
    FCNX.AUX.Active := False;
    FCNX.AUX.SQL.Clear;
  Except
    On E : Exception Do
      Utils_ManagerLog_Add('ServerController', 'TIWServerController', 'GetPassword_Items',  E.Message);
  End;
End;


Procedure TIWServerController.Prepare_Container;
Begin
  Self.FCONNECTED := False;
  Try
    FCNX := TConexion.Create(Nil);
    FCNX.SetConnection  (Conn_SQLSERVER      );
    FCNX.SetServer      (Self.DB.ServerName  );
    FCNX.SetDatabase    (Self.DB.DatabaseName);
    FCNX.SetUser        (Self.DB.UserName    );
    FCNX.SetPassword    (Self.DB.Password    );
    FCNX.SetDLL_DATABASE(Self.DB.DLL_DATABASE);
    Self.FCONNECTED := FCNX.Connect(True);
    If Self.FCONNECTED Then
    Begin
      TBL000_Info_Tabla_Init;
      If Not TBL001_Create_Tabla_CheckTables(FCNX) Then
        Utils_ManagerLog_Add('ServerController', 'TIWServerController', 'Prepare_Container', 'No es posible establecer el ambiente de las tablas');
    End
    Else
      Utils_ManagerLog_Add('ServerController', 'TIWServerController', 'Prepare_Container', 'No es posible conectarse a la base de datos');
  Except
    On E: Exception Do
      Utils_ManagerLog_Add('ServerController', 'TIWServerController', 'Prepare_Container', E.Message);
  End;
End;

procedure TIWServerController.IWServerControllerBaseCreate(Sender: TObject);
Var
  lPath : String;
begin
  FormatSettings.ShortDateFormat := 'yyyy-mm-dd';
  FCNX := TConexion.Create(Nil);
  lPath := IncludeTrailingPathDelimiter(TIWAppInfo.GetAppPath);
  FPATH_LOG := IncludeTrailingPathDelimiter(lPath + 'Log');
  FPATH_FILES := IncludeTrailingPathDelimiter(lPath + 'Files');
  FPATH_CONFIG := IncludeTrailingPathDelimiter(lPath + 'Config');
  Utils_ManagerLog_Add('ServerController', 'TIWServerController', 'IWServerControllerBaseCreate', 'Cargando el archivo de configuracion de ' + FPATH_CONFIG);
  If Not DirectoryExists(FPATH_LOG) Then
    ForceDirectories(FPATH_LOG);

  If Not DirectoryExists(FPATH_FILES) Then
    ForceDirectories(FPATH_FILES);

  If Not DirectoryExists(FPATH_CONFIG) Then
    ForceDirectories(FPATH_CONFIG);

  If UtilsIW_Cfg_Load(FDB, FPATH_CONFIG) Then
  Begin
    SetCurrentDir(FPATH_CONFIG);
    Prepare_Container;
  End
  Else
  Begin
    Utils_ManagerLog_Add('ServerController', 'TIWServerController', 'IWServerControllerBaseCreate', 'No existe el archivo de configuracion de ' + FPATH_CONFIG);
  End;
end;

procedure TIWServerController.IWServerControllerBaseDestroy(Sender: TObject);
begin
  If Assigned(FCNX) Then
  Begin
//    If FCNX.Connected Then
//      FCNX.Connect(False);
//    FreeAndNil(FCNX);
  End;

end;

procedure TIWServerController.IWServerControllerBaseException(AApplication: TIWApplication; AException: Exception; var Handled: Boolean);
begin
  Utils_ManagerLog_Add('ServerController', 'TIWServerController', 'IWServerControllerBaseException', AException.Message);
end;

Procedure TIWServerController.Close_Session(ASession: TIWApplication);
Var
  lI : integer;
  App : TIWApplication;
  lSessionList: TStringList;
Begin
  Try
    App := Nil;
    lSessionList := TStringList.Create;
    GSessions.GetList(lSessionList);
    Try
      For lI := 0 to LSessionList.Count - 1 Do
      begin
        gSessions.Execute(LSessionList[lI],procedure(aSession: TObject)
                        var
                          LSession : TIWApplication absolute aSession;
                        begin
                          If Not Assigned(App) Then
                            If ASession = LSession Then
                              App := LSession;

                        end
                       );
      End;
    Except
      On E: Exception Do
      Begin
        Utils_ManagerLog_Add('ServerController', 'TIWServerController', 'TIWServerController.Close_Session', E.Message);
      End;
    End;
  Finally
    If Assigned(lSessionList) Then
    Begin
      lSessionList.Clear;
      FreeAndNil(lSessionList);
    End;
  End;
End;

procedure TIWServerController.IWServerControllerBaseNewSession(ASession: TIWApplication);
Begin
  If Assigned(ASession) Then
    Utils_ManagerLog_Add('ServerController', 'TIWServerController', 'IWServerControllerBaseNewSession', 'Creando sesion: ' + ASession.IP + ', ' + ASession.AppID);
  ASession.Data := TIWUserSession.Create(nil, ASession);
  TIWUserSession(ASession.Data).SetPATH_CONFIG(Self.PATH_LOG);
  ForceDirectories(Self.PATH_LOG);
  TIWUserSession(ASession.Data).SetPATH_FILES(Self.PATH_CACHE);
  ForceDirectories(Self.PATH_CACHE);
  TIWUserSession(ASession.Data).SetPATH_CONFIG(Self.PATH_CONFIG);
  ForceDirectories(Self.PATH_CONFIG);
  TIWUserSession(ASession.Data).SetPATH_FILES(Self.PATH_FILES);
  ForceDirectories(Self.PATH_FILES);
  TFrIWLogin.SetAsMainForm;
  If Assigned(ASession) Then
    Utils_ManagerLog_Add('ServerController', 'TIWServerController', 'IWServerControllerBaseNewSession', 'Creando sesion: ' + ASession.IP + ', ' + ASession.AppID);
End;

Function TIWServerController.CountSessions : Integer;
var
  i: integer;
  App: TIWApplication;
  lSessionList: TStringList;
  S: string;
begin
  Result := 0;
  try
    lSessionList := TStringList.Create;
    GSessions.GetList(lSessionList);
    for i := 0 to lSessionList.Count - 1 do
    begin
      Inc(Result);
      App := TIWApplication(lSessionList.Objects[i]);
      S := IntToStr(i + 1) + '. ' + DateTimeToStr(App.SessionTimeStamp) + '. LastAccess=' + DateTimeToStr(App.LastAccess) + '. IP=' + App.IP + '. Browser=' + App.Browser.ToString + '.';
    end;
  finally
    If Assigned(lSessionList) Then
    Begin
      lSessionList.Clear;
      FreeAndNil(lSessionList);
    End;
  end;
end;

Function TIWServerController.Session_Active(Const pAuthUse : String; Var pIP : String)  : Boolean;
var
  i: Integer;
  lExiste : Boolean;
  LSessionList: TStringList;
begin
  Result := False;
  lExiste := False;
  // First, create a session list to hold the session IDs
  LSessionList := TStringList.Create;
  try
    gSessions.GetList(LSessionList);
    for i := 0 to LSessionList.Count - 1 do
    begin
      gSessions.Execute(LSessionList[i],procedure(aSession: TObject)
                        var
                          LSession : TIWApplication absolute aSession;
                        begin
                          If Not lExiste Then
                            lExiste := AnsiUpperCase(Trim(LSession.AuthUser)) = AnsiUpperCase(Trim(pAuthUse));
                        end
                       );

    end;
     Result := lExiste;
  finally
    LSessionList.Free;
  end;
End;


initialization
  TIWServerController.SetServerControllerClass;

end.
