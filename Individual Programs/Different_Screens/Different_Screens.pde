PFont myFont;
Widget button1, button2, forward, backward;
Screen screen1, screen2, currentScreen;

void settings()
{
  size( SCREENX, SCREENY );
}

void setup()
{
  myFont = loadFont( "ComicSansMS-30.vlw" );
  textFont( myFont );
  button1 = new Widget( 100, 100, 180, 40, "button 1", color( 0, 255, 0 ), myFont, EVENT_BUTTON1 ); 
  forward = new Widget( 100, 200, 180, 40, "forward", color( 200, 100, 0 ), myFont, EVENT_FORWARD );
  button2 = new Widget( 100, 100, 180, 40, "button 2", color( 255, 0, 0 ), myFont, EVENT_BUTTON2 ); 
  backward = new Widget( 100, 200, 180, 40, "backward", color( 200, 0, 100 ), myFont, EVENT_BACKWARD );
  screen1 = new Screen( color( 0, 255, 255 ) );
  screen2 = new Screen( color( 255, 255, 0 ) );
  screen1.addWidget( forward );
  screen1.addWidget( button1 );
  screen2.addWidget( backward );
  screen2.addWidget( button2 );
  currentScreen = screen1;
}

void draw()
{
  currentScreen.draw();
}

void mousePressed()
{
  int event = currentScreen.getEvent( mouseX, mouseY );
  switch( event )
  {
    case EVENT_BUTTON1:
    System.out.println( "button 1" );
    break;
    case EVENT_FORWARD:
    currentScreen = screen2;
    break;
    case EVENT_BUTTON2:
    System.out.println( "button 2" );
    break;
    case EVENT_BACKWARD:
    currentScreen = screen1;
    break;
  }
}