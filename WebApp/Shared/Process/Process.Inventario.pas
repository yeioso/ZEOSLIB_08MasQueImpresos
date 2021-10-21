unit Process.Inventario;

interface
Uses
  UtConexion,
  System.Classes;

Type
  TInventario = Class
    Private
      FCNX : TConexion;
      Function Calcular_Registro(Const pNumero : Integer; Const pCodigo_Documento : String) : Double;
      Function Calcular_Saldo(Const pCodigo_Producto : String) : Double;
    Public
      Constructor Create;
  End;
Function Process_Inventario_Saldo(Const pCodigo_Producto : String; Const pNumero : Integer; Const pCodigo_Documento : String; Const pCantidad : Double) : Double;

implementation
Uses
  UtLog,
  System.SysUtils,
  ServerController,
  TBL000.Info_Tabla;


{ TInventario }
Constructor TInventario.Create;
Begin
  FCNX := UserSession.CNX;
End;

Function TInventario.Calcular_Registro(Const pNumero : Integer; Const pCodigo_Documento : String) : Double;
Begin
  Result := 0;
  Try
    FCNX.TMP.Active := False;
    FCNX.TMP.SQL.Clear;
    FCNX.TMP.SQL.Add(' SELECT CANTIDAD ');
    FCNX.TMP.SQL.Add(' FROM ' + gInfo_Tablas[Id_TBL_Movto_Inventario].Name + FCNX.No_Lock );
    FCNX.TMP.SQL.Add(' WHERE ' + FCNX.Trim_Sentence('CODIGO_DOCUMENTO') + ' = ' + QuotedStr(Trim(pCodigo_Documento)));
    FCNX.TMP.SQL.Add(' AND NUMERO  = ' + IntToStr(pNumero));
    FCNX.TMP.Active := True;
    If FCNX.TMP.Active And (FCNX.TMP.RecordCount > 0) Then
      Result := FCNX.TMP.FieldByName('CANTIDAD').AsFloat;
    FCNX.TMP.Active := False;
    FCNX.TMP.SQL.Clear;
    If (Trim(pCodigo_Documento) = Trim(UserSession.DOCUMENTO_SALIDA_DE_INVENTARIO)) Then
      Result := Result * (-1);
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TInventario.Calcular_Registro, ' + E.Message);
    End;
  End;
End;

Function TInventario.Calcular_Saldo(Const pCodigo_Producto : String) : Double;
Begin
  Result := 0;
  Try
    FCNX.TMP.Active := False;
    FCNX.TMP.SQL.Clear;
    FCNX.TMP.SQL.Add(' SELECT SUM(ENTRADA) AS ENTRADA, SUM(SALIDA) AS SALIDA ');
    FCNX.TMP.SQL.Add(' FROM ');
    FCNX.TMP.SQL.Add(' ( ');
    FCNX.TMP.SQL.Add('   SELECT ');
    FCNX.TMP.SQL.Add('          SUM(CANTIDAD) AS ENTRADA ');
    FCNX.TMP.SQL.Add('        , 0 AS SALIDA ');
    FCNX.TMP.SQL.Add('   FROM ' + gInfo_Tablas[Id_TBL_Movto_Inventario].Name + FCNX.No_Lock );
    FCNX.TMP.SQL.Add('   WHERE ' + FCNX.Trim_Sentence('CODIGO_PRODUCTO') + ' = ' + QuotedStr(Trim(pCodigo_Producto)));
    FCNX.TMP.SQL.Add('   AND ' );
    FCNX.TMP.SQL.Add('   ( ' );
    FCNX.TMP.SQL.Add('      '    + FCNX.Trim_Sentence('CODIGO_DOCUMENTO') + ' = ' + QuotedStr(Trim(UserSession.DOCUMENTO_ENTRADA_DE_INVENTARIO)));
    FCNX.TMP.SQL.Add('      OR ' + FCNX.Trim_Sentence('CODIGO_DOCUMENTO') + ' = ' + QuotedStr(Trim(UserSession.DOCUMENTO_DEVOLUCION_AL_INVENTARIO)));
    FCNX.TMP.SQL.Add('   ) ' );
    FCNX.TMP.SQL.Add(' UNION ALL ');
    FCNX.TMP.SQL.Add('   SELECT ');
    FCNX.TMP.SQL.Add('          0 AS SALIDA ');
    FCNX.TMP.SQL.Add('        , SUM(CANTIDAD) AS ENTRADA ');
    FCNX.TMP.SQL.Add('   FROM ' + gInfo_Tablas[Id_TBL_Movto_Inventario].Name + FCNX.No_Lock );
    FCNX.TMP.SQL.Add('   WHERE ' + FCNX.Trim_Sentence('CODIGO_PRODUCTO') + ' = ' + QuotedStr(Trim(pCodigo_Producto)));
    FCNX.TMP.SQL.Add('   AND ' + FCNX.Trim_Sentence('CODIGO_DOCUMENTO') + ' = ' + QuotedStr(Trim(UserSession.DOCUMENTO_SALIDA_DE_INVENTARIO)));
    FCNX.TMP.SQL.Add(') AS X ');
    FCNX.TMP.Active := True;
    If FCNX.TMP.Active And (FCNX.TMP.RecordCount > 0) Then
      Result := FCNX.TMP.FieldByName('ENTRADA').AsFloat - FCNX.TMP.FieldByName('SALIDA').AsFloat;
    FCNX.TMP.Active := False;
    FCNX.TMP.SQL.Clear;
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TInventario.Calcular_Saldo, ' + E.Message);
    End;
  End;
End;

Function Process_Inventario_Saldo(Const pCodigo_Producto : String; Const pNumero : Integer; Const pCodigo_Documento : String; Const pCantidad : Double) : Double;
Var
  lI : TInventario;
Begin
  lI := TInventario.Create;
  Result := lI.Calcular_Saldo(pCodigo_Producto);
//  If pNumero > 0 Then
//  Begin
//    Result := Result + lI.Calcular_Registro(pNumero, pCodigo_Documento);
//    If (Trim(pCodigo_Documento) = Trim(UserSession.DOCUMENTO_ENTRADA_DE_INVENTARIO   )) Or
//       (Trim(pCodigo_Documento) = Trim(UserSession.DOCUMENTO_DEVOLUCION_AL_INVENTARIO)) Then
//      Result := Result + pCantidad
//    Else
//      Result := Result + pCantidad;
//  End;
  FreeAndNil(lI);
End;


end.
