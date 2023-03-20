class Mover {
 
  Vetor location;
  Vetor velocity;
  Vetor acceleration;
 
  Mover() {
    location = new Vetor(random(width),random(height));
    velocity = new Vetor(random(-2,2),random(-2,2));
  }
 
 void update() {
 
    Vetor mouse = new Vetor(mouseX,mouseY);
//Step 1: Compute direction, chasing mouse
    Vetor dir = Subtrai2Vetores(mouse,location);
 
//Step 2: Normalize
    dir.Normalizar();
 
//Step 3: Scale
    dir.MultEscalar(0.5);
 
//Step 4: Accelerate
    acceleration = dir;
 
    velocity.SomaVetor(acceleration);
    velocity.Limite(1.9);
    location.SomaVetor(velocity);
 }
  
  void display() {
    stroke(0);
    fill(175);
    ellipse(location.xcomp,location.ycomp,16,16);
  }
 
  void checkEdges() {
    if (location.xcomp > width  || location.xcomp < 0)  velocity.xcomp = velocity.xcomp * (-1);
    if (location.ycomp > height || location.ycomp < 0)  velocity.ycomp = velocity.ycomp * (-1);
  }
}
