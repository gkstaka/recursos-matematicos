
color red = color(255, 0, 0);
color green = color(0, 255, 0);
color blue = color(0, 0, 255);
color white = color(255, 255, 255);
color yellow = color(255, 255, 0);
color magenta = color(#E859DA);
color purple = color(#8528EA);
color orange = color(#FA962B);

void drawGrid() {
  stroke(50);
  background(0);
  for (int i = 0; i < height; i += 50) {
    line(0, i, width, i);
    line(i, 0, i, height);
  }
}

void drawSegment (float aX, float aY, float bX, float bY, color clr) {
  stroke(clr);
  line(aX, height - aY, bX, height - bY);
  text("A", aX - 10, height - aY);
  text("B", bX + 10, height - bY);
}

void drawVector(float oriX, float oriY, float x1, float y1, color clr) {
  stroke(clr);
  line(oriX, height - oriY, oriX + x1, height - (oriY + y1));
  ellipse(oriX + x1, height - (oriY + y1), 5, 5);
  text("v(" + x1 + ", " + y1 + ")", (2*oriX + x1)/2, height - (2*oriY + y1)/2);
  text("(" + oriX + ", " + oriY + ")", oriX +5, height - oriY);
}

void addVectors(float oriX, float oriY, float x1, float y1, float x2, float y2) {
  drawVector(oriX, oriY, x1, y1, green);
  drawVector(oriX + x1, oriY + y1, x2, y2, blue);
  float x3 = x1 + x2;
  float y3 = y1 + y2;
  drawVector(oriX, oriY, x3, y3, red);
}

void subtractVectorsAB(float oriX, float oriY, float x1, float y1, float x2, float y2) {
  drawVector(oriX, oriY, x1, y1, green);
  drawVector(oriX, oriY, x2, y2, blue);
  float x3 = x2 - x1; // blue - green vectors
  float y3 = y2 - y1; // blue - green vectors
  drawVector(oriX + x1, oriY + y1, x3, y3, red); // AB
}

void subtractVectorsBA(float oriX, float oriY, float x1, float y1, float x2, float y2) {
  drawVector(oriX, oriY, x1, y1, green);
  drawVector(oriX, oriY, x2, y2, blue);
  float x3 = x1 - x2; // green - blue vectors
  float y3 = y1 - y2; // green - blue vectors
  drawVector(oriX + x2, oriY + y2, x3, y3, red); // BA
}

void multVecScl(float oriX, float oriY, float x1, float y1, float scalar) {
  float x2, y2;
  strokeWeight(4);
  drawVector(oriX, oriY, x1, y1, white);
  x2 = scalar * x1;
  y2 = scalar * y1;
  strokeWeight(1);
  drawVector(oriX, oriY, x2, y2, yellow);
}

void angleDotProduct(float oriX, float oriY, float x1, float y1, float x2, float y2) {
  float dotProduct = x1*x2 + y1*y2;
  float absVector1 = sqrt(pow(x1, 2) + pow(y1, 2));
  float absVector2 = sqrt(pow(x2, 2) + pow(y2, 2));
  float angle = degrees(acos(dotProduct/(absVector1*absVector2)));
  text(round(angle) + "°", 1.05*oriX, height - 1.9*oriY);
  drawVector(oriX, oriY, x1, y1, green);
  drawVector(oriX, oriY, x2, y2, blue);
}

void setup() {
  size(800, 800);
  background(0);
}

void draw() {
  drawGrid();
  drawSegment(700, 650, 600, 750, blue);
  drawSegment(600, 750, 550, 550, red);
  drawSegment(550, 550, 700, 650, yellow);

  drawVector(550, 50, 50, 200, red);
  drawVector(550, 50, 50, 50, white);
  drawVector(600, 100, 150, 50, blue);

  addVectors(250, 700, -100, 50, -50, -50);
  addVectors(50, 650, 50, -50, 0, -50);

  subtractVectorsBA(50, 50, 100, 200, 150, 50);
  subtractVectorsAB(50, 300, 0, 200, 200, 0);

  multVecScl(300, 400, 75, 100, 2);
  multVecScl(350, 350, 50, 25, 4);
  
  angleDotProduct(300, 50, 0, 200, 150, 250);
}
