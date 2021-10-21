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
    IWLabel1: TIWLabel;
    IWLabel8: TIWLabel;
    DATO: TIWEdit;
    IWLabel2: TIWLabel;
    DESCRIPCION: TIWDBMemo;
    BTNNOMBRE: TIWImage;
    NOMBRE: TIWDBLabel;
    CODIGO_PRODUCTO: TIWDBLabel;
    BTNCODIGO: TIWImage;
    BTNDESCRIPCION: TIWImage;
    BTNACTIVO: TIWImage;
    lbNombre_Activo: TIWLabel;
    IWRegion_Navegador: TIWRegion;
    IWModalWindow1: TIWModalWindow;
    IWLabel11: TIWLabel;
    BTNSTOCK_MINIMO: TIWImage;
    STOCK_MINIMO: TIWDBLabel;
    IWLabel3: TIWLabel;
    BTNSTOCK_MAXIMO: TIWImage;
    STOCK_MAXIMO: TIWDBLabel;
    IWLabel4: TIWLabel;
    BTNVALOR_UNITARIO: TIWImage;
    VALOR_UNITARIO: TIWDBLabel;
    IWLabel5: TIWLabel;
    CODIGO_UNIDAD_MEDIDA: TIWDBLabel;
    IWLabel7: TIWLabel;
    BTNCODIGO_AREA: TIWImage;
    CODIGO_AREA: TIWDBLabel;
    BTNCREARAREA: TIWImage;
    lbNombre_Area: TIWLabel;
    BTNCODIGO_UNIDAD_MEDIDA: TIWImage;
    BTNCREARUNIDAD_MEDIDA: TIWImage;
    lbNombre_Unidad_Medida: TIWLabel;
    procedure BTNBACKAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure BTNBUSCARAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure CODIGO_ProductoAsyncExit(Sender: TObject;  EventParams: TStringList);
    procedure BtnAcarreoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCODIGOAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNNOMBREAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNDESCRIPCIONAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNACTIVOAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNSTOCK_MINIMOAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNUNIDAD_MEDIDAAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNSTOCK_MAXIMOAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNVALOR_UNITARIOAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCODIGO_AREAAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCREARAREAAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCODIGO_UNIDAD_MEDIDAAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure BTNCREARUNIDAD_MEDIDAAsyncClick(Sender: TObject;
      EventParams: TStringList);
  private
    FCNX : TConexion;
    FINFO : String;
    FQRMAESTRO : TMANAGER_DATA;
    FNAVEGADOR : TNavegador_ASE;
    FGRID_MAESTRO : TGRID_JQ;

    Procedure Resultado_Area(Sender: TObject; EventParams: TStringList);
    Procedure Resultado_Unidad_Medida(Sender: TObject; EventParams: TStringList);
    procedure Resultado_BasicData(Sender: TObject; EventParams: TStringList);
    procedure Mostrar_BasicData(Const pId : Integer; Const pTitle, pCaptionCode, pFieldCode, pCaptionName, pFieldName, pFieldDestiny : String; pResult : TIWAsyncEvent);
    Procedure Localizar_Registro(Sender: TObject; EventParams: TStringList);
    procedure Buscar_Info(pSD : Integer; pEvent : TIWAsyncEvent);
    Procedure Release_Me;

    Function Existe_Producto(Const pCODIGO_Producto : String) : Boolean;

    Procedure Validar_Campos_Master(pSender: TObject);
    procedure NewRecordMaster(pSender: TObject);

    procedure Resultado_Codigo(EventParams: TStringList);
    procedure Resultado_Nombre(EventParams: TStringList);
    procedure Resultado_Descripcion(EventParams: TStringList);
    procedure Resultado_Valor_Unitario(EventParams: TStringList);
    procedure Resultado_Stock_Minimo(EventParams: TStringList);
    procedure Resultado_Stock_Maximo(EventParams: TStringList);
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
  UtIWBasicData_ASE,
  TBL000.Info_Tabla,
  Process.Inventario;

