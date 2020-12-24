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
  beginShape();
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

//float[] Tx;
//boolean ct, ins, pt;

//float[] in(float c[]) {
//  Tx = new float[c.length];
//  for (int i=0; i<c.length; i++) {
//    c[i] = 0;
//    Tx[i] = 0;
//  }
//  return c;
//}

//float[] setTemp(float c[], float a) {
//  for (int i=1; i<=c.length-2; i++) {
//    c[i] = Tx[i] = a;
//  }
//  return c;
//}

//float[] setPointTemp(float c[], float[] x, float[] t) {
//  pt = true;
//    for (int i=1; i<=c.length-2; i++) {
//      for (int j=0; j<t.length; j++) {
//        if (i == x[j]) {
//          c[i] = Tx[i] = t[j];
//        }
//      }
//    }
//  return c;
//}

//float[] ctBoundary(float c[], float a, float b) {
//  ct = true;
//  c[0] = Tx[0] = a;
//  c[c.length-1] = Tx[c.length-1] = b;
//  return c;
//}

//float[] insBoundary(float c[]) {
//  ins = true;
//  c[0] = Tx[0] = c[1];
//  c[c.length-1] = Tx[c.length-1] = c[c.length-2];
//  return c;
//}

//float[] solve(float c[], float[] x, float[] t) {
  
//  if (ct) {
//    for (int i=1; i<c.length-1; i++) {
//      Tx[i] = tau*(c[i-1]+c[i+1]) + (1-(2*tau))*c[i];
//    }
//  } if (ins) {
//    for (int i=2; i<c.length-2; i++) {
//      Tx[i] = tau*(c[i-1]+c[i+1]) + (1-(2*tau))*c[i];
//    }
//    c[0] = c[1];
//    c[c.length-1] = c[c.length-2];
//  } if (pt) {
//    for (int i=1; i<c.length-1; i++) {
//      for (int j=1; i<x.length-1; j++)
//      if (i != x[j]) {
//        Tx[i] = tau*(c[i-1]+c[i+1]) + (1-(2*tau))*c[i];
//      } else {
//        Tx[i] = t[j];
//      }
//    }   
//  }
//  noStroke();
//  for (int i=0; i<Tx.length; i++) {
//    ellipse(i*dx+dx/2, height-Tx[i], 10, 10);
//  }
//  arrayCopy(Tx, c);
//  return c;
//}
