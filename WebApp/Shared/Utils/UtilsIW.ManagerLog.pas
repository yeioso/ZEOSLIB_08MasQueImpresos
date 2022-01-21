unit UtilsIW.ManagerLog;

interface
Uses
  System.Classes;

Procedure Utils_ManagerLog_Add(Const pUser, pDocumento, pOperacion, pDetalle : String);

implementation

Uses
  UtLog,
  UtFuncion,
  UtConexion,
  System.SysUtils;

Procedure Utils_ManagerLog_Add(Const pUser, pDocumento, pOperacion, pDetalle : String);
Var
  lDetalle : String;
Begin
  lDetalle := pDetalle;
  lDetalle := StringReplace(lDetalle, LINE_START, '', [rfReplaceAll]);
  lDetalle := StringReplace(lDetalle, LINE_FINISH, '', [rfReplaceAll]);
  UtLog_UserExecute(pUser, LINE_START +
                           Copy(pDocumento + StringOfChar(' ', 30), 01, 30) + ' - ' +
                           Copy(pOperacion + StringOfChar(' ', 50), 01, 50) + ' - ' +
                           lDetalle + LINE_FINISH);
End;

end.
