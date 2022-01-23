unit Form_IWTercero_Enc;

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
  TFrIWTercero_Enc = class(TIWAppForm)
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
    IWModalWindow1: TIWModalWindow;
    IWRegion_Navegador: TIWRegion;
    IWLabel6: TIWLabel;
    CODIGO_TERCERO: TIWDBEdit;
    NOMBRE: TIWDBEdit;
    CONTACTO: TIWDBEdit;
    DIRECCION: TIWDBEdit;
    EMAIL: TIWDBEdit;
    TELEFONO_1: TIWDBEdit;
    TELEFONO_2: TIWDBEdit;
    ID_CLIENTE: TIWDBCheckBox;
    ID_PROVEEDOR: TIWDBCheckBox;
    ID_ACTIVO: TIWDBCheckBox;
    procedure BTNBACKAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure BTNBUSCARAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BtnAcarreoAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    FCNX : TConexion;
    FINFO : String;
    FQRMAESTRO : TMANAGER_DATA;

    FNAVEGADOR : TNavegador_ASE;
    FGRID_MAESTRO : TGRID_JQ;

    FCODIGO_ACTUAL : String;

    Procedure Localizar_Registro(Sender: TObject; EventParams: TStringList);
    procedure Buscar_Info(pSD : Integer; pEvent : TIWAsyncEvent);


    Procedure Release_Me;

    Function Existe_Tercero(Const pCODIGO_TERCERO : String): Boolean;

    Procedure Validar_Campos_Master(pSender: TObject);
    Function Documento_Activo: Boolean;

    Procedure NewRecordMaster(pSender: TObject);
    Procedure DsDataChangeMaster(pSender: TObject);
    Procedure DsStateMaster(Sender: TObject);

    Procedure SetLabel;
    Procedure Estado_Controles;
    Function AbrirMaestro(Const pDato: String = ''): Boolean;
  public
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

procedure TFrIWTercero_Enc.Buscar_Info(pSD : Integer; pEvent : TIWAsyncEvent);
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWTercero_Enc', 'TFrIWTercero_Enc.Buscar_Info', E.Message);
  End;
End;

Procedure TFrIWTercero_Enc.Release_Me;
Begin
  Self.Release;
End;

Function TFrIWTercero_Enc.Existe_Tercero(Const pCODIGO_TERCERO : String) : Boolean;
Begin
  Result := FCNX.Record_Exist(Info_TablaGet(Id_TBL_Tercero).Name, ['CODIGO_TERCERO'], [pCODIGO_TERCERO]);
End;

Procedure TFrIWTercero_Enc.Validar_Campos_Master(pSender: TObject);
Var
  lMensaje: String;
Begin
  FQRMAESTRO.ERROR := 0;
  Try
    lMensaje := '';
    CODIGO_TERCERO.BGColor := UserSession.COLOR_OK;
    NOMBRE.BGColor := UserSession.COLOR_OK;
    CONTACTO.BGColor := UserSession.COLOR_OK;
    DIRECCION.BGColor := UserSession.COLOR_OK;
    TELEFONO_1.BGColor := UserSession.COLOR_OK;
    If FQRMAESTRO.Mode_Insert Then
    Begin
      If Vacio(FQRMAESTRO.QR.FieldByName('CODIGO_TERCERO').AsString) Then
      Begin
        lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Tercero invalido';
        CODIGO_TERCERO.BGColor := UserSession.COLOR_ERROR;
      End
      Else
      Begin
        FQRMAESTRO.QR.FieldByName('CODIGO_TERCERO').AsString := Justificar(FQRMAESTRO.QR.FieldByName('CODIGO_TERCERO').AsString, ' ', FQRMAESTRO.QR.FieldByName('CODIGO_TERCERO').Size);
        If FCNX.Record_Exist(Info_TablaGet(Id_TBL_Tercero).Name, ['CODIGO_TERCERO'], [FQRMAESTRO.QR.FieldByName('CODIGO_TERCERO').AsString]) Then
        Begin
          lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Tercero ya existente';
          CODIGO_TERCERO.BGColor := UserSession.COLOR_ERROR;
        End;
      End;
    End;

    If FQRMAESTRO.Mode_Edition Then
    Begin
      If Vacio(FQRMAESTRO.QR.FieldByName('NOMBRE').AsString) Then
      Begin
        lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Nombre invalido';
        NOMBRE.BGColor := UserSession.COLOR_ERROR;
      End;

      If Vacio(FQRMAESTRO.QR.FieldByName('CONTACTO').AsString) Then
      Begin
        lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Contacto invalido';
        CONTACTO.BGColor := UserSession.COLOR_ERROR;
      End;

      If Vacio(FQRMAESTRO.QR.FieldByName('DIRECCION').AsString) Then
      Begin
        lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Direccion invalida';
        DIRECCION.BGColor := UserSession.COLOR_ERROR;
      End;

      If Vacio(FQRMAESTRO.QR.FieldByName('TELEFONO_1').AsString) Then
      Begin
        lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Telefono invalido';
        TELEFONO_1.BGColor := UserSession.COLOR_ERROR;
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWTercero_Enc', 'TFrIWTercero_Enc.Validar_Campos_Master', E.Message);
  End;
