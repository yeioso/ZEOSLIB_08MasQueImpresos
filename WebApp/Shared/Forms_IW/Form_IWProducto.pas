unit Form_IWProducto;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes,
  Vcl.Imaging.pngimage, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompExtCtrls, Vcl.Controls, Vcl.Forms, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWCompLabel,
  IWCompTabControl, IWCompJQueryWidget, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, UtConexion, Data.DB, IWCompGrids, IWDBStdCtrls,
  IWCompEdit, IWCompCheckbox, IWCompMemo, IWDBExtCtrls, IWCompButton,
  IWCompListbox, IWCompGradButton, UtGrid_JQ, UtNavegador_ASE,
  UtilsIW.Busqueda;

type
  TFrIWProducto = class(TIWAppForm)
    RINFO: TIWRegion;
    lbInfo: TIWLabel;
    IWRegion1: TIWRegion;
    PAGINAS: TIWTabControl;
    PAG_00: TIWTabPage;
    PAG_01: TIWTabPage;
    RNAVEGADOR: TIWRegion;
    DATO: TIWEdit;
    IWRegion_Navegador: TIWRegion;
    IWModalWindow1: TIWModalWindow;
    IWLabel7: TIWLabel;
    BTNCODIGO_AREA: TIWImage;
    CODIGO_AREA: TIWDBLabel;
    BTNCREARAREA: TIWImage;
    IWLabel1: TIWLabel;
    IWLabel8: TIWLabel;
    IWLabel2: TIWLabel;
    CODIGO_PRODUCTO: TIWDBEdit;
    NOMBRE: TIWDBEdit;
    DESCRIPCION: TIWDBMemo;
    IWLabel11: TIWLabel;
    IWLabel3: TIWLabel;
    IWLabel4: TIWLabel;
    IWLabel5: TIWLabel;
    CODIGO_UNIDAD_MEDIDA: TIWDBLabel;
    lbNombre_Area: TIWLabel;
    BTNCODIGO_UNIDAD_MEDIDA: TIWImage;
    BTNCREARUNIDAD_MEDIDA: TIWImage;
    lbNombre_Unidad_Medida: TIWLabel;
    VALOR_UNITARIO: TIWDBEdit;
    STOCK_MINIMO: TIWDBEdit;
    STOCK_MAXIMO: TIWDBEdit;
    ID_ACTIVO: TIWDBCheckBox;
    procedure BTNBACKAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure BTNBUSCARAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BtnAcarreoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCODIGO_AREAAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCREARAREAAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCODIGO_UNIDAD_MEDIDAAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCREARUNIDAD_MEDIDAAsyncClick(Sender: TObject;  EventParams: TStringList);
  private
    FCNX : TConexion;
    FINFO : String;
    FQRMAESTRO : TMANAGER_DATA;
    FNAVEGADOR : TNavegador_ASE;
    FGRID_MAESTRO : TGRID_JQ;
    Procedure Asignar_Codigo_Producto;
    Procedure Resultado_Area(Sender: TObject; EventParams: TStringList);
    Procedure Resultado_Unidad_Medida(Sender: TObject; EventParams: TStringList);
    procedure Resultado_BasicData(Sender: TObject; EventParams: TStringList);
    procedure Mostrar_BasicData(Const pId : Integer; Const pTitle, pCaptionCode, pFieldCode, pCaptionName, pFieldName, pFieldDestiny : String; pResult : TIWAsyncEvent);
    Procedure Localizar_Registro(Sender: TObject; EventParams: TStringList);
    procedure Buscar_Info(pSD : Integer; pEvent : TIWAsyncEvent);
    Procedure Release_Me;

    Function Existe_Producto(Const pCODIGO_PRODUCTO : String) : Boolean;

    Procedure Validar_Campos_Master(pSender: TObject);
    procedure NewRecordMaster(pSender: TObject);

    Function Documento_Activo : Boolean;

    Procedure DsDataChangeMaster(pSender: TObject);
    Procedure DsStateMaster(pSender: TObject);

    Procedure SetLabel;
    Procedure Estado_Controles;
    Function AbrirMaestro(Const pDato : String = '') : Boolean;
  public
  end;


implementation
{$R *.dfm}
Uses
  Math,
  UtFecha,
  Variants,
  UtFuncion,
  Vcl.Graphics,
  Winapi.Windows,
  System.UITypes,
  System.StrUtils,
  ServerController,
  UtIWBasicData_ASE,
  TBL000.Info_Tabla,
  UtilsIW.ManagerLog,
  Report.Saldo_Inventario;

