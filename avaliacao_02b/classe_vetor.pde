///////////////////////////////////////////////////////// classe Vetor

class Vetor {
  float xcomp;
  float ycomp;

  Vetor(float txcomp, float tycomp) {
    xcomp = txcomp;
    ycomp = tycomp;
  }

  void Display(float xpos, float ypos, color c) {
    stroke(c);
    line(xpos, height-ypos, xpos+xcomp, height-(ypos+ycomp));
    ellipse(xpos+xcomp, height-(ypos+ycomp), 5, 5);
    fill(c);
    text("v(m"+Magnitude()+")", (2*xpos+xcomp)/2, height-(2*ypos+ycomp)/2);
  }

  float Magnitude() {
    return sqrt(xcomp*xcomp+ycomp*ycomp);
  }

  void MultEscalar(float k) {
    xcomp = k * xcomp;
    ycomp = k * ycomp;
  }

  void SomaVetor(Vetor tVetor) {
    xcomp = xcomp + tVetor.xcomp;
    ycomp = ycomp + tVetor.ycomp;
  }

  void SubtraiVetor(Vetor tVetor) {
    xcomp = xcomp - tVetor.xcomp;
    ycomp = ycomp - tVetor.ycomp;
  }

  float ProdutoEscalar(Vetor tVetor) {
    return xcomp * tVetor.xcomp + ycomp * tVetor.ycomp;
  }

  boolean Ortogonal(Vetor tVetor) {
    if (ProdutoEscalar(tVetor)==0) return true;
    else return false;
  }

  void Normalizar() {
    float Mag = Magnitude();
    xcomp = xcomp / Mag;
    ycomp = ycomp / Mag;
  }

  void Limite(float limite) {
    if (Magnitude()>limite)
      Normalizar();
    MultEscalar(limite);
  }

  float AnguloEixoY() {
    // Como a imagem está orientada para o eixo Y, estou pegando o ângulo com o Y
    Vetor versorX = new Vetor(0, 1);
    // como não consigo acessar o próprio vetor dentro da classe, estou criando toda vez um novo vetor com os mesmos atributos do original.
    float prod = ProdutoEscalar(versorX);
    float cosAngulo = prod/( new Vetor(xcomp, - ycomp)).Magnitude();
    return acos(cosAngulo);
  }
}

////////////////////////////////////////////////////////////// funções isoladas

Vetor Subtrai2Vetores(Vetor tVetor1, Vetor tVetor2) {
  Vetor VetorResultado;
  VetorResultado = new Vetor(0, 0);
  VetorResultado.xcomp = tVetor1.xcomp - tVetor2.xcomp;
  VetorResultado.ycomp = tVetor1.ycomp - tVetor2.ycomp;
  return VetorResultado;
}

Vetor rotacao(Vetor tVetor, float angle) {
  // transformação linear de rotação
  return new Vetor(tVetor.xcomp*cos(radians(angle)) - tVetor.ycomp*sin(radians(angle)), (tVetor.xcomp*sin(radians(angle)) + tVetor.ycomp*cos(radians(angle))));
}
/*
void triangleVetor(Vetor position, Vetor v1, Vetor v2, Vetor v3, float angle) {
 v1 = rotacao(v1, angle);
 v2 = rotacao(v2, angle);
 v3 = rotacao(v3, angle);
 triangle(position.xcomp + v1.xcomp, height - (position.ycomp + v1.ycomp), position.xcomp + v2.xcomp, height - (position.ycomp + v2.ycomp), position.xcomp + v3.xcomp, height - (position.ycomp + v3.ycomp));
 }*/
