//// class
class Vector {
  //// attributes
  float x;
  float y;

  //// constructor
  Vector(float xComp, float yComp) {
    x = xComp;
    y = yComp;
  }
  Vector(Vector self) {
    x = self.x;
    y = self.y;
  }

  //// methods
  void display(float xOrigin, float yOrigin, color clr) {
    stroke(clr);
    line(xOrigin, height - yOrigin, xOrigin + x, height - (yOrigin + y));
    ellipse(xOrigin + x, height - (yOrigin + y), 5, 5);
    fill(clr);
    text("v(m" + magnetude( ) + ")", (2*xOrigin + x)/2, height - (2*yOrigin + y)/2);
  }

  float magnetude() {
    return sqrt(pow(x, 2) + pow(y, 2));
  }

  void scalarProduct(float k) {
    x = x * k;
    y = y * k;
  }

  void addVector(Vector vectorB) {
    x += vectorB.x;
    y += vectorB.y;
  }

  void subtractVector(Vector vectorB) {
    // returns vector BA
    x -= vectorB.x;
    y -= vectorB.y;
  }

  float dotProduct(Vector vectorB) {
    return (x*vectorB.x + y*vectorB.y);
  }

  boolean isOrthogonal(Vector vectorB) {
    if (dotProduct(vectorB) == 0) {
      return true;
    } else {
      return false;
    }
  }

  void normalizeVector() {
    float absVector = magnetude();
    x = x/absVector;
    y = y/absVector;
  }
  
  
}
