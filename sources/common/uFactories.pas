unit uFactories;

interface

uses
  SysUtils,
  Windows,
  Forms,
  SOAPHttpClient,
  uInterfaces,
  uRemotable;

type

  Core = class
    public
      class function NewSettings(const ASection: string = ''): ISettings;
  end;

  Remotable = class
    private
      class var FHost: string;
      class var FAdministrator: IAdministrator;
    private
      class function GetHost: string; static;
      class procedure SetHost(const Value: string); static;

      class function GetAdministrator: IAdministrator; static;
      class procedure SetAdministrator(const Value: IAdministrator); static;

    public
      class property Administrator: IAdministrator read GetAdministrator write SetAdministrator;
      class property Host: string read GetHost write SetHost;
  end;

  Dialog = class
    public
      class function NewSplash(MainForm: TForm): ISplash;
      class procedure ShowWarningMessage(const AMessage: string);
  end;

implementation

uses
  uSplashImpl,
  uSettingsImpl;

{ Dialog }

class function Dialog.NewSplash(MainForm: TForm): ISplash;
begin
  Result := TFormSplash.Create(MainForm);
end;

class procedure Dialog.ShowWarningMessage(const AMessage: string);
begin
  MessageBox(Application.MainFormHandle, PChar(AMessage), '������������', MB_OK);
end;

{ Remotable }

class function Remotable.GetAdministrator: IAdministrator;
var
  HTTPRIO: THTTPRIO;
begin
  if not Assigned(FAdministrator) then
  begin
    HTTPRIO := THTTPRIO.Create(nil);

    // FAdministrator.HTTPWebNode.OnPostingData := OnPostData;
    // FAdministrator.HTTPWebNode.OnReceivingData := OnReceiveData;
    // FAdministrator.HTTPWebNode.OnWinInetError := OnInetError;
    HTTPRIO.URL := Format('http://%s:%d/soap/IAdministrator', [FHost, 3030]);
    FAdministrator := HTTPRIO as IAdministrator;
  end;
  Result := FAdministrator;
end;

class function Remotable.GetHost: string;
begin
  Result := FHost;
end;

class procedure Remotable.SetAdministrator(const Value: IAdministrator);
begin
  Administrator := Value;
end;

class procedure Remotable.SetHost(const Value: string);
begin
  if SameText(FHost, Value) then
    Exit;
  FHost := Value;
  FAdministrator := nil;
end;

{ Core }

class function Core.NewSettings(const ASection: string): ISettings;
begin
  Result := TSettingsImpl.Create;
  Result.SectionName := ASection;
end;

end.