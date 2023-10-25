//Tony Nguyen
//Danny helped with my restart button and so the snake doesn't keep on going after it crosses the border
//Charles helped with making the snake eat the apple
//Thank you Mr.McCue for helping me make the game restart when the snake ran over itself
float snakeX;
float snakeY;
int gameover;
float diff;
float appleX;
float appleY;
ArrayList<Link> myChain;

void setup() {
  size(500,500);
  gameover = 0;
  snakeX = width / 2;
  snakeY = height / 2;
  appleX = random(width - 20);
  appleY = random(height - 20);
  diff = appleX % 20;
  appleX = appleX - diff;
  diff = appleY % 20;
  appleY = appleY - diff;
  snakeX = 380;//where the snake spawns on x plane
  snakeY = 100;//when the snake spawns on y plane 
  myChain = new ArrayList<Link>();
  
  for (int x = 0; x > -2; x--) {//sets how much squares that are on the snake
    myChain.add(new Link(x * 20 + 380, 100));
  }
}

void draw() {
  if (gameover == 0){
    background(255);
    boundary();
    apple();
    keypress();
    snake();
    myChain.add(0,new Link(snakeX,snakeY));//adds a link to the front of the chain
    for(int x=0; x<myChain.size(); x++)//sets how much squares that are on the snake
    myChain.get(x).display();
    delay(80);
  }
  else {
    keypress();
  }
}



  
void snake() {
  diff = snakeX%20;//when the snake is on the same coordiantes as the apple, the apple disappears
  snakeX = snakeX-diff;
  diff = snakeY%20;
  snakeY = snakeY-diff;
}

void keypress() {
  if(keyPressed){}
    if(key=='d'){
    snakeX = snakeX + 20;
    }
    if(key=='a'){
    snakeX = snakeX - 20;
    }
  if(key=='s'){
    snakeY = snakeY + 20;
    }
  if(key=='w'){
    snakeY = snakeY - 20;
    }
  if (gameover == 1){
    if(keyPressed){
      if(key=='r'){
        replay();
      }
    }
  }
}


void boundary() {
  //death zone for the snake
  if (snakeX>width || snakeX<0 || snakeY>height || snakeY<0) {
    background(255);
    fill(255, 0, 0);//changes background of end game screen
    textSize(50);//size of text
    text("GAME OVER", 190, 200);//text
    textSize(50);
    text("OOOOF", 200, 250);
    textSize(50);
    text("Press 'r' to restart", 100, 300);
    gameover = 1;
  }
}

void apple() {
  fill(255, 0, 0);//the color of the apple
  rect(appleX, appleY, 20, 20);//the apple
  if(snakeX == appleX && snakeY == appleY){
    appleX = random(width - 20);//makes the apple spawn at a random spot horizontaly
    appleY = random(height - 20);//makes the apple spawn at a random spot vertically
    diff = appleX % 20;//when the apple is on the same coordinates as the snake, the apple disappears
    appleX = appleX - diff;
    diff = appleY % 20;
    appleY=appleY - diff;
  }
  else {
    myChain.remove(myChain.size()-1);
  }
  
  for (int x=1; x < myChain.size(); x++)
    if (snakeX == myChain.get(x).xLoc && snakeY == myChain.get(x).yLoc){
      background(255);
      fill(255, 0, 0);//changes background of end game screen
      textSize(50);//size of text
      text("GAME OVER", 190, 200);//text
      textSize(50);
      text("OOOOF", 200, 250);
      textSize(50);
      text("Press 'r' to restart", 100, 300);
      gameover = 1;
  }  
}

//replays setup and draw when 'r' is pressed
void replay() {
  gameover = 0;
  setup();
  draw();
}



  
  
  
  
