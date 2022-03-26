object FrIWMovto_Inventario: TFrIWMovto_Inventario
  Left = 0
  Top = 0
  Width = 1341
  Height = 593
  RenderInvisibleControls = True
  AllowPageAccess = True
  ConnectionMode = cmAny
  OnCreate = IWAppFormCreate
  OnDestroy = IWAppFormDestroy
  Background.Fixed = False
  HandleTabs = False
  LeftToRight = True
  LockUntilLoaded = True
  LockOnSubmit = True
  ShowHint = True
  DesignLeft = -101
  DesignTop = 2
  object RINFO: TIWRegion
    Left = 0
    Top = 0
    Width = 1341
    Height = 26
    HorzScrollBar.Visible = False
    VertScrollBar.Visible = False
    RenderInvisibleControls = True
    Align = alTop
    BorderOptions.NumericWidth = 0
    Color = clWebMEDIUMBLUE
    object lbInfo: TIWLabel
      Left = 0
      Top = 0
      Width = 1341
      Height = 26
      Align = alClient
      Alignment = taCenter
      Font.Color = clWebWHITE
      Font.Size = 12
      Font.Style = [fsBold]
      NoWrap = True
      HasTabOrder = False
      FriendlyName = 'lbInfo'
      Caption = 'lbInfo'
      ExplicitLeft = 2
      ExplicitTop = 4
      ExplicitWidth = 1339
      ExplicitHeight = 24
    end
  end
  object IWRegion1: TIWRegion
    Left = 0
    Top = 58
    Width = 1341
    Height = 535
    RenderInvisibleControls = True
    Align = alClient
    object PAGINAS: TIWTabControl
      Left = 1
      Top = 1
      Width = 1339
      Height = 533
      RenderInvisibleControls = True
      ActiveTabFont.Color = clWebWHITE
      ActiveTabFont.FontFamily = 'Arial, Sans-Serif, Verdana'
      ActiveTabFont.Size = 10
      ActiveTabFont.Style = [fsBold]
      InactiveTabFont.Color = clWebBLACK
      InactiveTabFont.FontFamily = 'Arial, Sans-Serif, Verdana'
      InactiveTabFont.Size = 10
      InactiveTabFont.Style = []
      ActiveTabColor = clWebDARKGRAY
      InactiveTabColor = clWebLIGHTGRAY
      ActivePage = 0
      Align = alClient
      BorderOptions.NumericWidth = 0
      BorderOptions.Style = cbsNone
      Color = clWebSILVER
      ClipRegion = False
      TabPadding = 10
      TabRowHeight = 30
      TabHeight = 40
      TabBorderRadius = 10
      ActiveTabBorder.Color = clWebBLACK
      ActiveTabBorder.Width = 0
      InactiveTabBorder.Color = clWebBLACK
      InactiveTabBorder.Width = 0
      DesignSize = (
        1339
        533)
      object PAG_01: TIWTabPage
        Left = 0
        Top = 30
        Width = 1339
        Height = 503
        RenderInvisibleControls = True
        TabOrder = 1
        Title = '[          Datos B'#225'sicos          ]'
        BorderOptions.NumericWidth = 0
        BorderOptions.Style = cbsNone
        Color = clWebWHITE
        object IWLabel1: TIWLabel
          Left = 10
          Top = 11
          Width = 49
          Height = 16
          RenderSize = False
          StyleRenderOptions.RenderSize = False
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          NoWrap = True
          HasTabOrder = False
          FriendlyName = 'IWLabel1'
          Caption = 'N'#250'mero'
        end
        object IWLabel8: TIWLabel
          Left = 10
          Top = 136
          Width = 49
          Height = 16
          RenderSize = False
          StyleRenderOptions.RenderSize = False
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          NoWrap = True
          HasTabOrder = False
          FriendlyName = 'IWLabel8'
          Caption = 'Nombre'
        end
        object IWLabel3: TIWLabel
          Left = 10
          Top = 266
          Width = 77
          Height = 16
          RenderSize = False
          StyleRenderOptions.RenderSize = False
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          NoWrap = True
          HasTabOrder = False
          FriendlyName = 'IWLabel3'
          Caption = 'Vencimiento'
        end
        object NUMERO: TIWDBLabel
          Left = 133
          Top = 10
          Width = 148
          Height = 21
          Alignment = taRightJustify
          BGColor = cl3DLight
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          NoWrap = True
          HasTabOrder = False
          AutoSize = False
          DataField = 'NUMERO'
          FriendlyName = 'NUMERO'
        end
        object lbTercero: TIWLabel
          Left = 10
          Top = 61
          Width = 49
          Height = 16
          RenderSize = False
          StyleRenderOptions.RenderSize = False
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          NoWrap = True
          HasTabOrder = False
          FriendlyName = 'lbTercero'
          Caption = 'Tercero'
        end
        object BTNCODIGO_TERCERO: TIWImage
          Left = 289
          Top = 58
          Width = 22
          Height = 21
          Cursor = crHandPoint
          Hint = 'Buscar'
          ParentShowHint = True
          BorderOptions.Width = 0
          UseSize = True
          OnAsyncClick = BTNCODIGO_TERCEROAsyncClick
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
          FriendlyName = 'BTNCODIGO_TERCERO'
          TransparentColor = clNone
          JpegOptions.CompressionQuality = 90
          JpegOptions.Performance = jpBestSpeed
          JpegOptions.ProgressiveEncoding = False
          JpegOptions.Smoothing = True
        end
        object CODIGO_TERCERO: TIWDBLabel
          Left = 133
          Top = 59
          Width = 148
          Height = 21
          Alignment = taRightJustify
          BGColor = cl3DLight
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          NoWrap = True
          HasTabOrder = False
          AutoSize = False
          DataField = 'CODIGO_TERCERO'
          FriendlyName = 'CODIGO_TERCERO'
        end
        object lbNombre_Tercero: TIWLabel
          Left = 345
          Top = 61
          Width = 129
          Height = 16
          RenderSize = False
          StyleRenderOptions.RenderSize = False
          Font.Color = clWebNAVY
          Font.Size = 10
          Font.Style = [fsBold]
          NoWrap = True
          HasTabOrder = False
          FriendlyName = 'lbNombre_Tercero'
          Caption = 'lbNombre_Tercero'
        end
        object IWLabel6: TIWLabel
          Left = 10
          Top = 86
          Width = 55
          Height = 16
          RenderSize = False
          StyleRenderOptions.RenderSize = False
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          NoWrap = True
          HasTabOrder = False
          FriendlyName = 'IWLabel6'
          Caption = 'Producto'
        end
        object BTNCODIGO_PRODUCTO: TIWImage
          Left = 289
          Top = 83
          Width = 22
          Height = 21
          Cursor = crHandPoint
          Hint = 'Buscar'
          ParentShowHint = True
          BorderOptions.Width = 0
          UseSize = True
          OnAsyncClick = BTNCODIGO_PRODUCTOAsyncClick
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
          FriendlyName = 'BTNCODIGO_PRODUCTO'
          TransparentColor = clNone
          JpegOptions.CompressionQuality = 90
          JpegOptions.Performance = jpBestSpeed
          JpegOptions.ProgressiveEncoding = False
          JpegOptions.Smoothing = True
        end
        object CODIGO_PRODUCTO: TIWDBLabel
          Left = 133
          Top = 84
          Width = 148
          Height = 21
          Alignment = taRightJustify
          BGColor = cl3DLight
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          NoWrap = True
          HasTabOrder = False
          AutoSize = False
          DataField = 'CODIGO_PRODUCTO'
          FriendlyName = 'CODIGO_PRODUCTO'
        end
        object lbNombre_Producto: TIWLabel
          Left = 321
          Top = 88
          Width = 123
          Height = 13
          RenderSize = False
          StyleRenderOptions.RenderSize = False
          Font.Color = clWebNAVY
          Font.Size = 8
          Font.Style = [fsBold]
          NoWrap = True
          HasTabOrder = False
          FriendlyName = 'lbNombre_Producto'
          Caption = 'lbNombre_Producto'
        end
        object lbInfoRegistro: TIWLabel
          Left = 286
          Top = 243
          Width = 101
          Height = 16
          RenderSize = False
          StyleRenderOptions.RenderSize = False
          Font.Color = clWebNAVY
          Font.Size = 10
          Font.Style = [fsBold, fsUnderline]
          NoWrap = True
          HasTabOrder = False
          FriendlyName = 'lbInfoRegistro'
          Caption = 'lbInfoRegistro'
        end
        object IWLabel9: TIWLabel
          Left = 10
          Top = 188
          Width = 71
          Height = 16
          RenderSize = False
          StyleRenderOptions.RenderSize = False
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          HasTabOrder = False
          FriendlyName = 'IWLabel9'
          Caption = 'Descripci'#243'n'
        end
        object IWLabel11: TIWLabel
          Left = 10
          Top = 291
          Width = 55
          Height = 16
          RenderSize = False
          StyleRenderOptions.RenderSize = False
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          NoWrap = True
          HasTabOrder = False
          FriendlyName = 'IWLabel11'
          Caption = 'Cantidad'
        end
        object BTNCREARTERCERO: TIWImage
          Left = 319
          Top = 56
          Width = 22
          Height = 21
          Cursor = crHandPoint
          Hint = 'Crear'
          ParentShowHint = True
          BorderOptions.Width = 0
          UseSize = True
          OnAsyncClick = BTNCREARTERCEROAsyncClick
          Picture.Data = {
            0954506E67496D61676589504E470D0A1A0A0000000D49484452000000200000
            00200806000000737A7AF4000008AD4944415478DAC55779901C551DFEFA9A99
            9E7B76AEDD9DBDC8EE2A95C3AC0608184D306C5248455218128C811C12089665
            D0120B4AFE30FE8105259692D2927024210462920A9052283587244A144274A3
            4984DADD64AF99CDCEB1B333D373F7E1AF7B7A63B2B0A288C5AB7AF3AAA6DFEB
            EFFB5DDFFB35838F7930FFCD66F508045A449A6E3AE9A2D5663E2A41438ED62C
            CD227B13AA1F19010265E8E522FD462A05CB12B9E2EED6F8C06C580361081EBB
            B1A99A29A09C1C63E4E419DE923D6CB1570E691AA20C6390D13E3401E530047A
            49733167DF202B6DEB2D4DD73609911BC0BA6601D64680739B1BC9F0720C6AEE
            2CAAD13FA132727284E706768AAEC20E2232CC754FEF9169092847605765F6F3
            D278D363B6B6C5732D9DB781717681E13D74CA4293A35DECA49F004DA1598126
            67A0493DA8F4BE8CD2C0D1D3CEBA9107595EFD0377130AFF3101E5281CD512BF
            A2989BF913C7A757D7F18DB700163F6D26408635C17973450D1CB24942259F13
            A14A0A72EC35E4FFBA675C749DFBB660950F1089FC071220B75BE50AB73C9F9D
            FDB4EBBA0D6E2EB4900CE568A36282531E3256FA8F26C39B04085C2DD3AACFAA
            4982C8A90A94F871E4DEDA9175B8CFDCC30BCA416E09CAD312207096CECE9BB8
            38E325F7356B9BB8C88D60980ABDB0402B81B15400ACA3B6325308E8E06A9166
            DE5835FD3FC64EAB054AF47564DFDE35E2AD3FFF65CAA95344427D5F02EA2104
            26E2DE676C9165CB2D735691B12E30CA28BD5C22E30998A3CA6329F119D1CC83
            CB09E8447502146A25474EA0957140E31AC829122A7FDF8B52F4D7073DA1898D
            4420F91E02CA2170D52AFB25293567BFE7B377F16C703E8598402BFFA0876335
            CB39A74180616C2601330935B596805AC92420D53CC1852977AEA6D428404DBC
            89CC89DDB2D3FFB79582A0FE8A4828571238026F7AD4BD530C2E5A6E9DBD148C
            FB1A7A3F0114DFA28729035C2312CFEE3E8DB1848CEFDEDF0DABD56A9C2D97CB
            F8D11387110EF2B8FBCEB96074709D04E727D9BA8EF8514E64DF46F9CCEF504C
            1C3BE8ABCFAEA7D29CB882807C083313032D6FF8665DEFE51A3BC13A3F490F49
            DC2AEFD22EDAC6BA902DF058F5951750E7F1E0BECD8BB1E873571B678FFDF11D
            3CB9F528C63319ECFBE51AB8ED7A52D2591201C303704295DE8512EB45FAEC9F
            27826D430BF82538778900251F57CC73AB8BA98EE7DDB3DAC1BA6D9463147F56
            4FBE6A4D705827B2451BBAAE7D020C95DBB6A737A1FB0B1D0681C3BFEFC3A67B
            B641A3B2EC39793FDCA21E0AA9960B1A4F1EA0642CE7A0664BC89EED87E8EFBB
            4BB42B7BF4304C12B0A493D61F7095190F899D5E0AB34C0948556F943AC59AF3
            982170E291AD31F4F60EE0C99FAE8068AD095CB12CE0BE6F1D4067671B1EDEDC
            4821906A21504894940A543D47ABA40EE4C162EF0414CBF947BDFEF2F7C90B95
            4902F678D4FE0B916D5A6B6DE3C1D92BB572E7199A3C9170191E302AC03A1310
            1AE8FAE9B952096D5D742750C594CFD512914868BA076499A666C88352B0A03C
            20A3A88EEC0A3616BE4E040A8C99808E8B438E1D7636BCD2D642C63A8800AF9A
            53F782ED5F040C019A2CC1CBA5D82C455D902E1128D5FE9659632A790B4A4340
            411DDB1F6ECE6FE0BB9167CC04B48F0EDBB739B4E09D6213B9DE4721E014F40E
            56702126E38B8BC90B06B0CD24204C7317544D4524605A0FFEA68A4F7DC28296
            06811E7350D31482118D5013BBEB9B0A9B84A5A607AA8760198D5A7F285642DF
            71345008820A1928A34A52BAE5E712D6ADB0606607635A2EC074CB6545A49904
            64538A2B38D7A7E1F9972AD8F20D2738DAABC93C940487FC2885C012FF717D63
            F97B96A5660E547F0B2E3ECEAD63D2F5CFBA4322F83011A004D3BD909634AC7E
            208F0D2B80D5CB04BA167460CE14A1CB3DA0ABAB42F2AF60EFAB32B61F00F63C
            6E87D7C118D66B94A8F218876C9C64DA77F16EBF4F79CE76B35905FA48BE82AE
            CC60E87830E0770921954AB144183A0915D1741DD63D940623A7B0F656018B17
            08688EB054A2B5E39ADE7D8CAA78FD44153B5FA94221017AEE512F22BE348153
            FC55814AD0866A9C452299CA795AE20B03B7A1E70A21925E85EF429F735F832B
            D26D0F3AC07A73E4059D04798355516266E099BD1EECDFF1062A59092E4A8790
            BFE681784A458E4ADFE276E2F675F371EF6A0956ED0201EBE0BAF536A8132E14
            12798CE6A2875BDBA555EE65484F25C08D8CB16BEC85C8765F7D0BC77BC87A27
            59CD110946274171E69D28F137E0E49B227A7B3248C7268CF07B1A3CE8ECF261
            FEF505D8941394D5790226D76B04AED8E82EF341CE08485F1C520AF6E8D71A02
            EA0B9E5BA7DC05862507101E3CEFDCD71A6C5FE80837D3AD4B04AC4922513448
            9004D2AA19FD81AE8E8CD19211904A2D994C931447D3E895DA24B848D607E876
            F6213F368CC144FFF196ABA455E1DB31F6BED771EA65B0B11416B399F0DE86E6
            5975622042499F20CB2F920748DB49960D22BAD9535B19ADF63A1D181A959D4A
            E225D7535104514C46313A7C765C758FDD11AEC3D1D08A69FA017DC4F6C3D637
            C4DDDBC0373E1668FD8CCD1668A3AACBD0932881D3ADC8E85D55B596F9971A5E
            C6AC082A518D7A008D6E4144A8F43C282507901CFC4B69548E3D38A34979AAE9
            0E6AE1A7EB882647FF8B70F50E709BDBC4C687832D5DA2D838179C8D6A5F1B27
            5CEA2534FD26A5E683914DEB7555D49B142FF108D05A07A544F51E3B8DC4504F
            71A0187BA4A355D9DAB1C6F876C00712D0C73BBBE0E81F66BEEA67FC5B5A23ED
            8DF6C83CEA4B3BC05AE81381D581E5291ED06F3D1E6AA548FD681F0AD153188C
            F6C7525A6ACB5511EDC599EBDFDB90FE5B02FA38BB1DC2581A5DE349EB03ED75
            FE5BC2C166A7D5DF0EC1DB0ADE4549EA08D564281F879C1B46756210E5543F35
            2CC352FF78EA355FA0FC78C8839E391B3FC477C125123BC048053846C7314FCA
            F22B3D82B828E472B4789D4EBBCDEA30FAF25239AF4C4852219ECB0F65AAC563
            4EB7BCBFDE8753A20DF9B91BFF872FA3A9E3C4CF20484578B379444A55441415
            1EFD7F8E45C62A20EAB623EA1431B1E09B1FE1B7E1FF7B7CEC04FE09D684E34E
            FD57E9680000000049454E44AE426082}
          FriendlyName = 'BTNCREARTERCERO'
          TransparentColor = clNone
          JpegOptions.CompressionQuality = 90
          JpegOptions.Performance = jpBestSpeed
          JpegOptions.ProgressiveEncoding = False
          JpegOptions.Smoothing = True
        end
        object IWLabel2: TIWLabel
          Left = 10
          Top = 36
          Width = 130
          Height = 16
          RenderSize = False
          StyleRenderOptions.RenderSize = False
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          NoWrap = True
          HasTabOrder = False
          FriendlyName = 'IWLabel2'
          Caption = 'Orden de Producci'#243'n'
        end
        object BTNOP: TIWImage
          Left = 587
          Top = 33
          Width = 22
          Height = 21
          Cursor = crHandPoint
          Hint = 'Buscar'
          ParentShowHint = True
          BorderOptions.Width = 0
          UseSize = True
          OnAsyncClick = BTNOPAsyncClick
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
          FriendlyName = 'BTNOP'
          TransparentColor = clNone
          JpegOptions.CompressionQuality = 90
          JpegOptions.Performance = jpBestSpeed
          JpegOptions.ProgressiveEncoding = False
          JpegOptions.Smoothing = True
        end
        object CODIGO_DOCUMENTO_OP: TIWDBLabel
          Left = 133
          Top = 35
          Width = 291
          Height = 21
          BGColor = cl3DLight
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          NoWrap = True
          HasTabOrder = False
          AutoSize = False
          DataField = 'CODIGO_DOCUMENTO_OP'
          FriendlyName = 'CODIGO_DOCUMENTO_OP'
        end
        object NUMERO_OP: TIWDBLabel
          Left = 430
          Top = 34
          Width = 148
          Height = 21
          Alignment = taRightJustify
          BGColor = cl3DLight
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          NoWrap = True
          HasTabOrder = False
          AutoSize = False
          DataField = 'NUMERO_OP'
          FriendlyName = 'NUMERO_OP'
        end
        object lbInfoOP: TIWLabel
          Left = 287
          Top = 270
          Width = 59
          Height = 16
          RenderSize = False
          StyleRenderOptions.RenderSize = False
          Font.Color = clWebNAVY
          Font.Size = 10
          Font.Style = [fsBold, fsUnderline]
          NoWrap = True
          HasTabOrder = False
          FriendlyName = 'lbInfoOP'
          Caption = 'lbInfoOP'
        end
        object IWLabel4: TIWLabel
          Left = 10
          Top = 316
          Width = 85
          Height = 16
          RenderSize = False
          StyleRenderOptions.RenderSize = False
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          NoWrap = True
          HasTabOrder = False
          FriendlyName = 'IWLabel4'
          Caption = 'Valor Unitario'
        end
        object lbInfoTotal: TIWLabel
          Left = 287
          Top = 322
          Width = 75
          Height = 16
          RenderSize = False
          StyleRenderOptions.RenderSize = False
          Font.Color = clWebNAVY
          Font.Size = 10
          Font.Style = [fsBold, fsUnderline]
          NoWrap = True
          HasTabOrder = False
          FriendlyName = 'lbInfoTotal'
          Caption = 'lbInfoTotal'
        end
        object IWLabel5: TIWLabel
          Left = 10
          Top = 241
          Width = 71
          Height = 16
          RenderSize = False
          StyleRenderOptions.RenderSize = False
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          NoWrap = True
          HasTabOrder = False
          FriendlyName = 'IWLabel3'
          Caption = 'Movimiento'
        end
        object NOMBRE: TIWDBEdit
          Left = 133
          Top = 135
          Width = 445
          Height = 24
          StyleRenderOptions.RenderBorder = False
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          FriendlyName = 'NOMBRE'
          SubmitOnAsyncEvent = True
          AutoEditable = False
          DataField = 'NOMBRE'
          PasswordPrompt = False
        end
        object DESCRIPCION: TIWDBMemo
          Left = 133
          Top = 161
          Width = 445
          Height = 73
          StyleRenderOptions.RenderBorder = False
          BGColor = clNone
          Editable = True
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          InvisibleBorder = False
          HorizScrollBar = False
          VertScrollBar = True
          Required = False
          SubmitOnAsyncEvent = True
          ResizeDirection = rdNone
          AutoEditable = False
          DataField = 'DESCRIPCION'
          FriendlyName = 'DESCRIPCION'
        end
        object FECHA_MOVIMIENTO: TIWDBEdit
          Left = 133
          Top = 238
          Width = 148
          Height = 25
          StyleRenderOptions.RenderBorder = False
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          FriendlyName = 'FECHA_MOVIMIENTO'
          SubmitOnAsyncEvent = True
          AutoEditable = False
          DataField = 'FECHA_MOVIMIENTO'
          PasswordPrompt = False
        end
        object FECHA_VENCIMIENTO: TIWDBEdit
          Left = 133
          Top = 266
          Width = 147
          Height = 24
          StyleRenderOptions.RenderBorder = False
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          FriendlyName = 'FECHA_VENCIMIENTO'
          SubmitOnAsyncEvent = True
          AutoEditable = False
          DataField = 'FECHA_VENCIMIENTO'
          PasswordPrompt = False
        end
        object CANTIDAD: TIWDBEdit
          Left = 133
          Top = 292
          Width = 148
          Height = 24
          StyleRenderOptions.RenderBorder = False
          Alignment = taRightJustify
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          FriendlyName = 'CANTIDAD'
          SubmitOnAsyncEvent = True
          OnAsyncExit = CANTIDADAsyncExit
          AutoEditable = False
          DataField = 'CANTIDAD'
          PasswordPrompt = False
        end
        object VALOR_UNITARIO: TIWDBEdit
          Left = 133
          Top = 319
          Width = 148
          Height = 24
          StyleRenderOptions.RenderBorder = False
          Alignment = taRightJustify
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          FriendlyName = 'VALOR_UNITARIO'
          SubmitOnAsyncEvent = True
          AutoEditable = False
          DataField = 'VALOR_UNITARIO'
          PasswordPrompt = False
        end
        object ID_ACTIVO: TIWDBCheckBox
          Left = 10
          Top = 343
          Width = 121
          Height = 21
          Caption = 'Activo'
          Editable = True
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          SubmitOnAsyncEvent = True
          Style = stNormal
          AutoEditable = False
          DataField = 'ID_ACTIVO'
          FriendlyName = 'ID_ACTIVO'
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object IWLabel7: TIWLabel
          Left = 10
          Top = 109
          Width = 29
          Height = 16
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          HasTabOrder = False
          FriendlyName = 'IWLabel7'
          Caption = 'Area'
        end
        object CODIGO_AREA: TIWDBLabel
          Left = 133
          Top = 109
          Width = 148
          Height = 21
          Alignment = taRightJustify
          BGColor = cl3DLight
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          NoWrap = True
          HasTabOrder = False
          AutoSize = False
          DataField = 'CODIGO_AREA'
          FriendlyName = 'CODIGO_AREA'
        end
        object BTNCODIGO_AREA: TIWImage
          Left = 289
          Top = 107
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
        object lbNombre_Area: TIWLabel
          Left = 321
          Top = 112
          Width = 96
          Height = 13
          RenderSize = False
          StyleRenderOptions.RenderSize = False
          Font.Color = clWebNAVY
          Font.Size = 8
          Font.Style = [fsBold]
          NoWrap = True
          HasTabOrder = False
          FriendlyName = 'lbNombre_Area'
          Caption = 'lbNombre_Area'
        end
      end
      object PAG_00: TIWTabPage
        Left = 0
        Top = 30
        Width = 1339
        Height = 503
        RenderInvisibleControls = True
        Title = '[          Registros          ]'
        BorderOptions.NumericWidth = 0
        BorderOptions.Style = cbsNone
        Color = clWebWHITE
      end
    end
  end
  object RNAVEGADOR: TIWRegion
    Left = 0
    Top = 26
    Width = 1341
    Height = 32
    HorzScrollBar.Visible = False
    VertScrollBar.Visible = False
    RenderInvisibleControls = True
    Align = alTop
    BorderOptions.NumericWidth = 0
    Color = clWebMEDIUMBLUE
    object DATO: TIWEdit
      Left = 400
      Top = 0
      Width = 121
      Height = 32
      Hint = 'Busqueda del dato'
      Align = alLeft
      ParentShowHint = True
      StyleRenderOptions.RenderBorder = False
      Font.Color = clNone
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'DATO'
      SubmitOnAsyncEvent = True
      TabOrder = 2
      ExplicitLeft = 513
      ExplicitTop = 6
      ExplicitHeight = 21
    end
    object IWRegion_Navegador: TIWRegion
      Left = 0
      Top = 0
      Width = 400
      Height = 32
      HorzScrollBar.Visible = False
      VertScrollBar.Visible = False
      RenderInvisibleControls = True
      Align = alLeft
      BorderOptions.NumericWidth = 0
      Color = clWebMEDIUMBLUE
    end
  end
  object IWModalWindow1: TIWModalWindow
    Left = 160
    Top = 16
  end
end
