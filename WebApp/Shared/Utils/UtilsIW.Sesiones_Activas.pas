unit UtilsIW.Sesiones_Activas;

interface
Uses
  UtConexion,
  IWApplication;

Function UtilsIW_Sesiones_Activas_Execute(pAPP : TIWApplication; pCnx: TConexion; Const pUser_Code : String) : Boolean;


implementation
Uses
  IWTypes,
  Classes,
  SysUtils,
  UtFuncion,
  TBL000.Info_Tabla,
  UtilsIW.ManagerLog,
  Form_Plantilla_Formato;

Type
  TSessionActiva = Class
    Private
      FSQL : TQUERY;
      FCNX : TConexion;
      FAPP : TIWApplication;
      FMENSAJE: String;
      FLISTADO : TStringList;
      FCONTADOR : Integer;
      FUSER_CODE : String;
      Function Save(Const pLine : String) : Boolean;
      Function Restart : Boolean;
      Function GetData : Boolean;
      Function SetLine(Const pDocumento, pFecha, pReferencia, pDetalle, pParcial : String) : String;
      Function Process : Boolean;
    Public
      Property MENSAJE : String Read FMENSAJE Write FMENSAJE;
      Constructor Create(pAPP : TIWApplication; pCnx: TConexion; Const pUser_Code : String);
      Function Execute : Boolean;
      Destructor Destroy;

  End;

{ TSessionActiva }
Constructor TSessionActiva.Create(pAPP : TIWApplication; pCnx: TConexion; Const pUser_Code : String);
begin
  FAPP := pAPP;
  FCNX := pCnx;
  FSQL := TQUERY.Create(Nil);
  FSQL.Connection := FCNX;
  FMENSAJE := '';
  FLISTADO := TStringList.Create;
  FCONTADOR := 0;
  FUSER_CODE := pUser_Code;
  Restart;
end;

Function TSessionActiva.Save(Const pLine : String) : Boolean;
Begin
  Inc(FCONTADOR);
  Try
    FCNX.TMP.Active := False;
    FCNX.TMP.SQL.Clear;
    FCNX.TMP.SQL.Add(' INSERT INTO ' + Info_TablaGet(Id_TBL_Usuario_Reporte).Name );
    FCNX.TMP.SQL.Add(' ( ');
    FCNX.TMP.SQL.Add('  CODIGO_USUARIO ');
    FCNX.TMP.SQL.Add(' ,LINEA ');
    FCNX.TMP.SQL.Add(' ,CONTENIDO ');
    FCNX.TMP.SQL.Add(' ) ');
    FCNX.TMP.SQL.Add(' VALUES ');
    FCNX.TMP.SQL.Add(' ( ');
    FCNX.TMP.SQL.Add(' ' + QuotedStr(FUSER_CODE));
    FCNX.TMP.SQL.Add(' ,' + QuotedStr(Justificar(IntToStr(FCONTADOR), '0', 5)));
    FCNX.TMP.SQL.Add(' ,' + QuotedStr(pLine));
    FCNX.TMP.SQL.Add(' ) ');
    FCNX.TMP.ExecSQL;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(FUSER_CODE, 'UtilsIW.Sesiones_Activas', 'TDetalleVsParcial.Save', E.Message);
      FMENSAJE := E.Message;
    End;
  End;
End;

Function TSessionActiva.Restart : Boolean;
Begin
  Result := False;
  Try
    FSQL.Active := False;
    FSQL.SQL.Clear;
    FSQL.SQL.Add(' DELETE FROM ' + Info_TablaGet(Id_TBL_Usuario_Reporte).Name + ' ');
    FSQL.SQL.Add(' WHERE ' + FCNX.Trim_Sentence('CODIGO_USUARIO') + ' = ' + QuotedStr(Trim(FUSER_CODE)));
    FSQL.ExecSQL;
    Result := (FSQL.RowsAffected > 0);
    FSQL.Active := False;
    FSQL.SQL.Clear;
  Except
    On E : Exception Do
    Begin
      Utils_ManagerLog_Add(FUSER_CODE, 'UtilsIW.Sesiones_Activas', 'TDetalleVsParcial.Restart', E.Message);
      FMENSAJE := E.Message;
    End;
  End;
End;

