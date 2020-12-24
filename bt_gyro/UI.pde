void mousePressed() {
  
  /////////////////////////cube
  if ((mouseX>0.05*width) && (mouseX<0.95*width) && 
      (mouseY<(height-0.05*width)) && (mouseY>(height-0.05*width)-width*0.9)) {
    cube = color(9,125,170);
    isCube = true;
  }
  
  ///////////////////////zo
  if ((mouseX>width*0.05) && (mouseX<(width*0.05)+80) && 
      (mouseY<(height-width)) && (mouseY>(height-width)-80)) {
    zo = color(9,125,170);
    isZo = true;
  }
  
  /////////////////////y
  if ((mouseX>(width*0.075)+80) && (mouseX<(width*0.075)+240) && 
      (mouseY<(height-width)) && (mouseY>(height-width)-80)) {
    y = color(9,125,170);  
    isY = true;
  }
  
  ////////////////////x
  if ((mouseX>width*0.05) && (mouseX<(width*0.05)+80) && 
      (mouseY<(height-width*1.025)-80) && (mouseY>(height-width*1.025)-240)) {
    x = color(9, 125, 170); 
    isX = true;
  }
  
  //////////////////z
  if ((mouseX>(width*0.075)+80) && (mouseX<(width*0.075)+240) && 
    (mouseY<(height-width*1.025)-80) && (mouseY>(height-width*1.025)-240)) {
    z = color(9, 125, 170);
    isZ = true;
  }
  
  //////////////////fit
  if (dist(mouseX, mouseY, (width*0.125)+300, (height-width)-60)<60) {
    fit = color(9, 125, 170);
    isFit = true;
  }
  
  ////////////////////f8
  if (dist(mouseX, mouseY, (width*0.175)+420, (height-width)-60)<60) {
    f8 = color(9, 125, 170);
    isF8 = true;
  }
  
  //////////////////home
  if (dist(mouseX, mouseY, (width*0.125)+300, (height-width*1.05)-180)<60) {
    home = color(9, 125, 170);
    isHome = true;
  }
  
  //////////////////end
  if (dist(mouseX, mouseY, (width*0.175)+420, (height-width*1.05)-180)<60) {
    end = color(9, 125, 170);
    isEnd = true;
  }
}

void mouseReleased() {
  cube = color(#C0C0C0);
  x = color(#C0C0C0);
  y = color(#C0C0C0);
  z = color(#C0C0C0);
  zo = color(#C0C0C0);
  fit = color(#C0C0C0);
  f8 = color(#C0C0C0);
  home = color(#C0C0C0);
  end = color(#C0C0C0);
  
  isCube = false;
  isX=isY=isZ = false;
  isZo = false;
  isFit=isF8 = false;
  isHome=isEnd = false;
}

void drawUI() {
  ////////////////////////buttons///////////////////////////////////
  strokeWeight(4);
  fill(cube);
  rect(width*0.05, height-(width*0.05), width*0.9, -width*0.9, 10, 10, 10, 10);   //cube
  fill(zo);
  rect(width*0.05, height-width, 80, -80, 0, 0, 0, 10);                         //zo 
  fill(y);
  rect((width*0.075)+80, height-width, 160, -80, 0, 0, 10, 0);                   //y
  fill(x);
  rect(width*0.05, height-(width*1.025)-80, 80, -160, 10, 0, 0, 0);                //x
  fill(z);
  rect((width*0.075)+80, height-width*1.025-80, 160, -160, 0, 10, 0, 0);          //z
  fill(fit);
  ellipse((width*0.125)+300, (height-width)-60, 120, 120);                       //fit
  fill(f8);
  ellipse((width*0.175)+420, (height-width)-60, 120, 120);                     //f8
    fill(home);
  ellipse((width*0.125)+300, (height-width*1.05)-180, 120, 120);                 //home
  fill(end);
  ellipse((width*0.175)+420, (height-width*1.05)-180, 120, 120);                 //end
  
  /////////////////////////////////////////////////////
  
  ///////////////////text//////////////////////////////////
  textSize(60);
  fill(0);
  textAlign(CENTER);
  text("X", (width*0.05)+40, height-(width*1.025)-140);
  text("Y", (width*0.075)+160, (height-width)-20);
  text("Z", (width*0.075)+160, height-(width*1.025)-140);
  text("Z0", (width*0.05)+40, (height-width)-20);
  text("FIT", (width*0.125)+300, (height-width)-40);
  text("F8", (width*0.175)+420, (height-width)-40);
  textSize(40);
  text("HOME", (width*0.125)+300, (height-width*1.05)-165);
  text("END", (width*0.175)+420, (height-width*1.05)-165);
}    
