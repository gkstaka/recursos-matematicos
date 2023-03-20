class Mover {

  Vetor location;
  Vetor velocity;
  Vetor acceleration;
  Vetor direction;
  Vetor target;
  int lastTimeColision;
  float maxSpeed;
  float radius;
  PImage img;
  int type;


  Mover(int tType, float tRadius, PImage tImg, float tMaxSpeed) {
    maxSpeed = tMaxSpeed;
    type = tType;
    radius = tRadius;
    img = tImg;
    location = new Vetor(random(0 + radius, width - radius), random(0 + radius, height- radius));
    velocity = new Vetor(random(-2, 2), random(-2, 2));
    direction = new Vetor(0, 0);
    lastTimeColision = millis();
  }

  void update() {
    // Para facilitar a implementaão, o player sempre foi considerado como o alvo da perseguição/fuga
    target = new Vetor(player.position.xcomp, player.position.ycomp);
    if (type == 0) direction = Subtrai2Vetores(target, location); // persegue
    if (type == 1) {
      float distance = 70 + 50*randomGaussian(); // Distancia aleatória com uma distribuição normal com média 70 e desvio padrão de 50
      if (Subtrai2Vetores(location, target).Magnitude() < distance) direction = Subtrai2Vetores(location, target); // foge
      else direction = Subtrai2Vetores(target, location); // persegue
    }
    //direction.Display(location.xcomp, location.ycomp, white);

    //Step 2: Normalize
    direction.Normalizar();

    //Step 3: Scale
    direction.MultEscalar(0.5);

    //Step 4: Accelerate
    acceleration = direction;

    velocity.SomaVetor(acceleration);
    velocity.Limite(maxSpeed);
    location.SomaVetor(velocity);
  }

  void display(boolean rotacao) {
    stroke(0);
    imageMode(CENTER);
    //ellipseMode(RADIUS);
    //ellipse(location.xcomp, height - location.ycomp, radius, radius);

    pushMatrix();
    translate(location.xcomp, height - location.ycomp);
    if (!rotacao) image(img, 0, 0); // se não é para a imagem girar
    else { // se for para a imagem girar e apontar para o jogador
      pushMatrix();
      // se encontra a esquerda ou a direita do "alvo". Isso faz com que a rotação seja positiva (caso de estar a esquerda) ou negativa (caso esteja a direita);
      if (location.xcomp < target.xcomp) rotate(direction.AnguloEixoY());
      if (location.xcomp >= target.xcomp) rotate(-direction.AnguloEixoY());
      image(img, 0, 0);
      popMatrix();
    }
    popMatrix();
  }

  void checkEdges() {
    // Checa se está fora dos limites da tela.
    if (location.xcomp + radius> width) velocity.xcomp = -abs(velocity.xcomp);
    if (location.xcomp - radius< 0)  velocity.xcomp = abs(velocity.xcomp);
    if (location.ycomp + radius > height) velocity.ycomp = -abs(velocity.ycomp);
    if (location.ycomp - radius < 0)  velocity.ycomp = abs(velocity.ycomp);
  }

  boolean colision(Vetor target, float targetRadius, float time) {
    // Testa se o "alvo" (colocado sempre como o player) colidiu com o objeto em questão. Terá um tempo "time" em segundos para atualização para não ser rodado a cada frame que está colidindo.
    float distance = sqrt(pow(location.xcomp - target.xcomp, 2) + pow(location.ycomp - target.ycomp, 2));
    if (distance <= targetRadius + radius && millis() - lastTimeColision > int(time*1000)) {
      lastTimeColision = millis();
      return true;
    }
    return false;
  }
}
