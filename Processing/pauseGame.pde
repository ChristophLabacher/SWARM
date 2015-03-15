void pauseGame() {

  if (pausing) {

    if (leap_lefthandset && leap_righthandset && !paused) {
      //pausing = false;
    }

    worldtick = false;
    fireflytick = false;

    if (frameCount-pause_firstFrameCount <= pause_fadeTime && !pretutorial) {
      pause_opacity = map(frameCount-pause_firstFrameCount, 0, pause_fadeTime, 0, pause_opacity_max);
      soundpause = map(frameCount-pause_firstFrameCount, 0, pause_fadeTime, 0, 20);
    }
    else {
      paused = true;
    }

    noStroke();
    fill(0, pause_opacity);
    rect(width/2, height/2, width, height);
    pauseScreenHands();
  }


  if (!pausing) {
    
    if (frameCount-pause_firstFrameCount <= pause_fadeTime) {
      pause_opacity = map(frameCount-pause_firstFrameCount, 0, pause_fadeTime, pause_opacity_max, 0);
      soundpause = map(frameCount-pause_firstFrameCount, 0, pause_fadeTime, 20, 0);
    }


    noStroke();
    fill(0, pause_opacity);
    rect(width/2, height/2, width, height);
    
    if (frameCount-pause_firstFrameCount >= pause_fadeTime) {
      if (!pretutorial) {
        fireflytick = true;
        if (tutorial || startscreen) {
          worldtick = false;
        }
        else {
          worldtick = true;
        }
      }
      else {
        fireflytick = true;
        pretutorial = false;
      }

      paused = false;
      pausing = false;
      unpausing = false;

    }else{
      pauseScreenHands();    
    }
  }
}

