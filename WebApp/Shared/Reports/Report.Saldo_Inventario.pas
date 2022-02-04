unit Report.Saldo_Inventario;

interface
Uses
  UtConexion,
  System.Classes;

Function Report_Saldo_Inventario_Saldo(pCNX: TConexion; Const pCodigo_Producto_Ini, pCodigo_Producto_Fin : String) : Double;
Function Report_Saldo_Inventario_Reporte(pCNX: TConexion; Const pCodigo_Producto_Ini, pCodigo_Producto_Fin : String) : Boolean;

implementation

Uses
  UtFuncion,
  System.SysUtils,
  ServerController,
  TBL000.Info_Tabla,
  UtilsIW.ManagerLog;

Type
  TReport_Saldo_Inventario = Class
    Private
      FCNX : TConexion;
      FINPUT : TQUERY;
      FOUTPUT : TQUERY;
      FCONTADOR : Integer;
      FCODIGO_PRODUCTO_INI : String;
      FCODIGO_PRODUCTO_FIN : String;
      Function Inicializar_Reporte : Boolean;
      Procedure SaveData(Const pLine : String; pForced : Boolean = False);
      Function GetData : Boolean;
      Function PutData : Boolean;
      Function Calcular_Saldo : Double;
      Procedure SetLinea(Const pCodigo, pNombre, pMinimo, pMaximo, pValor, pExistencia, pTotal : String);
    Public
      Constructor Create(pCNX: TConexion; Const pCodigo_Producto_Ini, pCodigo_Producto_Fin : String);
      Destructor Destroy;
  End;

{ TReport_Saldo_Inventario }
Constructor TReport_Saldo_Inventario.Create(pCNX: TConexion; Const pCodigo_Producto_Ini, pCodigo_Producto_Fin : String);
Begin
  Try
    FCNX := pCNX;
    FINPUT := TQUERY.Create(Nil);
    FOUTPUT := TQUERY.Create(Nil);
    FCONTADOR := 0;
    FINPUT.Connection := pCNX;
    FOUTPUT.Connection := pCNX;
    FCODIGO_PRODUCTO_INI := pCodigo_Producto_Ini;
    FCODIGO_PRODUCTO_FIN := pCodigo_Producto_Fin;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Saldo_Inventario', 'TReport_Saldo_Inventario.Create', E.Message);
    End;
  End;
End;

Function TReport_Saldo_Inventario.Inicializar_Reporte : Boolean;
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Saldo_Inventario', 'TReport_Saldo_Inventario.Inicializar_Reporte', E.Message);
    End;
  End;
End;

Procedure TReport_Saldo_Inventario.SaveData(Const pLine : String; pForced : Boolean = False);
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Saldo_Inventario', 'TReport_Saldo_Inventario.SaveData', E.Message);
    End;
  End;
End;

