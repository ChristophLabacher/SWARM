class Medal {
  boolean medal_my_active;
  boolean medal_my_opacity_raised = false;
  float medal_my_id;
  float medal_my_step=300;
  float medal_my_opacity=0;
  Medal() {
    medal_my_active=false;
    medal_my_opacity_raised=false;
  }

  void display(int n) {
    stroke(240, 220, 0, medal_my_opacity+gameOver_medalOpacity);
    fill(240, 220, 0, medal_my_opacity+gameOver_medalOpacity);
    ellipse((width/2+n*medal_my_step)-medal_my_step, height/2, 80, 80);
    strokeWeight(2);
    fill(0, 0);
    ellipse((width/2+n*medal_my_step)-medal_my_step, height/2, 120, 120);
    if (medal_my_active) {
      tint(255, random(medal_my_opacity-50,medal_my_opacity)+gameOver_medalOpacity);
      image(medal_blur, (width/2+n*medal_my_step)-medal_my_step, height/2);
    }
    opacity();
  }

  void opacity() {
    
    if (medal_my_active && !medal_my_opacity_raised && medal_my_opacity<=255) {
      medal_my_opacity+=10;
    }
    else if(medal_my_opacity>=255) {
      medal_my_opacity_raised=true;
    }
  }
}

