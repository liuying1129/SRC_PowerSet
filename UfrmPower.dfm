object frmPower: TfrmPower
  Left = 158
  Top = 111
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #26435#38480#35774#32622
  ClientHeight = 556
  ClientWidth = 782
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 782
    Height = 556
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = #35282#33394#35774#32622
      object Splitter1: TSplitter
        Left = 505
        Top = 89
        Width = 5
        Height = 439
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 774
        Height = 89
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Label2: TLabel
          Left = 512
          Top = 67
          Width = 260
          Height = 13
          Caption = #27880#65306#22312#32534#36753#26694#20013#25970#22238#36710#38190#21363#21487#20445#23384#25152#20570#30340#20462#25913
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = #23435#20307
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object Label4: TLabel
          Left = 8
          Top = 12
          Width = 52
          Height = 13
          Caption = #36873#25321#31995#32479
        end
        object BitBtn9: TBitBtn
          Left = 512
          Top = 34
          Width = 80
          Height = 25
          Caption = #26032#22686#35282#33394
          TabOrder = 0
          OnClick = BitBtn9Click
        end
        object BitBtn11: TBitBtn
          Left = 691
          Top = 34
          Width = 80
          Height = 25
          Caption = #21024#38500#35282#33394
          TabOrder = 1
          OnClick = BitBtn11Click
        end
        object DBEdtJSname: TDBEdit
          Left = 512
          Top = 9
          Width = 259
          Height = 21
          DataField = #35282#33394
          DataSource = DataSource_js
          TabOrder = 2
          OnKeyDown = DBEdtJSnameKeyDown
        end
        object ComboBox1: TComboBox
          Left = 64
          Top = 9
          Width = 121
          Height = 21
          ItemHeight = 13
          TabOrder = 3
          OnChange = ComboBox1Change
        end
        object BitBtn10: TBitBtn
          Left = 4
          Top = 34
          Width = 58
          Height = 25
          Caption = #26032#22686#26435#38480
          TabOrder = 4
          OnClick = BitBtn10Click
        end
        object BitBtn12: TBitBtn
          Left = 65
          Top = 34
          Width = 58
          Height = 25
          Caption = #20445#23384#26435#38480
          TabOrder = 5
          OnClick = BitBtn12Click
        end
        object BitBtn13: TBitBtn
          Left = 126
          Top = 34
          Width = 58
          Height = 25
          Caption = #21024#38500#26435#38480
          TabOrder = 6
          OnClick = BitBtn13Click
        end
        object Edit1: TEdit
          Left = 4
          Top = 62
          Width = 180
          Height = 21
          TabOrder = 7
        end
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 89
        Width = 185
        Height = 439
        Align = alLeft
        Caption = #26435#38480#21015#34920
        TabOrder = 1
        object DBGrid_power: TDBGrid
          Left = 2
          Top = 15
          Width = 181
          Height = 422
          Align = alClient
          DataSource = DataSource_power
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -13
          TitleFont.Name = #23435#20307
          TitleFont.Style = []
        end
      end
      object Panel3: TPanel
        Left = 185
        Top = 89
        Width = 120
        Height = 439
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 2
        object BitBtn5: TBitBtn
          Left = 8
          Top = 16
          Width = 105
          Height = 25
          Caption = #20840#37096#22686#21152'=>>'
          TabOrder = 0
          OnClick = BitBtn5Click
        end
        object BitBtn6: TBitBtn
          Left = 8
          Top = 66
          Width = 105
          Height = 25
          Caption = #21333#26465#22686#21152'=>'
          TabOrder = 1
          OnClick = BitBtn6Click
        end
        object BitBtn7: TBitBtn
          Left = 8
          Top = 116
          Width = 105
          Height = 25
          Caption = #21333#26465#21024#38500'<='
          TabOrder = 2
          OnClick = BitBtn7Click
        end
        object BitBtn8: TBitBtn
          Left = 8
          Top = 166
          Width = 105
          Height = 25
          Caption = #20840#37096#21024#38500'<<='
          TabOrder = 3
          OnClick = BitBtn8Click
        end
      end
      object GroupBox2: TGroupBox
        Left = 305
        Top = 89
        Width = 200
        Height = 439
        Align = alLeft
        Caption = #24403#21069#35282#33394#26435#38480
        TabOrder = 3
        object StringGrid_jsspower: TStringGrid
          Left = 2
          Top = 15
          Width = 196
          Height = 422
          Align = alClient
          ColCount = 1
          DefaultColWidth = 170
          FixedCols = 0
          RowCount = 100
          FixedRows = 0
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
          TabOrder = 0
          OnSelectCell = StringGrid_zysjsSelectCell
        end
      end
      object GroupBox3: TGroupBox
        Left = 510
        Top = 89
        Width = 264
        Height = 439
        Align = alClient
        Caption = #35282#33394#21015#34920
        TabOrder = 4
        object DBGrid_js1: TDBGrid
          Left = 2
          Top = 15
          Width = 260
          Height = 422
          Align = alClient
          DataSource = DataSource_js
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -13
          TitleFont.Name = #23435#20307
          TitleFont.Style = []
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #20154#21592#26435#38480#20998#37197
      ImageIndex = 1
      OnShow = TabSheet2Show
      object Splitter2: TSplitter
        Left = 505
        Top = 50
        Width = 5
        Height = 478
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 774
        Height = 50
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Label6: TLabel
          Left = 515
          Top = 14
          Width = 26
          Height = 13
          Caption = #37096#38376
        end
        object DBLookupComboBox1: TDBLookupComboBox
          Left = 544
          Top = 10
          Width = 225
          Height = 21
          DataField = 'pkid'
          KeyField = 'name'
          ListSource = DataSource_dep
          TabOrder = 0
          OnClick = DBLookupComboBox1Click
        end
      end
      object GroupBox4: TGroupBox
        Left = 0
        Top = 50
        Width = 185
        Height = 478
        Align = alLeft
        Caption = #35282#33394#21015#34920
        TabOrder = 1
        object DBGrid_js2: TDBGrid
          Left = 2
          Top = 15
          Width = 181
          Height = 461
          Align = alClient
          DataSource = DataSource_js
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -13
          TitleFont.Name = #23435#20307
          TitleFont.Style = []
        end
      end
      object Panel4: TPanel
        Left = 185
        Top = 50
        Width = 120
        Height = 478
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 2
        object BitBtn1: TBitBtn
          Left = 8
          Top = 16
          Width = 105
          Height = 25
          Caption = #20840#37096#22686#21152'=>>'
          TabOrder = 0
          OnClick = BitBtn1Click
        end
        object BitBtn2: TBitBtn
          Left = 8
          Top = 66
          Width = 105
          Height = 25
          Caption = #21333#26465#22686#21152'=>'
          TabOrder = 1
          OnClick = BitBtn2Click
        end
        object BitBtn3: TBitBtn
          Left = 8
          Top = 116
          Width = 105
          Height = 25
          Caption = #21333#26465#21024#38500'<='
          TabOrder = 2
          OnClick = BitBtn3Click
        end
        object BitBtn4: TBitBtn
          Left = 8
          Top = 166
          Width = 105
          Height = 25
          Caption = #20840#37096#21024#38500'<<='
          TabOrder = 3
          OnClick = BitBtn4Click
        end
      end
      object GroupBox5: TGroupBox
        Left = 305
        Top = 50
        Width = 200
        Height = 478
        Align = alLeft
        Caption = #24403#21069#32844#21592#35282#33394
        TabOrder = 3
        object StringGrid_zysjs: TStringGrid
          Left = 2
          Top = 15
          Width = 196
          Height = 461
          Align = alClient
          ColCount = 1
          DefaultColWidth = 170
          FixedCols = 0
          RowCount = 100
          FixedRows = 0
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
          TabOrder = 0
          OnSelectCell = StringGrid_zysjsSelectCell
        end
      end
      object GroupBox6: TGroupBox
        Left = 510
        Top = 50
        Width = 264
        Height = 478
        Align = alClient
        Caption = #32844#21592#21015#34920
        TabOrder = 4
        object DBGrid_zy: TDBGrid
          Left = 2
          Top = 15
          Width = 260
          Height = 461
          Align = alClient
          DataSource = DataSource_zy
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -13
          TitleFont.Name = #23435#20307
          TitleFont.Style = []
        end
      end
    end
  end
  object DataSource_power: TDataSource
    DataSet = ADOQuery_power
    Left = 264
  end
  object DataSource_js: TDataSource
    DataSet = ADOQuery_js
    Left = 424
  end
  object DataSource_zy: TDataSource
    DataSet = ADOQuery_zy
    Left = 592
  end
  object ADOQuery_power: TADOQuery
    AfterOpen = ADOQuery_powerAfterOpen
    AfterScroll = ADOQuery_powerAfterScroll
    Parameters = <>
    Left = 232
  end
  object ADOQuery_js: TADOQuery
    AfterOpen = ADOQuery_jsAfterOpen
    AfterScroll = ADOQuery_jsAfterScroll
    Parameters = <>
    Left = 392
  end
  object ADOQuery_zy: TADOQuery
    AfterOpen = ADOQuery_zyAfterOpen
    AfterScroll = ADOQuery_zyAfterScroll
    Parameters = <>
    Left = 560
  end
  object ADOQuery_dep: TADOQuery
    Parameters = <>
    Left = 696
  end
  object DataSource_dep: TDataSource
    DataSet = ADOQuery_dep
    Left = 728
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Left = 176
  end
end
