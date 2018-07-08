class Player
{  
  int xPosition;
  int yPosition;    
  color paddlecolor = color( 50 );
  
  Player( int y )  
  {  
    xPosition = SCREENX / 2;  
    yPosition = y;  
  }  
  
  void move( int x )
  {  
    if( x > SCREENX - PADDLEWIDTH )
    {
      xPosition = SCREENX - PADDLEWIDTH;
    }
    else 
    {
      xPosition = x;
    }
  }  
      
  void  draw()  
  {  
    fill( paddlecolor );  
    rect( xPosition, yPosition, PADDLEWIDTH, PADDLEHEIGHT );  
  }  
}