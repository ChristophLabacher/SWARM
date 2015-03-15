void showCreditscreen() {
  if (!creditOut) {
    creditset = true;
    if (creditfade<200) {
      creditfade+=creditsteps;
    }
    creditsteps = map(creditfade, 30, 200, 20, 10);
    creditopacity = map(creditfade, 30, 200, 0, 255);
  }
  else {
    creditset = false;
    if (creditfade>=0) {
      creditfade-=creditsteps;
    }
    creditopacity = map(creditfade, 30, 200, 0, 255);
    creditsteps = map(creditfade, 30, 200, 20, 10);

    if (creditfade<=0) {
      creditscreen = false;
      creditOut = false;
      firstclicked = false;
    }
  }

  fill(255);  // hier ist die anzeige des startscreens
  textAlign(LEFT);
  fill(255, creditopacity*3-random(0, 50));
  textFont(light20, 20);
  text("A game by", 64, 210);
  textFont(regular20, 20);
  fill(255, creditopacity*2.8-random(0, 50));
  text("Nikolas Klein", 64, 270);
  fill(255, creditopacity*2.1-random(0, 50));
  text("Christoph Labacher", 64, 300);
  fill(255, creditopacity*2.5-random(0, 50));
  text("Florian Ludwig", 64, 330);
  fill(255, creditopacity*1.7-random(0, 50));
  text("Miguel Pawlowski", 64, 360);
  fill(255, creditopacity*1-random(0, 50));
  textFont(light20, 20);
  text("Interaktionsgestaltung 2", 64, 445);
  text("3 dim. Grundlagen im medialen Raum", 64, 475);
  text("Summer term 2014", 64, 505);
  fill(255, creditopacity-random(0, 50));
  textFont(regular20, 20);
  text("Prof. Dr. Franklin Hernández-Castro", 64, 565);

  //  textFont(light, 20);
  //  text("Interaction Design 2", 300, 190);
  //  textFont(regular, 20);
  //  text("3D basics im medialen Raum, bei", 300, 240);  
  //  text("Prof. Dr. Franklin Hernández-Castro", 300, 280);  


  imageMode(CORNER);
  tint(255, creditopacity*0.85-random(0, 50));
  image(hfglogo, 64, height-64*1.2-71);
  imageMode(CENTER);


  if (leap_righthandset && leap_lefthandset && creditfade > 180) {
    float righthandposy = map(leap_righthand.getPosition().y, 200, 650, 0, height);

    if (hoverstart && leap_lefthand_fingercount > 1) {
      hoverstart = false;
    }
    if (!hoverstart && leap_lefthand_fingercount<=1 && leap_lefthand_spreaded) {
      creditOut = true;
      leap_lefthand_spreaded = false;
    }
  }
  else if (!leap_righthandset) {
    hoverstart = true;
  }
  else if (leap_righthandset && creditfade < 180) {
    float righthandposy = map(leap_righthand.getPosition().y, 200, 650, 0, height);
    if (righthandposy < 550) {
      hoverstart = true;
    }
  }
}