Procedure TFrIWProducto.Asignar_Codigo_Producto;
Var
  lI : Integer;
  lCode : string;
  lPrefix : string;
  lNumber : string;
  lAvailable : Boolean;
Begin
  Try
    If Not Vacio(lbNombre_Area.Caption) Then
    Begin
      lI := 0;
      lCode := '';
      lPrefix := Trim(Copy(lbNombre_Area.Caption, 1, 12));
      lAvailable := False;
      While (lI <= 9999999) And (Not lAvailable) Do
      Begin
        Inc(lI);
        lNumber := Justificar(IntToStr(lI), '0', 7);
        lCode := lPrefix + '-' + lNumber;
        lCode := Justificar(lCode, '0', FQRMAESTRO.QR.FieldByName('CODIGO_PRODUCTO').Size);
        lAvailable := Not FCNX.Record_Exist(Info_TablaGet(Id_TBL_Producto).Name, ['CODIGO_PRODUCTO'], [lCode]);
      End;
      If Not Vacio(lCode) And lAvailable Then
        FQRMAESTRO.QR.FieldByName('CODIGO_PRODUCTO').AsString := lCode;
    End;
  Except
   On E: Exception Do
     Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWProducto', 'TFrIWProducto.Asignar_Codigo_Producto', E.Message);
  End;
End;

