unit Form_IWExplosion_Material;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes,
  Vcl.Imaging.pngimage, IWCompExtCtrls, IWCompEdit, IWDBStdCtrls,
  IWCompCheckbox, Vcl.Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompLabel, IWCompGrids,
  UtConexion, Vcl.Forms, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompListbox, UtGrid_JQ,
  IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component;

type
  TFrIWExplosion_Material = class(TIWAppForm)
    BTNADD: TIWImage;
    BTNEDIT: TIWImage;
    BTNDEL: TIWImage;
    BTNSAVE: TIWImage;
    BTNCANCEL: TIWImage;
    BTNEXIT: TIWImage;
    IWLabel6: TIWLabel;
    BTNCODIGO_PRODUCTO: TIWImage;
    lbNombre_Producto: TIWLabel;
    IWLabel1: TIWLabel;
    FECHA_PROGRAMADA: TIWDBEdit;
    IWLabel2: TIWLabel;
    NOMBRE: TIWDBEdit;
    IWLabel3: TIWLabel;
    CANTIDAD: TIWDBEdit;
    ID_ACTIVO: TIWDBCheckBox;
    DATO: TIWEdit;
    IWModalWindow1: TIWModalWindow;
    CODIGO_PRODUCTO: TIWDBLabel;
    LBINFO: TIWLabel;
    procedure BTNEXITAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNADDAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNEDITAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNDELAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNSAVEAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCANCELAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure DATOAsyncKeyUp(Sender: TObject; EventParams: TStringList);
    procedure BTNCODIGO_PRODUCTOAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    FCNX : TConexion;
    FNOMBRE : String;
    FNUMERO : Integer;
    FPROYECTO : String;
    FQRDETALLE : TMANAGER_DATA;
    FREFERENCIA : String;
    FGRID_MAESTRO : TGRID_JQ;
    FEJECUTANDO_ONCHANGE : Boolean;
    FCODIGO_DOCUMENTO : String;
    Procedure Actualizar_Notificacion(Const pCodigo_Usuario, pCodigo_Producto, pFecha, pHora : string; Const pMin, pMax, pCantidad, pSaldo : Double);
    Procedure Verificar_Notificacion(pSender : TObject);
    Procedure Resultado_Producto(Sender: TObject; EventParams: TStringList);
    procedure Buscar_Info(pSD : Integer; pEvent : TIWAsyncEvent);
    Procedure Confirmacion_Guardar(EventParams: TStringList);
    Procedure Confirmacion_Eliminacion(EventParams: TStringList);
    Procedure Release_Me;
    Procedure Validar_Campos_Detalle(pSender: TObject);
    procedure NewRecordDetalle(pSender: TObject);
    procedure DsDataChangeDetalle(pSender: TObject);
    procedure DsStateChangeDetalle(pSender: TObject);
    Function AbrirDetalle(Const pDato : String  = '') : Boolean;
  public
    Constructor Create(AOwner: TComponent; Const pCodigo_Documento, pNombre, pReferencia, pProyecto : String; Const pNumero : Integer);
    Destructor Destroy; override;
  end;

implementation
{$R *.dfm}
Uses
  db,
  Math,
  UtFecha,
  StrUtils,
  Variants,
  UtFuncion,
  UtilsIW.Busqueda,
  ServerController,
  TBL000.Info_Tabla,
  UtilsIW.ManagerLog,
  Report.Saldo_Inventario;

{ TFrIWExplosion_Material }

Procedure TFrIWExplosion_Material.Resultado_Producto(Sender: TObject; EventParams: TStringList);
Begin
  Try
    If FQRDETALLE.Mode_Edition Then
    Begin
      FQRDETALLE.QR.FieldByName('CODIGO_PRODUCTO').AsString := EventParams.Values ['CODIGO_PRODUCTO'];
      FQRDETALLE.QR.FieldByName('NOMBRE').AsString := 'OP: ' + FormatFloat('###,###,###', FNUMERO)+ ', '+
                                                      'REFERENCIA: ' + FREFERENCIA  +', '+
                                                      'PROYECTO: ' + FPROYECTO;
    End;
  Except
   On E: Exception Do
     Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWExplosion_Material', 'TFrIWExplosion_Material.Resultado_Producto', E.Message);
  End;
