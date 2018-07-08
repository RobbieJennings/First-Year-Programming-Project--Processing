class Bomb
{  
  int xPosition;
  int yPosition;    
  color bombColor;
  
  Bomb( int x, int y )  
  {  
    xPosition = x;  
    yPosition = y;  
    bombColor = color( 255 );
  }  
  
  boolean collide( Player myPlayer )
  {
    for( int i = 0; i < myAliens.length; i++ )
    {
      if( ( myPlayer.yPosition >= yPosition + BOMBHEIGHT
      && myPlayer.yPosition - PLAYERHEIGHT <= yPosition + BOMBHEIGHT
      && myPlayer.xPosition + PLAYERWIDTH >= xPosition - BOMBWIDTH
      && myPlayer.xPosition <= xPosition + BOMBWIDTH ) )
      {  
        return true;  
      }  
    }
    return false;
  }
  
  void move()
  {  
    yPosition += BOMBSPEED;
  }  
      
  void  draw()  
  {  
    fill( bombColor );  
    rect( xPosition, yPosition, BOMBWIDTH, BOMBHEIGHT );  
  }
  
  boolean offScreen()
  {
    if( yPosition >= SCREENY )
    {
      return true;
    }
    return false;
  }
}