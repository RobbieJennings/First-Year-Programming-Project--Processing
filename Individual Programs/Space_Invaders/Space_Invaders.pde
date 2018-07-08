Alien myAliens[];
Player myPlayer;
Bullet myBullet;
PImage spacer;
PImage exploding;
PImage ship;
boolean shooting;
boolean gameOver;
boolean win;

void settings()
{
  size( SCREENX, SCREENY );
}

void setup()
{
  frameRate( 60 );
  myAliens = new Alien[NUMBER_OF_ALIENS];
  ship = loadImage( "ship.gif" );
  myPlayer = new Player( ship );
  spacer = loadImage( "spacer.gif" );
  exploding = loadImage( "exploding.GIF" );
  shooting = false;
  gameOver = false;
  win = false;
  init_aliens( myAliens );
}

void init_aliens ( Alien myAliens[] )
{
  for( int i = 0; i < myAliens.length; i++ )
  {
    myAliens[i] = new Alien( MARGIN + ( ( MARGIN + SIZE_OF_ALIENS ) * i ), MARGIN, spacer );
  }
}

void mousePressed()
{
  if( !shooting )
  {
    int x = myPlayer.xPosition;
    myBullet = new Bullet( x + ( PLAYERWIDTH / 2 ) );
    shooting = true;
  }
  if( myBullet.yPosition <= 0 )
  {
    shooting = false;
  }
}

void draw()
{
  background( 0 );
  if( gameOver )
  {
    PFont myFont = loadFont( "ComicSansMS-Italic-18.vlw" );
    textFont( myFont );
    text( "Game Over!", ( SCREENX / 2 ) - 50, ( SCREENY / 2 ) );
  }
  else if( win )
  {
    PFont myFont = loadFont( "ComicSansMS-Italic-18.vlw" );
    textFont( myFont );
    text( "You Win!", ( SCREENX / 2 ) - 50, ( SCREENY / 2 ) );
  }
  else
  {
    int alienCount = NUMBER_OF_ALIENS;
    for( int i = 0; i < myAliens.length; i++ ) 
    {   
      if( myAliens[i].exploded )
      {
        alienCount--;
      }
      if( alienCount <= 0 )
      {
        win = true;
      }
      myAliens[i].dropBomb();
      if( myAliens[i].myBomb != null )
      {
        if( myAliens[i].myBomb.collide( myPlayer ) )
        {
          gameOver = true;
        }
      }
      if( myAliens[0].yPosition < SCREENY - SIZE_OF_ALIENS - MARGIN || myAliens[NUMBER_OF_ALIENS - 1].yPosition < SCREENY - SIZE_OF_ALIENS - MARGIN )
      {
        myAliens[i].move();
      }
      if( shooting )
      {
        myBullet.collide( myAliens );
      }
      myAliens[i].draw();
    }
    myPlayer.move( mouseX );
    myPlayer.draw();
    if( shooting )
    {
      myBullet.move();
      myBullet.draw();
    }
  }
}