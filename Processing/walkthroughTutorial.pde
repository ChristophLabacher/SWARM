


void walkthroughTutorial() {

  if (tutorial && fadeaway_time<40) { // fadeaway from startscreen
    fadeaway_time++;
    int fadeaway_step = floor(map(fadeaway_time, 0, width/10, 5, width/1.5));
    fadeaway_transp = floor(map(fadeaway_time, 0, 40, 0, 255));

    fadeaway+= fadeaway_step;
  }
  else if (tutorial) {
    startscreen = false;
  }



  if (tutorial && leap_righthandset && leap_lefthandset) { // ablauf der einführung #### im moment noch hart getimet auf die frameRate - kommt noch auf completion der ergebnisse

    fadeaway_time++;


    // fade in for the control visual
    if (tutorial && !control_visual.fadeIn) {
      control_visual.fadeIn = true;
      control_visual.fadeStart = frameCount;
    }

    if (fadeaway_time==50) {
      if (!helptexts.get(1).fadeIn) {
        helptexts.get(1).fadeStart = frameCount;
        helptexts.get(1).fadeIn = true;
      }
      startscreen = false;
    }

    if (fadeaway_time>60 && righthandY<370) {
      tutorial_topmax = true;
    }
    if (fadeaway_time>60 && righthandY>520) {
      tutorial_downmax = true;
    }

    if (tutorial_topmax && tutorial_downmax) {
      if (fadeaway_time<140) {
        fadeaway_time = 145;
        helptexts.get(1).fadeHalf=10;
      }
    }

    if (fadeaway_time==165) {
      if (!helptexts.get(1).fadeOut) {
        helptexts.get(1).fadeOut = true;
        helptexts.get(1).fadeStart = frameCount;
      }

      if (!focusbutton.fadeIn) {
        focusbutton.fadeIn = true;
        focusbutton.fadeStart = frameCount;
      }
    }


    if (fadeaway_time==170) {
      if (!helptexts.get(2).fadeIn) {
        helptexts.get(2).fadeStart = frameCount;
        helptexts.get(2).fadeIn = true;
      }
    }


    if (!tutorial_pinched && fadeaway_time<360 && fadeaway_time>250) {
      fadeaway_time = 340; 
    }


    if (tutorial_pinched) {
      helptexts.get(2).text = "And spread it again.";
    }


    if (tutorial_pinched && tutorial_released) {
      if (fadeaway_time<360) {
        helptexts.get(2).fadeHalf = 10;
        fadeaway_time = 365;
      }
    }


    if (fadeaway_time==380) {
      if (!helptexts.get(2).fadeOut) {
        helptexts.get(2).fadeOut = true;
        helptexts.get(2).fadeStart = frameCount;
      }
    }




    if (fadeaway_time==400) {
      if (!helptexts.get(3).fadeIn) {
        helptexts.get(3).fadeStart = frameCount;
        helptexts.get(3).fadeIn = true;
      }
    }

    if (fadeaway_time==460) {
      started = true;
      worldtick = true;
      tutorial = false;
      
      if (!helptexts.get(3).fadeOut) {
        helptexts.get(3).fadeOut = true;
        helptexts.get(3).fadeStart = frameCount;
        tutorial_released = true;
      }
      
    }
  }
}

