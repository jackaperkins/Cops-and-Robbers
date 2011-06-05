class Treasure extends Mover {
  Treasure(float xx, float yy) {
    super(xx,yy); 
    fat=20;
    col=40;
  }

  void display() {
    fill(col,255,255,60);
    noStroke();
    ellipse(x,y,entities.PATROL_SIZE*2,entities.PATROL_SIZE*2);
    fill(col,255,220);
    ellipseMode(CENTER);
    ellipse(x,y,fat,fat); 
    noFill();
    if(entities.DEBUG) {
      ellipse(x,y,entities.PATROL_SIZE*2,entities.PATROL_SIZE*2);
    }
  }
}

