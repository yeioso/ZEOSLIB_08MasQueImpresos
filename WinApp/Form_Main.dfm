object FrMain: TFrMain
  Left = 0
  Top = 0
  Caption = 'FrMain'
  ClientHeight = 340
  ClientWidth = 687
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object BTNEXECUTE: TSpeedButton
    Left = 24
    Top = 72
    Width = 249
    Height = 25
    Caption = 'RUN'
    OnClick = BTNEXECUTEClick
  end
  object Origen: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=0;Persist Security Info=True;User I' +
      'D=sa;Initial Catalog=AUXILIAR;Data Source=ASE'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 48
    Top = 16
  end
  object Destino: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=0;Persist Security Info=True;User I' +
      'D=sa;Initial Catalog=MQI;Data Source=ASE'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 240
    Top = 16
  end
end
