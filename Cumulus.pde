class Cumulus extends Cloudscape {
  float perlinStepX = 0.015;
  float perlinStepY = 0.0225;
  float ellipseRadiusMin = 50.0;
  float ellipseRadiusMax = 180.0;
  float smoothEdge = 40.0;
  Layer layer;
  PShape triangle;
  int numberOfEllipses = 50;
  PShape cloud;
  
  Cumulus() {
    setAttributes();
    makeImage();
  }
  
  void setAttributes() {
    noiseDetail(12, 0.3);
    layer = new Layer(new PVector(0, 0), 900.0, 600.0);
    getTriangleVertices();
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
    //color(0, 100, 100);
    //shape(cloud);
  }
  
  float getAlpha(int i) {
    //return 100.0 * getShapeFactor(i);
    return 100.0 * getBaseFactor(i) * getShapeFactor(i);
  }
  
  float getBaseFactor(int i) {
    return 1.0 - 0.35 * constrain(pow(getNoiseValue(i), 1.2) * 1.6, 0, 1);
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
    for (int i = 0; i < numberOfEllipses; i++) {
      PVector centre = getPointInTriangle();
      int radius = getRadius();
      PShape ellipse = createShape(ELLIPSE, centre.x, centre.y, radius, radius);
      cloud.addChild(ellipse);
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
  
  int getRadius() {
    return int(random(ellipseRadiusMin, ellipseRadiusMax));
  }
  
  float getShapeFactor(int p) {
    if (pixelIsInRange(p)) {
      return getDistanceFromPerimeter(p) / smoothEdge;
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
  
  float getDistanceFromPerimeter(int p) {
    float closest = 0;
    for (int i = 0; i < cloud.getChildCount(); i++) {
      PShape ellipse = cloud.getChild(i);
      float radius = ellipse.getParam(2) / 2;
      float distance = radius - getPixelDistanceFromCentre(p, ellipse);
      if (distance > smoothEdge) {
        return smoothEdge;
      }
      if (distance >= 0 && distance < smoothEdge && distance > closest) {
        closest = distance;
      }
    }
    return closest;
  }
}
