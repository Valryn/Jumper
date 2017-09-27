class Player {  
  private final int JUMP_COOLDOWN = 30;
  private final int JUMP_SPEED = -20;
  
  private int hitPoints;
  private float moveSpeed = 3;
  private float jumpDecay = 0;
  private int jumpTimer = 0;
  private float gravity;

  
  private PVector position = new PVector();
  private HashMap<String, Animation> animations = new HashMap<String, Animation>();
  private Animation animState;

  Player(int hp, int xpos, int ypos){    
    position.set(xpos, ypos);
    hitPoints = hp;
    
    //Add animations to map
    animations.put("stand", new Animation("DragonWalk.png", 1, 6, 1, 1));
    animations.put("walk", new Animation("DragonWalk.png", 1, 6, 1));
    
    //Configure animations
    animations.get("walk").setSpeed(.15);
    
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
      jumpDecay = JUMP_SPEED;
      jumpTimer = JUMP_COOLDOWN;
      gravity = 0;
    }
      
    //Decay jump
    if(jumpDecay < 0) 
      ++jumpDecay;
    position.y = position.y + jumpDecay;
    --jumpTimer;
    
    //Gravity!
    if(position.y < GROUND_LEVEL)
      position.y = position.y + gravity;
    ++gravity;
  
    //Animate
    animState = (dInput || aInput) ? animations.get("walk") : animations.get("stand");
    animState.draw(position.x, position.y); 
  }
}