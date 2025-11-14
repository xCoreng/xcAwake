//
// xcAwake by ABrandaoL
// Copyright xCoreng Inc.
// 00.00.00  20251114  1012
//
var
  td,mtd : real;
  color  : integer;
begin
  //
  // Calculation
  //
  td := xcFnTrades();
  mtd := xcMSMA(7,2,td);
  if (mtd > 0) then
    color := clLime
  else 
    color := 255;
  //
  // Set Pot config
  //
  SetPlotType(2,1);
  SetPlotColor(1,clYellow);
  SetPlotColor(2,color);
  //
  // Plotagem
  //
  PlotN(1,0);
  PlotN(2,mtd);
  //
  // Change Paint Color
  //
  if ((color = clLime) and (close < open)) then
    color := clGreen
  else if ((color = 255) and (close > open)) then
    color := clMaroon;
  //
  // Paint
  //
  PaintBar(color);
end;
