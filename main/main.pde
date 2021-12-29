PFont f;
PImage bg, bird,bottom_pipe,top_pipe,gameOver;
int bgx, bgy, kx, ky,vky,g,score;
// kx and ky are coordinates  of the birds 
// g is the gravity 
float[] pipeX, pipeY; // two arrays for pipes 
int game_state;
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
  game_state = -1;

  pipeX = new float[5];
  pipeY = new float[pipeX.length];
  // assign coordinates for every pipe
  
  for(int i = 0 ; i < pipeX.length ;i++ ){
    pipeX[i] = (width/2)+  250 *i; // adding width/2 to make pipes starts to appear from the mid of the x axis
    pipeY[i] = (int)random(-300,0);
  }
}

void draw() {
  
  if (game_state == -1){
    start_screen();
  }else if (game_state == 0){
    set_background();
    set_pipes();
    bird();
    set_score();
  }else{
     gameOver();

 }
}

void menu(){


}
void start_screen(){
  image(bg,0,0);
  textSize(40);
  fill(255);
  text("Welcome to Flappy Bird!",150,100);
  text("Play",420,300);
  text("Rules", 420,400);
  text("Exit",420,500);
  
  if(mouseX > 420 && mouseX < 420 + 110 && mouseY > 250 && mouseY < 250+70){
    fill(102, 178, 255);
    text("Play", 420, 300);
    if(mousePressed){
      ky = height /2;
      game_state = 0;
    }
  }
  
  if(mouseX > 420 && mouseX < 420+140 && mouseY > 350 && mouseY < 350+70){
    fill(102, 178, 255);
    text("Rules", 420, 400);
    if(mousePressed){
      show_rules();
      
    }
  }
  
  if(mouseX > 420 && mouseX < 420+110 && mouseY > 450 && mouseY < 450+70){
    fill(102, 178, 255);
    text("Exit", 420, 500);
    if(mousePressed){
      exit();
    }
  }
}

void show_rules(){
  image(bg,0,0);
  textSize(40);
  fill(255);
  text("Welcome to Flappy Bird!",150,100);
  text("Dummy Fucking Rules!!",200,300);
  
  
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
    game_state = 1;
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

       pipeX[i] -= 2; //speed of pipes
       // redraw the pipes again
       if(pipeX[i] < -200){
         pipeX[i] = width;
       }
       // check for collision
       if(kx > (pipeX[i]-bird.width) && kx < pipeX[i] + bottom_pipe.width){
         if(!(ky > pipeY[i] + top_pipe.height && ky < pipeY[i] + (top_pipe.height +800 - top_pipe.height-bird.height))){
           game_state = 1;
         } else if(kx == pipeX[i] || kx == pipeX[i]+1){
           score++;
         }
       } 
  }    

}
void gameOver(){
stroke(5);
    fill (247,114,114);
    text("Game Over",300,400);
}

void set_score(){
  fill(255);
  textSize(32);
  text("Score : " + score, width - 200, 50);
}
