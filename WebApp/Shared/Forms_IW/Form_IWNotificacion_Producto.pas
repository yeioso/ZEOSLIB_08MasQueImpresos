unit Form_IWNotificacion_Producto;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, Form_IWFrame,
  UtConexion, Generics.Collections, Vcl.Controls, Vcl.Forms, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWjQGrid, IWCompButton;

Type
  TProducto = Class
    Private
      FCODIGO_PRODUCTO : String;
      FFECHA_REGISTRO  : String;
      FHORA_REGISTRO   : String;
      FNOMBRE          : String;
      FCANTIDAD        : Double;
      FID_SELECCIONADO : String;
    Public
      Property CODIGO_PRODUCTO : String Read FCODIGO_PRODUCTO;
      Property FECHA_REGISTRO  : String Read FFECHA_REGISTRO ;
      Property HORA_REGISTRO   : String Read FHORA_REGISTRO  ;
      Property NOMBRE          : String Read FNOMBRE         ;
      Property CANTIDAD        : Double Read FCANTIDAD       ;
      Property ID_SELECCIONADO : String Read FID_SELECCIONADO;
  End;
  TProductos = TList<TProducto>;

  TFrIWNotificacion_Producto = class(TIWAppForm)
    IWRegion_Head: TIWRegion;
    IWRegion_Detalle: TIWRegion;
    IWjQGrid1: TIWjQGrid;
    BTNCERRAR: TIWButton;
    BTNGUARDAR: TIWButton;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure BTNCERRARAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWjQGrid1GetCellText(Sender: TObject; const Row, Col: Integer; var CellText: string);
    procedure IWjQGrid1SaveCell(Sender: TObject; const RowID: string; ACol: Integer; const AColName: string; var AValue: string; var ASave: Boolean; var AErrorMessage: string);
    procedure BTNGUARDARAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWAppFormShow(Sender: TObject);
  private
    FCNX : TConexion;
    FFRAME : TFrIWFrame;
    FProductos : TProductos;
    Procedure Load_Items;
    Procedure Restart;
    Procedure Confirmacion_Guardar(EventParams: TStringList);
  public
  end;

implementation
{$R *.dfm}

Uses
  UtFuncion,
  System.StrUtils,
  ServerController,
  TBL000.Info_Tabla,
  UtilsIW.ManagerLog;

Procedure TFrIWNotificacion_Producto.Confirmacion_Guardar(EventParams: TStringList);
Var
  lI : Integer;
begin
  // Confirm callback has 1 main parameters:
  // RetValue (Boolean), indicates if the first button (Yes/OK/custom) was choosen
  If Result_Is_OK(EventParams.Values['RetValue']) Then
  Begin
    Try
      For lI := 0 To FProductos.Count-1 Do
      Begin
        If FProductos[lI].ID_SELECCIONADO = 'S' Then
        Begin
          FCNX.TMP.Active := False;
          FCNX.TMP.SQL.Clear;
          FCNX.TMP.SQL.Add(' UPDATE ' + Info_TablaGet(Id_TBL_Notificacion_Producto).Name + ' ');
          FCNX.TMP.SQL.Add(' SET ');
          FCNX.TMP.SQL.Add('      ID_ACTIVO = ' + QuotedStr('N'));
          FCNX.TMP.SQL.Add('    , FECHA_CONFIRMADA = ' + QuotedStr(FormatDateTime('YYYY-MM-DD', Now)));
          FCNX.TMP.SQL.Add('    , HORA_CONFIRMADA = '  + QuotedStr(FormatDateTime('HH:NN:SS.Z', Now)));
          FCNX.TMP.SQL.Add(' WHERE ' + FCNX.Trim_Sentence('CODIGO_USUARIO') + ' = ' + QuotedStr(Trim(UserSession.USER_CODE)));
          FCNX.TMP.SQL.Add(' AND ' + FCNX.Trim_Sentence('CODIGO_PRODUCTO') + ' = ' + QuotedStr(Trim(FProductos[lI].CODIGO_PRODUCTO)));
          FCNX.TMP.SQL.Add(' AND ' + FCNX.Trim_Sentence('FECHA_REGISTRO') + ' = ' + QuotedStr(Trim(FProductos[lI].FECHA_REGISTRO)));
          FCNX.TMP.SQL.Add(' AND ' + FCNX.Trim_Sentence('HORA_REGISTRO') + ' = ' + QuotedStr(Trim(FProductos[lI].HORA_REGISTRO)));
          FCNX.TMP.ExecSQL;
          FCNX.TMP.Active := False;
          FCNX.TMP.SQL.Clear;
        End;
      End;
      UserSession.SetMessage('Registros confirmados', False);
      Load_Items;
    Except
      On E: Exception Do
        Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWNotificacion_Producto', 'TFrIWNotificacion_Producto.Confirmacion_Guardar', E.Message);
    End;
  End;
