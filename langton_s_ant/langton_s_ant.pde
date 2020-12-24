//|-----------------------------------------------------------|
//|Mode: Android/Java                                         |
//|Work by Tank Priyansu                                      |
//|If you have any query or suggestions regarding this project| 
//|feel free to contact me.                                   |
//|-----------------------------------------------------------|

float pixeln=9;
color c=color(255);
Pixel[] pixelss = new Pixel[1];

void setup () {
  size(600,600);
  background(0);
  pixelss[0] = new Pixel(0,0,pixeln);
  
    for (int n = 1; n <= pixeln*pixeln; n++) {
      
        for (int i = 0; i < pixelss.length; i++ ) {
          
          if (n == (pixeln*pixeln+1)/2) {
            fill(c);
          } else {
            fill(200);
          }
          
          pixelss[i].makerect();
          pixelss[i].newrect();
        }     
    }
}

void draw () {

}

void mousePressed() {
    for (int i = 1; i == pixelss.length; i++) {
    if (pixelss[i].color() == 255) {
      fill(0);
      pixelss[i].makerect();
    }
  }
}
