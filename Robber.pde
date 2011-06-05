class Robber extends Mover {
  int timer;
  int flow;
  boolean stroll; //randomwalk switch

  Robber(float tempX,float tempY) {
    super(tempX,tempY);
    col = 200;
    fat = 14;
    state = "sneaking";
    flow = int(random(200))+100;

    timer = 0;
    /* 
     sneaking - moving around generally
     escaping - fleeing the police
     stealing - bolting for the diamond
     
     ?regrouping - looking for a theif to pair with
     */
  }

  void display() {
    noStroke();
    fill(col,200,255);
    //rect(x-fat/2,y-fat/2,fat,fat); 
    pushMatrix();
    translate(x,y);
    rotate(angle-HALF_PI);
    triangle(-fat/2,-fat/2,fat/2,-fat/2,0,fat);
    popMatrix();

    noFill();
    if(entities.DEBUG) {
      ellipse(x,y,2*entities.ROBBER_VISION,2*entities.ROBBER_VISION);
    }
  }

  void go () {
    if(distance(entities.closestTreasure(this))<30) {
      entities.closestTreasure(this).remove= true;
      col=180;
    }
    unspin();
    if(state=="sneaking") {
      if(timer<1) {
        timer = int(random(50))+30;  
        if(stroll) {
          stroll = false;
        } 
        else {
          stroll = true;
        }
      } 
      else {
        timer -= 1;
      }



      if(stroll) {
        angle += sin(TWO_PI*((frameCount% flow)/float(flow)))*0.05;
        angle += difference(entities.closestTreasure(this))*0.01;
      } 
      else {
        angle += 0.01*(random(1)-0.5);
        angle += difference(entities.closestTreasure(this))*0.06;
      }
      move(entities.ROBBER_WALK_SPEED);

      if(distance(entities.closestCop(this))<entities.ROBBER_VISION) {
        state = "escaping";
      } 
      else if (distance(entities.closestTreasure(this)) < entities.ROBBER_VISION) {
        state="stealing";
      }
    } 
    else if (state=="escaping") {
      if(distance(entities.closestCop(this))<entities.ROBBER_VISION) {
        timer = 60;
      } 
      else {
        timer -=1;
      }

      if(distance(entities.closestCop(this))>distance(entities.closestTreasure(this))) {
        angle -= difference(entities.closestTreasure(this))*0.11;
      } 
      else {
        angle -= difference(entities.closestCop(this))*0.11;
      }

      if(timer < 1) {
        if(distance(entities.closestCop(this))>distance(entities.closestTreasure(this))) {
          state="stealing";
        } 
        else {
          state="sneaking";
        }
      }
      move(entities.ROBBER_RUN_SPEED);
    }
    else if (state=="stealing") {
      angle += difference(entities.closestTreasure(this))*0.21;
      move(entities.ROBBER_RUN_SPEED);
      if(distance(entities.closestCop(this)) < entities.ROBBER_VISION*0.7) {
        state="escaping";
      }
    }
  }
}

