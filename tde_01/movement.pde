void moveTarget(){
    x = moveX(x);
    y = moveY(x);
}

float moveX(float xP) {
  xP = spawnTargetX(xP); // Returns itself if not a new target; returns spawnpoint if new target.
  xP += speed*xIncrement; // Movement in x
  return xP;
}

float moveY(float xP) {
  float yP = 0;
  switch (typeMovement) {
  case 0: // Linear
    yP = linear(xP);
    break;

  case 1: // Quadratic
    yP = quadratic(xP);
    break;

  case 2: //Cubic
    yP = cubic(xP);
    break;

  case 3: //4th Degree
    yP = forthDegree(xP);
    break;

  case 4: // Inverse
    yP = inverse(xP);
    break;

  case 5: // Wave
    yP = wave(xP);
    break;

  case 6: // Tan
    yP = tangent(xP);
    break;

  case 7: // Exponential 1
    yP = exponentialOne(xP);
    break;

  case 8: // Exponential 2
    yP = exponentialTwo(xP);
    break;

  case 9: // Logarithm
    yP = logarithm(xP);
    break;
  }
  return yP;
}

float spawnTargetX(float xP) {
  // Returns itself if not a new target; returns spawnpoint if new target.
  if (isOOBX()) {
    brokenTarget = false; // New target is not broken.
    int direction = int(random(2)); // 0 - left to right; 1 - right to left.
    typeMovement = int(random(10)); // Which function the target will follow for the movement.
    typeMovement = 0;
    calcParameters(); // Calculate parameters of said functions.
    switch (direction) {
    case 0: // From left to right.
      speed = abs(speed); // Absolute speed used for the cases the target is out of bound not to keep switching sign if it still remains out of bounds.
      xP = xWMin - scaleToWorld(targetRadius)*2; // Spawn on the left.
      break;
    case 1: // From right to left.
      speed = -abs(speed); // Absolute speed used for the cases the target is out of bound not to keep switching sign if it still remains out of bounds.
      xP = xWMax + scaleToWorld(targetRadius)*2; // Spawn on the Right.
      break;
    }
  }
  return xP;
}

boolean isOOBX() {
  // If target position is out of bounds in relation to X world
  return (xS(x) < xVpMin - targetRadius*2 || xS(x) > xVpMax + targetRadius*2) ? true: false;
}

float OOBY() {
  // Returns a garanted out of bound value to y for the target to dissapear.
  return 4*scaleToWorld(targetRadius) + yWMax;
}