End;

procedure TFrIWExplosion_Material.Buscar_Info(pSD : Integer; pEvent : TIWAsyncEvent);
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWExplosion_Material', 'TFrIWExplosion_Material.Buscar_Info', E.Message);
  End;
End;

Procedure TFrIWExplosion_Material.Confirmacion_Guardar(EventParams: TStringList);
Var
  lRecNo : Integer;
begin
  // Confirm callback has 1 main parameters:
  // RetValue (Boolean), indicates if the first button (Yes/OK/custom) was choosen
  If Result_Is_OK(EventParams.Values['RetValue']) Then
  Begin
    Try
      lRecNo := FQRDETALLE.QR.RecNo;
      FQRDETALLE.QR.Post;
      FGRID_MAESTRO.RefreshData;
      FQRDETALLE.QR.RecNo := lRecNo;
      UserSession.SetMessage('Registro almacenado', False);
    Except
      On E: Exception Do
        Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWExplosion_Material', 'TFrIWExplosion_Material.Confirmacion_Guardar', E.Message);
    End;
  End;
//  WebApplication.ShowNotification('This is the callback. ' + 'The selected button was: ' + SelectedButton, MsgType);
end;

Procedure TFrIWExplosion_Material.Confirmacion_Eliminacion(EventParams: TStringList);
Var
  lRecNo : Integer;
begin
  // Confirm callback has 1 main parameters:
  // RetValue (Boolean), indicates if the first button (Yes/OK/custom) was choosen
  If Result_Is_OK(EventParams.Values['RetValue']) Then
  Begin
    Try
      lRecNo := FQRDETALLE.QR.RecNo;
      FQRDETALLE.QR.Delete;
      FGRID_MAESTRO.RefreshData;
      FQRDETALLE.QR.RecNo := lRecNo;
      UserSession.SetMessage('Registro eliminado', False);
    Except
      On E: Exception Do
        Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWExplosion_Material', 'TFrIWExplosion_Material.Confirmacion_Guardar', E.Message);
    End;
  End;
//  WebApplication.ShowNotification('This is the callback. ' + 'The selected button was: ' + SelectedButton, MsgType);
end;

procedure TFrIWExplosion_Material.BTNDELAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  WebApplication.ShowConfirm('Está seguro(a) de eliminar?', Self.Name + '.Confirmacion_Eliminacion', 'Eliminar', 'Sí', 'No');
end;

procedure TFrIWExplosion_Material.BTNSAVEAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Validar_Campos_Detalle(Sender);
  If FQRDETALLE.ERROR = 0 Then
    WebApplication.ShowConfirm('Está seguro(a) de guardar?', Self.Name + '.Confirmacion_Guardar', 'Guardar', 'Sí', 'No')
  Else
    UserSession.SetMessage(FQRDETALLE.LAST_ERROR, True);
end;

Procedure TFrIWExplosion_Material.Actualizar_Notificacion(Const pCodigo_Usuario, pCodigo_Producto, pFecha, pHora : string; Const pMin, pMax, pCantidad, pSaldo : Double);
Var
  lNombre : String;
