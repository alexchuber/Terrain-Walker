class HexagonWalker extends Walker
{
  
  //Constructor
  HexagonWalker() {}
  
  //Copy constructor
  HexagonWalker(Walker w) {
    super(w);
  }

  PVector UpdatePos(PVector relative)
  {
      float distance = (sqrt(3)*(float)stepsize) * stepscale;
      float theta;
      
      int choice = int(random(0,6));
      if (choice == 0)
        theta = PI/6;
      else if (choice == 1)
        theta = 3*PI/6;
      else if (choice == 2)
        theta = 5*PI/6;
      else if (choice == 3)
        theta = 7*PI/6;
      else if (choice == 4)
        theta = 9*PI/6;
      else
        theta = 11*PI/6;
      
      PVector newpos = new PVector(relative.x + (distance*cos(theta)), relative.y + (distance*sin(theta)));
      return newpos;
  }
  
  void DrawShape(PVector p, color c)
  {
    if(hasStroke)
      stroke(0);
    else
      noStroke();
    fill(c);
    
    beginShape();
      vertex((p.x + (stepsize*cos(0))), (p.y + (stepsize*sin(0))));
      vertex(p.x + (stepsize*cos(PI/3)), p.y + (stepsize*sin(PI/3)));
      vertex(p.x + (stepsize*cos(2*PI/3)), p.y + (stepsize*sin(2*PI/3)));
      vertex(p.x + (stepsize*cos(3*PI/3)), p.y + (stepsize*sin(3*PI/3)));
      vertex(p.x + (stepsize*cos(4*PI/3)), p.y + (stepsize*sin(4*PI/3)));
      vertex(p.x + (stepsize*cos(5*PI/3)), p.y + (stepsize*sin(5*PI/3)));
    endShape();
  }
  
  void Draw()
  {
    for(int i = 0; i < steprate; i++)
    {
      if(stepcount >= maxsteps)
      {
        Stop();
        break;
      }
      //generate and set position -- reroll if necessary
      PVector newpos = UpdatePos(currentpos);
      while(hasConstraint && !(newpos.x + stepsize < width && newpos.x - stepsize > 200 && newpos.y + (sqrt(3)*stepsize/2.0f) < height && newpos.y - (sqrt(3)*stepsize/2.0f) > 0))
        newpos = UpdatePos(currentpos);
      currentpos = newpos;
      
      //update map
      PVector hexcoord = CartesianToHex(currentpos.x, currentpos.y, stepsize, stepscale, 600.f, 400.f);
      if(steps.containsKey(hexcoord))
      {
        Integer updatedcount = Integer.valueOf(steps.get(hexcoord) + 1);
        steps.replace(hexcoord, updatedcount);
      }
      else
      {
        steps.put(hexcoord, Integer.valueOf(1));
      }
      
      //get color
      int fillcolor = color(160, 32, 240);
      if(hasColor)
      {
        if(steps.get(hexcoord) < 4)
          fillcolor = color(160,126,84);
        else if(steps.get(hexcoord) < 7)
          fillcolor = color(143,170,64);
        else if(steps.get(hexcoord) < 10)
          fillcolor = color(135,135,135);
        else
          {
            int c = steps.get(hexcoord) * 20;
            c = (c > 255) ? 255 : c;
            fillcolor = color(c,c,c);
          }
      }
      
      //draw the thing lol
      DrawShape(currentpos, fillcolor);
      stepcount++;
    }
  }
}
