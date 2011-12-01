object NMOptions: TNMOptions
  Left = 360
  Top = 263
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'NetMeter Options'
  ClientHeight = 367
  ClientWidth = 455
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001001010000001001800680300001600000028000000100000002000
    0000010018000000000000000000600000006000000000000000000000000000
    00000078000078000078000078000078000078000000000000006F00006F0000
    6F00006F00006F00006F00000000202020000070000070000070000070000070
    000070202020202020009F00009F00009F00009F00009F00009F002020204040
    4000006800006800006800006800006800006840404040404000CF0000CF0000
    CF0000CF0000CF0000CF00404040606060000060000060000060000060000060
    00006060606060606000FF0000FF0000FF0000FF0000FF0000FF006060608080
    8000005800005800005800005800005800005880808080808000002000002000
    00200000200000200000208080809F9F9F000050000050000050000050000050
    0000509F9F9F9F9F9F0000280000280000280000280000280000289F9F9FBFBF
    BF000048000048000048000048000048000048BFBFBFBFBFBF00003000003000
    0030000030000030000030BFBFBFDFDFDF000040000040000040000040000040
    000040DFDFDFDFDFDF000038000038000038000038000038000038DFDFDFDFDF
    DF000038000038000038000038000038000038DFDFDFDFDFDF00004000004000
    0040000040000040000040DFDFDFBFBFBF000030000030000030000030000030
    000030BFBFBFBFBFBF000048000048000048000048000048000048BFBFBF9F9F
    9F00DE0000DE0000DE0000DE0000DE0000DE009F9F9F9F9F9F00005000005000
    00500000500000500000509F9F9F80808000BF0000BF0000BF0000BF0000BF00
    00BF008080808080800000580000580000580000580000580000588080806060
    60009F00009F00009F00009F00009F00009F0060606060606000006000006000
    0060000060000060000060606060404040007F00007F00007F00007F00007F00
    007F004040404040400000680000680000680000680000680000684040402020
    20005F00005F00005F00005F00005F00005F0020202020202000007000007000
    0070000070000070000070202020000000004000004000004000004000004000
    0040000000000000000000780000780000780000780000780000780000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object OKBtn: TBitBtn
    Left = 196
    Top = 333
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object ApplyBtn: TBitBtn
    Left = 284
    Top = 333
    Width = 75
    Height = 25
    Caption = 'Apply'
    TabOrder = 1
    OnClick = ApplyBtnClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object CancelBtn: TBitBtn
    Left = 372
    Top = 333
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object ChkRunOnStartup: TCheckBox
    Left = 12
    Top = 335
    Width = 145
    Height = 17
    Hint = 'Start this program with windows (this is a per user setting)'
    Caption = 'Load on windows startup'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = ChkRunOnStartupClick
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 439
    Height = 313
    ActivePage = TabSheet1
    HotTrack = True
    MultiLine = True
    TabOrder = 4
    object TabSheet1: TTabSheet
      Caption = 'General'
      ImageIndex = 5
      object NetIfGrp: TGroupBox
        Left = 8
        Top = 8
        Width = 417
        Height = 48
        Caption = 'Network interface to monitor'
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        object NetIfCombo: TComboBox
          Left = 8
          Top = 16
          Width = 401
          Height = 21
          AutoComplete = False
          Style = csDropDownList
          ItemHeight = 13
          MaxLength = 76
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnSelect = NetIfSelect
        end
      end
      object WindowPropGrp: TGroupBox
        Left = 8
        Top = 66
        Width = 417
        Height = 180
        Caption = 'Window properties'
        TabOrder = 1
        object TV_PercentDisplay: TLabel
          Left = 190
          Top = 34
          Width = 58
          Height = 13
          Caption = '000% visible'
        end
        object Bevel4: TBevel
          Left = 152
          Top = 16
          Width = 9
          Height = 153
          Shape = bsLeftLine
        end
        object ChkFadingEnabled: TCheckBox
          Left = 188
          Top = 104
          Width = 123
          Height = 17
          Hint = 'Activates fading effects on graph window'
          Caption = 'Enable fading effects'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 10
          OnClick = ChkFadingEnabledClick
        end
        object ChkAlwaysOnTop: TCheckBox
          Left = 8
          Top = 16
          Width = 89
          Height = 17
          Hint = 
            'Forces the graph window to stay above all other windows (restart' +
            ' NetMeter for the setting to take effect)'
          Caption = 'Always on top'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = ChkAlwaysOnTopClick
        end
        object ChkShowCaption: TCheckBox
          Left = 8
          Top = 32
          Width = 129
          Height = 17
          Hint = 'Toggles the window titlebar on/off'
          Caption = 'Show window caption'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = ChkShowCaptionClick
        end
        object ChkStartMinimized: TCheckBox
          Left = 8
          Top = 48
          Width = 97
          Height = 17
          Hint = 'Shows just the tray icon on program startup'
          Caption = 'Start minimized'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = ChkStartMinimizedClick
        end
        object ChkMinimizeWhenIdle: TCheckBox
          Left = 8
          Top = 64
          Width = 113
          Height = 17
          Hint = 
            'Hides the window when there is no traffic for some time. If ther' +
            'e is traffic again, the window will be restored automatically'
          Caption = 'Minimize when idle'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = ChkMinimizeWhenIdleClick
        end
        object ChkTransparency: TCheckBox
          Left = 166
          Top = 16
          Width = 249
          Height = 17
          Hint = 'Activates alpha transparency on graph window'
          Caption = 'Enable transparency (Windows 2000 or newer)'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          OnClick = ChkTransparencyClick
        end
        object TV_TrackBar: TTrackBar
          Left = 182
          Top = 46
          Width = 137
          Height = 33
          Max = 255
          Frequency = 32
          TabOrder = 8
          ThumbLength = 16
          TickMarks = tmTopLeft
          OnChange = TV_TrackBarChange
        end
        object ChkMouseFadingEnabled: TCheckBox
          Left = 204
          Top = 120
          Width = 169
          Height = 17
          Hint = 
            'Change transparency of graph window when the mouse cursor is ove' +
            'r it'
          Caption = 'Enable mouse sensitive fading'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 11
          OnClick = ChkMouseFadingEnabledClick
        end
        object ChkDisplayAverage: TCheckBox
          Left = 8
          Top = 80
          Width = 137
          Height = 17
          Hint = 
            'Display average values of the last 10 seconds instead of immedia' +
            'te data throughput readings'
          Caption = 'Display average values'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = ChkDisplayAverageClick
        end
        object ChkCloseToTray: TCheckBox
          Left = 8
          Top = 96
          Width = 81
          Height = 17
          Hint = 'Hide window when close button is clicked'
          Caption = 'Close to tray'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          OnClick = ChkCloseToTrayClick
        end
        object RadioFadeout: TRadioButton
          Left = 222
          Top = 136
          Width = 65
          Height = 17
          Caption = 'fade out'
          TabOrder = 12
          OnClick = RadioFadeoutClick
        end
        object RadioFadein: TRadioButton
          Left = 222
          Top = 152
          Width = 65
          Height = 17
          Caption = 'fade in'
          TabOrder = 13
          OnClick = RadioFadeinClick
        end
        object ChkClickThroughEnabled: TCheckBox
          Left = 188
          Top = 80
          Width = 171
          Height = 17
          Hint = 
            'Activate this to make the graph window unclickable. All mouse ev' +
            'ents will be passed to the underlying window.'
          Caption = 'Enable "click-through" feature'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 9
          OnClick = ChkClickThroughEnabledClick
        end
        object ChkScreenSnap: TCheckBox
          Left = 8
          Top = 112
          Width = 129
          Height = 17
          Caption = 'Snap to screen edges'
          TabOrder = 6
          OnClick = ChkScreenSnapClick
        end
      end
      object ChkUseOldDUDescriptions: TCheckBox
        Left = 8
        Top = 257
        Width = 265
        Height = 17
        Caption = 'Use old display unit descriptions (KB instead of KiB)'
        TabOrder = 2
        OnClick = ChkUseOldDUDescriptionsClick
      end
    end
    object GraphTabSheet: TTabSheet
      Caption = 'Graph'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object ScalingPropGrp: TGroupBox
        Left = 8
        Top = 8
        Width = 188
        Height = 129
        Caption = 'Scaling options'
        TabOrder = 0
        object BWLabel: TLabel
          Left = 8
          Top = 40
          Width = 169
          Height = 13
          Caption = 'Bandwidth of monitored interface(s):'
        end
        object BWCustomLabel1: TLabel
          Left = 8
          Top = 83
          Width = 126
          Height = 13
          Caption = 'Custom connection speed:'
        end
        object BWCustomLabel2: TLabel
          Left = 87
          Top = 102
          Width = 21
          Height = 13
          Caption = 'bit/s'
        end
        object ChkAutoscale: TCheckBox
          Left = 8
          Top = 16
          Width = 105
          Height = 17
          Hint = 'Scales graph to maximum value automatically'
          Caption = 'Autoscale graph'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = ChkAutoscaleClick
        end
        object BWCombo: TComboBox
          Left = 8
          Top = 56
          Width = 169
          Height = 21
          Style = csDropDownList
          Enabled = False
          ItemHeight = 0
          TabOrder = 1
          OnSelect = BWComboSelect
          Items.Strings = (
            'Autodetect'
            '56 kb/s (analog modem)'
            '64 kb/s (ISDN)'
            '128 kb/s (2x ISDN)'
            '384 kb/s (DSL)'
            '768 kb/s (DSL)'
            '1.536 Mb/s (DSL)'
            '1.544 Mb/s (T1)'
            '10 Mb/s (LAN)'
            '11 Mb/s (WLAN)'
            '22 Mb/s (WLAN)'
            '44.736 Mb/s (T3)'
            '54 Mb/s (WLAN)'
            '100 Mb/s (LAN)'
            '1 Gb/s (LAN)'
            'Custom value')
        end
        object BWCustom: TEdit
          Left = 8
          Top = 99
          Width = 73
          Height = 21
          TabOrder = 2
          OnChange = BWCustomChange
          OnKeyPress = EditInvalidKeyPress
        end
      end
      object NumericalDisplayGrp: TGroupBox
        Left = 8
        Top = 143
        Width = 348
        Height = 113
        Caption = 'Numerical display'
        TabOrder = 1
        object Label1: TLabel
          Left = 144
          Top = 16
          Width = 57
          Height = 13
          Caption = 'Display unit:'
        end
        object ChkUDDShow: TCheckBox
          Left = 8
          Top = 32
          Width = 129
          Height = 17
          Hint = 'Show current upload / download speed below graph'
          Caption = 'Show current UL / DL'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = ChkUDDShowClick
        end
        object ChkTUDDShow: TCheckBox
          Left = 8
          Top = 56
          Width = 121
          Height = 17
          Hint = 'Show upload / download totals below graph'
          Caption = 'Show UL / DL totals'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = ChkTUDDShowClick
        end
        object ChkUDDShowMaxVal: TCheckBox
          Left = 8
          Top = 80
          Width = 129
          Height = 17
          Hint = 'Show the maximum upload / download value left to the graph'
          Caption = 'Show maximum value'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = ChkUDDShowMaxValClick
        end
        object UDDUnitCombo: TComboBox
          Left = 144
          Top = 32
          Width = 161
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 3
          OnSelect = UDDUnitComboSelect
        end
        object TUDDUnitCombo: TComboBox
          Left = 144
          Top = 56
          Width = 161
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 4
          OnSelect = TUDDUnitComboSelect
        end
        object MVDUnitCombo: TComboBox
          Left = 144
          Top = 80
          Width = 161
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 5
          OnSelect = MVDUnitComboSelect
        end
      end
      object GraphicalDisplayGrp: TGroupBox
        Left = 210
        Top = 9
        Width = 146
        Height = 128
        Caption = 'Graphical display'
        TabOrder = 2
        object VertGridLabel: TLabel
          Left = 8
          Top = 64
          Width = 82
          Height = 13
          Caption = 'Vertical grid lines:'
        end
        object ChkGradientBkGr: TCheckBox
          Left = 8
          Top = 16
          Width = 129
          Height = 17
          Hint = 
            'Fill the graph background with a gradient instead of a single co' +
            'lor'
          Caption = 'Gradient background'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = ChkGradientBkGrClick
        end
        object ChkShowHorGrid: TCheckBox
          Left = 8
          Top = 40
          Width = 121
          Height = 17
          Hint = 
            'Show horizontal grid lines in graph (space between two lines = 1' +
            '0%)'
          Caption = 'Show horizontal grid'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = ChkShowHorGridClick
        end
        object VertGridCombo: TComboBox
          Left = 8
          Top = 80
          Width = 129
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 2
          OnChange = VertGridComboChange
          Items.Strings = (
            'Disabled'
            'Every 10 values'
            'Every 20 values'
            'Every 30 values'
            'Every 60 values')
        end
      end
    end
    object FontTabSheet: TTabSheet
      Caption = 'Fonts + Colors'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object FontPropGrp: TGroupBox
        Left = 8
        Top = 8
        Width = 417
        Height = 129
        Caption = 'Fonts'
        TabOrder = 0
        object Label3: TLabel
          Left = 8
          Top = 56
          Width = 98
          Height = 13
          Caption = 'DL / UL display font:'
        end
        object Label4: TLabel
          Left = 8
          Top = 16
          Width = 82
          Height = 13
          Caption = 'MAX display font:'
        end
        object Label5: TLabel
          Left = 160
          Top = 56
          Width = 47
          Height = 13
          Caption = 'Max. size:'
        end
        object Label6: TLabel
          Left = 160
          Top = 16
          Width = 47
          Height = 13
          Caption = 'Max. size:'
        end
        object UDFontPreview: TEdit
          Left = 16
          Top = 72
          Width = 145
          Height = 21
          TabStop = False
          AutoSize = False
          BevelInner = bvNone
          BevelOuter = bvNone
          Enabled = False
          ReadOnly = True
          TabOrder = 2
        end
        object MVFontPreview: TEdit
          Left = 16
          Top = 32
          Width = 145
          Height = 21
          TabStop = False
          AutoSize = False
          BevelInner = bvNone
          BevelOuter = bvNone
          Enabled = False
          ReadOnly = True
          TabOrder = 0
        end
        object UDFontSizePreview: TEdit
          Left = 168
          Top = 72
          Width = 33
          Height = 21
          TabStop = False
          AutoSize = False
          BevelInner = bvNone
          BevelOuter = bvNone
          Enabled = False
          ReadOnly = True
          TabOrder = 3
        end
        object MVFontSizePreview: TEdit
          Left = 168
          Top = 32
          Width = 33
          Height = 21
          TabStop = False
          AutoSize = False
          BevelInner = bvNone
          BevelOuter = bvNone
          Enabled = False
          ReadOnly = True
          TabOrder = 1
        end
        object ChkFontAutosize: TCheckBox
          Left = 16
          Top = 104
          Width = 161
          Height = 17
          Hint = 
            'If this option is active, NetMeter will try to size the fonts do' +
            'wn (min. size = 8) before switching the display panels off'
          Caption = 'Automatically adjust font size'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = ChkFontAutosizeClick
        end
        object BitBtn1: TBitBtn
          Left = 288
          Top = 16
          Width = 121
          Height = 25
          Caption = 'Reset to defaults'
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          OnClick = FontResetClick
          Glyph.Data = {
            DE010000424DDE01000000000000760000002800000024000000120000000100
            04000000000068010000130B0000130B00001000000010000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333888888
            33333333333F8888883F33330000318338111111883333388F3833333388F333
            000031188111111111833338F8833FFFFF338F33000031111119999911183338
            F333F88888F338F3000031111193333391118338F33F8333338F338F00003111
            1133333339118338F33833333338F38F000031111113333339888338FFFF8F33
            3338888300003999999933333333333888888833333333330000333333333333
            333333333333333333FFFFFF000033333333333388888833FFFF333333888888
            000039888333333911111838888F333338F33338000039118333333391111838
            F38F3333338333380000339118333338811118338338FFFFF883333800003391
            11888881111118338F3388888333FF3800003339111111111199183338FF3333
            33FF88F80000333399111111993393333388FFFFFF8833830000333333999999
            3333333333338888883333330000333333333333333333333333333333333333
            0000}
          NumGlyphs = 2
        end
        object Button1: TButton
          Left = 208
          Top = 32
          Width = 49
          Height = 21
          Caption = 'Change'
          TabOrder = 6
          OnClick = ChangeMVLabelFontClick
        end
        object Button2: TButton
          Left = 208
          Top = 72
          Width = 49
          Height = 21
          Caption = 'Change'
          TabOrder = 7
          OnClick = ChangeUDLabelFontClick
        end
      end
      object ColorPropGrp: TGroupBox
        Left = 8
        Top = 144
        Width = 417
        Height = 105
        Caption = 'Colors'
        TabOrder = 1
        object Bevel2: TBevel
          Left = 16
          Top = 48
          Width = 57
          Height = 49
          Style = bsRaised
        end
        object ColorPreview: TPaintBox
          Left = 17
          Top = 49
          Width = 55
          Height = 47
          OnClick = ColorChangeBtnClick
          OnPaint = ColorPreviewPaint
        end
        object BitBtn2: TBitBtn
          Left = 288
          Top = 16
          Width = 121
          Height = 25
          Caption = 'Reset to defaults'
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = ColorResetClick
          Glyph.Data = {
            DE010000424DDE01000000000000760000002800000024000000120000000100
            04000000000068010000130B0000130B00001000000010000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333888888
            33333333333F8888883F33330000318338111111883333388F3833333388F333
            000031188111111111833338F8833FFFFF338F33000031111119999911183338
            F333F88888F338F3000031111193333391118338F33F8333338F338F00003111
            1133333339118338F33833333338F38F000031111113333339888338FFFF8F33
            3338888300003999999933333333333888888833333333330000333333333333
            333333333333333333FFFFFF000033333333333388888833FFFF333333888888
            000039888333333911111838888F333338F33338000039118333333391111838
            F38F3333338333380000339118333338811118338338FFFFF883333800003391
            11888881111118338F3388888333FF3800003339111111111199183338FF3333
            33FF88F80000333399111111993393333388FFFFFF8833830000333333999999
            3333333333338888883333330000333333333333333333333333333333333333
            0000}
          NumGlyphs = 2
        end
        object Button3: TButton
          Left = 80
          Top = 48
          Width = 57
          Height = 49
          Caption = 'Change'
          TabOrder = 1
          OnClick = ColorChangeBtnClick
        end
        object ColorCombo: TComboBox
          Left = 8
          Top = 16
          Width = 249
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          ItemIndex = 0
          TabOrder = 2
          Text = 'MAX display border'
          OnSelect = ColorComboSelect
          Items.Strings = (
            'MAX display border'
            'MAX display background'
            'MAX display font'
            'DL/UL display border'
            'DL/UL display background'
            'UL display font'
            'DL display font'
            'Graph border'
            'Graph background (single/gradient top)'
            'Graph background (gradient bottom)'
            'Grid'
            'Upload'
            'Download'
            'Upload + Download')
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Totals + Reports'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object PeriodsGroup: TGroupBox
        Left = 8
        Top = 8
        Width = 329
        Height = 81
        Caption = 'Periods configuration'
        TabOrder = 0
        object Label7: TLabel
          Left = 8
          Top = 24
          Width = 112
          Height = 13
          Caption = 'Monthly period starts on'
        end
        object Label8: TLabel
          Left = 232
          Top = 24
          Width = 79
          Height = 13
          Caption = 'day of the month'
        end
        object Label9: TLabel
          Left = 8
          Top = 50
          Width = 111
          Height = 13
          Caption = 'Weekly period starts on'
        end
        object MPCombo: TComboBox
          Left = 128
          Top = 20
          Width = 97
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 0
          OnSelect = MPComboSelect
          Items.Strings = (
            '1st'
            '2nd'
            '3rd'
            '4th'
            '5th'
            '6th'
            '7th'
            '8th'
            '9th'
            '10th'
            '11th'
            '12th'
            '13th'
            '14th'
            '15th'
            '16th'
            '17th'
            '18th'
            '19th'
            '20th'
            '21st'
            '22nd'
            '23rd'
            '24th'
            '25th'
            '26th'
            '27th'
            '28th')
        end
        object WPCombo: TComboBox
          Left = 128
          Top = 46
          Width = 97
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 1
          OnSelect = WPComboSelect
          Items.Strings = (
            'Monday'
            'Tuesday'
            'Wednesday'
            'Thursday'
            'Friday'
            'Saturday'
            'Sunday')
        end
      end
      object TotalsDisplayUnitGroup: TGroupBox
        Left = 7
        Top = 95
        Width = 178
        Height = 59
        Caption = 'Totals display unit'
        TabOrder = 1
        object TDUCombo: TComboBox
          Left = 8
          Top = 20
          Width = 161
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 0
          OnSelect = TDUComboSelect
        end
      end
      object LogautosaveGroup: TGroupBox
        Left = 7
        Top = 160
        Width = 178
        Height = 81
        Caption = 'Logfile autosave'
        TabOrder = 2
        object LogautosaveLabel1: TLabel
          Left = 8
          Top = 48
          Width = 84
          Height = 13
          Caption = 'Save logfile every'
        end
        object LogautosaveLabel2: TLabel
          Left = 135
          Top = 48
          Width = 36
          Height = 13
          Caption = 'minutes'
        end
        object LogautosaveChk: TCheckBox
          Left = 8
          Top = 24
          Width = 106
          Height = 17
          Caption = 'Enable autosave'
          TabOrder = 0
          OnClick = LogautosaveChkClick
        end
        object LogautosaveMinutes: TEdit
          Left = 97
          Top = 46
          Width = 33
          Height = 21
          TabOrder = 1
          OnChange = LogautosaveMinutesChange
          OnKeyPress = EditInvalidKeyPress
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Notifications'
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object NotificationGroup: TGroupBox
        Left = 8
        Top = 8
        Width = 249
        Height = 57
        Caption = 'Type of Notification'
        TabOrder = 0
        object RadioBalloonHint: TRadioButton
          Left = 8
          Top = 16
          Width = 233
          Height = 17
          Caption = 'Use balloon hints (Windows 2000 or newer)'
          TabOrder = 0
          OnClick = RadioBalloonHintClick
        end
        object RadioPopup: TRadioButton
          Left = 8
          Top = 32
          Width = 129
          Height = 17
          Caption = 'Use pop-up windows'
          TabOrder = 1
          OnClick = RadioBalloonHintClick
        end
      end
      object TVAGroup: TGroupBox
        Left = 8
        Top = 75
        Width = 265
        Height = 132
        Caption = 'Traffic volume alert'
        TabOrder = 1
        object Label10: TLabel
          Left = 28
          Top = 48
          Width = 50
          Height = 13
          Caption = 'Alert when'
        end
        object Label11: TLabel
          Left = 34
          Top = 74
          Width = 44
          Height = 13
          Caption = 'reach(es)'
        end
        object Label12: TLabel
          Left = 14
          Top = 100
          Width = 65
          Height = 13
          Caption = 'during current'
        end
        object TLVEdit: TEdit
          Left = 88
          Top = 70
          Width = 49
          Height = 21
          TabOrder = 1
          OnChange = TLVEditChange
          OnKeyPress = EditInvalidKeyPress
        end
        object TLUCombo: TComboBox
          Left = 142
          Top = 70
          Width = 110
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 2
          OnSelect = TLUComboSelect
          Items.Strings = (
            'Megabyte (MB)'
            'Mebibyte (MiB)'
            'Gigabyte (GB)'
            'Gibibyte (GiB)')
        end
        object TLUDCombo: TComboBox
          Left = 88
          Top = 44
          Width = 129
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 0
          OnSelect = TLUDComboSelect
          Items.Strings = (
            'Upload + Download'
            'Upload'
            'Download')
        end
        object TLPCombo: TComboBox
          Left = 88
          Top = 96
          Width = 65
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 3
          OnSelect = TLPComboSelect
          Items.Strings = (
            'Day'
            'Week'
            'Month')
        end
        object TVAEChk: TCheckBox
          Left = 8
          Top = 16
          Width = 145
          Height = 17
          Caption = 'Enable traffic volume alert'
          TabOrder = 4
          OnClick = TVAEChkClick
        end
      end
      object ChkMonProbNotify: TCheckBox
        Left = 8
        Top = 218
        Width = 153
        Height = 17
        Caption = 'Notify monitoring problems'
        TabOrder = 2
        OnClick = ChkMonProbNotifyClick
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Tray Icon'
      ImageIndex = 5
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object RadioGroup1: TRadioGroup
        Left = 8
        Top = 8
        Width = 153
        Height = 81
        Caption = 'Icon style'
        TabOrder = 0
      end
      object RadioButton1: TRadioButton
        Left = 24
        Top = 32
        Width = 121
        Height = 17
        Caption = 'Use dynamic gauges'
        TabOrder = 1
        OnClick = RadioButton1Click
      end
      object RadioButton2: TRadioButton
        Left = 24
        Top = 55
        Width = 113
        Height = 17
        Caption = 'Use old static icons'
        TabOrder = 2
        OnClick = RadioButton2Click
      end
    end
  end
  object ColorDialog1: TColorDialog
    Options = [cdFullOpen]
    Left = 160
    Top = 333
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = []
    Options = []
    Left = 128
    Top = 333
  end
end
