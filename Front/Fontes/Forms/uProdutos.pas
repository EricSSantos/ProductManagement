unit uProdutos;

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
  Datasnap.DBClient,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  System.JSON,
  System.Generics.Collections,
  uCadastroProdutos,
  ProductAPIController,
  ProductAPIEntitie,
  Vcl.Buttons;

type
  TfrmProduct = class(TForm)
    DataSource: TDataSource;
    cdsProduct: TClientDataSet;
    Panel: TPanel;
    sbtnIncluir: TSpeedButton;
    pnlSbtnIncluir: TPanel;
    pnlSbtnBuscar: TPanel;
    sbtnBuscar: TSpeedButton;
    DBGrid: TDBGrid;
    pnlSbtnExcluir: TPanel;
    sbtnExcluir: TSpeedButton;
    pnlSbtnCancelar: TPanel;
    sbtnCancelar: TSpeedButton;
    procedure sbtnBuscarClick(Sender: TObject);
    procedure sbtnIncluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure DBGridCellClick(Column: TColumn);
    procedure sbtnExcluirClick(Sender: TObject);
    procedure sbtnCancelarClick(Sender: TObject);
  private
    function GetAll(out AMensagem: string): string;
    function Delete(AId: string; out AMensagem: string): string;
    procedure LoadProducts(const JSONResponse: string);
    procedure AddProductToDataSet(const ProductJSON: string);
  public
  end;

var
  frmProduct: TfrmProduct;

implementation

{$R *.dfm}

const
  ACTION_GET_ALL = 'GetAll';
  ACTION_DELETE = 'Delete';

procedure TfrmProduct.sbtnBuscarClick(Sender: TObject);
var
  Mensagem: string;
  Response: string;
begin
  Response := GetAll(Mensagem);

  if Mensagem <> '' then
  begin
    ShowMessage('Erro: ' + Mensagem);
    Exit;
  end;

  LoadProducts(Response);
end;

procedure TfrmProduct.sbtnCancelarClick(Sender: TObject);
begin
  if cdsProduct.Active then
  begin
    cdsProduct.DisableControls;
    try
      cdsProduct.EmptyDataSet;
    finally
      cdsProduct.EnableControls;
    end;
  end;
end;

procedure TfrmProduct.sbtnIncluirClick(Sender: TObject);
var
  frmCadastroProdutos: TfrmCadastroProdutos;
begin
  frmCadastroProdutos := TfrmCadastroProdutos.Create(Self);
  try
    frmCadastroProdutos.ShowModal;
  except
    frmCadastroProdutos.Free;
  end;
end;

procedure TfrmProduct.sbtnExcluirClick(Sender: TObject);
var
  Mensagem, Response, Id: string;
  IDs: TStringList;
begin
  IDs := TStringList.Create;
  try
    DBGrid.DataSource.DataSet.First;
    while not DBGrid.DataSource.DataSet.Eof do
    begin
      if DBGrid.DataSource.DataSet.FieldByName('ESCOLHIDO').AsBoolean then
      begin
        IDs.Add(DBGrid.DataSource.DataSet.FieldByName('ID').AsString);
      end;
      DBGrid.DataSource.DataSet.Next;
    end;

    if IDs.Count = 0 then
    begin
      ShowMessage('Nenhum item selecionado para exclusão.');
      Exit;
    end;

    for Id in IDs do
    begin
      Response := Delete(Id, Mensagem);
      if Mensagem <> '' then
      begin
        ShowMessage('Erro ao excluir os itens');
        Exit;
      end;
    end;

    ShowMessage('Itens excluídos com sucesso.');

    LoadProducts(Response);

  finally
    IDs.Free;
  end;
end;

function TfrmProduct.GetAll(out AMensagem: string): string;
var
  productAPIController: TProductAPIController;
begin
  Result := '';
  AMensagem := '';
  productAPIController := TProductAPIController.Create;
  try
    productAPIController.Action := ACTION_GET_ALL;
    Result := productAPIController.Get(AMensagem);
  finally
    productAPIController.Free;
  end;
end;

function TfrmProduct.Delete(AId: string; out AMensagem: string): string;
var
  productAPIController: TProductAPIController;
begin
  Result := '';
  AMensagem := '';
  productAPIController := TProductAPIController.Create;
  try
    productAPIController.Action := ACTION_DELETE;
    productAPIController.Params.Add(AId);
    Result := productAPIController.Delete(AMensagem);
  finally
    productAPIController.Free;
  end;
end;

