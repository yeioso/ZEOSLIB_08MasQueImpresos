unit Report.Comparativo_OP_Inventario;

interface
Uses
  UtConexion,
  System.Classes;

Function Report_Comparativo_OP_Inventario_Reporte(pCNX: TConexion; Const pCodigo_Documento : String; Const pNumero : Integer) : Boolean;

implementation

Uses
  UtFuncion,
  System.SysUtils,
  ServerController,
  TBL000.Info_Tabla,
  UtilsIW.ManagerLog;

Type
  TReport_Comparativo_OP_Inventario = Class
    Private
      FCNX : TConexion;
      FINPUT : TQUERY;
      FINPUT2 : TQUERY;
      FINPUT3 : TQUERY;
      FOUTPUT : TQUERY;
      FNUMERO : Integer;
      FCONTADOR : Integer;
      FCODIGO_DOCUMENTO : String;
      Function Inicializar_Reporte : Boolean;
      Procedure SaveData(Const pLine : String; pForced : Boolean = False);
      Function GetData : Boolean;
      Function GetDetail(Const pCodigo_Producto : String) : Double;
      Function GetService : Double;
      Function PutData : Boolean;
      Procedure SetLinea(Const pProducto, pCantidad_EDM, pCantidad_INV, pEfectividad : String);
      Procedure SetLinea2(Const pTipo_Documento, pNumero, pFecha_Movimiento, pFecha_Registro, Hora, pCantidad, pValor, pTotal : String);
      Procedure SetLinea3(Const pCodigo_Producto, pNombre, pCantidad, pValor, pTotal : String);
      Procedure Informacion_Adicional;
    Public
      Constructor Create(pCNX: TConexion; Const pCodigo_Documento : String; Const pNumero : Integer);
      Destructor Destroy;
  End;

{ TReport_Comparativo_OP_Inventario }
Constructor TReport_Comparativo_OP_Inventario.Create(pCNX: TConexion; Const pCodigo_Documento : String; Const pNumero : Integer);
Begin
  Try
    FCNX := pCNX;
    FINPUT := TQUERY.Create(Nil);
    FINPUT2 := TQUERY.Create(Nil);
    FINPUT3 := TQUERY.Create(Nil);
    FOUTPUT := TQUERY.Create(Nil);
    FCONTADOR := 0;
    FINPUT.Connection := pCNX;
    FINPUT2.Connection := pCNX;
    FINPUT3.Connection := pCNX;
    FOUTPUT.Connection := pCNX;
    FNUMERO := pNumero;
    FCODIGO_DOCUMENTO := pCodigo_Documento;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Comparativo_OP_Inventario', 'TReport_Comparativo_OP_Inventario.Create', E.Message);
    End;
  End;
End;

Function TReport_Comparativo_OP_Inventario.Inicializar_Reporte : Boolean;
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Comparativo_OP_Inventario', 'TReport_Comparativo_OP_Inventario.Inicializar_Reporte', E.Message);
    End;
  End;
End;

Procedure TReport_Comparativo_OP_Inventario.SaveData(Const pLine : String; pForced : Boolean = False);
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Comparativo_OP_Inventario', 'TReport_Comparativo_OP_Inventario.SaveData', E.Message);
    End;
  End;
End;

