
void leftHandGestures() {

  // lefthand gesten
  if (leap_lefthandset && !gameOver) {
    if (focusbutton.fadeIn || startscreen) {
      //finger reset
      leap_lefthand_fingercount=0;
      PVector fingertime = new PVector(0, 0, 0);
      // FINGERS
      for (Finger finger : leap_lefthand.getFingers()) {
        leap_lefthand_fingercount++;
        // Basics
        //finger.draw();
        int     finger_id         = finger.getId();
        PVector finger_position   = finger.getPosition();
        PVector finger_stabilized = finger.getStabilizedPosition();
        PVector finger_velocity   = finger.getVelocity();
        PVector finger_direction  = finger.getDirection();
        float   finger_time       = finger.getTimeVisible();
      }

      // text(leap_lefthand_fingercount, 20, 60);
      if (focusbutton.fadeIn && fireflytick && !startscreen) {


        if (leap_lefthand_fingercount>1 || focusfailed) {
          if (!normal) {
            focusmode = false;
            normal = true;
            for (Firefly firefly: fireflies) {
              firefly.spread(focustime);
            }
            if(focustime>5){
              if(!tutorial_released){
                tutorial_released = true;
              }
            }
          }

          if (leap_lefthand_fingercount>1 && focusfailed) {
            focusfailed = false;
          }

          float slowdown = floor(map(focusenergy, focusenergymax, 0, 1, 2)); // slowdown => easing 
          if (focusenergy<focusenergymax && frameCount % slowdown == 0) {
            focusenergy++;
            focusbutton.reloading = true;
            if (focusenergy<focusbutton.lowenergylevel) {
              focusbutton.lowenergy = true;
            }
            else {
              focusbutton.lowenergy = false;
            }
            focusbutton.state = map(focusenergy, 0, focusenergymax, -90, 270);
          }

          prevFrameCount = frameCount;
        }
        else {
          if (focusenergy>focusbutton.lowenergylevel || focusmode) {
            focusfailed = false;
            normal = false;
            focusmode = true;
            focusbutton.reloading = false;
            focustime = frameCount-prevFrameCount;
            lastFrameCount = frameCount;
            
            if(!tutorial_pinched && focustime>15){
              tutorial_pinched = true;
            }

            for (Firefly firefly: fireflies) {
              firefly.focus();
            }

            float slowdown = floor(map(focusenergy, focusenergymax, 0, 2, 1));

            //text( focusenergy + " focusenergy % " + slowdown, 20, 100 );

            if (focusenergy>0 && frameCount % slowdown == 0) {
              focusenergy--;
              focusbutton.state = map(focusenergy, 0, focusenergymax, -90, 270);
            }

            if (focusenergy <= 0) {
              focusmode = false;
              focusfailed = true;
            }
            //text("focustime! " + focustime, 20, 80);
          }
          else {
            //text("not enough focusenergy to start! ", 20, 80);
            focusmode = false;
            focusfailed = true;
          }
        }
      }
    }
  }
}

