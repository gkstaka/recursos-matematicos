float sinh(float xP) {
  return (exp(xP) - exp(-xP))/2;
}

float cosh(float xP) {
  return (exp(xP) + exp(-xP))/2;
}

int randomSign() {
  return int(pow(-1, round(random(1)))); // Generates a random + or - sign for addition or subtraction.
}

void newWorld(float xMin, float xMax, float yMin, float yMax) {
  // Creates new parameters for the world to fit the function movement call.
  xWMin = xMin;
  xWMax = xMax;
  deltaXW = xWMax - xWMin; // Center of x Axis
  averageXW = (xWMax + xWMin)/2; // lenght of x Axis
  yWMin = yMin;
  yWMax = yMax;
  averageYW = (yWMax + yWMin)/2; // Center of y Axis
  deltaYW = yWMax - yWMin; // lenghe of y Axis
  xIncrement = deltaXW/200; // x will be calculated 200 times for each spawn of target.
  // Average values serve the purpose to guide where values should spawn.
  // Delta values serve the purpose of making a range around the average of the values to spawn.
}

float linear(float xP) {
  // a(x - r1).
  return a*(xP - r1);
}

float quadratic(float xP) {
  // a(x - r1)(x - r2).
  return a*(xP - r1)*(xP -r2);
}

float cubic(float xP) {
  // a(x - r1)(x - r2)(x - r3).
  return a*(xP - r1)*(xP - r2)*(xP - r3);
}

float forthDegree(float xP) {
  // a(x - r1)(x - r2)(x - r3)(x - r4).
  return a*(xP - r1)*(xP - r2)*(xP - r3)*(xP - r4);
}

float inverse(float xP) {
  // a/((x - r1)) + linear coeff.
  return a/(xP - r1) + b;
}

float wave(float xP) {
  // A*sin(freq*"time" - phase) + linear coeff.
  return amp*sin(omega*xP - phase) + b;
}

float tangent(float xP) {
  // A*tan(freq*"time" - phase) + linear coeff
  return amp*tan(omega*xP - phase) + b;
}

float exponentialOne(float xP) {
  // (a*e^(1/t)*(x - x0)) + linear coeff.
  return aExp*exp((1/decayRate)*(xP - expZero)) + b;
}

float exponentialTwo(float xP) {
  // a*(sinh(c*x) +- cosh(d*x)) + b
  return aExp*(sinhCoeff*sinh(xP) + coshCoeff*cosh(xP)) + b;
}

float logarithm(float xP) {
  // a*ln(c*(x - r1)) + b
  // The next if-else block assure the target will not spawn on screen if the return of the function doesn't exist (negative values of ln).
  if (Float.isNaN((aExp*log(logCoeff*(xP - expZero))) + b)) return OOBY(); // Off-screen.
  else return (aExp*log(logCoeff*(xP - expZero))) + b; // On Screen.
}

