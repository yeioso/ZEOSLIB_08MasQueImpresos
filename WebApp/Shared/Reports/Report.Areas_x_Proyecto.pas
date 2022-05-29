unit Report.Areas_x_Proyecto;

interface
Uses
  UtConexion,
  System.Classes;

Function Report_Areas_x_Proyecto_Reporte(pCNX: TConexion; Const pCodigo_Proyecto, pFecha_Ini, pFecha_Fin : String; Const pId_Fecha : Integer) : Boolean;

implementation

Uses
  UtFuncion,
  System.SysUtils,
  ServerController,
  TBL000.Info_Tabla,
  UtilsIW.ManagerLog;

Type
  TReport_Areas_x_Proyecto = Class
    Private
      FCNX : TConexion;
      FINPUT : TQUERY;
      FOUTPUT : TQUERY;
      FCONTADOR : Integer;
      FID_FECHA : Integer;
      FFECHA_INI : String;
      FFECHA_FIN : String;
      FCODIGO_PROYECTO : String;
      Function Inicializar_Reporte : Boolean;
      Procedure SaveData(Const pLine : String; pForced : Boolean = False);
      Function GetData : Boolean;
      Function PutData : Boolean;
      Procedure SetLinea(Const pProducto, pCantidad, pValor, pTotal : String);
    Public
      Constructor Create(pCNX: TConexion; Const pCodigo_Proyecto, pFecha_Ini, pFecha_Fin : String; Const pId_Fecha : Integer);
      Destructor Destroy;
  End;

{ TReport_Areas_x_Proyecto }
Constructor TReport_Areas_x_Proyecto.Create(pCNX: TConexion; Const pCodigo_Proyecto, pFecha_Ini, pFecha_Fin : String; Const pId_Fecha : Integer);
Begin
  Try
    FCNX := pCNX;
    FINPUT := TQUERY.Create(Nil);
    FOUTPUT := TQUERY.Create(Nil);
    FCONTADOR := 0;
    FINPUT.Connection := pCNX;
    FOUTPUT.Connection := pCNX;
    FID_FECHA := pId_Fecha;
    FFECHA_INI := pFecha_Ini;
    FFECHA_FIN := pFecha_Fin;
    FCODIGO_PROYECTO := pCodigo_Proyecto;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Areas_x_Proyecto', 'TReport_Areas_x_Proyecto.Create', E.Message);
    End;
  End;
End;

Function TReport_Areas_x_Proyecto.Inicializar_Reporte : Boolean;
Begin
  Result := False;
  Try
    FOUTPUT.SQL.Clear;
    FOUTPUT.SQL.Add(' DELETE FROM ' + Info_TablaGet(Id_TBL_Usuario_Reporte).Name + ' ');
    FOUTPUT.SQL.Add(' WHERE ' + FCNX.Trim_Sentence('CODIGO_USUARIO')  + ' = ' + QuotedStr(Trim(UserSession.USER_CODE)) + ' ');
    FOUTPUT.ExecSQL;
    FOUTPUT.SQL.Clear;
    FOUTPUT.SQL.Add(' SELECT * FROM ' + Info_TablaGet(Id_TBL_Usuario_Reporte).Name + ' ');
    FOUTPUT.SQL.Add(' WHERE ' + FCNX.Trim_Sentence('CODIGO_USUARIO')  + ' = ' + QuotedStr(Trim(UserSession.USER_CODE)) + ' ');
    FOUTPUT.Active := True;
    Result := FOUTPUT.Active;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Areas_x_Proyecto', 'TReport_Areas_x_Proyecto.Inicializar_Reporte', E.Message);
    End;
  End;
End;

Procedure TReport_Areas_x_Proyecto.SaveData(Const pLine : String; pForced : Boolean = False);
Var
  lI : Integer;
Begin
  If Vacio(pLine) And (Not pForced) Then
    Exit;
  Try
    If FOUTPUT.Active Then
    Begin
      Inc(FCONTADOR);
      FOUTPUT.Append;
      FOUTPUT.FieldByName('CODIGO_USUARIO').AsString := UserSession.USER_CODE;
      FOUTPUT.FieldByName('LINEA'         ).AsString := Justificar(IntToStr(FCONTADOR - 1), '0', FOUTPUT.FieldByName('LINEA').Size);
      FOUTPUT.FieldByName('CONTENIDO'     ).AsString := pLine;
      FOUTPUT.Post;
    End;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Areas_x_Proyecto', 'TReport_Areas_x_Proyecto.SaveData', E.Message);
    End;
  End;
End;

