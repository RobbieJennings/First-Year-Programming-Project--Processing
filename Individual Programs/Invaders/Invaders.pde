Alien myAliens[];
PImage spacer;
PImage exploding;

void settings()
{
  size( SCREENX, SCREENY );
}

void setup()
{
  frameRate(60);
  myAliens = new Alien[NUMBER_OF_ALIENS];
  spacer = loadImage( "spacer.GIF" );
  exploding = loadImage( "exploding.GIF" );
  init_aliens( myAliens );
}

void init_aliens ( Alien myAliens[] )
{
  for( int i = 0; i < myAliens.length; i++ )
  {
    myAliens[i] = new Alien( MARGIN + ( ( MARGIN + SIZE_OF_ALIENS ) * i ), MARGIN, spacer );
  }
}

void draw()
{
  background( 255 );
  for( int i = 0; i < myAliens.length; i++ ) 
  {
    if( myAliens[0].y < SCREENY - SIZE_OF_ALIENS - MARGIN || myAliens[NUMBER_OF_ALIENS - 1].y < SCREENY - SIZE_OF_ALIENS - MARGIN )
    {
      myAliens[i].move(); 
    }
    myAliens[i].explode();
    myAliens[i].draw();
  }
}