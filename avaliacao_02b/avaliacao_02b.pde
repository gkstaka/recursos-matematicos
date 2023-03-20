color white = #FFFFFF, red = #FF0000, green = #00FF00, blue = #0000FF, yellow = #FFFF00, lightRed = #F2B3B5;
Player player;
Mover enemy;
Mover prize;
Bola bola;
int score;
int health;
PImage millenium, starDestroyer, deepSpace, rebelSymbol, asteroid;

void setup() {
  size(500, 500);
  textSize(20);
  millenium = loadImage("millenium_falcon.png");
  starDestroyer = loadImage("star_destroyer.png");
  deepSpace = loadImage("deep_space.png");
  rebelSymbol = loadImage("rebel_symbol.png");
  asteroid = loadImage("asteroid.png");
  player = new Player(20, millenium);
  enemy = new Mover(0, 37, starDestroyer, 0.5);
  prize = new Mover(1, 20, rebelSymbol, 0.2);
  bola = new Bola(20, asteroid);
  health = 25;
  score = 0;
  loop();
  textAlign(LEFT);
}

void draw() {
  noStroke();
  imageMode(CORNER);
  image(deepSpace, 0, 0); // background
  // Asteroid
  bola.update();
  bola.checkEdges();
  bola.display();
  bola.respawnObjects(); // Se objeto bola (asteroide) colidiu com o inimigo ou com o prêmio, reiniciará os parâmetros do inimigo/prêmio.
  // Inimigo
  enemy.update();
  enemy.checkEdges();
  enemy.display(true);
  if (enemy.colision(player.position, player.radius, 1)) health--;
  // Prêmio
  prize.update();
  prize.checkEdges();
  prize.display(false);
  if (prize.colision(player.position, player.radius, 0.5)) score++;
  // Jogador
  player.update();
  player.display();
  player.checkEdges();
  // Interface
  fill(255);
  stroke(0);
  text("Score: " + score, 5, 25);
  text("Health: " + health, 5, 50);
  // Condição de derrota
  if (health <= 0) {
    noLoop(); // Para o loop
    fill(255, 0, 0);
    rect(0, 0, width, height);
    fill(255);
    textSize(50);
    textAlign(CENTER);
    text("GAME OVER", width/2, height/2);
    textSize(30);
    text("Pressione \"R\" para reiniciar", width/2, 60 + height/2);
  }
}



void keyPressed() {
  // Reset
  if (key == 'r' || key == 'R') setup();
}
