void showUI() {
  textSize(20);
  fill(0);
  textAlign(LEFT);
  showBullets();
  showCartridge();
  showScore();
  reloadingText();
  drawAim();
}

void showBullets() {
  text("Bullets: " + bullets, 10, height - 10);
}

void showCartridge() {
  text("Cartridge: " + cartridge, 10, height - 30);
}

void showScore() {
  text("Score: " + score, 10, height - 50);
}

void reloadingText() {
  if (flagInEvent) {
    textAlign(CENTER);
    textSize(16);
    fill(0);
    text("Reloading gun", width/2, 80);
  }
}

// Draws the aim at pointer of mouse.
void drawAim() {
  ellipseMode(CENTER);
  noStroke();
  fill(0);
  circle(mouseX, mouseY, 5); // Central circle.
  float radius = 10;
  int numCirc = 20;
  for (int i = 0; i < numCirc; i++) {
    // Outer Circunference dots
    circle(mouseX + radius*cos(radians((i*360/numCirc))), mouseY + radius*sin(radians(((i*360/numCirc)))), 2);
  }
  stroke(0);
  strokeWeight(1);
  for (int i = 0; i < 4; i++) {
    // Line aim assist to centralize
    line(mouseX + (radius - 3)*cos(radians(i*360/4)), mouseY + (radius - 3)*sin(radians(i*360/4)), mouseX + (radius + 3)*cos(radians(i*360/4)), mouseY + (radius + 3)*sin(radians(i*360/4)));
  }
  noStroke();
}
