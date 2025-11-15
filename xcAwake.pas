//
// xcAwake by ABrandaoL
// Copyright xCoreng Inc.
// 00.00.02  20251115  1835
//
input
  period(5);
  useMedias(false);
var
  value,mtd : real;
  color     : integer;
begin
  //
  // Calculation
  //
  value := xcFnTrades();
  // Use media
  if (useMedias) then
    begin
      value := xcMSMA(period,2,value);
    end;
  mtd := xcMSMA(7,2,value);
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
  // Force of direction
  //
  if ((color = cllime) and (usemedias) and (mtd < mtd[1])) then
    begin
      color := clGreen;
      SetPlotColor(2,color);
    end
  else if ((color = 255) and (usemedias) and (mtd > mtd[1])) then
    begin
      color := clMaroon;
      SetPlotColor(2,color);
    end;
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
