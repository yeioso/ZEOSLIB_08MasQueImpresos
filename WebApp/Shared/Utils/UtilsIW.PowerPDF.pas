unit UtilsIW.PowerPDF;

interface
Uses
  UtType,
  PdfDoc,
  PReport,
  VCL.Forms,
  UtPowerPDF,
  PRJpegImage,
  System.Classes,
  Generics.Collections;

Type
  THEAD_MOVIMIENTO = Class(TBASE)
    Private

      FCUADRO_FECHA             : TPRRect ;

      FCLIENTE_LABEL_NOMBRE     : TPRLabel;
      FCLIENTE_DATO_NOMBRE      : TPRLabel;
      FCLIENTE_LABEL_DATE       : TPRLabel;

      FCLIENTE_LABEL_DIRECCION  : TPRLabel;
      FCLIENTE_DATO_DIRECCION   : TPRLabel;
      FCLIENTE_LABEL_DAY        : TPRLabel;
      FCLIENTE_LABEL_YEAR       : TPRLabel;
      FCLIENTE_LABEL_MONTH      : TPRLabel;

      FCLIENTE_LABEL_CONCEPTO   : TPRLabel;
      FCLIENTE_DATO_CONCEPTO    : TPRLabel;
      FCLIENTE_DATO_DAY         : TPRLabel;
      FCLIENTE_DATO_YEAR        : TPRLabel;
      FCLIENTE_DATO_MONTH       : TPRLabel;

      FCUADRO_CLIENTE_NOMBRE    : TPRRect ;
      FCUADRO_CLIENTE_CONCEPTO  : TPRRect ;
      FCUADRO_CLIENTE_DIRECCION : TPRRect ;
      Procedure SetComponents;
    Public
      Property DAY   : TPRLabel Read FCLIENTE_DATO_DAY   Write FCLIENTE_DATO_DAY  ;
      Property MONTH : TPRLabel Read  FCLIENTE_DATO_MONTH Write FCLIENTE_DATO_MONTH;
      Property YEAR  : TPRLabel Read FCLIENTE_DATO_YEAR Write FCLIENTE_DATO_YEAR ;

      Property NOMBRE : TPRLabel Read FCLIENTE_DATO_NOMBRE Write FCLIENTE_DATO_NOMBRE;
      Property CONCEPTO : TPRLabel Read FCLIENTE_DATO_CONCEPTO Write FCLIENTE_DATO_CONCEPTO;
      Property DIRECCION : TPRLabel Read FCLIENTE_DATO_DIRECCION Write FCLIENTE_DATO_DIRECCION;
      Constructor Create(AOwner: TComponent); Override;
      Destructor Destroy; Override;
  End;

  THEAD_FACTURA01 = Class(TBASE)
    Private
      FQR               : TPRImage;
      FCUADRO_QR        : TPRRect ;
      FLABEL_CUFE       : TPRLabel;
      FDATO_CUFE        : TPRLabel;
      FLABEL_CUDE       : TPRLabel;
      FDATO_CUDE        : TPRLabel;
      FLABEL_INFO_EXTRA : TPRLabel;
      FDATO_INFO_EXTRA  : TPRLabel;
      FLABEL_NOTADBCR   : TPRLabel;
      FDATO_NOTADBCR    : TPRLabel;
      FREGIMEN          : TPRLabel;
      FAUTORETENEDOR    : TPRLabel;
      FCONTRIBUYENTE    : TPRLabel;
      Procedure SetComponents;
    Public
      Property QR               : TPRImage     Read FQR               Write FQR              ;
      Property LABEL_CUFE       : TPRLabel     Read FLABEL_CUFE       Write FLABEL_CUFE      ;
      Property DATO_CUFE        : TPRLabel     Read FDATO_CUFE        Write FDATO_CUFE       ;
      Property LABEL_CUDE       : TPRLabel     Read FLABEL_CUDE       Write FLABEL_CUDE      ;
      Property DATO_CUDE        : TPRLabel     Read FDATO_CUDE        Write FDATO_CUDE       ;
      Property LABEL_INFO_EXTRA : TPRLabel     Read FLABEL_INFO_EXTRA Write FLABEL_INFO_EXTRA;
      Property DATO_INFO_EXTRA  : TPRLabel     Read FDATO_INFO_EXTRA  Write FDATO_INFO_EXTRA ;
      Property LABEL_NOTADBCR   : TPRLabel     Read FLABEL_NOTADBCR   Write FLABEL_NOTADBCR  ;
      Property DATO_NOTADBCR    : TPRLabel     Read FDATO_NOTADBCR    Write FDATO_NOTADBCR   ;
      Property REGIMEN          : TPRLabel     Read FREGIMEN          Write FREGIMEN         ;
      Property AUTORETENEDOR    : TPRLabel     Read FAUTORETENEDOR    Write FAUTORETENEDOR   ;
      Property CONTRIBUYENTE    : TPRLabel     Read FCONTRIBUYENTE    Write FCONTRIBUYENTE   ;
      Constructor Create(AOwner: TComponent); Override;
      Destructor Destroy; Override;
  End;

  THEAD_FACTURA02 = Class(TBASE)
    Private
      FCLIENTE_LABEL_NOMBRE            : TPRLabel;
      FCLIENTE_DATO_NOMBRE             : TPRLabel;

      FCLIENTE_LABEL_NIT               : TPRLabel;
      FCLIENTE_DATO_NIT                : TPRLabel;
      FCLIENTE_LABEL_FECHA_HORA_DOCTO  : TPRLabel;
      FCLIENTE_DATO_FECHA_HORA_DOCTO   : TPRLabel;

      FCLIENTE_LABEL_DIRECCION         : TPRLabel;
      FCLIENTE_DATO_DIRECCION          : TPRLabel;
      FCLIENTE_LABEL_FECHA_HORA_VENC   : TPRLabel;
      FCLIENTE_DATO_FECHA_HORA_VENC    : TPRLabel;

      FCLIENTE_LABEL_CIUDAD            : TPRLabel;
      FCLIENTE_DATO_CIUDAD             : TPRLabel;

      FCLIENTE_LABEL_FECHA_VALIDACION  : TPRLabel;
      FCLIENTE_DATO_FECHA_VALIDACION   : TPRLabel;

      FCLIENTE_LABEL_TELEFONO          : TPRLabel;
      FCLIENTE_DATO_TELEFONO           : TPRLabel;

      FCLIENTE_LABEL_OPERACION         : TPRLabel;
      FCLIENTE_DATO_OPERACION          : TPRLabel;

      FCLIENTE_LABEL_FORMA_PAGO        : TPRLabel;
      FCLIENTE_DATO_FORMA_PAGO         : TPRLabel;

      FCLIENTE_LABEL_MEDIO_PAGO        : TPRLabel;
      FCLIENTE_DATO_MEDIO_PAGO         : TPRLabel;

      FCLIENTE_INFO_EXTRA              : TPRLabel;

      FCLIENTE_LABEL_VENDEDOR          : TPRLabel;
      FCLIENTE_DATO_VENDEDOR           : TPRLabel;

//      FCUADRO_FECHA                    : TPRRect ;
//
      FCUADRO_CLIENTE_NOMBRE           : TPRRect ;
