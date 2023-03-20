float x, y;
int count;
int n = 30;
public class Points {
  float[] x = new float[n];
  float[] y = new float[n];
}

Points points = new Points();

void EllipseTrace(float[] xPosition, float[] yPosition) {
  for (int i = 0; i < n; i++) {
    ellipse(xPosition[i], yPosition[i], 2, 2);
  }
}

void setup() {
  size(400, 400);
  noStroke();
  background(0);
  x = -50;
  y = -0.05*pow(x, 2);
  count = 2*abs(int(x));
  for (int i = 0; i < n; i++) {
    points.x[i] = 0;
    points.y[i] = 0;
  }
}

void draw() {
  translate(width/2, height/2);
  background(0);

  y = -0.05*pow(x, 2);
  points.x[0] = x;
  points.y[0] = y;

  for (int i = n - 1; i > 0; i--) {
    points.x[i] = points.x[i-1];
    points.y[i] = points.y[i-1];
  }
  EllipseTrace(points.x, points.y);

  x++;
  count++;
  if (count >= 100) {
    x = -50;
    count = 0;
  }
}
