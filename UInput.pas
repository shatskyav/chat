unit UInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TFmInput = class(TForm)
    cbTip: TComboBox;
    edUser: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edPass: TEdit;
    Label3: TLabel;
    edAdress: TEdit;
    btn1: TBitBtn;
    procedure cbTipChange(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmInput: TFmInput;

implementation

{$R *.dfm}
uses UServer;

procedure TFmInput.btn1Click(Sender: TObject);
begin
     if cbTip.ItemIndex=0 then
      begin
       FmChat.Tag:=1;
       FmChat.tsrv1.LocalHost:=edAdress.Text;
       FmChat.tsrv1.Active:=True;
       FmChat.Caption:='Чат - Сервер';
      end
     else
      begin
        FmChat.Tag:=2;
        FmChat.tcl1.RemoteHost:=edAdress.Text;
        //проверка пользователя
        if edUser.Text='' then
        begin
          ShowMessage('Введите имя пользователя');
          edUser.SetFocus;
          Exit;
        end;
        // проверка пароля
        if edPass.Text='' then
        begin
          ShowMessage('Пароль не должен быть пустым');
          edPass.SetFocus;
          Exit;
        end;

        FmChat.tcl1.Connect;
        FmChat.Caption:='Чат - Клиент';
      end;
     User:=edUser.Text;
     password:=edPass.Text;


     ModalResult := mrOk;
end;

procedure TFmInput.cbTipChange(Sender: TObject);
begin
     { if cbTip.ItemIndex=0 then
       begin
          Label3.Visible:=False;
          edAdress.Visible:=False;
       end
      else
       begin
          Label3.Visible:=True;
          edAdress.Visible:=True;
       end;
      }
end;

end.