Function TSessionActiva.GetData : Boolean;
Var
  lI : Integer;
  lSessionList : TStringList;
Begin
  Result := False;
  FLISTADO.Clear;
  FCONTADOR := 0;
  Try
    lSessionList := TStringList.Create;
    try
      gSessions.GetList(lSessionList);
      FLISTADO.Add('SESIONES ACTIVAS=' + IntToStr(lSessionList.Count) + '.');
      for lI := 0 to lSessionList.Count - 1 do begin
        gSessions.Execute(lSessionList[lI],
          procedure(aSession: TObject)
          var
            LSession: TIWApplication absolute aSession;
          begin
            FLISTADO.Add(StringOfChar('=', 50));
            FLISTADO.Add(Trim(LSession.AuthUser) + ', ' + Trim(FCNX.GetValue(Info_TablaGet(Id_TBL_Usuario).Name, ['CODIGO_USUARIO'], [Trim(LSession.AuthUser)], ['NOMBRE'])));
            FLISTADO.Add(StringOfChar(' ', 03) + Trim(FormatDateTime('YYYY-MM-DD, HH:NN:SS', LSession.SessionTimeStamp)));
            FLISTADO.Add(StringOfChar(' ', 03) + 'Ultimo Acceso=' + DateTimeToStr(LSession.LastAccess));
            FLISTADO.Add(StringOfChar(' ', 03) + 'IP=' + LSession.IP );
            FLISTADO.Add(StringOfChar(' ', 03) + 'Browser=' + LSession.Browser.BrowserName);
          end
        );
      end;
    finally
      lSessionList.Free;
    end;
    Result := (FLISTADO.Count > 0);
    If Not Result Then
      FMENSAJE := 'No hay datos que cumpla con este criterio';
  Except
    On E : Exception Do
    Begin
      Utils_ManagerLog_Add(FUSER_CODE, 'UtilsIW.Sesiones_Activas', 'TDetalleVsParcial.GetData', E.Message);
      FMENSAJE := E.Message;
    End;
  End;
End;

Function TSessionActiva.SetLine(Const pDocumento, pFecha, pReferencia, pDetalle, pParcial : String) : String;
Begin
  Result := Copy(pDocumento  + StringOfChar(' ', 10), 01, 10) + '  ' +
            Copy(pFecha      + StringOfChar(' ', 10), 01, 10) + '  ' +
            Copy(pReferencia + StringOfChar(' ', 10), 01, 10) + '  ' +
            Copy(Justificar(pDetalle, ' ', 10) + StringOfChar(' ', 10), 01, 10) + '  ' +
            Copy(Justificar(pParcial, ' ', 10) + StringOfChar(' ', 10), 01, 10);
  Save(Result);
End;


Function TSessionActiva.Process : Boolean;
Var
  lI : Integer;
Begin
  Result := False;
  Try
    For lI := 0 To FLISTADO.Count-1 Do
      Save(FLISTADO[lI]);
     Result := True;
  Except
    On E : Exception Do
    Begin
      Result := False;
      Utils_ManagerLog_Add(FUSER_CODE, 'UtilsIW.Sesiones_Activas', 'TSessionActiva.Process', E.Message);
      FMENSAJE := E.Message;
    End;
  End;
End;

Function TSessionActiva.Execute : Boolean;
Begin
  Restart;
  Result := GetData;
  If Result Then
    Result := Process;
End;

destructor TSessionActiva.Destroy;
begin
  If Assigned(FLISTADO) Then
  Begin
    FLISTADO.Clear;
    FreeAndNil(FLISTADO);
  End;

  If Assigned(FSQL) Then
  Begin
    FSQL.Active := False;
    FreeAndNil(FSQL);
  End;
end;

Function UtilsIW_Sesiones_Activas_Execute(pAPP : TIWApplication; pCnx: TConexion; Const pUser_Code : String) : Boolean;
Var
  lDVP : TSessionActiva;
  lError : String;
Begin
  lDVP := TSessionActiva.Create(pAPP, pCnx, pUser_Code);
  Result := lDVP.Execute;
  FreeAndNil(lDVP);
  If Result And (Not Form_Plantilla_Reporte_Ercol(pAPP, lError)) Then
   pAPP.ShowMessage(lError, TIWShowMessageType.smAlert);
End;


end.
