class Widget 
{
  int x, y, width, height;
  String label; 
  int event;
  color widgetColor, labelColor;
  PFont widgetFont;
  boolean mouseHover;

  Widget(int x, int y, int width, int height, String label, color widgetColor, PFont widgetFont, int event )
  {
    this.x = x; 
    this.y = y; 
    this.width = width; 
    this.height = height;
    this.label = label; 
    this.event = event; 
    this.widgetColor = widgetColor;
    this.widgetFont = widgetFont;
    labelColor = color(0);
    mouseHover = false;
  }
   
  void draw()
  {
    if( mouseHover )
    {
      stroke( 255 );
    }
    fill( widgetColor );
    rect( x, y, width, height );
    fill( labelColor );
    text( label, x + 10, y + height - 10 );
    stroke( 0 );
  }
  
  int getEvent( int mX, int mY )
  {
     if( mX > x && mX < x + width && mY > y && mY < y + height )
     {
        return event;
     }
     return EVENT_NULL;
  }
  
  void checkMouse( int mX, int mY )
  {
    if( mX > x && mX < x + width && mY > y && mY < y + height )
    {
      mouseHover = true;
    }
    else
    {
      mouseHover = false;
    }
  }
}