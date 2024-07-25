object frmProduct: TfrmProduct
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Produtos'
  ClientHeight = 256
  ClientWidth = 529
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 529
    Height = 41
    Align = alTop
    TabOrder = 0
    ExplicitLeft = -40
    ExplicitTop = -6
    object pnlSbtnIncluir: TPanel
      Left = 93
      Top = 7
      Width = 81
      Height = 26
      Align = alCustom
      BevelOuter = bvNone
      Color = 8567563
      ParentBackground = False
      TabOrder = 0
      object sbtnIncluir: TSpeedButton
        Left = 0
        Top = 0
        Width = 81
        Height = 26
        Align = alClient
        Caption = 'Incluir'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = sbtnIncluirClick
        ExplicitLeft = -24
        ExplicitHeight = 25
      end
    end
    object pnlSbtnBuscar: TPanel
      Left = 6
      Top = 7
      Width = 81
      Height = 26
      Align = alCustom
      BevelOuter = bvNone
      Color = clMedGray
      ParentBackground = False
      TabOrder = 1
      object sbtnBuscar: TSpeedButton
        Left = 0
        Top = 0
        Width = 81
        Height = 26
        Align = alClient
        Caption = 'Buscar'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = sbtnBuscarClick
        ExplicitLeft = 1
      end
    end
    object pnlSbtnExcluir: TPanel
      Left = 179
      Top = 7
      Width = 81
      Height = 26
      Align = alCustom
      BevelOuter = bvNone
      Color = 1315996
      ParentBackground = False
      TabOrder = 2
      object sbtnExcluir: TSpeedButton
        Left = 0
        Top = 0
        Width = 81
        Height = 26
        Align = alClient
        Caption = 'Excluir'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = sbtnExcluirClick
        ExplicitLeft = 24
        ExplicitTop = -6
      end
    end
    object pnlSbtnCancelar: TPanel
      Left = 441
      Top = 7
      Width = 81
      Height = 26
      Align = alCustom
      BevelOuter = bvNone
      Color = clMedGray
      ParentBackground = False
      TabOrder = 3
      object sbtnCancelar: TSpeedButton
        Left = 0
        Top = 0
        Width = 81
        Height = 26
        Align = alClient
        Caption = 'Cancelar'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = sbtnCancelarClick
        ExplicitLeft = 1
      end
    end
  end
  object DBGrid: TDBGrid
    Left = 0
    Top = 41
    Width = 529
    Height = 215
    Align = alClient
    DataSource = DataSource
    DrawingStyle = gdsGradient
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = DBGridCellClick
    OnDrawColumnCell = DBGridDrawColumnCell
  end
  object DataSource: TDataSource
    DataSet = cdsProduct
    Left = 472
    Top = 96
  end
  object cdsProduct: TClientDataSet
    PersistDataPacket.Data = {
      910000009619E0BD010000001800000006000000000003000000910002494401
      00490000000100055749445448020002003200094553434F4C4849444F020003
      000000000006434F4449474F04000100000000000944455343524943414F0100
      49000000010005574944544802000200640005505245434F0800040000000000
      0A5155414E54494441444504000100000000000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'ESCOLHIDO'
        DataType = ftBoolean
      end
      item
        Name = 'CODIGO'
        DataType = ftInteger
      end
      item
        Name = 'DESCRICAO'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'PRECO'
        DataType = ftFloat
      end
      item
        Name = 'QUANTIDADE'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 472
    Top = 152
  end
end