//      FCUADRO_CLIENTE_NIT              : TPRRect ;
//      FCUADRO_CLIENTE_DIRECCION        : TPRRect ;
//      FCUADRO_CLIENTE_CIUDAD           : TPRRect ;
//      FCUADRO_CLIENTE_TELEFONO         : TPRRect ;
//      FCUADRO_CLIENTE_OPERACION        : TPRRect ;
      Procedure SetComponents;
    Public
      Property CLIENTE_DATO_NOMBRE             : TPRLabel Read FCLIENTE_DATO_NOMBRE            Write FCLIENTE_DATO_NOMBRE            ;
      Property CLIENTE_DATO_NIT                : TPRLabel Read FCLIENTE_DATO_NIT               Write FCLIENTE_DATO_NIT               ;
      Property CLIENTE_DATO_DIRECCION          : TPRLabel Read FCLIENTE_DATO_DIRECCION         Write FCLIENTE_DATO_DIRECCION         ;
      Property CLIENTE_DATO_FECHA_HORA_DOCTO   : TPRLabel Read FCLIENTE_DATO_FECHA_HORA_DOCTO  Write FCLIENTE_DATO_FECHA_HORA_DOCTO  ;

      Property CLIENTE_DATO_CIUDAD             : TPRLabel Read FCLIENTE_DATO_CIUDAD            Write FCLIENTE_DATO_CIUDAD            ;
      Property CLIENTE_DATO_FECHA_VALIDACION   : TPRLabel Read FCLIENTE_DATO_FECHA_VALIDACION  Write FCLIENTE_DATO_FECHA_VALIDACION  ;
      Property CLIENTE_DATO_TELEFONO           : TPRLabel Read FCLIENTE_DATO_TELEFONO          Write FCLIENTE_DATO_TELEFONO          ;
      Property CLIENTE_DATO_OPERACION          : TPRLabel Read FCLIENTE_DATO_OPERACION         Write FCLIENTE_DATO_OPERACION         ;
      Property CLIENTE_DATO_FECHA_HORA_VENC    : TPRLabel Read FCLIENTE_DATO_FECHA_HORA_VENC   Write FCLIENTE_DATO_FECHA_HORA_VENC   ;

      Property CLIENTE_DATO_FORMA_PAGO         : TPRLabel Read FCLIENTE_DATO_FORMA_PAGO        Write FCLIENTE_DATO_FORMA_PAGO        ;
      Property CLIENTE_DATO_MEDIO_PAGO         : TPRLabel Read FCLIENTE_DATO_MEDIO_PAGO        Write FCLIENTE_DATO_MEDIO_PAGO        ;

      Property CLIENTE_INFO_EXTRA              : TPRLabel Read FCLIENTE_INFO_EXTRA             Write FCLIENTE_INFO_EXTRA             ;
      Property CLIENTE_DATO_VENDEDOR           : TPRLabel Read FCLIENTE_DATO_VENDEDOR          Write FCLIENTE_DATO_VENDEDOR          ;

      Constructor Create(AOwner: TComponent); Override;
      Destructor Destroy; Override;
  End;

  TDETAIL_ERCOL = Class(TBASE)
    Private
    Public
      Constructor Create(AOwner: TComponent); Override;
      Destructor Destroy; Override;
      procedure SetLine(Const pContenido : String; Const pBold : Boolean); Overload;
      procedure SetLine_Reparacion_Conversion(Const pLabel, pValue : String);
      procedure SetLine_Novedad(Const pDescripcion, pCantidad, pValor_Unitario, pSubtotal : String; Const pBold : Boolean);
      procedure SetLine_Entrada(Const pCodigo, pDescripcion, pBuenas, pAveriadas, pTotal : String; Const pBold : Boolean);
      procedure SetLine_Salida(Const pCodigo, pDescripcion, pCantidad : String; Const pBold : Boolean);
      procedure SetLine_Factura_Alquiler(Const pItems, pDesde, pHasta, pDescripcion, pCantidad, pSaldo, pUnidad_Medida, pTarifa, pDias, pValor_Unitario, pPorcentaje_IVA, pSubtotal : String; Const pBold : Boolean);
      procedure SetLine_Factura_Servicio(Const pItems, pFecha, pDescripcion, pCantidad, pUnidad_Medida, pValor_Unitario, pPorcentaje_IVA, pSubtotal : String; Const pBold : Boolean);
  End;

  TFOOT_MOVIMIENTO = Class(TBASE)
    Private
      FLINEA_TOP           : TPRRect ;
      FLABEL_DESPACHADO    : TPRLabel;
      FDATO_DESPACHADO     : TPRLabel;

      FLABEL_TRANSPORTADOR : TPRLabel;
      FDATO_TRANSPORTADOR  : TPRLabel;

      FLABEL_PLACAS        : TPRLabel;
      FDATO_PLACAS         : TPRLabel;

      FLABEL_FIRMA         : TPRLabel;
      FLINEA_FIRMA         : TPRRect ;
      FLABEL_CLIENTE       : TPRLabel;
      Procedure SetComponents;
    Public
      Property DATO_DESPACHADO    : TPRLabel Read FDATO_DESPACHADO    Write FDATO_DESPACHADO   ;
      Property DATO_TRANSPORTADOR : TPRLabel Read FDATO_TRANSPORTADOR Write FDATO_TRANSPORTADOR;
      Property DATO_PLACAS        : TPRLabel Read FDATO_PLACAS        Write FDATO_PLACAS       ;
      Constructor Create(AOwner: TComponent); Override;
      Destructor Destroy; Override;
  End;

  TFOOT_FACTURA01 = Class(TBASE)
    Private
      FLINEA_TOP           : TPRRect ;
      FLABEL_VALOR_BRUTO   : TPRLabel;
      FDATO_VALOR_BRUTO    : TPRLabel;
      FLABEL_DESCUENTO     : TPRLabel;
      FDATO_DESCUENTO      : TPRLabel;
      FLABEL_SUBTOTAL      : TPRLabel;
      FDATO_SUBTOTAL       : TPRLabel;
      FLABEL_IVA           : TPRLabel;
      FDATO_IVA            : TPRLabel;
      FLABEL_TOTAL         : TPRLabel;
      FDATO_TOTAL          : TPRLabel;
      Procedure SetComponents;
    Public
      Property DATO_VALOR_BRUTO : TPRLabel Read FDATO_VALOR_BRUTO Write FDATO_VALOR_BRUTO;
      Property DATO_DESCUENTO   : TPRLabel Read FDATO_DESCUENTO   Write FDATO_DESCUENTO  ;
      Property DATO_SUBTOTAL    : TPRLabel Read FDATO_SUBTOTAL    Write FDATO_SUBTOTAL   ;
      Property DATO_IVA         : TPRLabel Read FDATO_IVA         Write FDATO_IVA        ;
      Property DATO_TOTAL       : TPRLabel Read FDATO_TOTAL       Write FDATO_TOTAL      ;
      Constructor Create(AOwner: TComponent); Override;
      Destructor Destroy; Override;
      Procedure SetLine(Const pLeft, pWidth : Integer; Const pValue : String; pBold : Boolean = False);
  End;

  TFOOT_FACTURA02 = Class(TBASE)
    Private
      FLINEA_TOP           : TPRRect ;
      FLABEL_PREPARADO_POR : TPRLabel;
      FDATO_PREPARADO_POR  : TPRLabel;
      FLABEL_FIRMA         : TPRLabel;
      FLINEA_FIRMA         : TPRRect ;
      FLABEL_NIT_CC        : TPRLabel;
      Procedure SetComponents;
    Public
      Property DATO_PREPARADO_POR : TPRLabel Read FDATO_PREPARADO_POR Write FDATO_PREPARADO_POR;
      Constructor Create(AOwner: TComponent); Override;
      Destructor Destroy; Override;
      procedure SetLine(Const pValue : String; pBold: Boolean; pSize : Integer = 8; pAlignment : TAlignment = TAlignment.taLeftJustify);
  End;

  TFOOT_ERCOL = Class(TBASE)
    Private
      FLINEA_TOP         : TPRRect ;
      FLABEL_OBSERVACION : TPRLabel;
      FMEMO_OBSERVACION  : TPRText ;
      Procedure SetComponents;
    Public
      Property LABEL_OBSERVACION : TPRLabel Read FLABEL_OBSERVACION Write FLABEL_OBSERVACION;
      Property MEMO_OBSERVACION  : TPRText  Read FMEMO_OBSERVACION  Write FMEMO_OBSERVACION ;
      Constructor Create(AOwner: TComponent); Override;
      Destructor Destroy; Override;
  End;

  THEAD_TRANSFERENCIA = Class(TBASE)
    Private
      FCUADRO_ORIGEN         : TPRRect ;
      FCUADRO_DESTINO        : TPRRect ;
      FCUADRO_CANTIDAD       : TPRRect ;
      FCUADRO_FECHA          : TPRRect ;
      FCUADRO_REFERENCIA      : TPRRect ;
      FTRANSFERENCIA_ID      : TPRLabel;
      FLABEL_ORIGEN          : TPRLabel;
      FNOMBRE_ORIGEN         : TPRLabel;
      FDIRECCION_ORIGEN      : TPRLabel;
      FLABEL_DESTINO         : TPRLabel;
      FNOMBRE_DESTINO        : TPRLabel;
      FDIRECCION_DESTINO     : TPRLabel;
      FCANTIDAD_PROGRAMADA   : TPRLabel;
      FCANTIDAD_DESPACHADA   : TPRLabel;
      FCANTIDAD_CONFIRMADA   : TPRLabel;
      FFECHA_PROGRAMADA      : TPRLabel;
      FFECHA_DESPACHADA      : TPRLabel;
      FFECHA_CONFIRMADA      : TPRLabel;
      FREFERENCIA_PROGRAMADA : TPRLabel;
      FREFERENCIA_DESPACHADA : TPRLabel;
      FLABEL_CANTIDAD        : TPRLabel;
      FLABEL_FECHA           : TPRLabel;
      FLABEL_REFERENCIA      : TPRLabel;
      FLABEL_PROGRAMADA      : TPRLabel;
      FLABEL_DESPACHADA      : TPRLabel;
      FLABEL_CONFIRMADA      : TPRLabel;
      Procedure SetComponents;
    Public
      Property TRANSFERENCIA_ID      : TPRLabel Read FTRANSFERENCIA_ID      Write FTRANSFERENCIA_ID     ;
      Property NOMBRE_ORIGEN         : TPRLabel Read FNOMBRE_ORIGEN         Write FNOMBRE_ORIGEN        ;
      Property DIRECCION_ORIGEN      : TPRLabel Read FDIRECCION_ORIGEN      Write FDIRECCION_ORIGEN     ;
      Property NOMBRE_DESTINO        : TPRLabel Read FNOMBRE_DESTINO        Write FNOMBRE_DESTINO       ;
      Property DIRECCION_DESTINO     : TPRLabel Read FDIRECCION_DESTINO     Write FDIRECCION_DESTINO    ;
      Property CANTIDAD_PROGRAMADA   : TPRLabel Read FCANTIDAD_PROGRAMADA   Write FCANTIDAD_PROGRAMADA  ;
      Property CANTIDAD_DESPACHADA   : TPRLabel Read FCANTIDAD_DESPACHADA   Write FCANTIDAD_DESPACHADA  ;
      Property CANTIDAD_CONFIRMADA   : TPRLabel Read FCANTIDAD_CONFIRMADA   Write FCANTIDAD_CONFIRMADA  ;
      Property FECHA_PROGRAMADA      : TPRLabel Read FFECHA_PROGRAMADA      Write FFECHA_PROGRAMADA     ;
      Property FECHA_DESPACHADA      : TPRLabel Read FFECHA_DESPACHADA      Write FFECHA_DESPACHADA     ;
      Property FECHA_CONFIRMADA      : TPRLabel Read FFECHA_CONFIRMADA      Write FFECHA_CONFIRMADA     ;
      Property REFERENCIA_PROGRAMADA : TPRLabel Read FREFERENCIA_PROGRAMADA Write FREFERENCIA_PROGRAMADA;
      Property REFERENCIA_DESPACHADA : TPRLabel Read FREFERENCIA_DESPACHADA Write FREFERENCIA_DESPACHADA;
      Constructor Create(AOwner: TComponent); Override;
      Destructor Destroy; Override;
  End;
  TDETAIL_TRANFERENCIA = Class(TBASE)
    Private
    Public
      Constructor Create(AOwner: TComponent); Override;
      Destructor Destroy; Override;
      procedure SetLine(Const pContenido : String; Const pBold : Boolean); Overload;
      Procedure SetLine(Const pItem, pDescripcion, pFabricacion, pVencimiento, pCantidad : String; Const pBold : Boolean); Overload;
  End;
  TFOOT_TRANFERENCIA = Class(TBASE)
    Private
      FLINEA_TOP         : TPRRect ;
      FLABEL_OBSERVACION : TPRLabel;
      FMEMO_OBSERVACION  : TPRText ;
      Procedure SetComponents;
    Public
      Property LABEL_OBSERVACION : TPRLabel Read FLABEL_OBSERVACION Write FLABEL_OBSERVACION;
      Property MEMO_OBSERVACION  : TPRText  Read FMEMO_OBSERVACION  Write FMEMO_OBSERVACION ;
      Constructor Create(AOwner: TComponent); Override;
      Destructor Destroy; Override;
  End;



implementation
Uses
  UtFuncion,
  VCL.Controls,
  System.SysUtils;


{ THEAD_MOVIMIENTO }
constructor THEAD_MOVIMIENTO.Create(AOwner: TComponent);
begin
  inherited;
  Self.Top                  := 001;
  Self.Height               := 065;
  Self.Name                 := 'THEAD_MOVIMIENTO' + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now);

  FCLIENTE_LABEL_NOMBRE     := Create_Label(Self);
  FCLIENTE_DATO_NOMBRE      := Create_Label(Self);
  FCLIENTE_LABEL_DATE       := Create_Label(Self);

  FCLIENTE_LABEL_DIRECCION  := Create_Label(Self);
  FCLIENTE_DATO_DIRECCION   := Create_Label(Self);
  FCLIENTE_LABEL_DAY        := Create_Label(Self);
  FCLIENTE_LABEL_MONTH      := Create_Label(Self);
  FCLIENTE_LABEL_YEAR       := Create_Label(Self);

  FCLIENTE_LABEL_CONCEPTO   := Create_Label(Self);
  FCLIENTE_DATO_CONCEPTO    := Create_Label(Self);
  FCLIENTE_DATO_DAY         := Create_Label(Self);
  FCLIENTE_DATO_MONTH       := Create_Label(Self);
  FCLIENTE_DATO_YEAR        := Create_Label(Self);

  FCUADRO_CLIENTE_NOMBRE    := Create_Rect (Self);
  FCUADRO_CLIENTE_CONCEPTO  := Create_Rect (Self);
  FCUADRO_CLIENTE_DIRECCION := Create_Rect (Self);

  FCUADRO_FECHA             := Create_Rect (Self);

  SetComponents;
End;

