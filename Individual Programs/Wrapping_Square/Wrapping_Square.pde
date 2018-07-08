int x = 0;
int width = 150;

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
  
  if( x >= 399 )
  {
    x = 0;
  }
  
  fill( 255, 0, 0 );
  rect( ( x - 399 ), 50, 150, 150 );
    
  fill( 255, 0, 0 );
  rect( x, 50, 150, 150 );
}