Function TReport_Areas_x_Proyecto.GetData : Boolean;
Begin
  Try
    FINPUT.Active := False;
    FINPUT.SQL.Clear;
    FINPUT.SQL.Add('SELECT ');
    FINPUT.SQL.Add('       PROY.CODIGO_PROYECTO ');
    FINPUT.SQL.Add('      ,PROY.NOMBRE AS NOMBRE_PROYECTO ');
    FINPUT.SQL.Add('      ,DET.CODIGO_AREA ');
    FINPUT.SQL.Add('      ,AREA.NOMBRE AS NOMBRE_AREA ');
    FINPUT.SQL.Add('      ,DET.CODIGO_PRODUCTO ');
    FINPUT.SQL.Add('      ,PROD.NOMBRE AS NOMBRE_PRODUCTO ');
    FINPUT.SQL.Add('      ,SUM(DET.CANTIDAD) AS CANTIDAD ');
    FINPUT.SQL.Add('      ,SUM(DET.VALOR_UNITARIO) AS VALOR_UNITARIO ');
    FINPUT.SQL.Add('      ,SUM(DET.CANTIDAD * DET.VALOR_UNITARIO) AS TOTAL ');
    FINPUT.SQL.Add('  FROM ' + Info_TablaGet(Id_TBL_Movto_Inventario).Name + ' DET ');
    FINPUT.SQL.Add('  INNER JOIN ' + Info_TablaGet(Id_TBL_Orden_Produccion).Name + ' OP ON DET.CODIGO_DOCUMENTO_OP = OP.CODIGO_DOCUMENTO AND DET.NUMERO_OP = OP.NUMERO ');
    FINPUT.SQL.Add('  INNER JOIN ' + Info_TablaGet(Id_TBL_Proyecto).Name + ' PROY ON OP.CODIGO_PROYECTO = PROY.CODIGO_PROYECTO ');
    FINPUT.SQL.Add('  INNER JOIN ' + Info_TablaGet(Id_TBL_Producto).Name + ' PROD ON DET.CODIGO_PRODUCTO = PROD.CODIGO_PRODUCTO ');
    FINPUT.SQL.Add('  INNER JOIN ' + Info_TablaGet(Id_TBL_Area).Name + ' AREA ON DET.CODIGO_AREA = AREA.CODIGO_AREA ');
    FINPUT.SQL.Add('  WHERE PROY.CODIGO_PROYECTO = ' + QuotedStr(FCODIGO_PROYECTO));
    If FID_FECHA = 0 Then FINPUT.SQL.Add('   AND DET.FECHA_REGISTRO BETWEEN '   + QuotedStr(FFECHA_INI) + ' AND ' + QuotedStr(FFECHA_FIN) + ' ');
    If FID_FECHA = 0 Then FINPUT.SQL.Add('   AND DET.FECHA_MOVIMIENTO BETWEEN ' + QuotedStr(FFECHA_INI) + ' AND ' + QuotedStr(FFECHA_FIN) + ' ');
    FINPUT.SQL.Add('  GROUP BY PROY.CODIGO_PROYECTO, PROY.NOMBRE, DET.CODIGO_AREA, AREA.NOMBRE, PROD.NOMBRE, DET.CODIGO_PRODUCTO ');
    FINPUT.SQL.Add('  ORDER BY PROY.CODIGO_PROYECTO, AREA.NOMBRE, PROD.NOMBRE ');
    FINPUT.Active := True;
    Result := FINPUT.Active;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Areas_x_Proyecto', 'TReport_Areas_x_Proyecto.GetData', E.Message);
    End;
  End;
End;


Procedure TReport_Areas_x_Proyecto.SetLinea(Const pProducto, pCantidad, pValor, pTotal : String);
Var
  lBase : String;
Begin
  Try
   lBase := StringOfChar(' ', 04) +
            Copy(Justificar(pProducto      , ' ', 080, 'I'), 01, 080) + ' ' +
            Copy(Justificar(pCantidad      , ' ', 018, 'D'), 01, 018) + ' ' +
            Copy(Justificar(pValor         , ' ', 018, 'D'), 01, 018) + ' ' +
            Copy(Justificar(pTotal         , ' ', 018, 'D'), 01, 018) ;
    SaveData(lBase);
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Areas_x_Proyecto', 'TReport_Areas_x_Proyecto.SetLinea', E.Message);
    End;
  End;
End;

Function TReport_Areas_x_Proyecto.PutData : Boolean;
Var
  lArea : String;
  lNombre : String;
  lProyecto : String;
  lArea_Total : Double;
  lArea_Cantidad : Double;
  lProyecto_Total : Double;
  lProyecto_Cantidad : Double;
