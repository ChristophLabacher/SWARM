class DustContainer {
  ArrayList <Dust> dust;

  int dustContainer_my_id;
  float dustContainer_my_speed;
  float dustContainer_my_pos;
  PVector dustContainer_my_position;
  boolean dustContainer_my_alive = true;
  int dustContainer_my_updateCount;

  DustContainer(int id, float pos, float speed) {
    dustContainer_my_id = id;
    dustContainer_my_pos = pos;
    dustContainer_my_speed = speed;

    switch(id) { 
    case 1:
      light_beam = loadImage("light_beam_1.png");
      break;
    case 2:
      light_beam = loadImage("light_beam_2.png");
      break;
    case 3:
      light_beam = loadImage("light_beam_3.png");
      break;
    }

    dust = new ArrayList<Dust>();
    for (int i = 0; i < 80; i++) {
      dust.add(new Dust(i, dustContainer_my_pos, dustContainer_my_speed));
    }
  }

  // Aktualisiert die Position des Partikels
  void update() {
    for (Dust dust_: dust) { 
      dust_.update();
      //dust_.move();
    }

    if (worldtick) {
      dustContainer_my_updateCount+=gameOver_fadeTick*tickspeed;
    }
  }

  boolean done() {
    if (dustContainer_my_pos - (dustContainer_my_updateCount * dustContainer_my_speed)  < -(width)) {
      dustContainer_my_alive = false;

      for (int i = 0; i < dust.size(); i++) {
        dust.remove(i);
      }

      return true;
    }
    return false;
  }

  // Zeichnet Ellipse an der Position des Partikels und erzeugt flackern.
  void display() {
    pushMatrix();
    if (dustContainer_my_id==0) {
      translate(dustContainer_my_pos - (dustContainer_my_updateCount * dustContainer_my_speed), -200);
    }
    else {
      translate(dustContainer_my_pos - (dustContainer_my_updateCount * dustContainer_my_speed), 0);
    }

    for (Dust dust_: dust) { 
      dust_.display();
    }
    if (dustContainer_my_id!=0) {
      image(light_beam, 0, 0);
    }

    popMatrix();
  }
}

