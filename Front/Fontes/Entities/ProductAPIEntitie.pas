unit ProductAPIEntitie;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON;

type
  TProductApi = class
  private
    FId: string;
    FCode: Integer;
    FDescription: string;
    FPrice: Double;
    FAmount: Integer;
  public
    constructor Create;

    procedure FromJSON(const AJSON: string);
    function ToJSON: string;

    property Id: string read FId write FId;
    property Code: Integer read FCode write FCode;
    property Description: string read FDescription write FDescription;
    property Price: Double read FPrice write FPrice;
    property Amount: Integer read FAmount write FAmount;
  end;

implementation

{ TProductApi }

constructor TProductApi.Create;
begin
  inherited;
end;

procedure TProductApi.FromJSON(const AJSON: string);
var
  JSONObj: TJSONObject;
begin
  JSONObj := TJSONObject.ParseJSONValue(AJSON) as TJSONObject;
  if Assigned(JSONObj) then
    try
      FId := JSONObj.GetValue<string>('id', '');
      FCode := JSONObj.GetValue<Integer>('code', 0);
      FDescription := JSONObj.GetValue<string>('description', '');
      FPrice := JSONObj.GetValue<Double>('price', 0.0);
      FAmount := JSONObj.GetValue<Integer>('amount', 0);
    finally
      JSONObj.Free;
    end
  else
    raise Exception.Create('Erro ao realizar o parse do JSON');
end;

function TProductApi.ToJSON: string;
var
  JSONObj: TJSONObject;
begin
  JSONObj := TJSONObject.Create;
  try
    JSONObj.AddPair('id', FId);
    JSONObj.AddPair('code', TJSONNumber.Create(FCode));
    JSONObj.AddPair('description', FDescription);
    JSONObj.AddPair('price', TJSONNumber.Create(FPrice));
    JSONObj.AddPair('amount', TJSONNumber.Create(FAmount));

    Result := JSONObj.ToString;
  finally
    JSONObj.Free;
  end;
end;

end.
