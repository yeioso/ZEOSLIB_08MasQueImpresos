unit Form_IWAdministrador_Documento;

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
  TFrIWAdministrador_Documento = class(TIWAppForm)
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
    IWLabel2: TIWLabel;
    DESCRIPCION: TIWDBMemo;
    BTNNOMBRE: TIWImage;
    NOMBRE: TIWDBLabel;
    BTNDESCRIPCION: TIWImage;
    BTNACTIVO: TIWImage;
    lbNombre_Activo: TIWLabel;
    IWRegion_Navegador: TIWRegion;
    IWModalWindow1: TIWModalWindow;
    CODIGO_DOCUMENTO: TIWDBComboBox;
    IWLabel3: TIWLabel;
    BTNINICIAL: TIWImage;
    DOCUMENTO_INICIAL: TIWDBLabel;
    IWLabel4: TIWLabel;
    BTNACTUAL: TIWImage;
    DOCUMENTO_ACTUAL: TIWDBLabel;
    IWLabel5: TIWLabel;
    BTNFINAL: TIWImage;
    DOCUMENTO_FINAL: TIWDBLabel;
    procedure BTNBACKAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure BTNBUSCARAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BtnAcarreoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNPREFIJOAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNNOMBREAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNDESCRIPCIONAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNACTIVOAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNINICIALAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNACTUALAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNFINALAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    FCNX : TConexion;
    FINFO : String;
    FQRMAESTRO : TMANAGER_DATA;
    FNAVEGADOR : TNavegador_ASE;
    FGRID_MAESTRO : TGRID_JQ;

    Procedure Localizar_Registro(Sender: TObject; EventParams: TStringList);
    procedure Buscar_Info(pSD : Integer; pEvent : TIWAsyncEvent);
    Procedure Release_Me;

    Function Existe_Codigo_Documento(Const pCODIGO_DOCUMENTO : String) : Boolean;

    Procedure Validar_Campos_Master(pSender: TObject);
    procedure NewRecordMaster(pSender: TObject);

    procedure Resultado_Codigo(EventParams: TStringList);
    procedure Resultado_Nombre(EventParams: TStringList);
    procedure Resultado_Documento_Inicial(EventParams: TStringList);
    procedure Resultado_Documento_Actual(EventParams: TStringList);
    procedure Resultado_Documento_Final(EventParams: TStringList);
    procedure Resultado_Descripcion(EventParams: TStringList);
    procedure Resultado_Activo(EventParams: TStringList);

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
  UtLog,
  UtFecha,
  Variants,
  UtFuncion,
  Vcl.Graphics,
  Winapi.Windows,
  System.UITypes,
  System.StrUtils,
  ServerController,
  TBL000.Info_Tabla;

Procedure TFrIWAdministrador_Documento.Localizar_Registro(Sender: TObject; EventParams: TStringList);
Begin
  Try
    AbrirMaestro(EventParams.Values['CODIGO_DOCUMENTO']);
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWAdministrador_Documento.Localizar_Registro, ' + e.Message);
  End;
End;

procedure TFrIWAdministrador_Documento.Buscar_Info(pSD : Integer; pEvent : TIWAsyncEvent);
Var
  lBusqueda : TBusqueda_Ercol_WjQDBGrid;
begin
  Try
    lBusqueda := TBusqueda_Ercol_WjQDBGrid.Create(Self);
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
      UtLog_Execute('TFrIWAdministrador_Documento.Buscar_Info, ' + e.Message);
  End;
End;

Procedure TFrIWAdministrador_Documento.Release_Me;
Begin
  Self.Release;
End;

Function TFrIWAdministrador_Documento.Existe_Codigo_Documento(Const pCODIGO_DOCUMENTO : String) : Boolean;
Begin
  Result := FCNX.Record_Exist(gInfo_Tablas[Id_TBL_Administrador_Documento].Name, ['CODIGO_DOCUMENTO'], [pCODIGO_DOCUMENTO]);
