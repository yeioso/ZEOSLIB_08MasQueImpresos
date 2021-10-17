unit Form_Plantilla_Documento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, PReport,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, PRJpegImage, PdfDoc, Generics.Collections,
  UtPowerPDF, UtilsIW.PowerPDF, UtConexion, IWApplication;

type
  TFrPlantilla_Documento = class(TForm)
    PAGINA: TPRPage;
    HEAD: TPRLayoutPanel;
    IMAGEN: TPRJpegImage;
    PRLabel1: TPRLabel;
    PRLabel2: TPRLabel;
    PRLabel3: TPRLabel;
    TIPO_DOCUMENTO: TPRLabel;
    PRLabel7: TPRLabel;
    PRLabel8: TPRLabel;
    PRRect1: TPRRect;
    PRLabel6: TPRLabel;
    PRLabel4: TPRLabel;
    PRLabel5: TPRLabel;
    PRLabel9: TPRLabel;
    PRLabel10: TPRLabel;
    PRLabel11: TPRLabel;
    PRLabel12: TPRLabel;
    DAY: TPRLabel;
    MONTH: TPRLabel;
    YEAR: TPRLabel;
    NOMBRE_SINONIMO: TPRLabel;
    DIRECCION: TPRLabel;
    CONCEPTO: TPRLabel;
    PRRect3: TPRRect;
    PRRect4: TPRRect;
    PRRect5: TPRRect;
    PRRect2: TPRRect;
    PRLayoutPanel1: TPRLayoutPanel;
    PRLabel13: TPRLabel;
    PRLabel14: TPRLabel;
    PRLabel15: TPRLabel;
    PRLabel16: TPRLabel;
    NOMBRE_DESPACHADO: TPRLabel;
    NOMBRE_TRANSPORTADOR: TPRLabel;
    PLACAS: TPRLabel;
    PRRect6: TPRRect;
    PRLabel17: TPRLabel;
    PRLayoutPanel2: TPRLayoutPanel;
    PReport1: TPReport;
    PRImage1: TPRImage;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FPages : TPages;
    FCURRENT_LEFT : Integer;
    Procedure SetImage(Var pTitle : TTITLE);
    Procedure SetPages;
    Procedure SetHead(pTitle : TTITLE; pQR : TQUERY; Const pNumero_Documento : String; Var pError : String); Overload;
    Procedure SetHead(pTitle : TTITLE; pQR : TQUERY; pEnc : Integer; Const pNumero_Documento : String; Var pError : String); Overload;
    Procedure Preparar_Pagina_Nueva(Var pPagina : TPRPage; Var pTitle : TTITLE; pData : TQUERY; Const pEnc : Integer; Const pNumero_Documento : String; Var pError : String);
    Function CUFE_QR_Format_Value(Const pValue : Double) : String;
    Function CUFE_QR_CUFE_STR(Const pNumFac, pFecFac, pNitOFE, pTipAdq, pNumAdq, pValFac, pValImp, pValPag : String) : String;
    Function CUFE_QR_QR_STR(Const pNumFac, pFecFac, pNitFac, pDocAdq, pValFac, pValIva, pValOtroIm, pValFacIm, pCUFE : String) : String;
    Function CUFE_QR_QR_BITMAP(Const pValue : String) : TBitmap;
    Procedure Set_CUFE_QR(pQuery : TQuery);
  public
    { Public declarations }
  end;


Var
  FrPlantilla_Documento : TFrPlantilla_Documento;

Function Form_Plantilla_Reporte_Generico(pApp : TIWApplication; Var pError : String; Const pReturn : Boolean = False) : Boolean;

implementation
{$R *.dfm}
Uses
  Math,
  UtLog,
  UtFecha,
  Data.DB,
  UtBase64,
  StrUtils,
  UtFuncion,
  IWAppCache,
  IWMimeTypes,
  IW.CacheStream,
  ServerController,
  TBL00.Info_Tabla,
  DelphiZXIngQRCode;

