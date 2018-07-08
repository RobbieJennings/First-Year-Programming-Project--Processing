int x = 0;

void setup()
{
  size( 400, 400 );
  frameRate( 60 );
  noStroke();
}

void draw()
{
  background( 255 );
  x++;
  
  if( x >= 254 )
  {
    x = 0;
  }
  
  fill( 255, 0, 0 );
  rect( x, 50, 150, 150 );
}