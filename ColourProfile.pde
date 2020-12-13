class ColourProfile {
  String[] options = {
    "sunrise",
    "cyan",
    "sahara",
    "twilight",
  };
  
  float[][] baseColours;
  float[][] cloudColours = {
    {0.00, #FFFFFF},
    {1.00, #FFFFFF},
  };
  
  ColourProfile(String option) {
    if (option == "random") {
      option = options[floor(random(4))];
    }
    switch (option) {
       case "sunrise":
         setSunriseColours();
         break;
       case "sunrise2":
         setSunrise2Colours();
         break;
       case "cyan":
         setCyanColours();
         break;
       case "sahara":
         setSaharaColours();
         break;
       case "twilight":
         setTwilightColours();
         break;
    }
  }
  
  void setSunriseColours() {
    baseColours = new float[][]{
      {0.00, #2B618F},
      {0.28, #4A7CA5},
      {0.55, #AEB4B7},
      {0.70, #D0D1CC},
      {0.84, #ECD8CD},
      {1.00, #FAAE8A},
    };
    cloudColours = new float[][]{
      {0.00, #B6958B},
      {0.40, #EDB99C},
      {0.70, #F2D0BD},
      {1.00, #FFFFFF},
    };
  }
  
  void setSunrise2Colours() {
    baseColours = new float[][]{
      {0.00, #2B618F},
      {0.35, #4A7CA5},
      {0.75, #AEB4B7},
      {1.00, #D0D1CC},
    };
    cloudColours = new float[][]{
      {0.00, #B6958B},
      {0.40, #EDB99C},
      {0.70, #F2D0BD},
      {0.95, #FFFFFF},
    };
  }
  
  void setCyanColours() {
    baseColours = new float[][]{
      {0.00, #5885D2},
      {0.60, #78B5FD},
      {1.00, #BBE7FE},
    };
    cloudColours = new float[][]{
      {0.00, #8394AE},
      {0.40, #D8DDE1},
      {1.00, #FFFFFF},
    };
  }
  
  void setSaharaColours() {
    baseColours = new float[][]{
      {0.00, #AF743E},
      {0.60, #F37D2A},
      {1.00, #E35723},
    };
  }
  
  void setTwilightColours() {
    baseColours = new float[][]{
      {0.00, #200140},
      {0.30, #B04178},
      {0.60, #CF799A},
      {1.00, #E2CE98},
    };
  }
}
