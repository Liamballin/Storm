
class wordManager {
  ArrayList<PVector> points = new ArrayList<PVector>();
  ArrayList<Word> words = new ArrayList<Word>();
  PFont handWriting;
  String currentWord;
  int charCount = 0;

  wordManager() {
    handWriting = createFont("AmaticSC-Bold.ttf", 60);
  }

  void keyHandle(char k, int kc) {

    if (kc == 10) {
      newWord(currentWord, false);
      currentWord = "";
    } else {
      currentWord += k;
    }
  }

  void newWord(String W, Boolean echo) {
    float[] posArray = windowPos();
    words.add(new Word(wordBreaker(W), posArray[0], posArray[1], this, echo));
  }

  String wordBreaker(String w) {
    float posX = 0;
    float posY = 0;

    int lineLength = 10;
    int lastMod = 0;

    StringBuilder chars = new StringBuilder(w);

    for (int i =0; i < chars.length(); i++) {
      lastMod ++;
      if (lastMod > lineLength) {
        chars.insert(i, "\n");
        lastMod = 0;
      }

    }

    return chars.toString();
  }

  float[] windowPos() {
    float midStrutX = width/2+50;
    float baseStrutY = height-355;

    //stroke(255,0,0);
    //strokeWeight(5);
    //line(midStrutX, 0, midStrutX, baseStrutY);
    //line(0, baseStrutY, width, baseStrutY);

    float posY = random(0, height);
    float posX;

    if (posY > baseStrutY) {
      posX = random(0, height-550);
    } else {
      if ((int) random(0, 1) != 0) {
        posX = random(midStrutX, width - 300);
      } else {
        posX = random(0, midStrutX-50);
      }
    }


    ellipse(posX, posY, 10, 10);
    points.add(new PVector(posX, posY));
    return new float[]{posX, posY};
  }

  void update() {

    for (int i = 0; i < words.size(); i ++) {
            words.get(i).update();

      if (words.get(i).opacity < 1) {
        words.remove(i);
      }
    }
  }
}


//------------------------------------------------------ ---------------------
class Word {
  String con;
  PVector pos;
  PVector vel;
  PFont font;
  color fil = color(255);

  float sizeMin = 10;
  float sizeMax = 20;
  float fSize = 65;
  float eSize = 30;

  float dropOpMin = 10;
  float dropOpMax = 200;

  float opacity;
  float birthTime;
  float fadeTime = 5500;
  float eFadeTime = 900;

  float dropEvery = 50;
  float lastDrop = 0;

  float rangeX;
  float rangeY = fSize/3;

  float velMin = 0.01;
  float velMax = 0.5;

  float startX;
  float startY;

  boolean echo = false;

  wordManager wordM;

  ArrayList<Drop> drops = new ArrayList<Drop>();

  Word(String c, float x, float y, wordManager wm, boolean ec) {
    con = c;
    pos = new PVector(x, y);
    wordM = wm;
    font = wordM.handWriting;
    birthTime = millis();

    if (ec) {
      fadeTime = eFadeTime;
      fSize = eSize;
    }

    rangeX  = (fSize * con.length())/3;

    startX = x;
    startY = y;

    vel = new PVector(0, random(velMin, velMax));
  }


  void update() {
    noStroke();

    float timeAlive = millis() - birthTime;
    opacity = map(timeAlive, 0, fadeTime, 255, 0);
    //opacity = 255;

    fill(fil, opacity);
    textFont(font);
    textSize(fSize);
    text(con, pos.x, pos.y);

    if (millis() - lastDrop > dropEvery) {

      drops.add(new Drop(this, random(0, rangeX), random(-rangeY*2, 0)));

      lastDrop = millis();
    }



    for (Drop d : drops) {
      fill(d.cl, d.opacity);
      ellipse(startX+d.pos.x, startY+d.pos.y, d.size, d.size);
    }
  }
}


class Drop {
  float size;
  PVector pos;
  color cl;
  Word p;
  float opacity;

  Drop(Word w, float x, float y) {
    p = w;
    pos = new PVector(x, y);
    init();
    opacity = random(w.dropOpMin, w.dropOpMax);
  }

  void init() {
    size = random(p.sizeMin, p.sizeMax);
  }
}


/*
class Word{
 ArrayList<Letter> letters = new ArrayList<Letter>();
 String word;
 
 float border = 100;
 
 float letterRangeX = 2;
 float letterRangeY = 5;
 
 float letterGap = 10;
 
 
 float addEvery = 10;
 float lastWordAdd = 0;
 
 float maxLineLength = 300;
 
 float x;
 float y;
 
 Word(String w){
 word = w; 
 
 x = random(border, width-(letterGap * word.length()));
 y = random(border, height-(letterGap * word.length()));
 
 }
 
 float workingGap = 0;
 int i = 0;
 
 void update(){
 
 for (Letter s : letters) {
 s.update();
 }
 
 
 if(i < word.length()){
 if(millis() - lastWordAdd > addEvery){
 
 workingGap += random(0, letterRangeX);
 
 float tX = x + (letterGap * i)+ workingGap;
 float tY = y; //+ random(-letterRangeY, letterRangeY);
 
 //println(tX + "  :  "+tY+"  :  "+i);
 
 letters.add(new Letter(str(word.charAt(i)), tX, tY));
 i += 1;
 lastWordAdd = millis();
 }
 }
 }
 
 
 
 }
 
 */

//class wordSystem {
//  ArrayList<Word> words = new ArrayList<Word>();

//  String currentWord = "";


//  void keyHandle(char k, int code){
//    if (code == 10) {
//    words.add(new Word(currentWord));
//    currentWord = "";
//  } else {
//    currentWord += str(key);
//  }

//  }

//  void update(){
//  for(Word w : words){
//     w.update(); 
//  } 

//  }
//}