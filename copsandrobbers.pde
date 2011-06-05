import processing.opengl.*;

Entities entities;

void setup() {
  size(800,600); 
  colorMode(HSB);
  entities = new Entities();

  entities.initialize();
}

void draw() {
  translate(width/2,height/2);


  Cop test = new Cop(0,0);
  float distance =  test.distance(entities.furthestRobber(test));
  scale(map(distance,0,width,1,0.5));
 
    background(255);
    entities.go();
  entities.display();
}

void mousePressed() {
  entities.initialize();
}