Procedure TFrIWProducto.Resultado_Area(Sender: TObject; EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      FQRMAESTRO.QR.FieldByName('CODIGO_AREA').AsString := EventParams.Values ['CODIGO_AREA' ];
    End;
  Except
   On E: Exception Do
     UtLog_Execute('TFrIWProducto.Resultado_Area, ' + e.Message);
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
     UtLog_Execute('TFrIWProducto.Resultado_Unidad_Medida, ' + e.Message);
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
       End;
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWProducto.Resultado_BasicData, ' + e.Message);
  End;
End;

procedure TFrIWProducto.Mostrar_BasicData(Const pId : Integer; Const pTitle, pCaptionCode, pFieldCode, pCaptionName, pFieldName, pFieldDestiny : String; pResult : TIWAsyncEvent);
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
      UtLog_Execute('TFrIWProducto.Mostrar_BasicData, ' + e.Message);
  End;
End;

Procedure TFrIWProducto.Localizar_Registro(Sender: TObject; EventParams: TStringList);
Begin
  Try
    AbrirMaestro(EventParams.Values['CODIGO_PRODUCTO']);
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWProducto.Localizar_Registro, ' + e.Message);
  End;
End;

procedure TFrIWProducto.Buscar_Info(pSD : Integer; pEvent : TIWAsyncEvent);
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
      UtLog_Execute('TFrIWProducto.Buscar_Info, ' + e.Message);
  End;
End;

Procedure TFrIWProducto.Release_Me;
Begin
  Self.Release;
End;

Function TFrIWProducto.Existe_Producto(Const pCODIGO_Producto : String) : Boolean;
Begin
  Result := FCNX.Record_Exist(gInfo_Tablas[Id_TBL_Producto].Name, ['CODIGO_Producto'], [pCODIGO_Producto]);
End;

procedure TFrIWProducto.Resultado_Codigo(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
    Begin
      FQRMAESTRO.QR.FieldByName('CODIGO_Producto').AsString := Justificar(EventParams.Values['InputStr'], '0', FQRMAESTRO.QR.FieldByName('CODIGO_Producto').Size);
      FQRMAESTRO.QR.FieldByName('CODIGO_Producto').AsString := AnsiUpperCase(FQRMAESTRO.QR.FieldByName('CODIGO_Producto').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWProducto.Resultado_Codigo, ' + e.Message);
  End;
End;

procedure TFrIWProducto.Resultado_Nombre(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
    Begin
      FQRMAESTRO.QR.FieldByName('NOMBRE').AsString := AnsiUpperCase(Trim(EventParams.Values['InputStr']));
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWProducto.Resultado_Nombre, ' + e.Message);
  End;
End;

procedure TFrIWProducto.Resultado_Descripcion(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
    Begin
      FQRMAESTRO.QR.FieldByName('DESCRIPCION').AsString := AnsiUpperCase(Trim(EventParams.Values['InputStr']));
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWProducto.Resultado_Descripcion, ' + e.Message);
  End;
End;

procedure TFrIWProducto.Resultado_Valor_Unitario(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
    Begin
      FQRMAESTRO.QR.FieldByName('VALOR_UNITARIO').AsFloat := SetToFloat(EventParams.Values['InputStr']);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWProducto.Resultado_Valor_Unitario, ' + e.Message);
  End;
End;

procedure TFrIWProducto.Resultado_Stock_Minimo(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
    Begin
      FQRMAESTRO.QR.FieldByName('STOCK_MINIMO').AsFloat := SetToFloat(EventParams.Values['InputStr']);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWProducto.Resultado_Stock_Minimo, ' + e.Message);
  End;
End;

procedure TFrIWProducto.Resultado_Stock_Maximo(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition And (Result_Is_OK(EventParams.Values['RetValue'])) Then
    Begin
      FQRMAESTRO.QR.FieldByName('STOCK_MAXIMO').AsFloat := SetToFloat(EventParams.Values['InputStr']);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWProducto.Resultado_Stock_Maximo, ' + e.Message);
  End;
End;

procedure TFrIWProducto.Resultado_Activo(EventParams: TStringList);
Begin
  Try
    If FQRMAESTRO.Mode_Edition Then
      FQRMAESTRO.QR.FieldByName('ID_ACTIVO').AsString := IfThen(Result_Is_OK(EventParams.Values['RetValue']), 'S', 'N');
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWProducto.Resultado_Activo, ' + E.Message);
  End;
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
    CODIGO_Producto.BGColor := UserSession.COLOR_OK;

    If BTNCODIGO.Visible And (Vacio(FQRMAESTRO.QR.FieldByName('CODIGO_Producto').AsString) Or Existe_Producto(FQRMAESTRO.QR.FieldByName('CODIGO_Producto').AsString)) Then
    Begin
      lMensaje := lMensaje + IfThen(Not Vacio(lMensaje), ', ') + 'Codigo de producto no valido o ya existe';
      CODIGO_Producto.BGColor := UserSession.COLOR_ERROR;
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
      UtLog_Execute('TFrIWProducto_Enc.Validar_Campos_Master, ' + E.Message);
  End;
End;

procedure TFrIWProducto.CODIGO_ProductoAsyncExit(Sender: TObject;  EventParams: TStringList);
begin
  If FQRMAESTRO.Mode_Edition And (Not Vacio(FQRMAESTRO.QR.FieldByName('CODIGO_Producto').AsString)) Then
    FQRMAESTRO.QR.FieldByName('CODIGO_Producto').AsString := Justificar(FQRMAESTRO.QR.FieldByName('CODIGO_Producto').AsString, '0', FQRMAESTRO.QR.FieldByName('CODIGO_Producto').Size);
end;

Procedure TFrIWProducto.Estado_Controles;
Begin
  BTNCODIGO.Visible               := (FQRMAESTRO.DS.State In [dsInsert]) And Documento_Activo;
  BTNNOMBRE.Visible               := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNDESCRIPCION.Visible          := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNCODIGO_AREA.Visible          := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNCODIGO_UNIDAD_MEDIDA.Visible := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNVALOR_UNITARIO.Visible       := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNSTOCK_MINIMO.Visible         := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNSTOCK_MAXIMO.Visible         := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNACTIVO.Visible               := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNCREARAREA.Visible            := FQRMAESTRO.Mode_Edition And Documento_Activo;
  BTNCREARUNIDAD_MEDIDA.Visible   := FQRMAESTRO.Mode_Edition And Documento_Activo;
  DATO.Visible                    := (Not FQRMAESTRO.Mode_Edition);
  PAG_00.Visible                  := (Not FQRMAESTRO.Mode_Edition);
  PAG_01.Visible                  := True;
End;

Procedure TFrIWProducto.SetLabel;
Begin
  If Not FQRMAESTRO.Active Then
    Exit;
  Try
    lbNombre_Area.Caption := FCNX.GetValue(gInfo_Tablas[Id_TBL_Area].Name, ['CODIGO_AREA'], [FQRMAESTRO.QR.FieldByName('CODIGO_AREA').AsString], ['NOMBRE']);
    lbNombre_Unidad_Medida.Caption := FCNX.GetValue(gInfo_Tablas[Id_TBL_Unidad_Medida].Name, ['CODIGO_UNIDAD_MEDIDA'], [FQRMAESTRO.QR.FieldByName('CODIGO_UNIDAD_MEDIDA').AsString], ['NOMBRE']);
    lbNombre_Activo.Caption := IfThen(FQRMAESTRO.QR.FieldByName('ID_ACTIVO').AsString = 'S', 'Producto activa', 'Producto inactivo');
    lbNombre_Unidad_Medida.Caption := lbNombre_Unidad_Medida.Caption +  ', Existencia: ' + FormatFloat('###,###,##0.#0', Process_Inventario_Saldo(FQRMAESTRO.QR.FieldByName('CODIGO_PRODUCTO').AsString, -1, '', 0));
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWProducto.SetLabel, ' + E.Message);
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
      UtLog_Execute('TFrIWProducto.Documento_Activo, ' + E.Message);
    End;
  End;
End;

procedure TFrIWProducto.DsDataChangeMaster(pSender: TObject);
begin
  FNAVEGADOR.UpdateState;
  If (Not FQRMAESTRO.Active)Then
    Exit;

  If FQRMAESTRO.Active Then
    lbInfo.Caption := FINFO + ' [ ' + FQRMAESTRO.QR.FieldByName('CODIGO_Producto').AsString + ',' + FQRMAESTRO.QR.FieldByName('NOMBRE').AsString + ' ] ';

  SetLabel;
  Try
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWProducto.DsDataChangeMaster, ' + E.Message);
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
  FGRID_MAESTRO.Caption := gInfo_Tablas[Id_TBL_Producto].Caption;
  Result := False;
  Try
    FQRMAESTRO.Active := False;
    FQRMAESTRO.SENTENCE := ' SELECT ' + FCNX.Top_Sentence(Const_Max_Record) + ' * FROM ' + gInfo_Tablas[Id_TBL_Producto].Name + ' ';
    FQRMAESTRO.WHERE := '';
    If Trim(pDato) <> '' Then
    Begin
      FQRMAESTRO.WHERE := ' WHERE CODIGO_Producto LIKE ' + QuotedStr('%' + Trim(pDato) + '%') ;
      FQRMAESTRO.WHERE := FQRMAESTRO.WHERE + ' OR NOMBRE LIKE ' + QuotedStr('%' + Trim(pDato) + '%') ;
    End;
    FQRMAESTRO.ORDER := ' ORDER BY CODIGO_Producto ';
    FQRMAESTRO.Active := True;
    Result := FQRMAESTRO.Active;
    If Result Then
    Begin

    End;
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWProducto.AbrirMaestro, ' + E.Message);
    End;
  End;
  FGRID_MAESTRO.RefreshData;
End;

procedure TFrIWProducto.IWAppFormCreate(Sender: TObject);
Var
  lI : Integer;
begin
  FINFO := UserSession.FULL_INFO + gInfo_Tablas[Id_TBL_Producto].Caption;
  Randomize;
  Self.Name := gInfo_Tablas[Id_TBL_Producto].Name + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now) + IntToStr(Random(1000) );
  FCNX := UserSession.CNX;
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Codigo'        , Resultado_Codigo        );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Nombre'        , Resultado_Nombre        );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Descripcion'   , Resultado_Descripcion   );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Valor_Unitario', Resultado_Valor_Unitario);
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Stock_Minimo'  , Resultado_Stock_Minimo  );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Stock_Maximo'  , Resultado_Stock_Maximo  );
  WebApplication.RegisterCallBack(Self.Name + '.Resultado_Activo'        , Resultado_Activo        );
  Try
    FGRID_MAESTRO        := TGRID_JQ.Create(PAG_00);
    FGRID_MAESTRO.Parent := PAG_00;
    FGRID_MAESTRO.Top    := 010;
    FGRID_MAESTRO.Left   := 010;
    FGRID_MAESTRO.Width  := 700;
    FGRID_MAESTRO.Height := 500;

    FQRMAESTRO := UserSession.Create_Manager_Data(gInfo_Tablas[Id_TBL_Producto].Name, gInfo_Tablas[Id_TBL_Producto].Caption);

    FQRMAESTRO.ON_NEW_RECORD   := NewRecordMaster;
    FQRMAESTRO.ON_DATA_CHANGE  := DsDataChangeMaster;
    FQRMAESTRO.ON_BEFORE_POST  := Validar_Campos_Master;
    FQRMAESTRO.ON_STATE_CHANGE := DsStateMaster;

    CODIGO_Producto.DataSource      := FQRMAESTRO.DS;
    NOMBRE.DataSource               := FQRMAESTRO.DS;
    DESCRIPCION.DataSource          := FQRMAESTRO.DS;
    CODIGO_AREA.DataSource          := FQRMAESTRO.DS;
    CODIGO_UNIDAD_MEDIDA.DataSource := FQRMAESTRO.DS;
    VALOR_UNITARIO.DataSource       := FQRMAESTRO.DS;
    STOCK_MINIMO.DataSource         := FQRMAESTRO.DS;
    STOCK_MAXIMO.DataSource         := FQRMAESTRO.DS;

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
      UtLog_Execute('TFrIWProducto_Enc.IWAppFormCreate, ' + E.Message);
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
      UtLog_Execute('TFrIWProducto_Enc.IWAppFormDestroy, ' + e.Message);
  End;
end;

procedure TFrIWProducto.NewRecordMaster(pSender: TObject);
begin
  Inherited;
  Try
    FQRMAESTRO.QR.FieldByName('CODIGO_Producto').AsString := FCNX.Next(gInfo_Tablas[Id_TBL_Producto].Name, '0', ['CODIGO_Producto'], [],[], FQRMAESTRO.QR.FieldByName('CODIGO_Producto').Size);
    FQRMAESTRO.QR.FieldByName('ID_ACTIVO'  ).AsString := 'S';
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrIWProducto.NewRecordMaster, ' + E.Message);
    End;
  End;
End;

procedure TFrIWProducto.BtnAcarreoAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  FQRMAESTRO.SetAcarreo(Not FQRMAESTRO.ACARREO, ['CODIGO_Producto'], [FQRMAESTRO.QR.FieldByName('CODIGO_Producto').AsString]);
//  If Not FQRMAESTRO.ACARREO Then
//    BtnAcarreo.Caption := 'Acarreo Inactivo'
//  Else
//    BtnAcarreo.Caption := 'Acarreo Activo';
end;

procedure TFrIWProducto.BTNACTIVOAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  WebApplication.ShowConfirm('Está seguro(a) de activar el registro?', Self.Name + '.Resultado_Activo', 'Activar', 'Sí', 'No')
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
      UtLog_Execute('TFrIWTercero_Enc.BTNBUSCARAsyncClick, ' + e.Message);
  End;
//AbrirMaestro(DATO.Text);
end;

procedure TFrIWProducto.BTNCODIGOAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese el codigo del Producto', Self.Name + '.Resultado_Codigo', 'Producto', FQRMAESTRO.QR.FieldByName('CODIGO_Producto').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWProducto.BTNCODIGOAsyncClick, ' + e.Message);
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

procedure TFrIWProducto.BTNNOMBREAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese el nombre del Producto', Self.Name + '.Resultado_Nombre', 'Nombre', FQRMAESTRO.QR.FieldByName('NOMBRE').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWProducto.BTNNOMBREAsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWProducto.BTNDESCRIPCIONAsyncClick(Sender: TObject; EventParams: TStringList);
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
      UtLog_Execute('TFrIWProducto.BTNDESCRIPCIONAsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWProducto.BTNUNIDAD_MEDIDAAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese la unidad de medida', Self.Name + '.Resultado_Unidad_Medida', 'Unidad de Medida', FQRMAESTRO.QR.FieldByName('UNIDAD_MEDIDA').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWProducto.BTNUNIDAD_MEDIDAAsyncClick, ' + e.Message);
  End;
end;


procedure TFrIWProducto.BTNVALOR_UNITARIOAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese el valor unitario del producto', Self.Name + '.Resultado_Valor_Unitario', 'Stock Minimo', FQRMAESTRO.QR.FieldByName('VALOR_UNITARIO').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWProducto.BTNVALOR_UNITARIOAsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWProducto.BTNSTOCK_MINIMOAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese el stock minimo del Producto', Self.Name + '.Resultado_Stock_Minimo', 'Stock Minimo', FQRMAESTRO.QR.FieldByName('STOCK_MINIMO').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWProducto.BTNSTOCK_MINIMOAsyncClick, ' + e.Message);
  End;
end;

procedure TFrIWProducto.BTNSTOCK_MAXIMOAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Try
    If FQRMAESTRO.Mode_Edition Then
    Begin
      WebApplication.ShowPrompt('Ingrese el stock maximo del Producto', Self.Name + '.Resultado_Stock_Maximo', 'Stock Maximo', FQRMAESTRO.QR.FieldByName('STOCK_MAXIMO').AsString);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('TFrIWProducto.BTNSTOCK_MAXIMOAsyncClick, ' + e.Message);
  End;
end;



end.
