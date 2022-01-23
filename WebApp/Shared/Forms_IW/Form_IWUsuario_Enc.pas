unit Form_IWUsuario_Enc;

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
  TFrIWUsuario_Enc = class(TIWAppForm)
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
    IWLabel37: TIWLabel;
    IWLabel2: TIWLabel;
    IWLabel3: TIWLabel;
    IWLabel4: TIWLabel;
    IWCambiarPassword: TIWRegion;
    IWLabel35: TIWLabel;
    MANAGER_PASSWORD: TIWEdit;
    IWModalWindow1: TIWModalWindow;
    IWRegion_Navegador: TIWRegion;
    CODIGO_USUARIO: TIWDBEdit;
    NOMBRE: TIWDBEdit;
    DIRECCION: TIWDBEdit;
    EMAIL: TIWDBEdit;
    TELEFONO_1: TIWDBEdit;
    TELEFONO_2: TIWDBEdit;
    IWLabel7: TIWLabel;
    IWLabel10: TIWLabel;
    BTNCODIGO_PERFIL: TIWImage;
    CODIGO_PERFIL: TIWDBLabel;
    lbNombre_Perfil: TIWLabel;
    CONTRASENA: TIWDBEdit;
    BTNCONTRASENA: TIWImage;
    ID_NOTIFICA_PRODUCTO: TIWDBCheckBox;
    ID_ACTIVO: TIWDBCheckBox;
    IWRDETALLE: TIWRegion;
    GRID_DETALLE: TIWListbox;
    IWRBOTONDETALLE: TIWRegion;
    BtnGrid: TIWImage;
    procedure BTNBACKAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure BTNBUSCARAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BtnAcarreoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCONTRASENAAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNDIRECCIONAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCODIGO_PERFILAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BtnGridAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    FCNX : TConexion;
    FINFO : String;
    FCODIGO_USUARIO : String;

    FQRMAESTRO : TMANAGER_DATA;

    FNAVEGADOR : TNavegador_ASE;
    FGRID_MAESTRO : TGRID_JQ;

    FCODIGO_ACTUAL : String;

    Procedure Localizar_Registro(Sender: TObject; EventParams: TStringList);
    Procedure Resultado_Perfil(Sender: TObject; EventParams: TStringList);
    procedure Buscar_Info(pSD : Integer; pEvent : TIWAsyncEvent);
    Procedure Asignar_Password(Sender: TObject;  EventParams: TStringList);

    Procedure Release_Me;

    Function Existe_Usuario(Const pCODIGO_USUARIO : String): Boolean;

    Procedure Validar_Campos_Master(pSender: TObject);
    Function Documento_Activo: Boolean;

    Procedure NewRecordMaster(pSender: TObject);
    Procedure DsDataChangeMaster(pSender: TObject);
    Procedure DsStateMaster(Sender: TObject);

    Procedure SetLabel;
    Procedure Estado_Controles;
    Function AbrirMaestro(Const pDato: String = ''): Boolean;
    Procedure AbrirDetalle(Sender: TObject; EventParams: TStringList);
    Procedure Cambiar_Password;
  public
    Constructor Create(AOwner: TComponent; Const pCodigo_Usuario : String);
  end;

implementation

{$R *.dfm}

Uses
  Math,
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
  UtilsIW.ManagerLog;

