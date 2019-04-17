final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg, soil0, soil1, soil2, soil3, soil4, soil5, life, stone1, stone2;
PImage imgGroundhogIdle, imgGroundhogDown, imgGroundhogLeft, imgGroundhogRight;

// groundhog
int groundhogX, groundhogY, groundhogSpeed;
final int SQUARE_UNIT=80;

// moveing
boolean downPressed=false;
boolean leftPressed=false;
boolean rightPressed=false;

// moveY lawn and soil
int moveY=0;

// grounghog image
boolean groundhogIdle=true;

// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
	size(640, 480, P2D);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
  // soil
  soil0 = loadImage("img/soil0.png");
  soil1 = loadImage("img/soil1.png");
  soil2 = loadImage("img/soil2.png");
  soil3 = loadImage("img/soil3.png");
  soil4 = loadImage("img/soil4.png");
  soil5 = loadImage("img/soil5.png");
  //line
  life = loadImage("img/life.png");
  //stone
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
  //groundhog
  imgGroundhogIdle= loadImage("img/groundhogIdle.png");
  imgGroundhogDown= loadImage("img/groundhogDown.png");
  imgGroundhogLeft= loadImage("img/groundhogLeft.png");
  imgGroundhogRight= loadImage("img/groundhogRight.png");

  // life
  playerHealth=2;
  
  //groundhog
  groundhogX=SQUARE_UNIT*4;
  groundhogY=SQUARE_UNIT;
  groundhogSpeed+=80/16;  // 15 change 16

}

void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

    
	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
			}

		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;

		case GAME_RUN: // In-Game

		// Background
		image(bg, 0, 0);

		// Sun
	    stroke(255,255,0);
	    strokeWeight(5);
	    fill(253,184,19);
	    ellipse(590,50,120,120);

   // moveY
   
   pushMatrix();
   translate(0,moveY);
   
		// Grass
		fill(124, 204, 25);
		noStroke();
		rect(0, 160 - GRASS_HEIGHT, width, GRASS_HEIGHT);

		// Soil 
		for(int y=160; y<80*6; y+=80){
     for(int x=0; x<width; x+=80){
       image(soil0,x,y);
     }
    }
    
    for(int y=80*6; y<80*10; y+=80){
     for(int x=0; x<width; x+=80){
       image(soil1,x,y);
     }
    }
    
    for(int y=80*10; y<80*14; y+=80){
     for(int x=0; x<width; x+=80){
       image(soil2,x,y);
     }
    }
    
    for(int y=80*14; y<80*18; y+=80){
     for(int x=0; x<width; x+=80){
       image(soil3,x,y);
     }
    }
    
    for(int y=80*18; y<80*22; y+=80){
     for(int x=0; x<width; x+=80){
       image(soil4,x,y);
     }
    }
    
    for(int y=80*22; y<80*26; y+=80){
     for(int x=0; x<width; x+=80){
       image(soil5,x,y);
     }
    }

    // stone
      // one to eight
      int y1=160;
      for(int x=0; x<width; x+=80){
        image(stone1,x,y1); 
        y1+=80;
      }
      
      // nine to sixteen 
      for(int x=80; x<width; x+=320){
        for(int y=80*10; y<80*18; y+=80){
          if(y==80*11 || y==80*12 || y==80*15 || y==80*16 ){
            image(stone1,x-80,y); 
            image(stone1,x+160,y);
          }else{
            image(stone1,x,y); 
            image(stone1,x+80,y);  
            } // else
        }
      }
      
      // seventeen to twentyfour
      for(int x=80; x<width; x+=240){
        for(int y=80*18; y<80*26; y+=80){               
          if(y%3==2){
            image(stone1,x-80,y); 
            image(stone1,x,y); 
          }else if(y%3==1){
            image(stone1,x-160,y); 
            image(stone1,x-80,y);
          }else{
            image(stone1,x,y); 
            image(stone1,x+80,y); 
          } // else
        }
      } // for
      
      for(int x=0; x<width; x+=240){
        for(int y=80*18; y<80*26; y+=80){               
          if(y%3==1){
            image(stone2,x,y);  
          }else if(y%3==2){
            image(stone2,x+80,y); 
          }else{
            image(stone2,x+160,y);  
          } // else
        }
      } // for

    popMatrix(); // moveY

		// Player
   // Grounghog move
      
      if(groundhogIdle){
        
        if(moveY>-80*20){
          groundhogY=80;
          image(imgGroundhogIdle,groundhogX,groundhogY);
        }else{
           image(imgGroundhogIdle,groundhogX,groundhogY); 
        }
      }
      
      if(downPressed){
        groundhogIdle=false;
        leftPressed= false;
        rightPressed= false;
        groundhogY+=groundhogSpeed;
        if(moveY>-80*20){
          image(imgGroundhogDown,groundhogX,80);
            moveY-=80/16;
          }else{
             moveY=-80*20;
             image(imgGroundhogDown,groundhogX,groundhogY);
          }

        if(groundhogY%80==0){
          downPressed= false;
          groundhogIdle=true;
          }
      }
      if(leftPressed){
        groundhogIdle=false;
        image(imgGroundhogLeft,groundhogX,groundhogY);
        downPressed= false;
        rightPressed= false;
        groundhogX-=groundhogSpeed;
        if(groundhogX%80==0){
          leftPressed= false;
          groundhogIdle=true;
          }
      }
      if(rightPressed){
        groundhogIdle=false;
        image(imgGroundhogRight,groundhogX,groundhogY);
        leftPressed= false;
        downPressed= false;
        groundhogX+=groundhogSpeed;
        if(groundhogX%80==0){
          rightPressed= false;
          groundhogIdle=true;
          }
      }
      
      // Grounghog boundary detection
      if(groundhogX<0){
        leftPressed= false;
        groundhogIdle=true;
        groundhogX=0;
      }
      if(groundhogX>width-SQUARE_UNIT){
        rightPressed= false;
        groundhogIdle=true;
        groundhogX=width-SQUARE_UNIT;
      }
      if(groundhogY>=height-80){
        downPressed= false;
        if(downPressed==true || leftPressed==true || rightPressed==true){
          groundhogIdle=false;
        }else{
          groundhogIdle=true;
        }
        groundhogY=height-80;
      }

		// Health UI
    for(int x=10; x<10+70*playerHealth; x+=70){
      image(life,x,10);
    }

		break;

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
				// Remember to initialize the game here!
			}
		}else{

			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;
		
	}

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
	// Add your moving input code here
   if (key == CODED) {
    switch (keyCode) {
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }

	// DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
}

void keyReleased(){
}
