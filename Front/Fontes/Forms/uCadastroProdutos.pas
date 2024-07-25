unit uCadastroProdutos;

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
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.ExtCtrls,
  Datasnap.DBClient,
  System.JSON,
  ProductAPIController,
  ProductAPIEntitie,
  Vcl.StdCtrls,
  Vcl.WinXCtrls,
  Vcl.Buttons,
  Vcl.ComCtrls;

type
  TfrmCadastroProdutos = class(TForm)
    Panel1: TPanel;
    GroupBox: TGroupBox;
    lblDescricao: TLabel;
    edtDescricao: TEdit;
    lblPreco: TLabel;
    edtPreco: TEdit;
    Label2: TLabel;
    lblQtd: TLabel;
    edtQtd: TEdit;
    pnlSbtnCancelar: TPanel;
    sbtnCancelar: TSpeedButton;
    pnlSbtnGravar: TPanel;
    sbtnGravar: TSpeedButton;
    procedure sbtnCancelarClick(Sender: TObject);
    procedure sbtnGravarClick(Sender: TObject);
    procedure edtDescricaoChange(Sender: TObject);
    procedure edtPrecoExit(Sender: TObject);
    procedure edtQtdExit(Sender: TObject);
  private
    procedure ShowConfirmationDialog(const AMessage: string; var AResult: Integer);
    function IsDouble(const Value: string): Boolean;
    function IsInteger(const Value: string): Boolean;
    procedure Post(AProduct: TProductApi; out AErrorMessage: string; out ASuccess: Boolean);
  public
  end;

var
  frmCadastroProdutos: TfrmCadastroProdutos;

implementation

{$R *.dfm}

const
  ACTION_ADD = 'Add';

procedure TfrmCadastroProdutos.sbtnCancelarClick(Sender: TObject);
var
  Response: Integer;
begin
  if (Trim(edtDescricao.Text) <> '') or (Trim(edtPreco.Text) <> '') or (Trim(edtQtd.Text) <> '') then
  begin
    ShowConfirmationDialog('Deseja cancelar a operação?', Response);
    if Response = mrYes then
      ModalResult := mrCancel;
  end
  else
  begin
    ModalResult := mrCancel;
  end;
end;

procedure TfrmCadastroProdutos.sbtnGravarClick(Sender: TObject);
var
  Response: Integer;
  Product: TProductApi;
  ErrorMessage: string;
  Success: Boolean;
begin
  if (Trim(edtDescricao.Text) = '') or (Trim(edtPreco.Text) = '') or (Trim(edtQtd.Text) = '') then
  begin
    ShowMessage('Todos os campos devem ser preenchidos.');
    Exit;
  end;

  ShowConfirmationDialog('Deseja confirmar a operação?', Response);
  if Response = mrYes then
  begin
    Product := TProductApi.Create;
    try
      Product.Description := edtDescricao.Text;
      Product.Price := StrToFloat(edtPreco.Text);
      Product.Amount := StrToInt(edtQtd.Text);

      Post(Product, ErrorMessage, Success);
      if Success then
      begin
        ShowMessage('Produto salvo com sucesso.');
        ModalResult := mrOk;
      end
      else
      begin
        ShowMessage('Falha ao salvar produto: ' + ErrorMessage);
      end;
    finally
      Product.Free;
    end;
  end;
end;

procedure TfrmCadastroProdutos.Post(AProduct: TProductApi; out AErrorMessage: string; out ASuccess: Boolean);
var
  APIController: TProductAPIController;
begin
  ASuccess := False;
  AErrorMessage := '';

  APIController := TProductAPIController.Create;
  try
    APIController.Action := ACTION_ADD;
    ASuccess := APIController.Post(AProduct, AErrorMessage);
  finally
    APIController.Free;
  end;
end;

procedure TfrmCadastroProdutos.edtDescricaoChange(Sender: TObject);
begin
  if Length(edtDescricao.Text) > 100 then
  begin
    ShowMessage('A descrição deve ter no máximo 100 caracteres.');
    edtDescricao.Text := Copy(edtDescricao.Text, 1, 100);
    edtDescricao.SelStart := Length(edtDescricao.Text);
  end;
end;

procedure TfrmCadastroProdutos.edtPrecoExit(Sender: TObject);
begin
  if not IsDouble(edtPreco.Text) then
  begin
    ShowMessage('O Preço deve conter um valor válido.');
    edtPreco.SetFocus;
  end;
end;

procedure TfrmCadastroProdutos.edtQtdExit(Sender: TObject);
begin
  if not IsInteger(edtQtd.Text) then
  begin
    ShowMessage('A Quantidade deve conter um número inteiro válido.');
    edtQtd.SetFocus;
  end;
end;

procedure TfrmCadastroProdutos.ShowConfirmationDialog(const AMessage: string; var AResult: Integer);
begin
  AResult := MessageDlg(AMessage, mtConfirmation, [mbYes, mbNo], 0);
end;

function TfrmCadastroProdutos.IsDouble(const Value: string): Boolean;
var
  TestValue: Double;
begin
  Result := TryStrToFloat(Value, TestValue);
end;

function TfrmCadastroProdutos.IsInteger(const Value: string): Boolean;
var
  TestValue: Integer;
begin
  Result := TryStrToInt(Value, TestValue);
end;

end.
