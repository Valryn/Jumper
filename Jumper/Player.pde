class Player {  
  private final int JUMP_COOLDOWN = 32;
  private final int JUMP_FORCE = -20;
  
  private final PVector WALK_OFFSET = new PVector(-50, -72);
  private final PVector WALK_LEFT_OFFSET = new PVector(-31, -72);
  private final PVector JUMP_OFFSET = new PVector(-50, -82);
  private final PVector JUMP_LEFT_OFFSET = new PVector(-31, -82);
  
  private int height = 74;
  private int width = 82;
  private float moveSpeed = 3;
  private int jumpArc = 0;
  private int jumpTimer = 0;
  private float gravity;
  private boolean faceForward = true;
  
  private PVector position = new PVector();
  private Collider currentCollider;
  private HashMap<String, Animation> animations = new HashMap<String, Animation>();
  private Animation animState;
  private HashMap<String, Collider> colliders = new HashMap<String, Collider>();
  
  Player(int xpos, int ypos){    
    position.set(xpos, ypos);
    //Create colliders
    colliders.put("walk", new Collider(position, 36, 75, false));
    colliders.put("jump", new Collider(position, 36, 83, false));

    //Load animations
    animations.put("stand", new Animation("DragonWalk.png", 1, 6, 1, 6));
    animations.put("standleft", new Animation("DragonWalkLeft.png", 1, 6, 1, 1));
    animations.put("walk", new Animation("DragonWalk.png", 1, 6, 1));
    animations.put("walkleft", new Animation("DragonWalkLeft.png", 1, 6, 1));
    animations.put("jump", new Animation("DragonJump.png", 1, 1));
    animations.put("jumpleft", new Animation("DragonJumpLeft.png", 1, 1));
    
    //Configure animations
    animations.get("stand").setOffset(WALK_OFFSET);
    animations.get("standleft").setOffset(WALK_LEFT_OFFSET);
    animations.get("walk").setOffset(WALK_OFFSET);   
    animations.get("walkleft").setOffset(WALK_LEFT_OFFSET);
    animations.get("jump").setOffset(JUMP_OFFSET);  
    animations.get("jumpleft").setOffset(JUMP_LEFT_OFFSET);      
       
    animations.get("walk").setSpeed(.15);
    animations.get("walkleft").setSpeed(.15);
    
    //Set defaults
    animState = animations.get("stand");
    currentCollider = colliders.get("walk");
  }
  
  public void update(){
    PlayerInput();
    animate();
    currentCollider.drawDebug();
  }
  
  private void PlayerInput(){
    //Movement
    if(dInput)
      move((int)moveSpeed, 0);
    if(aInput)
      move(-(int)moveSpeed, 0);
      
    //Jump!
    if(spacebarInput && jumpTimer <= 0) 
    {
      jump();
    }
        
    //Decay jump
    if(jumpArc < 0) 
      ++jumpArc;
    move(0, jumpArc);
    --jumpTimer;
    
    //Gravity! 
      move(0, (int)gravity);
      if(position.y < GROUND_LEVEL)
        gravity = gravity + GRAVITY_ACCELERATION;

  }
  
  public void move(int x, int y){
    currentCollider.move(x, y);
    for(Collider other : solidColliders){
      if(!currentCollider.checkCollision(other)){
        position.x = position.x + x;
        position.y = position.y + y;
      }
    }
    currentCollider.setPosition(position);
  }
  
  public void move(PVector velocity){
    move((int)velocity.x, (int)velocity.y); 
  }
  
  private void jump(){
    jumpArc = JUMP_FORCE;
    jumpTimer = JUMP_COOLDOWN;
    gravity = 0;

  }
  private void animate(){
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