Function TFrPlantilla_Documento.CUFE_QR_Format_Value(Const pValue : Double) : String;
Begin
  Result := FormatFloat('##############0.#0', pValue);
  Result := StringReplace(Result, ',', '.', [rfReplaceAll]);
End;

Function TFrPlantilla_Documento.CUFE_QR_CUFE_STR(Const pNumFac, pFecFac, pNitOFE, pTipAdq, pNumAdq, pValFac, pValImp, pValPag : String) : String;
Const
  Const_Separador = '';
Var
  lCUFE  : String;
Begin
  lCUFE := pNumFac + Const_Separador +
           pFecFac + Const_Separador +
           pValFac + Const_Separador +
           pValImp + Const_Separador +
           pValPag + Const_Separador +
           pNitOFE + Const_Separador +
           pTipAdq + Const_Separador +
           pNumAdq  ;
  lCUFE := StringReplace(lCUFE, ';', '', [rfReplaceAll]);
  Result := base64HashSHA1(lCUFE);
End;

Function TFrPlantilla_Documento.CUFE_QR_QR_STR(Const pNumFac, pFecFac, pNitFac, pDocAdq, pValFac, pValIva, pValOtroIm, pValFacIm, pCUFE : String) : String;
Begin
  Result := 'NumFac: '    + pNumFac    + #13 +
            'FecFac: '    + pFecFac    + #13 +
            'NitFac: '    + pNitFac    + #13 +
            'DocAdq: '    + pDocAdq    + #13 +
            'ValFac: '    + pValFac    + #13 +
            'ValIva: '    + pValIva    + #13 +
            'ValOtroIm: ' + pValOtroIm + #13 +
            'ValFacIm: '  + pValFacIm  + #13 +
            'CUFE: '      + pCUFE;
End;

Function TFrPlantilla_Documento.CUFE_QR_QR_BITMAP(Const pValue : String) : TBitmap;
Var
  Row : Integer;
  Column : Integer;
  QRCode : TDelphiZXingQRCode;
Begin
  Result := TBitmap.Create;
  QRCode := TDelphiZXingQRCode.Create;
  try
    QRCode.Data := pValue;
    QRCode.Encoding := TQRCodeEncoding(qrAuto);
    QRCode.QuietZone := StrToIntDef('4', 4);
    Result.SetSize(QRCode.Rows, QRCode.Columns);
    for Row := 0 to QRCode.Rows - 1 do
    begin
      for Column := 0 to QRCode.Columns - 1 do
      begin
        if (QRCode.IsBlack[Row, Column]) then
        begin
          Result.Canvas.Pixels[Column, Row] := clBlack;
        end else
        begin
          Result.Canvas.Pixels[Column, Row] := clWhite;
        end;
      end;
    end;
  finally
    QRCode.Free;
  end;
End;

Procedure TFrPlantilla_Documento.Set_CUFE_QR(pQuery : TQuery);
Const
  Const_Separador = '';
Var
  lQR : String;
  lSQL : TQUERY;
  lPos : Integer;
  lCUFE : String;
  PreFac : String;
  NumFac : String;
  FecFac : String;
  ValFac : String;
  ValIVA : String;
  ValRET : String;
  ValOTR : String;
  ValImp : String;
  ValPag : String;
  NitOFE : String;
  TipAdq : String;
  NumAdq : String;
  lBitmap : TBitmap;
  lTipo_Documento : String;
