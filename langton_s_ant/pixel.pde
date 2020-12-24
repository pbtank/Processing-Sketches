class Pixel {
  float x;
  float y;
  float c;
  float n;
  
  Pixel(float tempX, float tempY, float tempN) {
    x = tempX;
    y = tempY;
    n = tempN;
    c = 200;
  }
  
  void makerect() {
    stroke(255);
    //fill(c);
    rect(x,y,width/n,height/n);
  }
  
  void newrect() {
    x = x + width/n;
    //c = c - 10;
    
    if (x >= width) {
      x = x-width;
      y = y + height/n;
    } 
  }
}
  
