program LocalSearchConcole;

uses
  SysUtils,
  Classes,
  Messages,
  Problem,
  VarType,
  CharText,
  BAPLocalSearchImitation,
    BAPLocalSearch,
  BAPReduceLine,
  BAPImitation;

var
 f1:TStringList;
 LS:TBAPLocalSearchImitation;
 //LS:TBAPLocalSearch;
 PR:TBAPReduceLine;
 IPR:TBAPImitation;
 s:string;
 input,output:string;
 txt : MyText;
 run_cnt: TIndex;

begin
try
 input:=ParamStr(1);
 output:=ParamStr(2);
  run_cnt:=StrToInt(ParamStr(3));
 if input = '' then
  begin
     WriteLn('Error: Input file not found');
     readln;
     exit;
  end;
 Randomize;

 f1:=TStringList.Create;
 f1.Duplicates:=dupIgnore;
 f1.Sorted:=false;
 f1.LoadFromFile(ParamStr(1));

 if output = '' then output:= input;

 LS:=TBAPLocalSearchImitation.Create;
// LS:=TBAPLocalSearch.Create;
 LS.NameDebugFile:=output+'.deb';
 LS.NameRecordFile:=output+'.rec';


 {PR:=TBAPReduceLine.Create();
 PR.Load(f1);
 LS.Task := PR;}


 
 txt.Init(input);
 ipr:= TBAPImitation.Create(txt);
 ipr.SimulationDuration:=3000;
 ipr.NumberSimulationIterations:=10;
 ipr.Hash.MaxSize:=3000;
 LS.Task := IPR;



 LS.RunQuantity := run_cnt;
 if ParamCount >= 4 then
  LS.FirstRecordList.LoadFromFile(ParamStr(4));

 try
  LS.GetMemory();
  except
   on e: exception do
      begin
           WriteLn('Parsing error of input file: '+E.ToString);
           readln;
           exit;
      end;
  end;
 LS.Algoritm;

 LS.Destroy;


 //f1.Free;

 WriteLn('Done...');
 //readln;
 except
   on e: exception do
      begin
           WriteLn('Error: '+E.ToString);
           readln;
      end;

 end;

end.

