/*

class thunderClip {

  float startTime;
  AudioPlayer ap;

  thunderClip(String filePath) {
    ap = minim.loadFile(filePath);
    startTime = millis();
  }

  void play() {
    ap.play();
  }
}
/*
class ThunderManager {

  ArrayList<thunderClip> playList = new ArrayList<thunderClip>();

  String[] filePaths = {"thunder1.mp3", "thunder2.mp3", "thunder3.mp3", "thunder4.mp3", "thunder5.mp3", "thunder6.mp3"};
  String location = "/thunderClips/";

  int lastIndex = 6;

  float threshold = 80;

  boolean threshHit = false;

  float playStarted;
  float playLength = 5000;
  boolean playing = false;

  float lastBackground = 0;
  float backgroundLasts = 250;
  
  int flashCount = 0;
  int flashes = 1;


  void update() {
  //if(flashCount < flashes){
    if (millis() - lastBackground > backgroundLasts) {
      thunderBackground = false;
      flashCount ++;
    } else {
      thunderBackground = true;
      
    }
  //}


    //update and clean up currently playing clips
    for (int i = 0; i < playList.size(); i ++) {
      thunderClip a = playList.get(i);
      a.play(); 
      if (millis() - a.startTime > a.ap.length()) {
        playList.remove(i);
      }
    }
    //-------------------------------------------

    if (fadeIntensity > threshold) {
      if (!threshHit) {
        addThunder();
        threshHit = true;
      }
    } else {
      threshHit = false;
    }
  }

  void addThunder() {
    //AudioPlayer p1 = minim.loadFile(randomClip());
    backgroundLasts = random(100, 200);
    playList.add(new thunderClip(randomClip()));
    lastBackground = millis();
  }


  String randomClip() {
    int index;
    while (true) {
      index = (int)random(0, 7);
      if (index != lastIndex) {
        break;
      }
    }
    String loc = location+filePaths[index];

    return loc;
  }
}

*/