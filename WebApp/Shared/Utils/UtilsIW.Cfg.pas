unit UtilsIW.Cfg;

interface

Type
  TDB = Packed Record
    ServerName     : AnsiString;
    DatabaseName   : AnsiString;
    UserName       : AnsiString;
    Password       : AnsiString;
    Port           : Integer   ;
    Ruta_Inicial   : AnsiString;
    DLL_DATABASE   : AnsiString;
  End;

Function UtilsIW_Cfg_Load(Var pDB : TDB; Const pPath : String) : Boolean;
Function UtilsIW_Cfg_Save(Const pDB : TDB; Const pPath : String) : Boolean;

implementation

Uses
  UtLog,
  UtFuncion,
  System.Classes,
  System.SysUtils;

Const
  Const_Config = 'MQIERPCFG.dll';

Function UtilsIW_Cfg_Load(Var pDB : TDB; Const pPath : String) : Boolean;
Var
  lE : Integer;
  lI : Integer;
  lF : TStringList;
Begin
  Try
    If FileExists(pPath + Const_Config) Then
    Begin
      lF := TStringList.Create;
      lF.LoadFromFile(pPath + Const_Config);
      For lI := 0 To lF.Count-1 Do
      Begin
        If Pos(AnsiUpperCase(Trim('DLL_DATABASE')), AnsiUpperCase(Trim(lF[lI]))) > 0 Then
          pDB.DLL_DATABASE := Retornar_Texto_Intermedio(lF[lI], '=', True)
        Else
          If Pos(AnsiUpperCase(Trim('SERVERNAME')), AnsiUpperCase(Trim(lF[lI]))) > 0 Then
            pDB.ServerName := Retornar_Texto_Intermedio(lF[lI], '=', True)
          Else
            If Pos(AnsiUpperCase(Trim('DATABASENAME')), AnsiUpperCase(Trim(lF[lI]))) > 0 Then
              pDB.DatabaseName := Retornar_Texto_Intermedio(lF[lI], '=', True)
            Else
              If Pos(AnsiUpperCase(Trim('USERNAME')), AnsiUpperCase(Trim(lF[lI]))) > 0 Then
                pDB.UserName := Retornar_Texto_Intermedio(lF[lI], '=', True)
              Else
                If Pos(AnsiUpperCase(Trim('PASSWORD')), AnsiUpperCase(Trim(lF[lI]))) > 0 Then
                  pDB.Password := Retornar_Texto_Intermedio(lF[lI], '=', True)
                Else
                  If Pos(AnsiUpperCase(Trim('RUTA_INICIAL')), AnsiUpperCase(Trim(lF[lI]))) > 0 Then
                    pDB.Ruta_Inicial := Retornar_Texto_Intermedio(lF[lI], '=', True)
                  Else
                    If Pos(AnsiUpperCase(Trim('PORT')), AnsiUpperCase(Trim(lF[lI]))) > 0 Then
                       pDB.PORT := SetToInt(Retornar_Texto_Intermedio(lF[lI], '=', True));
          Result := True;
      End;
      FreeAndNil(lF);
    End;
  Except
    On E: Exception Do
      UtLog_Execute('UtilsIW_Cfg_Load, ' + E.Message);
  End;
End;

Function UtilsIW_Cfg_Save(Const pDB : TDB; Const pPath : String) : Boolean;
Var
  lI : Integer;
  lF : TStringList;
Begin
  Try
    lF := TStringList.Create;
    lF.Add('SERVERNAME= '   + pDB.ServerName    );
    lF.Add('DATABASENAME= ' + pDB.DatabaseName  );
    lF.Add('USERNAME= '     + pDB.UserName      );
    lF.Add('PASSWORD= '     + pDB.Password      );
    lF.Add('PORT= '         + IntToStr(pDB.Port));
    lF.Add('DLL_DATABASE= ' + pDB.DLL_DATABASE  );
    lF.SaveToFile(pPath + Const_Config);
    FreeAndNil(lF);
  Except
    On E: Exception Do
      UtLog_Execute('UtilsIW_Cfg_Save, ' + E.Message);
  End;
End;

end.
