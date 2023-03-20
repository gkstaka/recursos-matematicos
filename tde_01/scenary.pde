void drawScenary() {
  drawSky();
  drawClouds();
  drawGrass();
  drawTree();
  drawBush();
}

void drawGrass() {
  color green = #2D9043;
  fill(green);
  // Darker green grass background;
  rect(0, height - 0.2*height, width, 0.2*height);
  int offsetX = 0;
  int offsetY = int(0.04*height);
  // Little patches of light grass on the ground
  color lightGreen = #35BC53;
  fill(lightGreen);
  for (int j = 0; j <= 5*offsetY; j += offsetY) {
    for (int i = 0; i < width; i += 0.1*width) {
      rect(i + offsetX, height - j, width/100, height/100);
    }
    offsetX += 20;
  }
}

void drawTree() {
  colorMode(HSB, 360, 100, 100);
  for (int i = int(0.1*width); i < width; i += int(0.23*width)) { // Amount of trees.
    color brown = color(29, 67, 60);
    fill(brown);
    pushMatrix();
    translate(i, height - 0.2*height); // Position origin to draw trunk.
    rect(0, 0, 0.05*width, -0.4*height); // Tree trunk
    for (int brightness = -5; brightness < 5; brightness++) {
      brown = color(26, 66, 40 + 3*brightness); // Shading the trunk.
      fill(brown);
      rect(5 + brightness, 0, 0.001*width, -0.4*height);
    }
    // Treetop.
    color green = color(107, 67, 50);
    for (int j = 0; j < 2; j++) {
      for (int k = 0; k < 5; k++) {
        green = color(107, 67, 30 + 6*k);
        fill(green);
        // Transformations make a range for the leaves to offset
        pushMatrix();
        translate(0.025*width, -0.4*height);
        pushMatrix();
        rotate(radians(165 + 52*k));
        circle(0.03*width + 0.05*j*width, 0, 0.1*width);
        popMatrix();
        popMatrix();
      }
    }
    popMatrix();
  }
  colorMode(RGB, 255, 255, 255);
}

void drawBush() {
  colorMode(HSB, 360, 100, 100);
  color green = color(107, 70, 40);
  for (int i = int(0.05*width); i < width; i += int(0.17*width)) { // Amount of bushes.
    for (int radius = 2; radius <= 10; radius += 2) { // Concentric origin.
      int brightness = 60 + 3*radius; // Creates a range of shade.
      pushMatrix();
      translate(i, height - 0.15*height);
      for (int degree = 0; degree <= 180; degree += int(180/radius)) { // Distribution of leaves.
        // Transformations make the leaves radiate from a center.
        pushMatrix();
        green = color(107, 70, brightness);
        fill(green);
        rotate(-radians(degree));
        ellipse(radius*0.004*width, 0, 20, 10);
        popMatrix();
        brightness -= 5; // Change Brightness according to the position of the leaves in relation to origin in semi-circle;
      }
      popMatrix();
    }
  }
  colorMode(RGB, 255, 255, 255);
}

void drawSky() {
  colorMode(HSB, 360, 100, 100);
  color blue = color(189, 70, 100);
  float saturation = 70;
  int nShades = 40; // N# of shades for the transition
  float saturationSteps = (100 - saturation)/nShades; // Steps for the shades
  float ySteps = (0.8*height)/nShades;
  for (int shades = 0; shades < nShades; shades++) {
    saturation -= saturationSteps;
    blue = color(189, saturation, 100);
    fill(blue);
    rect(0, height - (0.2*height + shades*ySteps), width, -ySteps);
  }
  colorMode(RGB, 255, 255, 255);
}

void drawClouds() {
  colorMode(HSB, 360, 100, 100);
  color white = color(0, 5, 100);
  float brightness = 90;
  for (int row = 0; row < 4; row++) { // Row of clouds.
    for (int cloudsInRow = 0; cloudsInRow < 5; cloudsInRow++) { // Columns of clouds.
      white = color(0, 5, brightness);
      for (int circleModuleRow = 0; circleModuleRow < 3; circleModuleRow++) { // Row of circles in a cloud.
        for (int circleModuleColumn = 0; circleModuleColumn <= 5; circleModuleColumn++) { // Columns of circles in a cloud.
          pushMatrix();
          brightness = 90 + 3*circleModuleColumn; // Changes the brightness according to the distance of origin of the cloud.
          white = color(0, 5, brightness);
          fill(white);
          translate(0.05*width + 0.25*width*cloudsInRow, 0.05*height + 0.1*height*row); // Origin of the cloud
          circle (0 + 0.015*width*circleModuleColumn + 0.005*height*circleModuleRow + 0.06*width*row, 0 + 0.01*height*circleModuleRow, 0.03*width);
          popMatrix();
        }
        brightness = 90;
      }
    }
  }
  colorMode(RGB, 255, 255, 255);
}
