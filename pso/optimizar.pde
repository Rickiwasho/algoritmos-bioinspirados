


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

float evaluate(float x, float y){
	return 0;
}