unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    EditRound: TEdit;
    Memo1: TMemo;
    ButtonSimulate: TButton;
    EditSim: TEdit;
    ButtonCalcBank: TButton;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ButtonClear: TButton;
    CheckBox1: TCheckBox;
    ButtonSimFast: TButton;
    procedure ButtonSimulateClick(Sender: TObject);
    procedure ButtonCalcBankClick(Sender: TObject);
    procedure ButtonClearClick(Sender: TObject);
    procedure ButtonSimFastClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function CalcBank(ALose: integer): real;
    function GetBank(ALose: integer): real;
    procedure CreateArray;
  end;

var
  //BankArray: array[0..500] of real;
  BankArray: array of real;
  MaskArray: array[0..65535] of integer;
  N: integer;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.ButtonSimulateClick(Sender: TObject);
var
  i, k, Count, Lose : integer;
  Bank, Total: real;
  S: Integer;
  Half: integer;
  LoseTotal: int64;
  Start: TDateTime;
begin
  Randomize;
  N:= StrToIntDef(EditRound.Text, 500);
  S:= StrToIntDef(EditSim.Text, 100000);
  SetLength(BankArray, N + 1);
  for i:= 0 to High(BankArray) do begin
    BankArray[i]:= CalcBank(i) - 1; // -1;
  end;

  Half:= Round(N * 0.422);
  Count:= 0;
  Total:= 0;
  LoseTotal:= 0;
  Memo1.Lines.Add(Format(' Start %d Simulation,  %d Round  ', [S, N])) ;
  Start:= Now;
  for k:= 1 to S do begin
     Lose:= 0;
     for i:= 1 to N do begin
       if Random < 0.5 then begin
         Inc(Lose);
       end;
     end;
     Bank:= GetBank(Lose);
     Total:= Total + Bank;
     LoseTotal:= LoseTotal + Lose;
     if Lose <= Half then begin
       Inc(Count);
       if not CheckBox1.Checked then
         Memo1.Lines.Add(Format('%d.    N:    %d,  Lose: %d,  Result =   %n,          Total = %n', [Count,k, Lose, Bank,Total])) ;
     end;
  end;
  Memo1.Lines.Add('');
  Memo1.Lines.Add(Format(' End %d Simulation,  Win simulation:  %d,   Total = %n ', [S, Count,  Total])) ;
  Memo1.Lines.Add(Format('Total Lose: %d, Total Win: %d ', [LoseTotal, S*N - LoseTotal]));
  Memo1.Lines.Add('Time: '+ TimeToStr(Start - Now));
  Memo1.Lines.Add('');

end;

function TForm1.CalcBank(ALose: integer): real;
var
  Win: integer;
  Bank: real;
begin
  //N:= StrToIntDef(EditRound.Text, 1000);
  Bank:= 1;
  Win:= N - ALose;
  while (ALose > 0) and (Win > 0) do begin
    if Bank > 1 then begin
      Bank:= Bank * 0.55;
      Dec(ALose);
    end else begin
      Bank:= Bank * 1.55;
      Dec(Win);
    end;
  end;
  repeat
    if ALose > 0 then begin
        Bank:= Bank * 0.55;
        Dec(ALose);
    end else if Win > 0 then begin
      Bank:= Bank * 1.55;
      Dec(Win);
    end;
  until (ALose = 0) and (Win = 0);
  Result:= Bank;
end;

function TForm1.GetBank(ALose: integer): real;
begin
  Result:= BankArray[ALose];
end;

procedure TForm1.ButtonCalcBankClick(Sender: TObject);
var
  Lose: integer;
  Bank: real;
begin
  Lose:= StrToIntDef(Edit4.Text, 500);
  Bank:= CalcBank(Lose);
  Memo1.Lines.Add(Format('Lose = %d, Bank = %f ', [Lose, Bank])) ;
end;

procedure TForm1.ButtonClearClick(Sender: TObject);
begin
  Memo1.Clear;
end;

procedure TForm1.CreateArray;
var
  i, Mask: Word;
  k, Count, Half: integer;
begin
  for i:= 0 to High(MaskArray) do begin
    Mask:= i;
    Count:= 0;
    for k:= 1 to 16 do begin
      Count:= Count + Mask and 1;   // count only last bit
      Mask:= Mask shr 1;
    end;
    MaskArray[i]:= Count;
  end;
  SetLength(BankArray, N + 1);
  for i:= 0 to High(BankArray) do begin
      BankArray[i]:= CalcBank(i) - 1;
  end;
end;

procedure TForm1.ButtonSimFastClick(Sender: TObject);
var
  i, k, m, Count, Lose, NumMask, Ost, Half : integer;
  Bank, Total: real;
  S, LoseTotal: Int64;
  Mask: Word;
  Start: TDateTime;
begin
  Randomize;
  N:= StrToIntDef(EditRound.Text, 500);
  S:= StrToInt64Def(EditSim.Text, 100000);
  NumMask:= N div 16;
  Ost:= (N mod 16);
  if Ost <> 0 then
    Ost:= 16 - Ost;
 // N:= NumMask * 16;
  EditRound.Text:= IntToStr(N);
  Half:= Round(N * 0.422);
  Count:= 0;
  Total:= 0;
  LoseTotal:= 0;
  Memo1.Lines.Add(Format(' Start %d Simulation,  %d Round  ', [S*1000, N])) ;
  Start:= Now;
  CreateArray;

  for k:= 1 to S do begin
    for m:= 1 to 1000 do begin
     Lose:= 0;
     for i:= 1 to NumMask do begin
       Mask:= Random(65536);
       Lose:= Lose + MaskArray[Mask];
     end;
     if Ost > 0 then begin
       Mask:= Random(65536);
       Mask:= Mask shr Ost;
       Lose:= Lose + MaskArray[Mask];       // calc ostatok bit
     end;
     //Bank:= BankArray[Lose]; // GetBank(Lose);
     Total:= Total + BankArray[Lose]; // Bank;
     LoseTotal:= LoseTotal + Lose;
    {
     if Lose <= Half then begin
       Inc(Count);
       if not CheckBox1.Checked then
         Memo1.Lines.Add(Format('%d.  N:     %d,  Lose: %d,  Result =  %n,          Total = %n', [Count,k, Lose, Bank,Total])) ;
     end;
     }
    end;
  end;
  Memo1.Lines.Add('');
  Memo1.Lines.Add(Format(' End %d Simulation,  Total = %n ', [S*1000, Total])) ;
  Memo1.Lines.Add(Format('Total Lose: %d, Total Win: %d ', [LoseTotal, S*N*1000 - LoseTotal]));
  Memo1.Lines.Add('Time: '+ TimeToStr(Start - Now));
  Memo1.Lines.Add('');

end;


end.