Procedure THEAD_MOVIMIENTO.SetComponents;
Begin
  SetLabel(FCLIENTE_LABEL_NOMBRE , TAlignment.taLeftJustify   ,                          001, 008, 090, 014, 'SEÑOR(ES): '            , True );
  SetLabel(FCLIENTE_DATO_NOMBRE  , TAlignment.taLeftJustify   , FCLIENTE_LABEL_NOMBRE.Top   , 070, 353, 014, 'FCLIENTE_DATO_NOMBRE'   , False);
  SetLabel(FCLIENTE_LABEL_DATE   , TAlignment.taCenter        , FCLIENTE_LABEL_NOMBRE.Top   , 442, 138, 014, 'FECHA'                  , False);

  SetLabel(FCLIENTE_LABEL_DIRECCION , TAlignment.taLeftJustify,                          020, 008, 090, 014, 'DIRECCION: '            , True );
  SetLabel(FCLIENTE_DATO_DIRECCION  , TAlignment.taLeftJustify, FCLIENTE_LABEL_DIRECCION.Top, 070, 353, 014, 'FCLIENTE_DATO_DIRECCION', False);
  SetLabel(FCLIENTE_LABEL_DAY       , TAlignment.taCenter     , FCLIENTE_LABEL_DIRECCION.Top, 442, 035, 014, 'DIA'                    , False);
  SetLabel(FCLIENTE_LABEL_MONTH     , TAlignment.taCenter     , FCLIENTE_LABEL_DIRECCION.Top, 487, 035, 014, 'MES'                    , False);
  SetLabel(FCLIENTE_LABEL_YEAR      , TAlignment.taCenter     , FCLIENTE_LABEL_DIRECCION.Top, 533, 035, 014, 'AÑO'                    , False);

  SetLabel(FCLIENTE_LABEL_CONCEPTO  , TAlignment.taLeftJustify,                          039, 008, 090, 014, 'CONCEPTO: '             , True );
  SetLabel(FCLIENTE_DATO_CONCEPTO   , TAlignment.taLeftJustify, FCLIENTE_LABEL_CONCEPTO.Top , 070, 353, 014, 'FCLIENTE_DATO_CONCEPTO' , False);
  SetLabel(FCLIENTE_DATO_DAY        , TAlignment.taCenter     , FCLIENTE_LABEL_CONCEPTO.Top , 442, 035, 014, 'DIA'                    , False);
  SetLabel(FCLIENTE_DATO_MONTH      , TAlignment.taCenter     , FCLIENTE_LABEL_CONCEPTO.Top , 487, 035, 014, 'MES'                    , False);
  SetLabel(FCLIENTE_DATO_YEAR       , TAlignment.taCenter     , FCLIENTE_LABEL_CONCEPTO.Top , 533, 035, 014, 'AÑO'                    , False);

  SetRect (FCUADRO_FECHA            , FCLIENTE_LABEL_NOMBRE.Top - 6,
                                      FCLIENTE_LABEL_DATE.Left  - 5,
                                      FCLIENTE_LABEL_DATE.Width + 4,
                                      FCLIENTE_LABEL_CONCEPTO.Top - FCLIENTE_LABEL_NOMBRE.Top + 20);

  SetRect (FCUADRO_CLIENTE_NOMBRE   , FCLIENTE_LABEL_NOMBRE.Top  - 6,
                                      FCLIENTE_LABEL_NOMBRE.Left - 5,
                                      FCLIENTE_LABEL_YEAR.Left + FCLIENTE_LABEL_YEAR.Width + 8,
                                      FCLIENTE_LABEL_NOMBRE.Height + 6);

  SetRect (FCUADRO_CLIENTE_DIRECCION, FCLIENTE_LABEL_DIRECCION.Top  - 6,
                                      FCLIENTE_LABEL_DIRECCION.Left - 5,
                                      FCLIENTE_LABEL_YEAR.Left + FCLIENTE_LABEL_YEAR.Width + 8,
                                      FCLIENTE_LABEL_DIRECCION.Height + 6);
  SetRect (FCUADRO_CLIENTE_CONCEPTO , FCLIENTE_LABEL_CONCEPTO.Top  - 6,
                                      FCLIENTE_LABEL_CONCEPTO.Left - 5,
                                      FCLIENTE_LABEL_YEAR.Left + FCLIENTE_LABEL_YEAR.Width + 8,
                                      FCLIENTE_LABEL_CONCEPTO.Height + 6);



End;

destructor THEAD_MOVIMIENTO.Destroy;
begin
  Release_Component(FCUADRO_CLIENTE_DIRECCION);
  Release_Component(FCUADRO_CLIENTE_CONCEPTO );
  Release_Component(FCUADRO_CLIENTE_NOMBRE   );
  Release_Component(FCUADRO_FECHA            );
  Release_Component(FCLIENTE_DATO_YEAR       );
  Release_Component(FCLIENTE_DATO_MONTH      );
  Release_Component(FCLIENTE_DATO_DAY        );
  Release_Component(FCLIENTE_LABEL_YEAR      );
  Release_Component(FCLIENTE_LABEL_MONTH     );
  Release_Component(FCLIENTE_LABEL_DAY       );
  Release_Component(FCLIENTE_LABEL_DATE      );
  Release_Component(FCLIENTE_DATO_CONCEPTO   );
  Release_Component(FCLIENTE_DATO_DIRECCION  );
  Release_Component(FCLIENTE_DATO_NOMBRE     );
  Release_Component(FCLIENTE_LABEL_CONCEPTO  );
  Release_Component(FCLIENTE_LABEL_DIRECCION );
  Release_Component(FCLIENTE_LABEL_NOMBRE    );
  inherited;
end;

{ THEAD_FACTURA01}
constructor THEAD_FACTURA01.Create(AOwner: TComponent);
begin
  inherited;
  Self.Name         := 'THEAD_FACTURA01' + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now);
  Self.Height       := 090;
  FQR               := Create_Image(Self);
  FCUADRO_QR        := Create_Rect (Self);
  FLABEL_CUFE       := Create_Label(Self);
  FDATO_CUFE        := Create_Label(Self);
  FLABEL_CUDE       := Create_Label(Self);
  FDATO_CUDE        := Create_Label(Self);
  FLABEL_INFO_EXTRA := Create_Label(Self);
  FDATO_INFO_EXTRA  := Create_Label(Self);
  FLABEL_NOTADBCR   := Create_Label(Self);
  FDATO_NOTADBCR    := Create_Label(Self);
  FREGIMEN          := Create_Label(Self);
  FAUTORETENEDOR    := Create_Label(Self);
  FCONTRIBUYENTE    := Create_Label(Self);
  SetComponents;
end;

destructor THEAD_FACTURA01.Destroy;
begin
  Release_Component(FCONTRIBUYENTE   );
  Release_Component(FAUTORETENEDOR   );
  Release_Component(FREGIMEN         );
  Release_Component(FDATO_NOTADBCR   );
  Release_Component(FLABEL_NOTADBCR  );
  Release_Component(FDATO_INFO_EXTRA );
  Release_Component(FLABEL_INFO_EXTRA);
  Release_Component(FDATO_CUDE       );
  Release_Component(FLABEL_CUDE      );
  Release_Component(FDATO_CUFE       );
  Release_Component(FLABEL_CUFE      );
  Release_Component(FCUADRO_QR       );
  Release_Component(FQR              );
  inherited;
end;

procedure THEAD_FACTURA01.SetComponents;
begin
  SetLabel(FREGIMEN         , TAlignment.taLeftJustify, 001                                        - 000, 003, 465, 014, 'FREGIMEN'             , False, 7);
  SetLabel(FAUTORETENEDOR   , TAlignment.taLeftJustify, FREGIMEN.Top       + FREGIMEN.Height       - 003, 003, 465, 014, 'FAUTORETENEDOR'       , False, 7);
  SetLabel(FCONTRIBUYENTE   , TAlignment.taLeftJustify, FAUTORETENEDOR.Top + FAUTORETENEDOR.Height - 003, 003, 465, 014, 'FCONTRIBUYENTE'       , False, 7);
  SetLabel(FLABEL_CUFE      , TAlignment.taLeftJustify, FCONTRIBUYENTE.Top + FCONTRIBUYENTE.Height - 003, 003, 465, 014, 'FLABEL_CUFE'          , False, 7);
  SetLabel(FDATO_CUFE       , TAlignment.taLeftJustify, FCONTRIBUYENTE.Top + FCONTRIBUYENTE.Height - 003, 030, 465, 014, 'FDATO_CUFE'           , False, 7);
  SetLabel(FLABEL_CUDE      , TAlignment.taLeftJustify, FLABEL_CUFE.Top    + FLABEL_CUFE.Height    - 003, 003, 465, 014, 'FLABEL_CUDE'          , False, 7);
  SetLabel(FDATO_CUDE       , TAlignment.taLeftJustify, FLABEL_CUFE.Top    + FLABEL_CUFE.Height    - 003, 030, 465, 014, 'FDATO_CUDE'           , False, 7);
  SetLabel(FLABEL_INFO_EXTRA, TAlignment.taLeftJustify, FLABEL_CUDE.Top    + FLABEL_CUDE.Height    - 003, 003, 465, 014, 'FLABEL_INFO_EXTRA'    , False, 7);
  SetLabel(FDATO_INFO_EXTRA , TAlignment.taLeftJustify, FLABEL_CUDE.Top    + FLABEL_CUDE.Height    - 003, 100, 465, 014, 'FDATO_INFO_EXTRA'     , False, 7);
  SetLabel(FLABEL_NOTADBCR  , TAlignment.taLeftJustify, FLABEL_INFO_EXTRA.Top + FLABEL_INFO_EXTRA.Height - 003, 003, 465, 014, 'FLABEL_NOTADBCR', False, 7);
  SetLabel(FDATO_NOTADBCR   , TAlignment.taLeftJustify, FLABEL_INFO_EXTRA.Top + FLABEL_INFO_EXTRA.Height - 003, 070, 465, 014, 'FDATO_NOTADBCR' , False, 7);
  SetImage(FQR, 01, FREGIMEN.Left + FREGIMEN.Width + 5, 085, 080);
  SetRect(FCUADRO_QR, FQR.Top, FQR.Left, FQR.Width, FQR.Height);
  FCUADRO_QR.Printable := False;
end;

