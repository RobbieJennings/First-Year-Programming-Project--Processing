class Screen
{
  ArrayList widgetList;
  color background;
  int event;
  
  Screen( color background )
  {
    widgetList = new ArrayList(); 
    this.background = background;
  }
  
  void draw()
  {
    background( background );
    for( int i = 0; i < widgetList.size(); i++ )
    {
      Widget aWidget = ( Widget ) widgetList.get( i );
      aWidget.checkMouse( mouseX, mouseY );
      aWidget.draw();
    }
  }
  
  void addWidget( Widget myWidget )
  {
    widgetList.add( myWidget );
  }
  
  int getEvent( int x, int y)
  {
    for( int i = 0; i < widgetList.size(); i++ )
    {
      Widget aWidget = ( Widget ) widgetList.get( i );
      event = aWidget.getEvent( x, y );
      if( event != EVENT_NULL )
      {
        return event;
      }
    }
    return EVENT_NULL;
  }
}