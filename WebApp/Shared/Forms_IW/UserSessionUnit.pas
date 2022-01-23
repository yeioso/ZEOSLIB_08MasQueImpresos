unit UserSessionUnit;

{
  This is a DataModule where you can add components or declare fields that are specific to
  ONE user. Instead of creating global variables, it is better to use this datamodule. You can then
  access the it using UserSession.
}
interface

Uses
  DB,
  Classes,
  UtFecha,
  IWColor,
  SysUtils,
  StrUtils,
  SyncObjs,
  IWControl,
  UtFuncion,
  UtDatabase,
  UtConexion,
  UtilsIW.Cfg,
  IWDBStdCtrls,
  Vcl.ExtCtrls,
  Vcl.Graphics,
  IWCompExtCtrls,
  Winapi.Windows,
  IWUserSessionBase,

  UtilsIW.Permisos_App,

  Form_IWUsuario_Inicial,
  Form_IWLogin,
  Form_IWMenu,
  Form_IWPerfil_Enc,
  Form_IWPerfil_Permiso,
  Form_IWUsuario_Enc,
  Form_IWCambio_Password,

  Form_IWAdministrador_Documento,
  Form_IWArea,
  Form_IWUnidad_Medida,
  Form_IWTercero_Enc,
  Form_IWProducto,
  Form_IWProyecto,
  Form_IWOrden_Produccion,
  Form_IWExplosion_Material,
  Form_IWMovto_Inventario,
  Form_IWReporte,

  Form_IWNotificacion_Producto,
  Form_IWVisualizador_Log,

  IWBaseComponent,
  IWBaseHTMLComponent,
  IWBaseHTML40Component,
  Generics.Collections;

Type
  TIWUserSession = class(TIWUserSessionBase)
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  private
    { Private declarations }
    FUsuario_Inicial            : TFrIWUsuario_Inicial;
    FMenu                       : TFrIWMenu;
    FLogin                      : TFrIWLogin;
    FPerfil_Enc                 : TFrIWPerfil_Enc;
    FPerfil_Permiso             : TFrIWPerfil_Permiso;
    FUsuario_Enc                : TFrIWUsuario_Enc;
    FCambio_Password            : TFrIWCambio_Password;

    FAdministrador_Documento    : TFrIWAdministrador_Documento;
    FArea                       : TFrIWArea;
    FUnidad_Medida              : TFrIWUnidad_Medida;
    FTercero                    : TFrIWTercero_Enc;
    FProducto                   : TFrIWProducto;
    FProyecto                   : TFrIWProyecto;
    FOrden_Produccion           : TFrIWOrden_Produccion;
    FMovto_Inventario           : TFrIWMovto_Inventario;
    FExplosion_Material         : TFrIWExplosion_Material;
    FReporte                    : TFrIWReporte;
    FNotificacion_Producto      : TFrIWNotificacion_Producto;
    FVisualizador_Log           : TFrIWVisualizador_Log;

    FCNX                        : TConexion    ;
    FDB                         : TDB          ;
    FRESUMEN                    : TStringList  ;

    FTAG_INFO                   : Integer      ;
    FFULL_INFO                  : String       ;
    FPATH_LOG                   : String       ;
    FPATH_FILES                 : String       ;
    FPATH_CACHE                 : String       ;
    FGLOBAL_INFO                : String       ;

    FPATH_CONFIG                : String       ;
    FCODE_PROFILE               : String       ;
    FUSER_CODE                  : String       ;
    FUSER_NAME                  : String       ;

    FAPLICACION                 : String       ;
    FVERSION                    : String       ;
    FFECHA_ACTUAL               : TFecha_Info  ;
    FESTACION                   : String       ;
    FPERMISOS_APP               : TPermisos_App;

