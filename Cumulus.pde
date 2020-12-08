class Cumulus extends Cloudscape {
  float perlinStepX = 0.015;
  float perlinStepY = 0.0225;
  float ellipseRadiusMin = 20.0;
  float ellipseRadiusMax = 80.0;
  Layer layer;
  PShape triangle;
  int numberOfEllipses = 300;
  PVector[] ellipsePositions;
  
  Cumulus() {
    setAttributes();
    makeImage();
  }
  
  void setAttributes() {
    noiseDetail(12, 0.3);
    layer = new Layer(new PVector(200, 400), 600.0, 400.0);
    getTriangleVertices();
    color(0, 100, 100);
    getEllipsePositions();
  }
  
  void makeImage() {
    image = createImage(int(layer.layerWidth), int(layer.layerHeight), ARGB);
    //for (int i = 0; i < image.pixels.length; i++) {
    //  image.pixels[i] = color(0, 0, 100, getAlpha(i));
    //}
  }
  
  void display() {
    image(image, 0, 0);
    color(0, 100, 100);
    drawOutlines();
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
  
  void getTriangleVertices() {
    triangle = new PShape(PShape.PATH);
    triangle.vertex(layer.getStartX() + ellipseRadiusMax, layer.getEndY() - ellipseRadiusMax);
    triangle.vertex(layer.getEndX() - ellipseRadiusMax, layer.getEndY() - ellipseRadiusMax);
    triangle.vertex(random(triangle.getVertex(0).x, triangle.getVertex(1).x), layer.getStartY() + ellipseRadiusMax);
  }
  
  void getEllipsePositions() {
    if (ellipsePositions == null) {
      ellipsePositions = new PVector[numberOfEllipses];
      for (int i = 0; i < numberOfEllipses; i++) {
        ellipsePositions[i] = getPointInTriangle();
      }
    }
  }
  
  PVector getPointInTriangle() {
    PVector point = new PVector(layer.getMidX(), layer.getMidY());
    for (int i = 0; i < 1000; i++) {
      point = new PVector(layer.getRandomX(), layer.getRandomY());
      if (triangle.contains(int(point.x), int(point.y))) {
        return point;
      }
    }
    return point;
  }
  
  void drawOutlines() {
    color(0, 100, 100);
    for (PVector position : ellipsePositions) {
      // ellipse(position.x, position.y, position.z, position.z * 0.6);
      circle(position.x, position.y, 5);
    }
    noStroke();
  }
  
  float getRadius() {
    return 50 + random(200);
  }
  
  float getShapeFactor(int i) {
    if (pixelIsInRange(i)) {
      float factor = 0.0;
      float overlapFactor = 0.0;
      for (PVector pos : ellipsePositions) {
        float distanceToOutline = pos.z - getPixelVector(i).sub(new PVector(pos.x, pos.y)).mag();
        factor = max(factor, distanceToOutline / pos.z);
        if (distanceToOutline / pos.z > 0) {
          overlapFactor += distanceToOutline / pos.z;
        }
      }
      factor += overlapFactor * 0.1;
      return factor;
    }
    return 0.0;
  }
  
  boolean pixelIsInRange(int i) {
    getEllipsePositions();
    for (PVector position : ellipsePositions) {
      if (getPixelVector(i).sub(new PVector(position.x, position.y)).mag() < position.z) {
        return true;
      }
    }
    return false;
  }
}
