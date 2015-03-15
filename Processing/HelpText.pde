class HelpText {
  boolean fadeIn = false;
  boolean fadeOut = false;
  boolean thisfadeaway = false;
  int fadeHalf = 0;
  

  String text = "";

  int fadeStart = 0;
  float transp = 255;
  float posX, posY;

  HelpText(float _posX, float _posY, String _text, boolean _fadeaway) {
    posX = _posX;
    posY = _posY;

    text = _text;

    thisfadeaway = _fadeaway;
  }


  void display() {

    if (fadeIn && transp>0) {
      transp = fade(fadeStart, 10, true);
    }

    if (fadeOut && transp<255) {
      transp = fade(fadeStart, 10, false);
    }


    if(fadeHalf > 0){
      fill(255, random(200 - transp - fadeHalf, 210 - transp - fadeHalf));
    }else{
      fill(255, random(200 - transp, 255 - transp));
    }
    


    textFont(regular, 30);
    textAlign(RIGHT);
    if (!thisfadeaway) {
      text(text, posX, posY);
    }
    else {
      text(text, posX-fadeaway, posY);
    }
  }
}

