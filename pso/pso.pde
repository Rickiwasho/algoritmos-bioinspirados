
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
}


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
	ellipse(50, 50, 100, 100);
}

void setup(){
	size(1200, 900);
}