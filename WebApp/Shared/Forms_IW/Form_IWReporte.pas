unit Form_IWReporte;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, Vcl.Controls,
  Vcl.Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompButton, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls,
  Vcl.Imaging.pngimage, IWCompEdit, IWCompProgressIndicator, IWjQPageControl,
  IWCompLabel, IWCompListbox;

type
  TFrIWReporte = class(TIWAppForm)
    IWRegion_HEAD: TIWRegion;
    BTNBACK: TIWButton;
    IWModalWindow1: TIWModalWindow;
    IWProgressIndicator1: TIWProgressIndicator;
    REPORTE: TIWComboBox;
    IWLabel8: TIWLabel;
    IWRegion_Captura: TIWRegion;
    BTNCODIGO_PRODUCTO_INI: TIWImage;
    BTNCODIGO_PRODUCTO_FIN: TIWImage;
    CODIGO_PRODUCTO_INI: TIWEdit;
    CODIGO_PRODUCTO_FIN: TIWEdit;
    BTNGENERAR: TIWButton;
    lbProducto_Inicial: TIWLabel;
    lbProducto_Final: TIWLabel;
    CODIGO_AREA: TIWEdit;
    BTNCODIGO_AREA: TIWImage;
    lbCODIGO_AREA: TIWLabel;
    BTNCODIGO_OP: TIWImage;
    CODIGO_OP: TIWEdit;
    lbOP: TIWLabel;
    lbCODIGO_PROYECTO: TIWLabel;
    CODIGO_PROYECTO: TIWEdit;
    BTNCODIGO_PROYECTO: TIWImage;
    lbFecha_Inicial: TIWLabel;
    lbFecha_Final: TIWLabel;
    FECHA_INI: TIWEdit;
    FECHA_FIN: TIWEdit;
    ID_FECHA: TIWRadioGroup;
    procedure BTNBACKAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCODIGO_PRODUCTO_INIAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCODIGO_PRODUCTO_FINAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNGENERARAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWAppFormCreate(Sender: TObject);
    procedure BTNCODIGO_AREAAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCODIGO_OPAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure REPORTEAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure BTNCODIGO_PROYECTOAsyncClick(Sender: TObject;
      EventParams: TStringList);
  private
    Procedure SetVisibleControls;
    Procedure Resultado_Codigo_Producto_Ini(Sender: TObject; EventParams: TStringList);
    Procedure Resultado_Codigo_Producto_Fin(Sender: TObject; EventParams: TStringList);
    Procedure Resultado_Codigo_Area(Sender: TObject; EventParams: TStringList);
    Procedure Resultado_Orden_Produccion(Sender: TObject; EventParams: TStringList);
    Procedure Resultado_Codigo_Proyecto(Sender: TObject; EventParams: TStringList);
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
  Report.Areas_x_Proyecto,
  Form_Plantilla_Documento,
  Report.Comparativo_OP_Inventario;

Procedure TFrIWReporte.SetVisibleControls;
Begin
  lbProducto_Inicial.Visible     := REPORTE.ItemIndex In [00];
  lbProducto_Final.Visible       := REPORTE.ItemIndex In [00];
  BTNCODIGO_PRODUCTO_INI.Visible := REPORTE.ItemIndex In [00];
  BTNCODIGO_PRODUCTO_FIN.Visible := REPORTE.ItemIndex In [00];
  CODIGO_PRODUCTO_INI.Visible    := REPORTE.ItemIndex In [00];
  CODIGO_PRODUCTO_FIN.Visible    := REPORTE.ItemIndex In [00];

  lbCODIGO_AREA.Visible          := REPORTE.ItemIndex In [01];
  CODIGO_AREA.Visible            := REPORTE.ItemIndex In [01];
  BTNCODIGO_AREA.Visible         := REPORTE.ItemIndex In [01];

  lbOP.Visible                   := REPORTE.ItemIndex In [02];
  CODIGO_OP.Visible              := REPORTE.ItemIndex In [02];
  BTNCODIGO_OP.Visible           := REPORTE.ItemIndex In [02];

  lbCODIGO_PROYECTO.Visible      := REPORTE.ItemIndex In [03];
  CODIGO_PROYECTO.Visible        := REPORTE.ItemIndex In [03];
  BTNCODIGO_PROYECTO.Visible     := REPORTE.ItemIndex In [03];

  lbFecha_Inicial.Visible        := REPORTE.ItemIndex In [01, 03];
  lbFecha_Final.Visible          := REPORTE.ItemIndex In [01, 03];
  FECHA_INI.Visible              := REPORTE.ItemIndex In [01, 03];
  FECHA_FIN.Visible              := REPORTE.ItemIndex In [01, 03];
  ID_FECHA.Visible               := REPORTE.ItemIndex In [01, 03];

  BTNGENERAR.Visible             := REPORTE.ItemIndex In [00..REPORTE.Items.Count-1];