Function TReport_Comparativo_OP_Inventario.GetData : Boolean;
Begin
  Try
    FINPUT.Active := False;
    FINPUT.SQL.Clear;
    FINPUT.SQL.Add(' SELECT  X.CODIGO_PRODUCTO  ');
    FINPUT.SQL.Add('        ,P.NOMBRE  ');
    FINPUT.SQL.Add('        ,SUM(X.CANTIDAD_EDM) AS CANTIDAD_EDM');
    FINPUT.SQL.Add('        ,SUM(X.CANTIDAD_INV) AS CANTIDAD_INV');
    FINPUT.SQL.Add(' FROM  ');
    FINPUT.SQL.Add(' (  ');
    FINPUT.SQL.Add('     SELECT  D.CODIGO_PRODUCTO ');
    FINPUT.SQL.Add('            ,SUM(D.CANTIDAD) AS CANTIDAD_EDM ');
    FINPUT.SQL.Add('            ,0 AS CANTIDAD_INV ');
    FINPUT.SQL.Add('     FROM ' + Info_TablaGet(Id_TBL_Explosion_Material).Name + ' D ');
    FINPUT.SQL.Add('     WHERE ' +FCNX.Trim_Sentence('D.CODIGO_DOCUMENTO') + ' = ' + QuotedStr(Trim(FCODIGO_DOCUMENTO)) );
    FINPUT.SQL.Add('     AND D.NUMERO = ' + IntToStr(FNUMERO));
    FINPUT.SQL.Add('     GROUP BY D.CODIGO_PRODUCTO ');
    FINPUT.SQL.Add('   UNION ALL ');
    FINPUT.SQL.Add('     SELECT  D.CODIGO_PRODUCTO ');
    FINPUT.SQL.Add('            ,0 AS CANTIDAD_EDM ');
    FINPUT.SQL.Add('            ,SUM(D.CANTIDAD) AS CANTIDAD_INV ');
    FINPUT.SQL.Add('     FROM ' + Info_TablaGet(Id_TBL_Movto_Inventario).Name + ' D  ');
    FINPUT.SQL.Add('     WHERE ' +FCNX.Trim_Sentence('D.CODIGO_DOCUMENTO') + ' = ' + QuotedStr(Trim(UserSession.DOCUMENTO_SALIDA_DE_INVENTARIO)) );
    FINPUT.SQL.Add('     AND ' +FCNX.Trim_Sentence('D.CODIGO_DOCUMENTO_OP') + ' = ' + QuotedStr(Trim(FCODIGO_DOCUMENTO)));
    FINPUT.SQL.Add('     AND D.NUMERO_OP = ' + IntToStr(FNUMERO));
    FINPUT.SQL.Add('     GROUP BY D.CODIGO_PRODUCTO ');
    FINPUT.SQL.Add('   UNION ALL ');
    FINPUT.SQL.Add('     SELECT  D.CODIGO_PRODUCTO ');
    FINPUT.SQL.Add('            ,0 AS CANTIDAD_EDM ');
    FINPUT.SQL.Add('            ,SUM(D.CANTIDAD * -1) AS CANTIDAD_INV ');
    FINPUT.SQL.Add('     FROM ' + Info_TablaGet(Id_TBL_Movto_Inventario).Name + ' D  ');
    FINPUT.SQL.Add('     WHERE ' +FCNX.Trim_Sentence('D.CODIGO_DOCUMENTO') + ' = ' + QuotedStr(Trim(UserSession.DOCUMENTO_DEVOLUCION_AL_INVENTARIO)));
    FINPUT.SQL.Add('     AND ' +FCNX.Trim_Sentence('D.CODIGO_DOCUMENTO_OP') + ' = ' + QuotedStr(Trim(FCODIGO_DOCUMENTO)));
    FINPUT.SQL.Add('     AND D.NUMERO_OP = ' + IntToStr(FNUMERO));
    FINPUT.SQL.Add('     GROUP BY D.CODIGO_PRODUCTO ');
    FINPUT.SQL.Add(' ) AS X ');
    FINPUT.SQL.Add(' INNER JOIN ' + Info_TablaGet(Id_TBL_Producto).Name + ' P ON X.CODIGO_PRODUCTO = P.CODIGO_PRODUCTO ');
