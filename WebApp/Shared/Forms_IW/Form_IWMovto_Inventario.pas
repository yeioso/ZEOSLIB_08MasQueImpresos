unit Form_IWMovto_Inventario;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes,
  Vcl.Imaging.pngimage, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompExtCtrls, Vcl.Controls, Vcl.Forms, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWCompLabel,
  IWCompTabControl, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  UtConexion, Data.DB, IWCompGrids, IWDBStdCtrls, IWCompEdit,
  IWCompCheckbox, IWCompMemo, IWDBExtCtrls, IWCompButton, IWCompListbox,
  UtGrid_JQ, UtNavegador_ASE;

type
  TFrIWMovto_Inventario = class(TIWAppForm)
    RINFO: TIWRegion;
    lbInfo: TIWLabel;
    IWRegion1: TIWRegion;
    PAGINAS: TIWTabControl;
    PAG_00: TIWTabPage;
    PAG_01: TIWTabPage;
    RNAVEGADOR: TIWRegion;
    IWLabel1: TIWLabel;
    IWLabel8: TIWLabel;
    DATO: TIWEdit;
    IWLabel3: TIWLabel;
    IWModalWindow1: TIWModalWindow;
    NUMERO: TIWDBLabel;
    BTNNOMBRE: TIWImage;
    NOMBRE: TIWDBLabel;
    FECHA_VENCIMIENTO: TIWDBLabel;
    BTNFECHA_VENCIMIENTO: TIWImage;
    lbNombre_Activo: TIWLabel;
    BTNACTIVO: TIWImage;
    IWRegion_Navegador: TIWRegion;
    lbTercero: TIWLabel;
    BTNCODIGO_TERCERO: TIWImage;
    CODIGO_TERCERO: TIWDBLabel;
    lbNombre_Tercero: TIWLabel;
    IWLabel6: TIWLabel;
    BTNCODIGO_PRODUCTO: TIWImage;
    CODIGO_PRODUCTO: TIWDBLabel;
    lbNombre_Producto: TIWLabel;
    lbInfoRegistro: TIWLabel;
    DESCRIPCION: TIWDBMemo;
    BTNDESCRIPCION: TIWImage;
    IWLabel9: TIWLabel;
    CANTIDAD: TIWDBLabel;
    BTNCANTIDAD: TIWImage;
    IWLabel11: TIWLabel;
    BTNCREARTERCERO: TIWImage;
    IWLabel2: TIWLabel;
    BTNOP: TIWImage;
    CODIGO_DOCUMENTO_OP: TIWDBLabel;
    NUMERO_OP: TIWDBLabel;
    lbInfoOP: TIWLabel;
    VALOR_UNITARIO: TIWDBLabel;
    BTNVALOR_UNITARIO: TIWImage;
    IWLabel4: TIWLabel;
    lbInfoTotal: TIWLabel;
    IWLabel5: TIWLabel;
    FECHA_MOVIMIENTO: TIWDBLabel;
    BTNFECHA_MOVIMIENTO: TIWImage;
    procedure BTNBACKAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure BTNBUSCARAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BtnAcarreoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNNOMBREAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNDIRECCIONAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNEMAILAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNFECHA_VENCIMIENTOAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNACTIVOAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BtnGridAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCODIGO_TERCEROAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCODIGO_PRODUCTOAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNDESCRIPCIONAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCANTIDADAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCREARTERCEROAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCREARPRODUCTOAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNOPAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNVALOR_UNITARIOAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNFECHA_MOVIMIENTOAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    FCNX : TConexion;
    FINFO : String;
    FCODIGO_DOCUMENTO : String;

    FQRMAESTRO : TMANAGER_DATA;

    FNAVEGADOR : TNavegador_ASE;
    FGRID_MAESTRO : TGRID_JQ;

    FCODIGO_ACTUAL : String;

    Procedure Preparar_Numero_Cero;
    Procedure Localizar_Registro(Sender: TObject; EventParams: TStringList);
    procedure Buscar_Info(pSD : Integer; pEvent : TIWAsyncEvent);

    Procedure Resultado_Orden_Produccion(Sender: TObject; EventParams: TStringList);
    Procedure Resultado_Producto(Sender: TObject; EventParams: TStringList);
    Procedure Resultado_Tercero(Sender: TObject; EventParams: TStringList);

    procedure Resultado_Nombre(EventParams: TStringList);
    procedure Resultado_Descripcion(EventParams: TStringList);
    procedure Resultado_Fecha_Movimiento(EventParams: TStringList);
    procedure Resultado_Fecha_Vencimiento(EventParams: TStringList);
    procedure Resultado_Cantidad(EventParams: TStringList);
    procedure Resultado_Valor_Unitario(EventParams: TStringList);
    procedure Resultado_Activo(EventParams: TStringList);

    Procedure Release_Me;

    Function Existe_Movimiento(Const pNumero : String): Boolean;

    Procedure Validar_Campos_Master(pSender: TObject);
    Function Documento_Activo: Boolean;

    Procedure NewRecordMaster(pSender: TObject);
    Procedure AfterPostMaster(pSender : TObject);
    Procedure DsDataChangeMaster(pSender: TObject);
    Procedure DsStateMaster(Sender: TObject);

    Function Info_OP(Const pNumero : Integer; Const pCodigo_Documento : String) : String;
    Function Info_Producto(Const pCodigo_Producto : String) : String;
    Procedure SetLabel;
    Procedure Estado_Controles;
    Function AbrirMaestro(Const pDato: String = ''): Boolean;
    procedure Resultado_BasicData(Sender: TObject; EventParams: TStringList);
    procedure Mostrar_BasicData(Const pId : Integer; Const pTitle, pCaptionCode, pFieldCode, pCaptionName, pFieldName, pFieldDestiny : String; pResult : TIWAsyncEvent);
  public
    Constructor Create(AOwner: TComponent; Const pCodigo_Documento : String);
  end;

implementation

{$R *.dfm}

Uses
  Math,
  UtLog,
  UtType,
  UtFecha,
  Variants,
  UtFuncion,
  Vcl.Graphics,
  Criptografia,
  Winapi.Windows,
  System.UITypes,
  System.StrUtils,
  ServerController,
  UtilsIW.Busqueda,
  TBL000.Info_Tabla,
  UtIWBasicData_ASE,
  Report.Saldo_Inventario,
  UtilsIW.Numero_Siguiente;

