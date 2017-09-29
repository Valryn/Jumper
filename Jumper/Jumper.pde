//Jumper by Valryn

final float GRAVITY_ACCELERATION = 0.5f;
final int GROUND_LEVEL = 301;

boolean aInput;
boolean dInput;
boolean spacebarInput;
boolean paused;

ArrayList<Collider> solidColliders = new ArrayList<Collider>();
Collider levelCollider;
PImage levelBackground;
Player player;

void setup(){
  size(640, 480, P2D);
  orientation(LANDSCAPE); 
  frameRate(60);
  smooth(4);
  
  levelBackground = loadImage("Background Level.png");
  //Create level collider
  levelCollider = new Collider(320, 480, 640, 480 - GROUND_LEVEL, true);
  solidColliders.add(levelCollider);
  player = new Player(320, GROUND_LEVEL - 100);
}

void draw(){
  
  if(!paused){
    background(levelBackground);
    levelCollider.drawDebug();
    player.update();

  }
}

//Catch input
void keyPressed(){
  if(key == 'a' || key == 'A'){
    aInput = true;
    player.faceForward(false);
  }
  if(key == 'd' || key == 'D'){
    dInput = true;
    player.faceForward(true);
  }
  if(key == ' ') 
    spacebarInput = true;
  if(key == 'p' || key == 'P')
    paused = !paused;
}

void keyReleased(){
  if(key == 'a' || key == 'A') 
    aInput = false;
  if(key == 'd' || key == 'D') 
    dInput = false;
  if(key == ' ') 
    spacebarInput = false;
}