class Cop extends Mover {
  Cop(float tempX,float tempY) {
    super(tempX,tempY);
    col = 20;
    fat = 15;
    state = "patrol";

    /* 
     patrol - walking around
     chasing - actively persuing target criminal
     retreating - returning to closest treasure
     */
  }

  void display() {
    fill(col,200,255);
    rect(x-fat/2,y-fat/2,fat,fat); 
    line(x,y,x+cos(angle+0.2)*fat*2,y+sin(angle+0.2)*fat*2);
        line(x,y,x+cos(angle-0.2)*fat*2,y+sin(angle-0.2)*fat*2);
    noFill();
    if(entities.DEBUG) {
      ellipse(x,y,entities.COP_VISION*2,entities.COP_VISION*2);
    }
  }

  void go() {
    if(distance(entities.closestRobber(this))<15) {
      entities.closestRobber(this).remove = true;
      col=0;
    }
    unspin();
    if(distance(entities.closestCop(this))<fat*1.5) {
      angle -= 0.05*difference(entities.closestCop(this));
    }
    if(state=="patrol") {
      if(distance(entities.closestTreasure(this))<30) {
        angle -= difference(entities.closestTreasure(this))*0.1;
      }

      if(distance(entities.closestRobber(this))<entities.COP_VISION) {
        state ="chasing";
      }

      if(distance(entities.closestTreasure(this))>entities.PATROL_SIZE) {

        angle += difference(entities.closestTreasure(this))*0.03;
          move(entities.COP_RUN_SPEED);
      } 
      else {
        angle += random(0.25)-0.125;
          move(entities.COP_WALK_SPEED);
      }

    
    } 
    else if (state=="chasing") {
      if(distance(entities.closestRobber(this))>entities.COP_VISION || distance(entities.closestTreasure(this))>entities.PATROL_SIZE*1.2) {
        state = "patrol";
      }
      angle += difference(entities.closestRobber(this))*0.1;
      move(entities.COP_RUN_SPEED);
    }


    unspin();
  }
}