{ THEAD_FACTURA02}
constructor THEAD_FACTURA02.Create(AOwner: TComponent);
begin
  inherited;
  Self.Name    := 'THEAD_FACTURA02' + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now);
  Self.Height := 100;
  FCLIENTE_LABEL_NOMBRE            := Create_Label(Self);
  FCLIENTE_DATO_NOMBRE             := Create_Label(Self);

  FCLIENTE_LABEL_NIT               := Create_Label(Self);
  FCLIENTE_DATO_NIT                := Create_Label(Self);
  FCLIENTE_LABEL_FECHA_HORA_DOCTO  := Create_Label(Self);
  FCLIENTE_DATO_FECHA_HORA_DOCTO   := Create_Label(Self);

  FCLIENTE_LABEL_DIRECCION         := Create_Label(Self);
  FCLIENTE_DATO_DIRECCION          := Create_Label(Self);
  FCLIENTE_LABEL_FECHA_HORA_VENC   := Create_Label(Self);
  FCLIENTE_DATO_FECHA_HORA_VENC    := Create_Label(Self);

  FCLIENTE_LABEL_CIUDAD            := Create_Label(Self);
  FCLIENTE_DATO_CIUDAD             := Create_Label(Self);

  FCLIENTE_LABEL_FECHA_VALIDACION  := Create_Label(Self);
  FCLIENTE_DATO_FECHA_VALIDACION   := Create_Label(Self);

  FCLIENTE_LABEL_TELEFONO          := Create_Label(Self);
  FCLIENTE_DATO_TELEFONO           := Create_Label(Self);

  FCLIENTE_LABEL_OPERACION         := Create_Label(Self);
  FCLIENTE_DATO_OPERACION          := Create_Label(Self);
  FCLIENTE_LABEL_FORMA_PAGO        := Create_Label(Self);
  FCLIENTE_DATO_FORMA_PAGO         := Create_Label(Self);

  FCLIENTE_LABEL_MEDIO_PAGO        := Create_Label(Self);
  FCLIENTE_DATO_MEDIO_PAGO         := Create_Label(Self);

  FCLIENTE_INFO_EXTRA              := Create_Label(Self);

  FCLIENTE_LABEL_VENDEDOR          := Create_Label(Self);
  FCLIENTE_DATO_VENDEDOR           := Create_Label(Self);


  FCUADRO_CLIENTE_NOMBRE           := Create_Rect (Self);

  SetComponents;
end;

destructor THEAD_FACTURA02.Destroy;
begin
  Release_Component(FCLIENTE_INFO_EXTRA            );
  Release_Component(FCLIENTE_LABEL_NOMBRE          );
  Release_Component(FCLIENTE_DATO_NOMBRE           );
  Release_Component(FCLIENTE_LABEL_NIT             );
  Release_Component(FCLIENTE_DATO_NIT              );
  Release_Component(FCLIENTE_LABEL_FECHA_HORA_DOCTO);
  Release_Component(FCLIENTE_DATO_FECHA_HORA_DOCTO );
  Release_Component(FCLIENTE_LABEL_DIRECCION       );
  Release_Component(FCLIENTE_DATO_DIRECCION        );
  Release_Component(FCLIENTE_LABEL_FECHA_HORA_VENC );
  Release_Component(FCLIENTE_DATO_FECHA_HORA_VENC  );
  Release_Component(FCLIENTE_DATO_FECHA_VALIDACION );
  Release_Component(FCLIENTE_LABEL_FECHA_VALIDACION);
  Release_Component(FCLIENTE_LABEL_CIUDAD          );
  Release_Component(FCLIENTE_DATO_CIUDAD           );
  Release_Component(FCLIENTE_LABEL_TELEFONO        );
  Release_Component(FCLIENTE_DATO_TELEFONO         );
  Release_Component(FCLIENTE_LABEL_OPERACION       );
  Release_Component(FCLIENTE_DATO_OPERACION        );
  Release_Component(FCLIENTE_LABEL_FORMA_PAGO      );
  Release_Component(FCLIENTE_DATO_FORMA_PAGO       );
  Release_Component(FCLIENTE_LABEL_MEDIO_PAGO      );
  Release_Component(FCLIENTE_DATO_MEDIO_PAGO       );
  Release_Component(FCLIENTE_LABEL_VENDEDOR        );
  Release_Component(FCLIENTE_DATO_VENDEDOR         );
  Release_Component(FCUADRO_CLIENTE_NOMBRE         );
  inherited;
end;

procedure THEAD_FACTURA02.SetComponents;
begin
  SetLabel(FCLIENTE_LABEL_NOMBRE           , TAlignment.taLeftJustify,                                001 , 008, 090, 010, 'CLIENTE: '                    , True , 08);
  SetLabel(FCLIENTE_DATO_NOMBRE            , TAlignment.taLeftJustify, FCLIENTE_LABEL_NOMBRE.Top          , 060, 090, 010, 'FCLIENTE_DATO_NOMBRE'         , False, 08);

  SetLabel(FCLIENTE_LABEL_NIT              , TAlignment.taLeftJustify,                                014 , 008, 090, 010, 'NIT: '                        , True , 08);
  SetLabel(FCLIENTE_DATO_NIT               , TAlignment.taLeftJustify, FCLIENTE_LABEL_NIT.Top             , 060, 090, 010, 'FCLIENTE_DATO_NOMBRE'         , False, 08);
  SetLabel(FCLIENTE_LABEL_FECHA_HORA_DOCTO , TAlignment.taLeftJustify, FCLIENTE_LABEL_NIT.Top             , 350, 090, 010, 'FECHA ELABORACION: '          , True , 08);
  SetLabel(FCLIENTE_DATO_FECHA_HORA_DOCTO  , TAlignment.taLeftJustify, FCLIENTE_LABEL_NIT.Top             , 450, 090, 010, 'MES'                          , False, 08);

  SetLabel(FCLIENTE_LABEL_DIRECCION        , TAlignment.taLeftJustify,                                027 , 008, 090, 010, 'DIRECCION: '                  , True , 08);
  SetLabel(FCLIENTE_DATO_DIRECCION         , TAlignment.taLeftJustify, FCLIENTE_LABEL_DIRECCION.Top       , 060, 090, 010, 'FCLIENTE_DATO_DIRECCION'      , False, 08);
  SetLabel(FCLIENTE_LABEL_FECHA_HORA_VENC  , TAlignment.taLeftJustify, FCLIENTE_LABEL_DIRECCION.Top       , 350, 090, 010, 'FECHA VENCIMIENTO: '          , True , 08);
  SetLabel(FCLIENTE_DATO_FECHA_HORA_VENC   , TAlignment.taLeftJustify, FCLIENTE_LABEL_DIRECCION.Top       , 450, 090, 010, 'MES'                          , False, 08);

  SetLabel(FCLIENTE_LABEL_CIUDAD           , TAlignment.taLeftJustify,                                040 , 008, 090, 010, 'CIUDAD: '                     , True , 08);
  SetLabel(FCLIENTE_DATO_CIUDAD            , TAlignment.taLeftJustify, FCLIENTE_LABEL_CIUDAD.Top          , 060, 090, 010, 'FCLIENTE_DATO_CIUDAD'         , False, 08);
  SetLabel(FCLIENTE_LABEL_FECHA_VALIDACION , TAlignment.taLeftJustify, FCLIENTE_LABEL_CIUDAD.Top          , 350, 090, 010, 'FECHA/HORA VALIDACION: '      , True , 08);
  SetLabel(FCLIENTE_DATO_FECHA_VALIDACION  , TAlignment.taLeftJustify, FCLIENTE_LABEL_CIUDAD.Top          , 460, 090, 010, 'FECHA/HORA VALIDACION'        , False, 08);

  SetLabel(FCLIENTE_LABEL_TELEFONO         , TAlignment.taLeftJustify,                                053 , 008, 090, 010, 'TELEFONO: '                   , True , 08);
  SetLabel(FCLIENTE_DATO_TELEFONO          , TAlignment.taLeftJustify, FCLIENTE_LABEL_TELEFONO.Top        , 060, 090, 010, 'FCLIENTE_DATO_NOMBRE'         , False, 08);
  SetLabel(FCLIENTE_LABEL_FORMA_PAGO       , TAlignment.taLeftJustify, FCLIENTE_LABEL_TELEFONO.Top        , 350, 090, 010, 'FORMA DE PAGO: '              , True , 08);
  SetLabel(FCLIENTE_DATO_FORMA_PAGO        , TAlignment.taLeftJustify, FCLIENTE_LABEL_TELEFONO.Top        , 425, 090, 010, 'FCLIENTE_DATO_FORMA_PAGO'     , False, 08);

  SetLabel(FCLIENTE_LABEL_OPERACION        , TAlignment.taLeftJustify,                                066 , 008, 090, 010, 'TIPO DE OPERACION FACTURADO: ', True , 08);
  SetLabel(FCLIENTE_DATO_OPERACION         , TAlignment.taLeftJustify, FCLIENTE_LABEL_OPERACION.Top       , 150, 090, 010, 'FCLIENTE_DATO_OPERACION'      , False, 08);
  SetLabel(FCLIENTE_LABEL_MEDIO_PAGO       , TAlignment.taLeftJustify, FCLIENTE_LABEL_OPERACION.Top       , 350, 090, 010, 'MEDIO DE PAGO: '              , True , 08);
  SetLabel(FCLIENTE_DATO_MEDIO_PAGO        , TAlignment.taLeftJustify, FCLIENTE_LABEL_OPERACION.Top       , 425, 090, 010, 'FCLIENTE_DATO_MEDIO_PAGO'     , False, 08);

  SetLabel(FCLIENTE_INFO_EXTRA             , TAlignment.taLeftJustify,                                079 , 008, 090, 010, 'INFORMACION EXTRA: '          , True , 08);
  SetLabel(FCLIENTE_LABEL_VENDEDOR         , TAlignment.taLeftJustify, FCLIENTE_INFO_EXTRA.Top            , 350, 090, 010, 'VENDEDOR: '                   , True , 08);
  SetLabel(FCLIENTE_DATO_VENDEDOR          , TAlignment.taLeftJustify, FCLIENTE_INFO_EXTRA.Top            , 400, 177, 010, 'FCLIENTE_DATO_VENDEDOR'       , False, 08);

//  SetRect (FCUADRO_FECHA            , FCLIENTE_LABEL_NOMBRE.Top - 6,
//                                      FCLIENTE_LABEL_FECHA_VENCIMIENTO.Left  - 5,
//                                      FCLIENTE_LABEL_FECHA_VENCIMIENTO.Width + 5,
//                                      FCLIENTE_DATO_YEAR_VENCIMIENTO.Top - FCUADRO_FECHA.Top + 19);

  SetRect (FCUADRO_CLIENTE_NOMBRE   , FCLIENTE_LABEL_NOMBRE.Top  - 6,
                                      FCLIENTE_LABEL_NOMBRE.Left - 5,
                                      FCLIENTE_DATO_VENDEDOR.Left + FCLIENTE_DATO_VENDEDOR.Width - 3,
                                      FCLIENTE_INFO_EXTRA.Top + FCLIENTE_INFO_EXTRA.Height - FCLIENTE_LABEL_NOMBRE.Top + 12);