//  FINPUT.SQL.Add(' WHERE (P.ID_SERVICIO IS NULL) Or (P.ID_SERVICIO = ' + QuotedStr('N') + ') ');
    FINPUT.SQL.Add(' GROUP BY X.CODIGO_PRODUCTO, P.NOMBRE ');
    FINPUT.SQL.Add(' ORDER BY P.NOMBRE ');
    FINPUT.Active := True;
    Result := FINPUT.Active;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Comparativo_OP_Inventario', 'TReport_Comparativo_OP_Inventario.GetData', E.Message);
    End;
  End;
End;

Function TReport_Comparativo_OP_Inventario.GetDetail(Const pCodigo_Producto : String) : Double;
Begin
  Result := 0;
  Try
    FINPUT2.Active := False;
    FINPUT2.SQL.Clear;
    FINPUT2.SQL.Add(' SELECT  D.CODIGO_PRODUCTO  ');
    FINPUT2.SQL.Add('        ,P.NOMBRE  ');
    FINPUT2.SQL.Add('        ,D.CODIGO_DOCUMENTO ');
    FINPUT2.SQL.Add('        ,D.NUMERO ');
    FINPUT2.SQL.Add('        ,D.FECHA_MOVIMIENTO ');
    FINPUT2.SQL.Add('        ,D.FECHA_REGISTRO ');
    FINPUT2.SQL.Add('        ,D.HORA_REGISTRO ');
    FINPUT2.SQL.Add('        ,D.CANTIDAD ');
    FINPUT2.SQL.Add('        ,D.VALOR_UNITARIO AS VALOR_MOVIMIENTO ');
    FINPUT2.SQL.Add('        ,P.VALOR_UNITARIO AS VALOR_PRODUCTO ');
    FINPUT2.SQL.Add(' FROM ' + Info_TablaGet(Id_TBL_Movto_Inventario).Name + ' D  ');
    FINPUT2.SQL.Add(' INNER JOIN ' + Info_TablaGet(Id_TBL_Producto).Name + ' P ON D.CODIGO_PRODUCTO = P.CODIGO_PRODUCTO ');
    FINPUT2.SQL.Add(' WHERE D.NUMERO_OP = ' + IntToStr(FNUMERO));
    FINPUT2.SQL.Add(' AND ' + FCNX.Trim_Sentence('D.CODIGO_DOCUMENTO_OP') + ' = ' + QuotedStr(Trim(UserSession.DOCUMENTO_ORDEN_DE_PRODUCCION)));
    FINPUT2.SQL.Add(' AND ' + FCNX.Trim_Sentence('D.CODIGO_PRODUCTO')     + ' = ' + QuotedStr(Trim(pCodigo_Producto)));
    FINPUT2.SQL.Add(' ORDER BY P.NOMBRE ');
    FINPUT2.Active := True;
    If FINPUT2.RecordCount > 0 Then
    Begin
      SetLinea2(StringOfChar('-', 30),
                StringOfChar('-', 30),
                StringOfChar('-', 30),
                StringOfChar('-', 30),
                StringOfChar('-', 30),
                StringOfChar('-', 30),
                StringOfChar('-', 30),
                StringOfChar('-', 30));
      SetLinea2('MOVIMIENTO',
                'NUMERO',
                'FECHA MOVT',
                'FECHA REG.',
                'HORA REG.' ,
                'CANTIDAD'  ,
                'VLR. UNIT.',
                'TOTAL');
      SetLinea2(StringOfChar('-', 30),
                StringOfChar('-', 30),
                StringOfChar('-', 30),
                StringOfChar('-', 30),
                StringOfChar('-', 30),
                StringOfChar('-', 30),
                StringOfChar('-', 30),
                StringOfChar('-', 30));
      FINPUT2.First;
      While Not FINPUT2.Eof Do
      Begin
        If Trim(UserSession.DOCUMENTO_SALIDA_DE_INVENTARIO) =  Trim(FINPUT2.FieldByName('CODIGO_DOCUMENTO').AsString) Then
          Result := Result + (FINPUT2.FieldByName('CANTIDAD').AsFloat * FINPUT2.FieldByName('VALOR_MOVIMIENTO').AsFloat);
        If Trim(UserSession.DOCUMENTO_DEVOLUCION_AL_INVENTARIO) =  Trim(FINPUT2.FieldByName('CODIGO_DOCUMENTO').AsString) Then
          Result := Result - (FINPUT2.FieldByName('CANTIDAD').AsFloat * FINPUT2.FieldByName('VALOR_MOVIMIENTO').AsFloat);
        SetLinea2(FINPUT2.FieldByName('CODIGO_DOCUMENTO').AsString,
                  FINPUT2.FieldByName('NUMERO').AsString,
                  FINPUT2.FieldByName('FECHA_MOVIMIENTO').AsString,
                  FINPUT2.FieldByName('FECHA_REGISTRO').AsString  ,
                  FINPUT2.FieldByName('HORA_REGISTRO').AsString   ,
                  FormatFloat('###,##0.#0', FINPUT2.FieldByName('CANTIDAD').AsFloat)        ,
                  FormatFloat('###,##0.#0', FINPUT2.FieldByName('VALOR_MOVIMIENTO').AsFloat),
                  FormatFloat('#,###,###,##0.#0', FINPUT2.FieldByName('CANTIDAD').AsFloat * FINPUT2.FieldByName('VALOR_MOVIMIENTO').AsFloat));
        FINPUT2.Next;
      End;
      SetLinea2(StringOfChar('=', 30),
                StringOfChar('=', 30),
                StringOfChar('=', 30),
                StringOfChar('=', 30),
                StringOfChar('=', 30),
                StringOfChar('=', 30),
                StringOfChar('=', 30),
                StringOfChar('=', 30));
      SetLinea2('',
                '',
                '',
                '',
                '',
                '',
                'TOTAL',
                FormatFloat('#,###,###,##0.#0', Result));
      SaveData('', True);
    End;
    FINPUT2.Active := False;
    FINPUT2.SQL.Clear;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Comparativo_OP_Inventario', 'TReport_Comparativo_OP_Inventario.GetDetail', E.Message);
    End;
  End;
