class Firefly {
  int firefly_my_id;
  PVector firefly_my_position;
  PVector firefly_my_center;
  float firefly_my_center_start;
  PVector firefly_my_velocity;
  PVector firefly_my_aim;
  PVector firefly_my_acceleration;
  PVector firefly_my_size;
  PVector firefly_my_jiggle;
  float firefly_my_opacity;
  int firefly_my_updateCount;
  int firefly_my_spreadCount = 100;
  PVector firefly_my_spread_velocity;
  boolean firefly_my_alive = true;
  boolean firefly_my_alive_dying = false;
  boolean firefly_my_contained;
  boolean firefly_my_frontmost;
  boolean firefly_my_focused = false;
  boolean dying = false;
  int dyingcount = 0;

  Firefly(int id) {
    firefly_my_id = id;

    firefly_my_position = new PVector(200+ firefly_my_id*3, random(height/2-random(25, 75), height/2+random(25, 75)));
    firefly_my_center = new PVector(200 + firefly_my_id*3, random(height/2+50, height/2+50));
    firefly_my_center_start = 200 + firefly_my_id*3;
    firefly_my_velocity = new PVector(random(-1, 1), random(-1, 1));
    firefly_my_acceleration = new PVector(0, 0);
    firefly_my_size = new PVector(4, 4);
    firefly_my_spread_velocity = new PVector(random(-7, 7), random(-7, 7));
  }

  // Aktualisiert die Position des Partikels
  void update() {
    firefly_my_frontmost = false;

    if (firefly_my_center.x == firefly_frontmost_x) {
      firefly_my_frontmost = true;
    };

    // Partikel bekommt alle 50 Frames eine neue Richtung
    if (firefly_my_updateCount%50 == 0) {
      firefly_my_velocity = new PVector(random(-1, 1), random(-2, 2));
    }

    // Jiggle des Partikels wird in jedem Frame zufällig erzeugt
    firefly_my_jiggle = new PVector(random(-1, 1), random(-1, 1));
    firefly_my_position.add(firefly_my_jiggle);

    if (fireflytick) {

      float distance = dist(firefly_my_position.x, firefly_my_position.y, firefly_my_center.x, firefly_my_center.y);

      if (distance >= 100) {
        float x = firefly_my_center.x - firefly_my_position.x;
        float y = firefly_my_center.y - firefly_my_position.y;
        firefly_my_velocity =  new PVector(x * 0.02, y * 0.02);
      }

      follow();

      if (firefly_my_spreadCount < 30) {
        firefly_my_velocity =  firefly_my_spread_velocity;
        firefly_my_spreadCount++;

        if (firefly_my_spreadCount == 20) {
          firefly_my_spread_velocity.add(random(-5, 5), random(-5, 5), 0);
        }
        if (firefly_my_spreadCount > 20) {
          float x = firefly_my_center_start - firefly_my_position.x;
          float y = height/2 - firefly_my_position.y;
          firefly_my_velocity.add(new PVector(x * 0.004, y * 0.004));
        }
      }

      // Bewegung
      firefly_my_velocity.add(firefly_my_acceleration);
      firefly_my_position.add(firefly_my_velocity);
    }

    firefly_my_center.y = constrain(firefly_my_center.y, 0, height);
    firefly_my_updateCount++;

    collision();
  }