procedure TfrmProduct.LoadProducts(const JSONResponse: string);
var
  JSONValue: TJSONValue;
  JSONArray: TJSONArray;
  JSONItem: TJSONValue;
begin
  cdsProduct.DisableControls;
  try
    cdsProduct.Open;
    cdsProduct.EmptyDataSet;
    JSONValue := TJSONObject.ParseJSONValue(JSONResponse);
    try
      if JSONValue is TJSONArray then
      begin
        JSONArray := TJSONArray(JSONValue);

        for JSONItem in JSONArray do
        begin
          if JSONItem is TJSONObject then
            AddProductToDataSet(JSONItem.ToString);
        end;
      end;
    finally
      JSONValue.Free;
    end;
  finally
    cdsProduct.EnableControls;
  end;
end;

procedure TfrmProduct.AddProductToDataSet(const ProductJSON: string);
var
  Product: TProductApi;
begin
  Product := TProductApi.Create;
  try
    Product.FromJSON(ProductJSON);
    cdsProduct.Append;
    cdsProduct.FieldByName('ID').AsString := Product.Id;
    cdsProduct.FieldByName('CODIGO').AsInteger := Product.Code;
    cdsProduct.FieldByName('DESCRICAO').AsString := Product.Description;
    cdsProduct.FieldByName('PRECO').AsFloat := Product.Price;
    cdsProduct.FieldByName('QUANTIDADE').AsInteger := Product.Amount;
    cdsProduct.Post;
  finally
    Product.Free;
  end;
end;

procedure TfrmProduct.DBGridCellClick(Column: TColumn);
begin
  if (DBGrid.DataSource.DataSet.IsEmpty) then
    Exit;

  if Column.Index = 1 then
  begin
    DBGrid.DataSource.DataSet.Edit;

    if DBGrid.DataSource.DataSet.FieldByName('ESCOLHIDO').AsBoolean then
      DBGrid.DataSource.DataSet.FieldByName('ESCOLHIDO').AsBoolean := False
    else
      DBGrid.DataSource.DataSet.FieldByName('ESCOLHIDO').AsBoolean := True;

    DBGrid.DataSource.DataSet.Post;
  end;
end;

procedure TfrmProduct.DBGridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  Check: Integer;
  CheckBoxRect: TRect;
begin
  if not(gdSelected in State) then
  begin
    if Column.FieldName = 'ESCOLHIDO' then
    begin
      DBGrid.Canvas.Brush.Color := clInfoBk;
      DBGrid.Canvas.FillRect(Rect);
    end
    else
    begin
      if DataSource.DataSet.RecNo mod 2 = 0 then
        DBGrid.Canvas.Brush.Color := clWhite
      else
        DBGrid.Canvas.Brush.Color := cl3DLight;

      DBGrid.Canvas.FillRect(Rect);
    end;
  end
  else
  begin
    DBGrid.Canvas.Brush.Color := clHighlight;
    DBGrid.Canvas.FillRect(Rect);
  end;

  if Column.FieldName = 'ESCOLHIDO' then
  begin
    CheckBoxRect := Rect;
    InflateRect(CheckBoxRect, 2, 2);

    if (DataSource.DataSet.FieldByName('ESCOLHIDO').AsBoolean) then
      Check := DFCS_CHECKED
    else
      Check := 0;

    DrawFrameControl(DBGrid.Canvas.Handle, CheckBoxRect, DFC_BUTTON, DFCS_BUTTONCHECK or Check);
  end
  else
  begin
    DBGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TfrmProduct.FormCreate(Sender: TObject);
begin
  DBGrid.Columns[0].Visible := False;
  DBGrid.Columns[1].Width := 20;
  DBGrid.Columns[1].Title.Caption := ' ';
  DBGrid.Columns[1].Alignment := taCenter;
  DBGrid.Columns[2].Width := 74;
  DBGrid.Columns[2].Title.Caption := 'Código';
  DBGrid.Columns[2].Alignment := taLeftJustify;
  DBGrid.Columns[3].Width := 230;
  DBGrid.Columns[3].Title.Caption := 'Descrição';
  DBGrid.Columns[3].Alignment := taLeftJustify;
  DBGrid.Columns[4].Width := 74;
  DBGrid.Columns[4].Title.Caption := 'Preço';
  DBGrid.Columns[4].Alignment := taRightJustify;
  DBGrid.Columns[5].Width := 74;
  DBGrid.Columns[5].Title.Caption := 'Quantidade';
  DBGrid.Columns[5].Alignment := taRightJustify;
end;

end.
