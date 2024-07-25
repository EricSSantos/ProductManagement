unit ProductAPIController;

interface

uses
  IdHTTP,
  Classes,
  SysUtils,
  Rest.JSON,
  ProductAPIEntitie;

type
  TProductAPIController = class
  private
    FURL: string;
    FAction: string;
    FParams: TStringList;
    function BuildURL: string;
  public
    constructor Create;
    destructor Destroy; override;
    property URL: string read FURL write FURL;
    property Action: string read FAction write FAction;
    property Params: TStringList read FParams write FParams;
    function Get(out AMensagem: string): string;
    function Post(AProduct: TProductApi; out AMensagem: string): Boolean;
    function Delete(out AMensagem: string): string;
  end;

implementation

const
  BASE_URL = 'http://localhost:5000/api/Product';

{ TProductAPIController }

constructor TProductAPIController.Create;
begin
  inherited;
  FURL := BASE_URL;
  FParams := TStringList.Create;
end;

destructor TProductAPIController.Destroy;
begin
  FParams.Free;
  inherited;
end;

function TProductAPIController.BuildURL: string;
begin
  Result := FURL + '/' + FAction;
  if FParams.Count > 0 then
    Result := Result + '/' + FParams.DelimitedText.Replace('=', '=').Replace(' ', '&');
end;

function TProductAPIController.Get(out AMensagem: string): string;
var
  http: TIdHTTP;
begin
  Result := '';
  AMensagem := '';
  http := TIdHTTP.Create(nil);
  try
    try
      Result := http.Get(BuildURL);
    except
      on E: EIdHTTPProtocolException do
      begin
        AMensagem := E.ErrorMessage;
      end;
      on E: Exception do
      begin
        AMensagem := E.Message;
      end;
    end;
  finally
    http.Free;
  end;
end;

function TProductAPIController.Post(AProduct: TProductApi; out AMensagem: string): Boolean;
var
  http: TIdHTTP;
  JsonRequest: TStringStream;
begin
  Result := False;
  AMensagem := '';
  http := TIdHTTP.Create(nil);
  try
    http.Request.ContentType := 'application/json';
    JsonRequest := TStringStream.Create(AProduct.ToJSON, TEncoding.UTF8);
    try
      try
        http.Post(BuildURL, JsonRequest);
        Result := True;
      except
        on E: EIdHTTPProtocolException do
        begin
          AMensagem := E.ErrorMessage;
        end;
        on E: Exception do
        begin
          AMensagem := E.Message;
        end;
      end;
    finally
      JsonRequest.Free;
    end;
  finally
    http.Free;
  end;
end;

function TProductAPIController.Delete(out AMensagem: string): string;
var
  http: TIdHTTP;
begin
  Result := '';
  AMensagem := '';
  http := TIdHTTP.Create(nil);
  try
    try
      Result := http.Delete(BuildURL);
    except
      on E: EIdHTTPProtocolException do
      begin
        AMensagem := E.ErrorMessage;
      end;
      on E: Exception do
      begin
        AMensagem := E.Message;
      end;
    end;
  finally
    http.Free;
  end;
end;

end.
