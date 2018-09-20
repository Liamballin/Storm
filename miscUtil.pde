//replace with heartrate and stuff

//-------------------------- UPDATE GLOBAL INTENSITY -----------------
void updateIntensity() {
  if (useHeartRate) {
    getSerial(); 
    if (bpm == bpm) {
      intensity = bpm;
    }
    //println(bpm);
  } else {
    intensity = map(mouseX, 0, width, 0, 100);
  }

  if (intensity > 100) {
    intensity = 100;
  } else if (intensity < 0) {
    intensity = 0;
  }
}

//------------------------------  SHOW GRAPH OF INTENSITY OVER TIME- ---------------

void intensityViewer() {
  stroke(255);
  fill(255);
  float wMin = 50;
  float wMax = width - 50;
  float hMin = 10;
  float hMax = 110;

  //end bars
  line(wMin, hMin, wMin, hMax);
  line(wMax, hMin, wMax, hMax);

  //cross line

  line(wMin, hMin+(hMax-hMin)/2, wMax, hMin+(hMax-hMin)/2);

  text(fadeIntensity, wMin + 30, (hMin+(hMax-hMin)/2)+50);

  float fadeX = map(intensity, 0, 100, wMin, wMax);
  float fadeY =  hMin+(hMax-hMin)/2-7.;
  float fadeSize = 15;

  float inputX = map(fadeIntensity, 0, 100, wMin, wMax);
  float inputY = hMin+(hMax-hMin)/2-15;
  float inputSize = 30;



  rect(fadeX, fadeY, 15, 15);

  rect(inputX, inputY, 30, 30);


  //line(fadeX + (fadeSize/2), fadeY+(fadeSize/2), inputX, inputY);
  //line(fadeX + (fadeSize/2), fadeY+(fadeSize/2), inputX, inputY);
  rect(fadeX, fadeY+5, -(fadeX-inputX), 5);
}
//----------------------------------------------------------------------------------------------------------------------VOL SLIDER -----------------------------------------
class volSlider {
  PVector pos;
  PVector vel;
  PVector acc;

  float workingIntensity;

  float minSpeed = 0;
  float maxSpeed = 5;

  float randomTargetEvery = 5000;
  float lastRandomTarget = 0;

  float maxMag = 1000;

  float speed = 1;

  float velLimit = 0.5;
  float minLim = 0.1;
  float maxLim = 25;
  
  float randomValue = 40;

  volSlider() {

    pos = new PVector(intensity, 0);
    vel = new PVector(0, 0);
  }


  void update(Boolean render) {
    float intenVal = 0;
    
    if (intensityRandomWalk) {
      if (millis() - lastRandomTarget > randomTargetEvery) {
        print("New random intensity  ");
         randomValue = random(randomValue - 30, randomValue + 30);
         if(randomValue > 100 || randomValue < 0){
          randomValue = 50; 
         }
        //println(ranInten);

        

        lastRandomTarget = millis();
      }
      intenVal = randomValue;
    } else {
      intenVal = intensity;
    }
    
    //if(


    PVector inten = new PVector(intenVal, 0);
    PVector thisPos = pos.get();
    pos.x = constrain(pos.x, 0, 100);

    inten.sub(thisPos);

    speed = map(inten.mag(), 0, maxMag, minSpeed, maxSpeed);
    velLimit = map(inten.mag(), 0, maxMag, minLim, maxLim);

    inten.normalize();

    inten.mult(speed);

    vel.add(inten);

    vel.limit(velLimit);

    pos.add(vel);

    fadeIntensity = pos.x + globalOffset;

    if (globalOffset > 0) {
      globalOffset /= 1.5;
    }

    if (render) {
      display();
    }
  }

  void display() {

    fill(255, 0, 0);
    ellipse(map(intensity, 0, 100, 0, width), height/2, 10, 10);

    fill(0, 255, 0);
    ellipse(map(pos.x, 0, 100, 0, width), height/2, 10, 10);
  }
}