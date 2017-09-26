class Player {  
  private int hitPoints;
  
  private PVector position = new PVector();
  private HashMap<String, Animation> animations = new HashMap<String, Animation>();
  private Animation anim;
  private float moveSpeed = 1;
  private float jumpSpeed = 0;
  private float gravity;
  private int jumpCooldown = 0;
  
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
    //Movement:
    if(keyPressed == true && key == 'd') position.x = position.x + moveSpeed;
    if(keyPressed == true && key == 'a') position.x = position.x - moveSpeed;
    if(keyPressed == true && key == 'w' && jumpCooldown <= 0) 
      {
        jumpSpeed = -20;
        jumpCooldown = 50;
        gravity = 0;
      }
    //Decay jump
    if(jumpSpeed < 0) ++jumpSpeed;
    position.y = position.y + jumpSpeed;
    --jumpCooldown;
    
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