// --- Variables globales ----------

int n_particulas = 100; //número de partículas
Particle[] particles; //arreglo de particulas

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
		mybest_fit = evaluate(x, y);

		vx = random(-1,1);
		vy = random(-1,1);
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
float evaluate(float x, float y){
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