Begin
//  Try
//    If Not (pQuery.State In [TDataSetState.dsInsert, TDataSetState.dsEdit]) Then
//      pQuery.Edit;
//
//    Separate_Text_Number(pQuery.FieldByName('NUMERO_DOCUMENTO').AsString, PreFac, NumFac);
//    FecFac :=      StringReplace(pQuery.FieldByName('FECHA_FACTURA').AsString, '-', '', [rfReplaceAll]         ) +
//              Copy(StringReplace(pQuery.FieldByName('HORA_GENERACION').AsString, ':', '', [rfReplaceAll]), 01, 06);
//    ValFac := CUFE_QR_Format_Value(pQuery.FieldByName('SUBTOTAL').AsFloat);
//
//    If pQuery.FieldByName('VALOR_IVA').AsFloat > 0 Then
//      ValIVA := ValIVA + '01' + ';' + CUFE_QR_Format_Value(pQuery.FieldByName('VALOR_IVA').AsFloat)
//    Else
//      ValIVA := ValIVA + Justificar('1', '0', 2) + ';' + CUFE_QR_Format_Value(0);
//
//    If pQuery.FieldByName('VALOR_RETEFUENTE').AsFloat > 0 Then
//      ValRET := '02' + ';' + CUFE_QR_Format_Value(pQuery.FieldByName('VALOR_RETEFUENTE').AsFloat)
//    Else
//      ValRET := Justificar(IntToStr(2), '0', 2) + ';' + CUFE_QR_Format_Value(0);
//    ValOTR := Justificar(IntToStr(3), '0', 2) + ';' + CUFE_QR_Format_Value(0);
//    ValImp := ValIVA + ';' + ValRET + ';' + ValOTR;
//    ValPag := CUFE_QR_Format_Value(pQuery.FieldByName('VALOR_TOTAL').AsFloat);
//    NitOFE := Trim('811020038');
//    NitOFE := UserSession.NIT;
//
//    lTipo_Documento := UserSession.CNX.GetValue(Retornar_Info_Tabla(Id_Tercero).Name, ['CODIGO_TERCERO'], [pQuery.FieldByName('CODIGO_TERCERO').AsString], ['ID_TIPO_DOCUMENTO']);
//
//    TipAdq := '12';
//    If Trim(lTipo_Documento) = 'C' Then TipAdq := '12'
//      Else
//    If Trim(lTipo_Documento) = 'A' Then TipAdq := '31';//Nit;
//    NumAdq := Trim(pQuery.FieldByName('CODIGO_TERCERO').AsString);
//    NumAdq := StringReplace(NumAdq, ' ', '', [rfReplaceAll]);
//
//    ValIVA := CUFE_QR_Format_Value(pQuery.FieldByName('VALOR_IVA'       ).AsFloat);
//    ValRET := CUFE_QR_Format_Value(pQuery.FieldByName('VALOR_RETEFUENTE').AsFloat);
//    ValOTR := CUFE_QR_Format_Value(0);
//
//    lCUFE := CUFE_QR_CUFE_STR(NumFac, FecFac, NitOFE, TipAdq, NumAdq, ValFac, ValImp, ValPag);
//    lQR   := CUFE_QR_QR_STR  (NumFac, FecFac, NitOFE, TipAdq, ValFac, ValIVA, ValOTR, ValOTR, lCUFE);
//    lBitmap := CUFE_QR_QR_BITMAP(lQR);
//    If Assigned(lBitmap) Then
//    Begin
//      TBlobField(pQuery.FieldByName('QR')).Assign(lBitmap);
//      FreeAndNil(lBitmap);
//    End;
//    pQuery.FieldByName('CUFE').AsString := Trim(lCUFE);
//    If (pQuery.State In [TDataSetState.dsInsert, TDataSetState.dsEdit]) Then
//      pQuery.Post;
//  Except
//    On E: Exception Do
//    Begin
//      UtLog_Execute('TFrPlantilla_Documento.Set_CUFE_QR, ' + E.Message);
//    End;
//  End;
End;

Procedure TFrPlantilla_Documento.SetPages;
Var
  lI : Integer;
  lJ : Integer;
  lPagina : TPRPage;
