unit TBL000.Info_Tabla;

interface
Uses
  Classes,
  Generics.Collections;

Const
  Id_TBL_Perfil                  = 000;
  Id_TBL_Permiso_App             = 001;
  Id_TBL_Usuario                 = 002;
  Id_TBL_Administrador_Documento = 003;
  Id_TBL_Area                    = 004;
  Id_TBL_Unidad_Medida           = 005;
  Id_TBL_Producto                = 006;
  Id_TBL_Tercero                 = 007;
  Id_TBL_Proyecto                = 008;
  Id_TBL_Orden_Produccion        = 009;
  Id_TBL_Explosion_Material      = 010;
  Id_TBL_Movto_Inventario        = 011;
  Id_TBL_Notificacion_Producto   = 012;
  Id_TBL_Usuario_Reporte         = 013;

Type
 TA_PK = Array Of String;
 TInfo_Tabla = Class
   Id        : Integer;
   Name      : String ;
   Caption   : String ;
   Fk        : Array[1..15] Of String;
   Pk        : TA_PK;
 End;
 TInfo_Tablas = TList<TInfo_Tabla>;

Function Info_TablaGet(Const pId : Integer) : TInfo_Tabla;

implementation
Uses
  SysUtils,
  UtFuncion;

Var
  gInfo_Tablas : TInfo_Tablas;

Function Info_TablaGet(Const pId : Integer) : TInfo_Tabla;
Begin
  Result := Nil;
  If (pId >= 0) And (pId < gInfo_Tablas.Count) Then
    Result := gInfo_Tablas[pId];
End;

Procedure Cargar_Tablas(Const pId : Integer; Const pIdTable, pName, pCaption : String; Const pPK : TA_PK);
Var
  lI : Integer;
  lK : TInfo_Tabla;
Begin
  lK := TInfo_Tabla.Create;
  gInfo_Tablas.Add(lK);
  lK.Id        := pId          ;
  lK.Name      := 'TBL' + pIdTable + '_' + pName;
  lK.Caption   := pCaption     ;
  lK.Pk        := pPK          ;
  For lI := Low(lK.Fk) To High(lK.Fk) Do
    lK.Fk[lI] := 'FK' + IntToStr(pId) + '_' + IntToStr(lI) + IntToStr(Random(100));
End;

Procedure Preparar_Tablas;
Begin
  Cargar_Tablas(Id_TBL_Perfil                 , '001', 'PERFIL'       , 'Perfiles'                  , ['CODIGO_PERFIL']);
  Cargar_Tablas(Id_TBL_Permiso_App            , '002', 'PERMISO_APP'  , 'Permisos de Aplicación'    , ['CODIGO_PERFIL', 'CONSECUTIVO']);
  Cargar_Tablas(Id_TBL_Usuario                , '003', 'USUARIO'      , 'Usuario'                   , ['CODIGO_USUARIO']);
  Cargar_Tablas(Id_TBL_Administrador_Documento, '004', 'ADM_DOCUMENTO', 'Administrador de Documento', ['PREFIJO']);
  Cargar_Tablas(Id_TBL_Area                   , '005', 'AREA'         , 'Area'                      , ['CODIGO_AREA']);
  Cargar_Tablas(Id_TBL_Unidad_Medida          , '006', 'UNIDAD_MEDIDA', 'Unidad de Medida'          , ['CODIGO_UNIDAD_MEDIDA']);
  Cargar_Tablas(Id_TBL_Producto               , '007', 'PRODUCTO'     , 'Producto'                  , ['CODIGO_PRODUCTO']);
  Cargar_Tablas(Id_TBL_Tercero                , '008', 'TERCERO'      , 'Tercero'                   , ['CODIGO_TERCERO']);
  Cargar_Tablas(Id_TBL_Proyecto               , '009', 'PROYECTO'     , 'Proyecto'                  , ['CODIGO_PROYECTO']);
  Cargar_Tablas(Id_TBL_Orden_Produccion       , '030', 'ORDEN_PROD'   , 'Orden de Produccion'       , ['PREFIJO', 'NUMERO']);
  Cargar_Tablas(Id_TBL_Explosion_Material     , '031', 'EXPLOSION_MAT', 'Explosión de Materieles'   , ['PREFIJO', 'NUMERO', 'CODIGO_PRODUCTO']);
  Cargar_Tablas(Id_TBL_Movto_Inventario       , '032', 'MOVTO_INV'    , 'Movimiento de Inventario'  , ['PREFIJO', 'NUMERO']);
  Cargar_Tablas(Id_TBL_Notificacion_Producto  , '033', 'NOTIFICA_PROD', 'Notificación de producto'  , ['CODIGO_USUARIO', 'CODIGO_PRODUCTO', 'FECHA_REGISTRO']);
  Cargar_Tablas(Id_TBL_Usuario_Reporte        , '999', 'USUARIO_REP'  , 'Reporte de Usuarios'       , ['CODIGO_USUARIO', 'LINEA']);
End;

Initialization
  gInfo_Tablas := TInfo_Tablas.Create;
  Preparar_Tablas;

end.
