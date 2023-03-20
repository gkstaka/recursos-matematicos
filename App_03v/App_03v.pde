int branco=#FFFFFF, vermelho=#FF0000, azul=#0000FF, amarelo=#FFFF00;

Vetor local, velocidade, gravidade, vento;

void setup() {
  size(640,360);
  local = new Vetor(mouseX,height-mouseY);
  velocidade = new Vetor(0,0);
  gravidade = new Vetor(0,0);
  vento = new Vetor(0,0);
}

void draw() {
  background(0);  
  gravidade.SomaVetor(vento);
  velocidade.SomaVetor(gravidade);
  local.SomaVetor(velocidade); 
  if ((local.xcomp > width) || (local.xcomp < 0)) {
    velocidade.xcomp = velocidade.xcomp * -1;
  }
  if ((local.ycomp > height) || (local.ycomp < 0)) {
    velocidade.ycomp = velocidade.ycomp * -1;
  }  
  ellipse(local.xcomp,height-local.ycomp,16,16);
}

void mousePressed(){
  setup(); // reinicia tudo
  velocidade = new Vetor(0,0);
  gravidade = new Vetor(0,-0.5);
  vento = new Vetor(0.01,0);
}
