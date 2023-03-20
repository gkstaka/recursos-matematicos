import peasy.*;
PeasyCam cam;

color [][][]image3D;
Vertex v1, v2, v3, v4, v5, v6, v7, v8;

// Vertex class
class Vertex {
  float x;
  float y;
  float z;

  Vertex(float tX, float tY, float tZ) {
    x = tX;
    y = tY;
    z = tZ;
  }

  // Displays the coordinates of the vertex
  void display() {
    text(String.format("(%.0f, %.0f, %.0f)", x, y, z), x, y, z);
  }
}


void drawEdges() {
  // Draws the edges of the cube
  stroke(255);
  strokeWeight(3);
  drawLine(v1, v2);
  drawLine(v1, v3);
  drawLine(v1, v4);
  drawLine(v2, v5);
  drawLine(v2, v6);
  drawLine(v3, v5);
  drawLine(v3, v7);
  drawLine(v4, v6);
  drawLine(v4, v7);
  drawLine(v8, v5);
  drawLine(v8, v6);
  drawLine(v8, v7);
}

void drawLine(Vertex vtx1, Vertex vtx2) {
  // Draw a single line connecting vertex 1 to vertex 2
  line(vtx1.x, vtx1.y, vtx1.z, vtx2.x, vtx2.y, vtx2.z);
}
void setup() {
  size(500, 500, P3D);
  cam = new PeasyCam(this, 1000);
  cam.setMinimumDistance(20);
  cam.setMaximumDistance(2000);

  // Initializes the matrix
  image3D = new color[50][50][50];
  for (int i = 0; i < 50; i++) {
    for (int j = 0; j < 50; j++) {
      for (int k = 0; k < 50; k++) {
        image3D[i][j][k] = color(random(255), random(255), random(255));
      }
    }
  }
  // Defining the vertices of the cube
  v1 = new Vertex(0, 0, 0);
  v2 = new Vertex(0, 0, 500);
  v3 = new Vertex(0, 500, 0);
  v4 = new Vertex(500, 0, 0);
  v5 = new Vertex(0, 500, 500);
  v6 = new Vertex(500, 0, 500);
  v7 = new Vertex(500, 500, 0);
  v8 = new Vertex(500, 500, 500);
}

void draw() {
  pushMatrix();
  translate(-250, -250, -250); // Puts origin at center of the cube
  background(0);
  drawEdges();

  strokeWeight(1);
  textSize(30);
  // Couldn't find a way to make the text to always follow the camera movement
  v1.display();
  v2.display();
  v3.display();
  v4.display();
  v5.display();
  v6.display();
  v7.display();
  v8.display();

  // Draws the cube
  for (int i = 0; i < 50; i++) {
    for (int j = 0; j < 50; j++) {
      for (int k = 0; k < 50; k++) {
        stroke(image3D[i][j][k]);
        point(i*10, j*10, k*10);
      }
    }
  }
  popMatrix();
}