End;

Function TReport_Comparativo_OP_Inventario.GetService : Double;
Var
  lSuma : Double;
Begin
  lSuma := 0;
  Result := 0;
  Try
    FINPUT3.Active := False;
    FINPUT3.SQL.Clear;
    FINPUT3.SQL.Add('     SELECT  D.CODIGO_PRODUCTO ');
    FINPUT3.SQL.Add('            ,P.NOMBRE ');
    FINPUT3.SQL.Add('            ,D.CANTIDAD ');
    FINPUT3.SQL.Add('            ,D.VALOR_UNITARIO ');
    FINPUT3.SQL.Add('     FROM ' + Info_TablaGet(Id_TBL_Explosion_Material).Name + ' D ');
    FINPUT3.SQL.Add('     INNER JOIN ' + Info_TablaGet(Id_TBL_Producto).Name + ' P ');
    FINPUT3.SQL.Add('     ON D.CODIGO_PRODUCTO = P.CODIGO_PRODUCTO');
    FINPUT3.SQL.Add('     WHERE ' +FCNX.Trim_Sentence('D.CODIGO_DOCUMENTO') + ' = ' + QuotedStr(Trim(FCODIGO_DOCUMENTO)) );
    FINPUT3.SQL.Add('     AND D.NUMERO = ' + IntToStr(FNUMERO));
