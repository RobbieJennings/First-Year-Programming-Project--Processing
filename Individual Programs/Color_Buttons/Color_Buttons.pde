PFont myFont;
Widget widget1, widget2, widget3;
Display myDisplay;
ArrayList widgetList;

void settings()
{
  size( SCREENX, SCREENY );
}

void setup()
{
  myFont = loadFont( "ComicSansMS-30.vlw" );
  textFont( myFont );
  widget1 = new Widget( 100, 100, 180, 40, "Red", color( 255, 0, 0 ), myFont, EVENT_RED );
  widget2 = new Widget( 100, 200, 180, 40, "Green", color( 0, 255, 0 ), myFont, EVENT_GREEN ); 
  widget3 = new Widget( 100, 300, 180, 40, "Blue", color( 0, 0, 255 ), myFont, EVENT_BLUE); 
  widgetList = new ArrayList();
  widgetList.add( widget1 ); 
  widgetList.add( widget2 );
  widgetList.add( widget3 );
  myDisplay = new Display( 20, 20, 40, 40, color( 255 ) );
}

void draw()
{
  for( int i = 0; i < widgetList.size(); i++ )
  {
    Widget aWidget = ( Widget ) widgetList.get( i );
    aWidget.checkMouse( mouseX, mouseY );
    aWidget.draw();
  }
  myDisplay.draw();
}

void mousePressed()
{
  int event;
  
  for( int i = 0; i < widgetList.size(); i++ )
  {
    Widget aWidget = ( Widget ) widgetList.get( i );
    event = aWidget.getEvent( mouseX, mouseY );
    switch( event ) 
    {
      case EVENT_RED:
      myDisplay.changeColor( color( 255, 0, 0 ) );
      break;
      case EVENT_GREEN:
      myDisplay.changeColor( color( 0, 255, 0 ) );
      break;
      case EVENT_BLUE:
      myDisplay.changeColor( color( 0, 0, 255 ) );
      break;
    }  
  }
}