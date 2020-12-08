class Layer {
  PVector position;
  float layerWidth;
  float layerHeight;
  
  Layer(PVector _position, float _width, float _height) {
    position = _position;
    layerWidth = _width;
    layerHeight = _height;
  }
  
  float getStartX() {
    return position.x;
  }
  
  float getStartY() {
    return position.y;
  }
  
  float getEndX() {
    return position.x + layerWidth;
  }
  
  float getEndY() {
    return position.y + layerHeight;
  }
  
  float getMidX() {
    return position.x + layerWidth / 2;
  }
  
  float getMidY() {
    return position.y + layerHeight / 2;
  }
  
  float getRandomX() {
    return position.x + random(layerWidth);
  }
  
  float getRandomY() {
    return position.y + random(layerHeight);
  }
}
