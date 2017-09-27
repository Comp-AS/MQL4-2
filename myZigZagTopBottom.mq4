#property indicator_chart_window
#property indicator_buffers 3
#property indicator_color1 Red
#property indicator_width1 3
#property indicator_color2 Green
#property indicator_width2 3
#property indicator_color3 Yellow
#property indicator_width3 3


//---- indicator parameters
extern int ExtDepth=12;
extern int ExtDeviation=5;
extern int ExtBackstep=3;


double ZigZag[];
double Bottoms[];
double Toppers[];

int init()
{
   IndicatorBuffers(3);

   SetIndexStyle(0,DRAW_SECTION);
   SetIndexBuffer(0,ZigZag);
   SetIndexEmptyValue(0,0.0);
   
   SetIndexStyle(1,DRAW_SECTION);
   SetIndexBuffer(1,Bottoms);
   SetIndexEmptyValue(1,0.0);

   SetIndexStyle(2,DRAW_SECTION);
   SetIndexBuffer(2,Toppers);
   SetIndexEmptyValue(2,0.0);

  IndicatorShortName("zz show top & bottom");
  return(0);
}

int deinit()
{
  return(0);
}

int start()
{
  int counted_bars=IndicatorCounted();
  int limit=0;
  limit = Bars-counted_bars;
  
  for(int shift=limit-1;shift>=0;shift--)
  {
    ZigZag[shift]=iCustom(
        Symbol(),0,"ZigZag",
        ExtDepth, ExtDeviation, ExtBackstep,
        0, shift
    );

    if(ZigZag[shift]>0.1 && Low[shift]==ZigZag[shift]) Bottoms[shift]=ZigZag[shift];
    if(ZigZag[shift]>0.1 && High[shift]==ZigZag[shift]) Toppers[shift]=ZigZag[shift];
  }
  
  return(0);
}