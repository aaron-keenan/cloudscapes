class Cumulus extends Cloudscape {
  float perlinStepX = 0.01;
  float perlinStepY = 0.015;
  PVector[] outlinePositions;
  
  Cumulus() {
    noiseDetail(11, 0.3);
    // getOutlinePositions();
    makeImage();
  }
  
  void display() {
    image(image, 0, 0);
    // drawOutlines();
  }
  
  void makeImage() {
    image = createImage(width, height, ARGB);
    for (int i = 0; i < image.pixels.length; i++) {
      image.pixels[i] = color(0, 0, 100, getAlpha(i));
    }
  }
  
  float getAlpha(int i) {
    return 100.0 * getBaseFactor(i) * getShapeFactor(i);
  }
  
  float getBaseFactor(int i) {
    return constrain(pow(getNoiseValue(i), 1.2) * 1.6, 0, 1);
  }
  
  float getNoiseValue(int i) {
    float x = getPixelX(i) * perlinStepX;
    float y = getPixelY(i) * perlinStepY;
    return noise(x, y);
  }
  
  PVector[] getOutlinePositions() {
    if (outlinePositions == null) {
      int numberOfClouds = 1 + floor(random(60));
      outlinePositions = new PVector[numberOfClouds];
      for (int i = 0; i < numberOfClouds; i++) {
        outlinePositions[i] = new PVector(random(width), random(height), getRadius());
      }
    }
    return outlinePositions;
  }
  
  void drawOutlines() {
    color(0, 100, 100);
    for (PVector position : outlinePositions) {
      ellipse(position.x, position.y, position.z, position.z * 0.6);
    }
  }
  
  float getRadius() {
    return 50 + random(200);
  }
  
  float getShapeFactor(int i) {
    if (pixelIsInRange(i)) {
      float factor = 0.0;
      for (PVector pos : outlinePositions) {
        float distanceToOutline = pos.z - getPixelVector(i).sub(new PVector(pos.x, pos.y)).mag();
        factor = max(factor, (distanceToOutline * 0.90) / pos.z);
      }
      return factor;
    }
    return 0.0;
  }
  
  boolean pixelIsInRange(int i) {
    outlinePositions = getOutlinePositions();
    for (PVector position : outlinePositions) {
      if (getPixelVector(i).sub(new PVector(position.x, position.y)).mag() < position.z) {
        return true;
      }
    }
    return false;
  }
}
