import processing.sound.*;
SoundFile jumpSound, hit, bravo;

// Summer variables
PImage sBack;
PImage sun;
float sunAngle;
SoundFile beachSound, birdS;
boolean  summerSound= true, bravoSound = true;


// Winter variables
float snowY[], snowX[], snowAngle;
PImage snow, winter_bg;
SoundFile snowSound;
boolean winterSound = true;

// Bird and pipes variables
PFont f;
PImage bg, bird, bottom_pipe, top_pipe;
int bgx, bgy, kx, ky, vky, g, score, prescore, pipe_speed, word_height;
// kx and ky are coordinates  of the birds 
// g is the gravity 
// bg: background 

float[] pipeX, pipeY; // two arrays for pipes 
int game_state;
void setup() {
  size(1000, 600);
  background(0);
  textSize(60);
  text("Loading...", 350, 350);
  // sounds 
  jumpSound = new SoundFile(this, "../sound/jumpy.mp3");
  hit = new SoundFile(this, "../sound/gameover.mp3");
  bravo = new SoundFile(this, "../sound/bravoo_3leek.mp3");

  // define images
  bg = loadImage("../images/trial.png");
  bird = loadImage("../images/bird.png");
  bottom_pipe = loadImage("../images/bottom_pipeNewCropped.png");
  top_pipe = loadImage("../images/top_pipeNewCropped.png");



  //define font
  f = loadFont("AdobeArabic-Bold-60.vlw");
  textFont(f);

  // initialize values for bird and pipes
  pipe_speed = 2;
  kx = 100; // x position of the bird
  ky = 50;  // y position of the bird
  g = 1;    // how fast the birds falls
  game_state = -1;
  word_height = 55;
  pipeX = new float[5];
  pipeY = new float[pipeX.length];

  // assign coordinates for every pipe
  for (int i = 0; i < pipeX.length; i++ ) {
    pipeX[i] = (width/2)+  250 *i; // adding width/2 to make pipes starts to appear from the mid of the x axis
    pipeY[i] = (int)random(-400, -200);
  }

  // assgin Winter Varibales
  snowAngle = 0.0;
  winter_bg= loadImage("../images/winterBackround.png");
  snow = loadImage("../images/snow.png");
  snowSound = new SoundFile(this, "../sound/snow.mp3");
  snowSound.amp(0.5); //decreasing winter sound

  snowY = new float[20];
  snowX = new float[20];

  // assign different y coordinates for snow
  for (int i = 0; i < 20; i++) {
    snowY[i] = random(0, height);
  }

  // assign x coordinates for snow 
  snowX[0] = 5;
  for (int i = 1; i <= 19; i++) {
    snowX[i] = snowX[i-1] + 50;
  }

  // assign Summer variables
  birdS = new SoundFile(this, "../sound/bird.mp3");
  beachSound = new SoundFile(this, "../sound/beach.mp3");
  beachSound.amp(0.5);  // decrease the voice of beach


  sBack = loadImage("../images/summerBack.png");  
  sun = loadImage("../images/sun3.png");
}

void draw() {

  switch(game_state) {
  case -1: // the state of the start screen  
    start_screen();
    break;
  case 0: // the case of basic game
    set_background(bg);
    set_pipes();
    bird();
    set_score();
    bravo(); // function to say bravo 3aleek
    break;
  case 2: // the case of winter state
    if (winterSound == true) {
      snowSound.play(); 
      winterSound = false;
    }  
    set_background(winter_bg);
    set_pipes();  //display pipes
    bird();       //display bird
    set_score();  // display current score
    bravo();      // function to say bravo 3aleek
    callWinter(); // for the sonw special effect of rotation and random movement
    break;
  case 3:
    if (summerSound == true) {
      beachSound.play();
      birdS.play();  
      summerSound = false;
    }
    set_background(sBack);
    callSummer();   // for the sun special effect of rotation
    set_pipes();    // draw the pipes  
    bird();         //display bird
    set_score();    // draw the score
    bravo();// function to say bravo 3aleek
    break;
  case 4: 
    show_levels();
    break;
  case 5:
    show_rules();
    break;
  case 6:
    show_modes();
    break;
  default:
    gameOver();
    hit.stop();
    bravo.stop();
    break;
  }
}
void start_screen() {  
  image(bg, 0, 0);
  textSize(40);
  fill(255);
  text("Welcome to Flappy Bird!", 150, 100);
  text("Play", 420, 200);
  text("Levels", 420, 275);
  text("Modes", 420, 350);
  text("Rules", 420, 425);
  text("Exit", 420, 500);

  if (mouseX > 420 && mouseX < 420 + 110 && mouseY > 150 && mouseY < 150+word_height) {
    fill(102, 178, 255);
    text("Play", 420, 200);
    if (mousePressed) {
      ky = height /2;
      kx = 50 ;
      game_state = 0;
    }
  }

  if (mouseX > 420 && mouseX < 420+175 && mouseY > 225 && mouseY < 225+word_height) {
    fill(102, 178, 255);
    text("Levels", 420, 275);
    if (mousePressed) {
      game_state = 4; // Levels Panel
      delay(100);
    }
  }

  if (mouseX > 420 && mouseX < 420+175 && mouseY > 300 && mouseY < 300+word_height) {
    fill(102, 178, 255);
    text("Modes", 420, 350);
    if (mousePressed) {
      game_state = 6; // Modes Panel
      delay(100);
    }
  }

  if (mouseX > 420 && mouseX < 420+150 && mouseY > 375 && mouseY < 375+word_height) {
    fill(102, 178, 255);
    text("Rules", 420, 425);
    if (mousePressed) {
      game_state = 5; // Rules Panel
    }
  }

  if (mouseX > 420 && mouseX < 420 + 110 && mouseY > 450 && mouseY< 450+word_height) {
    fill(102, 178, 255);
    text("Exit", 420, 500);
    if (mousePressed) {
      exit();
    }
  }
}