End;

Procedure TFrIWTercero_Enc.Estado_Controles;
Begin
  CODIGO_TERCERO.Enabled  := FQRMAESTRO.Mode_Insert  And Documento_Activo;
  NOMBRE.Enabled          := FQRMAESTRO.Mode_Edition And Documento_Activo;
  CONTACTO.Enabled        := FQRMAESTRO.Mode_Edition And Documento_Activo;
  DIRECCION.Enabled       := FQRMAESTRO.Mode_Edition And Documento_Activo;
  EMAIL.Enabled           := FQRMAESTRO.Mode_Edition And Documento_Activo;
  TELEFONO_1.Enabled      := FQRMAESTRO.Mode_Edition And Documento_Activo;
  TELEFONO_2.Enabled      := FQRMAESTRO.Mode_Edition And Documento_Activo;
  ID_CLIENTE.Enabled      := FQRMAESTRO.Mode_Edition And Documento_Activo;
  ID_PROVEEDOR.Enabled    := FQRMAESTRO.Mode_Edition And Documento_Activo;
  ID_ACTIVO.Enabled       := FQRMAESTRO.Mode_Edition And Documento_Activo;

  CODIGO_TERCERO.Editable := FQRMAESTRO.Mode_Insert  And Documento_Activo;
  NOMBRE.Editable         := FQRMAESTRO.Mode_Edition And Documento_Activo;
  CONTACTO.Editable       := FQRMAESTRO.Mode_Edition And Documento_Activo;
  DIRECCION.Editable      := FQRMAESTRO.Mode_Edition And Documento_Activo;
  EMAIL.Editable          := FQRMAESTRO.Mode_Edition And Documento_Activo;
  TELEFONO_1.Editable     := FQRMAESTRO.Mode_Edition And Documento_Activo;
  TELEFONO_2.Editable     := FQRMAESTRO.Mode_Edition And Documento_Activo;
  ID_CLIENTE.Editable     := FQRMAESTRO.Mode_Edition And Documento_Activo;
  ID_PROVEEDOR.Editable   := FQRMAESTRO.Mode_Edition And Documento_Activo;
  ID_ACTIVO.Editable      := FQRMAESTRO.Mode_Edition And Documento_Activo;

  DATO.Visible           := (Not FQRMAESTRO.Mode_Edition);
  PAG_00.Visible         := (Not FQRMAESTRO.Mode_Edition);
  PAG_01.Visible         := True;
End;

Procedure TFrIWTercero_Enc.SetLabel;
Begin
  If Not FQRMAESTRO.Active Then
    Exit;
  Try
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWTercero_Enc', 'TFrIWTercero_Enc.SetLabel', E.Message);
    End;
  End;
End;

