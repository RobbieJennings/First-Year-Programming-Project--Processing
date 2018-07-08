class Alien 
{
  int x;
  int y; 
  int direction = SPEED; 
  int lastDirection = direction;
  int downMove = 0;
  PImage appearance;
 
  Alien( int xpos, int ypos, PImage alienImage )
  {
    x = xpos;
    y = ypos;
    appearance = alienImage;
  }
  
  void explode()
  {
    float i = random( 1000 );
    if( i >= 999 )
    appearance = exploding;
  }
  
  void move()
  {
    x += direction;
    if( ( x <= MARGIN || x >= SCREENX - SIZE_OF_ALIENS - MARGIN ) && ( direction != 0 ) )
    {
      lastDirection = direction;
      direction = 0; 
    }
    if( direction == 0 )
    {
      if( x <= MARGIN || x >= SCREENX - SIZE_OF_ALIENS - MARGIN )
      {
        y += SPEED;
      }
      downMove += SPEED;
      if( downMove >= SIZE_OF_ALIENS )
      {
        direction = -lastDirection;
        downMove = 0;
        x += direction;
      }
    }
  }
  
  void draw()
  {
    image( appearance, x, y );
  }
}