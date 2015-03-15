MultiThread thread1;

ArrayList <Firefly> fireflies;
boolean fireflytick = true;
boolean worldtick = false; // unterstrich einfügen

import geomerative.*;
RShape top;
RPoint[][] topPoints;
RShape bottom;
RPoint[][] bottomPoints;

boolean worldtick_save = false;   // for correctly unpausing
boolean fireflytick_save = false;
boolean saveticks = false; // for saving the ticks only once

int tickCount;

PImage texture;
PImage background;
PImage foreground;
PImage blur;
PImage firefly;
PImage firefly_glow;
PImage firefly_glow_focus;
float firefly_frontmost_x = 0;
PImage control_blur;
PImage grain;
PImage sound_rotate_blur;
PImage medal_blur;
PImage vignette;

float move = 0;
float change = 8;
float changeCount = 0;
boolean firefly_someonealive = true;

int paralax_text =0;
int paralax_fg = 0;
int paralax_bg = 0;
int paralax_blur = 0;

int paralax_text_y =0;
int paralax_fg_y = 0;
int paralax_bg_y = 0;
int paralax_blur_y = 0;

float game_medals=0;
float fireflies_counter=100;
boolean leap_lefthand_spreaded = false;

//Control
float control_x;
float control_y;
Control control_visual;

//GAME COUNTER
float game_counter=0;
ArrayList <Medal> medal;


// LEAP Variablen Start
import de.voidplus.leapmotion.*;
LeapMotion leap;

float leap_hand_mostright = 0;

Hand leap_lefthand;
boolean leap_lefthandset = false;
Hand leap_righthand;
float righthandY = 0;
boolean leap_righthandset = false;

int leap_lefthand_fingercount = 0;
int prevFrameCount = 0;
int lastFrameCount = 0;
int focusenergy = 100, focusenergymax = 100, focustime = 0;

float focusenergypercent = 0;

boolean focusenergyfull = true;
boolean focusmode = false;
boolean normal = true;
boolean focusfailed = false;

FocusButton focusbutton;

// LEAP Variablen Ende

//DUST
ArrayList <DustContainer> dustContainer;
PImage light_beam;
PImage dust_glow;
float pos_light = 400;

int lastSoundBoxTouch = 0;


//pauseMode
int pause_firstFrameCount = 0;
int pause_fadeTime = 15; // Anzahl des FrameFadeIn
float pause_opacity = 180;
float pause_opacity_max = 180;
boolean pausing = true;
boolean paused = true;
boolean unpausing = false;
boolean waiting = false; // waiting um fehlerkennungen zu verhindern
int wait_firstFrameCount = 0;

boolean hoverstart = true;
int helpFrameCount = 0;


// hands

PImage right;
PImage left_active;
PImage left_inactive;

PImage left_active_opacity;
PImage left_inactive_opacity;

float right_y;
float right_step_y=3;
float left_op_active=0;
float left_op_inactive=255;
float left_op_step=18;




// SOUND Variablen

ArrayList <SoundBox> spots;
ArrayList<AudioPlayer> sounds;
float layer1_vol, layer2_vol, layer3_vol, layer4_vol, layer5_vol, layer6_vol;
float ges_vol;

import ddf.minim.*;
import ddf.minim.analysis.*; 
BeatDetect beat;
Minim minim;
AudioPlayer layer_sound1, layer_sound2, layer_sound3, layer_sound4, layer_sound5, layer_sound6, sound;
AudioPlayer ambient, swarm;
PImage soundblur;
float soundpause;

float tickspeed = 0;

//startstopscreens
boolean startscreen = true;
boolean tutorial = false;
PImage logo;
PImage logobg;
PImage vignette_;
boolean started = false;
PFont light;
PFont regular;
PFont light20;
PFont regular20;


boolean pretutorial = true;

ArrayList <HelpText> helptexts;

// for checking the up and down movement
boolean tutorial_topmax = false;
boolean tutorial_downmax = false;
boolean tutorial_firsthelp = false;

//for checking pinched and released
boolean tutorial_pinched = false;
boolean tutorial_released = false;
boolean tutorial_secondhelp = false;
float gameOver_medalOpacity = 0;

boolean firstclicked = false; // check damit das erste mal clicken nur einmal ausgeführt wird

int fadeaway = 0;
int fadeaway_time = 0;
int fadeaway_transp = 0;


int dyingtime = 5; 

