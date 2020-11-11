class Cirrocumulus extends Cloudscape {
  float perlinStepX = 0.03;
  float perlinStepY = 0.05;
  float macroPerlinStepX = 0.0015;
  float macroPerlinStepY = 0.0023;
  
  Cirrocumulus() {
    noiseDetail(12, 0.4);
    makeImage();
  }
  
  float getAlpha(int i) {
    return 100.0 * getMicroFactor(i) * getMacroFactor(i);
  }
  
  float getMicroFactor(int i) {
    return constrain(pow(getNoiseValue(i), 1.8) + 0.4, 0, 1);
  }
  
  float getMacroFactor(int i) {
    return constrain(pow(getMacroNoiseValue(i), 1.7) + 0.25, 0, 1);
  }
  
  float getNoiseValue(int i) {
    float x = getPixelX(i) * perlinStepX;
    float y = getPixelY(i) * getPerlinStepY(i);
    return noise(x, y);
  }
  
  float getMacroNoiseValue(int i) {
    float x = getPixelX(i) * macroPerlinStepX;
    float y = getPixelY(i) * macroPerlinStepY;
    return noise(x, y);
  }
  
  float getPerlinStepY(int i) {
    float y = getPixelY(i);
    float yProgress = y / height;
    return perlinStepY + 0.04 * yProgress;
  }
}
