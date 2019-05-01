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
final int SQUARE_UNIT=80;


float soldierSpeed = 2f;

float groundhogX, groundhogY;
int playerCol, playerRow;
final float PLAYER_INIT_X = 4 * SQUARE_UNIT;
final float PLAYER_INIT_Y = - SQUARE_UNIT;
boolean leftState = false;
boolean rightState = false;
boolean downState = false;
final int PLAYER_MAX_HEALTH = 5;
int playerMoveDirection = 0;
int playerMoveTimer = 0;
int playerMoveDuration = 15;

boolean demoMode = false;


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

  // Initialize player
  groundhogX = PLAYER_INIT_X;
  groundhogY = PLAYER_INIT_Y;
  playerCol = (int) (groundhogX / SQUARE_UNIT);
  playerRow = (int) (groundhogY / SQUARE_UNIT);
  playerMoveTimer = 0;
  playerHealth = 2;

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
   translate(0, max(SQUARE_UNIT * -18, SQUARE_UNIT * 1 - groundhogY));
   
		// Grass
		fill(124, 204, 25);
		noStroke();
		rect(0, -GRASS_HEIGHT, width, GRASS_HEIGHT);

		// Soil 
		for(int y=0; y<80*4; y+=80){
     for(int x=0; x<width; x+=80){
       image(soil0,x,y);
     }
    }
    
    for(int y=80*4; y<80*8; y+=80){
     for(int x=0; x<width; x+=80){
       image(soil1,x,y);
     }
    }
    
    for(int y=80*8; y<80*12; y+=80){
     for(int x=0; x<width; x+=80){
       image(soil2,x,y);
     }
    }
    
    for(int y=80*12; y<80*16; y+=80){
     for(int x=0; x<width; x+=80){
       image(soil3,x,y);
     }
    }
    
    for(int y=80*16; y<80*20; y+=80){
     for(int x=0; x<width; x+=80){
       image(soil4,x,y);
     }
    }
    
    for(int y=80*20; y<80*24; y+=80){
     for(int x=0; x<width; x+=80){
       image(soil5,x,y);
     }
    }

    // stone
      // one to eight
      int y1=0;
      for(int x=0; x<width; x+=80){
        image(stone1,x,y1); 
        y1+=80;
      }
      
      // nine to sixteen 
      for(int x=80; x<width; x+=320){
        for(int y=80*8; y<80*16; y+=80){
          if(y==80*9 || y==80*10 || y==80*13 || y==80*14 ){
            image(stone1,x-80,y); 
            image(stone1,x+160,y);
          }else{
            image(stone1,x,y); 
            image(stone1,x+80,y);  
            } // else
        }
      }
      
      // seventeen to twentyfour
      for(int i=0; i<8; i++){
      for(int j=0; j<8; j++){
       if((i+j)%3==1){
         image(stone1,80*i,(j+16)*80);
         
       }
     if((i+j)%3==2){
       image(stone1,80*i,(j+16)*80);
       image(stone2,80*i,(j+16)*80);
       
       }
      }
     }  

// Groundhog

    PImage groundhogDisplay = imgGroundhogIdle;

    // If player is not moving, we have to decide what player has to do next
    if(playerMoveTimer == 0){

      // HINT:
      // You can use playerCol and playerRow to get which soil player is currently on

      // Check if "player is NOT at the bottom AND the soil under the player is empty"
      // > If so, then force moving down by setting playerMoveDirection and playerMoveTimer (see downState part below for example)
      // > Else then determine player's action based on input state

      if(leftState){

        groundhogDisplay = imgGroundhogLeft;

        // Check left boundary
        if(playerCol > 0){

          // HINT:
          // Check if "player is NOT above the ground AND there's soil on the left"
          // > If so, dig it and decrease its health
          // > Else then start moving (set playerMoveDirection and playerMoveTimer)

          playerMoveDirection = LEFT;
          playerMoveTimer = playerMoveDuration;

        }

      }else if(rightState){

        groundhogDisplay = imgGroundhogRight;

        // Check right boundary
        if(playerCol < 8 - 1){

          // HINT:
          // Check if "player is NOT above the ground AND there's soil on the right"
          // > If so, dig it and decrease its health
          // > Else then start moving (set playerMoveDirection and playerMoveTimer)

          playerMoveDirection = RIGHT;
          playerMoveTimer = playerMoveDuration;

        }

      }else if(downState){

        groundhogDisplay = imgGroundhogDown;

        // Check bottom boundary

        // HINT:
        // We have already checked "player is NOT at the bottom AND the soil under the player is empty",
        // and since we can only get here when the above statement is false,
        // we only have to check again if "player is NOT at the bottom" to make sure there won't be out-of-bound exception
        if(playerRow < 24 - 1){

          // > If so, dig it and decrease its health

          // For requirement #3:
          // Note that player never needs to move down as it will always fall automatically,
          // so the following 2 lines can be removed once you finish requirement #3

          playerMoveDirection = DOWN;
          playerMoveTimer = playerMoveDuration;


        }
      }

    }

    // If player is now moving?
    // (Separated if-else so player can actually move as soon as an action starts)
    // (I don't think you have to change any of these)

    if(playerMoveTimer > 0){

      playerMoveTimer --;
      switch(playerMoveDirection){

        case LEFT:
        groundhogDisplay = imgGroundhogLeft;
        if(playerMoveTimer == 0){
          playerCol--;
          groundhogX = SQUARE_UNIT * playerCol;
        }else{
          groundhogX = (float(playerMoveTimer) / playerMoveDuration + playerCol - 1) * SQUARE_UNIT;
        }
        break;

        case RIGHT:
        groundhogDisplay = imgGroundhogRight;
        if(playerMoveTimer == 0){
          playerCol++;
          groundhogX = SQUARE_UNIT * playerCol;
        }else{
          groundhogX = (1f - float(playerMoveTimer) / playerMoveDuration + playerCol) * SQUARE_UNIT;
        }
        break;

        case DOWN:
        groundhogDisplay = imgGroundhogDown;
        if(playerMoveTimer == 0){
          playerRow++;
          groundhogY = SQUARE_UNIT * playerRow;
        }else{
          groundhogY = (1f - float(playerMoveTimer) / playerMoveDuration + playerRow) * SQUARE_UNIT;
        }
        break;
      }

    }

    image(groundhogDisplay, groundhogX, groundhogY);


    popMatrix(); // moveY

		// Player
   // Grounghog move
     
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

// Initialize player
        groundhogX = PLAYER_INIT_X;
        groundhogY = PLAYER_INIT_Y;
        playerCol = (int) (groundhogX / SQUARE_UNIT);
        playerRow = (int) (groundhogY / SQUARE_UNIT);
        playerMoveTimer = 0;
        playerHealth = 2;

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
  if(key==CODED){
    switch(keyCode){
      case LEFT:
      leftState = true;
      break;
      case RIGHT:
      rightState = true;
      break;
      case DOWN:
      downState = true;
      break;
    }
  }else{
    if(key=='b'){
      // Press B to toggle demo mode
      demoMode = !demoMode;
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
  
  if(key==CODED){
    switch(keyCode){
      case LEFT:
      leftState = false;
      break;
      case RIGHT:
      rightState = false;
      break;
      case DOWN:
      downState = false;
      break;
    }
  }
  
}
