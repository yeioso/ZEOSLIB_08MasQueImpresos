unit Report.Consumo_Area;

interface
Uses
  UtConexion,
  System.Classes;

Function Report_Consumo_Area_Reporte(pCNX: TConexion; Const pCodigo_Area, pFecha_Ini, pFecha_Fin : String; Const pId_Fecha : Integer) : Boolean;

implementation

Uses
  UtFuncion,
  System.SysUtils,
  ServerController,
  TBL000.Info_Tabla,
  UtilsIW.ManagerLog;

Type
  TReport_Consumo_Area = Class
    Private
      FCNX : TConexion;
      FINPUT : TQUERY;
      FOUTPUT : TQUERY;
      FCONTADOR : Integer;
      FID_FECHA : Integer;
      FFECHA_INI : String;
      FFECHA_FIN : String;
      FCODIGO_AREA : String;
      Function Inicializar_Reporte : Boolean;
      Procedure SaveData(Const pLine : String; pForced : Boolean = False);
      Function GetData : Boolean;
      Function PutData : Boolean;
      Procedure SetLinea(Const pFecha, pHora, pProducto, pTipo_Documento, pNro_Documento, pOP, pCantidad, pValor, pTotal : String);
    Public
      Constructor Create(pCNX: TConexion; Const pCodigo_Area, pFecha_Ini, pFecha_Fin : String; Const pId_Fecha : Integer);
      Destructor Destroy;
  End;

{ TReport_Consumo_Area }
Constructor TReport_Consumo_Area.Create(pCNX: TConexion; Const pCodigo_Area, pFecha_Ini, pFecha_Fin : String; Const pId_Fecha : Integer);
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
    FCODIGO_AREA := pCodigo_Area;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Consumo_Area', 'TReport_Consumo_Area.Create', E.Message);
    End;
  End;
End;

Function TReport_Consumo_Area.Inicializar_Reporte : Boolean;
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Consumo_Area', 'TReport_Consumo_Area.Inicializar_Reporte', E.Message);
    End;
  End;
End;

Procedure TReport_Consumo_Area.SaveData(Const pLine : String; pForced : Boolean = False);
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Consumo_Area', 'TReport_Consumo_Area.SaveData', E.Message);
    End;
  End;
End;

Function TReport_Consumo_Area.GetData : Boolean;
Begin
  Try
    FINPUT.Active := False;
    FINPUT.SQL.Clear;
    FINPUT.SQL.Add('   SELECT     D.CODIGO_DOCUMENTO ');
    FINPUT.SQL.Add('             ,A.NOMBRE AS NOMBRE_AREA ');
    If FID_FECHA = 0 Then
    Begin
      FINPUT.SQL.Add('           ,D.FECHA_REGISTRO ');
      FINPUT.SQL.Add('           ,D.HORA_REGISTRO ');
    End
    Else
    Begin
      FINPUT.SQL.Add('           ,D.FECHA_MOVIMIENTO ');
      FINPUT.SQL.Add('           ,D.FECHA_VENCIMIENTO ');
    End;
    FINPUT.SQL.Add('           ,D.CODIGO_DOCUMENTO ');
    FINPUT.SQL.Add('           ,D.NUMERO AS DOCUMENTO ');
    FINPUT.SQL.Add('           ,D.CODIGO_PRODUCTO ');
    FINPUT.SQL.Add('           ,P.NOMBRE AS NOMBRE_PRODUCTO ');
    FINPUT.SQL.Add('           ,U.NOMBRE AS NOMBRE_USUARIO ');
    FINPUT.SQL.Add('           ,D.NUMERO_OP ');
    FINPUT.SQL.Add('           ,D.CANTIDAD ');
    FINPUT.SQL.Add('           ,D.VALOR_UNITARIO ');
    FINPUT.SQL.Add('   FROM ' + Info_TablaGet(Id_TBL_Movto_Inventario).Name + ' D ');
    FINPUT.SQL.Add('   INNER JOIN ' + Info_TablaGet(Id_TBL_Producto).Name + ' P ON D.CODIGO_PRODUCTO = P.CODIGO_PRODUCTO ');
    FINPUT.SQL.Add('   INNER JOIN ' + Info_TablaGet(Id_TBL_Area).Name + ' A ON P.CODIGO_AREA = A.CODIGO_AREA ');
    FINPUT.SQL.Add('   INNER JOIN ' + Info_TablaGet(Id_TBL_Usuario).Name + ' U ON D.CODIGO_USUARIO = U.CODIGO_USUARIO ');
    FINPUT.SQL.Add('   WHERE P.CODIGO_AREA = ' + QuotedStr(FCODIGO_AREA) + ' ');
    FINPUT.SQL.Add('   AND ');
    FINPUT.SQL.Add('       (  ');
    FINPUT.SQL.Add('           '    + FCNX.Trim_Sentence('D.CODIGO_DOCUMENTO') + ' = ' + QuotedStr(Trim(UserSession.DOCUMENTO_SALIDA_DE_INVENTARIO    )) + ' ');
    FINPUT.SQL.Add('         AND  ' + FCNX.Trim_Sentence('D.CODIGO_DOCUMENTO') + ' = ' + QuotedStr(Trim(UserSession.DOCUMENTO_DEVOLUCION_AL_INVENTARIO)) + ' ');
    FINPUT.SQL.Add('       )  ');
    If FID_FECHA = 0 Then
    Begin
      FINPUT.SQL.Add('   AND D.FECHA_REGISTRO BETWEEN ' + QuotedStr(FFECHA_INI) + ' AND ' + QuotedStr(FFECHA_FIN) + ' ');
      FINPUT.SQL.Add('   ORDER BY  D.CODIGO_DOCUMENTO, A.NOMBRE, D.FECHA_REGISTRO,D.HORA_REGISTRO ');
    End
    Else
    Begin
      FINPUT.SQL.Add('   AND D.FECHA_MOVIMIENTO BETWEEN ' + QuotedStr(FFECHA_INI) + ' AND ' + QuotedStr(FFECHA_FIN) + ' ');
      FINPUT.SQL.Add('   ORDER BY  D.CODIGO_DOCUMENTO, A.NOMBRE, D.FECHA_MOVIMIENTO ');
    End;
    FINPUT.Active := True;
    Result := FINPUT.Active;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Consumo_Area', 'TReport_Consumo_Area.GetData', E.Message);
    End;
  End;
