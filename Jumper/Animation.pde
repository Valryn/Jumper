class Animation{
  private ArrayList<PImage> animationFrames = new ArrayList<PImage>();
  private int currentFrame = 0;
  private float speed = 1;
  private float frameFractional;
  
  //Slices entire animation sheet by rows and columns
  Animation(String filePath, int rowCount, int columnCount){
    PImage animationSheet = loadImage(filePath);
    int frameW = animationSheet.width / columnCount;
    int frameH = animationSheet.height / rowCount;
    
    //Extract frames from animation sheet
    for(int row = 0; row < rowCount; ++row) {
      for(int column = 0; column < columnCount; ++column){
        PImage frameToAdd = extractFrame(animationSheet, frameW, frameH, row, column);
        animationFrames.add(frameToAdd);
      }
    }
  }
  
   //Slices one row of an animation sheet given number of rows and columns
   Animation(String filePath, int rowCount, int columnCount, int row){
    PImage animationSheet = loadImage(filePath);
    int frameW = animationSheet.width / columnCount;
    int frameH = animationSheet.height / rowCount;
    
    //Extract frames from animation sheet
    for(int column = 0; column < columnCount; ++column){
      animationFrames.add(extractFrame(animationSheet, frameW, frameH, row - 1, column));
    }
  }
  
  //Slices one frame of an animation sheet and loads it as an animation
  Animation(String filePath, int rowCount, int columnCount, int row, int column){
    PImage animationSheet = loadImage(filePath);
    int frameW = animationSheet.width / columnCount;
    int frameH = animationSheet.height / rowCount;
   
    //Extract frame from animation sheet
    animationFrames.add(extractFrame(animationSheet, frameW, frameH, row - 1, column - 1));   
  }
  
  //Draws the current frame
  public void draw(float x, float y){      
    PImage displayFrame;
    
    //Loop animation
    if(currentFrame > animationFrames.size() - 1)
    {
      currentFrame = 0;
      frameFractional = 0;
    }
    
    //Display the image
    displayFrame = animationFrames.get(currentFrame);
    
    image(animationFrames.get(currentFrame), x, y);
    
    //Increment to next frame
    frameFractional = frameFractional + speed;
    currentFrame = (int)frameFractional;
  }
  
  //Draw the current frame but takes a PVector
  public void draw(PVector position){
    draw(position.x, position.y);
  }
  
  //Grab 1 frame from an image
  private PImage extractFrame(PImage img, int frameW, int frameH, int frameRow, int frameColumn){
    //Find pixel location of frame to extract
    int framePosX = frameW * frameColumn;
    int framePosY = frameH * frameRow;
    //Get frame
    PImage frame = img.get(framePosX, framePosY, frameW, frameH);
    return frame;
  }

  public int getFrameIndex(){
    return currentFrame;
  }
  
  public PImage getFrame(int frameIndex){
    return animationFrames.get(frameIndex);
  }
  
  public void setSpeed(float speed){
    this.speed = speed;
  }
}