unit Report.Orden_Produccion;

interface
Uses
  UtConexion,
  System.Classes;

Function Report_Orden_Produccion_Reporte(pCNX: TConexion; Const pCodigo_Documento : String; Const pNumero : Integer) : Boolean;

implementation

Uses
  UtFuncion,
  System.SysUtils,
  ServerController,
  TBL000.Info_Tabla,
  UtilsIW.ManagerLog;

Type
  TReport_Orden_Produccion = Class
    Private
      FCNX : TConexion;
      FOUTPUT : TQUERY;
      FNUMERO : Integer;
      FCONTADOR : Integer;
      FINPUT_ENC : TQUERY;
      FINPUT_DET : TQUERY;
      FCODIGO_DOCUMENTO : String;
      Function Inicializar_Reporte : Boolean;
      Procedure SaveData(Const pLine : String; pForced : Boolean = False);
      Function GetData_Enc : Boolean;
      Function GetData_Det : Boolean;
      Function PutData : Boolean;
      Procedure SetLinea(Const pCodigo_Producto, pNombre_Producto, pFecha_Programada, pFecha_Registro, pHora_Registro, pCantidad, pValor_Unitario, pTotal  : String);
    Public
      Constructor Create(pCNX: TConexion; Const pCodigo_Documento : String; Const pNumero : Integer);
      Destructor Destroy;
  End;

{ TReport_Orden_Produccion }
Constructor TReport_Orden_Produccion.Create(pCNX: TConexion; Const pCodigo_Documento : String; Const pNumero : Integer);
Begin
  Try
    FCNX := pCNX;
    FOUTPUT := TQUERY.Create(Nil);
    FCONTADOR := 0;
    FINPUT_ENC := TQUERY.Create(Nil);
    FINPUT_DET := TQUERY.Create(Nil);
    FOUTPUT.Connection := pCNX;
    FINPUT_ENC.Connection := pCNX;
    FINPUT_DET.Connection := pCNX;
    FNUMERO := pNumero;
    FCODIGO_DOCUMENTO := pCodigo_Documento;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Orden_Produccion', 'TReport_Orden_Produccion.Create', E.Message);
    End;
  End;
End;

Function TReport_Orden_Produccion.Inicializar_Reporte : Boolean;
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Orden_Produccion', 'TReport_Orden_Produccion.Inicializar_Reporte', E.Message);
    End;
  End;
End;

Procedure TReport_Orden_Produccion.SaveData(Const pLine : String; pForced : Boolean = False);
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Orden_Produccion', 'TReport_Orden_Produccion.SaveData', E.Message);
    End;
  End;
End;

