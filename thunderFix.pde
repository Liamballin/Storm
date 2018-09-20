
class ThunderManager {
  AudioPlayer t1;
  AudioPlayer t2;
  AudioPlayer t3;
  AudioPlayer t4;
  AudioPlayer t5;
  AudioPlayer t6;

  ArrayList<AudioPlayer> clips = new ArrayList<AudioPlayer>();

  int[] playing = new int[6];
    String location = "/thunderClips/";
    
      float lastBackground = 0;
  float backgroundLasts = 250;
  
  float threshold = 80;
  boolean threshHit = false;
  
   float playStarted;
  float playLength = 5000;
  //boolean playing = false;



  ThunderManager() {
    t1 = minim.loadFile(location+"thunder1.mp3"); 
    t2 = minim.loadFile(location+"thunder2.mp3"); 
    t3 = minim.loadFile(location+"thunder3.mp3"); 
    t4 = minim.loadFile(location+"thunder4.mp3"); 
    t5 = minim.loadFile(location+"thunder5.mp3"); 
    t6 = minim.loadFile(location+"thunder6.mp3"); 


    clips.add(t1);
    clips.add(t2);
    clips.add(t3);
    clips.add(t4);
    clips.add(t5);
    clips.add(t6);
  }
  
  

  void addThunder() {
    int r = (int)random(0, 5);
    int index = 0;
    boolean allPlaying = true;

    for (int i = 0; i < 6; i++) {
      if (clips.get(i).position() > 0 == false) {
        allPlaying = false;
        index = i;
        break;
      }
    }
    if (allPlaying) {
      int longest = getLongest();
      clips.get(longest).rewind();
      clips.get(longest).play();
    } else {
      clips.get(index).rewind();
      clips.get(index).play();
    }
    lastBackground = millis();
  }

  int getLongest() {
    int longest = 0;
    int index = 0;
    for (int i = 0; i < 6; i ++) {
      if (clips.get(i).position() > longest) {
        longest = clips.get(i).position();
        index = i;
      }
    }
    return index;
  }

  void update() {
    
    if (fadeIntensity > threshold) {
      if (!threshHit) {
        addThunder();
        threshHit = true;
      }
    } else {
      threshHit = false;
    }
    
    
    if (millis() - lastBackground > backgroundLasts) {
      thunderBackground = false;
      //flashCount ++;
    } else {
      thunderBackground = true;
      
    }
    
    
    //check all playing clips, if finshed then rewind and pause
    for (AudioPlayer p : clips) {
      if (p.position() >= p.length()-500) {
        p.rewind(); 
        p.pause();
      }
    }


    int i = 0;

    //visualize positions
    //for (AudioPlayer p : clips) {
    //  i++;
    //  fill(100);
    //  rect(50, 50*i, map(p.position(), 0, p.length(), 0, width-200), 20);
    //  fill(255);
    //  text(str(p.position())+"  :  "+p.length(), 50, 50*i);



      //for (int w = 0; w < playing.length; w++) {
      //  text(playing[w], 50, height - 30*w);
      //}
    //}
  }
}