End;


Procedure TReport_Consumo_Area.SetLinea(Const pFecha, pHora, pProducto, pTipo_Documento, pNro_Documento, pOP, pCantidad, pValor, pTotal : String);
Var
  lPos : Integer;
  lBase : String;
  lMovto : String;
Begin
  lMovto := '';
  lPos := Pos(' ', pTipo_Documento);
  If lPos <= 0 Then
    lPos := Length(pTipo_Documento);
  lMovto := Copy(pTipo_Documento, 1, lPos);
  Try
   lBase := Copy(Justificar(pFecha         , ' ', 10, 'I'), 01, 010) + ' ' +
            Copy(Justificar(pHora          , ' ', 10, 'I'), 01, 010) + ' ' +
            Copy(Justificar(pProducto      , ' ', 40, 'I'), 01, 040) + ' ' +
            Copy(Justificar(lMovto         , ' ', 10, 'I'), 01, 010) + ' ' +
            Copy(Justificar(pNro_Documento , ' ', 10, 'I'), 01, 010) + ' ' +
            Copy(Justificar(pOP            , ' ', 05, 'I'), 01, 005) + ' ' +
            Copy(Justificar(pCantidad      , ' ', 10, 'D'), 01, 010) + ' ' +
            Copy(Justificar(pValor         , ' ', 10, 'D'), 01, 010) + ' ' +
            Copy(Justificar(pTotal         , ' ', 15, 'D'), 01, 015) ;
    SaveData(lBase);
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Consumo_Area', 'TReport_Consumo_Area.SetLinea', E.Message);
    End;
  End;
End;

Function TReport_Consumo_Area.PutData : Boolean;
Var
  lSuma : Double;
