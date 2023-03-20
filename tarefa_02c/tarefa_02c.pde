//libraries

//constants
//world size
float xWorldMin = -500;
float xWorldMax = 500;
float yWorldMin = -100;
float yWorldMax = 100;

//classes
public class Position {//origin of the drawn object
  float x;
  float y;
}
//variables

Position position = new Position();
float x0;

//images
PImage buttonDown;
PImage buttonUp;

//functions
//x coordinates to viewer
float xPView(float xPWorld) {
  float xS = (width)/(xWorldMax - xWorldMin);//scale in X
  float xP = xS * (xPWorld - xWorldMin);//correspondent P point from world to viewer
  return xP;
}
//y coordinates to viewer
float yPView(float yPWorld) {
  float yS = (height)/(yWorldMax - yWorldMin);//scale in Y
  float yP = yS * (yPWorld - yWorldMin);//correspondent P point from world to viewer
  return (height - yP);
}

//draw object
void Circle(float centerX, float centerY, float radius, float invSpacing) {//invSpacing - inverse of spacing - how many "dots" will be drawn
  for (int i = 0; i < invSpacing; i++) {//loop for how many "dots" will be drawn
    ellipse(centerX + radius*cos(radians(360*(1/invSpacing)*i)), centerY + radius*sin(radians(360*(1/invSpacing)*i)), 4, 4);
  }
}

void setup() {
  size(500, 500);
  background(0);
  noStroke();
  x0 = xWorldMin;
  fill(#34FAFF);
  buttonDown = loadImage("button_down.png");
  buttonUp = loadImage("button_up.png");
  image(buttonUp, (width/2) - 40, 440);
}

void draw() {
  position.y = 20*sin(radians(position.x));
  Circle(xPView(position.x), yPView(position.y), 10, 20);
  if (position.x >= xWorldMax) {//boundaries
    position.x = x0;
  } else {
    position.x = position.x + 10;
  }
}

void mousePressed() {
  if ((mouseX >= (width/2) - 40) && (mouseX <= (width/2) + 40) && (mouseY >= 420) && (mouseY <= 460)) {//if within area of button
    image(buttonDown, (width/2) - 40, 440);
    fill(random(0, 255), random(0, 255), random(0, 255));
  }
}

void mouseReleased() {
  image(buttonUp, (width/2) - 40, 440);
}