Begin
  Try
    lNombre := 'Saldo : ' + FormatFloat('###,###,##0.#0', pSaldo) + ', ' + 'Cantidad : ' + FormatFloat('###,###,##0.#0', pSaldo);
    If (pMin > 0) And (pMin > pSaldo) Then
      lNombre := lNombre + IfThen(Not Vacio(lNombre), ', ') +
                 'Stock Minimo : ' + FormatFloat('###,###,##0.#0', pMin);

    If (pMax > 0) And (pMax < pSaldo) Then
      lNombre := lNombre + IfThen(Not Vacio(lNombre), ', ') +
                 'Stock Maximo : ' + FormatFloat('###,###,##0.#0', pMax);

    FCNX.TMP.Active := False;
    FCNX.TMP.SQL.Clear;
    FCNX.TMP.SQL.Add(' UPDATE ' + Info_TablaGet(Id_TBL_Notificacion_Producto).Name + ' ');
    FCNX.TMP.SQL.Add(' SET ');
    FCNX.TMP.SQL.Add('     CANTIDAD = :CANTIDAD ');
    FCNX.TMP.SQL.Add('     , NOMBRE = :NOMBRE ');
    FCNX.TMP.SQL.Add(' WHERE ' + FCNX.Trim_Sentence('CODIGO_USUARIO' ) + ' = ' + QuotedStr(Trim(pCodigo_Usuario )));
    FCNX.TMP.SQL.Add(' AND '   + FCNX.Trim_Sentence('CODIGO_PRODUCTO') + ' = ' + QuotedStr(Trim(pCodigo_Producto)));
    FCNX.TMP.SQL.Add(' AND '   + FCNX.Trim_Sentence('FECHA_REGISTRO' ) + ' = ' + QuotedStr(Trim(pFecha          )));
    FCNX.TMP.SQL.Add(' AND '   + FCNX.Trim_Sentence('HORA_REGISTRO'  ) + ' = ' + QuotedStr(Trim(pFecha          )));
    FCNX.TMP.ParamByName('CANTIDAD').AsFloat  := pCantidad;
    FCNX.TMP.ParamByName('NOMBRE'  ).AsString := lNombre;

    FCNX.TMP.ExecSQL;
    If FCNX.TMP.RowsAffected <= 0 Then
    Begin
      FCNX.TMP.Active := False;
      FCNX.TMP.SQL.Clear;
      FCNX.TMP.SQL.Add(' INSERT INTO ' + Info_TablaGet(Id_TBL_Notificacion_Producto).Name + ' ');
      FCNX.TMP.SQL.Add(' ( ');
      FCNX.TMP.SQL.Add('     CODIGO_USUARIO ');
      FCNX.TMP.SQL.Add('    ,CODIGO_PRODUCTO ');
      FCNX.TMP.SQL.Add('    ,FECHA_REGISTRO ');
      FCNX.TMP.SQL.Add('    ,HORA_REGISTRO ');
      FCNX.TMP.SQL.Add('    ,NOMBRE ');
      FCNX.TMP.SQL.Add('    ,CANTIDAD ');
      FCNX.TMP.SQL.Add('    ,ID_ACTIVO ');
      FCNX.TMP.SQL.Add(' ) ');
      FCNX.TMP.SQL.Add(' VALUES ');
      FCNX.TMP.SQL.Add(' ( ');
      FCNX.TMP.SQL.Add('      :CODIGO_USUARIO ');
      FCNX.TMP.SQL.Add('    , :CODIGO_PRODUCTO ');
      FCNX.TMP.SQL.Add('    , :FECHA_REGISTRO ');
      FCNX.TMP.SQL.Add('    , :HORA_REGISTRO ');
      FCNX.TMP.SQL.Add('    , :NOMBRE ');
      FCNX.TMP.SQL.Add('    , :CANTIDAD ');
      FCNX.TMP.SQL.Add('    , :ID_ACTIVO ');
      FCNX.TMP.SQL.Add(' ) ');
      FCNX.TMP.ParamByName('CODIGO_USUARIO'  ).AsString := pCodigo_Usuario;
      FCNX.TMP.ParamByName('CODIGO_PRODUCTO' ).AsString := pCodigo_Producto;
      FCNX.TMP.ParamByName('FECHA_REGISTRO'  ).AsString := pFecha;
      FCNX.TMP.ParamByName('HORA_REGISTRO'   ).AsString := pHora;
      FCNX.TMP.ParamByName('NOMBRE'          ).AsString := lNombre;
      FCNX.TMP.ParamByName('CANTIDAD'        ).AsFloat  := pCantidad;
      FCNX.TMP.ParamByName('ID_ACTIVO'       ).AsString := 'S';
      FCNX.TMP.ExecSQL;
    End;
    FCNX.TMP.Active := False;
    FCNX.TMP.SQL.Clear;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWExplosion_Material', 'TFrIWExplosion_Material.Actualizar_Notificacion', E.Message);
    End;
  End;