//creditscreen
PImage hfglogo;
int creditfade = 0;
boolean creditscreen = false;
float creditopacity = 0;
boolean creditOut = false;
boolean creditset = false;
float creditsteps = 8;

//gameOver / win 
//and reset

boolean gameOver = false; // generelles gameOver
boolean win = false; // check ob medals angezeigt werden müssen und welche Art von reset - just restart without tutorial oder complete restart
int gameOver_frameCount = 0;
float pause_gameOver_opacity = 0;
float gameOver_opacity = 0;
float gameOver_fadeTick = 1;
float gameOver_fadeTick_sound = 1;
PImage vignette_gameOver;

boolean fadeDown = false;
float fadeDown_toStart = 255;


void setup() {
  size(1280, 800, OPENGL);
  noStroke();  
  imageMode(CENTER);
  noCursor();
  frameRate(25);

  right_y=height/2;
  right=loadImage("icon_right.png");
  left_active=loadImage("icon_left_active.png");
  left_inactive=loadImage("icon_left_inactive.png");
  left_active_opacity=loadImage("icon_left_active_opacity.png");
  left_inactive_opacity=loadImage("icon_left_inactive_opacity.png");

  dustContainer = new ArrayList<DustContainer>();
  dustContainer.add(new DustContainer(0, 350, 4));
  dustContainer.add(new DustContainer(1, 0, 4));
  dustContainer.add(new DustContainer(2, 9450/2, 5));
  dustContainer.add(new DustContainer(3, 19200/2, 6));
  dustContainer.add(new DustContainer(0, 10000, 4));
  dust_glow = loadImage("dust_glow.png");


  //SOUND
  sounds=new ArrayList<AudioPlayer>();
  minim = new Minim (this);

  ambient = minim.loadFile("ambient.mp3", 1024);
  ambient.loop();
  ambient.setGain(-2);

  swarm = minim.loadFile("swarm.mp3", 1024);
  swarm.loop();
  swarm.setGain(-18);

  layer_sound1 = minim.loadFile("music_1.mp3", 1024);
  layer_sound2 = minim.loadFile("music_2.mp3", 1024);
  layer_sound3 = minim.loadFile("music_3.mp3", 1024);
  layer_sound4 = minim.loadFile("music_4.mp3", 1024);
  layer_sound5 = minim.loadFile("music_5.mp3", 1024);
  layer_sound6 = minim.loadFile("music_6.mp3", 1024);
  soundblur=loadImage("soundblur.png");

  //CONTROL
  control_visual=new Control();


  // soundspots
  spots = new ArrayList<SoundBox>();
  spots.add(new SoundBox(0, 1600, 400));
  spots.add(new SoundBox(1, 4151, 300));
  spots.add(new SoundBox(2, 5738, 174));
  spots.add(new SoundBox(3, 9031, 321));
  spots.add(new SoundBox(4, 10370, 555));
  spots.add(new SoundBox(5, 12319, 155));
  for (int i=0;i<spots.size();i++) {
    sounds.get(i).setGain(-100);
    sounds.get(i).loop();
  }


  leap = new LeapMotion(this);
  rectMode(CENTER);
  ellipseMode(CENTER);
  background = loadImage("bg.png");
  foreground = loadImage("fg2.png");
  blur = loadImage("blur5.png");
  firefly_glow = loadImage("firefly_glow.png");
  firefly = loadImage("firefly.png");
  logo = loadImage("logo.png");
  logobg = loadImage("logobg.png");
  vignette_ = loadImage("vignette.png");

  firefly_glow_focus = loadImage("firefly_glow_focus.png");
  grain=loadImage("vignette.png");
  control_blur=loadImage("control.png");
  texture=loadImage("texture.jpg");
  sound_rotate_blur=loadImage("sound_rotateblur.png");
  medal_blur=loadImage("medalblur.png");
  vignette=loadImage("vignette_big.png");
  hfglogo=loadImage("hfglogo.png"); 
  vignette_gameOver=loadImage("vignette_gameOver.png");
  ; 

  fireflies = new ArrayList<Firefly>();
  for (int i = 0; i < 100; i++) {
    fireflies.add(new Firefly(i));
  }

  focusbutton = new FocusButton();

  medal = new ArrayList<Medal>();
  for (int i = 0; i < 3; i++) {
    medal.add(new Medal());
  }

  //bold = loadFont("Roboto-Bold-130.vlw");
  light = loadFont("Roboto-Thin-60.vlw");
  regular = loadFont("Roboto-Regular-30.vlw"); // for test load regular into light

    light20 = loadFont("Roboto-Thin-20.vlw");
  regular20 = loadFont("Roboto-Regular-20.vlw");

  helptexts = new ArrayList<HelpText>();

  helptexts.add( new HelpText(350, height-64*1.5, "Pinch with five fingers to click.", true));
  helptexts.add( new HelpText(width-64, height-64*1.2, "Move your right hand up and down.", false));
  helptexts.add( new HelpText(width-64, height-64*1.2, "Clench your left hand into a fist.", false));
  helptexts.add( new HelpText(width-64, height-64*1.2, "Great! Now go and activate the music spots.", false));

  RG.init(this);
  RG.setPolygonizer(RG.ADAPTATIVE);

  top = RG.loadShape("topD2.svg");
  topPoints = top.getPointsInPaths();
  bottom = RG.loadShape("bottomD2.svg");
  bottomPoints = bottom.getPointsInPaths();

  thread1 = new MultiThread(1, 0, 99);
  thread1.start();
} // ### END SETUP ###

