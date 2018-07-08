Player thePlayer;  
Player theComputer;
Ball theBall; 
int playerScore;
int computerScore;

void settings()
{  
  size( SCREENX, SCREENY );  
}  

void setup()
{  
  frameRate( 60 );
  thePlayer = new Player( SCREENY - MARGIN - PADDLEHEIGHT );  
  theComputer = new Player( MARGIN );
  theBall = new Ball();  
  ellipseMode( RADIUS );  
  playerScore = 0;
  computerScore = 0;
}  

void mousePressed()
{
  if( ( computerScore >= 2 && theBall.yPosition >= SCREENY ) 
  || ( playerScore >= 2 && theBall.yPosition <= 1 ) )
  {
    computerScore = 0;
    playerScore = 0;
    theBall.reset();
  }
  else if( theBall.yPosition >= SCREENY )
  {
    computerScore ++;
    System.out.println( playerScore + " " + computerScore );
    theBall.reset();
  }
  else if( theBall.yPosition <= 0 )
  {
    playerScore ++;
    System.out.println( playerScore + " " + computerScore );
    theBall.reset();
  }
}

int moveComputer()
{
  int position;
  if( theBall.xPosition - ( PADDLEWIDTH / 2 ) > theComputer.xPosition 
  && theComputer.xPosition < SCREENX - PADDLEWIDTH )
  {
    position = theComputer.xPosition + 1;
  }
  else if( theBall.xPosition - ( PADDLEWIDTH / 2 ) < theComputer.xPosition 
  && theComputer.xPosition > 0 )
  {
    position = theComputer.xPosition - 1;
  }
  else
  {
    position = theComputer.xPosition;
  }
  return position;
}

void  draw()
{  
  PFont myFont = loadFont( "ComicSansMS-Italic-18.vlw" );
  textFont( myFont );
  background( 0 );  
  if( playerScore >= 2 && theBall.yPosition <= 1 )
  {
    text( "Player Wins!", ( SCREENX / 2 ) - 50, ( SCREENY / 2 ) );
    text( computerScore, SCREENX - 30, ( SCREENY / 2 ) - 20 );
    text( playerScore + 1, SCREENX - 30, ( SCREENY / 2 ) + 20 );
  }
  else if( computerScore >= 2 && theBall.yPosition >= SCREENY )
  {
    text( "Computer Wins!", ( SCREENX / 2 ) - 60, ( SCREENY / 2 ) );
    text( computerScore + 1, SCREENX - 30, ( SCREENY / 2 ) - 20 );
    text( playerScore, SCREENX - 30, ( SCREENY / 2 ) + 20 );
  }
  else
  {
    if( theBall.yPosition <= 1 )
    {
      text( computerScore, SCREENX - 30, ( SCREENY / 2 ) - 20 );
      text( playerScore + 1, SCREENX - 30, ( SCREENY / 2 ) + 20 );
    }
    else if( theBall.yPosition >= SCREENY )
    {
      text( computerScore + 1, SCREENX - 30, ( SCREENY / 2 ) - 20 );
      text( playerScore, SCREENX - 30, ( SCREENY / 2 ) + 20 );
    }
    else
    {
      text( computerScore, SCREENX - 30, ( SCREENY / 2 ) - 20 );
      text( playerScore, SCREENX - 30, ( SCREENY / 2 ) + 20 );
    }
    thePlayer.move( mouseX ); 
    theComputer.move( moveComputer() );
    theBall.move();  
    theBall.collide( thePlayer, theComputer ); 
    thePlayer.draw();  
    theComputer.draw();
    theBall.draw();
  }
}