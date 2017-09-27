//+-------------------------------------------------------+
//|                        SVS.mq4                        |
//|         Copyright © 2016, Oluwasemire Olaniyi         |  
//|                  and Ibiyemi Adenifemi                |
//+-------------------------------------------------------+

/*
  +-------------------------------------------------------------------+
  | Intended for Options trading.                                     |
  |1. if both indies appear on the same candle                        |
  |2. if platinum appears on the next candle to seohoe indie.         |                                     |
  +-------------------------------------------------------------------+
*/ 
#property copyright "Copyright 2016, Oluwasemire Olaniyi"
#property version   "1.00"
#property strict
#property indicator_chart_window

#property indicator_buffers 2;

#property indicator_color1 Lime //both sfet
#property indicator_color2 Magenta //both sfet
//#property indicator_color3 Turquoise //either sfet
//#property indicator_color4 Pink //either sfet
#property indicator_width1 4
#property indicator_width2 4
//#property indicator_width3 2
//#property indicator_width4 2



///////////////////////////////////////////

extern bool Alertss = true;


//MyHarami
extern double now_prevRatio = 0.5;
extern bool Alerts = false;
extern bool use1st = true;
extern bool use2nd = true;

string sellNow = "sell Now";
string buyNow = "buy Now";
//buffer
double CrossUp[];
double CrossDown[];
//double CrossUpx[];//one sfet
//double CrossDownx[];//one sfet

 double alertTag;


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
   
   //SetIndexStyle(2, DRAW_ARROW, EMPTY);
   //SetIndexArrow(2, 233);
   //SetIndexBuffer(2, CrossUpx);
   
   //SetIndexStyle(3, DRAW_ARROW, EMPTY);
   //SetIndexArrow(3, 234);
   //SetIndexBuffer(3, CrossDownx);
   
   
   
   
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
    double c60mins1_1, c60mins2_1;
    double c30mins_1, c30mins_2, c30mins_3;
    double c15mins_1, c15mins_2, c15mins_3, c15mins_4, c15mins_5;
    double c5mins_1, c5mins_2, c5mins_3, c5mins_4, c5mins_5, c5mins_6, c5mins_7, c5mins_8, c5mins_9, c5mins_10, c5mins_11, c5mins_12, c5mins_13;
    
    if(rates_total <= 2)
      return(0);
      
    limit = rates_total - prev_calculated;
    if(prev_calculated >0)
      limit++;
   
    for(int i=limit-1; i >=0; i--)
    {
      c60mins1_1 = iCustom(Symbol(), 15, "MyHarami", now_prevRatio, Alerts, use1st, use2nd, 0, i+1);
      c60mins2_1 = iCustom(Symbol(), 60, "MyHarami", now_prevRatio, Alerts, use1st, use2nd, 3, i+1);
      
      c30mins_1 = iCustom(Symbol(), 30, "MyHarami", now_prevRatio, Alerts, use1st, use2nd, 5, i+1);
      c30mins_2 = iCustom(Symbol(), 30, "MyHarami", now_prevRatio, Alerts, use1st, use2nd, 5, i+3);
      c30mins_3 = iCustom(Symbol(), 30, "MyHarami", now_prevRatio, Alerts, use1st, use2nd, 5, i+3);
      
      c15mins_1 = iCustom(Symbol(), 15, "MyHarami", now_prevRatio, Alerts, use1st, use2nd, 5, i+1);
      c15mins_2 = iCustom(Symbol(), 15, "MyHarami", now_prevRatio, Alerts, use1st, use2nd, 5, i+2);
      c15mins_3 = iCustom(Symbol(), 15, "MyHarami", now_prevRatio, Alerts, use1st, use2nd, 5, i+3);
      c15mins_4 = iCustom(Symbol(), 15, "MyHarami", now_prevRatio, Alerts, use1st, use2nd, 5, i+4);
      c15mins_5 = iCustom(Symbol(), 15, "MyHarami", now_prevRatio, Alerts, use1st, use2nd, 5, i+5);
      
      c5mins_1 = iCustom(Symbol(), 5, "MyHarami", now_prevRatio, Alerts, use1st, use2nd, 5, i+1);
      c5mins_2 = iCustom(Symbol(), 5, "MyHarami", now_prevRatio, Alerts, use1st, use2nd, 5, i+2);
      c5mins_3 = iCustom(Symbol(), 5, "MyHarami", now_prevRatio, Alerts, use1st, use2nd, 5, i+3);
      c5mins_4 = iCustom(Symbol(), 5, "MyHarami", now_prevRatio, Alerts, use1st, use2nd, 5, i+4);
      c5mins_5 = iCustom(Symbol(), 5, "MyHarami", now_prevRatio, Alerts, use1st, use2nd, 5, i+5);
      c5mins_6 = iCustom(Symbol(), 5, "MyHarami", now_prevRatio, Alerts, use1st, use2nd, 5, i+6);
      c5mins_7 = iCustom(Symbol(), 5, "MyHarami", now_prevRatio, Alerts, use1st, use2nd, 5, i+7);
      c5mins_8 = iCustom(Symbol(), 5, "MyHarami", now_prevRatio, Alerts, use1st, use2nd, 5, i+8);
      c5mins_9 = iCustom(Symbol(), 5, "MyHarami", now_prevRatio, Alerts, use1st, use2nd, 5, i+9);
      c5mins_10 = iCustom(Symbol(), 5, "MyHarami", now_prevRatio, Alerts, use1st, use2nd, 5, i+10);
      c5mins_11 = iCustom(Symbol(), 5, "MyHarami", now_prevRatio, Alerts, use1st, use2nd, 5, i+11);
      c5mins_12 = iCustom(Symbol(), 5, "MyHarami", now_prevRatio, Alerts, use1st, use2nd, 5, i+12);
      c5mins_13 = iCustom(Symbol(), 5, "MyHarami", now_prevRatio, Alerts, use1st, use2nd, 5, i+13);
      
      
      if((c60mins1_1 != EMPTY_VALUE))
         //(c30mins_1 == 1.0 || c30mins_2 == 1.0) && 
         //(c15mins_1 == 1.0 || c15mins_2 == 1.0 || c15mins_3 == 1.0 || c15mins_4 == 1.0 || c15mins_5 == 1.0) &&
         //(c5mins_1 == 1.0 || c5mins_2 == 1.0 || c5mins_3 == 1.0 || c5mins_4 == 1.0 || c5mins_5 == 1.0 || c5mins_6 == 1.0 || 
          //c5mins_7 == 1.0 || c5mins_8 == 1.0 || c5mins_9 == 1.0 || c5mins_10 == 1.0 || c5mins_11 == 1.0 || c5mins_12 == 1.0 || c5mins_13 == 1.0)
        //)
      {
         CrossUp[i] = Low[i];
         Alertss(buyNow);
      }
      
      else if((c60mins1_1 == 2.0)) //&& 
               //(c30mins_1 == 2.0 || c30mins_2 == 2.0) && 
               //(c15mins_1 == 2.0 || c15mins_2 == 2.0 || c15mins_3 == 2.0 || c15mins_4 == 2.0 || c15mins_5 == 2.0) &&
               //(c5mins_1 == 2.0 || c5mins_2 == 2.0 || c5mins_3 == 2.0 || c5mins_4 == 2.0 || c5mins_5 == 2.0 || c5mins_6 == 2.0 || 
               // c5mins_7 == 2.0 || c5mins_8 == 2.0 || c5mins_9 == 2.0 || c5mins_10 == 2.0 || c5mins_11 == 2.0 || c5mins_12 == 2.0 || c5mins_13 == 2.0)
            // )
      {
         CrossDown[i] = High[i];
         Alertss(sellNow);
      }
      
   /*   
      
      if(
         (c60mins_1 == 1.0) && 
         (c30mins_1 == 1.0 || c30mins_2 == 1.0) && 
         (c15mins_1 == 1.0 || c15mins_2 == 1.0 || c15mins_3 == 1.0 || c15mins_4 == 1.0 || c15mins_5 == 1.0) &&
         (c5mins_1 == 1.0 || c5mins_2 == 1.0 || c5mins_3 == 1.0 || c5mins_4 == 1.0 || c5mins_5 == 1.0 || c5mins_6 == 1.0 || 
          c5mins_7 == 1.0 || c5mins_8 == 1.0 || c5mins_9 == 1.0 || c5mins_10 == 1.0 || c5mins_11 == 1.0 || c5mins_12 == 1.0 || c5mins_13 == 1.0)
        )
      {
         CrossUpx[i] = Low[i];
         Alertss(buyNow);
      }
      
      else if(
               (c60mins_1 == 2.0) && 
               (c30mins_1 == 2.0 || c30mins_2 == 2.0) && 
               (c15mins_1 == 2.0 || c15mins_2 == 2.0 || c15mins_3 == 2.0 || c15mins_4 == 2.0 || c15mins_5 == 2.0) &&
               (c5mins_1 == 2.0 || c5mins_2 == 2.0 || c5mins_3 == 2.0 || c5mins_4 == 2.0 || c5mins_5 == 2.0 || c5mins_6 == 2.0 || 
                c5mins_7 == 2.0 || c5mins_8 == 2.0 || c5mins_9 == 2.0 || c5mins_10 == 2.0 || c5mins_11 == 2.0 || c5mins_12 == 2.0 || c5mins_13 == 2.0)
             )
      {
         CrossDownx[i] = High[i];
         Alertss(sellNow);
      }
*/
     
     }
      
////////////////////////////
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
void Alertss(string AlertText)
  {
    static datetime timeprev;
    if(timeprev<iTime(NULL,0,0) && Alertss) {timeprev=iTime(NULL,0,0); Alert(AlertText," ",Symbol()," - ",Period(),"  at  ", Close[0],"  -  ", TimeToStr(CurTime(),TIME_SECONDS));}
  }