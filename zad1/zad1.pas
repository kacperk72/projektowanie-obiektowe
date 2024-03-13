program GenerateAndSortRandomNumbers;
uses crt, SysUtils;

var
  numbers: array of Integer;

procedure GenerateRandomNumbers(from, upto, count: Integer);
var
  i: Integer;
begin
  SetLength(numbers, count);
  Randomize;
  for i := 0 to count - 1 do
    numbers[i] := Random(upto - from + 1) + from;
end;

procedure BubbleSort(var arr: array of Integer; size: Integer);
var
  i, j, temp: Integer;
begin
  for i := size - 1 downto 1 do
    for j := 0 to i - 1 do
      if arr[j] > arr[j + 1] then
      begin
        temp := arr[j];
        arr[j] := arr[j + 1];
        arr[j + 1] := temp;
      end;
end;

procedure PrintNumbers(count: Integer);
var
  i: Integer;
begin
  for i := 0 to count - 1 do
    WriteLn(numbers[i]);
end;

var
  from, upto, count: Integer;

begin
  if ParamCount < 3 then
  begin
    WriteLn('Usage: program_name <from> <upto> <count>');
    Halt;
  end;

  from := StrToInt(ParamStr(1));
  upto := StrToInt(ParamStr(2));
  count := StrToInt(ParamStr(3));

  GenerateRandomNumbers(from, upto, count);
  WriteLn('Numbers before sorting:');
  PrintNumbers(count);

  BubbleSort(numbers, count);
  WriteLn('Numbers after sorting:');
  PrintNumbers(count);

  ReadKey;
end.
