class dropSystem {
  ArrayList<Streak> streaks = new ArrayList<Streak>();


  float wMin = -100;
  float wMax = width+50;
  float hMin = -50;
  float hMax = height+50;

  //how often to add drops, in ms
  float dropEvery = 500;
  float lastDrop = 0; //keep at 0, maybe move to init()
  
  //amount of drop instances added every add() call
  int addPerFrame = 10;
  int calmAdd = 5;
  int stormyAdd = 50;
  
  //min and max of sizes 
  float sizeMin = 2;
  float sizeMax = 7;
  
  //values for drop angle depending on the overall storm intensity
  float angle = 10;
  float calmAngle = 0;
  float stormyAngle = 76;
  
  float angleRange = 5;
  float angleRangeCalm = 1;
  float angleRangeStormy = 10;
  
  //values for gap lengths depending on the overall storm intensity
  float gap = 1;
  float calmGap = 3; //or 1
  float stormyGap = 10;
  float gapRange = 1;
  
  //opacity ranges
  float startOpacity = 200;
  float deathOpacity = 10;
  float opacityRange = .5;
  
  //range of drop instance life span
  float lifeTime = 500;
  float lifeMin = 300;
  float lifeMax = 700;
  
  //amount individual dots in a streak line can move
  //maybe add speed to simulate drops being blown by wind
  float trailShiftRange = 5; 
  //float lifeRange
  
  int maxDrops = 600;
  
  float streakDirection = -1; //1 or -1
  
 

  void addDrop(int count) {
    //dropSystem a = this;
    if (millis()-lastDrop > dropEvery) {
      for (int i = 0; i < count; i ++) {

        streaks.add(new Streak(random(wMin, wMax), random(hMin, hMax), this));
      }
    }
  }


  void cleanUp(){
   if(streaks.size() > maxDrops){
    while(streaks.size() > maxDrops){
     streaks.remove(0); 
    }
   }
    
  }

  void update() {
    //background(0);
    //adjust variables with overall intensity
    
    //angle of raindrop
    angle = map(fadeIntensity, 0, 100, calmAngle, stormyAngle);
    
    
    //change gap or gap range, formula is gap + random(-gapRange, gapRange);
    gapRange = map(fadeIntensity, 0, 100, calmGap, stormyGap);
    
    //amount added every add() call
    addPerFrame =(int) map(fadeIntensity,0,100, calmAdd, stormyAdd);
    
    //variation of angles
    angleRange = map(fadeIntensity, 0,100, angleRangeCalm, angleRangeStormy);
    
    cleanUp();
    addDrop(addPerFrame);

    for (Streak d : streaks) {
      d.update();
    }
  }
}