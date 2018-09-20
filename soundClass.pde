class Sound {
  
  float perStart;
  float perEnd;
  
  float maxDists;
  String file;
  
  float peakPer;
  color randomFill;
  
  float dist;
  
  float volMin = -20;
  float volMax = 10;
  
  float fadeOffset = 20;
  
  float gain;
  
  AudioPlayer player;
  
  Sound(String filePath){
    file = filePath;
   player = minim.loadFile(filePath);  
   player.play();
   
   randomFill = color(random(0,255),random(0,255),random(0,255), 50);

  
  }
  
  void setRange(float pPer, float gaps){
   //perStart = start; //% at which this sound starts
   //perEnd = end;     //% at which this soudn ends
   peakPer = pPer;
   maxDists = gaps + fadeOffset;  //the gaps between each volume max point;
  }
  

  
  void update(float distance){
    dist = distance;
    gain = map(distance, 0, maxDists+fadeOffset, volMax, volMin);
    player.setGain(gain);
    
  }
  
  
  
}