object NMTotals: TNMTotals
  Left = 323
  Top = 360
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Totals and Reports'
  ClientHeight = 450
  ClientWidth = 545
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
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 529
    Height = 401
    ActivePage = TotalsTab
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    HotTrack = True
    ParentFont = False
    TabIndex = 0
    TabOrder = 0
    object TotalsTab: TTabSheet
      Caption = 'Totals'
      object GroupBox1: TGroupBox
        Left = 8
        Top = 176
        Width = 313
        Height = 185
        Caption = '...'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object ULValue_Label: TLabel
          Left = 206
          Top = 18
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object ULPeekValue_Label: TLabel
          Left = 206
          Top = 80
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object ULPeek_Label: TLabel
          Left = 8
          Top = 80
          Width = 65
          Height = 13
          Caption = 'Peak Upload:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object UL_Label: TLabel
          Left = 8
          Top = 18
          Width = 37
          Height = 13
          Caption = 'Upload:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object UDValue_Label: TLabel
          Left = 206
          Top = 50
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object UD_Label: TLabel
          Left = 8
          Top = 50
          Width = 97
          Height = 13
          Caption = 'Upload + Download:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object DLValue_Label: TLabel
          Left = 206
          Top = 34
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object DLPeekValue_Label: TLabel
          Left = 206
          Top = 96
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object DLPeek_Label: TLabel
          Left = 8
          Top = 96
          Width = 79
          Height = 13
          Caption = 'Peak Download:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object DL_Label: TLabel
          Left = 8
          Top = 34
          Width = 51
          Height = 13
          Caption = 'Download:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Bevel3: TBevel
          Left = 8
          Top = 72
          Width = 220
          Height = 17
          Shape = bsTopLine
        end
        object ULAvgValue_Label: TLabel
          Left = 206
          Top = 128
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object ULAvg_Label: TLabel
          Left = 8
          Top = 128
          Width = 80
          Height = 13
          Caption = 'Average Upload:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object DLAvgValue_Label: TLabel
          Left = 206
          Top = 144
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object DLAvg_Label: TLabel
          Left = 8
          Top = 144
          Width = 94
          Height = 13
          Caption = 'Average Download:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Bevel9: TBevel
          Left = 8
          Top = 120
          Width = 220
          Height = 17
          Shape = bsTopLine
        end
        object UDAvg_Label: TLabel
          Left = 8
          Top = 160
          Width = 140
          Height = 13
          Caption = 'Average Upload + Download:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object UDAvgValue_Label: TLabel
          Left = 206
          Top = 160
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object GroupBox2: TGroupBox
        Left = 8
        Top = 8
        Width = 233
        Height = 73
        Caption = 'Data transferred today'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object Label1: TLabel
          Left = 8
          Top = 18
          Width = 37
          Height = 13
          Caption = 'Upload:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 8
          Top = 34
          Width = 51
          Height = 13
          Caption = 'Download:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 8
          Top = 50
          Width = 97
          Height = 13
          Caption = 'Upload + Download:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object ULToday_Label: TLabel
          Left = 206
          Top = 18
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object DLToday_Label: TLabel
          Left = 206
          Top = 34
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object UDToday_Label: TLabel
          Left = 206
          Top = 50
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object BitBtn2: TBitBtn
        Left = 240
        Top = 196
        Width = 65
        Height = 25
        Caption = 'Reset'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = BitBtn2Click
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
      object GroupBox3: TGroupBox
        Left = 8
        Top = 88
        Width = 233
        Height = 73
        Caption = 'Data transferred this week'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        object Label4: TLabel
          Left = 8
          Top = 18
          Width = 37
          Height = 13
          Caption = 'Upload:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label5: TLabel
          Left = 8
          Top = 34
          Width = 51
          Height = 13
          Caption = 'Download:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label6: TLabel
          Left = 8
          Top = 50
          Width = 97
          Height = 13
          Caption = 'Upload + Download:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object ULThisWeek_Label: TLabel
          Left = 206
          Top = 18
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object DLThisWeek_Label: TLabel
          Left = 206
          Top = 34
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object UDThisWeek_Label: TLabel
          Left = 206
          Top = 50
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object GroupBox4: TGroupBox
        Left = 264
        Top = 8
        Width = 233
        Height = 73
        Caption = 'Data transferred this month'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        object Label10: TLabel
          Left = 8
          Top = 18
          Width = 37
          Height = 13
          Caption = 'Upload:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label11: TLabel
          Left = 8
          Top = 34
          Width = 51
          Height = 13
          Caption = 'Download:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label12: TLabel
          Left = 8
          Top = 50
          Width = 97
          Height = 13
          Caption = 'Upload + Download:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object ULThisMonth_Label: TLabel
          Left = 206
          Top = 18
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object DLThisMonth_Label: TLabel
          Left = 206
          Top = 34
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object UDThisMonth_Label: TLabel
          Left = 206
          Top = 50
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object GroupBox5: TGroupBox
        Left = 264
        Top = 88
        Width = 233
        Height = 73
        Caption = 'Data transferred total'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        object Label16: TLabel
          Left = 8
          Top = 18
          Width = 37
          Height = 13
          Caption = 'Upload:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label17: TLabel
          Left = 8
          Top = 34
          Width = 51
          Height = 13
          Caption = 'Download:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label18: TLabel
          Left = 8
          Top = 50
          Width = 97
          Height = 13
          Caption = 'Upload + Download:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object ULTotal_Label: TLabel
          Left = 206
          Top = 18
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object DLTotal_Label: TLabel
          Left = 206
          Top = 34
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object UDTotal_Label: TLabel
          Left = 206
          Top = 50
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object gb_TrafficVolumeLimit: TGroupBox
        Left = 336
        Top = 176
        Width = 161
        Height = 129
        Caption = 'Traffic volume limit'
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 6
        object TVL_Used: TLabel
          Left = 8
          Top = 34
          Width = 28
          Height = 13
          Caption = 'Used:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object TVL_Left: TLabel
          Left = 8
          Top = 50
          Width = 21
          Height = 13
          Caption = 'Left:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object TVL_AvgLPD: TLabel
          Left = 32
          Top = 90
          Width = 98
          Height = 13
          Caption = 'Average left per day:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object TVL_UsedValue: TLabel
          Left = 134
          Top = 34
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
        end
        object TVL_LeftValue: TLabel
          Left = 134
          Top = 50
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
        end
        object TVL_AvgLPDValue: TLabel
          Left = 16
          Top = 106
          Width = 129
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '---'
        end
        object TVL_Limit: TLabel
          Left = 8
          Top = 18
          Width = 24
          Height = 13
          Caption = 'Limit:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object TVL_LimitValue: TLabel
          Left = 134
          Top = 18
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
        end
        object TVL_Projected: TLabel
          Left = 8
          Top = 66
          Width = 48
          Height = 13
          Caption = 'Projected:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object TVL_ProjectedValue: TLabel
          Left = 134
          Top = 66
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
        end
      end
    end
    object ProjectedTab: TTabSheet
      Caption = 'Projected'
      ImageIndex = 4
      object GroupBox6: TGroupBox
        Left = 8
        Top = 120
        Width = 417
        Height = 94
        Caption = 'This week'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Label7: TLabel
          Left = 8
          Top = 37
          Width = 37
          Height = 13
          Caption = 'Upload:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label8: TLabel
          Left = 8
          Top = 53
          Width = 51
          Height = 13
          Caption = 'Download:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label9: TLabel
          Left = 8
          Top = 69
          Width = 97
          Height = 13
          Caption = 'Upload + Download:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label19: TLabel
          Left = 192
          Top = 16
          Width = 42
          Height = 13
          Caption = 'Current'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label20: TLabel
          Left = 336
          Top = 16
          Width = 55
          Height = 13
          Caption = 'Projected'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Bevel1: TBevel
          Left = 152
          Top = 24
          Width = 241
          Height = 9
          Shape = bsBottomLine
          Style = bsRaised
        end
        object ULThisWeek2_Label: TLabel
          Left = 222
          Top = 37
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object DLThisWeek2_Label: TLabel
          Left = 222
          Top = 53
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object UDThisWeek2_Label: TLabel
          Left = 222
          Top = 69
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object ULThisWeekProj_Label: TLabel
          Left = 378
          Top = 37
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object DLThisWeekProj_Label: TLabel
          Left = 378
          Top = 53
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object UDThisWeekProj_Label: TLabel
          Left = 378
          Top = 69
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object GroupBox7: TGroupBox
        Left = 8
        Top = 232
        Width = 417
        Height = 94
        Caption = 'This month'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object Label24: TLabel
          Left = 8
          Top = 37
          Width = 37
          Height = 13
          Caption = 'Upload:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label25: TLabel
          Left = 8
          Top = 53
          Width = 51
          Height = 13
          Caption = 'Download:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label26: TLabel
          Left = 8
          Top = 69
          Width = 97
          Height = 13
          Caption = 'Upload + Download:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label27: TLabel
          Left = 192
          Top = 16
          Width = 42
          Height = 13
          Caption = 'Current'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label28: TLabel
          Left = 336
          Top = 16
          Width = 55
          Height = 13
          Caption = 'Projected'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Bevel2: TBevel
          Left = 152
          Top = 24
          Width = 241
          Height = 9
          Shape = bsBottomLine
          Style = bsRaised
        end
        object ULThisMonth2_Label: TLabel
          Left = 222
          Top = 37
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object DLThisMonth2_Label: TLabel
          Left = 222
          Top = 53
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object UDThisMonth2_Label: TLabel
          Left = 222
          Top = 69
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object ULThisMonthProj_Label: TLabel
          Left = 378
          Top = 37
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object DLThisMonthProj_Label: TLabel
          Left = 378
          Top = 53
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object UDThisMonthProj_Label: TLabel
          Left = 378
          Top = 69
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object GroupBox8: TGroupBox
        Left = 8
        Top = 8
        Width = 417
        Height = 94
        Caption = 'Today'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        object Label35: TLabel
          Left = 8
          Top = 37
          Width = 37
          Height = 13
          Caption = 'Upload:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label36: TLabel
          Left = 8
          Top = 53
          Width = 51
          Height = 13
          Caption = 'Download:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label37: TLabel
          Left = 8
          Top = 69
          Width = 97
          Height = 13
          Caption = 'Upload + Download:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label38: TLabel
          Left = 192
          Top = 16
          Width = 42
          Height = 13
          Caption = 'Current'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label39: TLabel
          Left = 336
          Top = 16
          Width = 55
          Height = 13
          Caption = 'Projected'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Bevel4: TBevel
          Left = 152
          Top = 24
          Width = 241
          Height = 9
          Shape = bsBottomLine
          Style = bsRaised
        end
        object ULToday2_Label: TLabel
          Left = 222
          Top = 37
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object DLToday2_Label: TLabel
          Left = 222
          Top = 53
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object UDToday2_Label: TLabel
          Left = 222
          Top = 69
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object ULTodayProj_Label: TLabel
          Left = 378
          Top = 37
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object DLTodayProj_Label: TLabel
          Left = 378
          Top = 53
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object UDTodayProj_Label: TLabel
          Left = 378
          Top = 69
          Width = 13
          Height = 13
          Alignment = taRightJustify
          Caption = '---'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
    end
    object DailyTab: TTabSheet
      Caption = 'Daily Reports'
      ImageIndex = 1
      object ListViewDaily: TListView
        Left = 8
        Top = 8
        Width = 505
        Height = 356
        Columns = <
          item
            Caption = 'Date'
            Width = 80
          end
          item
            Alignment = taCenter
            Caption = 'Upload'
            Width = 80
          end
          item
            Alignment = taCenter
            Caption = 'Download'
            Width = 80
          end
          item
            Alignment = taCenter
            Caption = 'UL + DL'
            Width = 80
          end>
        ColumnClick = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        FlatScrollBars = True
        GridLines = True
        ReadOnly = True
        RowSelect = True
        ParentFont = False
        TabOrder = 0
        ViewStyle = vsReport
        OnCustomDrawItem = ListViewCustomDrawItem
      end
    end
    object WeeklyTab: TTabSheet
      Caption = 'Weekly Reports'
      ImageIndex = 2
      object ListViewWeekly: TListView
        Left = 8
        Top = 8
        Width = 505
        Height = 356
        Columns = <
          item
            Caption = 'Week'
            Width = 140
          end
          item
            Alignment = taCenter
            Caption = 'Upload'
            Width = 80
          end
          item
            Alignment = taCenter
            Caption = 'Download'
            Width = 80
          end
          item
            Alignment = taCenter
            Caption = 'UL + DL'
            Width = 80
          end>
        ColumnClick = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        FlatScrollBars = True
        GridLines = True
        ReadOnly = True
        RowSelect = True
        ParentFont = False
        TabOrder = 0
        ViewStyle = vsReport
        OnCustomDrawItem = ListViewCustomDrawItem
      end
    end
    object MonthlyTab: TTabSheet
      Caption = 'Monthly Reports'
      ImageIndex = 3
      object ListViewMonthly: TListView
        Left = 8
        Top = 8
        Width = 505
        Height = 356
        Columns = <
          item
            Caption = 'Month'
            Width = 96
          end
          item
            Caption = 'Period'
            Width = 130
          end
          item
            Alignment = taCenter
            Caption = 'Upload'
            Width = 80
          end
          item
            Alignment = taCenter
            Caption = 'Download'
            Width = 80
          end
          item
            Alignment = taCenter
            Caption = 'UL + DL'
            Width = 80
          end>
        ColumnClick = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        FlatScrollBars = True
        GridLines = True
        ReadOnly = True
        RowSelect = True
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        ViewStyle = vsReport
        OnCustomDrawItem = ListViewCustomDrawItem
      end
    end
  end
  object BitBtn1: TBitBtn
    Left = 460
    Top = 416
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
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
  object ExportButton: TBitBtn
    Left = 372
    Top = 416
    Width = 75
    Height = 25
    Caption = 'Export'
    TabOrder = 1
    OnClick = ExportButtonClick
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B90000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000B90000B9000000000000000000000000FFB658FF9F15
      FF9F15FF9F15FF9F15FF9F15FF9F15FF9F15FF9F15FF9F150000B90000CA0000
      B9000000000000000000FFCD9DFEDDBBFEDAB5FEDAB5FED7B00000C20000C200
      00C20000C20000C20000B90000D10000CA0000B9000000000000FFCD9DFEDFC1
      FEDDBBFEDDBBFEDAB50000C20000E80000E30000E30000DE0000D80000D10000
      CA0000CA0000B9000000FFCD9DFEE2C7FEDFC1FEDFC1FEDDBB0000C20000EC00
      00E80000E30000DE0000DE0000D80000D10000CA0000CA0000B9FFCD9DFEE2C7
      FEE2C7FEDFC1FEDFC10000C20000EC0000EC0000E80000E30000DE0000D80000
      D80000D10000B9000000FFCD9DFEE5CDFEE5CDFEE2C7FEE2C70000C20000C200
      00C20000C20000C20000C20000DE0000D80000C2000000000000FFCD9DFEE8D2
      FEE8D2FEE5CDFEE5CDFEE2C7FEE2C7FEDFC1FEDFC1FEDDBB0000C90000E30000
      C2000000000000000000FFCD9DFEEBD8FEEBD8FEE8D2FEE8D2FEE5CDFEE2C7FE
      E2C7FEDFC1FEDFC10000C20000C9FF9F15000000000000000000FFCD9DFFEEDE
      FEEBD8FEEBD8FEE8D2FEE8D2FEE5CDFEE5CDFEE2C7FEE2C70000C9FEDFC1FF9F
      15000000000000000000FFCD9DFFF1E4FFEEDEFFEEDEFEEBD8FEEBD8FEE8D2FE
      E8D2FBE1BFFF9F15FF9F15FF9F15FF9F15000000000000000000FFD9B3FFF4EA
      FFF1E4FFF1E4FFEEDEFFEEDEFEEBD8FEEBD8F8C88AF4D1ACF5BD83F6B677FF9F
      15000000000000000000FFDFBEFFF4EAFFF4EAFFF1E4FFF1E4FFEEDEFFEEDEFE
      EBD8F8C88AF5D6B2F4D1ACFF9F15000000000000000000000000FFE2C4FFECD6
      FFF7F0FFF4EAFFF4EAFFF1E4FFF1E4FFEEDEF8C88AFCEEDEFFB6580000000000
      00000000000000000000FFE4C9FFE2C4FFDFBEFFD9B3FFCD9DFFCD9DFFCD9DFF
      CD9DFFCD9DFFCD9D000000000000000000000000000000000000}
  end
  object ImportButton: TBitBtn
    Left = 284
    Top = 416
    Width = 75
    Height = 25
    Caption = 'Import'
    TabOrder = 3
    OnClick = ImportButtonClick
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFB658FF9F15FF9F15FF9F15FF9F15FF
      9F15FF9F15FF9F15FF9F15FF9F15FF9F15FF9F15FF9F15000000000000000000
      FFCD9DFEDDBBFEDAB5FEDAB5FED7B0FED7B0FED4ABFED4ABFED2A6FED2A6FECF
      A2FECFA2FF9F15000000000000000000FFCD9DFEDFC1FEDDBBFEDDBBFEDAB5FE
      DAB5FED7B0FED7B0FED4ABFED4ABFED2A6FED2A6FF9F15000000000000000000
      FFCD9DFEE2C7FEDFC1FEDFC1FEDDBBFEDDBBFEDAB5FEDAB5FED7B0FED7B0FED4
      ABFED2A6FF9F15000000000000000000FFCD9DFEE2C7FEE2C7FEDFC1FEDFC1FE
      DDBBFEDDBBFEDAB5FEDAB5FED7B0FED7B0FED4ABFF9F15000000000000000000
      FFCD9DFEE5CDFEE5CDFEE2C7FEE2C7FEDFC1FEDFC1FEDDBBFEDDBBFEDAB5FEDA
      B5FED7B0FF9F15000000000000000000FFCD9DFEE8D2FEE8D2FEE5CDFEE5CDFE
      E2C7FEE2C7FEDFC1FEDFC1FEDDBBFEDDBBFEDAB5FF9F15000000000000000000
      FFCD9DFEEBD8FEEBD8FEE8D2168025FEE5CDFEE2C7FEE2C7FEDFC1FEDFC1FEDD
      BBFEDDBBFF9F15000000000000000000FFCD9DFFEEDEFEEBD81680251B9A2D16
      8025FEE5CDFEE5CDFEE2C7FEE2C7FEDFC1FEDFC1FF9F15000000000000000000
      FFCD9DFFF1E41680251B9E2D1DA52F1B9A2D168025FEE8D2FBE1BFFF9F15FF9F
      15FF9F15FF9F15000000168025000000FFD9B3168025168025188A281DA83018
      8A28168025168025F8C88AF4D1ACF5BD83F6B677FF9F15000000168025168025
      FFDFBEFFF4EAFFF4EA1680251EAB31168025FFEEDEFEEBD8F8C88AF5D6B2F4D1
      ACFF9F1500000000000016802521BE381B9D2D1680251680251EAE321EAA3116
      8025FFF1E4FFEEDEF8C88AFCEEDEFFB6580000000000000000000000001A962B
      1DA63020BC3620B9361FB033168025FFCD9DFFCD9DFFCD9DFFCD9DFFCD9D0000
      0000000000000000000000000000000016802516802516802516802500000000
      0000000000000000000000000000000000000000000000000000}
  end
  object ResetAllLogsBtn: TBitBtn
    Left = 168
    Top = 416
    Width = 105
    Height = 25
    Caption = 'Reset all logs'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = ResetAllLogsBtnClick
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
  object SaveDialog1: TSaveDialog
    DefaultExt = 'csv'
    FileName = 'NetMeterLog'
    Filter = 'Comma separated values (*.csv)|*.CSV'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofCreatePrompt, ofNoReadOnlyReturn, ofEnableSizing]
    Left = 56
    Top = 416
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'csv'
    FileName = 'NetMeterLog'
    Filter = 'Comma separated values (*.csv)|*.CSV'
    Left = 16
    Top = 416
  end
end