End;

Procedure TFrIWExplosion_Material.Verificar_Notificacion(pSender : TObject);
Var
  lMin : Double;
  lMax : Double;
  lSaldo : Double;
Begin
  Try
    lMin := FCNX.GetValueDbl(Info_TablaGet(Id_TBL_Producto).Name, ['CODIGO_PRODUCTO'], [FQRDETALLE.QR.FieldByName('CODIGO_PRODUCTO').AsString], ['STOCK_MINIMO']);
    lMax := FCNX.GetValueDbl(Info_TablaGet(Id_TBL_Producto).Name, ['CODIGO_PRODUCTO'], [FQRDETALLE.QR.FieldByName('CODIGO_PRODUCTO').AsString], ['STOCK_MAXIMO']);
    lSaldo := Report_Saldo_Inventario_Saldo(FCNX, FQRDETALLE.QR.FieldByName('CODIGO_PRODUCTO').AsString, FQRDETALLE.QR.FieldByName('CODIGO_PRODUCTO').AsString);
    If (lSaldo < FQRDETALLE.QR.FieldByName('CANTIDAD').AsFloat) Or((lMin > 0) And (lSaldo < lMin)) Or ((lMax > 0) And (lSaldo > lMax)) Then
    Begin
      FCNX.AUX.Active := False;
      FCNX.AUX.SQL.Clear;
      FCNX.AUX.SQL.Add(' SELECT CODIGO_USUARIO FROM ' + Info_TablaGet(Id_TBL_Usuario).Name + FCNX.No_Lock);
      FCNX.AUX.SQL.Add(' WHERE ID_NOTIFICA_PRODUCTO = ' + QuotedStr('S'));
      FCNX.AUX.Active := True;
      FCNX.AUX.First;
      While Not FCNX.AUX.Eof Do
      Begin
        Actualizar_Notificacion(FCNX.AUX.FieldByName('CODIGO_USUARIO').AsString,
                                FQRDETALLE.QR.FieldByName('CODIGO_PRODUCTO').AsString,
                                FQRDETALLE.QR.FieldByName('FECHA_PROGRAMADA').AsString,
                                FQRDETALLE.QR.FieldByName('FECHA_REGISTRO'  ).AsString,
                                lMin, lMax, FQRDETALLE.QR.FieldByName('CANTIDAD').AsFloat, lSaldo);
        FCNX.AUX.Next;
      End;
      FCNX.AUX.Active := False;
      FCNX.AUX.SQL.Clear;
    End;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWExplosion_Material', 'TFrIWExplosion_Material.Verificar_Notificacion', E.Message);
    End;
  End;
End;