End;

procedure TFrIWAdministrador_Documento.Resultado_Codigo(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
    Begin
      FQRMAESTRO.QR.FieldByName('CODIGO_DOCUMENTO').AsString := Justificar(EventParams.Values['InputStr'], ' ', FQRMAESTRO.QR.FieldByName('CODIGO_DOCUMENTO').Size, 'D');
      FQRMAESTRO.QR.FieldByName('CODIGO_DOCUMENTO').AsString := AnsiUpperCase(FQRMAESTRO.QR.FieldByName('CODIGO_DOCUMENTO').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWAdministrador_Documento.Resultado_Codigo, ' + e.Message);
  End;
End;

procedure TFrIWAdministrador_Documento.Resultado_Nombre(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
    Begin
      FQRMAESTRO.QR.FieldByName('NOMBRE').AsString := AnsiUpperCase(Trim(EventParams.Values['InputStr']));
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWAdministrador_Documento.Resultado_Nombre, ' + e.Message);
  End;
End;

procedure TFrIWAdministrador_Documento.Resultado_Documento_Inicial(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
    Begin
      FQRMAESTRO.QR.FieldByName('DOCUMENTO_INICIAL').AsInteger := SetToInt(EventParams.Values['InputStr']);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWAdministrador_Documento.Resultado_Documento_Inicial, ' + e.Message);
  End;
End;

procedure TFrIWAdministrador_Documento.Resultado_Documento_Actual(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
    Begin
      FQRMAESTRO.QR.FieldByName('DOCUMENTO_ACTUAL').AsInteger := SetToInt(EventParams.Values['InputStr']);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWAdministrador_Documento.Resultado_Documento_Actual, ' + e.Message);
  End;
End;

procedure TFrIWAdministrador_Documento.Resultado_Documento_Final(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
    Begin
      FQRMAESTRO.QR.FieldByName('DOCUMENTO_FINAL').AsInteger := SetToInt(EventParams.Values['InputStr']);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWAdministrador_Documento.Resultado_Documento_Final, ' + e.Message);
  End;
End;

procedure TFrIWAdministrador_Documento.Resultado_Descripcion(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
    Begin
      FQRMAESTRO.QR.FieldByName('DESCRIPCION').AsString := AnsiUpperCase(Trim(EventParams.Values['InputStr']));
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWAdministrador_Documento.Resultado_Descripcion, ' + e.Message);
  End;
End;

procedure TFrIWAdministrador_Documento.Resultado_Activo(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition Then
      FQRMAESTRO.QR.FieldByName('ID_ACTIVO').AsString := IfThen(Result_Is_OK(EventParams.Values['RetValue']), 'S', 'N');
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWAdministrador_Documento.Resultado_Activo, ' + E.Message);
  End;
End;


Procedure TFrIWAdministrador_Documento.Validar_Campos_Master(pSender: TObject);
Var
  lMensaje : String;
Begin
  FQRMAESTRO.ERROR := 0;
  Try
    lMensaje := '';
    FQRMAESTRO.LAST_ERROR := '';
    NOMBRE.BGColor := UserSession.COLOR_OK;
    CODIGO_DOCUMENTO.BGColor := UserSession.COLOR_OK;

    If (FQRMAESTRO.DS.State In [dsInsert]) And (Vacio(FQRMAESTRO.QR.FieldByName('CODIGO_DOCUMENTO').AsString) Or Existe_Codigo_Documento(FQRMAESTRO.QR.FieldByName('CODIGO_DOCUMENTO').AsString)) Then
    Begin
      lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Codigo de documento no valido o ya existe';
      CODIGO_DOCUMENTO.BGColor := UserSession.COLOR_ERROR;
    End;

    If BTNNOMBRE.Visible And Vacio(FQRMAESTRO.QR.FieldByName('NOMBRE').AsString) Then
    Begin
      lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Nombre invalido';
      NOMBRE.BGColor := UserSession.COLOR_ERROR;
    End;

    FQRMAESTRO.ERROR := IfThen(Vacio(lMensaje), 0, -1);
    If FQRMAESTRO.ERROR <> 0 Then
    Begin
      FQRMAESTRO.LAST_ERROR := 'Datos invalidos, ' + lMensaje;
      UserSession.SetMessage(FQRMAESTRO.LAST_ERROR, True);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWAdministrador_Documento_Enc.Validar_Campos_Master, ' + E.Message);
  End;
End;


Procedure TFrIWAdministrador_Documento.Estado_Controles;
Begin
  CODIGO_DOCUMENTO.Enabled :=(FQRMAESTRO.DS.State In [dsInsert]) And Documento_Activo;
  BTNNOMBRE.Visible        := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNINICIAL.Visible       := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNACTUAL.Visible        := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNFINAL.Visible         := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNDESCRIPCION.Visible   := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNACTIVO.Visible        := FQRMAESTRO.Mode_Edition And Documento_Activo;
  DATO.Visible             := (Not FQRMAESTRO.Mode_Edition);
  PAG_00.Visible           := (Not FQRMAESTRO.Mode_Edition);
  PAG_01.Visible           := True;
End;

Procedure TFrIWAdministrador_Documento.SetLabel;
Begin
  If Not FQRMAESTRO.Active Then
    Exit;
  Try
    lbNombre_Activo.Caption := IfThen(FQRMAESTRO.QR.FieldByName('ID_ACTIVO').AsString = 'S', 'Documento activo', 'Documento inactivo');
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWAdministrador_Documento.SetLabel, ' + E.Message);
    End;
  End;
End;

Function TFrIWAdministrador_Documento.Documento_Activo : Boolean;
Begin
  Try
    Result := True;
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWAdministrador_Documento.Documento_Activo, ' + E.Message);
    End;
  End;
End;

procedure TFrIWAdministrador_Documento.DsDataChangeMaster(pSender: TObject);
begin
  FNAVEGADOR.UpdateState;
  If (Not FQRMAESTRO.Active)Then
    Exit;

  If FQRMAESTRO.Active Then
    lbInfo.Caption := FINFO + ' [ ' + FQRMAESTRO.QR.FieldByName('CODIGO_DOCUMENTO').AsString + ',' + FQRMAESTRO.QR.FieldByName('NOMBRE').AsString + ' ] ';

  SetLabel;
  Try
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWAdministrador_Documento.DsDataChangeMaster, ' + E.Message);
    End;
  End;
end;

Procedure TFrIWAdministrador_Documento.DsStateMaster(pSender: TObject);
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

Function TFrIWAdministrador_Documento.AbrirMaestro(Const pDato : String = '') : Boolean;
Begin
  FGRID_MAESTRO.Caption := gInfo_Tablas[Id_TBL_Administrador_Documento].Caption;
  Result := False;
  Try
    FQRMAESTRO.Active := False;
    FQRMAESTRO.SENTENCE := ' SELECT ' + FCNX.Top_Sentence(Const_Max_Record) + ' * FROM ' + gInfo_Tablas[Id_TBL_Administrador_Documento].Name + ' ';
    FQRMAESTRO.WHERE := '';
    If Trim(pDato) <> '' Then
    Begin
      FQRMAESTRO.WHERE := ' WHERE CODIGO_DOCUMENTO LIKE ' + QuotedStr('%' + Trim(pDato) + '%') ;
      FQRMAESTRO.WHERE := FQRMAESTRO.WHERE + ' OR NOMBRE LIKE ' + QuotedStr('%' + Trim(pDato) + '%') ;
    End;
    FQRMAESTRO.ORDER := ' ORDER BY CODIGO_DOCUMENTO ';
    FQRMAESTRO.Active := True;
    Result := FQRMAESTRO.Active;
    If Result Then
    Begin

    End;
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWAdministrador_Documento.AbrirMaestro, ' + E.Message);
    End;
  End;
  FGRID_MAESTRO.RefreshData;
End;

procedure TFrIWAdministrador_Documento.IWAppFormCreate(Sender: TObject);
Var
  lI : Integer;
begin
  Randomize;
  Self.Name := gInfo_Tablas[Id_TBL_Administrador_Documento].Name + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now) + IntToStr(Random(1000) );
  FINFO := UserSession.FULL_INFO + gInfo_Tablas[Id_TBL_Administrador_Documento].Caption;
  FCNX := UserSession.CNX;
  CODIGO_DOCUMENTO.Items.Add(UserSession.DOCUMENTO_ENTRADA_DE_INVENTARIO   );
  CODIGO_DOCUMENTO.Items.Add(UserSession.DOCUMENTO_SALIDA_DE_INVENTARIO    );
  CODIGO_DOCUMENTO.Items.Add(UserSession.DOCUMENTO_DEVOLUCION_AL_INVENTARIO);
  CODIGO_DOCUMENTO.Items.Add(UserSession.DOCUMENTO_ORDEN_DE_PRODUCCION     );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Codigo'           , Resultado_Codigo           );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Nombre'           , Resultado_Nombre           );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Documento_Inicial', Resultado_Documento_Inicial);
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Documento_Actual' , Resultado_Documento_Actual );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Documento_Final'  , Resultado_Documento_Final  );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Descripcion'      , Resultado_Descripcion      );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Activo'           , Resultado_Activo           );
  Try
    FGRID_MAESTRO        := TGRID_JQ.Create(PAG_00);
    FGRID_MAESTRO.Parent := PAG_00;
    FGRID_MAESTRO.Top    := 010;
    FGRID_MAESTRO.Left   := 010;
    FGRID_MAESTRO.Width  := 700;
    FGRID_MAESTRO.Height := 500;

    FQRMAESTRO := UserSession.Create_Manager_Data(gInfo_Tablas[Id_TBL_Administrador_Documento].Name, gInfo_Tablas[Id_TBL_Administrador_Documento].Caption);

    FQRMAESTRO.ON_NEW_RECORD   := NewRecordMaster;
    FQRMAESTRO.ON_DATA_CHANGE  := DsDataChangeMaster;
    FQRMAESTRO.ON_BEFORE_POST  := Validar_Campos_Master;
    FQRMAESTRO.ON_STATE_CHANGE := DsStateMaster;

    CODIGO_DOCUMENTO.DataSource  := FQRMAESTRO.DS;
    NOMBRE.DataSource            := FQRMAESTRO.DS;
    DOCUMENTO_INICIAL.DataSource := FQRMAESTRO.DS;
    DOCUMENTO_ACTUAL.DataSource  := FQRMAESTRO.DS;
    DOCUMENTO_FINAL.DataSource   := FQRMAESTRO.DS;
    DESCRIPCION.DataSource       := FQRMAESTRO.DS;

    FGRID_MAESTRO.SetGrid(FQRMAESTRO.DS, ['CODIGO_DOCUMENTO', 'NOMBRE'     ],
                                         ['Código'          , 'Nombre'     ],
                                         ['S'               , 'N'          ],
                                         [200               , 400          ],
                                         [taLeftJustify     , taLeftJustify]);

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
      UtLog_Execute('TFrIWAdministrador_Documento_Enc.IWAppFormCreate, ' + E.Message);
    End;
  End;
end;

procedure TFrIWAdministrador_Documento.IWAppFormDestroy(Sender: TObject);
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
      UtLog_Execute('TFrIWAdministrador_Documento_Enc.IWAppFormDestroy, ' + e.Message);
  End;
end;

procedure TFrIWAdministrador_Documento.BTNFINALAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese el documento final', Self.Name + '.Resultado_Documento_Final', 'Documento Final', FQRMAESTRO.QR.FieldByName('DOCUMENTO_FINAL').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWAdministrador_Documento.BTNFINALAsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWAdministrador_Documento.NewRecordMaster(pSender: TObject);
begin
  Inherited;
  Try
//  FQRMAESTRO.QR.FieldByName('CODIGO_DOCUMENTO').AsString := FCNX.Next(gInfo_Tablas[Id_TBL_Administrador_Documento].Name, '0', ['CODIGO_DOCUMENTO'], [],[], FQRMAESTRO.QR.FieldByName('CODIGO_DOCUMENTO').Size);
    FQRMAESTRO.QR.FieldByName('ID_ACTIVO'       ).AsString := 'S';
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWAdministrador_Documento.NewRecordMaster, ' + E.Message);
    End;
  End;
End;

procedure TFrIWAdministrador_Documento.BtnAcarreoAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  FQRMAESTRO.SetAcarreo(Not FQRMAESTRO.ACARREO, ['CODIGO_DOCUMENTO'], [FQRMAESTRO.QR.FieldByName('CODIGO_DOCUMENTO').AsString]);
//  If Not FQRMAESTRO.ACARREO Then
//    BtnAcarreo.Caption := 'Acarreo Inactivo'
//  Else
//    BtnAcarreo.Caption := 'Acarreo Activo';
end;

procedure TFrIWAdministrador_Documento.BTNACTIVOAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  WebApplication.ShowConfirm('Está seguro(a) de activar el registro?', Self.Name + '.Resultado_Activo', 'Activar', 'Sí', 'No')
end;

procedure TFrIWAdministrador_Documento.BTNACTUALAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese el documento actual', Self.Name + '.Resultado_Documento_Actual', 'Documento Actual', FQRMAESTRO.QR.FieldByName('DOCUMENTO_ACTUAL').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWAdministrador_Documento.BTNACTUALAsyncClick, ' + e.Message);
  End;
end;

Procedure TFrIWAdministrador_Documento.BTNBACKAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  If FQRMAESTRO.Mode_Edition  Then
    FQRMAESTRO.QR.Cancel;
  Release_Me;
end;

procedure TFrIWAdministrador_Documento.BTNBUSCARAsyncClick(Sender: TObject;  EventParams: TStringList);
begin
  Try
    If Vacio(DATO.Text) Then
    Begin
      Buscar_Info(Id_TBL_Administrador_Documento, Localizar_Registro)
    End
    Else
    Begin
      AbrirMaestro(DATO.Text);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWTercero_Enc.BTNBUSCARAsyncClick, ' + e.Message);
  End;
//AbrirMaestro(DATO.Text);
end;

procedure TFrIWAdministrador_Documento.BTNPREFIJOAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese el codigo del area', Self.Name + '.Resultado_Codigo', 'Area', FQRMAESTRO.QR.FieldByName('CODIGO_DOCUMENTO').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWAdministrador_Documento.BTNCODIGOAsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWAdministrador_Documento.BTNDESCRIPCIONAsyncClick(Sender: TObject; EventParams: TStringList);
Var
  ltmp : String;
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      ltmp := FQRMAESTRO.QR.FieldByName('DESCRIPCION').AsString;
      WebApplication.ShowPrompt('Ingrese la descripción', Self.Name + '.Resultado_Descripcion', 'Descripción', ltmp);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWAdministrador_Documento.BTNDESCRIPCIONAsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWAdministrador_Documento.BTNINICIALAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese el documento inicial', Self.Name + '.Resultado_Documento_Inicial', 'Documento Inicial', FQRMAESTRO.QR.FieldByName('DOCUMENTO_INICIAL').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWAdministrador_Documento.BTNINICIALAsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWAdministrador_Documento.BTNNOMBREAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese el nombre del area', Self.Name + '.Resultado_Nombre', 'Nombre', FQRMAESTRO.QR.FieldByName('NOMBRE').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWAdministrador_Documento.BTNNOMBREAsyncClick, ' + e.Message);
  End;
end;

end.
