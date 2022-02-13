unit Form_Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.Buttons,
  Vcl.Samples.Gauges;

type
  TFrMain = class(TForm)
    Origen: TADOConnection;
    Destino: TADOConnection;
    BTNEXECUTE: TSpeedButton;
    Gauge1: TGauge;
    procedure BTNEXECUTEClick(Sender: TObject);
  private
    { Private declarations }
    Function GetCount(Const pTable  : String) : Integer;
    Function GetMaster(Const pTable, pField, pValue, pOut : String) : String;
    Procedure Inventario; Overload;
    Procedure Inventario(Const pCode, pName, pArea, pUnidad_Medida : String; Const pValor : Double); Overload;
    Function OP(Const pProyecto : String; Const pOP : Integer) : Integer;
    Function Maximo : Integer;
    Procedure Entrada(Const pTableName : String);
    Procedure Salida;
  public
    { Public declarations }
  end;

var
  FrMain: TFrMain;

implementation
{$R *.dfm}
Uses
  UtFuncion;

procedure TFrMain.BTNEXECUTEClick(Sender: TObject);
begin
  Inventario;
  Entrada('FERNANDO');
  Entrada('RIXIBEL');
//  Salida;
end;

Function TFrMain.GetCount(Const pTable  : String) : Integer;
Var
  lD : TADOQuery;
Begin
  Result := 0;
  lD := TADOQuery.Create(Nil);
  lD.Connection := Destino;
  lD.SQL.Add(' SELECT COUNT(*) AS RESULTADO FROM ' + pTable + ' ');
  lD.Active := True;
    Result := lD.FieldByName('RESULTADO').AsInteger + 1;
  lD.Active := False;
  FreeAndNil(lD);
End;

Function TFrMain.GetMaster(Const pTable, pField, pValue, pOut : String) : String;
Var
  lD : TADOQuery;
  lValue : String;
Begin
  lValue := pValue;
  lValue := AnsiUpperCase(Set_Texto_Valido(AnsiUpperCase(Trim(lValue))));
  If Vacio(lValue) Then
    lValue := 'NO DEFINIDO';
  lD := TADOQuery.Create(Nil);
  lD.Connection := Destino;
  lD.SQL.Add(' SELECT * FROM ' + pTable + ' WHERE UPPER(LTRIM(RTRIM(' + pField + '))) = ' + QuotedStr(Trim(lValue)));
  lD.Active := True;
  If lD.RecordCount > 0 Then
    Result := lD.FieldByName(pOut).AsString
  Else
  Begin
    lD.Append;
    lD.FieldByName(pOut  ).AsString := Justificar(IntToStr(GetCount(pTable)), '0', lD.FieldByName(pOut).Size);
    lD.FieldByName(pField).AsString := AnsiUpperCase(lValue);
    lD.Post;
    Result := lD.FieldByName(pOut).AsString
  End;
  lD.Active := False;
  FreeAndNil(lD);
End;

Procedure TFrMain.Inventario;
Var
  lO : TADOQuery;
  lD : TADOQuery;
  lCode : String;
  lName : String;
Begin
  lO := TADOQuery.Create(Nil);
  lD := TADOQuery.Create(Nil);
  lO.Connection := Origen;
  lD.Connection := Destino;
  lO.SQL.Add(' select * from FERNANDO');
  lO.Active := True;
  Gauge1.Progress := 0;
  Gauge1.MinValue := 0;
  Gauge1.MaxValue := lO.RecordCount;
  lO.First;
  While Not lO.Eof Do
  Begin
    Gauge1.Progress := Gauge1.Progress + 1;
    Application.ProcessMessages;
    lCode := AnsiUpperCase(Justificar(lO.FieldByName('CODIGO').AsString, '0', 20));
    lName := AnsiUpperCase(Set_Texto_Valido(AnsiUpperCase(Trim(lO.FieldByName('NOMBRE').AsString))));
    lD.Active := False;
    lD.SQL.Clear;
    lD.SQL.Add(' select * from TBL007_PRODUCTO ');
    lD.SQL.Add(' where LTRIM(RTRIM(CODIGO_PRODUCTO)) = ' + QuotedStr(Trim(lCode)));
    lD.Active := True;
    If lD.RecordCount <= 0 Then
    Begin
      lD.Append;
      lD.FieldByName('CODIGO_PRODUCTO'     ).AsString := lCode;
      lD.FieldByName('NOMBRE'              ).AsString := lName;
      lD.FieldByName('VALOR_UNITARIO'      ).AsFloat  := lO.FieldByName('VALOR_UNITARIO').AsFloat;
      lD.FieldByName('STOCK_MINIMO'        ).AsFloat  := lO.FieldByName('STOCK_MINIMO'  ).AsFloat;
      lD.FieldByName('CODIGO_AREA'         ).AsString := GetMaster('TBL005_AREA'         , 'NOMBRE', Set_Texto_Valido(AnsiUpperCase(Trim(lO.FieldByName('AREA').AsString))), 'CODIGO_AREA');
      lD.FieldByName('CODIGO_UNIDAD_MEDIDA').AsString := GetMaster('TBL006_UNIDAD_MEDIDA', 'NOMBRE', Set_Texto_Valido(AnsiUpperCase(Trim(lO.FieldByName('UNIDAD_MEDIDA').AsString))), 'CODIGO_UNIDAD_MEDIDA');
      lD.FieldByName('ID_ACTIVO'           ).AsString := 'S';
      lD.FieldByName('ID_SERVICIO'         ).AsString := 'N';
      lD.FieldByName('ID_FACTOR'           ).AsString := 'N';
      lD.Post;
    End;
    lO.Next;
  End;
  lD.Active := False;
  lO.Active := False;
  FreeAndNil(lD);
  FreeAndNil(lO);
