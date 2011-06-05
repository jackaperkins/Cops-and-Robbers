class Entities {
  ArrayList cops,robbers,treasures;

  boolean DEBUG;
  float PATROL_SIZE,COP_VISION,COP_WALK_SPEED,COP_RUN_SPEED;
  float ROBBER_VISION, ROBBER_WALK_SPEED, ROBBER_RUN_SPEED;

  void initialize() {
    cops = new ArrayList();
    robbers = new ArrayList();
    treasures = new ArrayList();  
    DEBUG=false;
    PATROL_SIZE = 90;
    COP_VISION = 70;
    COP_WALK_SPEED = 0.7;
    COP_RUN_SPEED = 1.5;

    ROBBER_VISION = 45;
    ROBBER_WALK_SPEED = 0.5;
    ROBBER_RUN_SPEED = 1.7;

    
    int maxy;
    
    maxy = 4+(int)random(2);
   for(int i=0;i<maxy; i++ ){
     float angle = (i/float(maxy))*TWO_PI+random(1/(maxy*2.0))-1/maxy*4.0;
     float len = 100+random(200);
     treasures.add(new Treasure(len*cos(angle),len*sin(angle)));
   }
   
       maxy = 9+(int)random(6);
   for(int i=0;i<maxy; i++ ){
     float angle = (i/float(maxy))*TWO_PI+random(1/(maxy*2.0))-1/maxy*4.0;
     float len = 100+random(200);
     cops.add(new Cop(len*cos(angle),len*sin(angle)));
   }
   
       maxy = 16+(int) random(7);
   for(int i=0;i<maxy; i++ ){
     float angle = (i/float(maxy))*TWO_PI+random(1/(maxy*2.0))-1/maxy*4.0;
     float len = 400+random(300);
     robbers.add(new Robber(len*cos(angle),len*sin(angle)));
   }
  } 

  Robber closestRobber(Mover test) { 
    Robber which = null;
    for(int i=0;i<robbers.size();i++) {
      Robber guy = (Robber) robbers.get(i); 
      if(i==0) {
        which = guy;
      } 
      else {
        if(test.distance(guy)<test.distance(which)) {
          which = guy;
        }
      }
    }
    return(which);
  }

  Robber furthestRobber(Mover test) { 
    Robber which = null;
    for(int i=0;i<robbers.size();i++) {
      Robber guy = (Robber) robbers.get(i); 
      if(i==0) {
        which = guy;
      } 
      else {
        if(test.distance(guy)>test.distance(which)) {
          which = guy;
        }
      }
    }
    return(which);
  }

  Cop closestCop(Mover test) {
    Cop which = null;
    for(int i=0;i<cops.size();i++) {
      Cop guy = (Cop) cops.get(i); 
      if(i==0) {
        if(guy != test){
        which = guy;
        } else {
         which =   (Cop) cops.get(1);
        }
      } 
      else {
        if(test.distance(guy)<test.distance(which) && guy != test ) {
          which = guy;
        }
      }
    }
    return(which);
  }


  Treasure closestTreasure(Mover test) {
    Treasure which = null;
    for(int i=0;i<treasures.size();i++) {
      Treasure guy = (Treasure) treasures.get(i); 
      if(i==0) {
        which = guy;
      } 
      else {
        if(test.distance(guy)<test.distance(which)) {
          which = guy;
        }
      }
    }
    return(which);
  }


  void go() {
    
        for(int i=0;i<treasures.size();i++) {
      Treasure frank = (Treasure) treasures.get(i);
      if(frank.remove){
       treasures.remove(i); 
       if(treasures.size()==0){
        mousePressed(); 
       }
      }
     }
    for(int i=0;i<robbers.size();i++) {
      Robber frank = (Robber) robbers.get(i);
      frank.go();
      
    }
    
     for(int i=0;i<robbers.size();i++) {
      Robber frank = (Robber) robbers.get(i);
      if(frank.remove){
       robbers.remove(i); 
       if(robbers.size()==0){
        mousePressed(); 
       }
      }
     }


 

    for(int i=0;i<cops.size();i++) {
      Cop frank = (Cop) cops.get(i);
      frank.go();
    }
  }


  void display() {
    
    for(int i=0;i<treasures.size();i++) {
      Treasure frank = (Treasure) treasures.get(i);
      frank.display();
    }
    for(int i=0;i<robbers.size();i++) {
      Robber frank = (Robber) robbers.get(i);
      frank.display();
    }

    for(int i=0;i<cops.size();i++) {
      Cop frank = (Cop) cops.get(i);
      frank.display();
    }


  }
  
  
}

