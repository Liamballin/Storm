class Letter {
  String chr;
  PVector pos;
  PVector vel;
  
  float velMax = .4;
  float velMin = .38;
  
  float textSize = 20;
  
  float velLimit;
  

  Letter(String k, float x, float y) {
    chr = k; 
    pos = new PVector(x, y);
    init();
  }

  void init() {
    
    vel = new PVector(0, random(velMin, velMax));
    
  }
  

  void update() {
    pos.add(vel);
    

    display();
  }

  void display() {
    textSize(textSize);
    fill(255);
    text(chr, pos.x, pos.y);
  }
}