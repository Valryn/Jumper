//Jumper by Valryn
boolean aInput;
boolean dInput;
boolean spacebarInput;

PImage levelBackground;
Player player;
static final int GROUND_LEVEL = 280;
void setup(){
  size(640, 480, P2D);
  orientation(LANDSCAPE); 
  frameRate(60);
  smooth(4);
  
  levelBackground = loadImage("Background Level.png");
  player = new Player(100, 320, GROUND_LEVEL);
}

void draw(){
  background(levelBackground);
  player.update();
}

//Catch input
void keyPressed(){
  if(key == 'a' || key == 'A') aInput = true;
  if(key == 'd' || key == 'D') dInput = true;
  if(key == ' ') spacebarInput = true;
}

void keyReleased(){
  if(key == 'a' || key == 'A') aInput = false;
  if(key == 'd' || key == 'D') dInput = false;
  if(key == ' ') spacebarInput = false;
}