class Control {
  float control_my_posx;
  float control_my_posy;
  float control_my_opacity;

  boolean fadeIn = false;
  boolean fadeOut = false;
  int fadeStart = 0;
  float transp = 255;
  int fadeTime = 20;


  Control() {
    control_my_opacity=150;
  }
  void display() {

      if(transp>0 && fadeIn){
        transp = fade(fadeStart, 20, true);
      }
      
      if(transp<255 && fadeOut){
        transp = fade(fadeStart, 20, false);
      }

      control_my_posx=control_x;
      control_my_posy=control_y;
      tint(255, random(100-transp, control_my_opacity-transp));
      image(control_blur, control_my_posx, control_my_posy);
   
  }
}

