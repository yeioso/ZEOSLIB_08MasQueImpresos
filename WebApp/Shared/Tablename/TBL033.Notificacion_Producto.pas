unit TBL033.Notificacion_Producto;

interface
Uses
  UtConexion;

Function TBL033_Notificacion_Producto_Create(pCnx : TConexion) : Boolean;

implementation

Uses
  UtError,
  SysUtils,
  TBL000.Info_Tabla,
  UtilsIW.ManagerLog;

Function TBL033_Notificacion_Producto_Create(pCnx : TConexion) : Boolean;
Begin
  Result := True;
  If Not pCnx.TableExists(Info_TablaGet(Id_TBL_Notificacion_Producto).Name) Then
  Begin
    Try
      pCnx.TMP.SQL.Clear;
      pCnx.TMP.SQL.Add('   CREATE TABLE ' + Info_TablaGet(Id_TBL_Notificacion_Producto).Name + ' '               );
      pCnx.TMP.SQL.Add('   (  '                                                                                  );
      pCnx.TMP.SQL.Add('      CODIGO_USUARIO '       + pCNX.Return_Type(TYPE_VARCHAR) + ' (020) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      CODIGO_PRODUCTO '      + pCNX.Return_Type(TYPE_VARCHAR) + ' (020) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      FECHA_REGISTRO '       + pCNX.Return_Type(TYPE_VARCHAR) + ' (010) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      HORA_REGISTRO '        + pCNX.Return_Type(TYPE_VARCHAR) + ' (010) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      FECHA_CONFIRMADA '     + pCNX.Return_Type(TYPE_VARCHAR) + ' (010) ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      HORA_CONFIRMADA '      + pCNX.Return_Type(TYPE_VARCHAR) + ' (010) ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      NOMBRE '               + pCNX.Return_Type(TYPE_VARCHAR) + ' (255) ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      CANTIDAD  '            + pCNX.Return_Type(TYPE_FLOAT  ) + ' '       + ' NULL, '    );
      pCnx.TMP.SQL.Add('      ID_ACTIVO '            + pCNX.Return_Type(TYPE_VARCHAR) + ' (001) ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      TAG_INFO  '            + pCNX.Return_Type(TYPE_INT    ) + ' '       + ' NULL, '    );
      pCnx.TMP.SQL.Add('      PRIMARY KEY (CODIGO_USUARIO, CODIGO_PRODUCTO, FECHA_REGISTRO), '                   );
      pCnx.TMP.SQL.Add(' ' + pCNX.FOREINGKEY(Info_TablaGet(Id_TBL_Notificacion_Producto).Fk[1],'CODIGO_PRODUCTO', Info_TablaGet(Id_TBL_Producto).Name, 'CODIGO_PRODUCTO' ) + ', ');
      pCnx.TMP.SQL.Add(' ' + pCNX.FOREINGKEY(Info_TablaGet(Id_TBL_Notificacion_Producto).Fk[2],'CODIGO_USUARIO' , Info_TablaGet(Id_TBL_Usuario ).Name, 'CODIGO_USUARIO'  ) + '  ');
      pCnx.TMP.SQL.Add('   ) ');
      pCnx.TMP.ExecSQL;
    Except
      On E : Exception Do
      Begin
        Result := False;
        Utils_ManagerLog_Add('DATABASE', 'TBL033.Notificacion_Producto', 'TBL033_Notificacion_Producto_Create', E.Message);
      End;
    End;
  End;
End;

end.

