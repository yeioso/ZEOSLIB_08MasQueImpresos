SELECT A.NOMBRE AS NOMBRE_AREA
      ,D.CODIGO_DOCUMENTO
      ,D.NUMERO AS DOCUMENTO
      ,D.CODIGO_PRODUCTO
      ,P.NOMBRE AS NOMBRE_PRODUCTO
      ,U.NOMBRE AS NOMBRE_USUARIO
      ,D.NUMERO_OP
      ,D.CANTIDAD
      ,D.VALOR_UNITARIO
FROM  [dbo].[TBL032_MOVTO_INV] D
INNER JOIN [dbo].[TBL007_PRODUCTO] P ON D.CODIGO_PRODUCTO = P.CODIGO_PRODUCTO
INNER JOIN [dbo].[TBL005_AREA] A ON P.CODIGO_AREA = A.CODIGO_AREA
INNER JOIN [dbo].[TBL003_USUARIO] U ON D.CODIGO_USUARIO = U.CODIGO_USUARIO
ORDER BY  A.NOMBRE, D.FECHA_REGISTRO,D.HORA_REGISTRO