//  FINPUT3.SQL.Add('     AND (P.ID_SERVICIO = ' + QuotedStr('S') + ') ');
    FINPUT3.Active := True;
    If FINPUT3.RecordCount > 0 Then
    Begin
      SaveData('', True);
      SaveData('EXPLOSION DE MATERIALES');
      SetLinea3(StringOfChar('-', 50), StringOfChar('-', 60), StringOfChar('-', 50), StringOfChar('-', 50), StringOfChar('-', 50));
      SetLinea3('CODIGO', 'NOMBRE','CANTIDAD','VALOR UNITARIO', 'TOTAL');
      SetLinea3(StringOfChar('-', 50), StringOfChar('-', 60), StringOfChar('-', 50), StringOfChar('-', 50), StringOfChar('-', 50));
      FINPUT3.First;
      While Not FINPUT3.Eof Do
      Begin
        lSuma := lSuma + FINPUT3.FieldByName('CANTIDAD').AsFloat * FINPUT3.FieldByName('VALOR_UNITARIO').AsFloat;
        Result := Result + FINPUT3.FieldByName('CANTIDAD').AsFloat * FINPUT3.FieldByName('VALOR_UNITARIO').AsFloat;
        SetLinea3(FINPUT3.FieldByName('CODIGO_PRODUCTO').AsString,
                  FINPUT3.FieldByName('NOMBRE').AsString,
                  FormatFloat('###,###,##0.#0', FINPUT3.FieldByName('CANTIDAD').AsFloat),
                  FormatFloat('###,###,##0.#0', FINPUT3.FieldByName('VALOR_UNITARIO').AsFloat),
                  FormatFloat('###,###,##0.#0', FINPUT3.FieldByName('CANTIDAD').AsFloat * FINPUT3.FieldByName('VALOR_UNITARIO').AsFloat));
        FINPUT3.Next;
      End;
      SetLinea3(StringOfChar('=', 50), StringOfChar('=', 60), StringOfChar('=', 50), StringOfChar('=', 50), StringOfChar('=', 50));
      SetLinea3('', '','','TOTAL', FormatFloat('###,###,##0.#0', lSuma));
    End;
    SaveData('', True);
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Comparativo_OP_Inventario', 'TReport_Comparativo_OP_Inventario.GetService', E.Message);
    End;
  End;
End;


Procedure TReport_Comparativo_OP_Inventario.SetLinea(Const pProducto, pCantidad_EDM, pCantidad_INV, pEfectividad : String);
Var
  lBase : String;
Begin
  Try
   lBase := Copy(Justificar(pProducto      , ' ', 099, 'I'), 01, 099) + ' ' +
            Copy(Justificar(pCantidad_EDM  , ' ', 014, 'D'), 01, 014) + ' ' +
            Copy(Justificar(pCantidad_INV  , ' ', 014, 'D'), 01, 014) + ' ' +
            Copy(Justificar(pEfectividad   , ' ', 014, 'D'), 01, 014);
    SaveData(lBase);
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Comparativo_OP_Inventario', 'TReport_Comparativo_OP_Inventario.SetLinea', E.Message);
    End;
  End;
End;

Procedure TReport_Comparativo_OP_Inventario.SetLinea2(Const pTipo_Documento, pNumero, pFecha_Movimiento, pFecha_Registro, Hora, pCantidad, pValor, pTotal : String);
Var
  lBase : String;
Begin
  Try
   lBase := StringOfChar(' ', 40) +
            Copy(Justificar(pTipo_Documento  , ' ', 025, 'I'), 01, 025) + ' ' +
            Copy(Justificar(pNumero          , ' ', 006, 'I'), 01, 006) + ' ' +
            Copy(Justificar(pFecha_Movimiento, ' ', 010, 'D'), 01, 010) + ' ' +
            Copy(Justificar(pFecha_Registro  , ' ', 010, 'D'), 01, 010) + ' ' +
            Copy(Justificar(Hora             , ' ', 010, 'D'), 01, 010) + ' ' +
            Copy(Justificar(pCantidad        , ' ', 010, 'D'), 01, 010) + ' ' +
            Copy(Justificar(pValor           , ' ', 010, 'D'), 01, 010) + ' ' +
            Copy(Justificar(pTotal           , ' ', 016, 'D'), 01, 016);
    SaveData(lBase);
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Comparativo_OP_Inventario', 'TReport_Comparativo_OP_Inventario.SetLinea', E.Message);
    End;
  End;