Procedure TFrIWMovto_Inventario.Preparar_Numero_Cero;
Begin
  Try
    FCNX.SQL.Active := False;
    FCNX.SQL.SQL.Clear;
    FCNX.SQL.SQL.Add(' SELECT * FROM ' + gInfo_Tablas[Id_TBL_Proyecto].Name + FCNX.No_Lock);
    FCNX.SQL.SQL.Add(' WHERE ' + FCNX.Trim_Sentence('CODIGO_PROYECTO') + ' = ' + QuotedStr(Justificar('0', '0', 10)));
    FCNX.SQL.Active := True;
    If FCNX.SQL.Active And (FCNX.SQL.RecordCount <= 0) Then
    Begin
      FCNX.SQL.Append;
      FCNX.SQL.FieldByName('CODIGO_PROYECTO').AsString := Justificar('0', '0', 10);
      FCNX.SQL.FieldByName('NOMBRE'         ).AsString := 'PROYECTO SIN DEFINIR';
      FCNX.SQL.FieldByName('FECHA_INICIAL'  ).AsString := FormatDateTime('YYYY-MM-DD', Now);
      FCNX.SQL.FieldByName('FECHA_FINAL'    ).AsString := FormatDateTime('YYYY-MM-DD', Now);
      FCNX.SQL.FieldByName('ID_ACTIVO'      ).AsString := 'N';
      FCNX.SQL.Post;
    End;

    FCNX.SQL.Active := False;
    FCNX.SQL.SQL.Clear;
    FCNX.SQL.SQL.Add(' SELECT * FROM ' + gInfo_Tablas[Id_TBL_Tercero].Name + FCNX.No_Lock);
    FCNX.SQL.SQL.Add(' WHERE ' + FCNX.Trim_Sentence('CODIGO_TERCERO') + ' = ' + QuotedStr(Justificar('0', '0', 20)));
    FCNX.SQL.Active := True;
    If FCNX.SQL.Active And (FCNX.SQL.RecordCount <= 0) Then
    Begin
      FCNX.SQL.Append;
      FCNX.SQL.FieldByName('CODIGO_TERCERO' ).AsString := Justificar('0', '0', 20);
      FCNX.SQL.FieldByName('NOMBRE'         ).AsString := 'TERCERO SIN DEFINIR';
      FCNX.SQL.FieldByName('ID_ACTIVO'      ).AsString := 'N';
      FCNX.SQL.Post;
    End;

    FCNX.SQL.Active := False;
    FCNX.SQL.SQL.Clear;
    FCNX.SQL.SQL.Add(' SELECT * FROM ' + gInfo_Tablas[Id_TBL_Orden_Produccion].Name + FCNX.No_Lock);
    FCNX.SQL.SQL.Add(' WHERE ' + FCNX.Trim_Sentence('CODIGO_DOCUMENTO') + ' = ' + QuotedStr(Trim(UserSession.DOCUMENTO_ORDEN_DE_PRODUCCION)));
    FCNX.SQL.SQL.Add(' AND NUMERO = 0');
    FCNX.SQL.Active := True;
    If FCNX.SQL.Active And (FCNX.SQL.RecordCount <= 0) Then
    Begin
      FCNX.SQL.Append;
      FCNX.SQL.FieldByName('CODIGO_DOCUMENTO').AsString  := UserSession.DOCUMENTO_ORDEN_DE_PRODUCCION;
      FCNX.SQL.FieldByName('NUMERO'          ).AsInteger := 0;
      FCNX.SQL.FieldByName('CODIGO_PROYECTO' ).AsString := Justificar('0', '0', 10);
      FCNX.SQL.FieldByName('CODIGO_TERCERO'  ).AsString := Justificar('0', '0', 20);
      FCNX.SQL.FieldByName('CODIGO_USUARIO'  ).AsString := UserSession.USER_CODE;
      FCNX.SQL.FieldByName('NOMBRE'          ).AsString := 'ORDEN DE PRODUCCION SIN DEFINIR';
      FCNX.SQL.FieldByName('FECHA_REGISTRO'  ).AsString := FormatDateTime('YYYY-MM-DD', Now);
      FCNX.SQL.FieldByName('HORA_REGISTRO'   ).AsString := FormatDateTime('HH:N:SS'   , Now);
      FCNX.SQL.FieldByName('ID_ACTIVO'       ).AsString := 'N';
      FCNX.SQL.Post;
    End;
    FCNX.SQL.Active := False;
    FCNX.SQL.SQL.Clear;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWMovto_Inventario.Preparar_Numero_Cero, ' + e.Message);
  End;
End;

procedure TFrIWMovto_Inventario.Resultado_BasicData(Sender: TObject; EventParams: TStringList);
Var
  lBD : TBasicData_ASE;
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (IWModalWindow1.ButtonIndex = 1) Then
    Begin
       If IWModalWindow1.ContentElement Is TBasicData_ASE Then
       Begin
         lBD := (IWModalWindow1.ContentElement As TBasicData_ASE);
         lBD.VALUECODE := Justificar(lBD.VALUECODE, ' ', FQRMAESTRO.QR.FieldByName(lBD.FIELDCODE).Size);
         If lBD.FIELDCODE <> 'CODIGO_TERCERO' Then
           lBD.VALUECODE := Justificar(lBD.VALUECODE, '0', FQRMAESTRO.QR.FieldByName(lBD.FIELDCODE).Size);
         lBD.VALUECODE := AnsiUpperCase(lBD.VALUECODE);
         If FCNX.Record_Insert(lBD.TABLENAME, lBD.FIELDCODE, lBD.FIELDNAME, lBD.VALUECODE, lBD.VALUENAME, [],[]) Then
           FQRMAESTRO.QR.FieldByName(lBD.DESTINY).AsString := lBD.VALUECODE;
         IWModalWindow1.ContentElement := Nil;
         lBD.Free;
       End;
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWMovto_Inventario.Resultado_BasicData, ' + e.Message);
  End;
End;

procedure TFrIWMovto_Inventario.Mostrar_BasicData(Const pId : Integer; Const pTitle, pCaptionCode, pFieldCode, pCaptionName, pFieldName, pFieldDestiny : String; pResult : TIWAsyncEvent);
Var
  lRG : TBasicData_ASE;