//  WebApplication.ShowNotification('This is the callback. ' + 'The selected button was: ' + SelectedButton, MsgType);
end;

Procedure TFrIWNotificacion_Producto.Load_Items;
Var
  lItem : TProducto;
Begin
  Restart;
  Try
    FCNX.TMP.Active := False;
    FCNX.TMP.SQL.Clear;
    FCNX.TMP.SQL.Add(' SELECT  ');
    FCNX.TMP.SQL.Add('         D.FECHA_REGISTRO ');
    FCNX.TMP.SQL.Add('        ,D.CODIGO_PRODUCTO ');
    FCNX.TMP.SQL.Add('        ,D.NOMBRE AS NOMBRE_ITEM ');
    FCNX.TMP.SQL.Add('        ,P.NOMBRE AS NOMBRE_PRODUCTO ');
    FCNX.TMP.SQL.Add('        ,D.FECHA_REGISTRO ');
    FCNX.TMP.SQL.Add('        ,D.HORA_REGISTRO ');
    FCNX.TMP.SQL.Add('        ,D.CANTIDAD ');
    FCNX.TMP.SQL.Add(' FROM ' + Info_TablaGet(Id_TBL_Notificacion_Producto).Name + ' D ');
    FCNX.TMP.SQL.Add(' INNER JOIN ' + Info_TablaGet(Id_TBL_Producto).Name + ' P ON D.CODIGO_PRODUCTO = P.CODIGO_PRODUCTO ');
    FCNX.TMP.SQL.Add(' WHERE D.ID_ACTIVO = ' + QuotedStr('S'));
    FCNX.TMP.SQL.Add(' AND ' + FCNX.Trim_Sentence('CODIGO_USUARIO') + ' = ' + QuotedStr(Trim(UserSession.USER_CODE)));
    FCNX.TMP.SQL.Add(' ORDER BY D.CODIGO_PRODUCTO, D.FECHA_REGISTRO DESC, D.HORA_REGISTRO DESC ');
    FCNX.TMP.Active := True;
    FCNX.TMP.First;
    While Not FCNX.TMP.Eof Do
    Begin
      lItem := TProducto.Create;
      lItem.FFECHA_REGISTRO  := FCNX.TMP.FieldByName('FECHA_REGISTRO' ).AsString;
      lItem.FHORA_REGISTRO   := FCNX.TMP.FieldByName('HORA_REGISTRO'  ).AsString;
      lItem.FCODIGO_PRODUCTO := FCNX.TMP.FieldByName('CODIGO_PRODUCTO').AsString;
      lItem.FNOMBRE          := Trim(FCNX.TMP.FieldByName('NOMBRE_PRODUCTO').AsString) + ', ' +
                                Trim(FCNX.TMP.FieldByName('NOMBRE_ITEM').AsString);
      lItem.FCANTIDAD        := FCNX.TMP.FieldByName('CANTIDAD').AsFloat;
      lItem.FID_SELECCIONADO       := 'N';
      FProductos.Add(lItem);
      FCNX.TMP.Next;
    End;
    FCNX.TMP.Active := False;
    FCNX.TMP.SQL.Clear;
    IWjQGrid1.RowCount := FProductos.Count;
    IWjQGrid1.RefreshData;
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWNotificacion_Producto', 'TFrIWNotificacion_Producto.Load_Items', E.Message);
  End;
End;