void draw() {

  //y paralax effects
  paralax_text_y =int(map(control_y, 1000, 0, -10, 10));
  paralax_fg_y =int(map(control_y, 1000, 0, 0, 0));
  //paralax_bg_y =int(map(control_y, 1000, 0, -20, 20));
  //paralax_blur_y =int(map(control_y, 1000, 0, 20, -20));

  background(25);
  tint(255, 255);
  imageMode(CORNER);
  image(texture, paralax_text, paralax_text_y);
  //image(background, paralax_bg, paralax_bg_y);
  imageMode(CENTER);

  for (int i=0;i<spots.size();i++) {

    if (spots.get(i).soundbox_my_counter > 0) {
      float soundgainfadeIn = map(spots.get(i).soundbox_my_inner_radius, 20, 50, -60, 0); 
      sounds.get(i).setGain((soundgainfadeIn-soundpause)-(100-100*gameOver_fadeTick_sound ));
    }
  }
  volume_detection();

  setHands();
  leftHandGestures();


  if (startscreen && !pretutorial) { // ### screen 1 start ###
    setStartscreen();
  }

  if (tutorial) {  // ### screen 2 to 4 ###
    walkthroughTutorial();
  }


  waitForPause();


  firefly_frontmost_x = 0;

  for (Firefly firefly: fireflies) {
    if (firefly.firefly_my_center.x > firefly_frontmost_x && firefly.firefly_my_alive) {
      firefly_frontmost_x = firefly.firefly_my_center.x;
    }
  }



  for (SoundBox spot: spots) {
    spot.display();
    spot.update();
  }

  for (int i = 0; i < fireflies.size(); i++) {
    if (fireflies.get(i).done()) {
      // fireflies.remove(i);
    }
  }

  focusbutton.display(); //focusbutton steht über allem - aber nicht über der vignette

  control_visual.display();

  darken_canvas();

  for (Firefly firefly: fireflies) { 
    //firefly.update();
    if (firefly.firefly_my_alive) {
      firefly.display();
    }
  }


  for (DustContainer dustContainer_: dustContainer) { 
    dustContainer_.update();
    dustContainer_.display();
  }

  for (int i = 0; i < dustContainer.size(); i++) {
    if (dustContainer.get(i).done()) {
      dustContainer.remove(i);
    }
  }

  tint(255, 255);
  imageMode(CORNER);
  image(foreground, paralax_fg, paralax_fg_y);
  imageMode(CENTER);



  if (worldtick) {
    if (tickspeed < 1) {
      float tickspeed_step = map(tickspeed, 0, 1, 0.02, 0.07);
      tickspeed+=tickspeed_step;
    }
    else {
      tickspeed = 1;
    }
    paralax_text-= 4*gameOver_fadeTick*tickspeed;
    paralax_fg -= 7*gameOver_fadeTick*tickspeed;
    paralax_bg -= 4*gameOver_fadeTick*tickspeed;
    paralax_blur -= 16*gameOver_fadeTick*tickspeed;
    changeCount += 7*tickspeed;
  }
  if (paralax_text<=-4866) {
    paralax_text=0;
  }
  if (paralax_fg <= -15360) {
    paralax_fg = 0;
  }
  if (paralax_bg <= -1260) {
    paralax_bg = 0;
  }
  if (paralax_blur <= -15360) {
    paralax_blur = 0;
  }

  if (startscreen) { 
    displayStartscreen();
  }


  tint(255, 255);
  imageMode(CORNER);
  image(blur, paralax_blur, paralax_blur_y); // damit blur immer komplett vorne ist…

  int ij = 0;
  for (HelpText helptext: helptexts) { //start help text "pinch to click" scrollt auch weg - helptexts[0]
    if (ij == 0 && startscreen) {
      //helptext.display();
    }
    else if (ij != 0) {
      helptext.display();
    }
    ij++;
  }

  if (creditscreen) {
    showCreditscreen();
  }

  if (!gameOver && gameOver_frameCount <20) {
    pauseGame();
  }


  waitForPause();




  if (gameOver) {
    gameOver();
  }

  if (fadeDown && fadeDown_toStart > 0) { // ausblenden der medallien bevor alles andere wieder angezeigt wird
    fadeDown_toStart-=10;
    tint(255, fadeDown_toStart);
    imageMode(CORNER);
    image(vignette_gameOver, 0, 0);
    imageMode(CENTER)  ;
  }
  else {
    fadeDown = false;
    fadeDown_toStart = 255;
  }


  tint(130, 140);//random(150, 160));
  imageMode(CORNER); 
  image(vignette_, 0, 0);
  imageMode(CENTER);  

  //fill(255);
  //text("fadeDown " + fadeDown + " // toStart " + fadeDown_toStart, width/2, height/2);


  //gameover früher anfangen auszufaden
  //focustime wird lang gehalten?

  //    textAlign(CENTER);

  //    text("left", width/4, height/2);
  //
  //    if (leap_righthandset) {
  //      fill(255, pause_opacity - 80);
  //    }
  //    else {
  //      fill(255, pause_opacity);
  //    }
  //    text("right", width-width/4, height/2);
  //    textAlign(RIGHT);


  if (paralax_fg <= (-15300+500)+width) { //(-3000+200)+width) {//
    win = true;
    gameOver = true;
  }

  firefly_someonealive = false;
  for (Firefly firefly: fireflies) {
    if (firefly.firefly_my_alive) {
      firefly_someonealive = true;
    }
  }




  fill(255);
  strokeWeight(1);
  textAlign(CENTER);
  textFont(regular, 20);

  if (!firefly_someonealive) {
    gameOver = true;
    win = false;
    //text("gameOver // ", width/2, height/2-20);
  }



  //text(righthandY + " righty", width/2, height/2);


  //RG.shape(top, -changeCount, 0);
  //RG.shape(bottom, -changeCount, 0);

  checkFingerCount();
}