//
//  SetRect (FCUADRO_CLIENTE_NIT      , FCLIENTE_LABEL_NIT.Top  - 6,
//                                      FCLIENTE_LABEL_NIT.Left - 5,
//                                      FCLIENTE_LABEL_FECHA_VENCIMIENTO.Left + FCLIENTE_LABEL_FECHA_VENCIMIENTO.Width - 3,
//                                      FCLIENTE_LABEL_NIT.Height + 6);
//
//  SetRect (FCUADRO_CLIENTE_DIRECCION, FCLIENTE_LABEL_DIRECCION.Top  - 6,
//                                      FCLIENTE_LABEL_DIRECCION.Left - 5,
//                                      FCLIENTE_LABEL_FECHA_VENCIMIENTO.Left + FCLIENTE_LABEL_FECHA_VENCIMIENTO.Width - 3,
//                                      FCLIENTE_LABEL_DIRECCION.Height + 6);
//
//  SetRect (FCUADRO_CLIENTE_CIUDAD   , FCLIENTE_LABEL_CIUDAD.Top  - 6,
//                                      FCLIENTE_LABEL_CIUDAD.Left - 5,
//                                      FCLIENTE_LABEL_FECHA_VENCIMIENTO.Left + FCLIENTE_LABEL_FECHA_VENCIMIENTO.Width - 3,
//                                      FCLIENTE_LABEL_CIUDAD.Height + 6);
//
//  SetRect (FCUADRO_CLIENTE_TELEFONO , FCLIENTE_LABEL_TELEFONO.Top  - 6,
//                                      FCLIENTE_LABEL_TELEFONO.Left - 5,
//                                      FCLIENTE_LABEL_FECHA_VENCIMIENTO.Left + FCLIENTE_LABEL_FECHA_VENCIMIENTO.Width - 3,
//                                      FCLIENTE_LABEL_TELEFONO.Height + 6);
//
//  SetRect (FCUADRO_CLIENTE_OPERACION, FCLIENTE_LABEL_OPERACION.Top  - 6,
//                                      FCLIENTE_LABEL_OPERACION.Left - 5,
//                                      FCLIENTE_LABEL_FECHA_VENCIMIENTO.Left + FCLIENTE_LABEL_FECHA_VENCIMIENTO.Width - 3,
//                                      FCLIENTE_LABEL_OPERACION.Height + 6);
end;

{ TDETAIL_ERCOL }
constructor TDETAIL_ERCOL.Create(AOwner: TComponent);
begin
  inherited;
  Self.Name    := 'TDETAIL_ERCOL' + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now);
  CURRENT_TOP := 3;
end;

procedure TDETAIL_ERCOL.SetLine(Const pContenido : String; Const pBold : Boolean);
Var
  FCONTENIDO : TPRLabel;
begin
  FCONTENIDO := Create_Label(Self);
  SetLabel(FCONTENIDO, TAlignment.taLeftJustify, CURRENT_TOP, 001, Self.Width - 12, 008, Copy(pContenido  , 01, 255), pBold);
  FCONTENIDO.FontName := TPRFontName.fnFixedWidth;
  FCONTENIDO.FontSize := 7;
  LAST_HEIGHT := FCONTENIDO.Height;
  CURRENT_TOP := CURRENT_TOP + FCONTENIDO.Height;
  Self.Height := CURRENT_TOP + 1;
end;

procedure TDETAIL_ERCOL.SetLine_Reparacion_Conversion(Const pLabel, pValue : String);
Const
  Const_Space = 6;
Var
  FCUADRO : TPRRect ;
  FLABEL  : TPRLabel;
  FVALUE  : TPRLabel;
begin
  FCUADRO := Create_Rect (Self);
  FLABEL  := Create_Label(Self, 08);
  FVALUE  := Create_Label(Self, 08);
  FLABEL.Caption := pLabel;
  FVALUE.Caption := pValue;
  SetLabel(FLABEL, TAlignment.taLeftJustify, CURRENT_TOP, Const_Space + 0000000000000000000000000000005, Round(FLABEL.GetTextWidth), Round(FLABEL.Height * 0.9), Copy(pLabel, 01, 100), True , Round(FLABEL.FontSize));
  SetLabel(FVALUE, TAlignment.taLeftJustify, CURRENT_TOP, Const_Space + FLABEL.Left + FLABEL.Width + 05, Round(FVALUE.GetTextWidth), Round(FVALUE.Height * 0.9), Copy(pValue, 01, 400), False, Round(FVALUE.FontSize));
  SetRect(FCUADRO, CURRENT_TOP - 2, 003, Self.Width + 1, FLABEL.Height + 1);
  CURRENT_TOP := CURRENT_TOP + Round(FVALUE.Height * 0.9);
  Self.Height := CURRENT_TOP + 1;
  FCUADRO.Printable := False;
end;

procedure TDETAIL_ERCOL.SetLine_Novedad(Const pDescripcion, pCantidad, pValor_Unitario, pSubtotal : String; Const pBold : Boolean);
Const
  Const_Space = 6;
Var
  lWidth          : Integer ;
  FCUADRO         : TPRRect ;
  FDESCRIPCION    : TPRLabel;
  FCANTIDAD       : TPRLabel;
  FVALOR_UNITARIO : TPRLabel;
  FSUBTOTAL       : TPRLabel;
begin
  FCUADRO         := Create_Rect (Self);
  FDESCRIPCION    := Create_Label(Self, 07);
  FCANTIDAD       := Create_Label(Self, 07);
  FVALOR_UNITARIO := Create_Label(Self, 07);
  FSUBTOTAL       := Create_Label(Self, 07);

  FDESCRIPCION.Caption := 'W';
  lWidth := Round(FDESCRIPCION.GetTextWidth);
  SetLabel(FDESCRIPCION   , TAlignment.taLeftJustify , CURRENT_TOP, Const_Space + 00000000000000000000000000000000000000000010, (lWidth * 45) + 2, 011, Copy(pDescripcion   , 01, 40), pBold, 07);
  SetLabel(FCANTIDAD      , TAlignment.taRightJustify, CURRENT_TOP, Const_Space + FDESCRIPCION.Left    + FDESCRIPCION.Width   , (lWidth * 08) + 0, 011, Copy(pCantidad      , 01, 08), pBold, 07);
  SetLabel(FVALOR_UNITARIO, TAlignment.taRightJustify, CURRENT_TOP, Const_Space + FCANTIDAD.Left       + FCANTIDAD.Width      , (lWidth * 14) + 0, 011, Copy(pValor_Unitario, 01, 14), pBold, 07);
  SetLabel(FSUBTOTAL      , TAlignment.taRightJustify, CURRENT_TOP, Const_Space + FVALOR_UNITARIO.Left + FVALOR_UNITARIO.Width, (lWidth * 10) + 0, 011, Copy(pSubtotal      , 01, 10), pBold, 07);
  SetRect(FCUADRO, CURRENT_TOP - 2, 003, FSUBTOTAL.Left + FSUBTOTAL.Width + 1, FSUBTOTAL.Height + 1);
  LAST_HEIGHT := FDESCRIPCION.Height;
  CURRENT_TOP := CURRENT_TOP + FDESCRIPCION.Height;
  Self.Height := CURRENT_TOP + 1;
end;

procedure TDETAIL_ERCOL.SetLine_Entrada(Const pCodigo, pDescripcion, pBuenas, pAveriadas, pTotal : String; Const pBold : Boolean);
Var
  FCUADRO      : TPRRect ;
  FCODIGO      : TPRLabel;
  FDESCRIPCION : TPRLabel;
  FBUENAS      : TPRLabel;
  FAVERIADAS   : TPRLabel;
  FTOTAL       : TPRLabel;
begin
  FCUADRO      := Create_Rect (Self);
  FCODIGO      := Create_Label(Self);
  FDESCRIPCION := Create_Label(Self);
  FBUENAS      := Create_Label(Self);
  FAVERIADAS   := Create_Label(Self);
  FTOTAL       := Create_Label(Self);

  SetLabel(FCODIGO     , TAlignment.taRightJustify, CURRENT_TOP, 012, 030, 014, Copy(pCodigo     , 01, 06), pBold);
  SetLabel(FDESCRIPCION, TAlignment.taLeftJustify , CURRENT_TOP, 047, 320, 014, Copy(pDescripcion, 01, 80), pBold);
  If Not pBold Then
  Begin
    FDESCRIPCION.FontSize := 7;
    FDESCRIPCION.Top := FDESCRIPCION.Top + 1;
  End;
  SetLabel(FBUENAS     , TAlignment.taRightJustify, CURRENT_TOP, 368, 070, 014, Copy(pBuenas     , 01, 12), pBold);
  SetLabel(FAVERIADAS  , TAlignment.taRightJustify, CURRENT_TOP, 443, 070, 014, Copy(pAveriadas  , 01, 12), pBold);
  SetLabel(FTOTAL      , TAlignment.taRightJustify, CURRENT_TOP, 505, 070, 014, Copy(pTotal      , 01, 12), pBold);
  SetRect(FCUADRO, CURRENT_TOP - 2, 003, FTOTAL.Left + FTOTAL.Width + 1, FTOTAL.Height + 1);
  LAST_HEIGHT := FCODIGO.Height;
  CURRENT_TOP := CURRENT_TOP + FCODIGO.Height;
  Self.Height := CURRENT_TOP + 1;
end;

procedure TDETAIL_ERCOL.SetLine_Salida(Const pCodigo, pDescripcion, pCantidad : String; Const pBold : Boolean);
Var
  FCUADRO      : TPRRect ;
  FCODIGO      : TPRLabel;
  FDESCRIPCION : TPRLabel;
  FCANTIDAD    : TPRLabel;
begin
  FCUADRO      := Create_Rect (Self);
  FCODIGO      := Create_Label(Self);
  FDESCRIPCION := Create_Label(Self);
  FCANTIDAD    := Create_Label(Self);
  SetLabel(FCODIGO     , TAlignment.taRightJustify, CURRENT_TOP, 012, 030, 014, Copy(pCodigo     , 01, 006), pBold);
  SetLabel(FDESCRIPCION, TAlignment.taLeftJustify , CURRENT_TOP, 047, 450, 014, Copy(pDescripcion, 01, 120), pBold);
  SetLabel(FCANTIDAD   , TAlignment.taRightJustify, CURRENT_TOP, 505, 070, 014, Copy(pCantidad   , 01, 012), pBold);
  SetRect(FCUADRO, CURRENT_TOP - 2, 003, FCANTIDAD.Left + FCANTIDAD.Width + 1, FCANTIDAD.Height + 1);
  LAST_HEIGHT := FCODIGO.Height;
  CURRENT_TOP := CURRENT_TOP + FCODIGO.Height;
  Self.Height := CURRENT_TOP + 1;
end;

procedure TDETAIL_ERCOL.SetLine_Factura_Alquiler(Const pItems, pDesde, pHasta, pDescripcion, pCantidad, pSaldo, pUnidad_Medida, pTarifa, pDias, pValor_Unitario, pPorcentaje_IVA, pSubtotal : String; Const pBold : Boolean);
Const
  Const_Space = 6;
Var
  lWidth          : Integer ;
  FCUADRO         : TPRRect ;
  FITEMS          : TPRLabel;
  FDESDE          : TPRLabel;
  FHASTA          : TPRLabel;
  FDESCRIPCION    : TPRLabel;
  FCANTIDAD       : TPRLabel;
  FSALDO          : TPRLabel;
  FUNIDAD_MEDIDA  : TPRLabel;
  FTARIFA         : TPRLabel;
  FDIAS           : TPRLabel;
  FVALOR_UNITARIO : TPRLabel;
  FPORC_IVA       : TPRLabel;
  FSUBTOTAL       : TPRLabel;