Begin
  lArea_Total := 0;
  lArea_Cantidad := 0;
  lProyecto_Total := 0;
  lProyecto_Cantidad := 0;
  Result := False;
  Try
    If FINPUT.Active And (FINPUT.RecordCount > 0) Then
    Begin
      SaveData('CONSUMO AREAS POR PROYECTO ');
      SaveData('FECHA/HORA: ' + FormatDateTime('YYYY-MM-DD, HH:NN:SS', Now));
      SaveData('USUARIO: ' + UserSession.USER_NAME);
      SaveData('PROYECTO: ' + Trim(FINPUT.FieldByName('NOMBRE_PROYECTO').AsString) + ' ENTRE ' + FFECHA_INI + ' Y ' + FFECHA_FIN);
      lProyecto := Trim(FINPUT.FieldByName('NOMBRE_PROYECTO').AsString);
      FINPUT.First;
      While Not FINPUT.Eof Do
      Begin
        lArea := FINPUT.FieldByName('CODIGO_AREA').AsString;
        lNombre := FINPUT.FieldByName('NOMBRE_AREA').AsString;
        SaveData('', True);
        SaveData(StringOfChar(' ', 02) + FINPUT.FieldByName('CODIGO_AREA').AsString + ' - ' + Trim(FINPUT.FieldByName('NOMBRE_AREA').AsString));
        SetLinea(StringOfChar('.', 100), StringOfChar('.', 20), StringOfChar('.', 30), StringOfChar('.', 30));
        SetLinea('PRODUCTO', 'CANTIDAD', 'VALOR', 'TOTAL');
        SetLinea(StringOfChar('.', 100), StringOfChar('.', 20), StringOfChar('.', 30), StringOfChar('.', 30));
        lArea_Total := 0;
        lArea_Cantidad := 0;
        While (Not FINPUT.Eof) And (Trim(lArea) = Trim(FINPUT.FieldByName('CODIGO_AREA').AsString))  Do
        Begin
          lArea_Total := lArea_Total + FINPUT.FieldByName('TOTAL').AsFloat;
          lArea_Cantidad := lArea_Cantidad + FINPUT.FieldByName('CANTIDAD').AsFloat;
          lProyecto_Total := lProyecto_Total + FINPUT.FieldByName('TOTAL').AsFloat;
          lProyecto_Cantidad := lProyecto_Cantidad + FINPUT.FieldByName('CANTIDAD').AsFloat;
          SetLinea(Trim(FINPUT.FieldByName('CODIGO_PRODUCTO').AsString) + ' - ' + Trim(FINPUT.FieldByName('NOMBRE_PRODUCTO').AsString),
                   FormatFloat('###,###,###,###.#0', FINPUT.FieldByName('CANTIDAD'      ).AsFloat),
                   FormatFloat('###,###,###,###.#0', FINPUT.FieldByName('VALOR_UNITARIO').AsFloat),
                   FormatFloat('###,###,###,###.#0', FINPUT.FieldByName('TOTAL'         ).AsFloat));
          FINPUT.Next;
          Result := True;
        End;
        SetLinea(StringOfChar('-', 100), StringOfChar('-', 20), StringOfChar(' ', 30), StringOfChar('-', 30));
        SetLinea('TOTAL ' + lNombre, FormatFloat('###,###,###,###.#0', lArea_Cantidad), StringOfChar(' ', 30), FormatFloat('###,###,###,###.#0', lArea_Total));
      End;
      SetLinea(StringOfChar('=', 100), StringOfChar('=', 20), StringOfChar(' ', 30), StringOfChar('=', 30));
      SetLinea('TOTAL ' + lProyecto, FormatFloat('###,###,###,###.#0', lProyecto_Cantidad), StringOfChar(' ', 30), FormatFloat('###,###,###,###.#0', lProyecto_Total));
    End;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Areas_x_Proyecto', 'TReport_Areas_x_Proyecto.PutData', E.Message);
    End;
  End;
End;

Destructor TReport_Areas_x_Proyecto.Destroy;
Begin
  Try
    If Assigned(FOUTPUT) Then
    Begin
      FOUTPUT.Active := False;
      FreeAndNil(FOUTPUT);
    End;

    If Assigned(FINPUT) Then
    Begin
      FINPUT.Active := False;
      FreeAndNil(FINPUT);
    End;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Areas_x_Proyecto', 'TReport_Areas_x_Proyecto.Destroy', E.Message);
    End;
  End;
End;

Function Report_Areas_x_Proyecto_Reporte(pCNX: TConexion; Const pCodigo_Proyecto, pFecha_Ini, pFecha_Fin : String; Const pId_Fecha : Integer) : Boolean;
Var
  lRSI : TReport_Areas_x_Proyecto;
Begin
  Result := False;
  Try
    lRSI := TReport_Areas_x_Proyecto.Create(pCNX, pCodigo_Proyecto, pFecha_Ini, pFecha_Fin, pId_Fecha);
    Result := lRSI.Inicializar_Reporte;
    If Result Then
      Result := lRSI.GetData;
    If Result Then
      Result := lRSI.PutData;
    FreeAndNil(lRSI);
  Except
    On E: Exception Do
    Begin
      Result := False;
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Areas_x_Proyecto', 'Report_Areas_x_Proyecto_Reporte', E.Message);
    End;
  End;
End;

End.
