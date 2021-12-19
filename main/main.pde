PImage bg, bird,bottom_pipe,top_pipe;
int bgx, bgy, kx, ky,vky,g;
int[] pipeX, pipeY;
void setup() {
  size(800, 620);
  bg = loadImage("../images/3.png");
  bird = loadImage("../images/new_bird.png");
  bottom_pipe = loadImage("../images/bottom_pipe.png");
  top_pipe = loadImage("../images/top_pipe.png");
  kx = 100;
  ky = 50;
  g = 1;
  
  pipeX = new int[5];
  pipeY = new int[pipeX.length];
  
  for(int i = 0 ; i < pipeX.length ;++i ){
    pipeX[i] = width + 200*i;
    pipeY[i] = (int)random(-350,0);
  }
}

void draw() {
  set_background();
  bird();
  for(int i = 0 ; i < pipeX.length ;i++ ){
       image(top_pipe,pipeX[i],pipeY[i]);
       image(bottom_pipe, pipeX[i],pipeY[i]+680);
       pipeX[i]-=4;
       if(pipeX[i] < -200){
         pipeX[i] = width;
       }
       
       
  }
}

void bird(){
  image(bird, kx, ky);
  ky = ky + vky;
  vky = vky + g;
}

void mousePressed(){
    vky = -15;
}

void set_background() {

  image(bg, bgx, bgy);
  image(bg, bgx + bg.width, bgy);
  bgx = bgx - 2;
  if (bgx < -bg.width) {
    bgx = 0;
  }
}