begin
  FCUADRO         := Create_Rect (Self);
  FITEMS          := Create_Label(Self, 06);
  FDESDE          := Create_Label(Self, 07);
  FHASTA          := Create_Label(Self, 07);
  FDESCRIPCION    := Create_Label(Self, 07);
  FCANTIDAD       := Create_Label(Self, 07);
  FSALDO          := Create_Label(Self, 07);
  FUNIDAD_MEDIDA  := Create_Label(Self, 06);
  FTARIFA         := Create_Label(Self, 07);
  FDIAS           := Create_Label(Self, 07);
  FVALOR_UNITARIO := Create_Label(Self, 07);
  FPORC_IVA       := Create_Label(Self, 06);
  FSUBTOTAL       := Create_Label(Self, 07);

  FDESDE.Caption := 'W';
  lWidth := Round(FDESDE.GetTextWidth);
  SetLabel(FITEMS         , TAlignment.taCenter      , CURRENT_TOP, 007                                                       , 010, 011, Copy(pItems         , 01, 04), pBold, 06);
  SetLabel(FDESDE         , TAlignment.taLeftJustify , CURRENT_TOP, Const_Space + FITEMS.Left          + FITEMS.Width         , 035, 011, Copy(pDesde         , 01, 10), pBold, 07);
  SetLabel(FHASTA         , TAlignment.taLeftJustify , CURRENT_TOP, Const_Space + FDESDE.Left          + FDESDE.Width         , 035, 011, Copy(pHasta         , 01, 10), pBold, 07);
  SetLabel(FDESCRIPCION   , TAlignment.taLeftJustify , CURRENT_TOP, Const_Space + FHASTA.Left          + FHASTA.Width         , 200, 011, Copy(pDescripcion   , 01, 53), pBold, 07);
  SetLabel(FCANTIDAD      , TAlignment.taRightJustify, CURRENT_TOP, Const_Space + FDESCRIPCION.Left    + FDESCRIPCION.Width   , 030, 011, Copy(pCantidad      , 01, 08), pBold, 07);
  SetLabel(FSALDO         , TAlignment.taRightJustify, CURRENT_TOP, Const_Space + FCANTIDAD.Left       + FCANTIDAD.Width      , 030, 011, Copy(pSaldo         , 01, 08), pBold, 07);
  SetLabel(FUNIDAD_MEDIDA , TAlignment.taCenter      , CURRENT_TOP, Const_Space + FSALDO.Left          + FSALDO.Width         , 015, 011, Copy(pUnidad_Medida , 01, 05), pBold, 06);
  SetLabel(FTARIFA        , TAlignment.taRightJustify, CURRENT_TOP, Const_Space + FUNIDAD_MEDIDA.Left  + FUNIDAD_MEDIDA.Width , 030, 011, Copy(pTarifa        , 01, 10), pBold, 07);
  SetLabel(FDIAS          , TAlignment.taCenter      , CURRENT_TOP, Const_Space + FTARIFA.Left         + FTARIFA.Width        , 015, 011, Copy(pDias          , 01, 05), pBold, 07);
  SetLabel(FVALOR_UNITARIO, TAlignment.taRightJustify, CURRENT_TOP, Const_Space + FDIAS.Left           + FDIAS.Width          , 035, 011, Copy(pValor_Unitario, 01, 12), pBold, 07);
  SetLabel(FPORC_IVA      , TAlignment.taCenter      , CURRENT_TOP, Const_Space + FVALOR_UNITARIO.Left + FVALOR_UNITARIO.Width, 025, 011, Copy(pPorcentaje_IVA, 01, 12), pBold, 06);
  SetLabel(FSUBTOTAL      , TAlignment.taRightJustify, CURRENT_TOP, Const_Space + FPORC_IVA.Left       + FPORC_IVA.Width      , 040, 011, Copy(pSubtotal      , 01, 14), pBold, 07);
  FSUBTOTAL.GetTextWidth;
  SetRect(FCUADRO, CURRENT_TOP - 2, 003, FSUBTOTAL.Left + FSUBTOTAL.Width + 1, FSUBTOTAL.Height + 1);
  LAST_HEIGHT := FDESDE.Height;
  CURRENT_TOP := CURRENT_TOP + FDESDE.Height;
  Self.Height := CURRENT_TOP + 1;
end;

procedure TDETAIL_ERCOL.SetLine_Factura_Servicio(Const pItems, pFecha, pDescripcion, pCantidad, pUnidad_Medida, pValor_Unitario, pPorcentaje_IVA, pSubtotal : String; Const pBold : Boolean);
Const
  Const_Space = 6;
Var
  lWidth          : Integer ;
  FCUADRO         : TPRRect ;
  FITEMS          : TPRLabel;
  FFECHA          : TPRLabel;
  FDESCRIPCION    : TPRLabel;
  FCANTIDAD       : TPRLabel;
  FUNIDAD_MEDIDA  : TPRLabel;
  FVALOR_UNITARIO : TPRLabel;
  FPORC_IVA       : TPRLabel;
  FSUBTOTAL       : TPRLabel;
begin
  FCUADRO         := Create_Rect (Self);
  FITEMS          := Create_Label(Self, 06);
  FFECHA          := Create_Label(Self, 07);
  FDESCRIPCION    := Create_Label(Self, 07);
  FCANTIDAD       := Create_Label(Self, 07);
  FUNIDAD_MEDIDA  := Create_Label(Self, 06);
  FVALOR_UNITARIO := Create_Label(Self, 07);
  FPORC_IVA       := Create_Label(Self, 06);
  FSUBTOTAL       := Create_Label(Self, 07);

  FFECHA.Caption := 'W';
  lWidth := Round(FFECHA.GetTextWidth);
  SetLabel(FITEMS         , TAlignment.taCenter      , CURRENT_TOP, 007                                                       , 010, 011, Copy(pItems         , 01, 04), pBold, 06);
  SetLabel(FFECHA         , TAlignment.taLeftJustify , CURRENT_TOP, Const_Space + FITEMS.Left          + FITEMS.Width         , 035, 011, Copy(pFecha         , 01, 10), pBold, 07);
  SetLabel(FDESCRIPCION   , TAlignment.taLeftJustify , CURRENT_TOP, Const_Space + FFECHA.Left          + FFECHA.Width         , 319, 011, Copy(pDescripcion   , 01, 80), pBold, 07);
  SetLabel(FCANTIDAD      , TAlignment.taRightJustify, CURRENT_TOP, Const_Space + FDESCRIPCION.Left    + FDESCRIPCION.Width   , 030, 011, Copy(pCantidad      , 01, 08), pBold, 07);
  SetLabel(FUNIDAD_MEDIDA , TAlignment.taCenter      , CURRENT_TOP, Const_Space + FCANTIDAD.Left       + FCANTIDAD.Width      , 015, 011, Copy(pUnidad_Medida , 01, 05), pBold, 06);
  SetLabel(FVALOR_UNITARIO, TAlignment.taRightJustify, CURRENT_TOP, Const_Space + FUNIDAD_MEDIDA.Left  + FUNIDAD_MEDIDA.Width , 040, 011, Copy(pValor_Unitario, 01, 12), pBold, 07);
  SetLabel(FPORC_IVA      , TAlignment.taCenter      , CURRENT_TOP, Const_Space + FVALOR_UNITARIO.Left + FVALOR_UNITARIO.Width, 030, 011, Copy(pPorcentaje_IVA, 01, 12), pBold, 06);
  SetLabel(FSUBTOTAL      , TAlignment.taRightJustify, CURRENT_TOP, Const_Space + FPORC_IVA.Left       + FPORC_IVA.Width      , 045, 011, Copy(pSubtotal      , 01, 14), pBold, 07);
  FSUBTOTAL.GetTextWidth;
  SetRect(FCUADRO, CURRENT_TOP - 2, 003, FSUBTOTAL.Left + FSUBTOTAL.Width + 1, FSUBTOTAL.Height + 1);
  LAST_HEIGHT := FFECHA.Height;
  CURRENT_TOP := CURRENT_TOP + FFECHA.Height;
  Self.Height := CURRENT_TOP + 1;
end;

destructor TDETAIL_ERCOL.Destroy;
begin

  inherited;
end;

{ TFOOT_MOVIMIENTO}
constructor TFOOT_MOVIMIENTO.Create(AOwner: TComponent);
Var
  lPagina : TPRPage;
begin
  inherited;
  Self.Name := 'TFOOT_MOVIMIENTO' + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now);
  lPagina := (AOwner As TPRPage);

  Self.Height          := 55;

  FLINEA_TOP           := Create_Rect (Self);
  FLABEL_DESPACHADO    := Create_Label(Self);
  FDATO_DESPACHADO     := Create_Label(Self);

  FLABEL_TRANSPORTADOR := Create_Label(Self);
  FDATO_TRANSPORTADOR  := Create_Label(Self);

  FLABEL_PLACAS        := Create_Label(Self);
  FDATO_PLACAS         := Create_Label(Self);

  FLABEL_FIRMA         := Create_Label(Self);
  FLINEA_FIRMA         := Create_Rect (Self);
  FLABEL_CLIENTE       := Create_Label(Self);
  SetComponents;
end;

procedure TFOOT_MOVIMIENTO.SetComponents;
begin
  SetRect(FLINEA_TOP, 001, 006, 564, 001);
  SetLabel(FLABEL_DESPACHADO   , TAlignment.taLeftJustify, FLINEA_TOP.Height        + FLINEA_TOP.Top        + 5      , 006, 130, 014, 'DESPACHADO POR'           , True );
  SetLabel(FDATO_DESPACHADO    , TAlignment.taLeftJustify, FLABEL_DESPACHADO.Height + FLABEL_DESPACHADO.Top - 4      , 006, 130, 014, 'FDATO_DESPACHADO'         , False);

  SetLabel(FLABEL_TRANSPORTADOR, TAlignment.taLeftJustify, FLINEA_TOP.Height + FLINEA_TOP.Top + 5                    , 166, 130, 014, 'TRANSPORTADO POR'         , True );
  SetLabel(FDATO_TRANSPORTADOR , TAlignment.taLeftJustify, FLABEL_TRANSPORTADOR.Height + FLABEL_TRANSPORTADOR.Top - 4, 166, 130, 014, 'FDATO_TRANSPORTADOR'      , False);

  SetLabel(FLABEL_PLACAS       , TAlignment.taCenter     , FLINEA_TOP.Height + FLINEA_TOP.Top + 5                    , 260, 130, 014, 'PLACA'                    , True );
  SetLabel(FDATO_PLACAS        , TAlignment.taCenter     , FLABEL_PLACAS.Height + FLABEL_PLACAS.Top - 4              , 260, 130, 014, 'FDATO_PLACAS'             , False);

  SetLabel(FLABEL_FIRMA        , TAlignment.taCenter     , FLINEA_TOP.Height + FLINEA_TOP.Top + 5                    , 376, 193, 014, 'FIRMA Y SELLO DE RECIBIDO', True );
  SetRect (FLINEA_FIRMA                                  , FLABEL_FIRMA.Top + FLABEL_FIRMA.Height + 20               , 376, 196, 001);
  SetLabel(FLABEL_CLIENTE      , TAlignment.taCenter     , FLINEA_FIRMA.Height + FLINEA_FIRMA.Top                    , 376, 193, 014, 'Cliente'                  , False);
end;

