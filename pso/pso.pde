// --- Variables globales ----------
int n_particulas = 100; //número de partículas
Particle[] particles; //arreglo de particulas
int evals = 0, evals_to_best = 0; //número de evaluaciones y evaluaciones necesitadas para encontrar un optimo
float gbest_x, gbest_y; //mejor poscicion y fitness global
float w = 1000; // inercia: baja (~50): explotación, alta (~5000): exploración (2000 ok)
float C1 = 30, C2 =  10; // learning factors (C1: own, C2: social) (ok)
float maxv = 3; // max velocidad (modulo)
float gbest = 57.84945;

// --------------------------------

class Particle{
  float x, y, fit; // current position(x-vector)  and fitness (x-fitness)
  float mybest_x, mybest_y, mybest_fit; // mejor valor alcanzado por esta particula
  float vx, vy; //velocidad

  Particle(){
    x = random(width);  //hay que hacer mapeo
    y = random(height); //de estas variables, lo ideal seria poner el 0,0 en el centro

    mybest_x = transform_x(x); 
    mybest_y = transform_y(y);
    mybest_fit = rastrigin(transform_x(x), transform_y(y));
    vx = random(-1,1);
    vy = random(-1,1);
  }

  void Eval (){ //evaluar la funcion en el punto
    evals++;
    fit = rastrigin(transform_x(x),transform_y(y));
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
    //return fit; //retorna el fitness
  }
  void display(){
    fill(30, 50);
    stroke(30, 100);
    int radius = 6;
    ellipse(x-radius/2, y-radius/2, radius, radius);
  }
    void move(){
    //actualiza velocidad (fórmula con factores de aprendizaje C1 y C2)
    //vx = vx + random(0,1)*C1*(mybest_x - x) + random(0,1)*C2*(gbest_x - x);
    //vy = vy + random(0,1)*C1*(mybest_y - y) + random(0,1)*C2*(gbest_y - y);
    //actualiza velocidad (fórmula con inercia, p.250)
    vx = w * vx + random(0,1)*(mybest_x - x) + random(0,1)*(gbest_x - x);
    vy = w * vy + random(0,1)*(mybest_y - y) + random(0,1)*(gbest_y - y);
    //actualiza velocidad (fórmula mezclada)  
    //vx = w * vx + random(0,1)*C1*(mybest_x - x) + random(0,1)*C2*(gbest_x - x);
    //vy = w * vy + random(0,1)*C1*(mybest_y - y) + random(0,1)*C2*(gbest_y - y);
    // trunca velocidad a maxv
    float modu = sqrt(vx*vx + vy*vy);
    if (modu > maxv){
      vx = vx/modu*maxv;
      vy = vy/modu*maxv;
    }
    // update position
    x = x + vx;
    y = y + vy;
    // rebota en murallas
    if (x > width || x < 0) vx = - vx;
    if (y > height || y < 0) vy = - vy;
  }
}
// ------------------------------
// funcion Rastrigin
float rastrigin(float x, float y){
  int n = 2; // dimensiones
  float sum = 0;
  // sumatoria
  //for (int i=1; i<=n; i++){ 
  // sum += x*x - 10*cos(2*PI*x); // sumando dos veces la componente x, no suma y
  //}
  sum += x*x - 10*cos(2*PI*x);
  sum += y*y - 10*cos(2*PI*y);
  float result = 10*n + sum;
  return result;
}

float detransform_x(float x){
  return (x+5.12)*100;
}

float detransform_y(float y){
  return -1*(y-5.12)*100;
}

float transform_x(float x){
  return (x/100)-5.12;
}

float transform_y(float y){
  return -1*((y/100)-5.12);
}

void despliegaBest(){
  fill(#0000ff);
  ellipse(gbest_x,gbest_y,15,15);
  PFont f = createFont("Arial",16,true);
  textFont(f,15);
  fill(#00ff00);
  text("Best fitness: "+str(gbest)+"\nEvals to best: "+str(evals_to_best)+"\nEvals: "+str(evals),10,20);
}
void setup(){
  size(1024, 1024);
  particles = new Particle[n_particulas];
  for (int i = 0; i < n_particulas; i++){
    particles[i] = new Particle();
  }
  print(rastrigin(5.12,5.12)); // para comprobar si funciona bien la funcion
}

void draw(){
  background(255);
  line(0,512,1024,512);
  line(512,0,512,1024);
  for (int i = 0; i < n_particulas; i++){
    particles[i].display();
  }
  despliegaBest();
  for(int i = 0;i<n_particulas;i++){
    particles[i].Eval();
    particles[i].move();
  }
  
}
