unit Form_IWUnidad_Medida;

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
  UtilsIW.Busqueda, Form_IWFrame;

type
  TFrIWUnidad_Medida = class(TIWAppForm)
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
    IWRegion_Navegador: TIWRegion;
    IWModalWindow1: TIWModalWindow;
    CODIGO_UNIDAD_MEDIDA: TIWDBEdit;
    NOMBRE: TIWDBEdit;
    DESCRIPCION: TIWDBMemo;
    ID_ACTIVO: TIWDBCheckBox;
    procedure BTNBACKAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure BTNBUSCARAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BtnAcarreoAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    FCNX : TConexion;
    FINFO : String;
    FFRAME : TFrIWFrame;
    FQRMAESTRO : TMANAGER_DATA;
    FNAVEGADOR : TNavegador_ASE;
    FGRID_MAESTRO : TGRID_JQ;

    Procedure Localizar_Registro(Sender: TObject; EventParams: TStringList);
    procedure Buscar_Info(pSD : Integer; pEvent : TIWAsyncEvent);
    Procedure Release_Me;

    Function Existe_Unidad_Medida(Const pCODIGO_UNIDAD_MEDIDA : String) : Boolean;

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
  TBL000.Info_Tabla,
  UtilsIW.ManagerLog;

Procedure TFrIWUnidad_Medida.Localizar_Registro(Sender: TObject; EventParams: TStringList);
Begin
  Try
    AbrirMaestro(EventParams.Values['CODIGO_UNIDAD_MEDIDA']);
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWUnidad_Medida', 'TFrIWUnidad_Medida.Localizar_Registro', E.Message);
  End;
End;

procedure TFrIWUnidad_Medida.Buscar_Info(pSD : Integer; pEvent : TIWAsyncEvent);
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWUnidad_Medida', 'TFrIWUnidad_Medida.Buscar_Info', E.Message);
  End;
End;

Procedure TFrIWUnidad_Medida.Release_Me;
Begin
  Self.Release;
End;

Function TFrIWUnidad_Medida.Existe_Unidad_Medida(Const pCODIGO_UNIDAD_MEDIDA : String) : Boolean;
Begin
  Result := FCNX.Record_Exist(Info_TablaGet(Id_TBL_Unidad_Medida).Name, ['CODIGO_UNIDAD_MEDIDA'], [pCODIGO_UNIDAD_MEDIDA]);
End;


Procedure TFrIWUnidad_Medida.Validar_Campos_Master(pSender: TObject);
Var
  lMensaje : String;
Begin
  FQRMAESTRO.ERROR := 0;
  Try
    lMensaje := '';
    FQRMAESTRO.LAST_ERROR := '';
    NOMBRE.BGColor := UserSession.COLOR_OK;
    CODIGO_UNIDAD_MEDIDA.BGColor := UserSession.COLOR_OK;

    If FQRMAESTRO.Mode_Insert And (Not Vacio(FQRMAESTRO.QR.FieldByName('CODIGO_UNIDAD_MEDIDA').AsString)) Then
    Begin
      FQRMAESTRO.QR.FieldByName('CODIGO_UNIDAD_MEDIDA').AsString := Justificar(FQRMAESTRO.QR.FieldByName('CODIGO_UNIDAD_MEDIDA').AsString, '0', FQRMAESTRO.QR.FieldByName('CODIGO_UNIDAD_MEDIDA').Size);
      FQRMAESTRO.QR.FieldByName('CODIGO_UNIDAD_MEDIDA').AsString := Copy(FQRMAESTRO.QR.FieldByName('CODIGO_UNIDAD_MEDIDA').AsString, 1, FQRMAESTRO.QR.FieldByName('CODIGO_UNIDAD_MEDIDA').Size);
    End;
    If FQRMAESTRO.Mode_Insert And (Vacio(FQRMAESTRO.QR.FieldByName('CODIGO_UNIDAD_MEDIDA').AsString) Or Existe_Unidad_Medida(FQRMAESTRO.QR.FieldByName('CODIGO_UNIDAD_MEDIDA').AsString)) Then
    Begin
      lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Codigo de Unidad_Medida no valido o ya existe';
      CODIGO_UNIDAD_MEDIDA.BGColor := UserSession.COLOR_ERROR;
    End;

    If FQRMAESTRO.Mode_Edition And Vacio(FQRMAESTRO.QR.FieldByName('NOMBRE').AsString) Then
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWUnidad_Medida', 'TFrIWUnidad_Medida_Enc.Validar_Campos_Master', E.Message);
  End;
