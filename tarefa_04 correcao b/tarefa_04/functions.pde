//// functions

float magnetude(Vector vector) {
  return sqrt(pow(vector.x, 2) + pow(vector.y, 2));
}

Vector scalarProduct(Vector vector, float k) {
  vector.x *= k;
  vector.y *= k;
  return vector;
}

Vector addVector(Vector vectorA, Vector vectorB) {
  Vector newVector;
  newVector = new Vector(vectorA.x + vectorB.x, vectorA.y + vectorB.y);
  return newVector;
}

Vector subtractVector(Vector vectorA, Vector vectorB) {
  // returns vector BA
  Vector newVector = new Vector(vectorA.x - vectorB.x, vectorA.y - vectorB.y);
  return newVector;
}

float dotProduct(Vector vectorA, Vector vectorB) {
  return (vectorA.x*vectorB.x + vectorA.y*vectorB.y);
}

boolean isOrthogonal(Vector vectorA, Vector vectorB) {
  if (dotProduct(vectorA, vectorB) == 0) {
    return true;
  } else {
    return false;
  }
}
Vector normalizeVector(Vector vector) {
  Vector newVector = new Vector(vector.x/magnetude(vector), vector.y/magnetude(vector));
  return newVector;
}
