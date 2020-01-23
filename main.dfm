object Form1: TForm1
  Left = 346
  Top = 146
  Width = 655
  Height = 702
  Caption = 'Simulation'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 24
    Width = 40
    Height = 16
    Caption = 'Round'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 24
    Top = 56
    Width = 62
    Height = 16
    Caption = 'Simulation'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object EditRound: TEdit
    Left = 96
    Top = 24
    Width = 81
    Height = 21
    TabOrder = 0
    Text = '500'
  end
  object Memo1: TMemo
    Left = 192
    Top = 16
    Width = 433
    Height = 633
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object ButtonSimulate: TButton
    Left = 24
    Top = 96
    Width = 145
    Height = 25
    Caption = 'Simulate'
    TabOrder = 2
    OnClick = ButtonSimulateClick
  end
  object EditSim: TEdit
    Left = 96
    Top = 56
    Width = 81
    Height = 21
    TabOrder = 3
    Text = '100000'
  end
  object ButtonCalcBank: TButton
    Left = 16
    Top = 584
    Width = 97
    Height = 25
    Caption = 'Calc Bank'
    TabOrder = 4
    Visible = False
    OnClick = ButtonCalcBankClick
  end
  object Edit4: TEdit
    Left = 16
    Top = 552
    Width = 65
    Height = 21
    TabOrder = 5
    Text = '422'
    Visible = False
  end
  object ButtonClear: TButton
    Left = 24
    Top = 144
    Width = 145
    Height = 25
    Caption = 'Clear'
    TabOrder = 6
    OnClick = ButtonClearClick
  end
  object CheckBox1: TCheckBox
    Left = 24
    Top = 184
    Width = 145
    Height = 25
    Caption = ' Show only final result'
    TabOrder = 7
  end
  object ButtonSimFast: TButton
    Left = 24
    Top = 224
    Width = 145
    Height = 25
    Caption = 'Fast  (Simulation x 1000)'
    TabOrder = 8
    OnClick = ButtonSimFastClick
  end
end
