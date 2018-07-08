class Alien 
{
  Bomb myBomb;
  int xPosition;
  int yPosition; 
  int direction; 
  int lastDirection;
  int downMove;
  PImage appearance;
  boolean exploded;
  boolean isExploding;
  int explodeCount;
  boolean isShooting;
 
  Alien( int x, int y, PImage alienImage )
  {
    xPosition = x;
    yPosition = y;
    direction = ALIENSPEED; 
    lastDirection = direction;
    downMove = 0;
    appearance = alienImage;
    exploded = false;
    isExploding = false;
    isShooting = false;
  }
  
  void dropBomb()
  {
    if( myBomb != null )
    {
      if( myBomb.offScreen() )
      {
        isShooting = false;
      }
    }
    if( isShooting == false && exploded == false && isExploding == false )
    {
      float i = random( 1000 );
      if( i >=998 )
      {
        isShooting = true;
        myBomb = new Bomb( xPosition, yPosition );
      }
    }
  }
  
  void explode()
  {
    appearance = exploding;
    isExploding = true;
  }
  
  void move()
  {
    xPosition += direction;
    if( ( xPosition <= MARGIN || xPosition >= SCREENX - SIZE_OF_ALIENS - MARGIN ) && ( direction != 0 ) )
    {
      lastDirection = direction;
      direction = 0; 
    }
    if( direction == 0 )
    {
      if( xPosition <= MARGIN || xPosition >= SCREENX - SIZE_OF_ALIENS - MARGIN )
      {
        yPosition += ALIENSPEED;
      }
      downMove += ALIENSPEED;
      if( downMove >= SIZE_OF_ALIENS )
      {
        direction = -lastDirection;
        downMove = 0;
        xPosition += direction;
      }
    }
  }
  
  void draw()
  {
    if( isExploding )
    {
      if( explodeCount >= DURATION_OF_EXPLOSION )
      {
        isExploding = false;
        exploded = true;
      }
      explodeCount++;
    }
    if( !exploded )
    {
      image( appearance, xPosition, yPosition );
    }
    if( isShooting )
    {
      myBomb.move();
      myBomb.draw();
    }
  }
}