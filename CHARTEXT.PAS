unit CharText;
{$MODE OBJFPC}
interface
uses MyTypes;
Type
 PStr=^String;
 arrp=array[1..1000] of PStr;
 MyText = object
 Private
  TextStr :arrp;
  TextEnd:boolean;
  Function GetSize:my_int;
  Function GetStr:string;
  Function GetEnd:boolean;
 Public
  TextSize:my_int;
  TextI   :my_int;
  Constructor Init(name:string);
  Constructor Create(var x:machine_array;y:my_real);
  Procedure NewText;
  Destructor Done;
 Property Size:my_int
  Read GetSize;
 Property Str:string
  Read GetStr;
 Property _End:boolean
  Read GetEnd;
end;
implementation
uses plin, Sysutils,GlobalVar;
 Constructor MyText.Create(var x:machine_array;y:my_real);
 var
  f1:TextFile;
  h:my_real;
  s,s1:string;
 begin
   new(TextStr[1]);
   if TextStr[1]<>nil then
    TextStr[1]^:='definition;';
//   write(f1,'definition;');
   new(TextStr[2]);
   if TextStr[2]<>nil then
    TextStr[2]^:='places;';
//   writeln(f1,TextStr[2]^);
   new(TextStr[3]);
   if TextStr[3]<>nil then
    TextStr[3]^:='1:*;';
//   writeln(f1,TextStr[3]^);
   new(TextStr[4]);
   if TextStr[4]<>nil then
    TextStr[4]^:='2:'+floattostr(y)+';';
//   writeln(f1,TextStr[4]^);
   new(TextStr[5]);
   if TextStr[5]<>nil then
    TextStr[5]^:='3:*;';
//   writeln(f1,TextStr[5]^);
   new(TextStr[6]);
   if TextStr[6]<>nil then
    TextStr[6]^:='transitions;';
//   writeln(f1,TextStr[6]^);
   new(TextStr[7]);
   System.str((1/x[1].lambda):10:6,s);
   System.str((1/x[1].mu),s1);
   if TextStr[7]<>nil then
    TextStr[7]^:='1:'+s+','+s1+';';
//   writeln(f1,TextStr[7]^);
   new(TextStr[8]);
   System.str((1/x[2].lambda):10:6,s);
   System.str((1/x[2].mu),s1);
   if TextStr[8]<>nil then
    TextStr[8]^:='2:'+s+','+s1+';';
//   writeln(f1,TextStr[8]^);
   new(TextStr[9]);
   if TextStr[9]<>nil then
    TextStr[9]^:='end;';
//   writeln(f1,TextStr[9]^);
   new(TextStr[10]);
   if TextStr[10]<>nil then
    TextStr[10]^:='connect;';
//   writeln(f1,TextStr[10]^);
   new(TextStr[11]);
   if TextStr[11]<>nil then
    TextStr[11]^:='enters;';
//   writeln(f1,TextStr[11]^);
   new(TextStr[12]);
   System.str((1/x[1].u),s);
   if TextStr[12]<>nil then
    TextStr[12]^:='t1<=p1:'+s+';';
//   writeln(f1,TextStr[12]^);
   new(TextStr[13]);
   System.str((1/x[2].u),s);
   if TextStr[13]<>nil then
    TextStr[13]^:='t2<=p2:'+s+';';
//   writeln(f1,TextStr[13]^);
   new(TextStr[14]);
   if TextStr[14]<>nil then
    TextStr[14]^:='exits;';
//   writeln(f1,TextStr[14]^);
   new(TextStr[15]);
   System.str((1/x[1].u),s);
   if TextStr[15]<>nil then
    TextStr[15]^:='t1=>p2:'+s+';';
//   writeln(f1,TextStr[15]^);
   new(TextStr[16]);
   System.str((1/x[2].u),s);
   if TextStr[16]<>nil then
    TextStr[16]^:='t2=>p3:'+s+';';
//   writeln(f1,TextStr[16]^);
   new(TextStr[17]);
   if TextStr[17]<>nil then
    TextStr[17]^:='end;';
//       writeln(f1,TextStr[17]^);
   new(TextStr[18]);
   if TextStr[18]<>nil then
    TextStr[18]^:='end.';
//   writeln(f1,TextStr[18]^);
  TextSize:=19;
  TextI:=1;
  TextEnd:=false;
 end;
 Constructor MyText.Init(name:string);
 var
  f:TextFile;
  st:string;
  i,j,m:my_int;
  ok:boolean;
 begin
  TextI:=1;
  TextSize:=0;
  assignfile(f,name);
  reset(f);
  readln(f,St);
  while (not Eof(f)) and not ((st[1]='e') and(st[2]='n') and (st[3]='d')  and(st[4]='.') ) do
  begin
   new(TextStr[TextI]);
   if TextStr[TextI]<>nil then
    TextStr[TextI]^:=st;
   TextI:=TextI+1;
   readln(f,St);
  end;
  new(TextStr[TextI]);
  if TextStr[TextI]<>nil then
   TextStr[TextI]^:=st;
  TextSize:=TextI;
  TextI:=1;
  TextEnd:=false;
  readln(f,St);
  readln(f,m);
  for i:=1 to m do
  begin
//   if det_cost[i] = nil then
    new(det_cost[i]);
   read(f,det_cost[i]^.h);
  end;
  readln(f,st);
  readln(f,st);
  ok:=true;
  revenue.fread(f,ok);
  readln(f,st);
  readln(f,inv_coef);
  readln(f,st);
  readln(f,amort);
  readln(f,st);
  alloc_cost.fread(f,ok);
  close(f);
 end;
 Destructor MyText.Done;
 var i:my_int;
 begin
  for i:=1 to TextSize do
   if TextStr[i]<>nil then
    dispose(TextStr[i]);
 end;
 Function MyText.GetSize:my_int;
 begin
  GetSize:=TextSize;
 end;
 Function MyText.GetEnd:boolean;
 begin
  GetEnd:=TextEnd;
 end;
 Function MyText.GetStr:string;
 begin
  TextI:=TextI+1;
  if TextI-1 < TextSize then
   GetStr:=TextStr[TextI-1]^
  else
  begin
   TextEnd:=true;
   GetStr:='�';
  end;
 end;
 Procedure MyText.NewText;
 begin
   TextI:=1;
   TextEnd:=False;
 end;
end.