Procedure TFrIWProducto.Resultado_Area(Sender: TObject; EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      FQRMAESTRO.QR.FieldByName('CODIGO_AREA').AsString := EventParams.Values ['CODIGO_AREA' ];
      Asignar_Codigo_Producto;
    End;
  Except
   On E: Exception Do
     Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWProducto', 'TFrIWProducto.Resultado_Area', E.Message);
  End;
End;

Procedure TFrIWProducto.Resultado_Unidad_Medida(Sender: TObject; EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      FQRMAESTRO.QR.FieldByName('CODIGO_UNIDAD_MEDIDA').AsString := EventParams.Values ['CODIGO_UNIDAD_MEDIDA'];
    End;
  Except
   On E: Exception Do
     Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWProducto', 'TFrIWProducto.Resultado_Unidad_Medida', E.Message);
  End;
End;

procedure TFrIWProducto.Resultado_BasicData(Sender: TObject; EventParams: TStringList);
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
         If lBD.FIELDCODE <> 'CODIGO_AREA' Then
           Asignar_Codigo_Producto;
       End;
    End;
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWProducto', 'TFrIWProducto.Resultado_BasicData', E.Message);
  End;
End;

procedure TFrIWProducto.Mostrar_BasicData(Const pId : Integer; Const pTitle, pCaptionCode, pFieldCode, pCaptionName, pFieldName, pFieldDestiny : String; pResult : TIWAsyncEvent);
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWProducto', 'TFrIWProducto.Mostrar_BasicData', E.Message);
  End;
End;

Procedure TFrIWProducto.Localizar_Registro(Sender: TObject; EventParams: TStringList);
Begin
  Try
    AbrirMaestro(EventParams.Values['CODIGO_PRODUCTO']);
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWProducto', 'TFrIWProducto.Localizar_Registro', E.Message);
  End;
End;

procedure TFrIWProducto.Buscar_Info(pSD : Integer; pEvent : TIWAsyncEvent);
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWProducto', 'TFrIWProducto.Buscar_Info', E.Message);
  End;
End;

Procedure TFrIWProducto.Release_Me;
Begin
  Self.Release;
End;

Function TFrIWProducto.Existe_Producto(Const pCODIGO_PRODUCTO : String) : Boolean;
Begin
  Result := FCNX.Record_Exist(Info_TablaGet(Id_TBL_Producto).Name, ['CODIGO_PRODUCTO'], [pCODIGO_PRODUCTO]);
End;

Procedure TFrIWProducto.Validar_Campos_Master(pSender: TObject);
Var
  lMensaje : String;
Begin
  FQRMAESTRO.ERROR := 0;
  Try
    lMensaje := '';
    FQRMAESTRO.LAST_ERROR := '';
    NOMBRE.BGColor := UserSession.COLOR_OK;
    CODIGO_AREA.BGColor := UserSession.COLOR_OK;
    CODIGO_PRODUCTO.BGColor := UserSession.COLOR_OK;
    CODIGO_UNIDAD_MEDIDA.BGColor := UserSession.COLOR_OK;

    If FQRMAESTRO.Mode_Insert And (Not Vacio(FQRMAESTRO.QR.FieldByName('CODIGO_PRODUCTO').AsString)) Then
    Begin
      FQRMAESTRO.QR.FieldByName('CODIGO_PRODUCTO').AsString := Justificar(FQRMAESTRO.QR.FieldByName('CODIGO_PRODUCTO').AsString, '0', FQRMAESTRO.QR.FieldByName('CODIGO_PRODUCTO').Size);
      FQRMAESTRO.QR.FieldByName('CODIGO_PRODUCTO').AsString := Copy(FQRMAESTRO.QR.FieldByName('CODIGO_PRODUCTO').AsString, 1, FQRMAESTRO.QR.FieldByName('CODIGO_PRODUCTO').Size);
    End;

    If FQRMAESTRO.Mode_Insert And (Vacio(FQRMAESTRO.QR.FieldByName('CODIGO_PRODUCTO').AsString) Or Existe_Producto(FQRMAESTRO.QR.FieldByName('CODIGO_PRODUCTO').AsString)) Then
    Begin
      lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Codigo de producto no valido o ya existe';
      CODIGO_PRODUCTO.BGColor := UserSession.COLOR_ERROR;
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

    If FQRMAESTRO.Mode_Edition And Vacio(FQRMAESTRO.QR.FieldByName('CODIGO_UNIDAD_MEDIDA').AsString) Then
    Begin
      lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Unidad de medida invalida';
      CODIGO_UNIDAD_MEDIDA.BGColor := UserSession.COLOR_ERROR;
    End;

    FQRMAESTRO.ERROR := IfThen(Vacio(lMensaje), 0, -1);
    If FQRMAESTRO.ERROR <> 0 Then
    Begin
      FQRMAESTRO.LAST_ERROR := 'Datos invalidos, ' + lMensaje;
      UserSession.SetMessage(FQRMAESTRO.LAST_ERROR, True);
    End;
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWProducto', 'TFrIWProducto.Validar_Campos_Master', E.Message);
  End;
End;

Procedure TFrIWProducto.Estado_Controles;
Begin
  CODIGO_PRODUCTO.Enabled  := FQRMAESTRO.Mode_Insert  And Documento_Activo;
  NOMBRE.Enabled           := FQRMAESTRO.Mode_Edition And Documento_Activo;
  VALOR_UNITARIO.Enabled   := FQRMAESTRO.Mode_Edition And Documento_Activo;
  STOCK_MINIMO.Enabled     := FQRMAESTRO.Mode_Edition And Documento_Activo;
  STOCK_MAXIMO.Enabled     := FQRMAESTRO.Mode_Edition And Documento_Activo;
  ID_ACTIVO.Enabled        := FQRMAESTRO.Mode_Edition And Documento_Activo;

  CODIGO_PRODUCTO.Editable := FQRMAESTRO.Mode_Insert  And Documento_Activo;
  NOMBRE.Editable          := FQRMAESTRO.Mode_Edition And Documento_Activo;
  VALOR_UNITARIO.Editable  := FQRMAESTRO.Mode_Edition And Documento_Activo;
  STOCK_MINIMO.Editable    := FQRMAESTRO.Mode_Edition And Documento_Activo;
  STOCK_MAXIMO.Editable    := FQRMAESTRO.Mode_Edition And Documento_Activo;
  ID_ACTIVO.Editable       := FQRMAESTRO.Mode_Edition And Documento_Activo;

  DESCRIPCION.Editable            := FQRMAESTRO.Mode_Edition And Documento_Activo;

  BTNCREARAREA.Visible            := FQRMAESTRO.Mode_Insert And Documento_Activo;
  BTNCREARUNIDAD_MEDIDA.Visible   := FQRMAESTRO.Mode_Insert And Documento_Activo;
  BTNCODIGO_AREA.Visible          := FQRMAESTRO.Mode_Insert And Documento_Activo;
  BTNCODIGO_UNIDAD_MEDIDA.Visible := FQRMAESTRO.Mode_Insert And Documento_Activo;
  DATO.Visible                    := (Not FQRMAESTRO.Mode_Edition);
  PAG_00.Visible                  := (Not FQRMAESTRO.Mode_Edition);
  PAG_01.Visible                  := True;
End;

Procedure TFrIWProducto.SetLabel;
Var
  lExistencia : Double;
Begin
  If Not FQRMAESTRO.Active Then
    Exit;
  Try
    lbNombre_Area.Caption := FCNX.GetValue(Info_TablaGet(Id_TBL_Area).Name, ['CODIGO_AREA'], [FQRMAESTRO.QR.FieldByName('CODIGO_AREA').AsString], ['NOMBRE']);
    lbNombre_Unidad_Medida.Caption := FCNX.GetValue(Info_TablaGet(Id_TBL_Unidad_Medida).Name, ['CODIGO_UNIDAD_MEDIDA'], [FQRMAESTRO.QR.FieldByName('CODIGO_UNIDAD_MEDIDA').AsString], ['NOMBRE']);
    lExistencia := Report_Saldo_Inventario_Saldo(FCNX, FQRMAESTRO.QR.FieldByName('CODIGO_PRODUCTO').AsString, FQRMAESTRO.QR.FieldByName('CODIGO_PRODUCTO').AsString);
    lbNombre_Unidad_Medida.Caption := lbNombre_Unidad_Medida.Caption + ', Existencia: ' + FormatFloat('###,###,##0.#0', lExistencia);
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWProducto', 'TFrIWProducto.SetLabel', E.Message);
    End;
  End;
End;

Function TFrIWProducto.Documento_Activo : Boolean;
Begin
  Try
    Result := True;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWProducto', 'TFrIWProducto.Documento_Activo', E.Message);
    End;
  End;
End;

procedure TFrIWProducto.DsDataChangeMaster(pSender: TObject);
begin
  FNAVEGADOR.UpdateState;
  If (Not FQRMAESTRO.Active)Then
    Exit;

  If FQRMAESTRO.Active Then
    lbInfo.Caption := FINFO + ' [ ' + FQRMAESTRO.QR.FieldByName('CODIGO_PRODUCTO').AsString + ',' + FQRMAESTRO.QR.FieldByName('NOMBRE').AsString + ' ] ';
  Self.Title := Info_TablaGet(Id_TBL_Producto).Caption + ', ' + lbInfo.Caption;
  SetLabel;
  Try
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWProducto', 'TFrIWProducto.DsDataChangeMaster', E.Message);
    End;
  End;
end;

Procedure TFrIWProducto.DsStateMaster(pSender: TObject);
Begin
  If Not FQRMAESTRO.Active Then
    Exit;
  Estado_Controles;
  If FQRMAESTRO.Mode_Edition Then
    PAGINAS.ActivePage := 1;
  Case FQRMAESTRO.DS.State Of
    dsInsert : Begin
               End;
    dsEdit   : Begin
               End;
  End;
End;

Function TFrIWProducto.AbrirMaestro(Const pDato : String = '') : Boolean;
Begin
  FGRID_MAESTRO.Caption := Info_TablaGet(Id_TBL_Producto).Caption;
  Result := False;
  Try
    FQRMAESTRO.Active := False;
    FQRMAESTRO.SENTENCE := ' SELECT ' + FCNX.Top_Sentence(Const_Max_Record) + ' * FROM ' + Info_TablaGet(Id_TBL_Producto).Name + ' ';
    FQRMAESTRO.WHERE := '';
    If Trim(pDato) <> '' Then
    Begin
      FQRMAESTRO.WHERE := ' WHERE CODIGO_PRODUCTO LIKE ' + QuotedStr('%' + Trim(pDato) + '%') ;
      FQRMAESTRO.WHERE := FQRMAESTRO.WHERE + ' OR NOMBRE LIKE ' + QuotedStr('%' + Trim(pDato) + '%') ;
    End;
    FQRMAESTRO.ORDER := ' ORDER BY CODIGO_PRODUCTO ';
    FQRMAESTRO.Active := True;
    Result := FQRMAESTRO.Active;
    If Result Then
    Begin

    End;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWProducto', 'TFrIWProducto.AbrirMaestro', E.Message);
    End;
  End;
  FGRID_MAESTRO.RefreshData;
End;

procedure TFrIWProducto.IWAppFormCreate(Sender: TObject);
Var
  lI : Integer;
begin
  FINFO := UserSession.FULL_INFO + Info_TablaGet(Id_TBL_Producto).Caption;
  Randomize;
  Self.Name := 'TFrIWProducto' + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now) + IntToStr(Random(1000) );
  Self.Title := Info_TablaGet(Id_TBL_Producto).Caption;
  FCNX := UserSession.CNX;
  Try
    FGRID_MAESTRO        := TGRID_JQ.Create(PAG_00);
    FGRID_MAESTRO.Parent := PAG_00;
    FGRID_MAESTRO.Top    := 010;
    FGRID_MAESTRO.Left   := 010;
    FGRID_MAESTRO.Width  := 700;
    FGRID_MAESTRO.Height := 500;

    FQRMAESTRO := UserSession.Create_Manager_Data(Info_TablaGet(Id_TBL_Producto).Name, Info_TablaGet(Id_TBL_Producto).Caption);

    FQRMAESTRO.ON_NEW_RECORD   := NewRecordMaster;
    FQRMAESTRO.ON_DATA_CHANGE  := DsDataChangeMaster;
    FQRMAESTRO.ON_BEFORE_POST  := Validar_Campos_Master;
    FQRMAESTRO.ON_STATE_CHANGE := DsStateMaster;

    CODIGO_PRODUCTO.DataSource      := FQRMAESTRO.DS;
    NOMBRE.DataSource               := FQRMAESTRO.DS;
    DESCRIPCION.DataSource          := FQRMAESTRO.DS;
    CODIGO_AREA.DataSource          := FQRMAESTRO.DS;
    CODIGO_UNIDAD_MEDIDA.DataSource := FQRMAESTRO.DS;
    VALOR_UNITARIO.DataSource       := FQRMAESTRO.DS;
    STOCK_MINIMO.DataSource         := FQRMAESTRO.DS;
    STOCK_MAXIMO.DataSource         := FQRMAESTRO.DS;
    ID_ACTIVO.DataSource            := FQRMAESTRO.DS;

    FGRID_MAESTRO.SetGrid(FQRMAESTRO.DS, ['CODIGO_PRODUCTO', 'NOMBRE'     ],
                                         ['Código'         , 'Nombre'     ],
                                         ['S'              , 'N'          ],
                                         [150              , 450          ],
                                         [taRightJustify, taLeftJustify]);

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

    If AbrirMaestro Then
    Begin
    End
    Else
      Release_Me
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWProducto', 'TFrIWProducto.IWAppFormCreate', E.Message);
    End;
  End;
end;

procedure TFrIWProducto.IWAppFormDestroy(Sender: TObject);
begin
  Try
    If Assigned(FQRMAESTRO) Then
    Begin
      FQRMAESTRO.Active := False;
      FreeAndNil(FQRMAESTRO);
    End;

    If Assigned(FNAVEGADOR) Then
      FreeAndNil(FNAVEGADOR);

    If Assigned(FGRID_MAESTRO) Then
      FreeAndNil(FGRID_MAESTRO);

  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWProducto', 'TFrIWProducto.IWAppFormDestroy', E.Message);
  End;
end;

procedure TFrIWProducto.NewRecordMaster(pSender: TObject);
begin
  Inherited;
  Try
    FQRMAESTRO.QR.FieldByName('CODIGO_PRODUCTO').AsString := FCNX.Next(Info_TablaGet(Id_TBL_Producto).Name, '0', ['CODIGO_PRODUCTO'], [],[], FQRMAESTRO.QR.FieldByName('CODIGO_PRODUCTO').Size);
    FQRMAESTRO.QR.FieldByName('ID_ACTIVO'      ).AsString := 'S';
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWProducto', 'TFrIWProducto.NewRecordMaster', E.Message);
    End;
  End;
End;

procedure TFrIWProducto.BtnAcarreoAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  FQRMAESTRO.SetAcarreo(Not FQRMAESTRO.ACARREO, ['CODIGO_PRODUCTO'], [FQRMAESTRO.QR.FieldByName('CODIGO_PRODUCTO').AsString]);
end;

Procedure TFrIWProducto.BTNBACKAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  If FQRMAESTRO.Mode_Edition  Then
    FQRMAESTRO.QR.Cancel;
  Release_Me;
end;

procedure TFrIWProducto.BTNBUSCARAsyncClick(Sender: TObject;  EventParams: TStringList);
begin
  Try
    If Vacio(DATO.Text) Then
    Begin
      Buscar_Info(Id_TBL_Producto, Localizar_Registro)
    End
    Else
    Begin
      AbrirMaestro(DATO.Text);
    End;
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWProducto', 'TFrIWProducto.BTNBUSCARAsyncClick', E.Message);
  End;
end;

procedure TFrIWProducto.BTNCODIGO_AREAAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Buscar_Info(Id_TBL_Area, Resultado_Area);
end;

procedure TFrIWProducto.BTNCODIGO_UNIDAD_MEDIDAAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Buscar_Info(Id_TBL_Unidad_Medida, Resultado_Unidad_Medida);
end;

procedure TFrIWProducto.BTNCREARAREAAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Mostrar_BasicData(Id_TBL_Area, 'Ingreso del Area', 'Código', 'CODIGO_AREA', 'Nombre' , 'NOMBRE', 'CODIGO_AREA', Resultado_BasicData);
end;

procedure TFrIWProducto.BTNCREARUNIDAD_MEDIDAAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Mostrar_BasicData(Id_TBL_Unidad_Medida, 'Ingreso de la unidad medida', 'Código', 'CODIGO_UNIDAD_MEDIDA', 'Nombre' , 'NOMBRE', 'CODIGO_UNIDAD_MEDIDA', Resultado_BasicData);
end;

end.