//    FLOGO_FORMATO               : TBitmap      ;

    Procedure Establecer_Conexion;
  public
    { Public declarations }
    Const COLOR_OK = cl3DLight;
    Const COLOR_ERROR = IWColor.clWebAQUA;
    Const DOCUMENTO_ENTRADA_DE_INVENTARIO    = 'ENTRADA DE INVENTARIO'   ;
    Const DOCUMENTO_SALIDA_DE_INVENTARIO     = 'SALIDA DE INVENTARIO'    ;
    Const DOCUMENTO_DEVOLUCION_AL_INVENTARIO = 'DEVOLUCION AL INVENTARIO';
    Const DOCUMENTO_ORDEN_DE_PRODUCCION      = 'ORDEN DE PRODUCCION'     ;
    Property CNX                        : TConexion     Read FCNX                    Write FCNX;
    Property DB                         : TDB           Read FDB                    ;
    Property RESUMEN                    : TStringList   Read FRESUMEN               ;
    Property TAG_INFO                   : Integer       Read FTAG_INFO              ;
    Property FULL_INFO                  : String        Read FFULL_INFO             ;
    Property PATH_LOG                   : String        Read FPATH_LOG              ;
    Property PATH_FILES                 : String        Read FPATH_FILES            ;
    Property PATH_CACHE                 : String        Read FPATH_CACHE            ;
    Property GLOBAL_INFO                : String        Read FGLOBAL_INFO           ;
    Property PATH_CONFIG                : String        Read FPATH_CONFIG           ;
    Property CODE_PROFILE               : String        Read FCODE_PROFILE          ;
    Property USER_CODE                  : String        Read FUSER_CODE             ;
    Property USER_NAME                  : String        Read FUSER_NAME             ;
    Property APLICACION                 : String        Read FAPLICACION            ;

    Property VERSION                    : String        Read FVERSION               ;
    Property FECHA_ACTUAL               : TFecha_Info   Read FFECHA_ACTUAL          ;
    Property ESTACION                   : String        Read FESTACION              ;
    Property PERMISOS_APP               : TPERMISOS_APP Read FPERMISOS_APP          ;
//    Property LOGO_FORMATO               : TBitmap       Read FLOGO_FORMATO          ;

    Procedure Refrescar;
    Procedure Refrescar2;
    Function Create_Manager_Data(Const pName, pCaption : String) : TMANAGER_DATA;
    Procedure IWAsyncRefresh(IWControlHTMLName : String = '');

    Procedure ShowForm_Menu;
    Procedure Show_Form_IWUsuario_Inicial;
    Procedure ShowForm_Login;
    Procedure ShowForm_Perfil_Enc(Const pCodigo_Perfil : String = '');
    Procedure ShowForm_Perfil_Permiso(Const pCodigo_Perfil : String);
    Procedure ShowForm_Usuario_Enc(Const pCodigo_Usuario : String = '');
    Procedure ShowForm_Cambio_Password;
    Procedure ShowForm_Administrador_Documento;
    Procedure ShowForm_Area;
    Procedure ShowForm_Unidad_Medida;
    Procedure ShowForm_Tercero;
    Procedure ShowForm_Producto;
    Procedure ShowForm_Proyecto;
    Procedure ShowForm_Orden_Produccion(Const pCodigo_Documento : String);
    Procedure ShowForm_Explosion_Material(Const pCodigo_Documento, pNombre, pReferencia, pProyecto : String; pNumero : Integer);
    Procedure ShowForm_Movto_Inventario(Const pCodigo_Documento : String);
    Procedure ShowForm_Reporte;
    Procedure ShowForm_Notificacion_Producto;
    Procedure ShowForm_Visualizador_Log;

    Procedure Update_Menu;

    //Procedure Generar_Log_Bloque(pAction: String; pQR: TQUERY);
    Function Usuario_Valido(Const pUsername, pPassword : String) : Boolean;
    Procedure SetTAG_INFO       (Const pValue : Integer  );
    Procedure SetFULL_INFO      (Const pValue : String   );
    Procedure SetPATH_LOG       (Const pValue : String   );
    Procedure SetPATH_FILES     (Const pValue : String   );
    Procedure SetPATH_CACHE     (Const pValue : String);
    Procedure SetGLOBAL_INFO    (Const pValue : String   );
    Procedure SetPATH_CONFIG    (Const pValue : String   );
    Procedure SetCODE_PROFILE   (Const pValue : String   );
    Procedure SetUSER_CODE      (Const pValue : String   );
    Procedure SetUSER_NAME      (Const pValue : String   );
    Procedure SetAPLICACION     (Const pValue : String   );
    Procedure SetFECHA_ACTUAL   (Const pValue : TDatetime);
    Procedure SetAmbiente;
    Procedure SetRESUMEN(Const pValue : String);
    Procedure RestartRESUMEN;
    Procedure SetEstacion(Const pValue : String);
    Procedure TerminateSession(Const pAuthUser, AppID : String);
    Procedure Validar_Perfil(pCodigo_Perfil : String);
    Procedure SetMessage(Const pValue : String; Const pError : Boolean; pTimes : Integer = 1);
    Procedure Show_Message(Const pValue : String);
  end;

