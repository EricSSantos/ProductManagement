unit uPrincipal;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.Menus,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.WinXCtrls,
  uCadastroProdutos,
  uProdutos;

type
  TfrmPrincipal = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.FormCreate(Sender: TObject);
var
  frmProdutos: TfrmProduct;
begin
  Constraints.MaxWidth := 535;
  Constraints.MaxHeight := 285;

  frmProdutos := TfrmProduct.Create(Self);
  try
    frmProdutos.Parent := Self;
    frmProdutos.BorderStyle := bsNone;
    frmProdutos.Align := alClient;

    frmProdutos.Show;
  except
    frmProdutos.Free;
  end;
end;

end.