End;

Procedure TReport_Comparativo_OP_Inventario.SetLinea3(Const pCodigo_Producto, pNombre, pCantidad, pValor, pTotal : String);
Var
  lBase : String;
Begin
  Try
   lBase := StringOfChar(' ', 10) +
            Copy(Justificar(pCodigo_Producto, ' ', 020, 'I'), 01, 020) + ' ' +
            Copy(Justificar(pNombre         , ' ', 055, 'I'), 01, 055) + ' ' +
            Copy(Justificar(pCantidad       , ' ', 010, 'D'), 01, 010) + ' ' +
            Copy(Justificar(pValor          , ' ', 020, 'D'), 01, 020) + ' ' +
            Copy(Justificar(pTotal          , ' ', 025, 'D'), 01, 025);
    SaveData(lBase);
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Comparativo_OP_Inventario', 'TReport_Comparativo_OP_Inventario.SetLinea', E.Message);
    End;
  End;
End;

Procedure TReport_Comparativo_OP_Inventario.Informacion_Adicional;
Begin
  Try
    FCNX.TMP.Active := False;
    FCNX.TMP.SQL.Clear;
    FCNX.TMP.SQL.Add('   SELECT ');
    FCNX.TMP.SQL.Add('             D.CODIGO_DOCUMENTO ');
    FCNX.TMP.SQL.Add('            ,D.NUMERO ');
    FCNX.TMP.SQL.Add('            ,D.CODIGO_TERCERO ');
    FCNX.TMP.SQL.Add('            ,T.NOMBRE AS NOMBRE_TERCERO ');
    FCNX.TMP.SQL.Add('            ,D.CODIGO_PROYECTO ');
    FCNX.TMP.SQL.Add('            ,P.NOMBRE AS NOMBRE_PROYECTO ');
    FCNX.TMP.SQL.Add('            ,D.CODIGO_USUARIO ');
    FCNX.TMP.SQL.Add('            ,U.NOMBRE AS NOMBRE_USUARIO ');
    FCNX.TMP.SQL.Add('            ,D.FECHA_REGISTRO ');
    FCNX.TMP.SQL.Add('            ,D.HORA_REGISTRO ');
    FCNX.TMP.SQL.Add('            ,D.NOMBRE ');
    FCNX.TMP.SQL.Add('            ,D.FECHA_INICIAL ');
    FCNX.TMP.SQL.Add('            ,D.FECHA_FINAL ');
    FCNX.TMP.SQL.Add('            ,D.DOCUMENTO_REFERENCIA ');
    FCNX.TMP.SQL.Add('            ,D.DESCRIPCION ');
    FCNX.TMP.SQL.Add('            ,D.CANTIDAD ');
    FCNX.TMP.SQL.Add('   FROM ' + Info_TablaGet(Id_TBL_Orden_Produccion).Name + ' D ');
    FCNX.TMP.SQL.Add('   INNER JOIN ' + Info_TablaGet(Id_TBL_Tercero ).Name + ' T ON D.CODIGO_TERCERO = T.CODIGO_TERCERO ');
    FCNX.TMP.SQL.Add('   INNER JOIN ' + Info_TablaGet(Id_TBL_Proyecto).Name + ' P ON D.CODIGO_PROYECTO = P.CODIGO_PROYECTO ');
    FCNX.TMP.SQL.Add('   INNER JOIN ' + Info_TablaGet(Id_TBL_Usuario).Name + ' U ON D.CODIGO_USUARIO = U.CODIGO_USUARIO ');
    FCNX.TMP.SQL.Add('   WHERE ' + FCNX.Trim_Sentence('D.CODIGO_DOCUMENTO') + ' = ' + QuotedStr(Trim(FCODIGO_DOCUMENTO)));
    FCNX.TMP.SQL.Add('   AND D.NUMERO  = ' + IntToStr(FNUMERO));
    FCNX.TMP.Active := True;
    If FCNX.TMP.Active And (FCNX.TMP.RecordCount > 0) Then
    Begin
      SaveData('ORDEN DE PRODUCCION: ' + Trim(FCNX.TMP.FieldByName('DOCUMENTO_REFERENCIA').AsString));
      SaveData('TERCERO: ' + Trim(FCNX.TMP.FieldByName('CODIGO_TERCERO').AsString) + ' ' + Trim(FCNX.TMP.FieldByName('NOMBRE_TERCERO').AsString));
      SaveData('PROYECTO: ' + Trim(FCNX.TMP.FieldByName('CODIGO_PROYECTO').AsString) + ' ' + Trim(FCNX.TMP.FieldByName('NOMBRE_PROYECTO').AsString));
      SaveData('USUARIO: ' + Trim(FCNX.TMP.FieldByName('CODIGO_USUARIO').AsString) + ' ' + Trim(FCNX.TMP.FieldByName('NOMBRE_USUARIO').AsString));
      SaveData('FECHA/HORA DEL REGISTRO: ' + Trim(FCNX.TMP.FieldByName('FECHA_REGISTRO').AsString) + ' / ' + Trim(FCNX.TMP.FieldByName('HORA_REGISTRO').AsString));
      SaveData('NOMBRE: ' + Trim(FCNX.TMP.FieldByName('NOMBRE').AsString));
      SaveData('FECHA INICIAL: ' + Trim(FCNX.TMP.FieldByName('FECHA_INICIAL').AsString));
      SaveData('FECHA FINAL: ' + Trim(FCNX.TMP.FieldByName('FECHA_FINAL').AsString));
      SaveData('DESCRIPCION: ' + Trim(FCNX.TMP.FieldByName('DESCRIPCION').AsString));
      SaveData('CANTIDAD: ' + FormatFloat('###,###,##0.#0', FCNX.TMP.FieldByName('CANTIDAD').AsFloat));
    End;
    FCNX.TMP.Active := False;
    FCNX.TMP.SQL.Clear;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Comparativo_OP_Inventario', 'TReport_Comparativo_OP_Inventario.Informacion_Adicional', E.Message);
    End;
  End;