  float followY = height/2+50, followx = 0; // außerhalb gesetzt, da falls es nicht erkannt wird auf der letzten erkannten position bleibt
  float followX = width-width/4;
  // Lässt die Partikel der Maus folgen
  void follow() {
    if (leap_righthandset && !gameOver) { // wenn rechte hand da ist werte mappen
      if (startscreen && leap_righthandset) { // werte für startscreen enger mappen
        followY = map(righthandY, 360, 620, height/3, height-height/5);
      }
      else if(leap_righthandset) {
        followY = map(righthandY, 360, 620, 0, height);
      }

      //followx = map(leap_righthand.getPosition().x, 800, 1200, 500, width-100);
    }
    else {
      //followY = height;
    }
    noStroke();
    fill(200, 10);

    //control => flo's control button 
    control_x=followX;
    control_y=followY;

    if (firefly_my_frontmost) {
      float distanceY = abs(followY - firefly_my_center.y);
      float changeRateY = map(distanceY, 0, height/2, 0, 50);
      if (followY > firefly_my_center.y) {
        firefly_my_center.y += changeRateY;
        firefly_my_position.y += changeRateY;
      }
      if (followY < firefly_my_center.y) {
        firefly_my_center.y -= changeRateY;
        firefly_my_position.y -= changeRateY;
      }
    }
    else {
      float closest_distance = 500;
      int closest_firefly = 0;

      for (int i = 0; i < fireflies.size(); i++) {
        float distance = fireflies.get(i).firefly_my_center.x - firefly_my_center.x;
        if (distance < closest_distance && distance > 0 && fireflies.get(i).firefly_my_alive) {
          closest_distance = distance;
          closest_firefly = i;
        }
      };

      stroke(255, 40);
      // line(fireflies.get(closest_firefly).firefly_my_position.x, fireflies.get(closest_firefly).firefly_my_position.y, firefly_my_position.x, firefly_my_position.y);
      noStroke();

      float next_pos_y;
      next_pos_y = fireflies.get(closest_firefly).firefly_my_center.y;

      float distanceY = abs(next_pos_y - firefly_my_center.y);
      float changeRateY = map(distanceY, 0, height, 0, 800);
      if (next_pos_y > firefly_my_center.y) {
        firefly_my_center.y += changeRateY;
        firefly_my_position.y += changeRateY;
      }
      if (next_pos_y < firefly_my_center.y) {
        firefly_my_center.y -= changeRateY;
        firefly_my_position.y -= changeRateY;
      }

      //fill(255, 0, 0);
      //ellipse(firefly_my_center.x, firefly_my_center.y, 3, 3);
    }
  }

  boolean done() {
    if (firefly_my_position.x  < 0 || firefly_my_center.x  < 0 || !firefly_my_alive) {
      firefly_my_alive = false;
      return true;
    }
    else if (firefly_my_alive_dying && frameCount - lastSoundBoxTouch < 75) { // to eliminate position jumping after activating a sound box
      dyingcount++;
      dying = true;
      if (dyingcount<dyingtime) {
        return false;
      }
      else {
        firefly_my_alive = false;
        return true;
      }
    }
    return false;
  }

