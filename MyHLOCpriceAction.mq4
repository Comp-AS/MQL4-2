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
/*
Pin bar anatomy:
1. It must be present
at a swing high or swing low points only because it is a reversal bar.

2. It must have a real body that is not more than 
25% of its full range that includes the shadow.

3. It must have its real body within the prior bar.

4. The nose or the long shadow must have a decent length; 
the longer it is the more powerful.
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

#property indicator_width1 5
#property indicator_width2 5
#property indicator_width3 3
#property indicator_width4 3




///////////////////////////////////////////
//SVS
//1 -> normal harami
//2 -> half harami
//3 -> third candle with half harami

extern bool Alerts = true;


double CrossUp[];
double CrossDown[];
double CrossUpx[];
double CrossDownx[];


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
   SetIndexArrow(0, 117);
   SetIndexBuffer(0, CrossUp);
   
   SetIndexStyle(1, DRAW_ARROW, EMPTY);
   SetIndexArrow(1, 117);
   SetIndexBuffer(1, CrossDown);
   
   SetIndexStyle(2, DRAW_ARROW, EMPTY);
   SetIndexArrow(2, 105);
   SetIndexBuffer(2, CrossUpx);
   
   SetIndexStyle(3, DRAW_ARROW, EMPTY);
   SetIndexArrow(3, 105);
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
    
   
    double O_1, C_1;
    double O_2, C_2;
    //double O_3, C_3;
    //double O_4, C_4;
    double H_1, H_2, L_1, L_2;
    
    
    
    if(rates_total <= 5)
      return(0);
      
    limit = rates_total - prev_calculated;
    if(prev_calculated >0)
      limit++;
   
    for(int i=limit-1; i >=0; i--)
    {
      
      O_1 = iOpen(Symbol(), 0, i+1);
      H_1 = iHigh(Symbol(), 0, i+1);
      L_1 = iLow(Symbol(), 0, i+1);
      C_1 = iClose(Symbol(), 0, i+1);
      
      O_2 = iOpen(Symbol(), 0, i+2);
      H_2 = iHigh(Symbol(), 0, i+2);
      L_2 = iLow(Symbol(), 0, i+2);
      C_2 = iClose(Symbol(), 0, i+2);
      
      //O_3 = iOpen(Symbol(), 0, i+3);
      //C_3 = iClose(Symbol(), 0, i+3);
      
      //O_4 = iOpen(Symbol(), 0, i+4);
      //C_4 = iClose(Symbol(), 0, i+4);
      
      //R_1 = H_1 - L_1;
      
   
      
      if((C_2 < O_2) && (C_1 > O_1) && (O_1 > C_2) && (C_1 < O_2) && (H_1 > H_2) && (L_1 < L_2))
         
      {
         CrossUp[i+1] = Low[i+1];
         Alerts(buyNow);
      }
      else if((C_2 > O_2) && (C_1 < O_1) && (O_1 < C_2) && (C_1 > O_2) && (H_1 > H_2) && (L_1 < L_2))
      {
         CrossDown[i+1] = High[i+1];
         Alerts(sellNow);
      }
         
      if((C_2 < O_2) && (C_1 > O_1) && (L_1 < L_2) && (((H_1 - C_1) / (O_1 - L_1)) < 0.1) && (((O_1 - L_1) / (C_1 - O_1)) > 2.0))
         
      {
         CrossUpx[i+1] = Low[i+1];
         Alerts(buyNow);
      }
      else if((C_2 > O_2) && (C_1 < O_1) && (H_1 > H_2) && (((C_1 - L_1) / (H_1 - O_1)) < 0.1) && (((H_1 - O_1) / (O_1 - C_1)) > 2.0))
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