End;

Function TReport_Comparativo_OP_Inventario.PutData : Boolean;
Var
  lEFE : Double;
  lSuma_EDM : Double;
  lSuma_INV : Double;
  lValor_Costo : Double;
Begin
  Result := False;
  lSuma_EDM := 0;
  lSuma_INV := 0;
  lValor_Costo := 0;
  Try
    If FINPUT.Active And (FINPUT.RecordCount > 0) Then
    Begin
      SaveData('EXPLOSION DE MATERIALES VERSUS INVENTARIO POR ORDEN DE PRODUCCION');
      SaveData('FECHA/HORA: ' + FormatDateTime('YYYY-MM-DD, HH:NN:SS', Now));
      SaveData('USUARIO: ' + UserSession.USER_NAME);
      SaveData('E.D.M: EXPLOSION DE MATERIALES');
      SaveData('FECHA/HORA: ' + FormatDateTime('YYYY-MM-DD / HH:NN:SS.Z', Now));
      SaveData('NUMERO: ' + Trim(FormatFloat('###,###,#0', FNUMERO)));
      Informacion_Adicional;
      SaveData('', True);
      SetLinea('PRODUCTO', 'E.D.M', 'INVENTARIO', 'EFECTIVIDAD');
      SetLinea(StringOfChar('-', 100), StringOfChar('-', 20), StringOfChar('-', 20), StringOfChar('-', 20));
      FINPUT.First;
      While Not FINPUT.Eof Do
      Begin
        lEFE := 0;
        If FINPUT.FieldByName('CANTIDAD_EDM').AsFloat <> 0 Then
          lEFE := (100 * FINPUT.FieldByName('CANTIDAD_INV').AsFloat)/FINPUT.FieldByName('CANTIDAD_EDM').AsFloat;
        SetLinea(FINPUT.FieldByName('CODIGO_PRODUCTO').AsString + ',' + FINPUT.FieldByName('NOMBRE').AsString,
                 FormatFloat('###,###,###.#0', FINPUT.FieldByName('CANTIDAD_EDM').AsFloat),
                 FormatFloat('###,###,###.#0', FINPUT.FieldByName('CANTIDAD_INV').AsFloat),
                 FormatFloat('###,###,###.#0', lEFE) + '%');
        lSuma_EDM := lSuma_EDM + FINPUT.FieldByName('CANTIDAD_EDM').AsFloat;
        lSuma_INV := lSuma_INV + FINPUT.FieldByName('CANTIDAD_INV').AsFloat;
        lValor_Costo := lValor_Costo + GetDetail(FINPUT.FieldByName('CODIGO_PRODUCTO').AsString);
        Result := True;
        FINPUT.Next;
      End;
      lEFE := 0;
      If lSuma_EDM <> 0 Then
        lEFE := (100 * lSuma_INV)/lSuma_EDM;
