class Player {
  Vetor position;
  Vetor velocity;
  Vetor direction;
  float rotation = 0;
  float speed;
  float radius;
  PImage img;

  Player(float tRadius, PImage tImg) {
    position = new Vetor(width/2, height/2);
    velocity = new Vetor(0, 1);
    speed = 2.5;
    radius = tRadius;
    img = tImg;
    direction = new Vetor(0, 1);
    rotation = 0;
  }
  void display() {
    //Vetor v1 = new Vetor(- 10, -15);
    //Vetor v2 = new Vetor(0, + 15);
    //Vetor v3 = new Vetor(10, - 15);
    //triangleVetor(position, v1, v2, v3, rotation);
    imageMode(CENTER);
    pushMatrix();
    translate (position.xcomp, height - position.ycomp); // coloca a origem na posição do jogador
    pushMatrix();
    rotate(radians(-rotation)); // rotaciona como a imagem será colocada (sinal de menos por causa das confusões de coordenadas do processing
    image(img, 0, 0);
    popMatrix();
    popMatrix();
  }

  void checkEdges() {
    // Checa se está fora dos limites da tela.
    if (position.xcomp - radius < 0) position.xcomp = radius;
    if (position.xcomp + radius > width) position.xcomp = width - radius;
    if (position.ycomp - radius < 0) position.ycomp = radius;
    if (position.ycomp + radius > height) position.ycomp = height - radius;
  }
  void update() {
    if (keyPressed) {
      if (keyCode == UP && keyCode != DOWN && keyCode != LEFT && keyCode != RIGHT) {
        player.position.SomaVetor(velocity);
      }
      if (keyCode == RIGHT && keyCode != DOWN && keyCode != UP && keyCode != LEFT) {
        rotation -= 3;
        player.velocity = rotacao(player.direction, rotation); // Transformação linear aplicada para rotacionar o vetor da velocidade 
      }
      if (keyCode == LEFT && keyCode != DOWN && keyCode != UP && keyCode != RIGHT) {
        rotation += 3;
        player.velocity = rotacao(player.direction, rotation); // Transformação linear aplicada para rotacionar o vetor da velocidade 
      }
    }
    player.velocity.Normalizar();
    player.velocity.MultEscalar(speed);
    //player.velocity.Display(player.position.xcomp, player.position.ycomp, blue);
    //player.position.SomaVetor(velocity);
  }
}