constructor TFrIWExplosion_Material.Create(AOwner: TComponent; Const pCodigo_Documento, pNombre, pReferencia, pProyecto : String; Const pNumero : Integer);
begin
  FCNX := UserSession.CNX;
  Inherited Create(AOwner);
  Try
    Randomize;
    Self.Name := 'TFrIWExplosion_Material' + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now) + IntToStr(Random(1000));
    FNUMERO := pNumero;
    FNOMBRE := AnsiUpperCase(pNombre);
    FPROYECTO := pProyecto;
    FREFERENCIA := pReferencia;
    LBINFO.Caption := FNOMBRE;
    Self.Title := Info_TablaGet(Id_TBL_Explosion_Material).Caption + ', ' + FNOMBRE + ', ' + lbNombre_Producto.Caption;
    WebApplication.RegisterCallBack(Self.Name + '.Confirmacion_Guardar'    , Confirmacion_Guardar    );
    WebApplication.RegisterCallBack(Self.Name + '.Confirmacion_Eliminacion', Confirmacion_Eliminacion);
    FCODIGO_DOCUMENTO := pCodigo_Documento;

    FGRID_MAESTRO        := TGRID_JQ.Create(Self);
    FGRID_MAESTRO.Parent := Self;

    FGRID_MAESTRO.Top    := DATO.Top + DATO.Height + 3;
    FGRID_MAESTRO.Left   := 010;
    FGRID_MAESTRO.Width  := DATO.Width;
    FGRID_MAESTRO.Height := 300;


    FQRDETALLE := UserSession.Create_Manager_Data(Info_TablaGet(Id_TBL_Explosion_Material).Name, Info_TablaGet(Id_TBL_Explosion_Material).Caption);
    FQRDETALLE.ON_AFTER_POST   := Verificar_Notificacion;
    FQRDETALLE.ON_NEW_RECORD   := NewRecordDetalle;
    FQRDETALLE.ON_BEFORE_POST  := Validar_Campos_Detalle;
    FQRDETALLE.ON_DATA_CHANGE  := DsDataChangeDetalle;
    FQRDETALLE.ON_STATE_CHANGE := DsStateChangeDetalle;

    CODIGO_PRODUCTO.DataSource  := FQRDETALLE.DS;
    NOMBRE.DataSource           := FQRDETALLE.DS;
    FECHA_PROGRAMADA.DataSource := FQRDETALLE.DS;
    CANTIDAD.DataSource         := FQRDETALLE.DS;
    ID_ACTIVO.DataSource        := FQRDETALLE.DS;

    FGRID_MAESTRO.VisibleRowCount := 11;
    FGRID_MAESTRO.SetGrid(FQRDETALLE.DS, ['CODIGO_PRODUCTO', 'NOMBRE'     , 'FECHA_PROGRAMADA'],
                                         ['Producto'       , 'Nombre'     , 'Fecha Programada'],
                                         ['S'              , 'N'          , 'N'               ],
                                         [150              , 450          , 100               ],
                                         [taRightJustify   , taLeftJustify, taLeftJustify     ]);
    AbrirDetalle;

  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWExplosion_Material', 'TFrIWExplosion_Material.Create', E.Message);
    End;
  End;
end;

procedure TFrIWExplosion_Material.DATOAsyncKeyUp(Sender: TObject; EventParams: TStringList);
begin
  AbrirDetalle(DATO.Text);
end;

destructor TFrIWExplosion_Material.Destroy;
begin
  Try
    If Assigned(FQRDETALLE) Then
    Begin
      FQRDETALLE.Active := False;
      FreeAndNil(FQRDETALLE);
    End;

    If Assigned(FGRID_MAESTRO) Then
      FreeAndNil(FGRID_MAESTRO);
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWExplosion_Material', 'TFrIWExplosion_Material.Destroy', E.Message);
    End;
  End;
  inherited;
end;

Procedure TFrIWExplosion_Material.Release_Me;
Begin
  Self.Release;
End;

procedure TFrIWExplosion_Material.BTNADDAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    FQRDETALLE.QR.Append;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWExplosion_Material', 'TFrIWExplosion_Material.BTNADDAsyncClick', E.Message);
    End;
  End;
end;

procedure TFrIWExplosion_Material.BTNCANCELAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    FQRDETALLE.QR.Cancel;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWExplosion_Material', 'TFrIWExplosion_Material.BTNCANCELAsyncClick', E.Message);
    End;
  End;
end;

procedure TFrIWExplosion_Material.BTNCODIGO_PRODUCTOAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Buscar_Info(Id_TBL_Producto, Resultado_Producto);
end;

procedure TFrIWExplosion_Material.BTNEDITAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    FQRDETALLE.QR.Edit;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWExplosion_Material', 'TFrIWExplosion_Material.BTNEDITAsyncClick', E.Message);
    End;
  End;
end;

