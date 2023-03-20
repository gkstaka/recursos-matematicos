int N = 100;             // N perseguidores
Mover[] perseguidores;   // declaração do Array de perseguidores
 
void setup() {
  size(640,360);
  perseguidores = new Mover[N]; // inicialização do Array
  for (int i = 0; i<N; i++)     // inicialização de cada instância do Array
    perseguidores[i] = new Mover();
}
 
void draw() {
  background(255);
  for (int i = 0; i<N; i++){ // para todos os perseguidores (todas as instâncias)
  perseguidores[i].update();   // atualização da posição dos perseguidores
  perseguidores[i].display();  // desenho dos perseguidores
  }
}
 
 
 
