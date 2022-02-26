unit TBL032.Movto_Inventario;

interface
Uses
  UtConexion;

Function TBL032_Movto_Inventario_Create(pCnx : TConexion) : Boolean;

implementation

Uses
  UtError,
  SysUtils,
  TBL000.Info_Tabla,
  UtilsIW.ManagerLog;

Function TBL032_Movto_Inventario_Create(pCnx : TConexion) : Boolean;
Begin
  Result := True;
  if Not pCnx.TableExists(Info_TablaGet(Id_TBL_Movto_Inventario).Name) then
  Begin
    Try
      pCnx.TMP.SQL.Clear;
      pCnx.TMP.SQL.Add('   CREATE TABLE ' + Info_TablaGet(Id_TBL_Movto_Inventario).Name + ' '                   );
      pCnx.TMP.SQL.Add('   (  '                                                                                 );
      pCnx.TMP.SQL.Add('      CODIGO_DOCUMENTO '    + pCNX.Return_Type(TYPE_VARCHAR) + ' (030) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      NUMERO  '             + pCNX.Return_Type(TYPE_INT    ) + ' '       + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      CODIGO_DOCUMENTO_OP ' + pCNX.Return_Type(TYPE_VARCHAR) + ' (030) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      NUMERO_OP  '          + pCNX.Return_Type(TYPE_INT    ) + ' '       + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      CODIGO_PRODUCTO '     + pCNX.Return_Type(TYPE_VARCHAR) + ' (020) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      CODIGO_AREA '         + pCNX.Return_Type(TYPE_VARCHAR) + ' (010) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      CODIGO_TERCERO '      + pCNX.Return_Type(TYPE_VARCHAR) + ' (020) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      CODIGO_USUARIO '      + pCNX.Return_Type(TYPE_VARCHAR) + ' (020) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      FECHA_REGISTRO '      + pCNX.Return_Type(TYPE_VARCHAR) + ' (010) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      HORA_REGISTRO '       + pCNX.Return_Type(TYPE_VARCHAR) + ' (010) ' + ' NOT NULL, ');
      pCnx.TMP.SQL.Add('      NOMBRE '              + pCNX.Return_Type(TYPE_VARCHAR) + ' (255) ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      DESCRIPCION '         + pCNX.Return_Type(TYPE_TEXT   ) + ' '       + ' NULL, '    );
      pCnx.TMP.SQL.Add('      FECHA_MOVIMIENTO '    + pCNX.Return_Type(TYPE_VARCHAR) + ' (010) ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      FECHA_VENCIMIENTO '   + pCNX.Return_Type(TYPE_VARCHAR) + ' (010) ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      CANTIDAD '            + pCNX.Return_Type(TYPE_FLOAT  ) + ' '       + ' NULL, '    );
      pCnx.TMP.SQL.Add('      VALOR_UNITARIO '      + pCNX.Return_Type(TYPE_FLOAT  ) + ' '       + ' NULL, '    );
      pCnx.TMP.SQL.Add('      ID_ACTIVO '           + pCNX.Return_Type(TYPE_VARCHAR) + ' (001) ' + ' NULL, '    );
      pCnx.TMP.SQL.Add('      TAG_INFO '            + pCNX.Return_Type(TYPE_INT    ) + ' '       + ' NULL, '    );
      pCnx.TMP.SQL.Add('      PRIMARY KEY (CODIGO_DOCUMENTO, NUMERO), '                                         );
      pCnx.TMP.SQL.Add(' ' + pCNX.FOREINGKEY(Info_TablaGet(Id_TBL_Movto_Inventario).Fk[1],'CODIGO_DOCUMENTO'  , Info_TablaGet(Id_TBL_Administrador_Documento).Name, 'CODIGO_DOCUMENTO') + ', ');
      pCnx.TMP.SQL.Add(' ' + pCNX.FOREINGKEY(Info_TablaGet(Id_TBL_Movto_Inventario).Fk[2],'CODIGO_PRODUCTO'   , Info_TablaGet(Id_TBL_Producto               ).Name, 'CODIGO_PRODUCTO' ) + ', ');
      pCnx.TMP.SQL.Add(' ' + pCNX.FOREINGKEY(Info_TablaGet(Id_TBL_Movto_Inventario).Fk[4],'CODIGO_AREA'       , Info_TablaGet(Id_TBL_Area                   ).Name, 'CODIGO_AREA'     ) + ', ');
      pCnx.TMP.SQL.Add(' ' + pCNX.FOREINGKEY(Info_TablaGet(Id_TBL_Movto_Inventario).Fk[3],'CODIGO_TERCERO'    , Info_TablaGet(Id_TBL_Tercero                ).Name, 'CODIGO_TERCERO'  ) + ', ');
      pCnx.TMP.SQL.Add(' ' + pCNX.FOREINGKEY(Info_TablaGet(Id_TBL_Movto_Inventario).Fk[5],'CODIGO_USUARIO'    , Info_TablaGet(Id_TBL_Usuario                ).Name, 'CODIGO_USUARIO'  ) + ', ');
      pCnx.TMP.SQL.Add(' ' + pCNX.FOREINGKEY(Info_TablaGet(Id_TBL_Movto_Inventario).Fk[6],'CODIGO_DOCUMENTO_OP, NUMERO_OP', Info_TablaGet(Id_TBL_Orden_Produccion).Name, 'CODIGO_DOCUMENTO, NUMERO') + ' ');
      pCnx.TMP.SQL.Add('   ) ');
      pCnx.TMP.ExecSQL;
    Except
      On E : Exception Do
      Begin
        Result := False;
        Utils_ManagerLog_Add('DATABASE', 'TBL032.Movto_Inventario', 'TBL032_Movto_Inventario_Create', E.Message);
      End;
    End;
  End;
End;

end.
