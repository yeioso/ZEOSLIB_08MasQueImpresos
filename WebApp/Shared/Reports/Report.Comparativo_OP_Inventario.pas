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
      FOUTPUT : TQUERY;
      FNUMERO : Integer;
      FCONTADOR : Integer;
      FCODIGO_DOCUMENTO : String;
      Function Inicializar_Reporte : Boolean;
      Procedure SaveData(Const pLine : String; pForced : Boolean = False);
      Function GetData : Boolean;
      Function PutData : Boolean;
      Procedure SetLinea(Const pProducto, pCantidad_EDM, pCantidad_INV, pEfectividad : String);
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
    FOUTPUT := TQUERY.Create(Nil);
    FCONTADOR := 0;
    FINPUT.Connection := pCNX;
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
    FINPUT.SQL.Add('     AND D.NUMERO = ' + IntToStr(FNUMERO));
    FINPUT.SQL.Add('     GROUP BY D.CODIGO_PRODUCTO ');
    FINPUT.SQL.Add(' ) AS X ');
    FINPUT.SQL.Add(' INNER JOIN ' + Info_TablaGet(Id_TBL_Producto).Name + ' P ON X.CODIGO_PRODUCTO = P.CODIGO_PRODUCTO ');
    FINPUT.SQL.Add(' WHERE (P.ID_SERVICIO IS NULL) Or (P.ID_SERVICIO = ' + QuotedStr('N') + ') ');
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


Procedure TReport_Comparativo_OP_Inventario.SetLinea(Const pProducto, pCantidad_EDM, pCantidad_INV, pEfectividad : String);
Var
  lBase : String;
Begin
  Try
   lBase := Copy(Justificar(pProducto      , ' ', 080, 'I'), 01, 080) + ' ' +
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
Begin
  Result := False;
  lSuma_EDM := 0;
  lSuma_INV := 0;
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
      SaveData('');
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
        Result := True;
        FINPUT.Next;
      End;
      lEFE := 0;
      If lSuma_EDM <> 0 Then
        lEFE := (100 * lSuma_INV)/lSuma_EDM;
      SetLinea(StringOfChar('=', 100), StringOfChar('=', 20), StringOfChar('=', 20), StringOfChar('=', 20));
      SetLinea('TOTAL DE LA ORDEN DE PRODUCION',
               FormatFloat('###,###,###.#0', lSuma_EDM),
               FormatFloat('###,###,###.#0', lSuma_INV),
               FormatFloat('###,###,###.#0', lEFE) + '%');
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