implementation
{$R *.dfm}
Uses
  IWTypes,
  IWCompEdit,
  IWCompGrids,
  IWDBExtCtrls,
  Vcl.Controls,
  IWApplication,
  UtManagerImages,
  ServerController,
  TBL000.Info_Tabla,
  UtilsIW.ManagerLog,
  UtilsIW.Usuario_Inicial;

Procedure Bridge_Add_Log(Const pUser, pDocumento, pOperacion, pDetalle : String);
Begin
  Utils_ManagerLog_Add(pUser, pDocumento, pOperacion, pDetalle);
End;

Function TIWUserSession.Create_Manager_Data(Const pName, pCaption : String) : TMANAGER_DATA;
Begin
  Try
    Result := TMANAGER_DATA.Create(pName, pCaption);
    Result.QR.Connection := Self.FCNX;
    Result.USER_NAME := FUSER_CODE;
    Result.ESTACION := FESTACION;
    Result.Procedure_Log := Bridge_Add_Log;
  Except
    On E: Exception Do
      Utils_ManagerLog_Add('UserSessionUnit', 'TIWUserSession', 'Create_Manager_Data', E.Message);
  End;
End;

procedure TIWUserSession.IWUserSessionBaseCreate(Sender: TObject);
begin
  FPERMISOS_APP := TPermisos_App.Create;
  FCNX := TConexion.Create(Nil);
  FCNX.Name  := 'MQIERP_DATABASE';
  SetPATH_LOG(IWServerController.PATH_LOG);
  SetPATH_FILES(IWServerController.PATH_FILES);
  SetPATH_CACHE(IWServerController.PATH_CACHE);
  SetPATH_CONFIG(IWServerController.PATH_CONFIG);
  Establecer_Conexion;
end;

procedure TIWUserSession.IWUserSessionBaseDestroy(Sender: TObject);
begin
  If Assigned(FCNX) Then
    FreeAndNil(FCNX);

  If Assigned(FRESUMEN) Then
  Begin
    FRESUMEN.Clear;
    FreeAndNil(FRESUMEN);
  End;

  If Assigned(FPERMISOS_APP) Then
    FreeAndNil(FPERMISOS_APP);
end;

Procedure TIWUserSession.Refrescar;
begin
  WebApplication.CallBackResponse.AddJavaScriptToExecute('location.reload(true);');
end;

Procedure TIWUserSession.Refrescar2;
begin
  WebApplication.CallBackResponse.AddJavaScriptToExecuteAsCDATA('location.reload(true);');
end;

Procedure TIWUserSession.IWAsyncRefresh(IWControlHTMLName : String = '');
var
ID: string;
JS: string;
Begin
  ID := IWControlHTMLName;
  JS := 'SubmitClick("'+ID+'","",false);';
  JS := 'document.getElementById("' + IWControlHTMLName + '").contentWindow.location.reload(true);';
//  JS := 'function reload(){ document.getElementsByTagName("' + IWControlHTMLName + '")[0].reload();}';
  IF WebApplication.IsCallBack then // Im Async Ereignis?
  Begin
    WebApplication.CallBackResponse.AddJavaScriptToExecute('<![CDATA['+JS+']]>');
  End;
End;

