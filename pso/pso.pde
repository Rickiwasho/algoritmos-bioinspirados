// --- Variables globales ----------

int n_particulas = 100; //número de partículas
Particle[] particles; //arreglo de particulas
int evals = 0, evals_to_best = 0; //número de evaluaciones y evaluaciones necesitadas para encontrar un optimo
float gbest_x, gbest_y, gbest; //mejor poscicion y fitness global
float w = 1000; // inercia: baja (~50): explotación, alta (~5000): exploración (2000 ok)
float C1 = 30, C2 =  10; // learning factors (C1: own, C2: social) (ok)

// --------------------------------

class Particle{
  float x, y, fit; // current position(x-vector)  and fitness (x-fitness)
  float mybest_x, mybest_y, mybest_fit; // mejor valor alcanzado por esta particula
  float vx, vy; //velocidad

  Particle(){
    x = random(width);
    y = random(height);

    mybest_x = x; 
    mybest_y = y;
    mybest_fit = rastrigin(x, y);

    vx = random(-1,1);
    vy = random(-1,1);
  }

  float Eval (float x, float y){ //evaluar la funcion en el punto
    evals++;
    fit = rastrigin(x,y);
    if (fit < mybest_fit){ //actualiza el mejor alcanzado por particula
      mybest_fit = fit;
      mybest_x = x;
      mybest_y  = y;
    }
    if (fit < gbest){ //actualiza mejor poscision global
      gbest = fit;
      gbest_x = x;
      gbest_y = y;
      evals_to_best = evals;
    }
    return fit; //retorna el fitness
  }
  void display(){
    fill(30, 50);
    stroke(30, 100);
    int radius = 6;
    ellipse(x-radius/2, y-radius/2, radius, radius);
  }
}


// ------------------------------

// funcion Rastrigin
float rastrigin(float x, float y){
  int n = 2; // dimensiones
  float sum = 0;

  // sumatoria
  for (int i=1; i<=n; i++){ 
    sum += x*x - 10*cos(2*PI*x);
  }

  float result = 10*n + sum;

  return result;
}

void draw(){
  background(255);
  for (int i = 0; i < n_particulas; i++){
    particles[i].display();
  }
}

void setup(){
  size(900, 900);

  particles = new Particle[n_particulas];
  for (int i = 0; i < n_particulas; i++){
    particles[i] = new Particle();
  }
}
