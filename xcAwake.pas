//
// xcAwake by ABrandaoL
// Copyright xCoreng Inc.
// 00.00.02  20251115  1835
//
input
  period(14);
  useMedias(true);
  // types
  // 1 - Trades
  // 2 - Volume
  // 3 - AskAndBid
  // 4 - Quantity
  // 5 - Synthetic
  type(5);
  tradesWeightOnSynthetic(1);
  volumeWeightOnSynthetic(1);
  askAndBidWeightOnSynthetic(2);
 quantityWeightOnSynthetic(1);
var
  value : real;
  color : integer;
begin
  value := 0;
  //
  // Calculation
  //
  if (type = 1) then
    value := xcFnTrades()
  else if (type = 2) then
    value := xcFnVolume()
  else if (type = 3) then
    value := xcFnAskBidBalance()
  else if (type = 4) then
    value := xcFnQuantity()
  else if (type = 5) then
    begin
      //Trades
      if (xcFnTrades > 0) then
        value := value + tradesWeightOnSynthetic
      else if (xcFnTrades < 0) then
        value := value - tradesWeightOnSynthetic;
      //Volume
      if (xcFnVolume > 0) then
        value := value + volumeWeightOnSynthetic
      else if (xcFnVolume < 0) then
        value := value - volumeWeightOnSynthetic;
      //Ask and Bid
      if (xcFnAskBidBalance > 0) then
        value := value + askAndBidWeightOnSynthetic
      else if (xcFnAskBidBalance < 0) then
        value := value - askAndBidWeightOnSynthetic;
      //Quatity
      if (xcFnQuantity > 0) then
        value := value + quantityWeightOnSynthetic
      else if (xcFnQuantity < 0) then
        value := value - quantityWeightOnSynthetic;
    end
  else 
    value := xcFnTrades();
  // Use media
  if (useMedias) then
    begin
      value := xcMSMA(period,2,value);
    end;
  if (value > 0) then
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
  PlotN(2,value);
  //
  // Force of direction
  //
  if ((color = cllime) and (usemedias) and (value < value[1])) then
    begin
      color := clGreen;
      SetPlotColor(2,color);
    end
  else if ((color = 255) and (usemedias) and (value > value[1])) then
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
