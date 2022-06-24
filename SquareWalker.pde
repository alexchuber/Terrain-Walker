class SquareWalker extends Walker
{
  
  //Constructor
  SquareWalker() {}
  
  //Copy constructor
  SquareWalker(Walker w) {
    super(w);
  }
  
  PVector UpdatePos(PVector relative)
  {
      PVector newpos = new PVector(currentpos.x, currentpos.y);
      float distance = (float)stepsize * stepscale;
      
      int choice = int(random(0,4));
      if (choice == 0)
        newpos.y = currentpos.y + distance;
      else if (choice == 1)
        newpos.y = currentpos.y - distance;
      else if (choice == 2)
        newpos.x = currentpos.x - distance;
      else
        newpos.x = currentpos.x + distance;
        
      return newpos;
  }
  
  void DrawShape(PVector p, color c)
  {
    if(hasStroke)
      stroke(0);
    else
      noStroke();
    fill(c);
    rect(p.x, p.y, stepsize, stepsize);
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
      //generate new/next position
      PVector newpos = UpdatePos(currentpos);
      while(hasConstraint && !(newpos.x + (stepsize/2) < width && newpos.x - (stepsize/2) > 200 && newpos.y + (stepsize/2) < height && newpos.y - (stepsize/2) > 0))            //Will result in a bit of a border, but whatever lol
        newpos = UpdatePos(currentpos);
      currentpos = newpos;
      
      //update map
      if(steps.containsKey(currentpos))
      {
        Integer updatedcount = Integer.valueOf(steps.get(currentpos) + 1);
        steps.replace(currentpos, updatedcount);
      }
      else
      {
        steps.put(currentpos, Integer.valueOf(1));
      }
      
      //get color
      int fillcolor = color(160, 32, 240);
      if(hasColor)
      {
        if(steps.get(currentpos) < 4)
          fillcolor = color(160,126,84);
        else if(steps.get(currentpos) < 7)
          fillcolor = color(143,170,64);
        else if(steps.get(currentpos) < 10)
          fillcolor = color(135,135,135);
        else
          {
            int c = steps.get(currentpos) * 20;
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
