unit TBL031.Explosion_Material;

interface
Uses
  UtConexion;

Function TBL031_Explosion_Material_Create(pCnx : TConexion) : Boolean;

implementation

Uses
  UtError,
  SysUtils,
  TBL000.Info_Tabla,
  UtilsIW.ManagerLog;

Function TBL031_Explosion_Material_Create(pCnx : TConexion) : Boolean;
Begin
  Result := True;
  If Not pCnx.TableExists(Info_TablaGet(Id_TBL_Explosion_Material).Name) Then
  Begin
    Try
      pCnx.TMP.SQL.Clear;
      pCnx.TMP.SQL.Add('   CREATE TABLE ' + Info_TablaGet(Id_TBL_Explosion_Material).Name + ' '                  );
      pCnx.TMP.SQL.Add('   (  '                                                                                  );
      pCnx.TMP.SQL.Add('      CODIGO_DOCUMENTO '     + pCNX.Return_Type(TYPE_VARCHAR) + ' (030) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      NUMERO  '              + pCNX.Return_Type(TYPE_INT    ) + ' '       + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      CODIGO_PRODUCTO '      + pCNX.Return_Type(TYPE_VARCHAR) + ' (020) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      CODIGO_USUARIO '       + pCNX.Return_Type(TYPE_VARCHAR) + ' (020) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      FECHA_PROGRAMADA '     + pCNX.Return_Type(TYPE_VARCHAR) + ' (010) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      FECHA_REGISTRO '       + pCNX.Return_Type(TYPE_VARCHAR) + ' (010) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      HORA_REGISTRO '        + pCNX.Return_Type(TYPE_VARCHAR) + ' (010) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      NOMBRE '               + pCNX.Return_Type(TYPE_VARCHAR) + ' (255) ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      CANTIDAD  '            + pCNX.Return_Type(TYPE_FLOAT  ) + ' '       + ' NULL, '    );
      pCnx.TMP.SQL.Add('      ID_ACTIVO '            + pCNX.Return_Type(TYPE_VARCHAR) + ' (001) ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      TAG_INFO  '            + pCNX.Return_Type(TYPE_INT    ) + ' '       + ' NULL, '    );
      pCnx.TMP.SQL.Add('      PRIMARY KEY (CODIGO_DOCUMENTO, NUMERO, CODIGO_PRODUCTO), '                         );
      pCnx.TMP.SQL.Add(' ' + pCNX.FOREINGKEY(Info_TablaGet(Id_TBL_Explosion_Material).Fk[1],'CODIGO_DOCUMENTO, NUMERO', Info_TablaGet(Id_TBL_Orden_Produccion       ).Name, 'CODIGO_DOCUMENTO, NUMERO') + ', ');
      pCnx.TMP.SQL.Add(' ' + pCNX.FOREINGKEY(Info_TablaGet(Id_TBL_Explosion_Material).Fk[2],'CODIGO_DOCUMENTO'        , Info_TablaGet(Id_TBL_Administrador_Documento).Name, 'CODIGO_DOCUMENTO') + ', ');
      pCnx.TMP.SQL.Add(' ' + pCNX.FOREINGKEY(Info_TablaGet(Id_TBL_Explosion_Material).Fk[3],'CODIGO_PRODUCTO'         , Info_TablaGet(Id_TBL_Producto               ).Name, 'CODIGO_PRODUCTO' ) + ', ');
      pCnx.TMP.SQL.Add(' ' + pCNX.FOREINGKEY(Info_TablaGet(Id_TBL_Explosion_Material).Fk[4],'CODIGO_USUARIO'          , Info_TablaGet(Id_TBL_Usuario                ).Name, 'CODIGO_USUARIO'  ) + '  ');

      pCnx.TMP.SQL.Add('   ) ');
      pCnx.TMP.ExecSQL;
    Except
      On E : Exception Do
      Begin
        Result := False;
        Utils_ManagerLog_Add('DATABASE', 'TBL031.Explosion_Material', 'TBL031_Explosion_Material_Create', E.Message);
      End;
    End;
  End;
End;

end.

