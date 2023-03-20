int branco=#FFFFFF, vermelho=#FF0000, azul=#0000FF, amarelo=#FFFF00;

Vetor local, velocidade, gravidade, mouse, origem;

void setup() {
  size(640,360);
  local = new Vetor(10,10);
  velocidade = new Vetor(8,18);
  gravidade = new Vetor(0,-0.5);
  origem = new Vetor(10,10); // origem do tiro
  mouse = new Vetor(mouseX, height-mouseY);
}

void draw() {
  background(0); stroke(255);
  
  velocidade.Display(0,0, branco);
  
  velocidade.SomaVetor(gravidade);
  local.SomaVetor(velocidade);
  
  if (local.ycomp < 0) {  // testa só a colisão com o chão
    velocidade.ycomp = velocidade.ycomp * -1;
  }
  
  ellipse(local.xcomp,height-local.ycomp,16,16); // invertendo o eixo y
}

void mousePressed(){
  setup(); // reinicia tudo
  
  mouse.SubtraiVetor(origem);
  mouse.Normalizar();
  mouse.MultEscalar(18);  
  velocidade = mouse;
}
