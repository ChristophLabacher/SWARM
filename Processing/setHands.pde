
void setHands() {
  // hand info reset
  leap_hand_mostright = width/2;
  leap_righthand = null;
  leap_righthandset = false;
  leap_lefthand = null;
  leap_lefthandset = false;
  int number = 0;

  for (Hand hand : leap.getHands()) {
    //hand.draw();
    //proof draw for wrong positions and wrong stuff
    number++;
    //    fill(#FF0000);
    //    text(number, hand.getPosition().x+15, hand.getPosition().y+15);
    //    ellipse(hand.getPosition().x, hand.getPosition().y, 10, 10);
    //    fill(0);
    if (hand.getPosition().y < 100 || hand.getPosition().z < 0) {
      break;
    }

    if (hand.getPosition().x > leap_hand_mostright) {
      if (!leap_righthandset) { // checken ob rechte hand schon gesetzt ist
        leap_righthand = hand;
        leap_hand_mostright = hand.getPosition().x;
        righthandY = hand.getPosition().y;
        leap_righthandset = true;
      }
      else { // die rechteste hand auf rechts - die andere dann auf links - korrigiert falsche erkennungen weil es in der for Hand schleife läuft
        Hand savehand = leap_righthand;
        leap_righthand = hand;
        righthandY = hand.getPosition().y;
        leap_righthandset = true;

        leap_hand_mostright = hand.getPosition().x;

        leap_lefthand = savehand;
        leap_lefthandset = true;
      }
    }
    else { // xpos nicht größer als leap_hand_mostright => muss also links sein
      leap_lefthand = hand;
      leap_lefthandset = true;
    }

    if (leap_lefthandset && leap_righthandset) {
      break;
    }
  }



  if (leap_righthandset && started ) { // rechte hand kann nicht auf der linken Seite sein
    if (!leap_lefthandset && leap_righthand.getPosition().x < width/2) {
      leap_righthand = null;
      leap_righthandset = false;
      //text("only one hand - not allowed on left side", 20, 200);
    }
  }
}

void checkFingerCount() {
  if (leap_lefthandset) {
    if (leap_lefthand_fingercount > 1) {
      leap_lefthand_spreaded = true;
    }
  }
}

