import controlP5.*;

//Initializing objects
ControlP5 cp5;
Walker walker;
SquareWalker squarewalker;
HexagonWalker hexagonwalker;


void setup() {
  rectMode(CENTER);
  size(1600, 900);
  background(115,155,205);
  
  //Instantiating objects
  cp5 = new ControlP5(this);
  walker = new SquareWalker();
  
  //Creating UI elements
  cp5.addButton("Start")
    .setPosition(10,10)
    .setSize(125,40)
    .setColorBackground(color(1,125,30))
    .getCaptionLabel()
    .setSize(16);
    
  cp5.addDropdownList("SetShape")
    .setId(69)
    .setPosition(10,60)
    .setSize(175,150)
    .addItem("Squares",0)
    .addItem("Hexagons",1)
    .setBarHeight(50)
    .setItemHeight(50)
    .close();   
    
  cp5.addTextlabel("Maximum Steps")
    .setPosition(10, 250)
    .get()
    .setText("Maximum Steps")
    .setSize(11);
  cp5.addSlider("SetMaxSteps")
    .setPosition(10, 262)
    .setSize(180, 25)
    .setRange(100, 50000)
    .getCaptionLabel()
    .setVisible(false);
    
  cp5.addTextlabel("Step Rate")
    .setPosition(10, 300)
    .get()
    .setText("Step Rate")
    .setSize(11);
  cp5.addSlider("SetStepRate")
    .setPosition(10, 312)
    .setSize(180, 25)
    .setRange(1, 1000)
    .getCaptionLabel()
    .setVisible(false);
    
  cp5.addTextlabel("Step Size")
    .setPosition(10, 400)
    .get()
    .setText("Step Size")
    .setSize(11);
  cp5.addSlider("SetStepSize")
    .setPosition(10, 412)
    .setSize(90, 25)
    .setRange(10, 30)
    .getCaptionLabel()
    .setVisible(false);

  cp5.addTextlabel("Step Scale")
    .setPosition(10, 450)
    .get()
    .setText("Step Scale")
    .setSize(11);
  cp5.addSlider("SetStepScale")
    .setPosition(10, 462)
    .setSize(90, 25)
    .setRange(1.0f, 1.5f)
    .getCaptionLabel()
    .setVisible(false);
    
    
  cp5.addToggle("ToggleConstraint")
    .setPosition(10, 550)
    .setSize(25,25)
    .getCaptionLabel()
    .setText("Constrain Steps")
    .setSize(11);
    
  cp5.addToggle("ToggleTerrain")
    .setPosition(10, 600)
    .setSize(25,25)
    .getCaptionLabel()
    .setText("Simulate Terrain")
    .setSize(11);
    
  cp5.addToggle("ToggleStroke")
    .setPosition(10, 650)
    .setSize(25,25)
    .getCaptionLabel()
    .setText("Use Stroke")
    .setSize(11);
    
  cp5.addToggle("ToggleSeed")
    .setPosition(10, 700)
    .setSize(25,25)
    .getCaptionLabel()
    .setText("Use Random Seed")
    .setSize(11);

cp5.addTextfield("SetSeed")
    .setPosition(125, 700)
    .setSize(50,25)
    .setText("0")
    .setInputFilter(ControlP5.INTEGER)
    .setAutoClear(false)
    .getCaptionLabel()
    .setText("Seed Value")
    .setSize(11);
}



void draw()
{
  fill(128,128,128);
  rect(0,0,400,1800);
  
  if(walker.isRunning())
      walker.Draw();
}



//UI Event Handlers
public void Start()
{
  walker.Start();
}
  
public void SetMaxSteps(int s)
{
  walker.SetMaxSteps(s);
}
  
  
public void SetStepRate(int r)
{
  walker.SetStepRate(r);
}
  
public void SetStepSize(int s)
{
  walker.SetStepSize(s);
}

public void SetStepScale(float s)
{
  walker.SetStepScale(s);
}

public void ToggleConstraint()
{
  walker.ToggleConstraint();
}

public void ToggleTerrain()
{
  walker.ToggleTerrain();
}

public void ToggleStroke()
{
  walker.ToggleStroke();
}

public void ToggleSeed()
{
  walker.ToggleSeed();
}

public void controlEvent(ControlEvent theEvent)
{
  if(theEvent.getId() == 69)
  {
    if(int(theEvent.getController().getValue()) == 0)
      walker = new SquareWalker(walker);
    else
      walker = new HexagonWalker(walker);
  }
}