End;

Procedure TFrMain.Inventario(Const pCode, pName, pArea, pUnidad_Medida : String; Const pValor : Double);
Var
  lD : TADOQuery;
  lCode : String;
  lName : String;
Begin
  lD := TADOQuery.Create(Nil);
  lD.Connection := Destino;
  lCode := AnsiUpperCase(Justificar(pCode, '0', 20));
  lName := AnsiUpperCase(Set_Texto_Valido(AnsiUpperCase(Trim(pName))));
  lD.Active := False;
  lD.SQL.Clear;
  lD.SQL.Add(' select * from TBL007_PRODUCTO ');
  lD.SQL.Add(' where LTRIM(RTRIM(CODIGO_PRODUCTO)) = ' + QuotedStr(Trim(lCode)));
  lD.Active := True;
  If lD.RecordCount <= 0 Then
  Begin
    lD.Append;
    lD.FieldByName('CODIGO_PRODUCTO'     ).AsString := lCode;
    lD.FieldByName('NOMBRE'              ).AsString := lName;
    lD.FieldByName('VALOR_UNITARIO'      ).AsFloat  := pValor;
    lD.FieldByName('STOCK_MINIMO'        ).AsFloat  := 0;
    lD.FieldByName('STOCK_MAXIMO'        ).AsFloat  := 0;
    lD.FieldByName('CODIGO_AREA'         ).AsString := GetMaster('TBL005_AREA'         , 'NOMBRE', Set_Texto_Valido(AnsiUpperCase(Trim(pArea))), 'CODIGO_AREA');
    lD.FieldByName('CODIGO_UNIDAD_MEDIDA').AsString := GetMaster('TBL006_UNIDAD_MEDIDA', 'NOMBRE', Set_Texto_Valido(AnsiUpperCase(Trim(pUnidad_Medida))), 'CODIGO_UNIDAD_MEDIDA');
    lD.FieldByName('ID_ACTIVO'           ).AsString := 'S';
    lD.Post;
  End;
  lD.Active := False;
  FreeAndNil(lD);
End;

Function TFrMain.OP(Const pProyecto : String; Const pOP : Integer) : Integer;
Var
  lD : TADOQuery;
  lProyecto : String;
  lName : String;
Begin
  Result := pOP;
  lProyecto := Set_Texto_Valido(AnsiUpperCase(Trim(pProyecto)));
  lProyecto := GetMaster('TBL009_PROYECTO', 'NOMBRE', Set_Texto_Valido(AnsiUpperCase(Trim(lProyecto))), 'CODIGO_PROYECTO');

  lD := TADOQuery.Create(Nil);
  lD.Connection := Destino;
  lD.Active := False;
  lD.SQL.Clear;
  lD.SQL.Add(' select * from TBL030_ORDEN_PROD ');
  lD.SQL.Add(' where LTRIM(RTRIM(CODIGO_DOCUMENTO)) = ' + QuotedStr(Trim('ORDEN DE PRODUCCION')));
  lD.SQL.Add(' and NUMERO = ' + IntToStr(pOP));
  lD.Active := True;
  If lD.RecordCount <= 0 Then
  Begin
    lD.Append;
    lD.FieldByName('CODIGO_DOCUMENTO'    ).AsString := 'ORDEN DE PRODUCCION';
    lD.FieldByName('NUMERO'              ).AsInteger:= pOP;
    lD.FieldByName('CODIGO_PROYECTO'     ).AsString := lProyecto;
    lD.FieldByName('CODIGO_TERCERO'      ).AsString  := GetMaster('TBL008_TERCERO', 'NOMBRE', 'NO DEFINIDO', 'CODIGO_TERCERO');
    lD.FieldByName('FECHA_REGISTRO'      ).AsString  := FormatDateTime('YYYY-MM-DD', Now);
    lD.FieldByName('HORA_REGISTRO'       ).AsString  := FormatDateTime('HH:NN:SS.ZZZ', Now);
    lD.FieldByName('CODIGO_USUARIO'      ).AsString  := '            15458469';
    lD.FieldByName('NOMBRE'              ).AsString := 'ORDEN DE PRODUCCION ' + pProyecto;
    lD.FieldByName('ID_ACTIVO'           ).AsString := 'S';
    lD.Post;
  End;
  lD.Active := False;
  FreeAndNil(lD);