  void collision() {

    // TOP ////////////////////////////////////////////////////////////////
    for (int i = 0; i<topPoints.length; i++) {
      if (topPoints[i] != null) {
        for (int j = 0; j<topPoints[i].length-1; j++) {

          if (topPoints[i][j].x  > changeCount  && topPoints[i][j].x < changeCount + 650) {
            if (dist(topPoints[i][j].x - changeCount, topPoints[i][j].y, firefly_my_position.x, firefly_my_position.y) < 25) {
              ///firefly_my_velocity.rotate(radians(90));
              firefly_my_velocity.set(new PVector(0, 0));
              firefly_my_position.x -= change*2;
              firefly_my_position.y += change;
            }
          }

          float distX = topPoints[i][j+1].x - topPoints[i][j].x;
          float distY = topPoints[i][j+1].y - topPoints[i][j].y;
          float wholedist = dist(topPoints[i][j].x, topPoints[i][j].y, topPoints[i][j+1].x, topPoints[i][j+1].y);
          float wholeLerpCount = abs(wholedist / 1);

          for (int k = 1; k < wholeLerpCount; k++) {
            float lerpX = (distX / wholeLerpCount) * k;
            float lerpY = (distY / wholeLerpCount) * k;
            if (dist(topPoints[i][j].x - changeCount + lerpX, topPoints[i][j].y + lerpY, firefly_my_position.x, firefly_my_position.y) < 25) {
              firefly_my_velocity.set(new PVector(0, 0));
              firefly_my_position.x -= change*2;
              firefly_my_position.y += change;
            }
          }

          if (distX < 4 && distX >= 0 && distY > 0) {
            for (int k = 1; k < wholeLerpCount; k++) {
              if (dist(topPoints[i][j].x - changeCount, topPoints[i][j].y + k, firefly_my_position.x, firefly_my_position.y) < 25) {
                firefly_my_velocity.set(new PVector(0, 0));
                firefly_my_position.x -= change*2;
                firefly_my_position.y += change;
              }
            }
          }

          if (distX < 4 && distX >= 0 && distY <= 0) {
            for (int k = 0; k < wholeLerpCount; k++) {
              if (dist(topPoints[i][j].x - 1 - changeCount, topPoints[i][j].y - k, firefly_my_position.x, firefly_my_position.y) < 25) {
                firefly_my_velocity.set(new PVector(0, 0));
                firefly_my_position.x -= change*2;
                firefly_my_position.y += change;
              }
            }
          }
        }
      }
    }

    // BOTTOM ////////////////////////////////////////////////////////////////
    for (int i = 0; i<bottomPoints.length; i++) {
      if (bottomPoints[i] != null) {
        for (int j = 0; j<bottomPoints[i].length-1; j++) {

          if (bottomPoints[i][j].x > changeCount && bottomPoints[i][j].x < changeCount+650) {
            if (dist(bottomPoints[i][j].x- changeCount, bottomPoints[i][j].y, firefly_my_position.x, firefly_my_position.y) < 25) {
              ///firefly_my_velocity.rotate(radians(90));
              firefly_my_velocity.set(new PVector(0, 0));
              firefly_my_position.x -= change*2;
              firefly_my_position.y -= change;
            }

            float distX = bottomPoints[i][j+1].x - bottomPoints[i][j].x;
            float distY = bottomPoints[i][j+1].y - bottomPoints[i][j].y;
            float wholedist = dist(bottomPoints[i][j].x, bottomPoints[i][j].y, bottomPoints[i][j+1].x, bottomPoints[i][j+1].y);
            float wholeLerpCount = abs(wholedist / 1);

            for (int k = 1; k < wholeLerpCount; k++) {
              float lerpX = (distX / wholeLerpCount) * k;
              float lerpY = (distY / wholeLerpCount) * k;
              if (dist(bottomPoints[i][j].x- changeCount + lerpX, bottomPoints[i][j].y + lerpY, firefly_my_position.x, firefly_my_position.y) < 25) {
                firefly_my_velocity.set(new PVector(0, 0));
                firefly_my_position.x -= change*2;
                firefly_my_position.y -= change;
              }
            }

            if (distX < 4 && distX >= 0 && distY > 0) {
              for (int k = 1; k < wholeLerpCount; k++) {
                if (dist(bottomPoints[i][j].x- changeCount, bottomPoints[i][j].y + k, firefly_my_position.x, firefly_my_position.y) < 25) {
                  firefly_my_velocity.set(new PVector(0, 0));
                  firefly_my_position.x -= change*2;
                  firefly_my_position.y -= change;
                }
              }
            }

            if (distX < 4 && distX >= 0 && distY <= 0) {
              for (int k = 0; k < wholeLerpCount; k++) {
                if (dist(bottomPoints[i][j].x - 1 - changeCount, bottomPoints[i][j].y - k, firefly_my_position.x, firefly_my_position.y) < 25) {
                  firefly_my_velocity.set(new PVector(0, 0));
                  firefly_my_position.x -= change*2;
                  firefly_my_position.y -= change;
                }
              }
            }
          }
        }
      }
    }
  }

  void focus() {
    float x = firefly_my_center.x - firefly_my_position.x;
    float y = firefly_my_center.y - firefly_my_position.y;

    firefly_my_velocity =  new PVector(x * 0.1, y * 0.1);
    firefly_my_focused = true;
    
    firefly_my_spreadCount = 100;
    swarm.setGain(-10);
  }

  void spread(float focustime) {
    firefly_my_spreadCount = 0;
    focustime = map(focustime, 10, focusenergymax, 2, 7);
    focustime = constrain(focustime, 2, 7);
    firefly_my_spread_velocity = new PVector(random(-focustime, focustime), random(-focustime, focustime));
    firefly_my_focused = false;
    swarm.setGain(-18);
  }


  // Zeichnet Ellipse an der Position des Partikels und erzeugt flackern.
  void display() {
    pushMatrix();
    firefly_my_opacity = random(150-2*ges_vol, 250);
    translate(firefly_my_position.get().x, firefly_my_position.get().y);
    float dying_opacity = map(dyingcount, 0, dyingtime, 200, 0);

    if (dying) {
      tint(255, dying_opacity);
    }
    else {
      tint(255, firefly_my_opacity);
    }

    image(firefly, 0, 0);
    if (dying) {
      tint(255, random(dying_opacity-100, dying_opacity-70));
    }
    else {
      tint(255, map(firefly_my_opacity, 200-ges_vol, 250, 20, 50));
    }
    if (firefly_my_focused || dying) {
      image(firefly_glow_focus, 0, 0, 70, 70);
    }
    else {
      image(firefly_glow, 0, 0, 70, 70);
    }
    popMatrix();
  }
}