End;

Procedure TFrIWUnidad_Medida.Estado_Controles;
Begin
  CODIGO_UNIDAD_MEDIDA.Enabled := FQRMAESTRO.Mode_Insert  And Documento_Activo;
  NOMBRE.Enabled               := FQRMAESTRO.Mode_Edition And Documento_Activo;
  DESCRIPCION.Editable         := FQRMAESTRO.Mode_Edition And Documento_Activo;
  ID_ACTIVO.Enabled            := FQRMAESTRO.Mode_Edition And Documento_Activo;
  DATO.Visible                 := (Not FQRMAESTRO.Mode_Edition);
  PAG_00.Visible               := (Not FQRMAESTRO.Mode_Edition);
  PAG_01.Visible               := True;
End;

Procedure TFrIWUnidad_Medida.SetLabel;
Begin
  If Not FQRMAESTRO.Active Then
    Exit;
  Try
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWUnidad_Medida', 'TFrIWUnidad_Medida.SetLabel', E.Message);
    End;
  End;
End;

Function TFrIWUnidad_Medida.Documento_Activo : Boolean;
Begin
  Try
    Result := True;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWUnidad_Medida', 'TFrIWUnidad_Medida.Documento_Activo', E.Message);
    End;
  End;
End;

procedure TFrIWUnidad_Medida.DsDataChangeMaster(pSender: TObject);
begin
  FNAVEGADOR.UpdateState;
  If (Not FQRMAESTRO.Active)Then
    Exit;

  If FQRMAESTRO.Active Then
    lbInfo.Caption := FINFO + ' [ ' + FQRMAESTRO.QR.FieldByName('CODIGO_UNIDAD_MEDIDA').AsString + ',' + FQRMAESTRO.QR.FieldByName('NOMBRE').AsString + ' ] ';

  SetLabel;
  Try

  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWUnidad_Medida', 'TFrIWUnidad_Medida.DsDataChangeMaster', E.Message);
    End;
  End;
end;

Procedure TFrIWUnidad_Medida.DsStateMaster(pSender: TObject);
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

Function TFrIWUnidad_Medida.AbrirMaestro(Const pDato : String = '') : Boolean;
Begin
  FGRID_MAESTRO.Caption := Info_TablaGet(Id_TBL_Unidad_Medida).Caption;
  Result := False;
  Try
    FQRMAESTRO.Active := False;
    FQRMAESTRO.SENTENCE := ' SELECT ' + FCNX.Top_Sentence(Const_Max_Record) + ' * FROM ' + Info_TablaGet(Id_TBL_Unidad_Medida).Name + ' ';
    FQRMAESTRO.WHERE := '';
    If Trim(pDato) <> '' Then
    Begin
      FQRMAESTRO.WHERE := ' WHERE CODIGO_UNIDAD_MEDIDA LIKE ' + QuotedStr('%' + Trim(pDato) + '%') ;
      FQRMAESTRO.WHERE := FQRMAESTRO.WHERE + ' OR NOMBRE LIKE ' + QuotedStr('%' + Trim(pDato) + '%') ;
    End;
    FQRMAESTRO.ORDER := ' ORDER BY CODIGO_UNIDAD_MEDIDA ';
    FQRMAESTRO.Active := True;
    Result := FQRMAESTRO.Active;
    If Result Then
    Begin

    End;
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWUnidad_Medida', 'TFrIWUnidad_Medida.AbrirMaestro', E.Message);
    End;
  End;
  FGRID_MAESTRO.RefreshData;
End;

procedure TFrIWUnidad_Medida.IWAppFormCreate(Sender: TObject);
Var
  lI : Integer;
