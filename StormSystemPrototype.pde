import java.net.URI;
import java.io.*; 

//boolean running = false;

void setup() {

  //fullScreen(2);

  img = loadImage("Storm (Small).png");
  size(700,900);
  width = 1000; 
  //height = 900;/

  minim = new Minim(this);
  //ser = new Serial(this, Serial.list()[0], 9600);  //adjust

  sm = new soundManager();
  vs = new volSlider();
  ds = new dropSystem();
  //ws = new wordSystem();
  wm = new wordManager();
  tm = new ThunderManager();
  sc = new serverManage();
}

PImage img;
float globalOffset = 0;

boolean useHeartRate = false;
boolean thunderBackground = false;
boolean intensityRandomWalk = false;

float intensity = 50;
float fadeIntensity = 0;

soundManager sm;
volSlider vs;
dropSystem ds;
//wordSystem ws; depricated
wordManager wm;
ThunderManager tm;
serverManage sc;

void mouseClicked() {
thunder();
}

void thunder(){
    tm.addThunder(); 
  vs.pos.x = random(70,100);
}

void draw() {
  
  background(0);

  //if(running){
  backColour();
  if (thunderBackground) {
    image(img, -5, -5, width+5, height+5);
  }
  //get intensity
  updateIntensity();
  //update rain, dropSystem
  
  ds.update();
  //update sound, soundManager
  sm.update(false);
  //update volume slider, volSlider
  vs.update(false);
  //update word system, wordSystem
  wm.update();
  //wm.windowPos();
  //update thunder manager
  tm.update();
  //check server for new words
  sc.update();

  //update an intensity graph
  //intensityViewer();
  //fill(255);
  //text(frameRate, width/2, height/2);

  //text(tm.playList.size(), width/2, height/2+100);
  //fill(255,0,0);
  //rect(0,0,width, height);
}


//}

void backColour() {
}