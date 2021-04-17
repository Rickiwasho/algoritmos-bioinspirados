// Variables globales
int n_particulas = 1000; // número de partículas
Particle[] particles; // arreglo de partículas
int iter = 0; // número de iteraciones
int iter_to_best = 0; // iteraciones necesitadas para encontrar el optimo
float gbest_x, gbest_y; // mejor poscicion global
float gbest = 1000; // mejor fitness global
float w = 0.9; // inercia
// float C1 = 0.3, C2 = 0.3; // factores de aprendizaje. C1: propio; C2: social
float maxv = 0.08; // max velocidad

boolean display_convergence = true ; //true: mostrar grafico de convergencia, false: mostrar puntos

// Clase Particle
class Particle {
  float x, y, fit; //posicion actual y fitness
  float mybest_x, mybest_y; // mejor posicion alcanzada por esta particula
  float mybest; // mejor fitness alcanzado por esta particula
  float vx, vy; // velocidad

  // constructor
  Particle() {
    x = random(-5.12, 5.12); // pto aleatorio en espacio de soluciones
    y = random(-5.12, 5.12);

    mybest_x = x;
    mybest_y = y;
    mybest = rastrigin(x, y);
    float v0_modulo = random(maxv); // generar un modulo para v inicial
    vx = v0_modulo - random(maxv); // una fraccion aleatoria del modulo
    vy = v0_modulo - vx; // el resto del modulo
  }

  void eval() {
    fit = rastrigin(x, y);
    if (fit < mybest) { //actualiza el mejor alcanzado por particula
      mybest = fit;
      mybest_x = x;
      mybest_y  = y;
    }
    if (fit < gbest) { //actualiza mejor pto global
      gbest = fit;
      gbest_x = x;
      gbest_y = y;
      iter_to_best = iter;
      print("Bet fit:", gbest, "\n");
    }
  }

  void display() {
    fill(30, 50); // color interno particulas. Gris semitransparente
    stroke(30, 100); // color borde particulas. Menos transparente

    int radius = 6;
    // convertir (x, y) a pixeles y dibujar:
    ellipse(float2pix_x(x)-radius/2, float2pix_y(y)-radius/2, radius, radius);
  }

  void move() {
    float rho1 = random(0, 0.01);
    float rho2 = random(0, 0.01);

    //actualizar velocidad, formula con inercia (p. 250)
    vx = w * vx + rho1 * (mybest_x - x) + rho2 * (gbest_x - x);
    vy = w * vy + rho1 * (mybest_y - y) + rho2 * (gbest_y - y);

    //limitar velocidad a maxv
    float module = sqrt(vx*vx + vy*vy);
    if (module > maxv) {
      vx = (vx/module) * maxv;
      vy = (vy/module) * maxv;
    }

    // actualizar posicion
    x = x + vx;
    y = y + vy;

    // rebotar en murallas
    if (x > 5.12) {
      vx = -vx;
      x = width; // evita posibilidad de quedar atrapado rebotando infinitamente
    }
    if (x < -5.12) {
      vx = -vx;
      x = 0; // ídem
    }
    if (y > 5.12) {
      vy = -vy;
      y = height; // ídem
    }
    if (y < -5.12) {
      vy = -vy;
      y = 0;  // ídem
    }
  }
}


// Funciones mandatorias
void setup() {
  size(1024, 1024);
  particles = new Particle[n_particulas];
  for (int i = 0; i < n_particulas; i++) {
    particles[i] = new Particle();
  }
}
void draw() {
  if (display_convergence){ //mostrar convergencia
    draw_convergence();
  }
  else { // mostrar puntos
    background(255);
    line(0, 512, 1024, 512);
    line(512, 0, 512, 1024);

    for (int i = 0; i < n_particulas; i++) {
      particles[i].eval();
      particles[i].move();
    }

    for (int i = 0; i < n_particulas; i++) {
      particles[i].display();
    }

    display_best();
  }

  iter++;
}


// Funcion objetivo
float rastrigin(float x, float y) {
  int n = 2; // dimensiones
  float sum = 0;
  sum += x*x - 10*cos(2*PI*x);
  sum += y*y - 10*cos(2*PI*y);
  float result = 10*n + sum;
  return result;
}

// Funciones de utilidad

void display_best() {
  fill(40, 100, 200);
  ellipse(float2pix_x(gbest_x), float2pix_y(gbest_y), 8, 8);

  PFont f = createFont("Ubuntu", 16, true);
  textFont(f,18);
  fill(30, 30, 30, 220);
  text("Best fitness: "+str(gbest)+"\nIter to best: "+str(iter_to_best)+"\nIter: "+str(iter),10,20);
}

// convertir de espacio solucion a pixel correspondiente
int float2pix_x(float x) {
  return floor((x + 5.12) * 100);
}
int float2pix_y(float y) {
  return floor((-y + 5.12) * 100);
}

float prev = 100; // funcion auxiliar para draw_convergence
//funcion para graficar convergencia
void draw_convergence(){

  for (int i = 0; i < n_particulas; i++) {
    particles[i].eval();
    particles[i].move();
  }
  
  int gf_left = 100; //limite izquierdo del grafico
  int gf_down = height-100; //limite inferior del grafico
  int radius = 4; //radio del punto.
  
  line(gf_left, gf_down, width, gf_down); // linea abcisa
  line(gf_left, gf_down, gf_left, 0); // linea ordenada
  
  strokeWeight(4);
  stroke(40, 80, 190);
  
  line(
       (float)gf_left + (iter-1)*6,
       (float)gf_down - prev*200,
       (float)gf_left + iter*6,
       (float)gf_down - gbest*200); 
       
  strokeWeight(2);
  stroke(0);
  
  prev = gbest;
}
