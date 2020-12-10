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
  }
  
  void setCyanColours() {
    baseColours = new float[][]{
      {0.00, #5885D2},
      {0.60, #78B5FD},
      {1.00, #BBE7FE},
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
    cloudColours = new float[][]{
      {0.00, #FF0000},
      {1.00, #FF0000},
    };
  }
}