begin
  Try
    lRG := TBasicData_ASE.Create(Self);
    lRG.Parent := Self;
    lRG.SetBasicData(pCaptionCode, pFieldCode, pCaptionName, pFieldName, gInfo_Tablas[pId].Name, pFieldDestiny);
    IWModalWindow1.Reset;
    IWModalWindow1.Buttons.CommaText := '&Aceptar,&Cancelar';
    IWModalWindow1.Title := pTitle;
    IWModalWindow1.Autosize := False;
    IWModalWindow1.WindowWidth := lRG.Width + 20;
    IWModalWindow1.WindowHeight := lRG.Height + 80;
    IWModalWindow1.SizeUnit := suPixel;
    IWModalWindow1.Draggable := True;
    IWModalWindow1.ContentElement := lRG;
    IWModalWindow1.OnAsyncClick := pResult;
    IWModalWindow1.OnAsyncClose := pResult;
    IWModalWindow1.Show;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWMovto_Inventario.Mostrar_BasicData, ' + e.Message);
  End;
End;

Procedure TFrIWMovto_Inventario.Resultado_Orden_Produccion(Sender: TObject; EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      FQRMAESTRO.QR.FieldByName('CODIGO_DOCUMENTO_OP').AsString := EventParams.Values ['CODIGO_DOCUMENTO'];
      FQRMAESTRO.QR.FieldByName('NUMERO_OP'          ).AsString := EventParams.Values ['NUMERO'          ];
    End;
  Except
   On E: Exception Do
     UtLog_Execute('TFrIWMovto_Inventario.Resultado_Orden_Produccion, ' + e.Message);
  End;
End;

Procedure TFrIWMovto_Inventario.Resultado_Producto(Sender: TObject; EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      FQRMAESTRO.QR.FieldByName('CODIGO_PRODUCTO').AsString := EventParams.Values ['CODIGO_PRODUCTO'];
      FQRMAESTRO.QR.FieldByName('VALOR_UNITARIO' ).AsFloat  := FCNX.GetValueDbl(gInfo_Tablas[Id_TBL_Producto].Name, ['CODIGO_PRODUCTO'], [EventParams.Values ['CODIGO_PRODUCTO']], ['VALOR_UNITARIO']);
    End;
  Except
   On E: Exception Do
     UtLog_Execute('TFrIWMovto_Inventario.Resultado_Producto, ' + e.Message);
  End;
End;

Procedure TFrIWMovto_Inventario.Resultado_Tercero(Sender: TObject; EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      FQRMAESTRO.QR.FieldByName('CODIGO_TERCERO').AsString := EventParams.Values ['CODIGO_TERCERO'];
    End;
  Except
   On E: Exception Do
     UtLog_Execute('TFrIWMovto_Inventario.Resultado_Tercero, ' + e.Message);
  End;
End;

procedure TFrIWMovto_Inventario.Buscar_Info(pSD : Integer; pEvent : TIWAsyncEvent);
Var
  lBusqueda : TBusqueda_MQI_WjQDBGrid;
begin
  Try
    lBusqueda := TBusqueda_MQI_WjQDBGrid.Create(Self);
    lBusqueda.Parent := Self;
    lBusqueda.SetComponents(FCNX, pEvent);
    lBusqueda.SetTSD(pSD);
    If lBusqueda.Abrir_Tabla Then
    Begin
      IWModalWindow1.Reset;
      IWModalWindow1.Buttons.CommaText := '&Cancelar';
      IWModalWindow1.Title := 'Busqueda de datos';
      IWModalWindow1.ContentElement := lBusqueda;
      IWModalWindow1.Autosize := True;
      IWModalWindow1.Draggable := True;
      IWModalWindow1.WindowTop := 10;
      IWModalWindow1.WindowLeft := 10;
      IWModalWindow1.WindowWidth := lBusqueda.Width + 20;
      IWModalWindow1.WindowHeight := lBusqueda.Height + 200;
      IWModalWindow1.OnAsyncClick := lBusqueda.Finish_Manager;
      IWModalWindow1.OnAsyncClose := lBusqueda.Finish_Manager;
      IWModalWindow1.SizeUnit := suPixel;
      IWModalWindow1.Show;
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWMovto_Inventario.Buscar_Info, ' + e.Message);
  End;
End;

procedure TFrIWMovto_Inventario.Resultado_Nombre(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
    Begin
      FQRMAESTRO.QR.FieldByName('NOMBRE').AsString := AnsiUpperCase(Trim(EventParams.Values['InputStr']));
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWMovto_Inventario.Resultado_Nombre, ' + e.Message);
  End;
End;

procedure TFrIWMovto_Inventario.Resultado_Descripcion(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
    Begin
      FQRMAESTRO.QR.FieldByName('DESCRIPCION').AsString := AnsiUpperCase(Trim(EventParams.Values['InputStr']));
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWMovto_Inventario.Resultado_Descripcion, ' + e.Message);
  End;
End;

procedure TFrIWMovto_Inventario.Resultado_Fecha_Movimiento(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
    Begin
      FQRMAESTRO.QR.FieldByName('FECHA_MOVIMIENTO').AsString := AnsiUpperCase(Trim(EventParams.Values['InputStr']));
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWMovto_Inventario.Resultado_Fecha_Movimiento, ' + e.Message);
  End;
End;

procedure TFrIWMovto_Inventario.Resultado_Fecha_Vencimiento(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
    Begin
      FQRMAESTRO.QR.FieldByName('FECHA_VENCIMIENTO').AsString := AnsiUpperCase(Trim(EventParams.Values['InputStr']));
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWMovto_Inventario.Resultado_Fecha_Vencimiento, ' + e.Message);
  End;
End;

procedure TFrIWMovto_Inventario.Resultado_Cantidad(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
    Begin
      FQRMAESTRO.QR.FieldByName('CANTIDAD').AsFloat := SetToFloat(EventParams.Values['InputStr']);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWMovto_Inventario.Resultado_Cantidad, ' + e.Message);
  End;
End;

procedure TFrIWMovto_Inventario.Resultado_Valor_Unitario(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
    Begin
      FQRMAESTRO.QR.FieldByName('VALOR_UNITARIO').AsFloat := SetToFloat(EventParams.Values['InputStr']);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWMovto_Inventario.Resultado_Valor_Unitario, ' + e.Message);
  End;
End;

procedure TFrIWMovto_Inventario.Resultado_Activo(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition Then
      FQRMAESTRO.QR.FieldByName('ID_ACTIVO').AsString := IfThen(Result_Is_OK(EventParams.Values['RetValue']), 'S', 'N');
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWMovto_Inventario.Resultado_Activo, ' + e.Message);
  End;
End;

Procedure TFrIWMovto_Inventario.Release_Me;
Begin
  Self.Release;
End;

Function TFrIWMovto_Inventario.Existe_Movimiento(Const pNumero : String) : Boolean;
Begin
  Result := FCNX.Record_Exist(gInfo_Tablas[Id_TBL_Movto_Inventario].Name, ['CODIGO_DOCUMENTO', 'NUMERO'], [FCODIGO_DOCUMENTO, pNumero]);
End;

Procedure TFrIWMovto_Inventario.Validar_Campos_Master(pSender: TObject);
Var
  lMensaje: String;
Begin
  FQRMAESTRO.ERROR := 0;
  Try
    lMensaje := '';
    NUMERO.BGColor := UserSession.COLOR_OK;
    NOMBRE.BGColor := UserSession.COLOR_OK;
    CANTIDAD.BGColor := UserSession.COLOR_OK;
    CODIGO_TERCERO.BGColor := UserSession.COLOR_OK;
    CODIGO_PRODUCTO.BGColor := UserSession.COLOR_OK;

    If FQRMAESTRO.DS.State In [dsInsert] Then
    Begin
      If FQRMAESTRO.QR.FieldByName('NUMERO').AsInteger <= 0 Then
      Begin
        lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Movimiento invalido';
        NUMERO.BGColor := UserSession.COLOR_ERROR;
      End
      Else
      Begin
        If Existe_Movimiento(IntToStr(FQRMAESTRO.QR.FieldByName('NUMERO').AsInteger)) Then
          FQRMAESTRO.QR.FieldByName('NUMERO').AsInteger := UtilsIW_Numero_Siguiente_Get(FCNX, FCODIGO_DOCUMENTO);
        If Existe_Movimiento(IntToStr(FQRMAESTRO.QR.FieldByName('NUMERO').AsInteger)) Or (FQRMAESTRO.QR.FieldByName('NUMERO').AsInteger <= 0) Then
        Begin
          lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Movimiento ya existente';
          NUMERO.BGColor := UserSession.COLOR_ERROR;
        End;
      End;
    End;

    If BTNNOMBRE.Visible And Vacio(FQRMAESTRO.QR.FieldByName('NOMBRE').AsString) Then
    Begin
      lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Nombre invalido';
      NOMBRE.BGColor := UserSession.COLOR_ERROR;
    End;

    If FQRMAESTRO.Mode_Edition And Vacio(FQRMAESTRO.QR.FieldByName('CODIGO_TERCERO').AsString) Then
    Begin
      lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Tercero invalido';
      CODIGO_TERCERO.BGColor := UserSession.COLOR_ERROR;
    End;

    If FQRMAESTRO.Mode_Edition And Vacio(FQRMAESTRO.QR.FieldByName('CODIGO_PRODUCTO').AsString) Then
    Begin
      lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Producto invalido';
      CODIGO_PRODUCTO.BGColor := UserSession.COLOR_ERROR;
    End;

    If FQRMAESTRO.Mode_Edition And (FQRMAESTRO.QR.FieldByName('CANTIDAD').AsInteger <= 0) Then
    Begin
      lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Cantidad no valida';
      CANTIDAD.BGColor := UserSession.COLOR_ERROR;
    End;

    FQRMAESTRO.ERROR := IfThen(Vacio(lMensaje), 0, -1);
    If FQRMAESTRO.ERROR <> 0 Then
    Begin
      FQRMAESTRO.LAST_ERROR := 'Datos invalidos, ' + lMensaje;
      UserSession.SetMessage(FQRMAESTRO.LAST_ERROR, True);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWMovto_Inventario.Validar_Campos_Master, ' + E.Message);
  End;
End;

Procedure TFrIWMovto_Inventario.Estado_Controles;
Begin
  NUMERO.Enabled               := False;
  BTNOP.Visible                := FQRMAESTRO.Mode_Edition And Documento_Activo And
                                  (Trim(FCODIGO_DOCUMENTO) = Trim(UserSession.DOCUMENTO_SALIDA_DE_INVENTARIO));
  lbInfoOP.Visible             := BTNOP.Visible;
  BTNCODIGO_TERCERO.Visible    := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNCODIGO_PRODUCTO.Visible   := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNNOMBRE.Visible            := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNDESCRIPCION.Visible       := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNFECHA_MOVIMIENTO.Visible  := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNFECHA_VENCIMIENTO.Visible := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNCANTIDAD.Visible          := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNVALOR_UNITARIO.Visible    := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNACTIVO.Visible            := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNCREARTERCERO.Visible      := FQRMAESTRO.Mode_Edition And Documento_Activo;
//BTNCREARPRODUCTO.Visible     := FQRMAESTRO.Mode_Edition And Documento_Activo;
  DATO.Visible                 := (Not FQRMAESTRO.Mode_Edition);
  PAG_00.Visible               := (Not FQRMAESTRO.Mode_Edition);
  PAG_01.Visible               := True;
End;

Function TFrIWMovto_Inventario.Info_OP(Const pNumero : Integer; Const pCodigo_Documento : String) : String;
Begin
  Result :=  '';
  Try
    FCNX.TMP.Active := False;
    FCNX.TMP.SQL.Clear;
    FCNX.TMP.SQL.Add(' SELECT ');
    FCNX.TMP.SQL.Add('         OP.NOMBRE AS NOMBRE_OP ');
    FCNX.TMP.SQL.Add('        ,TERC.NOMBRE AS NOMBRE_TERCERO ');
    FCNX.TMP.SQL.Add('        ,PROY.NOMBRE AS NOMBRE_PROYECTO ');
    FCNX.TMP.SQL.Add(' FROM ' + gInfo_Tablas[Id_TBL_Orden_Produccion].Name + ' OP ' + FCNX.No_Lock);
    FCNX.TMP.SQL.Add(' INNER JOIN ' + gInfo_Tablas[Id_TBL_Tercero].Name + ' TERC ' + FCNX.No_Lock);
    FCNX.TMP.SQL.Add(' ON TERC.CODIGO_TERCERO = OP.CODIGO_TERCERO ');
    FCNX.TMP.SQL.Add(' INNER JOIN ' + gInfo_Tablas[Id_TBL_Proyecto].Name + ' PROY ' + FCNX.No_Lock);
    FCNX.TMP.SQL.Add(' ON PROY.CODIGO_PROYECTO = OP.CODIGO_PROYECTO ');
    FCNX.TMP.SQL.Add(' WHERE ' + FCNX.Trim_Sentence('CODIGO_DOCUMENTO') + ' = ' + QuotedStr(Trim(pCodigo_Documento)));
    FCNX.TMP.SQL.Add(' AND NUMERO = ' + IntToStr(pNumero));
    FCNX.TMP.Active := True;
    If FCNX.TMP.Active And (FCNX.TMP.RecordCount > 0) Then
      Result := Trim(FCNX.TMP.FieldByName('NOMBRE_OP').AsString) +
                ', Tercero: ' + Trim(FCNX.TMP.FieldByName('NOMBRE_TERCERO').AsString) +
                ', Proyecto: ' + Trim(FCNX.TMP.FieldByName('NOMBRE_PROYECTO').AsString);
    FCNX.TMP.Active := False;
    FCNX.TMP.SQL.Clear;
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWMovto_Inventario.Info_OP, ' + E.Message);
    End;
  End;
  Result := AnsiUpperCase(Result);
End;

Function TFrIWMovto_Inventario.Info_Producto(Const pCodigo_Producto : String) : String;
Var
  lExistencia : Double;
Begin
  Result :=  '';
  If Vacio(pCodigo_Producto) Then
    Exit;
  Try
    FCNX.TMP.Active := False;
    FCNX.TMP.SQL.Clear;
    FCNX.TMP.SQL.Add(' SELECT ');
    FCNX.TMP.SQL.Add('         PROD.NOMBRE AS NOMBRE_PRODUCTO ');
    FCNX.TMP.SQL.Add('        ,AREA.NOMBRE AS NOMBRE_AREA ');
    FCNX.TMP.SQL.Add('        ,UNID.NOMBRE AS NOMBRE_UNIDAD_MEDIDA ');
    FCNX.TMP.SQL.Add('        ,PROD.STOCK_MINIMO ');
    FCNX.TMP.SQL.Add(' FROM ' + gInfo_Tablas[Id_TBL_Producto].Name + ' PROD ' + FCNX.No_Lock);
    FCNX.TMP.SQL.Add(' INNER JOIN ' + gInfo_Tablas[Id_TBL_Area].Name + ' AREA ' + FCNX.No_Lock);
    FCNX.TMP.SQL.Add(' ON AREA.CODIGO_AREA = PROD.CODIGO_AREA ');
    FCNX.TMP.SQL.Add(' INNER JOIN ' + gInfo_Tablas[Id_TBL_Unidad_Medida].Name + ' UNID ' + FCNX.No_Lock);
    FCNX.TMP.SQL.Add(' ON UNID.CODIGO_UNIDAD_MEDIDA = PROD.CODIGO_UNIDAD_MEDIDA ');
    FCNX.TMP.Active := True;
    If FCNX.TMP.Active And (FCNX.TMP.RecordCount > 0) Then
      Result := Trim(FCNX.TMP.FieldByName('NOMBRE_PRODUCTO').AsString) +
                ', unidad de medida: ' + Trim(FCNX.TMP.FieldByName('NOMBRE_UNIDAD_MEDIDA').AsString) +
                ', area: ' + Trim(FCNX.TMP.FieldByName('NOMBRE_AREA').AsString) +
                ', stock minimo: ' + FormatFloat('###,###,##0.#0', FCNX.TMP.FieldByName('STOCK_MINIMO').AsFloat);
    FCNX.TMP.Active := False;
    FCNX.TMP.SQL.Clear;
    lExistencia := Report_Saldo_Inventario_Saldo(FCNX, pCodigo_Producto, pCodigo_Producto);
    Result := Result +  ', Existencia: ' + FormatFloat('###,###,##0.#0', lExistencia);
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWMovto_Inventario.Info_Producto, ' + E.Message);
    End;
  End;
  Result := AnsiUpperCase(Result);
End;

Procedure TFrIWMovto_Inventario.SetLabel;
Begin
  If Not FQRMAESTRO.Active Then
    Exit;
  Try
    lbInfoOP.Caption := Info_OP(FQRMAESTRO.QR.FieldByName('NUMERO_OP').AsInteger, FQRMAESTRO.QR.FieldByName('CODIGO_DOCUMENTO_OP').AsString);
    lbInfoTotal.Caption := 'TOTAL: ' + FormatFloat('###,###,###,##0.#0', FQRMAESTRO.QR.FieldByName('CANTIDAD').AsFloat * FQRMAESTRO.QR.FieldByName('VALOR_UNITARIO').AsFloat);
    lbNombre_Activo.Caption := IfThen(FQRMAESTRO.QR.FieldByName('ID_ACTIVO').AsString = 'S', 'Esta activo', 'No esta activo');
    lbNombre_Tercero.Caption := FCNX.GetValue(gInfo_Tablas[Id_TBL_Tercero].Name, ['CODIGO_TERCERO'], [FQRMAESTRO.QR.FieldByName('CODIGO_TERCERO').AsString], ['NOMBRE']);
    lbNombre_Producto.Caption := Info_Producto(FQRMAESTRO.QR.FieldByName('CODIGO_PRODUCTO').AsString);
    lbInfoRegistro.Caption := 'Usuario: ' + FCNX.GetValue(gInfo_Tablas[Id_TBL_Usuario].Name, ['CODIGO_USUARIO'], [FQRMAESTRO.QR.FieldByName('CODIGO_USUARIO').AsString], ['NOMBRE']);
    lbInfoRegistro.Caption := lbInfoRegistro.Caption + ', Fecha: ' + FQRMAESTRO.QR.FieldByName('FECHA_REGISTRO').AsString;
    lbInfoRegistro.Caption := lbInfoRegistro.Caption + ', Hora: ' + FQRMAESTRO.QR.FieldByName('HORA_REGISTRO').AsString;
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWMovto_Inventario.SetLabel, ' + E.Message);
    End;
  End;
End;

Function TFrIWMovto_Inventario.Documento_Activo: Boolean;
Begin
  Try
    Result := True;
    // Result := (FQRMAESTRO.RecordCount >= 1) {And (Trim(FQRMAESTRO.FieldByName('ID_ANULADO').AsString) <> 'S')};
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWMovto_Inventario.Documento_Activo, ' + E.Message);
    End;
  End;
End;

procedure TFrIWMovto_Inventario.DsDataChangeMaster(pSender: TObject);
begin

  FNAVEGADOR.UpdateState;
  If (Not FQRMAESTRO.Active)Then
    Exit;

  If FQRMAESTRO.Active Then
    lbInfo.Caption := FINFO + ' [ ' + FQRMAESTRO.QR.FieldByName('NUMERO').AsString + ', '+ FQRMAESTRO.QR.FieldByName('NOMBRE') .AsString + ' ] ';

  SetLabel;

  Try
    If (FCODIGO_ACTUAL <> FQRMAESTRO.QR.FieldByName('NUMERO').AsString) And (Not FQRMAESTRO.Mode_Edition) Then
    Begin
      FCODIGO_ACTUAL := FQRMAESTRO.QR.FieldByName('NUMERO').AsString;
    End;
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWMovto_Inventario.DsDataChangeMaster, ' + E.Message);
    End;
  End;
end;

Procedure TFrIWMovto_Inventario.DsStateMaster(Sender: TObject);
Begin
  If Not FQRMAESTRO.Active Then
    Exit;

  Estado_Controles;
  If FQRMAESTRO.Mode_Edition Then
    PAGINAS.ActivePage := 1;
  Case FQRMAESTRO.QR.State Of
    dsInsert : Begin
               End;
    dsEdit   : Begin

               End;
  End;
End;

Function TFrIWMovto_Inventario.AbrirMaestro(Const pDato: String = ''): Boolean;
Begin
  FGRID_MAESTRO.Caption := gInfo_Tablas[Id_TBL_Movto_Inventario].Caption;
  Result := False;
  Try
    FQRMAESTRO.Active := False;
    FQRMAESTRO.WHERE    := '';
    FQRMAESTRO.SENTENCE := ' SELECT ' + FCNX.Top_Sentence(Const_Max_Record) + ' * FROM ' + gInfo_Tablas[Id_TBL_Movto_Inventario].Name + FCNX.No_Lock;
    FQRMAESTRO.WHERE := ' WHERE ' + FCNX.Trim_Sentence('CODIGO_DOCUMENTO') + ' = ' + QuotedStr(Trim(FCODIGO_DOCUMENTO)) + #13;
    If Trim(pDato) <> '' Then
    Begin
      FQRMAESTRO.WHERE := FQRMAESTRO.WHERE + ' AND ' + #13;
      FQRMAESTRO.WHERE := FQRMAESTRO.WHERE + ' ( ' + #13;
      FQRMAESTRO.WHERE := FQRMAESTRO.WHERE + '    NOMBRE LIKE '          + QuotedStr('%' + Trim(pDato) + '%') + #13;
      FQRMAESTRO.WHERE := FQRMAESTRO.WHERE + ' OR NUMERO LIKE '          + QuotedStr('%' + Trim(pDato) + '%') + #13;
      FQRMAESTRO.WHERE := FQRMAESTRO.WHERE + ' OR CODIGO_TERCERO LIKE '  + QuotedStr('%' + Trim(pDato) + '%') + #13;
      FQRMAESTRO.WHERE := FQRMAESTRO.WHERE + ' OR CODIGO_PRODUCTO LIKE ' + QuotedStr('%' + Trim(pDato) + '%') + #13;
      FQRMAESTRO.WHERE := FQRMAESTRO.WHERE + ' OR CODIGO_USUARIO LIKE '  + QuotedStr('%' + Trim(pDato) + '%') + #13;
      FQRMAESTRO.WHERE := FQRMAESTRO.WHERE + ' OR FECHA_REGISTRO LIKE '  + QuotedStr('%' + Trim(pDato) + '%') + #13;
      FQRMAESTRO.WHERE := FQRMAESTRO.WHERE + ' OR HORA_REGISTRO LIKE '   + QuotedStr('%' + Trim(pDato) + '%') + #13;
      FQRMAESTRO.WHERE := FQRMAESTRO.WHERE + ' ) ';
    End;
    FQRMAESTRO.ORDER := ' ORDER BY NUMERO DESC ';
    FQRMAESTRO.Active := True;
    Result := FQRMAESTRO.Active;
    If Result Then
    Begin
      FQRMAESTRO.SetFormatNumber('CANTIDAD');
      FQRMAESTRO.SetFormatNumber('VALOR_UNITARIO');
    End;
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWMovto_Inventario.AbrirMaestro, ' + E.Message);
    End;
  End;
  FGRID_MAESTRO.RefreshData;
End;

constructor TFrIWMovto_Inventario.Create(AOwner: TComponent; Const pCodigo_Documento : String);
begin
  Inherited Create(AOwner);
  Try
    Self.FCODIGO_DOCUMENTO := pCodigo_Documento ;
    FINFO := FINFO + ' (' + Trim(pCodigo_Documento) + ') ';
    If (Trim(FCODIGO_DOCUMENTO) = Trim(UserSession.DOCUMENTO_ENTRADA_DE_INVENTARIO)) Then
      lbTercero.Caption := 'Proveedor'
    Else
      If (Trim(FCODIGO_DOCUMENTO) = Trim(UserSession.DOCUMENTO_SALIDA_DE_INVENTARIO )) Then
        lbTercero.Caption := 'Solicitante';
    If (Trim(FCODIGO_DOCUMENTO) <> Trim(UserSession.DOCUMENTO_SALIDA_DE_INVENTARIO)) Then
      Preparar_Numero_Cero;
    If AbrirMaestro Then
    Begin
    End
    Else
      Release_Me
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWMovto_Inventario.IWAppFormCreate, ' + E.Message);
    End;
  End;
end;

procedure TFrIWMovto_Inventario.IWAppFormCreate(Sender: TObject);
begin
  Randomize;
  Self.Name := 'USUARIO' + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now) + IntToStr(Random(1000));
  FCNX := UserSession.CNX;
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Nombre'           , Resultado_Nombre           );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Descripcion'      , Resultado_Descripcion      );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Fecha_Movimiento' , Resultado_Fecha_Movimiento );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Fecha_Vencimiento', Resultado_Fecha_Vencimiento);
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Cantidad'         , Resultado_Cantidad         );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Valor_Unitario'   , Resultado_Valor_Unitario   );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Activo'           , Resultado_Activo           );
  FCODIGO_ACTUAL := '';
  FINFO := UserSession.FULL_INFO + gInfo_Tablas[Id_TBL_Movto_Inventario].Caption;
  Try
    FGRID_MAESTRO        := TGRID_JQ.Create(PAG_00);
    FGRID_MAESTRO.Parent := PAG_00;
    FGRID_MAESTRO.Top    := 010;
    FGRID_MAESTRO.Left   := 010;
    FGRID_MAESTRO.Width  := 700;
    FGRID_MAESTRO.Height := 500;

    FQRMAESTRO := UserSession.Create_Manager_Data(gInfo_Tablas[Id_TBL_Movto_Inventario].Name, gInfo_Tablas[Id_TBL_Movto_Inventario].Caption);

    FQRMAESTRO.ON_NEW_RECORD   := NewRecordMaster;
    FQRMAESTRO.ON_AFTER_POST   := AfterPostMaster;
    FQRMAESTRO.ON_DATA_CHANGE  := DsDataChangeMaster;
    FQRMAESTRO.ON_STATE_CHANGE := DsStateMaster;
    FQRMAESTRO.ON_BEFORE_POST  := Validar_Campos_Master;

    NUMERO.DataSource              := FQRMAESTRO.DS;
    CODIGO_DOCUMENTO_OP.DataSource := FQRMAESTRO.DS;
    NUMERO_OP.DataSource           := FQRMAESTRO.DS;
    NOMBRE.DataSource              := FQRMAESTRO.DS;
    CODIGO_TERCERO.DataSource      := FQRMAESTRO.DS;
    CODIGO_PRODUCTO.DataSource     := FQRMAESTRO.DS;
    DESCRIPCION.DataSource         := FQRMAESTRO.DS;
    FECHA_MOVIMIENTO.DataSource    := FQRMAESTRO.DS;
    FECHA_VENCIMIENTO.DataSource   := FQRMAESTRO.DS;
    CANTIDAD.DataSource            := FQRMAESTRO.DS;
    VALOR_UNITARIO.DataSource      := FQRMAESTRO.DS;

    FGRID_MAESTRO.SetGrid(FQRMAESTRO.DS, ['NUMERO'        , 'NOMBRE'     , 'CODIGO_PRODUCTO', 'FECHA_REGISTRO', 'FECHA_MOVIMIENTO'],
                                         ['numero'        , 'Nombre'     , 'Producto'       , 'Registro'      , 'Movimiento'      ],
                                         ['S'             , 'N'          , 'N'              , 'N'             , 'N'               ],
                                         [080             , 150          , 150              , 100             , 100               ],
                                         [taRightJustify  , taLeftJustify, taRightJustify   , taRightJustify  , taRightJustify    ]);
    FNAVEGADOR               := TNavegador_ASE.Create(IWRegion_Navegador);
    FNAVEGADOR.Parent        := IWRegion_Navegador;
    FNAVEGADOR.SetNavegador(FQRMAESTRO, WebApplication, FGRID_MAESTRO);
    FNAVEGADOR.ACTION_SEARCH := BTNBUSCARAsyncClick ;
    FNAVEGADOR.ACTION_COPY   := BtnAcarreoAsyncClick;
    FNAVEGADOR.ACTION_EXIT   := BTNBACKAsyncClick   ;
    FNAVEGADOR.Top  := 1;
    FNAVEGADOR.Left := 1;
    IWRegion_Navegador.Width  := FNAVEGADOR.Width  + 1;
    IWRegion_Navegador.Height := FNAVEGADOR.Height + 1;

  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWMovto_Inventario.IWAppFormCreate, ' + E.Message);
    End;
  End;
end;

procedure TFrIWMovto_Inventario.IWAppFormDestroy(Sender: TObject);
begin
  Try
    If Assigned(FQRMAESTRO) Then
    Begin
      FQRMAESTRO.Active := False;
      FreeAndNil(FQRMAESTRO);
    End;

    If Assigned(FGRID_MAESTRO) Then
      FreeAndNil(FGRID_MAESTRO);

    If Assigned(FNAVEGADOR) Then
      FreeAndNil(FNAVEGADOR);

  Except
    On E: Exception Do
      UtLog_Execute('TFrIWMovto_Inventario.IWAppFormDestroy, ' + E.Message);
  End;
end;

procedure TFrIWMovto_Inventario.NewRecordMaster(pSender: TObject);
begin
  Inherited;
  Try
    FQRMAESTRO.QR.FieldByName('CODIGO_DOCUMENTO' ).AsString  := FCODIGO_DOCUMENTO;
    FQRMAESTRO.QR.FieldByName('NUMERO'           ).AsInteger := UtilsIW_Numero_Siguiente_Get(FCNX, FCODIGO_DOCUMENTO);
    FQRMAESTRO.QR.FieldByName('CODIGO_USUARIO'   ).AsString  := UserSession.USER_CODE            ;
    FQRMAESTRO.QR.FieldByName('FECHA_REGISTRO'   ).AsString  := FormatDateTime('YYYY-MM-DD', Now);
    FQRMAESTRO.QR.FieldByName('HORA_REGISTRO'    ).AsString  := FormatDateTime('HH:NN:SS'  , Now);
    FQRMAESTRO.QR.FieldByName('FECHA_MOVIMIENTO' ).AsString  := FormatDateTime('YYYY-MM-DD', Now);
    FQRMAESTRO.QR.FieldByName('FECHA_VENCIMIENTO').AsString  := FormatDateTime('YYYY-MM-DD', Now);
    FQRMAESTRO.QR.FieldByName('ID_ACTIVO'        ).AsString  := 'S';
    If (Trim(FCODIGO_DOCUMENTO) <> Trim(UserSession.DOCUMENTO_SALIDA_DE_INVENTARIO)) Then
    Begin
      FQRMAESTRO.QR.FieldByName('CODIGO_DOCUMENTO_OP').AsString  := UserSession.DOCUMENTO_ORDEN_DE_PRODUCCION;
      FQRMAESTRO.QR.FieldByName('NUMERO_OP'          ).AsInteger := 0;
    End;
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWMovto_Inventario.NewRecordMaster, ' + E.Message);
    End;
  End;
end;

procedure TFrIWMovto_Inventario.AfterPostMaster(pSender : TObject);
begin
  Try
    FCODIGO_ACTUAL := '';
    If FQRMAESTRO.NEW_RECORD Then
       UtilsIW_Numero_Siguiente_Put(FCNX, FCODIGO_DOCUMENTO, FQRMAESTRO.QR.FieldByName('NUMERO').AsInteger);
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWMovto_Inventario.AfterPostMaster, ' + E.Message);
    End;
  End;
end;

procedure TFrIWMovto_Inventario.BtnAcarreoAsyncClick(Sender: TObject;  EventParams: TStringList);
begin
  FQRMAESTRO.SetAcarreo(Not FQRMAESTRO.ACARREO, ['CODIGO_DOCUMENTO', 'NUMERO'], [FQRMAESTRO.QR.FieldByName('CODIGO_DOCUMENTO').AsString, FQRMAESTRO.QR.FieldByName('NUMERO').AsString]);
end;

procedure TFrIWMovto_Inventario.BTNACTIVOAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  WebApplication.ShowConfirm('Esta activo?', Self.Name + '.Resultado_Activo', 'Activo', 'Sí', 'No')
end;

procedure TFrIWMovto_Inventario.BTNBACKAsyncClick(Sender: TObject;  EventParams: TStringList);
begin
  If FQRMAESTRO.Mode_Edition Then
    FQRMAESTRO.QR.Cancel;
  Release_Me;
end;

Procedure TFrIWMovto_Inventario.Localizar_Registro(Sender: TObject; EventParams: TStringList);
Begin
  Try
    AbrirMaestro(EventParams.Values['NUMERO']);
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWMovto_Inventario.Localizar_Registro, ' + e.Message);
  End;
End;

procedure TFrIWMovto_Inventario.BTNBUSCARAsyncClick(Sender: TObject;  EventParams: TStringList);
begin
  Try
    If Vacio(DATO.Text) Then
    Begin
      Buscar_Info(Id_TBL_Movto_Inventario, Localizar_Registro);
    End
    Else
    Begin
      AbrirMaestro(DATO.Text);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWAdm_Documento.BTNBUSCARAsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWMovto_Inventario.BTNNOMBREAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese el nombre del Movimiento', Self.Name + '.Resultado_Nombre', 'Nombre', FQRMAESTRO.QR.FieldByName('NOMBRE').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWMovto_Inventario.BTNNOMBREAsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWMovto_Inventario.BTNOPAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Buscar_Info(Id_TBL_Orden_Produccion, Resultado_Orden_Produccion);
end;

procedure TFrIWMovto_Inventario.BTNVALOR_UNITARIOAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese el valor unitario', Self.Name + '.Resultado_Valor_Unitario', 'Valor Unitario', FQRMAESTRO.QR.FieldByName('VALOR_UNITARIO').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWMovto_Inventario.BTNVALOR_UNITARIOAsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWMovto_Inventario.BTNFECHA_MOVIMIENTOAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese la fecha de movimento ', Self.Name + '.Resultado_Fecha_Movimiento', 'Fecha de movimiento', FQRMAESTRO.QR.FieldByName('FECHA_MOVIMIENTO').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWMovto_Inventario.BTNFECHA_MOVIMIENTOAsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWMovto_Inventario.BTNFECHA_VENCIMIENTOAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese la fecha de vencimiento ', Self.Name + '.Resultado_Fecha_Vencimiento', 'Fecha de vencimiento', FQRMAESTRO.QR.FieldByName('FECHA_VENCIMIENTO').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWMovto_Inventario.BTNFECHA_VENCIMIENTOAsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWMovto_Inventario.BTNCANTIDADAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese la cantidad', Self.Name + '.Resultado_Cantidad', 'Cantidad', FQRMAESTRO.QR.FieldByName('CANTIDAD').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWMovto_Inventario.BTNCANTIDADAsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWMovto_Inventario.BTNCODIGO_PRODUCTOAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Buscar_Info(Id_TBL_Producto, Resultado_Producto);
end;

procedure TFrIWMovto_Inventario.BTNCODIGO_TERCEROAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Buscar_Info(Id_TBL_Tercero, Resultado_Tercero);
end;

procedure TFrIWMovto_Inventario.BTNCREARPRODUCTOAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Mostrar_BasicData(Id_TBL_Producto, 'Ingreso del Producto', 'Codigo', 'CODIGO_PRODUCTO', 'Nombre' , 'NOMBRE', 'CODIGO_PRODUCTO', Resultado_BasicData);
end;

procedure TFrIWMovto_Inventario.BTNCREARTERCEROAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Mostrar_BasicData(Id_TBL_Tercero, 'Ingreso del Tercero', 'Identificación', 'CODIGO_TERCERO', 'Nombre' , 'NOMBRE', 'CODIGO_TERCERO', Resultado_BasicData);
end;

procedure TFrIWMovto_Inventario.BTNDESCRIPCIONAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese el descripcion del Movimiento', Self.Name + '.Resultado_Descripcion', 'Descripcion', FQRMAESTRO.QR.FieldByName('DESCRIPCION').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWMovto_Inventario.BTNDESCRIPCIONAsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWMovto_Inventario.BTNDIRECCIONAsyncClick(Sender: TObject; EventParams: TStringList);
Var
  ltmp : String;
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      ltmp := FQRMAESTRO.QR.FieldByName('DIRECCION').AsString;
      WebApplication.ShowPrompt('Ingrese la dirección', Self.Name + '.Resultado_Direccion', 'Dirección', ltmp);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWMovto_Inventario.BTNDIRECCIONAsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWMovto_Inventario.BTNEMAILAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese el correo electronico', Self.Name + '.Resultado_Email', 'Correo electronico', FQRMAESTRO.QR.FieldByName('EMAIL').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWMovto_Inventario.BTNEMAILAsyncClick, ' + e.Message);
  End;
end;


procedure TFrIWMovto_Inventario.BtnGridAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  UserSession.ShowForm_Perfil_Enc(FQRMAESTRO.QR.FieldByName('CODIGO_PERFIL').AsString);
end;

end.