Procedure TIWUserSession.ShowForm_Menu;
Begin
  FMenu := TFrIWMenu.Create(WebApplication);
  FMenu.SetAsMainForm;
  FMenu.Show;
End;

Procedure TIWUserSession.Show_Form_IWUsuario_Inicial;
Begin
  FUsuario_Inicial := TFrIWUsuario_Inicial.Create(WebApplication, FCNX);
  FUsuario_Inicial.SetAsMainForm;
  FUsuario_Inicial.Show;
End;

Procedure TIWUserSession.ShowForm_Login;
Begin
  FLogin := TFrIWLogin.Create(WebApplication, FCNX);
  FLogin.SetAsMainForm;
  FLogin.Show;
End;

Procedure TIWUserSession.ShowForm_Perfil_Enc(Const pCodigo_Perfil : String = '');
Begin
  FPerfil_Enc := TFrIWPerfil_Enc.Create(WebApplication, pCodigo_Perfil);
  FPerfil_Enc.Show;
End;

Procedure TIWUserSession.ShowForm_Perfil_Permiso(Const pCodigo_Perfil : String);
Begin
  FPerfil_Permiso := TFrIWPerfil_Permiso.Create(WebApplication, pCodigo_Perfil);
  FPerfil_Permiso.Show;
End;

Procedure TIWUserSession.ShowForm_Usuario_Enc(Const pCodigo_Usuario : String = '');
Begin
  FUsuario_Enc := TFrIWUsuario_Enc.Create(WebApplication, pCodigo_Usuario);
  FUsuario_Enc.Show;
End;

Procedure TIWUserSession.ShowForm_Cambio_Password;
Begin
  FCambio_Password := TFrIWCambio_Password.Create(WebApplication);
  FCambio_Password.Show;
End;

Procedure TIWUserSession.ShowForm_Administrador_Documento;
Begin
  FAdministrador_Documento := TFrIWAdministrador_Documento.Create(WebApplication);
  FAdministrador_Documento.Show;
End;

Procedure TIWUserSession.ShowForm_Area;
Begin
  FArea := TFrIWArea.Create(WebApplication);
  FArea.Show;
End;

Procedure TIWUserSession.ShowForm_Unidad_Medida;
Begin
  FUnidad_Medida := TFrIWUnidad_Medida.Create(WebApplication);
  FUnidad_Medida.Show;
End;

Procedure TIWUserSession.ShowForm_Tercero;
Begin
  FTercero := TFrIWTercero_Enc.Create(WebApplication);
  FTercero.Show;
End;

Procedure TIWUserSession.ShowForm_Producto;
Begin
  FProducto := TFrIWProducto.Create(WebApplication);
  FProducto.Show;
End;

Procedure TIWUserSession.ShowForm_Proyecto;
Begin
  FProyecto := TFrIWProyecto.Create(WebApplication);
  FProyecto.Show;
End;

Procedure TIWUserSession.ShowForm_Orden_Produccion(Const pCodigo_Documento : String);
Begin
  FOrden_Produccion := TFrIWOrden_Produccion.Create(WebApplication, pCodigo_Documento);
  FOrden_Produccion.Show;
End;

Procedure TIWUserSession.ShowForm_Explosion_Material(Const pCodigo_Documento, pNombre, pReferencia, pProyecto : String; pNumero : Integer);
Begin
  FExplosion_Material := TFrIWExplosion_Material.Create(WebApplication, pCodigo_Documento, pNombre, pReferencia, pProyecto, pNumero);
  FExplosion_Material.Show;
End;

Procedure TIWUserSession.ShowForm_Movto_Inventario(Const pCodigo_Documento : String);
Begin
  FMovto_Inventario := TFrIWMovto_Inventario.Create(WebApplication, pCodigo_Documento);
  FMovto_Inventario.Show;
End;

Procedure TIWUserSession.ShowForm_Reporte;
Begin
  FReporte := TFrIWReporte.Create(WebApplication);
  FReporte.Show;
End;

