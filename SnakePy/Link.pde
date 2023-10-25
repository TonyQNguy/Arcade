public class Link {
  float xLoc;
  float yLoc;
 
  public Link(){
    xLoc = random(width);
    yLoc = random(height); 
  }  
  
  void display(){
    fill (0, 255, 0);
    rect(xLoc, yLoc, 20, 20);
  } 
  
  public Link(float x,float y){
    
    xLoc = x;
    yLoc = y;
  }
}
