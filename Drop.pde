class drop{
  
  //x, y: position
  //dist: simulated distance from screen (size of the drop)
  //speed: current drop speed
  //weight: acceleration factor
  float x, y, dist, speed, weight;
  //amount of splashes particles
  int splashlen;
  //amount of dead particales (for clearing)
  int deadcount;
  //flag to show the particles
  boolean show;
  
  //particle array
  splash[] hit;
  
  drop(){
    
    //random position above screen and spread on the x axis
    y = random(-height, -50);
    x = random(width);
    
    //random simulated distance from screen (size of drop)
    dist = random(1, 5);
    
    //starting speed of 0 px/refresh
    speed = 0;
    
    //weight relative to distance (distance illusion)
    weight = dist + random(3);
    
    //amount of dead particles at 0
    deadcount = 0;
    
    //random amount of particles
    splashlen = int(random(10, 20));
    
    //array of particles
    hit = new splash[splashlen];
    //create all particles
    createsplash();
    
  }
  
  
  
  void display(){
    
    //pure blue
    fill(0, 0, 255);
    
    //rectangle with it's own settings
    rect(x, y, dist, dist*3 + speed/5);
    
  }
  
  void update(){
    
    //acceleration
    speed += grav * weight;
    
    //apply acceleration
    y += speed;
    
    //limit the speed to 50 pxs/refresh
    if(speed > 50){
      speed = 50;
    }
    
    //obstacle detection
    boolean contact = false;
    
    for(int i = 0; i < obslen; i++){
      
      //contact function at the obstacle
      if(obs[i].contact(x, y, dist, dist*3)){
        
        //set the global contact flag if the drop hit's any obstacle
        contact = true;
        
      }
      
    }
    
    //kill if contact with obstacle or if out of bounds
    if(y > height || contact){
      
      //creation of particles
      for(int i = 0; i < splashlen; i++){
        
        //particles allowed to be displayed/updated
        show = true;
        
        //create brand new drop
        hit[i] = new splash(x, y, true, speed);
        
      }
      
      //reset amount of dead particles
      deadcount = 0;
      
      //respawn the drop with new settings
      y = random(-200, -50);
      x = random(width);
      dist = random(1, 5);
      speed = 0;
      weight = dist + random(3);
    }
    
    //show, update, and get the amount of dead particles
    if(show){
      for(int i = 0; i < splashlen; i++){
        
        //show current particle
        hit[i].display();
        //update current particle
        hit[i].update();
        
        //increase the amount of dea particles if the current particle is dead
        if(hit[i].dead()){
          
          deadcount++;
          
        }
        
      }
      
      //reset all particles if they are all dead
      if(deadcount >= splashlen){
        
        createsplash();
        
      }
    }
    
    
  }
  
  
  void createsplash(){
    
    for(int i = 0; i < splashlen; i++){
      
      //create new particles
      hit[i] = new splash(x, y, false, 0);
      
    }
    
    //particles not allowed to be displayed/updated
    show = false;
    
  }
  
  
  
}