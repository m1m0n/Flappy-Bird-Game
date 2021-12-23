PFont f;
PImage bg, bird,bottom_pipe,top_pipe,gameOver;
int bgx, bgy, kx, ky,vky,g;
// kx and ky are coordinates  of the birds 
// g is the gravity 
float[] pipeX, pipeY; // two arrays for pipes 
boolean game_state;
void setup() {
  size(1000,825);
  bg = loadImage("../images/trial.png");
  bird = loadImage("../images/bird.png");
  bottom_pipe = loadImage("../images/bottom_pipeNewCropped.png");
  top_pipe = loadImage("../images/top_pipeNewCropped .png");
  gameOver= loadImage("../images/gameOver.png");
  f = loadFont("AdobeArabic-Bold-60.vlw");
  textFont(f);
  //fly = loadShape("../images/fly.svg");
  kx = 100;
  ky = 50;
  g = 1;

  pipeX = new float[5];
  pipeY = new float[pipeX.length];
  // assign coordinates for every pipe
  
  for(int i = 0 ; i < pipeX.length ;i++ ){
    pipeX[i] = (width/2)+  250 *i; // adding width/2 to make pipes starts to appear from the mid of the x axis
    pipeY[i] = (int)random(-300,0);
  }
}

void draw() {
  if (!game_state){
    set_background();
    set_pipes();
    bird(); 
  }else{
     gameOver();

 }
}
void bird(){
  image(bird, kx, ky);
  /* i make two equation becuase Vky will change when i
  press the mouse but g still constant an the total sum of g and Vky 
  will be added to the vertical cordinate of y-axis*/
  ky = ky + vky;
  vky = vky + g;
  if(ky > height || ky < 0){
     gameOver();
    game_state = true;
  }
}

void mousePressed(){
    vky = -13;
  //function is called once after every time a mouse button is pressed.
}

void set_background() {

  image(bg, bgx, bgy);
  image(bg, bgx + width, bgy);
  bgx = bgx - 2;
  if (bgx < -width) {
    bgx = 0;
  }
}
void set_pipes(){
  for(int i = 0 ; i < pipeX.length ;i++ ){
      // Draw the pipes
      
    image(top_pipe,pipeX[i],pipeY[i]);
       image(bottom_pipe, pipeX[i],pipeY[i]+800);
     
       // let the pipes move toward the bird

       pipeX[i]-=4; //speed of pipes
       // redraw the pipes again
       if(pipeX[i] < -200){
         pipeX[i] = width;
       }
       // check for collision
       if(kx > (pipeX[i]-bird.width) && kx < pipeX[i] + bottom_pipe.width){
         if(!(ky > pipeY[i] + top_pipe.height && ky < pipeY[i] + (top_pipe.height +800 - top_pipe.height-bird.height)))
         game_state = true;
       }
  }    

}
void gameOver(){
stroke(5);
    fill (247,114,114);
    text("Game Over",300,400);
}