abstract class Walker
{
  
  //Variables
  PVector currentpos = new PVector(600.f, 400.f);                           //Position of last-drawn step
  HashMap<PVector, Integer> steps = new HashMap<PVector, Integer>();        //Positions of all steps (with count of steps at each position)
  int stepcount = 0;                                                        //Current number of steps drawn
  boolean isRunning = false;
  
  int maxsteps = 100;                                                       //Maximum number of steps to be drawn
  int steprate = 1;                                                         //Number of steps to draw per frame
  int stepsize = 10;                                                        //Size of side (square) or radius (hexagon)
  float stepscale = 1.0f;                                                   //Spacing between each step
    
  boolean hasConstraint = false;
  boolean hasColor = false;
  boolean hasStroke = false;
  boolean hasSeed = false;

  //Constructor
  Walker() {}
  
  //Copy constructor
  Walker(Walker w) {
    this.currentpos = w.currentpos;
    this.steps = w.steps;
    this.stepcount = w.stepcount;
    this.isRunning = w.isRunning;
    
    this.maxsteps = w.maxsteps;
    this.steprate = w.steprate;
    this.stepsize = w.stepsize;
    this.stepscale = w.stepscale;
    
    this.hasConstraint = w.hasConstraint;
    this.hasColor = w.hasColor;
    this.hasStroke = w.hasStroke;
    this.hasSeed = w.hasSeed;
  }
  
  //Accessors
  boolean isRunning()
  {
    return isRunning;
  }

  
  //Modifiers
  void Start()
  {
    Reset();
    if(hasSeed)
      randomSeed(Integer.parseInt(cp5.getController("SetSeed").getValueLabel().getText()));                  //sorry this is so DISGUSTING but it cant be helped
    isRunning = true;
  }
  
  void Stop()
  {
    isRunning = false;
  }
  
  void Reset()
  {
    background(115,155,205);
    stepcount = 0;
    currentpos = new PVector(600.f,400.f);
    steps.clear();
  }
  
  void SetMaxSteps(int s)
  {
    maxsteps = s;
  }
  
  public void SetStepRate(int r)
  {
    steprate = r;
  }
  
  public void SetStepSize(int s)
  {
    stepsize = s;
  }

  void SetStepScale(float s)
  {
    stepscale = s;
  }

  void ToggleConstraint()
  {
    hasConstraint = !hasConstraint;
  }

  void ToggleTerrain()
  {
    hasColor = !hasColor;
  }

  void ToggleStroke()
  {
    hasStroke = !hasStroke;
  }

  void ToggleSeed()
  {
    hasSeed = !hasSeed;
  }
  
  
  //Abstract functions
  abstract PVector UpdatePos(PVector r);
  abstract void DrawShape(PVector p, color c);
  abstract void Draw();

}
