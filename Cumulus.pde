class Cumulus extends Cloudscape {
  float perlinStepX = 0.01;
  float perlinStepY = 0.015;
  
  Cumulus() {
    noiseDetail(7, 0.3);
    makeImage();
  }
  
  float getAlpha(int i) {
    return 100.0 * getMicroFactor(i);
  }
  
  float getMicroFactor(int i) {
    return constrain(pow(getNoiseValue(i), 1.2) * 1.6, 0, 1);
  }
  
  float getNoiseValue(int i) {
    float x = getPixelX(i) * perlinStepX;
    float y = getPixelY(i) * perlinStepY;
    return noise(x, y);
  }
}