boolean sketchFullScreen() {
  return true;
}



void darken_canvas() { //setzt eine Vignette in Abhängigkeit zu der Anzahl der noch vorhandenen Partikel
  fireflies_counter=0;
  for (Firefly firefly: fireflies) {
    if (firefly.firefly_my_alive) {
      fireflies_counter++;
    }
  }

  float vignette_opacity=map(fireflies_counter, 0, 100, 35, 0);
  tint(255, vignette_opacity);//XXX random(vignette_opacity-10, vignette_opacity));
  image(vignette, width/2, height/2);
}




void volume_detection() {
  if (layer_sound1.getGain()<0) {
    layer1_vol=0;
  }
  else {
    layer1_vol=layer_sound1.mix.level();
  }
  if (layer_sound2.getGain()<0) {
    layer2_vol=0;
  }
  else {
    layer2_vol=layer_sound2.mix.level();
  }
  if (layer_sound3.getGain()<0) {
    layer3_vol=0;
  }
  else {
    layer3_vol=layer_sound3.mix.level();
  }
  if (layer_sound4.getGain()<0) {
    layer4_vol=0;
  }
  else {
    layer4_vol=layer_sound4.mix.level();
  }
  if (layer_sound5.getGain()<0) {
    layer5_vol=0;
  }
  else {
    layer5_vol=layer_sound5.mix.level();
  }
  if (layer_sound6.getGain()<0) {
    layer6_vol=0;
  }
  else {
    layer6_vol=layer_sound6.mix.level();
  }
  ges_vol=(layer1_vol+layer2_vol+layer3_vol+layer4_vol+layer5_vol+layer6_vol)*100;
  ges_vol=map(ges_vol, 0, 100, 0, 100);
}

