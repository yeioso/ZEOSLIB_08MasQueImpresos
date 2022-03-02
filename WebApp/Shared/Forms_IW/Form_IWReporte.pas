unit Form_IWReporte;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, Vcl.Controls,
  Vcl.Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompButton, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls,
  Vcl.Imaging.pngimage, IWCompEdit, IWCompProgressIndicator, IWjQPageControl,
  IWCompLabel;

type
  TFrIWReporte = class(TIWAppForm)
    IWRegion_HEAD: TIWRegion;
    BTNBACK: TIWButton;
    IWModalWindow1: TIWModalWindow;
    IWProgressIndicator1: TIWProgressIndicator;
    PAGINAS: TIWjQPageControl;
    PAG00: TIWjQTabPage;
    PAG01: TIWjQTabPage;
    BTNCODIGO_PRODUCTO_INI: TIWImage;
    BTNCODIGO_PRODUCTO_FIN: TIWImage;
    CODIGO_PRODUCTO_INI: TIWEdit;
    CODIGO_PRODUCTO_FIN: TIWEdit;
    BTNGENERAR_INVENTARIO: TIWButton;
    CODIGO_AREA: TIWEdit;
    BTNCODIGO_AREA: TIWImage;
    BTNAREA: TIWButton;
    IWLabel1: TIWLabel;
    IWLabel2: TIWLabel;
    IWLabel3: TIWLabel;
    IWLabel4: TIWLabel;
    IWLabel5: TIWLabel;
    FECHA_INI: TIWEdit;
    FECHA_FIN: TIWEdit;
    ID_FECHA: TIWRadioGroup;
    IWLabel6: TIWLabel;
    PAG03: TIWjQTabPage;
    BTNOP: TIWImage;
    OP: TIWEdit;
    IWLabel7: TIWLabel;
    BTNCOMPARATIVO: TIWButton;
    procedure BTNBACKAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCODIGO_PRODUCTO_INIAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCODIGO_PRODUCTO_FINAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNGENERAR_INVENTARIOAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWAppFormCreate(Sender: TObject);
    procedure BTNCODIGO_AREAAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNAREAAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCOMPARATIVOAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure BTNOPAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    Procedure Resultado_Codigo_Producto_Ini(Sender: TObject; EventParams: TStringList);
    Procedure Resultado_Codigo_Producto_Fin(Sender: TObject; EventParams: TStringList);
    Procedure Resultado_Codigo_Area(Sender: TObject; EventParams: TStringList);
    Procedure Resultado_Orden_Produccion(Sender: TObject; EventParams: TStringList);
    procedure Buscar_Info(pSD : Integer; pEvent : TIWAsyncEvent);
  public
  end;

implementation
{$R *.dfm}
Uses
  UtFuncion,
  UtilsIW.Busqueda,
  ServerController,
  TBL000.Info_Tabla,
  UtilsIW.ManagerLog,
  Report.Consumo_Area,
  Report.Saldo_Inventario,
  Form_Plantilla_Documento,
  Report.Comparativo_OP_Inventario;

procedure TFrIWReporte.Buscar_Info(pSD : Integer; pEvent : TIWAsyncEvent);
Var
  lBusqueda : TBusqueda_MQI_WjQDBGrid;
begin
  Try
    lBusqueda := TBusqueda_MQI_WjQDBGrid.Create(Self);
    lBusqueda.Parent := Self;
    lBusqueda.SetComponents(UserSession.CNX, pEvent);
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
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWReporte', 'TFrIWReporte.Buscar_Info', E.Message);
  End;
End;

procedure TFrIWReporte.IWAppFormCreate(Sender: TObject);
begin
  Randomize;
  Self.Name := 'TFrIWReporte' + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now) + IntToStr(Random(1000) );
  Self.Title := 'Reportes';
  FECHA_INI.Text := FormatDateTime('YYYY-MM-DD', Now);
  FECHA_FIN.Text := FormatDateTime('YYYY-MM-DD', Now);
  IWProgressIndicator1.ProgressTextSettings.Text := LowerCase(UserSession.USER_NAME) + ', espera por favor..';
end;

procedure TFrIWReporte.BTNCODIGO_PRODUCTO_INIAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Buscar_Info(Id_TBL_Producto, Resultado_Codigo_Producto_Ini);
end;

