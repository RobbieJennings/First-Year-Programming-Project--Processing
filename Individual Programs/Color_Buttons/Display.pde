class Display
{  
  int x, y, width, height;
  int event;
  color displayColor;
  PFont widgetFont;

  Display(int x, int y, int width, int height, color displayColor )
  {
    this.x = x; 
    this.y = y; 
    this.width = width; 
    this.height = height; 
    this.displayColor = displayColor;
  }
  
  void changeColor( color newColor )
  {
    displayColor = newColor;
  }
   
  void draw()
  {
    fill( displayColor );
    rect( x, y, width, height);
  } 
}