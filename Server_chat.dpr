program Server_chat;

uses
  Forms,
  UServer in 'UServer.pas' {FmChat},
  UInput in 'UInput.pas' {FmInput};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFmChat, FmChat);
  Application.Run;
end.