Function TReport_Orden_Produccion.GetData_Enc : Boolean;
Begin
  Try
    FINPUT_ENC.Active := False;
    FINPUT_ENC.SQL.Clear;
    FINPUT_ENC.SQL.Add('   SELECT ');
    FINPUT_ENC.SQL.Add('             D.CODIGO_DOCUMENTO ');
    FINPUT_ENC.SQL.Add('            ,D.NUMERO ');
    FINPUT_ENC.SQL.Add('            ,D.CODIGO_TERCERO ');
    FINPUT_ENC.SQL.Add('            ,T.NOMBRE AS NOMBRE_TERCERO ');
    FINPUT_ENC.SQL.Add('            ,D.CODIGO_PROYECTO ');
    FINPUT_ENC.SQL.Add('            ,P.NOMBRE AS NOMBRE_PROYECTO ');
    FINPUT_ENC.SQL.Add('            ,D.CODIGO_USUARIO ');
    FINPUT_ENC.SQL.Add('            ,U.NOMBRE AS NOMBRE_USUARIO ');
    FINPUT_ENC.SQL.Add('            ,D.FECHA_REGISTRO ');
    FINPUT_ENC.SQL.Add('            ,D.HORA_REGISTRO ');
    FINPUT_ENC.SQL.Add('            ,D.NOMBRE ');
    FINPUT_ENC.SQL.Add('            ,D.FECHA_INICIAL ');
    FINPUT_ENC.SQL.Add('            ,D.FECHA_FINAL ');
    FINPUT_ENC.SQL.Add('            ,D.DOCUMENTO_REFERENCIA ');
    FINPUT_ENC.SQL.Add('            ,D.DESCRIPCION ');
    FINPUT_ENC.SQL.Add('            ,D.CANTIDAD ');
    FINPUT_ENC.SQL.Add('   FROM ' + Info_TablaGet(Id_TBL_Orden_Produccion).Name + ' D ');
    FINPUT_ENC.SQL.Add('   INNER JOIN ' + Info_TablaGet(Id_TBL_Tercero ).Name + ' T ON D.CODIGO_TERCERO = T.CODIGO_TERCERO ');
    FINPUT_ENC.SQL.Add('   INNER JOIN ' + Info_TablaGet(Id_TBL_Proyecto).Name + ' P ON D.CODIGO_PROYECTO = P.CODIGO_PROYECTO ');
    FINPUT_ENC.SQL.Add('   INNER JOIN ' + Info_TablaGet(Id_TBL_Usuario).Name + ' U ON D.CODIGO_USUARIO = U.CODIGO_USUARIO ');
    FINPUT_ENC.SQL.Add('   WHERE ' + FCNX.Trim_Sentence('D.CODIGO_DOCUMENTO') + ' = ' + QuotedStr(Trim(FCODIGO_DOCUMENTO)));
    FINPUT_ENC.SQL.Add('   AND D.NUMERO  = ' + IntToStr(FNUMERO));
    FINPUT_ENC.Active := True;
    Result := FINPUT_ENC.Active;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Orden_Produccion', 'TReport_Orden_Produccion.GetData_Enc', E.Message);
    End;
  End;
End;

Function TReport_Orden_Produccion.GetData_Det : Boolean;
Begin
  Try
    FINPUT_DET.Active := False;
    FINPUT_DET.SQL.Clear;
    FINPUT_DET.SQL.Add('   SELECT ');
    FINPUT_DET.SQL.Add('           D.CODIGO_PRODUCTO ');
    FINPUT_DET.SQL.Add('          ,P.NOMBRE AS NOMBRE_PRODUCTO ');
    FINPUT_DET.SQL.Add('          ,D.CODIGO_USUARIO ');
    FINPUT_DET.SQL.Add('          ,U.NOMBRE AS NOMBRE_USUARIO ');
    FINPUT_DET.SQL.Add('          ,D.FECHA_PROGRAMADA ');
    FINPUT_DET.SQL.Add('          ,D.FECHA_REGISTRO ');
    FINPUT_DET.SQL.Add('          ,D.HORA_REGISTRO ');
    FINPUT_DET.SQL.Add('          ,D.NOMBRE ');
    FINPUT_DET.SQL.Add('          ,D.CANTIDAD ');
    FINPUT_DET.SQL.Add('          ,P.VALOR_UNITARIO AS VALOR_PRODUCTO ');
    FINPUT_DET.SQL.Add('          ,D.VALOR_UNITARIO AS VALOR_EXPLOSION ');
    FINPUT_DET.SQL.Add('   FROM ' + Info_TablaGet(Id_TBL_Explosion_Material).Name + ' D ');
    FINPUT_DET.SQL.Add('   INNER JOIN ' + Info_TablaGet(Id_TBL_Producto).Name + ' P ON D.CODIGO_PRODUCTO = P.CODIGO_PRODUCTO ');
    FINPUT_DET.SQL.Add('   INNER JOIN ' + Info_TablaGet(Id_TBL_Usuario ).Name + ' U ON D.CODIGO_USUARIO = U.CODIGO_USUARIO ');
    FINPUT_DET.SQL.Add('   WHERE ' + FCNX.Trim_Sentence('D.CODIGO_DOCUMENTO') + ' = ' + QuotedStr(Trim(FCODIGO_DOCUMENTO)));
    FINPUT_DET.SQL.Add('   AND D.NUMERO  = ' + IntToStr(FNUMERO));
    FINPUT_DET.Active := True;
    Result := FINPUT_DET.Active;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Orden_Produccion', 'TReport_Orden_Produccion.GetData_Det', E.Message);
    End;
  End;