Procedure TIWUserSession.ShowForm_Notificacion_Producto;
Begin
  FNotificacion_Producto := TFrIWNotificacion_Producto.Create(WebApplication);
  FNotificacion_Producto.Show;
End;

Procedure TIWUserSession.ShowForm_Visualizador_Log;
Begin
  FVisualizador_Log := TFrIWVisualizador_Log.Create(WebApplication);
  FVisualizador_Log.Show;
End;

Procedure TIWUserSession.Update_Menu;
Begin
  If Assigned(FMenu) Then
    FMenu.Actualizar_Info;
End;

//Procedure TIWUserSession.Generar_Log_Bloque(pAction: String; pQR: TQUERY);
//Const
//  LINE_START = '<-----!';
//  LINE_FINISH = '!----->';
//Var
//  lI: Integer;
//  lLog : String;
//  lTexto : String;
//Begin
//  lTexto := '';
//  For lI := 0 To pQR.Fields.Count - 1 Do
//    If pQR.Fields[lI].DataType In  [ftSmallint, ftString, ftWideString, ftMemo, ftWideMemo, ftFloat, ftInteger, ftCurrency] Then
//      If Not Vacio(pQR.Fields[lI].AsString) Then
//        lTexto := lTexto + IfThen(Not Vacio(lTexto), #13 + StringOfChar(' ', 22)) + Trim(pQR.Fields[lI].FullName) + ' = ' + Trim(pQR.Fields[lI].AsString) ;
//  lLog := LINE_START + #13 +
//          StringOfChar(' ', 20) + pAction                  + #13 +
//          StringOfChar(' ', 20) + 'USUARIO: ' + FUSER_NAME + #13 +
//          StringOfChar(' ', 20) + 'ESTACION: ' + FESTACION + #13 +
//          StringOfChar(' ', 22) + lTexto                   + #13 +
//          StringOfChar(' ', 20) + LINE_FINISH;
//  Utils_ManagerLog_Add(lLog);
//End;

Procedure TIWUserSession.Establecer_Conexion;
Begin
  Try
    Self.FDB := IWServerController.DB;
    Utils_ManagerLog_Add('UserSessionUnit', 'TIWUserSession', 'Establecer_Conexion', 'Iniciando la conexion a la base de datos... ');
    FCNX.Connect(False);
    FCNX.SetConnection  (Conn_SQLSERVER);
    Utils_ManagerLog_Add('UserSessionUnit', 'TIWUserSession', 'Establecer_Conexion', 'IWServerController.DB.ServerName, ' + IWServerController.DB.ServerName);
    FCNX.SetServer      (IWServerController.DB.ServerName  );
    Utils_ManagerLog_Add('UserSessionUnit', 'TIWUserSession', 'Establecer_Conexion', 'IWServerController.DB.DatabaseName, ' + IWServerController.DB.DatabaseName);
    FCNX.SetDatabase    (IWServerController.DB.DatabaseName);
    Utils_ManagerLog_Add('UserSessionUnit', 'TIWUserSession', 'Establecer_Conexion', 'IWServerController.DB.UserName, ' + IWServerController.DB.UserName);
    FCNX.SetUser        (IWServerController.DB.UserName    );
    FCNX.SetPassword    (IWServerController.DB.Password    );
    Utils_ManagerLog_Add('UserSessionUnit', 'TIWUserSession', 'Establecer_Conexion', 'IWServerController.DB.DLL_DATABASE, ' + IWServerController.DB.DLL_DATABASE);
    FCNX.SetDLL_DATABASE(IWServerController.DB.DLL_DATABASE);
    Utils_ManagerLog_Add('UserSessionUnit', 'TIWUserSession', 'Establecer_Conexion', 'IWServerController.DB.Port, ' + IntToStr(IWServerController.DB.Port));
    FCNX.SetPort        (IWServerController.DB.Port        );
    If Not FCNX.Connect(True) Then
    Begin
      Utils_ManagerLog_Add('UserSessionUnit', 'TIWUserSession', 'Establecer_Conexion', 'No es posible conectarse a la base de datos');
      FRESUMEN.Add('No es posible conectarse a la base de datos');
    End
    Else
    Begin
      If UtilsIW_Usuario_Existe(FCNX) Then
        Self.ShowForm_Login
      Else
        Self.Show_Form_IWUsuario_Inicial;
      Utils_ManagerLog_Add('UserSessionUnit', 'TIWUserSession', 'Establecer_Conexion', 'TDM.Establecer_Conexion, conexion exitosa... ');
    End;
  Except
    On E: Exception Do
      Utils_ManagerLog_Add('UserSessionUnit', 'TIWUserSession', 'Establecer_Conexion', E.Message);
  End;
