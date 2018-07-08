class Widget {
  int x, y, width, height;
  String label; 
  int event;
  color widgetColor, labelColor;
  PFont widgetFont;
  boolean selected;

  Widget(int x,int y, int width, int height, String label,
  color widgetColor, PFont widgetFont, int event, boolean selected){
    this.x=x;
    this.y=y;
    this.width = width; 
    this.height= height;
    this.label=label;
    this.event=event; 
    this.widgetColor=widgetColor; 
    this.widgetFont=widgetFont;
    labelColor= color(0);
    this.selected = selected;
   }
   
  void draw(){
    if( selected )
    {
      widgetColor = color(255, 215, 0);
    }
    else
    {
      widgetColor = color(255);
    }
    fill(widgetColor);
    rect(x,y,width,height);
    fill(labelColor);
    text(label, x+10, y+height-10);
  }
  int getEvent(int mX, int mY){
    
     if(mX>x && mX < x+width && mY >y && mY <y+height )
     {
       return event;
     }
     else
     {
       return EVENT_NULL;
     }
  }
}