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

#property indicator_buffers 2;

#property indicator_color1 Lime //both sfet
#property indicator_color2 Magenta //both sfet


#property indicator_width1 4
#property indicator_width2 4


extern bool Alerts = true;

double CrossUp[];
double CrossDown[];



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
   SetIndexArrow(0, 208);
   SetIndexBuffer(0, CrossUp);
   
   SetIndexStyle(1, DRAW_ARROW, EMPTY);
   SetIndexArrow(1,212);
   SetIndexBuffer(1, CrossDown);


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
    
   
    double low_1, high_1, open_1, close_1;
    double low_2, high_2, open_2, close_2;
    
    if(rates_total <= 5)
      return(0);
      
    limit = rates_total - prev_calculated;
    if(prev_calculated >0)
      limit++;
   
    for(int i=limit-1; i >=0; i--)
    {
   
      low_1 = iLow(Symbol(), 0, i+1);
      high_1 = iHigh(Symbol(), 0, i+1);
      low_2 = iLow(Symbol(), 0, i+2);
      high_2 = iHigh(Symbol(), 0, i+2);
   
      
      open_1 = iOpen(Symbol(), 0, i+1);
      close_1 = iClose(Symbol(), 0, i+1);
      open_2 = iOpen(Symbol(), 0, i+2);
      close_2 = iClose(Symbol(), 0, i+2);
  
      
    
      
      if(low_2 > open_1 && high_2 < close_1)
      {
         CrossUp[i+1] = Low[i+1];
         Alerts(buyNow);     
                     
      }
      else if(low_2 > close_1 && high_2 < open_1)
      {
         CrossDown[i+1] = High[i+1];
        
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
