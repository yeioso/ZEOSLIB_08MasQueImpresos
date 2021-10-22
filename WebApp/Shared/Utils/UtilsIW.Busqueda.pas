unit UtilsIW.Busqueda;

interface
Uses
  System.Classes,
  UtBusqueda_WjQDBGrid;

Type

  TBusqueda_MQI_WjQDBGrid = Class(TBusqueda_WjQDBGrid)
    Public
      Constructor Create(AOwner : TComponent); Override;
      Procedure SetTSD(Const pId : Integer);
      Destructor Destroy; Override;
  End;

implementation
Uses
  StrUtils,
  TBL000.Info_Tabla;

{ TBusqueda_MQI_WjQDBGrid }
constructor TBusqueda_MQI_WjQDBGrid.Create(AOwner: TComponent);
begin
  inherited;

end;

Procedure TBusqueda_MQI_WjQDBGrid.SetTSD(Const pId : Integer);
Var
  lS : String;
begin
  Self.TABLA            := '';
  Self.FILTRO           := [];
  Self.CONECTOR         := [];
  Self.SENTENCIA        := '';
  Self.TITULO_ORIGEN    := [];
  Self.CAMPOS_ORIGEN    := [];
  Self.CAMPOS_LIKE      := [];
  Self.CAMPOS_ID        := [];
  Self.CAMPOS_ALIGNMENT := [];
  Self.SIZE_ORIGEN      := [];
  Self.CAMPOS_DESTINO   := [];
  Case pId Of
      Id_TBL_Administrador_Documento  : Begin
                                          Self.TABLA            := gInfo_Tablas[pId].Name;
                                          Self.TITULO_ORIGEN    := ['Código'                 , 'Nombre'                ];
                                          Self.CAMPOS_ORIGEN    := ['CODIGO_DOCUMENTO'       , 'NOMBRE'                ];
                                          Self.CAMPOS_LIKE      := ['CODIGO_DOCUMENTO'       , 'NOMBRE'                ];
                                          Self.CAMPOS_ID        := ['S'                      , 'N'                     ];
                                          Self.CAMPOS_ALIGNMENT := [TAlignment.taRightJustify, TAlignment.taLeftJustify];
                                          Self.SIZE_ORIGEN      := [0000000000000100         , 00000550                ];
                                          Self.CAMPOS_DESTINO   := ['CODIGO_DOCUMENTO'];
                                        End;
      Id_TBL_Perfil                   : Begin
                                          Self.TABLA            := gInfo_Tablas[pId].Name;
                                          Self.TITULO_ORIGEN    := ['Código'                 , 'Nombre'                ];
                                          Self.CAMPOS_ORIGEN    := ['CODIGO_PERFIL'          , 'NOMBRE'                ];
                                          Self.CAMPOS_LIKE      := ['CODIGO_PERFIL'          , 'NOMBRE'                ];
                                          Self.CAMPOS_ID        := ['S'                      , 'N'                     ];
                                          Self.CAMPOS_ALIGNMENT := [TAlignment.taRightJustify, TAlignment.taLeftJustify];
                                          Self.SIZE_ORIGEN      := [0000000000000100         ,                 00000550];
                                          Self.CAMPOS_DESTINO   := ['CODIGO_PERFIL'];
                                        End;
      Id_TBL_Usuario                  : Begin
                                          Self.TABLA            := gInfo_Tablas[pId].Name;
                                          Self.TITULO_ORIGEN    := ['Código'                 , 'Nombre'                ];
                                          Self.CAMPOS_ORIGEN    := ['CODIGO_USUARIO'         , 'NOMBRE'                ];
                                          Self.CAMPOS_LIKE      := ['CODIGO_USUARIO'         , 'NOMBRE'                ];
                                          Self.CAMPOS_ID        := ['S'                      , 'N'                     ];
                                          Self.CAMPOS_ALIGNMENT := [TAlignment.taRightJustify, TAlignment.taLeftJustify];
                                          Self.SIZE_ORIGEN      := [0000000000000100         , 00000550                ];
                                          Self.CAMPOS_DESTINO   := ['CODIGO_USUARIO'];
                                        End;
      Id_TBL_Area                     : Begin
                                          Self.TABLA            := gInfo_Tablas[pId].Name;
                                          Self.TITULO_ORIGEN    := ['Código'                 , 'Nombre'                ];
                                          Self.CAMPOS_ORIGEN    := ['CODIGO_AREA'            , 'NOMBRE'                ];
                                          Self.CAMPOS_LIKE      := ['CODIGO_AREA'            , 'NOMBRE'                ];
                                          Self.CAMPOS_ID        := ['S'                      , 'N'                     ];
                                          Self.CAMPOS_ALIGNMENT := [TAlignment.taRightJustify, TAlignment.taLeftJustify];
                                          Self.SIZE_ORIGEN      := [0000000000000100         , 00000550                ];
                                          Self.CAMPOS_DESTINO   := ['CODIGO_AREA'];
                                        End;
      Id_TBL_Unidad_Medida            : Begin
                                          Self.TABLA            := gInfo_Tablas[pId].Name;
                                          Self.TITULO_ORIGEN    := ['Código'                 , 'Nombre'                ];
                                          Self.CAMPOS_ORIGEN    := ['CODIGO_UNIDAD_MEDIDA'   , 'NOMBRE'                ];
                                          Self.CAMPOS_LIKE      := ['CODIGO_UNIDAD_MEDIDA'   , 'NOMBRE'                ];
                                          Self.CAMPOS_ID        := ['S'                      , 'N'                     ];
                                          Self.CAMPOS_ALIGNMENT := [TAlignment.taRightJustify, TAlignment.taLeftJustify];
                                          Self.SIZE_ORIGEN      := [0000000000000100         , 00000550                ];
                                          Self.CAMPOS_DESTINO   := ['CODIGO_UNIDAD_MEDIDA'];
                                        End;
      Id_TBL_Producto                 : Begin
                                          Self.TABLA            := gInfo_Tablas[pId].Name;
                                          Self.TITULO_ORIGEN    := ['Código'                 , 'Nombre'                ];
                                          Self.CAMPOS_ORIGEN    := ['CODIGO_PRODUCTO'        , 'NOMBRE'                ];
                                          Self.CAMPOS_LIKE      := ['CODIGO_PRODUCTO'        , 'NOMBRE'                ];
                                          Self.CAMPOS_ID        := ['S'                      , 'N'                     ];
                                          Self.CAMPOS_ALIGNMENT := [TAlignment.taRightJustify, TAlignment.taLeftJustify];
                                          Self.SIZE_ORIGEN      := [0000000000000150         , 00000450                ];
                                          Self.CAMPOS_DESTINO   := ['CODIGO_PRODUCTO'];
                                        End;
      Id_TBL_Tercero                  : Begin
                                          Self.TABLA            := gInfo_Tablas[pId].Name;
                                          Self.TITULO_ORIGEN    := ['Código'                 , 'Nombre'                ];
                                          Self.CAMPOS_ORIGEN    := ['CODIGO_TERCERO'         , 'NOMBRE'                ];
                                          Self.CAMPOS_LIKE      := ['CODIGO_TERCERO'         , 'NOMBRE'                ];
                                          Self.CAMPOS_ID        := ['S'                      , 'N'                     ];
                                          Self.CAMPOS_ALIGNMENT := [TAlignment.taRightJustify, TAlignment.taLeftJustify];
                                          Self.SIZE_ORIGEN      := [0000000000000150         , 00000450                ];
                                          Self.CAMPOS_DESTINO   := ['CODIGO_TERCERO'];
                                        End;
      Id_TBL_Proyecto                 : Begin
                                          Self.TABLA            := gInfo_Tablas[pId].Name;
                                          Self.TITULO_ORIGEN    := ['Código'                 , 'Nombre'                ];
                                          Self.CAMPOS_ORIGEN    := ['CODIGO_PROYECTO'        , 'NOMBRE'                ];
                                          Self.CAMPOS_LIKE      := ['CODIGO_PROYECTO'        , 'NOMBRE'                ];
                                          Self.CAMPOS_ID        := ['S'                      , 'N'                     ];
                                          Self.CAMPOS_ALIGNMENT := [TAlignment.taRightJustify, TAlignment.taLeftJustify];
                                          Self.SIZE_ORIGEN      := [0000000000000150         , 00000450                ];
                                          Self.CAMPOS_DESTINO   := ['CODIGO_PROYECTO'];
                                        End;
      Id_TBL_Orden_Produccion          ,
      Id_TBL_Movto_Inventario          : Begin
                                          Self.TABLA            := gInfo_Tablas[pId].Name;
                                          Self.TITULO_ORIGEN    := ['Numero'                 , 'Nombre'                ];
                                          Self.CAMPOS_ORIGEN    := ['NUMERO'                 , 'NOMBRE'                ];
                                          Self.CAMPOS_LIKE      := ['NUMERO'                 , 'NOMBRE'                ];
                                          Self.CAMPOS_ID        := ['S'                      , 'N'                     ];
                                          Self.CAMPOS_ALIGNMENT := [TAlignment.taRightJustify, TAlignment.taLeftJustify];
                                          Self.SIZE_ORIGEN      := [0000000000000100         , 00000550                ];
                                          Self.CAMPOS_DESTINO   := ['CODIGO_DOCUMENTO', 'NUMERO'];
                                        End;
  End;
  Self.SetGrid;
End;

destructor TBusqueda_MQI_WjQDBGrid.Destroy;
begin

  inherited;
end;

end.
