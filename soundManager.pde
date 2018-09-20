import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;



class soundManager {
 
  ArrayList<Sound> sounds = new ArrayList<Sound>();
  
    //TODO add these classes 

  //plays in the background independent of intensity
  //ArrayList<Ambient> ambients = new ArrayList<Ambient>();

  //plays once when insensity changes to over threshold.
  //ArrayList<Hit> hits = new ArrayList<Hit>();
  
  soundManager(){
    addSound("SoundFiles/drizzle.mp3");
    addSound("SoundFiles/light.mp3");
    addSound("SoundFiles/medium.mp3"); 
    
    calcDist();
  }
  
  void addSound(String filePath){
    sounds.add(new Sound(filePath));
    
  }
  
  void calcDist(){
     
    int soundCount = sounds.size();
    float peakGaps = (100/soundCount);
    
    int n = 1;
    for(Sound s : sounds){
      float peakPoint = (peakGaps * n) - (peakGaps/2);
      //println("Found peakPoint at "+ peakPoint);
      
      
      s.setRange(peakPoint, peakGaps); 
      n++;
    
   }
  }
  
  void update(Boolean render){
    
    for(Sound s : sounds){
     PVector thisSound = new PVector(s.peakPer, 0);
     PVector intensityValue = new PVector(fadeIntensity,0);
     
     intensityValue.sub(thisSound);
     
     s.update(intensityValue.mag());
      
    }
    if(render){
   display();
    }
  }
  
  void display(){
    
    int n = 0;
    
    for(Sound s : sounds){
      float thisX = map(s.peakPer, 0, 100, 0, width);
      fill(0,0,255);
     ellipse( thisX, height/2, 10, 10);
     fill(s.randomFill);
     float d = map(s.maxDists, 0, 100, 0, width);
     rect(thisX-d/2, height/2+(10*n), d, 10);
     
           fill(0,0,255);

     text(s.file, thisX, height/2 +50);
     text("Gain: "+s.gain, thisX, height/2+70);
     text("peak %: "+s.peakPer, thisX, height/2+90);
     text("Dist.: "+s.dist, thisX, height/2+110);
     text("max dists: "+s.maxDists, thisX, height/2+130);
      n++;
    }
    
  }
   
}