Procedure TFrIWNotificacion_Producto.Restart;
Var
  lItem : TProducto;
Begin
  Try
    For lItem In FProductos Do
      lItem.Free;
    FProductos.Clear;
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWNotificacion_Producto', 'TFrIWNotificacion_Producto.Restart', E.Message);
  End;
End;

procedure TFrIWNotificacion_Producto.BTNCERRARAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Self.Release;
end;

procedure TFrIWNotificacion_Producto.BTNGUARDARAsyncClick(Sender: TObject; EventParams: TStringList);
Var
  lI : Integer;
  lOk : Boolean;
begin
  lI := 0;
  lOk := False;
  While (lI <  FProductos.Count) And (Not lOk) Do
  Begin
    lOk := FProductos[lI].ID_SELECCIONADO = 'S';
    Inc(lI);
  End;
  If (Not lOk) Then
  Begin
    UserSession.SetMessage('Debe seleccionar al menos un registro', True);
    Exit;
  End;
  WebApplication.ShowConfirm('Está seguro(a) de confirmar los registros seleccionados?', Self.Name + '.Confirmacion_Guardar', 'Guardar', 'Sí', 'No')
end;

procedure TFrIWNotificacion_Producto.IWAppFormCreate(Sender: TObject);
begin
  Try
    Randomize;
    Self.Name := 'TFrIWNotificacion_Producto' + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now) + IntToStr(Random(1000));
    WebApplication.RegisterCallBack(Self.Name + '.Confirmacion_Guardar', Confirmacion_Guardar);
    FCNX := UserSession.CNX;
    Self.Title := Info_TablaGet(Id_TBL_Notificacion_Producto).Caption;
    FFRAME := TFrIWFrame.Create(Self);
    FFRAME.Parent := Self;
    FProductos := TProductos.Create;
    Load_Items;
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWNotificacion_Producto', 'TFrIWNotificacion_Producto.IWAppFormCreate', E.Message);
  End;
end;

procedure TFrIWNotificacion_Producto.IWAppFormDestroy(Sender: TObject);
begin
  Try
    If Assigned(FProductos) Then
    Begin
      Restart;
      FreeAndNil(FProductos);
    End;

    If Assigned(FFRAME) Then
      FreeAndNil(FFRAME);
  Except
    On E: Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWNotificacion_Producto', 'TFrIWNotificacion_Producto.IWAppFormDestroy', E.Message);
  End;
end;

procedure TFrIWNotificacion_Producto.IWAppFormShow(Sender: TObject);
begin
  If Assigned(FFRAME) Then
    FFRAME.Sincronizar_Informacion;
end;

procedure TFrIWNotificacion_Producto.IWjQGrid1GetCellText(Sender: TObject;
  const Row, Col: Integer; var CellText: string);
begin
  If (FProductos.Count > -1) And (Row < FProductos.Count) Then
  Begin
    Case Col Of
      0 : Begin
            CellText := FProductos[Row].CODIGO_PRODUCTO;
          End;
      1 : Begin
            CellText := FProductos[Row].NOMBRE;
          End;
      2 : Begin
            CellText := FProductos[Row].FECHA_REGISTRO;
          End;
      3 : Begin
            CellText := FProductos[Row].HORA_REGISTRO;
          End;
      4 : Begin
            CellText := FormatFloat('###,###,##0.#0', FProductos[Row].CANTIDAD);
          End;
      5 : Begin
            CellText := IfThen(FProductos[Row].FID_SELECCIONADO = 'S', 'Sí', 'No');
          End;
    End;
  End;
end;

procedure TFrIWNotificacion_Producto.IWjQGrid1SaveCell(Sender: TObject; const RowID: string; ACol: Integer; const AColName: string; var AValue: string; var ASave: Boolean; var AErrorMessage: string);
begin
  If (SetToInt(RowID) > -1) And (SetToInt(RowID) < FProductos.Count) And (ACol = 5) Then
  Begin
    FProductos[SetToInt(RowID)].FID_SELECCIONADO := Es_SI(AValue);
    AValue := IfThen(FProductos[SetToInt(RowID)].FID_SELECCIONADO = 'S', 'Sí', 'No');
  End;
end;

end.
