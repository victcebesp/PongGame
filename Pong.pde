import processing.sound.*;

int leftStickPosition, rightStickPosition, ballXCoordinate, ballYCoordinate, ballXSpeedDirection, ballYSpeedDirection, ballSize;
int stickWidth, stickHeight, leftPlayerScore, rightPlayerScore, ballXSpeed, ballYSpeed, rightStickSpeed;
SoundFile sound;

void setup() {
  size(500, 500);
  frameRate(60);
  stroke(0);
  fill(0);
  textSize(18);
  
  sound = new SoundFile(this,"bouncing_effect.wav");
  
  stickWidth = 10;
  stickHeight= 100;
  leftPlayerScore = 0;
  rightPlayerScore = 0;
  rightStickPosition = width / 2;
  rightStickSpeed = 7;
  
  ballSize = 40;
  initBall();
}

void draw() {
  
  background(255);
  drawMiddleLine();
  
  updateLeftStickPosition();
  updateRightStickPosition();
 
  drawBall();
  
  drawScores();
}

void drawBall() {
  
  updateBallXSpeedDirection();
  updateBallYSpeedDirection();
  
  ballXCoordinate += ballXSpeed * ballXSpeedDirection;
  ballYCoordinate += ballYSpeed * ballYSpeedDirection;
  
  ellipse(ballXCoordinate, ballYCoordinate, ballSize, ballSize);
}

void updateBallXSpeedDirection() {
  if(ballXCoordinate < ballSize) {
    if (ballYCoordinate <= leftStickPosition + stickHeight + ballSize / 2 && ballYCoordinate >= leftStickPosition - ballSize / 2) {
      ballXSpeedDirection = -ballXSpeedDirection;
      thread("playScoreSound");
    } else {
      rightPlayerScore++;
      initBall();
    }
  } else if (ballXCoordinate > width - ballSize){
    if (ballYCoordinate <= rightStickPosition + stickHeight + ballSize / 2 && ballYCoordinate >= rightStickPosition - ballSize / 2) {
      ballXSpeedDirection = -ballXSpeedDirection;
      thread("playScoreSound");
    } else {
      leftPlayerScore++;
      initBall();
    }
  }
  
}

void updateBallYSpeedDirection() {

  if(ballYCoordinate < ballSize || ballYCoordinate > width - ballSize) {
      ballYSpeedDirection = -ballYSpeedDirection;
  }
  
}

void updateLeftStickPosition() {
  leftStickPosition = mouseY < 10 ? 10 : mouseY > height - stickHeight - 10 ? height - stickHeight - 10 : mouseY;
  rect(10, leftStickPosition, stickWidth, stickHeight);
}

void updateRightStickPosition() {
  
  if (keyPressed) {
    if (key == CODED)
      if (keyCode == UP)
        rightStickPosition = rightStickPosition < 10 ? 
        10 : rightStickPosition > height - stickHeight - 10 ?
        height - stickHeight - 10 : rightStickPosition - rightStickSpeed;
      else if (keyCode==DOWN)
        rightStickPosition = rightStickPosition < 10 ?
        10 : rightStickPosition > height - stickHeight - 10 ?
        height - stickHeight - 10 : rightStickPosition + rightStickSpeed;
  }

  rect(width - stickWidth - 10, rightStickPosition, stickWidth, stickHeight);
}

void drawMiddleLine() {
  for(int i = 0; i < 30; i++)
    rect(width / 2 - 3, i * 20, 6, 12);  
}

void drawScores() {
  text(leftPlayerScore, width/2 - 36, 40) ;
  text(rightPlayerScore, width/2 + 30, 40) ;
}

void initBall() {
  ballXSpeedDirection = random(0, 1) > 0.5 ? 1 : -1;
  ballYSpeedDirection = random(0, 1) > 0.5 ? 1 : -1;
  ballXCoordinate = width / 2;
  ballYCoordinate = height / 2;    
  ballXSpeed = (int) random(3, 7);
  ballYSpeed = (int) random(3, 7);
}

void playScoreSound() {
  sound.play();
}






      
