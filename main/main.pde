import processing.sound.*;
SoundFile jumpSound, backSound, hit, bravo, snowSound ;
// 
boolean winterSound = false, summerSound= false;

// Summer variable
PImage sBack;
PImage sun;
float sunAngle;
SoundFile beachSound, birdS;

// SNOW VARIABLES
float snowY[];
float snowX[];

float snowAngle;
float Ysnow = 10;
PImage snow, winter_bg;

PFont f;
PImage bg, bird, bottom_pipe, top_pipe, gameOver;
int bgx, bgy, kx, ky, vky, g, score, pipe_speed;
// kx and ky are coordinates  of the birds 
// g is the gravity 
float[] pipeX, pipeY; // two arrays for pipes 
int game_state;
void setup() {
  size(1000, 825);
  frameRate(60);

  // sounds 
  jumpSound = new SoundFile(this, "../sound/jumpy.mp3");
  backSound = new SoundFile(this, "../sound/forest.wav");
  hit = new SoundFile(this, "../sound/gameover.mp3");
  bravo = new SoundFile(this, "../sound/bravoo_3leek.mp3");


  bg = loadImage("../images/trial.png");
  bird = loadImage("../images/bird.png");
  bottom_pipe = loadImage("../images/bottom_pipeNewCropped.png");
  top_pipe = loadImage("../images/top_pipeNewCropped .png");
  gameOver= loadImage("../images/gameOver.png");



  f = loadFont("AdobeArabic-Bold-60.vlw");
  textFont(f);

  pipe_speed = 2;
  kx = 100;
  ky = 50;
  g = 1;
  game_state = -1;
  snowAngle = 0.0;    


  pipeX = new float[5];
  pipeY = new float[pipeX.length];
  // assign coordinates for every pipe

  for (int i = 0; i < pipeX.length; i++ ) {
    pipeX[i] = (width/2)+  250 *i; // adding width/2 to make pipes starts to appear from the mid of the x axis
    pipeY[i] = (int)random(-300, 0);
  }
  // Winter Varibales
  winter_bg= loadImage("../images/winterBackround.png");
  snow = loadImage("../images/snow.png");
  snowSound = new SoundFile(this, "../sound/snow.mp3");
  snowSound.play();
  snowSound.pause();
  //snowSound.amp(0.5);
  snowY = new float[20];
  snowX= new float[20];

  // assign different y coordinates for snow
  for (int i=0; i<20; i++) {
    snowY[i] = random(0, height);
  }

  // assign x coordinates for snow 
  snowX[0] =5;
  for (int i=1; i<=19; i++) {
    snowX[i]= snowX[i-1]+50;
  }
  // Summer variables
  //birdS = new SoundFile(this, "../sound/bird.mp3");
  beachSound = new SoundFile(this, "../sound/beach.mp3");
  //birdS.play();
  beachSound.play();
  beachSound.pause();
  sBack = loadImage("../images/summerBack.png");  
  sun = loadImage("../images/sun3.png");

  backSound.loop();
}

void draw() {

  if (game_state == -1) {
    start_screen();
  } else if (game_state == 0) {
    if (score % 5 != 0) {
      bravo.loop();
    }
    set_background(bg);
    set_pipes();
    bird();
    set_score();
  } else if (game_state == 2) {
    //initWinter();
    if (!winterSound) {
      snowSound.play();
      beachSound.pause();
      winterSound = true;
      summerSound= false;
    }



    if (score % 5 != 0) {
      bravo.loop();
    }
    set_background(winter_bg);
    set_pipes();
    bird();
    set_score();
    callWinter();
  } else if (game_state == 3) {

    //initSummer();
    if (!summerSound) {
      snowSound.play();
      beachSound.pause();
      summerSound = true;
      winterSound = false;
    }

    if (score % 5 != 0) {
      bravo.loop();
    }
    pushMatrix();
    set_background(sBack);
    bird();
    callSummer();
    popMatrix();
    set_pipes();
    set_score();
  } else if (game_state == 4) {
    show_levels();
  } else if (game_state == 5) {
    show_rules();
  } else if (game_state == 6) {
    show_modes();
  } else {
    gameOver();
    exit();
    bravo.stop();
  }
}

