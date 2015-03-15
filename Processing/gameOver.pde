void gameOver() { // win - ob man es bis zum Ende geschafft hat - dann werden Medallien angezeigt
  gameOver_frameCount++ ;


  if (win) {
    if (gameOver_frameCount < 300) {
      gameOver_fadeTick_sound = map(gameOver_frameCount, 0, 300, 1, 0.6);
    }
    else {
      gameOver_fadeTick_sound = map(gameOver_frameCount, 300, 330, 0.6, 0);
    }
  }
  else {
    if (gameOver_frameCount < 70) {
      gameOver_fadeTick_sound = map(gameOver_frameCount, 0, 70, 1, 0.6);
    }
    else {
      gameOver_fadeTick_sound = map(gameOver_frameCount, 70, 80, 0.6, 0);
    }
  }

  if (gameOver_frameCount < 230) {
    if (win) {
      gameOver_opacity = map(gameOver_frameCount, 0, 200, 0, 255);
      
      pause_gameOver_opacity = map(gameOver_frameCount, 0, 60, 0, 255);
      
      gameOver_fadeTick = map(gameOver_frameCount, 0, 190, 1, 0);
    }
    else {
      gameOver_opacity = map(gameOver_frameCount, 0, 80, 0, 255);
      
      pause_gameOver_opacity = map(gameOver_frameCount, 0, 60, 0, 255);
      
      gameOver_fadeTick = map(gameOver_frameCount, 0, 100, 1, 0);
    }
  }
  else {
    worldtick = false;
    fireflytick = false;
  }

  tint(255, gameOver_opacity);
  imageMode(CORNER);
  image(vignette_gameOver, 0, 0);
  imageMode(CENTER);
  fill(0, gameOver_opacity-50);
  rect(width/2, height/2, width, height);
  if (!control_visual.fadeOut) {
    control_visual.fadeStart = frameCount;
    control_visual.fadeOut = true;
  }
  if (!focusbutton.fadeOut) {
    focusbutton.fadeStart = frameCount;
    focusbutton.fadeOut = true;
  }




  if (win) {

    if (gameOver_frameCount >= 170 && gameOver_frameCount <210) {
      gameOver_medalOpacity = map(gameOver_frameCount, 150, 190, 0, 28);
    }
    else if (gameOver_frameCount >= 210) {
      gameOver_medalOpacity = random(28, 36);
    }



    win_screen();

    if (gameOver_frameCount > 330) { // complete reset for win - slow fadeOut and back to startscreen
      fill(255);
      //text(" winn - now reset ", width/2, height/2);
      fill(0);




      started = false;
      worldtick = false;
      startscreen = true;
      tutorial = false;
      gameOver = false;
      gameOver_frameCount = 0;
      gameOver_opacity = 0;
      game_medals = 0;
      pause_gameOver_opacity = 0;
      gameOver_fadeTick = 1;
      gameOver_fadeTick_sound = 1;
      fadeaway_time = 0;
      fadeaway = 0;
      pretutorial = true;
      changeCount = 0;
      gameOver_medalOpacity = 0;
      tickspeed = 0;

      //   fireflies = new ArrayList<Firefly>();
      for (Firefly firefly: fireflies) {
        firefly.firefly_my_position = new PVector(200+ firefly.firefly_my_id*3, random(height/2-random(25, 75), height/2+random(25, 75)));
        firefly.firefly_my_center = new PVector(200 + firefly.firefly_my_id*3, random(height/2+50, height/2+50));
        firefly.firefly_my_center_start = 200 + firefly.firefly_my_id*3;
        firefly.firefly_my_velocity = new PVector(random(-1, 1), random(-1, 1));
        firefly.firefly_my_acceleration = new PVector(0, 0);
        firefly.firefly_my_size = new PVector(4, 4);
        firefly.firefly_my_spread_velocity = new PVector(random(-7, 7), random(-7, 7));
        firefly.firefly_my_alive = true;
        firefly.firefly_my_spreadCount = 100;
        firefly.firefly_my_focused = false;
        firefly.dying = false;
        firefly.dyingcount = 0;
      }

      fadeaway_transp = 0;

      paralax_fg = 0;
      paralax_bg = 0;
      paralax_blur = 0;

      fadeDown = true;


      pause_opacity = 180;
      pausing = true;
      paused = true;
      unpausing = false;

      firstclicked = false;
      // soundspots
      spots = new ArrayList<SoundBox>();
      spots.add(new SoundBox(0, 1600, 400));
      spots.add(new SoundBox(1, 4151, 300));
      spots.add(new SoundBox(2, 5738, 174));
      spots.add(new SoundBox(3, 9031, 321));
      spots.add(new SoundBox(4, 10370, 555));
      spots.add(new SoundBox(5, 12319, 155));
      for (int i=0;i<spots.size();i++) {
        sounds.get(i).setGain(-100);
        sounds.get(i).loop();
      }
      medal = new ArrayList<Medal>();
      for (int i = 0; i < 3; i++) {
        medal.add(new Medal());
      }
    }
  }
  else {
    if (gameOver_frameCount > 70) {
      fill(255);
      //text(" lose - now reset ", width/2, height/2);
      fill(0);

      fadeDown = true;

      started = true;
      worldtick = true;
      tutorial = false;
      gameOver = false;
      gameOver_frameCount = 0;
      game_medals = 0;
      gameOver_opacity = 0;
      pause_gameOver_opacity = 0;
      gameOver_fadeTick = 1;
      gameOver_fadeTick_sound = 1;
      gameOver_medalOpacity = 0;

      control_visual.fadeStart = frameCount;
      control_visual.fadeOut = false;
      control_visual.fadeIn = true;

      changeCount = 0;
      tickspeed = 0;
      
      focusbutton.fadeStart = frameCount;
      focusbutton.fadeOut = false;
      focusbutton.fadeIn = true;

      // soundspots
      spots = new ArrayList<SoundBox>();
      spots.add(new SoundBox(0, 1600, 400));
      spots.add(new SoundBox(1, 4151, 300));
      spots.add(new SoundBox(2, 5738, 174));
      spots.add(new SoundBox(3, 9031, 321));
      spots.add(new SoundBox(4, 10370, 555));
      spots.add(new SoundBox(5, 12319, 155));
      for (int i=0;i<spots.size();i++) {
        sounds.get(i).setGain(-100);
        sounds.get(i).loop();
      }

      paralax_fg = 0;
      paralax_bg = 0;
      paralax_blur = 0;


      for (Firefly firefly: fireflies) {
        firefly.firefly_my_position = new PVector(200+ firefly.firefly_my_id*3, random(height/2-random(25, 75), height/2+random(25, 75)));
        firefly.firefly_my_center = new PVector(200 + firefly.firefly_my_id*3, random(height/2+50, height/2+50));
        firefly.firefly_my_center_start = 200 + firefly.firefly_my_id*3;
        firefly.firefly_my_velocity = new PVector(random(-1, 1), random(-1, 1));
        firefly.firefly_my_acceleration = new PVector(0, 0);
        firefly.firefly_my_size = new PVector(4, 4);
        firefly.firefly_my_spread_velocity = new PVector(random(-7, 7), random(-7, 7));
        firefly.firefly_my_alive = true;
        firefly.firefly_my_spreadCount = 100;
        firefly.firefly_my_focused = false;
        firefly.dying = false;
        firefly.dyingcount = 0;
      }

      pause_opacity = 180;
      pausing = true;
      paused = true;
      unpausing = false;


      //#### fehlt noch ein reset der soundboxen und wahrscheinlich grain
    }
  }
}


void win_screen() {
  if (gameOver_frameCount > 80) {
    switch(floor(game_medals/2)) {
    case 1:
      medal.get(0).medal_my_active=true;
      medal.get(1).medal_my_active=false;
      medal.get(2).medal_my_active=false;
      break;
    case 2:
      medal.get(0).medal_my_active=true;
      if (medal.get(0).medal_my_opacity_raised) {
        medal.get(1).medal_my_active=true;
        medal.get(1).medal_my_opacity_raised=false;
      }
      medal.get(2).medal_my_active=false;
      break;
    case 3:
      medal.get(0).medal_my_active=true;
      if (medal.get(0).medal_my_opacity_raised) {
        medal.get(1).medal_my_active=true;
        if (medal.get(1).medal_my_opacity<255) {
          medal.get(1).medal_my_opacity_raised=false;
        }
      }
      if (medal.get(0).medal_my_opacity_raised&&medal.get(1).medal_my_opacity_raised) {
        medal.get(2).medal_my_active=true;
        if (medal.get(2).medal_my_opacity<255) {
          medal.get(2).medal_my_opacity_raised=false;
        }
      }
      break;
    }
  }

  medal.get(0).display(0);
  medal.get(1).display(1);
  medal.get(2).display(2);
}

