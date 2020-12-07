Cloudscape clouds;
Sky sky;
// sunrise / cyan / sahara / twilight
ColourProfile colourProfile = new ColourProfile("sunrise");

void setup() {
  size(980, 980);
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
  sky = new Sky();
  // clouds = new Cirrocumulus();
  clouds = new Cumulus();
}

void draw() {
  sky.display();
  // clouds.display();
}

int getPixelX(int i) {
  return i % width;
}

int getPixelY(int i) {
  return floor(i / width);
}

PVector getPixelVector(int i) {
  return new PVector(getPixelX(i), getPixelY(i));
}
  
