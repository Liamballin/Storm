import processing.serial.*;
Serial ser;

String input;
float bpm = 0;

//------------------------CHECK FLASK SERVER FOR NEW WORDS------------------
class serverManage {
  float checkEvery = 1000;
  float lastCheck = 0;

  float getRandomEvery = 4500;
  float lastGetRandom = 0;

  int stringCount = 0;
  String currentWord;

  String[] wordList = new String[100];

  void update() {
    if (millis() - lastCheck > checkEvery) {

      thread("serverRequest");
      lastCheck = millis();
    }

    if (millis() - lastGetRandom > getRandomEvery) {
      thread("submitStats");
      thread("randomWord");
      lastGetRandom = millis();
    }
  }
}

///----------------------------------------------------------------------------
void serverRequest() {
  JSONObject data = loadJSONObject("http://127.0.0.1:5000/words");
  if (data.getBoolean("valid") == true) {
    String word = data.getString("word");
    println(word);
    //------------------
    wm.newWord(word, false);
    thunder();
    //-----------------
  }
}

void randomWord() {
  JSONObject data = loadJSONObject("http://127.0.0.1:5000/rand");
  if (data.getBoolean("valid") == true) {
    String word = data.getString("word");
    //println(word);
    //------------------

    wm.newWord(word, true);
    //thunder();
    //-----------------
  }
}

 void submitStats() {
  JSONObject stats = new JSONObject();
  stats.setFloat("fps", frameRate);
  stats.setInt("words", wm.words.size());
  stats.setInt("rainDrops", ds.streaks.size());
  //stats.setInt("thunderClips", tm.playList.size());

  String jsonM = "{\"fps\":"+frameRate+", \"words\":"+wm.words.size()+", \"rainDrops\":"+ds.streaks.size()+", \"thunderClips\":"+"}";

  String[] data = loadStrings("http://127.0.0.1:5000/giveStat/"+URLEncode(jsonM));//.toString());
  //if (data.getBoolean("valid") == true) {
  //String word = data.getString("word");
  //println(word);
  //------------------

  //wm.newWord(word, true);
  //thunder();
  //-----------------
}

//fully taken from processing forums https://forum.processing.org/one/topic/how-make-urlencode.html
String URLEncode(String string) {
  String output = new String();
  try {
    byte[] input = string.getBytes("UTF-8");
    for (int i=0; i<input.length; i++) {
      if (input[i]<0)
        output += '%' + hex(input[i]);
      else if (input[i]==32)
        output += '+';
      else
        output += char(input[i]);
    }
  }
  catch(UnsupportedEncodingException e) {
    e.printStackTrace();
  }
  return output;
}





// -------------------------READ SERIAL INPUT ----------------
void getSerial() {
  boolean read;
  if (ser.available() > 0) {
    read = true;
  } else {
    read = false;
  }

  while (ser.available() > 0) {
    input =  ser.readStringUntil(10); 

    if (input != null) {
      //print(input);
      float in = float(trim(input));
      if (in < 500) {
        bpm = in; 
        intensityRandomWalk = false;
      } else {
        intensityRandomWalk = true;
      }
      print("BPM ");
      println(bpm);
      //println(bpm);
      read = false;
    }
  }
  ser.clear();
}

//-----------------------------MANAGE KEY PRESS INPUT---------------

void keyPressed() {
  wm.keyHandle(key, keyCode);
}