float x  = -10*PI; 
float y  = 0; 
int cont = 0;

void setup() {
  size(600, 500);
  noStroke();
  background(0);
  frameRate(15);
}
void draw() {
  background(0);
  translate(width/2, height/2);
  x = x + PI/20;
  y = 10*sin(x);

  fill(128);
  ellipse(0,0, x*15, y*15);
  fill(255);
  ellipse(0,0, x*10, y*10);
  fill(0);
  ellipse(0,0, x*5, y*5);
  
  if(cont>400) { x=-10*PI; y=0; cont=0;} 
  cont++;


}