void calcParameters() {
  float localDeltaXW; // To pass as parameter for the new worlds of each function.

  switch (typeMovement) {
  case 0: // Linear.
    // a(x - r1).
    println("Linear");
    localDeltaXW = 100;
    newWorld(-localDeltaXW/2, localDeltaXW/2, -localDeltaXW/10, localDeltaXW/10);
    a = atan(radians(5))*random(-1, 1); // Max inclination of 5 degrees;
    r1 = averageXW + random(0.1*deltaXW); // Root spawn between 0.4 to 0.6 lenght of the x Axis.
    println(a, r1);
    break;

  case 1: // Quadratic
    // a(x - r1)(x - r2).
    println("Quadratic");
    localDeltaXW = 20;
    newWorld(-localDeltaXW/2, localDeltaXW/2, -pow(1.1*localDeltaXW/2, 2), pow(1.1*localDeltaXW/2, 2));
    r1 = random(averageXW - 0.25*deltaXW, averageXW); // Root #1 between 0.25 to 0.5 lenght of the x Axis.
    r2 = random(averageXW, averageXW + 0.2*deltaXW); // Root #2 between 0.5 to 0.75 lenght of the x Axis.
    a = randomSign()*random(0.5, 4);
    println(a, r1, r2);
    break;

  case 2: //Cubic
    // a(x - r1)(x - r2)(x - r3).
    println("Cubic");
    localDeltaXW = 20;
    newWorld(-localDeltaXW/2, localDeltaXW/2, -pow(1.1*localDeltaXW/2, 3), pow(1.1*localDeltaXW/2, 3));
    r1 = random(averageXW - 0.3*deltaXW, averageXW); // Root #1 between 0.2 to 0.5 lenght of the x Axis.
    r2 = random(averageXW - 0.3*deltaXW, averageXW + 0.3*deltaXW); // Root #2 between 0.2 to 0.8 lenght of the x Axis.
    r3 = random(averageXW, averageXW + 0.3*deltaXW); // Root #3 between 0.5 to 0.8 lenght of the x Axis.
    a = randomSign()*random(0.5, 4);
    println(a, r1, r2, r3);
    break;

  case 3: //4th Degree
    // a(x - r1)(x - r2)(x - r3)(x - r4).
    println("Forth degree");
    localDeltaXW = 20;
    newWorld(-localDeltaXW/2, localDeltaXW/2, -pow(1.1*localDeltaXW/2, 4), pow(1.1*localDeltaXW/2, 4));
    r1 = random(averageXW - 0.45*deltaXW, averageXW - 0.25*deltaXW); // Root #1 between 0.05 to 0.25 lenght of the x Axis.
    r2 = random(averageXW - 0.25*deltaXW, averageXW + 0.1*deltaXW); // Root #2 between 0.25 to 0.6 lenght of the x Axis.
    r3 = random(averageXW - 0.1*deltaXW, averageXW + 0.25*deltaXW); // Root #3 between 0.4 to 0.75 lenght of the x Axis.
    r4 = random(averageXW + 0.25*deltaXW, averageXW + 0.45*deltaXW); // Root 4 between 0.75 to 0.95 lenght of the x Axis.
    a = randomSign()*random(0.5, 4);
    println(a, r1, r2, r3);
    break;

  case 4: // Inverse
    // a/((x - r1)) + linear coeff.
    println("Inverse of x");
    localDeltaXW = 20;
    newWorld(-localDeltaXW/2, localDeltaXW/2, -localDeltaXW/2, localDeltaXW/2);
    r1 = random(-3, 3);
    a = randomSign()*random(10, 16);
    b = averageYW + random(-0.1*deltaYW, 0.1*deltaYW);
    println(a, r1, b);
    break;

  case 5: // Wave
    // A*sin(freq*"time" - phase) + linear coeff.
    // Function already radians radians
    println("Sine/Cosine wave");
    localDeltaXW = 2*PI;
    newWorld(-localDeltaXW/2, localDeltaXW/2, -1, 1);
    amp = randomSign()*random(0.3, 0.6);
    omega = randomSign()*random(0.5, 2.5);
    phase = random(deltaXW);
    b = averageYW + random(-0.1*6, 0.1*deltaYW);
    println(amp, omega, phase, b);
    break;

  case 6: // Tan
    // A*tan(freq*"time" - phase) + linear coeff
    // Function already on radians
    println("Tangent");
    localDeltaXW = PI;
    newWorld(-localDeltaXW/2, localDeltaXW/2, -7, 7);
    amp = randomSign()*random(2, 3);
    omega = randomSign()*random(1.5, 2.5); //
    phase = random(deltaXW);
    b = averageYW + random(-0.1*deltaYW, 0.1*deltaYW);
    println(amp, omega, phase, b);
    break;

  case 7: // Exponential 1
    // (a*e^(1/t)*(x - x0)) + linear coeff.
    println("Simple exponential");
    localDeltaXW = 20;
    newWorld(-localDeltaXW/2, localDeltaXW/2, -localDeltaXW/2, localDeltaXW/2);
    aExp = randomSign()*random(1, 3);
    decayRate = randomSign()*random(1, 3);
    expZero = random(-0.1*deltaXW, 0.1*deltaXW);
    b = averageYW + random(-0.1*deltaYW, 0.1*deltaYW);
    println(decayRate, aExp, expZero, b);
    break;

  case 8: // Exponential 2
    // a*(sinh(c*x) +- cosh(d*x)) + b
    // The coefficient with higher absolute value will most likely dictate the movement of the function.
    println("Hyperbolic harmonic");
    localDeltaXW = 20;
    newWorld(-localDeltaXW/2, localDeltaXW/2, -localDeltaXW/2, localDeltaXW/2);
    aExp = randomSign()*random(0.5, 1);
    sinhCoeff = random(-0.5, 0.5);
    coshCoeff = random(-0.5, 0.5);
    b = averageYW + random(-0.1*deltaYW, 0.1*deltaYW);
    println(aExp, sinhCoeff, coshCoeff, b);
    break;

  case 9: // Logarithm
    // a*ln(c*(x - r1)) + b
    println("Logarithm");
    localDeltaXW = 20;
    newWorld(-localDeltaXW/2, localDeltaXW/2, -localDeltaXW/2, localDeltaXW/2);
    aExp = randomSign()*random(2, 5);
    expZero = averageXW + randomSign()*random(0.2*deltaXW, 0.4*deltaXW);
    // The next if-else block makes sure the target will spend most of the time on screen because ln("negative numbers") don't exist.
    if (expZero < 0) logCoeff = random(0.1, 0.5);
    else logCoeff = -random(0.1, 0.5);
    b = averageYW + random(-0.1*deltaYW, 0.1*deltaYW);
    println(aExp, logCoeff, expZero, b);
    break;
  }
}