End;

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
  SetVisibleControls;
end;

procedure TFrIWReporte.BTNCODIGO_PRODUCTO_INIAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Buscar_Info(Id_TBL_Producto, Resultado_Codigo_Producto_Ini);
end;

procedure TFrIWReporte.BTNCODIGO_PROYECTOAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Buscar_Info(Id_TBL_Proyecto, Resultado_Codigo_Proyecto);
end;

procedure TFrIWReporte.BTNGENERARAsyncClick(Sender: TObject; EventParams: TStringList);
Var
  lMsg : String;
begin
  Case REPORTE.ItemIndex Of
    00 : Begin
           lMsg := CODIGO_PRODUCTO_FIN.Text;
           If Vacio(lMsg) Then
             lMsg := Justificar('z', 'z', 20);
           If Report_Saldo_Inventario_Reporte(UserSession.CNX, CODIGO_PRODUCTO_INI.Text, lMsg) Then
             If Not Form_Plantilla_Reporte_Generico(UserSession.WebApplication, lMsg) Then
               UserSession.SetMessage(lMsg, True);
         End;
    01 : Begin
           If Vacio(CODIGO_AREA.Text) Then
           Begin
             UserSession.SetMessage('Debe elegir una  area', True);
             Exit;
           End;

           If Report_Consumo_Area_Reporte(UserSession.CNX, CODIGO_AREA.Text, FECHA_INI.Text, FECHA_FIN.Text, ID_FECHA.ItemIndex) Then
             If Not Form_Plantilla_Reporte_Generico(UserSession.WebApplication, lMsg) Then
               UserSession.SetMessage(lMsg, True);
         End;
    02 : Begin
           If Vacio(CODIGO_OP.Text) Or (SetToInt(CODIGO_OP.Text) < 0) Then
           Begin
             UserSession.SetMessage('Debe elegir una orden de produccion', True);
             Exit;
           End;

           If Report_Comparativo_OP_Inventario_Reporte(UserSession.CNX, UserSession.DOCUMENTO_ORDEN_DE_PRODUCCION, SetToInt(CODIGO_OP.Text)) Then
             If Not Form_Plantilla_Reporte_Generico(UserSession.WebApplication, lMsg) Then
               UserSession.SetMessage(lMsg, True);
         End;
    03 : Begin
           If Vacio(CODIGO_PROYECTO.Text) Then
           Begin
             UserSession.SetMessage('Debe elegir un proyecto', True);
             Exit;
           End;
           If Report_Areas_x_Proyecto_Reporte(UserSession.CNX, CODIGO_PROYECTO.Text, FECHA_INI.Text, FECHA_FIN.Text, ID_FECHA.ItemIndex) Then
             If Not Form_Plantilla_Reporte_Generico(UserSession.WebApplication, lMsg) Then
               UserSession.SetMessage(lMsg, True);
         End;
  End;

end;

procedure TFrIWReporte.BTNCODIGO_OPAsyncClick(Sender: TObject; EventParams: TStringList);
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

procedure TFrIWReporte.REPORTEAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  SetVisibleControls;
end;

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
    CODIGO_OP.Text := EventParams.Values ['NUMERO'];
  Except
   On E: Exception Do
     Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWReporte', 'TFrIWReporte.Resultado_Orden_Produccion', E.Message);
  End;
End;

Procedure TFrIWReporte.Resultado_Codigo_Proyecto(Sender: TObject; EventParams: TStringList);
Begin
  Try
    CODIGO_PROYECTO.Text := EventParams.Values ['CODIGO_PROYECTO'];
  Except
   On E: Exception Do
     Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWReporte', 'TFrIWReporte.Resultado_Codigo_Proyecto', E.Message);
  End;
End;

procedure TFrIWReporte.BTNBACKAsyncClick(Sender: TObject; EventParams: TStringList);
Begin
  Self.Release;
End;

end.
