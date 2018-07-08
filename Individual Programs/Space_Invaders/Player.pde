class Player
{  
  int xPosition;
  int yPosition;    
  PImage appearance;
  
  Player( PImage playerImage )  
  {  
    appearance = playerImage;
    xPosition = SCREENX / 2;  
    yPosition = SCREENY - MARGIN;  
  }  
  
  void move( int x )
  {  
    if( x > SCREENX - PLAYERWIDTH - MARGIN )
    {
      xPosition = SCREENX - PLAYERWIDTH - MARGIN;
    }
    else if( x < MARGIN )
    {
      xPosition = MARGIN;
    }
    else 
    {
      xPosition = x;
    }
  }  
      
  void  draw()  
  {    
    image( appearance, xPosition, yPosition );  
  }
}