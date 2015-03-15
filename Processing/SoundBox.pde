class SoundBox {
  float soundbox_my_x;
  float soundbox_my_y;
  float soundbox_my_radius;
  float soundbox_my_inner_radius;
  float soundbox_my_inner_radius_limit;
  float soundbox_my_inner_radius_step;
  float soundbox_scrolling=-7;
  float soundbox_my_wigglex;
  float  soundbox_my_wiggley;
  float soundbox_my_sincount=random(0, 500);
  float soundbox_my_sinamplitude;
  float soundbox_my_sin;
  float soundbox_my_sinstep=1;
  float soundbox_my_stroke=2;
  float soundbox_my_stroketransparent;
  float soundbox_my_blur_rotation;

  int soundbox_my_timeout = 10;
  int soundbox_my_limit = 10; //anzahl der nötigen fireflies

  boolean soundbox_my_active;
  boolean soundbox_my_grow;

  float soundbox_my_transparent=100;
  float soundbox_my_counter=0;
  float soundbox_my_soundswitch;
  float soundbox_my_transparent_step;
  boolean soundbox_my_finished = false;
  

    SoundBox(float s, float x_, float y_) {  //sound switch  
    soundbox_my_soundswitch=s;
    soundbox_my_x = x_;
    soundbox_my_y = y_;
    soundbox_my_radius = 60;
    soundbox_my_inner_radius = 20;
    soundbox_my_inner_radius_limit = soundbox_my_inner_radius;
    soundbox_my_inner_radius_step = (soundbox_my_radius-soundbox_my_inner_radius)/soundbox_my_limit;
    soundbox_my_transparent_step = 155/(soundbox_my_radius-soundbox_my_inner_radius);
    soundbox_my_blur_rotation=random(0, 1500);

    switch(int(soundbox_my_soundswitch)) {
    case 0:
      sound=layer_sound1;
      break;
    case 1:
      sound=layer_sound2;
      break;
    case 2:
      sound=layer_sound3;
      break;
    case 3:
      sound=layer_sound4;
      break;
    case 4:
      sound=layer_sound5;
      break;
    case 5:
      sound=layer_sound6;
      break;
    }
    sounds.add(sound);
  }


  void activating() {
    for (Firefly f: fireflies) {
      if (((dist(f.firefly_my_position.get().x, f.firefly_my_position.get().y, soundbox_my_x, soundbox_my_y) < soundbox_my_inner_radius))&&(f.firefly_my_alive)&&(soundbox_my_counter<=soundbox_my_limit)) {
        soundbox_my_grow = true;
        this.soundbox_my_counter++;
        f.firefly_my_alive_dying=true;
        lastSoundBoxTouch = frameCount;
        //println(soundbox_my_counter);

        soundbox_my_timeout=15;
        soundbox_my_inner_radius_limit+=soundbox_my_inner_radius_step; // mit dem step hochzählen — dann grow bis zu step - dann grow pause - falls timeout dann inner_radius_limit zurück und timeout zurück
      }
      if (soundbox_my_counter >= soundbox_my_limit) {
        soundbox_my_grow = true;
        soundbox_my_finished = true;
      }
    }
  }

  void update() {
    if (!soundbox_my_active) {
      activating();
      if (soundbox_my_grow) {
        if (soundbox_my_inner_radius < soundbox_my_inner_radius_limit) {
          soundbox_my_inner_radius++;
          soundbox_my_transparent+=soundbox_my_transparent_step;
        }
      }
      else {
        if (soundbox_my_inner_radius > 20 && soundbox_my_timeout == 0) {
          soundbox_my_inner_radius--;
        }
        if (soundbox_my_inner_radius == 20 && soundbox_my_timeout == 0) {
          soundbox_my_counter = 0;
        }
        if (soundbox_my_transparent>=100  && soundbox_my_timeout == 0) {
          soundbox_my_transparent-=soundbox_my_transparent_step;
        }
      }

      if (soundbox_my_timeout > 0) {
        if (!soundbox_my_finished) {
          soundbox_my_timeout--;
        }
      }
      else {
        soundbox_my_grow = false;
        soundbox_my_inner_radius_limit = 20;
      }

      //

      if (soundbox_my_inner_radius == soundbox_my_radius-10) {
        game_medals++;
        soundbox_my_active = true;
        trigger_music();
        soundbox_my_transparent=255;
      }
    }
  }

  void display() {
    soundbox_my_wigglex=random(-1, 1);
    soundbox_my_wiggley=random(-0.25, 0.25);
    if (soundbox_my_active) {
      soundbox_my_radius=random(60, 80);
      soundbox_my_stroketransparent=100;
    }
    else {
      soundbox_my_stroketransparent=soundbox_my_transparent/3;
    }
    pushMatrix();
    translate(soundbox_my_x, soundbox_my_y);
    
    noStroke();
    if (!soundbox_my_active) {
      fill(0, 157, 235, random(soundbox_my_transparent-50,soundbox_my_transparent));
    }
    else {
      fill(0, 157, 235, random(soundbox_my_transparent-50, soundbox_my_transparent));
    }
    ellipse(0, 0+5*sin(soundbox_my_sincount/4+soundbox_my_wiggley), soundbox_my_inner_radius, soundbox_my_inner_radius);
    noFill();
    strokeWeight(soundbox_my_stroke);
    stroke(0, 157, 235, random(50, soundbox_my_stroketransparent));
    ellipse(0, 0+5*sin(soundbox_my_sincount/4+soundbox_my_wiggley), soundbox_my_radius, soundbox_my_radius);
    tint(255,100);
    image(soundblur, 0, 5*sin(soundbox_my_sincount/4+soundbox_my_wiggley));
    fill(0, 157, 235, random(100, 255));
    translate(0, 0+5*sin(soundbox_my_sincount/4+soundbox_my_wiggley));
    rotate(radians(soundbox_my_blur_rotation+frameCount*30));
    //ellipse(0,32+5*sin(soundbox_my_sincount/4+soundbox_my_wiggley),5,5);
    tint((255), random(200, 255));
    image(sound_rotate_blur, 0, 0);
    popMatrix();
    if (worldtick) {
      soundbox_my_x+=soundbox_scrolling*gameOver_fadeTick*tickspeed;
    }
    soundbox_my_sincount+=soundbox_my_sinstep;

    if (soundbox_my_sincount>1900) {
      soundbox_my_sinstep=-soundbox_my_sinstep;
    }
  }

  void trigger_music() {
  }
}

