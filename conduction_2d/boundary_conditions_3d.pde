float[][] cd;
float R, G, B, max;

float[][] in(float[][] c) {
  cd = new float[c.length][2];
  for (int i=0; i<c.length; i++) {
    for (int j=0; j<2; j++) {
      if(j==0) {
        c[i][j] = i;
        cd[i][j] = i;
      } else {
        c[i][j] = 0;
        cd[i][j] = 0;
      }
    }
  }
  return c;
}

float[][] setTemp(float[][] c, int s, int e, float t) {
  for (int i=s-1; i<e; i++) {
    c[i][1] = t;
  }
  return c;
}

void pr(float[][] c) {
  for (int i=0; i<c.length; i++) {
    for (int j=0; j<2; j++) {
      println(c[i][j]);
    }
  }
}

float[][] solve(float[][] c) {
  for(int i=1; i<c.length-1; i++) {
    cd[i][1] = tau*(c[i-1][1]+c[i+1][1]) + (1-(2*tau))*c[i][1];
  }
  arrayCopy(cd, c);
  return c;
}

void plot(float[][] c) {
  //noStroke();
  //for(int i=0; i<c.length; i++) {
  //  ellipse(i*dx+dx/2, height-c[i][1], 10, 10);
  //}
  beginShape(QUAD_STRIP);
  noFill();
  strokeWeight(3);
  stroke(255);
    for (int i = 0; i < c.length; i++) {
      vertex((c[i][0]*dx)+dx/2,height-c[i][1]-50);
    }
  endShape();
  
  noStroke();
  for (int i = 0; i < c.length; i++) {
    R = map(c[i][1], 0, 400, 0, 255);
    G = 0;
    B = map(c[i][1], 0, 400, 255, 0);
    fill(R, G, B);
    rect(c[i][0]*dx, height-50, dx, 50);
  }
}
