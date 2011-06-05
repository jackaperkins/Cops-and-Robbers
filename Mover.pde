class Mover {
  float x,y,angle;
  float col;
  float fat;
  String state;
  boolean remove;

  Mover(float xTemp, float yTemp) {
    col =random(255);
    x=xTemp;
    y=yTemp;
    fat=10;
  } 

  void unspin() {
    angle = (angle+TWO_PI)%TWO_PI;
  }

  void go() {
  }

  void move(float speed) {
    x += cos(angle)*speed;
    y += sin(angle)*speed;
  }

  void display() {
    fill(col,200,255);
    rect(x-fat/2,y-fat/2,fat,fat); 
    line(x,y,x+cos(angle)*fat,y+sin(angle)*fat);
  }

  //returns the 'corrected' angle between heading and other
  float difference(Mover other) {
    float a = this.angle;
    float diff = towards(other)-a;
    if(diff>PI) {
      diff -= TWO_PI;
    } 
    else if(diff<-PI) {
      diff += TWO_PI;
    }
    return(diff);
  }

  //returns heading to face other directly
  float towards(Mover other) {
    return( atan2((-this.y+other.y),(-this.x+other.x)));
  }

  float distance(Mover other) {
    return(sqrt(sq(this.x-other.x)+sq(this.y-other.y)));
  }
}

