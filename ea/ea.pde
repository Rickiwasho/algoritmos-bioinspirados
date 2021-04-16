// Variables globales
individuals_per_gen = 100;
Individual[] individuals;
int gens = 0; // número de generaciones
int gens_to_best = 0; // generaciones necesitadas para encontrar el optimo
float gbest_x, gbest_y; // mejor poscicion global
float gbest = 1000; // mejor fitness global

// Clase Individual
class Individual{
    float x, y, fit; //posicion actual y fitness
}

// Funciones mandatorias
void setup(){
    size(1024, 1024);
}

void draw(){
    
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
}

// convertir de espacio solucion a pixel correspondiente
int float2pix_x(float x) {
  return floor((x + 5.12) * 100);
}
int float2pix_y(float y) {
  return floor((-y + 5.12) * 100);
}