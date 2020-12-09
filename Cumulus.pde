class Cumulus extends Cloudscape {
  float perlinStepX = 0.015;
  float perlinStepY = 0.0225;
  float ellipseRadiusMin = 50.0;
  float ellipseRadiusMax = 180.0;
  Layer layer;
  PShape triangle;
  int numberOfEllipses = 30;
  PVector[] ellipsePositions;
  float[] ellipseDiameters;
  PShape cloud;
  PShape[] ellipses;
  
  Cumulus() {
    setAttributes();
    makeImage();
  }
  
  void setAttributes() {
    noiseDetail(12, 0.3);
    layer = new Layer(new PVector(0, 0), 900.0, 600.0);
    getTriangleVertices();
    color(0, 100, 100);
    getEllipseAttributes();
  }
  
  void makeImage() {
    image = createImage(int(layer.layerWidth), int(layer.layerHeight), ARGB);
    for (int i = 0; i < image.pixels.length; i++) {
      image.pixels[i] = color(0, 0, 100, getAlpha(i));
    }
  }
  
  void display() {
    image(image, 40, 200);
    color(0, 100, 100);
    //shape(cloud);
    //drawOutlines();
  }
  
  float getAlpha(int i) {
    return 100.0 * getShapeFactor(i);
    // return 100.0 * getBaseFactor(i) * getShapeFactor(i);
  }
  
  float getBaseFactor(int i) {
    return constrain(pow(getNoiseValue(i), 1.2) * 1.6, 0, 1);
  }
  
  float getNoiseValue(int i) {
    float x = layer.getLayerPixelX(i) * perlinStepX;
    float y = layer.getLayerPixelY(i) * perlinStepY;
    return noise(x, y);
  }
  
  void getTriangleVertices() {
    triangle = new PShape(PShape.PATH);
    triangle.vertex(layer.getStartX() + ellipseRadiusMax, layer.getEndY() - ellipseRadiusMax);
    triangle.vertex(layer.getEndX() - ellipseRadiusMax, layer.getEndY() - ellipseRadiusMax);
    triangle.vertex(random(triangle.getVertex(0).x, triangle.getVertex(1).x), layer.getStartY() + ellipseRadiusMax);
  }
  
  void getEllipseAttributes() {
    cloud = createShape(GROUP);
    if (ellipsePositions == null) {
      ellipses = new PShape[numberOfEllipses];
      ellipsePositions = new PVector[numberOfEllipses];
      ellipseDiameters = new float[numberOfEllipses];
      for (int i = 0; i < numberOfEllipses; i++) {
        ellipsePositions[i] = getPointInTriangle();
        ellipseDiameters[i] = getRadius();
        ellipses[i] = createShape(ELLIPSE, ellipsePositions[i].x, ellipsePositions[i].y, int(ellipseDiameters[i]), int(ellipseDiameters[i]));
        cloud.addChild(ellipses[i]);
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
    for (int i = 0; i < numberOfEllipses; i++) {
      // ellipse(position.x, position.y, position.z, position.z * 0.6);
      circle(ellipsePositions[i].x, ellipsePositions[i].y, ellipseDiameters[i]);
    }
    noStroke();
  }
  
  float getRadius() {
    return random(ellipseRadiusMin, ellipseRadiusMax);
  }
  
  float getShapeFactor(int p) {
    if (pixelIsInRange(p)) {
    //if (cloud.contains(layer.getLayerPixelX(p), layer.getLayerPixelY(p))) {
      return 0.5;
      //float factor = 0.0;
      //float overlapFactor = 0.0;
      //for (int i = 0; i < numberOfEllipses; i++) {
      //  float distanceToOutline = (ellipseDiameters[i] / 2) - layer.getLayerPixelVector(i).sub(ellipsePositions[i].copy()).mag();
      //  if (distanceToOutline > 0) {
      //    println(distanceToOutline);
      //  }
      //  factor = max(factor, distanceToOutline / (ellipseDiameters[i] / 2));
      //  //if (distanceToOutline / (ellipseDiameters[i] / 2) > 0) {
      //  //  overlapFactor += distanceToOutline / (ellipseDiameters[i] / 2);
      //  //}
      //}
      //factor += overlapFactor * 0.1;
      //return factor;
    }
    return 0.0;
  }
  
  boolean pixelIsInRange(int p) {
    //for (int i = 0; i < numberOfEllipses; i++) {
    //  if (layer.getLayerPixelVector(p).sub(ellipsePositions[i].copy()).mag() < (ellipseDiameters[i] / 2)) {
    //    return true;
    //  }
    //}
    //return false;
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
  
  float getRatioDistanceFromPerimeter(int p, PShape ellipse) {
    float radius = ellipse.getParam(2) / 2;
    float distance = getPixelDistanceFromCentre(p, ellipse);
    return (radius - distance) / radius;
  }
}
