class Gradient {
  PImage image;
  float[][] palette;
  float weight = 1.0;
  
  Gradient(int _width, int _height) {
    image = createImage(_width, _height, RGB);
    //updatePixels();
  }
  
  void display() {
    image(image, 0, 0);
  }
  
  void updatePixels() {
    for (int i = 0; i < image.pixels.length; i++) {
      image.pixels[i] = getColour(i);
    }
  }
  
  float getGradientProgress(int i) {
    return 0.0;
  }
  
  void setWeight(float _weight) {
    this.weight = _weight;
  }
  
  void setPalette(float[][] _palette) {
    this.palette = _palette;
  }
  
  color getColour(int i) {
    float gradientProgress = getGradientProgress(i);
    float[] start = palette[0];
    float[] end = palette[palette.length - 1];
    for (float[] checkpoint : palette) {
      if (gradientProgress >= checkpoint[0]) {
        start = checkpoint;
      }
      if (gradientProgress < checkpoint[0]) {
        end = checkpoint;
        break;
      }
    }
    float sectionProgress = map(gradientProgress, start[0], end[0], 0, 1);
    return smootherLerpColor(int(start[1]), int(end[1]), sectionProgress);
  }
  
  color smootherLerpColor(color a, color b, float progress) {
    float huea = hue(a);
    float hueb = hue(b);
    float delta = hueb - huea;

    if (delta < -180) {
      hueb += 360;
    } else if (delta > 180) {
      huea += 360;
    }
    float hue = (huea + progress * (hueb - huea)) % 360;
    float saturation = lerp(saturation(a), saturation(b), progress);
    float brightness = lerp(brightness(a), brightness(b), progress);
    
    return color(hue, saturation, brightness);
  }
}