End;

Procedure TIWUserSession.Validar_Perfil(pCodigo_Perfil : String);
Var
  lI : Integer;
  lResult : String;
Begin
  Utils_ManagerLog_Add('UserSessionUnit', 'TIWUserSession', 'TDM.Validar_Perfil', 'Cargando permisos... ');
  For lI := 0 To PERMISOS_APP.Items_App.Count - 1 Do
  Begin
    lResult := CNX.GetValue(Info_TablaGet(Id_TBL_Permiso_App).Name, ['CODIGO_PERFIL', 'NOMBRE'], [pCodigo_Perfil, PERMISOS_APP.Items_App[lI].Id_Str], ['HABILITA_OPCION']);
    PERMISOS_APP.SetEnabled(PERMISOS_APP.Items_App[lI].Id_Int, lResult = 'S');
  End;
End;

Function TIWUserSession.Usuario_Valido(Const pUsername, pPassword : String) : Boolean;
Begin
  Result := False;

  If Not FCNX.Connected Then
    Exit;
  Try
    CNX.SQL.Active := False;
    CNX.SQL.SQL.Clear;
    CNX.SQL.SQL.Add(' SELECT * FROM ' + Info_TablaGet(Id_TBL_Usuario).Name + ' ' + CNX.No_Lock);
    CNX.SQL.SQL.Add(' WHERE ' );
    CNX.SQL.SQL.Add(' ( ' );
    CNX.SQL.SQL.Add(' '   + FCNX.Trim_Sentence('CODIGO_USUARIO') + ' = ' + QuotedStr(Trim(pUsername)));
    CNX.SQL.SQL.Add('   OR ');
    CNX.SQL.SQL.Add('   ' + FCNX.Trim_Sentence('EMAIL'         ) + ' = ' + QuotedStr(Trim(pUsername)));
    CNX.SQL.SQL.Add(' ) ' );
    CNX.SQL.Active := True;
    If CNX.SQL.Active And (CNX.SQL.RecordCount > 0) Then
    Begin
      Result := Trim(AnsiUpperCase(CNX.SQL.FieldByName('CONTRASENA').AsString)) = Trim(AnsiUpperCase(pPassword));
      If Not Result Then
        Utils_ManagerLog_Add('UserSessionUnit', 'TIWUserSession', 'Usuario_Valido', 'Autenticación no valida de ' + pUsername)
      Else
      Begin
        SetUSER_CODE(CNX.SQL.FieldByName('CODIGO_USUARIO').AsString);
        SetUSER_NAME(Trim(CNX.SQL.FieldByName('NOMBRE').AsString));
        Validar_Perfil(CNX.SQL.FieldByName('CODIGO_PERFIL').AsString);
      End;
    End
    Else
    Begin
      Utils_ManagerLog_Add('UserSessionUnit', 'TIWUserSession', 'Usuario_Valido', 'Usuario no existe ' + pUsername);
    End;
    CNX.SQL.Active := False;
  Except
    On E: Exception Do
      Utils_ManagerLog_Add('UserSessionUnit', 'TIWUserSession', 'Usuario_Valido', E.Message);
  End;
End;

Procedure TIWUserSession.SetTAG_INFO(Const pValue : Integer  );
Begin
  FTAG_INFO := pValue;
End;

Procedure TIWUserSession.SetFULL_INFO(Const pValue : String);
Begin
  FFULL_INFO := pValue;
End;

Procedure TIWUserSession.SetPATH_LOG(Const pValue : String);
Begin
  FPATH_LOG := pValue;
