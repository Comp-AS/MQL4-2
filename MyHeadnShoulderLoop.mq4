//+-------------------------------------------------------+
//|                   HeadnShoulder                       |
//|         Copyright © 2016, Oluwasemire Olaniyi         |  
//|                                                       |
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
#property indicator_color3 Lime //both sfet
#property indicator_color4 Magenta //both sfet


#property indicator_width1 4
#property indicator_width2 4
#property indicator_width3 2
#property indicator_width4 2


extern bool Alerts = true;

extern int CalculateOnBarClose    = 12;//Depth
extern int  ZZDepth                = 5;//Deviation
extern int  ZZDev                  = 3;//BackStep

double CrossUp[];
double CrossDown[];
double CrossUpx[];
double CrossDownx[];



string buyNow = "HnS buy now";
string sellNow = "HnS sell now";


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
   
   SetIndexStyle(0, DRAW_ARROW, EMPTY);
   SetIndexArrow(0, 208);
   SetIndexBuffer(0, CrossUpx);
   
   SetIndexStyle(1, DRAW_ARROW, EMPTY);
   SetIndexArrow(1,212);
   SetIndexBuffer(1, CrossDownx);


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
    
    /*
    double z1, z2, z3, z4, z5, z6, z7, z8, z9, z10, z11, z12, z13, z14, z15, z16, z17, z18, z19, z20, z21, z22, z23, z24, z25, z26, z27, z28, z29, z30;
    double z31, z32, z33, z34, z35, z36, z37, z38, z39, z40, z41, z42, z43, z44, z45, z46, z47, z48, z49, z50;
    double z51, z52, z53, z54, z55, z56, z57, z58, z59, z60, z61, z62, z63, z64, z65, z66, z67, z68, z69, z70;
    double z71, z72, z73, z74, z75, z76, z77, z78, z79, z80, z81, z82, z83, z84, z85, z86, z87, z88, z89, z90;
    double z91, z92, z93, z94, z95, z96, z97, z98, z99, z100, z101, z102, z103, z104, z105, z106, z107, z108, z109, z110; 
    double z111, z112, z113, z114, z115, z116, z117, z118, z119, z120, z121, z122, z123, z124, z125, z126, z127, z128, z129, z130; 
    double z131, z132, z133, z134, z135, z136, z137, z138, z139, z140, z141, z142, z143, z144, z145, z146, z147, z148, z149, z150; 
    double z151, z152, z153, z154, z155, z156, z157, z158, z159, z160, z161, z162, z163, z164, z165, z166, z167, z168, z169, z170; 
    double z171, z172, z173, z174, z175, z176, z177, z178, z179, z180, z181, z182, z183, z184, z185, z186, z187, z188, z189, z190; 
    double z191, z192, z193, z194, z195, z196, z197, z198, z199, z200, z201, z202, z203, z204, z205, z206, z207, z208, z209, z210; 
    double z211, z212, z213, z214, z215, z216, z217, z218, z219, z220, z221, z222, z223, z224, z225, z226, z227, z228, z229, z230;
    double z231, z232, z233, z234, z235, z236, z237, z238, z239, z240;
    */
    //double z[240];
    double zArray[240];
    /*
    for(int jxx = 1; jxx <= 240; jxx++)
    {
      zArray[jxx] = jxx*0.0;
    }
    */
    
    /*
    double zArray[240];
    
    zArray[240] = {z1, z2, z3, z4, z5, z6, z7, z8, z9, z10, z11, z12, z13, z14, z15, z16, z17, z18, z19, z20, 
      z21, z22, z23, z24, z25, z26, z27, z28, z29, z30, z31, z32, z33, z34, z35, z36, z37, z38, z39, z40, 
      z41, z42, z43, z44, z45, z46, z47, z48, z49, z50, z51, z52, z53, z54, z55, z56, z57, z58, z59, z60, 
      z61, z62, z63, z64, z65, z66, z67, z68, z69, z70, z71, z72, z73, z74, z75, z76, z77, z78, z79, z80, 
      z81, z82, z83, z84, z85, z86, z87, z88, z89, z90, z91, z92, z93, z94, z95, z96, z97, z98, z99, z100,
      z101, z102, z103, z104, z105, z106, z107, z108, z109, z110, 
      z111, z112, z113, z114, z115, z116, z117, z118, z119, z120, z121, z122, z123, z124, z125, z126, z127, z128, z129, z130, 
      z131, z132, z133, z134, z135, z136, z137, z138, z139, z140, z141, z142, z143, z144, z145, z146, z147, z148, z149, z150, 
      z151, z152, z153, z154, z155, z156, z157, z158, z159, z160, z161, z162, z163, z164, z165, z166, z167, z168, z169, z170, 
      z171, z172, z173, z174, z175, z176, z177, z178, z179, z180, z181, z182, z183, z184, z185, z186, z187, z188, z189, z190, 
      z191, z192, z193, z194, z195, z196, z197, z198, z199, z200, z201, z202, z203, z204, z205, z206, z207, z208, z209, z210, 
      z211, z212, z213, z214, z215, z216, z217, z218, z219, z220, z221, z222, z223, z224, z225, z226, z227, z228, z229, z230, 
      z231, z233, z234, z235, z236, z237, z238, z239, z240};
      */
      
    int zMaxIndex, maxLeftIndex, maxRightIndex, maxTroughLeftIndex, maxTroughRightIndex;
    int zMinIndex, minLeftIndex, minRightIndex, minTroughLeftIndex, minTroughRightIndex;
    double zMaxValue, maxLeftValue, maxRightValue, maxTroughLeftValue, maxTroughRightValue;
    double zMinValue, minLeftValue, minRightValue, minTroughLeftValue, minTroughRightValue;
   
    double C_1, C_2;
    
    if(rates_total <= 3)
      return(0);
      
    limit = rates_total - prev_calculated;
    if(prev_calculated >0)
      limit++;
   
    for(int i=limit-1; i >=0; i--)
    {
    
      C_1 = iClose(Symbol(), 0, i+1);
      C_2 = iClose(Symbol(), 0, i+2);
      
      if(C_1 > C_2)//((maxTroughLeftValue < maxTroughRightValue) && (C_1 < maxTroughRightValue))
         
      {
         CrossDown[i+1] = High[i+1];
         Alerts(sellNow);
      
      }
      
      for(int jyy = 0; jyy < 240; jyy++)
      {
         zArray[jyy] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+jyy);
      }
      

     
      zMaxIndex = ArrayMaximum(zArray, WHOLE_ARRAY, 0);
      maxLeftIndex = ArrayMaximum(zArray, (240 - zMaxIndex), (zMaxIndex + 1));
      maxRightIndex = ArrayMaximum(zArray, (zMaxIndex - 1), 0);
      maxTroughLeftIndex = ArrayMinimum(zArray, (maxLeftIndex - zMaxIndex), zMaxIndex+1);
      maxTroughRightIndex = ArrayMinimum(zArray, (zMaxIndex - maxRightIndex), maxRightIndex+1);
    
      zMinIndex = ArrayMinimum(zArray, WHOLE_ARRAY, 0);
      minLeftIndex = ArrayMinimum(zArray, (100 - zMinIndex), (zMinIndex + 1));
      minRightIndex = ArrayMinimum(zArray, (zMinIndex - 1), 0);
      minTroughLeftIndex = ArrayMaximum(zArray, (minLeftIndex - zMinIndex), zMinIndex+1);
      minTroughRightIndex = ArrayMaximum(zArray, (zMinIndex - minRightIndex), minRightIndex+1);
      
     
      
      zMaxValue = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+zMaxIndex);
      maxLeftValue = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+maxLeftIndex);
      maxRightValue = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+maxRightIndex);
      maxTroughLeftValue = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+maxTroughLeftIndex);
      maxTroughRightValue = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+maxTroughRightIndex);
      
      zMinValue = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+zMinIndex);
      minLeftValue = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+minLeftIndex);
      minRightValue = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+minRightIndex);
      minTroughLeftValue = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+minTroughLeftIndex);
      minTroughRightValue = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+minTroughRightIndex);
      
      
      
    
      
      
      if((zMaxValue != 0.0 && maxLeftValue != 0.0 && maxRightValue != 0.0 && maxTroughLeftIndex != 0.0 && maxTroughRightIndex != 0.0) &&
         (maxTroughLeftValue > maxTroughRightValue) && (C_1 < maxTroughRightValue)
         )
      {
         CrossDownx[i+1] = High[i+1];
         Alerts(sellNow);
      
      }
      
      if((zMinValue != 0.0 && minLeftValue != 0.0 && minRightValue != 0.0 && minTroughLeftIndex != 0.0 && minTroughRightIndex != 0.0) &&
         (minTroughLeftValue > minTroughRightValue) && (C_1 > minTroughRightValue))
         
      {
         CrossUp[i+1] = Low[i+1];
         Alerts(buyNow);     
                     
      }
      else if((zMinValue != 0.0 && minLeftValue != 0.0 && minRightValue != 0.0 && minTroughLeftIndex != 0.0 && minTroughRightIndex != 0.0) &&
         (minTroughLeftValue < minTroughRightValue) && (C_1 > minTroughRightValue))
      {
         CrossUpx[i+1] = Low[i+1];
        
         Alerts(buyNow);  
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


/*  
      z1 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+1);
      z2 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+2);
      z3 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+3);
      z4 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+4);
      z5 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+5);
      z6 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+6);
      z7 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+7);
      z8 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+8);
      z9 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+9);
      z10 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+10);
      z11 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+11);
      z12 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+12);
      z13 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+13);
      z14 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+14);
      z15 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+15);
      z16 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+16);
      z17 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+17);
      z18 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+18);
      z19 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+19);
      z20 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+20);
      z21 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+21);
      z22 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+22);
      z23 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+23);
      z24 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+24);
      z25 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+25);
      z26 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+26);
      z27 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+27);
      z28 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+28);
      z29 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+29);
      z30 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+30);
      z31 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+31);
      z32 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+32);
      z33 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+33);
      z34 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+34);
      z35 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+35);
      z36 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+36);
      z37 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+37);
      z38 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+38);
      z39 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+39);
      z40 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+40);
      z41 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+41);
      z42 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+42);
      z43 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+43);
      z44 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+44);
      z45 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+45);
      z46 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+46);
      z47 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+47);
      z48 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+48);
      z49 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+49);
      z50 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+50);
      z51 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+51);
      z52 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+52);
      z53 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+53);
      z54 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+54);
      z55 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+55);
      z56 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+56);
      z57 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+57);
      z58 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+58);
      z59 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+59);
      z60 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+60);
      z61 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+61);
      z62 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+62);
      z63 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+63);
      z64 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+64);
      z65 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+65);
      z66 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+66);
      z67 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+67);
      z68 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+68);
      z69 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+69);
      z70 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+70);
      z71 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+71);
      z72 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+72);
      z73 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+73);
      z74 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+74);
      z75 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+75);
      z76 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+76);
      z77 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+77);
      z78 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+78);
      z79 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+79);
      z80 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+80);
      z81 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+81);
      z82 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+82);
      z83 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+83);
      z84 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+84);
      z85 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+85);
      z86 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+86);
      z87 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+87);
      z88 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+88);
      z89 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+89);
      z90 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+90);
      z91 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+91);
      z92 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+92);
      z93 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+93);
      z94 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+94);
      z95 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+95);
      z96 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+96);
      z97 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+97);
      z98 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+98);
      z99 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+99);
      z100 = iCustom(Symbol(), 0, "FractalZigZagNoRepaint", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+100);
      
      
      z130 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+130); 
      z131 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+131);
      z132 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+132);
      z133 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+133);
      z134 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+134);
      z135 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+135);
      z136 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+136);
      z137 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+100);
      z138 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+101);
      z139 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+102);
      z140 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+103);
      z141 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+104);
      z142 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+105);
      z143 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+106);  
      z144 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+107);
      z145 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+108);
      z146 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+109);
      z147 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+110);
      z148 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+111);
      z149 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+112); 
      z150 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+113);
      z151 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+114);
      z152 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+115);
      z153 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+116);
      z154 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+117);
      z155 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+118); 
      z156 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+119);
      z157 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+120);
      z158 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+121);
      z159 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+122);
      z160 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+123);
      z161 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+124); 
      z162 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+125);
      z163 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+126);
      z164 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+127);
      z165 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+128);
      z166 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+129);
      z167 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+130); 
      z168 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+131);
      z169 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+132);
      z170 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+133);
      z171 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+134);
      z172 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+135);
      z173 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+136);
      z174 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+100);
      z175 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+101);
      z176 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+102);
      z177 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+103);
      z178 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+104);
      z179 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+105);
      z180 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+106);  
      z181 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+107);
      z182 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+108);
      z183 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+109);
      z184 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+110);
      z185 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+111);
      z186 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+112); 
      z187 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+113);
      z188 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+114);
      z189 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+115);
      z190 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+116);
      z191 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+117);
      z192 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+118); 
      z193 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+119);
      z194 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+120);
      z195 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+121);
      z196 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+122);
      z197 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+123);
      z198 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+124); 
      z199 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+125);
      z200 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+126);
      z201 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+127);
      z202 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+128);
      z203 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+129);
      z204 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+130); 
      z205 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+131);
      z206 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+132);
      z207 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+133);
      z208 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+134);
      z209 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+135);
      z210 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+136);
*/      


/*
      z[1] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+1);
      z[2] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+2);
      z[3] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+3);
      z[4] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+4);
      z[5] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+5);
      z[6] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+6);
      z[7] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+7);
      z[8] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+8);
      z[9] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+9);
      z[10] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+10);
      z[11] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+11);
      z[12] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+12);
      z[13] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+13);
      z[14] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+14);
      z[15] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+15);
      z[16] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+16);
      z[17] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+17);
      z[18] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+18);
      z[19] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+19);
      z[20] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+20);
      z[21] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+21);
      z[22] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+22);
      z[23] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+23);
      z[24] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+24);
      z[25] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+25);
      z[26] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+26);
      z[27] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+27);
      z[28] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+28);
      z[29] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+29);
      z[30] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+30);
      z[31] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+31);
      z[32] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+32);
      z[33] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+33);
      z[34] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+34);
      z[35] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+35);
      z[36] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+36);
      z[37] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+37);
      z[38] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+38);
      z[39] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+39);
      z[40] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+40);
      z[41] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+41);
      z[42] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+42);
      z[43] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+43);
      z[44] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+44);
      z[45] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+45);
      z[46] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+46);
      z[47] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+47);
      z[48] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+48);
      z[49] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+49);
      z[50] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+50);
      z[51] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+51);
      z[52] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+52);
      z[53] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+53);
      z[54] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+54);
      z[55] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+55);
      z[56] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+56);
      z[57] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+57);
      z[58] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+58);
      z[59] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+59);
      z[60] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+60);
      z[61] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+61);
      z[62] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+62);
      z[63] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+63);
      z[64] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+64);
      z[65] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+65);
      z[66] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+66);
      z[67] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+67);
      z[68] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+68);
      z[69] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+69);
      z[70] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+70);
      z[71] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+71);
      z[72] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+72);
      z[73] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+73);
      z[74] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+74);
      z[75] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+75);
      z[76] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+76);
      z[77] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+77);
      z[78] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+78);
      z[79] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+79);
      z[80] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+80);
      z[81] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+81);
      z[82] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+82);
      z[83] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+83);
      z[84] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+84);
      z[85] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+85);
      z[86] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+86);
      z[87] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+87);
      z[88] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+88);
      z[89] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+89);
      z[90] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+90);
      z[91] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+91);
      z[92] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+92);
      z[93] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+93);
      z[94] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+94);
      z[95] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+95);
      z[96] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+96);
      z[97] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+97);
      z[98] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+98);
      z[99] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+99);
      z[100] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+100);
      z[101] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+101);
      z[102] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+102);
      z[103] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+103);
      z[104] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+104);
      z[105] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+105);
      z[106] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+106);  
      z[107] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+107);
      z[108] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+108);
      z[109] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+109);
      z[110] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+110);
      z[111] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+111);
      z[112] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+112); 
      z[113] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+113);
      z[114] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+114);
      z[115] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+115);
      z[116] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+116);
      z[117] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+117);
      z[118] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+118); 
      z[119] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+119);
      z[120] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+120);
      z[121] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+121);
      z[122] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+122);
      z[123] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+123);
      z[124] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+124); 
      z[125] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+125);
      z[126] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+126);
      z[127] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+127);
      z[128] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+128);
      z[129] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+129);
      z[130] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+130); 
      z[131] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+131);
      z[132] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+132);
      z[133] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+133);
      z[134] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+134);
      z[135] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+135);
      z[136] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+136);
      z[137] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+137);
      z[138] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+138);
      z[139] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+139);
      z[140] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+140);
      z[141] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+141);
      z[142] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+142);
      z[143] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+143);  
      z[144] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+144);
      z[145] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+145);
      z[146] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+146);
      z[147] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+147);
      z[148] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+148);
      z[149] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+149); 
      z[150] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+150);
      z[151] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+151);
      z[152] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+152);
      z[153] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+153);
      z[154] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+154);
      z[155] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+155); 
      z[156] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+156);
      z[157] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+157);
      z[158] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+158);
      z[159] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+159);
      z[160] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+160);
      z[161] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+161); 
      z[162] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+162);
      z[163] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+163);
      z[164] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+164);
      z[165] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+165);
      z[166] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+166);
      z[167] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+167); 
      z[168] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+168);
      z[169] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+169);
      z[170] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+170);
      z[171] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+171);
      z[172] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+172);
      z[173] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+173);
      z[174] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+174);
      z[175] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+175);
      z[176] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+176);
      z[177] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+177);
      z[178] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+178);
      z[179] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+179);
      z[180] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+180);  
      z[181] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+181);
      z[182] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+182);
      z[183] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+183);
      z[184] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+184);
      z[185] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+185);
      z[186] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+186); 
      z[187] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+187);
      z[188] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+188);
      z[189] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+189);
      z[190] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+190);
      z[191] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+191);
      z[192] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+192); 
      z[193] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+193);
      z[194] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+194);
      z[195] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+195);
      z[196] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+196);
      z[197] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+197);
      z[198] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+198); 
      z[199] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+199);
      z[200] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+200);
      z[201] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+201);
      z[202] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+202);
      z[203] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+203);
      z[204] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+204); 
      z[205] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+205);
      z[206] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+206);
      z[207] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+207);
      z[208] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+208);
      z[209] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+209);
      z[210] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+210);
      z[211] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+211);
      z[212] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+212);
      z[213] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+213);
      z[214] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+214);
      z[215] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+215);
      z[216] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+216);
      z[217] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+217);  
      z[218] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+218);
      z[219] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+219);
      z[220] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+220);
      z[221] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+221);
      z[222] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+222);
      z[223] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+223); 
      z[224] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+224);
      z[225] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+225);
      z[226] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+226);
      z[227] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+227);
      z[228] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+228);
      z[229] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+229); 
      z[230] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+230);
      z[231] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+231);
      z[232] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+232);
      z[233] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+233);
      z[234] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+234);
      z[235] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+235); 
      z[236] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+236);
      z[237] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+237);
      z[238] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+238);
      z[239] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+239);
      z[240] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+240);
      */
      
      
      
      
      /*
      z[1] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+1);
      z[2] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+2);
      z[3] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+3);
      z[4] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+4);
      z[5] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+5);
      z[6] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+6);
      z[7] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+7);
      z[8] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+8);
      z[9] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+9);
      z[10] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+10);
      z[11] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+11);
      z12] = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+12);
      z13 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+13);
      z14 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+14);
      z15 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+15);
      z16 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+16);
      z17 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+17);
      z18 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+18);
      z19 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+19);
      z20 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+20);
      z21 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+21);
      z22 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+22);
      z23 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+23);
      z24 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+24);
      z25 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+25);
      z26 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+26);
      z27 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+27);
      z28 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+28);
      z29 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+29);
      z30 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+30);
      z31 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+31);
      z32 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+32);
      z33 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+33);
      z34 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+34);
      z35 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+35);
      z36 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+36);
      z37 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+37);
      z38 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+38);
      z39 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+39);
      z40 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+40);
      z41 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+41);
      z42 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+42);
      z43 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+43);
      z44 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+44);
      z45 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+45);
      z46 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+46);
      z47 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+47);
      z48 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+48);
      z49 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+49);
      z50 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+50);
      z51 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+51);
      z52 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+52);
      z53 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+53);
      z54 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+54);
      z55 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+55);
      z56 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+56);
      z57 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+57);
      z58 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+58);
      z59 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+59);
      z60 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+60);
      z61 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+61);
      z62 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+62);
      z63 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+63);
      z64 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+64);
      z65 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+65);
      z66 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+66);
      z67 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+67);
      z68 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+68);
      z69 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+69);
      z70 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+70);
      z71 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+71);
      z72 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+72);
      z73 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+73);
      z74 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+74);
      z75 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+75);
      z76 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+76);
      z77 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+77);
      z78 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+78);
      z79 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+79);
      z80 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+80);
      z81 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+81);
      z82 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+82);
      z83 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+83);
      z84 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+84);
      z85 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+85);
      z86 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+86);
      z87 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+87);
      z88 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+88);
      z89 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+89);
      z90 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+90);
      z91 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+91);
      z92 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+92);
      z93 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+93);
      z94 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+94);
      z95 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+95);
      z96 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+96);
      z97 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+97);
      z98 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+98);
      z99 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+99);
      z100 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+100);
      z101 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+101);
      z102 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+102);
      z103 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+103);
      z104 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+104);
      z105 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+105);
      z106 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+106);  
      z107 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+107);
      z108 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+108);
      z109 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+109);
      z110 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+110);
      z111 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+111);
      z112 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+112); 
      z113 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+113);
      z114 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+114);
      z115 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+115);
      z116 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+116);
      z117 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+117);
      z118 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+118); 
      z119 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+119);
      z120 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+120);
      z121 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+121);
      z122 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+122);
      z123 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+123);
      z124 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+124); 
      z125 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+125);
      z126 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+126);
      z127 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+127);
      z128 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+128);
      z129 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+129);
      z130 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+130); 
      z131 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+131);
      z132 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+132);
      z133 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+133);
      z134 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+134);
      z135 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+135);
      z136 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+136);
      z137 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+137);
      z138 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+138);
      z139 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+139);
      z140 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+140);
      z141 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+141);
      z142 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+142);
      z143 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+143);  
      z144 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+144);
      z145 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+145);
      z146 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+146);
      z147 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+147);
      z148 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+148);
      z149 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+149); 
      z150 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+150);
      z151 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+151);
      z152 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+152);
      z153 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+153);
      z154 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+154);
      z155 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+155); 
      z156 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+156);
      z157 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+157);
      z158 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+158);
      z159 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+159);
      z160 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+160);
      z161 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+161); 
      z162 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+162);
      z163 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+163);
      z164 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+164);
      z165 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+165);
      z166 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+166);
      z167 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+167); 
      z168 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+168);
      z169 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+169);
      z170 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+170);
      z171 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+171);
      z172 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+172);
      z173 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+173);
      z174 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+174);
      z175 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+175);
      z176 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+176);
      z177 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+177);
      z178 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+178);
      z179 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+179);
      z180 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+180);  
      z181 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+181);
      z182 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+182);
      z183 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+183);
      z184 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+184);
      z185 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+185);
      z186 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+186); 
      z187 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+187);
      z188 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+188);
      z189 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+189);
      z190 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+190);
      z191 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+191);
      z192 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+192); 
      z193 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+193);
      z194 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+194);
      z195 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+195);
      z196 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+196);
      z197 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+197);
      z198 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+198); 
      z199 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+199);
      z200 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+200);
      z201 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+201);
      z202 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+202);
      z203 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+203);
      z204 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+204); 
      z205 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+205);
      z206 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+206);
      z207 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+207);
      z208 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+208);
      z209 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+209);
      z210 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+210);
      z211 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+211);
      z212 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+212);
      z213 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+213);
      z214 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+214);
      z215 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+215);
      z216 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+216);
      z217 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+217);  
      z218 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+218);
      z219 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+219);
      z220 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+220);
      z221 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+221);
      z222 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+222);
      z223 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+223); 
      z224 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+224);
      z225 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+225);
      z226 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+226);
      z227 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+227);
      z228 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+228);
      z229 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+229); 
      z230 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+230);
      z231 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+231);
      z232 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+232);
      z233 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+233);
      z234 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+234);
      z235 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+235); 
      z236 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+236);
      z237 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+237);
      z238 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+238);
      z239 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+239);
      z240 = iCustom(Symbol(), 0, "ZigZag", CalculateOnBarClose, ZZDepth, ZZDev, 0, i+240);
          
*/