End;

Function TFrMain.Maximo : Integer;
Var
  lD : TADOQuery;
Begin
  Result := 0;
  lD := TADOQuery.Create(Nil);
  lD.Connection := Destino;
  lD.SQL.Add(' select max(NUMERO) AS RESULTADO from TBL032_MOVTO_INV ');
  lD.SQL.Add(' WHERE LTRIM(RTRIM(CODIGO_DOCUMENTO)) = ' + QuotedStr('ENTRADA DE INVENTARIO'));
  lD.Active := True;
  Result := lD.FieldByName('RESULTADO').AsInteger;
  lD.Active := False;
  FreeAndNil(lD);
End;

Procedure TFrMain.Entrada(Const pTableName : String);
Var
  lI : Integer;
  lO : TADOQuery;
  lD : TADOQuery;
  lCode : String;
  lName : String;
Begin
  lI := Maximo;
  lO := TADOQuery.Create(Nil);
  lD := TADOQuery.Create(Nil);
  lO.Connection := Origen;
  lD.Connection := Destino;
  lO.SQL.Add(' select * from ' + pTableName);
  lD.SQL.Add(' select * from TBL032_MOVTO_INV ');
  lO.Active := True;
  lD.Active := True;
  Gauge1.Progress := 0;
  Gauge1.MinValue := 0;
  Gauge1.MaxValue := lO.RecordCount;
  lO.First;
  While Not lO.Eof Do
  Begin
    Gauge1.Progress := Gauge1.Progress + 1;
    Application.ProcessMessages;
    lCode := AnsiUpperCase(Justificar(lO.FieldByName('CODIGO').AsString, '0', 20));
    lD.Active := False;
    lD.SQL.Clear;
    lD.SQL.Add(' select * from TBL032_MOVTO_INV ');
    lD.SQL.Add(' WHERE LTRIM(RTRIM(CODIGO_PRODUCTO)) = ' + QuotedStr(Trim(lCode)));
    lD.Active := True;
    If lD.Active And (lD.RecordCount <= 0) And ((lO.FieldByName('ENTRADA').AsFloat - lO.FieldByName('SALIDA').AsFloat) <> 0) Then
    Begin
      Inc(lI);
      Inventario(lCode,
                 lO.FieldByName('NOMBRE').AsString,
                 lO.FieldByName('AREA').AsString,
                 lO.FieldByName('UNIDAD_MEDIDA').AsString,
                 lO.FieldByName('VALOR_UNITARIO').AsFloat);
      lD.Append;
      lD.FieldByName('CODIGO_DOCUMENTO'    ).AsString  := 'ENTRADA DE INVENTARIO';
      lD.FieldByName('NUMERO'              ).AsInteger := lI;
      lD.FieldByName('CODIGO_TERCERO'      ).AsString  := '00000000000000000000';
      lD.FieldByName('CODIGO_PRODUCTO'     ).AsString  := lCode;
      lD.FieldByName('CODIGO_DOCUMENTO_OP' ).AsString  := 'ORDEN DE PRODUCCION';
      lD.FieldByName('NUMERO_OP'           ).AsInteger := 0;
      lD.FieldByName('NOMBRE'              ).AsString  := 'SALDOS INICIALES - FEBRERO 2022';
      lD.FieldByName('FECHA_REGISTRO'      ).AsString  := FormatDateTime('YYYY-MM-DD', Now + 1);
      lD.FieldByName('HORA_REGISTRO'       ).AsString  := FormatDateTime('HH:NN:SS.ZZZ', Now);
      lD.FieldByName('FECHA_MOVIMIENTO'    ).AsString  := FormatDateTime('YYYY-MM-DD', Now + 2);
      lD.FieldByName('FECHA_VENCIMIENTO'   ).AsString  := lD.FieldByName('FECHA_MOVIMIENTO').AsString;
      lD.FieldByName('CANTIDAD'            ).AsFloat   := (lO.FieldByName('ENTRADA').AsFloat - lO.FieldByName('SALIDA').AsFloat);
      lD.FieldByName('VALOR_UNITARIO'      ).AsFloat   := lO.FieldByName('VALOR_UNITARIO').AsFloat;
      lD.FieldByName('CODIGO_USUARIO'      ).AsString  := '            15458469';
      lD.FieldByName('ID_ACTIVO'           ).AsString  := 'S';
      lD.Post;
    End;
    lO.Next;
  End;
  lD.Active := False;
  lO.Active := False;
  FreeAndNil(lD);
  FreeAndNil(lO);
