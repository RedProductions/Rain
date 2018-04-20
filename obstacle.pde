class obstacle{
  
  //x, y: position
  //sx, sy: axis size
  float x, y, sx, sy;
  
  //amount of blue (0 - 255)
  float blue;
  
  //index in the array
  int index;
  
  obstacle(int i){
    
    //spread on the totality of the canvas
    x = random(width);
    y = random(height);
    
    //random width
    sx = random(20, 300);
    //set height
    //sy = random(60, 150);
    sy = 60;
    
    //starting with no blue
    blue = 0;
    
    //his index in the array
    index = i;
    
  }
  
  
  void show(){
    
    //obstacle lowers according to it's weight level (blue level)
    
    /*
    
    //object hit flag
    boolean contact = false;
    
    //go through all the obstcle
    for(int i = 0; i < obslen; i++){
      
      //if there's a contact with another object and if this object isn't himself
      if(obs[i].contact(x, y, sx, sy) && i != index && y < obs[i].get_y()){
        contact = true;
      }
      
    }
    
    //if he's above the bottom border and he didn't hit anything
    if(y + sy < height && !contact){
      //go down by a fraction of it's weight
      y += blue/(255 * 4);
    }
    
    */
    
    //black border
    stroke(0);
    
    //amount of blue and amount of red inversed from the amount of blue
    fill(255 - blue, 0, blue);
    
    //obstacle with his own parametres
    rect(x, y, sx, sy);
    
    //remove stroke for the rest of the drawing
    noStroke();
    
  }
  
  //set new position
  void set_pos(float nx, float ny){x = nx - sx/2; y = ny - sy/2;}
  
  //get position
  float get_y(){return y;}
  float get_x(){return x;}
  
  //set blue value
  void set_blue(float nblue){blue = nblue;}
  
  
  boolean contact(float nx, float ny, float nsx, float nsy){
    
    //starts thinking it's not hit yet
    boolean hit = false;
    
    //rectangle contact formula
    if(nx + nsx > x && nx < x + sx){
      if(ny + nsy > y && ny < y + sy){
        
        //set's himself hit
        hit = true;
        
      }
    }
    
    //add a small amount of blue upon contact
    if(hit){
      blue += 0.01;
      //limit the blue value to an 8bit
      if(blue > 255){
        blue = 255;
      }
    }
    
    //return his hit condition
    return hit;
    
  }
  
}