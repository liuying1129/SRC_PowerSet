object frmPower: TfrmPower
  Left = 161
  Top = 82
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
    object TabSheet1: TTabSheet
      Caption = #35282#33394#35774#32622
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 774
        Height = 41
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Label4: TLabel
          Left = 8
          Top = 12
          Width = 52
          Height = 13
          Caption = #36873#25321#31995#32479
        end
        object ComboBox1: TComboBox
          Left = 64
          Top = 9
          Width = 121
          Height = 21
          DropDownCount = 20
          ItemHeight = 13
          TabOrder = 0
          OnChange = ComboBox1Change
        end
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 41
        Width = 264
        Height = 487
        Align = alLeft
        Caption = #35282#33394#21015#34920
        TabOrder = 1
        object DBGrid_js1: TDBGrid
          Left = 2
          Top = 105
          Width = 260
          Height = 380
          Align = alClient
          DataSource = DataSource_js
          PopupMenu = PopupMenu2
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -13
          TitleFont.Name = #23435#20307
          TitleFont.Style = []
        end
        object Panel5: TPanel
          Left = 2
          Top = 15
          Width = 260
          Height = 90
          Align = alTop
          TabOrder = 1
          object Label2: TLabel
            Left = 0
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
          object BitBtn9: TBitBtn
            Left = 1
            Top = 34
            Width = 80
            Height = 25
            Caption = #26032#22686#35282#33394
            TabOrder = 0
            OnClick = BitBtn9Click
          end
          object DBEdtJSname: TDBEdit
            Left = 1
            Top = 9
            Width = 259
            Height = 21
            DataField = #35282#33394
            DataSource = DataSource_js
            TabOrder = 1
            OnKeyDown = DBEdtJSnameKeyDown
          end
        end
      end
      object GroupBox1: TGroupBox
        Left = 264
        Top = 41
        Width = 510
        Height = 487
        Align = alClient
        Caption = #26435#38480
        TabOrder = 2
        object Panel3: TPanel
          Left = 2
          Top = 15
          Width = 506
          Height = 122
          Align = alTop
          TabOrder = 0
          object BitBtn12: TBitBtn
            Left = 145
            Top = 58
            Width = 58
            Height = 25
            Caption = #20445#23384#26435#38480
            TabOrder = 0
            OnClick = BitBtn12Click
          end
          object BitBtn13: TBitBtn
            Left = 206
            Top = 58
            Width = 58
            Height = 25
            Caption = #21024#38500#26435#38480
            TabOrder = 1
            OnClick = BitBtn13Click
          end
          object Edit1: TEdit
            Left = 84
            Top = 86
            Width = 180
            Height = 21
            TabOrder = 2
          end
        end
        object CheckListBox1: TCheckListBox
          Left = 2
          Top = 137
          Width = 506
          Height = 348
          OnClickCheck = CheckListBox1ClickCheck
          Align = alClient
          Columns = 2
          ItemHeight = 13
          PopupMenu = PopupMenu1
          TabOrder = 1
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #20154#21592#26435#38480#20998#37197
      ImageIndex = 1
      OnShow = TabSheet2Show
      object GroupBox6: TGroupBox
        Left = 0
        Top = 0
        Width = 264
        Height = 528
        Align = alLeft
        TabOrder = 0
        object DBGrid_zy: TDBGrid
          Left = 2
          Top = 73
          Width = 260
          Height = 453
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
        object GroupBox2: TGroupBox
          Left = 2
          Top = 15
          Width = 260
          Height = 58
          Align = alTop
          Caption = #36873#25321#37096#38376
          TabOrder = 1
          object DBLookupComboBox1: TDBLookupComboBox
            Left = 20
            Top = 23
            Width = 225
            Height = 21
            DataField = 'pkid'
            DropDownRows = 38
            KeyField = 'name'
            ListSource = DataSource_dep
            TabOrder = 0
            OnClick = DBLookupComboBox1Click
          end
        end
      end
      object CheckListBox2: TCheckListBox
        Left = 264
        Top = 0
        Width = 510
        Height = 528
        OnClickCheck = CheckListBox2ClickCheck
        Align = alClient
        ItemHeight = 13
        TabOrder = 1
      end
    end
  end
  object DataSource_js: TDataSource
    DataSet = ADOQuery_js
    Left = 424
  end
  object DataSource_zy: TDataSource
    DataSet = ADOQuery_zy
    Left = 592
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
  object PopupMenu1: TPopupMenu
    Left = 412
    Top = 297
    object N1: TMenuItem
      Caption = #26032#22686#26435#38480
    end
    object N2: TMenuItem
      Caption = #20462#25913#26435#38480
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #21024#38500#26435#38480
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 164
    Top = 249
    object N4: TMenuItem
      Caption = #26032#22686#35282#33394
    end
    object N5: TMenuItem
      Caption = #20462#25913#35282#33394
    end
    object N6: TMenuItem
      Caption = #21024#38500#35282#33394
      OnClick = N6Click
    end
  end
end
