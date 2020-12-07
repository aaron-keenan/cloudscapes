class ColourProfile {
  String[] options = {
    "sunrise",
    "cyan",
    "sahara",
    "twilight",
  };
  
  float[][] colours;
  
  ColourProfile(String option) {
    switch (option) {
       case "sunrise":
         setSunriseColours();
         break;
    }
  }
  
  void setSunriseColours() {
    colours = new float[][]{
      {0.00, #2B618F},
      {0.28, #4A7CA5},
      {0.55, #AEB4B7},
      {0.70, #D0D1CC},
      {0.84, #ECD8CD},
      {1.00, #FAAE8A},
    };
  }
}
