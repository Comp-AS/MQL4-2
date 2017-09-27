//+-------------------------------------------------------+
//|                        SVS.mq4                        |
//|         Copyright © 2016, Oluwasemire Olaniyi         |  
//|                  and Ibiyemi Adenifemi                |
//+-------------------------------------------------------+

/*
  +-------------------------------------------------------+
  | Intended for Options trading.                         |
  | Rules:                                                |
  | For a call option (Buy)                               |
  |   1. the two sfet Podvale indie bars change to green  |
  |   2. Vcustom indicator is oversold from -7 below      |
  |    (i dont mind a separate colour arrow for when just | 
  |    one of the podvale changes colour with other rules)|
  |   3. Stocastic is over sold                           |
  | For a put otpion (Sell)                               |
  |   1. the two Podvale changes to red (a different      |      
  |       arrow for when just one colour changes)         |
  |   2. Vcustom indicator is oversold from +7 above      |
  |   3. stocahstic is overbought                         |
  |Indicators:                                            |
  |1. SVET_V_PODAVALE                                     |
  |2. VCustom3                                            |
  |3. Stochastic                                          |
  +-------------------------------------------------------+
*/ 
#property copyright "Copyright 2016, Oluwasemire Olaniyi and Ibiyemi Adenifemi"
#property version   "1.00"
#property strict
#property indicator_chart_window

#property indicator_buffers 4;

#property indicator_color1 Lime //both sfet
#property indicator_color2 Magenta //both sfet
#property indicator_color3 Turquoise //either sfet
#property indicator_color4 Pink //either sfet
#property indicator_width1 4
#property indicator_width2 4
#property indicator_width3 2
#property indicator_width4 2



///////////////////////////////////////////
//SVS
extern double now2nd_prevRatio = 0.5;
extern bool Alerts = true;
extern bool use1st = true;
extern bool use2nd = true;


//BollingerBand
//if(iBands(NULL,0,20,2,0,PRICE_LOW,MODE_LOWER,0)>Low[0]) return(0);
extern double BollingRatio = 0.75;
extern int BBPeriod = 20;
extern double BBDeviation = 2.0;
extern int BBShift = 0; // 
extern int BBPrice = 0; //0=CLOSE,1=OPEN,2=HI,3=LO,4=MEDIAN,5=TYPICAL,6=WEIGHTED



double CrossUp[];
double CrossDown[];
double CrossUpx[];//one sfet
double CrossDownx[];//one sfet

string buyNow = "buy now";
string sellNow = "sell now";


////////////////////////////////////////////////////////////




//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexStyle(0, DRAW_ARROW, EMPTY);
   SetIndexArrow(0, 233);
   SetIndexBuffer(0, CrossUp);
   
   SetIndexStyle(1, DRAW_ARROW, EMPTY);
   SetIndexArrow(1, 234);
   SetIndexBuffer(1, CrossDown);
   
   SetIndexStyle(2, DRAW_ARROW, EMPTY);
   SetIndexArrow(2, 233);
   SetIndexBuffer(2, CrossUpx);
   
   SetIndexStyle(3, DRAW_ARROW, EMPTY);
   SetIndexArrow(3, 234);
   SetIndexBuffer(3, CrossDownx);
   
   
   
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---
/////////////////////////

    int limit;
    
    double bband_upper, bband_lower;
    double currentLow, currentHigh, currentOpen, currentClose;
    double prevLow, prevHigh, prevOpen, prevClose;
    
    if(rates_total <= BBPeriod)
      return(0);
      
    limit = rates_total - prev_calculated;
    if(prev_calculated >0)
      limit++;
   
    for(int i=limit-1; i >=0; i--)
    {
      
      bband_upper = iBands(NULL, 0, BBPeriod, BBDeviation, BBShift, BBPrice, MODE_UPPER, i+1);
      bband_lower = iBands(NULL, 0, BBPeriod, BBDeviation, BBShift, BBPrice, MODE_LOWER, i+1);
      
      //double nnbid    = MarketInfo(Symbol(), MODE_BID); we can use bid too, but d arrow may not remain on chart.
      currentLow = iLow(Symbol(), 0, i+1);
      currentHigh = iHigh(Symbol(), 0, i+1);
      prevLow = iLow(Symbol(), 0, i+2);
      prevHigh = iHigh(Symbol(), 0, i+2);
      //p_prevLow = iLow(Symbol(), 0, i+2);
      //p_prevHigh = iHigh(Symbol(), 0, i+2);
      
      currentOpen = iOpen(Symbol(), 0, i+1);
      currentClose = iClose(Symbol(), 0, i+1);
      prevOpen = iOpen(Symbol(), 0, i+2);
      prevClose = iClose(Symbol(), 0, i+2);
      
    
      
      if((bband_lower > currentHigh) && (use1st) && (prevOpen > prevClose) && (currentOpen < currentClose) && (currentOpen > prevClose) && (currentClose < prevOpen))
      {
         CrossUp[i+1] = Low[i+1];
         Alerts(buyNow);     
                     
      }
      else if((currentLow > bband_upper) && (use1st) && (prevOpen < prevClose) && (currentOpen > currentClose) && (currentOpen < prevClose) && (currentClose > prevOpen))
      {
         CrossDown[i+1] = High[i+1];
         Alerts(sellNow);  
      }
         
      if(((bband_lower > currentLow) && (bband_lower < currentHigh)) && (((bband_lower - currentLow)/(currentHigh - currentLow)) > BollingRatio) &&
         (use2nd) && (prevOpen > prevClose) && (currentOpen < currentClose) && (currentOpen > prevClose) && (currentClose < prevOpen) && (((currentClose - currentOpen)/(prevOpen - prevClose)) <= now2nd_prevRatio))
      {
         CrossUpx[i+1] = Low[i+1];
         Alerts(buyNow);
      }
      else if(((bband_upper > currentLow) && (bband_upper < currentHigh)) && (((currentHigh - bband_upper)/(currentHigh - currentLow)) > BollingRatio) &&
         (use2nd) && (prevOpen < prevClose) && (currentOpen > currentClose) && (currentOpen < prevClose) && (currentClose > prevOpen) && (((currentOpen - currentClose)/(prevClose - prevOpen)) <= now2nd_prevRatio))
      {
         CrossDownx[i+1] = High[i+1];
         Alerts(sellNow);
      }
     
    }
      
      
      
   
   
   
   
   
   
////////////////////////////
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+

void Alerts(string AlertText)
  {
    static datetime timeprev;
    if(timeprev<iTime(NULL,0,0) && Alerts) {timeprev=iTime(NULL,0,0); Alert(AlertText," ",Symbol()," - ",Period(),"  at  ", Close[0],"  -  ", TimeToStr(CurTime(),TIME_SECONDS));}
  }
