program ProductManagement;

uses
  Vcl.Forms,
  ProductAPIController in 'Fontes\Controllers\ProductAPIController.pas',
  ProductAPIEntitie in 'Fontes\Entities\ProductAPIEntitie.pas',
  uPrincipal in 'Fontes\Forms\uPrincipal.pas',
  uProdutos in 'Fontes\Forms\uProdutos.pas',
  uCadastroProdutos in 'Fontes\Forms\uCadastroProdutos.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Gestão de Produtos';
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
