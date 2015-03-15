void setStartscreen() {

  if (leap_lefthandset && leap_righthandset) {

    float righthandposy = map(leap_righthand.getPosition().y, 200, 650, 0, height);

    if (righthandposy < 550 && !firstclicked) { // general check if lefthand is on start/credits
      if (!hoverstart && leap_lefthand_fingercount > 1) {
        helpFrameCount = frameCount;
        hoverstart = true;
      }
      if (hoverstart && leap_lefthand_fingercount<=1  && creditfade <= 0 && leap_lefthand_spreaded) {        
        leap_lefthand_spreaded = false;
        firstclicked = true;
        tutorial = true;
        if (tutorial_released) { // to check if it starts the second time - then display the gui immediatly and jump the tutorial
          control_visual.fadeStart = frameCount;
          control_visual.fadeOut = false;
          control_visual.fadeIn = true;

          focusbutton.fadeStart = frameCount;
          focusbutton.fadeOut = false;
          focusbutton.fadeIn = true;
        }
      }
    }
    else if (righthandposy >= 600 && !firstclicked) {
      if (hoverstart && leap_lefthand_fingercount > 1) {
        helpFrameCount = frameCount;
        hoverstart=false;
      }
      if (!hoverstart && leap_lefthand_fingercount<=1  && creditfade <= 0 && leap_lefthand_spreaded) {
        firstclicked = true;
        creditscreen = true;
        leap_lefthand_spreaded = false;
      }
    }
  }
  //handerkennungen auswerten zum starten
}