Procedure TFrIWUsuario_Enc.Resultado_Perfil(Sender: TObject; EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      FQRMAESTRO.QR.FieldByName('CODIGO_PERFIL').AsString := EventParams.Values ['CODIGO_PERFIL' ];
    End;
  Except
   On E: Exception Do
     Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWUsuario_Enc', 'TFrIWUsuario_Enc.Resultado_Perfil', E.Message);
  End;
End;

procedure TFrIWUsuario_Enc.Buscar_Info(pSD : Integer; pEvent : TIWAsyncEvent);
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWUsuario_Enc', 'TFrIWUsuario_Enc.Buscar_Info', E.Message);
  End;
End;

Procedure TFrIWUsuario_Enc.Asignar_Password(Sender: TObject;  EventParams: TStringList);
Var
  lHash : String;
Begin
  Case IWModalWindow1.ButtonIndex Of
    1 : Begin
          FQRMAESTRO.QR.FieldByName('CONTRASENA').AsString := Trim(RetornarCodificado(Const_KEY, Trim(MANAGER_PASSWORD.Text), lHash));
          CONTRASENA.Text := Trim(FQRMAESTRO.QR.FieldByName('CONTRASENA').AsString);
        End;
    3 : Begin
        End;
  End;
End;

Procedure TFrIWUsuario_Enc.Cambiar_Password;
Var
  lHash : String;
Begin
  MANAGER_PASSWORD.Text := RetornarDecodificado(Const_KEY, FQRMAESTRO.QR.FieldByName('CONTRASENA').AsString, lHash);
  IWModalWindow1.Reset;
  IWModalWindow1.Buttons.CommaText := '&Aceptar,&Cancelar';
  IWModalWindow1.Title := 'Cambio de Contraseña';
  IWModalWindow1.ContentElement := IWCambiarPassword;
  IWModalWindow1.Autosize := True;
  IWModalWindow1.Draggable := True;
  IWModalWindow1.WindowTop := 10;
  IWModalWindow1.WindowLeft := 10;
  IWModalWindow1.WindowWidth := IWCambiarPassword.Width;
  IWModalWindow1.WindowHeight := IWCambiarPassword.Height;
  IWModalWindow1.OnAsyncClick := Asignar_Password;
  IWModalWindow1.SizeUnit := suPixel;
  IWModalWindow1.Show;
End;


Procedure TFrIWUsuario_Enc.Release_Me;
Begin
  Self.Release;
End;

Function TFrIWUsuario_Enc.Existe_Usuario(Const pCODIGO_USUARIO : String) : Boolean;
Begin
  Result := FCNX.Record_Exist(Info_TablaGet(Id_TBL_Usuario).Name, ['CODIGO_USUARIO'], [pCODIGO_USUARIO]);
End;

Procedure TFrIWUsuario_Enc.Validar_Campos_Master(pSender: TObject);
Var
  lMensaje: String;
Begin
  FQRMAESTRO.ERROR := 0;
  Try
    lMensaje := '';

    CODIGO_USUARIO.BGColor := UserSession.COLOR_OK;
    NOMBRE.BGColor := UserSession.COLOR_OK;
    CODIGO_PERFIL.BGColor := UserSession.COLOR_OK;
    CONTRASENA.BGColor := UserSession.COLOR_OK;

    If FQRMAESTRO.Mode_Insert Then
    Begin
      If Vacio(FQRMAESTRO.QR.FieldByName('CODIGO_USUARIO').AsString) Then
      Begin
        lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Usuario invalido';
        CODIGO_USUARIO.BGColor := UserSession.COLOR_ERROR;
      End
      Else
      Begin
        FQRMAESTRO.QR.FieldByName('CODIGO_USUARIO').AsString := Justificar(FQRMAESTRO.QR.FieldByName('CODIGO_USUARIO').AsString, ' ', FQRMAESTRO.QR.FieldByName('CODIGO_USUARIO').Size);
        FQRMAESTRO.QR.FieldByName('CODIGO_USUARIO').AsString := Copy(FQRMAESTRO.QR.FieldByName('CODIGO_USUARIO').AsString, 1, FQRMAESTRO.QR.FieldByName('CODIGO_USUARIO').Size);
        If FCNX.Record_Exist(Info_TablaGet(Id_TBL_Usuario).Name, ['CODIGO_USUARIO'], [FQRMAESTRO.QR.FieldByName('CODIGO_USUARIO').AsString]) Then
        Begin
          lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Usuario ya existente';
          CODIGO_USUARIO.BGColor := UserSession.COLOR_ERROR;
        End;
      End;
    End;

    If FQRMAESTRO.Mode_Edition And Vacio(FQRMAESTRO.QR.FieldByName('NOMBRE').AsString) Then
    Begin
      lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Nombre invalido';
      NOMBRE.BGColor := UserSession.COLOR_ERROR;
    End;

    If FQRMAESTRO.Mode_Edition And  Vacio(FQRMAESTRO.QR.FieldByName('CONTRASENA').AsString) Then
    Begin
      lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') +  'Contraseña invalido';
      CONTRASENA.BGColor := UserSession.COLOR_ERROR;
    End;

    If BTNCODIGO_PERFIL.Visible And  Vacio(FQRMAESTRO.QR.FieldByName('CODIGO_PERFIL').AsString) Then
    Begin
      lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') +  'Perfil invalido';
      CODIGO_PERFIL.BGColor := UserSession.COLOR_ERROR;
    End;

    FQRMAESTRO.ERROR := IfThen(Vacio(lMensaje), 0, -1);
    If FQRMAESTRO.ERROR <> 0 Then
    Begin
      FQRMAESTRO.LAST_ERROR := 'Datos invalidos, ' + lMensaje;
      UserSession.SetMessage(FQRMAESTRO.LAST_ERROR, True);
    End;
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWUsuario_Enc', 'TFrIWUsuario_Enc.Validar_Campos_Master', E.Message);
  End;
End;

Procedure TFrIWUsuario_Enc.Estado_Controles;
Begin
  CONTRASENA.Enabled            := False;
  CODIGO_USUARIO.Enabled        := FQRMAESTRO.Mode_Insert  And Documento_Activo;
  NOMBRE.Enabled                := FQRMAESTRO.Mode_Edition And Documento_Activo;
  DIRECCION.Enabled             := FQRMAESTRO.Mode_Edition And Documento_Activo;
  EMAIL.Enabled                 := FQRMAESTRO.Mode_Edition And Documento_Activo;
  TELEFONO_1.Enabled            := FQRMAESTRO.Mode_Edition And Documento_Activo;
  TELEFONO_2.Enabled            := FQRMAESTRO.Mode_Edition And Documento_Activo;
  ID_NOTIFICA_PRODUCTO.Enabled  := FQRMAESTRO.Mode_Edition And Documento_Activo;
  ID_ACTIVO.Enabled             := FQRMAESTRO.Mode_Edition And Documento_Activo;

  CONTRASENA.Editable           := False;
  CODIGO_USUARIO.Editable       := FQRMAESTRO.Mode_Insert  And Documento_Activo;
  NOMBRE.Editable               := FQRMAESTRO.Mode_Edition And Documento_Activo;
  DIRECCION.Editable            := FQRMAESTRO.Mode_Edition And Documento_Activo;
  EMAIL.Editable                := FQRMAESTRO.Mode_Edition And Documento_Activo;
  TELEFONO_1.Editable           := FQRMAESTRO.Mode_Edition And Documento_Activo;
  TELEFONO_2.Editable           := FQRMAESTRO.Mode_Edition And Documento_Activo;
  ID_NOTIFICA_PRODUCTO.Editable := FQRMAESTRO.Mode_Edition And Documento_Activo;
  ID_ACTIVO.Editable            := FQRMAESTRO.Mode_Edition And Documento_Activo;

  BTNCONTRASENA.Visible        := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNCODIGO_PERFIL.Visible     := FQRMAESTRO.Mode_Edition And Documento_Activo;

  IWRBOTONDETALLE.Visible      := FQRMAESTRO.ACTIVE And (Not FQRMAESTRO.Mode_Edition) And (FQRMAESTRO.QR.RecordCount > 0);
  DATO.Visible                 := (Not FQRMAESTRO.Mode_Edition);
  PAG_00.Visible               := (Not FQRMAESTRO.Mode_Edition);
  PAG_01.Visible               := True;
End;

Procedure TFrIWUsuario_Enc.SetLabel;
Begin
  If Not FQRMAESTRO.Active Then
    Exit;
  Try
    lbNombre_Perfil.Caption := FCNX.GetValue(Info_TablaGet(Id_TBL_Perfil).Name, ['CODIGO_PERFIL'], [FQRMAESTRO.QR.FieldByName('CODIGO_PERFIL').AsString], ['NOMBRE']);
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWUsuario_Enc', 'TFrIWUsuario_Enc.SetLabel', E.Message);
    End;
  End;
End;

Function TFrIWUsuario_Enc.Documento_Activo: Boolean;
Begin
  Try
    Result := True;
    // Result := (FQRMAESTRO.RecordCount >= 1) {And (Trim(FQRMAESTRO.FieldByName('ID_ANULADO').AsString) <> 'S')};
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWUsuario_Enc', 'TFrIWUsuario_Enc.Documento_Activo', E.Message);
    End;
  End;
End;

procedure TFrIWUsuario_Enc.DsDataChangeMaster(pSender: TObject);
begin

  FNAVEGADOR.UpdateState;
  If (Not FQRMAESTRO.Active)Then
    Exit;

  If FQRMAESTRO.Active Then
    lbInfo.Caption := FINFO + ' [ ' + FQRMAESTRO.QR.FieldByName('CODIGO_USUARIO').AsString + ', '+ FQRMAESTRO.QR.FieldByName('NOMBRE') .AsString + ' ] ';
  Self.Title := Info_TablaGet(Id_TBL_Usuario).Caption + ', ' + lbInfo.Caption;
  Self.Title := lbInfo.Caption;

  SetLabel;

  Try
    If (FCODIGO_ACTUAL <> FQRMAESTRO.QR.FieldByName('CODIGO_USUARIO').AsString) And (Not FQRMAESTRO.Mode_Edition) Then
    Begin
      FCODIGO_ACTUAL := FQRMAESTRO.QR.FieldByName('CODIGO_USUARIO').AsString;
      AbrirDetalle(Nil, Nil);
    End;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWUsuario_Enc', 'TFrIWUsuario_Enc.DsDataChangeMaster', E.Message);
    End;
  End;
end;

Procedure TFrIWUsuario_Enc.DsStateMaster(Sender: TObject);
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

Function TFrIWUsuario_Enc.AbrirMaestro(Const pDato: String = ''): Boolean;
Begin
  FGRID_MAESTRO.Caption := Info_TablaGet(Id_TBL_Usuario).Caption;
  Result := False;
  Try
    FQRMAESTRO.Active := False;
    FQRMAESTRO.WHERE    := '';
    FQRMAESTRO.SENTENCE := ' SELECT * FROM ' + Info_TablaGet(Id_TBL_Usuario).Name + FCNX.No_Lock;
    If Trim(pDato) <> '' Then
    Begin
      FQRMAESTRO.WHERE := ' WHERE CODIGO_USUARIO LIKE ' + QuotedStr('%' + Trim(pDato) + '%');
      FQRMAESTRO.WHERE := FQRMAESTRO.WHERE + ' OR NOMBRE LIKE ' + QuotedStr('%' + Trim(pDato) + '%');
    End;
    FQRMAESTRO.ORDER := ' ORDER BY CODIGO_USUARIO ';
    FQRMAESTRO.Active := True;
    Result := FQRMAESTRO.Active;
    If Result Then
    Begin
    End;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWUsuario_Enc', 'TFrIWUsuario_Enc.AbrirMaestro', E.Message);
    End;
  End;
  FGRID_MAESTRO.RefreshData;
End;

Procedure TFrIWUsuario_Enc.AbrirDetalle(Sender: TObject; EventParams: TStringList);
Begin
  GRID_DETALLE.Items.Clear;
  Try
    FCNX.TMP.Active := False;
    FCNX.TMP.SQL.Clear;
    FCNX.TMP.SQL.Add(' SELECT * FROM ' + Info_TablaGet(Id_TBL_Permiso_App).Name + FCNX.No_Lock);
    FCNX.TMP.SQL.Add(' WHERE CODIGO_PERFIL = ' + QuotedStr(FQRMAESTRO.QR.FieldByName('CODIGO_PERFIL').AsString));
    FCNX.TMP.SQL.Add(' ORDER BY NOMBRE ');
    FCNX.TMP.Active := True;
    If FCNX.TMP.Active Then
    Begin
      FCNX.TMP.First;
      While Not FCNX.TMP.Eof Do
      Begin
        GRID_DETALLE.Items.Add(Trim(FCNX.TMP.FieldByName('NOMBRE').AsString)+ ': ' + IfThen(FCNX.TMP.FieldByName('HABILITA_OPCION').AsString = 'S', 'Habilitado', 'Desactivado'));
        FCNX.TMP.Next;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWUsuario_Enc', 'TFrIWUsuario_Enc.AbrirDetalle', E.Message);
    End;
  End;
End;


constructor TFrIWUsuario_Enc.Create(AOwner: TComponent; Const pCodigo_Usuario : String);
begin
  Inherited Create(AOwner);
  Try
    Self.FCODIGO_USUARIO := pCodigo_Usuario ;
    If AbrirMaestro(FCODIGO_USUARIO) Then
    Begin
    End
    Else
      Release_Me
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWUsuario_Enc', 'TFrIWUsuario_Enc.IWAppFormCreate', E.Message);
    End;
  End;
end;

procedure TFrIWUsuario_Enc.IWAppFormCreate(Sender: TObject);
begin
  Randomize;
  Self.Name := 'TFrIWUsuario_Enc' + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now) + IntToStr(Random(1000));
  Self.Title := Info_TablaGet(Id_TBL_Usuario).Caption;
  FCNX := UserSession.CNX;
  FCODIGO_ACTUAL := '';
  FINFO := UserSession.FULL_INFO + Info_TablaGet(Id_TBL_Usuario).Caption;
  Try
    FGRID_MAESTRO        := TGRID_JQ.Create(PAG_00);
    FGRID_MAESTRO.Parent := PAG_00;
    FGRID_MAESTRO.Top    := 010;
    FGRID_MAESTRO.Left   := 010;
    FGRID_MAESTRO.Width  := 700;
    FGRID_MAESTRO.Height := 500;

    FQRMAESTRO := UserSession.Create_Manager_Data(Info_TablaGet(Id_TBL_Usuario).Name, Info_TablaGet(Id_TBL_Usuario).Caption);

    FQRMAESTRO.ON_NEW_RECORD   := NewRecordMaster;
    FQRMAESTRO.ON_DATA_CHANGE  := DsDataChangeMaster;
    FQRMAESTRO.ON_STATE_CHANGE := DsStateMaster;
    FQRMAESTRO.ON_BEFORE_POST  := Validar_Campos_Master;

    CODIGO_USUARIO.DataSource       := FQRMAESTRO.DS;
    NOMBRE.DataSource               := FQRMAESTRO.DS;
    DIRECCION.DataSource            := FQRMAESTRO.DS;
    EMAIL.DataSource                := FQRMAESTRO.DS;
    TELEFONO_1.DataSource           := FQRMAESTRO.DS;
    TELEFONO_2.DataSource           := FQRMAESTRO.DS;
    CONTRASENA.DataSource           := FQRMAESTRO.DS;
    CODIGO_PERFIL.DataSource        := FQRMAESTRO.DS;
    CODIGO_PERFIL.DataSource        := FQRMAESTRO.DS;
    ID_NOTIFICA_PRODUCTO.DataSource := FQRMAESTRO.DS;
    ID_ACTIVO.DataSource            := FQRMAESTRO.DS;

    FGRID_MAESTRO.SetGrid(FQRMAESTRO.DS, ['CODIGO_USUARIO', 'NOMBRE'     ],
                                         ['Usuario'       , 'Nombre'     ],
                                         ['S'             , 'N'          ],
                                         [100             , 550          ],
                                         [taRightJustify  , taLeftJustify]);


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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWUsuario_Enc', 'TFrIWUsuario_Enc.IWAppFormCreate', E.Message);
    End;
  End;