void show_levels() {
  image(bg, 0, 0);
  textSize(40);
  fill(255);
  text("Welcome to Flappy Bird!", 150, 100);
  text("Easy", 420, 250);
  text("Medium", 420, 325);
  text("Hard", 420, 400);
  text("Back", 150, 500);

  if (mouseX > 420 && mouseX < 420 + 110 && mouseY > 200 && mouseY < 200+word_height) {
    fill(102, 178, 255);
    text("Easy", 420, 250);
    if (mousePressed) {
      pipe_speed = 2;
      ky = height /2;
      kx = 50 ;
      delay(100);
      game_state = -1;
    }
  }

  if (mouseX > 420 && mouseX < 420 + 215 && mouseY > 275 && mouseY < 275+word_height) {
    fill(102, 178, 255);
    text("Medium", 420, 325);
    if (mousePressed) {
      pipe_speed = 4;
      ky = height /2;
      kx = 50 ;
      delay(100);
      game_state = -1;
    }
  }

  if (mouseX > 420 && mouseX < 420 + 135 && mouseY > 350 && mouseY < 350+word_height) {
    fill(102, 178, 255);
    text("Hard", 420, 400);
    if (mousePressed) {
      pipe_speed = 5;
      ky = height /2;
      kx = 50 ;
      delay(100);
      game_state = -1;
    }
  }

  if (mouseX > 150 && mouseX < 150+125 && mouseY > 450 && mouseY < 450+word_height) {
    fill(102, 178, 255);
    text("Back", 150, 500);
    if (mousePressed) {
      game_state = -1;
    }
  }
}

void show_modes() {
  image(bg, 0, 0);
  textSize(40);
  fill(255);
  text("Welcome to Flappy Bird!", 150, 100);
  text("Winter", 420, 250);
  text("Summer", 420, 400);
  text("Back", 150, 500);

  if (mouseX > 420 && mouseX < 420+180 && mouseY > 200 && mouseY < 200+word_height) {
    fill(102, 178, 255);
    text("Winter", 420, 250);
    if (mousePressed) {
      game_state = 2; // Winter Mode
      ky = height /2;
      kx = 50 ;
    }
  }

  if (mouseX > 420 && mouseX < 420+215 && mouseY > 350 && mouseY < 350+word_height) {
    fill(102, 178, 255);
    text("Summer", 420, 400);
    if (mousePressed) {
      ky = height /2;
      kx = 50 ;
      game_state = 3; // Summer Mode
    }
  }

  if (mouseX > 150 && mouseX < 150+125 && mouseY > 450 && mouseY < 450+word_height) {
    fill(102, 178, 255);
    text("Back", 150, 500);
    if (mousePressed) {
      game_state = -1;
    }
  }
}
void show_rules() {
  image(bg, 0, 0);
  textSize(40);
  fill(255);
  text("Welcome to Flappy Bird!", 150, 75);
  textSize(20);
  text("1- If you choose 'Play': you will enter the basic mode and play directly.", 10, 125);
  text("2- Click on 'Levels' to choose Easy, Medium or Hard, then choose 'Play'.", 10, 175);
  text("3- Choose weather season (Summer/Winter) that you want, form 'Modes'.", 10, 225);
  text("4- If you hits the edges of the screen or the pipes, Game overs ", 10, 275);
  text("5- When you pass a pipe your score increases by 1.", 10, 325);
  text("6- When you pass 5 pipes you listen 'Bravo 3aleeek'. ", 10, 375);
  text("7- Choose 'Exit' if you want to close the game. ", 10, 425);
  text("8- Choose Back to return to the starting screen. ", 10, 475);

  textSize(20);
  text("Back", 150, 550);

  if (mouseX > 150 && mouseX < 150+125 && mouseY > 500 && mouseY < 500+word_height) {
    fill(102, 178, 255);
    text("Back", 150, 550);
    if (mousePressed) {
      game_state = -1;
    }
  }
}
void bird() {
  image(bird, kx, ky);
  /* i make two equation becuase Vky will change when i
   press the mouse but g still constant an the total sum of g and Vky 
   will be added to the vertical cordinate of y-axis*/
  ky += vky;
  vky +=  g;
  if (ky > height || ky < 0) {
    hit.play();
    game_state = 1;
  }
}