destructor TFOOT_MOVIMIENTO.Destroy;
begin
  Release_Component(FLABEL_CLIENTE      );
  Release_Component(FLINEA_FIRMA        );
  Release_Component(FLABEL_FIRMA        );
  Release_Component(FDATO_PLACAS        );
  Release_Component(FLABEL_PLACAS       );
  Release_Component(FDATO_TRANSPORTADOR );
  Release_Component(FLABEL_TRANSPORTADOR);
  Release_Component(FDATO_DESPACHADO    );
  Release_Component(FLABEL_DESPACHADO   );
  Release_Component(FLINEA_TOP);
  inherited;
end;

{ TFOOT_FACTURA01 }
constructor TFOOT_FACTURA01.Create(AOwner: TComponent);
Var
  ltmp : TPRLabel;
begin
  inherited;
  Self.Name := 'TFOOT_FACTURA01' + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now);
  Self.Height        := 70;
  FLINEA_TOP         := Create_Rect (Self);
  FLABEL_VALOR_BRUTO := Create_Label(Self);
  FDATO_VALOR_BRUTO  := Create_Label(Self);
  FLABEL_DESCUENTO   := Create_Label(Self);
  FDATO_DESCUENTO    := Create_Label(Self);
  FLABEL_SUBTOTAL    := Create_Label(Self);
  FDATO_SUBTOTAL     := Create_Label(Self);
  FLABEL_IVA         := Create_Label(Self);
  FDATO_IVA          := Create_Label(Self);
  FLABEL_TOTAL       := Create_Label(Self);
  FDATO_TOTAL        := Create_Label(Self);
  SetComponents;
end;

procedure TFOOT_FACTURA01.SetComponents;
Var
  lWidth : Integer;
begin
  lWidth := 8;
  SetLabel(FLABEL_VALOR_BRUTO, TAlignment.taLeftJustify , 003                                                    , 399, (lWidth * 10), 014, 'VALOR BRUTO: '     , True );
  SetLabel(FDATO_VALOR_BRUTO , TAlignment.taRightJustify, 003, FLABEL_VALOR_BRUTO.Left + FLABEL_VALOR_BRUTO.Width     , (lWidth * 12), 014, 'FDATO_VALOR_BRUTO' , False);

  SetLabel(FLABEL_DESCUENTO  , TAlignment.taLeftJustify , 016                                                    , 399, (lWidth * 10), 014, 'DESCUENTO: '       , True );
  SetLabel(FDATO_DESCUENTO   , TAlignment.taRightJustify, 016, FLABEL_DESCUENTO.Left   + FLABEL_DESCUENTO.Width       , (lWidth * 12), 014, 'FDATO_DESCUENTO'   , False);

  SetLabel(FLABEL_SUBTOTAL   ,  TAlignment.taLeftJustify, 029                                                    , 399, (lWidth * 10), 014, 'SUBTOTAL: '        , True );
  SetLabel(FDATO_SUBTOTAL    , TAlignment.taRightJustify, 029, FLABEL_SUBTOTAL.Left + FLABEL_SUBTOTAL.Width           , (lWidth * 12), 014, 'FDATO_SUBTOTAL'    , False);

  SetLabel(FLABEL_IVA        , TAlignment.taLeftJustify , 042                                                    , 399, (lWidth * 10), 014, 'I.V.A.: '          , True );
  SetLabel(FDATO_IVA         , TAlignment.taRightJustify, 042, FLABEL_SUBTOTAL.Left + FLABEL_SUBTOTAL.Width           , (lWidth * 12), 014, 'FDATO_IVA'         , False);

  SetLabel(FLABEL_TOTAL      , TAlignment.taLeftJustify , 055                                                    , 399, (lWidth * 10), 014, 'TOTAL: '           , True );
  SetLabel(FDATO_TOTAL       , TAlignment.taRightJustify, 055, FLABEL_SUBTOTAL.Left + FLABEL_SUBTOTAL.Width           , (lWidth * 12), 014, 'FDATO_TOTAL'       , False);
  SetRect(FLINEA_TOP, FLABEL_VALOR_BRUTO.Top  - 2,
                      FLABEL_VALOR_BRUTO.Left - 2,
                      FLABEL_TOTAL.Width + FDATO_TOTAL.Width + 7,
                      FDATO_TOTAL.Top + FDATO_TOTAL.Height - 2);
end;

procedure TFOOT_FACTURA01.SetLine(const pLeft, pWidth: Integer; const pValue : String; pBold: Boolean);
Var
  FLabel : TPRLabel;
  lWidth : Integer;
begin
  FLabel := Create_Label(Self);
  lWidth := Round(FLabel.GetTextWidth);
  SetLabel(FLabel, TAlignment.taLeftJustify , CURRENT_TOP, pLeft, (lWidth * 10), 014, Copy(pValue, 01, pWidth) , pBold);
  CURRENT_TOP := CURRENT_TOP + FLabel.Height;
  If Self.Height <= (CURRENT_TOP + 1) Then
    Self.Height := CURRENT_TOP + 1;
//    Self.Height := Self.Height + FLabel.Height + 1;
//    Self.Height := CURRENT_TOP + 1;
end;

destructor TFOOT_FACTURA01.Destroy;
begin
  Release_Component(FLINEA_TOP        );
  Release_Component(FLABEL_VALOR_BRUTO);
  Release_Component(FDATO_VALOR_BRUTO );
  Release_Component(FLABEL_DESCUENTO  );
  Release_Component(FDATO_DESCUENTO   );
  Release_Component(FLABEL_SUBTOTAL   );
  Release_Component(FDATO_SUBTOTAL    );
  Release_Component(FLABEL_IVA        );
  Release_Component(FDATO_IVA         );
  Release_Component(FLABEL_TOTAL      );
  Release_Component(FDATO_TOTAL       );
  inherited;
end;


{ TFOOT_FACTURA02 }
constructor TFOOT_FACTURA02.Create(AOwner: TComponent);
begin
  inherited;
  Self.Name := 'TFOOT_FACTURA02' + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now);
  Self.Height          := 60;
  FLINEA_TOP           := Create_Rect (Self);
  FLABEL_PREPARADO_POR := Create_Label(Self);
  FDATO_PREPARADO_POR  := Create_Label(Self);
  FLABEL_FIRMA         := Create_Label(Self);
  FLINEA_FIRMA         := Create_Rect (Self);
  FLABEL_NIT_CC        := Create_Label(Self);
  SetComponents;
end;

destructor TFOOT_FACTURA02.Destroy;
begin
  Release_Component(FLINEA_TOP          );
  Release_Component(FLABEL_PREPARADO_POR);
  Release_Component(FDATO_PREPARADO_POR );
  Release_Component(FLABEL_FIRMA        );
  Release_Component(FLINEA_FIRMA        );
  Release_Component(FLABEL_NIT_CC       );
  inherited;
end;

procedure TFOOT_FACTURA02.SetComponents;
begin
  SetRect(FLINEA_TOP, 001, 006, 564, 001);
  SetLabel(FLABEL_PREPARADO_POR, TAlignment.taLeftJustify, FLINEA_TOP.Height           + FLINEA_TOP.Top           + 5, 006, 130, 014, 'PREPARADO POR'               , True );
  SetLabel(FDATO_PREPARADO_POR , TAlignment.taLeftJustify, FLABEL_PREPARADO_POR.Height + FLABEL_PREPARADO_POR.Top + 5, 006, 130, 014, 'FDATO_PREPARADO_POR'         , False, 8);

  SetLabel(FLABEL_FIRMA , TAlignment.taLeftJustify, FLABEL_PREPARADO_POR.Top                                  + 000, 400, 170, 014, 'FECHA, NOMBRE, FIRMA Y SELLO', False);
  SetRect (FLINEA_FIRMA ,                           FLABEL_FIRMA.Top + FLABEL_FIRMA.Height                    + 020, 400, 170, 001);
  SetLabel(FLABEL_NIT_CC, TAlignment.taLeftJustify, FLINEA_FIRMA.Top + FLINEA_FIRMA.Height                    + 000, 400, 170, 014, 'NIT/CC'                      , False);
end;

procedure TFOOT_FACTURA02.SetLine(Const pValue : String; pBold: Boolean; pSize : Integer = 8; pAlignment : TAlignment = TAlignment.taLeftJustify);
Var
  FLabel : TPRLabel;
begin
  FLabel := Create_Label(Self);
  SetLabel(FLabel, pAlignment, CURRENT_TOP, 001, Self.Width - 2, 010, Copy(pValue, 01, 255) , pBold, pSize);
  CURRENT_TOP := CURRENT_TOP + FLabel.Height;
  If Self.Height <= (CURRENT_TOP + 1) Then
    Self.Height := CURRENT_TOP + 1;
//  Self.Height := Self.Height + FLabel.Height + 1;
//    Self.Height := CURRENT_TOP + 1;
end;



{ TFOOT_ERCOL }
constructor TFOOT_ERCOL.Create(AOwner: TComponent);
begin
  inherited;
  Self.Name          := 'TFOOT_ERCOL' + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now);
  Self.Height        := 100;
  FLINEA_TOP         := Create_Rect (Self);
  FLABEL_OBSERVACION := Create_Label(Self);
  FMEMO_OBSERVACION  := Create_Text (Self);
  SetComponents;
end;

procedure TFOOT_ERCOL.SetComponents;
begin
  SetRect(FLINEA_TOP, 001, 006, Self.Width - 30, 001);
  SetLabel(FLABEL_OBSERVACION, TAlignment.taLeftJustify, FLINEA_TOP.Height + FLINEA_TOP.Top                , 006, 130, 014, 'OBSERVACION', True);
  SetText (FMEMO_OBSERVACION ,                           FLABEL_OBSERVACION.Height + FLABEL_OBSERVACION.Top, 006, 565, 072, ['OBSERVACION 1', 'OBSERVACION ']);
end;

destructor TFOOT_ERCOL.Destroy;
begin
  Release_Component(FMEMO_OBSERVACION );
  Release_Component(FLABEL_OBSERVACION);
  Release_Component(FLINEA_TOP);
  inherited;
end;


{ THEAD_TRANSFERENCIA }
constructor THEAD_TRANSFERENCIA.Create(AOwner: TComponent);
begin
  inherited;
  Self.Height := 050;
  FCUADRO_ORIGEN         := Create_Rect (Self);
  FCUADRO_DESTINO        := Create_Rect (Self);
  FCUADRO_CANTIDAD       := Create_Rect (Self);
  FCUADRO_FECHA          := Create_Rect (Self);
  FCUADRO_REFERENCIA     := Create_Rect (Self);
  FTRANSFERENCIA_ID      := Create_Label(Self);
  FLABEL_ORIGEN          := Create_Label(Self);
  FNOMBRE_ORIGEN         := Create_Label(Self);
  FDIRECCION_ORIGEN      := Create_Label(Self);
  FLABEL_DESTINO         := Create_Label(Self);
  FNOMBRE_DESTINO        := Create_Label(Self);
  FDIRECCION_DESTINO     := Create_Label(Self);
  FCANTIDAD_PROGRAMADA   := Create_Label(Self);
  FCANTIDAD_DESPACHADA   := Create_Label(Self);
  FCANTIDAD_CONFIRMADA   := Create_Label(Self);
  FFECHA_PROGRAMADA      := Create_Label(Self);
  FFECHA_DESPACHADA      := Create_Label(Self);
  FFECHA_CONFIRMADA      := Create_Label(Self);
  FREFERENCIA_PROGRAMADA := Create_Label(Self);
  FREFERENCIA_DESPACHADA := Create_Label(Self);
  FLABEL_CANTIDAD        := Create_Label(Self);
  FLABEL_FECHA           := Create_Label(Self);
  FLABEL_REFERENCIA      := Create_Label(Self);
  FLABEL_PROGRAMADA      := Create_Label(Self);
  FLABEL_DESPACHADA      := Create_Label(Self);
  FLABEL_CONFIRMADA      := Create_Label(Self);
  SetComponents;
