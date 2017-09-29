class Collider{
  private int height;
  private int width;
  private boolean isSolid;
  
  private PVector lowLeft = new PVector();
  private PVector upRight = new PVector();
  private PVector position = new PVector();
  Collider( int x, int y, int w, int h, boolean solid){
    position.x = x;
    position.y = y;
    
    lowLeft.x = position.x - 0.5*w;
    lowLeft.y = position.y;
    upRight.x = position.x + 0.5*w;
    upRight.y = position.y - h;
    
    width = w;
    height = h;
    isSolid = solid;
  }
  
  Collider(PVector position, int w, int h, boolean solid){
    this((int)position.x, (int)position.y, w, h, solid);
  }
  
  public void move(int x, int y){
    position.x = position.x + x;
    position.y = position.y + y;
    
    lowLeft.x = lowLeft.x + x;
    lowLeft.y = lowLeft.y + y;
    upRight.x = upRight.x + x;
    upRight.y = upRight.y + y;
  }
  
  public void move(PVector velocity){
    move((int)velocity.x, (int)velocity.y);
  }
  
  public void setPosition(int x, int y){
    position.x = x;
    position.y = y;
    
    lowLeft.x = position.x - 0.5*width;
    lowLeft.y = position.y;
    upRight.x = position.x + 0.5*width;
    upRight.y = position.y - height;
  }
  
  public void setPosition(PVector velocity){
    setPosition((int)velocity.x, (int)velocity.y);
  }
    
  public boolean checkCollision(Collider other){
    
     boolean checkToRight = lowLeft.x > other.upRight.x;
     boolean checkToLeft = upRight.x < other.lowLeft.x;
     boolean checkToUp = lowLeft.y < other.upRight.y;
     boolean checkToDown = upRight.y > other.lowLeft.y;
     
     if(checkToRight || checkToLeft || checkToUp|| checkToDown)
       return false;
     else
       return true;
     
  }
  
  public void drawDebug(){
    rect(lowLeft.x, lowLeft.y, width, -height);
    rect(position.x, position.y, 2, -2);
    rect(lowLeft.x, lowLeft.y, 2, -2);
    rect(upRight.x, upRight.y, 2, -2);
  }
  public boolean isSolid(){
  return isSolid; 
  }
}