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
  UtGrid_JQ, UtNavegador_ASE, Utils.IWSelect_ASE;

type
  TItem_Select = Class
    Public
      CODE : TStringList;
      Constructor Create;
      Destructor Destroy;
  End;

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
    NUMERO: TIWDBLabel;
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
    IWLabel9: TIWLabel;
    IWLabel11: TIWLabel;
    BTNCREARTERCERO: TIWImage;
    IWLabel2: TIWLabel;
    BTNOP: TIWImage;
    CODIGO_DOCUMENTO_OP: TIWDBLabel;
    NUMERO_OP: TIWDBLabel;
    lbInfoOP: TIWLabel;
    IWLabel4: TIWLabel;
    lbInfoTotal: TIWLabel;
    IWLabel5: TIWLabel;
    NOMBRE: TIWDBEdit;
    DESCRIPCION: TIWDBMemo;
    FECHA_MOVIMIENTO: TIWDBEdit;
    FECHA_VENCIMIENTO: TIWDBEdit;
    CANTIDAD: TIWDBEdit;
    VALOR_UNITARIO: TIWDBEdit;
    ID_ACTIVO: TIWDBCheckBox;
    IWLabel7: TIWLabel;
    CODIGO_AREA: TIWDBLabel;
    BTNCODIGO_AREA: TIWImage;
    lbNombre_Area: TIWLabel;
    IWModalWindow1: TIWModalWindow;
    procedure BTNBACKAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure BTNBUSCARAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BtnAcarreoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BtnGridAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCODIGO_TERCEROAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCODIGO_PRODUCTOAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCREARTERCEROAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCREARPRODUCTOAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNOPAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure CANTIDADAsyncExit(Sender: TObject; EventParams: TStringList);
    procedure BTNCODIGO_AREAAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure ITEMS_OPAsyncChange(Sender: TObject; EventParams: TStringList);
  private
    FCNX : TConexion;
    FINFO : String;
    FCODIGO_DOCUMENTO : String;

    FQRMAESTRO : TMANAGER_DATA;

    FNAVEGADOR : TNavegador_ASE;
    FGRID_MAESTRO : TGRID_JQ;

    FCODIGO_ACTUAL : String;

    FBusqueda_OP : TSelect_ASE;
    FBusqueda_Area : TSelect_ASE;
    FBusqueda_Tercero : TSelect_ASE;
    FBusqueda_Producto : TSelect_ASE;

    Procedure Cargar_Productos;
    Procedure Cargar_Terceros;
    Procedure Cargar_Areas;
    Procedure Cargar_OP;
    Function Cantidad_Valida: Boolean;
    Procedure Info_Calculated(pDataset : TDataSet);

    Procedure Preparar_Numero_Cero;
    Procedure Localizar_Registro(Sender: TObject; EventParams: TStringList);

    Procedure Resultado_Orden_Produccion(Sender: TObject; EventParams: TStringList);
    Procedure Resultado_Producto(Sender: TObject; EventParams: TStringList);
    Procedure Resultado_Area(Sender: TObject; EventParams: TStringList);
    Procedure Resultado_Tercero(Sender: TObject; EventParams: TStringList);

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
  UtType,
  UtFecha,
  IWjQGrid,
  Variants,
  UtFuncion,
  Vcl.Graphics,
  Criptografia,
  Winapi.Windows,
  System.UITypes,
  System.StrUtils,
  ServerController,
  TBL000.Info_Tabla,
  UtIWBasicData_ASE,
  UtilsIW.ManagerLog,
  Report.Saldo_Inventario,
  UtilsIW.Numero_Siguiente;

{ TItem_Select }
Constructor TItem_Select.Create;
Begin
  CODE := TStringList.Create;
End;

Destructor TItem_Select.Destroy;
Begin
  CODE.Clear;
  FreeAndNil(CODE);
End;

Procedure TFrIWMovto_Inventario.Preparar_Numero_Cero;
Begin
  Try
    FCNX.SQL.Active := False;
    FCNX.SQL.SQL.Clear;
    FCNX.SQL.SQL.Add(' SELECT * FROM ' + Info_TablaGet(Id_TBL_Proyecto).Name + FCNX.No_Lock);
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
    FCNX.SQL.SQL.Add(' SELECT * FROM ' + Info_TablaGet(Id_TBL_Tercero).Name + FCNX.No_Lock);
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
    FCNX.SQL.SQL.Add(' SELECT * FROM ' + Info_TablaGet(Id_TBL_Orden_Produccion).Name + FCNX.No_Lock);
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMovto_Inventario', 'TFrIWMovto_Inventario.Preparar_Numero_Cero', E.Message);
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMovto_Inventario', 'TFrIWMovto_Inventario.Resultado_BasicData', E.Message);
  End;
End;

