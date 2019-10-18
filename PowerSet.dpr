program PowerSet;

uses
  Forms,
  UfrmPower in 'UfrmPower.pas' {frmPower};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPower, frmPower);
  Application.Run;
end.