Function TReport_Saldo_Inventario.GetData : Boolean;
Begin
  Try
    FINPUT.Active := False;
    FINPUT.SQL.Clear;
    FINPUT.SQL.Add(' SELECT CODIGO_PRODUCTO, NOMBRE_PRODUCTO, VALOR_UNITARIO, STOCK_MINIMO, STOCK_MAXIMO, SUM(ENTRADA) AS ENTRADA, SUM(SALIDA) AS SALIDA ');
    FINPUT.SQL.Add(' FROM ');
    FINPUT.SQL.Add(' ( ');
    FINPUT.SQL.Add('   SELECT ');
    FINPUT.SQL.Add('           MOVTO.CODIGO_PRODUCTO ');
    FINPUT.SQL.Add('        ,  PROD.NOMBRE AS NOMBRE_PRODUCTO ');
    FINPUT.SQL.Add('        ,  PROD.VALOR_UNITARIO ');
    FINPUT.SQL.Add('        ,  PROD.STOCK_MINIMO ');
    FINPUT.SQL.Add('        ,  PROD.STOCK_MAXIMO ');
    FINPUT.SQL.Add('        ,  SUM(MOVTO.CANTIDAD) AS ENTRADA ');
    FINPUT.SQL.Add('        , 0 AS SALIDA ');
    FINPUT.SQL.Add('   FROM ' + Info_TablaGet(Id_TBL_Movto_Inventario).Name + ' MOVTO ' + FCNX.No_Lock );
    FINPUT.SQL.Add('   INNER JOIN ' + Info_TablaGet(Id_TBL_Producto).Name + ' PROD ' + FCNX.No_Lock );
    FINPUT.SQL.Add('   ON PROD.CODIGO_PRODUCTO = MOVTO.CODIGO_PRODUCTO ' );
    FINPUT.SQL.Add('   WHERE ' + FCNX.Trim_Sentence('MOVTO.CODIGO_PRODUCTO') + ' BETWEEN ' + QuotedStr(Trim(FCODIGO_PRODUCTO_INI)) + ' AND ' + QuotedStr(Trim(FCODIGO_PRODUCTO_FIN)));
    FINPUT.SQL.Add('   AND ' );
    FINPUT.SQL.Add('   ( ' );
    FINPUT.SQL.Add('      '    + FCNX.Trim_Sentence('MOVTO.CODIGO_DOCUMENTO') + ' = ' + QuotedStr(Trim(UserSession.DOCUMENTO_ENTRADA_DE_INVENTARIO)));
    FINPUT.SQL.Add('      OR ' + FCNX.Trim_Sentence('MOVTO.CODIGO_DOCUMENTO') + ' = ' + QuotedStr(Trim(UserSession.DOCUMENTO_DEVOLUCION_AL_INVENTARIO)));
    FINPUT.SQL.Add('   ) ' );
    FINPUT.SQL.Add('   GROUP BY MOVTO.CODIGO_PRODUCTO, PROD.NOMBRE, PROD.VALOR_UNITARIO, PROD.STOCK_MINIMO, PROD.STOCK_MAXIMO ');
    FINPUT.SQL.Add(' UNION ALL ');
    FINPUT.SQL.Add('   SELECT ');
    FINPUT.SQL.Add('           MOVTO.CODIGO_PRODUCTO ');
    FINPUT.SQL.Add('        ,  PROD.NOMBRE AS NOMBRE_PRODUCTO ');
    FINPUT.SQL.Add('        ,  PROD.VALOR_UNITARIO ');
    FINPUT.SQL.Add('        ,  PROD.STOCK_MINIMO ');
    FINPUT.SQL.Add('        ,  PROD.STOCK_MAXIMO ');
    FINPUT.SQL.Add('        , 0 AS ENTRADA ');
    FINPUT.SQL.Add('        , SUM(MOVTO.CANTIDAD) AS SALIDAD ');
    FINPUT.SQL.Add('   FROM ' + Info_TablaGet(Id_TBL_Movto_Inventario).Name + ' MOVTO ' + FCNX.No_Lock );
    FINPUT.SQL.Add('   INNER JOIN ' + Info_TablaGet(Id_TBL_Producto).Name + ' PROD ' + FCNX.No_Lock );
    FINPUT.SQL.Add('   ON PROD.CODIGO_PRODUCTO = MOVTO.CODIGO_PRODUCTO ' );
    FINPUT.SQL.Add('   WHERE ' + FCNX.Trim_Sentence('MOVTO.CODIGO_PRODUCTO') + ' BETWEEN ' + QuotedStr(Trim(FCODIGO_PRODUCTO_INI)) + ' AND ' + QuotedStr(Trim(FCODIGO_PRODUCTO_FIN)));
    FINPUT.SQL.Add('   AND ' + FCNX.Trim_Sentence('MOVTO.CODIGO_DOCUMENTO') + ' = ' + QuotedStr(Trim(UserSession.DOCUMENTO_SALIDA_DE_INVENTARIO)));
    FINPUT.SQL.Add('   GROUP BY MOVTO.CODIGO_PRODUCTO, PROD.NOMBRE, PROD.VALOR_UNITARIO, PROD.STOCK_MINIMO, PROD.STOCK_MAXIMO ');
    FINPUT.SQL.Add(') AS X ');
    FINPUT.SQL.Add(' GROUP BY CODIGO_PRODUCTO, NOMBRE_PRODUCTO, VALOR_UNITARIO, STOCK_MINIMO, STOCK_MAXIMO ');
    FINPUT.SQL.Add(' ORDER BY NOMBRE_PRODUCTO ');
    FINPUT.Active := True;
    Result := FINPUT.Active;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Saldo_Inventario', 'TReport_Saldo_Inventario.GetData', E.Message);
    End;
  End;
End;

Function TReport_Saldo_Inventario.Calcular_Saldo : Double;
Begin
  Result := 0;
  Try
    If FINPUT.Active Then
      Result := FINPUT.FieldByName('ENTRADA').AsFloat - FINPUT.FieldByName('SALIDA').AsFloat;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Saldo_Inventario', 'TReport_Saldo_Inventario.Calcular_Saldo', E.Message);
    End;
  End;
End;