procedure TFrIWMovto_Inventario.Mostrar_BasicData(Const pId : Integer; Const pTitle, pCaptionCode, pFieldCode, pCaptionName, pFieldName, pFieldDestiny : String; pResult : TIWAsyncEvent);
Var
  lRG : TBasicData_ASE;
begin
  Try
    lRG := TBasicData_ASE.Create(Self);
    lRG.Parent := Self;
    lRG.SetBasicData(pCaptionCode, pFieldCode, pCaptionName, pFieldName, Info_TablaGet(pId).Name, pFieldDestiny);
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMovto_Inventario', 'TFrIWMovto_Inventario.Mostrar_BasicData', E.Message);
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
     Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMovto_Inventario', 'TFrIWMovto_Inventario.Resultado_Orden_Produccion', E.Message);
  End;
End;

Procedure TFrIWMovto_Inventario.Resultado_Producto(Sender: TObject; EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      FQRMAESTRO.QR.FieldByName('CODIGO_PRODUCTO').AsString := EventParams.Values ['CODIGO_PRODUCTO'];
      FQRMAESTRO.QR.FieldByName('CODIGO_AREA'    ).AsString := FCNX.GetValue(Info_TablaGet(Id_TBL_Producto).Name, ['CODIGO_PRODUCTO'], [FQRMAESTRO.QR.FieldByName('CODIGO_PRODUCTO').AsString], ['CODIGO_AREA']);
      FQRMAESTRO.QR.FieldByName('VALOR_UNITARIO' ).AsFloat  := FCNX.GetValueDbl(Info_TablaGet(Id_TBL_Producto).Name, ['CODIGO_PRODUCTO'], [FQRMAESTRO.QR.FieldByName('CODIGO_PRODUCTO').AsString], ['VALOR_UNITARIO']);
      Cantidad_Valida;
    End;
  Except
   On E: Exception Do
     Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMovto_Inventario', 'TFrIWMovto_Inventario.Resultado_Producto', E.Message);
  End;
End;

Procedure TFrIWMovto_Inventario.Resultado_Area(Sender: TObject; EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      FQRMAESTRO.QR.FieldByName('CODIGO_AREA').AsString := EventParams.Values ['CODIGO_AREA'];
    End;
  Except
   On E: Exception Do
     Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMovto_Inventario', 'TFrIWMovto_Inventario.Resultado_Area', E.Message);
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
     Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMovto_Inventario', 'TFrIWMovto_Inventario.Resultado_Tercero', E.Message);
  End;
End;


Procedure TFrIWMovto_Inventario.Release_Me;
Begin
  Self.Release;
End;

Function TFrIWMovto_Inventario.Existe_Movimiento(Const pNumero : String) : Boolean;
Begin
  Result := FCNX.Record_Exist(Info_TablaGet(Id_TBL_Movto_Inventario).Name, ['CODIGO_DOCUMENTO', 'NUMERO'], [FCODIGO_DOCUMENTO, pNumero]);
End;

procedure TFrIWMovto_Inventario.CANTIDADAsyncExit(Sender: TObject; EventParams: TStringList);
begin
  Cantidad_Valida;
end;

Function TFrIWMovto_Inventario.Cantidad_Valida: Boolean;
Var
  lEDM : Double;
  lINV : Double;
Begin
  Result := True;
  If (Trim(FCODIGO_DOCUMENTO) <> Trim(UserSession.DOCUMENTO_SALIDA_DE_INVENTARIO)) Or Vacio(FQRMAESTRO.QR.FieldByName('CODIGO_PRODUCTO').AsString) Then
    Exit;

  Try
    If FCNX.Record_Exist(Info_TablaGet(Id_TBL_Explosion_Material).Name, ['CODIGO_DOCUMENTO', 'NUMERO', 'CODIGO_PRODUCTO'],
                                                                         [FQRMAESTRO.QR.FieldByName('CODIGO_DOCUMENTO_OP').AsString, IntToStr(FQRMAESTRO.QR.FieldByName('NUMERO_OP').AsInteger), FQRMAESTRO.QR.FieldByName('CODIGO_PRODUCTO').AsString]) Then
    Begin
      lEDM := 0;
      lINV := 0;
      FCNX.TMP.Active := False;
      FCNX.TMP.SQL.Clear;
      FCNX.TMP.SQL.Add(' SELECT SUM(CANTIDAD) AS RESULTADO FROM ' + Info_TablaGet(Id_TBL_Explosion_Material).Name + ' ' + FCNX.No_Lock);
      FCNX.TMP.SQL.Add(' WHERE ' + FCNX.Trim_Sentence('CODIGO_DOCUMENTO') + ' = ' + QuotedStr(Trim(FQRMAESTRO.QR.FieldByName('CODIGO_DOCUMENTO_OP').AsString)));
      FCNX.TMP.SQL.Add(' AND NUMERO = ' + IntToStr(FQRMAESTRO.QR.FieldByName('NUMERO_OP').AsInteger));
      FCNX.TMP.SQL.Add(' AND ' + FCNX.Trim_Sentence('CODIGO_PRODUCTO') + ' = ' + QuotedStr(Trim(FQRMAESTRO.QR.FieldByName('CODIGO_PRODUCTO').AsString)));
      FCNX.TMP.Active := True;
      lEDM := FCNX.TMP.FieldByName('RESULTADO').AsFloat;

      FCNX.TMP.Active := False;
      FCNX.TMP.SQL.Clear;
      FCNX.TMP.SQL.Add(' SELECT SUM(CANTIDAD) AS RESULTADO FROM ' + Info_TablaGet(Id_TBL_Movto_Inventario).Name + ' ' + FCNX.No_Lock);
      FCNX.TMP.SQL.Add(' WHERE ' + FCNX.Trim_Sentence('CODIGO_DOCUMENTO_OP') + ' = ' + QuotedStr(Trim(FQRMAESTRO.QR.FieldByName('CODIGO_DOCUMENTO_OP').AsString)));
      FCNX.TMP.SQL.Add(' AND NUMERO_OP = ' + IntToStr(FQRMAESTRO.QR.FieldByName('NUMERO_OP').AsInteger));
      FCNX.TMP.SQL.Add(' AND ' + FCNX.Trim_Sentence('CODIGO_PRODUCTO') + ' = ' + QuotedStr(Trim(FQRMAESTRO.QR.FieldByName('CODIGO_PRODUCTO').AsString)));
      FCNX.TMP.SQL.Add(' AND ' + FCNX.Trim_Sentence('CODIGO_DOCUMENTO') + ' = ' + QuotedStr(Trim(FCODIGO_DOCUMENTO)));
      FCNX.TMP.SQL.Add(' AND NUMERO <> ' + IntToStr(FQRMAESTRO.QR.FieldByName('NUMERO').AsInteger));
      FCNX.TMP.Active := True;
      lINV := FCNX.TMP.FieldByName('RESULTADO').AsFloat;

      FCNX.TMP.Active := False;
      FCNX.TMP.SQL.Clear;

      Result := lEDM >= (lINV + FQRMAESTRO.QR.FieldByName('CANTIDAD').AsFloat);
      If Not Result Then
      Begin
        UserSession.SetMessage('Explosion de Materiales: ' + FormatFloat('###,###,##0.#0', lEDM), False);
        UserSession.SetMessage('Salidas Realizadas: ' + FormatFloat('###,###,##0.#0', lINV), True);
        UserSession.SetMessage('Cantidad Solicitada: ' + FormatFloat('###,###,##0.#0', FQRMAESTRO.QR.FieldByName('CANTIDAD').AsFloat), True);
      End;
    End;
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMovto_Inventario', 'TFrIWMovto_Inventario.Cantidad_Valida', E.Message);
  End;
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
    CODIGO_AREA.BGColor := UserSession.COLOR_OK;
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

    If FQRMAESTRO.Mode_Edition And Vacio(FQRMAESTRO.QR.FieldByName('NOMBRE').AsString) Then
    Begin
      lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Nombre invalido';
      NOMBRE.BGColor := UserSession.COLOR_ERROR;
    End;

    If FQRMAESTRO.Mode_Edition And Vacio(FQRMAESTRO.QR.FieldByName('CODIGO_AREA').AsString) Then
    Begin
      lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Area invalida';
      CODIGO_AREA.BGColor := UserSession.COLOR_ERROR;
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

    If FQRMAESTRO.Mode_Edition Then
    Begin
      If (FQRMAESTRO.QR.FieldByName('CANTIDAD').AsFloat <= 0) Then
      Begin
        lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Cantidad no valida';
        CANTIDAD.BGColor := UserSession.COLOR_ERROR;
      End
      Else
      Begin
        Cantidad_Valida;
//        If Not Cantidad_Valida Then
//        Begin
////          lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Cantidad no disponible segun lo estipulado en la explosion de materiales, ' + #13 + lResult;
////          CANTIDAD.BGColor := UserSession.COLOR_ERROR;
//        End;
      End;
    End;

    FQRMAESTRO.ERROR := IfThen(Vacio(lMensaje), 0, -1);
    If FQRMAESTRO.ERROR <> 0 Then
    Begin
      FQRMAESTRO.LAST_ERROR := 'Datos invalidos, ' + lMensaje;
      UserSession.SetMessage(FQRMAESTRO.LAST_ERROR, True);
    End;
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMovto_Inventario', 'TFrIWMovto_Inventario.Validar_Campos_Master', E.Message);
  End;
End;

Procedure TFrIWMovto_Inventario.Estado_Controles;
Begin
  NUMERO.Enabled             := False;
  BTNOP.Visible              := FQRMAESTRO.Mode_Edition And Documento_Activo And
                                (
                                  (Trim(FCODIGO_DOCUMENTO) = Trim(UserSession.DOCUMENTO_SALIDA_DE_INVENTARIO)) Or
                                  (Trim(FCODIGO_DOCUMENTO) = Trim(UserSession.DOCUMENTO_DEVOLUCION_AL_INVENTARIO))
                                );
  lbInfoOP.Visible           := BTNOP.Visible;
  BTNCREARTERCERO.Visible    := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNCODIGO_TERCERO.Visible  := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNCODIGO_PRODUCTO.Visible := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNCODIGO_AREA.Visible     := FQRMAESTRO.Mode_Edition And Documento_Activo;

  NOMBRE.Enabled             := FQRMAESTRO.Mode_Edition And Documento_Activo;
  FECHA_MOVIMIENTO.Enabled   := FQRMAESTRO.Mode_Edition And Documento_Activo;
  FECHA_VENCIMIENTO.Enabled  := FQRMAESTRO.Mode_Edition And Documento_Activo;
  CANTIDAD.Enabled           := FQRMAESTRO.Mode_Edition And Documento_Activo;
  VALOR_UNITARIO.Enabled     := FQRMAESTRO.Mode_Edition And Documento_Activo;
  ID_ACTIVO.Enabled          := FQRMAESTRO.Mode_Edition And Documento_Activo;

  NOMBRE.Editable            := FQRMAESTRO.Mode_Edition And Documento_Activo;
  FECHA_MOVIMIENTO.Editable  := FQRMAESTRO.Mode_Edition And Documento_Activo;
  FECHA_VENCIMIENTO.Editable := FQRMAESTRO.Mode_Edition And Documento_Activo;
  CANTIDAD.Editable          := FQRMAESTRO.Mode_Edition And Documento_Activo;
  VALOR_UNITARIO.Editable    := FQRMAESTRO.Mode_Edition And Documento_Activo;
  ID_ACTIVO.Editable         := FQRMAESTRO.Mode_Edition And Documento_Activo;

  DESCRIPCION.Editable       := FQRMAESTRO.Mode_Edition And Documento_Activo;

  DATO.Visible   := (Not FQRMAESTRO.Mode_Edition);
  PAG_00.Visible := (Not FQRMAESTRO.Mode_Edition);
  PAG_01.Visible := True;
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
    FCNX.TMP.SQL.Add(' FROM ' + Info_TablaGet(Id_TBL_Orden_Produccion).Name + ' OP ' + FCNX.No_Lock);
    FCNX.TMP.SQL.Add(' INNER JOIN ' + Info_TablaGet(Id_TBL_Tercero).Name + ' TERC ' + FCNX.No_Lock);
    FCNX.TMP.SQL.Add(' ON TERC.CODIGO_TERCERO = OP.CODIGO_TERCERO ');
    FCNX.TMP.SQL.Add(' INNER JOIN ' + Info_TablaGet(Id_TBL_Proyecto).Name + ' PROY ' + FCNX.No_Lock);
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMovto_Inventario',  'TFrIWMovto_Inventario.Info_OP', E.Message);
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
    FCNX.TMP.SQL.Add(' FROM ' + Info_TablaGet(Id_TBL_Producto).Name + ' PROD ' + FCNX.No_Lock);
    FCNX.TMP.SQL.Add(' INNER JOIN ' + Info_TablaGet(Id_TBL_Area).Name + ' AREA ' + FCNX.No_Lock);
    FCNX.TMP.SQL.Add(' ON AREA.CODIGO_AREA = PROD.CODIGO_AREA ');
    FCNX.TMP.SQL.Add(' INNER JOIN ' + Info_TablaGet(Id_TBL_Unidad_Medida).Name + ' UNID ' + FCNX.No_Lock);
    FCNX.TMP.SQL.Add(' ON UNID.CODIGO_UNIDAD_MEDIDA = PROD.CODIGO_UNIDAD_MEDIDA ');
    FCNX.TMP.SQL.Add(' WHERE PROD.CODIGO_PRODUCTO = ' + QuotedStr(pCodigo_Producto));
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMovto_Inventario', 'TFrIWMovto_Inventario.Info_Producto', E.Message);
    End;
  End;
  Result := AnsiUpperCase(Result);
End;

procedure TFrIWMovto_Inventario.ITEMS_OPAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  Resultado_Orden_Produccion(Sender, EventParams);
end;

Procedure TFrIWMovto_Inventario.SetLabel;
Begin
  If Not FQRMAESTRO.Active Then
    Exit;
  Try
    lbInfoOP.Caption := Info_OP(FQRMAESTRO.QR.FieldByName('NUMERO_OP').AsInteger, FQRMAESTRO.QR.FieldByName('CODIGO_DOCUMENTO_OP').AsString);
    lbInfoTotal.Caption := 'TOTAL: ' + FormatFloat('###,###,###,##0.#0', FQRMAESTRO.QR.FieldByName('CANTIDAD').AsFloat * FQRMAESTRO.QR.FieldByName('VALOR_UNITARIO').AsFloat);
    lbNombre_Area.Caption := FCNX.GetValue(Info_TablaGet(Id_TBL_Area).Name, ['CODIGO_AREA'], [FQRMAESTRO.QR.FieldByName('CODIGO_AREA').AsString], ['NOMBRE']);
    lbNombre_Tercero.Caption := FCNX.GetValue(Info_TablaGet(Id_TBL_Tercero).Name, ['CODIGO_TERCERO'], [FQRMAESTRO.QR.FieldByName('CODIGO_TERCERO').AsString], ['NOMBRE']);
    lbNombre_Producto.Caption := Info_Producto(FQRMAESTRO.QR.FieldByName('CODIGO_PRODUCTO').AsString);
    lbInfoRegistro.Caption := 'Usuario: ' + FCNX.GetValue(Info_TablaGet(Id_TBL_Usuario).Name, ['CODIGO_USUARIO'], [FQRMAESTRO.QR.FieldByName('CODIGO_USUARIO').AsString], ['NOMBRE']);
    lbInfoRegistro.Caption := lbInfoRegistro.Caption + ', Fecha: ' + FQRMAESTRO.QR.FieldByName('FECHA_REGISTRO').AsString;
    lbInfoRegistro.Caption := lbInfoRegistro.Caption + ', Hora: ' + FQRMAESTRO.QR.FieldByName('HORA_REGISTRO').AsString;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMovto_Inventario', 'TFrIWMovto_Inventario.SetLabel', E.Message);
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMovto_Inventario', 'TFrIWMovto_Inventario.Documento_Activo', E.Message);
    End;
  End;
End;

procedure TFrIWMovto_Inventario.DsDataChangeMaster(pSender: TObject);
begin
  FNAVEGADOR.UpdateState;
  If (Not FQRMAESTRO.Active)Then
    Exit;

  If FQRMAESTRO.Active Then
    lbInfo.Caption :=  FINFO + ' [ ' + FCODIGO_DOCUMENTO + ', '+  FQRMAESTRO.QR.FieldByName('NUMERO').AsString + ', '+ FQRMAESTRO.QR.FieldByName('NOMBRE') .AsString + ' ] ';
  Self.Title := Info_TablaGet(Id_TBL_Movto_Inventario).Caption + ', ' + lbInfo.Caption;
  SetLabel;

  Try
    If FQRMAESTRO.Mode_Edition Then
       Cantidad_Valida;
    If (FCODIGO_ACTUAL <> FQRMAESTRO.QR.FieldByName('NUMERO').AsString) And (Not FQRMAESTRO.Mode_Edition) Then
    Begin
      FCODIGO_ACTUAL := FQRMAESTRO.QR.FieldByName('NUMERO').AsString;
    End;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMovto_Inventario', 'TFrIWMovto_Inventario.DsDataChangeMaster', E.Message);
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

Procedure TFrIWMovto_Inventario.Info_Calculated(pDataset : TDataSet);
Begin
  Try
    If FQRMAESTRO.QR.FindField('CALC_OP') <> Nil Then
      FQRMAESTRO.QR.FieldByName('CALC_OP').AsString := FCNX.GetValue(Info_TablaGet(Id_TBL_Orden_Produccion).Name, ['CODIGO_DOCUMENTO', 'NUMERO'], [FQRMAESTRO.QR.FieldByName('CODIGO_DOCUMENTO_OP').AsString, FQRMAESTRO.QR.FieldByName('NUMERO_OP').AsString], ['DOCUMENTO_REFERENCIA']);

    If FQRMAESTRO.QR.FindField('CALC_NOMBRE_PRODUCTO') <> Nil Then
      FQRMAESTRO.QR.FieldByName('CALC_NOMBRE_PRODUCTO').AsString := FCNX.GetValue(Info_TablaGet(Id_TBL_Producto).Name, ['CODIGO_PRODUCTO'], [FQRMAESTRO.QR.FieldByName('CODIGO_PRODUCTO').AsString], ['NOMBRE']);

  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMovto_Inventario', 'TFrIWMovto_Inventario.Info_Calculated', E.Message);
    End;
  End;
End;

Function TFrIWMovto_Inventario.AbrirMaestro(Const pDato: String = ''): Boolean;
Begin
  FGRID_MAESTRO.Caption := Info_TablaGet(Id_TBL_Movto_Inventario).Caption;
  Result := False;
  Try
    FQRMAESTRO.Active := False;
    FQRMAESTRO.WHERE    := '';
    FQRMAESTRO.SENTENCE := ' SELECT ' + FCNX.Top_Sentence(Const_Max_Record) + ' * FROM ' + Info_TablaGet(Id_TBL_Movto_Inventario).Name + FCNX.No_Lock;
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
    FQRMAESTRO.ORDER := ' ORDER BY FECHA_REGISTRO DESC, HORA_REGISTRO DESC ';
    FQRMAESTRO.SetFields;
    FQRMAESTRO.SetCalcField('CALC_OP', 20, TFieldType.ftString);
    FQRMAESTRO.SetCalcField('CALC_NOMBRE_PRODUCTO', 50, TFieldType.ftString);
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMovto_Inventario', 'TFrIWMovto_Inventario.AbrirMaestro', E.Message);
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMovto_Inventario', 'TFrIWMovto_Inventario.Create', E.Message);
    End;
  End;
end;

Procedure TFrIWMovto_Inventario.Cargar_Productos;
Begin
  Try
    FCNX.TMP.Active := False;
    FCNX.TMP.SQL.Clear;
    FCNX.TMP.SQL.Add(' SELECT * FROM ' + Info_TablaGet(Id_TBL_Producto).Name + FCNX.No_Lock);
//  FCNX.TMP.SQL.Add(' WHERE (ID_SERVICIO IS NULL) OR (ID_SERVICIO = ' + QuotedStr('N') + ') ');
    FCNX.TMP.SQL.Add(' ORDER BY NOMBRE ');
    FCNX.TMP.Active := True;
    FCNX.TMP.First;
    While Not FCNX.TMP.Eof Do
    Begin
      FBusqueda_Producto.Add_Item(['CODIGO_PRODUCTO'], [FCNX.TMP.FieldByName('CODIGO_PRODUCTO').AsString], FCNX.TMP.FieldByName('CODIGO_PRODUCTO').AsString + ' - ' + FCNX.TMP.FieldByName('NOMBRE').AsString);
      FCNX.TMP.Next;
    End;

    FCNX.TMP.Active := False;
    FCNX.TMP.SQL.Clear;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMovto_Inventario', 'TFrIWMovto_Inventario.Cargar_Productos', E.Message);
    End;
  End;
End;

Procedure TFrIWMovto_Inventario.Cargar_Terceros;
Begin
  Try
    FCNX.TMP.Active := False;
    FCNX.TMP.SQL.Clear;
    FCNX.TMP.SQL.Add(' SELECT * FROM ' + Info_TablaGet(Id_TBL_Tercero).Name + FCNX.No_Lock);
    FCNX.TMP.SQL.Add(' ORDER BY NOMBRE ');
    FCNX.TMP.Active := True;
    FCNX.TMP.First;
    While Not FCNX.TMP.Eof Do
    Begin
      FBusqueda_Tercero.Add_Item(['CODIGO_TERCERO'], [FCNX.TMP.FieldByName('CODIGO_TERCERO').AsString], FCNX.TMP.FieldByName('CODIGO_TERCERO').AsString + ' - ' + FCNX.TMP.FieldByName('NOMBRE').AsString);
      FCNX.TMP.Next;
    End;

    FCNX.TMP.Active := False;
    FCNX.TMP.SQL.Clear;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMovto_Inventario', 'TFrIWMovto_Inventario.Cargar_Terceros', E.Message);
    End;
  End;
End;

Procedure TFrIWMovto_Inventario.Cargar_Areas;
Begin
  Try
    FCNX.TMP.Active := False;
    FCNX.TMP.SQL.Clear;
    FCNX.TMP.SQL.Add(' SELECT * FROM ' + Info_TablaGet(Id_TBL_Area).Name + FCNX.No_Lock);
    FCNX.TMP.SQL.Add(' ORDER BY NOMBRE ');
    FCNX.TMP.Active := True;
    FCNX.TMP.First;
    While Not FCNX.TMP.Eof Do
    Begin
      FBusqueda_Area.Add_Item(['CODIGO_AREA'], [FCNX.TMP.FieldByName('CODIGO_AREA').AsString], FCNX.TMP.FieldByName('CODIGO_AREA').AsString + ' - ' + FCNX.TMP.FieldByName('NOMBRE').AsString);
      FCNX.TMP.Next;
    End;

    FCNX.TMP.Active := False;
    FCNX.TMP.SQL.Clear;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMovto_Inventario', 'TFrIWMovto_Inventario.Cargar_Areas', E.Message);
    End;
  End;
End;

Procedure TFrIWMovto_Inventario.Cargar_OP;
Begin
  Try
    FCNX.TMP.Active := False;
    FCNX.TMP.SQL.Clear;
    FCNX.TMP.SQL.Add(' SELECT * FROM ' + Info_TablaGet(Id_TBL_Orden_Produccion).Name + FCNX.No_Lock);
    FCNX.TMP.SQL.Add(' ORDER BY NOMBRE ');
    FCNX.TMP.Active := True;
    FCNX.TMP.First;
    While Not FCNX.TMP.Eof Do
    Begin
      FBusqueda_OP.Add_Item(['CODIGO_DOCUMENTO', 'NUMERO', 'DOCUMENTO_REFERENCIA'],
                            [FCNX.TMP.FieldByName('CODIGO_DOCUMENTO').AsString, FCNX.TMP.FieldByName('NUMERO').AsString, FCNX.TMP.FieldByName('DOCUMENTO_REFERENCIA').AsString],
                            FCNX.TMP.FieldByName('DOCUMENTO_REFERENCIA').AsString + ' - ' + FCNX.TMP.FieldByName('NUMERO').AsString + ' - ' + FCNX.TMP.FieldByName('NOMBRE').AsString);
      FCNX.TMP.Next;
    End;

    FCNX.TMP.Active := False;
    FCNX.TMP.SQL.Clear;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMovto_Inventario', 'TFrIWMovto_Inventario.Cargar_OP', E.Message);
    End;
  End;
End;

procedure TFrIWMovto_Inventario.IWAppFormCreate(Sender: TObject);
begin
  Randomize;
  Self.Name := 'TFrIWMovto_Inventario' + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now) + IntToStr(Random(1000));
  FCNX := UserSession.CNX;

  FBusqueda_OP  := TSelect_ASE.Create(Self, Resultado_Orden_Produccion, 'Busqueda de orden de producción');
  FBusqueda_Area  := TSelect_ASE.Create(Self, Resultado_Area, 'Busqueda de area');
  FBusqueda_Tercero  := TSelect_ASE.Create(Self, Resultado_Tercero, 'Busqueda de tercero');
  FBusqueda_Producto := TSelect_ASE.Create(Self, Resultado_Producto, 'Busqueda de producto');

  FBusqueda_OP.Parent := Self;
  FBusqueda_Area.Parent := Self;
  FBusqueda_Tercero.Parent := Self;
  FBusqueda_Producto.Parent := Self;

  Cargar_Productos;
  Cargar_Terceros;
  Cargar_Areas;
  Cargar_OP;
  Self.Title := Info_TablaGet(Id_TBL_Movto_Inventario).Caption + ', ' + lbInfo.Caption;
  FCODIGO_ACTUAL := '';
  FINFO := UserSession.FULL_INFO + ', ' +  Info_TablaGet(Id_TBL_Movto_Inventario).Caption;
  Try
    FGRID_MAESTRO        := TGRID_JQ.Create(PAG_00);
    FGRID_MAESTRO.Parent := PAG_00;
    FGRID_MAESTRO.Top    := 0010;
    FGRID_MAESTRO.Left   := 0010;
    FGRID_MAESTRO.Width  := 1000;
    FGRID_MAESTRO.Height := 0500;

    FQRMAESTRO := UserSession.Create_Manager_Data(Info_TablaGet(Id_TBL_Movto_Inventario).Name, Info_TablaGet(Id_TBL_Movto_Inventario).Caption);

    FQRMAESTRO.ON_NEW_RECORD   := NewRecordMaster;
    FQRMAESTRO.ON_AFTER_POST   := AfterPostMaster;
    FQRMAESTRO.ON_DATA_CHANGE  := DsDataChangeMaster;
    FQRMAESTRO.ON_STATE_CHANGE := DsStateMaster;
    FQRMAESTRO.ON_BEFORE_POST  := Validar_Campos_Master;
    FQRMAESTRO.QR.OnCalcFields := Info_Calculated;

    NUMERO.DataSource              := FQRMAESTRO.DS;
    CODIGO_DOCUMENTO_OP.DataSource := FQRMAESTRO.DS;
    NUMERO_OP.DataSource           := FQRMAESTRO.DS;
    NOMBRE.DataSource              := FQRMAESTRO.DS;
    CODIGO_TERCERO.DataSource      := FQRMAESTRO.DS;
    CODIGO_PRODUCTO.DataSource     := FQRMAESTRO.DS;
    CODIGO_AREA.DataSource         := FQRMAESTRO.DS;
    DESCRIPCION.DataSource         := FQRMAESTRO.DS;
    FECHA_MOVIMIENTO.DataSource    := FQRMAESTRO.DS;
    FECHA_VENCIMIENTO.DataSource   := FQRMAESTRO.DS;
    CANTIDAD.DataSource            := FQRMAESTRO.DS;
    VALOR_UNITARIO.DataSource      := FQRMAESTRO.DS;
    ID_ACTIVO.DataSource           := FQRMAESTRO.DS;

    FGRID_MAESTRO.SetGrid(FQRMAESTRO.DS, ['NUMERO'        , 'NOMBRE'        , 'CALC_NOMBRE_PRODUCTO', 'CALC_OP'       , 'FECHA_REGISTRO', 'HORA_REGISTRO' , 'FECHA_MOVIMIENTO'],
                                         ['numero'        , 'Nombre'        , 'Producto'            , 'O.P.'          , 'F. Registro'   , 'H. Registro'   , 'Movimiento'      ],
                                         ['S'             , 'N'             , 'N'                   , 'N'             , 'N'             , 'N'             , 'N'               ],
                                         ['N'             , 'N'             , 'N'                   , 'N'             , 'N'             , 'N'             , 'N'               ],
                                         [070             , 200             , 350                   , 050             , 090             , 090             , 090               ],
                                         [taRightJustify  , taLeftJustify   , taLeftJustify         , taRightJustify  , taRightJustify  , taRightJustify  , taRightJustify    ],
                                         [TEditType.etNone, TEditType.etNone, TEditType.etNone      , TEditType.etNone, TEditType.etNone, TEditType.etNone, TEditType.etNone  ],
                                         [TDataType.dtInt , TDataType.dtText, TDataType.dtText      , TDataType.dtText, TDataType.dtText, TDataType.dtText, TDataType.dtText  ]);
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMovto_Inventario', 'TFrIWMovto_Inventario.IWAppFormCreate', E.Message);
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

    If Assigned(FBusqueda_Producto) Then
      FreeAndNil(FBusqueda_Producto);

    If Assigned(FBusqueda_Tercero) Then
      FreeAndNil(FBusqueda_Tercero);

    If Assigned(FBusqueda_Area) Then
      FreeAndNil(FBusqueda_Area);

    If Assigned(FBusqueda_OP) Then
      FreeAndNil(FBusqueda_OP);

    If Assigned(FGRID_MAESTRO) Then
      FreeAndNil(FGRID_MAESTRO);

    If Assigned(FNAVEGADOR) Then
      FreeAndNil(FNAVEGADOR);

  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMovto_Inventario', 'TFrIWMovto_Inventario.IWAppFormDestroy', E.Message);
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMovto_Inventario', 'TFrIWMovto_Inventario.NewRecordMaster', E.Message);
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMovto_Inventario', 'TFrIWMovto_Inventario.AfterPostMaster', E.Message);
    End;
  End;
end;

procedure TFrIWMovto_Inventario.BtnAcarreoAsyncClick(Sender: TObject;  EventParams: TStringList);
begin
  FQRMAESTRO.SetAcarreo(Not FQRMAESTRO.ACARREO, ['CODIGO_DOCUMENTO', 'NUMERO'], [FQRMAESTRO.QR.FieldByName('CODIGO_DOCUMENTO').AsString, FQRMAESTRO.QR.FieldByName('NUMERO').AsString]);
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMovto_Inventario', 'TFrIWMovto_Inventario.Localizar_Registro', E.Message);
  End;
End;

procedure TFrIWMovto_Inventario.BTNBUSCARAsyncClick(Sender: TObject;  EventParams: TStringList);
begin
  Try
    AbrirMaestro(DATO.Text);
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWMovto_Inventario', 'TFrIWMovto_Inventario.BTNBUSCARAsyncClick', E.Message);
  End;
end;

procedure TFrIWMovto_Inventario.BTNOPAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  FBusqueda_OP.Buscar_Info;
end;

procedure TFrIWMovto_Inventario.BTNCODIGO_AREAAsyncClick(Sender: TObject;EventParams: TStringList);
begin
  FBusqueda_Area.Buscar_Info;
end;

procedure TFrIWMovto_Inventario.BTNCODIGO_PRODUCTOAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  FBusqueda_Producto.Buscar_Info;
//  Buscar_Info(Id_TBL_Producto, Resultado_Producto);
end;

procedure TFrIWMovto_Inventario.BTNCODIGO_TERCEROAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  FBusqueda_Tercero.Buscar_Info;
end;

procedure TFrIWMovto_Inventario.BTNCREARPRODUCTOAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Mostrar_BasicData(Id_TBL_Producto, 'Ingreso del Producto', 'Codigo', 'CODIGO_PRODUCTO', 'Nombre' , 'NOMBRE', 'CODIGO_PRODUCTO', Resultado_BasicData);
end;

procedure TFrIWMovto_Inventario.BTNCREARTERCEROAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Mostrar_BasicData(Id_TBL_Tercero, 'Ingreso del Tercero', 'Identificación', 'CODIGO_TERCERO', 'Nombre' , 'NOMBRE', 'CODIGO_TERCERO', Resultado_BasicData);
end;

procedure TFrIWMovto_Inventario.BtnGridAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  UserSession.ShowForm_Perfil_Enc(FQRMAESTRO.QR.FieldByName('CODIGO_PERFIL').AsString);
end;

end.
