class GradientLinear extends Gradient {
  GradientLinear(int _width, int _height) {
    super(_width, _height);
  }
  
  float getGradientProgress(int i) {
    return map(getPixelY(i), 0, height, 0, 1);
  }
}