void start_screen() {
  image(bg, 0, 0);
  textSize(40);
  fill(255);
  text("Welcome to Flappy Bird!", 150, 100);
  text("Play", 420, 300);
  text("Levels", 420, 400);
  text("Modes", 420, 500);
  text("Rules", 420, 600);
  text("Exit", 420, 700);

  if (mouseX > 420 && mouseX < 420 + 110 && mouseY > 250 && mouseY < 250+70) {
    fill(102, 178, 255);
    text("Play", 420, 300);
    if (mousePressed) {
      ky = height /2;
      kx = 50 ;
      game_state = 0;
    }
  }

  if (mouseX > 420 && mouseX < 420+140 && mouseY > 350 && mouseY < 350+70) {
    fill(102, 178, 255);
    text("Levels", 420, 400);
    if (mousePressed) {
      game_state = 4; // Levels Panel
    }
  }

  if (mouseX > 420 && mouseX < 420+110 && mouseY > 550 && mouseY < 550+70) {
    fill(102, 178, 255);
    text("Rules", 420, 600);
    if (mousePressed) {
      game_state = 5; // Rules Panel
    }
  }


  if (mouseX > 420 && mouseX < 520+140 && mouseY > 450 && mouseY < 450+70) {
    fill(102, 178, 255);
    text("Modes", 420, 500);
    if (mousePressed) {
      game_state = 6; // Modes Panel
    }
  }

  if (mouseX > 420 && mouseX < 420 + 110 && mouseY > 650 && mouseY< 650+70) {
    fill(102, 178, 255);
    text("Exit", 420, 700);
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
  text("Easy", 420, 300);
  text("Medium", 420, 450);
  text("Hard", 420, 600);
  text("Back", 120, 700);

  if (mouseX > 420 && mouseX < 420+140 && mouseY > 250 && mouseY < 250+70) {
    fill(102, 178, 255);
    text("Easy", 420, 300);
    if (mousePressed) {
      pipe_speed = 2;
      ky = height /2;
      kx = 50 ;
      game_state = 0;
    }
  }

  if (mouseX > 420 && mouseX < 420+200 && mouseY > 400 && mouseY < 400+70) {
    fill(102, 178, 255);
    text("Medium", 420, 450);
    if (mousePressed) {
      pipe_speed = 4;
      ky = height /2;
      kx = 50 ;
      game_state = 0;
    }
  }

  if (mouseX > 420 && mouseX < 420+140 && mouseY > 550 && mouseY < 550+70) {
    fill(102, 178, 255);
    text("Hard", 420, 600);
    if (mousePressed) {
      pipe_speed = 6;
      ky = height /2;
      kx = 50 ;
      game_state = 0;
    }
  }

  if (mouseX > 120 && mouseX < 120+140 && mouseY > 650 && mouseY < 650+70) {
    fill(102, 178, 255);
    text("Back", 120, 700);
    if (mousePressed) {
      game_state = -1;
    }
  }
}

void show_rules() {
  image(bg, 0, 0);
  textSize(40);
  fill(255);
  text("Welcome to Flappy Bird!", 150, 100);
  text("Dummy Fucking Rules!!", 200, 300);
  text("Back", 120, 700);

  if (mouseX > 120 && mouseX < 120+140 && mouseY > 650 && mouseY < 650+70) {
    fill(102, 178, 255);
    text("Back", 120, 700);
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
  text("Normal", 420, 300);
  text("Winter", 420, 450);
  text("Summer", 420, 600);
  text("Back", 120, 700);

  if (mouseX > 420 && mouseX < 420+140 && mouseY > 250 && mouseY < 250+70) {
    fill(102, 178, 255);
    text("Normal", 420, 300);
    if (mousePressed) {
      pipe_speed = 2;
      ky = height /2;
      kx = 50 ;
      game_state = 0;
    }
  }

  if (mouseX > 420 && mouseX < 420+200 && mouseY > 400 && mouseY < 400+70) {
    fill(102, 178, 255);
    text("Winter", 420, 450);
    if (mousePressed) {
      game_state = 2; // Winter Mode
      pipe_speed = 2;
      ky = height /2;
      kx = 50 ;
    }
  }

  if (mouseX > 420 && mouseX < 420+140 && mouseY > 550 && mouseY < 550+70) {
    fill(102, 178, 255);
    text("Summer", 420, 600);
    if (mousePressed) {
      pipe_speed = 2;
      ky = height /2;
      kx = 50 ;
      game_state = 3; // Summer Mode
    }
  }

  if (mouseX > 120 && mouseX < 120+140 && mouseY > 650 && mouseY < 650+70) {
    fill(102, 178, 255);
    text("Back", 120, 700);
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
  ky = ky + vky;
  vky = vky + g;
  if (ky > height || ky < 0) {
    gameOver();
    game_state = 1;
  }
}

void mousePressed() {
  //function is called once after every time a mouse button is pressed.
  vky = -13;
  jumpSound.play();
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
    image(bottom_pipe, pipeX[i], pipeY[i]+800);

    // let the pipes move toward the bird

    pipeX[i] -= pipe_speed; //speed of pipes
    // redraw the pipes again
    if (pipeX[i] < -200) {
      pipeX[i] = width;
    }
    // check for collision
    if (kx > (pipeX[i]-bird.width) && kx < pipeX[i] + bottom_pipe.width) {
      if (!(ky > pipeY[i] + top_pipe.height && ky < pipeY[i] + (top_pipe.height +800 - top_pipe.height-bird.height))) {
        game_state = 1;
      } else if (kx == pipeX[i] || kx == pipeX[i]+(pipe_speed/2)) {
        score+=(pipe_speed/2);
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
    snowAngle = snowAngle + 0.1;
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
  stroke(5);
  fill (247, 114, 114);
  text("Game Over!", 350, 400);
  text("Your Score is : " + score, 300, 500);
  hit.play();
}

void restart() {
  //game_state = -1;
  score = 0;
  kx = 100;
  ky = 50;
}

void set_score() {
  fill(255);
  textSize(32);
  text("Score : " + score, 25, 50);
}
