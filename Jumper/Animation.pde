class Animation {
  private ArrayList<PImage> animationFrames = new ArrayList<PImage>();
  private int currentFrame = 0;
  private float scale = 1;
  private float speed = 1;
  private boolean flipx = false;
  private float frameFractional;
  
  //Slices entire animation sheet by rows and columns
  Animation(String filePath, int rowCount, int columnCount){
    //TODO: Try/catch if animation sheet doesn't divide evenly
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
    //TODO: Try/catch if animation sheet doesn't divide evenly
    PImage animationSheet = loadImage(filePath);
    int frameW = animationSheet.width / columnCount;
    int frameH = animationSheet.height / rowCount;
    
    //Extract frames from animation sheet
    for(int column = 0; column < columnCount; ++column){
      animationFrames.add(extractFrame(animationSheet, frameW, frameH, row, column));
    }
  }
  
  //Draws the current frame
  public void draw(float x, float y){   
    //Loop animation
    if(currentFrame > animationFrames.size() - 1){
      currentFrame = 0;
      frameFractional = 0;
    }
    //Display the image
    image(animationFrames.get(currentFrame), x, y);
   
    //Increment to next frame
    frameFractional = frameFractional + speed;
    currentFrame = (int)frameFractional;
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
  
  //public float getScale(){
  //  return scale;
  //}
  
  //public void setScale(float scale){  
  //this.scale = scale;  
  //}
  
  public void setSpeed(float speed){
    this.speed = speed;
  }
}