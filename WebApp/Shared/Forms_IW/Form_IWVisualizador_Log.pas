unit Form_IWVisualizador_Log;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes,
  Vcl.Imaging.pngimage, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompExtCtrls, Vcl.Controls, Vcl.Forms, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWCompLabel,
  IWCompButton, IWCompListbox, IWCompProgressIndicator, IWCompEdit, UtType,
  IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, UtConexion;

type
  TFrIWVisualizador_Log = class(TIWAppForm)
    RREGRESAR: TIWRegion;
    IMAGE_SALIR: TIWImage;
    ARCHIVOS: TIWListbox;
    IWLabel1: TIWLabel;
    IWLabel2: TIWLabel;
    DATO: TIWEdit;
    FECHA_INICIAL: TIWEdit;
    IWLabel3: TIWLabel;
    FECHA_FINAL: TIWEdit;
    IWProgressIndicator1: TIWProgressIndicator;
    BTNBUSCAR: TIWButton;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IMAGE_SALIRAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNBUSCARAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure ARCHIVOSAsyncDoubleClick(Sender: TObject;
      EventParams: TStringList);
  private
    FCNX : TConexion;
    Procedure Abrir_Archivo(Const pFilename : String);
    Procedure Buscar_Archivo(Const pPath, pDate : String; pDato : TStringList);
    Procedure Cargar_Directorios;
    Procedure Release_Me;
  public
  end;

implementation
{$R *.dfm}
Uses
  UtFuncion,
  IWAppCache,
  IWMimeTypes,
  System.IOUtils,
  IW.CacheStream,
  ServerController,
  UtilsIW.ManagerLog;

Procedure TFrIWVisualizador_Log.Abrir_Archivo(Const pFilename : String);
Var
  lF : String;
  lURL : String;
  lDestino : String;
Begin
  Try
    lF := pFilename;
    If FileExists(lF) Then
    Begin
      lDestino := TIWAppCache.NewTempFileName(ExtractFileName(lF)) ;
      If Not FileExists(lDestino) Then
        TFile.Copy(lF, lDestino);
      Sleep(500);
      If FileExists(lDestino) Then
      Begin
        lURL := TIWAppCache.AddFileToCache(WebApplication, lDestino, TIWMimeTypes.GetAsString(mtTXT), ctSession);
        WebApplication.NewWindow(lURL);
      End;
    End;
  Except
    On E : Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWVisualizador_Log', 'TFrIWVisualizador_Log.Abrir_Archivo', E.Message)
  End;
End;

Procedure TFrIWVisualizador_Log.Buscar_Archivo(Const pPath, pDate : String; pDato : TStringList);
Var
  lI : Integer;
  lJ : Integer;
  lPath : String;
  lItem : TData_Generic;
  lFile : TStringList;
  lExists : Boolean;
  lSearchRec : TSearchRec;
Begin
  Try
    lPath := IncludeTrailingBackslash(pPath + pDate);
    If System.SysUtils.FindFirst(lPath + '*.*', faAnyFile, lSearchRec) = 0 Then
    Begin
      lFile := TStringList.Create;
      Repeat
        If (lSearchRec.Attr And faArchive) >= faArchive Then
        Begin
          If FileExists(lPath + lSearchRec.Name) Then
          Begin
            lI := 0;
            lExists := False;
            lFile.LoadFromFile(lPath + lSearchRec.Name);
            While (lI < lFile.Count) And (Not lExists) Do
            Begin
              For lJ := 0 To pDato.Count-1 Do
                lExists := Pos(AnsiUpperCase(pDato[lJ]), AnsiUpperCase(lFile[lI])) > 0;
              Inc(lI);
            End;
            If lExists Then
            Begin
              lItem := TData_Generic.Create;
              lItem.Code := lPath + lSearchRec.Name;
              lItem.Name := pDate + ' - ' + lSearchRec.Name;
              ARCHIVOS.Items.AddObject(lItem.Name, lItem);
            End;
          End;
        End;
      Until FindNext(lSearchRec) <> 0;
      lFile.Clear;
      FreeAndNil(lFile);
    End;
  Except
    On E : Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWVisualizador_Log', 'TFrIWVisualizador_Log.Buscar_Archivo', E.Message)
  End;
