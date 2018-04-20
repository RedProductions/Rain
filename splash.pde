class splash{
  
  //x, y: position
  //speedx, speedy: current speed on axis
  float x, y, speedx, speedy;
  
  //flag to be displayed
  boolean show;
  
  splash(float nx, float ny, boolean nshow, float nspeed){
    
    //starting position at the drop's position
    x = nx;
    y = ny;
    
    //random speed on the x axis (can go either left or right)
    speedx = random(nspeed * -0.2, nspeed * 0.2);
    
    //random speed on the y axis (can only go up)
    speedy = random(nspeed * -0.2, nspeed * -0.6);
    
    //flag to be shown
    show = nshow;
    
  }
  
  
  void display(){
    
    //only display if allowed
    if(show){
      
      //pure blue
      fill(0, 0, 250);
      
      //ellipse with it's own settings
      ellipse(x, y, 3, 3);
      
    }
    
  }
  
  
  void update(){
    
    //only update if allowed
    if(show){
      
      //x speed doesn't change (no air resistance)
      //x += (-0.05 * x) //air resistance if needed (adds -5% of the drop's speed to itself)
      
      //add acceleration
      x += speedx;
      
      //acceleration of the drop vertically
      speedy += grav * 2;
      
      //acceleration of the drop
      y += speedy;
      
    }
    
  }
  
  
  
  boolean dead(){
    
    //detect contact of an obstacle
    boolean contact = false;
    
    for(int i = 0; i < obslen; i++){
      
      //collision function in obstacle class
      if(obs[i].contact(x, y, 3, 3)){
        
        //global hit flag to true if it hits any obstalce
        contact = true;
        
      }
      
    }
    
    //return if contact with obstacle or if out of bounds
    if(y > height || contact){
      return true;
    }else {
      return false;
    }
    
  }
  
}