end;

procedure TFrIWUsuario_Enc.IWAppFormDestroy(Sender: TObject);
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWUsuario_Enc', 'TFrIWUsuario_Enc.IWAppFormDestroy', E.Message);
  End;
end;

procedure TFrIWUsuario_Enc.NewRecordMaster(pSender: TObject);
begin
  Inherited;
  Try
    FQRMAESTRO.QR.FieldByName('ID_ACTIVO').AsString := 'S';
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWUsuario_Enc', 'TFrIWUsuario_Enc.NewRecordMaster', E.Message);
    End;
  End;
end;

procedure TFrIWUsuario_Enc.BtnAcarreoAsyncClick(Sender: TObject;  EventParams: TStringList);
begin
  FQRMAESTRO.SetAcarreo(Not FQRMAESTRO.ACARREO, ['CODIGO_USUARIO'], [FQRMAESTRO.QR.FieldByName('CODIGO_USUARIO').AsString]);
end;

procedure TFrIWUsuario_Enc.BTNBACKAsyncClick(Sender: TObject;  EventParams: TStringList);
begin
  If FQRMAESTRO.Mode_Edition Then
    FQRMAESTRO.QR.Cancel;
  Release_Me;
end;

Procedure TFrIWUsuario_Enc.Localizar_Registro(Sender: TObject; EventParams: TStringList);
Begin
  Try
    AbrirMaestro(EventParams.Values['CODIGO_USUARIO']);
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWUsuario_Enc', 'TFrIWUsuario_Enc.Localizar_Registro', E.Message);
  End;
End;

procedure TFrIWUsuario_Enc.BTNBUSCARAsyncClick(Sender: TObject;  EventParams: TStringList);
begin
  Try
    If Vacio(DATO.Text) Then
    Begin
      Buscar_Info(Id_TBL_Usuario, Localizar_Registro);
    End
    Else
    Begin
      AbrirMaestro(DATO.Text);
    End;
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWUsuario_Enc', 'TFrIWAdm_Documento.BTNBUSCARAsyncClick', E.Message);
  End;
end;

procedure TFrIWUsuario_Enc.BTNCODIGO_PERFILAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Buscar_Info(Id_TBL_Perfil, Resultado_Perfil);
end;

procedure TFrIWUsuario_Enc.BTNCONTRASENAAsyncClick(Sender: TObject;  EventParams: TStringList);
begin
  Cambiar_Password;
end;

procedure TFrIWUsuario_Enc.BTNDIRECCIONAsyncClick(Sender: TObject; EventParams: TStringList);
Var
  ltmp : String;
begin

end;

procedure TFrIWUsuario_Enc.BtnGridAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  UserSession.ShowForm_Perfil_Enc(FQRMAESTRO.QR.FieldByName('CODIGO_PERFIL').AsString);
end;

end.
