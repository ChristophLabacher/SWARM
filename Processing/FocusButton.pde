class FocusButton {
  // GUI-BUTTON
  float radius = 80;
  float state = 270;
  float transparency_white = 70;
  float transparency_yellow = 100;
  float lowenergylevel = focusenergymax*0.33; //

  boolean reloading = false;
  boolean lowenergy = false;
  boolean fadeIn = false;  
  int fadeStart = 0;
  float transp = 255;  
  
  boolean fadeOut = false; // fadeOut noch machen

  FocusButton() {}

  void display() {
      
      if (fadeIn && transp>0 && !fadeOut) {
        transp = fade(fadeStart, 20, true);
      }
      
      if(fadeOut && transp<255){
        transp = fade(fadeStart, 20, false);
      }
      
      
      if (focusmode) {
        transparency_yellow = 255-transp;
        transparency_white = 70-transp;
      }
      else {
        transparency_yellow = 100-transp;
        transparency_white = 70-transp;
      }

      fill(0, 0);

      stroke(255, transparency_white-transp-pause_opacity*0.2);
      strokeWeight(4);
      ellipse(radius, height - radius, radius, radius);

      stroke(240, 220, 0, transparency_yellow-transp-pause_opacity*0.8);
      if (reloading && lowenergy) {
        stroke(240, 0, 0, transparency_yellow-40-transp-pause_opacity*0.8);
      }
      arc(radius, height - radius, radius, radius, radians(-90), radians(state));

      strokeWeight(0);
    
  }
}