Begin
  For lI := 0 To FPages.Count - 1 Do
  Begin
    lPagina := FPages[lI];
    For lJ := 0 To lPagina.ComponentCount - 1 Do
      If lPagina.Components[lJ] Is TTITLE Then
        (lPagina.Components[lJ] As TTITLE).PAGINA.Caption := 'Pagina: ' + FormatFloat('###,##0', lI + 1) + ' / ' + FormatFloat('###,##0', FPages.Count);
  End;
End;

Procedure TFrPlantilla_Documento.SetImage(Var pTitle : TTITLE);
Var
  lMS : TMemoryStream;
  lSQL : TQUERY;
  lBitmap : TBitmap;
Begin
//  If Not Assigned(UserSession.LOGO_FORMATO) Then
//  Begin
//    Try
//      lSQL := TQUERY.Create(Nil);
//      lSQL.Connection := UserSession.CNX;
//      lSQL.SQL.Add(' SELECT LOGO_FORMATO  FROM ' + Retornar_Info_Tabla(Id_Configuracion).Name);
//      lSQL.Active := True;
//      If Not lSQL.FieldByName('LOGO_FORMATO').IsNull Then
//      Begin
//        lMS := TMemoryStream.Create;
//        TBlobField(lSQL.FieldByName('LOGO_FORMATO')).SaveToStream(lMS);
//        lMS.Position := 0;
//        lBitmap := TBitmap.Create;
//        lBitmap.LoadFromStream(lMS);
//        pTitle.IMAGEN.Picture.Assign(lBitmap);
//  //      pTitle.IMAGEN.Picture.LoadFromStream(lMS);
//        FreeAndNil(lBitmap);
//        FreeAndNil(lMS);
//      End;
//      lSQL.Active := False;
//      FreeAndNil(lSQL);
//    Except
//      On E: Exception Do
//      Begin
//        UtLog_Execute('TFrPlantilla_Documento.SetImage 1, ' + E.Message);
//      End;
//    End;
//  End
//  Else
//  Begin
//    Try
//      pTitle.IMAGEN.Picture.Assign(UserSession.LOGO_FORMATO);
//    Except
//      On E: Exception Do
//      Begin
//        UtLog_Execute('TFrPlantilla_Documento.SetImage 2, ' + E.Message);
//      End;
//    End;
//  End;
End;

Procedure TFrPlantilla_Documento.SetHead(pTitle : TTITLE; pQR : TQUERY; Const pNumero_Documento : String; Var pError : String);
Begin
  Try
    pTitle.CUADRO_DOCUMENTO.Printable := False;
    pTitle.IMAGEN.Picture.Assign(Self.IMAGEN.Picture);
    pTitle.TIPO_DOCUMENTO.Caption := '';
    pTitle.NUMERO_DOCUMENTO.Caption := '';
    SetImage(pTitle);
//    If Not Vacio(pNumero_Documento) Then
//    Begin
//      If Copy(pQR.FieldByName('CODIGO_DOCUMENTO_ADM').AsString, 01, 02) = 'SI' Then
//        pTitle.TIPO_DOCUMENTO.Caption := 'SALDO INICIAL'
//      Else
//        If Copy(pQR.FieldByName('CODIGO_DOCUMENTO_ADM').AsString, 01, 02) = 'EN' Then
//          pTitle.TIPO_DOCUMENTO.Caption := 'ENTRADA'
//        Else
//         If Copy(pQR.FieldByName('CODIGO_DOCUMENTO_ADM').AsString, 01, 02) = 'SA' Then
//          pTitle.TIPO_DOCUMENTO.Caption := 'SALIDA';
//      pTitle.TIPO_DOCUMENTO.FontSize := 9;
//      pTitle.NUMERO_DOCUMENTO.Caption := pNumero_Documento;
//      pTitle.NUMERO_DOCUMENTO.FontSize := 8;
//    End;
  Except
    On E: Exception Do
    Begin
      pError := E.Message;
      UtLog_Execute('TFrPlantilla_Documento.SetHead, ' + E.Message);
    End;
  End;
