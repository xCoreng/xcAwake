//
// xcAwake by ABrandaoL
// Copyright xCoreng Inc.
// 00.00.01  20251114  1028
//
input
  period(5);
  useMedias(false);  
var
  td,mtd : real;
  color  : integer;
begin
  //
  // Calculation
  //
  if(useMedias)then
  begin
  td := xcFnTrades();
  td := xcMSMA(period, 2, td);
  end else   td := xcFnTrades();
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
