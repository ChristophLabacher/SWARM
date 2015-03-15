class Dust {
  int dust_my_id;
  PVector dust_my_position;
  PVector dust_my_center;
  PVector dust_my_velocity;
  PVector dust_my_acceleration;
  float dust_my_speed;
  PVector dust_my_size;
  PVector dust_my_jiggle;
  float dust_my_opacity;
  boolean dust_my_alive = true;
  int dust_my_updateCount;
  float dust_my_intPos;

  Dust(int id, float pos, float speed) {
    dust_my_id = id;
    dust_my_intPos = pos;
    dust_my_speed = speed;

    dust_my_position = new PVector(random(width/2-250, width/2+250), random(height/2-400, height/2+400));

    dust_my_center = new PVector(random(width/2-250, width/2+250), random(height/2-400, height/2+400));

    dust_my_velocity = new PVector(random(-0.5, 0.5), random(-0.5, 0.5));
    dust_my_acceleration = new PVector(0, 0);
    dust_my_size = new PVector(1, 1);
  }

  // Aktualisiert die Position des Partikels
  void update() {

    // Partikel bekommt alle 50 Frames eine neue Richtung
    if (dust_my_updateCount%600 == 0) {
      dust_my_velocity = new PVector(random(-1, 1), random(-1, 1));
    }

    float distance = dist(dust_my_position.x, dust_my_position.y, dust_my_center.x, dust_my_center.y);

    if (distance >= 140) {
      float x = dust_my_center.x - dust_my_position.x;
      float y = dust_my_center.y - dust_my_position.y;
      dust_my_velocity =  new PVector(x * 0.003, y * 0.003);
      //dust_my_velocity.rotate(90);
    }

    // Bewegung
    dust_my_velocity.add(dust_my_acceleration);
    dust_my_position.add(dust_my_velocity);
  }


  void move() {
    if (worldtick) {
      dust_my_position.x -= dust_my_speed*gameOver_fadeTick*tickspeed;
      dust_my_center.x -= dust_my_speed*gameOver_fadeTick*tickspeed;
    }
  }

  // Zeichnet Ellipse an der Position des Partikels und erzeugt flackern.
  void display() {
    pushMatrix();
    //dust_my_opacity = random(70, 160);
    float pos = abs(dust_my_position.x - width/2);
    dust_my_opacity = map(pos, 0, 250, 30, 0);
    fill(255, dust_my_opacity);
    translate(dust_my_position.get().x, dust_my_position.get().y);
    //ellipse(0, 0, dust_my_size.get().x, dust_my_size.get().y);
    tint(255, dust_my_opacity);
    imageMode(CENTER);
    image(dust_glow, 0, 0, 7, 7);
    imageMode(CORNER);
    tint(255, 255);
    
    
    
    popMatrix();
  }
}