procedure TFrIWReporte.BTNCOMPARATIVOAsyncClick(Sender: TObject; EventParams: TStringList);
Var
  lMsg : String;
begin
  If Vacio(OP.Text) Or (SetToInt(OP.Text) < 0) Then
  Begin
    UserSession.SetMessage('Debe elegir una orden de produccion', True);
    Exit;
  End;

  If Report_Comparativo_OP_Inventario_Reporte(UserSession.CNX, UserSession.DOCUMENTO_ORDEN_DE_PRODUCCION, SetToInt(OP.Text)) Then
    If Not Form_Plantilla_Reporte_Generico(UserSession.WebApplication, lMsg) Then
      UserSession.SetMessage(lMsg, True);
end;


procedure TFrIWReporte.BTNGENERAR_INVENTARIOAsyncClick(Sender: TObject; EventParams: TStringList);
Var
  lFin : String;
begin
  lFin := CODIGO_PRODUCTO_FIN.Text;
  If Vacio(lFin) Then
    lFin := Justificar('z', 'z', 20);
  If Report_Saldo_Inventario_Reporte(UserSession.CNX, CODIGO_PRODUCTO_INI.Text, lFin) Then
     If Not Form_Plantilla_Reporte_Generico(UserSession.WebApplication, lFin) Then
       UserSession.SetMessage(lFin, True);
end;

procedure TFrIWReporte.BTNOPAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Buscar_Info(Id_TBL_Orden_Produccion, Resultado_Orden_Produccion);
end;

procedure TFrIWReporte.BTNCODIGO_AREAAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Buscar_Info(Id_TBL_Area, Resultado_Codigo_Area);
end;

procedure TFrIWReporte.BTNCODIGO_PRODUCTO_FINAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Buscar_Info(Id_TBL_Producto, Resultado_Codigo_Producto_Fin);
end;

Procedure TFrIWReporte.Resultado_Codigo_Producto_Ini(Sender: TObject; EventParams: TStringList);
Begin
  Try
    CODIGO_PRODUCTO_INI.Text := EventParams.Values ['CODIGO_PRODUCTO'];
  Except
   On E: Exception Do
     Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWReporte', 'TFrIWReporte.Resultado_Codigo_Producto_Ini', E.Message);
  End;
End;

Procedure TFrIWReporte.Resultado_Codigo_Producto_Fin(Sender: TObject; EventParams: TStringList);
Begin
  Try
    CODIGO_PRODUCTO_FIN.Text := EventParams.Values ['CODIGO_PRODUCTO'];
  Except
   On E: Exception Do
     Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWReporte', 'TFrIWReporte.Resultado_Codigo_Producto_Fin', E.Message);
  End;
End;

Procedure TFrIWReporte.Resultado_Codigo_Area(Sender: TObject; EventParams: TStringList);
Begin
  Try
    CODIGO_AREA.Text := EventParams.Values ['CODIGO_AREA'];
  Except
   On E: Exception Do
     Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWReporte', 'TFrIWReporte.Resultado_Codigo_Area', E.Message);
  End;
End;

Procedure TFrIWReporte.Resultado_Orden_Produccion(Sender: TObject; EventParams: TStringList);
Begin
  Try
    OP.Text := EventParams.Values ['NUMERO'];
  Except
   On E: Exception Do
     Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWReporte', 'TFrIWReporte.Resultado_Orden_Produccion', E.Message);
  End;
End;


procedure TFrIWReporte.BTNAREAAsyncClick(Sender: TObject; EventParams: TStringList);
Var
  lMsg : String;
begin
  If Vacio(CODIGO_AREA.Text) Then
  Begin
    UserSession.SetMessage('Debe elegir una  area', True);
    Exit;
  End;

  If Report_Consumo_Area_Reporte(UserSession.CNX, CODIGO_AREA.Text, FECHA_INI.Text, FECHA_FIN.Text, ID_FECHA.ItemIndex) Then
    If Not Form_Plantilla_Reporte_Generico(UserSession.WebApplication, lMsg) Then
      UserSession.SetMessage(lMsg, True);
end;

procedure TFrIWReporte.BTNBACKAsyncClick(Sender: TObject; EventParams: TStringList);
Begin
  Self.Release;
End;

end.