Begin
  lSuma := 0;
  Result := False;
  Try
    If FINPUT.Active And (FINPUT.RecordCount > 0) Then
    Begin
      SaveData('CONSUMO POR AREA');
      SaveData('FECHA/HORA: ' + FormatDateTime('YYYY-MM-DD, HH:NN:SS', Now));
      SaveData('USUARIO: ' + UserSession.USER_NAME);
      SaveData('AREA: ' + Trim(FINPUT.FieldByName('NOMBRE_AREA').AsString) + ' ENTRE ' + FFECHA_INI + ' Y ' + FFECHA_FIN);
      SaveData('');
      If FID_FECHA = 0 Then
      Begin
        SetLinea('FECHA', 'HORA', 'PRODUCTO', 'MOVIMIENTO', 'DOCUMENTO', 'O.P.', 'CANTIDAD', 'VALOR', 'TOTAL');
      End
      Else
      Begin
        SetLinea('FECHA', 'VENCIMIENT', 'PRODUCTO', 'MOVIMIENTO', 'DOCUMENTO', 'O.P.', 'CANTIDAD', 'VALOR', 'TOTAL');
      End;
      SetLinea(StringOfChar('-', 20), StringOfChar('-', 20), StringOfChar('-', 20), StringOfChar('-', 50), StringOfChar('-', 20), StringOfChar('-', 20), StringOfChar('-', 20), StringOfChar('-', 20), StringOfChar('-', 20));
      FINPUT.First;
      While Not FINPUT.Eof Do
      Begin
        lSuma := lSuma + (FINPUT.FieldByName('CANTIDAD').AsFloat * FINPUT.FieldByName('VALOR_UNITARIO').AsFloat);
        If FID_FECHA = 0 Then
        Begin
          SetLinea(FINPUT.FieldByName('FECHA_REGISTRO').AsString,
                   FINPUT.FieldByName('HORA_REGISTRO').AsString,
                   FINPUT.FieldByName('CODIGO_PRODUCTO').AsString + ',' + FINPUT.FieldByName('NOMBRE_PRODUCTO').AsString,
                   FINPUT.FieldByName('CODIGO_DOCUMENTO').AsString,
                   FINPUT.FieldByName('DOCUMENTO').AsString,
                   FINPUT.FieldByName('NUMERO_OP').AsString,
                   FormatFloat(        '###,##0.#0', FINPUT.FieldByName('CANTIDAD'      ).AsFloat),
                   FormatFloat(     '##,###,##0'   , FINPUT.FieldByName('VALOR_UNITARIO').AsFloat),
                   FormatFloat('###,###,###,##0'   , FINPUT.FieldByName('CANTIDAD').AsFloat * FINPUT.FieldByName('VALOR_UNITARIO').AsFloat));
        End
        Else
        Begin
          SetLinea(FINPUT.FieldByName('FECHA_MOVIMIENTO').AsString,
                   FINPUT.FieldByName('FECHA_VENCIMIENTO').AsString,
                   FINPUT.FieldByName('CODIGO_PRODUCTO').AsString + ',' + FINPUT.FieldByName('NOMBRE_PRODUCTO').AsString,
                   FINPUT.FieldByName('CODIGO_DOCUMENTO').AsString,
                   FINPUT.FieldByName('DOCUMENTO').AsString,
                   FINPUT.FieldByName('NUMERO_OP').AsString,
                   FormatFloat(        '###,##0.#0', FINPUT.FieldByName('CANTIDAD'      ).AsFloat),
                   FormatFloat(     '##,###,##0'   , FINPUT.FieldByName('VALOR_UNITARIO').AsFloat),
                   FormatFloat('###,###,###,##0'   , FINPUT.FieldByName('CANTIDAD').AsFloat * FINPUT.FieldByName('VALOR_UNITARIO').AsFloat));
        End;
        Result := True;
        FINPUT.Next;
      End;
      SetLinea(StringOfChar('=', 20), StringOfChar('=', 20), StringOfChar('=', 20), StringOfChar('=', 50), StringOfChar('=', 20), StringOfChar('=', 20), StringOfChar('=', 20), StringOfChar('=', 20), StringOfChar('=', 20));
      SetLinea(StringOfChar(' ', 20), StringOfChar(' ', 20), StringOfChar(' ', 20), StringOfChar(' ', 50), StringOfChar(' ', 20), StringOfChar(' ', 20), StringOfChar(' ', 20), 'TOTAL', FormatFloat('###,###,###,##0', lSuma));
    End;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Consumo_Area', 'TReport_Consumo_Area.PutData', E.Message);
    End;
  End;
End;

Destructor TReport_Consumo_Area.Destroy;
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Consumo_Area', 'TReport_Consumo_Area.Destroy', E.Message);
    End;
  End;
End;

Function Report_Consumo_Area_Reporte(pCNX: TConexion; Const pCodigo_Area, pFecha_Ini, pFecha_Fin : String; Const pId_Fecha : Integer) : Boolean;
Var
  lRSI : TReport_Consumo_Area;
Begin
  Result := False;
  Try
    lRSI := TReport_Consumo_Area.Create(pCNX, pCodigo_Area, pFecha_Ini, pFecha_Fin, pId_Fecha);
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Report.Consumo_Area', 'Report_Consumo_Area_Reporte', E.Message);
    End;
  End;
End;

End.