Procedure TReport_Saldo_Inventario.SetLinea(Const pCodigo, pNombre, pMinimo, pMaximo, pValor, pExistencia, pTotal : String);
Var
  lBase : String;
Begin
  Try
   lBase := Copy(Justificar(pCodigo    , ' ', 20, 'D'), 01, 020) + ' ' +
            Copy(Justificar(pNombre    , ' ', 40, 'I'), 01, 040) + ' ' +
            Copy(Justificar(pMinimo    , ' ', 10, 'D'), 01, 010) + ' ' +
            Copy(Justificar(pMaximo    , ' ', 10, 'D'), 01, 010) + ' ' +
            Copy(Justificar(pValor     , ' ', 10, 'D'), 01, 010) + ' ' +
            Copy(Justificar(pExistencia, ' ', 10, 'D'), 01, 010) + ' ' +
            Copy(Justificar(pTotal     , ' ', 20, 'D'), 01, 020);
    SaveData(lBase);
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Saldo_Inventario', 'TReport_Saldo_Inventario.SetLinea', E.Message);
    End;
  End;
End;

Function TReport_Saldo_Inventario.PutData : Boolean;
Begin
  Result := False;
  Try
    If FINPUT.Active And (FINPUT.RecordCount > 0) Then
    Begin
      SaveData('SALDO DE INVENTARIO');
      SaveData('FECHA/HORA: ' + FormatDateTime('YYYY-MM-DD, HH:NN:SS', Now));
      SaveData('USUARIO: ' + UserSession.USER_NAME);
      SetLinea('CODIGO', 'DESCRIPCION', 'MINIMO', 'MAXIMO', 'VALOR', 'EXISTENCIA', 'TOTAL');
      SetLinea(StringOfChar('-', 20), StringOfChar('-', 50), StringOfChar('-', 20), StringOfChar('-', 20), StringOfChar('-', 20), StringOfChar('-', 20), StringOfChar('-', 20));
      FINPUT.First;
      While Not FINPUT.Eof Do
      Begin
        SetLinea(FINPUT.FieldByName('CODIGO_PRODUCTO').AsString,
                 FINPUT.FieldByName('NOMBRE_PRODUCTO').AsString,
                 FormatFloat('###,###.#0', FINPUT.FieldByName('STOCK_MINIMO'   ).AsFloat),
                 FormatFloat('###,###.#0', FINPUT.FieldByName('STOCK_MAXIMO'   ).AsFloat),
                 FormatFloat('###,###.#0', FINPUT.FieldByName('VALOR_UNITARIO' ).AsFloat),
                 FormatFloat('###,###.#0', FINPUT.FieldByName('ENTRADA').AsFloat - FINPUT.FieldByName('SALIDA').AsFloat),
                 FormatFloat('###,###.#0', (FINPUT.FieldByName('ENTRADA').AsFloat - FINPUT.FieldByName('SALIDA').AsFloat) * FINPUT.FieldByName('VALOR_UNITARIO').AsFloat));
        Result := True;
        FINPUT.Next;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Saldo_Inventario', 'TReport_Saldo_Inventario.PutData', E.Message);
    End;
  End;
End;

Destructor TReport_Saldo_Inventario.Destroy;
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Saldo_Inventario', 'TReport_Saldo_Inventario.Destroy', E.Message);
    End;
  End;
End;

Function Report_Saldo_Inventario_Saldo(pCNX: TConexion; Const pCodigo_Producto_Ini, pCodigo_Producto_Fin : String) : Double;
Var
  lRSI : TReport_Saldo_Inventario;
Begin
  Result := 0;
  Try
    lRSI := TReport_Saldo_Inventario.Create(pCNX, pCodigo_Producto_Ini, pCodigo_Producto_Fin);
    If lRSI.GetData Then
      Result := lRSI.Calcular_Saldo;
    FreeAndNil(lRSI);
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Saldo_Inventario', 'Report_Saldo_Inventario_Saldo', E.Message);
    End;
  End;
End;

Function Report_Saldo_Inventario_Reporte(pCNX: TConexion; Const pCodigo_Producto_Ini, pCodigo_Producto_Fin : String) : Boolean;
Var
  lRSI : TReport_Saldo_Inventario;
Begin
  Result := False;
  Try
    lRSI := TReport_Saldo_Inventario.Create(pCNX, pCodigo_Producto_Ini, pCodigo_Producto_Fin);
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Saldo_Inventario', 'Report_Saldo_Inventario_Reporte', E.Message);
    End;
  End;
End;

End.
