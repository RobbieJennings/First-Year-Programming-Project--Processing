class Bullet
{  
  int xPosition;
  int yPosition;    
  color bulletColor;
  
  Bullet( int x )  
  {  
    xPosition = x;  
    yPosition = SCREENY - MARGIN;  
    bulletColor = color( 255 );
  }  
  
  void collide( Alien[] myAliens )
  {
    for( int i = 0; i < myAliens.length; i++ )
    {
      if( ( myAliens[i].yPosition >= yPosition + BULLETHEIGHT
      && myAliens[i].yPosition - SIZE_OF_ALIENS <= yPosition + BULLETHEIGHT
      && myAliens[i].xPosition + SIZE_OF_ALIENS >= xPosition - BULLETWIDTH
      && myAliens[i].xPosition <= xPosition + BULLETWIDTH ) )
      {    
        myAliens[i].explode();
      }  
    }
  }
  
  void move()
  {  
    yPosition -= BULLETSPEED;
  }  
      
  void  draw()  
  {  
    fill( bulletColor );  
    rect( xPosition, yPosition, BULLETWIDTH, BULLETHEIGHT );  
  }
}