void pauseScreenHands() {  
  float leftopacity = 0;
  float rightopacity = 0;
  boolean leftactivated = false;
  
  imageMode(CENTER);
  if (leap_lefthandset && !gameOver) {
    leftopacity = random(0, 10);
    leftactivated = true;
  }
  else {
    leftopacity = 0;
  }

  if (leap_righthandset && !gameOver) {
    rightopacity = random(100, 140);
  }
  else {
    rightopacity = 0;
  }

  if ((right_y>=height/2+30)||(right_y<=height/2-30)) {
    right_step_y=-right_step_y;
  }
  right_y+=right_step_y;
  tint(255, pause_opacity-rightopacity-pause_gameOver_opacity);
  image(right, width-width/4, right_y);


  float tint_left_active = pause_opacity-left_op_active;
  float tint_left_inactive = pause_opacity-left_op_inactive;
  
  if(leap_lefthandset){
    if(leap_lefthand_fingercount > 1){
      tint_left_active = map(tint_left_active, -20, 260, 0, 100)+leftopacity;
      tint_left_inactive = map(tint_left_inactive, -20, 260, 0, 100)+leftopacity; 
      leftactivated = true;   
    }else{
      leftactivated = false;
    }
  }
  
  
  tint(255,tint_left_active -pause_gameOver_opacity);
   if(leftactivated){
     image(left_active_opacity, width/4, height/2);
   }else{
    image(left_active, width/4, height/2);
   }
 
  tint(255, tint_left_inactive-pause_gameOver_opacity);
  if(leftactivated){
     image(left_inactive_opacity, width/4, height/2);
   }else{
    image(left_inactive, width/4, height/2);
   }
  
  
  if (pausing) {  
    if(left_op_active<=0){
      left_op_step=18;
    }else if(left_op_active > 255){
      left_op_step=-18;
    } 
    
    left_op_active+=left_op_step;
    left_op_inactive+=left_op_step*-1;
    
  }


//  if ((left_op_active>=255)||(left_op_inactive>=255)) {
//    left_op_step_active=-left_op_step_active;
//    left_op_step_inactive=-left_op_step_inactive;
//  }
  
}

