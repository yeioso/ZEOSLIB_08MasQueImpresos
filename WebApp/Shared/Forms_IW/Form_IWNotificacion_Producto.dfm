object FrIWNotificacion_Producto: TFrIWNotificacion_Producto
  Left = 0
  Top = 0
  Width = 1071
  Height = 551
  RenderInvisibleControls = True
  AllowPageAccess = True
  ConnectionMode = cmAny
  OnCreate = IWAppFormCreate
  OnDestroy = IWAppFormDestroy
  OnShow = IWAppFormShow
  Background.Fixed = False
  HandleTabs = False
  LeftToRight = True
  LockUntilLoaded = True
  LockOnSubmit = True
  ShowHint = True
  DesignLeft = 2
  DesignTop = 2
  object IWRegion_Head: TIWRegion
    Left = 0
    Top = 0
    Width = 1071
    Height = 38
    HorzScrollBar.Visible = False
    VertScrollBar.Visible = False
    RenderInvisibleControls = True
    Align = alTop
    object BTNCERRAR: TIWButton
      Left = 8
      Top = 4
      Width = 120
      Height = 30
      Cursor = crHandPoint
      Caption = 'CERRAR'
      Color = clBtnFace
      Font.Color = clNone
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'BTNCERRAR'
      OnAsyncClick = BTNCERRARAsyncClick
    end
    object BTNGUARDAR: TIWButton
      Left = 144
      Top = 4
      Width = 120
      Height = 30
      Cursor = crHandPoint
      Caption = 'GUARDAR'
      Color = clBtnFace
      Font.Color = clNone
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'BTNGUARDAR'
      OnAsyncClick = BTNGUARDARAsyncClick
    end
  end
  object IWRegion_Detalle: TIWRegion
    Left = 0
    Top = 38
    Width = 1071
    Height = 513
    HorzScrollBar.Visible = False
    VertScrollBar.Visible = False
    RenderInvisibleControls = True
    Align = alClient
    BorderOptions.NumericWidth = 0
    ExplicitTop = 60
    ExplicitWidth = 643
    ExplicitHeight = 491
    object IWjQGrid1: TIWjQGrid
      Left = 8
      Top = 6
      Width = 1060
      Height = 469
      Caption = 'Seleccione los registros a confirmar'
      VisibleRowCount = 15
      Options = [goViewRecords, goCellEdit, goGridView, goHoverRows, goIgnoreCase, goSortable, goShowToolbar, goShowPager, goMultiBoxOnly]
      DateFormat = 'd-m-Y'
      Columns = <
        item
          Width = 150
          Name = 'CODIGO_PRODUCTO'
          Alignment = taRightJustify
          Title = 'C'#243'digo'
        end
        item
          Width = 600
          Name = 'NOMBRE'
          Title = 'Descripci'#243'n'
        end
        item
          Width = 70
          Name = 'FECHA_REGISTRO'
          Title = 'Fecha'
        end
        item
          Width = 70
          Name = 'HORA_REGISTRO'
          Title = 'Hora'
        end
        item
          Width = 70
          Name = 'CANTIDAD'
          Alignment = taRightJustify
          Title = 'Cantidad'
        end
        item
          Width = 70
          Name = 'SELECCIONAR'
          Alignment = taCenter
          Title = 'Seleccionar'
          Cursor = ccHand
          Editable = True
          EditType = etCheckBox
          CheckBoxValues = 'S'#237':No'
        end>
      RowCount = 15
      OnGetCellText = IWjQGrid1GetCellText
      OnSaveCell = IWjQGrid1SaveCell
    end
  end
end