Function TFrIWTercero_Enc.Documento_Activo: Boolean;
Begin
  Try
    Result := True;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWTercero_Enc', 'TFrIWTercero_Enc.Documento_Activo', E.Message);
    End;
  End;
End;

procedure TFrIWTercero_Enc.DsDataChangeMaster(pSender: TObject);
begin

  FNAVEGADOR.UpdateState;
  If (Not FQRMAESTRO.Active)Then
    Exit;

  If FQRMAESTRO.Active Then
    lbInfo.Caption := FINFO + ' [ ' + FQRMAESTRO.QR.FieldByName('CODIGO_TERCERO').AsString + ', '+ FQRMAESTRO.QR.FieldByName('NOMBRE') .AsString + ' ] ';
  Self.Title := Info_TablaGet(Id_TBL_Tercero).Caption + ', ' + lbInfo.Caption;
  SetLabel;

  Try
    If (FCODIGO_ACTUAL <> FQRMAESTRO.QR.FieldByName('CODIGO_TERCERO').AsString) And (Not FQRMAESTRO.Mode_Edition) Then
    Begin
      FCODIGO_ACTUAL := FQRMAESTRO.QR.FieldByName('CODIGO_TERCERO').AsString;
    End;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWTercero_Enc', 'TFrIWTercero_Enc.DsDataChangeMaster', E.Message);
    End;
  End;
end;

Procedure TFrIWTercero_Enc.DsStateMaster(Sender: TObject);
Begin
  If Not FQRMAESTRO.Active Then
    Exit;

  Estado_Controles;
  If FQRMAESTRO.Mode_Edition Then
    PAGINAS.ActivePage := 1;
  Case FQRMAESTRO.QR.State Of
    dsInsert : Begin
//                 If CODIGO_TERCERO.Enabled Then
//                   CODIGO_TERCERO.SetFocus;
               End;
    dsEdit   : Begin
//                 If NOMBRE.Enabled Then
//                   NOMBRE.SetFocus;
               End;
  End;
End;

Function TFrIWTercero_Enc.AbrirMaestro(Const pDato: String = ''): Boolean;
Begin
  FGRID_MAESTRO.Caption := Info_TablaGet(Id_TBL_Tercero).Caption;
  Result := False;
  Try
    FQRMAESTRO.Active := False;
    FQRMAESTRO.WHERE    := '';
    FQRMAESTRO.SENTENCE := ' SELECT * FROM ' + Info_TablaGet(Id_TBL_Tercero).Name + FCNX.No_Lock;
    If Trim(pDato) <> '' Then
    Begin
      FQRMAESTRO.WHERE := ' WHERE CODIGO_TERCERO LIKE ' + QuotedStr('%' + Trim(pDato) + '%');
      FQRMAESTRO.WHERE := FQRMAESTRO.WHERE + ' OR NOMBRE LIKE ' + QuotedStr('%' + Trim(pDato) + '%');
    End;
    FQRMAESTRO.ORDER := ' ORDER BY CODIGO_TERCERO ';
    FQRMAESTRO.Active := True;
    Result := FQRMAESTRO.Active;
    If Result Then
    Begin
    End;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWTercero_Enc', 'TFrIWTercero_Enc.AbrirMaestro', E.Message);
    End;
  End;
  FGRID_MAESTRO.RefreshData;
End;

