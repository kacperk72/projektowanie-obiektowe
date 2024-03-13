program TestRandomAndSort;
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
procedure TestGenerateRandomNumbersRange;
var
  i: Integer;
  from, upto, count: Integer;
  inRange: Boolean;
begin
  from := 10;
  upto := 20;
  count := 100;
  GenerateRandomNumbers(from, upto, count);
  inRange := True;
  for i := 0 to count - 1 do
    if (numbers[i] < from) or (numbers[i] > upto) then
    begin
      inRange := False;
      Break;
    end;
  if inRange then
    WriteLn('TestGenerateRandomNumbersRange: PASS')
  else
    WriteLn('TestGenerateRandomNumbersRange: FAIL');
end;

procedure TestBubbleSortAscendingOrder;
var
  i, count: Integer;
  isSorted: Boolean;
begin
  count := 100;
  GenerateRandomNumbers(1, 100, count);
  BubbleSort(numbers, count);
  isSorted := True;
  for i := 0 to count - 2 do
    if numbers[i] > numbers[i + 1] then
    begin
      isSorted := False;
      Break;
    end;
  if isSorted then
    WriteLn('TestBubbleSortAscendingOrder: PASS')
  else
    WriteLn('TestBubbleSortAscendingOrder: FAIL');
end;

procedure TestEmptyArray;
begin
  SetLength(numbers, 0);
  BubbleSort(numbers, 0);
  WriteLn('TestEmptyArray: PASS');
end;

procedure TestSingleElementArray;
begin
  SetLength(numbers, 1);
  numbers[0] := 1;
  BubbleSort(numbers, 1);
  if (Length(numbers) = 1) and (numbers[0] = 1) then
    WriteLn('TestSingleElementArray: PASS')
  else
    WriteLn('TestSingleElementArray: FAIL');
end;

procedure TestRepeatedElements;
begin
  SetLength(numbers, 3);
  numbers[0] := 2; numbers[1] := 2; numbers[2] := 2;
  BubbleSort(numbers, 3);
  if (numbers[0] = 2) and (numbers[1] = 2) and (numbers[2] = 2) then
    WriteLn('TestRepeatedElements: PASS')
  else
    WriteLn('TestRepeatedElements: FAIL');
end;

begin
  TestGenerateRandomNumbersRange;
  TestBubbleSortAscendingOrder;
  TestEmptyArray;
  TestSingleElementArray;
  TestRepeatedElements;
  ReadKey;
end.