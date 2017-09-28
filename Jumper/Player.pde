class Player {  
  private final int JUMP_COOLDOWN = 32;
  private final int JUMP_FORCE = -20;

  private float moveSpeed = 3;
  private float jumpArc = 0;
  private int jumpTimer = 0;
  private float gravity;
  private boolean faceForward = true;
  
  private PVector position = new PVector();
  private HashMap<String, Animation> animations = new HashMap<String, Animation>();
  private Animation animState;

  Player(int xpos, int ypos){    
    position.set(xpos, ypos);
    
    //Load animations
    animations.put("stand", new Animation("DragonWalk.png", 1, 6, 1, 6));
    animations.put("standleft", new Animation("DragonWalkLeft.png", 1, 6, 1, 1));
    animations.put("walk", new Animation("DragonWalk.png", 1, 6, 1));
    animations.put("walkleft", new Animation("DragonWalkLeft.png", 1, 6, 1));
    animations.put("jump", new Animation("DragonJump.png", 1, 1));
    animations.put("jumpleft", new Animation("DragonJumpLeft.png", 1, 1));
    
    //Configure animations
    animations.get("walk").setSpeed(.15);
    animations.get("walkleft").setSpeed(.15);
    animState = animations.get("stand");
  }
  
  public void update(){
    //Movement
    if(dInput)
      position.x = position.x + moveSpeed;
    if(aInput)
      position.x = position.x - moveSpeed;
    if(spacebarInput && jumpTimer <= 0) 
    {
      jumpArc = JUMP_FORCE;
      jumpTimer = JUMP_COOLDOWN;
      gravity = 0;
    }
      
    //Decay jump
    if(jumpArc < 0) 
      ++jumpArc;
    position.y = position.y + jumpArc;
    --jumpTimer;
    
    //Gravity!
    if(position.y < GROUND_LEVEL){
      position.y = position.y + gravity;
      gravity = gravity + GRAVITY_ACCELERATION;
    }
  
    //Animate
    //Walk or stand
    if(faceForward){
      animState = (aInput || dInput) ? animations.get("walk") : animations.get("stand");
    }
    else{
      animState = (aInput || dInput) ? animations.get("walkleft") : animations.get("standleft");
    }
    //Jump
    if(position.y < GROUND_LEVEL)
      animState = (faceForward) ? animations.get("jump") : animations.get("jumpleft");
   
    animState.draw(position); 
  }
  
  public void faceForward(boolean forward){
  faceForward = forward;
  }
}