End;

Procedure TFrPlantilla_Documento.SetHead(pTitle : TTITLE; pQR : TQUERY; pEnc : Integer; Const pNumero_Documento : String; Var pError : String);
Var
  ltmp : String;
  PreFac : String;
  NumFac : String;
Begin
  Try
    pTitle.CUADRO_DOCUMENTO.Printable := False;
    pTitle.TIPO_DOCUMENTO.Caption := '';
    pTitle.NUMERO_DOCUMENTO.Caption := '';
//    pTitle.TELEFONO.Caption   := Trim(UserSession.TELEFONO);
//    pTitle.MUNICIPIO.Caption  := Trim(UserSession.MUNICIPIO);
//    pTitle.DIRECCION.Caption  := Trim(UserSession.DIRECCION);
//    pTitle.NIT_NOMBRE.Caption := Trim(UserSession.NOMBRE);
    SetImage(pTitle);
    If Not Vacio(pNumero_Documento) Then
    Begin
      pTitle.NUMERO_DOCUMENTO.Caption := pNumero_Documento;
      Separate_Text_Number(pNumero_Documento, PreFac, NumFac);
      pTitle.NUMERO_DOCUMENTO.Caption := PreFac + ' - ' + NumFac;
      pTitle.CUADRO_DOCUMENTO.Printable := True;
    End;
  Except
    On E: Exception Do
    Begin
      pError := E.Message;
      UtLog_Execute('TFrPlantilla_Documento.SetHead, ' + E.Message);
    End;
  End;
End;

Procedure TFrPlantilla_Documento.Preparar_Pagina_Nueva(Var pPagina : TPRPage; Var pTitle : TTITLE; pData : TQUERY; Const pEnc : Integer; Const pNumero_Documento : String; Var pError : String);
Begin
  pPagina := TPRPage.Create(Self);
  pPagina.Parent := Self;
  pPagina.Width := PDF_PAGE_WIDTH_LETTER;
  pPagina.Height := PDF_PAGE_HEIGHT_LETTER;
  Self.FPages.Add(pPagina);
  pTITLE := TTITLE.Create(pPagina);
  pTITLE.Parent := pPagina;
  pTITLE.Top   := 020;
  pTITLE.Left  := 007 + Self.FCURRENT_LEFT;
  pTITLE.Width := pPagina.Width - 2;
  Self.SetHead(pTITLE, pData, pEnc, pNumero_Documento, pError);
End;

Function Form_Plantilla_Reporte_Generico(pApp : TIWApplication; Var pError : String; Const pReturn : Boolean = False) : Boolean;
Var
  lI : Integer;
  lF : TFrPlantilla_Documento;
  lM : TQUERY;
  lURL : String;
  lTop : Integer;
  lTITLE  : TTITLE;
  lDETAIL : TDETAIL_ERCOL;
  lFOOT   : TFOOT_FINAL;
  lPagina : TPRPage;
  lDestino : String;
