unit plin;
interface
const piece_lin = 1;
type
  my_arr = array[1..100] of real;

  a_function = object
      f_type,n_pieces:integer;alphas,betas,borders:my_arr;
      constructor fread(var f:text;var ok:boolean);
      function get(x:real; var ok:boolean):real;
      destructor done;

  end;
implementation
  destructor a_function.done;
  begin
  end;
  constructor a_function.fread(var f:text;var ok:boolean);
  var c:char; i:integer;
  begin
    read(f,c);
    if c='p' then
    begin
      read(f,c);
      if c='l' then f_type:=piece_lin;
    end;

    if f_type=piece_lin then
    begin
      readln(f,n_pieces);
      for i:=1 to n_pieces do
      begin
        readln(f,borders[i],alphas[i],betas[i]);
      end;
    end;
  end;

  function a_function.get(x:real; var ok:boolean):real;
  var i:integer;
  begin
    if borders[1]>x then
    begin
      get:=0;
      ok:=false;
      exit;
    end;
(*    if borders[n_pieces+1]<x then
    begin
      plin:=0;
      ok:=false;
      exit;
    end;*)
    ok:=true;
    i:=1;
    while (i<=n_pieces) and (borders[i]<=x) do inc(i);
    get:=alphas[i-1]+betas[i-1]*(x-borders[i-1]);
  end;
end.
