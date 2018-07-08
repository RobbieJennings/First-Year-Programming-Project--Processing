int x = 0;
int y = 399;
int width = 150;

void setup()
{
  size( 400, 400 );
  frameRate( 50 );
  noStroke();
}

void draw()
{
  background( 255 );
  x++;
  y--;
  
  if( x >= 400 )
  {
    x = 0;
  }
  
  fill( 255, 0, 0 );
  rect( ( x - 399 ), 50, 150, 150 );
  
  fill( 255, 0, 0 );
  rect( x, 50, 150, 150 );
  
  if( y <= 0 )
  {
    y = 399;
  }

  fill( 0, 255, 0 );
  rect( ( 399 - width + y ), 220, 150, 150 );

  fill( 0, 255, 0 );
  rect( y - width, 220, 150, 150 );
}