class Sky {
  PImage image;
  PVector gradientCentre;
  PVector gradientEnd;
  float gradientSize;
  color darkest = color(218, 40, 63);
  color lightest = color(208, 40, 95);
  
  Sky() {
    image = createImage(width, height, RGB);
    gradientCentre = new PVector(-width/2 + random(2*width), -random(height/2));
    gradientSize = getGradientSize();
    for (int i = 0; i < image.pixels.length; i++) {
      float distance = PVector.sub(gradientCentre, new PVector(getPixelX(i), getPixelY(i))).mag();
      float gradientProgress = map(distance, 0, gradientSize, 0, 1);
      image.pixels[i] = lerpColor(lightest, darkest, gradientProgress);
    }
  }
  
  void display() {
    image(image, 0, 0);
  }
  
  float getGradientSize() {
    gradientEnd = getGradientEnd();
    return PVector.sub(gradientCentre, gradientEnd).mag();
  }
  
  PVector getGradientEnd() {
    if (gradientCentre.x < width/2) {
      return new PVector(width, height);
    }
    return new PVector(0, height);
  }
}