End;


Procedure TReport_Orden_Produccion.SetLinea(Const pCodigo_Producto, pNombre_Producto, pFecha_Programada, pFecha_Registro, pHora_Registro, pCantidad, pValor_Unitario, pTotal  : String);
Var
  lBase : String;
Begin
  Try
   lBase := Copy(Justificar(pCodigo_Producto , ' ', 20, 'I'), 01, 020) + ' ' +
            Copy(Justificar(pNombre_Producto , ' ', 40, 'I'), 01, 040) + ' ' +
            Copy(Justificar(pFecha_Programada, ' ', 10, 'I'), 01, 010) + ' ' +
            Copy(Justificar(pFecha_Registro  , ' ', 11, 'I'), 01, 011) + ' ' +
            Copy(Justificar(pHora_Registro   , ' ', 11, 'I'), 01, 011) + ' ' +
            Copy(Justificar(pCantidad        , ' ', 10, 'D'), 01, 010) + ' ' +
            Copy(Justificar(pValor_Unitario  , ' ', 11, 'D'), 01, 011) + ' ' +
            Copy(Justificar(pTotal           , ' ', 15, 'D'), 01, 015);
    SaveData(lBase);
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Orden_Produccion', 'TReport_Orden_Produccion.SetLinea', E.Message);
    End;
  End;
End;

Function TReport_Orden_Produccion.PutData : Boolean;
Var
  lSuma : Double;
  lValor : Double;
