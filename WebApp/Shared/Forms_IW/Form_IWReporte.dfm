object FrIWReporte: TFrIWReporte
  Left = 0
  Top = 0
  Width = 618
  Height = 400
  RenderInvisibleControls = True
  AllowPageAccess = True
  ConnectionMode = cmAny
  OnCreate = IWAppFormCreate
  Background.Fixed = False
  HandleTabs = False
  LeftToRight = True
  LockUntilLoaded = True
  LockOnSubmit = True
  ShowHint = True
  ProgressIndicator = IWProgressIndicator1
  DesignLeft = 2
  DesignTop = 2
  object IWRegion_HEAD: TIWRegion
    Left = 0
    Top = 0
    Width = 618
    Height = 60
    HorzScrollBar.Visible = False
    VertScrollBar.Visible = False
    RenderInvisibleControls = True
    Align = alTop
    ExplicitWidth = 555
    object BTNBACK: TIWButton
      Left = 13
      Top = 12
      Width = 120
      Height = 30
      Cursor = crHandPoint
      Caption = 'REGRESAR'
      Color = clBtnFace
      Font.Color = clNone
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'BTNBACK'
      TabOrder = 1
      OnAsyncClick = BTNBACKAsyncClick
    end
  end
  object PAGINAS: TIWjQPageControl
    Left = 3
    Top = 66
    Width = 606
    Height = 226
    RenderInvisibleControls = False
    ActivePage = PAG01
    Font.Color = clNone
    Font.Size = 10
    Font.Style = []
    TabHeight = 30
    TabTextHeight = 17
    TabMargin = 7
    TabPadding = 13
    TabBorderHeight = 0
    object PAG00: TIWjQTabPage
      Left = 1
      Top = 38
      Width = 604
      Height = 187
      RenderInvisibleControls = True
      Caption = 'Saldo de Inventario'
      PageIndex = 0
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object BTNCODIGO_PRODUCTO_INI: TIWImage
        Left = 305
        Top = 13
        Width = 22
        Height = 21
        Cursor = crHandPoint
        Hint = 'Buscar'
        ParentShowHint = True
        BorderOptions.Width = 0
        UseSize = True
        OnAsyncClick = BTNCODIGO_PRODUCTO_INIAsyncClick
        Picture.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D49484452000000180000
          00180806000000E0773DF80000042C4944415478DAED94DB4F9B7518C79FA727
          DAB77DE9017AA087C8A914282301A21820960D10861A25E30225BBDA96A8376A
          624C3CFC01CE7557A2DECC1997186346614EC93615641886BAB5890ED8686530
          683B2CB495B7941EDEBEFDF9838B65C60577A157EE9BBCF9E5CDEFF0799EEFEF
          F73C08FFB1F021E07F0C709F70BF98CD64DC335452A9B477E4DC287FEF7C7FDF
          21659EE4C7DADADAAAC562F14BAFBCF6EAE80303DE7BF7B83DB5BD7DF5D2B7DF
          A843A130A9ADA9A9BB70E9E2FCBD6B7A7B0EBA66E7E7266D561B1CECE9898845
          A2E637DF797B794FC087431F18BC3EEF5193D1D4CFF37CC3E4E424B02C4B3639
          6E4822919ECE643303C5C57A9E650B3F5B5D597EABB0903D9C4824A0B3A393C8
          A4D2AB80385CED709C1A187C21FE37C0A867C44E871FA80C1CC741201000A552
          09347D585B5B03111D556C2168B55A48D0F9782C0A269309B27C1652A914D439
          EBA0A9A9094A4CA6D53C21AD4F3DF374F02F80F3E7BE1C4BA7D3BD13DF4F80D7
          EB25740AA51209102AA432984AA0BBB363F7FFFCD763B8F9479CECEC1789443B
          DB894C26C327BBBAA0D6E9241A8DE673D7FEF6C1BB8091614F4530185CA05688
          16177F03BFDF0FA15008D46A35A8942AE07339D068B4D0EE7285552A9574D8E3
          D167D229A097BF1BDCCED8D5D909E5E5E5749D6627B64C369B2D7DB6EFB9DF77
          01A74F7DECC9E7F37DC15010E3F1382C2EDE22D7BCD71029DF68341025A3C41C
          85E404E1239A82961E3840ADDBCD8CA600399E27D41EDC399C5132C462B1608E
          CF8D1C3976F4109E3CE16E189F18F7E636D7C16E2B4156AB83709423533FFB50
          A160805A405A5B5B7179690962B1D8108D476B369B07AD362BF12FF8D1A0D703
          7D18C456A4C20AAB0954851A128C72C86504D271A0A309EBF7D59FB1CA85C38A
          AD355262D4A3C6500232AD910456EEE0959BAB5069AF24DDDDDD18F007C0E7F3
          1DA1004D4B4BCB49BBDD4EA6A7A7D11FF0039B8A1096A4B1D46A8622A389C8B5
          46BC7E7B0D7C81E0A758EF746ED9B221A6AA98018B560952050B495E80782607
          677F8980B9B4728AFABE9A4C2667E92370D33B1629148AD7E957452DB345C32B
          072A251C382D3AD0A9E42097CB21B69D05DF62187C898224565755C55A549C76
          9FBE80A8E56204B10C42F12D12E4789C8AC9000A548FDFB879E3A7FB15649DD3
          D92C15323F36C83952AA91A155C7020A59B2C5E7F1D7481A2EDE11C5B1ACB4EC
          78A55AFCC6F365481C163DF228865BE108F92AC0E192C8B090CB0975B373B3B9
          FB011C550E092DB0B91AD9A6BDA74C89E5663D4889401642EB78C69F85DBDBE8
          C6A6C64629ADDAF76D72E158239340097D571B8C19562586D9C8FA46FF959919
          FF5ECDACB1A1D1A166959E5A45AAF6118C834010AE0BC56439899FD0E05EBE5B
          68FB5DAE8AA2A2A227185ABED4EBF9583476F9BB8971E1413A66F3A38F49743A
          6DBBD16874320CB31D8D6E5CFEE2ECB07FCF6EFA6FE921E01FF5277ADCC83C3A
          4D1F7A0000000049454E44AE426082}
        FriendlyName = 'BTNCODIGO_PRODUCTO_INI'
        TransparentColor = clNone
        JpegOptions.CompressionQuality = 90
        JpegOptions.Performance = jpBestSpeed
        JpegOptions.ProgressiveEncoding = False
        JpegOptions.Smoothing = True
      end
      object BTNCODIGO_PRODUCTO_FIN: TIWImage
        Left = 305
        Top = 45
        Width = 22
        Height = 21
        Cursor = crHandPoint
        Hint = 'Buscar'
        ParentShowHint = True
        BorderOptions.Width = 0
        UseSize = True
        OnAsyncClick = BTNCODIGO_PRODUCTO_FINAsyncClick
        Picture.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D49484452000000180000
          00180806000000E0773DF80000042C4944415478DAED94DB4F9B7518C79FA727
          DAB77DE9017AA087C8A914282301A21820960D10861A25E30225BBDA96A8376A
          624C3CFC01CE7557A2DECC1997186346614EC93615641886BAB5890ED8686530
          683B2CB495B7941EDEBEFDF9838B65C60577A157EE9BBCF9E5CDEFF0799EEFEF
          F73C08FFB1F021E07F0C709F70BF98CD64DC335452A9B477E4DC287FEF7C7FDF
          21659EE4C7DADADAAAC562F14BAFBCF6EAE80303DE7BF7B83DB5BD7DF5D2B7DF
          A843A130A9ADA9A9BB70E9E2FCBD6B7A7B0EBA66E7E7266D561B1CECE9898845
          A2E637DF797B794FC087431F18BC3EEF5193D1D4CFF37CC3E4E424B02C4B3639
          6E4822919ECE643303C5C57A9E650B3F5B5D597EABB0903D9C4824A0B3A393C8
          A4D2AB80385CED709C1A187C21FE37C0A867C44E871FA80C1CC741201000A552
          09347D585B5B03111D556C2168B55A48D0F9782C0A269309B27C1652A914D439
          EBA0A9A9094A4CA6D53C21AD4F3DF374F02F80F3E7BE1C4BA7D3BD13DF4F80D7
          EB25740AA51209102AA432984AA0BBB363F7FFFCD763B8F9479CECEC1789443B
          DB894C26C327BBBAA0D6E9241A8DE673D7FEF6C1BB8091614F4530185CA05688
          16177F03BFDF0FA15008D46A35A8942AE07339D068B4D0EE7285552A9574D8E3
          D167D229A097BF1BDCCED8D5D909E5E5E5749D6627B64C369B2D7DB6EFB9DF77
          01A74F7DECC9E7F37DC15010E3F1382C2EDE22D7BCD71029DF68341025A3C41C
          85E404E1239A82961E3840ADDBCD8CA600399E27D41EDC399C5132C462B1608E
          CF8D1C3976F4109E3CE16E189F18F7E636D7C16E2B4156AB83709423533FFB50
          A160805A405A5B5B7179690962B1D8108D476B369B07AD362BF12FF8D1A0D703
          7D18C456A4C20AAB0954851A128C72C86504D271A0A309EBF7D59FB1CA85C38A
          AD355262D4A3C6500232AD910456EEE0959BAB5069AF24DDDDDD18F007C0E7F3
          1DA1004D4B4BCB49BBDD4EA6A7A7D11FF0039B8A1096A4B1D46A8622A389C8B5
          46BC7E7B0D7C81E0A758EF746ED9B221A6AA98018B560952050B495E80782607
          677F8980B9B4728AFABE9A4C2667E92370D33B1629148AD7E957452DB345C32B
          072A251C382D3AD0A9E42097CB21B69D05DF62187C898224565755C55A549C76
          9FBE80A8E56204B10C42F12D12E4789C8AC9000A548FDFB879E3A7FB15649DD3
          D92C15323F36C83952AA91A155C7020A59B2C5E7F1D7481A2EDE11C5B1ACB4EC
          78A55AFCC6F365481C163DF228865BE108F92AC0E192C8B090CB0975B373B3B9
          FB011C550E092DB0B91AD9A6BDA74C89E5663D4889401642EB78C69F85DBDBE8
          C6A6C64629ADDAF76D72E158239340097D571B8C19562586D9C8FA46FF959919
          FF5ECDACB1A1D1A166959E5A45AAF6118C834010AE0BC56439899FD0E05EBE5B
          68FB5DAE8AA2A2A227185ABED4EBF9583476F9BB8971E1413A66F3A38F49743A
          6DBBD16874320CB31D8D6E5CFEE2ECB07FCF6EFA6FE921E01FF5277ADCC83C3A
          4D1F7A0000000049454E44AE426082}
        FriendlyName = 'BTNCODIGO_PRODUCTO_FIN'
        TransparentColor = clNone
        JpegOptions.CompressionQuality = 90
        JpegOptions.Performance = jpBestSpeed
        JpegOptions.ProgressiveEncoding = False
        JpegOptions.Smoothing = True
      end
      object CODIGO_PRODUCTO_INI: TIWEdit
        Left = 106
        Top = 13
        Width = 191
        Height = 23
        StyleRenderOptions.RenderBorder = False
        Alignment = taRightJustify
        Font.Color = clNone
        Font.Size = 10
        Font.Style = []
        FriendlyName = 'CODIGO_PRODUCTO_INI'
        SubmitOnAsyncEvent = True
        TabOrder = 3
      end
      object CODIGO_PRODUCTO_FIN: TIWEdit
        Left = 106
        Top = 44
        Width = 191
        Height = 23
        StyleRenderOptions.RenderBorder = False
        Alignment = taRightJustify
        Font.Color = clNone
        Font.Size = 10
        Font.Style = []
        FriendlyName = 'CODIGO_PRODUCTO_FIN'
        SubmitOnAsyncEvent = True
        TabOrder = 4
      end
      object BTNGENERAR_INVENTARIO: TIWButton
        Left = 360
        Top = 26
        Width = 120
        Height = 30
        Caption = 'GENERAR'
        Color = clBtnFace
        Font.Color = clNone
        Font.Size = 10
        Font.Style = []
        FriendlyName = 'BTNGENERAR_INVENTARIO'
        OnAsyncClick = BTNGENERAR_INVENTARIOAsyncClick
      end
      object IWLabel1: TIWLabel
        Left = 10
        Top = 18
        Width = 95
        Height = 16
        Font.Color = clNone
        Font.Size = 10
        Font.Style = []
        NoWrap = True
        HasTabOrder = False
        FriendlyName = 'IWLabel1'
        Caption = 'Producto Inicial'
      end
      object IWLabel2: TIWLabel
        Left = 10
        Top = 47
        Width = 89
        Height = 16
        Font.Color = clNone
        Font.Size = 10
        Font.Style = []
        NoWrap = True
        HasTabOrder = False
        FriendlyName = 'IWLabel2'
        Caption = 'Producto Final'
      end
    end
    object PAG01: TIWjQTabPage
      Left = 1
      Top = 38
      Width = 604
      Height = 187
      RenderInvisibleControls = True
      Caption = 'Consumo por area'
      PageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object CODIGO_AREA: TIWEdit
        Left = 105
        Top = 15
        Width = 105
        Height = 23
        StyleRenderOptions.RenderBorder = False
        Alignment = taRightJustify
        Font.Color = clNone
        Font.Size = 10
        Font.Style = []
        FriendlyName = 'CODIGO_AREA'
        SubmitOnAsyncEvent = True
        TabOrder = 2
      end
      object BTNCODIGO_AREA: TIWImage
        Left = 216
        Top = 15
        Width = 22
        Height = 21
        Cursor = crHandPoint
        Hint = 'Buscar'
        ParentShowHint = True
        BorderOptions.Width = 0
        UseSize = True
        OnAsyncClick = BTNCODIGO_AREAAsyncClick
        Picture.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D49484452000000180000
          00180806000000E0773DF80000042C4944415478DAED94DB4F9B7518C79FA727
          DAB77DE9017AA087C8A914282301A21820960D10861A25E30225BBDA96A8376A
          624C3CFC01CE7557A2DECC1997186346614EC93615641886BAB5890ED8686530
          683B2CB495B7941EDEBEFDF9838B65C60577A157EE9BBCF9E5CDEFF0799EEFEF
          F73C08FFB1F021E07F0C709F70BF98CD64DC335452A9B477E4DC287FEF7C7FDF
          21659EE4C7DADADAAAC562F14BAFBCF6EAE80303DE7BF7B83DB5BD7DF5D2B7DF
          A843A130A9ADA9A9BB70E9E2FCBD6B7A7B0EBA66E7E7266D561B1CECE9898845
          A2E637DF797B794FC087431F18BC3EEF5193D1D4CFF37CC3E4E424B02C4B3639
          6E4822919ECE643303C5C57A9E650B3F5B5D597EABB0903D9C4824A0B3A393C8
          A4D2AB80385CED709C1A187C21FE37C0A867C44E871FA80C1CC741201000A552
          09347D585B5B03111D556C2168B55A48D0F9782C0A269309B27C1652A914D439
          EBA0A9A9094A4CA6D53C21AD4F3DF374F02F80F3E7BE1C4BA7D3BD13DF4F80D7
          EB25740AA51209102AA432984AA0BBB363F7FFFCD763B8F9479CECEC1789443B
          DB894C26C327BBBAA0D6E9241A8DE673D7FEF6C1BB8091614F4530185CA05688
          16177F03BFDF0FA15008D46A35A8942AE07339D068B4D0EE7285552A9574D8E3
          D167D229A097BF1BDCCED8D5D909E5E5E5749D6627B64C369B2D7DB6EFB9DF77
          01A74F7DECC9E7F37DC15010E3F1382C2EDE22D7BCD71029DF68341025A3C41C
          85E404E1239A82961E3840ADDBCD8CA600399E27D41EDC399C5132C462B1608E
          CF8D1C3976F4109E3CE16E189F18F7E636D7C16E2B4156AB83709423533FFB50
          A160805A405A5B5B7179690962B1D8108D476B369B07AD362BF12FF8D1A0D703
          7D18C456A4C20AAB0954851A128C72C86504D271A0A309EBF7D59FB1CA85C38A
          AD355262D4A3C6500232AD910456EEE0959BAB5069AF24DDDDDD18F007C0E7F3
          1DA1004D4B4BCB49BBDD4EA6A7A7D11FF0039B8A1096A4B1D46A8622A389C8B5
          46BC7E7B0D7C81E0A758EF746ED9B221A6AA98018B560952050B495E80782607
          677F8980B9B4728AFABE9A4C2667E92370D33B1629148AD7E957452DB345C32B
          072A251C382D3AD0A9E42097CB21B69D05DF62187C898224565755C55A549C76
          9FBE80A8E56204B10C42F12D12E4789C8AC9000A548FDFB879E3A7FB15649DD3
          D92C15323F36C83952AA91A155C7020A59B2C5E7F1D7481A2EDE11C5B1ACB4EC
          78A55AFCC6F365481C163DF228865BE108F92AC0E192C8B090CB0975B373B3B9
          FB011C550E092DB0B91AD9A6BDA74C89E5663D4889401642EB78C69F85DBDBE8
          C6A6C64629ADDAF76D72E158239340097D571B8C19562586D9C8FA46FF959919
          FF5ECDACB1A1D1A166959E5A45AAF6118C834010AE0BC56439899FD0E05EBE5B
          68FB5DAE8AA2A2A227185ABED4EBF9583476F9BB8971E1413A66F3A38F49743A
          6DBBD16874320CB31D8D6E5CFEE2ECB07FCF6EFA6FE921E01FF5277ADCC83C3A
          4D1F7A0000000049454E44AE426082}
        FriendlyName = 'BTNCODIGO_AREA'
        TransparentColor = clNone
        JpegOptions.CompressionQuality = 90
        JpegOptions.Performance = jpBestSpeed
        JpegOptions.ProgressiveEncoding = False
        JpegOptions.Smoothing = True
      end
      object BTNAREA: TIWButton
        Left = 282
        Top = 40
        Width = 191
        Height = 30
        Caption = 'GENERAR'
        Color = clBtnFace
        Font.Color = clNone
        Font.Size = 10
        Font.Style = []
        FriendlyName = 'BTNAREA'
        OnAsyncClick = BTNAREAAsyncClick
      end
      object IWLabel3: TIWLabel
        Left = 10
        Top = 16
        Width = 29
        Height = 16
        Font.Color = clNone
        Font.Size = 10
        Font.Style = []
        HasTabOrder = False
        FriendlyName = 'IWLabel3'
        Caption = 'Area'
      end
      object IWLabel4: TIWLabel
        Left = 10
        Top = 48
        Width = 78
        Height = 16
        Font.Color = clNone
        Font.Size = 10
        Font.Style = []
        HasTabOrder = False
        FriendlyName = 'IWLabel4'
        Caption = 'Fecha Inicial'
      end
      object IWLabel5: TIWLabel
        Left = 10
        Top = 76
        Width = 71
        Height = 16
        Font.Color = clNone
        Font.Size = 10
        Font.Style = []
        HasTabOrder = False
        FriendlyName = 'IWLabel5'
        Caption = 'Fecha Final'
      end
      object FECHA_INI: TIWEdit
        Left = 105
        Top = 44
        Width = 105
        Height = 24
        StyleRenderOptions.RenderBorder = False
        Font.Color = clNone
        Font.Size = 10
        Font.Style = []
        FriendlyName = 'FECHA_INI'
        SubmitOnAsyncEvent = True
        Text = 'FECHA_INI'
      end
      object FECHA_FIN: TIWEdit
        Left = 106
        Top = 72
        Width = 104
        Height = 24
        StyleRenderOptions.RenderBorder = False
        Font.Color = clNone
        Font.Size = 10
        Font.Style = []
        FriendlyName = 'FECHA_FIN'
        SubmitOnAsyncEvent = True
        Text = 'FECHA_FIN'
      end
      object ID_FECHA: TIWRadioGroup
        Left = 101
        Top = 115
        Width = 172
        Height = 42
        SubmitOnAsyncEvent = True
        RawText = False
        Editable = True
        Font.Color = clNone
        Font.Size = 10
        Font.Style = []
        FriendlyName = 'ID_FECHA'
        ItemIndex = 0
        Items.Strings = (
          'Fecha de registro'
          'Fecha de movimiento')
        Layout = glVertical
      end
      object IWLabel6: TIWLabel
        Left = 10
        Top = 125
        Width = 85
        Height = 16
        Font.Color = clNone
        Font.Size = 10
        Font.Style = []
        NoWrap = True
        HasTabOrder = False
        FriendlyName = 'IWLabel6'
        Caption = 'Tipo de fecha'
      end
    end
  end
  object IWModalWindow1: TIWModalWindow
    Left = 176
    Top = 8
  end
  object IWProgressIndicator1: TIWProgressIndicator
    Mode = pimAsync
    ProgressTextSettings.Text = 'Please wait...'
    ProgressTextSettings.Font.Color = clNone
    ProgressTextSettings.Font.FontFamily = 'Arial, Sans-Serif, Verdana'
    ProgressTextSettings.Font.Size = 12
    ProgressTextSettings.Font.Style = []
    Left = 304
    Top = 8
  end
end
