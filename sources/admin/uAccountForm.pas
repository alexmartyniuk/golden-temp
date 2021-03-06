unit uAccountForm;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ExtCtrls,
  uRemotable;

type
  TAccountForm = class(TForm)
    PanelMain: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EditHost: TEdit;
    EditLogin: TEdit;
    EditPassword: TEdit;
    CheckBoxSavePassword: TCheckBox;
    ButtonOK: TButton;
    ButtonCancel: TButton;
    procedure FormShow(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
      { Private declarations }
  end;

implementation

uses
  uChangePasswordForm,
  uInterfaces,
  uFactories,
  uUtils,
  uMainUnit;

{$R *.DFM}

procedure TAccountForm.ButtonOKClick(Sender: TObject);
begin
  Remotable.Account.Login := EditLogin.Text;
  Remotable.Account.Password := EditPassword.Text;
  Remotable.Host := EditHost.Text;
end;

procedure TAccountForm.FormShow(Sender: TObject);
begin
  EditLogin.Text := Remotable.Account.Login;
  EditPassword.Text := Remotable.Account.Password;
  EditHost.Text := Remotable.Host;
end;

end.