end;
procedure THEAD_TRANSFERENCIA.SetComponents;
Const
  Const_Left = 070;
begin
  SetLabel(FTRANSFERENCIA_ID, TAlignment.taCenter, 001, 006, 565, 014, 'OBSERVACION', True);
  SetLabel(FLABEL_ORIGEN         , TAlignment.taLeftJustify, 020, 006, 090, 014, 'ORIGEN'              , True );
  SetLabel(FNOMBRE_ORIGEN        , TAlignment.taLeftJustify, 020, 050, 170, 014, 'FNOMBRE_ORIGEN'      , False);
  SetLabel(FDIRECCION_ORIGEN     , TAlignment.taLeftJustify, 020, 350, 350, 014, 'FDIRECCION_ORIGEN'   , False);
  SetRect(FCUADRO_ORIGEN, 17, 003, 576, 17);
  SetLabel(FLABEL_DESTINO        , TAlignment.taLeftJustify, 039, 006, 090, 014, 'DESTINO'             , True );
  SetLabel(FNOMBRE_DESTINO       , TAlignment.taLeftJustify, 039, 050, 170, 014, 'FNOMBRE_DESTINO'     , False);
  SetLabel(FDIRECCION_DESTINO    , TAlignment.taLeftJustify, 039, 350, 350, 014, 'FDIRECCION_DESTINO'  , False);
  SetRect(FCUADRO_DESTINO, 36, 003, 576, 17);
  SetLabel(FLABEL_PROGRAMADA     , TAlignment.taCenter     , 058, Const_Left + 150, 090, 014, 'PROGRAMADA'          , True );
  SetLabel(FCANTIDAD_PROGRAMADA  , TAlignment.taCenter     , 077, Const_Left + 150, 090, 014, 'PROGRAMADA'          , False);
  SetLabel(FFECHA_PROGRAMADA     , TAlignment.taCenter     , 096, Const_Left + 150, 090, 014, 'PROGRAMADA'          , False);
  SetLabel(FREFERENCIA_PROGRAMADA, TAlignment.taCenter     , 115, Const_Left + 150, 090, 014, 'PROGRAMADA'          , False);
  SetLabel(FLABEL_DESPACHADA     , TAlignment.taCenter     , 058, Const_Left + 240, 090, 014, 'DESPACHADA'          , True );
  SetLabel(FCANTIDAD_DESPACHADA  , TAlignment.taCenter     , 077, Const_Left + 240, 090, 014, 'PROGRAMADA'          , False);
  SetLabel(FFECHA_DESPACHADA     , TAlignment.taCenter     , 096, Const_Left + 240, 090, 014, 'PROGRAMADA'          , False);
  SetLabel(FREFERENCIA_DESPACHADA, TAlignment.taCenter     , 115, Const_Left + 240, 090, 014, 'PROGRAMADA'          , False);
  SetLabel(FLABEL_CONFIRMADA     , TAlignment.taCenter     , 058, Const_Left + 330, 090, 014, 'CONFIRMADA'          , True );
  SetLabel(FCANTIDAD_CONFIRMADA  , TAlignment.taCenter     , 077, Const_Left + 330, 090, 014, 'CONFIRMADA'          , False);
  SetLabel(FFECHA_CONFIRMADA     , TAlignment.taCenter     , 096, Const_Left + 330, 090, 014, 'FECHA'               , False);
  SetLabel(FLABEL_CANTIDAD       , TAlignment.taLeftJustify, 077, Const_Left      , 070, 014, 'CANTIDAD'            , True );
  SetLabel(FLABEL_FECHA          , TAlignment.taLeftJustify, 096, Const_Left      , 070, 014, 'FECHA'               , True );
  SetLabel(FLABEL_REFERENCIA     , TAlignment.taLeftJustify, 115, Const_Left      , 070, 014, 'DOCUMENTO REFERENCIA', True );
  SetRect(FCUADRO_CANTIDAD  , FCANTIDAD_PROGRAMADA.Top    - 4,
                              FCANTIDAD_PROGRAMADA.Left   - 10,
                              FCANTIDAD_PROGRAMADA.Width + FCANTIDAD_DESPACHADA.Width + FCANTIDAD_CONFIRMADA.Width + 20,
                              FCANTIDAD_PROGRAMADA.Height + 4);
  SetRect(FCUADRO_FECHA     , FFECHA_PROGRAMADA.Top - 4,
                              FCUADRO_CANTIDAD.Left    ,
                              FCUADRO_CANTIDAD.Width   ,
                              FCUADRO_CANTIDAD.Height  );
  SetRect(FCUADRO_REFERENCIA, FREFERENCIA_PROGRAMADA.Top - 4,
                              FCUADRO_CANTIDAD.Left         ,
                              FCUADRO_CANTIDAD.Width        ,
                              FCUADRO_CANTIDAD.Height       );
end;
destructor THEAD_TRANSFERENCIA.Destroy;
begin
  Release_Component(FLABEL_CANTIDAD       );
  Release_Component(FLABEL_FECHA          );
  Release_Component(FLABEL_REFERENCIA     );
  Release_Component(FLABEL_PROGRAMADA     );
  Release_Component(FLABEL_DESPACHADA     );
  Release_Component(FLABEL_CONFIRMADA     );
  Release_Component(FDIRECCION_DESTINO    );
  Release_Component(FNOMBRE_DESTINO       );
  Release_Component(FLABEL_DESTINO        );
  Release_Component(FDIRECCION_ORIGEN     );
  Release_Component(FNOMBRE_ORIGEN        );
  Release_Component(FLABEL_ORIGEN         );
  Release_Component(FTRANSFERENCIA_ID     );
  Release_Component(FCUADRO_DESTINO       );
  Release_Component(FCUADRO_ORIGEN        );
  Release_Component(FCANTIDAD_PROGRAMADA  );
  Release_Component(FCANTIDAD_DESPACHADA  );
  Release_Component(FCANTIDAD_CONFIRMADA  );
  Release_Component(FFECHA_PROGRAMADA     );
  Release_Component(FFECHA_DESPACHADA     );
  Release_Component(FFECHA_CONFIRMADA     );
  Release_Component(FREFERENCIA_PROGRAMADA);
  Release_Component(FREFERENCIA_DESPACHADA);
  Release_Component(FCUADRO_CANTIDAD      );
  Release_Component(FCUADRO_FECHA         );
  Release_Component(FCUADRO_REFERENCIA    );
  inherited;
end;
{ TDETAIL_TRANFERENCIA }
constructor TDETAIL_TRANFERENCIA.Create(AOwner: TComponent);
begin
  inherited;
  CURRENT_TOP := 3;
end;
procedure TDETAIL_TRANFERENCIA.SetLine(Const pContenido : String; Const pBold : Boolean);
Var
  FCONTENIDO : TPRLabel;
begin
  FCONTENIDO := Create_Label(Self);
  SetLabel(FCONTENIDO, TAlignment.taLeftJustify, CURRENT_TOP, 001, Self.Width - 12, 008, Copy(pContenido  , 01, 130), pBold);
  FCONTENIDO.FontName := TPRFontName.fnFixedWidth;
  FCONTENIDO.FontSize := 7;
  LAST_HEIGHT := FCONTENIDO.Height;
  CURRENT_TOP := CURRENT_TOP + FCONTENIDO.Height;
  Self.Height := CURRENT_TOP + 1;
end;
procedure TDETAIL_TRANFERENCIA.SetLine(Const pItem, pDescripcion, pFabricacion, pVencimiento, pCantidad : String; Const pBold : Boolean);
Var
  FCUADRO      : TPRRect ;
  FITEM        : TPRLabel;
  FDESCRIPCION : TPRLabel;
  FFABRICACION : TPRLabel;
  FVENCIMIENTO : TPRLabel;
  FCANTIDAD    : TPRLabel;
begin
  FCUADRO      := Create_Rect (Self);
  FITEM        := Create_Label(Self);
  FDESCRIPCION := Create_Label(Self);
  FFABRICACION := Create_Label(Self);
  FVENCIMIENTO := Create_Label(Self);
  FCANTIDAD    := Create_Label(Self);
  SetLabel(FITEM       , TAlignment.taRightJustify, CURRENT_TOP, 006, 030, 014, Copy(pItem       , 01, 04), pBold);
  SetLabel(FDESCRIPCION, TAlignment.taLeftJustify , CURRENT_TOP, 045, 320, 014, Copy(pDescripcion, 01, 63), pBold);
  SetLabel(FFABRICACION, TAlignment.taLeftJustify , CURRENT_TOP, 368, 070, 014, Copy(pFabricacion, 01, 12), pBold);
  SetLabel(FVENCIMIENTO, TAlignment.taLeftJustify , CURRENT_TOP, 443, 070, 014, Copy(pVencimiento, 01, 12), pBold);
  SetLabel(FCANTIDAD   , TAlignment.taRightJustify, CURRENT_TOP, 505, 070, 014, Copy(pCantidad   , 01, 12), pBold);
  SetRect(FCUADRO, CURRENT_TOP - 2, 003, FCANTIDAD.Left + FCANTIDAD.Width + 1, FCANTIDAD.Height + 1);
  LAST_HEIGHT := FITEM.Height;
  CURRENT_TOP := CURRENT_TOP + FITEM.Height;
  Self.Height := CURRENT_TOP + 1;
end;
destructor TDETAIL_TRANFERENCIA.Destroy;
begin
  inherited;
end;
{ TFOOT_TRANFERENCIA }
constructor TFOOT_TRANFERENCIA.Create(AOwner: TComponent);
begin
  inherited;
  Self.Height        := 100;
  FLINEA_TOP         := Create_Rect (Self);
  FLABEL_OBSERVACION := Create_Label(Self);
  FMEMO_OBSERVACION  := Create_Text (Self);
  SetComponents;
end;
procedure TFOOT_TRANFERENCIA.SetComponents;
begin
  SetRect(FLINEA_TOP, 001, 006, Self.Width - 30, 001);
  SetLabel(FLABEL_OBSERVACION, TAlignment.taLeftJustify, FLINEA_TOP.Height + FLINEA_TOP.Top                , 006, 130, 014, 'OBSERVACION', True);
  SetText (FMEMO_OBSERVACION ,                           FLABEL_OBSERVACION.Height + FLABEL_OBSERVACION.Top, 006, 565, 072, ['OBSERVACION 1', 'OBSERVACION ']);
end;
destructor TFOOT_TRANFERENCIA.Destroy;
begin
  Release_Component(FMEMO_OBSERVACION );
  Release_Component(FLABEL_OBSERVACION);
  Release_Component(FLINEA_TOP);
  inherited;
end;



end.