End;

Procedure TIWUserSession.SetPATH_FILES(Const pValue : String);
Begin
  FPATH_FILES := pValue;
End;

Procedure TIWUserSession.SetPATH_CACHE(Const pValue : String);
Begin
  FPATH_CACHE := pValue;
End;

Procedure TIWUserSession.SetGLOBAL_INFO(Const pValue : String);
Begin
  FGLOBAL_INFO := pValue;
End;

Procedure TIWUserSession.SetPATH_CONFIG(Const pValue : String);
Begin
  FPATH_CONFIG := pValue;
End;

Procedure TIWUserSession.SetCODE_PROFILE(Const pValue : String);
Begin
  FCODE_PROFILE := pValue;
End;

Procedure TIWUserSession.SetUSER_CODE(Const pValue : String);
Begin
  FUSER_CODE := pValue;
End;

Procedure TIWUserSession.SetUSER_NAME(Const pValue : String);
Begin
  FUSER_NAME := pValue;
End;

Procedure TIWUserSession.SetAPLICACION(Const pValue : String);
Begin
  FAPLICACION := pValue;
End;

Procedure TIWUserSession.SetFECHA_ACTUAL(Const pValue : TDatetime);
Begin
  FFECHA_ACTUAL := Return_Type_Date(pValue);
End;

Procedure TIWUserSession.SetAmbiente;
Begin

End;

Procedure TIWUserSession.SetRESUMEN(Const pValue : String);
Begin
  If Assigned(FRESUMEN) Then
  Begin
    FRESUMEN.Add(pValue);
  End;
End;

Procedure TIWUserSession.RestartRESUMEN;
Begin
  If Assigned(FRESUMEN) Then
  Begin
    FRESUMEN.Clear;
  End;
End;

Procedure TIWUserSession.SetEstacion(Const pValue : String);
Begin
  FESTACION := pValue;
End;

Procedure TIWUserSession.TerminateSession(Const pAuthUser, AppID : String);
var
  lI : Integer;
  lS : TIWApplication;
  lSessionList : TStringList;
begin
  // First, create a session list to hold the session IDs
  LSessionList := TStringList.Create;
  Try
    lI := 0;
    gSessions.GetList(LSessionList);
    While lI  < lSessionList.Count - 1 Do
    Begin
      lS := Nil;
      gSessions.Execute(LSessionList[lI], Procedure(aSession: TObject)
                        Var
                          lSession : TIWApplication absolute aSession;
                        begin
                          If (AnsiUpperCase(Trim(lSession.AuthUser)) = AnsiUpperCase(Trim(pAuthUser))) And
                             (AnsiUpperCase(Trim(lSession.AppID   )) <> AnsiUpperCase(Trim(AppID   ))) Then
                            lS := lSession;
//                          If AnsiUpperCase(Trim(lSession.AuthUser)) = AnsiUpperCase(Trim(pValue)) Then
//                            lSession.Terminate;
                        end
                        );
      Try
        If lS <> Nil Then
        Begin
          gSessions.Terminate(lS.AppID);
          lS.Terminate;
          LSessionList.Delete(lI);
        End
        Else
          Inc(lI);
      Except
        On E: Exception Do
          Utils_ManagerLog_Add('UserSessionUnit', 'TIWUserSession', 'TerminateSession', E.Message);
      End;
    End;
  Finally
    lSessionList.Free;
  End;
End;

Procedure TIWUserSession.Show_Message(Const pValue : String);
Begin
  WebApplication.ShowMessage(pValue);
End;

Procedure TIWUserSession.SetMessage(Const pValue : String; Const pError : Boolean; pTimes : Integer = 1);
Begin
  Try
    If pError Then
      WebApplication.ShowNotification(pValue, ntError)
    Else
      WebApplication.ShowNotification(pValue, ntSuccess);
  Except
    On E: Exception Do
       Utils_ManagerLog_Add('UserSessionUnit', 'TIWUserSession', 'SetMessage', E.Message);
  End;
End;



end.