Begin
  lSuma := 0;
  Result := False;
  Try
    If FINPUT_ENC.Active And (FINPUT_ENC.RecordCount > 0) Then
    Begin
      SaveData('ORDEN DE PRODUCCION / EXPLOSION DE MATERIALES');
      SaveData('FECHA/HORA: ' + FormatDateTime('YYYY-MM-DD, HH:NN:SS', Now));
      SaveData('USUARIO: ' + UserSession.USER_NAME);
      SaveData('');
      SaveData('ORDEN DE PRODUCCION: ' + IntToStr(FNUMERO));
      SaveData('DOCUMENTO REFERENCIA: ' + Trim(FINPUT_ENC.FieldByName('DOCUMENTO_REFERENCIA').AsString));
      SaveData('TERCERO: ' + Trim(FINPUT_ENC.FieldByName('CODIGO_TERCERO').AsString) + ' ' + Trim(FINPUT_ENC.FieldByName('NOMBRE_TERCERO').AsString));
      SaveData('PROYECTO: ' + Trim(FINPUT_ENC.FieldByName('CODIGO_PROYECTO').AsString) + ' ' + Trim(FINPUT_ENC.FieldByName('NOMBRE_PROYECTO').AsString));
      SaveData('USUARIO: ' + Trim(FINPUT_ENC.FieldByName('CODIGO_USUARIO').AsString) + ' ' + Trim(FINPUT_ENC.FieldByName('NOMBRE_USUARIO').AsString));
      SaveData('FECHA/HORA DEL REGISTRO: ' + Trim(FINPUT_ENC.FieldByName('FECHA_REGISTRO').AsString) + ' / ' + Trim(FINPUT_ENC.FieldByName('HORA_REGISTRO').AsString));
      SaveData('NOMBRE: ' + Trim(FINPUT_ENC.FieldByName('NOMBRE').AsString));
      SaveData('FECHA INICIAL: ' + Trim(FINPUT_ENC.FieldByName('FECHA_INICIAL').AsString));
      SaveData('FECHA FINAL: ' + Trim(FINPUT_ENC.FieldByName('FECHA_FINAL').AsString));
      SaveData('DESCRIPCION: ' + Trim(FINPUT_ENC.FieldByName('DESCRIPCION').AsString));
      SaveData('CANTIDAD: ' + FormatFloat('###,###,##0.#0', FINPUT_ENC.FieldByName('CANTIDAD').AsFloat));
      If FINPUT_DET.RecordCount > 0 Then
      Begin
        SetLinea('PRODUCTO', 'NOMBRE DEL PRODUCTO', 'PROGRAMADA', 'F.REGISTRO', 'H.REGISTRO', 'CANTIDAD', 'VALOR', 'TOTAL');
        SetLinea(StringOfChar('-', 20),
                 StringOfChar('-', 50),
                 StringOfChar('-', 10),
                 StringOfChar('-', 10),
                 StringOfChar('-', 10),
                 StringOfChar('-', 14),
                 StringOfChar('-', 14),
                 StringOfChar('-', 20));

        FINPUT_DET.First;
        While Not FINPUT_DET.Eof Do
        Begin
          lValor := FINPUT_DET.FieldByName('VALOR_EXPLOSION').AsFloat;
          If lValor <= 0 Then
            lValor := FINPUT_DET.FieldByName('VALOR_PRODUCTO').AsFloat;
          lSuma := lSuma + (FINPUT_DET.FieldByName('CANTIDAD').AsFloat * lValor);
          SetLinea(FINPUT_DET.FieldByName('CODIGO_PRODUCTO' ).AsString,
                   FINPUT_DET.FieldByName('NOMBRE_PRODUCTO' ).AsString,
                   FINPUT_DET.FieldByName('FECHA_PROGRAMADA').AsString,
                   FINPUT_DET.FieldByName('FECHA_REGISTRO'  ).AsString,
                   FINPUT_DET.FieldByName('HORA_REGISTRO'   ).AsString,
                   FormatFloat(        '###,##0.#0', FINPUT_DET.FieldByName('CANTIDAD').AsFloat),
                   FormatFloat(    '###,###,##0'   , lValor),
                   FormatFloat('###,###,###,##0'   , FINPUT_DET.FieldByName('CANTIDAD').AsFloat * lValor)
                   );
          FINPUT_DET.Next;
        End;

        SetLinea(StringOfChar('=', 20),
                 StringOfChar('=', 50),
                 StringOfChar('=', 10),
                 StringOfChar('=', 10),
                 StringOfChar('=', 10),
                 StringOfChar('=', 14),
                 StringOfChar('=', 14),
                 StringOfChar('=', 20));
        SetLinea(StringOfChar(' ', 20),
                 StringOfChar(' ', 50),
                 StringOfChar(' ', 10),
                 StringOfChar(' ', 10),
                 StringOfChar(' ', 10),
                 StringOfChar(' ', 14),
                 'TOTAL:',
                 FormatFloat('###,###,###,##0', lSuma));
      End;
      Result := True;
    End;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Orden_Produccion', 'TReport_Orden_Produccion.PutData', E.Message);
    End;
  End;
End;

Destructor TReport_Orden_Produccion.Destroy;
Begin
  Try
    If Assigned(FOUTPUT) Then
    Begin
      FOUTPUT.Active := False;
      FreeAndNil(FOUTPUT);
    End;

    If Assigned(FINPUT_ENC) Then
    Begin
      FINPUT_ENC.Active := False;
      FreeAndNil(FINPUT_ENC);
    End;

    If Assigned(FINPUT_DET) Then
    Begin
      FINPUT_DET.Active := False;
      FreeAndNil(FINPUT_DET);
    End;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Orden_Produccion', 'TReport_Orden_Produccion.Destroy', E.Message);
    End;
  End;
End;

Function Report_Orden_Produccion_Reporte(pCNX: TConexion; Const pCodigo_Documento : String; Const pNumero : Integer) : Boolean;
Var
  lRSI : TReport_Orden_Produccion;
Begin
  Result := False;
  Try
    lRSI := TReport_Orden_Produccion.Create(pCNX, pCodigo_Documento, pNumero);
    Result := lRSI.Inicializar_Reporte;
    If Result Then
      Result := lRSI.GetData_Enc;
    If Result Then
      Result := lRSI.GetData_Det;
    If Result Then
      Result := lRSI.PutData;
    FreeAndNil(lRSI);
  Except
    On E: Exception Do
    Begin
      Result := False;
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Orden_Produccion', 'Report_Orden_Produccion_Reporte', E.Message);
    End;
  End;
End;

End.