void mousePressed() {
  //function is called once after every time a mouse button is pressed.
  vky = -13;
  if (game_state != 1 && game_state > -1 && game_state < 4) jumpSound.play();
}

void set_background(PImage image) {

  image(image, bgx, bgy);
  image(image, bgx + width, bgy);
  bgx = bgx - 2;
  if (bgx < -width) {
    bgx = 0;
  }
}
void set_pipes() {
  for (int i = 0; i < pipeX.length; i++ ) {
    // Draw the pipes
    image(top_pipe, pipeX[i], pipeY[i]);
    image(bottom_pipe, pipeX[i], pipeY[i]+750);

    // let the pipes move toward the bird
    pipeX[i] -= pipe_speed; //speed of pipes
    // redraw the pipes again
    if (pipeX[i] < -200) {
      pipeX[i] = width;
    }
    // check for collision
    if (kx > (pipeX[i]-bird.width) && kx < pipeX[i] + bottom_pipe.width) {
      if (!(ky > pipeY[i] + top_pipe.height && ky < pipeY[i] + (800 - 2*bird.height))) {
        hit.play();
        game_state = 1;
      } else if (kx == pipeX[i] || kx == pipeX[i]+(pipe_speed/2)) {
        score += 1;
      }
    }
  }
}


// this function is used to call the winter
void callWinter() {
  for (int i=0; i<20; i++) {
    pushMatrix();
    translate(snowX[i], snowY[i]);
    rotate(snowAngle);
    image(snow, -10, -10, 20, 20);
    snowAngle = snowAngle + 0.5;
    popMatrix();
    snowY[i] = snowY[i]+random(0, 6);
    if (snowY[i]>height)
      snowY[i] = 0;
  }
}

void callSummer() {
  pushMatrix();
  translate (950, 70);
  rotate(sunAngle);
  image(sun, -50, -50, 100, 100);
  sunAngle = sunAngle + 0.02;
  popMatrix();
}

void gameOver() {
  if (!winterSound) {
    snowSound.pause();
  }
  if (!summerSound) {
    beachSound.pause();  
    birdS.pause();
  }
  winterSound = true;
  summerSound = true;

  fill (247, 114, 114);
  text("Game Over!", 350, 250);
  text("Your Score is : " + score, 300, 350);
  text("Exit", 250, 450);
  text("Restart", 600, 450);

  if (mouseX > 250 && mouseX <250+150 && mouseY > 400 && mouseY < 400+70) {
    fill(255);
    text("Exit", 250, 450);
    if (mousePressed) {
      exit();
    }
  }

  if (mouseX > 600 && mouseX < 600+170 && mouseY > 400 && mouseY < 400+70) {
    fill(255);
    text("Restart", 600, 450);
    if (mousePressed) {
      restart();
    }
  }
  hit.play();
}

void restart() {
  game_state = -1;
  score = 0;
  kx = 100;
  ky = 50;
  pipeX = null;
  pipeY = null;

  pipeX = new float[5];
  pipeY = new float[pipeX.length];
  // assign coordinates for every pipe

  for (int i = 0; i < pipeX.length; i++ ) {
    pipeX[i] = (width/2)+  250 *i; // adding width/2 to make pipes starts to appear from the mid of the x axis
    pipeY[i] = (int)random(-300, 0);
  }
}

void set_score() {
  fill(255);
  textSize(32);
  text("Score : " + score, 25, 50);
}
void bravo() {
  if (score - prescore > 0)bravoSound = true;
  prescore = score;
  if (score != 0 && bravoSound == true && score % 5 == 0) {
    bravo.play();
    bravoSound = false;
  }
}