procedure TFrIWExplosion_Material.BTNEXITAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Release_Me;
end;

Function TFrIWExplosion_Material.AbrirDetalle(Const pDato : String  = '') : Boolean;
Begin
  Result := False;
  Try
    FQRDETALLE.Active := False;
    FQRDETALLE.SENTENCE := ' SELECT * FROM ' + Info_TablaGet(Id_TBL_Explosion_Material).Name + FCNX.No_Lock;
    FQRDETALLE.WHERE    := ' WHERE ' + FCNX.Trim_Sentence('CODIGO_DOCUMENTO') + ' = ' + QuotedStr(Trim(FCODIGO_DOCUMENTO));
    FQRDETALLE.WHERE := FQRDETALLE.WHERE + ' AND NUMERO = ' + IntToStr(FNUMERO);
    If Not Vacio(pDato) Then
    Begin
      FQRDETALLE.WHERE := FQRDETALLE.WHERE + ' AND ( ';
      FQRDETALLE.WHERE := FQRDETALLE.WHERE + '  ' + FCNX.Trim_Sentence('NOMBRE') + ' LIKE ' + QuotedStr('%' + Trim(pDato) + '%');
      FQRDETALLE.WHERE := FQRDETALLE.WHERE + ' OR ' + FCNX.Trim_Sentence('CODIGO_PRODUCTO') + ' LIKE ' + QuotedStr('%' + Trim(pDato) + '%');
      FQRDETALLE.WHERE := FQRDETALLE.WHERE + ' OR ' + FCNX.Trim_Sentence('FECHA_PROGRAMADA') + ' LIKE ' + QuotedStr('%' + Trim(pDato) + '%');
      FQRDETALLE.WHERE := FQRDETALLE.WHERE + ' OR CANTIDAD = ' + pDato;
      FQRDETALLE.WHERE := FQRDETALLE.WHERE + ' ) ';
    End;
    FQRDETALLE.Active := True;
    Result := FQRDETALLE.Active;
    If Result Then
    Begin
    End;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWExplosion_Material', 'TFrIWExplosion_Material.AbrirDetalle', E.Message);
    End;
  End;
End;

Procedure TFrIWExplosion_Material.Validar_Campos_Detalle(pSender: TObject);
Var
  lMensaje : String;
Begin
  FQRDETALLE.ERROR := 0;
  Try
    lMensaje := '';
    NOMBRE.BGColor := UserSession.COLOR_OK;
    CANTIDAD.BGColor := UserSession.COLOR_OK;
    CODIGO_PRODUCTO.BGColor := UserSession.COLOR_OK;
    FECHA_PROGRAMADA.BGColor := UserSession.COLOR_OK;

    If FQRDETALLE.Mode_Insert Then
    Begin
      If Vacio(FQRDETALLE.QR.FieldByName('CODIGO_PRODUCTO').AsString) Or
        (Not FCNX.Record_Exist(Info_TablaGet(Id_TBL_Producto).Name, ['CODIGO_PRODUCTO'], [FQRDETALLE.QR.FieldByName('CODIGO_PRODUCTO').AsString])) Then
      Begin
        lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Producto invalido';
        CODIGO_PRODUCTO.BGColor := UserSession.COLOR_ERROR;
      End;
    End;

    If FQRDETALLE.Mode_Edition Then
    Begin
      If Vacio(FQRDETALLE.QR.FieldByName('NOMBRE').AsString) Then
      Begin
        lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Nombre invalido';
        NOMBRE.BGColor := UserSession.COLOR_ERROR;
      End;

      If Not Fecha_Valida(FQRDETALLE.QR.FieldByName('FECHA_PROGRAMADA').AsString) Then
      Begin
        lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Fecha programada invalida';
        FECHA_PROGRAMADA.BGColor := UserSession.COLOR_ERROR;
      End;

      If FQRDETALLE.QR.FieldByName('CANTIDAD').AsFloat <= 0 Then
      Begin
        lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Cantidad invalida';
        CANTIDAD.BGColor := UserSession.COLOR_ERROR;
      End;

      FQRDETALLE.ERROR := IfThen(Vacio(lMensaje), 0, -1);
      If FQRDETALLE.ERROR <> 0 Then
      Begin
        FQRDETALLE.LAST_ERROR := 'Datos invalidos, ' + lMensaje;
        UserSession.SetMessage(FQRDETALLE.LAST_ERROR, True);
      End;
    End;
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWExplosion_Material', 'TFrIWExplosion_Material.Validar_Campos_Detalle', E.Message);
  End;