begin
  FINFO := UserSession.FULL_INFO + Info_TablaGet(Id_TBL_Unidad_Medida).Caption;
  Randomize;
  Self.Name := 'TFrIWUnidad_Medida' + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now) + IntToStr(Random(1000) );
  FCNX := UserSession.CNX;
  FFRAME := TFrIWFrame.Create(Self);
  FFRAME.Parent := Self;
  Try
    FGRID_MAESTRO        := TGRID_JQ.Create(PAG_00);
    FGRID_MAESTRO.Parent := PAG_00;
    FGRID_MAESTRO.Top    := 010;
    FGRID_MAESTRO.Left   := 010;
    FGRID_MAESTRO.Width  := 700;
    FGRID_MAESTRO.Height := 500;


    FQRMAESTRO := UserSession.Create_Manager_Data(Info_TablaGet(Id_TBL_Unidad_Medida).Name, Info_TablaGet(Id_TBL_Unidad_Medida).Caption);

    FQRMAESTRO.ON_NEW_RECORD   := NewRecordMaster;
    FQRMAESTRO.ON_DATA_CHANGE  := DsDataChangeMaster;
    FQRMAESTRO.ON_BEFORE_POST  := Validar_Campos_Master;
    FQRMAESTRO.ON_STATE_CHANGE := DsStateMaster;

    CODIGO_UNIDAD_MEDIDA.DataSource := FQRMAESTRO.DS;
    NOMBRE.DataSource               := FQRMAESTRO.DS;
    DESCRIPCION.DataSource          := FQRMAESTRO.DS;
    ID_ACTIVO.DataSource            := FQRMAESTRO.DS;

    FGRID_MAESTRO.SetGrid(FQRMAESTRO.DS, ['CODIGO_UNIDAD_MEDIDA' , 'NOMBRE'     ],
                                         ['Código'      , 'Nombre'     ],
                                         ['S'           , 'N'          ],
                                         [100           , 550          ],
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWUnidad_Medida', 'TFrIWUnidad_Medida_Enc.IWAppFormCreate', E.Message);
    End;
  End;
end;

procedure TFrIWUnidad_Medida.IWAppFormDestroy(Sender: TObject);
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

    If Assigned(FFRAME) Then
      FreeAndNil(FFRAME);

  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWUnidad_Medida', 'TFrIWUnidad_Medida_Enc.IWAppFormDestroy', E.Message);
  End;
end;

procedure TFrIWUnidad_Medida.NewRecordMaster(pSender: TObject);
begin
  Inherited;
  Try
    FQRMAESTRO.QR.FieldByName('CODIGO_UNIDAD_MEDIDA').AsString := FCNX.Next(Info_TablaGet(Id_TBL_Unidad_Medida).Name, '0', ['CODIGO_UNIDAD_MEDIDA'], [],[], FQRMAESTRO.QR.FieldByName('CODIGO_UNIDAD_MEDIDA').Size);
    FQRMAESTRO.QR.FieldByName('ID_ACTIVO'           ).AsString := 'S';
  Except
    On E: Exception Do
    Begin
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWUnidad_Medida', 'TFrIWUnidad_Medida.NewRecordMaster', E.Message);
    End;
  End;
End;

procedure TFrIWUnidad_Medida.BtnAcarreoAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  FQRMAESTRO.SetAcarreo(Not FQRMAESTRO.ACARREO, ['CODIGO_UNIDAD_MEDIDA'], [FQRMAESTRO.QR.FieldByName('CODIGO_UNIDAD_MEDIDA').AsString]);
end;

Procedure TFrIWUnidad_Medida.BTNBACKAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  If FQRMAESTRO.Mode_Edition  Then
    FQRMAESTRO.QR.Cancel;
  Release_Me;
end;

procedure TFrIWUnidad_Medida.BTNBUSCARAsyncClick(Sender: TObject;  EventParams: TStringList);
begin
  Try
    If Vacio(DATO.Text) Then
    Begin
      Buscar_Info(Id_TBL_Unidad_Medida, Localizar_Registro)
    End
    Else
    Begin
      AbrirMaestro(DATO.Text);
    End;
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWUnidad_Medida', 'TFrIWUnidad_Medida.BTNBUSCARAsyncClick', E.Message);
  End;
end;

end.
