int x = 0;
int y = 399;
float z = 0.0;

int a = 50;
int b = 100;
int c = 150;
boolean aBackwards = false;
boolean bBackwards = false;
boolean cBackwards = false;

int width = 150;

void setup()
{
  size( 400, 400 );
  frameRate( 50 );
  noStroke();
}

void draw()
{ 
  if( a >= 255 )
  {
    aBackwards = true;
  }
  if( a <= 0 )
  {
    aBackwards = false;
  }
  if( b >= 255 )
  {
    bBackwards = true;
  }
  if( b <= 0 )
  {
    bBackwards = false;
  }
  if( c >= 255 )
  {
    cBackwards = true;
  }
  if( c <= 0 )
  {
    cBackwards = false;
  }
  
  if( aBackwards )
  {
    a--;
  }
  else
  {
    a++;
  }
  if( bBackwards )
  {
    b--;
  }
  else
  {
    b++;
  }
  if( cBackwards )
  {
    c--;
  }
  else
  {
    c++;
  }
  
  background( 255 );
  x++;
  y--;
  
  if( z >= 2 * Math.PI )
  {
    z = 0;
  }
  
  z += 0.01 * 2 * Math.PI;
  
  if( x >= 400 )
  {
    x = 0;
  }
  
  fill( a, b, c);
  rect( ( x - 399 ), ( 50 + 20 * sin( z ) ), width, width );
  
  fill( a, b, c);
  rect( x, ( 50 + 20 * sin( z ) ), width, width );
  
  if( y <= 0 )
  {
    y = 399;
  }

  fill( a, b, c );
  rect( ( 399 - width + y ), ( 220 + 20 * sin( z ) ), width, width );

  fill( a, b, c );
  rect( ( y - width ), ( 220 + 20 * sin( z ) ), width, width );
}