End;

Procedure TFrIWVisualizador_Log.Cargar_Directorios;
Var
  lDato : TStringList;
  lPath : String;
  lFechaIni : String;
  lFechaFin : String;
  lSearchRec : TSearchRec;
Begin
  Try
    lDato := TStringList.Create;
    Desglosar_Texto_Caracter(DATO.Text, ';', lDato);
    lFechaIni := StringReplace(FECHA_INICIAL.Text, '-', '', [rfReplaceAll]);
    lFechaFin := StringReplace(FECHA_FINAL.Text  , '-', '', [rfReplaceAll]);
    lPath := IncludeTrailingBackslash(UserSession.PATH_LOG);
    If System.SysUtils.FindFirst(lPath + '*.*', faDirectory, lSearchRec) = 0 Then
    Begin
      Repeat
        If (lSearchRec.Attr And faDirectory) = faDirectory Then
        Begin
          If (Trim(lSearchRec.Name) <> '.') And (Trim(lSearchRec.Name) <> '..') Then
          Begin
            If (lSearchRec.Name >= lFechaIni) And (lSearchRec.Name <= lFechaFin) Then
              Buscar_Archivo(lPath, lSearchRec.Name, lDato);
          End;
        End;
      Until FindNext(lSearchRec) <> 0;
    End;
    System.SysUtils.FindClose(lSearchRec);
    lDato.Clear;
    FreeAndNil(lDato);
  Except
    On E : Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWVisualizador_Log', 'TFrIWVisualizador_Log.Cargar_Directorios', E.Message)
  End;
End;

procedure TFrIWVisualizador_Log.ARCHIVOSAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
Var
  lItem : TData_Generic;
Begin
  If ARCHIVOS.ItemIndex > -1 Then
  Begin
    If ARCHIVOS.Items.Objects[ARCHIVOS.ItemIndex] <> Nil Then
    Begin
      lItem := TData_Generic(ARCHIVOS.Items.Objects[ARCHIVOS.ItemIndex]);
      Abrir_Archivo(lItem.Code);
    End;
  End;
End;

Procedure TFrIWVisualizador_Log.BTNBUSCARAsyncClick(Sender: TObject; EventParams: TStringList);
Var
  lI : Integer;
Begin
  If Length(Trim(DATO.Text)) < 4 Then
  Begin
    UserSession.SetMessage('Debe ingresar una busqueda de mas 4 caracteres', True);
    Exit;
  End;
  Try
    For lI := 0 To ARCHIVOS.Items.Count-1 Do
      If ARCHIVOS.Items.Objects[lI] <> Nil Then
        ARCHIVOS.Items.Objects[lI].Free;
    ARCHIVOS.Items.Clear;
    Cargar_Directorios;
  Except
    On E : Exception Do
      Utils_ManagerLog_Add(UserSession.USER_CODE, 'Form_IWVisualizador_Log', 'TFrIWVisualizador_Log.BTNBUSCARAsyncClick', E.Message)
  End;
End;

procedure TFrIWVisualizador_Log.IMAGE_SALIRAsyncClick(Sender: TObject;  EventParams: TStringList);
begin
  Release_Me;
end;

procedure TFrIWVisualizador_Log.IWAppFormCreate(Sender: TObject);
begin
  Randomize;
  Self.Name := 'VISUALIZAR_LOG' + FormatDateTime('YYYYMMDDHHNNSSZZZ', Now) + IntToStr(Random(1000));
  FCNX := UserSession.CNX;
  FECHA_INICIAL.Text := FormatDateTime('YYYY-MM-DD', Now);
  FECHA_FINAL.Text   := FormatDateTime('YYYY-MM-DD', Now);
end;

Procedure TFrIWVisualizador_Log.Release_Me;
Begin
  Self.Release;
End;


end.
