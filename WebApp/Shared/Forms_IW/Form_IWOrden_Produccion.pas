unit Form_IWOrden_Produccion;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes,
  Vcl.Imaging.pngimage, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompExtCtrls, Vcl.Controls, Vcl.Forms, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWCompLabel,
  IWCompTabControl, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  UtConexion, Data.DB, IWCompGrids, IWDBStdCtrls, IWCompEdit,
  IWCompCheckbox, IWCompMemo, IWDBExtCtrls, IWCompButton, IWCompListbox,
  UtGrid_JQ, UtNavegador_ASE, UtilsIW.Busqueda;

type
  TFrIWOrden_Produccion = class(TIWAppForm)
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
    IWLabel7: TIWLabel;
    IWModalWindow1: TIWModalWindow;
    NUMERO: TIWDBLabel;
    BTNNOMBRE: TIWImage;
    NOMBRE: TIWDBLabel;
    lbNombre_Activo: TIWLabel;
    BTNACTIVO: TIWImage;
    BTNCODIGO_PROYECTO: TIWImage;
    CODIGO_PROYECTO: TIWDBLabel;
    lbNombre_Proyecto: TIWLabel;
    IWRegion_Navegador: TIWRegion;
    IWLabel5: TIWLabel;
    BTNCODIGO_TERCERO: TIWImage;
    CODIGO_TERCERO: TIWDBLabel;
    lbNombre_Tercero: TIWLabel;
    lbInfoRegistro: TIWLabel;
    DESCRIPCION: TIWDBMemo;
    BTNDESCRIPCION: TIWImage;
    IWLabel9: TIWLabel;
    BTNCREARPROYECTO: TIWImage;
    BTNCREARTERCERO: TIWImage;
    IWLabel3: TIWLabel;
    BTNFECHA_INICIAL: TIWImage;
    FECHA_INICIAL: TIWDBLabel;
    BTNFECHA_FINAL: TIWImage;
    IWLabel2: TIWLabel;
    FECHA_FINAL: TIWDBLabel;
    BTNREFERENCIA: TIWImage;
    IWLabel4: TIWLabel;
    DOCUMENTO_REFERENCIA: TIWDBLabel;
    CANTIDAD: TIWDBLabel;
    BTNCANTIDAD: TIWImage;
    IWLabel11: TIWLabel;
    procedure BTNBACKAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure BTNBUSCARAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BtnAcarreoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNNOMBREAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNACTIVOAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCODIGO_PROYECTOAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCODIGO_TERCEROAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCODIGO_PRODUCTOAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNDESCRIPCIONAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCANTIDADAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCREARPROYECTOAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCREARTERCEROAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCREARPRODUCTOAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNREFERENCIAAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNFECHA_INICIALAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNFECHA_FINALAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    FCNX : TConexion;
    FINFO : String;
    FCODIGO_DOCUMENTO : String;

    FQRMAESTRO : TMANAGER_DATA;

    FNAVEGADOR : TNavegador_ASE;
    FGRID_MAESTRO : TGRID_JQ;

    FCODIGO_ACTUAL : String;

    Procedure Localizar_Registro(Sender: TObject; EventParams: TStringList);
    Procedure Resultado_Perfil(Sender: TObject; EventParams: TStringList);
    procedure Buscar_Info(pSD : Integer; pEvent : TIWAsyncEvent);

    Procedure Resultado_Proyecto(Sender: TObject; EventParams: TStringList);
    Procedure Resultado_Producto(Sender: TObject; EventParams: TStringList);
    Procedure Resultado_Tercero(Sender: TObject; EventParams: TStringList);

    procedure Resultado_Nombre(EventParams: TStringList);
    procedure Resultado_Referencia(EventParams: TStringList);
    procedure Resultado_Descripcion(EventParams: TStringList);
    procedure Resultado_Fecha_Inicial(EventParams: TStringList);
    procedure Resultado_Fecha_Final(EventParams: TStringList);
    procedure Resultado_Fecha_Vencimiento(EventParams: TStringList);
    procedure Resultado_Cantidad(EventParams: TStringList);
    procedure Resultado_Activo(EventParams: TStringList);

    Procedure Release_Me;

    Function Existe_Orden_Produccion(Const pNumero : String): Boolean;

    Procedure Validar_Campos_Master(pSender: TObject);
    Function Documento_Activo: Boolean;

    Procedure NewRecordMaster(pSender: TObject);
    Procedure AfterPostMaster(pSender : TObject);
    Procedure DsDataChangeMaster(pSender: TObject);
    Procedure DsStateMaster(Sender: TObject);

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
  TBL000.Info_Tabla,
  UtIWBasicData_ASE,
  UtilsIW.Numero_Siguiente;

