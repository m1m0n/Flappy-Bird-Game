PImage bg, bird,bottom_pipe,top_pipe;
int bgx, bgy, kx, ky,vky,g;
int[] pipeX, pipeY;
boolean game_state;

void setup() {
  size(800, 620);
  bg = loadImage("../images/3.png");
  bird = loadImage("../images/new_bird.png");
  bottom_pipe = loadImage("../images/bottom_pipe.png");
  top_pipe = loadImage("../images/top_pipe.png");
  kx = 100;
  ky = 50;
  g = 1; // speed of downward acceleration
  
  pipeX = new int[5];
  pipeY = new int[pipeX.length];
  
  for(int i = 0 ; i < pipeX.length ;++i ){
    // let the bird warm up and the pipes not start from the begining
    pipeX[i] = width + 200*i;
    pipeY[i] = (int)random(-350,0);
  }
}

void draw() {
  if (!game_state){
    set_background();
    set_pipes();
    bird(); 
  }else{
    
    textSize(32);
    text("YOU LOSE",50,100);

  }
}

void set_pipes(){
  for(int i = 0 ; i < pipeX.length ;i++ ){
      // Draw the pipes
       image(top_pipe,pipeX[i],pipeY[i]);
       image(bottom_pipe, pipeX[i],pipeY[i]+680);
       // let the pipes move toward the bird
       pipeX[i]-=4; //speed of pipes
       // redraw the pipes again
       if(pipeX[i] < -200){
         pipeX[i] = width;
       }
       // check for collision
       if(kx > (pipeX[i]-bird.width) && kx < pipeX[i] + bottom_pipe.width){
         if(!(ky > pipeY[i] + top_pipe.height && ky < pipeY[i] + top_pipe.height +680 - top_pipe.height))
         game_state = true;
       }
  }    

}

void bird(){
  image(bird, kx, ky);
  ky = ky + vky;
  vky = vky + g;
  if(ky > height || ky < 0){
    textSize(32);
    text("You Died!",20,34);
    game_state = true;
  }
}

void mousePressed(){
    vky = -15;// bird jumps up when the mouse is clicked
}

void set_background() {

  image(bg, bgx, bgy);
  // redraw the background
  image(bg, bgx + bg.width, bgy);
  // Animation the background
  bgx = bgx - 2;
  if (bgx < -bg.width) {
    bgx = 0; // reset it once the first image is done
  }
}
