// Libraries
import processing.sound.*; // Modules -> Sound (The Processing Foundation).

// Variables.
// Sound files.
SoundFile shot, broke_target;

// World Parameters.
float xWMin, xWMax, yWMin, yWMax;
float deltaXW, deltaYW, averageXW, averageYW;

// Viewport Parameters.
float xVpMin, xVpMax, yVpMin, yVpMax;
float deltaXVp, deltaYVp, averageXVp, averageYVp;

// Position of target on World.
float x, y;
float xIncrement = 1;
// X speed of target on World.
float speed;

// Function parameters.
// Linear Coefficient.
float b;
// Polynomial parameters.
float a; // Constant multiplier.
float r1, r2, r3, r4; // Roots.
// Wave Parameters.
//--Amplitude, Frequency, Phase--.
float amp, omega, phase;
// Exponential parameters.
//--Multiplier, Decay Rate, root/zero of function, sinh multiplier, cosh multiplier, log multiplier.
float aExp, decayRate, expZero, sinhCoeff, coshCoeff, logCoeff;

// Movement.
int typeMovement = 0; // Decides which function the target will follow the movement (from 0 to 9)

// Target.
float targetRadius = 40; // Target Size.
boolean brokenTarget = false; // Flag if target has been hit.

// UI.
int score, bullets, cartridge;

// Time/Events
int lastTimeEvent = millis();
boolean flagInEvent = false;

boolean flagInGame = true; // Is playing game flag.

// Coordinate transformation.
// x coordinates.
int xS(float xW) {
  float xScale = (xVpMax - xVpMin)/(xWMax - xWMin);
  return int(xScale*(xW - xWMin) + xVpMin);
}
// y coordinates.
int yS(float yW) {
  float yScale = (yVpMax - yVpMin)/(yWMax - yWMin);
  return height - int(yScale*(yW - yWMin) + yVpMin);
}
// Scale a viewport object to the current world
int scaleToWorld(float dimension) {
  float scale = 1/((xVpMax - xVpMin)/(xWMax - xWMin));
  return int(scale*(dimension));
}

// Draws a red and white target.
void drawTarget(int xP, int yP) {
  stroke(0);
  strokeWeight(1);
  fill(#FF0000);
  ellipseMode(RADIUS);
  // Concentric circles
  circle(xP, yP, targetRadius);
  fill(255);
  circle(xP, yP, (4*targetRadius)/5);
  fill(#FF0000);
  circle(xP, yP, (3*targetRadius)/5);
  fill(255);
  circle(xP, yP, (2*targetRadius)/5);
  fill(#FF0000);
  circle(xP, yP, (1*targetRadius)/5);
  noStroke();
}

// If you have hit the target. More points earned the closer you hit the center.
int hasHitTarget() {
  int points = 0;
  if (brokenTarget == false) { // If target has not been hit before.
    float distance = sqrt(pow(xS(x) - mouseX, 2) + pow(yS(y) - mouseY, 2)); // Distance from center of target to the aim.
    // The greater the distance to the center of the target, the less points you gain from hitting the target.
    if (distance <= (1*targetRadius)/5) points = 5;
    else if ((1*targetRadius)/5 < distance && distance <= (2*targetRadius)/5) points = 4;
    else if ((2*targetRadius)/5 < distance && distance <= (3*targetRadius)/5) points = 3;
    else if ((3*targetRadius)/5 < distance && distance <= (4*targetRadius)/5) points = 2;
    else if ((4*targetRadius)/5 < distance && distance <= targetRadius) points = 1;
    if (points != 0) { // If target was hit, play sound and set flag target was hit.
      broke_target.play(random(0.8, 1.2), 1);
      brokenTarget = true;
    }
  }
  return points;
}

// Reload the gun
void reloadGun() {
  int deltaTime = 3000; // Time to finish reloading
  if (flagInEvent == false) {
    flagInEvent = true; // Flag that reloading is occuring
    lastTimeEvent = millis(); // Start of reload
  }
  if (cartridge > 0 && millis() - lastTimeEvent > deltaTime) {
    flagInEvent = false; // End of reload
    bullets = 7;
    cartridge--;
  }
}

// Shoots a projectile.
void shootTarget() {
  if (bullets > 0) {
    shot.play(random(0.8, 1.2), 0.5); // Play sounds for shooting.
    score += hasHitTarget(); // Increase total score if hit target.
    bullets--; 
  }
}

void oneTimeEventStart(int time) {
  // Message at start of game to inform the player - lasts <time> seconds.
  fill(0);
  if (millis() < time*1000) {
    textSize(30);
    textAlign(CENTER);
    text("Press \"R\" if you wish to restart.", width/2, 40);
  }
}


void setup() {
  size(720, 540);
  // World and Viewport setup.
  xWMin = -180;
  xWMax = 180;
  deltaXW = xWMax - xWMin;
  yWMin = -deltaXW * 3/8;
  yWMax = deltaXW * 3/8;
  deltaYW = yWMax - yWMin;
  averageXW = (xWMax + xWMin)/2;
  averageYW = (yWMax + yWMin)/2;
  xVpMin = 0;
  xVpMax = width;
  yVpMin = 0;
  yVpMax = height;
  x = xWMax + scaleToWorld(targetRadius);
  y = (yWMax + yWMin)/2;

  // Sound setup.
  broke_target = new SoundFile(this, "broke_target.aiff");
  shot = new SoundFile(this, "shot.aiff");

  // UI and game mech setup.
  score = 0;
  bullets = 7;
  cartridge = 3;

  // Target movement setup.
  speed = 1;
  xIncrement = 1;

  loop();
}


void draw() {
  flagInGame = (boolean(bullets) || boolean(cartridge)); // Game is occuring
  if (flagInGame) {
    drawScenary();
    moveTarget();
    if (!brokenTarget) drawTarget(xS(x), yS(y)); // Draw target if it was not hit before.
    showUI();
    oneTimeEventStart(5); // Show text for restart at the beginning for 5 seconds.
    if (bullets == 0) reloadGun();
  } else { // End of game.
    noLoop(); // Stop iterating.
    drawScenary(); // Draw scenary one last time.
    // Text to restart game.
    textSize(50);
    fill(0);
    textAlign(CENTER);
    text("Press \"R\" to restart.", width/2, height/2);
    showUI();
  }
}


void mousePressed() {
  if (flagInGame) shootTarget();
}

void keyPressed() {
  if (key == 'R' || key == 'r') {
    println("Restarted");
    setup();
  }
}
