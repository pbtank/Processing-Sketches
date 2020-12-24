//|-----------------------------------------------------------|
//|Mode: Android/Java                                         |
//|Work by Tank Priyansu                                      |
//|If you have any query or suggestions regarding this project| 
//|feel free to contact me.                                   |
//|-----------------------------------------------------------|

import java.awt.AWTException;
import java.awt.Robot;

int xx = 10, yy = 10;
Robot robby;

void setup()
{
  size(500, 500);
  try
  {
    robby = new Robot();
  }
  catch (AWTException e)
  {
    println("Robot class not supported by your system!");
    exit();
  }
}

void draw()
{
  xx = (xx + 2) % width;
  yy = (yy + 2) % height;
  
  // Might need to confine to sketch's window...
  robby.mouseMove(xx, yy);
}
