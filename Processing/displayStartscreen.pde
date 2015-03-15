void displayStartscreen() {
  // nicht pause bildschirm sondern startscreen
  noStroke();
  fill(0, random(140, 145)-fadeaway_transp);
  rect(width/2, height/2, width, height);
  imageMode(CORNER);
  tint(255, random(70, 100)-fadeaway_transp);
  image(logobg, 0-fadeaway, 64*0.2-creditfade/2);
  tint(255, random(150, 160)-fadeaway_transp);
  image(logo, 0-fadeaway, 64*0.2-creditfade/2);
  tint(255, 255);
  imageMode(CENTER);
  textFont(light, 60);
  textAlign(RIGHT);

  float credit_opacity_fadeOut = map(creditfade, 0, 60, 0, 255);
  float credit_opacity_fadeIn = map(creditfade, 40, 100, 255, 0);
  

  if (hoverstart && !pretutorial) {
    fill(255, random(200, 255)-fadeaway_transp * 2 - credit_opacity_fadeOut);
  }
  else {
    fill(255, random(100, 110)-fadeaway_transp - credit_opacity_fadeOut);
  }
  text("START", width-64-fadeaway*6, height-64*1.2-90); // x-fadeaway * 5 damit die schrift rechts schneller nach links wegfadet


  if (!hoverstart) {
    fill(255, random(200, 255)-fadeaway_transp - credit_opacity_fadeOut);
  }
  else {
    fill(255, random(100, 110)-fadeaway_transp - credit_opacity_fadeOut);
  }
  text("CREDITS", width-64-fadeaway*6, height-64*1.2);

  if (!hoverstart) {
    fill(255, random(200, 255)-fadeaway_transp - credit_opacity_fadeIn);
  }
  else {
    fill(255, random(100, 110)-fadeaway_transp - credit_opacity_fadeIn);
  }
  text("BACK", width-64-fadeaway*6, height-64*1.2); // x-fadeaway * 5 damit die schrift rechts schneller nach links wegfadet
  
}

