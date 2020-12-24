class Complex {
  
  float re, im;
  
  Complex(float a, float b) {
    re = a;
    im = b;
  }
  
  void add(Complex c) {
    this.re += c.re;
    this.im += c.im;
    //return new Complex(re, im);
  }
  
  Complex mult(Complex c) {
    re = this.re * c.re - this.im * c.im;
    im = this.re * c.im + this.im * c.re;
    return new Complex(re, im);
  }
}

FloatDict[] dft(float[] x) {
  X = new FloatDict();
  int N = x.length;
  
  for (int k = 0; k < N; k++) {
    Complex sum = new Complex(0, 0);
    
    for (int n = 0; n < N; n++) {
      float phi = (2*PI*k*n)/N;
      Complex c = new Complex(cos(phi), -sin(phi));
      sum.add(x[n].mult(c));
    }
    
    sum.re = sum.re/N;
    sum.im = sum.im/N;
    
    int freq = k;
    float amp = sqrt((sum.re*sum.re)+(sum.im*sum.im));
    float phase = atan2(sum.im, sum.re);
    
    X[k] = {re:sum.re, im:sum.im, freq, amp, phase}
  }
  
}
