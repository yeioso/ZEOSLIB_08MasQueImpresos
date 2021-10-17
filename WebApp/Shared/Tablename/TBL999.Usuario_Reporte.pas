unit TBL999.Usuario_Reporte;

interface
Uses
  UtConexion;

Function TBL999_Usuario_Reporte_Create(pCnx : TConexion) : Boolean;

implementation

Uses
  UtLog,
  UtError,
  SysUtils,
  TBL000.Info_Tabla;

Function TBL999_Usuario_Reporte_Create(pCnx : TConexion) : Boolean;
Begin
  Result := True;
  if Not pCnx.TableExists(gInfo_Tablas[Id_TBL_Usuario_Reporte].Name) then
  Begin
    Try
      pCnx.TMP.SQL.Clear;
      pCnx.TMP.SQL.Add('   CREATE TABLE ' + gInfo_Tablas[Id_TBL_Usuario_Reporte].Name + '  '               );
      pCnx.TMP.SQL.Add('   (  '                                                                            );
      pCnx.TMP.SQL.Add('      CODIGO_USUARIO '  + pCnx.Return_Type(TYPE_VARCHAR) + '(020)'  + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      LINEA '           + pCnx.Return_Type(TYPE_VARCHAR) + '(005)'  + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      CONTENIDO '       + pCnx.Return_Type(TYPE_VARCHAR) + '(255)'  + ' NULL, '    );
      pCnx.TMP.SQL.Add('      PRIMARY KEY (CODIGO_USUARIO, LINEA), '                                       );
      pCnx.TMP.SQL.Add(' ' + pCnx.FOREINGKEY(gInfo_Tablas[Id_TBL_Usuario_Reporte].Fk[1], 'CODIGO_USUARIO', gInfo_Tablas[Id_TBL_Usuario].Name, 'CODIGO_USUARIO') + ' ');
      pCnx.TMP.SQL.Add('   ) '                                                                             );
      pCnx.TMP.ExecSQL;
    Except
      On E : Exception Do
      Begin
        Result := False;
        UtLog_Execute(MessageError(IE_ERROR_CREATE) + ' Tabla ' + gInfo_Tablas[Id_TBL_Usuario_Reporte].Name + ', TBL999_Usuario_Reporte_Create, ' + E.Message);
      End;
    End;
  End;
End;

end.
