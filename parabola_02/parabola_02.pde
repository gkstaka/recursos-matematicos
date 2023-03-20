float x  = -100; 
float y  = 0; 
int cont = 0;

void setup() {
  size(600, 600);
  noStroke();
  background(0);
}
void draw() {
  translate(width/2, height); // Translada origem para o centro da borda inferior da janela
  x++;
  y=-0.05*pow(x,2);
  fill(random(255), random(255), random(255));
  ellipse(x,y, 10, 10);
  if(cont>200) { x=-100; y=0; cont=0;}  // 200 x (de -100 a +100)
  cont++;
  println(x, y);
}