procedure TFrIWOrden_Produccion.Resultado_BasicData(Sender: TObject; EventParams: TStringList);
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
      UtLog_Execute('TFrIWOrden_Produccion.Resultado_BasicData, ' + e.Message);
  End;
End;

procedure TFrIWOrden_Produccion.Mostrar_BasicData(Const pId : Integer; Const pTitle, pCaptionCode, pFieldCode, pCaptionName, pFieldName, pFieldDestiny : String; pResult : TIWAsyncEvent);
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
      UtLog_Execute('TFrIWOrden_Produccion.Mostrar_BasicData, ' + e.Message);
  End;
End;

Procedure TFrIWOrden_Produccion.Resultado_Proyecto(Sender: TObject; EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      FQRMAESTRO.QR.FieldByName('CODIGO_PROYECTO').AsString := EventParams.Values ['CODIGO_PROYECTO' ];
    End;
  Except
   On E: Exception Do
     UtLog_Execute('TFrIWOrden_Produccion.Resultado_Proyecto, ' + e.Message);
  End;
End;

Procedure TFrIWOrden_Produccion.Resultado_Producto(Sender: TObject; EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      FQRMAESTRO.QR.FieldByName('CODIGO_PRODUCTO').AsString := EventParams.Values ['CODIGO_PRODUCTO' ];
    End;
  Except
   On E: Exception Do
     UtLog_Execute('TFrIWOrden_Produccion.Resultado_Producto, ' + e.Message);
  End;
End;

Procedure TFrIWOrden_Produccion.Resultado_Tercero(Sender: TObject; EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      FQRMAESTRO.QR.FieldByName('CODIGO_TERCERO').AsString := EventParams.Values ['CODIGO_TERCERO'];
    End;
  Except
   On E: Exception Do
     UtLog_Execute('TFrIWOrden_Produccion.Resultado_Tercero, ' + e.Message);
  End;
End;

Procedure TFrIWOrden_Produccion.Resultado_Perfil(Sender: TObject; EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      FQRMAESTRO.QR.FieldByName('CODIGO_PERFIL').AsString := EventParams.Values ['CODIGO_PERFIL' ];
    End;
  Except
   On E: Exception Do
     UtLog_Execute('TFrIWOrden_Produccion.Resultado_Perfil, ' + e.Message);
  End;
End;

procedure TFrIWOrden_Produccion.Buscar_Info(pSD : Integer; pEvent : TIWAsyncEvent);
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
      UtLog_Execute('TFrIWOrden_Produccion.Buscar_Info, ' + e.Message);
  End;
End;

procedure TFrIWOrden_Produccion.Resultado_Nombre(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
    Begin
      FQRMAESTRO.QR.FieldByName('NOMBRE').AsString := AnsiUpperCase(Trim(EventParams.Values['InputStr']));
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWOrden_Produccion.Resultado_Nombre, ' + e.Message);
  End;
End;

procedure TFrIWOrden_Produccion.Resultado_Referencia(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
    Begin
      FQRMAESTRO.QR.FieldByName('DOCUMENTO_REFERENCIA').AsString := AnsiUpperCase(Trim(EventParams.Values['InputStr']));
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWOrden_Produccion.Resultado_Referencia, ' + e.Message);
  End;
End;

procedure TFrIWOrden_Produccion.Resultado_Descripcion(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
    Begin
      FQRMAESTRO.QR.FieldByName('DESCRIPCION').AsString := AnsiUpperCase(Trim(EventParams.Values['InputStr']));
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWOrden_Produccion.Resultado_Descripcion, ' + e.Message);
  End;
End;

procedure TFrIWOrden_Produccion.Resultado_Fecha_Inicial(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
    Begin
      FQRMAESTRO.QR.FieldByName('FECHA_INICIAL').AsString := AnsiUpperCase(Trim(EventParams.Values['InputStr']));
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWOrden_Produccion.Resultado_Fecha_Inicial, ' + e.Message);
  End;
End;

procedure TFrIWOrden_Produccion.Resultado_Fecha_Final(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
    Begin
      FQRMAESTRO.QR.FieldByName('FECHA_FINAL').AsString := AnsiUpperCase(Trim(EventParams.Values['InputStr']));
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWOrden_Produccion.Resultado_Fecha_Final, ' + e.Message);
  End;
End;

procedure TFrIWOrden_Produccion.Resultado_Fecha_Vencimiento(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
    Begin
      FQRMAESTRO.QR.FieldByName('FECHA_VENCIMIENTO').AsString := AnsiUpperCase(Trim(EventParams.Values['InputStr']));
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWOrden_Produccion.Resultado_Fecha_Vencimiento, ' + e.Message);
  End;
End;

procedure TFrIWOrden_Produccion.Resultado_Cantidad(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
    Begin
      FQRMAESTRO.QR.FieldByName('CANTIDAD').AsFloat := SetToFloat(EventParams.Values['InputStr']);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWOrden_Produccion.Resultado_Cantidad, ' + e.Message);
  End;
End;

procedure TFrIWOrden_Produccion.Resultado_Activo(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition Then
      FQRMAESTRO.QR.FieldByName('ID_ACTIVO').AsString := IfThen(Result_Is_OK(EventParams.Values['RetValue']), 'S', 'N');
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWOrden_Produccion.Resultado_Activo, ' + e.Message);
  End;
End;

Procedure TFrIWOrden_Produccion.Release_Me;
Begin
  Self.Release;
End;

Function TFrIWOrden_Produccion.Existe_Orden_Produccion(Const pNumero : String) : Boolean;
Begin
  Result := FCNX.Record_Exist(gInfo_Tablas[Id_TBL_Orden_Produccion].Name, ['CODIGO_DOCUMENTO', 'NUMERO'], [FCODIGO_DOCUMENTO, pNumero]);
End;

Procedure TFrIWOrden_Produccion.Validar_Campos_Master(pSender: TObject);
Var
  lMensaje: String;
Begin
  FQRMAESTRO.ERROR := 0;
  Try
    lMensaje := '';
    NUMERO.BGColor := UserSession.COLOR_OK;
    NOMBRE.BGColor := UserSession.COLOR_OK;
    CODIGO_PROYECTO.BGColor := UserSession.COLOR_OK;
    CODIGO_TERCERO.BGColor := UserSession.COLOR_OK;

    If FQRMAESTRO.DS.State In [dsInsert] Then
    Begin
      If FQRMAESTRO.QR.FieldByName('NUMERO').AsInteger <= 0 Then
      Begin
        lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Orden_Produccion invalido';
        NUMERO.BGColor := UserSession.COLOR_ERROR;
      End
      Else
      Begin
        If Existe_Orden_Produccion(IntToStr(FQRMAESTRO.QR.FieldByName('NUMERO').AsInteger)) Then
          FQRMAESTRO.QR.FieldByName('NUMERO').AsInteger := UtilsIW_Numero_Siguiente_Get(FCNX, FCODIGO_DOCUMENTO);
        If Existe_Orden_Produccion(IntToStr(FQRMAESTRO.QR.FieldByName('NUMERO').AsInteger)) Or (FQRMAESTRO.QR.FieldByName('NUMERO').AsInteger <= 0) Then
        Begin
          lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Orden_Produccion ya existente';
          NUMERO.BGColor := UserSession.COLOR_ERROR;
        End;
      End;
    End;

    If BTNNOMBRE.Visible And Vacio(FQRMAESTRO.QR.FieldByName('NOMBRE').AsString) Then
    Begin
      lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Nombre invalido';
      NOMBRE.BGColor := UserSession.COLOR_ERROR;
    End;

    If FQRMAESTRO.Mode_Edition And Vacio(FQRMAESTRO.QR.FieldByName('CODIGO_PROYECTO').AsString) Then
    Begin
      lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Proyecto invalido';
      CODIGO_PROYECTO.BGColor := UserSession.COLOR_ERROR;
    End;

    If FQRMAESTRO.Mode_Edition And Vacio(FQRMAESTRO.QR.FieldByName('CODIGO_TERCERO').AsString) Then
    Begin
      lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Tercero invalido';
      CODIGO_TERCERO.BGColor := UserSession.COLOR_ERROR;
    End;

    FQRMAESTRO.ERROR := IfThen(Vacio(lMensaje), 0, -1);
    If FQRMAESTRO.ERROR <> 0 Then
    Begin
      FQRMAESTRO.LAST_ERROR := 'Datos invalidos, ' + lMensaje;
      UserSession.SetMessage(FQRMAESTRO.LAST_ERROR, True);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWOrden_Produccion.Validar_Campos_Master, ' + E.Message);
  End;
End;

Procedure TFrIWOrden_Produccion.Estado_Controles;
Begin
  NUMERO.Enabled               := False;
  BTNCODIGO_PROYECTO.Visible   := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNCODIGO_TERCERO.Visible    := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNNOMBRE.Visible            := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNREFERENCIA.Visible        := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNDESCRIPCION.Visible       := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNFECHA_INICIAL.Visible     := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNFECHA_FINAL.Visible       := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNCANTIDAD.Visible          := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNACTIVO.Visible            := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNCREARTERCERO.Visible      := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNCREARPROYECTO.Visible     := FQRMAESTRO.Mode_Edition And Documento_Activo;
  DATO.Visible                 := (Not FQRMAESTRO.Mode_Edition);
  PAG_00.Visible               := (Not FQRMAESTRO.Mode_Edition);
  PAG_01.Visible               := True;
End;

Procedure TFrIWOrden_Produccion.SetLabel;
Begin
  If Not FQRMAESTRO.Active Then
    Exit;
  Try
    lbNombre_Activo.Caption := IfThen(FQRMAESTRO.QR.FieldByName('ID_ACTIVO').AsString = 'S', 'Esta activo', 'No esta activo');
    lbNombre_Tercero.Caption := FCNX.GetValue(gInfo_Tablas[Id_TBL_Tercero].Name, ['CODIGO_TERCERO'], [FQRMAESTRO.QR.FieldByName('CODIGO_TERCERO').AsString], ['NOMBRE']);
    lbNombre_Proyecto.Caption := FCNX.GetValue(gInfo_Tablas[Id_TBL_Proyecto].Name, ['CODIGO_PROYECTO'], [FQRMAESTRO.QR.FieldByName('CODIGO_PROYECTO').AsString], ['NOMBRE']);
    lbInfoRegistro.Caption := 'Usuario: ' + FCNX.GetValue(gInfo_Tablas[Id_TBL_Usuario].Name, ['CODIGO_USUARIO'], [FQRMAESTRO.QR.FieldByName('CODIGO_USUARIO').AsString], ['NOMBRE']);
    lbInfoRegistro.Caption := lbInfoRegistro.Caption + ', Fecha: ' + FQRMAESTRO.QR.FieldByName('FECHA_REGISTRO').AsString;
    lbInfoRegistro.Caption := lbInfoRegistro.Caption + ', Hora: ' + FQRMAESTRO.QR.FieldByName('HORA_REGISTRO').AsString;
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWOrden_Produccion.SetLabel, ' + E.Message);
    End;
  End;
End;

Function TFrIWOrden_Produccion.Documento_Activo: Boolean;
Begin
  Try
    Result := True;
    // Result := (FQRMAESTRO.RecordCount >= 1) {And (Trim(FQRMAESTRO.FieldByName('ID_ANULADO').AsString) <> 'S')};
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWOrden_Produccion.Documento_Activo, ' + E.Message);
    End;
  End;
End;

procedure TFrIWOrden_Produccion.DsDataChangeMaster(pSender: TObject);
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
      UtLog_Execute('TFrIWOrden_Produccion.DsDataChangeMaster, ' + E.Message);
    End;
  End;
end;

Procedure TFrIWOrden_Produccion.DsStateMaster(Sender: TObject);
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

Function TFrIWOrden_Produccion.AbrirMaestro(Const pDato: String = ''): Boolean;
Begin
  FGRID_MAESTRO.Caption := gInfo_Tablas[Id_TBL_Orden_Produccion].Caption;
  Result := False;
  Try
    FQRMAESTRO.Active := False;
    FQRMAESTRO.WHERE    := '';
    FQRMAESTRO.SENTENCE := ' SELECT * FROM ' + gInfo_Tablas[Id_TBL_Orden_Produccion].Name + FCNX.No_Lock;
    FQRMAESTRO.WHERE := ' WHERE ' + FCNX.Trim_Sentence('CODIGO_DOCUMENTO') + ' = ' + QuotedStr(Trim(FCODIGO_DOCUMENTO)) + #13;
    FQRMAESTRO.WHERE := FQRMAESTRO.WHERE + ' AND NUMERO > 0';
    If Trim(pDato) <> '' Then
    Begin
      FQRMAESTRO.WHERE := FQRMAESTRO.WHERE + ' AND ' + #13;
      FQRMAESTRO.WHERE := FQRMAESTRO.WHERE + ' ( ' + #13;
      FQRMAESTRO.WHERE := FQRMAESTRO.WHERE + '    NOMBRE LIKE '          + QuotedStr('%' + Trim(pDato) + '%') + #13;
      FQRMAESTRO.WHERE := FQRMAESTRO.WHERE + ' OR CODIGO_TERCERO LIKE '  + QuotedStr('%' + Trim(pDato) + '%') + #13;
      FQRMAESTRO.WHERE := FQRMAESTRO.WHERE + ' OR CODIGO_PRODUCTO LIKE ' + QuotedStr('%' + Trim(pDato) + '%') + #13;
      FQRMAESTRO.WHERE := FQRMAESTRO.WHERE + ' OR CODIGO_USUARIO LIKE '  + QuotedStr('%' + Trim(pDato) + '%') + #13;
      FQRMAESTRO.WHERE := FQRMAESTRO.WHERE + ' OR FECHA_REGISTRO LIKE '  + QuotedStr('%' + Trim(pDato) + '%') + #13;
      FQRMAESTRO.WHERE := FQRMAESTRO.WHERE + ' OR HORA_REGISTRO LIKE '   + QuotedStr('%' + Trim(pDato) + '%') + #13;
      FQRMAESTRO.WHERE := FQRMAESTRO.WHERE + ' OR CODIGO_PROYECTO LIKE '     + QuotedStr('%' + Trim(pDato) + '%') + #13;
      FQRMAESTRO.WHERE := FQRMAESTRO.WHERE + ' ) ';
    End;
    FQRMAESTRO.ORDER := ' ORDER BY NUMERO DESC ';
    FQRMAESTRO.Active := True;
    Result := FQRMAESTRO.Active;
    If Result Then
    Begin
    End;
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWOrden_Produccion.AbrirMaestro, ' + E.Message);
    End;
  End;
  FGRID_MAESTRO.RefreshData;
End;

constructor TFrIWOrden_Produccion.Create(AOwner: TComponent; Const pCodigo_Documento : String);
begin
  Inherited Create(AOwner);
  Try
    Self.FCODIGO_DOCUMENTO := pCodigo_Documento ;
    If AbrirMaestro Then
    Begin
    End
    Else
      Release_Me
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWOrden_Produccion.IWAppFormCreate, ' + E.Message);
    End;
  End;
end;

procedure TFrIWOrden_Produccion.IWAppFormCreate(Sender: TObject);
begin
  Randomize;
  Self.Name := 'USUARIO' + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now) + IntToStr(Random(1000));
  FCNX := UserSession.CNX;
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Nombre'           , Resultado_Nombre           );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Referencia'       , Resultado_Referencia       );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Descripcion'      , Resultado_Descripcion      );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Fecha_Inicial'    , Resultado_Fecha_Inicial    );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Fecha_Final'      , Resultado_Fecha_Final      );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Fecha_Vencimiento', Resultado_Fecha_Vencimiento);
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Cantidad'         , Resultado_Cantidad         );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Activo'           , Resultado_Activo           );
  FCODIGO_ACTUAL := '';
  FINFO := UserSession.FULL_INFO + gInfo_Tablas[Id_TBL_Orden_Produccion].Caption;
  Try
    FGRID_MAESTRO        := TGRID_JQ.Create(PAG_00);
    FGRID_MAESTRO.Parent := PAG_00;
    FGRID_MAESTRO.Top    := 010;
    FGRID_MAESTRO.Left   := 010;
    FGRID_MAESTRO.Width  := 700;
    FGRID_MAESTRO.Height := 500;

    FQRMAESTRO := UserSession.Create_Manager_Data(gInfo_Tablas[Id_TBL_Orden_Produccion].Name, gInfo_Tablas[Id_TBL_Orden_Produccion].Caption);

    FQRMAESTRO.ON_NEW_RECORD   := NewRecordMaster;
    FQRMAESTRO.ON_AFTER_POST   := AfterPostMaster;
    FQRMAESTRO.ON_DATA_CHANGE  := DsDataChangeMaster;
    FQRMAESTRO.ON_STATE_CHANGE := DsStateMaster;
    FQRMAESTRO.ON_BEFORE_POST  := Validar_Campos_Master;

    NUMERO.DataSource               := FQRMAESTRO.DS;
    NOMBRE.DataSource               := FQRMAESTRO.DS;
    CODIGO_PROYECTO.DataSource      := FQRMAESTRO.DS;
    CODIGO_TERCERO.DataSource       := FQRMAESTRO.DS;
    DOCUMENTO_REFERENCIA.DataSource := FQRMAESTRO.DS;
    DESCRIPCION.DataSource          := FQRMAESTRO.DS;
    FECHA_INICIAL.DataSource        := FQRMAESTRO.DS;
    FECHA_FINAL.DataSource          := FQRMAESTRO.DS;
    CANTIDAD.DataSource             := FQRMAESTRO.DS;
    FGRID_MAESTRO.SetGrid(FQRMAESTRO.DS, ['NUMERO'      , 'NOMBRE'     , 'FECHA_INICIAL', 'FECHA_FINAL'  ],
                                         ['numero'      , 'Nombre'     , 'Inicio'       , 'Final'        ],
                                         ['S'           , 'N'          , 'N'            , 'N'            ],
                                         [100           , 380          , 100            , 100            ],
                                         [taRightJustify, taLeftJustify, taLeftJustify  , taLeftJustify  ]);

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
      UtLog_Execute('TFrIWOrden_Produccion.IWAppFormCreate, ' + E.Message);
    End;
  End;
end;

procedure TFrIWOrden_Produccion.IWAppFormDestroy(Sender: TObject);
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
      UtLog_Execute('TFrIWOrden_Produccion.IWAppFormDestroy, ' + E.Message);
  End;
end;

procedure TFrIWOrden_Produccion.BTNFECHA_FINALAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese la fecha final de la orden de prodcucci�n', Self.Name + '.Resultado_Fecha_Final', 'Fecha Final', FQRMAESTRO.QR.FieldByName('FECHA_FINAL').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWOrden_Produccion.BTNFECHA_FINALAsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWOrden_Produccion.NewRecordMaster(pSender: TObject);
begin
  Inherited;
  Try
    FQRMAESTRO.QR.FieldByName('CODIGO_DOCUMENTO' ).AsString  := FCODIGO_DOCUMENTO;
    FQRMAESTRO.QR.FieldByName('NUMERO'           ).AsInteger := UtilsIW_Numero_Siguiente_Get(FCNX, FCODIGO_DOCUMENTO);
    FQRMAESTRO.QR.FieldByName('CODIGO_USUARIO'   ).AsString  := UserSession.USER_CODE            ;
    FQRMAESTRO.QR.FieldByName('FECHA_REGISTRO'   ).AsString  := FormatDateTime('YYYY-MM-DD', Now);
    FQRMAESTRO.QR.FieldByName('FECHA_INICIAL'    ).AsString  := FormatDateTime('YYYY-MM-DD', Now);
    FQRMAESTRO.QR.FieldByName('FECHA_FINAL'      ).AsString  := FormatDateTime('YYYY-MM-DD', Now);
    FQRMAESTRO.QR.FieldByName('HORA_REGISTRO'    ).AsString  := FormatDateTime('HH:NN:SS'  , Now);
    FQRMAESTRO.QR.FieldByName('ID_ACTIVO'        ).AsString  := 'S';
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWOrden_Produccion.NewRecordMaster, ' + E.Message);
    End;
  End;
end;

procedure TFrIWOrden_Produccion.AfterPostMaster(pSender : TObject);
begin
  Try
    FCODIGO_ACTUAL := '';
    If FQRMAESTRO.NEW_RECORD Then
       UtilsIW_Numero_Siguiente_Put(FCNX, FCODIGO_DOCUMENTO, FQRMAESTRO.QR.FieldByName('NUMERO').AsInteger);
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWOrden_Produccion.AfterPostMaster, ' + E.Message);
    End;
  End;
end;

procedure TFrIWOrden_Produccion.BtnAcarreoAsyncClick(Sender: TObject;  EventParams: TStringList);
begin
  FQRMAESTRO.SetAcarreo(Not FQRMAESTRO.ACARREO, ['CODIGO_DOCUMENTO', 'NUMERO'], [FQRMAESTRO.QR.FieldByName('CODIGO_DOCUMENTO').AsString, FQRMAESTRO.QR.FieldByName('NUMERO').AsString]);
end;

procedure TFrIWOrden_Produccion.BTNACTIVOAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  WebApplication.ShowConfirm('Esta activo?', Self.Name + '.Resultado_Activo', 'Activo', 'S�', 'No')
end;

procedure TFrIWOrden_Produccion.BTNBACKAsyncClick(Sender: TObject;  EventParams: TStringList);
begin
  If FQRMAESTRO.Mode_Edition Then
    FQRMAESTRO.QR.Cancel;
  Release_Me;
end;

Procedure TFrIWOrden_Produccion.Localizar_Registro(Sender: TObject; EventParams: TStringList);
Begin
  Try
    AbrirMaestro(EventParams.Values['NUMERO']);
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWOrden_Produccion.Localizar_Registro, ' + e.Message);
  End;
End;

procedure TFrIWOrden_Produccion.BTNBUSCARAsyncClick(Sender: TObject;  EventParams: TStringList);
begin
  Try
    If Vacio(DATO.Text) Then
    Begin
      Buscar_Info(Id_TBL_Orden_Produccion, Localizar_Registro);
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

procedure TFrIWOrden_Produccion.BTNNOMBREAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese el nombre del Orden_Produccion', Self.Name + '.Resultado_Nombre', 'Nombre', FQRMAESTRO.QR.FieldByName('NOMBRE').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWOrden_Produccion.BTNNOMBREAsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWOrden_Produccion.BTNREFERENCIAAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese el documento referencia de la orden de producci�n', Self.Name + '.Resultado_Referencia', 'Documento Referencia', FQRMAESTRO.QR.FieldByName('DOCUMENTO_REFERENCIA').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWOrden_Produccion.BTNREFERENCIAAsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWOrden_Produccion.BTNFECHA_INICIALAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese la fecha inicial de la orden de prodcucci�n', Self.Name + '.Resultado_Fecha_Inicial', 'Fecha Inicial', FQRMAESTRO.QR.FieldByName('FECHA_INICIAL').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWOrden_Produccion.BTNFECHA_INICIALAsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWOrden_Produccion.BTNCANTIDADAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese la cantidad', Self.Name + '.Resultado_Cantidad', 'Cantidad', FQRMAESTRO.QR.FieldByName('CANTIDAD').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWOrden_Produccion.BTNCANTIDADAsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWOrden_Produccion.BTNCODIGO_PROYECTOAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Buscar_Info(Id_TBL_Proyecto, Resultado_Proyecto);
end;

procedure TFrIWOrden_Produccion.BTNCODIGO_PRODUCTOAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Buscar_Info(Id_TBL_Producto, Resultado_Producto);
end;

procedure TFrIWOrden_Produccion.BTNCODIGO_TERCEROAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Buscar_Info(Id_TBL_Tercero, Resultado_Tercero);
end;

procedure TFrIWOrden_Produccion.BTNCREARPROYECTOAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Mostrar_BasicData(Id_TBL_Proyecto, 'Ingreso del Proyecto', 'C�digo', 'CODIGO_PROYECTO', 'Nombre' , 'NOMBRE', 'CODIGO_PROYECTO', Resultado_BasicData);
end;

procedure TFrIWOrden_Produccion.BTNCREARPRODUCTOAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Mostrar_BasicData(Id_TBL_Producto, 'Ingreso del Producto', 'Codigo', 'CODIGO_PRODUCTO', 'Nombre' , 'NOMBRE', 'CODIGO_PRODUCTO', Resultado_BasicData);
end;

procedure TFrIWOrden_Produccion.BTNCREARTERCEROAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Mostrar_BasicData(Id_TBL_Tercero, 'Ingreso del Tercero', 'Identificaci�n', 'CODIGO_TERCERO', 'Nombre' , 'NOMBRE', 'CODIGO_TERCERO', Resultado_BasicData);
end;

procedure TFrIWOrden_Produccion.BTNDESCRIPCIONAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese el descripcion de la orden produccion', Self.Name + '.Resultado_Descripcion', 'Descripcion', FQRMAESTRO.QR.FieldByName('DESCRIPCION').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWOrden_Produccion.BTNDESCRIPCIONAsyncClick, ' + e.Message);
  End;
end;


end.
