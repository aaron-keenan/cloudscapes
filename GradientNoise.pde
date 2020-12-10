class GradientNoise extends Gradient {
  float stepX, stepY;
  
  GradientNoise(int _width, int _height) {
    super(_width, _height);
  }
  
  float getGradientProgress(int i) {
    return getGradientNoiseValue(i);
  }
  
  float getGradientNoiseValue(int i) {
    float x = getPixelX(i) * stepX;
    float y = getPixelY(i) * stepY;
    return noise(x, y);
  }
  
  int getPixelX(int i) {
    return i % image.width;
  }
  
  int getPixelY(int i) {
    return floor(i / image.width);
  }
  
  void setGradientNoiseDetails(float _stepX, float _stepY, int lod, float falloff) {
    stepX = _stepX;
    stepY = _stepY;
    noiseDetail(lod, falloff);
  }
}