End;

procedure TFrIWExplosion_Material.NewRecordDetalle(pSender: TObject);
begin
  Inherited;
  Try
    FQRDETALLE.QR.FieldByName('CODIGO_DOCUMENTO').AsString  := FCODIGO_DOCUMENTO;
    FQRDETALLE.QR.FieldByName('NUMERO'          ).AsInteger := FNUMERO;
    FQRDETALLE.QR.FieldByName('FECHA_PROGRAMADA').AsString  := FormatDateTime('YYYY-MM-DD', Now);
    FQRDETALLE.QR.FieldByName('FECHA_REGISTRO'  ).AsString  := FormatDateTime('YYYY-MM-DD', Now);
    FQRDETALLE.QR.FieldByName('HORA_REGISTRO'   ).AsString  := FormatDateTime('HH:NN:SS.Z', Now);
    FQRDETALLE.QR.FieldByName('CODIGO_USUARIO'  ).AsString  := UserSession.USER_CODE;
    FQRDETALLE.QR.FieldByName('ID_ACTIVO'       ).AsString := 'S';
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWExplosion_Material', 'TFrIWExplosion_Material.NewRecordDetalle', E.Message);
    End;
  End;
end;

procedure TFrIWExplosion_Material.DsDataChangeDetalle(pSender: TObject);
Begin
  Try
    lbNombre_Producto.Caption := FCNX.GetValue(Info_TablaGet(Id_TBL_Producto).Name, ['CODIGO_PRODUCTO'], [FQRDETALLE.QR.FieldByName('CODIGO_PRODUCTO').AsString], ['NOMBRE']);
    Self.Title := Info_TablaGet(Id_TBL_Explosion_Material).Caption + ', ' + FNOMBRE + ', ' + lbNombre_Producto.Caption;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWExplosion_Material', 'TFrIWExplosion_Material.DsDataChangeDetalle', E.Message);
    End;
  End;
End;

procedure TFrIWExplosion_Material.DsStateChangeDetalle(pSender: TObject);
Begin
  BTNADD.Visible       := Not FQRDETALLE.Mode_Edition;
  BTNDEL.Visible       := FQRDETALLE.ACTIVE and (Not FQRDETALLE.Mode_Edition) And (FQRDETALLE.QR.RecordCount > 0);
  BTNEDIT.Visible      := Not FQRDETALLE.Mode_Edition;
  BTNSAVE.Visible      := FQRDETALLE.Mode_Edition;
  BTNCANCEL.Visible    := FQRDETALLE.Mode_Edition;

  DATO.Visible             := Not FQRDETALLE.Mode_Edition;

  BTNCODIGO_PRODUCTO.Visible := FQRDETALLE.Mode_Insert ;

  FECHA_PROGRAMADA.Enabled  := FQRDETALLE.Mode_Insert ;
  NOMBRE.Enabled            := FQRDETALLE.Mode_Edition;
  CANTIDAD.Enabled          := FQRDETALLE.Mode_Edition;
  ID_ACTIVO.Enabled         := FQRDETALLE.Mode_Edition;

  FECHA_PROGRAMADA.Editable := FQRDETALLE.Mode_Insert ;
  NOMBRE.Editable           := FQRDETALLE.Mode_Edition;
  CANTIDAD.Editable         := FQRDETALLE.Mode_Edition;
  ID_ACTIVO.Editable        := FQRDETALLE.Mode_Edition;
End;

end.
