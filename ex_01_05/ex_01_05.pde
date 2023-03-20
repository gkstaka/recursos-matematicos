import peasy.*;
PeasyCam cam;

color [][][]cube;


void setup() {
  size(600, 600, P3D);
  cam = new PeasyCam(this, 1000);
  cam.setMinimumDistance(200);
  cam.setMaximumDistance(2000);
  cube = new color[50][50][50];
  for (int i = 0; i < 50; i++) {
    for (int j = 0; j < 50; j++) {
      for (int k = 0; k < 50; k++) {
        cube[i][j][k] = color(random(255), random(255), random(255));
      }
    }
  }
}

void draw() {
  background(0);
  for (int i = 0; i < 50; i++) {
    for (int j = 0; j < 50; j++) {
      for (int k = 0; k < 50; k++) {
        stroke(cube[i][j][k]);
        point(i*10, j*10, k*10);
      }
    }
  }
}
