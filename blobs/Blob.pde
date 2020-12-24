class Blob {
  float minX;
  float minY;
  float maxX;
  float maxY;
  
  Blob(float x, float y) {
  minX = x;
  minY = y;
  maxX = x;
  maxY = y;
  }
  
  void add(float x, float y) {
    minX = min(minX, x);
    minY = min(minY, y);
    maxX = max(maxX, x);
    maxY = max(maxY, y);  
  }
  
  float size() {
    return (maxX - minX) * (maxY - minY);
  }
  
  void show() {
    stroke(0);
    fill(255);
    strokeWeight(2);
    rectMode(CORNERS);
    rect(width - minX, minY, width - maxX, maxY);
  }
  
  boolean isNear(float x, float y) {
    float cx = (minX + maxX) / 2;
    float cy = (minY + maxY) / 2;
    
    float d = distsq(cx, cy, x, y);
    
    if (d < distThreshold*distThreshold) {
      return true;
    } else {
      return false;
    }
  }
}
