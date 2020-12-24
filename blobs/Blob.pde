class Blob {
  float minX;
  float minY;
  float maxX;
  float maxY;
  
  ArrayList<PVector> points;
  
  Blob(float x, float y) {
    minX = x; 
    minY = y;
    maxX = x;
    maxY = y;
    points = new ArrayList<PVector>();
    points.add(new PVector(x, y));
  }
  
  void add(float x, float y) {
    points.add(new PVector(x, y));
    minX = min(minX, x);
    minY = min(minY, y);
    maxX = max(maxX, x);
    maxY = max(maxY, y);  
  }
  
  float size() {
    return (maxX - minX) * (maxY - minY);
  }
  
  float rectx() {
    return (maxX - minX)/2 + minX;
  }
  float recty() {
    return (maxY - minY)/2 + minY;
  }
  
  void show() {
    stroke(0);
    //fill(255, 150);
    strokeWeight(2);
    rectMode(CORNERS);
    rect(width - minX, minY, width - maxX, maxY);
    
    //for (PVector v : points) {
    //  stroke(0, 0, 255);
    //  point(width - v.x, v.y);
    //}
    
    //textAlign(CENTER);
    //textSize(44);
    //fill(0);
    //text(num, width - (minX + (maxX  - minX)/2), minY + (maxY  - minY)/2);
   
  }
  
  boolean isNear(float x, float y) {
    //float cx = max(min(x, maxX), minX);
    //float cy = max(min(y, maxY), minY);
    //cx = max(cx, minX);
    
    //float cx = (minX + maxX) / 2;
    //float cy = (minY + maxY) / 2;
    
    //float d = distsq(cx, cy, x, y);
    
    float d = 10000000;
    for (PVector v : points) {
      float tempD = distsq(x, y, v.x, v.y);
      if (tempD < d) {
        d = tempD;
      }
    }
        
    if (d < distThreshold*distThreshold) {
      return true;
    } else {
      return false;
    }
  }
}