End;

Procedure TFrMain.Salida;
Var
  lI : Integer;
  lO : TADOQuery;
  lD : TADOQuery;
  lCode : String;
  lName : String;
  lUsuario : String;
  lEmpresa : String;
Begin
  lI := 0;
  lO := TADOQuery.Create(Nil);
  lD := TADOQuery.Create(Nil);
  lO.Connection := Origen;
  lD.Connection := Destino;
  lO.SQL.Add(' select * from Salida');
  lD.SQL.Add(' select * from TBL031_MOVTO_INV ');
  lO.Active := True;
  lD.Active := True;
  lO.First;
  While Not lO.Eof Do
  Begin
    If lO.FieldByName('Cantidad').AsFloat > 0 Then
    Begin
      Inc(lI);
      lCode := AnsiUpperCase(Justificar(lO.FieldByName('li').AsString, '0', 20));
      Inventario(lCode,
                 lO.FieldByName('Descripcion').AsString,
                 lO.FieldByName('Area').AsString,
                 lO.FieldByName('Unidad').AsString,
                 lO.FieldByName('Valor').AsFloat);
      lUsuario := Set_Texto_Valido(AnsiUpperCase(Trim(lO.FieldByName('Solicitante').AsString)));
      lD.Append;
      lD.FieldByName('CODIGO_DOCUMENTO'    ).AsString  := 'SALIDA DE INVENTARIO';
      lD.FieldByName('NUMERO'              ).AsInteger := lI;
      lD.FieldByName('CODIGO_TERCERO'      ).AsString  := GetMaster('TBL008_TERCERO', 'NOMBRE', 'NO DEFINIDO', 'CODIGO_TERCERO');
      lD.FieldByName('CODIGO_PRODUCTO'     ).AsString  := lCode;
      lD.FieldByName('CODIGO_DOCUMENTO_OP' ).AsString  := 'ORDEN DE PRODUCCION';
      lD.FieldByName('NUMERO_OP'           ).AsInteger := OP(lO.FieldByName('Proyecto').AsString, Trunc(lO.FieldByName('OP').AsInteger));
      lD.FieldByName('NOMBRE'              ).AsString  := 'CARGA DE SALIDA DEL INVENTARIO';
      lD.FieldByName('FECHA_REGISTRO'      ).AsString  := FormatDateTime('YYYY-MM-DD', Now);
      lD.FieldByName('HORA_REGISTRO'       ).AsString  := FormatDateTime('HH:NN:SS.ZZZ', Now);
      lD.FieldByName('FECHA_MOVIMIENTO'    ).AsString  := FormatDateTime('YYYY-MM-DD', lO.FieldByName('Fecha').AsDateTime);
      lD.FieldByName('FECHA_VENCIMIENTO'   ).AsString  := lD.FieldByName('FECHA_MOVIMIENTO').AsString;
      lD.FieldByName('CANTIDAD'            ).AsFloat   := lO.FieldByName('Cantidad').AsFloat;
      lD.FieldByName('VALOR_UNITARIO'      ).AsFloat   := lO.FieldByName('Valor').AsFloat;
      lD.FieldByName('CODIGO_USUARIO'      ).AsString  := GetMaster('TBL003_USUARIO', 'NOMBRE', lUsuario, 'CODIGO_USUARIO');
      lD.FieldByName('ID_ACTIVO'           ).AsString  := 'S';
      lD.Post;
    End;
    lO.Next;
  End;
  lD.Active := False;
  lO.Active := False;
  FreeAndNil(lD);
  FreeAndNil(lO);
End;

end.
