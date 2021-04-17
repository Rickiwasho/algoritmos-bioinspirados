// Variables globales
int individuals_per_gen = 1000;
int selected_per_tournament = 100;
int tournaments_per_gen = 1000;

Individual[] individuals; //arreglo de individuos, old gen
Individual[] newgen; // arreglo de individuos para nueva gen

int gens = 0; // número de generaciones
int gens_to_best = 0; // generaciones necesitadas para encontrar el optimo
Individual best_ever; // mejor individuo historico

// Clase Individual
class Individual{
    float x, y, fit; //posicion actual y fitness
    Individual(){
      x = random(-5.12, 5.12);
      y = random(-5.12, 5.12);
    }
}

// Funciones mandatorias
void setup(){
    size(1024, 1024);

    individuals = new Individual[individuals_per_gen];
    newgen = new Individual[individuals_per_gen];

    for (int i = 0; i < n_particulas; i++) {
      individuals[i] = new Individual();
    }
}

void draw(){
  for (int i = 0; i < individuals_per_gen ; i++){
    Individual[i].fit = rastrigin(Individual[i].x, Individual[i].y);
  }

  // Arreglo que guardará seleccionados aleatoriamente para cada torneo
  Individual[] selected_random  = new Individual[selected_per_tournament]; // se actualiza cada torneo

  Individual[] winners = new Individual[tournaments_per_gen];

  for (int i = 0; i < tournaments_per_gen; i++ ){ //crea tournaments_per_gen torneos
    int best_in_tournament = -1; //indice del mejor del torneo
    for (int j = 0; j < selected_per_tournament; j++){ // Crea un torneo con selected_per_tournament individuos
      selected[j] = individuals[random(individuals_per_gen)];

      if (selected[j].fit > best_in_tournament){
        best_in_tournament = j;
      }
    }
    winners[i] = individuals[best_in_tournament];
  } // fin torneo




    
    
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

Individual cruzar_A(Individual padre, Individual madre){
  Individual hijo = new Individual();
  hijo.x = padre.x;
  hijo.y = madre.y;

  return hijo;
}

Individual cruzar_B(Individual padre, Individual madre){
  Individual hijo = new Individual();
  hijo.x = madre.x;
  hijo.y = padre.y;

  return hijo;
}

void display_best() {
}

// convertir de espacio solucion a pixel correspondiente
int float2pix_x(float x) {
  return floor((x + 5.12) * 100);
}
int float2pix_y(float y) {
  return floor((-y + 5.12) * 100);
}