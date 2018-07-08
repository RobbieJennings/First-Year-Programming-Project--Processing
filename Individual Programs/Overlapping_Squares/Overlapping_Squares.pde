void setup()
{
  size( 400, 400 );
  frameRate( 60 );
  noStroke();
}

void draw()
{
  background( 255 );
  
  fill( 255, 0, 0 );
  rect( 30, 30, 150, 150 );
  
  fill( 0, 0, 255 );
  rect( 230, 230, 150, 150 );
  
  fill( 0, 255, 0 );
  rect( 130, 130, 150, 150 );
}