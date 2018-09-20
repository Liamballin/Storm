class Streak {

  PVector pos;
  PVector vel;
  
  
  boolean letterDrops = false;
  
  float velMin = 0.05;
  float velMax = 0.5;

  float dropSizeRange = .2;
  float baseSize = 5;
  float maxSize = 5;
  float heightMult = 3;
  float angle = 10;
  float averageSize;

  color clr = color(255);
  float opacity;

  String letter;

  float textMin = 10;
  float textMax = 25;
  
  float lastSize = textMax;

  float dropSeriesLength = 5;
  float dropCount = 5;
  float gap = .1;

  float birthMillis;
  float dropStep;

  float lifeTime;



  dropSystem par;

  float[] dropSizes = new float[(int)dropCount];
  
  //Streak a = new Streak(x, y, 


  Streak(float x, float y, dropSystem p) {
    pos = new PVector(x, y); 
    par = p;
    init();
    update();
  }

  void init() {
    //get values from parent and add random variations
    //base size that is added or minused from to get size, bad system - should change
    
    vel = new PVector(0, (random(velMin, velMax)));

    char a = char((int)random(80, 100));
    letter = str(a);
    //println(str(a));


    baseSize = random(par.sizeMin, par.sizeMax);

    gap = par.gap + random(-par.gapRange, par.gapRange);

    angle = par.angle + random(-par.angleRange, par.angleRange);
    vel.rotate(radians(angle));

    opacity = par.startOpacity + random(-par.opacityRange, par.opacityRange);

    birthMillis = millis();

    lifeTime = random(par.lifeMin, par.lifeMax);

    dropStep = maxSize / dropCount;
    float sum = 0;
    float lastSize = baseSize;

    for (int i = 0; i < dropCount; i++) {
      float val = lastSize - dropStep; 
      sum += val;
      dropSizes[i] = val;
      lastSize = val;
    }
    averageSize = sum/dropCount;
  }

  void update() {

    opacity = map(millis() - birthMillis, 0, lifeTime, par.startOpacity, par.deathOpacity);
    
    pos.add(vel);

    display();
  }

  void display() {
    noStroke();

    pushMatrix();
    translate(pos.x, pos.y);
    rotate(radians(angle));



    for (int drop = 0; drop < dropCount; drop++) {
      fill(clr, opacity);
      if (!letterDrops) {
        
      ellipse(
         0, //no x shift because of translate
         par.streakDirection*drop*averageSize+(gap*drop), 
         dropSizes[drop], 
         dropSizes[drop]*heightMult);
         
      } else {
        float s = map(dropSizes[drop], par.sizeMin, par.sizeMax, textMin, textMax);
        if(s <= 0){
         textSize(lastSize); 
        }else{
         textSize(s);
         lastSize = s;
        }
        //textSize();
        text(
          letter, 
          0, 
          par.streakDirection*drop*averageSize+(gap*drop));
      }
    }

    popMatrix();
  }
}