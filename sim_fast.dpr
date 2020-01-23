program sim_fast;

uses
  Forms,
  main in 'main.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'sim_fast';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
