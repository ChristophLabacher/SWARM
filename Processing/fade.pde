float fade(int startFrame, int fadeTime, boolean inOut) {
  if (inOut) { //fadeIn
    int diff = frameCount-startFrame;
    return map(diff, 0, fadeTime, 255, 0); //
  }
  else {
    int diff = frameCount-startFrame;
    return map(diff, 0, fadeTime, 0, 255); //
  }
}

