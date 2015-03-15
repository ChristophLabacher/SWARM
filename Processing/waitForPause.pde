void waitForPause() {

  //if(!pretutorial){
  if (!leap_righthandset || !leap_lefthandset) { // pause modus falls righthandset is false
    if (!waiting) {
      waiting = true;
      wait_firstFrameCount = frameCount;
    }
    if (waiting && frameCount-wait_firstFrameCount>3) {
      if (!pausing) {  // vielleicht noch 5frames warten bevor auf pause geschaltet wird… —> nicht immer direkt in die pause gehen
        pause_firstFrameCount = frameCount;
        pausing = true;
      }
      waiting = false;
    }
  }
  // }

  if (leap_righthandset && leap_lefthandset) {
    waiting = false;
    if (leap_lefthand_fingercount > 1) {
      if (pausing) {
        pause_firstFrameCount = frameCount;
      }
      pausing = false;
    }
  }
}