Begin
  Result := False;
  pError := '';
  lDestino := TIWAppCache.NewTempFileName('.pdf');
  Try
    lM := TQUERY.Create(Nil);
    lM.Connection := UserSession.CNX;
    lM.SQL.Add(' SELECT * FROM ' + gInfo_Tablas[Id_TBL_Usuario_Reporte].Name + UserSession.CNX.No_Lock);
    lM.SQL.Add(' WHERE ' + UserSession.CNX.Trim_Sentence('CODIGO_USUARIO') + ' = ' + QuotedStr(Trim(UserSession.USER_CODE)));
    lM.SQL.Add(' ORDER BY LINEA ');
    lM.Active := True;
    If lM.Active And (lM.RecordCount > 0) Then
    Begin
      lTop := 3;
      lF := TFrPlantilla_Documento.Create(Nil);
      lPagina := TPRPage.Create(lF);
      lPagina.Parent := lF;
      lF.FPages.Add(lPagina);

      lTITLE := TTITLE.Create(lPagina);
      lTITLE.Parent := lPagina;

      lDETAIL        := TDETAIL_ERCOL.Create(lPagina);
      lDETAIL.Parent := lPagina;

      lTop := lTITLE.Height + lTITLE.Top;

      lM.First;
      lF.SetHead(lTITLE, lM, -1, '', pError);


      lTITLE.Width := lPagina.Width - 2;

      lDETAIL.Top    := lTITLE.Height + lTITLE.Top;
      lDETAIL.Left   := 007 + lF.FCURRENT_LEFT;
      lDETAIL.Width  := lPagina.Width - 2;
      lDETAIL.Top    := lTITLE.Height;

      lTop := lTITLE.Height + lTITLE.Top + lTITLE.Height;

      lM.First;
      While Not lM.Eof Do
      Begin
        lDETAIL.SetLine(lM.FieldByName('CONTENIDO').AsString, False);
        If (lTop + lDETAIL.CURRENT_TOP + lDETAIL.LAST_HEIGHT) > (lPagina.Height) Then
        Begin
          lPagina := TPRPage.Create(lF);
          lPagina.Parent := lF;
          lF.FPages.Add(lPagina);

          lTITLE := TTITLE.Create(lPagina);
          lTITLE.Parent := lPagina;
//          lTITLE.Top   := 001;
//          lTITLE.Left  := 007;
          lTITLE.Width := lPagina.Width - 2;
          lF.SetHead(lTITLE, lM, -1, '', pError);

          lDETAIL        := TDETAIL_ERCOL.Create(lPagina);
          lDETAIL.Parent := lPagina;
          lDETAIL.Left   := 007 + lF.FCURRENT_LEFT;
          lDETAIL.Width  := lPagina.Width - 2;
          lDETAIL.Top    := lTITLE.Height + lTITLE.Top;
          lTop := lTITLE.Height + lTITLE.Top;
        End;
        lM.Next;
      End;

      lFOOT        := TFOOT_FINAL.Create(lPagina);
      lFOOT.Parent := lPagina;
      lFOOT.Top    := lPagina.Height - lFOOT.Height;
      lFOOT.Left   := 007;
      lFOOT.Width  := lPagina.Width - 2;

      lF.SetPages;
      lF.PReport1.FileName := lDestino;
      lF.PReport1.BeginDoc;
      For lI := 0 To lF.FPages.Count-1 Do
      Begin
        lF.PReport1.Print(lF.FPages[lI]);
      End;
      lF.PReport1.EndDoc;
      FreeAndNil(lFOOT);
      FreeAndNil(lDETAIL);
      FreeAndNil(lTITLE);
      FreeAndNil(lF);
      Result := True;
    End;
    lM.Active := False;
    FreeAndNil(lM);
    If FileExists(lDestino) Then
    Begin
      lURL := TIWAppCache.AddFileToCache(pApp, lDestino, TIWMimeTypes.GetAsString(mtPDF), ctSession);
      If Not pReturn Then
        pApp.NewWindow(lURL)
      Else
        pError := lURL;
    End;
  Except
    On E: Exception Do
    Begin
      pError := E.Message;
      UtLog_Execute('Form_Plantilla_Reporte_Ercol, ' + E.Message);
    End;
  End;
End;

procedure TFrPlantilla_Documento.FormCreate(Sender: TObject);
begin
  Try
    FPages := TPages.Create;
    FCURRENT_LEFT := 10;
  Except
    On E: Exception Do
    Begin
      UtLog_Execute('TFrPlantilla_Documento.FormCreate, ' + E.Message);
    End;
  End;
end;

procedure TFrPlantilla_Documento.FormDestroy(Sender: TObject);
Var
  lPage : TPRPage;
begin
  For lPage In FPages Do
    lPage.Free;
  FPages.Clear;
  FreeAndNil(FPages);
end;

end.
