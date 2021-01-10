class Cumulus extends Cloudscape {
  float perlinStepX = 0.03;
  float perlinStepY = 0.04;
  float ellipseWidthMin = 50.0;
  float ellipseWidthMax = 270.0;
  float smoothEdge = 24.0;
  Layer layer;
  PShape triangle;
  int numberOfEllipses = 120;
  PShape cloud;
  PVector cloudStart, cloudEnd;
  
  Cumulus() {
    setAttributes();
    makeImage();
  }
  
  void setAttributes() {
    noiseDetail(12, 0.3);
    layer = new Layer(new PVector(0, 0), 1000, 550);
    getTriangleVertices();
    setupShapeGroup();
  }
  
  void makeImage() {
    image = createImage(int(layer.layerWidth), int(layer.layerHeight), ARGB);
    GradientHybrid cloudColourGradient = new GradientHybrid(layer.layerWidth, layer.layerHeight);
    GradientLinear cloudColourLinear = new GradientLinear(layer.layerWidth, layer.layerHeight);
    GradientNoise cloudColourNoise = new GradientNoise(layer.layerWidth, layer.layerHeight);
    cloudColourGradient.setPalette(colourProfile.cloudColours);
    cloudColourNoise.setGradientNoiseDetails(0.004, 0.006, 12, 0.5);
    cloudColourGradient.addGradient(cloudColourLinear, 0.3);
    cloudColourGradient.addGradient(cloudColourNoise, 0.7);
    cloudColourGradient.updatePixels();
    for (int i = 0; i < image.pixels.length; i++) {
      color gradientColour = cloudColourGradient.image.pixels[i];
      image.pixels[i] = color(hue(gradientColour), saturation(gradientColour), brightness(gradientColour), getAlpha(i));
    }
  }
  
  void display() {
    image(image, getXOffset(), getYOffset());
    //color(0, 100, 100);
    //shape(cloud);
  }
  
  float getAlpha(int i) {
    return 85.0 * getBaseFactor(i) * getShapeFactor(i);
  }
  
  float getBaseFactor(int i) {
    float distance = getDistanceFromPerimeter(i, 5000);
    float noiseEdge = 60.0;
    if (distance > noiseEdge) {
      return 1.0;
    }
    return 1.0 - ((noiseEdge - distance) / noiseEdge) * constrain(pow(getNoiseValue(i), 1.2) * 1.6, 0, 1);
  }
  
  float getNoiseValue(int i) {
    float x = layer.getLayerPixelX(i) * perlinStepX;
    float y = layer.getLayerPixelY(i) * perlinStepY;
    return noise(x, y);
  }
  
  void getTriangleVertices() {
    triangle = new PShape(PShape.PATH);
    float ellipseRadius = ellipseWidthMax / 2;
    triangle.vertex(layer.getStartX() + ellipseRadius, layer.getEndY() - ellipseRadius);
    triangle.vertex(layer.getEndX() - ellipseRadius, layer.getEndY() - ellipseRadius);
    triangle.vertex(random(triangle.getVertex(0).x, triangle.getVertex(1).x), layer.getStartY() + ellipseRadius);
  }
  
  void setupShapeGroup() {
    cloud = createShape(GROUP);
    cloudStart = new PVector(0, 0);
    cloudEnd = new PVector(0, 0);
    for (int i = 0; i < numberOfEllipses; i++) {
      PVector centre = getPointInTriangle();
      int diameter = getEllipseWidth();
      PShape ellipse = createShape(ELLIPSE, centre.x, centre.y, diameter, diameter);
      cloud.addChild(ellipse);
      updateGroupProperties(ellipse);
    }
  }
  
  void updateGroupProperties(PShape ellipse) {
    float ellipseStartX = ellipse.getParam(0) - ellipse.getParam(2) / 2;
    float ellipseEndX = ellipse.getParam(0) + ellipse.getParam(2) / 2;
    float ellipseStartY = ellipse.getParam(1) - ellipse.getParam(3) / 2;
    float ellipseEndY = ellipse.getParam(1) + ellipse.getParam(3) / 2;
    if (cloudStart.x == 0 || ellipseStartX < cloudStart.x) {
      cloudStart.set(ellipseStartX, cloudStart.y);
    }
    if (cloudEnd.x == 0 || ellipseEndX > cloudEnd.x) {
      cloudEnd.set(ellipseEndX, cloudEnd.y);
    }
    if (cloudStart.y == 0 || ellipseStartY < cloudStart.y) {
      cloudStart.set(cloudStart.x, ellipseStartY);
    }
    if (cloudEnd.y == 0 || ellipseEndY > cloudEnd.y) {
      cloudEnd.set(cloudEnd.x, ellipseEndY);
    }
  }
  
  int getXOffset() {
    float cloudCentreX = cloudStart.x + ((cloudEnd.x - cloudStart.x) / 2);
    return int((width / 2) - cloudCentreX);
  }
  
  int getYOffset() {
    float cloudCentreY = cloudStart.y + ((cloudEnd.y - cloudStart.y) / 2);
    return int((height / 2) - cloudCentreY);
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
  
  int getEllipseWidth() {
    return int(random(ellipseWidthMin, ellipseWidthMax));
  }
  
  float getShapeFactor(int p) {
    if (pixelIsInRange(p)) {
      return getDistanceFromPerimeter(p, smoothEdge) / smoothEdge;
    }
    return 0.0;
  }
  
  boolean pixelIsInRange(int p) {
    for (int i = 0; i < cloud.getChildCount(); i++) {
      if (pixelIsInEllipse(p, cloud.getChild(i))) {
        return true;
      }
    }
    return false;
  }
  
  boolean pixelIsInEllipse(int p, PShape ellipse) {
    float radius = ellipse.getParam(2) / 2;
    float distance = getPixelDistanceFromCentre(p, ellipse);
    
    if (distance < radius) {
      return true;
    }
    return false;
  }
  
  float getPixelDistanceFromCentre(int p, PShape ellipse) {
    PVector centre = new PVector(ellipse.getParam(0), ellipse.getParam(1));
    return layer.getLayerPixelVector(p).sub(centre).mag();
  }
  
  float getDistanceFromPerimeter(int p, float taper) {
    float closest = 0;
    for (int i = 0; i < cloud.getChildCount(); i++) {
      PShape ellipse = cloud.getChild(i);
      float radius = ellipse.getParam(2) / 2;
      float distance = radius - getPixelDistanceFromCentre(p, ellipse);
      if (distance > taper) {
        return taper;
      }
      if (distance >= 0 && distance < taper && distance > closest) {
        closest = distance;
      }
    }
    return closest;
  }
}
