{$IFDEF INTERFACE}
  PTVector = ^TVector;
  TVector = Class
  private
   FSize             :Integer;
   Element_           :array of T;
   Function GetSize_ :Integer;
   Procedure SetSize(x:Integer);
   Function GetElement(Index:Integer) :T;
   Procedure SetElement(Index:Integer; Value:T);

  public
   Constructor Create();overload;
   Constructor Create(const x : TVector);overload;
   Destructor Destroy;override;

   Procedure GetMemory;
   Procedure FreeMemory;

   Procedure FillBy(x: T);
   Procedure Assign(const x:TVector);overload;

   Function IsEqual(const x:TVector):Boolean;

   Property Size:Integer read FSize write SetSize;
   Property Size_:Integer read GetSize_;
   Property Element[Index:Integer]:T read GetElement write SetElement;
  end;
{$UNDEF INTERFACE}
{$ENDIF}

{$IFDEF IMPLEMENTATION}
 {******************************************************************************}
 Constructor TVector.Create();
 begin
   FSize:=0;
 end;
{******************************************************************************}
 Constructor TVector.Create(const x : TVector);
 begin
  Assign(x);
 end;
{******************************************************************************}
 Destructor TVector.Destroy;
 begin
  FreeMemory;
 end;
{******************************************************************************}
 Procedure TVector.GetMemory;
 begin
  SetLength(Element_,FSize);
 end;
{******************************************************************************}
 Procedure TVector.FreeMemory;
 begin
  if FSize <> 0 then
    Finalize(Element_);
 end;
{******************************************************************************}
 Procedure TVector.FillBy(x:T);
 var i : Integer;
 begin
  for i:=0 to Size_ do  Element_[i]:=x;
 end;
{******************************************************************************}
 Procedure TVector.Assign(const x:TVector);
 var i:Integer;
 begin
  if x.Size <> Size then Size:=x.Size;
  for i:=0 to Size_ do  Element_[i] := x.Element_[i];
 end;
{******************************************************************************}
 Function TVector.IsEqual(const x:TVector):Boolean;
 var i:Integer;
 begin
  IsEqual:=false;
  if Size = x.Size then
  begin
   IsEqual:=true;
   for i:=0 to Size_ do
    if x.Element_[i] <> Element_[i] then
    begin
     IsEqual:=false;
     break;
    end;
  end;
 end;
{******************************************************************************}
 Function TVector.GetSize_:Integer;
 begin
  GetSize_:=FSize-1;
 end;
{******************************************************************************}
 Procedure TVector.SetSize(x:Integer);
 begin
  FreeMemory;
  FSize:=x;
  GetMemory;
 end;
{******************************************************************************}
Function TVector.GetElement(Index:Integer) :T;
begin
 GetElement:=Element_[Index];
end;
{******************************************************************************}
Procedure TVector.SetElement(Index:Integer; Value:T);
begin
 Element_[Index]:=Value;
end;
{******************************************************************************}

{$UNDEF IMPLEMENTATION}
{$ENDIF}

