unit UServer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Sockets, StdCtrls, IniFiles;

type
  TFmChat = class(TForm)
    tsrv1: TTcpServer;
    pnmenu: TPanel;
    pnSend: TPanel;
    pnChat: TPanel;
    pnUsers: TPanel;
    tmSend: TMemo;
    btnSend: TButton;
    tmChat: TMemo;
    lstUser: TListBox;
    tcl1: TTcpClient;
    tmr1: TTimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure tsrv1Accept(Sender: TObject; ClientSocket: TCustomIpClient);
    procedure tsrv1GetThread(Sender: TObject;
      var ClientSocketThread: TClientSocketThread);
    procedure tmr1Timer(Sender: TObject);
    procedure tmChatChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TMyClientThread = class(TClientSocketThread)
    private
       FUser: String;
       FData: String;
       SServer:string;
       NewMessage:Boolean;
protected
    procedure SyncProc; override;
end;

var
  FmChat: TFmChat;
  User,password,new_str:string;
  Users : TIniFile;


const
  Cod='0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/';

implementation

{$R *.dfm}
 uses UInput;

 function Encode(S:string):string;
var
  i,a,b,x: Integer;
begin
  a:=0;
  b:=0;
  for i:=1 to length(s) do
  begin
    x:=Ord(s[i]);
    b:= b*256+x;
    inc(a,8);
    while a>=6 do
    begin
      dec(a,6);
      x:=b div (1 shl a);
      b:=b mod (1 shl a);
      Result:=Result+Cod[x+1];
    end;
  end;
  if a>0 then
  begin
    x:=b shl (6-a);
    Result:=Result+Cod[x+1];
  end;
end;

function Decode(S:string):string;
var
  i,a,b,x: Integer;
begin
  a:=0;
  b:=0;
  for i:=1 to length(s) do
  begin
    x:=pos(s[i], cod)-1;
    if x>=0 then
    begin
      b:=b*64+x;
      inc(a,6);
      if a>=8 then
      begin
        dec(a,8);
        x:=b shr a;
        b:=b mod (1 shl a);
        x:=x mod 256;
        Result:=Result+chr(x);
      end;
    end
    else
      Exit;
  end;
end;



procedure  TMyClientThread.SyncProc;
begin
   if FData<>'' then
   begin
     if FData='Terminate' then
      begin
         Terminate;
         ClientSocket.Sendln('Terminate');
         Exit;
      end;
     FmChat.tmChat.Lines.Add(FUser+': '+FData);
     ClientSocket.Sendln('-> : '+FData);
   end
   else
    begin
     if Sserver<>'' then
        ClientSocket.Sendln(SServer)
     else
        ClientSocket.Sendln('');
    end;

end;


procedure TFmChat.btnSendClick(Sender: TObject);
var s:AnsiString;
begin
     if FmChat.Tag=2 then
      //клиент
      begin
        if not tcl1.Connected then
         begin
           ShowMessage('Ќет соединени€ с сервером');
           Exit;
         end;
        s:=tmSend.Lines[0];
        tcl1.Sendln(s);
        s:=tcl1.Receiveln();
        tmChat.Lines.Add(s);
        tmSend.Lines.Delete(0);
      end
     else
      //сервер
      begin
        s:=tmSend.Lines[0];
        tmChat.Lines.Add('—ервер-> '+s);
        tmSend.Lines.Delete(0);
      end;
end;

procedure TFmChat.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    if FmChat.Tag=1 then tsrv1.Active:=false;
end;

procedure TFmChat.FormCreate(Sender: TObject);
begin
      Users:=TIniFile.Create(ExtractFileDir(Application.EXEName)+'\users.ini');
end;

procedure TFmChat.FormShow(Sender: TObject);
var s:AnsiString;
begin
      Application.CreateForm(TFmInput, FmInput);
      if FmInput.ShowModal=mrCancel then Application.Terminate;
      if (FmChat.Tag=2) then
       begin
        if (tcl1.Connected) then ShowMessage('ѕодключились')
                            else Close;
        //авторизаци€
        s:='User';
        tcl1.Sendln(s);
        //им€ пользовател€
        tcl1.Sendln(User);
        // пароль пользовател€ передаем закодированный
        tcl1.Sendln(Encode(password));
        //tmChat.Lines.Add(Encode(password));
       end
      else
       begin

        ShowMessage('—ервер запущен!');
       end;


end;

procedure TFmChat.tmChatChange(Sender: TObject);
begin
     if FmChat.Tag=1 then
        New_str:=tmChat.Lines.Strings[tmChat.Lines.Count-1]
     else
       if tmChat.Lines.Strings[tmChat.Lines.Count-1]='Terminate' then Application.Terminate;

end;

procedure TFmChat.tmr1Timer(Sender: TObject);
var s:string;
begin
       if tcl1.Connected then
        begin
             s:='';
             tcl1.Sendln(s);
             s:=tcl1.Receiveln();
             if s<>'' then  tmChat.Lines.Add(s);
        end;
end;

procedure TFmChat.tsrv1Accept(Sender: TObject; ClientSocket: TCustomIpClient);
begin
      with (ClientSocket.GetThreadObject as TMyClientThread) do
      begin
             while not Terminated do
             begin
                FData:= ClientSocket.Receiveln;
                if FData='User' then
                 begin
                   FUser:=ClientSocket.Receiveln;
                   FData:=ClientSocket.Receiveln;
                   //проверка парол€
                    password:=Users.ReadString('', UpperCase(FUser), '');
                    //если новый пользователь добавл€ем в список
                    if password='' then
                     begin
                        Users.WriteString('',UpperCase(FUser),FData);
                        password:=FData;
                     end;
                    if password=FData then
                     tmChat.Lines.Add(FUser+' вошел в чат!')
                    else
                     ClientSocket.Sendln('Terminate');
                   //tmChat.Lines.Add(Fdata);
                 end
                else
                 begin
                    if new_str=SServer then NewMessage:=False
                   else NewMessage:=True;
                   if NewMessage then SServer:=new_str else SServer:='';
                   ExecuteSyncProc;
                   SServer:=new_str;
                 end;
            end;
      end;
end;

procedure TFmChat.tsrv1GetThread(Sender: TObject;
  var ClientSocketThread: TClientSocketThread);
begin
   ClientSocketThread:=TMyClientThread.Create(tsrv1.ServerSocketThread);
end;

end.