//    lValor_Costo := lValor_Costo + GetService;
      GetService;
      SaveData('', True);
      SetLinea(StringOfChar('=', 100), StringOfChar('=', 20), StringOfChar('=', 20), StringOfChar('=', 20));
      SetLinea('', 'E.D.M', 'INVENTARIO', 'EFECTIVIDAD');
      SetLinea(StringOfChar('-', 100), StringOfChar('-', 20), StringOfChar('-', 20), StringOfChar('-', 20));
      SetLinea('TOTAL CANTIDADES DE LA ORDEN DE PRODUCION',
               FormatFloat('###,###,###.#0', lSuma_EDM),
               FormatFloat('###,###,###.#0', lSuma_INV),
               FormatFloat('###,###,###.#0', lEFE) + '%');
      SaveData('', True);
      SetLinea(StringOfChar('*', 100), StringOfChar('*', 20), StringOfChar('*', 20), StringOfChar('*', 20));
      SetLinea('TOTAL DE COSTO DE LA ORDEN DE PRODUCION', '', '', FormatFloat('###,###,###.#0', lValor_Costo));
      SetLinea(StringOfChar('*', 100), StringOfChar('*', 20), StringOfChar('*', 20), StringOfChar('*', 20));
    End;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Comparativo_OP_Inventario', 'TReport_Comparativo_OP_Inventario.PutData', E.Message);
    End;
  End;
End;

Destructor TReport_Comparativo_OP_Inventario.Destroy;
Begin
  Try
    If Assigned(FOUTPUT) Then
    Begin
      FOUTPUT.Active := False;
      FreeAndNil(FOUTPUT);
    End;

    If Assigned(FINPUT3) Then
    Begin
      FINPUT3.Active := False;
      FreeAndNil(FINPUT3);
    End;

    If Assigned(FINPUT2) Then
    Begin
      FINPUT2.Active := False;
      FreeAndNil(FINPUT2);
    End;

    If Assigned(FINPUT) Then
    Begin
      FINPUT.Active := False;
      FreeAndNil(FINPUT);
    End;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Comparativo_OP_Inventario', 'TReport_Comparativo_OP_Inventario.Destroy', E.Message);
    End;
  End;
End;

Function Report_Comparativo_OP_Inventario_Reporte(pCNX: TConexion; Const pCodigo_Documento : String; Const pNumero : Integer) : Boolean;
Var
  lRSI : TReport_Comparativo_OP_Inventario;
Begin
  Result := False;
  Try
    lRSI := TReport_Comparativo_OP_Inventario.Create(pCNX, pCodigo_Documento, pNumero);
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Comparativo_OP_Inventario', 'Report_Comparativo_OP_Inventario_Reporte', E.Message);
    End;
  End;
End;

End.
