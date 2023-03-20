//// variables
Vector ballPosition, ballSpeed, barPosition, barSpeed, barNormal;
color white = #FFFFFF, red =  #FF0000, green = #00FF00, blue = #0000FF, cyan = #00FFFF, magenta = #FF00FF, yellow = #FFFF00;
float barWidth, barHeight, ballRadius;
color barColor, ballColor;
float maxSpeed = 5;


void drawBar(color clr) {
  fill(clr);
  rectMode(CENTER);
  rect(barPosition.x, height - barPosition.y, barWidth, barHeight);
}

void drawBall(color clr) {
  fill(clr);
  ellipseMode(RADIUS);
  circle(ballPosition.x, height - ballPosition.y, ballRadius);
  fill(0);
}

void drawGrid() {
  int spacing = 50;
  stroke(50);
  fill(50);
  for (int i = 0; i <= width; i += spacing) {
    fill(50);
    line(i, 0, i, height);
    fill(150);
    //text(i, 0, height - i);
  }
  for (int i = 0; i <= height; i += spacing) {
    fill(50);
    line(0, i, width, i);
    fill(150);
    //text(i, i, height);
  }
  noStroke();
}

//// start
void setup() {
  size(800, 600);
  background(0);
  ballPosition = new Vector(width/3, height/2);
  ballSpeed = new Vector(0, 0);
  maxSpeed = 5;
  barPosition = new Vector(700, height/2);
  barSpeed = new Vector(0, 4);
  barWidth = 10;
  barHeight = 100;
  ballRadius = 5;
  barNormal = new Vector(1, 0);
  ballColor = white;
  barColor = blue;
}

void draw() {
  background(0);
  drawGrid();
  isBallOOB(); // If ball hits the edge of the screen.
  isBarOOB(); // If the bar is offscreen.
  bounceBall(); // When the ball hits the bar.
  ballPosition.addVector(ballSpeed); // Ball Movement.
  barPosition.addVector(barSpeed); // Bar Movement.
  drawBall(ballColor);
  drawBar(barColor);
}

void keyPressed() {
  // Move according to the arrow keys (max 5 units of speed for one direction).
  if (keyCode == UP && ballSpeed.y < 5) ballSpeed.addVector(new Vector(0, 0.5));
  if (keyCode == DOWN && ballSpeed.y > -5) ballSpeed.addVector(new Vector(0, -0.5));
  if (keyCode == LEFT && ballSpeed.x > -5) ballSpeed.addVector(new Vector(-0.5, 0));
  if (keyCode == RIGHT && ballSpeed.x < 5) ballSpeed.addVector(new Vector(0.5, 0));
  // Stops ball.
  if (key == 'S' || key == 's') {
    ballSpeed.x = 0;
    ballSpeed.y = 0;
  };
}

void isBallOOB() {
  // If ball hits the edge of the screen, changes speed vector to the opposite sign from where it hit (x speed if it hits y, y speed if it hits x).
  if (ballPosition.x < 0) ballSpeed.x = abs(ballSpeed.x);
  if (ballPosition.x > width) ballSpeed.x = -abs(ballSpeed.x);
  if (ballPosition.y < 0) ballSpeed.y = abs(ballSpeed.y);
  if (ballPosition.y > height) ballSpeed.y = -abs(ballSpeed.y);
}

void isBarOOB() {
  // Simply to loop the bar on screen.
  if (barPosition.y - barHeight/2 > height)
    barPosition.y = - barHeight/2;
}

void bounceBall() {
  // If test if the ball tries to overlap with the bar
  if (barPosition.x - barWidth/2 <= ballPosition.x + ballRadius  && ballPosition.x - ballRadius <= barPosition.x + barWidth/2 && barPosition.y - barHeight/2 <= ballPosition.y + ballRadius && ballPosition.y - ballRadius <= barPosition.y + barHeight/2) {
    Vector newDirection; // New direction will be the point where the ball hit in relation to the bar - sharper angles when the ball hits farther points from the center of the bar.
    newDirection = subtractVector(ballPosition, barPosition); // Direction of the movement the ball will follow after bouncing.
    newDirection.normalizeVector(); // Normalize the value so just the direction is given.
    ballSpeed = scalarProduct(newDirection, ballSpeed.magnetude()); // New speed of the ball will be the direction given from the bounce and the magnetude it already had - it'll maintain the absolute speed of the ball.
    // Change color of the ball and the bar after a hit.
    barColor = color(random (128, 255), random(128, 255), random(128, 255)); 
    ballColor = color(random (128, 255), random(128, 255), random(128, 255));
  }
}