procedure TFrIWTercero_Enc.IWAppFormCreate(Sender: TObject);
begin
  Randomize;
  Self.Name := 'TFrIWTercero_Enc' + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now) + IntToStr(Random(1000));
  Self.Title := Info_TablaGet(Id_TBL_Tercero).Caption;
  FCNX := UserSession.CNX;
  FCODIGO_ACTUAL := '';
  FINFO := UserSession.FULL_INFO + Info_TablaGet(Id_TBL_Tercero).Caption;
  Try
    FGRID_MAESTRO        := TGRID_JQ.Create(PAG_00);
    FGRID_MAESTRO.Parent := PAG_00;
    FGRID_MAESTRO.Top    := 010;
    FGRID_MAESTRO.Left   := 010;
    FGRID_MAESTRO.Width  := 700;
    FGRID_MAESTRO.Height := 500;

    FQRMAESTRO := UserSession.Create_Manager_Data(Info_TablaGet(Id_TBL_Tercero).Name, Info_TablaGet(Id_TBL_Tercero).Caption);

    FQRMAESTRO.ON_NEW_RECORD   := NewRecordMaster;
    FQRMAESTRO.ON_DATA_CHANGE  := DsDataChangeMaster;
    FQRMAESTRO.ON_STATE_CHANGE := DsStateMaster;
    FQRMAESTRO.ON_BEFORE_POST  := Validar_Campos_Master;

    CODIGO_TERCERO.DataSource := FQRMAESTRO.DS;
    NOMBRE.DataSource         := FQRMAESTRO.DS;
    CONTACTO.DataSource       := FQRMAESTRO.DS;
    DIRECCION.DataSource      := FQRMAESTRO.DS;
    EMAIL.DataSource          := FQRMAESTRO.DS;
    TELEFONO_1.DataSource     := FQRMAESTRO.DS;
    TELEFONO_2.DataSource     := FQRMAESTRO.DS;
    ID_CLIENTE.DataSource     := FQRMAESTRO.DS;
    ID_PROVEEDOR.DataSource   := FQRMAESTRO.DS;
    ID_ACTIVO.DataSource      := FQRMAESTRO.DS;

    FGRID_MAESTRO.SetGrid(FQRMAESTRO.DS, ['CODIGO_TERCERO', 'NOMBRE'     ],
                                         ['Tercero'       , 'Nombre'     ],
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
    AbrirMaestro;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWTercero_Enc', 'TFrIWTercero_Enc.IWAppFormCreate', E.Message);
    End;
  End;
end;

procedure TFrIWTercero_Enc.IWAppFormDestroy(Sender: TObject);
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWTercero_Enc', 'TFrIWTercero_Enc.IWAppFormDestroy', E.Message);
  End;
end;

procedure TFrIWTercero_Enc.NewRecordMaster(pSender: TObject);
begin
  Inherited;
  Try
    FQRMAESTRO.QR.FieldByName('ID_ACTIVO').AsString := 'S';
    FQRMAESTRO.QR.FieldByName('ID_CLIENTE').AsString := 'S';
    FQRMAESTRO.QR.FieldByName('ID_PROVEEDOR').AsString := 'S';
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWTercero_Enc', 'TFrIWTercero_Enc.NewRecordMaster', E.Message);
    End;
  End;
end;

procedure TFrIWTercero_Enc.BtnAcarreoAsyncClick(Sender: TObject;  EventParams: TStringList);
begin
  FQRMAESTRO.SetAcarreo(Not FQRMAESTRO.ACARREO, ['CODIGO_TERCERO'], [FQRMAESTRO.QR.FieldByName('CODIGO_TERCERO').AsString]);
end;


procedure TFrIWTercero_Enc.BTNBACKAsyncClick(Sender: TObject;  EventParams: TStringList);
begin
  If FQRMAESTRO.Mode_Edition Then
    FQRMAESTRO.QR.Cancel;
  Release_Me;
end;

Procedure TFrIWTercero_Enc.Localizar_Registro(Sender: TObject; EventParams: TStringList);
Begin
  Try
    AbrirMaestro(EventParams.Values['CODIGO_TERCERO']);
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWTercero_Enc', 'TFrIWTercero_Enc.Localizar_Registro', E.Message);
  End;
End;

procedure TFrIWTercero_Enc.BTNBUSCARAsyncClick(Sender: TObject;  EventParams: TStringList);
begin
  Try
    If Vacio(DATO.Text) Then
    Begin
      Buscar_Info(Id_TBL_Tercero, Localizar_Registro);
    End
    Else
    Begin
      AbrirMaestro(DATO.Text);
    End;
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWTercero_Enc', 'TFrIWTercero_Enc.BTNBUSCARAsyncClick', E.Message);
  End;
end;

end.
