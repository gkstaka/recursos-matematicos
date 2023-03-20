float colorR = 0, colorG = 0, colorB = 0;
int i = 0;

//parametros(origem x, origem y, comprimento da base, altura do triangulo
void TriRect(float xOrigin, float yOrigin, float widthTri, float heightTri) {
  PVector p1 = new PVector (xOrigin, yOrigin); //ponto 1
  PVector p2 = new PVector (xOrigin + widthTri, yOrigin); //ponto 2
  PVector p3 = new PVector (xOrigin, yOrigin + heightTri); //ponto 3
  //criacao do triangulo com os pontos p1, p2, p3
  triangle(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y);
}



void setup() {
  size(400, 400);
  background(255);
  stroke(0);
}

void draw () {
  //brincadeira mudando a cor do fundo
  float period = 0.1; // periodicidade de mudanca de cor
  colorR = 225 + 30*sin(period*radians(millis()));
  colorG = 225 + 30*sin(1.1*period*radians(millis()) + radians(120)); //defasagem inicial de 120 e periodo 10% mais rapido para desincronizar
  colorB = 225 + 30*sin(1.2*period*radians(millis()) + radians(240)); //defasagem inicial de 240 e periodo 20% mais rapido para desincronizar
  background(colorR, colorG, colorB);

  //parametrizacao dos valores de base e altura do triangulo - valores devem ser 0< t <1
  float t = 0.5 + 0.5*sin(radians(i));
  i++;
  //triangulo origem canto superior esquerdo
  fill(#FF922B);
  TriRect(0, 0, width*t, width*(1-t));

  //triangulo origem canto superior direito
  fill(#DE4AFF);
  TriRect(width, 0, -width*(1-t), width*t);

  //triangulo origem canto inferior direito
  fill(#A9FF30);
  TriRect(width, height, -width*t, -width*(1-t));

  //triangulo origem canto inferior esquerdo
  fill(#3DD6FF);
  TriRect(0, height, width*(1-t), -width*t);
}
