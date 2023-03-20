class Bola {
  Vetor location;
  Vetor velocity;
  Vetor acceleration;
  int lastReset; // Intervalo de tempo que será resetado os parâmetros do objeto bola
  PImage img;
  float radius;

  Bola(float tRadius, PImage tImg) {
    lastReset = millis();
    img = tImg;
    radius = tRadius;
    // Parâmetros randomizados para vetores posição, velocidade e aceleração
    location = new Vetor((width/2) + (width/5)*randomGaussian(), (height/2) + (height/5)*randomGaussian());
    velocity = new Vetor(random(-0.2, 0.2), random(-0.2, 0.2));
    acceleration = new Vetor(random(-0.2, 0.2), random(-0.2, 0.2));
  }

  void update() {
    velocity.SomaVetor(acceleration);
    location.SomaVetor(velocity);

    restartMovement(5); // Reseta o movimento a cada 5 segundos
  }

  void display() {
    //noStroke();
    //ellipseMode(RADIUS);
    //ellipse(location.xcomp, height - location.ycomp, radius, radius);
    imageMode(CENTER);
    image(img, location.xcomp, location.ycomp);
  }

  void checkEdges() {
    // Checa se está fora dos limites da tela
    if (location.xcomp + radius > width) velocity.xcomp = -abs(velocity.xcomp);
    if (location.xcomp - radius < 0)  velocity.xcomp = abs(velocity.xcomp);
    if (location.ycomp + radius > height) velocity.ycomp = -abs(velocity.ycomp);
    if (location.ycomp - radius < 0)  velocity.ycomp = abs(velocity.ycomp);
  }

  void restartMovement(int time) {
    // função pare resetar movimento a cada "time" segundos com novos parametros para a posição, velocidade e aceleração
    if (millis() - lastReset > time*1000) {
      lastReset = millis();
      location = new Vetor((width/2) + (width/5)*randomGaussian(), (height/2) + (height/5)*randomGaussian());
      velocity = new Vetor(random(-2, 2), random(-2, 2));
      acceleration = new Vetor(random(-0.5, 0.5), random(-0.5, 0.5));
      //gravity = new Vetor(0, random(0.1, 0.4));
    }
  }
  boolean colision(Vetor target, float targetRadius) {
    // Teste de colisão
    float distance = sqrt(pow(location.xcomp - target.xcomp, 2) + pow(location.ycomp - (height - target.ycomp), 2));
    if (distance <= targetRadius + radius) return true;
    else return false;
  }

  void respawnObjects() {
    
    if (bola.colision(enemy.location, enemy.radius)) enemy = new Mover(0, 37, starDestroyer, 0.5);
    if (bola.colision(prize.location, prize.radius)) prize = new Mover(1, 20, rebelSymbol, 0.2);
  }
}
