class  Ball
{  
  float xPosition;
  float yPosition;  
  float dx;
  float dy;    
  color ballColor = color( 200, 100, 50 );  
  
  Ball()
  {  
    xPosition = random( SCREENX / 4, SCREENX / 2 );    
    yPosition = random( SCREENY / 4, SCREENY / 2 );  
    dx = random( 1, 2 );
    dy = random( 1, 2 );      
  }  
    
  void  reset()
  {  
    xPosition = random( SCREENX / 4, SCREENX / 2 );    
    yPosition = random( SCREENY / 4, SCREENY / 2 );
    dx = random( 1, 2 );
    dy = random( 1, 2 );
  } 
  
  void  move()
  {  
    if( yPosition > 0 && yPosition < SCREENY )
    {
      xPosition = xPosition + dx;
      yPosition = yPosition + dy;
    }
  }  
  
  void  draw()
  {  
    fill( ballColor );  
    ellipse( int( xPosition ), int( yPosition ), BALLRADIUS, BALLRADIUS );  
  }  
  
  void  collide( Player thePlayer, Player theComputer )
  {  
    if( xPosition - BALLRADIUS <= 0 
    || xPosition + BALLRADIUS >= SCREENX )
    {
      dx = -dx;
    }
    if( ( yPosition + BALLRADIUS >= thePlayer.yPosition 
    && yPosition - BALLRADIUS <= thePlayer.yPosition + PADDLEHEIGHT
    && xPosition >= thePlayer.xPosition 
    && xPosition <= thePlayer.xPosition + PADDLEWIDTH )
    || ( yPosition + BALLRADIUS >= theComputer.yPosition 
    && yPosition - BALLRADIUS <= theComputer.yPosition + PADDLEHEIGHT 
    && xPosition >= theComputer.xPosition 
    && xPosition <= theComputer.xPosition + PADDLEWIDTH ) )
    {  
      println( "collided!" );  
      dy = -dy;  
    }    
  }
}