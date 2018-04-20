
//gavity
public float grav = 1.1;

//array lengths:
//obstacles
public int obslen;
//rain drops
public int len = 1000;

//rain drops array
public drop[] rain;
//obstacle array
public obstacle[] obs;


//flag for obstacle dragging
boolean drag = false;
//index of the moving obstacle
int mover;
//flag if new obstacles need to be created
boolean newobs = false;

//mouse range sensitivity to grab an obstacle (in pixels)
int sens = 1;

void setup(){
  
  //take's the entire screen
  fullScreen();
  
  //high frameRate for high fluidity
  frameRate(240);
  
  //no shape border (useless in this context and is very ressource intensive
  noStroke();
  
  //create every arrays (drops and obstacles)
  createall();
  
}



void draw(){
  
  //dark grey background
  background(50);
  
  //display (and update) every drop
  disprain();
  
  //display all obstacles
  dispobs();
  
  //delay of 10 ms to be able to see
  delay(20);
  
}



void disprain(){
  
  for(int i = 0; i < len; i++){
    
    //call the display and update function for every rain drop
    rain[i].display();
    rain[i].update();
    
  }
  
}


void dispobs(){
  
  for(int i = 0; i < obslen; i++){
    
    //call display function for every obstacle
    obs[i].show();
    
  }
  
}


void mousePressed(){
  
  for(int i = 0; i < obslen; i++){
    
    //detect if the mouse hovers an obstacle with the range sensitivity and if there's no obstacle selected yet
    if(obs[i].contact(mouseX, mouseY, sens, sens) && !drag){
      
      //flag to drag is true
      drag = true;
      
      //current obstacle is now the dragged one
      mover = i;
      
    }
    
  }
  
  //if the user right clicks
  if(mouseButton == RIGHT){
    //doesn't drag
    drag = false;
    //want's to create a single obstacle
    newobs = true;
  }
  
}



void mouseReleased(){
  
  //if the user is not dragging an obstacle and is not creating a single obstacle
  if(!drag && !newobs){
    
    //create a random amount of obstacles
    createobs(0);
    println("Creating a random amount of obstacles");
    
    //if the user want's to create a single obstacle
  }else if(newobs){
    
    //if there's only one obstacle: create a random amount
    //if not: create only one
    if(obslen == 1){
      println("Creating a random amount of obstacles...");
      createobs(0);
    }else {
      println("Creating a single obstacle...");
      createobs(1);
    }
    
    //reset the single obstacle flag
    newobs = false;
  }
  
  if(drag){
    println("Obstacle " + (mover + 1) + "/" + obslen + " is now at position (" + mouseX + ", " + mouseY + ").");
  }
  //reset the dragging flag
  drag = false;
  
}



void mouseDragged(){
  
  if(drag){
    
    float oldx = obs[mover].x;
    float oldy = obs[mover].y;
    
    float speedx = mouseX - oldx;
    float speedy = mouseY - oldy;
    
    float speed = sqrt(pow(speedx, 2) + pow(speedy, 2));
    
    if(speed > 200){
      obs[mover].set_blue(0);
      println("Obstacle " + (mover + 1) + "'s wet level reseted");
    }
    
    //set the selected obstacle to the mouse's position
    obs[mover].set_pos(float(mouseX), float(mouseY));
  }
  
}



void createall(){
  
  //create rain array
  createrain();
  
  //create obstacle array
  createobs(0);
  
}



void createrain(){
  
  //creation of the array
  rain = new drop[len];
  
  for(int i = 0; i < len; i++){
    
    //creation of the individual drop
    rain[i] = new drop();
    
  }
  
}


void createobs(int nlen){
  
  //if the amount of obstacle is set to 0, create a random amount
  if(nlen == 0){
    obslen = int(random(10, 20));
  }else {
    //set the amount of obstacle to the desired amount
    obslen = nlen;
  }
  
  //creation of the array
  obs = new obstacle[obslen];
  
  for(int i = 0; i < obslen; i++){
    
    //creation of the individual obstacle
    obs[i] = new obstacle(i);
    
  }
  
  if(obslen > 1){
    println(obslen + " obstacles were created.");
  }else {
    println(obslen + " obstacle was created.");
  }
    
  
}