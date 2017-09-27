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
  private Animation anim;

  Player(int hp, int xpos, int ypos){    
    position.set(xpos, ypos);
    hitPoints = hp;
    
    //Add animations to map
    animations.put("fire", new Animation("Cannonball.png", 1, 6));
    animations.put("purple", new Animation("MagicBatDeath.png", 1, 5)); 
    
    //Configure animations
    animations.get("fire").setSpeed(.2);
    animations.get("purple").setSpeed(.2);
    
    anim = animations.get("fire");
  }
  
  public void update(){
    //Movement
    if(dInput) position.x = position.x + moveSpeed;
    if(aInput) position.x = position.x - moveSpeed;
    if(spacebarInput && jumpTimer <= 0) 
      {
        jumpDecay = JUMP_SPEED;
        jumpTimer = JUMP_COOLDOWN;
        gravity = 0;
      }
    //Decay jump
    if(jumpDecay < 0) ++jumpDecay;
    position.y = position.y + jumpDecay;
    --jumpTimer;
    
    //Gravity!
    if(position.y < GROUND_LEVEL) position.y = position.y + gravity;
    ++gravity;
    
    //Toggle animation:
    if(keyPressed == true && key == 'q') anim = animations.get("purple");
    if(keyPressed == true && key == 'e') anim = animations.get("fire");
    
    //Draw player animation
    anim.draw(position.x, position.y); 
  }
}